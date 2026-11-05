import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;

/// Streams an installer to an isolated directory; partial files are never opened.
Future<File> downloadAppUpdate({
  required Dio client,
  required String url,
  required Directory directory,
  required CancelToken cancelToken,
  required ProgressCallback onProgress,
  List<String> fallbackUrls = const [],
  int maxBytes = 1024 * 1024 * 1024,
}) async {
  if (maxBytes <= 0) throw ArgumentError.value(maxBytes, 'maxBytes');
  final sources = <String>{url, ...fallbackUrls}.toList();
  var sourceIndex = 0;
  while (true) {
    try {
      return await _downloadAppUpdateFromSource(
        client: client,
        url: sources[sourceIndex],
        directory: directory,
        cancelToken: cancelToken,
        onProgress: onProgress,
        maxBytes: maxBytes,
      );
    } catch (error) {
      if (cancelToken.isCancelled) throw cancelToken.cancelError!;
      if (sourceIndex == sources.length - 1 || !_isUpdateSourceFailure(error)) {
        rethrow;
      }
      sourceIndex++;
    }
    onProgress(0, -1);
  }
}

bool _isUpdateSourceFailure(Object? error) {
  if (error is DioException) {
    if (error.type == DioExceptionType.cancel ||
        error.error is FileSystemException) {
      return false;
    }
    return error.type != DioExceptionType.unknown ||
        _isUpdateSourceFailure(error.error);
  }
  return error is FormatException ||
      error is SocketException ||
      error is HttpException ||
      error is TlsException ||
      error is TimeoutException;
}

Future<File> _downloadAppUpdateFromSource({
  required Dio client,
  required String url,
  required Directory directory,
  required CancelToken cancelToken,
  required ProgressCallback onProgress,
  required int maxBytes,
}) async {
  final uri = Uri.parse(url);
  final name = uri.pathSegments.lastOrNull ?? '';
  if ((!uri.isScheme('https') && !uri.isScheme('http')) ||
      uri.host.isEmpty ||
      name.isEmpty ||
      p.basename(name) != name ||
      name.contains('\\') ||
      name == '.' ||
      name == '..') {
    throw const FormatException('Invalid update URL or filename');
  }
  if (cancelToken.isCancelled) throw cancelToken.cancelError!;
  await directory.create(recursive: true);
  final staging = await directory.createTemp('flclash-update-');
  final partial = File(p.join(staging.path, '$name.part'));
  final transferToken = CancelToken();
  unawaited(
    cancelToken.whenCancel.then((error) => transferToken.cancel(error)),
  );
  RandomAccessFile? output;
  try {
    if (cancelToken.isCancelled) throw cancelToken.cancelError!;
    final response = await client.get<ResponseBody>(
      url,
      cancelToken: transferToken,
      options: Options(
        responseType: ResponseType.stream,
        receiveTimeout: const Duration(seconds: 30),
        receiveDataWhenStatusError: false,
        validateStatus: (status) => status == HttpStatus.ok,
      ),
    );
    final expected = int.tryParse(
      response.headers.value(HttpHeaders.contentLengthHeader) ?? '',
    );
    final contentType = response.headers
        .value(HttpHeaders.contentTypeHeader)
        ?.split(';')
        .first
        .trim()
        .toLowerCase();
    if ((expected != null && (expected <= 0 || expected > maxBytes)) ||
        contentType?.startsWith('text/') == true ||
        contentType == 'application/json' ||
        contentType?.endsWith('+json') == true ||
        contentType == 'application/xml' ||
        contentType?.endsWith('+xml') == true) {
      throw const FormatException('Invalid update download');
    }
    final encoding = response.headers
        .value(HttpHeaders.contentEncodingHeader)
        ?.trim()
        .toLowerCase();
    // Content-Length describes compressed bytes when automatic decoding is used.
    final total = encoding == null || encoding == 'identity' ? expected : null;
    final writer = output = await partial.open(mode: FileMode.write);
    var received = 0;
    final timeout = response.requestOptions.receiveTimeout!;
    // Dio starts its body timer only after the first chunk has arrived.
    final stream = response.data!.stream.timeout(
      timeout,
      onTimeout: (events) {
        events.addError(
          DioException.receiveTimeout(
            timeout: timeout,
            requestOptions: response.requestOptions,
          ),
        );
        events.close();
      },
    );
    await for (final chunk in stream) {
      if (cancelToken.isCancelled) throw cancelToken.cancelError!;
      received += chunk.length;
      if (received > maxBytes || (total != null && received > total)) {
        throw const FormatException('Update download exceeds expected size');
      }
      await writer.writeFrom(chunk);
      onProgress(received, total ?? -1);
    }
    if (cancelToken.isCancelled) throw cancelToken.cancelError!;
    if (received == 0 || (total != null && received != total)) {
      throw const FormatException('Incomplete update download');
    }
    // Own the file handle so cancellation cannot race directory deletion.
    await writer.close();
    output = null;
    final file = await partial.rename(p.join(staging.path, name));
    if (cancelToken.isCancelled) throw cancelToken.cancelError!;
    return file;
  } catch (_) {
    FileSystemException? cleanupError;
    try {
      await output?.close();
    } on FileSystemException catch (error) {
      cleanupError = error;
    }
    try {
      await staging.delete(recursive: true);
    } on FileSystemException catch (error) {
      // An already removed directory is clean; other failures must stop retries.
      if (await staging.exists()) cleanupError ??= error;
    }
    if (cleanupError != null) throw cleanupError;
    rethrow;
  } finally {
    transferToken.cancel();
  }
}

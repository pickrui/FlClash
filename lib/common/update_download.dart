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
  int maxBytes = 1024 * 1024 * 1024,
}) async {
  if (maxBytes <= 0) throw ArgumentError.value(maxBytes, 'maxBytes');
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
    try {
      await output?.close();
    } on FileSystemException {
      // Cleanup must preserve the original download or cancellation error.
    }
    try {
      await staging.delete(recursive: true);
    } on FileSystemException {
      // The OS may have already removed the temporary directory.
    }
    rethrow;
  } finally {
    transferToken.cancel();
  }
}

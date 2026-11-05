import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// Receives a complete, bounded response before a read can win a route race.
class BoundedHttpClientAdapter implements HttpClientAdapter {
  BoundedHttpClientAdapter(this._inner, {required this.maxBytes})
    : assert(maxBytes > 0);

  final HttpClientAdapter _inner;
  final int maxBytes;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final response = await _inner.fetch(options, requestStream, cancelFuture);
    if (response.statusCode == HttpStatus.unauthorized ||
        response.statusCode == HttpStatus.forbidden) {
      // Deliver the authoritative status without waiting for an error body.
      // WebDAV also needs the challenge headers to negotiate authentication.
      _discard(response.stream);
      return _withBytes(response, Uint8List(0));
    }
    final declaredLength = int.tryParse(
      response.headers[HttpHeaders.contentLengthHeader]?.firstOrNull ?? '',
    );
    if (declaredLength != null && declaredLength > maxBytes) {
      _discard(response.stream);
      throw const FormatException('HTTP response exceeds size limit');
    }
    final bytes = await _read(response, options, cancelFuture);
    return _withBytes(response, bytes);
  }

  ResponseBody _withBytes(ResponseBody response, Uint8List bytes) {
    return ResponseBody.fromBytes(
        bytes,
        response.statusCode,
        headers: response.headers,
        statusMessage: response.statusMessage,
        isRedirect: response.isRedirect,
      )
      ..redirects = response.redirects
      ..extra = response.extra;
  }

  Future<Uint8List> _read(
    ResponseBody response,
    RequestOptions options,
    Future<void>? cancelFuture,
  ) {
    final result = Completer<Uint8List>();
    final bytes = BytesBuilder(copy: false);
    StreamSubscription<Uint8List>? subscription;
    Timer? receiveTimer;

    void fail(Object error, [StackTrace? stack]) {
      if (result.isCompleted) return;
      receiveTimer?.cancel();
      bytes.clear();
      _cancel(subscription);
      result.completeError(error, stack);
    }

    void resetReceiveTimeout() {
      receiveTimer?.cancel();
      final timeout = options.receiveTimeout;
      if (timeout == null || timeout <= Duration.zero) return;
      receiveTimer = Timer(timeout, () {
        fail(
          DioException.receiveTimeout(
            timeout: timeout,
            requestOptions: options,
          ),
        );
      });
    }

    resetReceiveTimeout();
    try {
      subscription = response.stream.listen(
        (chunk) {
          if (result.isCompleted) return;
          if (bytes.length + chunk.length > maxBytes) {
            fail(const FormatException('HTTP response exceeds size limit'));
            return;
          }
          bytes.add(chunk);
          resetReceiveTimeout();
        },
        onError: fail,
        onDone: () {
          receiveTimer?.cancel();
          if (!result.isCompleted) result.complete(bytes.takeBytes());
        },
        cancelOnError: true,
      );
    } catch (error, stack) {
      fail(error, stack);
    }
    if (result.isCompleted) _cancel(subscription);
    unawaited(
      cancelFuture?.then((_) {
        fail(
          DioException.requestCancelled(
            requestOptions: options,
            reason: 'HTTP read cancelled',
          ),
        );
      }),
    );
    return result.future;
  }

  void _discard(Stream<Uint8List> stream) {
    try {
      _cancel(stream.listen(null, onError: (Object _) {}));
    } catch (_) {}
  }

  void _cancel(StreamSubscription<Uint8List>? subscription) {
    try {
      unawaited(subscription?.cancel().catchError((Object _) {}));
    } catch (_) {}
  }

  @override
  void close({bool force = false}) => _inner.close(force: force);
}

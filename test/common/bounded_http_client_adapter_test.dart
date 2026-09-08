import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/bounded_http_client_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('waits for the whole body and retains response metadata', () async {
    final stream = StreamController<Uint8List>();
    final response = ResponseBody(
      stream.stream,
      200,
      headers: {
        'etag': ['v1'],
      },
    )..extra = {'protocol': '1.1'};
    final pending = _adapter(response).fetch(RequestOptions(), null, null);
    var completed = false;
    unawaited(pending.then((_) => completed = true));
    stream.add(Uint8List.fromList([1, 2]));
    await Future<void>.delayed(Duration.zero);
    expect(completed, false);
    stream.add(Uint8List.fromList([3]));
    await stream.close();
    final result = await pending;
    expect(await result.stream.expand((chunk) => chunk).toList(), [1, 2, 3]);
    expect(result.headers['etag'], ['v1']);
    expect(result.extra, {'protocol': '1.1'});
  });

  test(
    'declared oversize does not wait for an uncooperative cancellation',
    () async {
      var cancelled = false;
      final stream = StreamController<Uint8List>(
        onCancel: () {
          cancelled = true;
          return Completer<void>().future;
        },
      );
      await expectLater(
        _adapter(
              ResponseBody(
                stream.stream,
                200,
                headers: {
                  'content-length': ['101'],
                },
              ),
            )
            .fetch(RequestOptions(), null, null)
            .timeout(const Duration(seconds: 1)),
        throwsFormatException,
      );
      expect(cancelled, true);
    },
  );

  test(
    'chunked oversized bodies are cancelled without yielding partial data',
    () async {
      var cancelled = false;
      final stream = StreamController<Uint8List>(
        onCancel: () => cancelled = true,
      );
      final pending = _adapter(
        ResponseBody(stream.stream, 200),
      ).fetch(RequestOptions(), null, null);
      final expectation = expectLater(pending, throwsFormatException);
      stream.add(Uint8List(60));
      stream.add(Uint8List(60));
      await expectation;
      expect(cancelled, true);
    },
  );

  test(
    'cancels a hanging body and contains errors from cancellation',
    () async {
      final cancel = Completer<void>();
      var cancelled = false;
      final stream = StreamController<Uint8List>(
        onCancel: () {
          cancelled = true;
          return Future<void>.error(StateError('cleanup failed'));
        },
      );
      final pending = _adapter(
        ResponseBody(stream.stream, 200),
      ).fetch(RequestOptions(), null, cancel.future);
      final expectation = expectLater(
        pending,
        throwsA(
          isA<DioException>().having(
            (e) => e.type,
            'type',
            DioExceptionType.cancel,
          ),
        ),
      );
      cancel.complete();
      await expectation;
      expect(cancelled, true);
    },
  );

  test('receive timeout cancels a stalled body', () async {
    var cancelled = false;
    final stream = StreamController<Uint8List>(
      onCancel: () => cancelled = true,
    );
    await expectLater(
      _adapter(ResponseBody(stream.stream, 200)).fetch(
        RequestOptions(receiveTimeout: const Duration(milliseconds: 20)),
        null,
        null,
      ),
      throwsA(
        isA<DioException>().having(
          (e) => e.type,
          'type',
          DioExceptionType.receiveTimeout,
        ),
      ),
    );
    expect(cancelled, true);
  });

  for (final status in [401, 403]) {
    test(
      'HTTP $status is authoritative despite an oversized hanging body',
      () async {
        var cancelled = false;
        final stream = StreamController<Uint8List>(
          onCancel: () {
            cancelled = true;
            return Completer<void>().future;
          },
        );
        final response =
            await _adapter(
                  ResponseBody(
                    stream.stream,
                    status,
                    headers: {
                      'content-length': ['1000'],
                      'www-authenticate': ['Basic realm="test"'],
                    },
                  ),
                )
                .fetch(RequestOptions(), null, null)
                .timeout(const Duration(seconds: 1));
        expect(response.statusCode, status);
        expect(response.headers['www-authenticate'], ['Basic realm="test"']);
        expect(
          await response.stream.expand((chunk) => chunk).toList(),
          isEmpty,
        );
        expect(cancelled, true);
      },
    );
  }

  test(
    'synchronous oversized streams are cancelled after listen returns',
    () async {
      final stream = _SynchronousStream();
      await expectLater(
        _adapter(ResponseBody(stream, 200)).fetch(RequestOptions(), null, null),
        throwsFormatException,
      );
      expect(stream.subscription.cancelled, true);
    },
  );
}

BoundedHttpClientAdapter _adapter(ResponseBody response) =>
    BoundedHttpClientAdapter(_Adapter(response), maxBytes: 100);

class _Adapter implements HttpClientAdapter {
  _Adapter(this.response);
  final ResponseBody response;
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async => response;
  @override
  void close({bool force = false}) {}
}

class _SynchronousStream extends Stream<Uint8List> {
  final subscription = _Subscription();
  @override
  StreamSubscription<Uint8List> listen(
    void Function(Uint8List)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    onData?.call(Uint8List(101));
    onDone?.call();
    return subscription;
  }
}

class _Subscription implements StreamSubscription<Uint8List> {
  var cancelled = false;
  @override
  Future<void> cancel() async => cancelled = true;
  @override
  bool get isPaused => false;
  @override
  void onData(void Function(Uint8List)? handleData) {}
  @override
  void onDone(void Function()? handleDone) {}
  @override
  void onError(Function? handleError) {}
  @override
  void pause([Future<void>? resumeSignal]) {}
  @override
  void resume() {}
  @override
  Future<E> asFuture<E>([E? futureValue]) => Future.value(futureValue);
}

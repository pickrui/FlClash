import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/update_download.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Directory directory;
  late HttpServer server;
  late Dio client;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('update-download-test-');
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    client = Dio();
  });

  tearDown(() async {
    client.close(force: true);
    await server.close(force: true);
    if (await directory.exists()) await directory.delete(recursive: true);
  });

  Future<File> download({
    CancelToken? token,
    ProgressCallback? progress,
    int maxBytes = 1024 * 1024 * 1024,
  }) => downloadAppUpdate(
    client: client,
    url: 'http://${server.address.address}:${server.port}/update.apk',
    directory: directory,
    cancelToken: token ?? CancelToken(),
    onProgress: progress ?? (_, _) {},
    maxBytes: maxBytes,
  );

  test('streams the complete installer and reports progress', () async {
    final bytes = List.generate(32768, (index) => index % 256);
    server.listen((request) async {
      request.response.headers.contentType = ContentType.binary;
      request.response.contentLength = bytes.length;
      request.response.add(bytes);
      await request.response.close();
    });
    var received = 0;
    final file = await download(progress: (count, _) => received = count);
    expect(file.path, endsWith('update.apk'));
    expect(await file.readAsBytes(), bytes);
    expect(received, bytes.length);
    expect(await file.parent.list().length, 1);
  });

  test('rejects HTML responses and removes partial files', () async {
    server.listen((request) async {
      request.response.headers.contentType = ContentType.binary;
      request.response.headers.contentType = ContentType.html;
      request.response.write('<html>download unavailable</html>');
      await request.response.close();
    });
    await expectLater(download(), throwsFormatException);
    expect(await directory.list().toList(), isEmpty);
  });

  test('failed HTTP requests leave no installer', () async {
    server.listen((request) async {
      request.response.headers.contentType = ContentType.binary;
      request.response.statusCode = 503;
      await request.response.close();
    });
    await expectLater(download(), throwsA(isA<DioException>()));
    expect(await directory.list().toList(), isEmpty);
  });

  test('cancellation removes the partial download', () async {
    final token = CancelToken();
    server.listen((request) async {
      request.response.headers.contentType = ContentType.binary;
      request.response.bufferOutput = false;
      request.response.contentLength = 1000000;
      request.response.add(List.filled(65536, 1));
      await request.response.flush();
    });
    await expectLater(
      download(token: token, progress: (_, _) => token.cancel()),
      throwsA(
        isA<DioException>().having(
          (error) => error.type,
          'type',
          DioExceptionType.cancel,
        ),
      ),
    );
    expect(await directory.list().toList(), isEmpty);
  });

  test(
    'cancellation on the final chunk never publishes an installer',
    () async {
      final token = CancelToken();
      server.listen((request) async {
        request.response.headers.contentType = ContentType.binary;
        request.response.contentLength = 3;
        request.response.add([1, 2, 3]);
        await request.response.close();
      });
      await expectLater(
        download(
          token: token,
          progress: (received, total) {
            if (received == total) token.cancel();
          },
        ),
        throwsA(
          isA<DioException>().having(
            (error) => error.type,
            'type',
            DioExceptionType.cancel,
          ),
        ),
      );
      expect(await directory.list().toList(), isEmpty);
    },
  );

  test('an already cancelled download creates no staging directory', () async {
    await expectLater(
      download(token: CancelToken()..cancel()),
      throwsA(
        isA<DioException>().having(
          (error) => error.type,
          'type',
          DioExceptionType.cancel,
        ),
      ),
    );
    expect(await directory.list().toList(), isEmpty);
  });

  test(
    'cleanup preserves the request error when the directory is gone',
    () async {
      late DioException failure;
      client.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            directory.deleteSync(recursive: true);
            failure = DioException.connectionError(
              requestOptions: options,
              reason: 'network unavailable',
            );
            handler.reject(failure);
          },
        ),
      );
      await expectLater(
        download(),
        throwsA(predicate((error) => identical(error, failure))),
      );
    },
  );

  for (final contentType in [
    'text/plain',
    'application/problem+json',
    'application/xml',
  ]) {
    test('rejects $contentType error bodies', () async {
      server.listen((request) async {
        request.response.headers.contentType = ContentType.binary;
        request.response.headers.set(
          HttpHeaders.contentTypeHeader,
          contentType,
        );
        request.response.write('download unavailable');
        await request.response.close();
      });
      await expectLater(download(), throwsFormatException);
      expect(await directory.list().toList(), isEmpty);
    });
  }

  test('rejects an oversized body before receiving it', () async {
    server.listen((request) async {
      request.response.headers.contentType = ContentType.binary;
      request.response.bufferOutput = false;
      request.response.contentLength = 1000;
      request.response.add([1]);
      await request.response.flush();
    });
    await expectLater(download(maxBytes: 100), throwsFormatException);
    expect(await directory.list().toList(), isEmpty);
  });

  test('limits chunked downloads without Content-Length', () async {
    server.listen((request) async {
      request.response.headers.contentType = ContentType.binary;
      request.response.add(List.filled(101, 1));
      await request.response.close();
    });
    await expectLater(download(maxBytes: 100), throwsFormatException);
    expect(await directory.list().toList(), isEmpty);
  });

  test('rejects an empty download', () async {
    server.listen((request) async {
      request.response.headers.contentType = ContentType.binary;
      await request.response.close();
    });
    await expectLater(download(), throwsFormatException);
    expect(await directory.list().toList(), isEmpty);
  });

  test('rejects a partial HTTP response', () async {
    server.listen((request) async {
      request.response.headers.contentType = ContentType.binary;
      request.response.statusCode = HttpStatus.partialContent;
      request.response.add([1, 2, 3]);
      await request.response.close();
    });
    await expectLater(
      download(),
      throwsA(
        isA<DioException>().having(
          (error) => error.type,
          'type',
          DioExceptionType.badResponse,
        ),
      ),
    );
    expect(await directory.list().toList(), isEmpty);
  });

  for (final length in [2, 4]) {
    test('rejects a body that does not match length $length', () async {
      client.httpClientAdapter = _ResponseAdapter(
        ResponseBody.fromBytes(
          [1, 2, 3],
          HttpStatus.ok,
          headers: {
            HttpHeaders.contentLengthHeader: ['$length'],
            HttpHeaders.contentEncodingHeader: ['identity'],
          },
        ),
      );
      await expectLater(download(), throwsFormatException);
      expect(await directory.list().toList(), isEmpty);
    });
  }

  test(
    'accepts compressed downloads with a different decoded length',
    () async {
      final bytes = List.filled(1000, 1);
      final compressed = gzip.encode(bytes);
      server.listen((request) async {
        request.response.headers.contentType = ContentType.binary;
        request.response.headers.set(HttpHeaders.contentEncodingHeader, 'gzip');
        request.response.contentLength = compressed.length;
        request.response.add(compressed);
        await request.response.close();
      });
      var total = 0;
      final file = await download(progress: (_, value) => total = value);
      expect(await file.readAsBytes(), bytes);
      expect(total, -1);
    },
  );

  for (final body in ['', 'a']) {
    test(
      'times out a stalled response after ${body.length} body bytes',
      () async {
        var receivedHeaders = false;
        client.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              expect(options.receiveTimeout, const Duration(seconds: 30));
              options.receiveTimeout = const Duration(milliseconds: 100);
              handler.next(options);
            },
            onResponse: (response, handler) {
              receivedHeaders = true;
              handler.next(response);
            },
          ),
        );
        server.listen((request) async {
          final socket = await request.response.detachSocket(
            writeHeaders: false,
          );
          addTearDown(socket.destroy);
          socket.write(
            'HTTP/1.1 200 OK\r\n'
            'Content-Type: application/octet-stream\r\n'
            'Content-Length: 1000\r\n\r\n$body',
          );
          await socket.flush();
        });
        await expectLater(
          download(),
          throwsA(
            isA<DioException>().having(
              (error) => error.type,
              'type',
              DioExceptionType.receiveTimeout,
            ),
          ),
        );
        expect(receivedHeaders, isTrue);
        expect(await directory.list().toList(), isEmpty);
      },
    );
  }
}

class _ResponseAdapter implements HttpClientAdapter {
  _ResponseAdapter(this.response);
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

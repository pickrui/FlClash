import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/http.dart';
import 'package:fl_clash/common/http_read_race.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'resource fallback preserves preferred route and rejects invalid ports',
    () {
      expect(
        resolveResourceProxy(isCoreRunning: true, port: 7890),
        'PROXY localhost:7890; DIRECT',
      );
      expect(
        resolveCloudApiProxy(isCoreRunning: true, port: 7890),
        'DIRECT; PROXY localhost:7890',
      );
      for (final port in [0, -1, 65536]) {
        expect(resolveResourceProxy(isCoreRunning: true, port: port), 'DIRECT');
      }
      expect(resolveResourceProxy(isCoreRunning: false, port: 7890), 'DIRECT');
    },
  );

  test('a failed read cannot beat a slower successful route', () async {
    final tokens = <CancelToken>[];
    final success = Completer<String>();
    final pending = raceHttpReads<String>([
      (token) {
        tokens.add(token);
        return Future.error(StateError('unavailable'));
      },
      (token) {
        tokens.add(token);
        return success.future;
      },
    ], timeout: const Duration(seconds: 1));
    success.complete('complete response');
    expect(await pending, 'complete response');
    expect(tokens.every((token) => token.isCancelled), true);
  });

  test(
    'a stuck read reaches the total deadline and cancels both routes',
    () async {
      final tokens = <CancelToken>[];
      Future<String> stuck(CancelToken token) {
        tokens.add(token);
        return Completer<String>().future;
      }

      await expectLater(
        raceHttpReads([
          stuck,
          stuck,
        ], timeout: const Duration(milliseconds: 20)),
        throwsA(isA<TimeoutException>()),
      );
      expect(tokens.length, 2);
      expect(tokens.every((token) => token.isCancelled), true);
    },
  );

  test('all read routes failing returns an error', () async {
    await expectLater(
      raceHttpReads<String>([
        (_) async => throw StateError('one'),
        (_) async => throw StateError('two'),
      ], timeout: const Duration(seconds: 1)),
      throwsStateError,
    );
  });

  test('connection fallback sends an authenticated POST only once', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final unused = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
    final closedPort = unused.port;
    await unused.close();
    addTearDown(() => server.close(force: true));
    var received = 0;
    server.listen((request) async {
      received++;
      expect(request.headers.value('authorization'), 'Bearer local-test');
      await request.drain<void>();
      request.response.write('ok');
      await request.response.close();
    });
    final client = Dio()
      ..httpClientAdapter = createFlClashHttpClientAdapter(
        findProxy: (_) => 'PROXY 127.0.0.1:$closedPort; DIRECT',
      );
    addTearDown(() => client.close(force: true));
    final response = await client.post<String>(
      'http://127.0.0.1:${server.port}/write',
      data: 'payload',
      options: Options(headers: {'Authorization': 'Bearer local-test'}),
    );
    expect(response.data, 'ok');
    expect(received, 1);
  });

  test(
    'a response timeout cannot replay a write through the fallback proxy',
    () async {
      final origin = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final proxy = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(() => origin.close(force: true));
      addTearDown(() => proxy.close(force: true));
      var writes = 0;
      var proxyRequests = 0;
      origin.listen((request) async {
        writes++;
        await request.drain<void>();
      });
      proxy.listen((request) async {
        proxyRequests++;
        await request.response.close();
      });
      final client =
          Dio(BaseOptions(receiveTimeout: const Duration(milliseconds: 50)))
            ..httpClientAdapter = createFlClashHttpClientAdapter(
              findProxy: (_) => 'DIRECT; PROXY 127.0.0.1:${proxy.port}',
            );
      addTearDown(() => client.close(force: true));
      await expectLater(
        client.post('http://127.0.0.1:${origin.port}/write', data: 'once'),
        throwsA(isA<DioException>()),
      );
      expect(writes, 1);
      expect(proxyRequests, 0);
    },
  );
}

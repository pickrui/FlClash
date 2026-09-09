import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:fl_clash/common/http.dart';
import 'package:fl_clash/common/secrets.dart';
import 'package:fl_clash/core/controller.dart' show ConfigValidationException;
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:fl_clash/services/age_crypto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/cloud_api_adapter.dart';

void main() {
  test(
    'sync reads time out, cancel late auth responses and allow retry',
    () async {
      final adapter = QueuedCloudAdapter();
      final service = CloudApiService.forTesting(
        client: adapter.createClient(),
        syncRequestTimeout: const Duration(milliseconds: 100),
      )..setToken('session');
      final revision = service.sessionRevision;
      final stalled = service.getUserInfo();
      final failure = expectLater(stalled, throwsA(isA<CloudApiException>()));
      final pending = await adapter.takeRequest();
      await failure;
      expect(pending.options.cancelToken?.isCancelled, true);
      pending.respond({'ret': 401}, statusCode: 401);
      await pumpEventQueue();
      expect(service.sessionRevision, revision);
      final retry = service.getUserInfo();
      final next = await adapter.takeRequest();
      next.respond({
        'ret': 200,
        'data': {
          for (final key in [
            'plan',
            'plan_time',
            'used',
            'traffic',
            'today_used',
            'unused',
            'money',
            'aff_money',
            'integral',
          ])
            key: '0',
        },
      });
      await retry;
      expect(adapter.requestCount, 2);
    },
  );

  test(
    'a 401 invalidation becomes obsolete before its caller handles it',
    () async {
      final adapter = QueuedCloudAdapter();
      final client = adapter.createClient();
      final service = CloudApiService.forTesting(client: client);
      final invalidated = Completer<void>();
      final releaseError = Completer<void>();
      service.setToken('account-a');
      final oldRequest = service.fetchBought().catchError((Object error) async {
        expect(CloudApiException.isUnauthorized(error), isTrue);
        invalidated.complete();
        await releaseError.future;
        throw error;
      });
      final pending = await adapter.takeRequest();
      pending.respond({'ret': 401}, statusCode: 401);
      await invalidated.future;
      service.setToken('account-b');
      final rejected = expectLater(
        oldRequest,
        throwsA(
          predicate<Object>(
            (error) =>
                CloudApiException.isHandledUnauthorized(error) &&
                !CloudApiException.isUnauthorized(error),
          ),
        ),
      );
      releaseError.complete();
      await rejected;

      final currentRequest = service.fetchBought();
      final current = await adapter.takeRequest();
      expect(current.options.headers['Authorization'], 'Bearer account-b');
      current.respond({
        'ret': 200,
        'data': {'boughts': []},
      });
      await currentRequest;
    },
  );

  test(
    'an account switch before dispatch cannot send an old write as the new account',
    () async {
      final adapter = QueuedCloudAdapter();
      final service = CloudApiService.forTesting(
        client: adapter.createClient(),
      );
      service.setToken('account-a');
      final request = service.activatePlan(1);
      service.setToken('account-b');

      await expectLater(
        request,
        throwsA(predicate<Object>(CloudApiException.isStaleSession)),
      );
      expect(adapter.requestCount, 0);

      final next = service.fetchBought();
      final current = await adapter.takeRequest();
      expect(current.options.headers['Authorization'], 'Bearer account-b');
      current.respond({
        'ret': 200,
        'data': {'boughts': []},
      });
      await next;
    },
  );

  for (final statusCode in [200, 401]) {
    test(
      'a late $statusCode/401 response cannot invalidate a new account',
      () async {
        final adapter = QueuedCloudAdapter();
        final service = CloudApiService.forTesting(
          client: adapter.createClient(),
        );
        service.setToken('account-a');
        final oldRequest = service.fetchBought();
        final pending = await adapter.takeRequest();
        service.setToken(null);
        service.setToken('account-b');
        final revision = service.sessionRevision;
        final rejected = expectLater(
          oldRequest,
          throwsA(
            predicate<Object>(
              (error) =>
                  CloudApiException.isHandledUnauthorized(error) &&
                  !CloudApiException.isUnauthorized(error),
            ),
          ),
        );
        pending.respond({'ret': 401}, statusCode: statusCode);
        await rejected;

        expect(service.sessionRevision, revision);
        final currentRequest = service.fetchBought();
        final current = await adapter.takeRequest();
        expect(current.options.headers['Authorization'], 'Bearer account-b');
        current.respond({
          'ret': 200,
          'data': {'boughts': []},
        });
        expect(await currentRequest, isEmpty);
      },
    );
  }

  test('a current-session 401 still clears its credentials', () async {
    final adapter = QueuedCloudAdapter();
    final service = CloudApiService.forTesting(client: adapter.createClient());
    service.setToken('account-a');
    final request = service.fetchBought();
    final pending = await adapter.takeRequest();
    final rejected = expectLater(
      request,
      throwsA(predicate<Object>(CloudApiException.isUnauthorized)),
    );
    pending.respond({'ret': 401}, statusCode: 401);
    await rejected;

    final next = service.fetchPlans();
    final withoutToken = await adapter.takeRequest();
    expect(withoutToken.options.headers.containsKey('Authorization'), isFalse);
    withoutToken.respond({
      'ret': 200,
      'data': {'shops': []},
    });
    await next;
  });

  test(
    'an unauthenticated endpoint cannot clear the signed-in token',
    () async {
      final adapter = QueuedCloudAdapter();
      final service = CloudApiService.forTesting(
        client: adapter.createClient(),
      );
      service.setToken('account-b');
      final registration = service.fetchRegisterConfig();
      final pending = await adapter.takeRequest();
      final rejected = expectLater(registration, throwsException);
      pending.respond({
        'ret': 401,
        'msg': 'registration unavailable',
      }, statusCode: 401);
      await rejected;

      final next = service.fetchBought();
      final current = await adapter.takeRequest();
      expect(current.options.headers['Authorization'], 'Bearer account-b');
      current.respond({
        'ret': 200,
        'data': {'boughts': []},
      });
      await next;
    },
  );

  test('certificate classifier ignores generic TLS handshake failures', () {
    expect(
      FlClashTemporaryTls.isCertificateVerifyFailed(
        const HandshakeException('Connection terminated during handshake'),
      ),
      false,
    );
    expect(
      FlClashTemporaryTls.isCertificateVerifyFailed(
        const HandshakeException(
          'Handshake error in client (OS Error: CONNECTION_RESET)',
        ),
      ),
      false,
    );
  });

  test('certificate classifier recognizes verification failures', () {
    expect(
      FlClashTemporaryTls.isCertificateVerifyFailed(
        const HandshakeException(
          'Handshake error in client '
          '(OS Error: CERTIFICATE_VERIFY_FAILED: certificate has expired)',
        ),
      ),
      true,
    );

    expect(
      FlClashTemporaryTls.isCertificateVerifyFailed(
        DioException(
          requestOptions: RequestOptions(path: '/'),
          type: DioExceptionType.badCertificate,
        ),
      ),
      true,
    );
  });

  test('cloud API connection errors do not expose endpoint details', () {
    final error = DioException(
      requestOptions: RequestOptions(
        baseUrl: 'https://private-api.example',
        path: '/api/v1/information',
      ),
      type: DioExceptionType.connectionError,
      error: SocketException(
        "Can't assign requested address",
        address: InternetAddress.loopbackIPv4,
        port: 443,
      ),
      message: 'Connection failed',
    );

    final message = CloudApiException.clean(error);
    expect(message, isNot(contains('private-api.example')));
    expect(message, isNot(contains('443')));
    expect(message, isNot(contains('SocketException')));
    expect(message, isNot(contains('requested address')));
  });

  test('API hostname redaction covers URLs, ports, and socket addresses', () {
    const host = 'private-api.example';
    final redacted = redactHostnames(
      'GET https://$host:443/api/v1/information failed; '
      'address = $host, port = 443',
      const [host],
    );

    expect(redacted, isNot(contains(host)));
    expect(redacted, isNot(contains('/api/v1/information')));
  });

  test('cloud API 401 errors remain recognizable after sanitizing', () {
    final options = RequestOptions(path: '/api/v1/information');
    final error = DioException(
      requestOptions: options,
      response: Response<dynamic>(requestOptions: options, statusCode: 401),
      type: DioExceptionType.badResponse,
    );

    expect(CloudApiException.clean(error), 'Unauthorized');
    expect(CloudApiException.isUnauthorized(error), true);
  });

  test('managed config offers both routes as soon as the core runs', () {
    expect(
      resolveCloudApiProxy(isCoreRunning: true, port: 7890),
      'DIRECT; PROXY localhost:7890',
    );

    for (final state in [
      (running: false, port: 7890),
      (running: true, port: 0),
    ]) {
      expect(
        resolveCloudApiProxy(isCoreRunning: state.running, port: state.port),
        'DIRECT',
      );
    }
  });

  test('a late losing domain response is drained', () async {
    final inner = _RacingAdapter();
    expect(await _domainService(inner).fetchBought(), isEmpty);
    await inner.losingResponseDrained.future.timeout(
      const Duration(seconds: 1),
    );
  });

  test('cloud adapter sends a non-idempotent request only once', () async {
    final inner = _CountingAdapter();
    final adapter = CloudApiAdapter(
      inner,
      domains: () => const ['primary.test', 'spare.test'],
    );

    final response = await adapter.fetch(
      RequestOptions(
        baseUrl: 'https://primary.test',
        path: '/login',
        extra: {cloudNonIdempotentExtraKey: true},
      ),
      null,
      null,
    );

    expect(await response.stream.single, Uint8List.fromList([1]));
    expect(inner.fetchCount, 1);
  });

  test('login options disable hedging but allow sequential failover', () {
    final options = buildCloudLoginOptions();

    expect(options.connectTimeout, const Duration(seconds: 5));
    expect(options.extra?['skipAuth'], true);
    expect(options.extra?[cloudNonIdempotentExtraKey], true);
    expect(options.extra?[cloudSequentialFailoverExtraKey], true);
  });

  test('login failover tries the spare domain without overlapping', () async {
    final inner = _SequentialFailoverAdapter();
    final adapter = CloudApiAdapter(
      inner,
      domains: () => const ['primary.test', 'spare.test'],
    );
    final options = RequestOptions(
      baseUrl: 'https://primary.test',
      path: '/login',
      extra: buildCloudLoginOptions().extra ?? const {},
    );

    final response = await adapter.fetch(
      options,
      Stream<Uint8List>.value(Uint8List.fromList([1, 2, 3])),
      null,
    );

    expect(await response.stream.single, Uint8List.fromList([2]));
    expect(inner.hosts, ['primary.test', 'spare.test']);
    expect(inner.bodies, [
      [1, 2, 3],
      [1, 2, 3],
    ]);
    expect(inner.maxConcurrent, 1);
  });

  test('login failover does not replay after a response timeout', () async {
    final inner = _SequentialFailoverAdapter(
      primaryErrorType: DioExceptionType.receiveTimeout,
    );
    final adapter = CloudApiAdapter(
      inner,
      domains: () => const ['primary.test', 'spare.test'],
    );

    await expectLater(
      adapter.fetch(
        RequestOptions(
          baseUrl: 'https://primary.test',
          path: '/login',
          extra: buildCloudLoginOptions().extra ?? const {},
        ),
        null,
        null,
      ),
      throwsA(
        isA<DioException>().having(
          (error) => error.type,
          'type',
          DioExceptionType.receiveTimeout,
        ),
      ),
    );
    expect(inner.hosts, ['primary.test']);
  });
  test('cloud replay policy only permits known reads', () {
    for (final path in [
      '/register/config',
      '/information',
      '/shop/list',
      '/shop/bought',
      '/pay/methods',
      '/pay/status',
    ]) {
      expect(
        canReplayCloudRequest(
          RequestOptions(
            baseUrl: 'https://cloud.test/api/v1',
            path: path,
            method: 'POST',
          ),
        ),
        isTrue,
        reason: path,
      );
    }
    for (final path in [
      '/login',
      '/shop/activate',
      '/pay/order',
      '/new-action',
    ]) {
      expect(
        canReplayCloudRequest(
          RequestOptions(
            baseUrl: 'https://cloud.test/api/v1',
            path: path,
            method: 'POST',
          ),
        ),
        isFalse,
        reason: path,
      );
    }
    expect(
      canReplayCloudRequest(
        RequestOptions(
          path: 'https://cloud.test/profile',
          extra: {cloudNonIdempotentExtraKey: true},
        ),
      ),
      isFalse,
    );
  });

  for (final read in <String, Future<dynamic> Function(CloudApiService)>{
    'register config': (service) => service.fetchRegisterConfig(),
    'plans': (service) => service.fetchPlans(),
    'orders': (service) => service.fetchBought(),
    'payment methods': (service) => service.fetchPaymentMethods(),
    'payment status': (service) => service.queryPaymentPaid('order'),
  }.entries) {
    test('${read.key} has a total deadline and cancels its request', () async {
      final adapter = QueuedCloudAdapter();
      final service = CloudApiService.forTesting(
        client: adapter.createClient(),
        syncRequestTimeout: const Duration(milliseconds: 50),
      )..setToken('session');
      final failure = expectLater(
        read.value(service),
        throwsA(isA<CloudApiException>()),
      );
      final pending = await adapter.takeRequest();
      await failure;
      expect(pending.options.cancelToken?.isCancelled, isTrue);
      pending.respond({'ret': 401}, statusCode: 401);
      await pumpEventQueue();
      expect(service.sessionRevision, 1);
    });
  }

  test('plan activation is marked non-idempotent', () async {
    final adapter = QueuedCloudAdapter();
    final service = CloudApiService.forTesting(client: adapter.createClient())
      ..setToken('session');
    final activation = service.activatePlan(1);
    final pending = await adapter.takeRequest();
    expect(pending.options.extra[cloudNonIdempotentExtraKey], isTrue);
    pending.respond({'ret': 200, 'msg': 'Activated'});
    expect((await activation).success, isTrue);
  });

  for (final failure in <String, ResponseBody Function()>{
    'HTTP failure': () => _jsonResponse({'ret': 503}, statusCode: 503),
    'API failure': () => _jsonResponse({'ret': 503}),
    'HTML challenge': () => ResponseBody.fromString(
      '<html>Verify your browser</html>',
      200,
      headers: {
        Headers.contentTypeHeader: ['text/html'],
      },
    ),
    'malformed JSON': () => ResponseBody.fromString(
      '{invalid',
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    ),
  }.entries) {
    test(
      'cloud reads prefer a usable domain response over ${failure.key}',
      () async {
        final inner = _CallbackAdapter((options, _) async {
          return options.uri.host == 'primary.test'
              ? failure.value()
              : _boughtResponse();
        });
        expect(await _domainService(inner).fetchBought(), isEmpty);
        expect(inner.hosts, ['primary.test', 'spare.test']);
      },
    );
  }

  test('an unrecognized POST is neither hedged nor retried', () async {
    final inner = _CallbackAdapter((options, _) async {
      throw DioException.receiveTimeout(
        requestOptions: options,
        timeout: const Duration(seconds: 1),
      );
    });
    final dio = Dio(BaseOptions(baseUrl: 'https://primary.test/api/v1'))
      ..httpClientAdapter = CloudApiAdapter(
        inner,
        domains: () => ['primary.test', 'spare.test'],
      );
    dio.interceptors.add(RetryInterceptor(dio: dio));
    await expectLater(dio.post('/new-action'), throwsA(isA<DioException>()));
    expect(inner.hosts, ['primary.test']);
  });
  test('an incomplete JSON response cannot win the domain race', () async {
    final inner = _CallbackAdapter((options, _) async {
      if (options.uri.host == 'spare.test') {
        return _boughtResponse();
      }
      return ResponseBody(
        Stream<Uint8List>.error(const SocketException('connection lost')),
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );
    });
    expect(await _domainService(inner).fetchBought(), isEmpty);
  });

  test('cancelled login failover does not dispatch another domain', () async {
    final cancellation = Completer<void>();
    final inner = _CallbackAdapter((options, _) async {
      cancellation.complete();
      await pumpEventQueue();
      throw DioException.connectionError(
        requestOptions: options,
        reason: 'connection failed after cancellation',
      );
    });
    final adapter = CloudApiAdapter(
      inner,
      domains: () => ['primary.test', 'spare.test'],
    );
    await expectLater(
      adapter.fetch(
        RequestOptions(
          path: 'https://primary.test/api/v1/login',
          method: 'POST',
          extra: buildCloudLoginOptions().extra ?? const {},
        ),
        null,
        cancellation.future,
      ),
      throwsA(
        isA<DioException>().having(
          (error) => error.type,
          'type',
          DioExceptionType.cancel,
        ),
      ),
    );
    expect(inner.hosts, ['primary.test']);
  });
  for (final declaredOversize in [false, true]) {
    test(
      'cloud reads reject ${declaredOversize ? 'declared' : 'streamed'} oversized JSON',
      () async {
        final streamCancelled = Completer<void>();
        late StreamController<Uint8List> responseBody;
        responseBody = StreamController<Uint8List>(
          onListen: () {
            if (!declaredOversize) responseBody.add(Uint8List(65));
          },
          onCancel: () => streamCancelled.complete(),
        );
        final inner = _CallbackAdapter((options, _) async {
          if (options.uri.host == 'spare.test') {
            return _boughtResponse();
          }
          return ResponseBody(
            responseBody.stream,
            200,
            headers: {
              if (declaredOversize) Headers.contentLengthHeader: ['65'],
            },
          );
        });
        expect(
          await _domainService(inner, maxResponseBytes: 64).fetchBought(),
          isEmpty,
        );
        await streamCancelled.future.timeout(const Duration(seconds: 1));
        await responseBody.close();
      },
    );
  }

  test(
    'a cloud read deadline cancels an unfinished JSON response stream',
    () async {
      final listening = Completer<void>();
      final streamCancelled = Completer<void>();
      final responseBody = StreamController<Uint8List>(
        onListen: () => listening.complete(),
        onCancel: () => streamCancelled.complete(),
      );
      final inner = _CallbackAdapter((_, _) async {
        return ResponseBody(responseBody.stream, 200);
      });
      final client = Dio(BaseOptions(baseUrl: 'https://primary.test/api/v1'))
        ..httpClientAdapter = CloudApiAdapter(
          inner,
          domains: () => ['primary.test', 'spare.test'],
        );
      final service = CloudApiService.forTesting(
        client: client,
        syncRequestTimeout: const Duration(milliseconds: 50),
      )..setToken('session');
      final failure = expectLater(
        service.fetchBought(),
        throwsA(isA<CloudApiException>()),
      );
      await listening.future;
      await failure;
      await streamCancelled.future.timeout(const Duration(seconds: 1));
      expect(inner.hosts, ['primary.test']);
      await responseBody.close();
    },
  );

  test(
    'a successful domain cancels another incomplete response body',
    () async {
      final streamCancelled = Completer<void>();
      final responseBody = StreamController<Uint8List>(
        onCancel: () => streamCancelled.complete(),
      );
      final inner = _CallbackAdapter((options, _) async {
        return options.uri.host == 'primary.test'
            ? ResponseBody(responseBody.stream, 200)
            : _boughtResponse();
      });
      expect(await _domainService(inner).fetchBought(), isEmpty);
      await streamCancelled.future.timeout(const Duration(seconds: 1));
      await responseBody.close();
    },
  );
  test(
    'cloud reads start both authenticated routes and cancel a stalled loser',
    () async {
      final adapter = QueuedCloudAdapter();
      final service = CloudApiService.forTesting(
        client: adapter.createClient(),
        syncRequestTimeout: const Duration(milliseconds: 400),
        readRoutes: const ['DIRECT', 'PROXY localhost:7890'],
      )..setToken('session');
      final result = service.fetchBought();
      final direct = await adapter.takeRequest();
      expect(direct.options.extra[cloudReadRouteExtraKey], 'DIRECT');
      final proxy = await adapter.takeRequest();
      expect(direct.options.cancelToken?.isCancelled, isFalse);
      expect(
        proxy.options.extra[cloudReadRouteExtraKey],
        'PROXY localhost:7890',
      );
      expect(proxy.options.headers['Authorization'], 'Bearer session');
      proxy.respond({
        'ret': 200,
        'data': {'boughts': []},
      });
      expect(await result, isEmpty);
      expect(proxy.options.cancelToken?.isCancelled, isTrue);
      direct.respond({'ret': 401}, statusCode: 401);
      await pumpEventQueue();
      expect(service.sessionRevision, 1);
      expect(adapter.requestCount, 2);
    },
  );

  for (final apiFailure in [false, true]) {
    test(
      'cloud reads keep the other route after ${apiFailure ? 'API' : 'HTTP'} failure',
      () async {
        final adapter = QueuedCloudAdapter();
        final service = CloudApiService.forTesting(
          client: adapter.createClient(),
          readRoutes: const ['DIRECT', 'PROXY localhost:7890'],
        )..setToken('session');
        final result = service.fetchBought();
        final direct = await adapter.takeRequest();
        direct.respond({'ret': 503}, statusCode: apiFailure ? 200 : 503);
        final proxy = await adapter.takeRequest();
        expect(direct.options.cancelToken?.isCancelled, isFalse);
        expect(
          proxy.options.extra[cloudReadRouteExtraKey],
          'PROXY localhost:7890',
        );
        proxy.respond({
          'ret': 200,
          'data': {'boughts': []},
        });
        expect(await result, isEmpty);
        expect(adapter.requestCount, 2);
      },
    );
  }

  for (final status in [401, 403]) {
    test('cloud HTTP $status terminates both active read routes', () async {
      final adapter = QueuedCloudAdapter();
      final service = CloudApiService.forTesting(
        client: adapter.createClient(),
        readRoutes: const ['DIRECT', 'PROXY localhost:7890'],
      )..setToken('session');
      final failure = expectLater(
        service.fetchBought(),
        throwsA(isA<Exception>()),
      );
      final direct = await adapter.takeRequest();
      direct.respond({
        'ret': status,
        'msg': 'Access denied',
      }, statusCode: status);
      await failure;
      expect(adapter.requestCount, 2);
      expect(direct.options.cancelToken?.isCancelled, isTrue);
    });
  }

  test('cloud racing reads cannot continue as a new account', () async {
    final adapter = QueuedCloudAdapter();
    final service = CloudApiService.forTesting(
      client: adapter.createClient(),
      readRoutes: const ['DIRECT', 'PROXY localhost:7890'],
    )..setToken('account-a');
    final failure = expectLater(
      service.fetchBought(),
      throwsA(predicate<Object>(CloudApiException.isStaleSession)),
    );
    final direct = await adapter.takeRequest();
    final proxy = await adapter.takeRequest();
    service.setToken('account-b');
    direct.response.completeError(
      DioException.connectionError(
        requestOptions: direct.options,
        reason: 'connection lost',
      ),
    );
    await failure;
    expect(adapter.requestCount, 2);
    expect(direct.options.cancelToken?.isCancelled, isTrue);
    expect(proxy.options.cancelToken?.isCancelled, isTrue);
  });

  test('cloud racing reads share one deadline across both routes', () async {
    final adapter = QueuedCloudAdapter();
    final service = CloudApiService.forTesting(
      client: adapter.createClient(),
      syncRequestTimeout: const Duration(milliseconds: 150),
      readRoutes: const ['DIRECT', 'PROXY localhost:7890'],
    )..setToken('session');
    final elapsed = Stopwatch()..start();
    final failure = expectLater(
      service.fetchBought(),
      throwsA(isA<CloudApiException>()),
    );
    final direct = await adapter.takeRequest();
    final proxy = await adapter.takeRequest();
    await failure;
    expect(elapsed.elapsed, lessThan(const Duration(milliseconds: 500)));
    expect(direct.options.cancelToken?.isCancelled, isTrue);
    expect(proxy.options.cancelToken?.isCancelled, isTrue);
    direct.respond({'ret': 401}, statusCode: 401);
    proxy.respond({'ret': 401}, statusCode: 401);
    await pumpEventQueue();
    expect(service.sessionRevision, 1);
  });

  test(
    'cloud route selection keeps writes on native connection fallback',
    () async {
      final native = _CountingAdapter();
      final routes = <String, _CountingAdapter>{};
      final adapter = CloudReadRouteAdapter(
        fallback: native,
        createRouteAdapter: (route) => routes[route] = _CountingAdapter(),
      );
      for (final route in ['DIRECT', 'PROXY localhost:7890']) {
        final response = await adapter.fetch(
          RequestOptions(
            path: 'https://cloud.test/api/v1/information',
            method: 'POST',
            extra: {cloudReadRouteExtraKey: route},
          ),
          null,
          null,
        );
        await response.stream.drain<void>();
      }
      final write = await adapter.fetch(
        RequestOptions(
          path: 'https://cloud.test/api/v1/pay/order',
          method: 'POST',
          extra: {cloudReadRouteExtraKey: 'PROXY localhost:7890'},
        ),
        null,
        null,
      );
      await write.stream.drain<void>();
      expect(routes.keys, ['DIRECT', 'PROXY localhost:7890']);
      expect(routes.values.map((route) => route.fetchCount), [1, 1]);
      expect(native.fetchCount, 1);
    },
  );
  test(
    'a successful direct cloud read cancels the concurrent proxy route',
    () async {
      final adapter = QueuedCloudAdapter();
      final service = CloudApiService.forTesting(
        client: adapter.createClient(),
        readRoutes: const ['DIRECT', 'PROXY localhost:7890'],
      )..setToken('session');
      final result = service.fetchBought();
      final direct = await adapter.takeRequest();
      direct.respond({
        'ret': 200,
        'data': {'boughts': []},
      });
      expect(await result, isEmpty);
      expect(adapter.requestCount, 2);
      expect(direct.options.cancelToken?.isCancelled, isTrue);
    },
  );

  test('an HTML challenge cannot defeat the other cloud read route', () async {
    final adapter = QueuedCloudAdapter();
    final service = CloudApiService.forTesting(
      client: adapter.createClient(),
      readRoutes: const ['DIRECT', 'PROXY localhost:7890'],
    )..setToken('session');
    final result = service.fetchBought();
    final direct = await adapter.takeRequest();
    direct.response.complete(
      ResponseBody.fromString(
        '<html>Challenge</html>',
        200,
        headers: {
          Headers.contentTypeHeader: ['text/html'],
        },
      ),
    );
    final proxy = await adapter.takeRequest();
    expect(direct.options.cancelToken?.isCancelled, isFalse);
    proxy.respond({
      'ret': 200,
      'data': {'boughts': []},
    });
    expect(await result, isEmpty);
    expect(adapter.requestCount, 2);
  });

  for (final status in [401, 403]) {
    for (final apiStatus in [false, true]) {
      test(
        'cloud ${apiStatus ? 'API' : 'HTTP'} $status stops domain and route failover',
        () async {
          final inner = _CallbackAdapter((options, _) async {
            return options.uri.host == 'primary.test'
                ? _jsonResponse({
                    'ret': status,
                    'msg': 'Access denied',
                  }, statusCode: apiStatus ? 200 : status)
                : _jsonResponse({
                    'ret': 200,
                    'data': {'boughts': []},
                  });
          });
          final client =
              Dio(BaseOptions(baseUrl: 'https://primary.test/api/v1'))
                ..httpClientAdapter = CloudApiAdapter(
                  inner,
                  domains: () => ['primary.test', 'spare.test'],
                );
          final service = CloudApiService.forTesting(
            client: client,
            readRoutes: const ['DIRECT', 'PROXY localhost:7890'],
          )..setToken('session');
          addTearDown(() => client.close(force: true));
          await expectLater(
            service.fetchBought(),
            throwsA(
              status == 401
                  ? predicate<Object>(CloudApiException.isUnauthorized)
                  : isA<Exception>(),
            ),
          );
          expect(inner.hosts, ['primary.test', 'primary.test']);
          expect(service.sessionRevision, status == 401 ? 2 : 1);
        },
      );
    }

    test('malformed HTTP $status cannot trigger read fallback', () async {
      final inner = _CallbackAdapter((options, _) async {
        return options.uri.host == 'primary.test'
            ? ResponseBody.fromString(
                '{invalid',
                status,
                headers: {
                  Headers.contentTypeHeader: [Headers.jsonContentType],
                },
              )
            : _jsonResponse({
                'ret': 200,
                'data': {'boughts': []},
              });
      });
      final client = Dio(BaseOptions(baseUrl: 'https://primary.test/api/v1'))
        ..httpClientAdapter = CloudApiAdapter(
          inner,
          domains: () => ['primary.test', 'spare.test'],
        );
      final service = CloudApiService.forTesting(
        client: client,
        readRoutes: const ['DIRECT', 'PROXY localhost:7890'],
      )..setToken('session');
      addTearDown(() => client.close(force: true));
      await expectLater(
        service.fetchBought(),
        throwsA(
          status == 401
              ? predicate<Object>(CloudApiException.isUnauthorized)
              : isA<DioException>().having(
                  (error) => error.response?.statusCode,
                  'HTTP status',
                  status,
                ),
        ),
      );
      expect(inner.hosts, ['primary.test', 'primary.test']);
    });
  }

  test(
    'changing account cancels an active read before its domain hedge',
    () async {
      final dispatched = Completer<void>();
      final canceled = Completer<void>();
      final inner = _CallbackAdapter((options, cancelFuture) {
        if (options.uri.host != 'primary.test') {
          return Future.value(
            _jsonResponse({
              'ret': 200,
              'data': {'boughts': []},
            }),
          );
        }
        if (!dispatched.isCompleted) dispatched.complete();
        unawaited(
          cancelFuture!.then((_) {
            if (!canceled.isCompleted) canceled.complete();
          }),
        );
        return Completer<ResponseBody>().future;
      });
      final client = Dio(BaseOptions(baseUrl: 'https://primary.test/api/v1'))
        ..httpClientAdapter = CloudApiAdapter(
          inner,
          domains: () => ['primary.test', 'spare.test'],
        );
      final service = CloudApiService.forTesting(
        client: client,
        syncRequestTimeout: const Duration(seconds: 1),
        readRoutes: const ['DIRECT', 'PROXY localhost:7890'],
      )..setToken('account-a');
      addTearDown(() => client.close(force: true));
      final failure = expectLater(
        service.fetchBought().timeout(const Duration(milliseconds: 400)),
        throwsA(predicate<Object>(CloudApiException.isStaleSession)),
      );
      await dispatched.future;
      service.setToken('account-b');
      await failure;
      await canceled.future.timeout(const Duration(milliseconds: 100));
      await Future<void>.delayed(const Duration(milliseconds: 300));
      expect(inner.hosts, ['primary.test', 'primary.test']);
    },
  );

  test(
    'an authoritative 401 cancels other reads without masking itself',
    () async {
      final adapter = QueuedCloudAdapter();
      final service = CloudApiService.forTesting(
        client: adapter.createClient(),
        readRoutes: const ['DIRECT', 'PROXY localhost:7890'],
      )..setToken('session');
      final firstFailure = expectLater(
        service.fetchBought(),
        throwsA(predicate<Object>(CloudApiException.isUnauthorized)),
      );
      final first = await adapter.takeRequest();
      final firstSibling = await adapter.takeRequest();
      final secondFailure = expectLater(
        service.fetchPlans(),
        throwsA(predicate<Object>(CloudApiException.isStaleSession)),
      );
      final second = await adapter.takeRequest();
      final secondSibling = await adapter.takeRequest();
      first.respond({'ret': 401}, statusCode: 401);
      await firstFailure;
      await secondFailure;
      expect(firstSibling.options.cancelToken?.isCancelled, isTrue);
      expect(second.options.cancelToken?.isCancelled, isTrue);
      expect(secondSibling.options.cancelToken?.isCancelled, isTrue);
      second.respond({
        'ret': 200,
        'data': {'shops': []},
      });
    },
  );

  test('an invalid account payload cannot win the cloud route race', () async {
    final adapter = QueuedCloudAdapter();
    final service = CloudApiService.forTesting(
      client: adapter.createClient(),
      readRoutes: const ['DIRECT', 'PROXY localhost:7890'],
    )..setToken('session');
    final result = service.getUserInfo();
    final direct = await adapter.takeRequest();
    final proxy = await adapter.takeRequest().timeout(
      const Duration(milliseconds: 100),
    );
    direct.respond({'ret': 200, 'data': {}});
    await pumpEventQueue();
    expect(proxy.options.cancelToken?.isCancelled, isFalse);
    proxy.respond({
      'ret': 200,
      'data': {
        for (final key in [
          'plan',
          'plan_time',
          'used',
          'traffic',
          'today_used',
          'unused',
          'money',
          'aff_money',
          'integral',
        ])
          key: '0',
      },
    });
    await result;
    expect(adapter.requestCount, 2);
  });

  for (final failure in ['signature', 'decryption']) {
    test(
      'managed configuration $failure failure cannot beat a valid route',
      () async {
        final adapter = QueuedCloudAdapter();
        final service = CloudApiService.forTesting(
          client: adapter.createClient(),
          readRoutes: const ['DIRECT', 'PROXY localhost:7890'],
        )..setToken('session');
        final result = service.fetchManagedConfig('token=query-token');
        final direct = await adapter.takeRequest();
        final proxy = await adapter.takeRequest().timeout(
          const Duration(milliseconds: 100),
        );
        final publicKey = _decodeAgeRecipient(
          proxy.options.headers['X-Flclash-Age-Pubkey'] as String,
        );
        final invalidRecipient =
            (await AgeCrypto.generateIdentity()).publicKeyBytes;
        final invalidBytes = await AgeCrypto.encrypt(
          utf8.encode('invalid'),
          invalidRecipient,
        );
        direct.response.complete(
          _managedResponse(
            direct.options,
            invalidBytes,
            validSignature: failure != 'signature',
          ),
        );
        await pumpEventQueue();
        expect(proxy.options.cancelToken?.isCancelled, isFalse);
        final validBytes = await AgeCrypto.encrypt(
          utf8.encode('proxies: []'),
          publicKey,
        );
        proxy.response.complete(_managedResponse(proxy.options, validBytes));
        final (content, userinfo) = await result;
        expect(utf8.decode(content), 'proxies: []');
        expect(userinfo, 'upload=0; download=0');
        expect(direct.options.cancelToken?.isCancelled, isTrue);
        expect(proxy.options.cancelToken?.isCancelled, isTrue);
      },
    );
  }

  test('invalid account data cannot cancel the alternate API domain', () async {
    final inner = _CallbackAdapter((options, _) async {
      expect(options.headers['Authorization'], 'Bearer session');
      return _jsonResponse({
        'ret': 200,
        'data': options.uri.host == 'primary.test'
            ? <String, String>{}
            : {
                for (final key in [
                  'plan',
                  'plan_time',
                  'used',
                  'traffic',
                  'today_used',
                  'unused',
                  'money',
                  'aff_money',
                  'integral',
                ])
                  key: '0',
              },
      });
    });
    final client = Dio(BaseOptions(baseUrl: 'https://primary.test/api/v1'))
      ..httpClientAdapter = CloudApiAdapter(
        inner,
        domains: () => ['primary.test', 'spare.test'],
      );
    final service = CloudApiService.forTesting(
      client: client,
      readRoutes: const ['DIRECT', 'PROXY localhost:7890'],
    )..setToken('session');
    await service.getUserInfo();
    expect(inner.hosts.where((host) => host == 'primary.test'), hasLength(2));
    expect(inner.hosts, contains('spare.test'));
  });

  for (final failure in ['signature', 'decryption', 'configuration']) {
    test(
      'managed $failure failure cannot cancel the alternate domain',
      () async {
        final wrongIdentity = await AgeCrypto.generateIdentity();
        final inner = _CallbackAdapter((options, _) async {
          final primary = options.uri.host == 'primary.test';
          final recipient = primary && failure == 'decryption'
              ? wrongIdentity.publicKeyBytes
              : _decodeAgeRecipient(
                  options.headers['X-Flclash-Age-Pubkey'] as String,
                );
          final bytes = await AgeCrypto.encrypt(
            utf8.encode(
              primary && failure == 'configuration'
                  ? 'invalid config'
                  : 'proxies: []',
            ),
            recipient,
          );
          return _managedResponse(
            options,
            bytes,
            validSignature: !primary || failure != 'signature',
          );
        });
        final client = Dio(BaseOptions(baseUrl: 'https://primary.test/api/v1'))
          ..httpClientAdapter = CloudApiAdapter(
            inner,
            domains: () => ['primary.test', 'spare.test'],
          );
        final service = CloudApiService.forTesting(
          client: client,
          readRoutes: const ['DIRECT', 'PROXY localhost:7890'],
        )..setToken('session');
        final (bytes, userinfo) = await service.fetchManagedConfig(
          'token=local',
          validate: (bytes) async {
            if (utf8.decode(bytes) != 'proxies: []') {
              throw const ConfigValidationException('Invalid candidate config');
            }
          },
        );
        expect(utf8.decode(bytes), 'proxies: []');
        expect(userinfo, 'upload=0; download=0');
        expect(
          inner.hosts.where((host) => host == 'primary.test'),
          hasLength(2),
        );
        expect(inner.hosts, contains('spare.test'));
      },
    );
  }

  test(
    'cloud route pools stay alive through the body and close independently',
    () async {
      final pools = <_BodyPoolAdapter>[];
      final adapter = CloudReadRouteAdapter(
        fallback: _CountingAdapter(),
        createRouteAdapter: (_) {
          final pool = _BodyPoolAdapter();
          pools.add(pool);
          return pool;
        },
      );
      final cancellation = Completer<void>();
      RequestOptions options() => RequestOptions(
        path: 'https://cloud.test/api/v1/information',
        method: 'POST',
        extra: {cloudReadRouteExtraKey: 'DIRECT'},
      );
      final first = await adapter.fetch(options(), null, cancellation.future);
      final second = await adapter.fetch(options(), null, null);
      expect(pools, hasLength(2));
      expect(pools.map((p) => p.closed), [false, false]);
      final firstDone = first.stream.drain<void>();
      final secondDone = second.stream.drain<void>();
      cancellation.complete();
      await firstDone;
      expect(pools.map((p) => p.closed), [true, false]);
      pools[1].body.add(Uint8List.fromList([1]));
      await pools[1].body.close();
      await secondDone;
      expect(pools.map((p) => p.closed), [true, true]);
      adapter.close(force: true);
      await expectLater(adapter.fetch(options(), null, null), throwsStateError);
    },
  );

  for (final auth in <String, Future<dynamic> Function(CloudApiService)>{
    'login': (service) => service.login('user@example.com', 'password'),
    'register': (service) => service.register(
      name: 'User',
      email: 'user@example.com',
      password: 'password',
    ),
  }.entries) {
    test(
      'an invalid ${auth.key} profile cannot replace the current session',
      () async {
        final adapter = QueuedCloudAdapter();
        final service = CloudApiService.forTesting(
          client: adapter.createClient(),
        )..setToken('current-account');
        final revision = service.sessionRevision;
        final failure = expectLater(auth.value(service), throwsException);
        final pending = await adapter.takeRequest();
        pending.respond({
          'ret': 200,
          'data': {'token': 'unusable-account'},
        });
        await failure;
        expect(service.sessionRevision, revision);
        final currentRead = service.fetchBought();
        final current = await adapter.takeRequest();
        expect(
          current.options.headers['Authorization'],
          'Bearer current-account',
        );
        current.respond({
          'ret': 200,
          'data': {'boughts': []},
        });
        expect(await currentRead, isEmpty);
      },
    );
  }
}

class _RacingAdapter implements HttpClientAdapter {
  final losingResponseDrained = Completer<void>();

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    if (options.uri.host == 'spare.test') {
      return _boughtResponse();
    }

    await Future<void>.delayed(const Duration(milliseconds: 300));
    late StreamController<Uint8List> controller;
    controller = StreamController<Uint8List>(
      onListen: () {
        losingResponseDrained.complete();
        controller
          ..add(
            Uint8List.fromList(
              utf8.encode(
                jsonEncode({
                  'ret': 200,
                  'data': {'boughts': []},
                }),
              ),
            ),
          )
          ..close();
      },
    );
    return ResponseBody(
      controller.stream,
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }
}

class _CountingAdapter implements HttpClientAdapter {
  var fetchCount = 0;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    fetchCount++;
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return ResponseBody.fromBytes([1], 200);
  }
}

class _SequentialFailoverAdapter implements HttpClientAdapter {
  _SequentialFailoverAdapter({
    this.primaryErrorType = DioExceptionType.connectionTimeout,
  });

  final DioExceptionType primaryErrorType;
  final hosts = <String>[];
  final bodies = <List<int>>[];
  var _concurrent = 0;
  var maxConcurrent = 0;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    _concurrent++;
    if (_concurrent > maxConcurrent) maxConcurrent = _concurrent;
    hosts.add(options.uri.host);
    bodies.add(
      requestStream == null
          ? const []
          : await requestStream.expand((chunk) => chunk).toList(),
    );

    try {
      await Future<void>.delayed(const Duration(milliseconds: 10));
      if (options.uri.host == 'primary.test') {
        throw DioException(
          requestOptions: options,
          type: primaryErrorType,
          message: 'simulated timeout',
        );
      }
      return ResponseBody.fromBytes([2], 200);
    } finally {
      _concurrent--;
    }
  }
}

CloudApiService _domainService(
  HttpClientAdapter inner, {
  int maxResponseBytes = 64 * 1024 * 1024,
}) {
  final client = Dio(BaseOptions(baseUrl: 'https://primary.test/api/v1'))
    ..httpClientAdapter = CloudApiAdapter(
      inner,
      domains: () => ['primary.test', 'spare.test'],
      maxResponseBytes: maxResponseBytes,
    );
  return CloudApiService.forTesting(client: client)..setToken('session');
}

ResponseBody _boughtResponse() => _jsonResponse({
  'ret': 200,
  'data': {'boughts': []},
});

ResponseBody _jsonResponse(Object data, {int statusCode = 200}) {
  return ResponseBody.fromString(
    jsonEncode(data),
    statusCode,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );
}

class _CallbackAdapter implements HttpClientAdapter {
  _CallbackAdapter(this.callback);

  final Future<ResponseBody> Function(RequestOptions, Future<void>?) callback;
  final hosts = <String>[];

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    hosts.add(options.uri.host);
    return callback(options, cancelFuture);
  }
}

List<int> _decodeAgeRecipient(String recipient) {
  const alphabet = 'qpzry9x8gf2tvdw0s3jn54khce6mua7l';
  final result = <int>[];
  var value = 0;
  var bits = 0;
  for (final char in recipient.substring(4, recipient.length - 6).split('')) {
    value = ((value << 5) | alphabet.indexOf(char)) & 0xffff;
    bits += 5;
    if (bits >= 8) {
      bits -= 8;
      result.add((value >> bits) & 255);
    }
  }
  return result;
}

ResponseBody _managedResponse(
  RequestOptions request,
  List<int> encrypted, {
  bool validSignature = true,
}) {
  final encoded = base64Encode(encrypted);
  final timestamp = request.headers['X-Flclash-Timestamp'];
  final signature = crypto.Hmac(
    crypto.sha256,
    utf8.encode(Secrets.flClashAppSecret),
  ).convert(utf8.encode('$timestamp.$encoded')).toString();
  return ResponseBody.fromString(
    jsonEncode({'config': encoded, 'userinfo': 'upload=0; download=0'}),
    200,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
      'x-flclash-response-signature': [validSignature ? signature : 'invalid'],
    },
  );
}

class _BodyPoolAdapter implements HttpClientAdapter {
  final body = StreamController<Uint8List>();
  bool closed = false;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async => ResponseBody(body.stream, 200);

  @override
  void close({bool force = false}) {
    closed = true;
    unawaited(body.close());
  }
}

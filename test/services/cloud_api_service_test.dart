import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/http.dart';
import 'package:fl_clash/common/secrets.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/cloud_api_adapter.dart';

void main() {
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
      final request = service.deleteAccount(password: 'test-password');
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

  test('delete account request includes confirmation and optional TOTP', () {
    expect(
      buildDeleteAccountRequestData(
        password: 'secret',
        twoFactorCode: ' 123456 ',
      ),
      {'passwd': 'secret', 'confirmation': 'DELETE', 'code': '123456'},
    );

    expect(buildDeleteAccountRequestData(password: 'secret'), {
      'passwd': 'secret',
      'confirmation': 'DELETE',
    });
  });

  test('managed config prefers direct with a ready core fallback', () {
    expect(
      resolveCloudApiProxy(
        isCoreRunning: true,
        hasProxyGroups: true,
        port: 7890,
      ),
      'DIRECT; PROXY localhost:7890',
    );

    for (final state in [
      (running: false, groups: true, port: 7890),
      (running: true, groups: false, port: 7890),
      (running: true, groups: true, port: 0),
    ]) {
      expect(
        resolveCloudApiProxy(
          isCoreRunning: state.running,
          hasProxyGroups: state.groups,
          port: state.port,
        ),
        'DIRECT',
      );
    }
  });

  test('hedged adapter drains a response that loses the race', () async {
    final inner = _RacingAdapter();
    final adapter = HedgedApiAdapter(
      inner,
      domains: () => const ['primary.test', 'spare.test'],
    );

    final response = await adapter.fetch(
      RequestOptions(baseUrl: 'https://primary.test', path: '/profile'),
      null,
      null,
    );

    expect(await response.stream.single, Uint8List.fromList([2]));
    await inner.losingResponseDrained.future.timeout(
      const Duration(seconds: 1),
    );
  });

  test('hedged adapter sends a non-idempotent request only once', () async {
    final inner = _CountingAdapter();
    final adapter = HedgedApiAdapter(
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
    final adapter = HedgedApiAdapter(
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
    final adapter = HedgedApiAdapter(
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
      return ResponseBody.fromBytes([2], 200);
    }

    await Future<void>.delayed(const Duration(milliseconds: 300));
    late StreamController<Uint8List> controller;
    controller = StreamController<Uint8List>(
      onListen: () {
        losingResponseDrained.complete();
        controller
          ..add(Uint8List.fromList([1]))
          ..close();
      },
    );
    return ResponseBody(controller.stream, 200);
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

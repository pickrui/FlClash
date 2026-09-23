import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/host_resolver.dart';
import 'package:fl_clash/common/http.dart';
import 'package:fl_clash/common/proxy_auth.dart';
import 'package:fl_clash/models/config.dart';
import 'package:flutter_test/flutter_test.dart';

class _ChangedCertificate implements X509Certificate {
  @override
  Uint8List get der => Uint8List.fromList([1, 2, 3]);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _AuthenticatedProxy extends HttpOverrides {
  _AuthenticatedProxy(this.port);
  final int port;

  @override
  HttpClient createHttpClient(SecurityContext? context) =>
      ProxyAuthenticatedHttpClient(
        create: () => super.createHttpClient(context),
        read: () => (
          port: port,
          authentication: const AuthenticationProps(
            enable: true,
            username: 'fixture',
            password: 'password',
          ),
        ),
      );
}

void main() {
  late HttpServer origin;
  late HttpServer other;
  late Dio client;
  late Uri target;
  late Uri otherTarget;
  late TlsCertificateFailure failure;
  late List<int> ports;
  late Completer<void> heldRequest;
  late Completer<void> heldClosed;

  Dio retryClient({HostResolver? resolver}) => Dio()
    ..httpClientAdapter = createFlClashHttpClientAdapter(
      findProxy: (_) => 'DIRECT',
      allowCertificateRetry: true,
      resolver: resolver,
    );

  Future<TlsCertificateFailure> rejected(Uri uri, {Dio? using}) async {
    try {
      await (using ?? client).getUri<String>(uri);
      fail('Untrusted certificate was accepted');
    } on DioException catch (error) {
      expect(error.type, DioExceptionType.badCertificate);
      return FlClashTemporaryTls.failureFor(error)!;
    }
  }

  setUp(() async {
    final context = SecurityContext()
      ..useCertificateChain('test/fixtures/tls/server.crt')
      ..usePrivateKey('test/fixtures/tls/server.key');
    origin = await HttpServer.bindSecure(
      InternetAddress.loopbackIPv4,
      0,
      context,
    );
    other = await HttpServer.bindSecure(
      InternetAddress.loopbackIPv4,
      0,
      context,
    );
    target = Uri.parse('https://localhost:${origin.port}/ok');
    otherTarget = Uri.parse('https://localhost:${other.port}/ok');
    ports = [];
    heldRequest = Completer<void>();
    heldClosed = Completer<void>();
    origin.listen((request) async {
      ports.add(request.connectionInfo!.remotePort);
      expect(
        request.headers.value(HttpHeaders.proxyAuthorizationHeader),
        isNull,
      );
      if (request.uri.path == '/held') {
        final socket = await request.response.detachSocket(writeHeaders: false);
        socket.write('HTTP/1.1 200 OK\r\nContent-Length: 100\r\n\r\npartial');
        await socket.flush();
        void disconnected() {
          socket.destroy();
          if (!heldClosed.isCompleted) heldClosed.complete();
        }

        socket.listen(
          (_) {},
          onDone: disconnected,
          onError: (_) => disconnected(),
        );
        heldRequest.complete();
        return;
      }
      if (request.uri.path == '/redirect' || request.uri.path == '/same') {
        request.response.statusCode = HttpStatus.found;
        request.response.headers.set(
          HttpHeaders.locationHeader,
          request.uri.path == '/same' ? '/ok' : otherTarget.toString(),
        );
      } else {
        request.response.write('accepted');
      }
      await request.response.close();
    }, onError: (_) {});
    other.listen((request) async {
      request.response.write('other');
      await request.response.close();
    }, onError: (_) {});
    client = retryClient();
    failure = await rejected(target);
  });

  tearDown(() async {
    client.close(force: true);
    await origin.close(force: true);
    await other.close(force: true);
  });

  test(
    'a shared adapter isolates the retry from concurrent requests',
    () async {
      final entered = Completer<void>();
      final finish = Completer<void>();
      final retry = FlClashTemporaryTls.runWithBadCertificateAllowed(
        failure,
        () async {
          expect((await client.getUri<String>(target)).data, 'accepted');
          entered.complete();
          await finish.future;
        },
      );
      await entered.future;
      expect(FlClashTemporaryTls.allowBadCertificate, isFalse);
      await rejected(target);
      finish.complete();
      await retry;
      await rejected(target);
    },
  );

  test('only the failed origin and certificate are authorized', () async {
    expect(failure.origin.host, 'localhost');
    expect(failure.origin.port, origin.port);
    await FlClashTemporaryTls.runWithBadCertificateAllowed(failure, () async {
      expect((await client.getUri<String>(target)).data, 'accepted');
      await rejected(otherTarget);
      await rejected(target.replace(host: '127.0.0.1'));
      expect(
        (await client.getUri<String>(target.replace(path: '/same'))).data,
        'accepted',
      );
      final redirectedFailure = await rejected(
        target.replace(path: '/redirect'),
      );
      expect(redirectedFailure.origin.port, other.port);
    });
    final changed = TlsCertificateFailure(
      _ChangedCertificate(),
      'localhost',
      origin.port,
    );
    await FlClashTemporaryTls.runWithBadCertificateAllowed(
      changed,
      () => rejected(target),
    );
  });

  test(
    'global clients and strict adapters remain strict inside a retry',
    () async {
      await HttpOverrides.runWithHttpOverrides(() async {
        final raw = HttpClient();
        final strict = Dio()
          ..httpClientAdapter = createFlClashHttpClientAdapter(
            findProxy: (_) => 'DIRECT',
          );
        addTearDown(() => raw.close(force: true));
        addTearDown(() => strict.close(force: true));
        await FlClashTemporaryTls.runWithBadCertificateAllowed(
          failure,
          () async {
            await expectLater(
              raw.getUrl(target),
              throwsA(isA<HandshakeException>()),
            );
            await expectLater(
              strict.getUri<String>(target),
              throwsA(isA<DioException>()),
            );
            expect((await client.getUri<String>(target)).data, 'accepted');
          },
        );
        await expectLater(
          raw.getUrl(target),
          throwsA(isA<HandshakeException>()),
        );
      }, FlClashHttpOverrides());
    },
  );

  test(
    'accepted connections are isolated and cannot outlive the retry',
    () async {
      await FlClashTemporaryTls.runWithBadCertificateAllowed(failure, () async {
        expect((await client.getUri<String>(target)).data, 'accepted');
        expect((await client.getUri<String>(target)).data, 'accepted');
      });
      expect(ports.toSet(), hasLength(2));
      await rejected(target);
    },
  );

  test(
    'an inherited asynchronous task cannot reuse an expired grant',
    () async {
      final gate = Completer<void>();
      late Future<TlsCertificateFailure> delayed;
      await expectLater(
        FlClashTemporaryTls.runWithBadCertificateAllowed(failure, () async {
          delayed = gate.future.then((_) => rejected(target));
          throw StateError('operation failed');
        }),
        throwsStateError,
      );
      gate.complete();
      await delayed;
      await rejected(target);
    },
  );

  test('resolver TLS uses the same scoped certificate decision', () async {
    final resolver = HostResolver(
      lookup: (_, {type = InternetAddressType.any}) async => [
        InternetAddress.loopbackIPv4,
      ],
    );
    final resolved = retryClient(resolver: resolver);
    addTearDown(() => resolved.close(force: true));
    final uri = target.replace(host: 'api.test');
    final failed = await rejected(uri, using: resolved);
    expect(failed.origin.host, 'api.test');
    await FlClashTemporaryTls.runWithBadCertificateAllowed(failed, () async {
      expect((await resolved.getUri<String>(uri)).data, 'accepted');
      await rejected(otherTarget.replace(host: 'api.test'), using: resolved);
    });
    await rejected(uri, using: resolved);
  });
  test('authenticated CONNECT preserves the scoped TLS decision', () async {
    final proxy = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final tunnels = <Socket>[];
    addTearDown(() async {
      for (final socket in tunnels) {
        socket.destroy();
      }
      await proxy.close(force: true);
    });
    var connects = 0;
    proxy.listen((request) async {
      connects++;
      expect(request.method, 'CONNECT');
      expect(
        request.headers.value(HttpHeaders.proxyAuthorizationHeader),
        'Basic ${base64Encode(utf8.encode('fixture:password'))}',
      );
      final upstream = await Socket.connect(
        InternetAddress.loopbackIPv4,
        Uri.parse('http://${request.uri}').port,
      );
      request.response.statusCode = HttpStatus.ok;
      request.response.contentLength = 0;
      final downstream = await request.response.detachSocket();
      tunnels.addAll([upstream, downstream]);
      downstream.listen(
        upstream.add,
        onDone: upstream.destroy,
        onError: (_) => upstream.destroy(),
      );
      upstream.listen(
        downstream.add,
        onDone: downstream.destroy,
        onError: (_) => downstream.destroy(),
      );
    });
    await HttpOverrides.runWithHttpOverrides(() async {
      final tunneled = Dio()
        ..httpClientAdapter = createFlClashHttpClientAdapter(
          findProxy: (_) => 'PROXY localhost:${proxy.port}',
          allowCertificateRetry: true,
        );
      addTearDown(() => tunneled.close(force: true));
      final failed = await rejected(target, using: tunneled);
      await FlClashTemporaryTls.runWithBadCertificateAllowed(failed, () async {
        expect((await tunneled.getUri<String>(target)).data, 'accepted');
        await rejected(otherTarget, using: tunneled);
      });
      await rejected(target, using: tunneled);
    }, _AuthenticatedProxy(proxy.port));
    expect(connects, 4);
  });

  for (final revoke in [false, true]) {
    test(
      revoke
          ? 'revoking a grant closes an unfinished response'
          : 'canceling a retry closes an unfinished response',
      () async {
        final token = CancelToken();
        late Future<void> rejectedRequest;
        await FlClashTemporaryTls.runWithBadCertificateAllowed(
          failure,
          () async {
            rejectedRequest = expectLater(
              client.getUri<String>(
                target.replace(path: '/held'),
                cancelToken: token,
              ),
              throwsA(isA<DioException>()),
            );
            await heldRequest.future;
            if (!revoke) {
              token.cancel('fixture canceled');
              await rejectedRequest;
            }
          },
        );
        await rejectedRequest;
        await heldClosed.future.timeout(const Duration(seconds: 3));
        await rejected(target);
      },
    );
  }
}

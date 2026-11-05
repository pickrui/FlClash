import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:fl_clash/common/tls_connection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late HttpServer server;
  late SecurityContext trust;
  setUp(() async {
    final identity = SecurityContext()
      ..useCertificateChain('test/fixtures/tls/server.crt')
      ..usePrivateKey('test/fixtures/tls/server.key');
    trust = SecurityContext(withTrustedRoots: false)
      ..setTrustedCertificates('test/fixtures/tls/ca.crt');
    server = await HttpServer.bindSecure(
      InternetAddress.loopbackIPv4,
      0,
      identity,
    );
  });
  tearDown(() => server.close(force: true));

  test('trusted HTTPS streams large bodies and preserves the domain', () async {
    final hosts = <String?>[];
    final clients = <int>{};
    server.listen((request) async {
      hosts.add(request.headers.value(HttpHeaders.hostHeader));
      clients.add(request.connectionInfo!.remotePort);
      request.response.headers.contentType = ContentType.binary;
      request.response.contentLength = request.contentLength;
      final body = BytesBuilder(copy: false);
      await for (final chunk in request) {
        body.add(chunk);
      }
      request.response.add(body.takeBytes());
      await request.response.close();
    });
    final client = HttpClient()
      ..connectionFactory = (uri, _, _) => startTlsConnection(
        InternetAddress.loopbackIPv4,
        server.port,
        host: uri.host,
        context: trust,
      );
    addTearDown(() => client.close(force: true));
    final payload = Uint8List.fromList(
      List.generate(2 * 1024 * 1024, (i) => i % 251),
    );
    for (var i = 0; i < 2; i++) {
      final request = await client.postUrl(
        Uri.parse('https://api.test:${server.port}/echo'),
      );
      request.contentLength = payload.length;
      request.add(payload);
      final response = await request.close();
      expect(response.certificate, isNotNull);
      final received = BytesBuilder(copy: false);
      await for (final chunk in response) {
        received.add(chunk);
      }
      expect(received.takeBytes(), payload);
      // HttpClient returns a drained connection to its pool asynchronously.
      await pumpEventQueue();
    }
    expect(hosts, List.filled(2, 'api.test:${server.port}'));
    expect(
      clients,
      hasLength(1),
      reason: 'completed responses keep the TLS connection reusable',
    );
  });

  test('a trusted certificate still rejects the wrong domain', () async {
    server.listen((request) async {
      await request.response.close();
    });
    final task = await startTlsConnection(
      InternetAddress.loopbackIPv4,
      server.port,
      host: 'wrong.test',
      context: trust,
    );
    addTearDown(task.cancel);
    await expectLater(task.socket, throwsA(isA<HandshakeException>()));
  });

  test(
    'an untrusted certificate requires explicit temporary acceptance',
    () async {
      server.listen((request) async {
        await request.response.close();
      });
      final refused = await startTlsConnection(
        InternetAddress.loopbackIPv4,
        server.port,
        host: 'api.test',
      );
      addTearDown(refused.cancel);
      await expectLater(refused.socket, throwsA(isA<HandshakeException>()));
      var asked = false;
      final accepted = await startTlsConnection(
        InternetAddress.loopbackIPv4,
        server.port,
        host: 'api.test',
        onBadCertificate: (_) {
          asked = true;
          return true;
        },
      );
      final socket = await accepted.socket;
      addTearDown(socket.destroy);
      expect(asked, isTrue);
      expect(socket, isA<SecureSocket>());
    },
  );

  test('destroy cancels a bound upload stream without throwing', () async {
    server.listen((request) async {
      await request.response.close();
    });
    final task = await startTlsConnection(
      InternetAddress.loopbackIPv4,
      server.port,
      host: 'api.test',
      context: trust,
    );
    final socket = await task.socket;
    final stream = StreamController<List<int>>();
    addTearDown(() async {
      socket.destroy();
      await stream.close();
    });
    final upload = socket.addStream(stream.stream);
    await pumpEventQueue();
    expect(stream.hasListener, isTrue);
    socket.destroy();
    await upload.timeout(const Duration(seconds: 2));
    await socket.done.timeout(const Duration(seconds: 2));
    expect(stream.hasListener, isFalse);
  });
}

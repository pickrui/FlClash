import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/http.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final fallback in [false, true]) {
    test(
      fallback
          ? 'HTTPS direct fallback cannot reuse a previous proxy tunnel'
          : 'switching HTTPS to direct cannot reuse a previous proxy tunnel',
      () async {
        final context = SecurityContext()
          ..useCertificateChainBytes(utf8.encode(_certificate))
          ..usePrivateKeyBytes(utf8.encode(_privateKey));
        final origin = await HttpServer.bindSecure(
          InternetAddress.loopbackIPv4,
          0,
          context,
        );
        final proxy = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        final proxyPort = proxy.port;
        final tunnels = <Socket>[];
        final proxySourcePorts = <int>{};
        var connectCount = 0;
        var proxyClosed = false;
        var useProxy = true;
        addTearDown(() async {
          for (final socket in tunnels) {
            socket.destroy();
          }
          if (!proxyClosed) await proxy.close(force: true);
          await origin.close(force: true);
        });
        origin.listen((request) async {
          final sourcePort = request.connectionInfo!.remotePort;
          request.response.write(
            proxySourcePorts.contains(sourcePort) ? 'proxy' : 'direct',
          );
          await request.response.close();
        });
        proxy.listen((request) async {
          expect(request.method, 'CONNECT');
          connectCount++;
          final upstream = await Socket.connect(
            InternetAddress.loopbackIPv4,
            origin.port,
          );
          proxySourcePorts.add(upstream.port);
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
        final client = Dio()
          ..httpClientAdapter = createFlClashHttpClientAdapter(
            findProxy: (_) =>
                useProxy ? 'PROXY 127.0.0.1:$proxyPort; DIRECT' : 'DIRECT',
            allowBadCertificate: () => true,
          );
        addTearDown(() => client.close(force: true));
        final url = 'https://localhost:${origin.port}/resource';
        Future<String?> read() async {
          final response = await client.get<String>(
            url,
            // A caller requesting persistence must not defeat route isolation.
            options: Options(persistentConnection: true),
          );
          return response.data;
        }

        expect(await read(), 'proxy');
        expect(connectCount, 1);
        if (fallback) {
          // Detached tunnels remain live in an affected client's origin pool.
          await proxy.close(force: true);
          proxyClosed = true;
        } else {
          useProxy = false;
        }
        expect(await read(), 'direct');
        expect(connectCount, 1);
      },
    );
  }
}

// Self-signed localhost credentials generated solely for these offline tests.
const _certificate = '''
-----BEGIN CERTIFICATE-----
MIIBfDCCASOgAwIBAgIUBhJaB9U1EHlzuRzV52wuWn49ztkwCgYIKoZIzj0EAwIw
FDESMBAGA1UEAwwJbG9jYWxob3N0MB4XDTI2MDkwODExMzUwOVoXDTM2MDkwNTEx
MzUwOVowFDESMBAGA1UEAwwJbG9jYWxob3N0MFkwEwYHKoZIzj0CAQYIKoZIzj0D
AQcDQgAEusAA/6gW26d1ahG6Kn7DzLaJk+1tPRiWjaC/Uml1FviO36bW2DwqinWs
uSDrD6uTTyx+AFi+yJ8wAxeEuGhcL6NTMFEwHQYDVR0OBBYEFLzNV/zTaiA1/IMF
5CkbZUwqQHtfMB8GA1UdIwQYMBaAFLzNV/zTaiA1/IMF5CkbZUwqQHtfMA8GA1Ud
EwEB/wQFMAMBAf8wCgYIKoZIzj0EAwIDRwAwRAIgG/UR8IwhrUOkv1VB9Lzww1ox
pRtYM//bKMQcJRAqmjwCIGsxkqBAmGqdi73d3+DtrgNbW0InoiTz6UnSuk/VYhyp
-----END CERTIFICATE-----
''';

const _privateKey = '''
-----BEGIN PRIVATE KEY-----
MIGHAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBG0wawIBAQQgIdrmLKUczjbclh6y
/xA4C1h1LbUtIoR7sDl3Al+5kXehRANCAAS6wAD/qBbbp3VqEboqfsPMtomT7W09
GJaNoL9SaXUW+I7fptbYPCqKday5IOsPq5NPLH4AWL7InzADF4S4aFwv
-----END PRIVATE KEY-----
''';

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fl_clash/common/proxy_auth.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/providers/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'old configs remain unauthenticated and credentials round trip safely',
    () {
      expect(NetworkProps.fromJson({}).authentication.enable, isFalse);
      final enabled = enableProxyAuthentication(const AuthenticationProps());
      final restored = NetworkProps.fromJson(
        jsonDecode(jsonEncode(NetworkProps(authentication: enabled).toJson())),
      );
      expect(restored.authentication, enabled);
      expect(enabled.username.length, 8);
      expect(enabled.password.length, 20);
      expect(enabled.credentials, ['${enabled.username}:${enabled.password}']);
      expect(restored.toString(), isNot(contains(enabled.password)));
      expect(enableProxyAuthentication(enabled), enabled);
      expect(enabled.copyWith(enable: false).credentials, isEmpty);
    },
  );

  test(
    'credential validation respects SOCKS5 byte lengths and fails closed',
    () {
      for (final value in ['', 'a:b', 'a\n', '中' * 86]) {
        expect(AuthenticationProps.validUsername(value), isFalse);
        expect(
          () => AuthenticationProps(
            enable: true,
            username: value,
            password: 'pass',
          ).credentials,
          throwsFormatException,
        );
      }
      for (final value in ['', 'a\r', 'x' * 256]) {
        expect(AuthenticationProps.validPassword(value), isFalse);
      }
      expect(AuthenticationProps.validPassword(' ;:@ 中文 '), isTrue);
      expect(AuthenticationProps.validUsername('中' * 85), isTrue);
      expect(AuthenticationProps.validPassword('x' * 255), isTrue);
    },
  );

  test(
    'effective system proxy is suspended without erasing saved VPN preferences',
    () {
      final container = ProviderContainer(
        overrides: [
          runTimeProvider.overrideWithBuild((_, _) => 1),
          patchClashConfigProvider.overrideWithBuild(
            (_, _) => const ClashConfig(),
          ),
          vpnSettingProvider.overrideWithBuild((_, _) => const VpnProps()),
          networkSettingProvider.overrideWithBuild(
            (_, _) => const NetworkProps(),
          ),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(proxyStateProvider, (_, _) {});
      addTearDown(subscription.close);
      expect(container.read(proxyStateProvider).systemProxy, isTrue);
      final enabled = enableProxyAuthentication(const AuthenticationProps());
      container
          .read(networkSettingProvider.notifier)
          .update((state) => state.copyWith(authentication: enabled));
      expect(container.read(proxyStateProvider).systemProxy, isFalse);
      expect(container.read(vpnStateProvider).vpnProps.systemProxy, isFalse);
      expect(container.read(vpnStateProvider).vpnProps.enable, isTrue);
      expect(container.read(vpnSettingProvider).systemProxy, isTrue);
      expect(container.read(networkSettingProvider).systemProxy, isTrue);
      expect(
        container.read(updateParamsProvider).authentication,
        enabled.credentials,
      );
      container
          .read(networkSettingProvider.notifier)
          .update(
            (state) =>
                state.copyWith(authentication: enabled.copyWith(enable: false)),
          );
      expect(container.read(proxyStateProvider).systemProxy, isTrue);
      expect(container.read(vpnStateProvider).vpnProps.systemProxy, isTrue);
    },
  );

  test('only active Android VPN HTTP proxy transitions require restart', () {
    expect(
      needsVpnRestartForAuthentication(
        android: true,
        running: true,
        vpn: const VpnProps(),
        before: false,
        after: true,
      ),
      isTrue,
    );
    expect(
      needsVpnRestartForAuthentication(
        android: true,
        running: true,
        vpn: const VpnProps(),
        before: true,
        after: false,
      ),
      isTrue,
    );
    for (final (android, running, vpn, before, after) in [
      (false, true, const VpnProps(), false, true),
      (true, false, const VpnProps(), false, true),
      (true, true, const VpnProps(systemProxy: false), false, true),
      (true, true, const VpnProps(enable: false), false, true),
      (true, true, const VpnProps(), true, true),
    ]) {
      expect(
        needsVpnRestartForAuthentication(
          android: android,
          running: running,
          vpn: vpn,
          before: before,
          after: after,
        ),
        isFalse,
      );
    }
  });

  test(
    'proxy credentials rotate, disable and never reach direct requests',
    () async {
      final proxy = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final origin = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(() => proxy.close(force: true));
      addTearDown(() => origin.close(force: true));
      var auth = const AuthenticationProps(
        enable: true,
        username: 'local',
        password: ' ;:@ 中文 ',
      );
      var direct = false;
      var received = 0;
      final tunnels = <Socket>[];
      final proxyPorts = <int>{};
      addTearDown(() {
        for (final socket in tunnels) {
          socket.destroy();
        }
      });
      proxy.listen((request) async {
        received++;
        final expected = auth.enable
            ? 'Basic ${base64Encode(utf8.encode('${auth.username}:${auth.password}'))}'
            : null;
        expect(
          request.headers.value(HttpHeaders.proxyAuthorizationHeader),
          expected,
        );
        expect(request.headers.value(HttpHeaders.authorizationHeader), isNull);
        expect(request.headers.value(HttpHeaders.userAgentHeader), 'auth-test');
        if (request.method == 'CONNECT') {
          final upstream = await Socket.connect(
            InternetAddress.loopbackIPv4,
            origin.port,
          );
          proxyPorts.add(upstream.port);
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
        } else {
          await request.drain<void>();
          request.response.write('proxy');
          await request.response.close();
        }
      });
      origin.listen((request) async {
        expect(
          request.headers.value(HttpHeaders.proxyAuthorizationHeader),
          isNull,
        );
        request.response.write(
          proxyPorts.contains(request.connectionInfo!.remotePort)
              ? 'proxy'
              : 'direct',
        );
        await request.response.close();
      });
      final client =
          ProxyAuthenticatedHttpClient(
              create: () => _DirectHttpOverrides().createHttpClient(null),
              read: () => (port: proxy.port, authentication: auth),
            )
            ..userAgent = 'auth-test'
            ..findProxy = (_) =>
                direct ? 'DIRECT' : 'PROXY localhost:${proxy.port}';
      addTearDown(() => client.close(force: true));
      final url = Uri.parse('http://localhost:${origin.port}/post');
      Future<String> read() async {
        final request = await client.postUrl(url);
        request.write('payload');
        return utf8.decoder.bind(await request.close()).join();
      }

      expect(await read(), 'proxy');
      auth = auth.copyWith(password: 'new:password;@');
      expect(await read(), 'proxy');
      auth = auth.copyWith(enable: false);
      expect(await read(), 'proxy');
      auth = auth.copyWith(enable: true);
      direct = true;
      expect(await read(), 'direct');
      expect(
        received,
        3,
      ); // Each POST reaches the proxy only once, no 407 replay.
      client.close(force: true);
      expect(() => client.getUrl(url), throwsStateError);
    },
  );
  test('authenticated route falls back only before sending the POST', () async {
    final closed = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
    final proxyPort = closed.port;
    await closed.close();
    final origin = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(() => origin.close(force: true));
    var writes = 0;
    origin.listen((request) async {
      writes++;
      expect(
        request.headers.value(HttpHeaders.proxyAuthorizationHeader),
        isNull,
      );
      expect(await utf8.decoder.bind(request).join(), 'payload');
      request.response.write('ok');
      await request.response.close();
    });
    final client = ProxyAuthenticatedHttpClient(
      create: () => _DirectHttpOverrides().createHttpClient(null),
      read: () => (
        port: proxyPort,
        authentication: const AuthenticationProps(
          enable: true,
          username: 'local',
          password: 'test',
        ),
      ),
    )..findProxy = (_) => 'PROXY localhost:$proxyPort; DIRECT';
    addTearDown(() => client.close(force: true));
    final request = await client.postUrl(
      Uri.parse('http://localhost:${origin.port}/write'),
    );
    request.write('payload');
    expect(await utf8.decoder.bind(await request.close()).join(), 'ok');
    expect(writes, 1);
  });

  test('closing a client cancels a stalled CONNECT without a retry', () async {
    final proxy = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(() => proxy.close(force: true));
    final arrived = Completer<void>();
    var attempts = 0;
    proxy.listen((request) {
      attempts++;
      if (!arrived.isCompleted) arrived.complete();
    });
    final client = ProxyAuthenticatedHttpClient(
      create: () => _DirectHttpOverrides().createHttpClient(null),
      read: () => (
        port: proxy.port,
        authentication: const AuthenticationProps(
          enable: true,
          username: 'local',
          password: 'test',
        ),
      ),
    )..findProxy = (_) => 'PROXY localhost:${proxy.port}';
    final result = expectLater(
      client.getUrl(Uri.parse('https://example.invalid/test')),
      throwsA(isA<Exception>()),
    );
    await arrived.future.timeout(const Duration(seconds: 2));
    client.close(force: true);
    await result.timeout(const Duration(seconds: 2));
    expect(attempts, 1);
  });
}

class _DirectHttpOverrides extends HttpOverrides {}

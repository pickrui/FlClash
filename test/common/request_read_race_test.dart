import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fl_clash/common/request.dart';
import 'package:fl_clash/core/controller.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  setUpAll(() {
    globalState.packageInfo = PackageInfo(
      appName: 'FlClash',
      packageName: 'test.flclash',
      version: '0.8.96',
      buildNumber: '1',
    );
  });

  test(
    'authenticated subscription routes race until a fully validated response wins',
    () async {
      final bothStarted = Completer<void>();
      final paths = <String>[];
      final auth = <String?>[];
      Future<HttpServer> proxy(String body) async {
        final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        addTearDown(() => server.close(force: true));
        server.listen((incoming) async {
          paths.add(incoming.uri.toString());
          auth.add(incoming.headers.value(HttpHeaders.authorizationHeader));
          if (paths.length == 2) bothStarted.complete();
          await bothStarted.future;
          if (body == 'valid configuration') {
            await Future<void>.delayed(const Duration(milliseconds: 20));
          }
          incoming.response.write(body);
          await incoming.response.close();
        });
        return server;
      }

      final fast = await proxy('<html>upstream unavailable</html>');
      final slow = await proxy('valid configuration');
      final request = Request(
        isApiDomain: (_) => false,
        readRoutes: (_) => [
          'PROXY 127.0.0.1:${fast.port}',
          'PROXY 127.0.0.1:${slow.port}',
        ],
        readTimeout: const Duration(seconds: 2),
      );
      addTearDown(() => request.dio.close(force: true));
      final candidates = <String>[];
      final result = await request.getFileResponseForUrl(
        'http://alice:local-test@subscription.invalid/profile?token=local-query',
        validate: (bytes) {
          final candidate = utf8.decode(bytes);
          candidates.add(candidate);
          if (candidate != 'valid configuration') {
            throw const ConfigValidationException('Invalid configuration');
          }
        },
      );
      expect(utf8.decode(result.data!), 'valid configuration');
      expect(candidates, [
        '<html>upstream unavailable</html>',
        'valid configuration',
      ]);
      expect(paths, hasLength(2));
      expect(
        paths.every(
          (path) =>
              path.contains('token=local-query') &&
              !path.contains('local-test'),
        ),
        isTrue,
      );
      expect(
        auth,
        List.filled(
          2,
          'Basic ${base64Encode(utf8.encode('alice:local-test'))}',
        ),
      );
    },
  );

  test(
    'all invalid subscriptions preserve the configuration validation error',
    () async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(() => server.close(force: true));
      server.listen((incoming) async {
        incoming.response.write('invalid');
        await incoming.response.close();
      });
      final request = Request(isApiDomain: (_) => false);
      addTearDown(() => request.dio.close(force: true));
      await expectLater(
        request.getFileResponseForUrl(
          'http://127.0.0.1:${server.port}/profile',
          validate: (_) =>
              throw const ConfigValidationException('Invalid proxy group'),
        ),
        throwsA(
          isA<ConfigValidationException>().having(
            (error) => error.message,
            'message',
            'Invalid proxy group',
          ),
        ),
      );
    },
  );
}

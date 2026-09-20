import 'package:fl_clash/core/interface.dart';
import 'package:fl_clash/core/method.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('default probe budget and RPC guard match upstream', () async {
    final handler = _FakeCoreHandler();
    await handler.asyncTestDelay('https://example.com', 'node');
    expect(handler.arguments, {
      'proxy-name': 'node',
      'timeout': 8000,
      'test-url': 'https://example.com',
      'generation': 0,
    });
    expect(handler.timeout, const Duration(seconds: 30));
  });

  test('the probe carries its test run so the Core can supersede it', () async {
    final handler = _FakeCoreHandler();
    await handler.asyncTestDelay(
      'https://example.com',
      'node',
      generation: 7,
      session: 'frontend-session',
    );
    expect((handler.arguments as Map)['generation'], 7);
    expect((handler.arguments as Map)['session'], 'frontend-session');
  });

  test('a custom network budget always fits inside the RPC guard', () async {
    final handler = _FakeCoreHandler();
    await handler.asyncTestDelay(
      'https://example.com',
      'node',
      timeout: const Duration(seconds: 40),
    );
    expect((handler.arguments as Map)['timeout'], 40000);
    expect(handler.timeout, const Duration(seconds: 42));
  });

  test('only an actual failed probe produces a failure result', () async {
    final handler = _FakeCoreHandler();
    for (final value in [25, -1]) {
      handler.response = {
        'name': 'node',
        'url': 'https://example.com',
        'value': value,
      };
      final result = await handler.asyncTestDelay(
        'https://example.com',
        'node',
      );
      expect(result.value, value);
    }
    handler.response = null;
    final result = await handler.asyncTestDelay('https://example.com', 'node');
    expect(result.value, isNull);
    expect(result.url, 'https://example.com');
  });
  const setupParams = SetupParams(
    selectedMap: {},
    testUrl: 'https://example.com',
  );
  const updateParams = UpdateParams(
    tun: Tun(),
    mixedPort: 7895,
    allowLan: false,
    findProcessMode: FindProcessMode.off,
    mode: Mode.rule,
    logLevel: LogLevel.error,
    ipv6: false,
    tcpConcurrent: true,
    externalController: '',
    secret: '',
    unifiedDelay: true,
  );

  test('configuration operations require an actual Core response', () async {
    final handler = _FakeCoreHandler();
    final operations = <CoreMethod, Future<String> Function()>{
      CoreMethod.validateConfig: () => handler.validateConfig('config.yaml'),
      CoreMethod.validateConfigWithBytes: () =>
          handler.validateConfigWithBytes('encoded-config'),
      CoreMethod.setupConfig: () => handler.setupConfig(setupParams),
      CoreMethod.updateConfig: () => handler.updateConfig(updateParams),
    };

    for (final entry in operations.entries) {
      handler.response = null;
      await expectLater(entry.value(), throwsA(_missingResponse(entry.key)));

      handler.response = '';
      expect(await entry.value(), isEmpty);
      handler.response = 'configuration rejected';
      expect(await entry.value(), 'configuration rejected');
    }
  });

  test(
    'Geo updates distinguish missing responses from success and rejection',
    () async {
      final handler = _FakeCoreHandler();
      for (final type in GeoResource.values) {
        final params = UpdateGeoDataParams(
          geoType: type.name,
          geoName: '${type.name.toLowerCase()}.dat',
          url: 'https://example.com/${type.name}',
        );

        handler.response = null;
        await expectLater(
          handler.updateGeoData(params),
          throwsA(_missingResponse(CoreMethod.updateGeoData)),
        );

        handler.response = '';
        expect(await handler.updateGeoData(params), isEmpty);
        handler.response = 'GEO download failed';
        expect(await handler.updateGeoData(params), 'GEO download failed');
      }
    },
  );

  test(
    'listener and shutdown operations distinguish no response from false',
    () async {
      final handler = _FakeCoreHandler();
      final operations = <CoreMethod, Future<bool> Function()>{
        CoreMethod.startListener: handler.startListener,
        CoreMethod.stopListener: handler.stopListener,
        CoreMethod.shutdown: handler.shutdownCore,
      };

      for (final entry in operations.entries) {
        handler.response = null;
        await expectLater(entry.value(), throwsA(_missingResponse(entry.key)));

        handler.response = false;
        expect(await entry.value(), isFalse);
        handler.response = true;
        expect(await entry.value(), isTrue);
      }
    },
  );

  test(
    'optional observations and delay probes retain missing response defaults',
    () async {
      final handler = _FakeCoreHandler();

      expect(await handler.isInit, isFalse);
      expect(await handler.getMemory(), 0);
      expect(await handler.getCountryCode('127.0.0.1'), isEmpty);
      final delay = await handler.asyncTestDelay('https://example.com', 'node');
      expect(delay.value, isNull);
      expect(delay.name, 'node');
    },
  );
}

Matcher _missingResponse(CoreMethod method) {
  return isA<CoreMethodException>()
      .having((error) => error.code, 'code', 'empty_result')
      .having((error) => error.message, 'message', contains(method.name));
}

class _FakeCoreHandler extends CoreHandlerInterface {
  Object? response;
  Object? arguments;
  Duration? timeout;

  @override
  bool get isConnected => true;

  @override
  Future<bool> destroy() async => true;

  @override
  Future<String> preload() async => '';

  @override
  Future<bool> shutdown(bool isUser) => shutdownCore();

  @override
  Future<T?> invokeMethod<T>({
    required CoreMethod method,
    Object? arguments,
    Duration? timeout,
  }) async {
    this.arguments = arguments;
    this.timeout = timeout;
    return response as T?;
  }
}

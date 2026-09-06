import 'package:fl_clash/core/interface.dart';
import 'package:fl_clash/core/method.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
      expect(delay.value, -1);
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
  }) async => response as T?;
}

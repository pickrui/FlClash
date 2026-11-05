import 'package:flutter_test/flutter_test.dart';
import 'package:proxy/proxy_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final proxy = MethodChannelProxy();
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  tearDown(() => messenger.setMockMethodCallHandler(proxy.methodChannel, null));
  test(
    'diagnostic channel forwards native flags without proxy mutations',
    () async {
      final calls = <String>[];
      messenger.setMockMethodCallHandler(proxy.methodChannel, (call) async {
        calls.add(call.method);
        return {'flags': 10, 'proxyServer': '127.0.0.1:7890'};
      });
      expect(await proxy.getProxySettings(), {
        'flags': 10,
        'proxyServer': '127.0.0.1:7890',
      });
      expect(calls, ['GetProxySettings']);
    },
  );
  test('unavailable native state is represented as null', () async {
    messenger.setMockMethodCallHandler(proxy.methodChannel, (_) async => null);
    expect(await proxy.getProxySettings(), isNull);
  });
}

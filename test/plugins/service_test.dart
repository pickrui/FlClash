import 'dart:async';

import 'package:fl_clash/common/constant.dart';
import 'package:fl_clash/plugins/service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class _Listener with ServiceListener {
  int changes = 0;
  final crashes = <String>[];

  @override
  void onServiceStateChanged() => changes++;

  @override
  void onServiceCrash(String message) => crashes.add(message);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('$packageName/service');
  const codec = StandardMethodCodec();
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  final service = Service();
  late _Listener listener;

  Future<void> sendNative(String method, [Object? arguments]) {
    final response = Completer<void>();
    messenger.handlePlatformMessage(
      channel.name,
      codec.encodeMethodCall(MethodCall(method, arguments)),
      (data) {
        try {
          if (data != null) codec.decodeEnvelope(data);
          response.complete();
        } catch (error, stackTrace) {
          response.completeError(error, stackTrace);
        }
      },
    );
    return response.future;
  }

  setUp(() {
    listener = _Listener();
    service.addListener(listener);
  });
  tearDown(() {
    service.removeListener(listener);
    messenger.setMockMethodCallHandler(channel, null);
  });

  test(
    'VPN state changes do not report a Core crash or request stop',
    () async {
      final calls = <String>[];
      messenger.setMockMethodCallHandler(channel, (call) async {
        calls.add(call.method);
        return null;
      });
      await sendNative('stateChanged');
      await sendNative('stateChanged');
      expect(listener.changes, 2);
      expect(listener.crashes, isEmpty);
      expect(calls, isEmpty);
      await sendNative('crash', 'Core process disconnected');
      expect(listener.crashes, ['Core process disconnected']);
      expect(listener.changes, 2);
    },
  );

  test('state listeners stop receiving notifications after removal', () async {
    service.removeListener(listener);
    await sendNative('stateChanged');
    expect(listener.changes, 0);
  });

  test(
    'authoritative synchronization uses the returned current runtime',
    () async {
      var runtime = 123;
      messenger.setMockMethodCallHandler(channel, (call) async {
        expect(call.method, 'syncRunState');
        expect(call.arguments, isNull);
        return runtime;
      });
      expect(
        await service.syncRunState(),
        DateTime.fromMillisecondsSinceEpoch(123),
      );
      runtime = 0;
      expect(await service.syncRunState(), isNull);
      expect(await service.syncRunState(), isNull);
    },
  );

  test('missing or failed queries are not interpreted as stopped', () async {
    messenger.setMockMethodCallHandler(channel, (_) async => null);
    await expectLater(service.syncRunState(), throwsStateError);
    messenger.setMockMethodCallHandler(channel, (_) async {
      throw PlatformException(code: 'service_error');
    });
    await expectLater(
      service.syncRunState(),
      throwsA(isA<PlatformException>()),
    );
  });
}

import 'dart:async';

import 'package:fl_clash/common/constant.dart';
import 'package:fl_clash/plugins/tile.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class _Listener with TileListener {
  FutureOr<bool> Function()? start;
  FutureOr<bool> Function()? stop;

  @override
  FutureOr<bool> onStart() => start?.call() ?? false;

  @override
  FutureOr<bool> onStop() => stop?.call() ?? false;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('$packageName/tile');
  const codec = StandardMethodCodec();
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  final tile = Tile.instance;
  late _Listener listener;
  final readiness = <bool>[];

  Future<Object?> sendNative(String method) {
    final response = Completer<Object?>();
    messenger.handlePlatformMessage(
      channel.name,
      codec.encodeMethodCall(MethodCall(method)),
      (data) {
        try {
          response.complete(data == null ? null : codec.decodeEnvelope(data));
        } catch (error, stackTrace) {
          response.completeError(error, stackTrace);
        }
      },
    );
    return response.future;
  }

  setUp(() async {
    readiness.clear();
    messenger.setMockMethodCallHandler(channel, (call) async {
      expect(call.method, 'setReady');
      readiness.add(call.arguments as bool);
      return null;
    });
    listener = _Listener();
    tile.addListener(listener);
    await tile.setReady(false);
  });

  tearDown(() async {
    tile.removeListener(listener);
    await tile.setReady(false);
    messenger.setMockMethodCallHandler(channel, null);
  });

  test('does not acknowledge shortcuts before initialization', () async {
    var starts = 0;
    listener.start = () {
      starts++;
      return true;
    };

    expect(await sendNative('start'), false);
    expect(starts, 0);

    await tile.setReady(true);
    expect(readiness, [false, true]);
    expect(await sendNative('start'), true);
    expect(starts, 1);
  });

  for (final method in ['start', 'stop']) {
    test('acknowledges $method only after the operation finishes', () async {
      final started = Completer<void>();
      final finished = Completer<void>();
      Future<bool> handle() async {
        started.complete();
        await finished.future;
        return true;
      }

      listener.start = handle;
      listener.stop = handle;
      await tile.setReady(true);
      var replied = false;
      final response = sendNative(method).then((value) {
        replied = true;
        return value;
      });
      await started.future;
      expect(replied, false);

      finished.complete();
      expect(await response, true);
    });
  }

  test('revokes readiness when the last listener is removed', () async {
    listener.start = () => true;
    await tile.setReady(true);

    tile.removeListener(listener);
    await tile.setReady(true);

    expect(readiness.last, false);
    expect(await sendNative('start'), false);
  });

  test('does not report an unhandled shortcut as accepted', () async {
    await tile.setReady(true);

    expect(await sendNative('start'), false);
    expect(await sendNative('stop'), false);
  });

  test('reports operation failures to the native caller', () async {
    listener.start = () => Future<bool>.error(StateError('start failed'));
    await tile.setReady(true);

    await expectLater(
      sendNative('start'),
      throwsA(
        isA<PlatformException>().having(
          (error) => error.message,
          'message',
          contains('start failed'),
        ),
      ),
    );
  });

  test('stops dispatching after a listener accepts the shortcut', () async {
    final other = _Listener();
    var calls = 0;
    listener.start = () => true;
    other.start = () {
      calls++;
      return true;
    };
    tile.addListener(other);
    addTearDown(() => tile.removeListener(other));
    await tile.setReady(true);

    expect(await sendNative('start'), true);
    expect(calls, 0);
  });
}

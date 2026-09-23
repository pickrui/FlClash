import 'dart:async';

import 'package:fl_clash/pages/scan.dart';
import 'package:fl_clash/providers/action.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../helpers/test_app.dart';

class _FakeScannerPlatform extends MobileScannerPlatform {
  final _barcodes = StreamController<BarcodeCapture?>.broadcast();
  final _torch = StreamController<TorchState>.broadcast();
  final _zoom = StreamController<double>.broadcast();

  Completer<void>? permission;
  bool denied = false;
  int startCalls = 0;
  int stopCalls = 0;
  int disposeCalls = 0;

  void emit(BarcodeCapture capture) => _barcodes.add(capture);

  @override
  Stream<BarcodeCapture?> get barcodesStream => _barcodes.stream;

  @override
  Stream<TorchState> get torchStateStream => _torch.stream;

  @override
  Stream<double> get zoomScaleStateStream => _zoom.stream;

  @override
  Widget buildCameraView() => const SizedBox.shrink();

  @override
  Future<MobileScannerViewAttributes> start(StartOptions startOptions) async {
    startCalls++;
    await permission?.future;
    if (denied) {
      throw const MobileScannerException(
        errorCode: MobileScannerErrorCode.permissionDenied,
      );
    }
    return const MobileScannerViewAttributes(
      cameraDirection: CameraFacing.back,
      currentTorchMode: TorchState.off,
      size: Size(100, 100),
    );
  }

  @override
  Future<void> stop() async {
    stopCalls++;
  }

  @override
  Future<void> updateScanWindow(Rect? window) async {}

  @override
  Future<void> dispose() async {
    disposeCalls++;
  }

  Future<void> close() async {
    await _barcodes.close();
    await _torch.close();
    await _zoom.close();
  }
}

class _PickerProfileAction extends ProfileAction {
  final picked = Completer<void>();
  int picks = 0;

  @override
  Future<void> addProfileFormQrCode() {
    picks++;
    return picked.future;
  }
}

BarcodeCapture _capture(BarcodeType type, String rawValue) {
  return BarcodeCapture(
    barcodes: [Barcode(type: type, rawValue: rawValue)],
  );
}

Future<void> _sendLifecycle(WidgetTester tester, AppLifecycleState state) {
  return tester.binding.defaultBinaryMessenger.handlePlatformMessage(
    'flutter/lifecycle',
    const StringCodec().encodeMessage(state.toString()),
    (_) {},
  );
}

Future<void> _sendLifecycles(
  WidgetTester tester,
  List<AppLifecycleState> states,
) async {
  for (final state in states) {
    await _sendLifecycle(tester, state);
  }
}

const _leave = [
  AppLifecycleState.inactive,
  AppLifecycleState.hidden,
  AppLifecycleState.paused,
];

const _return = [
  AppLifecycleState.hidden,
  AppLifecycleState.inactive,
  AppLifecycleState.resumed,
];

Future<void> _leaveAndReturn(WidgetTester tester) {
  return _sendLifecycles(tester, [..._leave, ..._return]);
}

void main() {
  late _FakeScannerPlatform platform;

  setUp(() {
    platform = _FakeScannerPlatform();
    MobileScannerPlatform.instance = platform;
    addTearDown(platform.close);
  });

  Future<void> pumpScanPage(
    WidgetTester tester, {
    void Function(String? result)? onPopped,
    bool settle = true,
    List<Override> overrides = const [],
  }) async {
    late BuildContext hostContext;
    await tester.pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: TestApp(
          child: Builder(
            builder: (context) {
              hostContext = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
    unawaited(
      Navigator.of(hostContext)
          .push<String>(
            MaterialPageRoute<String>(builder: (_) => const ScanPage()),
          )
          .then((value) => onPopped?.call(value)),
    );
    if (settle) {
      await tester.pumpAndSettle();
    } else {
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
    }
  }

  testWidgets('opening the page starts the camera once', (tester) async {
    await pumpScanPage(tester);

    expect(platform.startCalls, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('closing the page keeps the dispose contract', (tester) async {
    await pumpScanPage(tester);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(platform.disposeCalls, 1);
  });

  testWidgets('a barcode after teardown never pops a dead route', (
    tester,
  ) async {
    var popped = false;
    await pumpScanPage(tester, onPopped: (_) => popped = true);

    await tester.pumpWidget(const SizedBox.shrink());
    platform.emit(_capture(BarcodeType.url, 'https://a.example'));
    await tester.pumpAndSettle();

    expect(popped, isFalse);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a url barcode pops its raw value', (tester) async {
    String? result;
    await pumpScanPage(tester, onPopped: (value) => result = value);

    platform.emit(_capture(BarcodeType.url, 'https://sub.example/x'));
    await tester.pumpAndSettle();

    expect(result, 'https://sub.example/x');
  });

  testWidgets('going inactive stops and resuming restarts the camera', (
    tester,
  ) async {
    var popCount = 0;
    await pumpScanPage(tester, onPopped: (_) => popCount++);

    await _sendLifecycle(tester, AppLifecycleState.inactive);
    await tester.pumpAndSettle();
    expect(platform.stopCalls, 1);

    await _sendLifecycle(tester, AppLifecycleState.resumed);
    await tester.pumpAndSettle();
    expect(platform.startCalls, 2);

    platform.emit(_capture(BarcodeType.url, 'https://b.example'));
    await tester.pumpAndSettle();
    expect(popCount, 1);
  });

  testWidgets('a permission prompt does not start the camera again', (
    tester,
  ) async {
    final permission = platform.permission = Completer<void>();
    await pumpScanPage(tester, settle: false);
    expect(platform.startCalls, 1);

    await _sendLifecycle(tester, AppLifecycleState.inactive);
    await _sendLifecycle(tester, AppLifecycleState.resumed);
    await tester.pump();

    permission.complete();
    await tester.pumpAndSettle();

    expect(platform.startCalls, 1);
    expect(platform.stopCalls, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a denial is retried only after returning from outside the app', (
    tester,
  ) async {
    String? result;
    platform.denied = true;
    await pumpScanPage(tester, onPopped: (value) => result = value);
    expect(platform.startCalls, 1);

    await _sendLifecycle(tester, AppLifecycleState.inactive);
    await _sendLifecycle(tester, AppLifecycleState.resumed);
    await tester.pumpAndSettle();
    expect(platform.startCalls, 1);

    platform.denied = false;
    await _leaveAndReturn(tester);
    await tester.pumpAndSettle();
    expect(platform.startCalls, 2);

    platform.emit(_capture(BarcodeType.url, 'https://c.example'));
    await tester.pumpAndSettle();
    expect(result, 'https://c.example');
    expect(tester.takeException(), isNull);
  });

  testWidgets('a retried start that prompts again does not start twice', (
    tester,
  ) async {
    String? result;
    platform.denied = true;
    await pumpScanPage(tester, onPopped: (value) => result = value);

    final permission = platform.permission = Completer<void>();
    await _leaveAndReturn(tester);
    await tester.pump();
    expect(platform.startCalls, 2);

    await _sendLifecycle(tester, AppLifecycleState.inactive);
    await _sendLifecycle(tester, AppLifecycleState.resumed);
    await tester.pump();

    platform.denied = false;
    permission.complete();
    await tester.pumpAndSettle();
    expect(platform.startCalls, 2);
    expect(tester.takeException(), isNull);

    platform.emit(_capture(BarcodeType.url, 'https://d.example'));
    await tester.pumpAndSettle();
    expect(result, 'https://d.example');
  });

  testWidgets('a denial after leaving during the prompt is not asked again', (
    tester,
  ) async {
    final permission = platform.permission = Completer<void>();
    platform.denied = true;
    await pumpScanPage(tester, settle: false);
    expect(platform.startCalls, 1);

    await _sendLifecycles(tester, _leave);
    permission.complete();
    await tester.pump();
    await _sendLifecycles(tester, _return);
    await tester.pumpAndSettle();
    expect(platform.startCalls, 1);

    platform.denied = false;
    await _leaveAndReturn(tester);
    await tester.pumpAndSettle();
    expect(platform.startCalls, 2);
    expect(tester.takeException(), isNull);
  });

  testWidgets('the gallery picker is not leaving the app after a denial', (
    tester,
  ) async {
    final action = _PickerProfileAction();
    platform.denied = true;
    await pumpScanPage(
      tester,
      overrides: [profileActionProvider.overrideWith(() => action)],
    );
    expect(platform.startCalls, 1);

    await tester.tap(find.byIcon(Icons.photo_camera_back));
    await tester.pump();
    expect(action.picks, 1);

    await _sendLifecycles(tester, _leave);
    action.picked.complete();
    await tester.pump();
    await _sendLifecycles(tester, _return);
    await tester.pumpAndSettle();
    expect(platform.startCalls, 1);

    platform.denied = false;
    await _leaveAndReturn(tester);
    await tester.pumpAndSettle();
    expect(platform.startCalls, 2);
    expect(tester.takeException(), isNull);
  });
}

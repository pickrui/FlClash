import 'dart:async';

import 'package:fl_clash/pages/scan.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../helpers/test_app.dart';

class _FakeScannerPlatform extends MobileScannerPlatform {
  final _barcodes = StreamController<BarcodeCapture?>.broadcast();
  final _torch = StreamController<TorchState>.broadcast();
  final _zoom = StreamController<double>.broadcast();

  Completer<void>? permission;
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
  }) async {
    late BuildContext hostContext;
    await tester.pumpWidget(
      ProviderScope(
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
}

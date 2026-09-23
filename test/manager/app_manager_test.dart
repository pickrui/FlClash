import 'package:fl_clash/common/render.dart';
import 'package:fl_clash/common/render_binding.dart';
import 'package:fl_clash/manager/app_manager.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _AppManagerTestBinding extends AutomatedTestWidgetsFlutterBinding
    with RenderSchedulerBinding {}

void main() {
  final binding = _AppManagerTestBinding();
  const contentKey = ValueKey('app-state-content');

  Future<void> withManager(
    WidgetTester tester, {
    bool windowVisible = true,
    void Function()? onHover,
    required Future<void> Function() check,
  }) async {
    final container = ProviderContainer();
    globalState.container = container;
    render!.resume();
    binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    globalState.setUpdateVisibility(
      appVisible: true,
      windowVisible: windowVisible,
      trayTraffic: false,
    );
    try {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: AppStateManager(
            child: Listener(
              key: contentKey,
              behavior: HitTestBehavior.opaque,
              onPointerHover: (_) => onHover?.call(),
              child: const SizedBox.expand(),
            ),
          ),
        ),
      );
      await check();
    } finally {
      render!.resume();
      await tester.pumpWidget(const SizedBox.shrink());
      globalState.stopUpdateTasks();
      globalState.setUpdateVisibility(
        appVisible: true,
        windowVisible: true,
        trayTraffic: false,
      );
      binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      container.dispose();
    }
    expect(tester.takeException(), isNull);
  }

  for (final windowVisible in [false, true]) {
    testWidgets(
      windowVisible
          ? 'resumed restores rendering when the desktop window is visible'
          : 'resumed preserves rendering pause while the desktop window is hidden',
      (tester) async {
        await withManager(
          tester,
          windowVisible: windowVisible,
          check: () async {
            render!.pause();
            await tester.pump(const Duration(seconds: 5));
            await tester.pump();
            expect(binding.renderPaused, isTrue);
            expect(binding.hasScheduledFrame, isFalse);

            binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);

            expect(globalState.isUiVisible, windowVisible);
            expect(binding.renderPaused, !windowVisible);
            expect(binding.framesEnabled, windowVisible);
            binding.scheduleFrame();
            expect(binding.hasScheduledFrame, windowVisible);
          },
        );
      },
    );
  }

  testWidgets(
    'hover delivered after hide preserves pending and active pauses',
    (tester) async {
      var hovers = 0;
      await withManager(
        tester,
        onHover: () => hovers++,
        check: () async {
          final position = tester.getCenter(find.byKey(contentKey));
          final mouse = await tester.createGesture(
            kind: PointerDeviceKind.mouse,
          );
          await mouse.addPointer(location: position);
          try {
            await mouse.moveTo(position + const Offset(1, 0));
            expect(hovers, 1);

            globalState.setUpdateVisibility(windowVisible: false);
            render!.pause();
            await mouse.moveTo(position + const Offset(2, 0));
            expect(hovers, 2);
            await tester.pump(const Duration(seconds: 5));
            await tester.pump();
            expect(binding.renderPaused, isTrue);
            expect(binding.hasScheduledFrame, isFalse);

            await mouse.moveTo(position + const Offset(3, 0));
            expect(hovers, 3);
            expect(globalState.isUiVisible, isFalse);
            expect(binding.renderPaused, isTrue);
            binding.scheduleFrame();
            expect(binding.hasScheduledFrame, isFalse);
          } finally {
            await mouse.removePointer();
          }
        },
      );
    },
  );
}

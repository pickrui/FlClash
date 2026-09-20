import 'package:fl_clash/state.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer container;
  setUp(() {
    container = ProviderContainer();
    container.listen(networkSettingProvider, (_, _) {});
    container.listen(runTimeProvider, (_, _) {});
    globalState.container = container;
    globalState.startTime = null;
    globalState.setUpdateVisibility(
      appVisible: true,
      windowVisible: true,
      trayTraffic: false,
    );
  });
  tearDown(() {
    globalState.stopUpdateTasks();
    globalState.startTime = null;
    globalState.setUpdateVisibility(
      appVisible: true,
      windowVisible: true,
      trayTraffic: false,
    );
    container.dispose();
  });

  for (final suspendOnIdle in [false, true]) {
    testWidgets(
      'automatic sampling demand is independent of suspendOnIdle=$suspendOnIdle',
      (tester) async {
        container
            .read(networkSettingProvider.notifier)
            .update((state) => state.copyWith(suspendOnIdle: suspendOnIdle));
        var samples = 0;
        globalState.setUpdateVisibility(windowVisible: false);
        globalState.startTime = DateTime.now();
        await globalState.startUpdateTasks([() => samples++]);
        expect(container.read(runTimeProvider), isNotNull);
        await tester.pump(const Duration(minutes: 5));
        expect(samples, 0);
        globalState.setUpdateVisibility(trayTraffic: true);
        await tester.pump();
        expect(samples, 1);
        expect(globalState.isUiVisible, isFalse);
        await tester.pump(const Duration(seconds: 1));
        expect(samples, 2);
        globalState.setUpdateVisibility(trayTraffic: false);
        await tester.pump(const Duration(minutes: 5));
        expect(samples, 2);
        globalState.setUpdateVisibility(windowVisible: true);
        await tester.pump();
        expect(samples, 3);
        expect(globalState.isUiVisible, isTrue);
        expect(
          container.read(networkSettingProvider).suspendOnIdle,
          suspendOnIdle,
        );
        globalState.stopUpdateTasks();
        globalState.startTime = null;
        globalState.setUpdateVisibility(windowVisible: false);
        globalState.setUpdateVisibility(windowVisible: true, trayTraffic: true);
        await tester.pump(const Duration(minutes: 5));
        expect(samples, 3);
      },
    );
  }

  testWidgets(
    'app background and window visibility must both recover before UI polling',
    (tester) async {
      var samples = 0;
      await globalState.startUpdateTasks([() => samples++]);
      globalState.setUpdateVisibility(appVisible: false, windowVisible: false);
      globalState.setUpdateVisibility(appVisible: true);
      await tester.pump(const Duration(minutes: 5));
      expect(samples, 1);
      globalState.setUpdateVisibility(windowVisible: true);
      await tester.pump();
      expect(samples, 2);
      globalState.setUpdateVisibility(appVisible: false);
      await tester.pump(const Duration(minutes: 5));
      expect(samples, 2);
      globalState.setUpdateVisibility(appVisible: true);
      await tester.pump();
      expect(samples, 3);
      globalState.stopUpdateTasks();
    },
  );
}

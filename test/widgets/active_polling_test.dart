import 'package:fl_clash/widgets/active_polling.dart';
import 'package:fl_clash/widgets/inherited.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  late int polls;

  setUp(() {
    polls = 0;
  });

  Future<void> mount(WidgetTester tester, {bool isPageActive = true}) async {
    await tester.pumpWidget(
      PageActivityScope(
        isActive: isPageActive,
        child: _Poller(onPoll: () => polls++),
      ),
    );
    await tester.pump();
  }

  void setLifecycle(WidgetTester tester, AppLifecycleState state) {
    tester.binding.handleAppLifecycleStateChanged(state);
  }

  Future<void> tick(WidgetTester tester, [int seconds = 1]) async {
    await tester.pump(Duration(seconds: seconds));
    await tester.pump();
  }

  testWidgets('polls on start and then on every interval', (tester) async {
    setLifecycle(tester, AppLifecycleState.resumed);
    await mount(tester);
    expect(polls, 1);

    await tick(tester);
    expect(polls, 2);

    await tick(tester);
    expect(polls, 3);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('polls only while the page is active', (tester) async {
    setLifecycle(tester, AppLifecycleState.resumed);
    await mount(tester, isPageActive: false);
    await tick(tester, 3);
    expect(polls, 0);

    await mount(tester);
    expect(polls, 1);

    await mount(tester, isPageActive: false);
    await tick(tester, 3);
    expect(polls, 1);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('stops polling while the app is paused', (tester) async {
    setLifecycle(tester, AppLifecycleState.resumed);
    await mount(tester);
    expect(polls, 1);

    setLifecycle(tester, AppLifecycleState.paused);
    await tick(tester, 3);
    expect(polls, 1);

    setLifecycle(tester, AppLifecycleState.resumed);
    await tester.pump();
    expect(polls, 2);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets(
    'keeps polling on desktop while the window is visible but unfocused',
    (tester) async {
      addTearDown(() => setLifecycle(tester, AppLifecycleState.resumed));
      setLifecycle(tester, AppLifecycleState.resumed);
      await mount(tester);
      expect(polls, 1);

      setLifecycle(tester, AppLifecycleState.inactive);
      await tick(tester);
      expect(polls, 2);
      await tick(tester);
      expect(polls, 3);

      setLifecycle(tester, AppLifecycleState.hidden);
      await tick(tester, 3);
      expect(polls, 3);

      await tester.pumpWidget(const SizedBox.shrink());
    },
    variant: TargetPlatformVariant.desktop(),
  );

  testWidgets('starts polling on desktop when mounted in the inactive state', (
    tester,
  ) async {
    addTearDown(() => setLifecycle(tester, AppLifecycleState.resumed));
    setLifecycle(tester, AppLifecycleState.inactive);
    await mount(tester);
    expect(polls, 1);

    await tester.pumpWidget(const SizedBox.shrink());
  }, variant: TargetPlatformVariant.desktop());

  testWidgets('stops polling on mobile while the app is inactive', (
    tester,
  ) async {
    addTearDown(() => setLifecycle(tester, AppLifecycleState.resumed));
    setLifecycle(tester, AppLifecycleState.resumed);
    await mount(tester);
    expect(polls, 1);

    setLifecycle(tester, AppLifecycleState.inactive);
    await tick(tester, 3);
    expect(polls, 1);

    setLifecycle(tester, AppLifecycleState.resumed);
    await tester.pump();
    expect(polls, 2);

    await tester.pumpWidget(const SizedBox.shrink());
  }, variant: TargetPlatformVariant.only(TargetPlatform.android));
}

class _Poller extends StatefulWidget {
  final VoidCallback onPoll;

  const _Poller({required this.onPoll});

  @override
  State<_Poller> createState() => _PollerState();
}

class _PollerState extends State<_Poller>
    with WidgetsBindingObserver, ActivePollingMixin<_Poller> {
  @override
  Duration get pollInterval => const Duration(seconds: 1);

  @override
  Future<void> poll(PollGuard isCurrent) async => widget.onPoll();

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

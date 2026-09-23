import 'package:fl_clash/common/render.dart';
import 'package:fl_clash/common/render_binding.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class _RenderTestBinding extends AutomatedTestWidgetsFlutterBinding
    with RenderSchedulerBinding {
  int begun = 0;
  int drawn = 0;

  @override
  void handleBeginFrame(Duration? rawTimeStamp) {
    begun++;
    super.handleBeginFrame(rawTimeStamp);
  }

  @override
  void handleDrawFrame() {
    drawn++;
    super.handleDrawFrame();
  }
}

void main() {
  final binding = _RenderTestBinding();

  tearDown(binding.resumeRendering);

  testWidgets('pausing drains one pending frame and stops continuous ticks', (
    tester,
  ) async {
    var ticks = 0;
    final ticker = Ticker((_) => ticks++);
    addTearDown(ticker.dispose);
    ticker.start();
    await tester.pump();
    final begun = binding.begun;
    final drawn = binding.drawn;
    final beginCallback = binding.platformDispatcher.onBeginFrame;
    final drawCallback = binding.platformDispatcher.onDrawFrame;
    expect(binding.hasScheduledFrame, isTrue);

    binding.pauseRendering();
    binding.pauseRendering();
    await tester.pump(const Duration(milliseconds: 16));
    expect(binding.begun, begun + 1);
    expect(binding.drawn, drawn + 1);
    expect(binding.hasScheduledFrame, isFalse);
    final stoppedTicks = ticks;
    for (var index = 0; index < 20; index++) {
      binding.scheduleFrame();
      binding.ensureVisualUpdate();
      await tester.pump(const Duration(milliseconds: 16));
    }
    expect(binding.begun, begun + 1);
    expect(binding.drawn, drawn + 1);
    expect(ticks, stoppedTicks);
    expect(binding.platformDispatcher.onBeginFrame, same(beginCallback));
    expect(binding.platformDispatcher.onDrawFrame, same(drawCallback));

    binding.resumeRendering();
    binding.resumeRendering();
    expect(binding.hasScheduledFrame, isTrue);
    await tester.pump(const Duration(milliseconds: 16));
    expect(ticks, stoppedTicks + 1);
    expect(binding.hasScheduledFrame, isTrue);
    ticker.stop();
  });

  testWidgets('pausing inside a frame completes its draw phase', (
    tester,
  ) async {
    binding.scheduleFrameCallback((_) => binding.pauseRendering());
    final begun = binding.begun;
    final drawn = binding.drawn;
    await tester.pump();
    expect(binding.begun, begun + 1);
    expect(binding.drawn, drawn + 1);
    expect(binding.schedulerPhase, SchedulerPhase.idle);
    expect(binding.hasScheduledFrame, isFalse);
    binding.scheduleFrame();
    await tester.pump();
    expect(binding.drawn, drawn + 1);
    binding.resumeRendering();
    await tester.pump();
    expect(binding.drawn, drawn + 2);
  });

  testWidgets('forced and warm-up frames do not restart continuous ticks', (
    tester,
  ) async {
    var ticks = 0;
    final ticker = Ticker((_) => ticks++);
    addTearDown(ticker.dispose);
    ticker.start();
    binding.pauseRendering();
    await tester.pump();
    final drawn = binding.drawn;
    final stoppedTicks = ticks;

    binding.scheduleForcedFrame();
    await tester.pump(const Duration(milliseconds: 16));
    expect(binding.drawn, drawn + 1);
    expect(ticks, stoppedTicks + 1);
    expect(binding.hasScheduledFrame, isFalse);
    for (var index = 0; index < 10; index++) {
      await tester.pump(const Duration(milliseconds: 16));
    }
    expect(binding.drawn, drawn + 1);
    expect(ticks, stoppedTicks + 1);

    var completed = false;
    binding.endOfFrame.then((_) => completed = true);
    binding.scheduleWarmUpFrame();
    expect(completed, isTrue);
    expect(binding.drawn, drawn + 2);
    expect(ticks, stoppedTicks + 2);
    expect(binding.hasScheduledFrame, isFalse);
    await tester.pump(const Duration(seconds: 1));
    expect(binding.drawn, drawn + 2);
    expect(ticks, stoppedTicks + 2);
    ticker.stop();
  });

  testWidgets('a hidden startup warm-up builds and runs startup callbacks', (
    tester,
  ) async {
    binding.pauseRendering();
    var built = 0;
    var started = false;
    binding.addPostFrameCallback((_) => started = true);
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Builder(
          builder: (_) {
            built++;
            return const Text('startup');
          },
        ),
      ),
    );
    expect(built, 0);
    expect(started, isFalse);
    binding.scheduleWarmUpFrame();
    expect(built, 1);
    expect(started, isTrue);
    expect(find.text('startup'), findsOneWidget);
    expect(binding.hasScheduledFrame, isFalse);
    binding.resumeRendering();
    await tester.pump();
    expect(binding.schedulerPhase, SchedulerPhase.idle);
  });

  testWidgets('resume respects the real application lifecycle', (tester) async {
    binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    binding.pauseRendering();
    final lifecycle = binding.lifecycleState;
    binding.resumeRendering();
    expect(binding.lifecycleState, lifecycle);
    expect(binding.framesEnabled, isFalse);
    expect(binding.hasScheduledFrame, isFalse);
    binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    expect(binding.framesEnabled, isTrue);
    expect(binding.hasScheduledFrame, isTrue);
    await tester.pump();
  });

  testWidgets('visible tray actions never create a pause request', (
    tester,
  ) async {
    final render = Render(binding: binding);
    addTearDown(render.resume);
    render.active();
    await tester.pump(const Duration(seconds: 6));
    expect(binding.renderPaused, isFalse);
    binding.scheduleFrame();
    expect(binding.hasScheduledFrame, isTrue);
    await tester.pump();
  });

  testWidgets('hidden tray activity renews its existing pause grace period', (
    tester,
  ) async {
    final render = Render(binding: binding);
    addTearDown(render.resume);
    render.pause();
    await tester.pump(const Duration(seconds: 4));
    render.active();
    await tester.pump(const Duration(seconds: 4));
    expect(binding.renderPaused, isFalse);
    await tester.pump(const Duration(seconds: 1));
    expect(binding.renderPaused, isTrue);
    render.active();
    expect(binding.renderPaused, isFalse);
    await tester.pump(const Duration(seconds: 5));
    expect(binding.renderPaused, isTrue);
    render.resume();
    expect(binding.renderPaused, isFalse);
  });

  testWidgets('show cancels pending pauses and repeated hide remains bounded', (
    tester,
  ) async {
    final render = Render(binding: binding);
    addTearDown(render.resume);
    render.pause();
    await tester.pump(const Duration(seconds: 4));
    render.resume();
    await tester.pump(const Duration(seconds: 2));
    expect(binding.renderPaused, isFalse);
    render.pause();
    await tester.pump(const Duration(seconds: 4));
    render.pause();
    await tester.pump(const Duration(seconds: 1));
    expect(binding.renderPaused, isTrue);
    render.resume();
    render.pause();
    render.resume();
    await tester.pump(const Duration(seconds: 6));
    expect(binding.renderPaused, isFalse);
  });
}

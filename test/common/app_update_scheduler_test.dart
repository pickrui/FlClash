import 'dart:async';

import 'package:fl_clash/common/app_update_scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('checks every 24 hours without repeating the startup check', (
    tester,
  ) async {
    var calls = 0;
    final scheduler = AppUpdateScheduler(
      checkForUpdates: () async => calls++,
      onError: (error, _) => fail('$error'),
    );
    addTearDown(scheduler.stop);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    scheduler.start();
    scheduler.start();
    await tester.pump(const Duration(hours: 23, minutes: 59));
    expect(calls, 0);
    await tester.pump(const Duration(minutes: 1));
    expect(calls, 1);
    await tester.pump(const Duration(hours: 24));
    expect(calls, 2);
    scheduler.stop();
  });

  for (final background in [
    AppLifecycleState.inactive,
    AppLifecycleState.hidden,
    AppLifecycleState.paused,
  ]) {
    testWidgets('checks once when returning from $background', (tester) async {
      var calls = 0;
      final scheduler = AppUpdateScheduler(
        checkForUpdates: () async => calls++,
        onError: (error, _) => fail('$error'),
      );
      addTearDown(scheduler.stop);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      scheduler.start();
      tester.binding.handleAppLifecycleStateChanged(background);
      await tester.pump();
      expect(calls, 0);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pump();
      expect(calls, 1);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pump();
      expect(calls, 1);
      scheduler.stop();
    });
  }

  testWidgets('foreground checks do not postpone the daily check', (
    tester,
  ) async {
    var calls = 0;
    final scheduler = AppUpdateScheduler(
      checkForUpdates: () async => calls++,
      onError: (error, _) => fail('$error'),
    );
    addTearDown(scheduler.stop);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    scheduler.start();
    await tester.pump(const Duration(hours: 23));
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    expect(calls, 1);
    await tester.pump(const Duration(hours: 1));
    expect(calls, 2);
    scheduler.stop();
  });

  testWidgets('keeps daily checks active while the desktop window is hidden', (
    tester,
  ) async {
    var calls = 0;
    final scheduler = AppUpdateScheduler(
      checkForUpdates: () async => calls++,
      onError: (error, _) => fail('$error'),
    );
    addTearDown(scheduler.stop);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    scheduler.start();
    await tester.pump(const Duration(hours: 24));
    expect(calls, 1);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    expect(calls, 2);
    scheduler.stop();
  });

  testWidgets('foreground and daily checks share an in-flight request', (
    tester,
  ) async {
    var calls = 0;
    final pending = Completer<void>();
    final scheduler = AppUpdateScheduler(
      checkForUpdates: () {
        calls++;
        return pending.future;
      },
      onError: (error, _) => fail('$error'),
    );
    addTearDown(scheduler.stop);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    scheduler.start();
    await tester.pump(const Duration(hours: 24));
    expect(calls, 1);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump(const Duration(hours: 24));
    expect(calls, 1);
    pending.complete();
    await tester.pump();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    expect(calls, 2);
    scheduler.stop();
  });

  testWidgets('failed checks do not end foreground or daily checking', (
    tester,
  ) async {
    var calls = 0;
    final errors = <Object>[];
    final scheduler = AppUpdateScheduler(
      checkForUpdates: () async {
        if (++calls == 1) throw StateError('offline');
      },
      onError: (error, _) => errors.add(error),
    );
    addTearDown(scheduler.stop);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    scheduler.start();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    expect(errors.single, isStateError);
    await tester.pump(const Duration(hours: 24));
    expect(calls, 2);
    expect(errors, hasLength(1));
    scheduler.stop();
  });

  testWidgets('stop releases the timer and observer even during a check', (
    tester,
  ) async {
    var calls = 0;
    final pending = Completer<void>();
    final scheduler = AppUpdateScheduler(
      checkForUpdates: () {
        calls++;
        return pending.future;
      },
      onError: (error, _) => fail('$error'),
    );
    addTearDown(scheduler.stop);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    scheduler.start();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    expect(calls, 1);
    scheduler.stop();
    pending.complete();
    await tester.pump(const Duration(hours: 48));
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    expect(calls, 1);
    scheduler.start();
    await tester.pump(const Duration(hours: 24));
    expect(calls, 2);
    scheduler.stop();
  });
}

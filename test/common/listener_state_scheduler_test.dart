import 'dart:async';
import 'package:fl_clash/common/listener_state_scheduler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('queued network resume cannot overtake a newer manual stop', () async {
    final calls = <bool>[];
    final gate = Completer<void>();
    final entered = Completer<void>();
    final scheduler = ListenerStateScheduler((running) async {
      calls.add(running);
      if (calls.length == 1) {
        entered.complete();
        await gate.future;
      }
    });
    final start = scheduler.apply(running: true, suspended: false);
    await entered.future;
    final pause = scheduler.apply(running: true, suspended: true);
    final resume = scheduler.apply(running: true, suspended: false);
    final stop = scheduler.apply(running: false, suspended: false);
    gate.complete();
    await Future.wait([start, pause, resume, stop]);
    expect(calls, [true, false]);
  });

  test(
    'start while excluded keeps listeners closed, but stop remains final',
    () async {
      final calls = <bool>[];
      final scheduler = ListenerStateScheduler(
        (running) async => calls.add(running),
      );
      await scheduler.apply(running: true, suspended: true);
      await scheduler.apply(running: true, suspended: false);
      await scheduler.apply(running: false, suspended: false);
      await scheduler.apply(running: false, suspended: true);
      await scheduler.apply(running: false, suspended: false);
      expect(calls, [false, true, false, false, false]);
    },
  );

  test('failed transition is reported and later stop still executes', () async {
    final calls = <bool>[];
    final scheduler = ListenerStateScheduler((running) async {
      calls.add(running);
      if (running) throw StateError('port unavailable');
    });
    await expectLater(
      scheduler.apply(running: true, suspended: false),
      throwsStateError,
    );
    await scheduler.apply(running: false, suspended: false);
    expect(calls, [true, false]);
  });
}

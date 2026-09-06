import 'dart:async';

import 'package:fl_clash/common/periodic_task_runner.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('stop during an RPC skips remaining tasks and future ticks', (
    tester,
  ) async {
    final pending = Completer<void>();
    final events = <String>[];
    final runner = PeriodicTaskRunner(onError: (error, _) => fail('$error'));
    final run = runner.start([
      () async {
        events.add('rpc');
        await pending.future;
      },
      () => events.add('next'),
    ]);
    runner.stop();
    pending.complete();
    await run;
    await tester.pump(const Duration(seconds: 3));
    expect(events, ['rpc']);
  });

  testWidgets('duplicate starts share a run and replace tasks for next tick', (
    tester,
  ) async {
    final pending = Completer<void>();
    final events = <String>[];
    final runner = PeriodicTaskRunner(onError: (error, _) => fail('$error'));
    final first = runner.start([
      () async {
        events.add('first');
        await pending.future;
      },
    ]);
    final duplicate = runner.start([() => events.add('replacement')]);
    expect(events, ['first']);
    pending.complete();
    await Future.wait([first, duplicate]);
    expect(events, ['first']);
    await tester.pump(const Duration(seconds: 1));
    expect(events, ['first', 'replacement']);
    runner.stop();
  });

  testWidgets('resume waits for a cancelled RPC and runs only latest tasks', (
    tester,
  ) async {
    final pending = Completer<void>();
    final events = <String>[];
    final runner = PeriodicTaskRunner(onError: (error, _) => fail('$error'));
    final old = runner.start([
      () async {
        events.add('old');
        await pending.future;
      },
      () => events.add('stale'),
    ]);
    runner.stop();
    final discarded = runner.start([() => events.add('discarded')]);
    runner.stop();
    final resumed = runner.start([() => events.add('resumed')]);
    expect(events, ['old']);
    pending.complete();
    await Future.wait([old, discarded, resumed]);
    expect(events, ['old', 'resumed']);
    await tester.pump(const Duration(seconds: 1));
    expect(events, ['old', 'resumed', 'resumed']);
    runner.stop();
  });

  testWidgets('a failed task is reported without ending later polling', (
    tester,
  ) async {
    final errors = <Object>[];
    var attempts = 0;
    var laterTasks = 0;
    final runner = PeriodicTaskRunner(onError: (error, _) => errors.add(error));
    await runner.start([
      () {
        if (++attempts == 1) throw StateError('temporary failure');
      },
      () => laterTasks++,
    ]);
    expect(errors.single, isStateError);
    expect(laterTasks, 1);
    await tester.pump(const Duration(seconds: 1));
    expect(attempts, 2);
    expect(laterTasks, 2);
    runner.stop();
  });

  testWidgets('stop cancels a pending timer and start reuses saved tasks', (
    tester,
  ) async {
    var calls = 0;
    final runner = PeriodicTaskRunner(onError: (error, _) => fail('$error'));
    await runner.start([() => calls++]);
    runner.stop();
    await tester.pump(const Duration(seconds: 3));
    expect(calls, 1);
    await runner.start();
    expect(calls, 2);
    await runner.start([]);
    await tester.pump(const Duration(seconds: 3));
    expect(calls, 2);
  });
}

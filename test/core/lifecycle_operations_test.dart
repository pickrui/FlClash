import 'dart:async';

import 'package:fl_clash/core/lifecycle_operations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'nested readiness does not await a check queued behind itself',
    () async {
      final operations = CoreLifecycleOperations();
      final entered = Completer<void>();
      final resume = Completer<void>();
      final events = <String>[];

      final apply = operations.run(() async {
        entered.complete();
        await resume.future;
        final ready = await operations.ensureReady(() async {
          events.add('nested-ready');
          return true;
        });
        events.add('apply-finished');
        return ready;
      });
      await entered.future;
      final external = operations.ensureReady(() async {
        events.add('external-ready');
        return true;
      });
      resume.complete();

      expect(await apply.timeout(const Duration(seconds: 1)), isTrue);
      expect(await external.timeout(const Duration(seconds: 1)), isTrue);
      expect(events, ['nested-ready', 'apply-finished', 'external-ready']);
    },
  );

  test('independent readiness requests share one recovery', () async {
    final operations = CoreLifecycleOperations();
    final recovered = Completer<bool>();
    var calls = 0;
    Future<bool> recover() {
      calls++;
      return recovered.future;
    }

    final first = operations.ensureReady(recover);
    final second = operations.ensureReady(recover);
    expect(second, same(first));
    recovered.complete(true);
    expect(await first, isTrue);
    expect(calls, 1);
  });

  test('a failed recovery releases the queue and can be retried', () async {
    final operations = CoreLifecycleOperations();
    await expectLater(
      operations.ensureReady(() async => throw StateError('disconnected')),
      throwsStateError,
    );
    expect(await operations.run(() async => 42), 42);
    expect(await operations.ensureReady(() async => true), isTrue);
  });

  test('a detached readiness check queues after its parent releases', () async {
    final operations = CoreLifecycleOperations();
    final runDetached = Completer<void>();
    final releaseNext = Completer<void>();
    final nextEntered = Completer<void>();
    final events = <String>[];
    late Future<bool> detached;
    await operations.run(() async {
      detached = () async {
        await runDetached.future;
        return operations.ensureReady(() async {
          events.add('detached-ready');
          return true;
        });
      }();
    });
    final next = operations.run(() async {
      nextEntered.complete();
      await releaseNext.future;
      events.add('next-finished');
    });
    await nextEntered.future;
    runDetached.complete();
    await pumpEventQueue();
    expect(events, isEmpty);
    releaseNext.complete();
    await next;
    expect(await detached, isTrue);
    expect(events, ['next-finished', 'detached-ready']);
  });
}

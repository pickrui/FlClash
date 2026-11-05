import 'dart:async';

import 'package:fl_clash/providers/database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('withRollback', () {
    test('rolls back with snapshot and rethrows async errors', () async {
      final error = StateError('write failed');
      final previous = [1, 2, 3];
      List<int>? rolledBack;

      await expectLater(
        withRollback(
          snapshot: previous,
          action: () async {
            throw error;
          },
          rollback: (value) => rolledBack = value,
        ),
        throwsA(same(error)),
      );

      expect(rolledBack, previous);
    });

    test('does not roll back when action succeeds', () async {
      var rollbackCalled = false;

      await withRollback(
        snapshot: [1, 2, 3],
        action: () async {},
        rollback: (_) => rollbackCalled = true,
      );

      expect(rollbackCalled, false);
    });
  });

  group('DatabaseWriteQueue', () {
    test('runs writes in submission order', () async {
      final queue = DatabaseWriteQueue();
      final firstCompleter = Completer<void>();
      final events = <String>[];

      queue.add(() async {
        events.add('first-start');
        await firstCompleter.future;
        events.add('first-end');
      });
      queue.add(() {
        events.add('second');
      });
      await Future<void>.delayed(Duration.zero);
      expect(events, ['first-start']);

      firstCompleter.complete();
      await queue.wait();
      expect(events, ['first-start', 'first-end', 'second']);
    });

    test('reports an error once without blocking later writes', () async {
      final queue = DatabaseWriteQueue();
      final events = <String>[];
      queue.add(() => throw StateError('write failed'));
      queue.add(() => events.add('after-error'));

      await expectLater(queue.wait(), throwsStateError);
      expect(events, ['after-error']);
      await expectLater(queue.wait(), completes);
    });

    test('wait includes writes added while waiting', () async {
      final queue = DatabaseWriteQueue();
      final firstCompleter = Completer<void>();
      final secondCompleter = Completer<void>();
      final events = <String>[];
      queue.add(() async {
        await firstCompleter.future;
        events.add('first');
      });

      final waiting = queue.wait();
      queue.add(() async {
        await secondCompleter.future;
        events.add('second');
      });
      firstCompleter.complete();
      await Future<void>.delayed(Duration.zero);
      expect(events, ['first']);

      secondCompleter.complete();
      await waiting;
      expect(events, ['first', 'second']);
    });

    test(
      'exclusive operations keep later writes outside the critical section',
      () async {
        final queue = DatabaseWriteQueue();
        final releaseExclusive = Completer<void>();
        final events = <String>[];
        queue.add(() async {
          events.add('exclusive-start');
          await releaseExclusive.future;
          events.add('exclusive-end');
        });
        queue.add(() => events.add('later-write'));
        await Future<void>.delayed(Duration.zero);

        expect(events, ['exclusive-start']);
        releaseExclusive.complete();
        await queue.wait();
        expect(events, ['exclusive-start', 'exclusive-end', 'later-write']);
      },
    );

    test('queueDatabaseWrite invokes rollback callback on failure', () async {
      var rolledBack = false;
      final previousHandler = FlutterError.onError;
      FlutterError.onError = (_) {};
      addTearDown(() => FlutterError.onError = previousHandler);

      queueDatabaseWrite(
        () => throw StateError('write failed'),
        onError: () => rolledBack = true,
      );
      await expectLater(waitForPendingDatabaseWrites(), throwsStateError);

      expect(rolledBack, true);
    });

    test('awaited exclusive errors are not reported again by wait', () async {
      await expectLater(
        runExclusiveDatabaseOperation<void>(
          () => throw StateError('exclusive failed'),
        ),
        throwsStateError,
      );

      await expectLater(waitForPendingDatabaseWrites(), completes);
    });

    test('suspension drains old writes and rejects new writes', () async {
      final release = Completer<void>();
      var oldWriteExecuted = false;
      var newWriteExecuted = false;
      queueDatabaseWrite(() async {
        await release.future;
        oldWriteExecuted = true;
      });
      final suspended = suspendDatabaseWrites();
      await Future<void>.delayed(Duration.zero);
      final previousHandler = FlutterError.onError;
      FlutterError.onError = (_) {};
      addTearDown(() => FlutterError.onError = previousHandler);
      try {
        await expectLater(
          queueDatabaseWrite(() => newWriteExecuted = true),
          throwsStateError,
        );
        release.complete();
        await suspended;
      } finally {
        resumeDatabaseWrites();
      }

      expect(oldWriteExecuted, true);
      expect(newWriteExecuted, false);
    });
  });
}

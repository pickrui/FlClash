import 'dart:async';

import 'package:fl_clash/common/lock.dart';
import 'package:test/test.dart';

void main() {
  test('AsyncStorageLock serializes independent operations', () async {
    final lock = AsyncStorageLock();
    final release = Completer<void>();
    final events = <String>[];

    final first = lock.synchronized(() async {
      events.add('first-start');
      await release.future;
      events.add('first-end');
    });
    final second = lock.synchronized(() async {
      events.add('second');
    });
    await Future<void>.delayed(Duration.zero);
    expect(events, ['first-start']);

    release.complete();
    await Future.wait([first, second]);
    expect(events, ['first-start', 'first-end', 'second']);
  });

  test('AsyncStorageLock allows nested operations in the same zone', () async {
    final lock = AsyncStorageLock();
    final result = await lock.synchronized(() {
      return lock.synchronized(() async => 42);
    });

    expect(result, 42);
  });

  test('detached nested operations queue after the parent releases', () async {
    final lock = AsyncStorageLock();
    final runDetached = Completer<void>();
    final releaseSecond = Completer<void>();
    final events = <String>[];
    late Future<void> detached;

    await lock.synchronized(() async {
      detached = () async {
        await runDetached.future;
        await lock.synchronized(() async {
          events.add('detached');
        });
      }();
    });
    final second = lock.synchronized(() async {
      events.add('second-start');
      await releaseSecond.future;
      events.add('second-end');
    });
    await Future<void>.delayed(Duration.zero);
    runDetached.complete();
    await Future<void>.delayed(Duration.zero);
    expect(events, ['second-start']);

    releaseSecond.complete();
    await Future.wait([second, detached]);
    expect(events, ['second-start', 'second-end', 'detached']);
  });
}

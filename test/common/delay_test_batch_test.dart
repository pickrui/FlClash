import 'dart:async';

import 'package:fl_clash/common/constant.dart';
import 'package:fl_clash/common/delay_test.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final concurrency in [16, 50]) {
    test(
      'partially failed batches probe each target once at $concurrency',
      () async {
        final attempts = <String, int>{};
        final results = <Delay>[];
        await runDelayTestBatch(
          targets: List.generate(100, (i) => (name: '$i', url: 'url')),
          concurrency: concurrency,
          isCurrent: () => true,
          probe: (target) async {
            attempts.update(
              target.name,
              (count) => count + 1,
              ifAbsent: () => 1,
            );
            final failed = int.parse(target.name).isOdd;
            return Delay(
              name: target.name,
              url: target.url,
              value: failed ? -1 : 25,
              failure: failed ? DelayFailure.timeout : null,
            );
          },
          onResult: results.add,
        );
        expect(attempts, hasLength(100));
        expect(attempts.values, everyElement(1));
        expect(results, hasLength(100));
        expect(results.where((delay) => delay.value == -1), hasLength(50));
        expect(results.where((delay) => delay.value == 25), hasLength(50));
      },
    );
  }

  test(
    'a lower configured concurrency avoids saturating a constrained link',
    () async {
      var active = 0;
      var peak = 0;
      final attempts = <String, int>{};
      final results = <Delay>[];
      await runDelayTestBatch(
        targets: List.generate(100, (i) => (name: '$i', url: 'url')),
        concurrency: 16,
        isCurrent: () => true,
        probe: (target) async {
          attempts.update(target.name, (n) => n + 1, ifAbsent: () => 1);
          active++;
          if (active > peak) peak = active;
          final congested = active > 16;
          await Future<void>.delayed(Duration.zero);
          active--;
          return Delay(
            name: target.name,
            url: target.url,
            value: congested ? -1 : 25,
          );
        },
        onResult: results.add,
      );
      expect(peak, 16);
      expect(results, hasLength(100));
      expect(results.map((delay) => delay.value), everyElement(25));
      expect(attempts.values, everyElement(1));
    },
  );

  testWidgets('queued slow nodes each receive a full network budget', (
    tester,
  ) async {
    final results = <Delay>[];
    var finished = false;
    final run = runDelayTestBatch(
      targets: List.generate(48, (i) => (name: '$i', url: 'url')),
      concurrency: 16,
      isCurrent: () => true,
      probe: (target) async {
        const needed = Duration(seconds: 6);
        final reachable = delayTestTimeoutDuration >= needed;
        await Future<void>.delayed(
          reachable ? needed : delayTestTimeoutDuration,
        );
        return Delay(
          name: target.name,
          url: target.url,
          value: reachable ? 6000 : -1,
        );
      },
      onResult: results.add,
    ).then((_) => finished = true);
    for (var wave = 1; wave <= 3; wave++) {
      await tester.pump(const Duration(seconds: 6));
      expect(results, hasLength(wave * 16));
    }
    expect(finished, isTrue);
    expect(results.map((delay) => delay.value), everyElement(6000));
    await run;
  });

  testWidgets(
    '100 unreachable nodes finish once without a second retry queue',
    (tester) async {
      final results = <Delay>[];
      var finished = false;
      var calls = 0;
      final run = runDelayTestBatch(
        targets: List.generate(100, (i) => (name: '$i', url: 'url')),
        concurrency: maxConcurrentDelayTests,
        isCurrent: () => true,
        probe: (target) async {
          calls++;
          await Future<void>.delayed(delayTestTimeoutDuration);
          return Delay(name: target.name, url: target.url, value: -1);
        },
        onResult: results.add,
      ).then((_) => finished = true);
      expect(delayTestTimeoutDuration, const Duration(seconds: 8));
      final waves = (100 / maxConcurrentDelayTests).ceil();
      for (var wave = 1; wave <= waves; wave++) {
        await tester.pump(const Duration(seconds: 8));
        expect(
          results,
          hasLength((wave * maxConcurrentDelayTests).clamp(0, 100)),
        );
        expect(finished, wave == waves);
      }
      expect(calls, 100);
      expect(results, hasLength(100));
      expect(results.map((delay) => delay.value), everyElement(-1));
      await run;
    },
  );

  test('completed results appear while a slow peer stays pending', () async {
    final slow = Completer<Delay>();
    final results = <Delay>[];
    final run = runDelayTestBatch(
      targets: [
        (name: 'fast', url: 'url'),
        (name: 'failed', url: 'url'),
        (name: 'interrupted', url: 'url'),
        (name: 'slow', url: 'url'),
      ],
      concurrency: 4,
      isCurrent: () => true,
      probe: (target) async => target.name == 'slow'
          ? slow.future
          : Delay(
              name: target.name,
              url: target.url,
              value: switch (target.name) {
                'fast' => 20,
                'failed' => -1,
                _ => null,
              },
            ),
      onResult: results.add,
    );
    await pumpEventQueue();
    expect(results.map((delay) => delay.name), [
      'fast',
      'failed',
      'interrupted',
    ]);
    expect(results.map((delay) => delay.value), [20, -1, null]);
    slow.complete(const Delay(name: 'slow', url: 'url', value: 30));
    await run;
    expect(results.last.value, 30);
  });

  test(
    'a missing Core response stops queued work and preserves completed probes',
    () async {
      final first = Completer<Delay>();
      final second = Completer<Delay>();
      final results = <String, int?>{};
      final calls = <String>[];
      final run = runDelayTestBatch(
        targets: List.generate(5, (i) => (name: '$i', url: 'url')),
        concurrency: 2,
        isCurrent: () => true,
        probe: (target) {
          calls.add(target.name);
          return target.name == '0' ? first.future : second.future;
        },
        onResult: (delay) => results[delay.name] = delay.value,
      );
      first.complete(const Delay(name: '0', url: 'url', value: null));
      await pumpEventQueue();
      expect(calls, ['0', '1']);
      expect(results, {'0': null, '2': null, '3': null, '4': null});
      second.complete(const Delay(name: '1', url: 'url', value: 25));
      await run;
      expect(results, {'0': null, '1': 25, '2': null, '3': null, '4': null});
    },
  );

  test(
    'a Core exception clears all pending results and stops queued work',
    () async {
      final results = <String, int?>{};
      var calls = 0;
      await runDelayTestBatch(
        targets: List.generate(100, (i) => (name: '$i', url: 'url')),
        concurrency: 2,
        isCurrent: () => true,
        probe: (_) async {
          calls++;
          throw StateError('Core disconnected');
        },
        onResult: (delay) => results[delay.name] = delay.value,
      );
      expect(calls, 2);
      expect(results.length, 100);
      expect(results.values, everyElement(isNull));
    },
  );

  test('a new generation discards late results and queued probes', () async {
    var current = true;
    var calls = 0;
    final pending = Completer<Delay>();
    final results = <Delay>[];
    final run = runDelayTestBatch(
      targets: [(name: 'one', url: 'url'), (name: 'two', url: 'url')],
      concurrency: 1,
      isCurrent: () => current,
      probe: (_) {
        calls++;
        return pending.future;
      },
      onResult: results.add,
    );
    current = false;
    pending.complete(const Delay(name: 'one', url: 'url', value: -1));
    await run;
    expect(calls, 1);
    expect(results, isEmpty);
  });
}

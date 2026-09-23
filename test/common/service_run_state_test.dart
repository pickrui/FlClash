import 'dart:async';

import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer container;
  setUp(() {
    container = ProviderContainer();
    container.listen(runTimeProvider, (_, _) {});
    globalState.container = container;
    globalState.clearRunState();
    globalState.setUpdateVisibility(
      appVisible: true,
      windowVisible: true,
      trayTraffic: false,
    );
  });
  tearDown(() {
    globalState.clearRunState();
    container.dispose();
  });

  void testRunStateWidgets(
    String description,
    Future<void> Function(WidgetTester) body,
  ) {
    testWidgets(description, (tester) async {
      try {
        await body(tester);
      } finally {
        globalState.clearRunState();
      }
    });
  }

  testRunStateWidgets(
    'external stop clears the running UI and cancels sampling',
    (tester) async {
      globalState.startTime = DateTime.now();
      var samples = 0;
      await globalState.startUpdateTasks([() => samples++]);
      Future<DateTime?> stopped() async => null;

      expect(await globalState.syncServiceRunState(query: stopped), isTrue);
      expect(await globalState.syncServiceRunState(query: stopped), isFalse);
      expect(globalState.startTime, isNull);
      expect(container.read(runTimeProvider), isNull);
      await tester.pump(const Duration(seconds: 5));
      expect(samples, 1);
    },
  );

  testRunStateWidgets(
    'resume recovers a running native session after a lost event',
    (tester) async {
      final started = DateTime.now().subtract(const Duration(minutes: 1));
      var samples = 0;
      final tasks = [() => samples++];
      Future<DateTime?> running() async => started;
      expect(
        await globalState.syncServiceRunState(query: running, tasks: tasks),
        isTrue,
      );
      expect(globalState.startTime, started);
      expect(container.read(runTimeProvider), greaterThanOrEqualTo(60000));
      expect(
        await globalState.syncServiceRunState(query: running, tasks: tasks),
        isFalse,
      );
      expect(samples, 1);
      await tester.pump(const Duration(seconds: 1));
      expect(samples, 2);
    },
  );

  test('an in-flight running query cannot undo a newer local stop', () async {
    globalState.startTime = DateTime.now();
    final response = Completer<DateTime?>();
    final sync = globalState.syncServiceRunState(query: () => response.future);
    globalState.clearRunState();
    response.complete(DateTime.now());
    expect(await sync, isFalse);
    expect(globalState.startTime, isNull);
    expect(container.read(runTimeProvider), isNull);
  });

  test(
    'an old stopped query cannot clear a replacement after stop and restart',
    () async {
      globalState.startTime = DateTime.now();
      final response = Completer<DateTime?>();
      final sync = globalState.syncServiceRunState(
        query: () => response.future,
      );
      globalState.clearRunState();
      final replacement = DateTime.now().add(const Duration(seconds: 1));
      globalState.startTime = replacement;
      response.complete(null);
      expect(await sync, isFalse);
      expect(globalState.startTime, replacement);
    },
  );

  testRunStateWidgets(
    'query failure preserves the current session and sampling',
    (tester) async {
      final started = DateTime.now();
      globalState.startTime = started;
      var samples = 0;
      await globalState.startUpdateTasks([() => samples++]);
      await expectLater(
        globalState.syncServiceRunState(
          query: () async => throw StateError('service unavailable'),
        ),
        throwsStateError,
      );
      expect(globalState.startTime, started);
      expect(container.read(runTimeProvider), isNotNull);
      await tester.pump(const Duration(seconds: 1));
      expect(samples, 2);
    },
  );
}

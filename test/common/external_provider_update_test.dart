import 'dart:async';

import 'package:fl_clash/providers/action.dart';
import 'package:fl_clash/models/core.dart';
import 'package:test/test.dart';

void main() {
  final provider = ExternalProvider(
    name: 'example',
    type: 'Proxy',
    count: 2,
    vehicleType: 'HTTP',
    updateAt: DateTime(2026),
  );
  late bool current;
  late int reads;
  late List<ExternalProvider> published;

  setUp(() {
    current = true;
    reads = 0;
    published = [];
  });

  Future<String> run(Future<String> Function() update) =>
      refreshExternalProvider(
        isCurrent: () => current,
        update: update,
        read: () async {
          reads++;
          return provider;
        },
        publish: published.add,
      );

  test(
    'successful update reads and publishes the refreshed provider',
    () async {
      expect(await run(() async => ''), '');
      expect(reads, 1);
      expect(published, [provider]);
    },
  );

  test(
    'failed update preserves the last provider and returns its error',
    () async {
      expect(await run(() async => 'invalid rules'), 'invalid rules');
      expect(reads, 0);
      expect(published, isEmpty);
    },
  );

  test('transport exceptions reach the caller without publishing', () async {
    await expectLater(
      run(() async => throw StateError('disconnected')),
      throwsStateError,
    );
    expect(reads, 0);
    expect(published, isEmpty);
  });

  test('an obsolete operation does not start', () async {
    current = false;
    expect(await run(() async => fail('obsolete update started')), '');
    expect(reads, 0);
  });

  test('switching profiles during an update prevents readback', () async {
    final response = Completer<String>();
    final operation = run(() => response.future);
    current = false;
    response.complete('');
    expect(await operation, '');
    expect(reads, 0);
    expect(published, isEmpty);
  });

  test(
    'obsolete update errors do not become errors for the new profile',
    () async {
      final response = Completer<String>();
      final operation = run(() => response.future);
      current = false;
      response.complete('old provider no longer exists');
      expect(await operation, '');
      expect(reads, 0);
    },
  );

  test(
    'switching profiles during readback discards the old snapshot',
    () async {
      final response = Completer<ExternalProvider?>();
      final reading = Completer<void>();
      final operation = refreshExternalProvider(
        isCurrent: () => current,
        update: () async => '',
        read: () {
          reading.complete();
          return response.future;
        },
        publish: published.add,
      );
      await reading.future;
      current = false;
      response.complete(provider);
      expect(await operation, '');
      expect(published, isEmpty);
    },
  );

  test(
    'stale transport failures are ignored after switching profiles',
    () async {
      final response = Completer<String>();
      final operation = run(() => response.future);
      current = false;
      response.completeError(StateError('old core disconnected'));
      expect(await operation, '');
      expect(published, isEmpty);
    },
  );

  test('a removed provider is not published', () async {
    await refreshExternalProvider(
      isCurrent: () => true,
      update: () async => '',
      read: () async => null,
      publish: published.add,
    );
    expect(published, isEmpty);
  });
}

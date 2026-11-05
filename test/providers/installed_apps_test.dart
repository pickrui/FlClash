import 'dart:async';

import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/installed_apps.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/installed_apps_fake.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late InstalledAppsFake api;
  late ProviderContainer container;
  var listening = false;

  Future<InstalledAppsResult> load() {
    if (!listening) {
      listening = true;
      container.listen(installedAppsProvider, (_, _) {});
    }
    return container.read(installedAppsProvider.future);
  }

  setUp(() {
    api = InstalledAppsFake();
    container = ProviderContainer(
      overrides: [installedAppsAppProvider.overrideWithValue(api)],
    );
    listening = false;
  });
  tearDown(() async {
    container.dispose();
    await api.changes.close();
  });

  test(
    'denied permission never mistakes a partial nonempty list for access',
    () async {
      api.granted = false;
      api.packages = [installedPackage('partial.app')];
      final result = await load();
      expect(result.permissionGranted, isFalse);
      expect(result.packages, isEmpty);
      expect(api.queries, 0);
    },
  );

  test('permission revoked during the query discards returned apps', () async {
    var checks = 0;
    api.check = () async => checks++ == 0;
    api.packages = [installedPackage('was.visible')];
    final result = await load();
    expect(result.permissionGranted, isFalse);
    expect(result.packages, isEmpty);
  });

  test('package events reload even after the old list was empty', () async {
    expect((await load()).packages, isEmpty);
    api.packages = [installedPackage('new.app')];
    api.changes.add(null);
    expect(
      (await container.read(
        installedAppsProvider.future,
      )).packages.single.packageName,
      'new.app',
    );
    api.packages = [];
    api.changes.add(null);
    expect((await load()).packages, isEmpty);
    expect(api.queries, 3);
  });

  test(
    'late pre-uninstall response cannot replace the current result',
    () async {
      final old = Completer<List<Package>>();
      final started = Completer<void>();
      api.load = () {
        started.complete();
        return old.future;
      };
      final first = load();
      await started.future;
      api.load = null;
      api.packages = [installedPackage('current.app')];
      api.changes.add(null);
      final latest = await load();
      expect(latest.packages.single.packageName, 'current.app');
      old.complete([installedPackage('removed.app')]);
      await first;
      await Future<void>.delayed(Duration.zero);
      expect(
        container
            .read(installedAppsProvider)
            .value
            ?.packages
            .single
            .packageName,
        'current.app',
      );
    },
  );

  test('query failure remains an error and can be retried', () async {
    api.fail = true;
    await expectLater(load(), throwsStateError);
    api.fail = false;
    api.packages = [installedPackage('available')];
    container.invalidate(installedAppsProvider);
    expect(
      (await container.read(
        installedAppsProvider.future,
      )).packages.single.packageName,
      'available',
    );
  });
}

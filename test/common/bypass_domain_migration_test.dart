import 'dart:convert';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _narrowed172 = [
  '172.20.*',
  '172.21.*',
  '172.22.*',
  '172.23.*',
  '172.24.*',
  '172.25.*',
  '172.26.*',
  '172.27.*',
  '172.28.*',
  '172.29.*',
];

Map<String, Object?> _storedConfig(List<String> bypassDomain) {
  final config = Config(
    themeProps: defaultThemeProps,
    networkProps: NetworkProps(bypassDomain: bypassDomain),
  );
  return (jsonDecode(jsonEncode(config)) as Map).cast<String, Object?>();
}

final _savedAtVersion = <int, List<String>>{};

Future<List<String>> _load(
  Map<String, Object?> configMap, {
  Future<void> Function(Config config)? persist,
}) async {
  final config = await migration.migrationIfNeeded(
    configMap,
    sync: (_) => throw StateError('current configs must not be resynced'),
    persist:
        persist ??
        (config) async => _savedAtVersion[await preferences.getVersion()] =
            config.networkProps.bypassDomain,
  );
  return config.networkProps.bypassDomain;
}

void main() {
  setUpAll(() => SharedPreferences.setMockInitialValues({}));
  setUp(_savedAtVersion.clear);

  test('v1 config expands 172.2* in place and keeps user entries', () async {
    await preferences.setVersion(1);

    final bypass = await _load(
      _storedConfig(['corp.example', '172.19.*', '172.2*', '192.168.*']),
    );

    expect(bypass, ['corp.example', '172.19.*', ..._narrowed172, '192.168.*']);
    expect(_savedAtVersion, {1: bypass});
    expect(await preferences.getVersion(), migration.currentVersion);
    expect(migration.currentVersion, 2);
  });

  test('v1 config without 172.2* is left unchanged', () async {
    await preferences.setVersion(1);
    const custom = ['*.lan', '10.*', '172.200.*'];

    expect(await _load(_storedConfig(custom)), custom);
    expect(_savedAtVersion, isEmpty);
    expect(await preferences.getVersion(), migration.currentVersion);
  });

  test('migrated config keeps a 172.2* entry the user adds back', () async {
    await preferences.setVersion(1);
    final migrated = await _load(_storedConfig(['172.2*']));
    expect(migrated, _narrowed172);
    _savedAtVersion.clear();

    final bypass = await _load(_storedConfig([...migrated, '172.2*']));

    expect(bypass, [..._narrowed172, '172.2*']);
    expect(_savedAtVersion, isEmpty);
    expect(await preferences.getVersion(), migration.currentVersion);
  });

  for (final version in [0, 1]) {
    test(
      'v$version keeps its version when saving the narrowed list fails',
      () async {
        await preferences.setVersion(version);
        final stored = _storedConfig(['172.2*', 'localhost']);

        await expectLater(
          _load(stored, persist: (_) => throw StateError('disk full')),
          throwsStateError,
        );
        expect(await preferences.getVersion(), version);

        expect(await _load(stored), [..._narrowed172, 'localhost']);
        expect(_savedAtVersion, {
          version: [..._narrowed172, 'localhost'],
        });
        expect(await preferences.getVersion(), migration.currentVersion);
      },
    );
  }

  test('config without a stored version is narrowed as well', () async {
    await preferences.setVersion(0);

    expect(await _load(_storedConfig(['172.2*', 'localhost'])), [
      ..._narrowed172,
      'localhost',
    ]);
    expect(_savedAtVersion, {
      0: [..._narrowed172, 'localhost'],
    });
    expect(await preferences.getVersion(), migration.currentVersion);
  });

  test('expansion skips ranges the user already lists', () {
    final narrowed = narrowLegacy172Bypass({
      'networkProps': {
        'bypassDomain': ['172.2*', '172.25.*', '172.2*'],
      },
    });

    expect((narrowed?['networkProps'] as Map)['bypassDomain'], [
      ..._narrowed172.where((entry) => entry != '172.25.*'),
      '172.25.*',
    ]);
  });

  test('configs without a bypass list pass through untouched', () {
    final config = <String, Object?>{'appSettingProps': <String, Object?>{}};

    expect(narrowLegacy172Bypass(null), isNull);
    expect(identical(narrowLegacy172Bypass(config), config), isTrue);
  });
}

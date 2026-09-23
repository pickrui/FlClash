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

Future<List<String>> _load(Map<String, Object?> configMap) async {
  final config = await migration.migrationIfNeeded(
    configMap,
    sync: (_) => throw StateError('current configs must not be resynced'),
  );
  return config.networkProps.bypassDomain;
}

void main() {
  setUpAll(() => SharedPreferences.setMockInitialValues({}));

  test('v1 config expands 172.2* in place and keeps user entries', () async {
    await preferences.setVersion(1);

    final bypass = await _load(
      _storedConfig(['corp.example', '172.19.*', '172.2*', '192.168.*']),
    );

    expect(bypass, ['corp.example', '172.19.*', ..._narrowed172, '192.168.*']);
    expect(await preferences.getVersion(), migration.currentVersion);
    expect(migration.currentVersion, 2);
  });

  test('v1 config without 172.2* is left unchanged', () async {
    await preferences.setVersion(1);
    const custom = ['*.lan', '10.*', '172.200.*'];

    expect(await _load(_storedConfig(custom)), custom);
    expect(await preferences.getVersion(), migration.currentVersion);
  });

  test('migrated config keeps a 172.2* entry the user adds back', () async {
    await preferences.setVersion(1);
    final migrated = await _load(_storedConfig(['172.2*']));
    expect(migrated, _narrowed172);

    final bypass = await _load(_storedConfig([...migrated, '172.2*']));

    expect(bypass, [..._narrowed172, '172.2*']);
    expect(await preferences.getVersion(), migration.currentVersion);
  });

  test('config without a stored version is narrowed as well', () async {
    await preferences.setVersion(0);

    expect(await _load(_storedConfig(['172.2*', 'localhost'])), [
      ..._narrowed172,
      'localhost',
    ]);
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

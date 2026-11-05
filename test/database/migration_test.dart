import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fl_clash/database/database.dart';
import 'package:fl_clash/common/migration.dart';
import 'package:test/test.dart';

void main() {
  test('current config shape is recognized before legacy retry', () {
    expect(
      isCurrentConfigShape({
        'appSettingProps': <String, Object?>{},
        'patchClashConfig': <String, Object?>{},
      }),
      true,
    );
    expect(
      isCurrentConfigShape({
        'profiles': <Object?>[],
        'appSetting': <String, Object?>{},
      }),
      false,
    );
  });

  test('schema v2 profiles migrate to custom overwrite columns', () async {
    final tempDir = await Directory.systemTemp.createTemp('flclash_migration_');
    addTearDown(() => tempDir.delete(recursive: true));
    final file = File('${tempDir.path}/database.sqlite');
    await _createV2Database(file);

    final database = Database(NativeDatabase(file));
    addTearDown(database.close);
    final profile = await database.profilesDao.all().getSingle();

    expect(database.schemaVersion, 3);
    expect(profile.label, 'Legacy');
    expect(profile.customProxyGroups, isEmpty);
    expect(profile.customRules, isEmpty);
    expect(await database.select(database.profileRuleLinks).get(), isEmpty);
  });

  for (final existingColumns in [
    {'custom_proxy_groups'},
    {'custom_proxy_groups', 'custom_rules'},
  ]) {
    test(
      'schema v2 migration resumes with ${existingColumns.length} custom columns',
      () async {
        final tempDir = await Directory.systemTemp.createTemp(
          'flclash_partial_migration_',
        );
        addTearDown(() => tempDir.delete(recursive: true));
        final file = File('${tempDir.path}/database.sqlite');
        await _createV2Database(file, existingColumns: existingColumns);

        final database = Database(NativeDatabase(file));
        addTearDown(database.close);
        final profile = await database.profilesDao.all().getSingle();
        final columns = await database
            .customSelect('PRAGMA table_info("profiles")')
            .get();
        final userVersion = await database
            .customSelect('PRAGMA user_version')
            .getSingle();

        expect(profile.label, 'Legacy');
        expect(profile.customProxyGroups.single.name, 'Recovered');
        if (existingColumns.contains('custom_rules')) {
          expect(profile.customRules.single.value, 'MATCH,DIRECT');
        }
        expect(
          columns.map((row) => row.read<String>('name')),
          containsAll(['custom_proxy_groups', 'custom_rules']),
        );
        expect(userVersion.read<int>('user_version'), 3);
      },
    );
  }
}

Future<void> _createV2Database(
  File file, {
  Set<String> existingColumns = const {},
}) async {
  final customColumns = [
    if (existingColumns.contains('custom_proxy_groups'))
      "custom_proxy_groups TEXT NOT NULL DEFAULT '[]',",
    if (existingColumns.contains('custom_rules'))
      "custom_rules TEXT NOT NULL DEFAULT '[]',",
  ].join('\n');
  final oldExecutor = NativeDatabase(file);
  await oldExecutor.ensureOpen(_V2ExecutorUser());
  await oldExecutor.runCustom('''
    CREATE TABLE profiles (
      id INTEGER NOT NULL PRIMARY KEY,
      label TEXT NOT NULL,
      current_group_name TEXT NULL,
      url TEXT NOT NULL,
      last_update_date INTEGER NULL,
      overwrite_type TEXT NOT NULL,
      script_id INTEGER NULL,
      auto_update_duration_millis INTEGER NOT NULL,
      subscription_info TEXT NULL,
      auto_update INTEGER NOT NULL CHECK (auto_update IN (0, 1)),
      selected_map TEXT NOT NULL,
      unfold_set TEXT NOT NULL,
      proxy_chains TEXT NOT NULL DEFAULT '[]',
      profile_proxies TEXT NOT NULL DEFAULT '[]',
      $customColumns
      "order" INTEGER NULL
    )
  ''');
  await oldExecutor.runCustom('''
    INSERT INTO profiles (
      id, label, url, overwrite_type, auto_update_duration_millis,
      auto_update, selected_map, unfold_set
    ) VALUES (1, 'Legacy', '', 'standard', 3600000, 1, '{}', '[]')
  ''');
  if (existingColumns.contains('custom_proxy_groups')) {
    await oldExecutor.runCustom('UPDATE profiles SET custom_proxy_groups = ?', [
      '[{"name":"Recovered","type":"select","proxies":["DIRECT"]}]',
    ]);
  }
  if (existingColumns.contains('custom_rules')) {
    await oldExecutor.runCustom('UPDATE profiles SET custom_rules = ?', [
      '[{"id":1,"value":"MATCH,DIRECT","order":"a0"}]',
    ]);
  }
  await oldExecutor.runCustom('''
    CREATE TABLE rules (
      id INTEGER NOT NULL PRIMARY KEY,
      value TEXT NOT NULL
    )
  ''');
  await oldExecutor.runCustom('''
    CREATE TABLE scripts (
      id INTEGER NOT NULL PRIMARY KEY,
      label TEXT NOT NULL,
      last_update_time INTEGER NOT NULL
    )
  ''');
  await oldExecutor.runCustom('''
    CREATE TABLE profile_rule_mapping (
      id TEXT NOT NULL PRIMARY KEY,
      profile_id INTEGER NULL,
      rule_id INTEGER NOT NULL,
      scene TEXT NULL,
      "order" TEXT NULL
    )
  ''');
  await oldExecutor.runCustom('''
    INSERT INTO profile_rule_mapping (id, profile_id, rule_id)
    VALUES ('orphan', 99, 99)
  ''');
  await oldExecutor.close();
}

class _V2ExecutorUser extends QueryExecutorUser {
  @override
  int get schemaVersion => 2;

  @override
  Future<void> beforeOpen(
    QueryExecutor executor,
    OpeningDetails details,
  ) async {}
}

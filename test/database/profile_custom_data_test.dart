import 'dart:io';

import 'package:drift/native.dart';
import 'package:fl_clash/database/database.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:test/test.dart';

void main() {
  test('Profile custom overwrite data survives database round-trip', () async {
    final database = Database(NativeDatabase.memory());
    addTearDown(database.close);
    const profile = Profile(
      id: 1,
      label: 'Custom',
      autoUpdateDuration: Duration(hours: 1),
      customProxyGroups: [
        ProxyGroup(name: 'Auto', type: GroupType.URLTest, proxies: ['Proxy A']),
      ],
      customRules: [Rule(id: 2, value: 'MATCH,Auto')],
    );

    await database.profiles.put(profile.toCompanion());
    final restored = await database.profilesDao.all().getSingle();

    expect(restored.customProxyGroups, profile.customProxyGroups);
    expect(restored.customRules, profile.customRules);
  });

  test('Profile JSON defaults custom overwrite data to empty lists', () {
    final profile = Profile.fromJson({
      'id': 1,
      'autoUpdateDuration': const Duration(hours: 1).inMicroseconds,
    });

    expect(profile.customProxyGroups, isEmpty);
    expect(profile.customRules, isEmpty);
  });

  test('database snapshot includes latest custom overwrite data', () async {
    final tempDir = await Directory.systemTemp.createTemp('flclash_snapshot_');
    addTearDown(() => tempDir.delete(recursive: true));
    final source = Database(
      NativeDatabase(File('${tempDir.path}/source.sqlite')),
    );
    addTearDown(source.close);
    const profile = Profile(
      id: 1,
      label: 'Snapshot',
      autoUpdateDuration: Duration(hours: 1),
      customRules: [Rule(id: 1, value: 'MATCH,DIRECT')],
    );
    await source.profiles.put(profile.toCompanion());

    final snapshotPath = '${tempDir.path}/snapshot.sqlite';
    await source.createSnapshot(snapshotPath);
    final snapshot = Database(NativeDatabase(File(snapshotPath)));
    addTearDown(snapshot.close);

    final restored = await snapshot.profilesDao.all().getSingle();
    expect(restored.customRules, profile.customRules);
  });

  test('empty override restore clears existing data', () async {
    final database = Database(NativeDatabase.memory());
    addTearDown(database.close);
    const profile = Profile(
      id: 1,
      label: 'Existing',
      autoUpdateDuration: Duration(hours: 1),
    );
    const rule = Rule(id: 1, value: 'MATCH,DIRECT');
    await database.profiles.put(profile.toCompanion());
    await database.rulesDao.putGlobalRule(rule);

    await database.restore([], [], [], [], isOverride: true);

    expect(await database.profilesDao.all().get(), isEmpty);
    expect(await database.select(database.rules).get(), isEmpty);
    expect(await database.select(database.profileRuleLinks).get(), isEmpty);
  });

  test('empty compatible restore preserves existing data', () async {
    final database = Database(NativeDatabase.memory());
    addTearDown(database.close);
    const profile = Profile(
      id: 1,
      label: 'Existing',
      autoUpdateDuration: Duration(hours: 1),
    );
    const rule = Rule(id: 1, value: 'MATCH,DIRECT');
    await database.profiles.put(profile.toCompanion());
    await database.rulesDao.putGlobalRule(rule);

    await database.restore([], [], [], [], isOverride: false);

    expect(await database.profilesDao.all().get(), [profile]);
    expect(await database.select(database.rules).get(), hasLength(1));
    expect(
      await database.select(database.profileRuleLinks).get(),
      hasLength(1),
    );
  });

  test('deleting a script clears every profile reference atomically', () async {
    final database = Database(NativeDatabase.memory());
    addTearDown(database.close);
    final script = Script(
      id: 9,
      label: 'Shared',
      lastUpdateTime: DateTime(2026),
    );
    const profiles = [
      Profile(id: 1, autoUpdateDuration: Duration(hours: 1), scriptId: 9),
      Profile(id: 2, autoUpdateDuration: Duration(hours: 1), scriptId: 9),
      Profile(id: 3, autoUpdateDuration: Duration(hours: 1)),
    ];
    await database.profilesDao.putAll(
      profiles.map((profile) => profile.toCompanion()),
    );
    await database.scripts.put(script.toCompanion());

    final affected = await database.deleteScriptAndClearReferences(script.id);
    final restored = await database.profilesDao.all().get();

    expect(affected.toSet(), {1, 2});
    expect(
      restored
          .where((profile) => profile.id != 3)
          .every((profile) => profile.scriptId == null),
      true,
    );
    expect(await database.scriptsDao.all().get(), isEmpty);
  });
}

import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:fl_clash/database/database.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:test/test.dart';

const sample = Profile(
  id: 1,
  label: 'oixCloud',
  autoUpdateDuration: Duration(hours: 1),
  matchTarget: 'Personal',
  customProxyGroups: [
    ProxyGroup(
      name: 'Personal',
      type: GroupType.LoadBalance,
      proxies: ['A"B', 'C\\D'],
      tolerance: 50,
      strategy: 'consistent-hashing',
      expectedStatus: [200, 204],
      disableUdp: true,
    ),
  ],
  customRules: [
    Rule(id: 2, value: 'AND,((DOMAIN,example.com),(NETWORK,TCP)),Personal'),
  ],
);

void main() {
  test(
    'v3 migration preserves snapshots, rule IDs and all custom group fields',
    () async {
      final temp = Directory.systemTemp.createTempSync('flclash-v3-');
      addTearDown(() => temp.deleteSync(recursive: true));
      final file = File('${temp.path}/database.sqlite');
      final old = Database(NativeDatabase(file));
      await old.profiles.put(sample.toCompanion());
      // Simulate the old local schema with data written only to its snapshot.
      await old.customStatement('DROP TABLE proxy_groups');
      await old.customStatement('DROP TABLE icon_records');
      await old.customStatement('PRAGMA user_version = 3');
      await old.close();
      final db = Database(NativeDatabase(file));
      addTearDown(db.close);
      final profile = await db.profilesDao.all().getSingle();
      expect(profile, sample);
      final group = await db.proxyGroupsDao.query(1).getSingle();
      expect(jsonEncode(group), jsonEncode(sample.customProxyGroups.single));
      expect(group.id, isNotNull);
      expect(group.order, isNotNull);
      final rules = await db.rulesDao.queryProfileCustomRules(1).get();
      expect(rules.single.value, sample.customRules.single.value);
      expect(rules.single.id, 2);
      expect(
        (await db.customSelect('PRAGMA foreign_key_check').get()),
        isEmpty,
      );
    },
  );

  test(
    'profile, normalized groups and custom rules roll back together',
    () async {
      final db = Database(NativeDatabase.memory());
      addTearDown(db.close);
      await db.putProfile(sample);
      final groups = await db.proxyGroupsDao.query(1).get();
      await db.customStatement(
        "CREATE TRIGGER fail_group BEFORE INSERT ON proxy_groups BEGIN SELECT RAISE(ABORT, 'fixture'); END",
      );
      await expectLater(
        db.putProfile(
          sample.copyWith(
            label: 'Uncommitted',
            customProxyGroups: [
              sample.customProxyGroups.single.copyWith(name: 'Changed'),
            ],
          ),
        ),
        throwsA(isA<Exception>()),
      );
      expect(await db.profilesDao.all().getSingle(), sample);
      expect(await db.proxyGroupsDao.query(1).get(), groups);
      expect(
        (await db.rulesDao.queryProfileCustomRules(1).getSingle()).value,
        sample.customRules.single.value,
      );
    },
  );

  test(
    'same portable rule ID never overwrites another profile or global rule',
    () async {
      final db = Database(NativeDatabase.memory());
      addTearDown(db.close);
      await db.rulesDao.putGlobalRule(const Rule(id: 2, value: 'MATCH,DIRECT'));
      await db.putProfile(sample);
      await db.putProfile(
        sample.copyWith(
          id: 3,
          customRules: const [Rule(id: 2, value: 'MATCH,REJECT')],
        ),
      );
      expect(
        (await db.rulesDao.allGlobalAddedRules().getSingle()).value,
        'MATCH,DIRECT',
      );
      expect(
        (await db.rulesDao.queryProfileCustomRules(1).getSingle()).value,
        sample.customRules.single.value,
      );
      expect(
        (await db.rulesDao.queryProfileCustomRules(3).getSingle()).value,
        'MATCH,REJECT',
      );
      await db.rulesDao.setCustomRules(1, []);
      expect(await db.rulesDao.queryProfileCustomRules(1).get(), isEmpty);
      expect(
        (await db.rulesDao.allGlobalAddedRules().getSingle()).value,
        'MATCH,DIRECT',
      );
      expect(
        (await db.rulesDao.queryProfileCustomRules(3).getSingle()).value,
        'MATCH,REJECT',
      );
    },
  );

  test(
    'normalized edits keep portable snapshots current and profile deletion cascades',
    () async {
      final db = Database(NativeDatabase.memory());
      addTearDown(db.close);
      await db.putProfile(sample);
      final group = await db.proxyGroupsDao.query(1).getSingle();
      await db.proxyGroupsDao.setAll(1, [group.copyWith(name: 'Renamed')]);
      expect(
        (await db.profilesDao.all().getSingle()).customProxyGroups.single.name,
        'Renamed',
      );
      expect((await db.proxyGroupsDao.query(1).getSingle()).id, group.id);
      await db.profiles.remove((row) => row.id.equals(1));
      expect(await db.proxyGroupsDao.query(1).get(), isEmpty);
      expect(await db.rulesDao.queryProfileCustomRules(1).get(), isEmpty);
    },
  );

  test(
    'icon history evicts oldest entries while retaining recently used URLs',
    () async {
      final db = Database(NativeDatabase.memory());
      addTearDown(db.close);
      await db.batch((batch) {
        batch.insertAll(
          db.iconRecords,
          List.generate(
            1000,
            (i) => IconRecordsCompanion.insert(
              url: 'https://example.test/$i.svg',
              lastAccessed: i,
            ),
          ),
        );
      });
      await db.iconRecordsDao.get('https://example.test/0.svg');
      await db.iconRecordsDao.put('https://example.test/new.svg');
      expect(
        await db.iconRecordsDao.get('https://example.test/0.svg'),
        isNotNull,
      );
      expect(await db.iconRecordsDao.get('https://example.test/1.svg'), isNull);
      expect((await db.iconRecordsDao.query('example.test')).length, 1000);
    },
  );
}

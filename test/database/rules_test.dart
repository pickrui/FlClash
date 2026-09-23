import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:fl_clash/common/indexing.dart';
import 'package:fl_clash/common/task.dart';
import 'package:fl_clash/database/database.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:test/test.dart';

void main() {
  late Database database;

  setUp(() async {
    database = Database(NativeDatabase.memory());
    await database.profilesDao.putAll([
      const Profile(id: 1, autoUpdateDuration: Duration.zero).toCompanion(),
    ]);
  });

  tearDown(() async {
    await database.close();
  });

  test('added rules follow profile then global UI order', () async {
    await database.rulesDao.putProfileAddedRule(
      1,
      const Rule(id: 1, value: 'profile first'),
    );
    await database.rulesDao.putProfileAddedRule(
      1,
      const Rule(id: 2, value: 'profile second'),
    );
    await database.rulesDao.putGlobalRule(
      const Rule(id: 3, value: 'global first'),
    );
    await database.rulesDao.putGlobalRule(
      const Rule(id: 4, value: 'global second'),
    );
    // UI order keys are descending: larger key sorts earlier within a group.
    await database.rulesDao.orderProfileAddedRule(1, ruleId: 1, order: 'b');
    await database.rulesDao.orderProfileAddedRule(1, ruleId: 2, order: 'a');
    await database.rulesDao.orderGlobalRule(ruleId: 3, order: 'b');
    await database.rulesDao.orderGlobalRule(ruleId: 4, order: 'a');

    final rules = await database.rulesDao.allAddedRules(1).get();

    expect(rules.map((rule) => rule.id), [1, 2, 3, 4]);
  });

  test('new rules lead their list and edits keep their place', () async {
    for (final id in [1, 2, 3]) {
      await database.rulesDao.putGlobalRule(Rule(id: id, value: 'rule $id'));
    }
    final added = await database.rulesDao.allGlobalAddedRules().get();
    expect(added.map((rule) => rule.id), [3, 2, 1]);
    await database.rulesDao.orderGlobalRule(
      ruleId: 1,
      order: indexing.generateKeyBetween(added[1].order, added[0].order)!,
    );
    await database.rulesDao.putGlobalRule(const Rule(id: 1, value: 'edited'));

    final shown = await database.rulesDao.allGlobalAddedRules().get();
    final applied = await database.rulesDao.allAddedRules(1).get();

    expect(shown.map((rule) => rule.id), [3, 1, 2]);
    expect(shown[1].value, 'edited');
    expect(applied, shown);
  });

  test('a new rule keeps a given key only when it tops the list', () async {
    await database.rulesDao.putGlobalRule(const Rule(id: 1, value: 'first'));
    await database.rulesDao.putGlobalRule(
      const Rule(id: 2, value: 'keyed', order: 'a5'),
    );
    await database.rulesDao.putGlobalRule(
      const Rule(id: 3, value: 'stale', order: 'a1'),
    );

    final shown = await database.rulesDao.allGlobalAddedRules().get();

    expect(shown.map((rule) => (rule.id, rule.order)), [
      (3, 'a6'),
      (2, 'a5'),
      (1, 'a0'),
    ]);
  });

  test('migrated legacy rules keep their legacy list order', () async {
    final temp = await Directory.systemTemp.createTemp('flclash_rules_');
    addTearDown(() => temp.delete(recursive: true));
    await File('${temp.path}/profiles/legacy.yaml').create(recursive: true);
    final globalNames = ['g1', 'g2', 'g3', 'g4', 'g5'];
    final profileNames = ['p1', 'p2', 'p3', 'p4', 'p5'];
    final migration = await migrateLegacyBackup(
      {
        'rules': [
          for (final name in globalNames) {'id': name, 'value': name},
        ],
        'profiles': [
          {
            'id': 'legacy',
            'autoUpdateDuration': const Duration(days: 1).inMicroseconds,
            'overwrite': {
              'type': 'standard',
              'standardOverwrite': {
                'addedRules': [
                  for (final name in profileNames) {'id': name, 'value': name},
                ],
              },
            },
          },
        ],
      },
      sourcePath: temp.path,
      targetPath: '${temp.path}/target',
      livePath: '${temp.path}/live',
    );
    await database.restore(
      migration.profiles,
      migration.scripts,
      migration.rules,
      migration.links,
    );

    final applied = await database.rulesDao
        .allAddedRules(migration.profiles.single.id)
        .get();

    expect(applied.map((rule) => rule.value), [
      ...profileNames,
      ...globalNames,
    ]);
  });

  test(
    'reopening rekeys lists with missing or duplicate keys in core order',
    () async {
      final temp = await Directory.systemTemp.createTemp('flclash_rules_');
      addTearDown(() => temp.delete(recursive: true));
      final file = File('${temp.path}/database.sqlite');
      final legacy = Database(NativeDatabase(file));
      await legacy.profilesDao.putAll([
        const Profile(id: 1, autoUpdateDuration: Duration.zero).toCompanion(),
      ]);
      for (final id in [1, 2, 3]) {
        await legacy.rulesDao.putGlobalRule(Rule(id: id, value: 'global $id'));
      }
      for (final id in [4, 5]) {
        await legacy.rulesDao.putProfileAddedRule(
          1,
          Rule(id: id, value: 'profile $id'),
        );
      }
      await legacy
          .update(legacy.profileRuleLinks)
          .write(const ProfileRuleLinksCompanion(order: Value(null)));
      await legacy.rulesDao.orderGlobalRule(ruleId: 2, order: 'a0');
      await legacy.rulesDao.orderProfileAddedRule(1, ruleId: 4, order: 'a0');
      await legacy.rulesDao.orderProfileAddedRule(1, ruleId: 5, order: 'a0');
      await legacy.close();

      final reopened = Database(NativeDatabase(file));
      addTearDown(reopened.close);
      final shown = await reopened.rulesDao.allGlobalAddedRules().get();
      final profile = await reopened.rulesDao.allProfileAddedRules(1).get();

      expect(shown.map((rule) => rule.id), [2, 1, 3]);
      expect(profile.map((rule) => rule.id), [4, 5]);
      for (final list in [shown, profile]) {
        final keys = list.map((rule) => rule.order).toList();
        expect(keys, everyElement(isNotNull));
        expect(keys.toSet(), hasLength(keys.length));
      }
      expect(
        (await reopened.rulesDao.allAddedRules(1).get()).map((rule) => rule.id),
        [4, 5, 2, 1, 3],
      );
    },
  );

  test('reopening keeps never reordered rules in insertion order', () async {
    final temp = await Directory.systemTemp.createTemp('flclash_rules_');
    addTearDown(() => temp.delete(recursive: true));
    final file = File('${temp.path}/database.sqlite');
    final legacy = Database(NativeDatabase(file));
    for (final (id, value) in [(2, 'A'), (3, 'B'), (1, 'C')]) {
      await legacy.rulesDao.putGlobalRule(Rule(id: id, value: value));
    }
    await legacy
        .update(legacy.profileRuleLinks)
        .write(const ProfileRuleLinksCompanion(order: Value(null)));
    await legacy.close();

    final reopened = Database(NativeDatabase(file));
    addTearDown(reopened.close);
    final applied = await reopened.rulesDao.allAddedRules(1).get();
    final shown = await reopened.rulesDao.allGlobalAddedRules().get();
    await reopened.rulesDao.repairOrders();

    expect(applied.map((rule) => rule.value), ['A', 'B', 'C']);
    expect(shown.map((rule) => rule.value), ['A', 'B', 'C']);
    expect(await reopened.rulesDao.allGlobalAddedRules().get(), shown);
  });

  test('restoring unkeyed rules keeps their backup order', () async {
    await database.restore(
      const [],
      const [],
      const [
        Rule(id: 2, value: 'A'),
        Rule(id: 3, value: 'B'),
        Rule(id: 1, value: 'C'),
      ],
      const [
        ProfileRuleLink(ruleId: 2),
        ProfileRuleLink(ruleId: 3),
        ProfileRuleLink(ruleId: 1),
      ],
    );

    final applied = await database.rulesDao.allAddedRules(1).get();
    final shown = await database.rulesDao.allGlobalAddedRules().get();

    expect(applied.map((rule) => rule.value), ['A', 'B', 'C']);
    expect(shown.map((rule) => rule.value), ['A', 'B', 'C']);
  });

  test('reopening drops rules left behind by a deleted profile', () async {
    final temp = await Directory.systemTemp.createTemp('flclash_rules_');
    addTearDown(() => temp.delete(recursive: true));
    final file = File('${temp.path}/database.sqlite');
    final source = Database(NativeDatabase(file));
    await source.putProfile(
      const Profile(
        id: 2,
        autoUpdateDuration: Duration.zero,
        customRules: [Rule(id: 10, value: 'MATCH,DIRECT')],
      ),
    );
    await source.rulesDao.putProfileAddedRule(
      2,
      const Rule(id: 11, value: 'MATCH,REJECT'),
    );
    await source.rulesDao.putGlobalRule(const Rule(id: 12, value: 'global'));
    await source.profiles.remove((row) => row.id.equals(2));
    await source.close();

    final reopened = Database(NativeDatabase(file));
    addTearDown(reopened.close);

    expect(
      (await reopened.select(reopened.rules).get()).map((rule) => rule.id),
      [12],
    );
  });

  test(
    'added rules exclude globally added rules disabled for profile',
    () async {
      await database.rulesDao.putProfileAddedRule(
        1,
        const Rule(id: 1, value: 'profile'),
      );
      await database.rulesDao.putGlobalRule(const Rule(id: 2, value: 'global'));
      await database.rulesDao.putDisabledLink(1, 2);

      final rules = await database.rulesDao.allAddedRules(1).get();

      expect(rules.map((rule) => rule.id), [1]);
    },
  );

  test('merged overwrite rules reach the final core config in order', () async {
    await database.rulesDao.putProfileAddedRule(
      1,
      const Rule(id: 1, value: 'DOMAIN,profile.example,DIRECT'),
    );
    await database.rulesDao.putGlobalRule(
      const Rule(id: 2, value: 'MATCH,REJECT'),
    );
    await database.rulesDao.putGlobalRule(
      const Rule(id: 3, value: 'DOMAIN,disabled.example,REJECT'),
    );
    await database.rulesDao.putDisabledLink(1, 3);

    final addedRules = await database.rulesDao.allAddedRules(1).get();
    final config = await makeRealProfileTask(
      MakeRealProfileState(
        profilesPath: '/profiles',
        profileId: 1,
        rawConfig: const {
          'rules': ['DOMAIN,original.example,DIRECT', 'MATCH,Proxy'],
        },
        overwriteType: OverwriteType.standard,
        realPatchConfig: const ClashConfig(),
        overrideDns: false,
        appendSystemDns: false,
        addedRules: addedRules,
        proxyChains: const [],
        profileProxies: const [],
        customProxyGroups: const [],
        customRules: const [],
        defaultUA: 'FlClash',
      ),
    );

    expect(config['rules'], [
      'DOMAIN,profile.example,DIRECT',
      'MATCH,REJECT',
      'DOMAIN,original.example,DIRECT',
      'MATCH,Proxy',
    ]);
  });
}

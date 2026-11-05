import 'package:drift/native.dart';
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

part of 'database.dart';

@DataClassName('RawRule')
@TableIndex(name: 'idx_rule_target', columns: {#ruleTarget})
class Rules extends Table {
  @override
  String get tableName => 'rules';

  IntColumn get id => integer()();

  TextColumn get value => text()();

  // Keep verbatim rule text for forward compatibility with new core actions.
  TextColumn get ruleAction => textEnum<RuleAction>().nullable()();
  TextColumn get content => text().nullable()();
  TextColumn get ruleTarget => text().nullable()();
  TextColumn get ruleProvider => text().nullable()();
  TextColumn get subRule => text().nullable()();
  BoolColumn get noResolve => boolean().withDefault(const Constant(false))();
  BoolColumn get src => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftAccessor(tables: [Rules, ProfileRuleLinks])
class RulesDao extends DatabaseAccessor<Database> with _$RulesDaoMixin {
  RulesDao(super.attachedDatabase);

  Selectable<Rule> queryProfileCustomRules(int profileId) {
    final query =
        select(rules).join([
            innerJoin(
              profileRuleLinks,
              profileRuleLinks.ruleId.equalsExp(rules.id),
            ),
          ])
          ..where(
            profileRuleLinks.profileId.equals(profileId) &
                profileRuleLinks.scene.equalsValue(RuleScene.custom),
          )
          ..orderBy([OrderingTerm.asc(profileRuleLinks.order)]);
    return query.map(
      (row) => row
          .readTable(rules)
          .toRule(row.read(profileRuleLinks.order))
          .copyWith(
            id: row.read(profileRuleLinks.sourceId) ?? row.read(rules.id)!,
          ),
    );
  }

  Future<void> replaceCustomWithBatch(Batch batch, Profile profile) async {
    final links =
        await (select(profileRuleLinks)..where(
              (row) =>
                  row.profileId.equals(profile.id) &
                  row.scene.equalsValue(RuleScene.custom),
            ))
            .get();
    final keys = indexing.generateNKeys(profile.customRules.length);
    batch.deleteWhere(
      profileRuleLinks,
      (row) =>
          row.profileId.equals(profile.id) &
          row.scene.equalsValue(RuleScene.custom),
    );
    for (var index = 0; index < profile.customRules.length; index++) {
      final rule = profile.customRules[index];
      final old = links.firstWhereOrNull((link) => link.sourceId == rule.id);
      final internalId = old?.ruleId ?? snowflake.id;
      batch.insertAllOnConflictUpdate(rules, [
        rule.copyWith(id: internalId).toCompanion(),
      ]);
      batch.insert(
        profileRuleLinks,
        ProfileRuleLink(
          profileId: profile.id,
          ruleId: internalId,
          scene: RuleScene.custom,
          order: keys[index],
        ).toCompanion().copyWith(sourceId: Value(rule.id)),
      );
    }
    final linkedIds = selectOnly(profileRuleLinks)
      ..addColumns([profileRuleLinks.ruleId]);
    batch.deleteWhere(
      rules,
      (row) =>
          row.id.isIn(links.map((link) => link.ruleId)) &
          row.id.isNotInQuery(linkedIds),
    );
  }

  Future<void> setCustomRules(int profileId, List<Rule> rules) =>
      attachedDatabase.transaction(() async {
        final profile = await (attachedDatabase.select(
          attachedDatabase.profiles,
        )..where((row) => row.id.equals(profileId))).getSingle();
        await attachedDatabase.putProfile(
          profile.toProfile().copyWith(customRules: rules),
        );
      });

  Selectable<Rule> allGlobalAddedRules() {
    return _get();
  }

  Selectable<Rule> allProfileAddedRules(int profileId) {
    return _get(profileId: profileId, scene: RuleScene.added);
  }

  Selectable<Rule> allProfileDisabledRules(int profileId) {
    return _get(profileId: profileId, scene: RuleScene.disabled);
  }

  Selectable<Rule> allAddedRules(int profileId) {
    final disabledIdsQuery = selectOnly(profileRuleLinks)
      ..addColumns([profileRuleLinks.ruleId])
      ..where(
        profileRuleLinks.profileId.equals(profileId) &
            profileRuleLinks.scene.equalsValue(RuleScene.disabled),
      );

    final query = select(rules).join([
      innerJoin(profileRuleLinks, profileRuleLinks.ruleId.equalsExp(rules.id)),
    ]);

    query.where(
      (profileRuleLinks.profileId.isNull() |
              (profileRuleLinks.profileId.equals(profileId) &
                  profileRuleLinks.scene.equalsValue(RuleScene.added))) &
          profileRuleLinks.ruleId.isNotInQuery(disabledIdsQuery),
    );

    query.orderBy([
      OrderingTerm.asc(
        profileRuleLinks.profileId.isNull().caseMatch<int>(
          when: {const Constant(true): const Constant(1)},
          orElse: const Constant(0),
        ),
      ),
      OrderingTerm.desc(profileRuleLinks.order),
    ]);

    return query.map((row) {
      final ruleData = row.readTable(rules);
      final order = row.read(profileRuleLinks.order);
      return ruleData.toRule(order);
    });
  }

  void restoreWithBatch(
    Batch batch,
    Iterable<Rule> rules,
    Iterable<ProfileRuleLink> links,
  ) {
    batch.insertAllOnConflictUpdate(
      this.rules,
      rules.map((item) => item.toCompanion()),
    );
    final ruleIds = rules.map((item) => item.id);
    batch.deleteWhere(this.rules, (t) => t.id.isNotIn(ruleIds));
    batch.insertAllOnConflictUpdate(
      profileRuleLinks,
      links.map((item) => item.toCompanion()),
    );
    final linkKeys = links.map((item) => item.key);
    batch.deleteWhere(profileRuleLinks, (t) => t.id.isNotIn(linkKeys));
  }

  Future<void> delRules(Iterable<int> ruleIds) {
    return _delAll(ruleIds);
  }

  Future<void> putGlobalRule(Rule rule) {
    return _put(rule);
  }

  Future<void> putProfileAddedRule(int profileId, Rule rule) {
    return _put(rule, profileId: profileId, scene: RuleScene.added);
  }

  Future<int> putDisabledLink(int profileId, int ruleId) async {
    return profileRuleLinks.insertOnConflictUpdate(
      ProfileRuleLink(
        ruleId: ruleId,
        profileId: profileId,
        scene: RuleScene.disabled,
      ).toCompanion(),
    );
  }

  Future<bool> delDisabledLink(int profileId, int ruleId) async {
    return profileRuleLinks.deleteOne(
      ProfileRuleLink(
        profileId: profileId,
        ruleId: ruleId,
        scene: RuleScene.disabled,
      ).toCompanion(),
    );
  }

  Future<int> orderGlobalRule({
    required int ruleId,
    required String order,
  }) async {
    return _order(ruleId: ruleId, order: order);
  }

  Future<int> orderProfileAddedRule(
    int profileId, {
    required int ruleId,
    required String order,
  }) async {
    return _order(
      ruleId: ruleId,
      order: order,
      profileId: profileId,
      scene: RuleScene.added,
    );
  }

  Selectable<Rule> _get({int? profileId, RuleScene? scene}) {
    final query = select(rules).join([
      innerJoin(profileRuleLinks, profileRuleLinks.ruleId.equalsExp(rules.id)),
    ]);

    query.where(
      profileId == null
          ? profileRuleLinks.profileId.isNull()
          : profileRuleLinks.profileId.equals(profileId) &
                profileRuleLinks.scene.equalsValue(scene),
    );

    query.orderBy([
      OrderingTerm.desc(profileRuleLinks.order),
      OrderingTerm.desc(profileRuleLinks.id),
    ]);

    return query.map((row) {
      return row.readTable(rules).toRule(row.read(profileRuleLinks.order));
    });
  }

  Future<int> _order({
    required int ruleId,
    required String order,
    int? profileId,
    RuleScene? scene,
  }) async {
    final stmt = profileRuleLinks.update();
    stmt.where((t) {
      return (profileId == null
              ? t.profileId.isNull()
              : t.profileId.equals(profileId)) &
          t.ruleId.equals(ruleId) &
          t.scene.equalsValue(scene);
    });
    return stmt.write(ProfileRuleLinksCompanion(order: Value(order)));
  }

  Future<int> _put(Rule rule, {int? profileId, RuleScene? scene}) async {
    return transaction(() async {
      final row = await rules.insertOnConflictUpdate(rule.toCompanion());
      if (row == 0) {
        return 0;
      }
      return profileRuleLinks.insertOnConflictUpdate(
        ProfileRuleLink(
          ruleId: rule.id,
          profileId: profileId,
          scene: scene,
        ).toCompanion(),
      );
    });
  }

  Future<void> _delAll(Iterable<int> ruleIds) async {
    await rules.deleteWhere((t) => t.id.isIn(ruleIds));
  }
}

extension RawRuleExt on RawRule {
  Rule toRule([String? order]) {
    return Rule(id: id, value: value, order: order);
  }
}

extension RulesCompanionExt on Rule {
  RulesCompanion toCompanion() {
    final parsed = ParsedRule.parseString(value);
    return RulesCompanion.insert(
      id: Value(id),
      value: value,
      ruleAction: Value(parsed.ruleAction),
      content: Value(parsed.content),
      ruleTarget: Value(parsed.ruleTarget),
      ruleProvider: Value(parsed.ruleProvider),
      subRule: Value(parsed.subRule),
      noResolve: Value(parsed.noResolve),
      src: Value(parsed.src),
    );
  }
}

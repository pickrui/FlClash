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
      OrderingTerm.desc(profileRuleLinks.id),
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

  /// Lists show the largest key first and a reorder derives its key from both
  /// neighbours, so a list with missing or duplicate keys is rekeyed in place.
  Future<void> repairOrders() async {
    final profileIds = await customSelect(
      'SELECT profile_id FROM profile_rule_mapping '
      "WHERE profile_id IS NULL OR scene = 'added' "
      'GROUP BY profile_id '
      'HAVING COUNT(*) > COUNT(DISTINCT "order")',
      readsFrom: {profileRuleLinks},
    ).map((row) => row.readNullable<int>('profile_id')).get();
    if (profileIds.isEmpty) return;
    final updates = <String, String>{};
    for (final profileId in profileIds) {
      final ids =
          await (selectOnly(profileRuleLinks)
                ..addColumns([profileRuleLinks.id])
                ..where(_listFilter(profileId))
                ..orderBy([
                  OrderingTerm.desc(profileRuleLinks.order),
                  OrderingTerm.desc(profileRuleLinks.id),
                ]))
              .map((row) => row.read(profileRuleLinks.id)!)
              .get();
      final keys = indexing.generateNKeys(ids.length);
      for (var index = 0; index < ids.length; index++) {
        updates[ids[index]] = keys[ids.length - 1 - index]!;
      }
    }
    await batch((batch) {
      for (final MapEntry(key: id, value: order) in updates.entries) {
        batch.update(
          profileRuleLinks,
          ProfileRuleLinksCompanion(order: Value(order)),
          where: (row) => row.id.equals(id),
        );
      }
    });
  }

  Expression<bool> _listFilter(int? profileId) => profileId == null
      ? profileRuleLinks.profileId.isNull()
      : profileRuleLinks.profileId.equals(profileId) &
            profileRuleLinks.scene.equalsValue(RuleScene.added);

  Future<int> _put(Rule rule, {int? profileId, RuleScene? scene}) async {
    return transaction(() async {
      final row = await rules.insertOnConflictUpdate(rule.toCompanion());
      if (row == 0) {
        return 0;
      }
      final link = ProfileRuleLink(
        ruleId: rule.id,
        profileId: profileId,
        scene: scene,
      );
      final existing = await (select(
        profileRuleLinks,
      )..where((row) => row.id.equals(link.key))).getSingleOrNull();
      final String? order;
      if (existing != null) {
        order = existing.order;
      } else {
        final top = profileRuleLinks.order.max();
        final current =
            await (selectOnly(profileRuleLinks)
                  ..addColumns([top])
                  ..where(_listFilter(profileId)))
                .map((row) => row.read(top))
                .getSingle();
        final requested = rule.order;
        order =
            requested != null &&
                (current == null || requested.compareTo(current) > 0)
            ? requested
            : indexing.generateKeyBetween(current, null);
      }
      return profileRuleLinks.insertOnConflictUpdate(
        link.copyWith(order: order).toCompanion(),
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

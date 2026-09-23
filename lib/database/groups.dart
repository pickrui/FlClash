part of 'database.dart';

@DataClassName('RawProxyGroup')
@TableIndex(
  name: 'idx_profile_name_order',
  columns: {#profileId, #name, #order},
)
class ProxyGroups extends Table {
  @override
  String get tableName => 'proxy_groups';

  IntColumn get id => integer()();

  IntColumn get profileId => integer().nullable().references(
    Profiles,
    #id,
    onDelete: KeyAction.cascade,
  )();

  TextColumn get name => text()();

  TextColumn get type => text()();

  TextColumn get proxies =>
      text().map(const StringListConverter()).nullable()();

  TextColumn get use => text().map(const StringListConverter()).nullable()();

  TextColumn get url => text().nullable()();

  IntColumn get interval => integer().nullable()();

  IntColumn get timeout => integer().nullable()();

  IntColumn get maxFailedTimes => integer().nullable()();

  BoolColumn get lazy => boolean().nullable()();

  BoolColumn get disableUdp => boolean().nullable()();

  TextColumn get filter => text().nullable()();

  TextColumn get excludeFilter => text().nullable()();

  TextColumn get excludeType => text().nullable()();

  TextColumn get expectedStatus =>
      text().map(const JsonValueConverter()).nullable()();

  IntColumn get tolerance => integer().nullable()();

  TextColumn get strategy => text().nullable()();

  BoolColumn get includeAll => boolean().nullable()();

  BoolColumn get includeAllProxies => boolean().nullable()();

  BoolColumn get includeAllProviders => boolean().nullable()();

  BoolColumn get hidden => boolean().nullable()();

  TextColumn get icon => text().nullable()();

  TextColumn get order => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftAccessor(tables: [ProxyGroups])
class ProxyGroupsDao extends DatabaseAccessor<Database>
    with _$ProxyGroupsDaoMixin {
  ProxyGroupsDao(super.attachedDatabase);

  Selectable<ProxyGroup> query(int profileId) {
    final stmt = proxyGroups.select();
    stmt.where((row) => row.profileId.equals(profileId));
    stmt.orderBy([
      (t) => OrderingTerm(expression: t.order, nulls: NullsOrder.last),
    ]);
    return stmt.map((item) => item.toProxyGroup());
  }

  Future<void> setAll(int profileId, List<ProxyGroup> groups) async {
    await attachedDatabase.transaction(() async {
      final profile = await (attachedDatabase.select(
        attachedDatabase.profiles,
      )..where((row) => row.id.equals(profileId))).getSingle();
      await attachedDatabase.putProfile(
        profile.toProfile().copyWith(customProxyGroups: groups),
      );
    });
  }

  Future<void> replaceWithBatch(Batch batch, Profile profile) async {
    final previous = await query(profile.id).get();
    final keys = indexing.generateNKeys(profile.customProxyGroups.length);
    proxyGroups.setAll(
      batch,
      profile.customProxyGroups.mapIndexed((index, group) {
        final old =
            previous.firstWhereOrNull(
              (item) => group.id != null && item.id == group.id,
            ) ??
            previous.firstWhereOrNull((item) => item.name == group.name);
        return group
            .copyWith(id: old?.id ?? snowflake.id, profileId: profile.id)
            .toCompanion(profile.id, keys[index]);
      }),
      deleteFilter: (row) => row.profileId.equals(profile.id),
      preDelete: true,
    );
  }
}

extension RawProxyGroupExt on RawProxyGroup {
  ProxyGroup toProxyGroup() {
    return ProxyGroup(
      profileId: profileId,
      id: id,
      name: name,
      type: GroupType.parseProfileType(type),
      proxies: proxies,
      use: use,
      url: url,
      interval: interval,
      timeout: timeout,
      maxFailedTimes: maxFailedTimes,
      lazy: lazy,
      disableUdp: disableUdp,
      filter: filter,
      excludeFilter: excludeFilter,
      excludeType: excludeType,
      expectedStatus: expectedStatus,
      tolerance: tolerance,
      strategy: strategy,
      includeAll: includeAll,
      includeAllProxies: includeAllProxies,
      includeAllProviders: includeAllProviders,
      hidden: hidden,
      icon: icon,
      order: order,
    );
  }
}

extension ProxyGroupsCompanionExt on ProxyGroup {
  ProxyGroupsCompanion toCompanion([int? profileId, String? order]) {
    return ProxyGroupsCompanion.insert(
      id: Value(id ?? snowflake.id),
      profileId: Value(this.profileId ?? profileId),
      name: name,
      type: type.name,
      proxies: Value(proxies),
      use: Value(use),
      url: Value(url),
      interval: Value(interval),
      timeout: Value(timeout),
      maxFailedTimes: Value(maxFailedTimes),
      lazy: Value(lazy),
      disableUdp: Value(disableUdp),
      filter: Value(filter),
      excludeFilter: Value(excludeFilter),
      excludeType: Value(excludeType),
      expectedStatus: Value(expectedStatus),
      tolerance: Value(tolerance),
      strategy: Value(strategy),
      includeAll: Value(includeAll),
      includeAllProxies: Value(includeAllProxies),
      includeAllProviders: Value(includeAllProviders),
      hidden: Value(hidden),
      icon: Value(icon),
      order: Value(order ?? this.order),
    );
  }
}

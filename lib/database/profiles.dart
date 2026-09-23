part of 'database.dart';

@DataClassName('RawProfile')
class Profiles extends Table {
  @override
  String get tableName => 'profiles';

  IntColumn get id => integer()();

  TextColumn get label => text()();

  TextColumn get currentGroupName => text().nullable()();

  TextColumn get url => text()();

  DateTimeColumn get lastUpdateDate => dateTime().nullable()();

  TextColumn get overwriteType => textEnum<OverwriteType>()();

  IntColumn get scriptId => integer().nullable()();

  TextColumn get matchTarget => text().nullable()();

  IntColumn get autoUpdateDurationMillis => integer()();

  TextColumn get subscriptionInfo =>
      text().map(const SubscriptionInfoConverter()).nullable()();

  BoolColumn get autoUpdate => boolean()();

  TextColumn get selectedMap => text().map(const StringMapConverter())();

  TextColumn get unfoldSet => text().map(const StringSetConverter())();

  TextColumn get proxyChains => text()
      .map(const ProxyChainListConverter())
      .withDefault(const Constant('[]'))();

  TextColumn get profileProxies => text()
      .map(const ProfileProxyListConverter())
      .withDefault(const Constant('[]'))();

  TextColumn get customProxyGroups => text()
      .map(const ProxyGroupListConverter())
      .withDefault(const Constant('[]'))();

  TextColumn get customRules =>
      text().map(const RuleListConverter()).withDefault(const Constant('[]'))();

  IntColumn get order => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class SubscriptionInfoConverter
    extends TypeConverter<SubscriptionInfo?, String?> {
  const SubscriptionInfoConverter();

  @override
  SubscriptionInfo? fromSql(String? fromDb) {
    if (fromDb == null) return null;
    return SubscriptionInfo.fromJson(json.decode(fromDb));
  }

  @override
  String? toSql(SubscriptionInfo? value) {
    if (value == null) return null;
    return json.encode(value.toJson());
  }
}

@DriftAccessor(tables: [Profiles])
class ProfilesDao extends DatabaseAccessor<Database> with _$ProfilesDaoMixin {
  ProfilesDao(super.attachedDatabase);

  Selectable<Profile> all() {
    final stmt = profiles.select();
    stmt.orderBy([
      (t) => OrderingTerm(expression: t.order, nulls: NullsOrder.last),
      (t) => OrderingTerm.asc(t.id),
    ]);
    return stmt.map((item) => item.toProfile());
  }

  Future<void> setAll(Iterable<Profile> profiles) async {
    await transaction(() async {
      await batch((b) => setAllWithBatch(b, profiles));
      await batch((b) async {
        for (final profile in profiles) {
          await attachedDatabase.proxyGroupsDao.replaceWithBatch(b, profile);
          await attachedDatabase.rulesDao.replaceCustomWithBatch(b, profile);
        }
      });
    });
  }

  Future<void> putAll(Iterable<Insertable<RawProfile>> items) =>
      batch((b) => putAllWithBatch(b, items));

  void putAllWithBatch(Batch batch, Iterable<Insertable<RawProfile>> items) {
    batch.insertAllOnConflictUpdate(profiles, items);
  }

  void setAllWithBatch(Batch batch, Iterable<Profile> profiles) {
    final List<ProfilesCompanion> items = [];
    final List<int> ids = [];
    profiles.forEachIndexed((index, profile) {
      ids.add(profile.id);
      items.add(profile.toCompanion(index));
    });

    this.profiles.setAll(batch, items, deleteFilter: (t) => t.id.isNotIn(ids));
  }
}

List<T> _jsonListFromSql<T>(
  String fromDb,
  T Function(Map<String, Object?> item) fromJson,
) {
  final value = json.decode(fromDb);
  if (value is! List) {
    return [];
  }
  return value
      .whereType<Map>()
      .map((item) => fromJson(Map<String, Object?>.from(item)))
      .toList();
}

String _jsonListToSql<T>(List<T> value, Object? Function(T item) toJson) {
  return json.encode(value.map(toJson).toList());
}

class ProxyChainListConverter extends TypeConverter<List<ProxyChain>, String> {
  const ProxyChainListConverter();

  @override
  List<ProxyChain> fromSql(String fromDb) {
    return _jsonListFromSql(fromDb, ProxyChain.fromJson);
  }

  @override
  String toSql(List<ProxyChain> value) {
    return _jsonListToSql(value, (item) => item.toJson());
  }
}

class ProfileProxyListConverter
    extends TypeConverter<List<ProfileProxy>, String> {
  const ProfileProxyListConverter();

  @override
  List<ProfileProxy> fromSql(String fromDb) {
    return _jsonListFromSql(fromDb, ProfileProxy.fromJson);
  }

  @override
  String toSql(List<ProfileProxy> value) {
    return _jsonListToSql(value, (item) => item.toJson());
  }
}

class ProxyGroupListConverter extends TypeConverter<List<ProxyGroup>, String> {
  const ProxyGroupListConverter();

  @override
  List<ProxyGroup> fromSql(String fromDb) {
    return _jsonListFromSql(fromDb, ProxyGroup.fromJson);
  }

  @override
  String toSql(List<ProxyGroup> value) {
    return _jsonListToSql(value, (item) => item.toJson());
  }
}

class RuleListConverter extends TypeConverter<List<Rule>, String> {
  const RuleListConverter();

  @override
  List<Rule> fromSql(String fromDb) {
    return _jsonListFromSql(fromDb, Rule.fromJson);
  }

  @override
  String toSql(List<Rule> value) {
    return _jsonListToSql(value, (item) => item.toJson());
  }
}

extension RawProfilExt on RawProfile {
  Profile toProfile() {
    return Profile(
      id: id,
      label: label,
      currentGroupName: currentGroupName,
      url: url,
      lastUpdateDate: lastUpdateDate,
      autoUpdateDuration: Duration(milliseconds: autoUpdateDurationMillis),
      subscriptionInfo: subscriptionInfo,
      autoUpdate: autoUpdate,
      selectedMap: selectedMap,
      unfoldSet: unfoldSet,
      overwriteType: overwriteType,
      proxyChains: proxyChains,
      profileProxies: profileProxies,
      customProxyGroups: customProxyGroups,
      customRules: customRules,
      scriptId: scriptId,
      matchTarget: matchTarget,
      order: order,
    );
  }
}

extension ProfilesCompanionExt on Profile {
  ProfilesCompanion toCompanion([int? order]) {
    return ProfilesCompanion.insert(
      id: Value(id),
      label: label,
      currentGroupName: Value(currentGroupName),
      url: url,
      lastUpdateDate: Value(lastUpdateDate),
      autoUpdateDurationMillis: autoUpdateDuration.inMilliseconds,
      subscriptionInfo: Value(subscriptionInfo),
      autoUpdate: autoUpdate,
      selectedMap: selectedMap,
      unfoldSet: unfoldSet,
      overwriteType: overwriteType,
      proxyChains: Value(proxyChains),
      profileProxies: Value(profileProxies),
      customProxyGroups: Value(customProxyGroups),
      customRules: Value(customRules),
      scriptId: Value(scriptId),
      matchTarget: Value(matchTarget),
      order: Value(order ?? this.order),
    );
  }
}

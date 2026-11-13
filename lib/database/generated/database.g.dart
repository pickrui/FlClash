// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../database.dart';

// ignore_for_file: type=lint
class $ProfilesTable extends Profiles
    with TableInfo<$ProfilesTable, RawProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentGroupNameMeta = const VerificationMeta(
    'currentGroupName',
  );
  @override
  late final GeneratedColumn<String> currentGroupName = GeneratedColumn<String>(
    'current_group_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ageSecretKeyMeta = const VerificationMeta(
    'ageSecretKey',
  );
  @override
  late final GeneratedColumn<String> ageSecretKey = GeneratedColumn<String>(
    'age_secret_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastUpdateDateMeta = const VerificationMeta(
    'lastUpdateDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdateDate =
      GeneratedColumn<DateTime>(
        'last_update_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastCheckDateMeta = const VerificationMeta(
    'lastCheckDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastCheckDate =
      GeneratedColumn<DateTime>(
        'last_check_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<OverwriteType, String>
  overwriteType = GeneratedColumn<String>(
    'overwrite_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<OverwriteType>($ProfilesTable.$converteroverwriteType);
  static const VerificationMeta _scriptIdMeta = const VerificationMeta(
    'scriptId',
  );
  @override
  late final GeneratedColumn<int> scriptId = GeneratedColumn<int>(
    'script_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _matchTargetMeta = const VerificationMeta(
    'matchTarget',
  );
  @override
  late final GeneratedColumn<String> matchTarget = GeneratedColumn<String>(
    'match_target',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _autoUpdateDurationMillisMeta =
      const VerificationMeta('autoUpdateDurationMillis');
  @override
  late final GeneratedColumn<int> autoUpdateDurationMillis =
      GeneratedColumn<int>(
        'auto_update_duration_millis',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  @override
  late final GeneratedColumnWithTypeConverter<SubscriptionInfo?, String>
  subscriptionInfo = GeneratedColumn<String>(
    'subscription_info',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<SubscriptionInfo?>($ProfilesTable.$convertersubscriptionInfo);
  static const VerificationMeta _autoUpdateMeta = const VerificationMeta(
    'autoUpdate',
  );
  @override
  late final GeneratedColumn<bool> autoUpdate = GeneratedColumn<bool>(
    'auto_update',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("auto_update" IN (0, 1))',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, String>, String>
  selectedMap = GeneratedColumn<String>(
    'selected_map',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<Map<String, String>>($ProfilesTable.$converterselectedMap);
  @override
  late final GeneratedColumnWithTypeConverter<Set<String>, String> unfoldSet =
      GeneratedColumn<String>(
        'unfold_set',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Set<String>>($ProfilesTable.$converterunfoldSet);
  @override
  late final GeneratedColumnWithTypeConverter<List<ProxyChain>, String>
  proxyChains = GeneratedColumn<String>(
    'proxy_chains',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  ).withConverter<List<ProxyChain>>($ProfilesTable.$converterproxyChains);
  @override
  late final GeneratedColumnWithTypeConverter<List<ProfileProxy>, String>
  profileProxies = GeneratedColumn<String>(
    'profile_proxies',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  ).withConverter<List<ProfileProxy>>($ProfilesTable.$converterprofileProxies);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, String>, String>
  proxyAliases = GeneratedColumn<String>(
    'proxy_aliases',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  ).withConverter<Map<String, String>>($ProfilesTable.$converterproxyAliases);
  @override
  late final GeneratedColumnWithTypeConverter<List<ProxyGroup>, String>
  customProxyGroups = GeneratedColumn<String>(
    'custom_proxy_groups',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  ).withConverter<List<ProxyGroup>>($ProfilesTable.$convertercustomProxyGroups);
  @override
  late final GeneratedColumnWithTypeConverter<List<Rule>, String> customRules =
      GeneratedColumn<String>(
        'custom_rules',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      ).withConverter<List<Rule>>($ProfilesTable.$convertercustomRules);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ProfileType?, String>
  profileType = GeneratedColumn<String>(
    'profile_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<ProfileType?>($ProfilesTable.$converterprofileTypen);
  @override
  late final GeneratedColumnWithTypeConverter<ProfileOverrides?, String>
  overrides = GeneratedColumn<String>(
    'overrides',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<ProfileOverrides?>($ProfilesTable.$converteroverrides);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    label,
    currentGroupName,
    url,
    ageSecretKey,
    lastUpdateDate,
    lastCheckDate,
    overwriteType,
    scriptId,
    matchTarget,
    autoUpdateDurationMillis,
    subscriptionInfo,
    autoUpdate,
    selectedMap,
    unfoldSet,
    proxyChains,
    profileProxies,
    proxyAliases,
    customProxyGroups,
    customRules,
    order,
    profileType,
    overrides,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('current_group_name')) {
      context.handle(
        _currentGroupNameMeta,
        currentGroupName.isAcceptableOrUnknown(
          data['current_group_name']!,
          _currentGroupNameMeta,
        ),
      );
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('age_secret_key')) {
      context.handle(
        _ageSecretKeyMeta,
        ageSecretKey.isAcceptableOrUnknown(
          data['age_secret_key']!,
          _ageSecretKeyMeta,
        ),
      );
    }
    if (data.containsKey('last_update_date')) {
      context.handle(
        _lastUpdateDateMeta,
        lastUpdateDate.isAcceptableOrUnknown(
          data['last_update_date']!,
          _lastUpdateDateMeta,
        ),
      );
    }
    if (data.containsKey('last_check_date')) {
      context.handle(
        _lastCheckDateMeta,
        lastCheckDate.isAcceptableOrUnknown(
          data['last_check_date']!,
          _lastCheckDateMeta,
        ),
      );
    }
    if (data.containsKey('script_id')) {
      context.handle(
        _scriptIdMeta,
        scriptId.isAcceptableOrUnknown(data['script_id']!, _scriptIdMeta),
      );
    }
    if (data.containsKey('match_target')) {
      context.handle(
        _matchTargetMeta,
        matchTarget.isAcceptableOrUnknown(
          data['match_target']!,
          _matchTargetMeta,
        ),
      );
    }
    if (data.containsKey('auto_update_duration_millis')) {
      context.handle(
        _autoUpdateDurationMillisMeta,
        autoUpdateDurationMillis.isAcceptableOrUnknown(
          data['auto_update_duration_millis']!,
          _autoUpdateDurationMillisMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_autoUpdateDurationMillisMeta);
    }
    if (data.containsKey('auto_update')) {
      context.handle(
        _autoUpdateMeta,
        autoUpdate.isAcceptableOrUnknown(data['auto_update']!, _autoUpdateMeta),
      );
    } else if (isInserting) {
      context.missing(_autoUpdateMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      currentGroupName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_group_name'],
      ),
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      ageSecretKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}age_secret_key'],
      ),
      lastUpdateDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_update_date'],
      ),
      lastCheckDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_check_date'],
      ),
      overwriteType: $ProfilesTable.$converteroverwriteType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}overwrite_type'],
        )!,
      ),
      scriptId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}script_id'],
      ),
      matchTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}match_target'],
      ),
      autoUpdateDurationMillis: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}auto_update_duration_millis'],
      )!,
      subscriptionInfo: $ProfilesTable.$convertersubscriptionInfo.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}subscription_info'],
        ),
      ),
      autoUpdate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}auto_update'],
      )!,
      selectedMap: $ProfilesTable.$converterselectedMap.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}selected_map'],
        )!,
      ),
      unfoldSet: $ProfilesTable.$converterunfoldSet.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}unfold_set'],
        )!,
      ),
      proxyChains: $ProfilesTable.$converterproxyChains.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}proxy_chains'],
        )!,
      ),
      profileProxies: $ProfilesTable.$converterprofileProxies.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}profile_proxies'],
        )!,
      ),
      proxyAliases: $ProfilesTable.$converterproxyAliases.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}proxy_aliases'],
        )!,
      ),
      customProxyGroups: $ProfilesTable.$convertercustomProxyGroups.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}custom_proxy_groups'],
        )!,
      ),
      customRules: $ProfilesTable.$convertercustomRules.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}custom_rules'],
        )!,
      ),
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      ),
      profileType: $ProfilesTable.$converterprofileTypen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}profile_type'],
        ),
      ),
      overrides: $ProfilesTable.$converteroverrides.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}overrides'],
        ),
      ),
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<OverwriteType, String, String>
  $converteroverwriteType = const EnumNameConverter<OverwriteType>(
    OverwriteType.values,
  );
  static TypeConverter<SubscriptionInfo?, String?> $convertersubscriptionInfo =
      const SubscriptionInfoConverter();
  static TypeConverter<Map<String, String>, String> $converterselectedMap =
      const StringMapConverter();
  static TypeConverter<Set<String>, String> $converterunfoldSet =
      const StringSetConverter();
  static TypeConverter<List<ProxyChain>, String> $converterproxyChains =
      const ProxyChainListConverter();
  static TypeConverter<List<ProfileProxy>, String> $converterprofileProxies =
      const ProfileProxyListConverter();
  static TypeConverter<Map<String, String>, String> $converterproxyAliases =
      const StringMapConverter();
  static TypeConverter<List<ProxyGroup>, String> $convertercustomProxyGroups =
      const ProxyGroupListConverter();
  static TypeConverter<List<Rule>, String> $convertercustomRules =
      const RuleListConverter();
  static JsonTypeConverter2<ProfileType, String, String> $converterprofileType =
      const EnumNameConverter<ProfileType>(ProfileType.values);
  static JsonTypeConverter2<ProfileType?, String?, String?>
  $converterprofileTypen = JsonTypeConverter2.asNullable($converterprofileType);
  static TypeConverter<ProfileOverrides?, String?> $converteroverrides =
      const ProfileOverridesConverter();
}

class RawProfile extends DataClass implements Insertable<RawProfile> {
  final int id;
  final String label;
  final String? currentGroupName;
  final String url;
  final String? ageSecretKey;
  final DateTime? lastUpdateDate;
  final DateTime? lastCheckDate;
  final OverwriteType overwriteType;
  final int? scriptId;
  final String? matchTarget;
  final int autoUpdateDurationMillis;
  final SubscriptionInfo? subscriptionInfo;
  final bool autoUpdate;
  final Map<String, String> selectedMap;
  final Set<String> unfoldSet;
  final List<ProxyChain> proxyChains;
  final List<ProfileProxy> profileProxies;
  final Map<String, String> proxyAliases;
  final List<ProxyGroup> customProxyGroups;
  final List<Rule> customRules;
  final int? order;
  final ProfileType? profileType;
  final ProfileOverrides? overrides;
  const RawProfile({
    required this.id,
    required this.label,
    this.currentGroupName,
    required this.url,
    this.ageSecretKey,
    this.lastUpdateDate,
    this.lastCheckDate,
    required this.overwriteType,
    this.scriptId,
    this.matchTarget,
    required this.autoUpdateDurationMillis,
    this.subscriptionInfo,
    required this.autoUpdate,
    required this.selectedMap,
    required this.unfoldSet,
    required this.proxyChains,
    required this.profileProxies,
    required this.proxyAliases,
    required this.customProxyGroups,
    required this.customRules,
    this.order,
    this.profileType,
    this.overrides,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['label'] = Variable<String>(label);
    if (!nullToAbsent || currentGroupName != null) {
      map['current_group_name'] = Variable<String>(currentGroupName);
    }
    map['url'] = Variable<String>(url);
    if (!nullToAbsent || ageSecretKey != null) {
      map['age_secret_key'] = Variable<String>(ageSecretKey);
    }
    if (!nullToAbsent || lastUpdateDate != null) {
      map['last_update_date'] = Variable<DateTime>(lastUpdateDate);
    }
    if (!nullToAbsent || lastCheckDate != null) {
      map['last_check_date'] = Variable<DateTime>(lastCheckDate);
    }
    {
      map['overwrite_type'] = Variable<String>(
        $ProfilesTable.$converteroverwriteType.toSql(overwriteType),
      );
    }
    if (!nullToAbsent || scriptId != null) {
      map['script_id'] = Variable<int>(scriptId);
    }
    if (!nullToAbsent || matchTarget != null) {
      map['match_target'] = Variable<String>(matchTarget);
    }
    map['auto_update_duration_millis'] = Variable<int>(
      autoUpdateDurationMillis,
    );
    if (!nullToAbsent || subscriptionInfo != null) {
      map['subscription_info'] = Variable<String>(
        $ProfilesTable.$convertersubscriptionInfo.toSql(subscriptionInfo),
      );
    }
    map['auto_update'] = Variable<bool>(autoUpdate);
    {
      map['selected_map'] = Variable<String>(
        $ProfilesTable.$converterselectedMap.toSql(selectedMap),
      );
    }
    {
      map['unfold_set'] = Variable<String>(
        $ProfilesTable.$converterunfoldSet.toSql(unfoldSet),
      );
    }
    {
      map['proxy_chains'] = Variable<String>(
        $ProfilesTable.$converterproxyChains.toSql(proxyChains),
      );
    }
    {
      map['profile_proxies'] = Variable<String>(
        $ProfilesTable.$converterprofileProxies.toSql(profileProxies),
      );
    }
    {
      map['proxy_aliases'] = Variable<String>(
        $ProfilesTable.$converterproxyAliases.toSql(proxyAliases),
      );
    }
    {
      map['custom_proxy_groups'] = Variable<String>(
        $ProfilesTable.$convertercustomProxyGroups.toSql(customProxyGroups),
      );
    }
    {
      map['custom_rules'] = Variable<String>(
        $ProfilesTable.$convertercustomRules.toSql(customRules),
      );
    }
    if (!nullToAbsent || order != null) {
      map['order'] = Variable<int>(order);
    }
    if (!nullToAbsent || profileType != null) {
      map['profile_type'] = Variable<String>(
        $ProfilesTable.$converterprofileTypen.toSql(profileType),
      );
    }
    if (!nullToAbsent || overrides != null) {
      map['overrides'] = Variable<String>(
        $ProfilesTable.$converteroverrides.toSql(overrides),
      );
    }
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      label: Value(label),
      currentGroupName: currentGroupName == null && nullToAbsent
          ? const Value.absent()
          : Value(currentGroupName),
      url: Value(url),
      ageSecretKey: ageSecretKey == null && nullToAbsent
          ? const Value.absent()
          : Value(ageSecretKey),
      lastUpdateDate: lastUpdateDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdateDate),
      lastCheckDate: lastCheckDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastCheckDate),
      overwriteType: Value(overwriteType),
      scriptId: scriptId == null && nullToAbsent
          ? const Value.absent()
          : Value(scriptId),
      matchTarget: matchTarget == null && nullToAbsent
          ? const Value.absent()
          : Value(matchTarget),
      autoUpdateDurationMillis: Value(autoUpdateDurationMillis),
      subscriptionInfo: subscriptionInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(subscriptionInfo),
      autoUpdate: Value(autoUpdate),
      selectedMap: Value(selectedMap),
      unfoldSet: Value(unfoldSet),
      proxyChains: Value(proxyChains),
      profileProxies: Value(profileProxies),
      proxyAliases: Value(proxyAliases),
      customProxyGroups: Value(customProxyGroups),
      customRules: Value(customRules),
      order: order == null && nullToAbsent
          ? const Value.absent()
          : Value(order),
      profileType: profileType == null && nullToAbsent
          ? const Value.absent()
          : Value(profileType),
      overrides: overrides == null && nullToAbsent
          ? const Value.absent()
          : Value(overrides),
    );
  }

  factory RawProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawProfile(
      id: serializer.fromJson<int>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      currentGroupName: serializer.fromJson<String?>(json['currentGroupName']),
      url: serializer.fromJson<String>(json['url']),
      ageSecretKey: serializer.fromJson<String?>(json['ageSecretKey']),
      lastUpdateDate: serializer.fromJson<DateTime?>(json['lastUpdateDate']),
      lastCheckDate: serializer.fromJson<DateTime?>(json['lastCheckDate']),
      overwriteType: $ProfilesTable.$converteroverwriteType.fromJson(
        serializer.fromJson<String>(json['overwriteType']),
      ),
      scriptId: serializer.fromJson<int?>(json['scriptId']),
      matchTarget: serializer.fromJson<String?>(json['matchTarget']),
      autoUpdateDurationMillis: serializer.fromJson<int>(
        json['autoUpdateDurationMillis'],
      ),
      subscriptionInfo: serializer.fromJson<SubscriptionInfo?>(
        json['subscriptionInfo'],
      ),
      autoUpdate: serializer.fromJson<bool>(json['autoUpdate']),
      selectedMap: serializer.fromJson<Map<String, String>>(
        json['selectedMap'],
      ),
      unfoldSet: serializer.fromJson<Set<String>>(json['unfoldSet']),
      proxyChains: serializer.fromJson<List<ProxyChain>>(json['proxyChains']),
      profileProxies: serializer.fromJson<List<ProfileProxy>>(
        json['profileProxies'],
      ),
      proxyAliases: serializer.fromJson<Map<String, String>>(
        json['proxyAliases'],
      ),
      customProxyGroups: serializer.fromJson<List<ProxyGroup>>(
        json['customProxyGroups'],
      ),
      customRules: serializer.fromJson<List<Rule>>(json['customRules']),
      order: serializer.fromJson<int?>(json['order']),
      profileType: $ProfilesTable.$converterprofileTypen.fromJson(
        serializer.fromJson<String?>(json['profileType']),
      ),
      overrides: serializer.fromJson<ProfileOverrides?>(json['overrides']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'label': serializer.toJson<String>(label),
      'currentGroupName': serializer.toJson<String?>(currentGroupName),
      'url': serializer.toJson<String>(url),
      'ageSecretKey': serializer.toJson<String?>(ageSecretKey),
      'lastUpdateDate': serializer.toJson<DateTime?>(lastUpdateDate),
      'lastCheckDate': serializer.toJson<DateTime?>(lastCheckDate),
      'overwriteType': serializer.toJson<String>(
        $ProfilesTable.$converteroverwriteType.toJson(overwriteType),
      ),
      'scriptId': serializer.toJson<int?>(scriptId),
      'matchTarget': serializer.toJson<String?>(matchTarget),
      'autoUpdateDurationMillis': serializer.toJson<int>(
        autoUpdateDurationMillis,
      ),
      'subscriptionInfo': serializer.toJson<SubscriptionInfo?>(
        subscriptionInfo,
      ),
      'autoUpdate': serializer.toJson<bool>(autoUpdate),
      'selectedMap': serializer.toJson<Map<String, String>>(selectedMap),
      'unfoldSet': serializer.toJson<Set<String>>(unfoldSet),
      'proxyChains': serializer.toJson<List<ProxyChain>>(proxyChains),
      'profileProxies': serializer.toJson<List<ProfileProxy>>(profileProxies),
      'proxyAliases': serializer.toJson<Map<String, String>>(proxyAliases),
      'customProxyGroups': serializer.toJson<List<ProxyGroup>>(
        customProxyGroups,
      ),
      'customRules': serializer.toJson<List<Rule>>(customRules),
      'order': serializer.toJson<int?>(order),
      'profileType': serializer.toJson<String?>(
        $ProfilesTable.$converterprofileTypen.toJson(profileType),
      ),
      'overrides': serializer.toJson<ProfileOverrides?>(overrides),
    };
  }

  RawProfile copyWith({
    int? id,
    String? label,
    Value<String?> currentGroupName = const Value.absent(),
    String? url,
    Value<String?> ageSecretKey = const Value.absent(),
    Value<DateTime?> lastUpdateDate = const Value.absent(),
    Value<DateTime?> lastCheckDate = const Value.absent(),
    OverwriteType? overwriteType,
    Value<int?> scriptId = const Value.absent(),
    Value<String?> matchTarget = const Value.absent(),
    int? autoUpdateDurationMillis,
    Value<SubscriptionInfo?> subscriptionInfo = const Value.absent(),
    bool? autoUpdate,
    Map<String, String>? selectedMap,
    Set<String>? unfoldSet,
    List<ProxyChain>? proxyChains,
    List<ProfileProxy>? profileProxies,
    Map<String, String>? proxyAliases,
    List<ProxyGroup>? customProxyGroups,
    List<Rule>? customRules,
    Value<int?> order = const Value.absent(),
    Value<ProfileType?> profileType = const Value.absent(),
    Value<ProfileOverrides?> overrides = const Value.absent(),
  }) => RawProfile(
    id: id ?? this.id,
    label: label ?? this.label,
    currentGroupName: currentGroupName.present
        ? currentGroupName.value
        : this.currentGroupName,
    url: url ?? this.url,
    ageSecretKey: ageSecretKey.present ? ageSecretKey.value : this.ageSecretKey,
    lastUpdateDate: lastUpdateDate.present
        ? lastUpdateDate.value
        : this.lastUpdateDate,
    lastCheckDate: lastCheckDate.present
        ? lastCheckDate.value
        : this.lastCheckDate,
    overwriteType: overwriteType ?? this.overwriteType,
    scriptId: scriptId.present ? scriptId.value : this.scriptId,
    matchTarget: matchTarget.present ? matchTarget.value : this.matchTarget,
    autoUpdateDurationMillis:
        autoUpdateDurationMillis ?? this.autoUpdateDurationMillis,
    subscriptionInfo: subscriptionInfo.present
        ? subscriptionInfo.value
        : this.subscriptionInfo,
    autoUpdate: autoUpdate ?? this.autoUpdate,
    selectedMap: selectedMap ?? this.selectedMap,
    unfoldSet: unfoldSet ?? this.unfoldSet,
    proxyChains: proxyChains ?? this.proxyChains,
    profileProxies: profileProxies ?? this.profileProxies,
    proxyAliases: proxyAliases ?? this.proxyAliases,
    customProxyGroups: customProxyGroups ?? this.customProxyGroups,
    customRules: customRules ?? this.customRules,
    order: order.present ? order.value : this.order,
    profileType: profileType.present ? profileType.value : this.profileType,
    overrides: overrides.present ? overrides.value : this.overrides,
  );
  RawProfile copyWithCompanion(ProfilesCompanion data) {
    return RawProfile(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      currentGroupName: data.currentGroupName.present
          ? data.currentGroupName.value
          : this.currentGroupName,
      url: data.url.present ? data.url.value : this.url,
      ageSecretKey: data.ageSecretKey.present
          ? data.ageSecretKey.value
          : this.ageSecretKey,
      lastUpdateDate: data.lastUpdateDate.present
          ? data.lastUpdateDate.value
          : this.lastUpdateDate,
      lastCheckDate: data.lastCheckDate.present
          ? data.lastCheckDate.value
          : this.lastCheckDate,
      overwriteType: data.overwriteType.present
          ? data.overwriteType.value
          : this.overwriteType,
      scriptId: data.scriptId.present ? data.scriptId.value : this.scriptId,
      matchTarget: data.matchTarget.present
          ? data.matchTarget.value
          : this.matchTarget,
      autoUpdateDurationMillis: data.autoUpdateDurationMillis.present
          ? data.autoUpdateDurationMillis.value
          : this.autoUpdateDurationMillis,
      subscriptionInfo: data.subscriptionInfo.present
          ? data.subscriptionInfo.value
          : this.subscriptionInfo,
      autoUpdate: data.autoUpdate.present
          ? data.autoUpdate.value
          : this.autoUpdate,
      selectedMap: data.selectedMap.present
          ? data.selectedMap.value
          : this.selectedMap,
      unfoldSet: data.unfoldSet.present ? data.unfoldSet.value : this.unfoldSet,
      proxyChains: data.proxyChains.present
          ? data.proxyChains.value
          : this.proxyChains,
      profileProxies: data.profileProxies.present
          ? data.profileProxies.value
          : this.profileProxies,
      proxyAliases: data.proxyAliases.present
          ? data.proxyAliases.value
          : this.proxyAliases,
      customProxyGroups: data.customProxyGroups.present
          ? data.customProxyGroups.value
          : this.customProxyGroups,
      customRules: data.customRules.present
          ? data.customRules.value
          : this.customRules,
      order: data.order.present ? data.order.value : this.order,
      profileType: data.profileType.present
          ? data.profileType.value
          : this.profileType,
      overrides: data.overrides.present ? data.overrides.value : this.overrides,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawProfile(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('currentGroupName: $currentGroupName, ')
          ..write('url: $url, ')
          ..write('ageSecretKey: $ageSecretKey, ')
          ..write('lastUpdateDate: $lastUpdateDate, ')
          ..write('lastCheckDate: $lastCheckDate, ')
          ..write('overwriteType: $overwriteType, ')
          ..write('scriptId: $scriptId, ')
          ..write('matchTarget: $matchTarget, ')
          ..write('autoUpdateDurationMillis: $autoUpdateDurationMillis, ')
          ..write('subscriptionInfo: $subscriptionInfo, ')
          ..write('autoUpdate: $autoUpdate, ')
          ..write('selectedMap: $selectedMap, ')
          ..write('unfoldSet: $unfoldSet, ')
          ..write('proxyChains: $proxyChains, ')
          ..write('profileProxies: $profileProxies, ')
          ..write('proxyAliases: $proxyAliases, ')
          ..write('customProxyGroups: $customProxyGroups, ')
          ..write('customRules: $customRules, ')
          ..write('order: $order, ')
          ..write('profileType: $profileType, ')
          ..write('overrides: $overrides')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    label,
    currentGroupName,
    url,
    ageSecretKey,
    lastUpdateDate,
    lastCheckDate,
    overwriteType,
    scriptId,
    matchTarget,
    autoUpdateDurationMillis,
    subscriptionInfo,
    autoUpdate,
    selectedMap,
    unfoldSet,
    proxyChains,
    profileProxies,
    proxyAliases,
    customProxyGroups,
    customRules,
    order,
    profileType,
    overrides,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawProfile &&
          other.id == this.id &&
          other.label == this.label &&
          other.currentGroupName == this.currentGroupName &&
          other.url == this.url &&
          other.ageSecretKey == this.ageSecretKey &&
          other.lastUpdateDate == this.lastUpdateDate &&
          other.lastCheckDate == this.lastCheckDate &&
          other.overwriteType == this.overwriteType &&
          other.scriptId == this.scriptId &&
          other.matchTarget == this.matchTarget &&
          other.autoUpdateDurationMillis == this.autoUpdateDurationMillis &&
          other.subscriptionInfo == this.subscriptionInfo &&
          other.autoUpdate == this.autoUpdate &&
          other.selectedMap == this.selectedMap &&
          other.unfoldSet == this.unfoldSet &&
          other.proxyChains == this.proxyChains &&
          other.profileProxies == this.profileProxies &&
          other.proxyAliases == this.proxyAliases &&
          other.customProxyGroups == this.customProxyGroups &&
          other.customRules == this.customRules &&
          other.order == this.order &&
          other.profileType == this.profileType &&
          other.overrides == this.overrides);
}

class ProfilesCompanion extends UpdateCompanion<RawProfile> {
  final Value<int> id;
  final Value<String> label;
  final Value<String?> currentGroupName;
  final Value<String> url;
  final Value<String?> ageSecretKey;
  final Value<DateTime?> lastUpdateDate;
  final Value<DateTime?> lastCheckDate;
  final Value<OverwriteType> overwriteType;
  final Value<int?> scriptId;
  final Value<String?> matchTarget;
  final Value<int> autoUpdateDurationMillis;
  final Value<SubscriptionInfo?> subscriptionInfo;
  final Value<bool> autoUpdate;
  final Value<Map<String, String>> selectedMap;
  final Value<Set<String>> unfoldSet;
  final Value<List<ProxyChain>> proxyChains;
  final Value<List<ProfileProxy>> profileProxies;
  final Value<Map<String, String>> proxyAliases;
  final Value<List<ProxyGroup>> customProxyGroups;
  final Value<List<Rule>> customRules;
  final Value<int?> order;
  final Value<ProfileType?> profileType;
  final Value<ProfileOverrides?> overrides;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.currentGroupName = const Value.absent(),
    this.url = const Value.absent(),
    this.ageSecretKey = const Value.absent(),
    this.lastUpdateDate = const Value.absent(),
    this.lastCheckDate = const Value.absent(),
    this.overwriteType = const Value.absent(),
    this.scriptId = const Value.absent(),
    this.matchTarget = const Value.absent(),
    this.autoUpdateDurationMillis = const Value.absent(),
    this.subscriptionInfo = const Value.absent(),
    this.autoUpdate = const Value.absent(),
    this.selectedMap = const Value.absent(),
    this.unfoldSet = const Value.absent(),
    this.proxyChains = const Value.absent(),
    this.profileProxies = const Value.absent(),
    this.proxyAliases = const Value.absent(),
    this.customProxyGroups = const Value.absent(),
    this.customRules = const Value.absent(),
    this.order = const Value.absent(),
    this.profileType = const Value.absent(),
    this.overrides = const Value.absent(),
  });
  ProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String label,
    this.currentGroupName = const Value.absent(),
    required String url,
    this.ageSecretKey = const Value.absent(),
    this.lastUpdateDate = const Value.absent(),
    this.lastCheckDate = const Value.absent(),
    required OverwriteType overwriteType,
    this.scriptId = const Value.absent(),
    this.matchTarget = const Value.absent(),
    required int autoUpdateDurationMillis,
    this.subscriptionInfo = const Value.absent(),
    required bool autoUpdate,
    required Map<String, String> selectedMap,
    required Set<String> unfoldSet,
    this.proxyChains = const Value.absent(),
    this.profileProxies = const Value.absent(),
    this.proxyAliases = const Value.absent(),
    this.customProxyGroups = const Value.absent(),
    this.customRules = const Value.absent(),
    this.order = const Value.absent(),
    this.profileType = const Value.absent(),
    this.overrides = const Value.absent(),
  }) : label = Value(label),
       url = Value(url),
       overwriteType = Value(overwriteType),
       autoUpdateDurationMillis = Value(autoUpdateDurationMillis),
       autoUpdate = Value(autoUpdate),
       selectedMap = Value(selectedMap),
       unfoldSet = Value(unfoldSet);
  static Insertable<RawProfile> custom({
    Expression<int>? id,
    Expression<String>? label,
    Expression<String>? currentGroupName,
    Expression<String>? url,
    Expression<String>? ageSecretKey,
    Expression<DateTime>? lastUpdateDate,
    Expression<DateTime>? lastCheckDate,
    Expression<String>? overwriteType,
    Expression<int>? scriptId,
    Expression<String>? matchTarget,
    Expression<int>? autoUpdateDurationMillis,
    Expression<String>? subscriptionInfo,
    Expression<bool>? autoUpdate,
    Expression<String>? selectedMap,
    Expression<String>? unfoldSet,
    Expression<String>? proxyChains,
    Expression<String>? profileProxies,
    Expression<String>? proxyAliases,
    Expression<String>? customProxyGroups,
    Expression<String>? customRules,
    Expression<int>? order,
    Expression<String>? profileType,
    Expression<String>? overrides,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (currentGroupName != null) 'current_group_name': currentGroupName,
      if (url != null) 'url': url,
      if (ageSecretKey != null) 'age_secret_key': ageSecretKey,
      if (lastUpdateDate != null) 'last_update_date': lastUpdateDate,
      if (lastCheckDate != null) 'last_check_date': lastCheckDate,
      if (overwriteType != null) 'overwrite_type': overwriteType,
      if (scriptId != null) 'script_id': scriptId,
      if (matchTarget != null) 'match_target': matchTarget,
      if (autoUpdateDurationMillis != null)
        'auto_update_duration_millis': autoUpdateDurationMillis,
      if (subscriptionInfo != null) 'subscription_info': subscriptionInfo,
      if (autoUpdate != null) 'auto_update': autoUpdate,
      if (selectedMap != null) 'selected_map': selectedMap,
      if (unfoldSet != null) 'unfold_set': unfoldSet,
      if (proxyChains != null) 'proxy_chains': proxyChains,
      if (profileProxies != null) 'profile_proxies': profileProxies,
      if (proxyAliases != null) 'proxy_aliases': proxyAliases,
      if (customProxyGroups != null) 'custom_proxy_groups': customProxyGroups,
      if (customRules != null) 'custom_rules': customRules,
      if (order != null) 'order': order,
      if (profileType != null) 'profile_type': profileType,
      if (overrides != null) 'overrides': overrides,
    });
  }

  ProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? label,
    Value<String?>? currentGroupName,
    Value<String>? url,
    Value<String?>? ageSecretKey,
    Value<DateTime?>? lastUpdateDate,
    Value<DateTime?>? lastCheckDate,
    Value<OverwriteType>? overwriteType,
    Value<int?>? scriptId,
    Value<String?>? matchTarget,
    Value<int>? autoUpdateDurationMillis,
    Value<SubscriptionInfo?>? subscriptionInfo,
    Value<bool>? autoUpdate,
    Value<Map<String, String>>? selectedMap,
    Value<Set<String>>? unfoldSet,
    Value<List<ProxyChain>>? proxyChains,
    Value<List<ProfileProxy>>? profileProxies,
    Value<Map<String, String>>? proxyAliases,
    Value<List<ProxyGroup>>? customProxyGroups,
    Value<List<Rule>>? customRules,
    Value<int?>? order,
    Value<ProfileType?>? profileType,
    Value<ProfileOverrides?>? overrides,
  }) {
    return ProfilesCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      currentGroupName: currentGroupName ?? this.currentGroupName,
      url: url ?? this.url,
      ageSecretKey: ageSecretKey ?? this.ageSecretKey,
      lastUpdateDate: lastUpdateDate ?? this.lastUpdateDate,
      lastCheckDate: lastCheckDate ?? this.lastCheckDate,
      overwriteType: overwriteType ?? this.overwriteType,
      scriptId: scriptId ?? this.scriptId,
      matchTarget: matchTarget ?? this.matchTarget,
      autoUpdateDurationMillis:
          autoUpdateDurationMillis ?? this.autoUpdateDurationMillis,
      subscriptionInfo: subscriptionInfo ?? this.subscriptionInfo,
      autoUpdate: autoUpdate ?? this.autoUpdate,
      selectedMap: selectedMap ?? this.selectedMap,
      unfoldSet: unfoldSet ?? this.unfoldSet,
      proxyChains: proxyChains ?? this.proxyChains,
      profileProxies: profileProxies ?? this.profileProxies,
      proxyAliases: proxyAliases ?? this.proxyAliases,
      customProxyGroups: customProxyGroups ?? this.customProxyGroups,
      customRules: customRules ?? this.customRules,
      order: order ?? this.order,
      profileType: profileType ?? this.profileType,
      overrides: overrides ?? this.overrides,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (currentGroupName.present) {
      map['current_group_name'] = Variable<String>(currentGroupName.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (ageSecretKey.present) {
      map['age_secret_key'] = Variable<String>(ageSecretKey.value);
    }
    if (lastUpdateDate.present) {
      map['last_update_date'] = Variable<DateTime>(lastUpdateDate.value);
    }
    if (lastCheckDate.present) {
      map['last_check_date'] = Variable<DateTime>(lastCheckDate.value);
    }
    if (overwriteType.present) {
      map['overwrite_type'] = Variable<String>(
        $ProfilesTable.$converteroverwriteType.toSql(overwriteType.value),
      );
    }
    if (scriptId.present) {
      map['script_id'] = Variable<int>(scriptId.value);
    }
    if (matchTarget.present) {
      map['match_target'] = Variable<String>(matchTarget.value);
    }
    if (autoUpdateDurationMillis.present) {
      map['auto_update_duration_millis'] = Variable<int>(
        autoUpdateDurationMillis.value,
      );
    }
    if (subscriptionInfo.present) {
      map['subscription_info'] = Variable<String>(
        $ProfilesTable.$convertersubscriptionInfo.toSql(subscriptionInfo.value),
      );
    }
    if (autoUpdate.present) {
      map['auto_update'] = Variable<bool>(autoUpdate.value);
    }
    if (selectedMap.present) {
      map['selected_map'] = Variable<String>(
        $ProfilesTable.$converterselectedMap.toSql(selectedMap.value),
      );
    }
    if (unfoldSet.present) {
      map['unfold_set'] = Variable<String>(
        $ProfilesTable.$converterunfoldSet.toSql(unfoldSet.value),
      );
    }
    if (proxyChains.present) {
      map['proxy_chains'] = Variable<String>(
        $ProfilesTable.$converterproxyChains.toSql(proxyChains.value),
      );
    }
    if (profileProxies.present) {
      map['profile_proxies'] = Variable<String>(
        $ProfilesTable.$converterprofileProxies.toSql(profileProxies.value),
      );
    }
    if (proxyAliases.present) {
      map['proxy_aliases'] = Variable<String>(
        $ProfilesTable.$converterproxyAliases.toSql(proxyAliases.value),
      );
    }
    if (customProxyGroups.present) {
      map['custom_proxy_groups'] = Variable<String>(
        $ProfilesTable.$convertercustomProxyGroups.toSql(
          customProxyGroups.value,
        ),
      );
    }
    if (customRules.present) {
      map['custom_rules'] = Variable<String>(
        $ProfilesTable.$convertercustomRules.toSql(customRules.value),
      );
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (profileType.present) {
      map['profile_type'] = Variable<String>(
        $ProfilesTable.$converterprofileTypen.toSql(profileType.value),
      );
    }
    if (overrides.present) {
      map['overrides'] = Variable<String>(
        $ProfilesTable.$converteroverrides.toSql(overrides.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('currentGroupName: $currentGroupName, ')
          ..write('url: $url, ')
          ..write('ageSecretKey: $ageSecretKey, ')
          ..write('lastUpdateDate: $lastUpdateDate, ')
          ..write('lastCheckDate: $lastCheckDate, ')
          ..write('overwriteType: $overwriteType, ')
          ..write('scriptId: $scriptId, ')
          ..write('matchTarget: $matchTarget, ')
          ..write('autoUpdateDurationMillis: $autoUpdateDurationMillis, ')
          ..write('subscriptionInfo: $subscriptionInfo, ')
          ..write('autoUpdate: $autoUpdate, ')
          ..write('selectedMap: $selectedMap, ')
          ..write('unfoldSet: $unfoldSet, ')
          ..write('proxyChains: $proxyChains, ')
          ..write('profileProxies: $profileProxies, ')
          ..write('proxyAliases: $proxyAliases, ')
          ..write('customProxyGroups: $customProxyGroups, ')
          ..write('customRules: $customRules, ')
          ..write('order: $order, ')
          ..write('profileType: $profileType, ')
          ..write('overrides: $overrides')
          ..write(')'))
        .toString();
  }
}

class $ScriptsTable extends Scripts with TableInfo<$ScriptsTable, RawScript> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScriptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUpdateTimeMeta = const VerificationMeta(
    'lastUpdateTime',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdateTime =
      GeneratedColumn<DateTime>(
        'last_update_time',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, label, lastUpdateTime, url, order];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scripts';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawScript> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('last_update_time')) {
      context.handle(
        _lastUpdateTimeMeta,
        lastUpdateTime.isAcceptableOrUnknown(
          data['last_update_time']!,
          _lastUpdateTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUpdateTimeMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawScript map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawScript(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      lastUpdateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_update_time'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      ),
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      ),
    );
  }

  @override
  $ScriptsTable createAlias(String alias) {
    return $ScriptsTable(attachedDatabase, alias);
  }
}

class RawScript extends DataClass implements Insertable<RawScript> {
  final int id;
  final String label;
  final DateTime lastUpdateTime;
  final String? url;
  final int? order;
  const RawScript({
    required this.id,
    required this.label,
    required this.lastUpdateTime,
    this.url,
    this.order,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['label'] = Variable<String>(label);
    map['last_update_time'] = Variable<DateTime>(lastUpdateTime);
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || order != null) {
      map['order'] = Variable<int>(order);
    }
    return map;
  }

  ScriptsCompanion toCompanion(bool nullToAbsent) {
    return ScriptsCompanion(
      id: Value(id),
      label: Value(label),
      lastUpdateTime: Value(lastUpdateTime),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      order: order == null && nullToAbsent
          ? const Value.absent()
          : Value(order),
    );
  }

  factory RawScript.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawScript(
      id: serializer.fromJson<int>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      lastUpdateTime: serializer.fromJson<DateTime>(json['lastUpdateTime']),
      url: serializer.fromJson<String?>(json['url']),
      order: serializer.fromJson<int?>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'label': serializer.toJson<String>(label),
      'lastUpdateTime': serializer.toJson<DateTime>(lastUpdateTime),
      'url': serializer.toJson<String?>(url),
      'order': serializer.toJson<int?>(order),
    };
  }

  RawScript copyWith({
    int? id,
    String? label,
    DateTime? lastUpdateTime,
    Value<String?> url = const Value.absent(),
    Value<int?> order = const Value.absent(),
  }) => RawScript(
    id: id ?? this.id,
    label: label ?? this.label,
    lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
    url: url.present ? url.value : this.url,
    order: order.present ? order.value : this.order,
  );
  RawScript copyWithCompanion(ScriptsCompanion data) {
    return RawScript(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      lastUpdateTime: data.lastUpdateTime.present
          ? data.lastUpdateTime.value
          : this.lastUpdateTime,
      url: data.url.present ? data.url.value : this.url,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawScript(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('lastUpdateTime: $lastUpdateTime, ')
          ..write('url: $url, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, label, lastUpdateTime, url, order);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawScript &&
          other.id == this.id &&
          other.label == this.label &&
          other.lastUpdateTime == this.lastUpdateTime &&
          other.url == this.url &&
          other.order == this.order);
}

class ScriptsCompanion extends UpdateCompanion<RawScript> {
  final Value<int> id;
  final Value<String> label;
  final Value<DateTime> lastUpdateTime;
  final Value<String?> url;
  final Value<int?> order;
  const ScriptsCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
    this.url = const Value.absent(),
    this.order = const Value.absent(),
  });
  ScriptsCompanion.insert({
    this.id = const Value.absent(),
    required String label,
    required DateTime lastUpdateTime,
    this.url = const Value.absent(),
    this.order = const Value.absent(),
  }) : label = Value(label),
       lastUpdateTime = Value(lastUpdateTime);
  static Insertable<RawScript> custom({
    Expression<int>? id,
    Expression<String>? label,
    Expression<DateTime>? lastUpdateTime,
    Expression<String>? url,
    Expression<int>? order,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (lastUpdateTime != null) 'last_update_time': lastUpdateTime,
      if (url != null) 'url': url,
      if (order != null) 'order': order,
    });
  }

  ScriptsCompanion copyWith({
    Value<int>? id,
    Value<String>? label,
    Value<DateTime>? lastUpdateTime,
    Value<String?>? url,
    Value<int?>? order,
  }) {
    return ScriptsCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      url: url ?? this.url,
      order: order ?? this.order,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (lastUpdateTime.present) {
      map['last_update_time'] = Variable<DateTime>(lastUpdateTime.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScriptsCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('lastUpdateTime: $lastUpdateTime, ')
          ..write('url: $url, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }
}

class $RulesTable extends Rules with TableInfo<$RulesTable, RawRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<RuleAction?, String> ruleAction =
      GeneratedColumn<String>(
        'rule_action',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<RuleAction?>($RulesTable.$converterruleActionn);
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ruleTargetMeta = const VerificationMeta(
    'ruleTarget',
  );
  @override
  late final GeneratedColumn<String> ruleTarget = GeneratedColumn<String>(
    'rule_target',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ruleProviderMeta = const VerificationMeta(
    'ruleProvider',
  );
  @override
  late final GeneratedColumn<String> ruleProvider = GeneratedColumn<String>(
    'rule_provider',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subRuleMeta = const VerificationMeta(
    'subRule',
  );
  @override
  late final GeneratedColumn<String> subRule = GeneratedColumn<String>(
    'sub_rule',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noResolveMeta = const VerificationMeta(
    'noResolve',
  );
  @override
  late final GeneratedColumn<bool> noResolve = GeneratedColumn<bool>(
    'no_resolve',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("no_resolve" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _srcMeta = const VerificationMeta('src');
  @override
  late final GeneratedColumn<bool> src = GeneratedColumn<bool>(
    'src',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("src" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    value,
    ruleAction,
    content,
    ruleTarget,
    ruleProvider,
    subRule,
    noResolve,
    src,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawRule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    }
    if (data.containsKey('rule_target')) {
      context.handle(
        _ruleTargetMeta,
        ruleTarget.isAcceptableOrUnknown(data['rule_target']!, _ruleTargetMeta),
      );
    }
    if (data.containsKey('rule_provider')) {
      context.handle(
        _ruleProviderMeta,
        ruleProvider.isAcceptableOrUnknown(
          data['rule_provider']!,
          _ruleProviderMeta,
        ),
      );
    }
    if (data.containsKey('sub_rule')) {
      context.handle(
        _subRuleMeta,
        subRule.isAcceptableOrUnknown(data['sub_rule']!, _subRuleMeta),
      );
    }
    if (data.containsKey('no_resolve')) {
      context.handle(
        _noResolveMeta,
        noResolve.isAcceptableOrUnknown(data['no_resolve']!, _noResolveMeta),
      );
    }
    if (data.containsKey('src')) {
      context.handle(
        _srcMeta,
        src.isAcceptableOrUnknown(data['src']!, _srcMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawRule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      ruleAction: $RulesTable.$converterruleActionn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}rule_action'],
        ),
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      ),
      ruleTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_target'],
      ),
      ruleProvider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_provider'],
      ),
      subRule: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sub_rule'],
      ),
      noResolve: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}no_resolve'],
      )!,
      src: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}src'],
      )!,
    );
  }

  @override
  $RulesTable createAlias(String alias) {
    return $RulesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RuleAction, String, String> $converterruleAction =
      const EnumNameConverter<RuleAction>(RuleAction.values);
  static JsonTypeConverter2<RuleAction?, String?, String?>
  $converterruleActionn = JsonTypeConverter2.asNullable($converterruleAction);
}

class RawRule extends DataClass implements Insertable<RawRule> {
  final int id;
  final String value;
  final RuleAction? ruleAction;
  final String? content;
  final String? ruleTarget;
  final String? ruleProvider;
  final String? subRule;
  final bool noResolve;
  final bool src;
  const RawRule({
    required this.id,
    required this.value,
    this.ruleAction,
    this.content,
    this.ruleTarget,
    this.ruleProvider,
    this.subRule,
    required this.noResolve,
    required this.src,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['value'] = Variable<String>(value);
    if (!nullToAbsent || ruleAction != null) {
      map['rule_action'] = Variable<String>(
        $RulesTable.$converterruleActionn.toSql(ruleAction),
      );
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || ruleTarget != null) {
      map['rule_target'] = Variable<String>(ruleTarget);
    }
    if (!nullToAbsent || ruleProvider != null) {
      map['rule_provider'] = Variable<String>(ruleProvider);
    }
    if (!nullToAbsent || subRule != null) {
      map['sub_rule'] = Variable<String>(subRule);
    }
    map['no_resolve'] = Variable<bool>(noResolve);
    map['src'] = Variable<bool>(src);
    return map;
  }

  RulesCompanion toCompanion(bool nullToAbsent) {
    return RulesCompanion(
      id: Value(id),
      value: Value(value),
      ruleAction: ruleAction == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleAction),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      ruleTarget: ruleTarget == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleTarget),
      ruleProvider: ruleProvider == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleProvider),
      subRule: subRule == null && nullToAbsent
          ? const Value.absent()
          : Value(subRule),
      noResolve: Value(noResolve),
      src: Value(src),
    );
  }

  factory RawRule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawRule(
      id: serializer.fromJson<int>(json['id']),
      value: serializer.fromJson<String>(json['value']),
      ruleAction: $RulesTable.$converterruleActionn.fromJson(
        serializer.fromJson<String?>(json['ruleAction']),
      ),
      content: serializer.fromJson<String?>(json['content']),
      ruleTarget: serializer.fromJson<String?>(json['ruleTarget']),
      ruleProvider: serializer.fromJson<String?>(json['ruleProvider']),
      subRule: serializer.fromJson<String?>(json['subRule']),
      noResolve: serializer.fromJson<bool>(json['noResolve']),
      src: serializer.fromJson<bool>(json['src']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'value': serializer.toJson<String>(value),
      'ruleAction': serializer.toJson<String?>(
        $RulesTable.$converterruleActionn.toJson(ruleAction),
      ),
      'content': serializer.toJson<String?>(content),
      'ruleTarget': serializer.toJson<String?>(ruleTarget),
      'ruleProvider': serializer.toJson<String?>(ruleProvider),
      'subRule': serializer.toJson<String?>(subRule),
      'noResolve': serializer.toJson<bool>(noResolve),
      'src': serializer.toJson<bool>(src),
    };
  }

  RawRule copyWith({
    int? id,
    String? value,
    Value<RuleAction?> ruleAction = const Value.absent(),
    Value<String?> content = const Value.absent(),
    Value<String?> ruleTarget = const Value.absent(),
    Value<String?> ruleProvider = const Value.absent(),
    Value<String?> subRule = const Value.absent(),
    bool? noResolve,
    bool? src,
  }) => RawRule(
    id: id ?? this.id,
    value: value ?? this.value,
    ruleAction: ruleAction.present ? ruleAction.value : this.ruleAction,
    content: content.present ? content.value : this.content,
    ruleTarget: ruleTarget.present ? ruleTarget.value : this.ruleTarget,
    ruleProvider: ruleProvider.present ? ruleProvider.value : this.ruleProvider,
    subRule: subRule.present ? subRule.value : this.subRule,
    noResolve: noResolve ?? this.noResolve,
    src: src ?? this.src,
  );
  RawRule copyWithCompanion(RulesCompanion data) {
    return RawRule(
      id: data.id.present ? data.id.value : this.id,
      value: data.value.present ? data.value.value : this.value,
      ruleAction: data.ruleAction.present
          ? data.ruleAction.value
          : this.ruleAction,
      content: data.content.present ? data.content.value : this.content,
      ruleTarget: data.ruleTarget.present
          ? data.ruleTarget.value
          : this.ruleTarget,
      ruleProvider: data.ruleProvider.present
          ? data.ruleProvider.value
          : this.ruleProvider,
      subRule: data.subRule.present ? data.subRule.value : this.subRule,
      noResolve: data.noResolve.present ? data.noResolve.value : this.noResolve,
      src: data.src.present ? data.src.value : this.src,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawRule(')
          ..write('id: $id, ')
          ..write('value: $value, ')
          ..write('ruleAction: $ruleAction, ')
          ..write('content: $content, ')
          ..write('ruleTarget: $ruleTarget, ')
          ..write('ruleProvider: $ruleProvider, ')
          ..write('subRule: $subRule, ')
          ..write('noResolve: $noResolve, ')
          ..write('src: $src')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    value,
    ruleAction,
    content,
    ruleTarget,
    ruleProvider,
    subRule,
    noResolve,
    src,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawRule &&
          other.id == this.id &&
          other.value == this.value &&
          other.ruleAction == this.ruleAction &&
          other.content == this.content &&
          other.ruleTarget == this.ruleTarget &&
          other.ruleProvider == this.ruleProvider &&
          other.subRule == this.subRule &&
          other.noResolve == this.noResolve &&
          other.src == this.src);
}

class RulesCompanion extends UpdateCompanion<RawRule> {
  final Value<int> id;
  final Value<String> value;
  final Value<RuleAction?> ruleAction;
  final Value<String?> content;
  final Value<String?> ruleTarget;
  final Value<String?> ruleProvider;
  final Value<String?> subRule;
  final Value<bool> noResolve;
  final Value<bool> src;
  const RulesCompanion({
    this.id = const Value.absent(),
    this.value = const Value.absent(),
    this.ruleAction = const Value.absent(),
    this.content = const Value.absent(),
    this.ruleTarget = const Value.absent(),
    this.ruleProvider = const Value.absent(),
    this.subRule = const Value.absent(),
    this.noResolve = const Value.absent(),
    this.src = const Value.absent(),
  });
  RulesCompanion.insert({
    this.id = const Value.absent(),
    required String value,
    this.ruleAction = const Value.absent(),
    this.content = const Value.absent(),
    this.ruleTarget = const Value.absent(),
    this.ruleProvider = const Value.absent(),
    this.subRule = const Value.absent(),
    this.noResolve = const Value.absent(),
    this.src = const Value.absent(),
  }) : value = Value(value);
  static Insertable<RawRule> custom({
    Expression<int>? id,
    Expression<String>? value,
    Expression<String>? ruleAction,
    Expression<String>? content,
    Expression<String>? ruleTarget,
    Expression<String>? ruleProvider,
    Expression<String>? subRule,
    Expression<bool>? noResolve,
    Expression<bool>? src,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (value != null) 'value': value,
      if (ruleAction != null) 'rule_action': ruleAction,
      if (content != null) 'content': content,
      if (ruleTarget != null) 'rule_target': ruleTarget,
      if (ruleProvider != null) 'rule_provider': ruleProvider,
      if (subRule != null) 'sub_rule': subRule,
      if (noResolve != null) 'no_resolve': noResolve,
      if (src != null) 'src': src,
    });
  }

  RulesCompanion copyWith({
    Value<int>? id,
    Value<String>? value,
    Value<RuleAction?>? ruleAction,
    Value<String?>? content,
    Value<String?>? ruleTarget,
    Value<String?>? ruleProvider,
    Value<String?>? subRule,
    Value<bool>? noResolve,
    Value<bool>? src,
  }) {
    return RulesCompanion(
      id: id ?? this.id,
      value: value ?? this.value,
      ruleAction: ruleAction ?? this.ruleAction,
      content: content ?? this.content,
      ruleTarget: ruleTarget ?? this.ruleTarget,
      ruleProvider: ruleProvider ?? this.ruleProvider,
      subRule: subRule ?? this.subRule,
      noResolve: noResolve ?? this.noResolve,
      src: src ?? this.src,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (ruleAction.present) {
      map['rule_action'] = Variable<String>(
        $RulesTable.$converterruleActionn.toSql(ruleAction.value),
      );
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (ruleTarget.present) {
      map['rule_target'] = Variable<String>(ruleTarget.value);
    }
    if (ruleProvider.present) {
      map['rule_provider'] = Variable<String>(ruleProvider.value);
    }
    if (subRule.present) {
      map['sub_rule'] = Variable<String>(subRule.value);
    }
    if (noResolve.present) {
      map['no_resolve'] = Variable<bool>(noResolve.value);
    }
    if (src.present) {
      map['src'] = Variable<bool>(src.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RulesCompanion(')
          ..write('id: $id, ')
          ..write('value: $value, ')
          ..write('ruleAction: $ruleAction, ')
          ..write('content: $content, ')
          ..write('ruleTarget: $ruleTarget, ')
          ..write('ruleProvider: $ruleProvider, ')
          ..write('subRule: $subRule, ')
          ..write('noResolve: $noResolve, ')
          ..write('src: $src')
          ..write(')'))
        .toString();
  }
}

class $ProfileRuleLinksTable extends ProfileRuleLinks
    with TableInfo<$ProfileRuleLinksTable, RawProfileRuleLink> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileRuleLinksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<int> profileId = GeneratedColumn<int>(
    'profile_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ruleIdMeta = const VerificationMeta('ruleId');
  @override
  late final GeneratedColumn<int> ruleId = GeneratedColumn<int>(
    'rule_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES rules (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<RuleScene?, String> scene =
      GeneratedColumn<String>(
        'scene',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<RuleScene?>($ProfileRuleLinksTable.$converterscenen);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<String> order = GeneratedColumn<String>(
    'order',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, profileId, ruleId, scene, order];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_rule_mapping';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawProfileRuleLink> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    }
    if (data.containsKey('rule_id')) {
      context.handle(
        _ruleIdMeta,
        ruleId.isAcceptableOrUnknown(data['rule_id']!, _ruleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ruleIdMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawProfileRuleLink map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawProfileRuleLink(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profile_id'],
      ),
      ruleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rule_id'],
      )!,
      scene: $ProfileRuleLinksTable.$converterscenen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}scene'],
        ),
      ),
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order'],
      ),
    );
  }

  @override
  $ProfileRuleLinksTable createAlias(String alias) {
    return $ProfileRuleLinksTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RuleScene, String, String> $converterscene =
      const EnumNameConverter<RuleScene>(RuleScene.values);
  static JsonTypeConverter2<RuleScene?, String?, String?> $converterscenen =
      JsonTypeConverter2.asNullable($converterscene);
}

class RawProfileRuleLink extends DataClass
    implements Insertable<RawProfileRuleLink> {
  final String id;
  final int? profileId;
  final int ruleId;
  final RuleScene? scene;
  final String? order;
  const RawProfileRuleLink({
    required this.id,
    this.profileId,
    required this.ruleId,
    this.scene,
    this.order,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || profileId != null) {
      map['profile_id'] = Variable<int>(profileId);
    }
    map['rule_id'] = Variable<int>(ruleId);
    if (!nullToAbsent || scene != null) {
      map['scene'] = Variable<String>(
        $ProfileRuleLinksTable.$converterscenen.toSql(scene),
      );
    }
    if (!nullToAbsent || order != null) {
      map['order'] = Variable<String>(order);
    }
    return map;
  }

  ProfileRuleLinksCompanion toCompanion(bool nullToAbsent) {
    return ProfileRuleLinksCompanion(
      id: Value(id),
      profileId: profileId == null && nullToAbsent
          ? const Value.absent()
          : Value(profileId),
      ruleId: Value(ruleId),
      scene: scene == null && nullToAbsent
          ? const Value.absent()
          : Value(scene),
      order: order == null && nullToAbsent
          ? const Value.absent()
          : Value(order),
    );
  }

  factory RawProfileRuleLink.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawProfileRuleLink(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<int?>(json['profileId']),
      ruleId: serializer.fromJson<int>(json['ruleId']),
      scene: $ProfileRuleLinksTable.$converterscenen.fromJson(
        serializer.fromJson<String?>(json['scene']),
      ),
      order: serializer.fromJson<String?>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<int?>(profileId),
      'ruleId': serializer.toJson<int>(ruleId),
      'scene': serializer.toJson<String?>(
        $ProfileRuleLinksTable.$converterscenen.toJson(scene),
      ),
      'order': serializer.toJson<String?>(order),
    };
  }

  RawProfileRuleLink copyWith({
    String? id,
    Value<int?> profileId = const Value.absent(),
    int? ruleId,
    Value<RuleScene?> scene = const Value.absent(),
    Value<String?> order = const Value.absent(),
  }) => RawProfileRuleLink(
    id: id ?? this.id,
    profileId: profileId.present ? profileId.value : this.profileId,
    ruleId: ruleId ?? this.ruleId,
    scene: scene.present ? scene.value : this.scene,
    order: order.present ? order.value : this.order,
  );
  RawProfileRuleLink copyWithCompanion(ProfileRuleLinksCompanion data) {
    return RawProfileRuleLink(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      ruleId: data.ruleId.present ? data.ruleId.value : this.ruleId,
      scene: data.scene.present ? data.scene.value : this.scene,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawProfileRuleLink(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('ruleId: $ruleId, ')
          ..write('scene: $scene, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, profileId, ruleId, scene, order);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawProfileRuleLink &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.ruleId == this.ruleId &&
          other.scene == this.scene &&
          other.order == this.order);
}

class ProfileRuleLinksCompanion extends UpdateCompanion<RawProfileRuleLink> {
  final Value<String> id;
  final Value<int?> profileId;
  final Value<int> ruleId;
  final Value<RuleScene?> scene;
  final Value<String?> order;
  final Value<int> rowid;
  const ProfileRuleLinksCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.ruleId = const Value.absent(),
    this.scene = const Value.absent(),
    this.order = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfileRuleLinksCompanion.insert({
    required String id,
    this.profileId = const Value.absent(),
    required int ruleId,
    this.scene = const Value.absent(),
    this.order = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ruleId = Value(ruleId);
  static Insertable<RawProfileRuleLink> custom({
    Expression<String>? id,
    Expression<int>? profileId,
    Expression<int>? ruleId,
    Expression<String>? scene,
    Expression<String>? order,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (ruleId != null) 'rule_id': ruleId,
      if (scene != null) 'scene': scene,
      if (order != null) 'order': order,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfileRuleLinksCompanion copyWith({
    Value<String>? id,
    Value<int?>? profileId,
    Value<int>? ruleId,
    Value<RuleScene?>? scene,
    Value<String?>? order,
    Value<int>? rowid,
  }) {
    return ProfileRuleLinksCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      ruleId: ruleId ?? this.ruleId,
      scene: scene ?? this.scene,
      order: order ?? this.order,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<int>(profileId.value);
    }
    if (ruleId.present) {
      map['rule_id'] = Variable<int>(ruleId.value);
    }
    if (scene.present) {
      map['scene'] = Variable<String>(
        $ProfileRuleLinksTable.$converterscenen.toSql(scene.value),
      );
    }
    if (order.present) {
      map['order'] = Variable<String>(order.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileRuleLinksCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('ruleId: $ruleId, ')
          ..write('scene: $scene, ')
          ..write('order: $order, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IconRecordsTable extends IconRecords
    with TableInfo<$IconRecordsTable, IconRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IconRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastAccessedMeta = const VerificationMeta(
    'lastAccessed',
  );
  @override
  late final GeneratedColumn<int> lastAccessed = GeneratedColumn<int>(
    'last_accessed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [url, lastAccessed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'icon_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<IconRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('last_accessed')) {
      context.handle(
        _lastAccessedMeta,
        lastAccessed.isAcceptableOrUnknown(
          data['last_accessed']!,
          _lastAccessedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastAccessedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {url};
  @override
  IconRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IconRecord(
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      lastAccessed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_accessed'],
      )!,
    );
  }

  @override
  $IconRecordsTable createAlias(String alias) {
    return $IconRecordsTable(attachedDatabase, alias);
  }
}

class IconRecord extends DataClass implements Insertable<IconRecord> {
  final String url;
  final int lastAccessed;
  const IconRecord({required this.url, required this.lastAccessed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['url'] = Variable<String>(url);
    map['last_accessed'] = Variable<int>(lastAccessed);
    return map;
  }

  IconRecordsCompanion toCompanion(bool nullToAbsent) {
    return IconRecordsCompanion(
      url: Value(url),
      lastAccessed: Value(lastAccessed),
    );
  }

  factory IconRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IconRecord(
      url: serializer.fromJson<String>(json['url']),
      lastAccessed: serializer.fromJson<int>(json['lastAccessed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'url': serializer.toJson<String>(url),
      'lastAccessed': serializer.toJson<int>(lastAccessed),
    };
  }

  IconRecord copyWith({String? url, int? lastAccessed}) => IconRecord(
    url: url ?? this.url,
    lastAccessed: lastAccessed ?? this.lastAccessed,
  );
  IconRecord copyWithCompanion(IconRecordsCompanion data) {
    return IconRecord(
      url: data.url.present ? data.url.value : this.url,
      lastAccessed: data.lastAccessed.present
          ? data.lastAccessed.value
          : this.lastAccessed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IconRecord(')
          ..write('url: $url, ')
          ..write('lastAccessed: $lastAccessed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(url, lastAccessed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IconRecord &&
          other.url == this.url &&
          other.lastAccessed == this.lastAccessed);
}

class IconRecordsCompanion extends UpdateCompanion<IconRecord> {
  final Value<String> url;
  final Value<int> lastAccessed;
  final Value<int> rowid;
  const IconRecordsCompanion({
    this.url = const Value.absent(),
    this.lastAccessed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IconRecordsCompanion.insert({
    required String url,
    required int lastAccessed,
    this.rowid = const Value.absent(),
  }) : url = Value(url),
       lastAccessed = Value(lastAccessed);
  static Insertable<IconRecord> custom({
    Expression<String>? url,
    Expression<int>? lastAccessed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (url != null) 'url': url,
      if (lastAccessed != null) 'last_accessed': lastAccessed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IconRecordsCompanion copyWith({
    Value<String>? url,
    Value<int>? lastAccessed,
    Value<int>? rowid,
  }) {
    return IconRecordsCompanion(
      url: url ?? this.url,
      lastAccessed: lastAccessed ?? this.lastAccessed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (lastAccessed.present) {
      map['last_accessed'] = Variable<int>(lastAccessed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IconRecordsCompanion(')
          ..write('url: $url, ')
          ..write('lastAccessed: $lastAccessed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClashProvidersTable extends ClashProviders
    with TableInfo<$ClashProvidersTable, RawClashProvider> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClashProvidersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ProviderKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ProviderKind>($ClashProvidersTable.$converterkind);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  late final GeneratedColumnWithTypeConverter<RuleProviderBehavior, String>
  behavior =
      GeneratedColumn<String>(
        'behavior',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<RuleProviderBehavior>(
        $ClashProvidersTable.$converterbehavior,
      );
  @override
  late final GeneratedColumnWithTypeConverter<RuleProviderFormat, String>
  format = GeneratedColumn<String>(
    'format',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<RuleProviderFormat>($ClashProvidersTable.$converterformat);
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<Uint8List> content = GeneratedColumn<Uint8List>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    kind,
    label,
    url,
    behavior,
    format,
    content,
    order,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clash_providers';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawClashProvider> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {kind, label},
  ];
  @override
  RawClashProvider map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawClashProvider(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      kind: $ClashProvidersTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      behavior: $ClashProvidersTable.$converterbehavior.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}behavior'],
        )!,
      ),
      format: $ClashProvidersTable.$converterformat.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}format'],
        )!,
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}content'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
    );
  }

  @override
  $ClashProvidersTable createAlias(String alias) {
    return $ClashProvidersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ProviderKind, String, String> $converterkind =
      const EnumNameConverter<ProviderKind>(ProviderKind.values);
  static JsonTypeConverter2<RuleProviderBehavior, String, String>
  $converterbehavior = const EnumNameConverter<RuleProviderBehavior>(
    RuleProviderBehavior.values,
  );
  static JsonTypeConverter2<RuleProviderFormat, String, String>
  $converterformat = const EnumNameConverter<RuleProviderFormat>(
    RuleProviderFormat.values,
  );
}

class RawClashProvider extends DataClass
    implements Insertable<RawClashProvider> {
  final int id;
  final ProviderKind kind;
  final String label;
  final String url;
  final RuleProviderBehavior behavior;
  final RuleProviderFormat format;
  final Uint8List content;
  final int order;
  const RawClashProvider({
    required this.id,
    required this.kind,
    required this.label,
    required this.url,
    required this.behavior,
    required this.format,
    required this.content,
    required this.order,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['kind'] = Variable<String>(
        $ClashProvidersTable.$converterkind.toSql(kind),
      );
    }
    map['label'] = Variable<String>(label);
    map['url'] = Variable<String>(url);
    {
      map['behavior'] = Variable<String>(
        $ClashProvidersTable.$converterbehavior.toSql(behavior),
      );
    }
    {
      map['format'] = Variable<String>(
        $ClashProvidersTable.$converterformat.toSql(format),
      );
    }
    map['content'] = Variable<Uint8List>(content);
    map['order'] = Variable<int>(order);
    return map;
  }

  ClashProvidersCompanion toCompanion(bool nullToAbsent) {
    return ClashProvidersCompanion(
      id: Value(id),
      kind: Value(kind),
      label: Value(label),
      url: Value(url),
      behavior: Value(behavior),
      format: Value(format),
      content: Value(content),
      order: Value(order),
    );
  }

  factory RawClashProvider.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawClashProvider(
      id: serializer.fromJson<int>(json['id']),
      kind: $ClashProvidersTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      label: serializer.fromJson<String>(json['label']),
      url: serializer.fromJson<String>(json['url']),
      behavior: $ClashProvidersTable.$converterbehavior.fromJson(
        serializer.fromJson<String>(json['behavior']),
      ),
      format: $ClashProvidersTable.$converterformat.fromJson(
        serializer.fromJson<String>(json['format']),
      ),
      content: serializer.fromJson<Uint8List>(json['content']),
      order: serializer.fromJson<int>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kind': serializer.toJson<String>(
        $ClashProvidersTable.$converterkind.toJson(kind),
      ),
      'label': serializer.toJson<String>(label),
      'url': serializer.toJson<String>(url),
      'behavior': serializer.toJson<String>(
        $ClashProvidersTable.$converterbehavior.toJson(behavior),
      ),
      'format': serializer.toJson<String>(
        $ClashProvidersTable.$converterformat.toJson(format),
      ),
      'content': serializer.toJson<Uint8List>(content),
      'order': serializer.toJson<int>(order),
    };
  }

  RawClashProvider copyWith({
    int? id,
    ProviderKind? kind,
    String? label,
    String? url,
    RuleProviderBehavior? behavior,
    RuleProviderFormat? format,
    Uint8List? content,
    int? order,
  }) => RawClashProvider(
    id: id ?? this.id,
    kind: kind ?? this.kind,
    label: label ?? this.label,
    url: url ?? this.url,
    behavior: behavior ?? this.behavior,
    format: format ?? this.format,
    content: content ?? this.content,
    order: order ?? this.order,
  );
  RawClashProvider copyWithCompanion(ClashProvidersCompanion data) {
    return RawClashProvider(
      id: data.id.present ? data.id.value : this.id,
      kind: data.kind.present ? data.kind.value : this.kind,
      label: data.label.present ? data.label.value : this.label,
      url: data.url.present ? data.url.value : this.url,
      behavior: data.behavior.present ? data.behavior.value : this.behavior,
      format: data.format.present ? data.format.value : this.format,
      content: data.content.present ? data.content.value : this.content,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawClashProvider(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('label: $label, ')
          ..write('url: $url, ')
          ..write('behavior: $behavior, ')
          ..write('format: $format, ')
          ..write('content: $content, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    kind,
    label,
    url,
    behavior,
    format,
    $driftBlobEquality.hash(content),
    order,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawClashProvider &&
          other.id == this.id &&
          other.kind == this.kind &&
          other.label == this.label &&
          other.url == this.url &&
          other.behavior == this.behavior &&
          other.format == this.format &&
          $driftBlobEquality.equals(other.content, this.content) &&
          other.order == this.order);
}

class ClashProvidersCompanion extends UpdateCompanion<RawClashProvider> {
  final Value<int> id;
  final Value<ProviderKind> kind;
  final Value<String> label;
  final Value<String> url;
  final Value<RuleProviderBehavior> behavior;
  final Value<RuleProviderFormat> format;
  final Value<Uint8List> content;
  final Value<int> order;
  const ClashProvidersCompanion({
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
    this.label = const Value.absent(),
    this.url = const Value.absent(),
    this.behavior = const Value.absent(),
    this.format = const Value.absent(),
    this.content = const Value.absent(),
    this.order = const Value.absent(),
  });
  ClashProvidersCompanion.insert({
    this.id = const Value.absent(),
    required ProviderKind kind,
    required String label,
    this.url = const Value.absent(),
    required RuleProviderBehavior behavior,
    required RuleProviderFormat format,
    required Uint8List content,
    required int order,
  }) : kind = Value(kind),
       label = Value(label),
       behavior = Value(behavior),
       format = Value(format),
       content = Value(content),
       order = Value(order);
  static Insertable<RawClashProvider> custom({
    Expression<int>? id,
    Expression<String>? kind,
    Expression<String>? label,
    Expression<String>? url,
    Expression<String>? behavior,
    Expression<String>? format,
    Expression<Uint8List>? content,
    Expression<int>? order,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kind != null) 'kind': kind,
      if (label != null) 'label': label,
      if (url != null) 'url': url,
      if (behavior != null) 'behavior': behavior,
      if (format != null) 'format': format,
      if (content != null) 'content': content,
      if (order != null) 'order': order,
    });
  }

  ClashProvidersCompanion copyWith({
    Value<int>? id,
    Value<ProviderKind>? kind,
    Value<String>? label,
    Value<String>? url,
    Value<RuleProviderBehavior>? behavior,
    Value<RuleProviderFormat>? format,
    Value<Uint8List>? content,
    Value<int>? order,
  }) {
    return ClashProvidersCompanion(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      label: label ?? this.label,
      url: url ?? this.url,
      behavior: behavior ?? this.behavior,
      format: format ?? this.format,
      content: content ?? this.content,
      order: order ?? this.order,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $ClashProvidersTable.$converterkind.toSql(kind.value),
      );
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (behavior.present) {
      map['behavior'] = Variable<String>(
        $ClashProvidersTable.$converterbehavior.toSql(behavior.value),
      );
    }
    if (format.present) {
      map['format'] = Variable<String>(
        $ClashProvidersTable.$converterformat.toSql(format.value),
      );
    }
    if (content.present) {
      map['content'] = Variable<Uint8List>(content.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClashProvidersCompanion(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('label: $label, ')
          ..write('url: $url, ')
          ..write('behavior: $behavior, ')
          ..write('format: $format, ')
          ..write('content: $content, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }
}

class $IconSetsTable extends IconSets
    with TableInfo<$IconSetsTable, RawIconSet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IconSetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<IconSetIcon>, String> icons =
      GeneratedColumn<String>(
        'icons',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<IconSetIcon>>($IconSetsTable.$convertericons);
  static const VerificationMeta _lastUpdateTimeMeta = const VerificationMeta(
    'lastUpdateTime',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdateTime =
      GeneratedColumn<DateTime>(
        'last_update_time',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    url,
    icons,
    lastUpdateTime,
    order,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'icon_sets';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawIconSet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('last_update_time')) {
      context.handle(
        _lastUpdateTimeMeta,
        lastUpdateTime.isAcceptableOrUnknown(
          data['last_update_time']!,
          _lastUpdateTimeMeta,
        ),
      );
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawIconSet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawIconSet(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      icons: $IconSetsTable.$convertericons.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}icons'],
        )!,
      ),
      lastUpdateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_update_time'],
      ),
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      ),
    );
  }

  @override
  $IconSetsTable createAlias(String alias) {
    return $IconSetsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<IconSetIcon>, String> $convertericons =
      const IconSetIconsConverter();
}

class RawIconSet extends DataClass implements Insertable<RawIconSet> {
  final int id;
  final String name;
  final String url;
  final List<IconSetIcon> icons;
  final DateTime? lastUpdateTime;
  final int? order;
  const RawIconSet({
    required this.id,
    required this.name,
    required this.url,
    required this.icons,
    this.lastUpdateTime,
    this.order,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['url'] = Variable<String>(url);
    {
      map['icons'] = Variable<String>(
        $IconSetsTable.$convertericons.toSql(icons),
      );
    }
    if (!nullToAbsent || lastUpdateTime != null) {
      map['last_update_time'] = Variable<DateTime>(lastUpdateTime);
    }
    if (!nullToAbsent || order != null) {
      map['order'] = Variable<int>(order);
    }
    return map;
  }

  IconSetsCompanion toCompanion(bool nullToAbsent) {
    return IconSetsCompanion(
      id: Value(id),
      name: Value(name),
      url: Value(url),
      icons: Value(icons),
      lastUpdateTime: lastUpdateTime == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdateTime),
      order: order == null && nullToAbsent
          ? const Value.absent()
          : Value(order),
    );
  }

  factory RawIconSet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawIconSet(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      url: serializer.fromJson<String>(json['url']),
      icons: serializer.fromJson<List<IconSetIcon>>(json['icons']),
      lastUpdateTime: serializer.fromJson<DateTime?>(json['lastUpdateTime']),
      order: serializer.fromJson<int?>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'url': serializer.toJson<String>(url),
      'icons': serializer.toJson<List<IconSetIcon>>(icons),
      'lastUpdateTime': serializer.toJson<DateTime?>(lastUpdateTime),
      'order': serializer.toJson<int?>(order),
    };
  }

  RawIconSet copyWith({
    int? id,
    String? name,
    String? url,
    List<IconSetIcon>? icons,
    Value<DateTime?> lastUpdateTime = const Value.absent(),
    Value<int?> order = const Value.absent(),
  }) => RawIconSet(
    id: id ?? this.id,
    name: name ?? this.name,
    url: url ?? this.url,
    icons: icons ?? this.icons,
    lastUpdateTime: lastUpdateTime.present
        ? lastUpdateTime.value
        : this.lastUpdateTime,
    order: order.present ? order.value : this.order,
  );
  RawIconSet copyWithCompanion(IconSetsCompanion data) {
    return RawIconSet(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      url: data.url.present ? data.url.value : this.url,
      icons: data.icons.present ? data.icons.value : this.icons,
      lastUpdateTime: data.lastUpdateTime.present
          ? data.lastUpdateTime.value
          : this.lastUpdateTime,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawIconSet(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('url: $url, ')
          ..write('icons: $icons, ')
          ..write('lastUpdateTime: $lastUpdateTime, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, url, icons, lastUpdateTime, order);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawIconSet &&
          other.id == this.id &&
          other.name == this.name &&
          other.url == this.url &&
          other.icons == this.icons &&
          other.lastUpdateTime == this.lastUpdateTime &&
          other.order == this.order);
}

class IconSetsCompanion extends UpdateCompanion<RawIconSet> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> url;
  final Value<List<IconSetIcon>> icons;
  final Value<DateTime?> lastUpdateTime;
  final Value<int?> order;
  const IconSetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.url = const Value.absent(),
    this.icons = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
    this.order = const Value.absent(),
  });
  IconSetsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String url,
    required List<IconSetIcon> icons,
    this.lastUpdateTime = const Value.absent(),
    this.order = const Value.absent(),
  }) : name = Value(name),
       url = Value(url),
       icons = Value(icons);
  static Insertable<RawIconSet> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? url,
    Expression<String>? icons,
    Expression<DateTime>? lastUpdateTime,
    Expression<int>? order,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (url != null) 'url': url,
      if (icons != null) 'icons': icons,
      if (lastUpdateTime != null) 'last_update_time': lastUpdateTime,
      if (order != null) 'order': order,
    });
  }

  IconSetsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? url,
    Value<List<IconSetIcon>>? icons,
    Value<DateTime?>? lastUpdateTime,
    Value<int?>? order,
  }) {
    return IconSetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      icons: icons ?? this.icons,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      order: order ?? this.order,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (icons.present) {
      map['icons'] = Variable<String>(
        $IconSetsTable.$convertericons.toSql(icons.value),
      );
    }
    if (lastUpdateTime.present) {
      map['last_update_time'] = Variable<DateTime>(lastUpdateTime.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IconSetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('url: $url, ')
          ..write('icons: $icons, ')
          ..write('lastUpdateTime: $lastUpdateTime, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }
}

class $MitmModulesTable extends MitmModules
    with TableInfo<$MitmModulesTable, RawMitmModule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MitmModulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, String>, String>
  arguments = GeneratedColumn<String>(
    'arguments',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  ).withConverter<Map<String, String>>($MitmModulesTable.$converterarguments);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, String>, String>
  resources = GeneratedColumn<String>(
    'resources',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  ).withConverter<Map<String, String>>($MitmModulesTable.$converterresources);
  static const VerificationMeta _systemMeta = const VerificationMeta('system');
  @override
  late final GeneratedColumn<String> system = GeneratedColumn<String>(
    'system',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scriptsMeta = const VerificationMeta(
    'scripts',
  );
  @override
  late final GeneratedColumn<int> scripts = GeneratedColumn<int>(
    'scripts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastUpdateTimeMeta = const VerificationMeta(
    'lastUpdateTime',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdateTime =
      GeneratedColumn<DateTime>(
        'last_update_time',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    url,
    enabled,
    order,
    arguments,
    resources,
    system,
    scripts,
    lastUpdateTime,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mitm_modules';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawMitmModule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    if (data.containsKey('system')) {
      context.handle(
        _systemMeta,
        system.isAcceptableOrUnknown(data['system']!, _systemMeta),
      );
    }
    if (data.containsKey('scripts')) {
      context.handle(
        _scriptsMeta,
        scripts.isAcceptableOrUnknown(data['scripts']!, _scriptsMeta),
      );
    }
    if (data.containsKey('last_update_time')) {
      context.handle(
        _lastUpdateTimeMeta,
        lastUpdateTime.isAcceptableOrUnknown(
          data['last_update_time']!,
          _lastUpdateTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUpdateTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawMitmModule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawMitmModule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      ),
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      ),
      arguments: $MitmModulesTable.$converterarguments.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}arguments'],
        )!,
      ),
      resources: $MitmModulesTable.$converterresources.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}resources'],
        )!,
      ),
      system: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}system'],
      ),
      scripts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}scripts'],
      )!,
      lastUpdateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_update_time'],
      )!,
    );
  }

  @override
  $MitmModulesTable createAlias(String alias) {
    return $MitmModulesTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, String>, String> $converterarguments =
      const StringMapConverter();
  static TypeConverter<Map<String, String>, String> $converterresources =
      const StringMapConverter();
}

class RawMitmModule extends DataClass implements Insertable<RawMitmModule> {
  final int id;
  final String name;
  final String description;
  final String? url;
  final bool enabled;
  final int? order;
  final Map<String, String> arguments;
  final Map<String, String> resources;
  final String? system;
  final int scripts;
  final DateTime lastUpdateTime;
  const RawMitmModule({
    required this.id,
    required this.name,
    required this.description,
    this.url,
    required this.enabled,
    this.order,
    required this.arguments,
    required this.resources,
    this.system,
    required this.scripts,
    required this.lastUpdateTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    map['enabled'] = Variable<bool>(enabled);
    if (!nullToAbsent || order != null) {
      map['order'] = Variable<int>(order);
    }
    {
      map['arguments'] = Variable<String>(
        $MitmModulesTable.$converterarguments.toSql(arguments),
      );
    }
    {
      map['resources'] = Variable<String>(
        $MitmModulesTable.$converterresources.toSql(resources),
      );
    }
    if (!nullToAbsent || system != null) {
      map['system'] = Variable<String>(system);
    }
    map['scripts'] = Variable<int>(scripts);
    map['last_update_time'] = Variable<DateTime>(lastUpdateTime);
    return map;
  }

  MitmModulesCompanion toCompanion(bool nullToAbsent) {
    return MitmModulesCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      enabled: Value(enabled),
      order: order == null && nullToAbsent
          ? const Value.absent()
          : Value(order),
      arguments: Value(arguments),
      resources: Value(resources),
      system: system == null && nullToAbsent
          ? const Value.absent()
          : Value(system),
      scripts: Value(scripts),
      lastUpdateTime: Value(lastUpdateTime),
    );
  }

  factory RawMitmModule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawMitmModule(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      url: serializer.fromJson<String?>(json['url']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      order: serializer.fromJson<int?>(json['order']),
      arguments: serializer.fromJson<Map<String, String>>(json['arguments']),
      resources: serializer.fromJson<Map<String, String>>(json['resources']),
      system: serializer.fromJson<String?>(json['system']),
      scripts: serializer.fromJson<int>(json['scripts']),
      lastUpdateTime: serializer.fromJson<DateTime>(json['lastUpdateTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'url': serializer.toJson<String?>(url),
      'enabled': serializer.toJson<bool>(enabled),
      'order': serializer.toJson<int?>(order),
      'arguments': serializer.toJson<Map<String, String>>(arguments),
      'resources': serializer.toJson<Map<String, String>>(resources),
      'system': serializer.toJson<String?>(system),
      'scripts': serializer.toJson<int>(scripts),
      'lastUpdateTime': serializer.toJson<DateTime>(lastUpdateTime),
    };
  }

  RawMitmModule copyWith({
    int? id,
    String? name,
    String? description,
    Value<String?> url = const Value.absent(),
    bool? enabled,
    Value<int?> order = const Value.absent(),
    Map<String, String>? arguments,
    Map<String, String>? resources,
    Value<String?> system = const Value.absent(),
    int? scripts,
    DateTime? lastUpdateTime,
  }) => RawMitmModule(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    url: url.present ? url.value : this.url,
    enabled: enabled ?? this.enabled,
    order: order.present ? order.value : this.order,
    arguments: arguments ?? this.arguments,
    resources: resources ?? this.resources,
    system: system.present ? system.value : this.system,
    scripts: scripts ?? this.scripts,
    lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
  );
  RawMitmModule copyWithCompanion(MitmModulesCompanion data) {
    return RawMitmModule(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      url: data.url.present ? data.url.value : this.url,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      order: data.order.present ? data.order.value : this.order,
      arguments: data.arguments.present ? data.arguments.value : this.arguments,
      resources: data.resources.present ? data.resources.value : this.resources,
      system: data.system.present ? data.system.value : this.system,
      scripts: data.scripts.present ? data.scripts.value : this.scripts,
      lastUpdateTime: data.lastUpdateTime.present
          ? data.lastUpdateTime.value
          : this.lastUpdateTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawMitmModule(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('url: $url, ')
          ..write('enabled: $enabled, ')
          ..write('order: $order, ')
          ..write('arguments: $arguments, ')
          ..write('resources: $resources, ')
          ..write('system: $system, ')
          ..write('scripts: $scripts, ')
          ..write('lastUpdateTime: $lastUpdateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    url,
    enabled,
    order,
    arguments,
    resources,
    system,
    scripts,
    lastUpdateTime,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawMitmModule &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.url == this.url &&
          other.enabled == this.enabled &&
          other.order == this.order &&
          other.arguments == this.arguments &&
          other.resources == this.resources &&
          other.system == this.system &&
          other.scripts == this.scripts &&
          other.lastUpdateTime == this.lastUpdateTime);
}

class MitmModulesCompanion extends UpdateCompanion<RawMitmModule> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String?> url;
  final Value<bool> enabled;
  final Value<int?> order;
  final Value<Map<String, String>> arguments;
  final Value<Map<String, String>> resources;
  final Value<String?> system;
  final Value<int> scripts;
  final Value<DateTime> lastUpdateTime;
  const MitmModulesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.url = const Value.absent(),
    this.enabled = const Value.absent(),
    this.order = const Value.absent(),
    this.arguments = const Value.absent(),
    this.resources = const Value.absent(),
    this.system = const Value.absent(),
    this.scripts = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
  });
  MitmModulesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.url = const Value.absent(),
    this.enabled = const Value.absent(),
    this.order = const Value.absent(),
    this.arguments = const Value.absent(),
    this.resources = const Value.absent(),
    this.system = const Value.absent(),
    this.scripts = const Value.absent(),
    required DateTime lastUpdateTime,
  }) : name = Value(name),
       lastUpdateTime = Value(lastUpdateTime);
  static Insertable<RawMitmModule> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? url,
    Expression<bool>? enabled,
    Expression<int>? order,
    Expression<String>? arguments,
    Expression<String>? resources,
    Expression<String>? system,
    Expression<int>? scripts,
    Expression<DateTime>? lastUpdateTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (url != null) 'url': url,
      if (enabled != null) 'enabled': enabled,
      if (order != null) 'order': order,
      if (arguments != null) 'arguments': arguments,
      if (resources != null) 'resources': resources,
      if (system != null) 'system': system,
      if (scripts != null) 'scripts': scripts,
      if (lastUpdateTime != null) 'last_update_time': lastUpdateTime,
    });
  }

  MitmModulesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? description,
    Value<String?>? url,
    Value<bool>? enabled,
    Value<int?>? order,
    Value<Map<String, String>>? arguments,
    Value<Map<String, String>>? resources,
    Value<String?>? system,
    Value<int>? scripts,
    Value<DateTime>? lastUpdateTime,
  }) {
    return MitmModulesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      url: url ?? this.url,
      enabled: enabled ?? this.enabled,
      order: order ?? this.order,
      arguments: arguments ?? this.arguments,
      resources: resources ?? this.resources,
      system: system ?? this.system,
      scripts: scripts ?? this.scripts,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (arguments.present) {
      map['arguments'] = Variable<String>(
        $MitmModulesTable.$converterarguments.toSql(arguments.value),
      );
    }
    if (resources.present) {
      map['resources'] = Variable<String>(
        $MitmModulesTable.$converterresources.toSql(resources.value),
      );
    }
    if (system.present) {
      map['system'] = Variable<String>(system.value);
    }
    if (scripts.present) {
      map['scripts'] = Variable<int>(scripts.value);
    }
    if (lastUpdateTime.present) {
      map['last_update_time'] = Variable<DateTime>(lastUpdateTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MitmModulesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('url: $url, ')
          ..write('enabled: $enabled, ')
          ..write('order: $order, ')
          ..write('arguments: $arguments, ')
          ..write('resources: $resources, ')
          ..write('system: $system, ')
          ..write('scripts: $scripts, ')
          ..write('lastUpdateTime: $lastUpdateTime')
          ..write(')'))
        .toString();
  }
}

class $CustomProxiesTable extends CustomProxies
    with TableInfo<$CustomProxiesTable, RawCustomProxy> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomProxiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, Object?>, String>
  definition =
      GeneratedColumn<String>(
        'definition',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Map<String, Object?>>(
        $CustomProxiesTable.$converterdefinition,
      );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _uriMeta = const VerificationMeta('uri');
  @override
  late final GeneratedColumn<String> uri = GeneratedColumn<String>(
    'uri',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Set<String>, String>
  emptyOptions = GeneratedColumn<String>(
    'empty_options',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<Set<String>>($CustomProxiesTable.$converteremptyOptions);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    definition,
    enabled,
    uri,
    emptyOptions,
    order,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'custom_proxies';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawCustomProxy> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('uri')) {
      context.handle(
        _uriMeta,
        uri.isAcceptableOrUnknown(data['uri']!, _uriMeta),
      );
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawCustomProxy map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawCustomProxy(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      definition: $CustomProxiesTable.$converterdefinition.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}definition'],
        )!,
      ),
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      uri: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uri'],
      )!,
      emptyOptions: $CustomProxiesTable.$converteremptyOptions.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}empty_options'],
        )!,
      ),
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
    );
  }

  @override
  $CustomProxiesTable createAlias(String alias) {
    return $CustomProxiesTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, Object?>, String> $converterdefinition =
      const JsonMapConverter();
  static TypeConverter<Set<String>, String> $converteremptyOptions =
      const StringSetConverter();
}

class RawCustomProxy extends DataClass implements Insertable<RawCustomProxy> {
  final int id;
  final Map<String, Object?> definition;
  final bool enabled;
  final String uri;
  final Set<String> emptyOptions;
  final int order;
  const RawCustomProxy({
    required this.id,
    required this.definition,
    required this.enabled,
    required this.uri,
    required this.emptyOptions,
    required this.order,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['definition'] = Variable<String>(
        $CustomProxiesTable.$converterdefinition.toSql(definition),
      );
    }
    map['enabled'] = Variable<bool>(enabled);
    map['uri'] = Variable<String>(uri);
    {
      map['empty_options'] = Variable<String>(
        $CustomProxiesTable.$converteremptyOptions.toSql(emptyOptions),
      );
    }
    map['order'] = Variable<int>(order);
    return map;
  }

  CustomProxiesCompanion toCompanion(bool nullToAbsent) {
    return CustomProxiesCompanion(
      id: Value(id),
      definition: Value(definition),
      enabled: Value(enabled),
      uri: Value(uri),
      emptyOptions: Value(emptyOptions),
      order: Value(order),
    );
  }

  factory RawCustomProxy.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawCustomProxy(
      id: serializer.fromJson<int>(json['id']),
      definition: serializer.fromJson<Map<String, Object?>>(json['definition']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      uri: serializer.fromJson<String>(json['uri']),
      emptyOptions: serializer.fromJson<Set<String>>(json['emptyOptions']),
      order: serializer.fromJson<int>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'definition': serializer.toJson<Map<String, Object?>>(definition),
      'enabled': serializer.toJson<bool>(enabled),
      'uri': serializer.toJson<String>(uri),
      'emptyOptions': serializer.toJson<Set<String>>(emptyOptions),
      'order': serializer.toJson<int>(order),
    };
  }

  RawCustomProxy copyWith({
    int? id,
    Map<String, Object?>? definition,
    bool? enabled,
    String? uri,
    Set<String>? emptyOptions,
    int? order,
  }) => RawCustomProxy(
    id: id ?? this.id,
    definition: definition ?? this.definition,
    enabled: enabled ?? this.enabled,
    uri: uri ?? this.uri,
    emptyOptions: emptyOptions ?? this.emptyOptions,
    order: order ?? this.order,
  );
  RawCustomProxy copyWithCompanion(CustomProxiesCompanion data) {
    return RawCustomProxy(
      id: data.id.present ? data.id.value : this.id,
      definition: data.definition.present
          ? data.definition.value
          : this.definition,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      uri: data.uri.present ? data.uri.value : this.uri,
      emptyOptions: data.emptyOptions.present
          ? data.emptyOptions.value
          : this.emptyOptions,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawCustomProxy(')
          ..write('id: $id, ')
          ..write('definition: $definition, ')
          ..write('enabled: $enabled, ')
          ..write('uri: $uri, ')
          ..write('emptyOptions: $emptyOptions, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, definition, enabled, uri, emptyOptions, order);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawCustomProxy &&
          other.id == this.id &&
          other.definition == this.definition &&
          other.enabled == this.enabled &&
          other.uri == this.uri &&
          other.emptyOptions == this.emptyOptions &&
          other.order == this.order);
}

class CustomProxiesCompanion extends UpdateCompanion<RawCustomProxy> {
  final Value<int> id;
  final Value<Map<String, Object?>> definition;
  final Value<bool> enabled;
  final Value<String> uri;
  final Value<Set<String>> emptyOptions;
  final Value<int> order;
  const CustomProxiesCompanion({
    this.id = const Value.absent(),
    this.definition = const Value.absent(),
    this.enabled = const Value.absent(),
    this.uri = const Value.absent(),
    this.emptyOptions = const Value.absent(),
    this.order = const Value.absent(),
  });
  CustomProxiesCompanion.insert({
    this.id = const Value.absent(),
    required Map<String, Object?> definition,
    this.enabled = const Value.absent(),
    this.uri = const Value.absent(),
    required Set<String> emptyOptions,
    required int order,
  }) : definition = Value(definition),
       emptyOptions = Value(emptyOptions),
       order = Value(order);
  static Insertable<RawCustomProxy> custom({
    Expression<int>? id,
    Expression<String>? definition,
    Expression<bool>? enabled,
    Expression<String>? uri,
    Expression<String>? emptyOptions,
    Expression<int>? order,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (definition != null) 'definition': definition,
      if (enabled != null) 'enabled': enabled,
      if (uri != null) 'uri': uri,
      if (emptyOptions != null) 'empty_options': emptyOptions,
      if (order != null) 'order': order,
    });
  }

  CustomProxiesCompanion copyWith({
    Value<int>? id,
    Value<Map<String, Object?>>? definition,
    Value<bool>? enabled,
    Value<String>? uri,
    Value<Set<String>>? emptyOptions,
    Value<int>? order,
  }) {
    return CustomProxiesCompanion(
      id: id ?? this.id,
      definition: definition ?? this.definition,
      enabled: enabled ?? this.enabled,
      uri: uri ?? this.uri,
      emptyOptions: emptyOptions ?? this.emptyOptions,
      order: order ?? this.order,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (definition.present) {
      map['definition'] = Variable<String>(
        $CustomProxiesTable.$converterdefinition.toSql(definition.value),
      );
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (uri.present) {
      map['uri'] = Variable<String>(uri.value);
    }
    if (emptyOptions.present) {
      map['empty_options'] = Variable<String>(
        $CustomProxiesTable.$converteremptyOptions.toSql(emptyOptions.value),
      );
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomProxiesCompanion(')
          ..write('id: $id, ')
          ..write('definition: $definition, ')
          ..write('enabled: $enabled, ')
          ..write('uri: $uri, ')
          ..write('emptyOptions: $emptyOptions, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $ScriptsTable scripts = $ScriptsTable(this);
  late final $RulesTable rules = $RulesTable(this);
  late final $ProfileRuleLinksTable profileRuleLinks = $ProfileRuleLinksTable(
    this,
  );
  late final $IconRecordsTable iconRecords = $IconRecordsTable(this);
  late final $ClashProvidersTable clashProviders = $ClashProvidersTable(this);
  late final $IconSetsTable iconSets = $IconSetsTable(this);
  late final $MitmModulesTable mitmModules = $MitmModulesTable(this);
  late final $CustomProxiesTable customProxies = $CustomProxiesTable(this);
  late final Index idxRuleTarget = Index(
    'idx_rule_target',
    'CREATE INDEX idx_rule_target ON rules (rule_target)',
  );
  late final Index idxProfileSceneOrder = Index(
    'idx_profile_scene_order',
    'CREATE INDEX idx_profile_scene_order ON profile_rule_mapping (profile_id, scene, "order")',
  );
  late final Index lastAccessedUrl = Index(
    'last_accessed_url',
    'CREATE INDEX last_accessed_url ON icon_records (last_accessed, url)',
  );
  late final ProfilesDao profilesDao = ProfilesDao(this as Database);
  late final ScriptsDao scriptsDao = ScriptsDao(this as Database);
  late final RulesDao rulesDao = RulesDao(this as Database);
  late final IconRecordsDao iconRecordsDao = IconRecordsDao(this as Database);
  late final ClashProvidersDao clashProvidersDao = ClashProvidersDao(
    this as Database,
  );
  late final IconSetsDao iconSetsDao = IconSetsDao(this as Database);
  late final MitmModulesDao mitmModulesDao = MitmModulesDao(this as Database);
  late final CustomProxiesDao customProxiesDao = CustomProxiesDao(
    this as Database,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    profiles,
    scripts,
    rules,
    profileRuleLinks,
    iconRecords,
    clashProviders,
    iconSets,
    mitmModules,
    customProxies,
    idxRuleTarget,
    idxProfileSceneOrder,
    lastAccessedUrl,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('profile_rule_mapping', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'rules',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('profile_rule_mapping', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ProfilesTableCreateCompanionBuilder = ProfilesCompanion Function({
  Value<int> id,
  required String label,
  Value<String?> currentGroupName,
  required String url,
  Value<String?> ageSecretKey,
  Value<DateTime?> lastUpdateDate,
  Value<DateTime?> lastCheckDate,
  required OverwriteType overwriteType,
  Value<int?> scriptId,
  Value<String?> matchTarget,
  required int autoUpdateDurationMillis,
  Value<SubscriptionInfo?> subscriptionInfo,
  required bool autoUpdate,
  required Map<String, String> selectedMap,
  required Set<String> unfoldSet,
  Value<List<ProxyChain>> proxyChains,
  Value<List<ProfileProxy>> profileProxies,
  Value<Map<String, String>> proxyAliases,
  Value<List<ProxyGroup>> customProxyGroups,
  Value<List<Rule>> customRules,
  Value<int?> order,
  Value<ProfileType?> profileType,
  Value<ProfileOverrides?> overrides,
});
typedef $$ProfilesTableUpdateCompanionBuilder = ProfilesCompanion Function({
  Value<int> id,
  Value<String> label,
  Value<String?> currentGroupName,
  Value<String> url,
  Value<String?> ageSecretKey,
  Value<DateTime?> lastUpdateDate,
  Value<DateTime?> lastCheckDate,
  Value<OverwriteType> overwriteType,
  Value<int?> scriptId,
  Value<String?> matchTarget,
  Value<int> autoUpdateDurationMillis,
  Value<SubscriptionInfo?> subscriptionInfo,
  Value<bool> autoUpdate,
  Value<Map<String, String>> selectedMap,
  Value<Set<String>> unfoldSet,
  Value<List<ProxyChain>> proxyChains,
  Value<List<ProfileProxy>> profileProxies,
  Value<Map<String, String>> proxyAliases,
  Value<List<ProxyGroup>> customProxyGroups,
  Value<List<Rule>> customRules,
  Value<int?> order,
  Value<ProfileType?> profileType,
  Value<ProfileOverrides?> overrides,
});

final class $$ProfilesTableReferences
    extends BaseReferences<_$Database, $ProfilesTable, RawProfile> {
  $$ProfilesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProfileRuleLinksTable, List<RawProfileRuleLink>>
  _profileRuleLinksRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.profileRuleLinks,
    aliasName: 'profiles__id__profile_rule_mapping__profile_id',
  );

  $$ProfileRuleLinksTableProcessedTableManager get profileRuleLinksRefs {
    final manager = $$ProfileRuleLinksTableTableManager(
      $_db,
      $_db.profileRuleLinks,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _profileRuleLinksRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProfilesTableFilterComposer
    extends Composer<_$Database, $ProfilesTable> {
  $$ProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentGroupName => $composableBuilder(
    column: $table.currentGroupName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ageSecretKey => $composableBuilder(
    column: $table.ageSecretKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdateDate => $composableBuilder(
    column: $table.lastUpdateDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastCheckDate => $composableBuilder(
    column: $table.lastCheckDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<OverwriteType, OverwriteType, String>
  get overwriteType => $composableBuilder(
    column: $table.overwriteType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get scriptId => $composableBuilder(
    column: $table.scriptId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get matchTarget => $composableBuilder(
    column: $table.matchTarget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get autoUpdateDurationMillis => $composableBuilder(
    column: $table.autoUpdateDurationMillis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SubscriptionInfo?, SubscriptionInfo, String>
  get subscriptionInfo => $composableBuilder(
    column: $table.subscriptionInfo,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get autoUpdate => $composableBuilder(
    column: $table.autoUpdate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, String>,
    Map<String, String>,
    String
  >
  get selectedMap => $composableBuilder(
    column: $table.selectedMap,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<Set<String>, Set<String>, String>
  get unfoldSet => $composableBuilder(
    column: $table.unfoldSet,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<ProxyChain>, List<ProxyChain>, String>
  get proxyChains => $composableBuilder(
    column: $table.proxyChains,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<ProfileProxy>, List<ProfileProxy>, String>
  get profileProxies => $composableBuilder(
    column: $table.profileProxies,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, String>,
    Map<String, String>,
    String
  >
  get proxyAliases => $composableBuilder(
    column: $table.proxyAliases,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<ProxyGroup>, List<ProxyGroup>, String>
  get customProxyGroups => $composableBuilder(
    column: $table.customProxyGroups,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<Rule>, List<Rule>, String>
  get customRules => $composableBuilder(
    column: $table.customRules,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ProfileType?, ProfileType, String>
  get profileType => $composableBuilder(
    column: $table.profileType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<ProfileOverrides?, ProfileOverrides, String>
  get overrides => $composableBuilder(
    column: $table.overrides,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  Expression<bool> profileRuleLinksRefs(
    Expression<bool> Function($$ProfileRuleLinksTableFilterComposer f) f,
  ) {
    final $$ProfileRuleLinksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.profileRuleLinks,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileRuleLinksTableFilterComposer(
            $db: $db,
            $table: $db.profileRuleLinks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProfilesTableOrderingComposer
    extends Composer<_$Database, $ProfilesTable> {
  $$ProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentGroupName => $composableBuilder(
    column: $table.currentGroupName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ageSecretKey => $composableBuilder(
    column: $table.ageSecretKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdateDate => $composableBuilder(
    column: $table.lastUpdateDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastCheckDate => $composableBuilder(
    column: $table.lastCheckDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overwriteType => $composableBuilder(
    column: $table.overwriteType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scriptId => $composableBuilder(
    column: $table.scriptId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get matchTarget => $composableBuilder(
    column: $table.matchTarget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get autoUpdateDurationMillis => $composableBuilder(
    column: $table.autoUpdateDurationMillis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subscriptionInfo => $composableBuilder(
    column: $table.subscriptionInfo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get autoUpdate => $composableBuilder(
    column: $table.autoUpdate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selectedMap => $composableBuilder(
    column: $table.selectedMap,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unfoldSet => $composableBuilder(
    column: $table.unfoldSet,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proxyChains => $composableBuilder(
    column: $table.proxyChains,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profileProxies => $composableBuilder(
    column: $table.profileProxies,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proxyAliases => $composableBuilder(
    column: $table.proxyAliases,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customProxyGroups => $composableBuilder(
    column: $table.customProxyGroups,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customRules => $composableBuilder(
    column: $table.customRules,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profileType => $composableBuilder(
    column: $table.profileType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overrides => $composableBuilder(
    column: $table.overrides,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfilesTableAnnotationComposer
    extends Composer<_$Database, $ProfilesTable> {
  $$ProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get currentGroupName => $composableBuilder(
    column: $table.currentGroupName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get ageSecretKey => $composableBuilder(
    column: $table.ageSecretKey,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUpdateDate => $composableBuilder(
    column: $table.lastUpdateDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastCheckDate => $composableBuilder(
    column: $table.lastCheckDate,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<OverwriteType, String> get overwriteType =>
      $composableBuilder(
        column: $table.overwriteType,
        builder: (column) => column,
      );

  GeneratedColumn<int> get scriptId =>
      $composableBuilder(column: $table.scriptId, builder: (column) => column);

  GeneratedColumn<String> get matchTarget => $composableBuilder(
    column: $table.matchTarget,
    builder: (column) => column,
  );

  GeneratedColumn<int> get autoUpdateDurationMillis => $composableBuilder(
    column: $table.autoUpdateDurationMillis,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SubscriptionInfo?, String>
  get subscriptionInfo => $composableBuilder(
    column: $table.subscriptionInfo,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get autoUpdate => $composableBuilder(
    column: $table.autoUpdate,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Map<String, String>, String>
  get selectedMap => $composableBuilder(
    column: $table.selectedMap,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Set<String>, String> get unfoldSet =>
      $composableBuilder(column: $table.unfoldSet, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<ProxyChain>, String> get proxyChains =>
      $composableBuilder(
        column: $table.proxyChains,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<List<ProfileProxy>, String>
  get profileProxies => $composableBuilder(
    column: $table.profileProxies,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Map<String, String>, String>
  get proxyAliases => $composableBuilder(
    column: $table.proxyAliases,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<ProxyGroup>, String>
  get customProxyGroups => $composableBuilder(
    column: $table.customProxyGroups,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<Rule>, String> get customRules =>
      $composableBuilder(
        column: $table.customRules,
        builder: (column) => column,
      );

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ProfileType?, String> get profileType =>
      $composableBuilder(
        column: $table.profileType,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<ProfileOverrides?, String> get overrides =>
      $composableBuilder(column: $table.overrides, builder: (column) => column);

  Expression<T> profileRuleLinksRefs<T extends Object>(
    Expression<T> Function($$ProfileRuleLinksTableAnnotationComposer a) f,
  ) {
    final $$ProfileRuleLinksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.profileRuleLinks,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileRuleLinksTableAnnotationComposer(
            $db: $db,
            $table: $db.profileRuleLinks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProfilesTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ProfilesTable,
          RawProfile,
          $$ProfilesTableFilterComposer,
          $$ProfilesTableOrderingComposer,
          $$ProfilesTableAnnotationComposer,
          $$ProfilesTableCreateCompanionBuilder,
          $$ProfilesTableUpdateCompanionBuilder,
          (RawProfile, $$ProfilesTableReferences),
          RawProfile,
          PrefetchHooks Function({bool profileRuleLinksRefs})
        > {
  $$ProfilesTableTableManager(_$Database db, $ProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String?> currentGroupName = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<String?> ageSecretKey = const Value.absent(),
                Value<DateTime?> lastUpdateDate = const Value.absent(),
                Value<DateTime?> lastCheckDate = const Value.absent(),
                Value<OverwriteType> overwriteType = const Value.absent(),
                Value<int?> scriptId = const Value.absent(),
                Value<String?> matchTarget = const Value.absent(),
                Value<int> autoUpdateDurationMillis = const Value.absent(),
                Value<SubscriptionInfo?> subscriptionInfo =
                    const Value.absent(),
                Value<bool> autoUpdate = const Value.absent(),
                Value<Map<String, String>> selectedMap = const Value.absent(),
                Value<Set<String>> unfoldSet = const Value.absent(),
                Value<List<ProxyChain>> proxyChains = const Value.absent(),
                Value<List<ProfileProxy>> profileProxies = const Value.absent(),
                Value<Map<String, String>> proxyAliases = const Value.absent(),
                Value<List<ProxyGroup>> customProxyGroups =
                    const Value.absent(),
                Value<List<Rule>> customRules = const Value.absent(),
                Value<int?> order = const Value.absent(),
                Value<ProfileType?> profileType = const Value.absent(),
                Value<ProfileOverrides?> overrides = const Value.absent(),
              }) => ProfilesCompanion(
                id: id,
                label: label,
                currentGroupName: currentGroupName,
                url: url,
                ageSecretKey: ageSecretKey,
                lastUpdateDate: lastUpdateDate,
                lastCheckDate: lastCheckDate,
                overwriteType: overwriteType,
                scriptId: scriptId,
                matchTarget: matchTarget,
                autoUpdateDurationMillis: autoUpdateDurationMillis,
                subscriptionInfo: subscriptionInfo,
                autoUpdate: autoUpdate,
                selectedMap: selectedMap,
                unfoldSet: unfoldSet,
                proxyChains: proxyChains,
                profileProxies: profileProxies,
                proxyAliases: proxyAliases,
                customProxyGroups: customProxyGroups,
                customRules: customRules,
                order: order,
                profileType: profileType,
                overrides: overrides,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String label,
                Value<String?> currentGroupName = const Value.absent(),
                required String url,
                Value<String?> ageSecretKey = const Value.absent(),
                Value<DateTime?> lastUpdateDate = const Value.absent(),
                Value<DateTime?> lastCheckDate = const Value.absent(),
                required OverwriteType overwriteType,
                Value<int?> scriptId = const Value.absent(),
                Value<String?> matchTarget = const Value.absent(),
                required int autoUpdateDurationMillis,
                Value<SubscriptionInfo?> subscriptionInfo =
                    const Value.absent(),
                required bool autoUpdate,
                required Map<String, String> selectedMap,
                required Set<String> unfoldSet,
                Value<List<ProxyChain>> proxyChains = const Value.absent(),
                Value<List<ProfileProxy>> profileProxies = const Value.absent(),
                Value<Map<String, String>> proxyAliases = const Value.absent(),
                Value<List<ProxyGroup>> customProxyGroups =
                    const Value.absent(),
                Value<List<Rule>> customRules = const Value.absent(),
                Value<int?> order = const Value.absent(),
                Value<ProfileType?> profileType = const Value.absent(),
                Value<ProfileOverrides?> overrides = const Value.absent(),
              }) => ProfilesCompanion.insert(
                id: id,
                label: label,
                currentGroupName: currentGroupName,
                url: url,
                ageSecretKey: ageSecretKey,
                lastUpdateDate: lastUpdateDate,
                lastCheckDate: lastCheckDate,
                overwriteType: overwriteType,
                scriptId: scriptId,
                matchTarget: matchTarget,
                autoUpdateDurationMillis: autoUpdateDurationMillis,
                subscriptionInfo: subscriptionInfo,
                autoUpdate: autoUpdate,
                selectedMap: selectedMap,
                unfoldSet: unfoldSet,
                proxyChains: proxyChains,
                profileProxies: profileProxies,
                proxyAliases: proxyAliases,
                customProxyGroups: customProxyGroups,
                customRules: customRules,
                order: order,
                profileType: profileType,
                overrides: overrides,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProfilesTable, RawProfile>(table),
                  $$ProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileRuleLinksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (profileRuleLinksRefs) db.profileRuleLinks,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (profileRuleLinksRefs)
                    await $_getPrefetchedDataByColumns<
                      RawProfile,
                      $ProfilesTable,
                      RawProfileRuleLink,
                      $ProfileRuleLinksTable
                    >(
                      currentTable: table,
                      referencedTable: $$ProfilesTableReferences
                          ._profileRuleLinksRefsTable(db),
                      managerFromTypedResult: (p0) => $$ProfilesTableReferences(
                        db,
                        table,
                        p0,
                      ).profileRuleLinksRefs,
                      currentColumn: 'id',
                      referencedColumn: 'profile_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ProfilesTable,
      RawProfile,
      $$ProfilesTableFilterComposer,
      $$ProfilesTableOrderingComposer,
      $$ProfilesTableAnnotationComposer,
      $$ProfilesTableCreateCompanionBuilder,
      $$ProfilesTableUpdateCompanionBuilder,
      (RawProfile, $$ProfilesTableReferences),
      RawProfile,
      PrefetchHooks Function({bool profileRuleLinksRefs})
    >;
typedef $$ScriptsTableCreateCompanionBuilder = ScriptsCompanion Function({
  Value<int> id,
  required String label,
  required DateTime lastUpdateTime,
  Value<String?> url,
  Value<int?> order,
});
typedef $$ScriptsTableUpdateCompanionBuilder = ScriptsCompanion Function({
  Value<int> id,
  Value<String> label,
  Value<DateTime> lastUpdateTime,
  Value<String?> url,
  Value<int?> order,
});

class $$ScriptsTableFilterComposer extends Composer<_$Database, $ScriptsTable> {
  $$ScriptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ScriptsTableOrderingComposer
    extends Composer<_$Database, $ScriptsTable> {
  $$ScriptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ScriptsTableAnnotationComposer
    extends Composer<_$Database, $ScriptsTable> {
  $$ScriptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);
}

class $$ScriptsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ScriptsTable,
          RawScript,
          $$ScriptsTableFilterComposer,
          $$ScriptsTableOrderingComposer,
          $$ScriptsTableAnnotationComposer,
          $$ScriptsTableCreateCompanionBuilder,
          $$ScriptsTableUpdateCompanionBuilder,
          (RawScript, BaseReferences<_$Database, $ScriptsTable, RawScript>),
          RawScript,
          PrefetchHooks Function()
        > {
  $$ScriptsTableTableManager(_$Database db, $ScriptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScriptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScriptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScriptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<DateTime> lastUpdateTime = const Value.absent(),
                Value<String?> url = const Value.absent(),
                Value<int?> order = const Value.absent(),
              }) => ScriptsCompanion(
                id: id,
                label: label,
                lastUpdateTime: lastUpdateTime,
                url: url,
                order: order,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String label,
                required DateTime lastUpdateTime,
                Value<String?> url = const Value.absent(),
                Value<int?> order = const Value.absent(),
              }) => ScriptsCompanion.insert(
                id: id,
                label: label,
                lastUpdateTime: lastUpdateTime,
                url: url,
                order: order,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ScriptsTable, RawScript>(table),
                  BaseReferences<_$Database, $ScriptsTable, RawScript>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ScriptsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ScriptsTable,
      RawScript,
      $$ScriptsTableFilterComposer,
      $$ScriptsTableOrderingComposer,
      $$ScriptsTableAnnotationComposer,
      $$ScriptsTableCreateCompanionBuilder,
      $$ScriptsTableUpdateCompanionBuilder,
      (RawScript, BaseReferences<_$Database, $ScriptsTable, RawScript>),
      RawScript,
      PrefetchHooks Function()
    >;
typedef $$RulesTableCreateCompanionBuilder = RulesCompanion Function({
  Value<int> id,
  required String value,
  Value<RuleAction?> ruleAction,
  Value<String?> content,
  Value<String?> ruleTarget,
  Value<String?> ruleProvider,
  Value<String?> subRule,
  Value<bool> noResolve,
  Value<bool> src,
});
typedef $$RulesTableUpdateCompanionBuilder = RulesCompanion Function({
  Value<int> id,
  Value<String> value,
  Value<RuleAction?> ruleAction,
  Value<String?> content,
  Value<String?> ruleTarget,
  Value<String?> ruleProvider,
  Value<String?> subRule,
  Value<bool> noResolve,
  Value<bool> src,
});

final class $$RulesTableReferences
    extends BaseReferences<_$Database, $RulesTable, RawRule> {
  $$RulesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProfileRuleLinksTable, List<RawProfileRuleLink>>
  _profileRuleLinksRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.profileRuleLinks,
    aliasName: 'rules__id__profile_rule_mapping__rule_id',
  );

  $$ProfileRuleLinksTableProcessedTableManager get profileRuleLinksRefs {
    final manager = $$ProfileRuleLinksTableTableManager(
      $_db,
      $_db.profileRuleLinks,
    ).filter((f) => f.ruleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _profileRuleLinksRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RulesTableFilterComposer extends Composer<_$Database, $RulesTable> {
  $$RulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RuleAction?, RuleAction, String>
  get ruleAction => $composableBuilder(
    column: $table.ruleAction,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleTarget => $composableBuilder(
    column: $table.ruleTarget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleProvider => $composableBuilder(
    column: $table.ruleProvider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subRule => $composableBuilder(
    column: $table.subRule,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get noResolve => $composableBuilder(
    column: $table.noResolve,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get src => $composableBuilder(
    column: $table.src,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> profileRuleLinksRefs(
    Expression<bool> Function($$ProfileRuleLinksTableFilterComposer f) f,
  ) {
    final $$ProfileRuleLinksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.profileRuleLinks,
      getReferencedColumn: (t) => t.ruleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileRuleLinksTableFilterComposer(
            $db: $db,
            $table: $db.profileRuleLinks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RulesTableOrderingComposer extends Composer<_$Database, $RulesTable> {
  $$RulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleAction => $composableBuilder(
    column: $table.ruleAction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleTarget => $composableBuilder(
    column: $table.ruleTarget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleProvider => $composableBuilder(
    column: $table.ruleProvider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subRule => $composableBuilder(
    column: $table.subRule,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get noResolve => $composableBuilder(
    column: $table.noResolve,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get src => $composableBuilder(
    column: $table.src,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RulesTableAnnotationComposer extends Composer<_$Database, $RulesTable> {
  $$RulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RuleAction?, String> get ruleAction =>
      $composableBuilder(
        column: $table.ruleAction,
        builder: (column) => column,
      );

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get ruleTarget => $composableBuilder(
    column: $table.ruleTarget,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ruleProvider => $composableBuilder(
    column: $table.ruleProvider,
    builder: (column) => column,
  );

  GeneratedColumn<String> get subRule =>
      $composableBuilder(column: $table.subRule, builder: (column) => column);

  GeneratedColumn<bool> get noResolve =>
      $composableBuilder(column: $table.noResolve, builder: (column) => column);

  GeneratedColumn<bool> get src =>
      $composableBuilder(column: $table.src, builder: (column) => column);

  Expression<T> profileRuleLinksRefs<T extends Object>(
    Expression<T> Function($$ProfileRuleLinksTableAnnotationComposer a) f,
  ) {
    final $$ProfileRuleLinksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.profileRuleLinks,
      getReferencedColumn: (t) => t.ruleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileRuleLinksTableAnnotationComposer(
            $db: $db,
            $table: $db.profileRuleLinks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RulesTableTableManager
    extends
        RootTableManager<
          _$Database,
          $RulesTable,
          RawRule,
          $$RulesTableFilterComposer,
          $$RulesTableOrderingComposer,
          $$RulesTableAnnotationComposer,
          $$RulesTableCreateCompanionBuilder,
          $$RulesTableUpdateCompanionBuilder,
          (RawRule, $$RulesTableReferences),
          RawRule,
          PrefetchHooks Function({bool profileRuleLinksRefs})
        > {
  $$RulesTableTableManager(_$Database db, $RulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<RuleAction?> ruleAction = const Value.absent(),
                Value<String?> content = const Value.absent(),
                Value<String?> ruleTarget = const Value.absent(),
                Value<String?> ruleProvider = const Value.absent(),
                Value<String?> subRule = const Value.absent(),
                Value<bool> noResolve = const Value.absent(),
                Value<bool> src = const Value.absent(),
              }) => RulesCompanion(
                id: id,
                value: value,
                ruleAction: ruleAction,
                content: content,
                ruleTarget: ruleTarget,
                ruleProvider: ruleProvider,
                subRule: subRule,
                noResolve: noResolve,
                src: src,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String value,
                Value<RuleAction?> ruleAction = const Value.absent(),
                Value<String?> content = const Value.absent(),
                Value<String?> ruleTarget = const Value.absent(),
                Value<String?> ruleProvider = const Value.absent(),
                Value<String?> subRule = const Value.absent(),
                Value<bool> noResolve = const Value.absent(),
                Value<bool> src = const Value.absent(),
              }) => RulesCompanion.insert(
                id: id,
                value: value,
                ruleAction: ruleAction,
                content: content,
                ruleTarget: ruleTarget,
                ruleProvider: ruleProvider,
                subRule: subRule,
                noResolve: noResolve,
                src: src,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RulesTable, RawRule>(table),
                  $$RulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileRuleLinksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (profileRuleLinksRefs) db.profileRuleLinks,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (profileRuleLinksRefs)
                    await $_getPrefetchedDataByColumns<
                      RawRule,
                      $RulesTable,
                      RawProfileRuleLink,
                      $ProfileRuleLinksTable
                    >(
                      currentTable: table,
                      referencedTable: $$RulesTableReferences
                          ._profileRuleLinksRefsTable(db),
                      managerFromTypedResult: (p0) => $$RulesTableReferences(
                        db,
                        table,
                        p0,
                      ).profileRuleLinksRefs,
                      currentColumn: 'id',
                      referencedColumn: 'rule_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RulesTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $RulesTable,
      RawRule,
      $$RulesTableFilterComposer,
      $$RulesTableOrderingComposer,
      $$RulesTableAnnotationComposer,
      $$RulesTableCreateCompanionBuilder,
      $$RulesTableUpdateCompanionBuilder,
      (RawRule, $$RulesTableReferences),
      RawRule,
      PrefetchHooks Function({bool profileRuleLinksRefs})
    >;
typedef $$ProfileRuleLinksTableCreateCompanionBuilder =
    ProfileRuleLinksCompanion Function({
      required String id,
      Value<int?> profileId,
      required int ruleId,
      Value<RuleScene?> scene,
      Value<String?> order,
      Value<int> rowid,
    });
typedef $$ProfileRuleLinksTableUpdateCompanionBuilder =
    ProfileRuleLinksCompanion Function({
      Value<String> id,
      Value<int?> profileId,
      Value<int> ruleId,
      Value<RuleScene?> scene,
      Value<String?> order,
      Value<int> rowid,
    });

final class $$ProfileRuleLinksTableReferences
    extends
        BaseReferences<_$Database, $ProfileRuleLinksTable, RawProfileRuleLink> {
  $$ProfileRuleLinksTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfilesTable _profileIdTable(_$Database db) =>
      db.profiles.createAlias('profile_rule_mapping__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager? get profileId {
    final $_column = $_itemColumn<int>('profile_id');
    if ($_column == null) return null;
    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RulesTable _ruleIdTable(_$Database db) =>
      db.rules.createAlias('profile_rule_mapping__rule_id__rules__id');

  $$RulesTableProcessedTableManager get ruleId {
    final $_column = $_itemColumn<int>('rule_id')!;

    final manager = $$RulesTableTableManager(
      $_db,
      $_db.rules,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ruleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProfileRuleLinksTableFilterComposer
    extends Composer<_$Database, $ProfileRuleLinksTable> {
  $$ProfileRuleLinksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RuleScene?, RuleScene, String> get scene =>
      $composableBuilder(
        column: $table.scene,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RulesTableFilterComposer get ruleId {
    final $$RulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleId,
      referencedTable: $db.rules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RulesTableFilterComposer(
            $db: $db,
            $table: $db.rules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProfileRuleLinksTableOrderingComposer
    extends Composer<_$Database, $ProfileRuleLinksTable> {
  $$ProfileRuleLinksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scene => $composableBuilder(
    column: $table.scene,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RulesTableOrderingComposer get ruleId {
    final $$RulesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleId,
      referencedTable: $db.rules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RulesTableOrderingComposer(
            $db: $db,
            $table: $db.rules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProfileRuleLinksTableAnnotationComposer
    extends Composer<_$Database, $ProfileRuleLinksTable> {
  $$ProfileRuleLinksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RuleScene?, String> get scene =>
      $composableBuilder(column: $table.scene, builder: (column) => column);

  GeneratedColumn<String> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RulesTableAnnotationComposer get ruleId {
    final $$RulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleId,
      referencedTable: $db.rules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RulesTableAnnotationComposer(
            $db: $db,
            $table: $db.rules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProfileRuleLinksTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ProfileRuleLinksTable,
          RawProfileRuleLink,
          $$ProfileRuleLinksTableFilterComposer,
          $$ProfileRuleLinksTableOrderingComposer,
          $$ProfileRuleLinksTableAnnotationComposer,
          $$ProfileRuleLinksTableCreateCompanionBuilder,
          $$ProfileRuleLinksTableUpdateCompanionBuilder,
          (RawProfileRuleLink, $$ProfileRuleLinksTableReferences),
          RawProfileRuleLink,
          PrefetchHooks Function({bool profileId, bool ruleId})
        > {
  $$ProfileRuleLinksTableTableManager(
    _$Database db,
    $ProfileRuleLinksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileRuleLinksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileRuleLinksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfileRuleLinksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int?> profileId = const Value.absent(),
                Value<int> ruleId = const Value.absent(),
                Value<RuleScene?> scene = const Value.absent(),
                Value<String?> order = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfileRuleLinksCompanion(
                id: id,
                profileId: profileId,
                ruleId: ruleId,
                scene: scene,
                order: order,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<int?> profileId = const Value.absent(),
                required int ruleId,
                Value<RuleScene?> scene = const Value.absent(),
                Value<String?> order = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfileRuleLinksCompanion.insert(
                id: id,
                profileId: profileId,
                ruleId: ruleId,
                scene: scene,
                order: order,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProfileRuleLinksTable, RawProfileRuleLink>(
                    table,
                  ),
                  $$ProfileRuleLinksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false, ruleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.profileId,
                        referencedTable: $$ProfileRuleLinksTableReferences
                            ._profileIdTable(db),
                        referencedColumn: $$ProfileRuleLinksTableReferences
                            ._profileIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (ruleId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.ruleId,
                        referencedTable: $$ProfileRuleLinksTableReferences
                            ._ruleIdTable(db),
                        referencedColumn: $$ProfileRuleLinksTableReferences
                            ._ruleIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProfileRuleLinksTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ProfileRuleLinksTable,
      RawProfileRuleLink,
      $$ProfileRuleLinksTableFilterComposer,
      $$ProfileRuleLinksTableOrderingComposer,
      $$ProfileRuleLinksTableAnnotationComposer,
      $$ProfileRuleLinksTableCreateCompanionBuilder,
      $$ProfileRuleLinksTableUpdateCompanionBuilder,
      (RawProfileRuleLink, $$ProfileRuleLinksTableReferences),
      RawProfileRuleLink,
      PrefetchHooks Function({bool profileId, bool ruleId})
    >;
typedef $$IconRecordsTableCreateCompanionBuilder =
    IconRecordsCompanion Function({
      required String url,
      required int lastAccessed,
      Value<int> rowid,
    });
typedef $$IconRecordsTableUpdateCompanionBuilder =
    IconRecordsCompanion Function({
      Value<String> url,
      Value<int> lastAccessed,
      Value<int> rowid,
    });

class $$IconRecordsTableFilterComposer
    extends Composer<_$Database, $IconRecordsTable> {
  $$IconRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastAccessed => $composableBuilder(
    column: $table.lastAccessed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$IconRecordsTableOrderingComposer
    extends Composer<_$Database, $IconRecordsTable> {
  $$IconRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastAccessed => $composableBuilder(
    column: $table.lastAccessed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IconRecordsTableAnnotationComposer
    extends Composer<_$Database, $IconRecordsTable> {
  $$IconRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<int> get lastAccessed => $composableBuilder(
    column: $table.lastAccessed,
    builder: (column) => column,
  );
}

class $$IconRecordsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $IconRecordsTable,
          IconRecord,
          $$IconRecordsTableFilterComposer,
          $$IconRecordsTableOrderingComposer,
          $$IconRecordsTableAnnotationComposer,
          $$IconRecordsTableCreateCompanionBuilder,
          $$IconRecordsTableUpdateCompanionBuilder,
          (
            IconRecord,
            BaseReferences<_$Database, $IconRecordsTable, IconRecord>,
          ),
          IconRecord,
          PrefetchHooks Function()
        > {
  $$IconRecordsTableTableManager(_$Database db, $IconRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IconRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IconRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IconRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> url = const Value.absent(),
                Value<int> lastAccessed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IconRecordsCompanion(
                url: url,
                lastAccessed: lastAccessed,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String url,
                required int lastAccessed,
                Value<int> rowid = const Value.absent(),
              }) => IconRecordsCompanion.insert(
                url: url,
                lastAccessed: lastAccessed,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$IconRecordsTable, IconRecord>(table),
                  BaseReferences<_$Database, $IconRecordsTable, IconRecord>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$IconRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $IconRecordsTable,
      IconRecord,
      $$IconRecordsTableFilterComposer,
      $$IconRecordsTableOrderingComposer,
      $$IconRecordsTableAnnotationComposer,
      $$IconRecordsTableCreateCompanionBuilder,
      $$IconRecordsTableUpdateCompanionBuilder,
      (IconRecord, BaseReferences<_$Database, $IconRecordsTable, IconRecord>),
      IconRecord,
      PrefetchHooks Function()
    >;
typedef $$ClashProvidersTableCreateCompanionBuilder =
    ClashProvidersCompanion Function({
      Value<int> id,
      required ProviderKind kind,
      required String label,
      Value<String> url,
      required RuleProviderBehavior behavior,
      required RuleProviderFormat format,
      required Uint8List content,
      required int order,
    });
typedef $$ClashProvidersTableUpdateCompanionBuilder =
    ClashProvidersCompanion Function({
      Value<int> id,
      Value<ProviderKind> kind,
      Value<String> label,
      Value<String> url,
      Value<RuleProviderBehavior> behavior,
      Value<RuleProviderFormat> format,
      Value<Uint8List> content,
      Value<int> order,
    });

class $$ClashProvidersTableFilterComposer
    extends Composer<_$Database, $ClashProvidersTable> {
  $$ClashProvidersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ProviderKind, ProviderKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    RuleProviderBehavior,
    RuleProviderBehavior,
    String
  >
  get behavior => $composableBuilder(
    column: $table.behavior,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<RuleProviderFormat, RuleProviderFormat, String>
  get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<Uint8List> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ClashProvidersTableOrderingComposer
    extends Composer<_$Database, $ClashProvidersTable> {
  $$ClashProvidersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get behavior => $composableBuilder(
    column: $table.behavior,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClashProvidersTableAnnotationComposer
    extends Composer<_$Database, $ClashProvidersTable> {
  $$ClashProvidersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ProviderKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RuleProviderBehavior, String> get behavior =>
      $composableBuilder(column: $table.behavior, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RuleProviderFormat, String> get format =>
      $composableBuilder(column: $table.format, builder: (column) => column);

  GeneratedColumn<Uint8List> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);
}

class $$ClashProvidersTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ClashProvidersTable,
          RawClashProvider,
          $$ClashProvidersTableFilterComposer,
          $$ClashProvidersTableOrderingComposer,
          $$ClashProvidersTableAnnotationComposer,
          $$ClashProvidersTableCreateCompanionBuilder,
          $$ClashProvidersTableUpdateCompanionBuilder,
          (
            RawClashProvider,
            BaseReferences<_$Database, $ClashProvidersTable, RawClashProvider>,
          ),
          RawClashProvider,
          PrefetchHooks Function()
        > {
  $$ClashProvidersTableTableManager(_$Database db, $ClashProvidersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClashProvidersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClashProvidersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClashProvidersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<ProviderKind> kind = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<RuleProviderBehavior> behavior = const Value.absent(),
                Value<RuleProviderFormat> format = const Value.absent(),
                Value<Uint8List> content = const Value.absent(),
                Value<int> order = const Value.absent(),
              }) => ClashProvidersCompanion(
                id: id,
                kind: kind,
                label: label,
                url: url,
                behavior: behavior,
                format: format,
                content: content,
                order: order,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required ProviderKind kind,
                required String label,
                Value<String> url = const Value.absent(),
                required RuleProviderBehavior behavior,
                required RuleProviderFormat format,
                required Uint8List content,
                required int order,
              }) => ClashProvidersCompanion.insert(
                id: id,
                kind: kind,
                label: label,
                url: url,
                behavior: behavior,
                format: format,
                content: content,
                order: order,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ClashProvidersTable, RawClashProvider>(table),
                  BaseReferences<
                    _$Database,
                    $ClashProvidersTable,
                    RawClashProvider
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClashProvidersTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ClashProvidersTable,
      RawClashProvider,
      $$ClashProvidersTableFilterComposer,
      $$ClashProvidersTableOrderingComposer,
      $$ClashProvidersTableAnnotationComposer,
      $$ClashProvidersTableCreateCompanionBuilder,
      $$ClashProvidersTableUpdateCompanionBuilder,
      (
        RawClashProvider,
        BaseReferences<_$Database, $ClashProvidersTable, RawClashProvider>,
      ),
      RawClashProvider,
      PrefetchHooks Function()
    >;
typedef $$IconSetsTableCreateCompanionBuilder = IconSetsCompanion Function({
  Value<int> id,
  required String name,
  required String url,
  required List<IconSetIcon> icons,
  Value<DateTime?> lastUpdateTime,
  Value<int?> order,
});
typedef $$IconSetsTableUpdateCompanionBuilder = IconSetsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> url,
  Value<List<IconSetIcon>> icons,
  Value<DateTime?> lastUpdateTime,
  Value<int?> order,
});

class $$IconSetsTableFilterComposer
    extends Composer<_$Database, $IconSetsTable> {
  $$IconSetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<IconSetIcon>, List<IconSetIcon>, String>
  get icons => $composableBuilder(
    column: $table.icons,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );
}

class $$IconSetsTableOrderingComposer
    extends Composer<_$Database, $IconSetsTable> {
  $$IconSetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icons => $composableBuilder(
    column: $table.icons,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IconSetsTableAnnotationComposer
    extends Composer<_$Database, $IconSetsTable> {
  $$IconSetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<IconSetIcon>, String> get icons =>
      $composableBuilder(column: $table.icons, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);
}

class $$IconSetsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $IconSetsTable,
          RawIconSet,
          $$IconSetsTableFilterComposer,
          $$IconSetsTableOrderingComposer,
          $$IconSetsTableAnnotationComposer,
          $$IconSetsTableCreateCompanionBuilder,
          $$IconSetsTableUpdateCompanionBuilder,
          (RawIconSet, BaseReferences<_$Database, $IconSetsTable, RawIconSet>),
          RawIconSet,
          PrefetchHooks Function()
        > {
  $$IconSetsTableTableManager(_$Database db, $IconSetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IconSetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IconSetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IconSetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<List<IconSetIcon>> icons = const Value.absent(),
                Value<DateTime?> lastUpdateTime = const Value.absent(),
                Value<int?> order = const Value.absent(),
              }) => IconSetsCompanion(
                id: id,
                name: name,
                url: url,
                icons: icons,
                lastUpdateTime: lastUpdateTime,
                order: order,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String url,
                required List<IconSetIcon> icons,
                Value<DateTime?> lastUpdateTime = const Value.absent(),
                Value<int?> order = const Value.absent(),
              }) => IconSetsCompanion.insert(
                id: id,
                name: name,
                url: url,
                icons: icons,
                lastUpdateTime: lastUpdateTime,
                order: order,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$IconSetsTable, RawIconSet>(table),
                  BaseReferences<_$Database, $IconSetsTable, RawIconSet>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$IconSetsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $IconSetsTable,
      RawIconSet,
      $$IconSetsTableFilterComposer,
      $$IconSetsTableOrderingComposer,
      $$IconSetsTableAnnotationComposer,
      $$IconSetsTableCreateCompanionBuilder,
      $$IconSetsTableUpdateCompanionBuilder,
      (RawIconSet, BaseReferences<_$Database, $IconSetsTable, RawIconSet>),
      RawIconSet,
      PrefetchHooks Function()
    >;
typedef $$MitmModulesTableCreateCompanionBuilder =
    MitmModulesCompanion Function({
      Value<int> id,
      required String name,
      Value<String> description,
      Value<String?> url,
      Value<bool> enabled,
      Value<int?> order,
      Value<Map<String, String>> arguments,
      Value<Map<String, String>> resources,
      Value<String?> system,
      Value<int> scripts,
      required DateTime lastUpdateTime,
    });
typedef $$MitmModulesTableUpdateCompanionBuilder =
    MitmModulesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> description,
      Value<String?> url,
      Value<bool> enabled,
      Value<int?> order,
      Value<Map<String, String>> arguments,
      Value<Map<String, String>> resources,
      Value<String?> system,
      Value<int> scripts,
      Value<DateTime> lastUpdateTime,
    });

class $$MitmModulesTableFilterComposer
    extends Composer<_$Database, $MitmModulesTable> {
  $$MitmModulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, String>,
    Map<String, String>,
    String
  >
  get arguments => $composableBuilder(
    column: $table.arguments,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, String>,
    Map<String, String>,
    String
  >
  get resources => $composableBuilder(
    column: $table.resources,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get system => $composableBuilder(
    column: $table.system,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scripts => $composableBuilder(
    column: $table.scripts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MitmModulesTableOrderingComposer
    extends Composer<_$Database, $MitmModulesTable> {
  $$MitmModulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get arguments => $composableBuilder(
    column: $table.arguments,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resources => $composableBuilder(
    column: $table.resources,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get system => $composableBuilder(
    column: $table.system,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scripts => $composableBuilder(
    column: $table.scripts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MitmModulesTableAnnotationComposer
    extends Composer<_$Database, $MitmModulesTable> {
  $$MitmModulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, String>, String> get arguments =>
      $composableBuilder(column: $table.arguments, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, String>, String> get resources =>
      $composableBuilder(column: $table.resources, builder: (column) => column);

  GeneratedColumn<String> get system =>
      $composableBuilder(column: $table.system, builder: (column) => column);

  GeneratedColumn<int> get scripts =>
      $composableBuilder(column: $table.scripts, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => column,
  );
}

class $$MitmModulesTableTableManager
    extends
        RootTableManager<
          _$Database,
          $MitmModulesTable,
          RawMitmModule,
          $$MitmModulesTableFilterComposer,
          $$MitmModulesTableOrderingComposer,
          $$MitmModulesTableAnnotationComposer,
          $$MitmModulesTableCreateCompanionBuilder,
          $$MitmModulesTableUpdateCompanionBuilder,
          (
            RawMitmModule,
            BaseReferences<_$Database, $MitmModulesTable, RawMitmModule>,
          ),
          RawMitmModule,
          PrefetchHooks Function()
        > {
  $$MitmModulesTableTableManager(_$Database db, $MitmModulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MitmModulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MitmModulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MitmModulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> url = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int?> order = const Value.absent(),
                Value<Map<String, String>> arguments = const Value.absent(),
                Value<Map<String, String>> resources = const Value.absent(),
                Value<String?> system = const Value.absent(),
                Value<int> scripts = const Value.absent(),
                Value<DateTime> lastUpdateTime = const Value.absent(),
              }) => MitmModulesCompanion(
                id: id,
                name: name,
                description: description,
                url: url,
                enabled: enabled,
                order: order,
                arguments: arguments,
                resources: resources,
                system: system,
                scripts: scripts,
                lastUpdateTime: lastUpdateTime,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> description = const Value.absent(),
                Value<String?> url = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int?> order = const Value.absent(),
                Value<Map<String, String>> arguments = const Value.absent(),
                Value<Map<String, String>> resources = const Value.absent(),
                Value<String?> system = const Value.absent(),
                Value<int> scripts = const Value.absent(),
                required DateTime lastUpdateTime,
              }) => MitmModulesCompanion.insert(
                id: id,
                name: name,
                description: description,
                url: url,
                enabled: enabled,
                order: order,
                arguments: arguments,
                resources: resources,
                system: system,
                scripts: scripts,
                lastUpdateTime: lastUpdateTime,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MitmModulesTable, RawMitmModule>(table),
                  BaseReferences<_$Database, $MitmModulesTable, RawMitmModule>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MitmModulesTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $MitmModulesTable,
      RawMitmModule,
      $$MitmModulesTableFilterComposer,
      $$MitmModulesTableOrderingComposer,
      $$MitmModulesTableAnnotationComposer,
      $$MitmModulesTableCreateCompanionBuilder,
      $$MitmModulesTableUpdateCompanionBuilder,
      (
        RawMitmModule,
        BaseReferences<_$Database, $MitmModulesTable, RawMitmModule>,
      ),
      RawMitmModule,
      PrefetchHooks Function()
    >;
typedef $$CustomProxiesTableCreateCompanionBuilder =
    CustomProxiesCompanion Function({
      Value<int> id,
      required Map<String, Object?> definition,
      Value<bool> enabled,
      Value<String> uri,
      required Set<String> emptyOptions,
      required int order,
    });
typedef $$CustomProxiesTableUpdateCompanionBuilder =
    CustomProxiesCompanion Function({
      Value<int> id,
      Value<Map<String, Object?>> definition,
      Value<bool> enabled,
      Value<String> uri,
      Value<Set<String>> emptyOptions,
      Value<int> order,
    });

class $$CustomProxiesTableFilterComposer
    extends Composer<_$Database, $CustomProxiesTable> {
  $$CustomProxiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, Object?>,
    Map<String, Object>,
    String
  >
  get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uri => $composableBuilder(
    column: $table.uri,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Set<String>, Set<String>, String>
  get emptyOptions => $composableBuilder(
    column: $table.emptyOptions,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomProxiesTableOrderingComposer
    extends Composer<_$Database, $CustomProxiesTable> {
  $$CustomProxiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uri => $composableBuilder(
    column: $table.uri,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emptyOptions => $composableBuilder(
    column: $table.emptyOptions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomProxiesTableAnnotationComposer
    extends Composer<_$Database, $CustomProxiesTable> {
  $$CustomProxiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, Object?>, String>
  get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<String> get uri =>
      $composableBuilder(column: $table.uri, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Set<String>, String> get emptyOptions =>
      $composableBuilder(
        column: $table.emptyOptions,
        builder: (column) => column,
      );

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);
}

class $$CustomProxiesTableTableManager
    extends
        RootTableManager<
          _$Database,
          $CustomProxiesTable,
          RawCustomProxy,
          $$CustomProxiesTableFilterComposer,
          $$CustomProxiesTableOrderingComposer,
          $$CustomProxiesTableAnnotationComposer,
          $$CustomProxiesTableCreateCompanionBuilder,
          $$CustomProxiesTableUpdateCompanionBuilder,
          (
            RawCustomProxy,
            BaseReferences<_$Database, $CustomProxiesTable, RawCustomProxy>,
          ),
          RawCustomProxy,
          PrefetchHooks Function()
        > {
  $$CustomProxiesTableTableManager(_$Database db, $CustomProxiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomProxiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomProxiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomProxiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<Map<String, Object?>> definition = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<String> uri = const Value.absent(),
                Value<Set<String>> emptyOptions = const Value.absent(),
                Value<int> order = const Value.absent(),
              }) => CustomProxiesCompanion(
                id: id,
                definition: definition,
                enabled: enabled,
                uri: uri,
                emptyOptions: emptyOptions,
                order: order,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required Map<String, Object?> definition,
                Value<bool> enabled = const Value.absent(),
                Value<String> uri = const Value.absent(),
                required Set<String> emptyOptions,
                required int order,
              }) => CustomProxiesCompanion.insert(
                id: id,
                definition: definition,
                enabled: enabled,
                uri: uri,
                emptyOptions: emptyOptions,
                order: order,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CustomProxiesTable, RawCustomProxy>(table),
                  BaseReferences<
                    _$Database,
                    $CustomProxiesTable,
                    RawCustomProxy
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomProxiesTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $CustomProxiesTable,
      RawCustomProxy,
      $$CustomProxiesTableFilterComposer,
      $$CustomProxiesTableOrderingComposer,
      $$CustomProxiesTableAnnotationComposer,
      $$CustomProxiesTableCreateCompanionBuilder,
      $$CustomProxiesTableUpdateCompanionBuilder,
      (
        RawCustomProxy,
        BaseReferences<_$Database, $CustomProxiesTable, RawCustomProxy>,
      ),
      RawCustomProxy,
      PrefetchHooks Function()
    >;

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db, _db.profiles);
  $$ScriptsTableTableManager get scripts =>
      $$ScriptsTableTableManager(_db, _db.scripts);
  $$RulesTableTableManager get rules =>
      $$RulesTableTableManager(_db, _db.rules);
  $$ProfileRuleLinksTableTableManager get profileRuleLinks =>
      $$ProfileRuleLinksTableTableManager(_db, _db.profileRuleLinks);
  $$IconRecordsTableTableManager get iconRecords =>
      $$IconRecordsTableTableManager(_db, _db.iconRecords);
  $$ClashProvidersTableTableManager get clashProviders =>
      $$ClashProvidersTableTableManager(_db, _db.clashProviders);
  $$IconSetsTableTableManager get iconSets =>
      $$IconSetsTableTableManager(_db, _db.iconSets);
  $$MitmModulesTableTableManager get mitmModules =>
      $$MitmModulesTableTableManager(_db, _db.mitmModules);
  $$CustomProxiesTableTableManager get customProxies =>
      $$CustomProxiesTableTableManager(_db, _db.customProxies);
}

mixin _$ProfilesDaoMixin on DatabaseAccessor<Database> {
  $ProfilesTable get profiles => attachedDatabase.profiles;
  ProfilesDaoManager get managers => ProfilesDaoManager(this);
}

class ProfilesDaoManager {
  final _$ProfilesDaoMixin _db;
  ProfilesDaoManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db.attachedDatabase, _db.profiles);
}

mixin _$ScriptsDaoMixin on DatabaseAccessor<Database> {
  $ScriptsTable get scripts => attachedDatabase.scripts;
  ScriptsDaoManager get managers => ScriptsDaoManager(this);
}

class ScriptsDaoManager {
  final _$ScriptsDaoMixin _db;
  ScriptsDaoManager(this._db);
  $$ScriptsTableTableManager get scripts =>
      $$ScriptsTableTableManager(_db.attachedDatabase, _db.scripts);
}

mixin _$RulesDaoMixin on DatabaseAccessor<Database> {
  $RulesTable get rules => attachedDatabase.rules;
  $ProfilesTable get profiles => attachedDatabase.profiles;
  $ProfileRuleLinksTable get profileRuleLinks =>
      attachedDatabase.profileRuleLinks;
  RulesDaoManager get managers => RulesDaoManager(this);
}

class RulesDaoManager {
  final _$RulesDaoMixin _db;
  RulesDaoManager(this._db);
  $$RulesTableTableManager get rules =>
      $$RulesTableTableManager(_db.attachedDatabase, _db.rules);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db.attachedDatabase, _db.profiles);
  $$ProfileRuleLinksTableTableManager get profileRuleLinks =>
      $$ProfileRuleLinksTableTableManager(
        _db.attachedDatabase,
        _db.profileRuleLinks,
      );
}

mixin _$IconRecordsDaoMixin on DatabaseAccessor<Database> {
  $IconRecordsTable get iconRecords => attachedDatabase.iconRecords;
  IconRecordsDaoManager get managers => IconRecordsDaoManager(this);
}

class IconRecordsDaoManager {
  final _$IconRecordsDaoMixin _db;
  IconRecordsDaoManager(this._db);
  $$IconRecordsTableTableManager get iconRecords =>
      $$IconRecordsTableTableManager(_db.attachedDatabase, _db.iconRecords);
}

mixin _$ClashProvidersDaoMixin on DatabaseAccessor<Database> {
  $ClashProvidersTable get clashProviders => attachedDatabase.clashProviders;
  ClashProvidersDaoManager get managers => ClashProvidersDaoManager(this);
}

class ClashProvidersDaoManager {
  final _$ClashProvidersDaoMixin _db;
  ClashProvidersDaoManager(this._db);
  $$ClashProvidersTableTableManager get clashProviders =>
      $$ClashProvidersTableTableManager(
        _db.attachedDatabase,
        _db.clashProviders,
      );
}

mixin _$IconSetsDaoMixin on DatabaseAccessor<Database> {
  $IconSetsTable get iconSets => attachedDatabase.iconSets;
  IconSetsDaoManager get managers => IconSetsDaoManager(this);
}

class IconSetsDaoManager {
  final _$IconSetsDaoMixin _db;
  IconSetsDaoManager(this._db);
  $$IconSetsTableTableManager get iconSets =>
      $$IconSetsTableTableManager(_db.attachedDatabase, _db.iconSets);
}

mixin _$MitmModulesDaoMixin on DatabaseAccessor<Database> {
  $MitmModulesTable get mitmModules => attachedDatabase.mitmModules;
  MitmModulesDaoManager get managers => MitmModulesDaoManager(this);
}

class MitmModulesDaoManager {
  final _$MitmModulesDaoMixin _db;
  MitmModulesDaoManager(this._db);
  $$MitmModulesTableTableManager get mitmModules =>
      $$MitmModulesTableTableManager(_db.attachedDatabase, _db.mitmModules);
}

mixin _$CustomProxiesDaoMixin on DatabaseAccessor<Database> {
  $CustomProxiesTable get customProxies => attachedDatabase.customProxies;
  CustomProxiesDaoManager get managers => CustomProxiesDaoManager(this);
}

class CustomProxiesDaoManager {
  final _$CustomProxiesDaoMixin _db;
  CustomProxiesDaoManager(this._db);
  $$CustomProxiesTableTableManager get customProxies =>
      $$CustomProxiesTableTableManager(_db.attachedDatabase, _db.customProxies);
}

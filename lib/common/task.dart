import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/database/database.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

const maxBackupArchiveBytes = 64 * 1024 * 1024;
const maxBackupFileBytes = 64 * 1024 * 1024;
const maxBackupTotalBytes = 256 * 1024 * 1024;
const maxBackupEntries = 4096;

Future<T> decodeJSONTask<T>(String data) async {
  return compute<String, T>(_decodeJSON, data);
}

Future<T> _decodeJSON<T>(String content) async {
  return json.decode(content);
}

Future<String> encodeJSONTask<T>(T data) async {
  return compute<T, String>(_encodeJSON, data);
}

Future<String> _encodeJSON<T>(T content) async {
  return json.encode(content);
}

Future<String> encodeYamlTask<T>(T data) async {
  return compute<T, String>(_encodeYaml, data);
}

Future<String> _encodeYaml<T>(T content) async {
  return yaml.encode(content);
}

Future<List<Group>> toGroupsTask(ComputeGroupsState data) async {
  return compute<ComputeGroupsState, List<Group>>(_toGroupsTask, data);
}

Future<List<Group>> _toGroupsTask(ComputeGroupsState state) async {
  final proxiesData = state.proxiesData;
  final all = proxiesData.all;
  final sortType = state.sortType;
  final delayMap = state.delayMap;
  final selectedMap = state.selectedMap;
  final defaultTestUrl = state.defaultTestUrl;
  final proxies = proxiesData.proxies;
  if (proxies.isEmpty) return [];
  final groupsRaw = all
      .where((name) {
        final proxy = proxies[name] ?? {};
        return GroupTypeExtension.valueList.contains(proxy['type']);
      })
      .map((groupName) {
        final group = Map<String, dynamic>.from(proxies[groupName]);
        group['all'] = ((group['all'] ?? []) as List)
            .map((name) => proxies[name])
            .where((proxy) => proxy != null)
            .toList();
        return group;
      })
      .toList();
  final groups = groupsRaw.map((e) => Group.fromJson(e)).toList();
  return computeSort(
    groups: groups,
    sortType: sortType,
    delayMap: delayMap,
    selectedMap: selectedMap,
    defaultTestUrl: defaultTestUrl,
  );
}

Future<Map<String, dynamic>> makeRealProfileTask(
  MakeRealProfileState data,
) async {
  return compute<MakeRealProfileState, Map<String, dynamic>>(
    _makeRealProfileTask,
    data,
  );
}

void _preserveProxyDnsBootstrap(
  Map<String, dynamic> targetDns,
  Map<dynamic, dynamic> sourceDns,
) {
  final sourcePolicy = sourceDns['proxy-server-nameserver-policy'];
  if (sourcePolicy is! Map || sourcePolicy.isEmpty) {
    return;
  }

  final policy = <String, dynamic>{};
  for (final entry in sourcePolicy.entries) {
    final key = entry.key;
    if (key is! String) {
      continue;
    }
    final value = entry.value;
    policy[key] = value is List ? List.from(value) : value;
  }
  if (policy.isEmpty) {
    return;
  }

  // Proxy endpoint resolution is a connectivity prerequisite, not part of
  // the user-facing DNS override.
  targetDns['proxy-server-nameserver-policy'] = policy;

  final targetNameservers = targetDns['proxy-server-nameserver'];
  if (targetNameservers is! List || targetNameservers.isEmpty) {
    final sourceNameservers = sourceDns['proxy-server-nameserver'];
    if (sourceNameservers is List && sourceNameservers.isNotEmpty) {
      targetDns['proxy-server-nameserver'] = List.from(sourceNameservers);
    }
  }

  final sourceFakeIpFilter = sourceDns['fake-ip-filter'];
  final targetFakeIpFilter = targetDns['fake-ip-filter'];
  if (sourceFakeIpFilter is! List || targetFakeIpFilter is! List) {
    return;
  }

  final sourceFakeIpDomains = sourceFakeIpFilter.whereType<String>().toSet();
  final mergedFakeIpFilter = List<String>.from(targetFakeIpFilter);
  for (final domain in policy.keys) {
    if (sourceFakeIpDomains.contains(domain) &&
        !mergedFakeIpFilter.contains(domain)) {
      mergedFakeIpFilter.add(domain);
    }
  }
  targetDns['fake-ip-filter'] = mergedFakeIpFilter;
}

void _applyWebRtcBlock(Map<String, dynamic> rawConfig) {
  final rawSniffer = rawConfig['sniffer'];
  final snifferMap = rawSniffer is Map
      ? Map<dynamic, dynamic>.from(rawSniffer)
      : <String, dynamic>{};
  snifferMap['enable'] = true;
  snifferMap['parse-pure-ip'] = true;
  final rawSniff = snifferMap['sniff'];
  final sniffMap = rawSniff is Map
      ? Map<dynamic, dynamic>.from(rawSniff)
      : <String, dynamic>{};
  sniffMap['STUN'] = <String, dynamic>{};
  for (final entry in sniffMap.entries.toList()) {
    final value = entry.value;
    if (value is Map && value['ports'] is List) {
      sniffMap[entry.key] = Map<dynamic, dynamic>.from(value)
        ..['ports'] = (value['ports'] as List)
            .map((item) => item.toString())
            .toList();
    }
  }
  snifferMap['sniff'] = sniffMap;
  rawConfig['sniffer'] = snifferMap;
}

Future<Map<String, dynamic>> _makeRealProfileTask(
  MakeRealProfileState data,
) async {
  final rawConfig = Map<String, dynamic>.from(data.rawConfig);
  final realPatchConfig = data.realPatchConfig;
  final profilesPath = data.profilesPath;
  final profileId = data.profileId;
  final overrideDns = data.overrideDns;
  final addedRules = data.addedRules;
  final proxyChains = data.proxyChains;
  final profileProxies = data.profileProxies;
  final customProxyGroups = data.customProxyGroups;
  final customRules = data.customRules;
  final appendSystemDns = data.appendSystemDns;
  final defaultUA = data.defaultUA;
  final blockQuic = data.blockQuic;
  final blockWebRtc = data.blockWebRtc;
  String getProvidersFilePathInner(String type, String url) {
    return join(
      profilesPath,
      'providers',
      profileId.toString(),
      type,
      url.toMd5(),
    );
  }

  rawConfig['external-controller'] = resolveExternalController(
    realPatchConfig.externalController,
    realPatchConfig.externalControllerAddress,
  );
  rawConfig['secret'] = resolveExternalControllerSecret(realPatchConfig.secret);
  rawConfig['external-ui'] = '';
  rawConfig['interface-name'] = '';
  rawConfig['external-ui-url'] = '';
  rawConfig['tcp-concurrent'] = realPatchConfig.tcpConcurrent;
  rawConfig['unified-delay'] = realPatchConfig.unifiedDelay;
  rawConfig['ipv6'] = realPatchConfig.ipv6;
  rawConfig['log-level'] = realPatchConfig.logLevel.name;
  rawConfig['port'] = 0;
  rawConfig['socks-port'] = 0;
  rawConfig['keep-alive-interval'] = realPatchConfig.keepAliveInterval;
  rawConfig['mixed-port'] = realPatchConfig.mixedPort;
  rawConfig['port'] = realPatchConfig.port;
  rawConfig['socks-port'] = realPatchConfig.socksPort;
  rawConfig['redir-port'] = realPatchConfig.redirPort;
  rawConfig['tproxy-port'] = realPatchConfig.tproxyPort;
  rawConfig['find-process-mode'] = realPatchConfig.findProcessMode.name;
  rawConfig['allow-lan'] = data.dockerMode || realPatchConfig.allowLan;
  if (data.dockerMode) {
    rawConfig['bind-address'] = '*';
  }
  rawConfig['mode'] = realPatchConfig.mode.name;
  if (rawConfig['tun'] == null) {
    rawConfig['tun'] = {};
  }
  rawConfig['tun']['enable'] = realPatchConfig.tun.enable;
  rawConfig['tun']['device'] = realPatchConfig.tun.device;
  rawConfig['tun']['dns-hijack'] = realPatchConfig.tun.dnsHijack;
  rawConfig['tun']['stack'] = realPatchConfig.tun.stack.name;
  rawConfig['tun']['route-address'] = realPatchConfig.tun.routeAddress;
  rawConfig['tun']['auto-route'] = realPatchConfig.tun.autoRoute;
  rawConfig['geodata-loader'] = realPatchConfig.geodataLoader.name;
  rawConfig['geo-auto-update'] = realPatchConfig.geoAutoUpdate;
  rawConfig['geo-update-interval'] = normalizeGeoUpdateInterval(
    realPatchConfig.geoUpdateInterval,
  );
  if (blockWebRtc) {
    _applyWebRtcBlock(rawConfig);
  }
  if (rawConfig['profile'] == null) {
    rawConfig['profile'] = {};
  }
  if (rawConfig['proxy-providers'] != null) {
    final proxyProviders = rawConfig['proxy-providers'] as Map;
    for (final key in proxyProviders.keys) {
      final proxyProvider = proxyProviders[key];
      if (proxyProvider['type'] != 'http') {
        continue;
      }
      if (proxyProvider['url'] != null) {
        proxyProvider['path'] = getProvidersFilePathInner(
          'proxies',
          proxyProvider['url'],
        );
      }
    }
  }
  if (rawConfig['rule-providers'] != null) {
    final ruleProviders = rawConfig['rule-providers'] as Map;
    for (final key in ruleProviders.keys) {
      final ruleProvider = ruleProviders[key];
      if (ruleProvider['type'] != 'http') {
        continue;
      }
      if (ruleProvider['url'] != null) {
        ruleProvider['path'] = getProvidersFilePathInner(
          'rules',
          ruleProvider['url'],
        );
      }
    }
  }
  rawConfig['profile']['store-selected'] = false;
  if (data.overwriteType == OverwriteType.custom) {
    rawConfig['proxy-groups'] = customProxyGroups.map((group) {
      return group.toJson()..removeWhere((_, value) => value == null);
    }).toList();
  }
  _applyProfileProxies(rawConfig, profileProxies);
  _applyProxyChains(rawConfig, proxyChains);
  rawConfig['geox-url'] = realPatchConfig.geoXUrl.toJson();
  rawConfig['global-ua'] = realPatchConfig.globalUa ?? defaultUA;
  final existingFingerprint = rawConfig['global-client-fingerprint'];
  if (existingFingerprint is! String || existingFingerprint.isEmpty) {
    rawConfig['global-client-fingerprint'] = defaultGlobalClientFingerprint;
  }
  if (rawConfig['hosts'] == null) {
    rawConfig['hosts'] = {};
  }
  for (final host in realPatchConfig.hosts.entries) {
    rawConfig['hosts'][host.key] = host.value.splitByMultipleSeparators;
  }
  if (rawConfig['dns'] == null) {
    rawConfig['dns'] = {};
  }
  final sourceDns = Map<dynamic, dynamic>.from(rawConfig['dns'] as Map);
  final isEnableDns = rawConfig['dns']['enable'] == true;
  const systemDns = 'system://';
  if (overrideDns || !isEnableDns) {
    final baseDns = overrideDns ? realPatchConfig.dns : defaultDns;
    final dns = !isEnableDns && !baseDns.nameserver.contains(systemDns)
        ? baseDns.copyWith(nameserver: [...baseDns.nameserver, systemDns])
        : baseDns;
    final targetDns = dns.toJson();
    targetDns['nameserver-policy'] = {};
    for (final entry in dns.nameserverPolicy.entries) {
      targetDns['nameserver-policy'][entry.key] =
          entry.value.splitByMultipleSeparators;
    }
    _preserveProxyDnsBootstrap(targetDns, sourceDns);
    rawConfig['dns'] = targetDns;
  }
  if (appendSystemDns) {
    final List<String> nameserver = List<String>.from(
      rawConfig['dns']['nameserver'] ?? [],
    );
    if (!nameserver.contains(systemDns)) {
      rawConfig['dns']['nameserver'] = [...nameserver, systemDns];
    }
  }
  List<String> rules = customRules.map((rule) => rule.value).toList();
  if (data.overwriteType != OverwriteType.custom &&
      rawConfig['rules'] != null) {
    rules = List<String>.from(rawConfig['rules']);
  }
  rawConfig.remove('rules');
  if (addedRules.isNotEmpty) {
    final parsedNewRules = addedRules
        .map((item) => ParsedRule.parseString(item.value))
        .toList();
    final hasMatchPlaceholder = parsedNewRules.any(
      (item) => item.ruleTarget?.toUpperCase() == 'MATCH',
    );
    String? replacementTarget;

    if (hasMatchPlaceholder) {
      for (int i = rules.length - 1; i >= 0; i--) {
        final parsed = ParsedRule.parseString(rules[i]);
        if (parsed.ruleAction == RuleAction.MATCH) {
          final target = parsed.ruleTarget;
          if (target != null && target.isNotEmpty) {
            replacementTarget = target;
            break;
          }
        }
      }
    }
    final List<String> finalAddedRules;

    if (replacementTarget?.isNotEmpty == true) {
      finalAddedRules = [];
      for (int i = 0; i < parsedNewRules.length; i++) {
        final parsed = parsedNewRules[i];
        if (parsed.ruleTarget?.toUpperCase() == 'MATCH') {
          finalAddedRules.add(
            parsed.copyWith(ruleTarget: replacementTarget).value,
          );
        } else {
          finalAddedRules.add(addedRules[i].value);
        }
      }
    } else {
      finalAddedRules = addedRules.map((e) => e.value).toList();
    }
    rules = [...finalAddedRules, ...rules];
  }
  rawConfig['rules'] = [
    if (blockWebRtc) 'SNIFF-PROTOCOL,stun,REJECT-DROP',
    if (blockQuic) 'AND,((NETWORK,udp),(DST-PORT,443)),REJECT',
    ...rules,
  ];
  return Map<String, dynamic>.from(rawConfig);
}

void _applyProfileProxies(Map rawConfig, List<ProfileProxy> profileProxies) {
  final customProxies = profileProxies
      .where((profileProxy) => profileProxy.isValid)
      .map((profileProxy) => profileProxy.normalizedProxy)
      .toList();
  if (customProxies.isEmpty) {
    return;
  }
  final customNames = customProxies
      .map((proxy) => proxy['name'])
      .whereType<String>()
      .toList();
  final customNameSet = customNames.toSet();
  final proxies = rawConfig['proxies'];
  final nextProxies = <Map>[];
  if (proxies is List) {
    for (final proxy in proxies.whereType<Map>()) {
      final name = proxy['name'];
      if (name is String && customNameSet.contains(name)) {
        continue;
      }
      nextProxies.add(proxy);
    }
  }
  rawConfig['proxies'] = [...customProxies, ...nextProxies];
  _appendProfileProxyNamesToSelectorGroups(rawConfig, customNames);
}

void _appendProfileProxyNamesToSelectorGroups(
  Map rawConfig,
  List<String> customNames,
) {
  if (customNames.isEmpty) {
    return;
  }
  final proxyGroups = rawConfig['proxy-groups'];
  if (proxyGroups is! List) {
    return;
  }
  for (var i = 0; i < proxyGroups.length; i++) {
    final group = proxyGroups[i];
    if (group is! Map) {
      continue;
    }
    if (group['type'] != 'select') {
      continue;
    }
    final rawProxies = group['proxies'];
    final proxies = rawProxies is List ? List.of(rawProxies) : [];
    for (final name in customNames) {
      if (!proxies.contains(name)) {
        proxies.add(name);
      }
    }
    group['proxies'] = proxies;
  }
}

void _applyProxyChains(Map rawConfig, List<ProxyChain> proxyChains) {
  if (proxyChains.isEmpty) {
    return;
  }
  final enabledProxyChains = proxyChains
      .where((chain) => chain.enable)
      .toList();
  if (enabledProxyChains.any((chain) => !chain.isValid)) {
    throw const FormatException('invalid proxy chain');
  }
  final validProxyChains = enabledProxyChains;
  if (validProxyChains.isEmpty) return;
  final proxies = rawConfig['proxies'];
  final proxyMap = <String, Map>{};
  if (proxies is List) {
    for (final proxy in proxies.whereType<Map>()) {
      final name = proxy['name'];
      if (name is String && name.isNotEmpty) {
        proxyMap[name] = proxy;
      }
    }
  }
  final proxyGroups = rawConfig['proxy-groups'];
  final groupNames = proxyGroups is List
      ? proxyGroups
            .whereType<Map>()
            .map((group) => group['name'])
            .whereType<String>()
            .where((name) => name.isNotEmpty)
            .toSet()
      : <String>{};
  final scope = ProxyChainNameScope(
    targetNames: proxyMap.keys.toSet(),
    dialerNames: {...proxyMap.keys, ...groupNames},
  );
  final applicableProxyChains = validProxyChains.where((chain) {
    return scope.isValid(chain.normalizedProxies);
  }).toList();
  if (applicableProxyChains.length != validProxyChains.length) {
    throw const FormatException('proxy chain references an unavailable node');
  }
  final existingRelations = <String, String>{
    for (final entry in proxyMap.entries)
      if (entry.value['dialer-proxy'] case final String dialer)
        if (dialer.isNotEmpty) entry.key: dialer,
  };
  final conflict = findProxyChainConflictName(
    applicableProxyChains,
    existingRelations: existingRelations,
  );
  if (conflict != null) {
    throw FormatException('proxy chain conflict: $conflict');
  }
  for (final chain in applicableProxyChains) {
    final chainProxies = chain.normalizedProxies;
    for (var i = 1; i < chainProxies.length; i++) {
      final proxyName = chainProxies[i];
      final dialerProxy = chainProxies[i - 1];
      proxyMap[proxyName]!['dialer-proxy'] = dialerProxy;
    }
  }
}

Future<List<String>> shakingProfileTask(
  VM2<Iterable<int>, Iterable<int>> data,
) async {
  return compute<
    VM3<Iterable<int>, Iterable<int>, RootIsolateToken>,
    List<String>
  >(_shakingProfileTask, VM3(data.a, data.b, RootIsolateToken.instance!));
}

Future<List<String>> _shakingProfileTask(
  VM3<Iterable<int>, Iterable<int>, RootIsolateToken> data,
) async {
  final profileIds = data.a;
  final scriptIds = data.b;
  final token = data.c;
  BackgroundIsolateBinaryMessenger.ensureInitialized(token);
  final profilesDir = Directory(await appPath.profilesPath);
  final scriptsDir = Directory(await appPath.scriptsDirPath);
  final providersDir = Directory(await appPath.getProvidersRootPath());
  final List<String> targets = [];
  void scanDirectory(
    Directory dir,
    Iterable<int> baseNames, {
    bool skipProvidersFolder = false,
  }) {
    if (!dir.existsSync()) return;
    final entities = dir.listSync(recursive: false, followLinks: false);

    for (final entity in entities) {
      if (entity is File) {
        final id = basenameWithoutExtension(entity.path);
        if (!baseNames.contains(int.tryParse(id))) {
          targets.add(entity.path);
        }
      } else if (skipProvidersFolder && entity is Directory) {
        if (basename(entity.path) == 'providers') {
          continue;
        }
      }
    }
  }

  scanDirectory(profilesDir, profileIds, skipProvidersFolder: true);
  scanDirectory(providersDir, profileIds);
  scanDirectory(scriptsDir, scriptIds);
  return targets;
}

Future<String> encodeLogsTask(List<Log> data) async {
  return compute<List<Log>, String>(_encodeLogsTask, data);
}

Future<String> _encodeLogsTask(List<Log> data) async {
  final logsRaw = data.map((item) => item.toString());
  final logsRawString = logsRaw.join('\n');
  return logsRawString;
}

Future<MigrationData> oldToNowTask(Map<String, Object?> data) async {
  final homeDir = await appPath.homeDirPath;
  return migrateLegacyBackup(
    data,
    sourcePath: homeDir,
    targetPath: homeDir,
    livePath: homeDir,
  );
}

Future<MigrationData> migrateLegacyBackup(
  Map<String, Object?> data, {
  required String sourcePath,
  required String targetPath,
  required String livePath,
}) {
  return compute<
    VM4<Map<String, Object?>, String, String, String>,
    MigrationData
  >(_oldToNowTask, VM4(data, sourcePath, targetPath, livePath));
}

Future<MigrationData> _oldToNowTask(
  VM4<Map<String, Object?>, String, String, String> data,
) async {
  final configMap = data.a;
  final sourcePath = data.b;
  final targetPath = data.c;
  final livePath = data.d;

  final accessControlMap = configMap['accessControl'];
  final isAccessControl = configMap['isAccessControl'];
  if (accessControlMap != null) {
    (accessControlMap as Map)['enable'] = isAccessControl;
    if (configMap['vpnProps'] != null) {
      final vpnPropsRaw = configMap['vpnProps'] as Map;
      vpnPropsRaw['accessControl'] = accessControlMap;
    }
  }
  if (configMap['vpnProps'] != null) {
    final vpnPropsRaw = configMap['vpnProps'] as Map;
    vpnPropsRaw['accessControlProps'] = vpnPropsRaw['accessControl'];
  }
  configMap['davProps'] = configMap['dav'];
  final appSettingProps =
      (configMap['appSetting'] as Map?)?.cast<String, Object?>() ??
      <String, Object?>{};
  appSettingProps['restoreStrategy'] = appSettingProps['recoveryStrategy'];
  configMap['appSettingProps'] = appSettingProps;
  configMap['proxiesStyleProps'] = configMap['proxiesStyle'];
  // final overwriteMap = configMap['overwrite'] as Map? ?? {};
  // configMap['overwriteType'] = overwriteMap['type'];
  // configMap['scriptId'] = overwriteMap['scriptOverwrite'];
  List rawScripts = configMap['scripts'] as List<dynamic>? ?? [];
  if (rawScripts.isEmpty) {
    final scriptPropsJson = configMap['scriptProps'] as Map<String, dynamic>?;
    if (scriptPropsJson != null) {
      rawScripts = scriptPropsJson['scripts'] as List<dynamic>? ?? [];
    }
  }
  final Map<String, int> idMap = {};
  final definedIds = <String>{};
  final List<Script> scripts = [];
  final List<VM2<String, String>> fileMigrations = [];
  for (final rawScript in rawScripts) {
    final id = rawScript['id'] as String?;
    final content = rawScript['content'] as String?;
    final label = rawScript['label'] as String?;
    if (id == null || content == null || label == null) {
      continue;
    }
    if (!definedIds.add(id)) {
      throw const FormatException('duplicate legacy id');
    }
    final newId = idMap.updateCacheValue(rawScript['id'], () => _legacyId(id));
    final path = _getScriptPath(targetPath, newId.toString());
    final file = File(path);
    await file.safeWriteAsString(content);
    scripts.add(
      Script(id: newId, label: label, lastUpdateTime: DateTime.now()),
    );
    if (targetPath != sourcePath) {
      fileMigrations.add(VM2(path, _getScriptPath(livePath, newId.toString())));
    }
  }
  final List rawRules = configMap['rules'] as List<dynamic>? ?? [];
  final List<Rule> rules = [];
  final List<ProfileRuleLink> links = [];
  for (final rawRule in rawRules) {
    final ruleMap = Map<String, dynamic>.from(rawRule as Map);
    final rawRuleId = ruleMap['id']?.toString();
    if (rawRuleId == null || !definedIds.add(rawRuleId)) {
      throw const FormatException('invalid or duplicate legacy rule id');
    }
    final id = idMap.updateCacheValue(
      ruleMap['id'],
      () => _legacyId(rawRuleId),
    );
    ruleMap['id'] = id;
    rules.add(Rule.fromJson(ruleMap));
    links.add(ProfileRuleLink(ruleId: id));
  }
  final List rawProfiles = configMap['profiles'] as List<dynamic>? ?? [];
  final List<Profile> profiles = [];
  for (final rawProfile in rawProfiles) {
    final profileMap = Map<String, dynamic>.from(rawProfile as Map);
    final rawId = profileMap['id'] as String?;
    if (rawId == null) {
      continue;
    }
    if (!definedIds.add(rawId)) {
      throw const FormatException('duplicate legacy id');
    }
    if (rawId.isEmpty || basename(rawId) != rawId || rawId.contains('\\')) {
      throw const FormatException('invalid legacy profile id');
    }
    final sourceFile = File(_getProfilePath(sourcePath, rawId));
    // A legacy config can outlive its profile file; skipping keeps startup alive.
    if (!await sourceFile.exists()) {
      continue;
    }
    final profileId = idMap.updateCacheValue(rawId, () => _legacyId(rawId));
    profileMap['id'] = profileId;
    final overwrite = profileMap['overwrite'] as Map?;
    if (overwrite != null) {
      final standardOverwrite = overwrite['standardOverwrite'] as Map?;
      if (standardOverwrite != null) {
        final addedRules = standardOverwrite['addedRules'] as List? ?? [];
        for (final addRule in addedRules) {
          final addRuleMap = Map<String, dynamic>.from(addRule as Map);
          final addRuleId = addRuleMap['id']?.toString();
          if (addRuleId == null || !definedIds.add(addRuleId)) {
            throw const FormatException('invalid or duplicate legacy rule id');
          }
          final id = idMap.updateCacheValue(
            addRuleMap['id'],
            () => _legacyId(addRuleId),
          );
          addRuleMap['id'] = id;
          rules.add(Rule.fromJson(addRuleMap));
          links.add(
            ProfileRuleLink(
              profileId: profileId,
              ruleId: id,
              scene: RuleScene.added,
            ),
          );
        }
        final disabledRuleIds = standardOverwrite['disabledRuleIds'] as List?;
        if (disabledRuleIds != null) {
          for (final disabledRuleId in disabledRuleIds) {
            final newDisabledRuleId = idMap[disabledRuleId];
            if (newDisabledRuleId != null) {
              links.add(
                ProfileRuleLink(
                  profileId: profileId,
                  ruleId: newDisabledRuleId,
                  scene: RuleScene.disabled,
                ),
              );
            }
          }
        }
      }
      final scriptOverwrite = overwrite['scriptOverwrite'] as Map?;
      if (scriptOverwrite != null) {
        final scriptId = scriptOverwrite['scriptId'] as String?;
        profileMap['scriptId'] = scriptId != null ? idMap[scriptId] : null;
      }
      profileMap['overwriteType'] = overwrite['type'];
    }

    final targetFilePath = _getProfilePath(targetPath, profileId.toString());
    await sourceFile.safeCopy(targetFilePath);
    if (targetPath != sourcePath) {
      fileMigrations.add(
        VM2(targetFilePath, _getProfilePath(livePath, profileId.toString())),
      );
    }
    profiles.add(Profile.fromJson(profileMap));
  }
  final currentProfileId = configMap['currentProfileId'];
  configMap['currentProfileId'] = currentProfileId != null
      ? idMap[currentProfileId]
      : null;
  for (final key in const [
    'profiles',
    'scripts',
    'rules',
    'scriptProps',
    'accessControl',
    'isAccessControl',
    'dav',
    'appSetting',
    'proxiesStyle',
    'overwrite',
  ]) {
    configMap.remove(key);
  }
  return MigrationData(
    configMap: configMap,
    profiles: profiles,
    rules: rules,
    scripts: scripts,
    links: links,
    fileMigrations: fileMigrations,
  );
}

int _legacyId(String value) {
  final bytes = sha256.convert(utf8.encode('flclash-legacy-v1:$value')).bytes;
  var result = 0;
  for (var index = 0; index < 8; index++) {
    result = (result << 8) | bytes[index];
  }
  result &= 0x7fffffffffffffff;
  return result == 0 ? 1 : result;
}

Future<String> backupTask(
  Map<String, dynamic> configMap,
  String storageSnapshotPath,
) async {
  final tempZipFilePath = await appPath.tempFilePath;
  final tempConfigFilePath = await appPath.tempFilePath;
  return compute<VM4<Map<String, dynamic>, String, String, String>, String>(
    _backupTask,
    VM4(configMap, storageSnapshotPath, tempZipFilePath, tempConfigFilePath),
  );
}

Future<String> _backupTask<T>(
  VM4<Map<String, dynamic>, String, String, String> args,
) async {
  final configMap = args.a;
  final storageSnapshotPath = args.b;
  final tempZipFilePath = args.c;
  final tempConfigFilePath = args.d;
  final configStr = json.encode(configMap);
  final storageSnapshotDir = Directory(storageSnapshotPath);
  final profilesDir = Directory(join(storageSnapshotPath, 'profiles'));
  final scriptsDir = Directory(join(storageSnapshotPath, 'scripts'));
  final tempDBFile = File(join(storageSnapshotPath, backupDatabaseName));
  final tempZipFile = File(tempZipFilePath);
  final tempConfigFile = File(tempConfigFilePath);
  final encoder = ZipFileEncoder();
  try {
    final configBytes = utf8.encode(configStr).length;
    if (configBytes > maxBackupFileBytes) {
      throw const FormatException('backup config exceeds restore limit');
    }
    var totalBytes = configBytes;
    var entries = 1;
    await for (final entity in storageSnapshotDir.list(recursive: true)) {
      entries++;
      if (entries > maxBackupEntries) {
        throw const FormatException('too many backup entries');
      }
      if (entity is Directory) {
        continue;
      }
      if (entity is! File) {
        throw const FormatException('unsupported backup entity');
      }
      final size = await entity.length();
      if (size > maxBackupFileBytes) {
        throw const FormatException('backup file exceeds restore limit');
      }
      totalBytes += size;
      if (totalBytes > maxBackupTotalBytes) {
        throw const FormatException('backup expands beyond restore limit');
      }
    }
    encoder.create(tempZipFilePath);
    await tempConfigFile.writeAsString(configStr);
    await encoder.addFile(tempDBFile, backupDatabaseName);
    await encoder.addFile(tempConfigFile, configJsonName);
    if (await profilesDir.exists()) {
      await encoder.addDirectory(profilesDir);
    }
    if (await scriptsDir.exists()) {
      await encoder.addDirectory(scriptsDir);
    }
    await encoder.close();
    if (await tempZipFile.length() > maxBackupArchiveBytes) {
      throw const FormatException('backup archive exceeds restore limit');
    }
    return tempZipFilePath;
  } catch (_) {
    await tempZipFile.safeDelete();
    rethrow;
  } finally {
    await tempConfigFile.safeDelete();
    await storageSnapshotDir.safeDelete(recursive: true);
  }
}

Future<MigrationData> restoreTask(
  String backupFilePath,
  String restoreDirPath,
  String homeDirPath,
) async {
  return compute<VM3<String, String, String>, MigrationData>(
    _restoreTask,
    VM3(backupFilePath, restoreDirPath, homeDirPath),
  );
}

String resolveSafeArchivePath(String basePath, String entryName) {
  final normalizedEntry = posix.normalize(entryName.replaceAll('\\', '/'));
  final hasDrivePrefix = RegExp(r'^[A-Za-z]:').hasMatch(normalizedEntry);
  if (normalizedEntry.isEmpty ||
      normalizedEntry == '.' ||
      posix.isAbsolute(normalizedEntry) ||
      hasDrivePrefix ||
      normalizedEntry == '..' ||
      normalizedEntry.startsWith('../')) {
    throw const FormatException('unsafe archive path');
  }
  final base = absolute(normalize(basePath));
  final target = absolute(
    normalize(joinAll([base, ...posix.split(normalizedEntry)])),
  );
  if (!isWithin(base, target)) {
    throw const FormatException('unsafe archive path');
  }
  return target;
}

Future<void> extractBackupArchive(
  Archive archive,
  String restoreDirPath, {
  int maxEntries = maxBackupEntries,
  int maxFileBytes = maxBackupFileBytes,
  int maxTotalBytes = maxBackupTotalBytes,
}) async {
  if (archive.files.length > maxEntries) {
    throw const FormatException('too many archive entries');
  }
  final dir = Directory(restoreDirPath);
  await dir.safeDelete(recursive: true);
  await dir.create(recursive: true);
  final extractedPaths = <String>{};
  final budget = _ExtractionBudget(maxTotalBytes);
  try {
    for (final file in archive.files) {
      if (file.isSymbolicLink) {
        throw const FormatException('symbolic links are not allowed');
      }
      final outPath = resolveSafeArchivePath(restoreDirPath, file.name);
      if (!extractedPaths.add(outPath)) {
        throw const FormatException('duplicate archive path');
      }
      if (file.isDirectory) {
        await Directory(outPath).create(recursive: true);
        continue;
      }
      if (!file.isFile) {
        throw const FormatException('unsupported archive entry');
      }
      if (file.size < 0 || file.size > maxFileBytes) {
        throw const FormatException('archive entry too large');
      }
      budget.reserve(file.size);
      await Directory(dirname(outPath)).create(recursive: true);
      final outputStream = _LimitedOutputStream(
        OutputFileStream(outPath),
        maxFileBytes,
        budget,
      );
      try {
        file.writeContent(outputStream);
        if (outputStream.written != file.size) {
          throw const FormatException('archive entry size mismatch');
        }
        if (file.crc32 != null && outputStream.crc32 != file.crc32) {
          throw const FormatException('archive entry checksum mismatch');
        }
      } finally {
        await outputStream.close();
      }
    }
  } catch (_) {
    await dir.safeDelete(recursive: true);
    rethrow;
  }
}

Future<void> validateBackupArchiveDirectory(
  String archivePath,
  String restoreDirPath, {
  int maxEntries = maxBackupEntries,
  int maxFileBytes = maxBackupFileBytes,
  int maxTotalBytes = maxBackupTotalBytes,
}) async {
  final input = InputFileStream(archivePath);
  try {
    final directory = ZipDirectory()..read(input);
    if (directory.numberOfThisDisk != 0 ||
        directory.diskWithTheStartOfTheCentralDirectory != 0 ||
        directory.totalCentralDirectoryEntries <= 0 ||
        directory.totalCentralDirectoryEntries > maxEntries ||
        directory.fileHeaders.length !=
            directory.totalCentralDirectoryEntries) {
      throw const FormatException('invalid zip directory');
    }
    final extractedPaths = <String>{};
    var totalBytes = 0;
    for (final header in directory.fileHeaders) {
      final localName = header.file?.filename;
      if (localName == null || localName != header.filename) {
        throw const FormatException('zip header name mismatch');
      }
      final outPath = resolveSafeArchivePath(restoreDirPath, header.filename);
      if (!extractedPaths.add(outPath)) {
        throw const FormatException('duplicate archive path');
      }
      final entryMode = header.externalFileAttributes >> 16;
      if (header.versionMadeBy >> 8 == 3 && entryMode & 0xf000 == 0xa000) {
        throw const FormatException('symbolic links are not allowed');
      }
      if (header.generalPurposeBitFlag & 0x1 != 0) {
        throw const FormatException('encrypted archives are not allowed');
      }
      if (header.uncompressedSize < 0 ||
          header.uncompressedSize > maxFileBytes ||
          header.compressedSize < 0) {
        throw const FormatException('archive entry too large');
      }
      totalBytes += header.uncompressedSize;
      if (totalBytes > maxTotalBytes) {
        throw const FormatException('archive expands beyond limit');
      }
    }
  } finally {
    await input.close();
  }
}

Future<bool> validateBackupDatabase(String path) async {
  final file = File(path);
  if (!await file.exists() || await file.length() < 16) {
    return false;
  }
  final header = await file
      .openRead(0, 16)
      .fold<List<int>>(<int>[], (bytes, chunk) => bytes..addAll(chunk));
  if (ascii.decode(header, allowInvalid: true) != 'SQLite format 3\u0000') {
    return false;
  }
  sqlite.Database? backupDatabase;
  try {
    backupDatabase = sqlite.sqlite3.open(path, mode: sqlite.OpenMode.readOnly);
    final quickCheck = backupDatabase.select('PRAGMA quick_check').first;
    if (quickCheck.values.first != 'ok') {
      return false;
    }
    final schemaVersion =
        backupDatabase.select('PRAGMA user_version').first.values.first as int;
    if (schemaVersion < 1 || schemaVersion > currentDatabaseSchemaVersion) {
      return false;
    }
    final foreignKeyViolations = backupDatabase.select(
      'PRAGMA foreign_key_check',
    );
    if (foreignKeyViolations.any(
      (row) => row['table'] != 'profile_rule_mapping',
    )) {
      return false;
    }
    final tables = backupDatabase
        .select("SELECT name FROM sqlite_master WHERE type = 'table'")
        .map((row) => row['name'])
        .whereType<String>()
        .toSet();
    if (const {
      'profiles',
      'scripts',
      'rules',
      'profile_rule_mapping',
    }.difference(tables).isNotEmpty) {
      return false;
    }
    final requiredColumns = <String, Set<String>>{
      'profiles': {
        'id',
        'label',
        'url',
        'overwrite_type',
        'auto_update_duration_millis',
        'auto_update',
        'selected_map',
        'unfold_set',
        if (schemaVersion >= 2) ...{'proxy_chains', 'profile_proxies'},
        if (schemaVersion >= 3) ...{'custom_proxy_groups', 'custom_rules'},
      },
      'scripts': {'id', 'label', 'last_update_time'},
      'rules': {'id', 'value'},
      'profile_rule_mapping': {'id', 'profile_id', 'rule_id', 'scene', 'order'},
    };
    for (final entry in requiredColumns.entries) {
      final columns = backupDatabase
          .select('PRAGMA table_info("${entry.key}")')
          .map((row) => row['name'])
          .whereType<String>()
          .toSet();
      if (entry.value.difference(columns).isNotEmpty) {
        return false;
      }
    }
    return true;
  } catch (_) {
    return false;
  } finally {
    backupDatabase?.dispose();
  }
}

class _ExtractionBudget {
  final int maxBytes;
  int declaredBytes = 0;
  int writtenBytes = 0;

  _ExtractionBudget(this.maxBytes);

  void reserve(int bytes) {
    declaredBytes += bytes;
    if (declaredBytes > maxBytes) {
      throw const FormatException('archive expands beyond limit');
    }
  }

  void write(int bytes) {
    writtenBytes += bytes;
    if (writtenBytes > maxBytes) {
      throw const FormatException('archive write exceeds limit');
    }
  }
}

class _LimitedOutputStream extends OutputStream {
  final OutputFileStream _delegate;
  final int _maxFileBytes;
  final _ExtractionBudget _budget;
  int _written = 0;
  int _crc32 = 0;

  int get written => _written;
  int get crc32 => _crc32;

  _LimitedOutputStream(this._delegate, this._maxFileBytes, this._budget)
    : super(byteOrder: _delegate.byteOrder);

  void _add(int bytes) {
    _written += bytes;
    if (_written > _maxFileBytes) {
      throw const FormatException('archive entry write exceeds limit');
    }
    _budget.write(bytes);
  }

  @override
  int get length => _delegate.length;

  @override
  bool get isOpen => _delegate.isOpen;

  @override
  void clear() => _delegate.clear();

  @override
  Future<void> close() => _delegate.close();

  @override
  void closeSync() => _delegate.closeSync();

  @override
  void flush() => _delegate.flush();

  @override
  void writeByte(int value) {
    _add(1);
    _crc32 = getCrc32([value], _crc32);
    _delegate.writeByte(value);
  }

  @override
  void writeBytes(List<int> bytes, {int? length}) {
    final writeLength = length ?? bytes.length;
    _add(writeLength);
    _crc32 = getCrc32(bytes.take(writeLength).toList(), _crc32);
    _delegate.writeBytes(bytes, length: writeLength);
  }

  @override
  void writeStream(InputStream stream) {
    var remaining = stream.length;
    const chunkSize = 1024 * 1024;
    while (remaining > 0) {
      final size = remaining > chunkSize ? chunkSize : remaining;
      final bytes = stream.readBytes(size).toUint8List();
      writeBytes(bytes);
      remaining -= size;
    }
  }

  @override
  Uint8List subset(int start, [int? end]) => _delegate.subset(start, end);
}

Future<MigrationData> _restoreTask(VM3<String, String, String> paths) async {
  final backupFilePath = paths.a;
  final restoreDirPath = paths.b;
  final homeDirPath = paths.c;
  final zipDecoder = ZipDecoder();
  final backupFile = File(backupFilePath);
  if (!await backupFile.exists() ||
      await backupFile.length() > maxBackupArchiveBytes) {
    throw appLocalizations.invalidBackupFile;
  }
  await validateBackupArchiveDirectory(backupFilePath, restoreDirPath);
  final input = InputFileStream(backupFilePath);
  late final Archive archive;
  try {
    archive = zipDecoder.decodeStream(input);
  } finally {
    await input.close();
  }
  await extractBackupArchive(archive, restoreDirPath);
  final restoreConfigFile = File(join(restoreDirPath, configJsonName));
  if (!await restoreConfigFile.exists()) {
    throw appLocalizations.invalidBackupFile;
  }
  final restoreConfigMap =
      json.decode(await restoreConfigFile.readAsString())
          as Map<String, Object?>?;
  final version = restoreConfigMap?['version'] ?? 0;
  MigrationData migrationData = MigrationData(configMap: restoreConfigMap);
  if (version == 0 && restoreConfigMap != null) {
    if (!_isLegacyBackupConfig(restoreConfigMap)) {
      throw appLocalizations.invalidBackupFile;
    }
    final legacyOutputPath = join(restoreDirPath, 'legacy-output');
    migrationData = await migrateLegacyBackup(
      restoreConfigMap,
      sourcePath: restoreDirPath,
      targetPath: legacyOutputPath,
      livePath: homeDirPath,
    );
    return migrationData;
  }
  final backupDatabaseFile = File(join(restoreDirPath, backupDatabaseName));
  sqlite.sqlite3.tempDirectory = restoreDirPath;
  if (!await validateBackupDatabase(backupDatabaseFile.path)) {
    throw appLocalizations.invalidBackupFile;
  }
  final database = Database(NativeDatabase(backupDatabaseFile));
  try {
    final results = await Future.wait([
      database.profilesDao.all().get(),
      database.scriptsDao.all().get(),
      database.rules.all().map((item) => item.toRule()).get(),
      database.profileRuleLinks.all().map((item) => item.toLink()).get(),
    ]);
    final profiles = results[0].cast<Profile>();
    final scripts = results[1].cast<Script>();
    final profilesMigration = profiles
        .where((item) => item.includeInPortableBackup)
        .map(
          (item) => VM2(
            _getProfilePath(restoreDirPath, item.id.toString()),
            _getProfilePath(homeDirPath, item.id.toString()),
          ),
        );
    final scriptsMigration = scripts.map(
      (item) => VM2(
        _getScriptPath(restoreDirPath, item.id.toString()),
        _getScriptPath(homeDirPath, item.id.toString()),
      ),
    );
    final fileMigrations = [...profilesMigration, ...scriptsMigration];
    for (final migration in fileMigrations) {
      if (!await File(migration.a).exists()) {
        throw appLocalizations.invalidBackupFile;
      }
    }
    return migrationData.copyWith(
      profiles: profiles,
      scripts: scripts,
      rules: results[2].cast<Rule>(),
      links: results[3].cast<ProfileRuleLink>(),
      fileMigrations: fileMigrations,
    );
  } finally {
    await database.close();
  }
}

bool _isLegacyBackupConfig(Map<String, Object?> config) {
  final scripts = config['scripts'];
  final scriptProps = config['scriptProps'];
  return config['profiles'] is List &&
      config['rules'] is List &&
      (scripts is List || scriptProps is Map) &&
      config['appSetting'] is Map &&
      config['themeProps'] is Map &&
      config['patchClashConfig'] is Map;
}

String _getScriptPath(String root, String fileName) {
  return join(root, 'scripts', '$fileName.js');
}

String _getProfilePath(String root, String fileName) {
  return join(root, 'profiles', '$fileName.yaml');
}

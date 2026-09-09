import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/core/controller.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/services/age_crypto.dart';
import 'package:fl_clash/services/config_key_store.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'clash_config.dart';
import 'state.dart';

part 'generated/profile.freezed.dart';
part 'generated/profile.g.dart';

typedef FetchManagedConfigCallback =
    Future<(Uint8List, String?)> Function(
      String paramString, {
      Future<void> Function(Uint8List bytes)? validate,
    });
FetchManagedConfigCallback? _fetchManagedConfigCallback;
bool Function()? _canFetchManagedConfigCallback;

/// Hook the cloud-account layer registers so [Profile.update] can wait for
/// token bootstrap to finish before issuing a managed-config fetch.
Future<void> Function()? _ensureCloudReady;

const _flclashEncryptedVersion = 0x02;

Future<void> _validateProfileBytes(Uint8List bytes) async {
  final message = await coreController.validateConfigWithBytes(
    base64Encode(bytes),
  );
  if (message.isNotEmpty) throw ConfigValidationException(message);
}

const reservedOutboundNames = {
  'DIRECT',
  'REJECT',
  'REJECT-DROP',
  'PASS',
  'PASS-RULE',
  'COMPATIBLE',
  'GLOBAL',
};

bool isEncryptedProfileBytes(Uint8List bytes) {
  if (AgeCrypto.isArmored(bytes)) {
    return true;
  }
  // Legacy FLEN (AES-GCM) format: still recognised so older snapshots are not
  // re-encrypted; new snapshots are written as age (see encryptProfileBytes).
  return bytes.length >= 5 &&
      bytes[0] == 0x46 &&
      bytes[1] == 0x4C &&
      bytes[2] == 0x45 &&
      bytes[3] == 0x4E &&
      bytes[4] == _flclashEncryptedVersion;
}

Future<Uint8List> encryptProfileBytes(Uint8List bytes) async {
  // At-rest encryption uses a per-device age identity (secret in platform
  // secure storage, injected into the core via InitParams) instead of the
  // shared compile-time profile key.
  final identity = await ConfigKeyStore.identity();
  return AgeCrypto.encrypt(bytes, identity.publicKeyBytes);
}

Future<Uint8List> ensureEncryptedProfileBytes(Uint8List bytes) async {
  if (isEncryptedProfileBytes(bytes)) {
    return bytes;
  }
  return encryptProfileBytes(bytes);
}

void registerFetchManagedConfig(FetchManagedConfigCallback callback) {
  _fetchManagedConfigCallback = callback;
}

void registerCanFetchManagedConfig(bool Function() callback) {
  _canFetchManagedConfigCallback = callback;
}

void registerEnsureCloudReady(Future<void> Function() ensure) {
  _ensureCloudReady = ensure;
}

@freezed
abstract class SubscriptionInfo with _$SubscriptionInfo {
  const factory SubscriptionInfo({
    @Default(0) int upload,
    @Default(0) int download,
    @Default(0) int total,
    @Default(0) int expire,
  }) = _SubscriptionInfo;

  factory SubscriptionInfo.fromJson(Map<String, Object?> json) =>
      _$SubscriptionInfoFromJson(json);

  factory SubscriptionInfo.formHString(String? info) {
    if (info == null) return const SubscriptionInfo();
    final list = info.split(';');
    final Map<String, int?> map = {};
    for (final i in list) {
      final keyValue = i.trim().split('=');
      if (keyValue.length >= 2) {
        map[keyValue[0]] = int.tryParse(keyValue[1]);
      }
    }
    return SubscriptionInfo(
      upload: map['upload'] ?? 0,
      download: map['download'] ?? 0,
      total: map['total'] ?? 0,
      expire: map['expire'] ?? 0,
    );
  }
}

@freezed
abstract class ProxyChain with _$ProxyChain {
  const factory ProxyChain({
    required int id,
    @Default(true) bool enable,
    @Default('') String name,
    @Default([]) List<String> proxies,
  }) = _ProxyChain;

  factory ProxyChain.create({
    String name = '',
    List<String> proxies = const [],
  }) {
    return ProxyChain(id: snowflake.id, name: name, proxies: proxies);
  }

  factory ProxyChain.fromJson(Map<String, Object?> json) =>
      _$ProxyChainFromJson(json);
}

@freezed
abstract class ProfileProxy with _$ProfileProxy {
  const factory ProfileProxy({
    required int id,
    @Default(true) bool enable,
    @Default('') String uri,
    @Default({}) Map<String, Object?> proxy,
  }) = _ProfileProxy;

  factory ProfileProxy.create({
    required String uri,
    required Map<String, Object?> proxy,
  }) {
    return ProfileProxy(id: snowflake.id, uri: uri, proxy: proxy);
  }

  factory ProfileProxy.fromJson(Map<String, Object?> json) =>
      _$ProfileProxyFromJson(json);
}

List<String> normalizeProxyChainProxies(Iterable<String> proxies) {
  return proxies
      .map((proxy) => proxy.trim())
      .where((proxy) => proxy.isNotEmpty)
      .toList();
}

class ProxyChainNameScope {
  final Set<String> targetNames;
  final Set<String> dialerNames;

  const ProxyChainNameScope({
    required this.targetNames,
    required this.dialerNames,
  });

  bool isValid(Iterable<String> proxies) {
    return getInvalidName(proxies) == null;
  }

  String? getInvalidName(Iterable<String> proxies) {
    final names = normalizeProxyChainProxies(proxies);
    for (var i = 0; i < names.length; i++) {
      final name = names[i];
      final isEntry = i == 0;
      final isExit = i == names.length - 1;
      if (isEntry) {
        if (!dialerNames.contains(name)) {
          return name;
        }
        continue;
      }
      if (!targetNames.contains(name)) {
        return name;
      }
      if (!isExit && !dialerNames.contains(name)) {
        return name;
      }
    }
    return null;
  }
}

Map<String, Object?> normalizeProfileProxyMap(Map<String, Object?> proxy) {
  final nextProxy = <String, Object?>{};
  for (final entry in proxy.entries) {
    final key = entry.key.trim();
    if (key.isEmpty) {
      continue;
    }
    final value = _normalizeProfileProxyValue(entry.value);
    if (value != null) {
      nextProxy[key] = value;
    }
  }
  return nextProxy;
}

Object? _normalizeProfileProxyValue(Object? value) {
  if (value == null) {
    return null;
  }
  if (value is String) {
    final nextValue = value.trim();
    return nextValue.isEmpty ? null : nextValue;
  }
  if (value is Map) {
    final nextMap = <String, Object?>{};
    for (final entry in value.entries) {
      final key = entry.key?.toString().trim() ?? '';
      if (key.isEmpty) {
        continue;
      }
      final nextValue = _normalizeProfileProxyValue(entry.value);
      if (nextValue != null) {
        nextMap[key] = nextValue;
      }
    }
    return nextMap.isEmpty ? null : nextMap;
  }
  if (value is Iterable) {
    final nextList = value
        .map(_normalizeProfileProxyValue)
        .whereType<Object>()
        .toList();
    return nextList.isEmpty ? null : nextList;
  }
  return value;
}

extension ProfileProxyExt on ProfileProxy {
  String get name {
    final proxyMap = this.proxy;
    final name = proxyMap['name'];
    return name is String ? name.trim() : '';
  }

  String get type {
    final proxyMap = this.proxy;
    final type = proxyMap['type'];
    return type is String ? type.trim() : '';
  }

  bool get isValid => enable && name.isNotEmpty && type.isNotEmpty;

  Map<String, Object?> get normalizedProxy {
    final nextProxy = Map<String, Object?>.from(this.proxy);
    nextProxy['name'] = name;
    nextProxy['type'] = type;
    return normalizeProfileProxyMap(nextProxy)..remove('dialer-proxy');
  }
}

extension ProfileProxiesExt on List<ProfileProxy> {
  List<ProfileProxy> copyAndPut(ProfileProxy profileProxy) {
    final nextList = List<ProfileProxy>.from(this);
    final index = nextList.indexWhere((item) => item.id == profileProxy.id);
    if (index == -1) {
      nextList.insert(0, profileProxy);
    } else {
      nextList[index] = profileProxy;
    }
    return nextList;
  }
}

extension ProxyChainExt on ProxyChain {
  List<String> get normalizedProxies => normalizeProxyChainProxies(proxies);

  String? get entryProxyName {
    final proxies = normalizedProxies;
    return proxies.isNotEmpty ? proxies.first : null;
  }

  String? get exitProxyName {
    final proxies = normalizedProxies;
    return proxies.length >= 2 ? proxies.last : null;
  }

  Map<String, String> get dialerProxyRelations {
    final proxies = normalizedProxies;
    final relations = <String, String>{};
    for (var i = 1; i < proxies.length; i++) {
      relations[proxies[i]] = proxies[i - 1];
    }
    return relations;
  }

  ProxyChain get disabledIfIncomplete {
    return normalizedProxies.length < 2 ? copyWith(enable: false) : this;
  }

  ProxyChain copyAndRenameProxy(String previousName, String nextName) {
    if (previousName.isEmpty || nextName.isEmpty || previousName == nextName) {
      return this;
    }
    return copyWith(
      proxies: proxies.map((proxy) {
        return proxy.trim() == previousName ? nextName : proxy;
      }).toList(),
    );
  }

  ProxyChain copyAndRemoveProxies(Set<String> proxyNames) {
    if (proxyNames.isEmpty) {
      return this;
    }
    return copyWith(
      proxies: proxies
          .where((proxy) => !proxyNames.contains(proxy.trim()))
          .toList(),
    ).disabledIfIncomplete;
  }

  bool get hasDuplicateProxy {
    final proxies = normalizedProxies;
    return proxies.toSet().length != proxies.length;
  }

  bool get isValid =>
      enable && normalizedProxies.length >= 2 && !hasDuplicateProxy;

  String get label {
    if (name.trim().isNotEmpty) {
      return name.trim();
    }
    final proxies = normalizedProxies;
    if (proxies.isNotEmpty) {
      return proxies.join(' -> ');
    }
    return id.toString();
  }
}

extension ProxyChainsExt on List<ProxyChain> {
  List<ProxyChain> copyAndPut(ProxyChain proxyChain) {
    final nextList = List<ProxyChain>.from(this);
    final index = nextList.indexWhere((item) => item.id == proxyChain.id);
    if (index == -1) {
      nextList.insert(0, proxyChain);
    } else {
      nextList[index] = proxyChain;
    }
    return nextList;
  }

  List<ProxyChain> copyAndReorder(int oldIndex, int newIndex) {
    final nextList = List<ProxyChain>.from(this);
    final proxyChain = nextList.removeAt(oldIndex);
    nextList.insert(newIndex, proxyChain);
    return nextList;
  }

  List<ProxyChain> copyAndRenameProxy(String? previousName, String nextName) {
    if (previousName == null) {
      return this;
    }
    return map((chain) {
      return chain.copyAndRenameProxy(previousName, nextName);
    }).toList();
  }

  List<ProxyChain> copyAndRemoveProxies(Set<String> proxyNames) {
    if (proxyNames.isEmpty) {
      return this;
    }
    return map((chain) => chain.copyAndRemoveProxies(proxyNames)).toList();
  }

  List<ProxyChain> copyAndDisableChainsUsingProxy(String proxyName) {
    if (proxyName.isEmpty) {
      return this;
    }
    var changed = false;
    final nextList = map((chain) {
      if (!chain.normalizedProxies.contains(proxyName)) {
        return chain;
      }
      changed = true;
      return chain.copyWith(enable: false);
    }).toList();
    return changed ? nextList : this;
  }

  ({bool hasDisabledConflicts, List<ProxyChain> proxyChains})
  copyAndPutResolvingTargetConflicts(ProxyChain proxyChain) {
    final nextProxyChain = proxyChain.copyWith(enable: true);
    final nextRelations = nextProxyChain.dialerProxyRelations;
    final nextEntryProxyName = nextProxyChain.entryProxyName;
    final nextExitProxyName = nextProxyChain.exitProxyName;
    var hasDisabledConflicts = false;
    final nextList = map((chain) {
      if (chain.id == nextProxyChain.id || !chain.isValid) {
        return chain;
      }
      final chainEntryProxyName = chain.entryProxyName;
      final chainRelations = chain.dialerProxyRelations;
      final hasExitConflict =
          nextExitProxyName != null && chain.exitProxyName == nextExitProxyName;
      final hasEntryConflict =
          (nextEntryProxyName != null &&
              chainRelations.containsKey(nextEntryProxyName)) ||
          (chainEntryProxyName != null &&
              nextRelations.containsKey(chainEntryProxyName));
      final hasConflict =
          hasExitConflict ||
          hasEntryConflict ||
          chainRelations.entries.any((entry) {
            final dialer = nextRelations[entry.key];
            return dialer != null && dialer != entry.value;
          });
      if (!hasConflict) {
        return chain;
      }
      hasDisabledConflicts = true;
      return chain.copyWith(enable: false);
    }).toList();
    return (
      hasDisabledConflicts: hasDisabledConflicts,
      proxyChains: nextList.copyAndPut(nextProxyChain),
    );
  }
}

String? _findProxyChainCycleName(
  Map<String, String> targetDialerMap,
  String target,
) {
  final seen = <String>{};
  var current = target;
  while (true) {
    if (!seen.add(current)) {
      return current;
    }
    final dialer = targetDialerMap[current];
    if (dialer == null) {
      return null;
    }
    current = dialer;
  }
}

String? _findProxyChainDuplicateExitName(Iterable<ProxyChain> proxyChains) {
  final exitNames = <String>{};
  for (final proxyChain in proxyChains.where((item) => item.isValid)) {
    final exitProxyName = proxyChain.exitProxyName;
    if (exitProxyName == null) {
      continue;
    }
    if (!exitNames.add(exitProxyName)) {
      return exitProxyName;
    }
  }
  return null;
}

String? _findProxyChainEntryTargetName(Iterable<ProxyChain> proxyChains) {
  final targetNames = <String>{};
  final entries = <String>[];
  for (final proxyChain in proxyChains.where((item) => item.isValid)) {
    targetNames.addAll(proxyChain.dialerProxyRelations.keys);
    final entryProxyName = proxyChain.entryProxyName;
    if (entryProxyName != null) {
      entries.add(entryProxyName);
    }
  }
  for (final entry in entries) {
    if (targetNames.contains(entry)) {
      return entry;
    }
  }
  return null;
}

String? findProxyChainConflictName(
  Iterable<ProxyChain> proxyChains, {
  Map<String, String> existingRelations = const {},
}) {
  final duplicateExitName = _findProxyChainDuplicateExitName(proxyChains);
  if (duplicateExitName != null) {
    return duplicateExitName;
  }
  final entryTargetName = _findProxyChainEntryTargetName(proxyChains);
  if (entryTargetName != null) {
    return entryTargetName;
  }
  final targetDialerMap = Map<String, String>.from(existingRelations);
  for (final target in targetDialerMap.keys) {
    final cycleName = _findProxyChainCycleName(targetDialerMap, target);
    if (cycleName != null) return cycleName;
  }
  for (final proxyChain in proxyChains.where((item) => item.isValid)) {
    for (final entry in proxyChain.dialerProxyRelations.entries) {
      final target = entry.key;
      final dialer = entry.value;
      final existingDialer = targetDialerMap[target];
      if (existingDialer != null && existingDialer != dialer) {
        return target;
      }
      targetDialerMap[target] = dialer;
      final cycleName = _findProxyChainCycleName(targetDialerMap, target);
      if (cycleName != null) {
        return cycleName;
      }
    }
  }
  return null;
}

@freezed
abstract class Profile with _$Profile {
  const factory Profile({
    required int id,
    @Default('') String label,
    String? currentGroupName,
    @Default('') String url,
    DateTime? lastUpdateDate,
    required Duration autoUpdateDuration,
    SubscriptionInfo? subscriptionInfo,
    @Default(true) bool autoUpdate,
    @Default({}) Map<String, String> selectedMap,
    @Default({}) Set<String> unfoldSet,
    @Default(OverwriteType.standard) OverwriteType overwriteType,
    @Default([]) List<ProxyChain> proxyChains,
    @Default([]) List<ProfileProxy> profileProxies,
    @Default([]) List<ProxyGroup> customProxyGroups,
    @Default([]) List<Rule> customRules,
    int? scriptId,
    int? order,
  }) = _Profile;

  factory Profile.fromJson(Map<String, Object?> json) =>
      _$ProfileFromJson(json);

  factory Profile.normal({String? label, String url = ''}) {
    final id = snowflake.id;
    return Profile(
      label: label ?? '',
      url: url,
      id: id,
      autoUpdateDuration: defaultUpdateDuration,
    );
  }
}

extension ProfileCustomOverwriteExt on Profile {
  Profile copyAndPutCustomProxyGroup(
    ProxyGroup proxyGroup, {
    ProxyGroup? previous,
  }) {
    final previousName = previous?.name;
    final nextName = proxyGroup.name;
    final groups = List<ProxyGroup>.from(customProxyGroups);
    if (previous == null) {
      groups.add(proxyGroup);
    } else {
      final index = groups.indexOf(previous);
      if (index == -1) {
        return this;
      }
      groups[index] = proxyGroup;
    }
    return copyWith(
      customProxyGroups: groups,
    ).copyAndRenameOutboundReferences(previousName, nextName);
  }

  Profile copyAndRenameOutboundReferences(
    String? previousName,
    String nextName,
  ) {
    if (previousName == null ||
        previousName.isEmpty ||
        previousName == nextName) {
      return this;
    }
    final renamedGroups = customProxyGroups.map((group) {
      final proxies = group.proxies;
      if (proxies == null || !proxies.contains(previousName)) {
        return group;
      }
      return group.copyWith(
        proxies: proxies
            .map((name) => name == previousName ? nextName : name)
            .toList(),
      );
    }).toList();
    final renamedRules = customRules.map((rule) {
      return rule.copyWith(
        value: renameRuleTarget(rule.value, previousName, nextName),
      );
    }).toList();
    final renamedSelectedMap = <String, String>{};
    for (final entry in selectedMap.entries) {
      final key = entry.key == previousName ? nextName : entry.key;
      final value = entry.value == previousName ? nextName : entry.value;
      renamedSelectedMap[key] = value;
    }
    final renamedUnfoldSet = unfoldSet
        .map((name) => name == previousName ? nextName : name)
        .toSet();

    return copyWith(
      currentGroupName: currentGroupName == previousName
          ? nextName
          : currentGroupName,
      selectedMap: renamedSelectedMap,
      unfoldSet: renamedUnfoldSet,
      proxyChains: proxyChains.copyAndRenameProxy(previousName, nextName),
      customProxyGroups: renamedGroups,
      customRules: renamedRules,
    );
  }

  bool hasCustomOutboundReferences(
    String name, {
    ProxyGroup? excludingGroup,
    bool includeProxyChains = true,
  }) {
    final groupReference = customProxyGroups.any((group) {
      return group != excludingGroup &&
          (group.proxies?.contains(name) ?? false);
    });
    final ruleReference = customRules.any(
      (rule) => ruleTarget(rule.value) == name,
    );
    final chainReference =
        includeProxyChains &&
        proxyChains.any((chain) => chain.normalizedProxies.contains(name));
    return groupReference || ruleReference || chainReference;
  }

  Profile copyAndRemoveCustomProxyGroup(ProxyGroup group) {
    final name = group.name;
    return copyWith(
      customProxyGroups: customProxyGroups
          .where((item) => item != group)
          .toList(),
    ).copyAndRemoveOutboundCaches({name});
  }

  Profile copyAndRemoveOutboundCaches(Set<String> names) {
    if (names.isEmpty) {
      return this;
    }
    final nextSelectedMap = Map<String, String>.from(selectedMap)
      ..removeWhere(
        (key, value) => names.contains(key) || names.contains(value),
      );
    return copyWith(
      currentGroupName: names.contains(currentGroupName)
          ? null
          : currentGroupName,
      selectedMap: nextSelectedMap,
      unfoldSet: unfoldSet.where((item) => !names.contains(item)).toSet(),
    );
  }
}

Set<String> rawProxyGroupNames(Map rawConfig) {
  final groups = rawConfig['proxy-groups'];
  if (groups is! List) {
    return const {};
  }
  return groups
      .whereType<Map>()
      .map((group) => group['name'])
      .whereType<String>()
      .map((name) => name.trim())
      .where((name) => name.isNotEmpty)
      .toSet();
}

String? findProxyGroupCycle(List<ProxyGroup> groups) {
  final names = groups.map((group) => group.name).toSet();
  final dependencies = <String, Set<String>>{
    for (final group in groups)
      group.name: {...?group.proxies?.where(names.contains)},
  };
  final visiting = <String>{};
  final visited = <String>{};

  String? visit(String name) {
    if (visiting.contains(name)) {
      return name;
    }
    if (!visited.add(name)) {
      return null;
    }
    visiting.add(name);
    for (final dependency in dependencies[name] ?? const <String>{}) {
      final cycle = visit(dependency);
      if (cycle != null) {
        return cycle;
      }
    }
    visiting.remove(name);
    return null;
  }

  for (final name in names) {
    final cycle = visit(name);
    if (cycle != null) {
      return cycle;
    }
  }
  return null;
}

String renameRuleTarget(String value, String previousName, String nextName) {
  final parts = value.split(',');
  final targetIndex = _ruleTargetIndex(parts);
  if (targetIndex < 0 || parts[targetIndex].trim() != previousName) {
    return value;
  }
  final target = parts[targetIndex];
  final leadingLength = target.length - target.trimLeft().length;
  final trailingLength = target.length - target.trimRight().length;
  parts[targetIndex] =
      '${target.substring(0, leadingLength)}$nextName${target.substring(target.length - trailingLength)}';
  return parts.join(',');
}

String? ruleTarget(String value) {
  final parts = value.split(',');
  final targetIndex = _ruleTargetIndex(parts);
  return targetIndex < 0 ? null : parts[targetIndex].trim();
}

String? findRawOutboundReference(
  Map<String, dynamic> rawConfig,
  String name, {
  bool includeTopLevelRules = true,
  bool includeProxyGroups = true,
}) {
  String? scanMapField(Object? value, String key, String path) {
    if (value is Map && value[key]?.toString() == name) {
      return '$path.$key';
    }
    return null;
  }

  String? scanRules(Object? value, String path) {
    if (value is! List) {
      return null;
    }
    for (var index = 0; index < value.length; index++) {
      final rule = value[index];
      if (rule is String && ruleTarget(rule) == name) {
        return '$path[$index]';
      }
    }
    return null;
  }

  String? scanDnsServers(Object? value, String path) {
    if (value is String) {
      final fragment = Uri.tryParse(value)?.fragment;
      if (fragment == null || fragment.isEmpty) return null;
      // Match mihomo's DNS fragment parser: key=value entries are options,
      // while the last bare entry selects the outbound (after URI decoding).
      String? outbound;
      for (final part in Uri.decodeComponent(fragment).split('&')) {
        if (!part.contains('=')) outbound = part;
      }
      return outbound == name ? path : null;
    }
    if (value is List) {
      for (var index = 0; index < value.length; index++) {
        final reference = scanDnsServers(value[index], '$path[$index]');
        if (reference != null) return reference;
      }
    } else if (value is Map) {
      for (final entry in value.entries) {
        final reference = scanDnsServers(entry.value, '$path.${entry.key}');
        if (reference != null) return reference;
      }
    }
    return null;
  }

  if (includeProxyGroups) {
    final groups = rawConfig['proxy-groups'];
    if (groups is List) {
      for (var groupIndex = 0; groupIndex < groups.length; groupIndex++) {
        final group = groups[groupIndex];
        if (group is! Map) {
          continue;
        }
        final members = group['proxies'];
        if (members is! List) {
          continue;
        }
        for (var memberIndex = 0; memberIndex < members.length; memberIndex++) {
          if (members[memberIndex] == name) {
            return 'proxy-groups[$groupIndex].proxies[$memberIndex]';
          }
        }
      }
    }
  }

  final proxies = rawConfig['proxies'];
  if (proxies is List) {
    for (var index = 0; index < proxies.length; index++) {
      final path = scanMapField(
        proxies[index],
        'dialer-proxy',
        'proxies[$index]',
      );
      if (path != null) {
        return path;
      }
    }
  }

  final providers = rawConfig['proxy-providers'];
  if (providers is Map) {
    for (final entry in providers.entries) {
      final providerPath = 'proxy-providers.${entry.key}';
      for (final key in const ['proxy', 'dialer-proxy']) {
        final path = scanMapField(entry.value, key, providerPath);
        if (path != null) {
          return path;
        }
      }
      if (entry.value is Map) {
        final provider = entry.value as Map;
        final overridePath = scanMapField(
          provider['override'],
          'dialer-proxy',
          '$providerPath.override',
        );
        if (overridePath != null) {
          return overridePath;
        }
        final payload = provider['payload'];
        if (payload is List) {
          for (var index = 0; index < payload.length; index++) {
            final path = scanMapField(
              payload[index],
              'dialer-proxy',
              '$providerPath.payload[$index]',
            );
            if (path != null) {
              return path;
            }
          }
        }
      }
    }
  }

  final ruleProviders = rawConfig['rule-providers'];
  if (ruleProviders is Map) {
    for (final entry in ruleProviders.entries) {
      final path = scanMapField(
        entry.value,
        'proxy',
        'rule-providers.${entry.key}',
      );
      if (path != null) {
        return path;
      }
    }
  }

  final ntpPath = scanMapField(rawConfig['ntp'], 'dialer-proxy', 'ntp');
  if (ntpPath != null) {
    return ntpPath;
  }

  final dns = rawConfig['dns'];
  if (dns is Map) {
    for (final key in const [
      'nameserver',
      'fallback',
      'default-nameserver',
      'proxy-server-nameserver',
      'direct-nameserver',
      'nameserver-policy',
      'proxy-server-nameserver-policy',
    ]) {
      final path = scanDnsServers(dns[key], 'dns.$key');
      if (path != null) return path;
    }
  }

  final listeners = rawConfig['listeners'];
  if (listeners is List) {
    for (var index = 0; index < listeners.length; index++) {
      final path = scanMapField(listeners[index], 'proxy', 'listeners[$index]');
      if (path != null) {
        return path;
      }
    }
  }

  final subRules = rawConfig['sub-rules'];
  if (subRules is Map) {
    for (final entry in subRules.entries) {
      final path = scanRules(entry.value, 'sub-rules.${entry.key}');
      if (path != null) {
        return path;
      }
    }
  }

  return includeTopLevelRules ? scanRules(rawConfig['rules'], 'rules') : null;
}

int _ruleTargetIndex(List<String> parts) {
  if (parts.length < 2) {
    return -1;
  }
  return switch (parts.first.trim().toUpperCase()) {
    'MATCH' => 1,
    'NOT' ||
    'OR' ||
    'AND' ||
    'DOMAIN-REGEX' ||
    'PROCESS-NAME-REGEX' ||
    'PROCESS-PATH-REGEX' => parts.length - 1,
    'DOMAIN' ||
    'DOMAIN-SUFFIX' ||
    'DOMAIN-KEYWORD' ||
    'DOMAIN-WILDCARD' ||
    'GEOSITE' ||
    'GEOIP' ||
    'SRC-GEOIP' ||
    'IP-ASN' ||
    'SRC-IP-ASN' ||
    'IP-CIDR' ||
    'IP-CIDR6' ||
    'SRC-IP-CIDR' ||
    'IP-SUFFIX' ||
    'SRC-IP-SUFFIX' ||
    'SRC-PORT' ||
    'DST-PORT' ||
    'IN-PORT' ||
    'DSCP' ||
    'PROCESS-NAME' ||
    'PROCESS-PATH' ||
    'PROCESS-NAME-WILDCARD' ||
    'PROCESS-PATH-WILDCARD' ||
    'NETWORK' ||
    'SNIFF-PROTOCOL' ||
    'UID' ||
    'IN-TYPE' ||
    'IN-USER' ||
    'IN-NAME' ||
    'RULE-SET' => parts.length > 2 ? 2 : -1,
    _ => -1,
  };
}

@freezed
abstract class ProfileRuleLink with _$ProfileRuleLink {
  const factory ProfileRuleLink({
    int? profileId,
    required int ruleId,
    RuleScene? scene,
    String? order,
  }) = _ProfileRuleLink;
}

extension ProfileRuleLinkExt on ProfileRuleLink {
  String get key {
    final splits = <String?>[
      profileId?.toString(),
      ruleId.toString(),
      scene?.name,
    ];
    return splits.where((item) => item != null).join('_');
  }
}

// @freezed
// abstract class Overwrite with _$Overwrite {
//   const factory Overwrite({
//     @Default(OverwriteType.standard) OverwriteType type,
//     @Default(StandardOverwrite()) StandardOverwrite standardOverwrite,
//     @Default(ScriptOverwrite()) ScriptOverwrite scriptOverwrite,
//   }) = _Overwrite;
//
//   factory Overwrite.fromJson(Map<String, Object?> json) =>
//       _$OverwriteFromJson(json);
// }

@freezed
abstract class StandardOverwrite with _$StandardOverwrite {
  const factory StandardOverwrite({
    @Default([]) List<Rule> addedRules,
    @Default([]) List<int> disabledRuleIds,
  }) = _StandardOverwrite;

  factory StandardOverwrite.fromJson(Map<String, Object?> json) =>
      _$StandardOverwriteFromJson(json);
}

@freezed
abstract class ScriptOverwrite with _$ScriptOverwrite {
  const factory ScriptOverwrite({int? scriptId}) = _ScriptOverwrite;

  factory ScriptOverwrite.fromJson(Map<String, Object?> json) =>
      _$ScriptOverwriteFromJson(json);
}

extension ProfilesExt on List<Profile> {
  Profile? getProfile(int? profileId) {
    final index = indexWhere((profile) => profile.id == profileId);
    return index == -1 ? null : this[index];
  }

  String _getLabel(String label, int id) {
    final realLabel = label.takeFirstValid([id.toString()]);
    final hasDup =
        indexWhere(
          (element) => element.label == realLabel && element.id != id,
        ) !=
        -1;
    if (hasDup) {
      return _getLabel(utils.getOverwriteLabel(realLabel), id);
    } else {
      return label;
    }
  }

  VM2<List<Profile>, Profile> copyAndAddProfile(Profile profile) {
    final List<Profile> profilesTemp = List.from(this);
    final index = profilesTemp.indexWhere(
      (element) => element.id == profile.id,
    );
    final updateProfile = profile.copyWith(
      label: _getLabel(profile.label, profile.id),
    );
    if (index == -1) {
      profilesTemp.add(updateProfile);
    } else {
      profilesTemp[index] = updateProfile;
    }
    return VM2(profilesTemp, updateProfile);
  }
}

extension ProfileExtension on Profile {
  ProfileType get type => url.isEmpty ? ProfileType.file : ProfileType.url;

  String get realLabel => label.takeFirstValid([id.toString()]);

  bool get isoixCloudProfile {
    return isoixCloudProfileUrl(url);
  }

  String get fileName => '$id.yaml';

  String get updatingKey => 'profile_$id';

  bool get includeInPortableBackup => !isoixCloudProfile;

  Future<bool> hasLocalConfigSnapshot() async {
    return await getExistingFilePath() != null;
  }

  Future<String?> getExistingFilePath() async {
    final mFile = await _getFile(false);
    if (!await mFile.exists()) return null;

    if (!isoixCloudProfile) {
      return mFile.path;
    }

    if (!await coreController.isInit) {
      return mFile.path;
    }

    final message = await coreController.validateConfig(mFile.path);
    if (message.isEmpty) {
      return mFile.path;
    }

    commonPrint.log(
      'discarding invalid oixCloud snapshot $id: $message',
      logLevel: LogLevel.warning,
    );
    await mFile.safeDelete();
    return null;
  }

  Future<Profile?> checkAndUpdateAndCopy() async {
    if (isoixCloudProfile) {
      if (await hasLocalConfigSnapshot()) return null;
      return update();
    }
    final mFile = await _getFile(false);
    final isExists = await mFile.exists();
    if (isExists || url.isEmpty) {
      return null;
    }
    return update();
  }

  Future<File> _getFile([bool autoCreate = true]) async {
    final fileName = id.toString();
    final path = await appPath.getProfilePath(fileName);
    final file = File(path);

    final isExists = await file.exists();
    if (!isExists && autoCreate) {
      final createdFile = await file.create(recursive: true);
      return createdFile;
    }

    return file;
  }

  Future<File> get file => _getFile();

  Future<void> _replaceWithEncryptedSnapshot(Uint8List bytes) async {
    final encryptedBytes = await ensureEncryptedProfileBytes(bytes);
    final mFile = await _getFile(false);
    final tempFile = File(await appPath.getProfilePath('.$id'));

    try {
      await tempFile.create(recursive: true);
      await tempFile.writeAsBytes(encryptedBytes, flush: true);
      await durableRename(tempFile.path, mFile.path);
    } catch (error, stackTrace) {
      try {
        await tempFile.safeDelete();
      } catch (_) {}
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<Profile> update() async {
    if (isoixCloudProfile) {
      final fetch = _fetchManagedConfigCallback;
      if (fetch == null) throw Exception('fetchManagedConfig not registered');

      // Wait for cloud-account bootstrap so the API client has its token.
      await _ensureCloudReady?.call();
      if (!(_canFetchManagedConfigCallback?.call() ?? true)) {
        return this;
      }

      final params = await CloudParamsStorage.load();
      final paramWithTfo = params.encodeWithTfo();
      final (bytes, userinfo) = await fetch(
        paramWithTfo,
        validate: _validateProfileBytes,
      );
      final profileWithLabel = copyWith(
        label: label.isNotEmpty ? label : 'oixCloud',
        url: oixCloudManagedProfileUrl,
      );
      return profileWithLabel
          .copyWith(subscriptionInfo: SubscriptionInfo.formHString(userinfo))
          ._saveValidatedFile(bytes);
    }

    final response = await request.getFileResponseForUrl(
      url,
      validate: _validateProfileBytes,
    );
    final disposition = response.headers.value('content-disposition');
    final userinfo = response.headers.value('subscription-userinfo');
    return copyWith(
      label: label.takeFirstValid([
        utils.getFileNameForDisposition(disposition),
        id.toString(),
      ]),
      subscriptionInfo: SubscriptionInfo.formHString(userinfo),
    )._saveValidatedFile(response.data!);
  }

  Future<Profile> saveFile(Uint8List bytes) async {
    return storageLock.synchronized(() => _saveFileUnlocked(bytes));
  }

  Future<Profile> _saveValidatedFile(Uint8List bytes) => storageLock
      .synchronized(() => _saveFileUnlocked(bytes, alreadyValidated: true));

  Future<Profile> _saveFileUnlocked(
    Uint8List bytes, {
    bool alreadyValidated = false,
  }) async {
    if (isoixCloudProfile) {
      if (!alreadyValidated) await _validateProfileBytes(bytes);

      await _replaceWithEncryptedSnapshot(bytes);

      return copyWith(lastUpdateDate: DateTime.now());
    }

    final path = await appPath.tempFilePath;
    final tempFile = File(path);
    try {
      await tempFile.safeWriteAsBytes(bytes);
      commonPrint.log('====== saveFile bytes length: ${bytes.length}');
      if (!alreadyValidated) {
        final message = await coreController.validateConfig(path);
        if (message.isNotEmpty) {
          commonPrint.log('====== validateConfig Message: $message');
          throw ConfigValidationException(message);
        }
      }
      final mFile = await file;
      await tempFile.copy(mFile.path);
      return copyWith(lastUpdateDate: DateTime.now());
    } finally {
      await tempFile.safeDelete();
    }
  }

  Future<Profile> saveFileWithPath(String path) async {
    return storageLock.synchronized(() async {
      final message = await coreController.validateConfig(path);
      if (message.isNotEmpty) {
        throw ConfigValidationException(message);
      }
      final mFile = await file;
      await File(path).copy(mFile.path);
      return copyWith(lastUpdateDate: DateTime.now());
    });
  }
}

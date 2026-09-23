import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';

class Migration {
  static Migration? _instance;

  Migration._internal();

  final currentVersion = 2;

  factory Migration() {
    _instance ??= Migration._internal();
    return _instance!;
  }

  Future<Config> migrationIfNeeded(
    Map<String, Object?>? configMap, {
    required Future<Config> Function(MigrationData data) sync,
    Future<void> Function(Config config)? persist,
  }) async {
    final persistConfig = persist ?? preferences.saveConfig;
    var oldVersion = await preferences.getVersion();
    if (oldVersion == 0 && isCurrentConfigShape(configMap)) {
      final narrowed = narrowLegacy172Bypass(configMap);
      final config = Config.realFromJson(narrowed);
      if (!identical(narrowed, configMap)) {
        await persistConfig(config);
      }
      await preferences.setVersion(currentVersion);
      await preferences.clearClashConfig();
      return config;
    }
    if (oldVersion == 1 || oldVersion == currentVersion) {
      final narrowed = oldVersion == 1
          ? narrowLegacy172Bypass(configMap)
          : configMap;
      Config? config;
      try {
        config = Config.realFromJson(narrowed);
      } catch (_) {
        final isV0 = configMap?['proxiesStyle'] != null;
        if (isV0) {
          oldVersion = 0;
        } else {
          throw 'Local data is damaged. A reset is required to fix this issue.';
        }
      }
      if (config != null) {
        if (oldVersion != currentVersion) {
          if (!identical(narrowed, configMap)) {
            await persistConfig(config);
          }
          await preferences.setVersion(currentVersion);
        }
        return config;
      }
    }
    MigrationData data = MigrationData(configMap: configMap);
    var clearLegacyClashConfig = false;
    if (oldVersion == 0 && configMap != null) {
      final clashConfigMap = await preferences.getClashConfigMap();
      if (clashConfigMap != null) {
        configMap['patchClashConfig'] = clashConfigMap;
        clearLegacyClashConfig = true;
      }
      data = await oldToNowTask(configMap);
      data = data.copyWith(configMap: narrowLegacy172Bypass(data.configMap));
    }
    final res = await sync(data);
    await preferences.setVersion(currentVersion);
    if (clearLegacyClashConfig) {
      await preferences.clearClashConfig();
    }
    return res;
  }
}

bool isCurrentConfigShape(Map<String, Object?>? config) {
  return config != null &&
      config.containsKey('appSettingProps') &&
      config.containsKey('patchClashConfig') &&
      !config.containsKey('profiles');
}

// '172.2*' also bypassed public 172.2.x.x and 172.200-255.x.x hosts.
const _legacy172Bypass = '172.2*';

Map<String, Object?>? narrowLegacy172Bypass(Map<String, Object?>? config) {
  if (config == null) return null;
  final networkProps = config['networkProps'];
  if (networkProps is! Map) return config;
  final bypassDomain = networkProps['bypassDomain'];
  if (bypassDomain is! List || !bypassDomain.contains(_legacy172Bypass)) {
    return config;
  }
  final narrowed = <Object?>[];
  for (final entry in bypassDomain) {
    if (entry != _legacy172Bypass) {
      narrowed.add(entry);
      continue;
    }
    for (var octet = 20; octet <= 29; octet++) {
      final replacement = '172.$octet.*';
      if (!bypassDomain.contains(replacement) &&
          !narrowed.contains(replacement)) {
        narrowed.add(replacement);
      }
    }
  }
  return {
    ...config,
    'networkProps': {
      ...Map<String, Object?>.from(networkProps),
      'bypassDomain': narrowed,
    },
  };
}

final migration = Migration();

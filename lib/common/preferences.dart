import 'dart:convert';

import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/services/config_key_store.dart';
import 'package:fl_clash/services/durable_config_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constant.dart';
import 'path.dart';

final durableConfigStore = DurableConfigStore(
  identityProvider: ConfigKeyStore.identity,
);

class Preferences {
  static Preferences? _instance;
  Future<SharedPreferences?>? _sharedPreferences;

  Future<bool> get isInit async => await _loadSharedPreferences() != null;

  Preferences._internal();

  factory Preferences() {
    _instance ??= Preferences._internal();
    return _instance!;
  }

  Future<SharedPreferences?> _loadSharedPreferences() {
    return _sharedPreferences ??= _createSharedPreferences();
  }

  Future<SharedPreferences?> _createSharedPreferences() async {
    try {
      return await SharedPreferences.getInstance();
    } catch (_) {
      return null;
    }
  }

  Future<int> getVersion() async {
    final preferences = await _loadSharedPreferences();
    return preferences?.getInt('version') ?? 0;
  }

  Future<void> setVersion(int version) async {
    final preferences = await _loadSharedPreferences();
    await preferences?.setInt('version', version);
  }

  Future<void> saveShareState(SharedState shareState) async {
    final preferences = await _loadSharedPreferences();
    await preferences?.setString('sharedState', json.encode(shareState));
  }

  Future<Map<String, Object?>?> getConfigMap() async {
    final durablePath = await appPath.durableConfigPath;
    final durable = await durableConfigStore.read(durablePath);
    if (durable != null) {
      return durable;
    }
    final preferences = await _loadSharedPreferences();
    final configString = preferences?.getString(configKey);
    if (configString == null) return null;
    final decoded = json.decode(configString);
    if (decoded is! Map) {
      throw const FormatException('stored config must be a JSON object');
    }
    return Map<String, Object?>.from(decoded);
  }

  Future<Map<String, Object?>?> getClashConfigMap() async {
    try {
      final preferences = await _loadSharedPreferences();
      final clashConfigString = preferences?.getString(clashConfigKey);
      if (clashConfigString == null) return null;
      return json.decode(clashConfigString);
    } catch (_) {
      return null;
    }
  }

  Future<void> clearClashConfig() async {
    try {
      final preferences = await _loadSharedPreferences();
      await preferences?.remove(clashConfigKey);
      return;
    } catch (_) {
      return;
    }
  }

  Future<Config?> getConfig() async {
    final configMap = await getConfigMap();
    if (configMap == null) {
      return null;
    }
    return Config.fromJson(configMap);
  }

  Future<bool> saveConfig(Config config) async {
    await durableConfigStore.write(await appPath.durableConfigPath, config);
    final preferences = await _loadSharedPreferences();
    try {
      await preferences?.setString(
        configKey,
        json.encode(sanitizeConfigForPreferences(config)),
      );
    } catch (_) {}
    return true;
  }

  Future<void> saveDurableConfig(Config config) async {
    await durableConfigStore.write(await appPath.durableConfigPath, config);
  }

  Future<void> clearPreferences({Set<String> preserveKeys = const {}}) async {
    final sharedPreferencesIns = await _loadSharedPreferences();
    if (sharedPreferencesIns != null) {
      for (final key in sharedPreferencesIns.getKeys()) {
        if (preserveKeys.contains(key)) {
          continue;
        }
        if (!await sharedPreferencesIns.remove(key)) {
          throw StateError('failed to clear preference: $key');
        }
      }
    }
    await durableConfigStore.clear(await appPath.durableConfigPath);
  }
}

final preferences = Preferences();

Config sanitizeConfigForPreferences(Config config) {
  final davProps = config.davProps;
  return config.copyWith(
    davProps: davProps?.copyWith(password: ''),
    patchClashConfig: config.patchClashConfig.copyWith(secret: ''),
  );
}

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';

class Migration {
  static Migration? _instance;

  Migration._internal();

  final currentVersion = 1;

  factory Migration() {
    _instance ??= Migration._internal();
    return _instance!;
  }

  Future<Config> migrationIfNeeded(
    Map<String, Object?>? configMap, {
    required Future<Config> Function(MigrationData data) sync,
  }) async {
    var oldVersion = await preferences.getVersion();
    if (oldVersion == 0 && isCurrentConfigShape(configMap)) {
      final config = Config.realFromJson(configMap);
      await preferences.setVersion(currentVersion);
      await preferences.clearClashConfig();
      return config;
    }
    if (oldVersion == currentVersion) {
      try {
        return Config.realFromJson(configMap);
      } catch (_) {
        final isV0 = configMap?['proxiesStyle'] != null;
        if (isV0) {
          oldVersion = 0;
        } else {
          throw 'Local data is damaged. A reset is required to fix this issue.';
        }
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

final migration = Migration();

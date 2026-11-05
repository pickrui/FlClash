import 'package:fl_clash/models/oix_params.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persistence layer for the user's oixCloud query parameters.
///
/// Handles two stored values:
///   - `cloud_service_config_params`  user-effective params (encoded form)
///   - `cloud_service_default_params` last computed default for the active tier
class OixParamsStorage {
  static const _kConfigParams = 'cloud_service_config_params';
  static const _kDefaultParams = 'cloud_service_default_params';
  // Legacy: previously stored as separate bool. Kept for migration only.
  static const _kLegacyTfo = 'cloud_service_tfo';

  static Future<OixParams> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_kConfigParams) ?? '';
    var parsed = OixParams.parse(raw);

    // Migrate legacy `cloud_service_tfo` bool into the params object.
    if (parsed.tfo == null && prefs.containsKey(_kLegacyTfo)) {
      parsed = parsed.copyWith(tfo: prefs.getBool(_kLegacyTfo) ?? true);
      await prefs.remove(_kLegacyTfo);
      await prefs.setString(_kConfigParams, parsed.encode());
    }
    return parsed;
  }

  static Future<void> save(OixParams params) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kConfigParams, params.encode());
  }

  static Future<String> loadDefaultRaw() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kDefaultParams) ?? '';
  }

  static Future<void> saveDefaultRaw(String encoded) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kDefaultParams, encoded);
  }

  static Future<bool> hasConfig() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_kConfigParams);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kConfigParams);
    await prefs.remove(_kDefaultParams);
    await prefs.remove(_kLegacyTfo);
  }
}

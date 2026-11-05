import 'package:fl_clash/models/oix_params.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persistence layer for the user's oixCloud query parameters.
///
/// Handles two stored values:
///   - `cloud_service_config_params`  user-effective params (encoded form)
///   - `cloud_service_default_params` last computed default for the active tier
class CloudParamsStorage {
  static const _kConfigParams = 'cloud_service_config_params';
  static const _kDefaultParams = 'cloud_service_default_params';
  // Legacy: previously stored as separate bool. Kept for migration only.
  static const _kLegacyTfo = 'cloud_service_tfo';
  static Future<void> _tail = Future.value();

  static Future<T> _synchronized<T>(Future<T> Function() action) {
    final operation = _tail.then((_) => action());
    _tail = operation.then<void>((_) {}, onError: (_, _) {});
    return operation;
  }

  static Future<CloudParams> load() {
    return _synchronized(() async {
      final prefs = await SharedPreferences.getInstance();
      return _load(prefs);
    });
  }

  static Future<CloudParams> _load(SharedPreferences prefs) async {
    final raw = prefs.getString(_kConfigParams) ?? '';
    var parsed = CloudParams.parse(raw);
    final normalized = parsed.encode();
    if (normalized != raw) {
      await prefs.setString(_kConfigParams, normalized);
    }

    // Migrate legacy `cloud_service_tfo` bool into the params object.
    if (parsed.tfo == null && prefs.containsKey(_kLegacyTfo)) {
      parsed = parsed.copyWith(tfo: prefs.getBool(_kLegacyTfo) ?? true);
      await prefs.remove(_kLegacyTfo);
      await prefs.setString(_kConfigParams, parsed.encode());
    }
    return parsed;
  }

  static Future<void> save(CloudParams params) {
    return _synchronized(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kConfigParams, params.encode());
    });
  }

  static Future<String> loadDefaultRaw() {
    return _synchronized(() async {
      final prefs = await SharedPreferences.getInstance();
      return _loadDefaultRaw(prefs);
    });
  }

  static Future<String> _loadDefaultRaw(SharedPreferences prefs) async {
    final raw = prefs.getString(_kDefaultParams) ?? '';
    final normalized = CloudParams.parse(raw).encodeDefaultComparable();
    if (normalized != raw) {
      await prefs.setString(_kDefaultParams, normalized);
    }
    return normalized;
  }

  static Future<void> saveDefaultRaw(String encoded) {
    return _synchronized(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _kDefaultParams,
        CloudParams.parse(encoded).encodeDefaultComparable(),
      );
    });
  }

  static Future<bool> hasConfig() {
    return _synchronized(() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(_kConfigParams);
    });
  }

  static Future<void> reconcileForTier(SubscriptionTier tier) {
    return _synchronized(() async {
      final prefs = await SharedPreferences.getInstance();
      final oldDefaultRaw = await _loadDefaultRaw(prefs);
      final hasUserParams = prefs.containsKey(_kConfigParams);
      final userParams = await _load(prefs);
      final newDefault = tier.defaultParams;
      final newDefaultEncoded = newDefault.encode();

      if (oldDefaultRaw != newDefaultEncoded) {
        await prefs.setString(_kDefaultParams, newDefaultEncoded);
      }

      var effective = userParams;
      if (!hasUserParams ||
          (userParams.encodeDefaultComparable() == oldDefaultRaw &&
              oldDefaultRaw != newDefaultEncoded)) {
        effective = userParams.applyingTierDefaults(newDefault);
      }
      effective = effective.adjustedForTier(tier);
      effective = effective.copyWith(tfo: effective.tfo ?? true);

      if (!hasUserParams || effective != userParams) {
        await prefs.setString(_kConfigParams, effective.encode());
      }
    });
  }

  static Future<void> clear() {
    return _synchronized(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_kConfigParams);
      await prefs.remove(_kDefaultParams);
      await prefs.remove(_kLegacyTfo);
    });
  }
}

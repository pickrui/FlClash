import 'package:fl_clash/models/oix_params.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists the oixCloud profile switches in `cloud_service_config_params`.
/// Loading rewrites older values, which also carried node keys and free-form
/// options, down to `tfo` and `simplerules`.
class CloudParamsStorage {
  static const _kConfigParams = 'cloud_service_config_params';
  static const _kLegacyDefaultParams = 'cloud_service_default_params';
  static const _kLegacyTfo = 'cloud_service_tfo';
  // Dropped once idle, so no call chains onto a future of a finished zone.
  static Future<void>? _tail;

  static Future<T> _synchronized<T>(Future<T> Function() action) {
    final previous = _tail;
    final operation = previous == null
        ? Future.microtask(action)
        : previous.then((_) => action());
    final tail = operation.then<void>((_) {}, onError: (_, _) {});
    _tail = tail;
    tail.whenComplete(() {
      if (identical(_tail, tail)) _tail = null;
    });
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
    if (prefs.containsKey(_kLegacyDefaultParams)) {
      await prefs.remove(_kLegacyDefaultParams);
    }

    if (parsed.tfo == null && prefs.containsKey(_kLegacyTfo)) {
      parsed = CloudParams(
        tfo: prefs.getBool(_kLegacyTfo) ?? false,
        simplerules: parsed.simplerules,
      );
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

  static Future<void> clear() {
    return _synchronized(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_kConfigParams);
      await prefs.remove(_kLegacyDefaultParams);
      await prefs.remove(_kLegacyTfo);
    });
  }
}

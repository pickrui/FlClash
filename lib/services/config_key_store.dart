import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:fl_clash/common/path.dart';
import 'package:fl_clash/services/age_crypto.dart';
import 'package:fl_clash/utils/safe_storage.dart';
import 'package:flutter/foundation.dart';

@visibleForTesting
bool shouldPreserveConfigSeed({
  required bool hasValidSeed,
  required bool durableConfigExists,
}) {
  return !hasValidSeed && durableConfigExists;
}

/// Storage can be retried without discarding the existing encrypted data.
class ConfigKeyUnavailableException implements Exception {
  final Object? cause;

  const ConfigKeyUnavailableException([this.cause]);

  @override
  String toString() => 'Config encryption key is temporarily unavailable';
}

@visibleForTesting
Future<String> loadConfigSeed({
  required bool durableConfigExists,
  required Future<String?> Function(bool retry) readSeed,
  required Future<void> Function(String seed) writeSeed,
}) async {
  Object? readError;
  for (var attempt = 0; attempt < 2; attempt++) {
    try {
      final stored = await readSeed(attempt > 0);
      readError = null;
      if (ConfigKeyStore.decodeSeed(stored) != null) {
        return stored!;
      }
      if (!durableConfigExists) {
        break;
      }
    } catch (error) {
      readError = error;
    }
  }
  if (readError != null ||
      shouldPreserveConfigSeed(
        hasValidSeed: false,
        durableConfigExists: durableConfigExists,
      )) {
    throw ConfigKeyUnavailableException(readError);
  }
  final generated = base64Encode(ConfigKeyStore._randomSeed());
  try {
    await writeSeed(generated);
  } catch (error) {
    throw ConfigKeyUnavailableException(error);
  }
  return generated;
}

/// Per-device X25519 identity used to encrypt oixCloud configs at rest.
///
/// The 32-byte seed is persisted via [SafeStorage] (preferences on macOS,
/// platform secure storage elsewhere) and injected into the core so the core
/// can decrypt the same age blobs. This replaces the shared compile-time
/// profile key for at-rest encryption, so extracting the binary no longer
/// yields a key that decrypts every install's stored config.
class ConfigKeyStore {
  ConfigKeyStore._();

  static const _seedKey = 'config_age_seed';
  static String? _cachedSeedBase64;
  static AgeIdentity? _cachedIdentity;
  static Future<String>? _seedLoad;
  static Future<AgeIdentity>? _identityLoad;
  static Future<void>? _clearOperation;
  static int _generation = 0;
  static bool _cleared = false;

  /// Base64 of the 32-byte seed, generating and persisting one on first use.
  /// Injected into the core via `InitParams.configAgeSecretKey`.
  static Future<String> seedBase64({bool retry = false}) async {
    if (_cleared) {
      throw StateError('config encryption key store was cleared');
    }
    final clearing = _clearOperation;
    if (clearing != null) {
      await clearing;
    }
    final cached = _cachedSeedBase64;
    if (cached != null) return cached;

    final pending = _seedLoad;
    if (pending != null) return pending;

    final generation = _generation;
    final load = _loadOrCreateSeed(generation, retry: retry);
    _seedLoad = load;
    try {
      return await load;
    } finally {
      if (identical(_seedLoad, load)) {
        _seedLoad = null;
      }
    }
  }

  /// Retry startup after the user has restored access to their stored key.
  /// Pending loads are allowed to settle before invalidating their caches.
  static Future<void> reload() async {
    for (final pending in [_seedLoad, _identityLoad]) {
      if (pending == null) continue;
      try {
        await pending;
      } catch (_) {}
    }
    _generation++;
    _cachedSeedBase64 = null;
    _cachedIdentity = null;
    await seedBase64(retry: true);
  }

  static Future<String> _loadOrCreateSeed(
    int generation, {
    required bool retry,
  }) async {
    final bool durableConfigExists;
    try {
      durableConfigExists = await _durableConfigExists();
    } catch (error) {
      throw ConfigKeyUnavailableException(error);
    }
    final seed = await loadConfigSeed(
      durableConfigExists: durableConfigExists,
      readSeed: (retryRead) => SafeStorage.read(
        _seedKey,
        retry: retry || retryRead,
        legacyEvidence: durableConfigExists,
        isValid: (value) => decodeSeed(value) != null,
      ),
      writeSeed: (seed) => SafeStorage.write(_seedKey, seed),
    );
    if (generation != _generation) {
      throw StateError('config encryption seed load was invalidated');
    }
    _cachedSeedBase64 = seed;
    return seed;
  }

  static Future<bool> _durableConfigExists() async {
    final path = await appPath.durableConfigPath;
    for (final candidate in [path, '$path.tmp', '$path.old']) {
      if (await File(candidate).exists()) {
        return true;
      }
    }
    return false;
  }

  /// Identity derived from the persistent seed, for at-rest encryption.
  static Future<AgeIdentity> identity() async {
    if (_cleared) {
      throw StateError('config encryption key store was cleared');
    }
    final clearing = _clearOperation;
    if (clearing != null) {
      await clearing;
    }
    final cached = _cachedIdentity;
    if (cached != null) return cached;

    final pending = _identityLoad;
    if (pending != null) return pending;

    final generation = _generation;
    final load = _deriveIdentity(generation);
    _identityLoad = load;
    try {
      return await load;
    } finally {
      if (identical(_identityLoad, load)) {
        _identityLoad = null;
      }
    }
  }

  static Future<AgeIdentity> _deriveIdentity(int generation) async {
    final seed = decodeSeed(await seedBase64());
    if (seed == null) {
      throw StateError('invalid config encryption seed');
    }
    final identity = await AgeCrypto.identityFromSeed(seed);
    if (generation != _generation) {
      throw StateError('config encryption identity load was invalidated');
    }
    _cachedIdentity = identity;
    return identity;
  }

  static Future<void> clear() {
    final active = _clearOperation;
    if (active != null) {
      return active;
    }
    final operation = _clear();
    _clearOperation = operation;
    return operation.whenComplete(() {
      if (identical(_clearOperation, operation)) {
        _clearOperation = null;
      }
    });
  }

  static Future<void> _clear() async {
    _cleared = true;
    _generation++;
    final pendingSeed = _seedLoad;
    final pendingIdentity = _identityLoad;
    for (final pending in [pendingSeed, pendingIdentity]) {
      if (pending == null) {
        continue;
      }
      try {
        await pending;
      } catch (_) {}
    }
    _cachedSeedBase64 = null;
    _cachedIdentity = null;
    await SafeStorage.delete(_seedKey);
  }

  static Uint8List? decodeSeed(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    try {
      final decoded = base64Decode(value);
      if (decoded.length != 32 || base64Encode(decoded) != value) {
        return null;
      }
      return decoded;
    } catch (_) {
      return null;
    }
  }

  static Uint8List _randomSeed() {
    final random = Random.secure();
    return Uint8List.fromList(
      List<int>.generate(32, (_) => random.nextInt(256)),
    );
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fl_clash/common/path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? legacySecureStorageValue(String? payload, String key) {
  if (payload == null || payload.isEmpty) return null;
  final decoded = jsonDecode(payload);
  if (decoded is! Map) {
    throw const FormatException('legacy secure storage must be a JSON object');
  }
  final value = decoded[key];
  return value is String ? value : null;
}

@visibleForTesting
bool shouldReadLegacyMacStorage({
  required bool migrationMarked,
  required bool identityMigrated,
}) {
  return migrationMarked || identityMigrated;
}

class SafeStorage {
  static const _secureStorage = FlutterSecureStorage();
  static const _legacyMacOptions = MacOsOptions(
    usesDataProtectionKeychain: false,
    authenticationUIBehavior: 'u_AuthUIF',
  );
  static const _legacyMacTimeout = Duration(seconds: 10);
  static const _legacyLinuxStorage = MethodChannel(
    'com.oixcloud.clash/legacy_secure_storage',
  );
  static bool _legacyMacStorageAvailable = true;

  static bool get _isMacOS =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.macOS;

  static Future<String?> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final migrationKey = _migrationKey(key);
    final deletionKey = _deletionKey(key);
    if (prefs.getBool(deletionKey) == true) {
      await _deleteLegacyValue(prefs, key);
      if (!_isMacOS) {
        try {
          await _secureStorage.delete(key: key);
        } catch (_) {}
      }
      return null;
    }
    final legacyValue = prefs.getString(key);
    final migrated = prefs.getBool(migrationKey) ?? false;
    if (_isMacOS) {
      if (legacyValue != null) {
        return legacyValue;
      }
      final legacySecureValue = await _readLegacyMacValue(
        key,
        migrationMarked: migrated,
      );
      if (legacySecureValue != null) {
        await _writeFallback(prefs, key, legacySecureValue, migrationKey);
      }
      return legacySecureValue;
    }
    if (!migrated && legacyValue != null) {
      try {
        await _writeSecure(key, legacyValue);
      } catch (_) {
        return legacyValue;
      }
      await _markMigratedAndDeleteLegacy(prefs, key, migrationKey);
      return legacyValue;
    }
    final secureValue = await _secureStorage.read(key: key);
    if (secureValue != null) {
      await _markMigratedAndDeleteLegacy(prefs, key, migrationKey);
      return secureValue;
    }
    if (legacyValue != null) {
      try {
        await _writeSecure(key, legacyValue);
        await _markMigratedAndDeleteLegacy(prefs, key, migrationKey);
      } catch (_) {
        return legacyValue;
      }
      return legacyValue;
    }
    final legacySecureValue = await _readLegacyLinuxValue(key);
    if (legacySecureValue != null) {
      try {
        await _writeSecure(key, legacySecureValue);
        await _markMigratedAndDeleteLegacy(prefs, key, migrationKey);
      } catch (_) {
        return legacySecureValue;
      }
      return legacySecureValue;
    }
    return null;
  }

  static Future<void> write(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    if (_isMacOS) {
      await _writeFallback(prefs, key, value, _migrationKey(key));
      return;
    }
    await _writeSecure(key, value);
    await _markMigratedAndDeleteLegacy(prefs, key, _migrationKey(key));
    await _clearDeletionMarker(prefs, key);
  }

  static Future<void> delete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (!await prefs.setBool(_deletionKey(key), true) ||
        prefs.getBool(_deletionKey(key)) != true) {
      throw StateError('secure storage deletion marker failed');
    }
    await _markMigratedAndDeleteLegacy(prefs, key, _migrationKey(key));
    if (_isMacOS) {
      return;
    }
    await _secureStorage.delete(key: key);
    if (await _secureStorage.read(key: key) != null) {
      throw StateError('secure storage delete verification failed');
    }
  }

  static String deletionMarkerKey(String key) => _deletionKey(key);

  static String _migrationKey(String key) => '__safe_storage_migrated_$key';
  static String _deletionKey(String key) => '__safe_storage_deleted_$key';

  static Future<String?> _readLegacyMacValue(
    String key, {
    required bool migrationMarked,
  }) async {
    if (!_isMacOS || !_legacyMacStorageAvailable) {
      return null;
    }
    if (!shouldReadLegacyMacStorage(
      migrationMarked: migrationMarked,
      identityMigrated: await File(
        await appPath.identityMigrationMarkerPath,
      ).exists(),
    )) {
      return null;
    }
    try {
      return await _secureStorage
          .read(key: key, mOptions: _legacyMacOptions)
          .timeout(_legacyMacTimeout);
    } catch (_) {
      _legacyMacStorageAvailable = false;
      return null;
    }
  }

  static Future<String?> _readLegacyLinuxValue(String key) async {
    if (!Platform.isLinux ||
        !await File(await appPath.identityMigrationMarkerPath).exists()) {
      return null;
    }
    try {
      final payload = await _legacyLinuxStorage.invokeMethod<String>('readAll');
      return legacySecureStorageValue(payload, key);
    } catch (_) {
      return null;
    }
  }

  static Future<void> _deleteLegacyValue(
    SharedPreferences prefs,
    String key,
  ) async {
    if (prefs.containsKey(key) &&
        (!await prefs.remove(key) || prefs.containsKey(key))) {
      throw StateError('legacy secure storage cleanup failed');
    }
  }

  static Future<void> _writeSecure(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
    if (await _secureStorage.read(key: key) != value) {
      throw StateError('secure storage write verification failed');
    }
  }

  static Future<void> _writeFallback(
    SharedPreferences prefs,
    String key,
    String value,
    String migrationKey,
  ) async {
    if (!await prefs.setString(key, value) || prefs.getString(key) != value) {
      throw StateError('secure storage fallback write failed');
    }
    if (!await prefs.setBool(migrationKey, true) ||
        prefs.getBool(migrationKey) != true) {
      throw StateError('secure storage migration marker failed');
    }
    await _clearDeletionMarker(prefs, key);
  }

  static Future<void> _clearDeletionMarker(
    SharedPreferences prefs,
    String key,
  ) async {
    final deletionKey = _deletionKey(key);
    if (prefs.containsKey(deletionKey) &&
        (!await prefs.remove(deletionKey) || prefs.containsKey(deletionKey))) {
      throw StateError('secure storage deletion marker cleanup failed');
    }
  }

  static Future<void> _markMigratedAndDeleteLegacy(
    SharedPreferences prefs,
    String key,
    String migrationKey,
  ) async {
    if (!await prefs.setBool(migrationKey, true) ||
        prefs.getBool(migrationKey) != true) {
      throw StateError('secure storage migration marker failed');
    }
    await _deleteLegacyValue(prefs, key);
  }
}

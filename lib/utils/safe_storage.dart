import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class SafeStorage {
  static const _secureStorage = FlutterSecureStorage();

  static bool get _useSharedPreferences =>
      !kIsWeb && (Platform.isLinux || Platform.isMacOS);

  static bool _isEntitlementError(PlatformException e) =>
      e.code == '-34018' || e.message?.contains('entitlement') == true;

  static Future<String?> read(String key) async {
    if (!_useSharedPreferences) {
      try {
        return await _secureStorage.read(key: key);
      } on PlatformException catch (e) {
        if (!_isEntitlementError(e)) rethrow;
      }
    }
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> write(String key, String value) async {
    if (!_useSharedPreferences) {
      try {
        await _secureStorage.write(key: key, value: value);
        return;
      } on PlatformException catch (e) {
        if (!_isEntitlementError(e)) rethrow;
      }
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<void> delete(String key) async {
    if (!_useSharedPreferences) {
      try {
        await _secureStorage.delete(key: key);
        return;
      } on PlatformException catch (e) {
        if (!_isEntitlementError(e)) rethrow;
      }
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}

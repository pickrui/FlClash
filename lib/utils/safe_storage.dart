import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class SafeStorage {
  static const _secureStorage = FlutterSecureStorage();
  
  static Future<String?> read(String key) async {
    try {
      return await _secureStorage.read(key: key);
    } on PlatformException catch (e) {
      if (e.code == '-34018' || e.message?.contains('entitlement') == true) {
        final prefs = await SharedPreferences.getInstance();
        return prefs.getString(key);
      }
      rethrow;
    }
  }

  static Future<void> write(String key, String value) async {
    try {
      await _secureStorage.write(key: key, value: value);
    } on PlatformException catch (e) {
      if (e.code == '-34018' || e.message?.contains('entitlement') == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(key, value);
        return;
      }
      rethrow;
    }
  }

  static Future<void> delete(String key) async {
    try {
      await _secureStorage.delete(key: key);
    } on PlatformException catch (e) {
      if (e.code == '-34018' || e.message?.contains('entitlement') == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(key);
        return;
      }
      rethrow;
    }
  }
}

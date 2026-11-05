import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:encrypt/encrypt.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileCrypto {
  static final ProfileCrypto _instance = ProfileCrypto._internal();
  factory ProfileCrypto() => _instance;
  ProfileCrypto._internal();

  late final Encrypter _encrypter;
  late final IV _iv;
  bool _initialized = false;
  static const String _deviceIdKey = 'profile_crypto_device_id';

  Future<String> _getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString(_deviceIdKey);
    
    if (deviceId != null && deviceId.isNotEmpty) return deviceId;
    
    try {
      final deviceInfo = DeviceInfoPlugin();
      deviceId = Platform.isAndroid
          ? (await deviceInfo.androidInfo).id
          : Platform.isIOS
              ? (await deviceInfo.iosInfo).identifierForVendor
              : const Uuid().v4();
    } catch (_) {
      deviceId = const Uuid().v4();
    }
    
    await prefs.setString(_deviceIdKey, deviceId!);
    return deviceId;
  }

  Future<void> initialize() async {
    if (_initialized) return;
    
    final deviceId = await _getDeviceId();
    final key = Key(Uint8List.fromList(_deriveKey(deviceId)));
    _iv = IV(Uint8List.fromList(_deriveIV(deviceId)));
    _encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    _initialized = true;
  }

  Future<String> getDeviceId() async {
    return await _getDeviceId();
  }

  List<int> _deriveKey(String deviceId) =>
      sha256.convert(utf8.encode('$deviceId:flclash:profile:key')).bytes;

  List<int> _deriveIV(String deviceId) =>
      md5.convert(utf8.encode('$deviceId:flclash:profile:iv')).bytes;

  Uint8List encrypt(Uint8List data) {
    if (!_initialized) throw StateError('ProfileCrypto not initialized');
    return _encrypter.encryptBytes(data, iv: _iv).bytes;
  }

  Uint8List decrypt(Uint8List encryptedData) {
    if (!_initialized) throw StateError('ProfileCrypto not initialized');
    try {
      return Uint8List.fromList(
        _encrypter.decryptBytes(Encrypted(encryptedData), iv: _iv),
      );
    } catch (_) {
      return encryptedData;
    }
  }

  bool isEncrypted(Uint8List data) {
    try {
      final text = utf8.decode(data, allowMalformed: false);
      return !text.startsWith('proxies:') &&
          !text.startsWith('proxy-groups:') &&
          !text.startsWith('rules:');
    } catch (_) {
      return true;
    }
  }

  String encryptString(String plaintext) {
    if (!_initialized) throw StateError('ProfileCrypto not initialized');
    if (plaintext.isEmpty) return plaintext;
    try {
      return _encrypter.encrypt(plaintext, iv: _iv).base64;
    } catch (_) {
      return plaintext;
    }
  }

  String decryptString(String encrypted) {
    if (!_initialized) throw StateError('ProfileCrypto not initialized');
    if (encrypted.isEmpty) return encrypted;
    try {
      return _encrypter.decrypt64(encrypted, iv: _iv);
    } catch (_) {
      return encrypted;
    }
  }
}

final profileCrypto = ProfileCrypto();


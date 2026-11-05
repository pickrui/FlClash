import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';

class ProfileCrypto {
  static const _key = 'FlClash_Dler_Cloud_Profile_Key_2025';
  static const _ivString = 'FlClash_IV_2025!';
  
  static final _encrypter = Encrypter(AES(
    Key.fromUtf8(_key.padRight(32).substring(0, 32)),
    mode: AESMode.cbc,
  ));
  
  static final _iv = IV.fromUtf8(_ivString.padRight(16).substring(0, 16));
  
  static Uint8List encrypt(Uint8List data) {
    try {
      final encrypted = _encrypter.encryptBytes(data, iv: _iv);
      return encrypted.bytes;
    } catch (e) {
      throw 'Encryption failed: $e';
    }
  }
  
  static Uint8List decrypt(Uint8List encryptedData) {
    try {
      final encrypted = Encrypted(encryptedData);
      final decrypted = _encrypter.decryptBytes(encrypted, iv: _iv);
      return Uint8List.fromList(decrypted);
    } catch (e) {
      throw 'Decryption failed: $e';
    }
  }
  
  static bool isEncrypted(Uint8List data) {
    try {
      decrypt(data);
      return true;
    } catch (_) {
      return false;
    }
  }
}


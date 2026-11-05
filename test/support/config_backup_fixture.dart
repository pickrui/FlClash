import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:fl_clash/services/config_backup.dart';

/// Portable authenticated encryption for filesystem fault tests; production
/// uses Windows DPAPI, exercised separately by the Windows CI test.
ConfigBackup testConfigBackup() {
  final cipher = Chacha20.poly1305Aead();
  final key = SecretKey(List.filled(32, 7));
  return ConfigBackup(
    encrypt: (plain) async => Uint8List.fromList(
      (await cipher.encrypt(plain, secretKey: key)).concatenation(),
    ),
    decrypt: (encrypted) async => Uint8List.fromList(
      await cipher.decrypt(
        SecretBox.fromConcatenation(encrypted, nonceLength: 12, macLength: 16),
        secretKey: key,
      ),
    ),
  );
}

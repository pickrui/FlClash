import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

// CRYPTPROTECT_UI_FORBIDDEN from dpapi.h (not exported by win32 5.x).
const _cryptProtectUiForbidden = 0x1;

class WindowsStorageProtectionException implements Exception {
  const WindowsStorageProtectionException(this.code);
  final int code;

  @override
  String toString() => 'Windows storage protection failed ($code)';
}

Uint8List protectWindowsStorage(Uint8List bytes) =>
    _crypt(bytes, protect: true);
Uint8List unprotectWindowsStorage(Uint8List bytes) =>
    _crypt(bytes, protect: false);

Uint8List _crypt(Uint8List bytes, {required bool protect}) {
  if (!Platform.isWindows) throw UnsupportedError('Windows DPAPI is required');
  return using((arena) {
    final input = arena<CRYPT_INTEGER_BLOB>();
    final inputBytes = arena<Uint8>(bytes.isEmpty ? 1 : bytes.length);
    inputBytes.asTypedList(bytes.length).setAll(0, bytes);
    input.ref
      ..cbData = bytes.length
      ..pbData = inputBytes;
    final output = arena<CRYPT_INTEGER_BLOB>();
    try {
      // Keep user-scoped protection and no entropy for existing-file compatibility.
      final result = protect
          ? CryptProtectData(
              input,
              nullptr,
              nullptr,
              nullptr,
              nullptr,
              _cryptProtectUiForbidden,
              output,
            )
          : CryptUnprotectData(
              input,
              nullptr,
              nullptr,
              nullptr,
              nullptr,
              _cryptProtectUiForbidden,
              output,
            );
      if (result == 0) throw WindowsStorageProtectionException(GetLastError());
      if (output.ref.pbData == nullptr) {
        throw const WindowsStorageProtectionException(ERROR_INVALID_DATA);
      }
      return Uint8List.fromList(
        output.ref.pbData.asTypedList(output.ref.cbData),
      );
    } finally {
      inputBytes.asTypedList(bytes.length).fillRange(0, bytes.length, 0);
      if (output.ref.pbData != nullptr) {
        output.ref.pbData
            .asTypedList(output.ref.cbData)
            .fillRange(0, output.ref.cbData, 0);
        LocalFree(output.ref.pbData);
      }
    }
  });
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:fl_clash/utils/windows_storage_crypto.dart';
import 'package:path/path.dart' as p;

typedef BackupCrypt = FutureOr<Uint8List> Function(Uint8List bytes);

/// The directory contains only numbered encrypted files and an encrypted
/// manifest. No original names, paths, DNS, nodes or plaintext temporary files
/// are written. DPAPI remains usable even when the app's old age seed is lost.
class ConfigBackup {
  ConfigBackup({
    this.encrypt = protectWindowsStorage,
    this.decrypt = unprotectWindowsStorage,
  });

  final BackupCrypt encrypt;
  final BackupCrypt decrypt;
  static const manifestName = 'manifest.enc';
  static const _chunkSize = 64 * 1024;

  Future<void> create(
    String sourcePath,
    List<String> names,
    String backupPath,
  ) async {
    final records = <Map<String, Object>>[];
    Future<void> visit(String relative) async {
      final source = p.join(sourcePath, relative);
      final type = await FileSystemEntity.type(source, followLinks: false);
      final record = <String, Object>{'path': relative};
      records.add(record);
      if (type == FileSystemEntityType.directory) {
        record['type'] = 'directory';
        final children = await Directory(
          source,
        ).list(followLinks: false).toList();
        children.sort((a, b) => a.path.compareTo(b.path));
        for (final child in children) {
          await visit(p.join(relative, p.basename(child.path)));
        }
      } else if (type == FileSystemEntityType.link) {
        record['type'] = 'link';
        record['target'] = await Link(source).target();
      } else if (type == FileSystemEntityType.file) {
        record['type'] = 'file';
        final stored = '${records.length}.enc';
        record['stored'] = stored;
        final digest = _DigestSink();
        final hash = sha256.startChunkedConversion(digest);
        var length = 0;
        final output = await File(
          p.join(backupPath, stored),
        ).open(mode: FileMode.write);
        try {
          await for (final plain in _readChunks(source)) {
            length += plain.length;
            hash.add(plain);
            final encrypted = await encrypt(plain);
            final header = ByteData(4)..setUint32(0, encrypted.length);
            await output.writeFrom(header.buffer.asUint8List());
            await output.writeFrom(encrypted);
          }
          await output.flush();
        } finally {
          await output.close();
          hash.close();
        }
        record['size'] = length;
        record['sha256'] = digest.value.toString();
      } else {
        throw const FileSystemException(
          'Unsupported configuration backup entry',
        );
      }
    }

    for (final name in names) {
      await visit(name);
    }
    final manifest = utf8.encode(
      jsonEncode({'version': 1, 'records': records}),
    );
    await File(
      p.join(backupPath, manifestName),
    ).writeAsBytes(await encrypt(manifest), flush: true);
    // Verify ciphertext and still-current source data before reset is permitted.
    final verified = await verify(backupPath);
    await verifySources(sourcePath, verified);
  }

  Future<List<Map<String, dynamic>>> verify(String backupPath) async {
    final encrypted = await File(
      p.join(backupPath, manifestName),
    ).readAsBytes();
    final Object? data;
    try {
      data = jsonDecode(utf8.decode(await decrypt(encrypted)));
    } on FormatException {
      // Do not quote decrypted filenames or metadata in startup diagnostics.
      throw const FormatException('Invalid encrypted configuration backup');
    }
    if (data is! Map || data['version'] != 1 || data['records'] is! List) {
      throw const FormatException('Invalid encrypted configuration backup');
    }
    final records = (data['records'] as List)
        .map((r) => Map<String, dynamic>.from(r as Map))
        .toList();
    final paths = <String>{};
    final storedNames = <String>{};
    for (final record in records) {
      final relative = record['path'];
      if (relative is! String ||
          !_validRelativePath(relative) ||
          !paths.add(relative)) {
        throw const FormatException('Invalid configuration backup path');
      }
      switch (record['type']) {
        case 'file':
          final stored = record['stored'];
          if (stored is! String ||
              !RegExp(r'^\d+\.enc$').hasMatch(stored) ||
              !storedNames.add(stored) ||
              record['size'] is! int ||
              record['size'] < 0 ||
              record['sha256'] is! String) {
            throw const FormatException('Invalid configuration backup file');
          }
          var length = 0;
          final digest = _DigestSink();
          final hash = sha256.startChunkedConversion(digest);
          try {
            await for (final plain in readFile(backupPath, stored)) {
              length += plain.length;
              hash.add(plain);
            }
          } finally {
            hash.close();
          }
          if (length != record['size'] ||
              digest.value.toString() != record['sha256']) {
            throw const FormatException(
              'Configuration backup integrity check failed',
            );
          }
        case 'directory':
          break;
        case 'link':
          if (record['target'] is! String) {
            throw const FormatException('Invalid configuration backup link');
          }
        default:
          throw const FormatException(
            'Invalid configuration backup entry type',
          );
      }
    }
    return records;
  }

  /// Decrypted chunks stay in memory; used for verification and future restore
  /// tooling. The encrypted manifest authenticates each file's size and SHA256.
  Stream<Uint8List> readFile(String backupPath, String stored) async* {
    if (!RegExp(r'^\d+\.enc$').hasMatch(stored)) {
      throw const FormatException('Invalid configuration backup filename');
    }
    final input = await File(p.join(backupPath, stored)).open();
    try {
      while (true) {
        final header = await input.read(4);
        if (header.isEmpty) break;
        if (header.length != 4) {
          throw const FormatException('Truncated backup frame');
        }
        final length = ByteData.sublistView(header).getUint32(0);
        if (length == 0 || length > _chunkSize * 2) {
          throw const FormatException('Invalid backup frame size');
        }
        final encrypted = await input.read(length);
        if (encrypted.length != length) {
          throw const FormatException('Truncated backup frame');
        }
        final plain = await decrypt(encrypted);
        if (plain.length > _chunkSize) {
          throw const FormatException('Invalid backup payload size');
        }
        yield plain;
      }
    } finally {
      await input.close();
    }
  }

  /// Missing originals are allowed only when resuming a confirmed reset. Any
  /// changed or unexpected remaining entry blocks deletion of newer data.
  Future<void> verifySources(
    String homePath,
    List<Map<String, dynamic>> records, {
    bool allowMissing = false,
  }) async {
    final expected = {
      for (final record in records) record['path'] as String: record,
    };
    for (final record in records) {
      final relative = record['path'] as String;
      final source = p.join(homePath, relative);
      final type = await FileSystemEntity.type(source, followLinks: false);
      if (type == FileSystemEntityType.notFound && allowMissing) continue;
      if (type == FileSystemEntityType.file && record['type'] == 'file') {
        final file = File(source);
        if (await file.length() == record['size'] &&
            (await sha256.bind(file.openRead()).first).toString() ==
                record['sha256']) {
          continue;
        }
      } else if (type == FileSystemEntityType.directory &&
          record['type'] == 'directory') {
        final children = await Directory(
          source,
        ).list(followLinks: false).toList();
        if (children.every(
          (child) =>
              expected.containsKey(p.relative(child.path, from: homePath)),
        )) {
          continue;
        }
      } else if (type == FileSystemEntityType.link &&
          record['type'] == 'link') {
        if (await Link(source).target() == record['target']) continue;
      }
      throw const FileSystemException(
        'Configuration changed after encrypted backup',
      );
    }
  }

  bool _validRelativePath(String value) =>
      value.isNotEmpty &&
      !p.isAbsolute(value) &&
      !p.windows.isAbsolute(value) &&
      !value.contains(':') &&
      !value.contains('\x00') &&
      value
          .split(RegExp(r'[/\\]'))
          .every((part) => part.isNotEmpty && part != '.' && part != '..');

  Stream<Uint8List> _readChunks(String path) async* {
    final input = await File(path).open();
    try {
      while (true) {
        final bytes = await input.read(_chunkSize);
        if (bytes.isEmpty) break;
        yield bytes;
      }
    } finally {
      await input.close();
    }
  }
}

class _DigestSink implements Sink<Digest> {
  late Digest value;
  @override
  void add(Digest data) => value = data;
  @override
  void close() {}
}

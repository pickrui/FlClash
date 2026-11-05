import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fl_clash/common/durable_file.dart';
import 'package:path/path.dart' as p;

import 'windows_storage_crypto.dart';

/// Compatible with flutter_secure_storage's existing DPAPI JSON file. All keys
/// share one transaction, including across instances and Windows processes.
class WindowsSecureStorage {
  WindowsSecureStorage({
    required this.path,
    this.encrypt = protectWindowsStorage,
    this.decrypt = unprotectWindowsStorage,
  });

  final String path;
  final Uint8List Function(Uint8List) encrypt;
  final Uint8List Function(Uint8List) decrypt;
  static final Map<String, Future<void>> _queues = {};

  Future<T> _transaction<T>(Future<T> Function() action) async {
    final key = p.normalize(p.absolute(path));
    final previous = _queues[key] ?? Future<void>.value();
    final done = Completer<void>();
    _queues[key] = done.future;
    await previous;
    try {
      await durableCreateDirectory(p.dirname(path));
      final lock = await File('$path.lock').open(mode: FileMode.append);
      try {
        // Non-blocking: a busy external process is a retryable storage error.
        await lock.lock(FileLock.exclusive);
        return await action();
      } finally {
        await lock.close();
      }
    } finally {
      done.complete();
      if (identical(_queues[key], done.future)) _queues.remove(key);
    }
  }

  Future<String?> read(String key) => _transaction(() async {
    final value = await _load();
    return value[key];
  });

  Future<void> write(String key, String value) => _transaction(() async {
    final values = await _load();
    values[key] = value;
    await _save(values);
  });

  Future<void> delete(String key) => _transaction(() async {
    final values = await _load();
    values.remove(key);
    // Refresh both copies, even after an interrupted previous deletion.
    await _save(values);
    await _copyAtomically(File(path), '$path.old');
  });

  Future<Map<String, String>> _load() async {
    Object? failure;
    StackTrace? failureStack;
    for (final candidatePath in [path, '$path.old', '$path.tmp']) {
      final candidate = File(candidatePath);
      // Do not turn permission errors or unexpected directories into "missing".
      final type = await FileSystemEntity.type(
        candidatePath,
        followLinks: false,
      );
      if (type == FileSystemEntityType.notFound) continue;
      if (type != FileSystemEntityType.file) {
        throw FileSystemException('Invalid secure storage file', candidatePath);
      }
      final ciphertext = await candidate.readAsBytes();
      final Map<String, String> values;
      try {
        final decoded = jsonDecode(utf8.decode(decrypt(ciphertext)));
        if (decoded is! Map ||
            decoded.entries.any(
              (e) => e.key is! String || e.value is! String,
            )) {
          throw const FormatException('Invalid secure storage contents');
        }
        values = Map<String, String>.from(decoded);
      } catch (error, stack) {
        // JSON decoder errors may quote the decrypted payload.
        failure ??= error is FormatException
            ? const FormatException('Invalid encrypted secure storage')
            : error;
        failureStack ??= stack;
        continue;
      }
      if (candidatePath != path) {
        // Preserve unreadable original bytes before promoting a good copy.
        final target = File(path);
        if (await target.exists()) {
          final saved =
              '$path.unreadable-${DateTime.now().microsecondsSinceEpoch}.enc';
          await File(
            saved,
          ).writeAsBytes(encrypt(await target.readAsBytes()), flush: true);
        }
        final repair = File('$path.repair');
        await repair.writeAsBytes(ciphertext, flush: true);
        await durableRename(repair.path, path);
      }
      return values;
    }
    if (failure != null) Error.throwWithStackTrace(failure, failureStack!);
    return {};
  }

  Future<void> _save(Map<String, String> values) async {
    final ciphertext = encrypt(
      Uint8List.fromList(utf8.encode(jsonEncode(values))),
    );
    final temporary = File('$path.tmp');
    await temporary.writeAsBytes(ciphertext, flush: true);
    final target = File(path);
    if (await target.exists()) {
      await _copyAtomically(target, '$path.old');
    }
    await durableRename(temporary.path, path);
    if (!await File('$path.old').exists()) {
      await _copyAtomically(target, '$path.old');
    }
  }

  Future<void> _copyAtomically(File source, String destination) async {
    final temporary = File('$destination.new');
    await temporary.writeAsBytes(await source.readAsBytes(), flush: true);
    await durableRename(temporary.path, destination);
  }
}

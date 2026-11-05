import 'dart:io';

import 'utils.dart';

extension FileExt on File {
  Future<void> safeCopy(String newPath) async {
    if (!await exists()) {
      throw FileSystemException('Source file does not exist', path);
    }
    final targetFile = File(newPath);
    if (!await targetFile.exists()) {
      await targetFile.create(recursive: true);
    }
    await copy(newPath);
  }

  Future<File> safeWriteAsString(String str) async {
    if (!await exists()) {
      await create(recursive: true);
    }
    return writeAsString(str);
  }

  Future<File> safeWriteAsBytes(List<int> bytes) async {
    if (!await exists()) {
      await create(recursive: true);
    }
    return writeAsBytes(bytes);
  }
}

extension FileSystemEntityExt on FileSystemEntity {
  Future<void> safeDelete({bool recursive = false}) async {
    if (!await exists()) {
      return;
    }
    await delete(recursive: recursive);
  }
}

Future<T> withFileRollback<T>(String path, Future<T> Function() action) async {
  final target = File(path);
  final existed = await target.exists();
  final backup = File('$path.write-backup-${utils.id}');
  if (existed) {
    await target.copy(backup.path);
  }
  late T result;
  try {
    result = await action();
  } catch (error, stackTrace) {
    var rollbackSucceeded = false;
    try {
      if (existed) {
        await backup.copy(path);
      } else {
        await target.safeDelete();
      }
      rollbackSucceeded = true;
    } catch (rollbackError) {
      Error.throwWithStackTrace(
        StateError('$error; file rollback failed: $rollbackError'),
        stackTrace,
      );
    } finally {
      if (rollbackSucceeded) {
        try {
          await backup.safeDelete();
        } catch (_) {}
      }
    }
    Error.throwWithStackTrace(error, stackTrace);
  }
  try {
    await backup.safeDelete();
  } catch (_) {}
  return result;
}

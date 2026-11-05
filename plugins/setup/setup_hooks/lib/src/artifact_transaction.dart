import 'dart:async';
import 'dart:io';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'util.dart';

final _queues = <String, Future<void>>{};

/// Different CPU targets share the platform's installed filenames. Hold the
/// lock through Core, Helper and manifest generation, including rollback.
Future<T> withArtifactTransaction<T>({
  required String rootDir,
  required String key,
  required List<String> outputs,
  required Future<T> Function() build,
}) async {
  final lockPath = p.join(
    rootDir,
    '.dart_tool',
    'setup_build_cache',
    '$key.install.lock',
  );
  final previous = _queues[lockPath] ?? Future<void>.value();
  final done = Completer<void>();
  _queues[lockPath] = done.future;
  await previous;
  RandomAccessFile? lock;
  Directory? backup;
  final saved = <String, String?>{};
  var discardBackup = false;
  try {
    final file = File(lockPath)..createSync(recursive: true);
    lock = await file.open(mode: FileMode.append);
    await lock.lock(FileLock.blockingExclusive);
    backup = Directory(file.parent.path).createTempSync('$key.backup-');
    for (final output in outputs) {
      final existing = File(output);
      if (existing.existsSync()) {
        final copy = p.join(backup.path, saved.length.toString());
        existing.copySync(copy);
        saved[output] = copy;
      } else {
        saved[output] = null;
      }
    }
    try {
      final result = await build();
      discardBackup = true;
      return result;
    } catch (_) {
      for (final entry in saved.entries) {
        final old = entry.value;
        if (old != null) {
          copyFile(old, entry.key);
        } else {
          final output = File(entry.key);
          if (output.existsSync()) output.deleteSync();
        }
      }
      discardBackup = true;
      rethrow;
    }
  } finally {
    try {
      if (backup?.existsSync() ?? false) {
        if (discardBackup) {
          backup!.deleteSync(recursive: true);
        } else {
          Logger(
            'setup_hooks',
          ).severe('Previous build artifacts retained at ${backup!.path}');
        }
      }
    } finally {
      try {
        if (lock != null) {
          try {
            await lock.unlock();
          } finally {
            await lock.close();
          }
        }
      } finally {
        done.complete();
        if (identical(_queues[lockPath], done.future)) _queues.remove(lockPath);
      }
    }
  }
}

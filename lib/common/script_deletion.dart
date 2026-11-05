import 'dart:io';

import 'package:path/path.dart' as p;

import 'durable_file.dart';

String pendingScriptDeletionPath(String scriptsPath, int scriptId) {
  return p.join(scriptsPath, '.script-delete-$scriptId.js');
}

Future<T> commitScriptDeletion<T>({
  required String scriptPath,
  required int scriptId,
  required Future<T> Function() commit,
}) async {
  final target = File(scriptPath);
  final pending = File(pendingScriptDeletionPath(target.parent.path, scriptId));
  var renamed = false;
  if (await target.exists()) {
    if (await pending.exists()) {
      throw StateError('script deletion is already pending');
    }
    await durableRename(target.path, pending.path);
    renamed = true;
  }
  try {
    final result = await commit();
    if (renamed) {
      try {
        await durableDeleteFile(pending.path);
      } catch (_) {}
    }
    return result;
  } catch (_) {
    if (renamed && await pending.exists() && !await target.exists()) {
      await durableRename(pending.path, target.path);
    }
    rethrow;
  }
}

Future<void> recoverPendingScriptDeletions({
  required String scriptsPath,
  required Future<bool> Function(int scriptId) scriptExists,
}) async {
  final directory = Directory(scriptsPath);
  if (!await directory.exists()) {
    return;
  }
  final pattern = RegExp(r'^\.script-delete-([0-9]+)\.js$');
  await for (final entry in directory.list(followLinks: false)) {
    if (entry is! File) {
      continue;
    }
    final match = pattern.firstMatch(p.basename(entry.path));
    if (match == null) {
      continue;
    }
    final scriptId = int.tryParse(match.group(1)!);
    if (scriptId == null) {
      continue;
    }
    final target = File(p.join(scriptsPath, '$scriptId.js'));
    if (await scriptExists(scriptId) && !await target.exists()) {
      await durableRename(entry.path, target.path);
    } else {
      await durableDeleteFile(entry.path);
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:fl_clash/common/durable_file.dart';
import 'package:path/path.dart' as p;

const _journalDirectoryName = '.restore-transaction';
const _preparedManifestName = 'prepared.json';
const _committedManifestName = 'committed.json';
const _rolledBackManifestName = 'rolled-back.json';
const _databaseSnapshotName = 'database.sqlite';
const _configSnapshotName = 'config.age';

class RestoreReplacementPlan {
  final String target;
  final String backup;
  final String temporary;
  final bool existed;

  const RestoreReplacementPlan({
    required this.target,
    required this.backup,
    required this.temporary,
    required this.existed,
  });

  factory RestoreReplacementPlan.fromJson(Map<String, Object?> json) {
    return RestoreReplacementPlan(
      target: json['target']! as String,
      backup: json['backup']! as String,
      temporary: json['temporary']! as String,
      existed: json['existed']! as bool,
    );
  }

  Map<String, Object?> toJson() => {
    'target': target,
    'backup': backup,
    'temporary': temporary,
    'existed': existed,
  };
}

class RestoreDeletionPlan {
  final String target;
  final String backup;
  final bool isDirectory;

  const RestoreDeletionPlan({
    required this.target,
    required this.backup,
    required this.isDirectory,
  });

  factory RestoreDeletionPlan.fromJson(Map<String, Object?> json) {
    return RestoreDeletionPlan(
      target: json['target']! as String,
      backup: json['backup']! as String,
      isDirectory: json['isDirectory']! as bool,
    );
  }

  Map<String, Object?> toJson() => {
    'target': target,
    'backup': backup,
    'isDirectory': isDirectory,
  };
}

class RestoreFilePlan {
  final List<RestoreReplacementPlan> replacements;
  final List<RestoreDeletionPlan> deletions;

  const RestoreFilePlan({required this.replacements, required this.deletions});

  factory RestoreFilePlan.fromJson(Map<String, Object?> json) {
    return RestoreFilePlan(
      replacements: (json['replacements']! as List)
          .map(
            (item) => RestoreReplacementPlan.fromJson(
              Map<String, Object?>.from(item as Map),
            ),
          )
          .toList(),
      deletions: (json['deletions']! as List)
          .map(
            (item) => RestoreDeletionPlan.fromJson(
              Map<String, Object?>.from(item as Map),
            ),
          )
          .toList(),
    );
  }

  Map<String, Object?> toJson() => {
    'replacements': replacements.map((item) => item.toJson()).toList(),
    'deletions': deletions.map((item) => item.toJson()).toList(),
  };
}

class RestoreJournal {
  final String homePath;
  final Directory directory;
  final String databaseSnapshotPath;
  final String configSnapshotPath;
  RestoreFilePlan? _plan;
  bool _prepared = false;
  bool _committed = false;
  bool _rolledBack = false;

  bool get hasPendingRollback => _prepared && !_committed && !_rolledBack;

  RestoreJournal._(this.homePath, this.directory)
    : databaseSnapshotPath = p.join(directory.path, _databaseSnapshotName),
      configSnapshotPath = p.join(directory.path, _configSnapshotName);

  static Future<RestoreJournal> begin({
    required String homePath,
    required String durableConfigPath,
    required Future<void> Function(String path) createDatabaseSnapshot,
  }) async {
    final directory = Directory(p.join(homePath, _journalDirectoryName));
    if (await directory.exists()) {
      throw StateError('a pending restore transaction requires recovery');
    }
    await durableCreateDirectory(directory.path);
    final journal = RestoreJournal._(homePath, directory);
    try {
      await createDatabaseSnapshot(journal.databaseSnapshotPath);
      final durableConfig = File(durableConfigPath);
      if (!await durableConfig.exists()) {
        throw StateError('durable config snapshot source is missing');
      }
      await durableConfig.copy(journal.configSnapshotPath);
      await _flushFile(File(journal.databaseSnapshotPath));
      await _flushFile(File(journal.configSnapshotPath));
      await syncDirectory(directory.path);
      return journal;
    } catch (_) {
      await directory.delete(recursive: true);
      rethrow;
    }
  }

  Future<void> prepare(RestoreFilePlan plan) async {
    await _validatePlan(homePath, plan);
    _plan = plan;
    final manifest = {'version': 1, 'files': plan.toJson()};
    final target = File(p.join(directory.path, _preparedManifestName));
    final temporary = File('${target.path}.tmp');
    await temporary.writeAsString(jsonEncode(manifest), flush: true);
    await durableRename(temporary.path, target.path);
    _prepared = true;
  }

  Future<void> markCommitted() async {
    if (!_prepared) {
      throw StateError('restore journal was not prepared');
    }
    final prepared = File(p.join(directory.path, _preparedManifestName));
    final committed = File(p.join(directory.path, _committedManifestName));
    await durableRename(prepared.path, committed.path);
    _committed = true;
  }

  Future<void> clearAfterRollback() async {
    if (_committed) {
      throw StateError('cannot roll back a committed restore journal');
    }
    if (_prepared) {
      final prepared = File(p.join(directory.path, _preparedManifestName));
      final rolledBack = File(p.join(directory.path, _rolledBackManifestName));
      await durableRename(prepared.path, rolledBack.path);
      _rolledBack = true;
    }
    await _deleteDirectory();
  }

  Future<void> clearAfterCommit() async {
    if (!_committed) {
      throw StateError('restore journal was not committed');
    }
    await _cleanupArtifacts(_plan);
    await _deleteDirectory();
  }

  Future<void> clearIfUnprepared() async {
    if (!_prepared && !_committed && !_rolledBack) {
      await _deleteDirectory();
    }
  }

  Future<void> _deleteDirectory() async {
    if (await directory.exists()) {
      await directory.delete(recursive: true);
      await syncDirectory(homePath);
    }
  }
}

Future<void> recoverPendingRestore({
  required String homePath,
  required String databasePath,
  required String durableConfigPath,
}) async {
  final directory = Directory(p.join(homePath, _journalDirectoryName));
  if (!await directory.exists()) {
    return;
  }
  final prepared = File(p.join(directory.path, _preparedManifestName));
  final committed = File(p.join(directory.path, _committedManifestName));
  final rolledBack = File(p.join(directory.path, _rolledBackManifestName));
  final manifestFile = await committed.exists()
      ? committed
      : await rolledBack.exists()
      ? rolledBack
      : await prepared.exists()
      ? prepared
      : null;
  if (manifestFile == null) {
    await directory.delete(recursive: true);
    await syncDirectory(homePath);
    return;
  }
  final manifest = Map<String, Object?>.from(
    jsonDecode(await manifestFile.readAsString()) as Map,
  );
  if (manifest['version'] != 1) {
    throw const FormatException('unsupported restore journal version');
  }
  final plan = RestoreFilePlan.fromJson(
    Map<String, Object?>.from(manifest['files']! as Map),
  );
  await _validatePlan(homePath, plan);
  if (identical(manifestFile, prepared)) {
    await _rollbackFiles(plan);
    final databaseSnapshot = File(
      p.join(directory.path, _databaseSnapshotName),
    );
    if (!await databaseSnapshot.exists()) {
      throw const FormatException('restore database snapshot is missing');
    }
    final configSnapshot = File(p.join(directory.path, _configSnapshotName));
    if (!await configSnapshot.exists()) {
      throw const FormatException('restore config snapshot is missing');
    }
    await _deleteFileIfExists(File('$databasePath-journal'));
    await _deleteFileIfExists(File('$databasePath-wal'));
    await _deleteFileIfExists(File('$databasePath-shm'));
    await _replaceFile(databaseSnapshot, File(databasePath));
    await _replaceFile(configSnapshot, File(durableConfigPath));
  }
  await _cleanupArtifacts(plan);
  await directory.delete(recursive: true);
  await syncDirectory(homePath);
}

Future<void> discardPendingRestore(String homePath) async {
  await durableDeleteEntity(p.join(homePath, _journalDirectoryName));
}

Future<void> _flushFile(File file) async {
  final handle = await file.open(mode: FileMode.append);
  try {
    await handle.flush();
  } finally {
    await handle.close();
  }
}

Future<void> _validatePlan(String homePath, RestoreFilePlan plan) async {
  final normalizedHome = p.absolute(p.normalize(homePath));
  for (final replacement in plan.replacements) {
    for (final path in [
      replacement.target,
      replacement.backup,
      replacement.temporary,
    ]) {
      if (!p.isWithin(normalizedHome, p.absolute(p.normalize(path)))) {
        throw const FormatException('restore journal path is outside home');
      }
      await _rejectSymlinkComponents(normalizedHome, path);
    }
  }
  for (final deletion in plan.deletions) {
    for (final path in [deletion.target, deletion.backup]) {
      if (!p.isWithin(normalizedHome, p.absolute(p.normalize(path)))) {
        throw const FormatException('restore journal path is outside home');
      }
      await _rejectSymlinkComponents(normalizedHome, path);
    }
  }
}

Future<void> _rejectSymlinkComponents(String homePath, String path) async {
  final relative = p.relative(p.absolute(p.normalize(path)), from: homePath);
  var current = homePath;
  for (final part in p.split(relative)) {
    current = p.join(current, part);
    final type = await FileSystemEntity.type(current, followLinks: false);
    if (type == FileSystemEntityType.link) {
      throw const FormatException('restore journal path contains a link');
    }
    if (type == FileSystemEntityType.notFound) {
      return;
    }
  }
}

Future<void> _rollbackFiles(RestoreFilePlan plan) async {
  for (final deletion in plan.deletions.reversed) {
    final backup = await FileSystemEntity.type(
      deletion.backup,
      followLinks: false,
    );
    if (backup != FileSystemEntityType.notFound) {
      await _deleteEntity(deletion.target);
      if (deletion.isDirectory) {
        await durableRenameDirectory(deletion.backup, deletion.target);
      } else {
        await durableRename(deletion.backup, deletion.target);
      }
    } else if (await FileSystemEntity.type(
          deletion.target,
          followLinks: false,
        ) ==
        FileSystemEntityType.notFound) {
      throw const FormatException('restore deletion backup is missing');
    }
  }
  for (final replacement in plan.replacements.reversed) {
    final backupExists = await File(replacement.backup).exists();
    if (backupExists) {
      await _deleteEntity(replacement.target);
      await durableRename(replacement.backup, replacement.target);
    } else if (!replacement.existed) {
      await _deleteEntity(replacement.target);
    } else if (!await File(replacement.target).exists()) {
      throw const FormatException('restore replacement source is missing');
    }
    await _deleteFileIfExists(File(replacement.temporary));
  }
}

Future<void> _cleanupArtifacts(RestoreFilePlan? plan) async {
  if (plan == null) {
    return;
  }
  for (final replacement in plan.replacements) {
    await _deleteFileIfExists(File(replacement.backup));
    await _deleteFileIfExists(File(replacement.temporary));
  }
  for (final deletion in plan.deletions) {
    await _deleteEntity(deletion.backup);
  }
}

Future<void> _replaceFile(File source, File target) async {
  await durableCreateDirectory(target.parent.path);
  final temporary = File('${target.path}.restore-recovery-new');
  final discarded = File('${target.path}.restore-recovery-old');
  await _deleteFileIfExists(temporary);
  await _deleteFileIfExists(discarded);
  await source.openRead().pipe(temporary.openWrite());
  final handle = await temporary.open(mode: FileMode.append);
  try {
    await handle.flush();
  } finally {
    await handle.close();
  }
  if (await target.exists()) {
    await durableRename(target.path, discarded.path);
  }
  await durableRename(temporary.path, target.path);
  await _deleteFileIfExists(discarded);
}

Future<void> _deleteFileIfExists(File file) async {
  await durableDeleteFile(file.path);
}

Future<void> _deleteEntity(String path) async {
  await durableDeleteEntity(path);
}

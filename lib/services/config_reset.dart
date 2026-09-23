import 'dart:convert';
import 'dart:io';

import 'package:fl_clash/common/durable_file.dart';
import 'package:path/path.dart' as p;

import 'config_backup.dart';

/// Startup-only reset under the single-instance lock, before database/core use.
/// A verified encrypted backup is mandatory before any original is removed.
/// The encrypted journal resumes only an explicitly confirmed interrupted reset.
class ConfigReset {
  ConfigReset(this.homePath, {ConfigBackup? backup})
    : backup = backup ?? ConfigBackup();

  final String homePath;
  final ConfigBackup backup;
  static const journalName = '.config-recovery.dat';
  static const _temporaryJournalName = '$journalName.new';
  static const _preservedNames = {
    'FlClash.lock',
    journalName,
    _temporaryJournalName,
  };
  Future<String>? _operation;

  String get _journalPath => p.join(homePath, journalName);

  Future<String> backupAndReset() =>
      _operation ??= _reset().whenComplete(() => _operation = null);

  Future<void> resumePending() async {
    final journal = await _readJournal();
    if (journal != null && journal['complete'] == false) await _finish(journal);
  }

  Future<String> _reset() async {
    var journal = await _readJournal();
    if (journal == null || journal['complete'] == true) {
      final entries = await Directory(
        homePath,
      ).list(followLinks: false).toList();
      final names =
          entries
              .map((e) => p.basename(e.path))
              .where((name) => !_preservedNames.contains(name))
              .toList()
            ..sort();
      final directory = await Directory(
        p.dirname(homePath),
      ).createTemp('${p.basename(homePath)}.recovery-');
      // Creation and validation never write plaintext copies, even on failure.
      try {
        await backup.create(homePath, names, directory.path);
      } catch (_) {
        try {
          await directory.delete(recursive: true);
        } catch (_) {}
        rethrow;
      }
      journal = {
        'version': 1,
        'backup': p.basename(directory.path),
        'entries': names,
        'complete': false,
      };
      await _writeJournal(journal);
    }
    return _finish(journal);
  }

  Future<Map<String, dynamic>?> _readJournal() async {
    final file = File(_journalPath);
    if (!await file.exists()) return null;
    final Object? data;
    try {
      data = jsonDecode(
        utf8.decode(await backup.decrypt(await file.readAsBytes())),
      );
    } on FormatException {
      throw const FormatException(
        'Invalid encrypted configuration reset journal',
      );
    }
    if (data is! Map<String, dynamic> ||
        data['version'] != 1 ||
        data['complete'] is! bool ||
        data['backup'] is! String ||
        data['entries'] is! List) {
      throw const FormatException('Invalid configuration reset journal');
    }
    final name = data['backup'] as String;
    final entries = data['entries'] as List;
    if (!_isName(name) ||
        !name.startsWith('${p.basename(homePath)}.recovery-') ||
        entries.any(
          (name) =>
              name is! String ||
              !_isName(name) ||
              _preservedNames.contains(name),
        ) ||
        entries.toSet().length != entries.length) {
      throw const FormatException('Invalid configuration reset paths');
    }
    return data;
  }

  bool _isName(String name) =>
      name.isNotEmpty &&
      name != '.' &&
      name != '..' &&
      !name.contains(RegExp(r'[/\\:\x00]'));

  Future<String> _finish(Map<String, dynamic> journal) async {
    final backupPath = p.join(p.dirname(homePath), journal['backup'] as String);
    if (await FileSystemEntity.type(backupPath, followLinks: false) !=
        FileSystemEntityType.directory) {
      throw const FileSystemException(
        'Encrypted configuration backup is unavailable',
      );
    }
    // A corrupt/missing backup can never authorize deleting surviving originals.
    final records = await backup.verify(backupPath);
    final names = (journal['entries'] as List).cast<String>();
    final recordedNames = records
        .map((r) => p.split(r['path'] as String).first)
        .toSet();
    if (recordedNames.length != names.length ||
        !recordedNames.containsAll(names)) {
      throw const FormatException(
        'Configuration backup does not match reset journal',
      );
    }
    await backup.verifySources(homePath, records, allowMissing: true);
    for (final name in names) {
      await durableDeleteEntity(p.join(homePath, name));
    }
    await _writeJournal({...journal, 'complete': true});
    return backupPath;
  }

  Future<void> _writeJournal(Map<String, dynamic> journal) async {
    final temporary = File(p.join(homePath, _temporaryJournalName));
    await temporary.writeAsBytes(
      await backup.encrypt(utf8.encode(jsonEncode(journal))),
      flush: true,
    );
    await durableRename(temporary.path, _journalPath);
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:fl_clash/common/restore_journal.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

typedef Stores = ({File database, File config});

Future<Stores> createStores(Directory home) async {
  final database = File(p.join(home.path, 'database.sqlite'));
  final config = File(p.join(home.path, 'config.age'));
  await database.writeAsString('old-database');
  await config.writeAsString('old-config');
  return (database: database, config: config);
}

Future<RestoreJournal> beginJournal(Directory home, Stores stores) {
  return RestoreJournal.begin(
    homePath: home.path,
    durableConfigPath: stores.config.path,
    createDatabaseSnapshot: (path) => stores.database.copy(path),
  );
}

Future<void> recover(Directory home, Stores stores) {
  return recoverPendingRestore(
    homePath: home.path,
    databasePath: stores.database.path,
    durableConfigPath: stores.config.path,
  );
}

void main() {
  test('prepared journal restores files database and config', () async {
    final home = await Directory.systemTemp.createTemp('restore_journal_');
    addTearDown(() => home.delete(recursive: true));
    final stores = await createStores(home);
    final target = File(p.join(home.path, 'profiles', '1.yaml'))
      ..createSync(recursive: true)
      ..writeAsStringSync('old-profile');
    final backup = '${target.path}.backup';
    final journal = await beginJournal(home, stores);
    await journal.prepare(
      RestoreFilePlan(
        replacements: [
          RestoreReplacementPlan(
            target: target.path,
            backup: backup,
            temporary: '${target.path}.temporary',
            existed: true,
          ),
        ],
        deletions: const [],
      ),
    );
    await target.rename(backup);
    await File(target.path).writeAsString('new-profile');
    await stores.database.writeAsString('new-database');
    await stores.config.writeAsString('new-config');
    await File('${stores.database.path}-journal').writeAsString('hot');

    await recover(home, stores);

    expect(await target.readAsString(), 'old-profile');
    expect(await stores.database.readAsString(), 'old-database');
    expect(await stores.config.readAsString(), 'old-config');
    expect(await File('${stores.database.path}-journal').exists(), false);
    expect(await File(backup).exists(), false);
  });

  test('committed journal preserves new state and removes artifacts', () async {
    final home = await Directory.systemTemp.createTemp('restore_journal_');
    addTearDown(() => home.delete(recursive: true));
    final stores = await createStores(home);
    final target = File(p.join(home.path, 'profiles', '1.yaml'))
      ..createSync(recursive: true)
      ..writeAsStringSync('old-profile');
    final backup = '${target.path}.backup';
    final journal = await beginJournal(home, stores);
    await journal.prepare(
      RestoreFilePlan(
        replacements: [
          RestoreReplacementPlan(
            target: target.path,
            backup: backup,
            temporary: '${target.path}.temporary',
            existed: true,
          ),
        ],
        deletions: const [],
      ),
    );
    await target.rename(backup);
    await File(target.path).writeAsString('new-profile');
    await stores.database.writeAsString('new-database');
    await stores.config.writeAsString('new-config');
    await journal.markCommitted();

    await recover(home, stores);

    expect(await target.readAsString(), 'new-profile');
    expect(await stores.database.readAsString(), 'new-database');
    expect(await stores.config.readAsString(), 'new-config');
    expect(await File(backup).exists(), false);
  });

  test('prepared journal before mutation preserves existing files', () async {
    final home = await Directory.systemTemp.createTemp('restore_journal_');
    addTearDown(() => home.delete(recursive: true));
    final stores = await createStores(home);
    final target = File(p.join(home.path, 'profiles', '1.yaml'))
      ..createSync(recursive: true)
      ..writeAsStringSync('old-profile');
    final journal = await beginJournal(home, stores);
    await journal.prepare(
      RestoreFilePlan(
        replacements: [
          RestoreReplacementPlan(
            target: target.path,
            backup: '${target.path}.backup',
            temporary: '${target.path}.temporary',
            existed: true,
          ),
        ],
        deletions: const [],
      ),
    );

    await recover(home, stores);

    expect(await target.readAsString(), 'old-profile');
  });

  test('prepared journal restores deletions and removes new targets', () async {
    final home = await Directory.systemTemp.createTemp('restore_journal_');
    addTearDown(() => home.delete(recursive: true));
    final stores = await createStores(home);
    final newTarget = File(p.join(home.path, 'profiles', 'new.yaml'));
    final deletedDirectory = Directory(p.join(home.path, 'providers', '1'))
      ..createSync(recursive: true);
    File(p.join(deletedDirectory.path, 'cache')).writeAsStringSync('cache');
    final deletedBackup = '${deletedDirectory.path}.backup';
    final journal = await beginJournal(home, stores);
    await journal.prepare(
      RestoreFilePlan(
        replacements: [
          RestoreReplacementPlan(
            target: newTarget.path,
            backup: '${newTarget.path}.backup',
            temporary: '${newTarget.path}.temporary',
            existed: false,
          ),
        ],
        deletions: [
          RestoreDeletionPlan(
            target: deletedDirectory.path,
            backup: deletedBackup,
            isDirectory: true,
          ),
        ],
      ),
    );
    newTarget
      ..createSync(recursive: true)
      ..writeAsStringSync('new-profile');
    await deletedDirectory.rename(deletedBackup);

    await recover(home, stores);

    expect(await newTarget.exists(), false);
    expect(
      await File(p.join(deletedDirectory.path, 'cache')).readAsString(),
      'cache',
    );
  });

  test('journal rejects paths outside application home', () async {
    final home = await Directory.systemTemp.createTemp('restore_journal_');
    final outside = await Directory.systemTemp.createTemp('restore_outside_');
    addTearDown(() async {
      await home.delete(recursive: true);
      await outside.delete(recursive: true);
    });
    final stores = await createStores(home);
    final journalDirectory = Directory(
      p.join(home.path, '.restore-transaction'),
    )..createSync();
    File(
      p.join(journalDirectory.path, 'database.sqlite'),
    ).writeAsStringSync('database');
    File(
      p.join(journalDirectory.path, 'config.age'),
    ).writeAsStringSync('config');
    File(p.join(journalDirectory.path, 'prepared.json')).writeAsStringSync(
      jsonEncode({
        'version': 1,
        'files': {
          'replacements': [
            {
              'target': p.join(outside.path, 'target'),
              'backup': p.join(outside.path, 'backup'),
              'temporary': p.join(outside.path, 'temporary'),
              'existed': true,
            },
          ],
          'deletions': [],
        },
      }),
    );

    await expectLater(recover(home, stores), throwsFormatException);
  });

  test('journal rejects a symlink ancestor inside application home', () async {
    final home = await Directory.systemTemp.createTemp('restore_journal_');
    final outside = await Directory.systemTemp.createTemp('restore_outside_');
    addTearDown(() async {
      await home.delete(recursive: true);
      await outside.delete(recursive: true);
    });
    final stores = await createStores(home);
    final linked = p.join(home.path, 'profiles');
    try {
      await Link(linked).create(outside.path);
    } on FileSystemException {
      return;
    }
    final journal = await beginJournal(home, stores);
    await expectLater(
      journal.prepare(
        RestoreFilePlan(
          replacements: [
            RestoreReplacementPlan(
              target: p.join(linked, '1.yaml'),
              backup: p.join(linked, '1.yaml.backup'),
              temporary: p.join(linked, '1.yaml.temporary'),
              existed: true,
            ),
          ],
          deletions: const [],
        ),
      ),
      throwsFormatException,
    );
  });
}

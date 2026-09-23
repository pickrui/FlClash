import 'dart:convert';
import 'dart:io';

import 'package:fl_clash/services/config_backup.dart';
import 'package:fl_clash/services/config_reset.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../support/config_backup_fixture.dart';

void main() {
  late Directory directory;
  late String home;
  late ConfigBackup backup;
  late ConfigReset reset;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('config_reset_');
    home = p.join(directory.path, 'clash');
    await Directory(home).create();
    await File(p.join(home, 'FlClash.lock')).writeAsString('lock');
    backup = testConfigBackup();
    reset = ConfigReset(home, backup: backup);
  });
  tearDown(() => directory.delete(recursive: true));

  Future<void> journal(
    String location,
    List<String> names, {
    bool complete = false,
  }) async {
    await File(p.join(home, ConfigReset.journalName)).writeAsBytes(
      await backup.encrypt(
        utf8.encode(
          jsonEncode({
            'version': 1,
            'backup': location,
            'entries': names,
            'complete': complete,
          }),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> readJournal() async =>
      jsonDecode(
            utf8.decode(
              await backup.decrypt(
                await File(p.join(home, ConfigReset.journalName)).readAsBytes(),
              ),
            ),
          )
          as Map<String, dynamic>;
  Future<String> prepare(List<String> names) async {
    final location = await Directory(
      directory.path,
    ).createTemp('clash.recovery-');
    await backup.create(home, names, location.path);
    await journal(p.basename(location.path), names);
    return location.path;
  }

  test(
    'encrypts all original data and names before reset while preserving the held lock',
    () async {
      final values = {
        'config.age': 'encrypted config',
        'flutter_secure_storage.dat': 'protected seed',
        'shared_preferences.json': 'https://dns.example.invalid/dns-query',
        'database.sqlite': 'private-node.example.invalid',
        'database.sqlite-wal': 'wal',
        p.join('profiles', 'private-node.yaml'): 'node-password-test',
      };
      for (final entry in values.entries) {
        final file = File(p.join(home, entry.key));
        await file.parent.create(recursive: true);
        await file.writeAsString(entry.value);
      }
      final heldLock = await File(
        p.join(home, 'FlClash.lock'),
      ).open(mode: FileMode.append);
      await heldLock.lock(FileLock.exclusive);
      try {
        final operation = reset.backupAndReset();
        expect(identical(reset.backupAndReset(), operation), isTrue);
        final location = await operation;
        final records = await backup.verify(location);
        for (final entry in values.entries) {
          final record = records.singleWhere((r) => r['path'] == entry.key);
          final bytes = await backup
              .readFile(location, record['stored'] as String)
              .expand((b) => b)
              .toList();
          expect(utf8.decode(bytes), entry.value);
          expect(await File(p.join(home, entry.key)).exists(), isFalse);
        }
        await for (final file in Directory(location).list(recursive: true)) {
          expect(file, isA<File>());
          final bytes = await File(file.path).readAsBytes();
          final text = utf8.decode(bytes, allowMalformed: true);
          for (final secret in [...values.keys, ...values.values]) {
            // Tiny fixtures such as 'wal' can occur by chance in ciphertext.
            if (secret.length < 12) continue;
            expect(text, isNot(contains(secret)));
            expect(p.basename(file.path), isNot(contains(secret)));
          }
        }
        expect(await File(p.join(home, 'FlClash.lock')).exists(), isTrue);
        // Windows enforces the held byte-range lock even against a second
        // handle in this process. Read through the owning handle instead.
        await heldLock.setPosition(0);
        expect(
          utf8.decode(await heldLock.read(await heldLock.length())),
          'lock',
        );
        expect((await readJournal())['complete'], isTrue);
        final rawJournal = await File(
          p.join(home, ConfigReset.journalName),
        ).readAsBytes();
        expect(
          utf8.decode(rawJournal, allowMalformed: true),
          isNot(contains('shared_preferences.json')),
        );
      } finally {
        await heldLock.close();
      }
    },
  );

  test(
    'an interrupted reset verifies the encrypted backup before deleting remaining originals',
    () async {
      await File(p.join(home, 'config.age')).writeAsString('config');
      await File(
        p.join(home, 'shared_preferences.json'),
      ).writeAsString('preferences');
      final location = await prepare(['config.age', 'shared_preferences.json']);
      await File(p.join(home, 'config.age')).delete();
      await reset.resumePending();
      expect(
        await File(p.join(home, 'shared_preferences.json')).exists(),
        isFalse,
      );
      expect(await backup.verify(location), hasLength(2));
      expect((await readJournal())['complete'], isTrue);
    },
  );

  test(
    'completed reset never removes new configuration on next launch',
    () async {
      await File(p.join(home, 'config.age')).writeAsString('original');
      await reset.backupAndReset();
      await File(p.join(home, 'config.age')).writeAsString('fresh');
      await ConfigReset(home, backup: backup).resumePending();
      expect(await File(p.join(home, 'config.age')).readAsString(), 'fresh');
    },
  );

  test(
    'encryption failure leaves every original and creates no plaintext backup',
    () async {
      const secret = 'sensitive-node-password';
      await File(p.join(home, 'config.yaml')).writeAsString(secret);
      final failing = ConfigBackup(
        encrypt: (_) => throw StateError('DPAPI unavailable'),
      );
      await expectLater(
        ConfigReset(home, backup: failing).backupAndReset(),
        throwsStateError,
      );
      expect(await File(p.join(home, 'config.yaml')).readAsString(), secret);
      expect(
        await File(p.join(home, ConfigReset.journalName)).exists(),
        isFalse,
      );
      expect(
        await directory
            .list()
            .where((entity) => p.basename(entity.path) != p.basename(home))
            .toList(),
        isEmpty,
      );
      await for (final file in directory.list(recursive: true)) {
        if (file is! File || p.isWithin(home, file.path)) continue;
        expect(
          utf8.decode(await file.readAsBytes(), allowMalformed: true),
          isNot(contains(secret)),
        );
      }
    },
  );

  test(
    'corrupted encrypted backup cannot authorize removal of originals',
    () async {
      await File(p.join(home, 'config.age')).writeAsString('original');
      final location = await prepare(['config.age']);
      await File(p.join(location, '1.enc')).writeAsBytes([1, 2, 3]);
      await expectLater(reset.resumePending(), throwsFormatException);
      expect(await File(p.join(home, 'config.age')).readAsString(), 'original');
      expect((await readJournal())['complete'], isFalse);
    },
  );

  test(
    'a changed source or a new file inside a directory blocks reset',
    () async {
      await Directory(p.join(home, 'profiles')).create();
      final file = File(p.join(home, 'profiles', 'a.yaml'));
      await file.writeAsString('original');
      await prepare(['profiles']);
      await file.writeAsString('new');
      await expectLater(
        reset.resumePending(),
        throwsA(isA<FileSystemException>()),
      );
      await file.writeAsString('original');
      await File(
        p.join(home, 'profiles', 'new.yaml'),
      ).writeAsString('new entry');
      await expectLater(
        reset.resumePending(),
        throwsA(isA<FileSystemException>()),
      );
      expect(await file.readAsString(), 'original');
    },
  );

  test(
    'invalid journal paths cannot select external data or the instance lock',
    () async {
      for (final names in [
        ['../outside'],
        [r'..\outside'],
        ['FlClash.lock'],
        ['x', 'x'],
      ]) {
        await journal('clash.recovery-test', names);
        await expectLater(reset.resumePending(), throwsFormatException);
      }
      await journal('../outside', ['config.age']);
      await expectLater(reset.resumePending(), throwsFormatException);
    },
  );

  test(
    'Windows reset verifies its native DPAPI backup before deleting data',
    () async {
      await File(
        p.join(home, 'config.yaml'),
      ).writeAsString('private DNS and node data');
      final location = await ConfigReset(home).backupAndReset();
      expect(await ConfigBackup().verify(location), hasLength(1));
      expect(await File(p.join(home, 'config.yaml')).exists(), isFalse);
    },
    skip: !Platform.isWindows,
  );
}

import 'dart:convert';
import 'dart:io';

import 'package:fl_clash/common/path.dart';
import 'package:fl_clash/common/constant.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('legacyApplicationSupportPathFor', () {
    test('maps macOS and Linux application identifiers', () {
      expect(
        legacyApplicationSupportPathFor(
          '/Users/test/Library/Application Support/com.oixcloud.clash.debug',
          isWindows: false,
        ),
        '/Users/test/Library/Application Support/com.follow.clash.debug',
      );
      expect(
        legacyApplicationSupportPathFor(
          '/Users/com.oixcloud.clash/Application Support/FlClash',
          isWindows: false,
        ),
        isNull,
      );
    });

    test('maps Windows company and product directories', () {
      expect(
        legacyApplicationSupportPathFor(
          r'C:\Users\test\AppData\Roaming\com.oixcloud\clash',
          isWindows: true,
        ),
        r'C:\Users\test\AppData\Roaming\com.follow\clash',
      );
    });
  });

  test('copies legacy data without moving transient instance files', () async {
    final root = await Directory.systemTemp.createTemp(
      'flclash_identity_migration_',
    );
    addTearDown(() => root.delete(recursive: true));
    final legacy = Directory(p.join(root.path, 'legacy'));
    final current = Directory(p.join(root.path, 'current'));
    await File(
      p.join(legacy.path, 'database.sqlite'),
    ).create(recursive: true).then((file) => file.writeAsString('database'));
    await File(
      p.join(legacy.path, 'profiles', '1.yaml'),
    ).create(recursive: true).then((file) => file.writeAsString('profile'));
    await File(
      p.join(legacy.path, 'FlClash.lock'),
    ).create(recursive: true).then((file) => file.writeAsString('lock'));
    final externalFile = File(p.join(root.path, 'external'))
      ..writeAsStringSync('external');
    await Link(p.join(legacy.path, 'external-link')).create(externalFile.path);
    await current.create(recursive: true);

    expect(
      await migrateLegacyApplicationSupportDirectory(
        legacyPath: legacy.path,
        currentPath: current.path,
      ),
      isTrue,
    );
    expect(
      await File(p.join(current.path, 'database.sqlite')).readAsString(),
      'database',
    );
    expect(
      await File(p.join(current.path, 'profiles', '1.yaml')).readAsString(),
      'profile',
    );
    expect(File(p.join(current.path, 'FlClash.lock')).existsSync(), isFalse);
    expect(File(p.join(current.path, 'external-link')).existsSync(), isFalse);
    expect(
      await File(
        p.join(current.path, identityMigrationMarkerName),
      ).readAsString(),
      legacyPackageName,
    );
    expect(File(p.join(legacy.path, 'database.sqlite')).existsSync(), isTrue);
  });

  test('keeps existing current data instead of merging legacy data', () async {
    final root = await Directory.systemTemp.createTemp(
      'flclash_identity_conflict_',
    );
    addTearDown(() => root.delete(recursive: true));
    final legacyFile = File(p.join(root.path, 'legacy', 'config.yaml'));
    final currentFile = File(p.join(root.path, 'current', 'config.yaml'));
    await legacyFile
        .create(recursive: true)
        .then((file) => file.writeAsString('legacy'));
    await currentFile
        .create(recursive: true)
        .then((file) => file.writeAsString('current'));

    expect(
      await migrateLegacyApplicationSupportDirectory(
        legacyPath: legacyFile.parent.path,
        currentPath: currentFile.parent.path,
      ),
      isFalse,
    );
    expect(await currentFile.readAsString(), 'current');
  });

  test('rejects migration while legacy data is in use', () async {
    final root = await Directory.systemTemp.createTemp(
      'flclash_identity_locked_',
    );
    addTearDown(() => root.delete(recursive: true));
    final legacy = Directory(p.join(root.path, 'legacy'));
    final current = Directory(p.join(root.path, 'current'));
    final lockFile = File(p.join(legacy.path, 'FlClash.lock'));
    await lockFile.create(recursive: true);
    final helper = File(p.join(root.path, 'lock_helper.dart'));
    await helper.writeAsString('''
import 'dart:io';

Future<void> main(List<String> arguments) async {
  final lock = await File(arguments.single).open(mode: FileMode.write);
  await lock.lock(FileLock.exclusive);
  stdout.writeln('locked');
  await stdin.first;
  await lock.unlock();
  await lock.close();
}
''');
    final process = await Process.start('dart', [helper.path, lockFile.path]);
    try {
      await process.stdout
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .first
          .timeout(const Duration(seconds: 5));
      await expectLater(
        migrateLegacyApplicationSupportDirectory(
          legacyPath: legacy.path,
          currentPath: current.path,
        ),
        throwsA(isA<FileSystemException>()),
      );
    } finally {
      try {
        process.stdin.writeln();
        await process.stdin.close();
      } catch (_) {}
      await process.exitCode.timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          process.kill();
          return -1;
        },
      );
    }
  });

  test('keeps a caller-held legacy lock after migration', () async {
    final root = await Directory.systemTemp.createTemp(
      'flclash_identity_retained_lock_',
    );
    addTearDown(() => root.delete(recursive: true));
    final legacy = Directory(p.join(root.path, 'legacy'));
    final current = Directory(p.join(root.path, 'current'));
    final lockFile = File(p.join(legacy.path, 'FlClash.lock'));
    await lockFile.create(recursive: true);
    await File(p.join(legacy.path, 'config.yaml')).writeAsString('config');
    final heldLock = await lockFile.open(mode: FileMode.write);
    await heldLock.lock(FileLock.exclusive);

    expect(
      await migrateLegacyApplicationSupportDirectory(
        legacyPath: legacy.path,
        currentPath: current.path,
        heldLegacyLock: heldLock,
      ),
      isTrue,
    );

    final helper = File(p.join(root.path, 'lock_helper.dart'));
    await helper.writeAsString('''
import 'dart:io';

Future<void> main(List<String> arguments) async {
  final lock = await File(arguments.single).open(mode: FileMode.write);
  try {
    await lock.lock(FileLock.exclusive);
    stdout.writeln('locked');
    await lock.unlock();
  } catch (_) {
    stdout.writeln('blocked');
  } finally {
    await lock.close();
  }
}
''');
    try {
      final blockedProcess = await Process.start('dart', [
        helper.path,
        lockFile.path,
      ]);
      expect(
        await blockedProcess.stdout
            .transform(utf8.decoder)
            .transform(const LineSplitter())
            .first,
        'blocked',
      );
      expect(await blockedProcess.exitCode, 0);

      await heldLock.unlock();
      final acquiredProcess = await Process.start('dart', [
        helper.path,
        lockFile.path,
      ]);
      expect(
        await acquiredProcess.stdout
            .transform(utf8.decoder)
            .transform(const LineSplitter())
            .first,
        'locked',
      );
      expect(await acquiredProcess.exitCode, 0);
    } finally {
      try {
        await heldLock.close();
      } catch (_) {}
    }
  });
}

import 'dart:io';

import 'package:fl_clash/services/config_backup.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../support/config_backup_fixture.dart';

void main() {
  late Directory directory;
  late String source;
  late String destination;
  late ConfigBackup backup;
  setUp(() async {
    directory = await Directory.systemTemp.createTemp('config_backup_');
    source = p.join(directory.path, 'source');
    destination = p.join(directory.path, 'backup');
    await Directory(source).create();
    await Directory(destination).create();
    backup = testConfigBackup();
  });
  tearDown(() => directory.delete(recursive: true));

  test(
    'large files stream across encrypted frames and empty files/directories survive',
    () async {
      final data = List.generate(160000, (i) => i % 251);
      await File(p.join(source, 'large.bin')).writeAsBytes(data);
      await File(p.join(source, 'empty.bin')).create();
      await Directory(p.join(source, 'empty')).create();
      await backup.create(source, [
        'large.bin',
        'empty.bin',
        'empty',
      ], destination);
      final records = await backup.verify(destination);
      expect(records, hasLength(3));
      expect(
        await backup
            .readFile(destination, '1.enc')
            .expand((bytes) => bytes)
            .toList(),
        data,
      );
    },
  );

  test(
    'truncation, dropped frames and altered data fail integrity verification',
    () async {
      await File(p.join(source, 'data')).writeAsBytes(List.filled(140000, 11));
      await backup.create(source, ['data'], destination);
      final file = File(p.join(destination, '1.enc'));
      final original = await file.readAsBytes();
      await file.writeAsBytes(original.sublist(0, original.length - 1));
      await expectLater(backup.verify(destination), throwsFormatException);
      await file.writeAsBytes([]);
      await expectLater(backup.verify(destination), throwsFormatException);
      final altered = original.toList()..[12] ^= 1;
      await file.writeAsBytes(altered);
      await expectLater(backup.verify(destination), throwsA(isA<Exception>()));
    },
  );

  test('missing encrypted files do not count as a valid backup', () async {
    await File(p.join(source, 'data')).writeAsString('original');
    await backup.create(source, ['data'], destination);
    await File(p.join(destination, '1.enc')).delete();
    await expectLater(
      backup.verify(destination),
      throwsA(isA<FileSystemException>()),
    );
  });

  test(
    'symbolic link targets are encrypted metadata and never traversed',
    () async {
      final outside = File(p.join(directory.path, 'outside'));
      await outside.writeAsString('must not be read or changed');
      await Link(p.join(source, 'link')).create(outside.path);
      await backup.create(source, ['link'], destination);
      final records = await backup.verify(destination);
      expect(records.single['type'], 'link');
      expect(records.single['target'], outside.path);
      expect(await Directory(destination).list().length, 1);
      expect(await outside.readAsString(), 'must not be read or changed');
    },
    skip: Platform.isWindows,
  );
}

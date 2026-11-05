import 'dart:io';

import 'package:fl_clash/common/file.dart';
import 'package:test/test.dart';

void main() {
  test(
    'withFileRollback restores an existing file when commit fails',
    () async {
      final root = await Directory.systemTemp.createTemp('file_rollback_');
      addTearDown(() => root.delete(recursive: true));
      final file = File('${root.path}/profile.yaml')..writeAsStringSync('old');

      await expectLater(
        withFileRollback(file.path, () async {
          await file.writeAsString('new');
          throw StateError('database failed');
        }),
        throwsStateError,
      );

      expect(await file.readAsString(), 'old');
      expect(
        await root
            .list()
            .where((entity) => entity.path.contains('write-backup'))
            .isEmpty,
        true,
      );
    },
  );

  test(
    'withFileRollback removes a newly created file when commit fails',
    () async {
      final root = await Directory.systemTemp.createTemp('file_rollback_new_');
      addTearDown(() => root.delete(recursive: true));
      final file = File('${root.path}/script.js');

      await expectLater(
        withFileRollback(file.path, () async {
          await file.writeAsString('new');
          throw StateError('database failed');
        }),
        throwsStateError,
      );

      expect(await file.exists(), false);
    },
  );

  test(
    'withFileRollback keeps successful changes and removes its backup',
    () async {
      final root = await Directory.systemTemp.createTemp('file_commit_');
      addTearDown(() => root.delete(recursive: true));
      final file = File('${root.path}/script.js')..writeAsStringSync('old');

      await withFileRollback(file.path, () => file.writeAsString('new'));

      expect(await file.readAsString(), 'new');
      expect(
        await root
            .list()
            .where((entity) => entity.path.contains('write-backup'))
            .isEmpty,
        true,
      );
    },
  );
}

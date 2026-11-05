import 'dart:io';

import 'package:fl_clash/common/script_deletion.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  test('failed database commit restores the script', () async {
    final directory = await Directory.systemTemp.createTemp('script_delete_');
    addTearDown(() => directory.delete(recursive: true));
    final script = File(p.join(directory.path, '7.js'))
      ..writeAsStringSync('content');

    await expectLater(
      commitScriptDeletion<void>(
        scriptPath: script.path,
        scriptId: 7,
        commit: () => throw StateError('database failed'),
      ),
      throwsStateError,
    );

    expect(await script.readAsString(), 'content');
    expect(
      await File(pendingScriptDeletionPath(directory.path, 7)).exists(),
      false,
    );
  });

  test('successful database commit removes the script', () async {
    final directory = await Directory.systemTemp.createTemp('script_delete_');
    addTearDown(() => directory.delete(recursive: true));
    final script = File(p.join(directory.path, '7.js'))
      ..writeAsStringSync('content');

    final result = await commitScriptDeletion(
      scriptPath: script.path,
      scriptId: 7,
      commit: () async => 'committed',
    );

    expect(result, 'committed');
    expect(await script.exists(), false);
    expect(
      await File(pendingScriptDeletionPath(directory.path, 7)).exists(),
      false,
    );
  });

  test(
    'startup recovery restores a script still present in the database',
    () async {
      final directory = await Directory.systemTemp.createTemp('script_delete_');
      addTearDown(() => directory.delete(recursive: true));
      final pending = File(pendingScriptDeletionPath(directory.path, 7))
        ..writeAsStringSync('content');

      await recoverPendingScriptDeletions(
        scriptsPath: directory.path,
        scriptExists: (scriptId) async => scriptId == 7,
      );

      expect(
        await File(p.join(directory.path, '7.js')).readAsString(),
        'content',
      );
      expect(await pending.exists(), false);
    },
  );

  test('startup recovery removes a committed deletion', () async {
    final directory = await Directory.systemTemp.createTemp('script_delete_');
    addTearDown(() => directory.delete(recursive: true));
    final pending = File(pendingScriptDeletionPath(directory.path, 7))
      ..writeAsStringSync('content');

    await recoverPendingScriptDeletions(
      scriptsPath: directory.path,
      scriptExists: (_) async => false,
    );

    expect(await pending.exists(), false);
    expect(await File(p.join(directory.path, '7.js')).exists(), false);
  });
}

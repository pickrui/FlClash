import 'dart:async';
import 'dart:io';
import 'package:setup_hooks/src/artifact_transaction.dart';
import 'package:test/test.dart';

void main() {
  late Directory root;
  late List<File> outputs;
  setUp(() {
    root = Directory.systemTemp.createTempSync('flclash-artifact-transaction-');
    outputs = [
      for (final name in ['Core', 'Helper', 'manifest.json'])
        File('${root.path}/$name')..writeAsStringSync('old-$name'),
    ];
  });
  tearDown(() {
    root.deleteSync(recursive: true);
  });
  Future<T> run<T>(Future<T> Function() build) => withArtifactTransaction(
    rootDir: root.path,
    key: 'windows',
    outputs: outputs.map((f) => f.path).toList(),
    build: build,
  );
  test(
    'Helper failure restores the previous Core, Helper and manifest together',
    () async {
      await expectLater(
        run(() async {
          outputs[0].writeAsStringSync('new-core');
          outputs[1].writeAsStringSync('partial-helper');
          outputs[2].deleteSync();
          throw StateError('Helper failed');
        }),
        throwsStateError,
      );
      expect(outputs.map((f) => f.readAsStringSync()), [
        'old-Core',
        'old-Helper',
        'old-manifest.json',
      ]);
    },
  );
  test(
    'a failed first build removes new outputs and a later retry can commit',
    () async {
      for (final file in outputs) {
        file.deleteSync();
      }
      await expectLater(
        run(() async {
          outputs.first.writeAsStringSync('new-core');
          throw StateError('Helper failed');
        }),
        throwsStateError,
      );
      expect(outputs.every((f) => !f.existsSync()), isTrue);
      await run(() async {
        for (final file in outputs) {
          file.writeAsStringSync('complete');
        }
      });
      expect(outputs.every((f) => f.readAsStringSync() == 'complete'), isTrue);
    },
  );
  test(
    'CPU targets sharing output names serialize the complete artifact set',
    () async {
      final gate = Completer<void>();
      final entered = Completer<void>();
      var secondEntered = false;
      final first = run(() async {
        entered.complete();
        await gate.future;
        outputs.first.writeAsStringSync('arm64');
      });
      await entered.future;
      final second = run(() async {
        secondEntered = true;
        expect(outputs.first.readAsStringSync(), 'arm64');
        outputs.first.writeAsStringSync('amd64');
      });
      await Future<void>.delayed(Duration.zero);
      expect(secondEntered, isFalse);
      gate.complete();
      await Future.wait([first, second]);
      expect(outputs.first.readAsStringSync(), 'amd64');
    },
  );
  test(
    'an obstructed rollback retains backups and releases the build lock',
    () async {
      await expectLater(
        run(() async {
          outputs.first.deleteSync();
          Directory(outputs.first.path).createSync();
          throw StateError('Helper failed');
        }),
        throwsA(isA<FileSystemException>()),
      );
      final backups = Directory(
        '${root.path}/.dart_tool/setup_build_cache',
      ).listSync().whereType<Directory>().toList();
      expect(backups, hasLength(1));
      expect(File('${backups.single.path}/0').readAsStringSync(), 'old-Core');
      Directory(outputs.first.path).deleteSync();
      await run(() async {
        outputs.first.writeAsStringSync('recovered');
      });
      expect(outputs.first.readAsStringSync(), 'recovered');
    },
  );
}

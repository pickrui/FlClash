import 'dart:io';
import 'package:setup_hooks/src/build.dart';
import 'package:setup_hooks/src/go_builder.dart';
import 'package:path/path.dart' as p;
import 'package:setup_hooks/src/target.dart';
import 'package:test/test.dart';

void main() {
  bool goAvailable;
  try {
    goAvailable = Process.runSync('go', ['version']).exitCode == 0;
  } on ProcessException {
    goAvailable = false;
  }
  test('Windows Go cache fallback retains configured roots', () {
    final root = Directory.systemTemp.path;
    for (final environment in [
      {'GoCache': r'D:\go-cache', 'GoPath': r'E:\go'},
      {
        'LocalAppData': r'C:\Users\runner\AppData\Local',
        'UserProfile': r'C:\Users\runner',
      },
    ]) {
      expect(
        goCacheEnvironment(
          rootDir: root,
          environment: environment,
          isWindows: true,
        ),
        isEmpty,
      );
    }
    expect(
      goCacheEnvironment(
        rootDir: root,
        environment: const {},
        isWindows: false,
      ),
      isEmpty,
    );
  });

  test(
    'Go builds with the stripped Windows hook environment',
    () {
      final root = Directory.systemTemp.createTempSync('flclash stripped go ');
      addTearDown(() => root.deleteSync(recursive: true));
      File(
        p.join(root.path, 'go.mod'),
      ).writeAsStringSync('module example.invalid/fixture\n\ngo 1.23\n');
      File(
        p.join(root.path, 'main.go'),
      ).writeAsStringSync('package main\nfunc main() {}\n');
      final environment = {
        for (final entry in Platform.environment.entries)
          if (const {
            'PATH',
            'SYSTEMROOT',
            'TEMP',
            'TMP',
          }.contains(entry.key.toUpperCase()))
            entry.key: entry.value,
        ...goCacheEnvironment(
          rootDir: root.path,
          environment: const {},
          isWindows: true,
        ),
        'CGO_ENABLED': '0',
        'GOTOOLCHAIN': 'local',
        'GOPROXY': 'off',
      };
      final output = p.join(
        root.path,
        Platform.isWindows ? 'fixture.exe' : 'fixture',
      );
      final result = Process.runSync(
        'go',
        ['build', '-o', output, '.'],
        workingDirectory: root.path,
        environment: environment,
        includeParentEnvironment: false,
      );
      expect(result.exitCode, 0, reason: result.stderr.toString());
      expect(File(output).existsSync(), isTrue);
    },
    skip: !goAvailable,
    timeout: const Timeout(Duration(minutes: 2)),
  );

  test(
    'real Go build caches, detects new source files and excludes build trees from hook dependencies',
    () async {
      final root = Directory.systemTemp.createTempSync('flclash-go-build-');
      addTearDown(() => root.deleteSync(recursive: true));
      final core = Directory(p.join(root.path, 'core'))..createSync();
      File(
        p.join(root.path, 'pubspec.yaml'),
      ).writeAsStringSync('name: fixture\n');
      File(
        p.join(core.path, 'go.mod'),
      ).writeAsStringSync('module example.invalid/fixture\n\ngo 1.23\n');
      File(
        p.join(core.path, 'main.go'),
      ).writeAsStringSync('package main\nfunc main() {}\n');
      final request = BuildRequest(
        rootDir: root.path,
        target: Target.macosArm64,
        includeHelper: false,
      );
      final first = await buildPlatform(request);
      expect(first.rebuilt, isTrue);
      expect(File(first.outputs.single).existsSync(), isTrue);
      final buildInfo = Process.runSync('go', [
        'version',
        '-m',
        first.outputs.single,
      ]);
      expect(buildInfo.exitCode, 0, reason: buildInfo.stderr.toString());
      expect(buildInfo.stdout, contains('go1.26.8'));
      expect(first.inputs, contains(core.path));
      expect(first.inputs, isNot(contains(root.path)));
      expect(first.inputs, isNot(contains(p.join(root.path, '.dart_tool'))));
      expect((await buildPlatform(request)).rebuilt, isFalse);
      final added = File(p.join(core.path, 'extra.go'))
        ..writeAsStringSync('package main\nconst extra = 1\n');
      final changed = await buildPlatform(request);
      expect(changed.rebuilt, isTrue);
      expect(changed.inputs, contains(added.path));
      File(changed.outputs.single).deleteSync();
      expect((await buildPlatform(request)).rebuilt, isTrue);
    },
    skip: !goAvailable,
    timeout: const Timeout(Duration(minutes: 2)),
  );
}

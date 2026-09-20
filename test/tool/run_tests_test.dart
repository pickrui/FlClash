import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final runner = File('tool/run_tests.dart').absolute.path;
  const dart = 'dart';
  const original =
      'name: edited_fixture\r\nversion: 0.8.98+2026092009\r\n'
      'hooks:\r\n  user_defines:\r\n    setup:\r\n      build_assets: true\r\n'
      '    rust_api:\r\n      build_assets: false\r\n';
  late Directory temp;
  late File pubspec;
  late File flutter;

  setUp(() {
    temp = Directory.systemTemp.createTempSync('flclash-test-runner-');
    pubspec = File('${temp.path}/pubspec.yaml')..writeAsStringSync(original);
    flutter = File('${temp.path}/flutter');
  });
  tearDown(() => temp.deleteSync(recursive: true));

  Map<String, String> environment() => {
    'PATH': '${temp.path}:${Platform.environment['PATH']}',
  };
  Future<void> stub(String body) async {
    flutter.writeAsStringSync('#!/bin/sh\n$body\n');
    await Process.run('chmod', ['+x', flutter.path]);
  }

  for (final status in [0, 17]) {
    test(
      'restores an edited CRLF pubspec after exit $status',
      () async {
        await stub(
          'grep -q "build_assets: true" pubspec.yaml && exit 99\nexit $status',
        );
        final result = await Process.run(
          dart,
          [runner, '--no-pub'],
          workingDirectory: temp.path,
          environment: environment(),
        );
        expect(result.exitCode, status, reason: result.stderr.toString());
        expect(pubspec.readAsBytesSync(), utf8.encode(original));
      },
      skip: Platform.isWindows,
    );
  }

  test(
    'preserves edits made while tests run and restores both original switches',
    () async {
      await stub('echo "description: concurrent edit" >> pubspec.yaml');
      final result = await Process.run(
        dart,
        [runner],
        workingDirectory: temp.path,
        environment: environment(),
      );
      expect(result.exitCode, 1);
      expect(
        pubspec.readAsStringSync(),
        '$original'
        'description: concurrent edit\n',
      );
    },
    skip: Platform.isWindows,
  );

  test('restores pubspec after the runner receives SIGTERM', () async {
    await stub('echo ready > ready\nexec sleep 30');
    final child = await Process.start(
      dart,
      [runner],
      workingDirectory: temp.path,
      environment: environment(),
    );
    final stdoutDone = child.stdout.drain<void>();
    final stderrDone = child.stderr.drain<void>();
    addTearDown(() => child.kill(ProcessSignal.sigkill));
    final ready = File('${temp.path}/ready');
    final deadline = DateTime.now().add(const Duration(seconds: 10));
    while (!ready.existsSync() && DateTime.now().isBefore(deadline)) {
      await Future<void>.delayed(const Duration(milliseconds: 20));
    }
    expect(ready.existsSync(), isTrue);
    child.kill(ProcessSignal.sigterm);
    expect(await child.exitCode.timeout(const Duration(seconds: 10)), 143);
    await Future.wait([stdoutDone, stderrDone]);
    expect(pubspec.readAsBytesSync(), utf8.encode(original));
  }, skip: Platform.isWindows);
}

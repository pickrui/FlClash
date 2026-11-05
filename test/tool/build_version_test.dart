import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:yaml/yaml.dart';

import '../../setup.dart' as setup;

void main() {
  group('release build dates', () {
    test('uses the requested compilation date in Beijing time', () {
      expect(
        setup.buildNumberForTime(DateTime.utc(2026, 9, 15, 11, 59, 59)),
        '2026091519',
      );
    });

    test('handles midnight, month, leap day and year boundaries', () {
      for (final entry in {
        DateTime.utc(2026, 9, 15, 15, 59): '2026091523',
        DateTime.utc(2026, 9, 15, 16): '2026091600',
        DateTime.utc(2026, 9, 30, 16): '2026100100',
        DateTime.utc(2028, 2, 28, 16): '2028022900',
        DateTime.utc(2026, 12, 31, 16): '2027010100',
      }.entries) {
        expect(setup.buildNumberForTime(entry.key), entry.value);
        expect(setup.buildNumberForTime(entry.key.toLocal()), entry.value);
      }
    });
  });

  group('app packaging version preparation', () {
    late Directory temp;
    late File pubspec;

    setUp(() {
      temp = Directory.systemTemp.createTempSync('flclash build version ');
      pubspec = File('${temp.path}/pubspec.yaml');
    });
    tearDown(() => temp.deleteSync(recursive: true));

    test('replaces future and stale snapshots with the actual build date', () {
      for (final suffix in ['2026092919', '2026010100']) {
        final source =
            'name: fixture\r\n'
            'version: 0.8.97+$suffix\r\n'
            'hooks:\r\n  user_defines: {}\r\n';
        pubspec.writeAsStringSync(source);
        setup.Build.prepareAppVersion(
          pubspecFile: pubspec,
          now: DateTime.utc(2026, 9, 15, 11),
          environment: {},
        );
        expect(
          pubspec.readAsStringSync(),
          source.replaceFirst(suffix, '2026091519'),
        );
      }
    });

    test('reuses the CI batch date even if an architecture builds later', () {
      pubspec.writeAsStringSync('version: 0.8.97+2026092919\n');
      setup.Build.prepareAppVersion(
        pubspecFile: pubspec,
        now: DateTime.utc(2026, 9, 16, 1),
        environment: {
          'FLUTTER_VERSION_NUMBER': '0.8.97',
          'FLUTTER_BUILD_NUMBER': '2026091519',
        },
      );
      expect(pubspec.readAsStringSync(), 'version: 0.8.97+2026091519\n');
    });

    test('a version override alone still generates a fresh build date', () {
      pubspec.writeAsStringSync('version: 0.8.97+2026092919\n');
      setup.Build.prepareAppVersion(
        pubspecFile: pubspec,
        now: DateTime.utc(2026, 9, 15, 11),
        environment: {'FLUTTER_VERSION_NUMBER': '0.8.98-beta.1'},
      );
      expect(pubspec.readAsStringSync(), 'version: 0.8.98-beta.1+2026091519\n');
    });

    test('invalid overrides fail without changing the source', () {
      const source = 'version: 0.8.97+2026092919\n';
      for (final environment in [
        {'FLUTTER_VERSION_NUMBER': 'invalid'},
        {'FLUTTER_BUILD_NUMBER': 'invalid'},
        {'FLUTTER_BUILD_NUMBER': '123'},
      ]) {
        pubspec.writeAsStringSync(source);
        expect(
          () => setup.Build.prepareAppVersion(
            pubspecFile: pubspec,
            environment: environment,
          ),
          throwsFormatException,
        );
        expect(pubspec.readAsStringSync(), source);
      }
    });

    test('a missing version fails without changing the source', () {
      const source = 'name: fixture\n';
      pubspec.writeAsStringSync(source);
      expect(
        () => setup.Build.prepareAppVersion(
          pubspecFile: pubspec,
          environment: {},
        ),
        throwsFormatException,
      );
      expect(pubspec.readAsStringSync(), source);
    });
  });

  test(
    'the real CI script ignores the future pubspec floor and matches setup',
    () async {
      final workflow =
          loadYaml(File('.github/workflows/build.yaml').readAsStringSync())
              as YamlMap;
      final job = (workflow['jobs'] as YamlMap)['version'] as YamlMap;
      final step = (job['steps'] as YamlList).cast<YamlMap>().singleWhere(
        (step) => step['id'] == 'version',
      );
      final temp = Directory.systemTemp.createTempSync('flclash CI version ');
      addTearDown(() => temp.deleteSync(recursive: true));
      final bin = Directory('${temp.path}/bin')..createSync();
      final date = File('${bin.path}/date')
        ..writeAsStringSync(
          '#!/bin/sh\n'
          'printf "%s\\n" "\$TZ" "\$@" > "\$DATE_CALL"\n'
          'printf "%s\\n" 2026091519\n',
        );
      final chmod = await Process.run('chmod', ['+x', date.path]);
      expect(chmod.exitCode, 0);
      final pubspec = File('${temp.path}/pubspec.yaml')
        ..writeAsStringSync('version: 0.8.97+2026092919\n');
      final output = File('${temp.path}/output');
      final dateCall = File('${temp.path}/date-call');
      final environment = <String, String>{
        'PATH': '${bin.path}:${Platform.environment['PATH']}',
        'GITHUB_OUTPUT': output.path,
        'DATE_CALL': dateCall.path,
        for (final entry in (step['env'] as YamlMap).entries)
          entry.key as String: entry.value as String,
      };
      final result = await Process.run(
        'bash',
        ['-c', step['run'] as String],
        workingDirectory: temp.path,
        environment: environment,
        includeParentEnvironment: false,
      );
      expect(result.exitCode, 0, reason: '${result.stderr}');
      expect(dateCall.readAsLinesSync(), ['Asia/Shanghai', '+%Y%m%d%H']);
      expect(output.readAsLinesSync(), [
        'version_number=0.8.97',
        'build_number=2026091519',
        'full_version=0.8.97+2026091519',
      ]);
      setup.Build.prepareAppVersion(
        pubspecFile: pubspec,
        now: DateTime.utc(2026, 9, 15, 11),
        environment: {},
      );
      expect(pubspec.readAsStringSync(), 'version: 0.8.97+2026091519\n');
    },
    skip: Platform.isWindows ? 'CI version generation runs on Ubuntu' : false,
  );
}

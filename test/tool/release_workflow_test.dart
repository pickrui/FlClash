import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:yaml/yaml.dart';

void main() {
  late YamlMap jobs;
  setUp(() {
    jobs =
        (loadYaml(File('.github/workflows/build.yaml').readAsStringSync())
                as YamlMap)['jobs']
            as YamlMap;
  });

  test(
    'packaging overlaps depth checks while publication waits for every gate',
    () {
      expect(jobs['build']['needs'], ['version', 'go-test']);
      expect(
        jobs['upload']['needs'],
        containsAll(['version', 'build', 'checks']),
      );
      expect(
        jobs['checks']['needs'],
        containsAll([
          'version',
          'test',
          'go-test',
          'deep-tests',
          'android-core-test',
          'android-test',
          'android-native-test',
          'windows-helper-test',
        ]),
      );
      expect(jobs['checks']['if'], contains('always()'));
      final step = (jobs['checks']['steps'] as YamlList).last as YamlMap;
      expect(step['env']['NEEDS_JSON'], contains('toJSON(needs)'));
      expect(step['run'], 'python3 tool/release_checks.py gate');
    },
  );

  test(
    'each standalone Android build verifies the manifest before artifact upload',
    () {
      final build = jobs['build'] as YamlMap;
      final matrix = build['strategy']['matrix']['include'] as YamlList;
      expect(
        matrix
            .where((row) => row['platform'] == 'android')
            .map((row) => row['arch']),
        unorderedEquals(['arm64', 'arm', 'amd64']),
      );
      final steps = (build['steps'] as YamlList).cast<YamlMap>();
      final verify = steps.indexWhere(
        (step) => step['name'] == 'Verify final Android APK version',
      );
      final upload = steps.indexWhere((step) => step['name'] == 'Upload');
      expect(verify, greaterThan(0));
      expect(verify, lessThan(upload));
      expect(steps[verify]['if'], "matrix.platform == 'android'");
      expect(
        steps[verify]['env']['RELEASE_BUILD'],
        contains('needs.version.outputs.build_number'),
      );
      expect(steps[verify]['run'], contains('tool/check_apk_version.py'));
      expect(
        File('setup.dart').readAsStringSync(),
        isNot(contains("'--split-per-abi'")),
      );
    },
  );

  test(
    'deep checks remain callable by releases and scheduled without a release',
    () {
      final workflow =
          loadYaml(
                File('.github/workflows/go-deep-tests.yaml').readAsStringSync(),
              )
              as YamlMap;
      expect(workflow['on']['workflow_call'], isNotNull);
      expect(workflow['on']['schedule'], isNotEmpty);
      expect(
        (workflow['jobs'] as YamlMap).keys,
        containsAll(['go-deep-test', 'go-deep-deps-test']),
      );
      expect(
        jobs['deep-tests']['if'],
        "needs.version.outputs.deep_tests == 'true'",
      );
      expect(
        jobs['deep-tests']['uses'],
        './.github/workflows/go-deep-tests.yaml',
      );
    },
  );
}

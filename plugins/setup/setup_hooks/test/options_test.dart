import 'dart:io';

import 'package:setup_hooks/src/options.dart';
import 'package:test/test.dart';

void main() {
  test('release defaults retain the mips policy in the build fingerprint', () {
    final root = Directory.systemTemp.createTempSync('mips_build_options_');
    addTearDown(() => root.deleteSync(recursive: true));
    final config = BuildConfig.load(rootDir: root.path);
    final tags = config.tags.split(',');
    expect(tags, containsAll(['with_gvisor', 'with_mips_low_memory']));
    expect(tags, isNot(contains('with_low_memory')));
    expect(
      config.withCoreSecrets('fixture').toFingerprintMap()['tags'],
      config.tags,
    );
  });
}

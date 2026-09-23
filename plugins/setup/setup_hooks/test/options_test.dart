import 'package:setup_hooks/src/options.dart';
import 'package:test/test.dart';

void main() {
  test('release defaults retain the mips policy in the build fingerprint', () {
    const config = BuildConfig.release;
    final tags = config.tags.split(',');
    expect(tags, containsAll(['with_gvisor', 'with_mips_low_memory']));
    expect(tags, isNot(contains('with_low_memory')));
    expect(
      config.withCoreSecrets('fixture').toFingerprintMap()['tags'],
      config.tags,
    );
  });
}

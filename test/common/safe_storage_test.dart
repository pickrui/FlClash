import 'package:fl_clash/utils/safe_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
  });

  test('legacySecureStorageValue reads a string value', () {
    expect(
      legacySecureStorageValue(
        '{"config_age_seed":"seed","cloud_token":"token"}',
        'cloud_token',
      ),
      'token',
    );
  });

  test('legacySecureStorageValue rejects a non-object payload', () {
    expect(
      () => legacySecureStorageValue('["token"]', 'cloud_token'),
      throwsFormatException,
    );
  });

  test('legacy macOS storage is read only with migration evidence', () {
    expect(
      shouldReadLegacyMacStorage(
        migrationMarked: true,
        identityMigrated: false,
      ),
      true,
    );
    expect(
      shouldReadLegacyMacStorage(
        migrationMarked: false,
        identityMigrated: true,
      ),
      true,
    );
    expect(
      shouldReadLegacyMacStorage(
        migrationMarked: false,
        identityMigrated: false,
      ),
      false,
    );
  });

  test('macOS fallback write clears a previous deletion marker', () async {
    SharedPreferences.setMockInitialValues({
      SafeStorage.deletionMarkerKey('cloud_token'): true,
    });

    await SafeStorage.write('cloud_token', 'new-token');

    final prefs = await SharedPreferences.getInstance();
    expect(await SafeStorage.read('cloud_token'), 'new-token');
    expect(
      prefs.containsKey(SafeStorage.deletionMarkerKey('cloud_token')),
      false,
    );
  });

  test('macOS fallback deletion prevents value resurrection', () async {
    await SafeStorage.write('cloud_token', 'token');
    await SafeStorage.delete('cloud_token');

    final prefs = await SharedPreferences.getInstance();
    expect(await SafeStorage.read('cloud_token'), isNull);
    expect(prefs.getBool(SafeStorage.deletionMarkerKey('cloud_token')), true);
  });
}

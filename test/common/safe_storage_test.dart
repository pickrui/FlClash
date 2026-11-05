import 'dart:async';
import 'dart:io';

import 'package:fl_clash/utils/safe_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('plugins.it_nomads.com/flutter_secure_storage');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  late Directory tempDir;
  late List<MethodCall> keychainCalls;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp('safe_storage_test_');
    PathProviderPlatform.instance = _FakePathProvider(tempDir.path);
  });

  tearDownAll(() async {
    await tempDir.delete(recursive: true);
  });

  setUp(() {
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    SharedPreferences.setMockInitialValues({});
    keychainCalls = [];
    messenger.setMockMethodCallHandler(channel, (call) async {
      keychainCalls.add(call);
      return null;
    });
  });

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
    messenger.setMockMethodCallHandler(channel, null);
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

  test('macOS keychain failure can recover on explicit retry', () async {
    const key = 'retry_seed';
    var attempts = 0;
    messenger.setMockMethodCallHandler(channel, (call) async {
      expect(call.method, 'read');
      expect(call.arguments['key'], key);
      expect(
        call.arguments['options']['authenticationUIBehavior'],
        'u_AuthUIF',
      );
      expect(call.arguments['options']['usesDataProtectionKeychain'], 'false');
      if (++attempts == 1) {
        throw PlatformException(code: 'locked');
      }
      return 'recovered-seed';
    });

    expect(await SafeStorage.read(key, legacyEvidence: true), isNull);
    expect(await SafeStorage.read(key, legacyEvidence: true), isNull);
    expect(attempts, 1);
    expect(
      await SafeStorage.read(key, legacyEvidence: true, retry: true),
      'recovered-seed',
    );
    expect(attempts, 2);
    expect(await SafeStorage.read(key), 'recovered-seed');
    expect(attempts, 2);
  });

  test(
    'durable evidence allows legacy recovery without migration markers',
    () async {
      const key = 'evidence_seed';
      messenger.setMockMethodCallHandler(channel, (call) async {
        keychainCalls.add(call);
        return 'recovered-seed';
      });

      expect(await SafeStorage.read(key), isNull);
      expect(keychainCalls, isEmpty);
      expect(
        await SafeStorage.read(key, legacyEvidence: true),
        'recovered-seed',
      );
      expect(keychainCalls, hasLength(1));
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(key), 'recovered-seed');
      expect(prefs.getBool('__safe_storage_migrated_$key'), isTrue);
    },
  );

  for (final invalidValue in <Object>['damaged-seed', 123]) {
    test(
      'invalid macOS preference $invalidValue recovers a valid legacy seed',
      () async {
        const key = 'config_age_seed';
        SharedPreferences.setMockInitialValues({key: invalidValue});
        messenger.setMockMethodCallHandler(channel, (call) async {
          keychainCalls.add(call);
          return 'valid-seed';
        });

        expect(
          await SafeStorage.read(
            key,
            legacyEvidence: true,
            isValid: (value) => value == 'valid-seed',
          ),
          'valid-seed',
        );
        expect(keychainCalls, hasLength(1));
        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString(key), 'valid-seed');
      },
    );
  }

  test('invalid legacy seed does not replace a damaged preference', () async {
    const key = 'invalid_legacy_seed';
    SharedPreferences.setMockInitialValues({key: 'damaged-seed'});
    messenger.setMockMethodCallHandler(channel, (call) async => 'also-damaged');

    expect(
      await SafeStorage.read(
        key,
        legacyEvidence: true,
        isValid: (value) => value == 'valid-seed',
      ),
      isNull,
    );
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(key), 'damaged-seed');
    expect(prefs.containsKey('__safe_storage_migrated_$key'), isFalse);
  });

  test(
    'another keychain key failing does not suppress seed recovery',
    () async {
      messenger.setMockMethodCallHandler(channel, (call) async {
        keychainCalls.add(call);
        if (call.arguments['key'] == 'cloud_token') {
          throw PlatformException(code: 'locked');
        }
        return 'valid-seed';
      });

      expect(
        await SafeStorage.read('cloud_token', legacyEvidence: true),
        isNull,
      );
      expect(
        await SafeStorage.read('config_age_seed', legacyEvidence: true),
        'valid-seed',
      );
      expect(keychainCalls, hasLength(2));
    },
  );

  test('retry and legacy evidence cannot override a deletion marker', () async {
    const key = 'deleted_seed';
    final deletionKey = SafeStorage.deletionMarkerKey(key);
    SharedPreferences.setMockInitialValues({
      key: 'deleted-seed',
      deletionKey: true,
    });

    expect(
      await SafeStorage.read(key, retry: true, legacyEvidence: true),
      isNull,
    );
    expect(keychainCalls, isEmpty);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.containsKey(key), isFalse);
    expect(prefs.getBool(deletionKey), isTrue);
  });

  test('deletion during legacy recovery cannot resurrect the seed', () async {
    const key = 'deleted_while_reading_seed';
    final started = Completer<void>();
    final result = Completer<String>();
    messenger.setMockMethodCallHandler(channel, (call) async {
      started.complete();
      return result.future;
    });

    final read = SafeStorage.read(key, legacyEvidence: true);
    await started.future;
    await SafeStorage.delete(key);
    result.complete('old-seed');

    expect(await read, isNull);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.containsKey(key), isFalse);
    expect(prefs.getBool(SafeStorage.deletionMarkerKey(key)), isTrue);
  });

  test('a newer macOS write supersedes an in-flight legacy read', () async {
    const key = 'replaced_while_reading_seed';
    final started = Completer<void>();
    final result = Completer<String>();
    messenger.setMockMethodCallHandler(channel, (call) async {
      started.complete();
      return result.future;
    });

    final read = SafeStorage.read(key, legacyEvidence: true);
    await started.future;
    await SafeStorage.write(key, 'new-seed');
    result.complete('old-seed');

    expect(await read, isNull);
    expect(await SafeStorage.read(key), 'new-seed');
  });

  for (final platform in [TargetPlatform.android, TargetPlatform.windows]) {
    test('$platform deletion invalidates an in-flight secure read', () async {
      debugDefaultTargetPlatformOverride = platform;
      const key = 'deleted_secure_token';
      final started = Completer<void>();
      final result = Completer<String>();
      var secureDeleted = false;
      messenger.setMockMethodCallHandler(channel, (call) async {
        switch (call.method) {
          case 'read':
            if (secureDeleted) return null;
            started.complete();
            return result.future;
          case 'delete':
            secureDeleted = true;
            return null;
          default:
            fail('Unexpected secure storage method: ${call.method}');
        }
      });

      final read = SafeStorage.read(key);
      await started.future;
      await SafeStorage.delete(key);
      result.complete('old-token');

      expect(await read, isNull);
      expect(await SafeStorage.read(key), isNull);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(SafeStorage.deletionMarkerKey(key)), isTrue);
    });

    test('$platform deletion follows an in-flight migration write', () async {
      debugDefaultTargetPlatformOverride = platform;
      const key = 'deleted_migrating_token';
      SharedPreferences.setMockInitialValues({key: 'old-token'});
      final started = Completer<void>();
      final releaseWrite = Completer<void>();
      String? secureValue;
      messenger.setMockMethodCallHandler(channel, (call) async {
        switch (call.method) {
          case 'read':
            return secureValue;
          case 'write':
            started.complete();
            await releaseWrite.future;
            secureValue = call.arguments['value'] as String;
            return null;
          case 'delete':
            secureValue = null;
            return null;
          default:
            fail('Unexpected secure storage method: ${call.method}');
        }
      });

      final read = SafeStorage.read(key);
      await started.future;
      final deletion = SafeStorage.delete(key);
      releaseWrite.complete();

      expect(await read, isNull);
      await deletion;
      expect(secureValue, isNull);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.containsKey(key), isFalse);
      expect(prefs.getBool(SafeStorage.deletionMarkerKey(key)), isTrue);
    });
  }

  test('failed secure mutation does not block a subsequent write', () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    const key = 'retry_secure_write';
    var writes = 0;
    String? secureValue;
    messenger.setMockMethodCallHandler(channel, (call) async {
      if (call.method == 'write') {
        if (++writes == 1) throw PlatformException(code: 'locked');
        secureValue = call.arguments['value'] as String;
        return null;
      }
      expect(call.method, 'read');
      return secureValue;
    });

    await expectLater(
      SafeStorage.write(key, 'first'),
      throwsA(isA<PlatformException>()),
    );
    await SafeStorage.write(key, 'second');

    expect(await SafeStorage.read(key), 'second');
    expect(writes, 2);
  });
}

class _FakePathProvider extends PathProviderPlatform {
  final String path;

  _FakePathProvider(this.path);

  @override
  Future<String?> getTemporaryPath() async => path;

  @override
  Future<String?> getApplicationSupportPath() async => path;

  @override
  Future<String?> getApplicationCachePath() async => path;

  @override
  Future<String?> getDownloadsPath() async => path;
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fl_clash/common/path.dart';
import 'package:fl_clash/services/config_key_store.dart';
import 'package:fl_clash/utils/safe_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const preferencesChannel = MethodChannel(
    'plugins.flutter.io/shared_preferences',
  );
  const keychainChannel = MethodChannel(
    'plugins.it_nomads.com/flutter_secure_storage',
  );
  const seedKey = 'config_age_seed';
  const persistedSeedKey = 'flutter.$seedKey';
  final seedA = base64Encode(List<int>.filled(32, 1));
  final seedB = base64Encode(List<int>.filled(32, 2));
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  late Directory directory;
  late String configPath;
  late Map<String, Object> persistedPreferences;
  late List<MethodCall> preferenceWrites;
  Future<void> Function()? beforeSeedWrite;

  setUpAll(() async {
    directory = await Directory.systemTemp.createTemp('config_key_store_test_');
    PathProviderPlatform.instance = _FakePathProvider(directory.path);
    configPath = await appPath.durableConfigPath;
  });

  tearDownAll(() async {
    await directory.delete(recursive: true);
  });

  setUp(() async {
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    SharedPreferences.resetStatic();
    persistedPreferences = {};
    preferenceWrites = [];
    beforeSeedWrite = null;
    messenger.setMockMethodCallHandler(preferencesChannel, (call) async {
      switch (call.method) {
        case 'getAll':
          return Map<String, Object>.from(persistedPreferences);
        case 'setString':
        case 'setBool':
          preferenceWrites.add(call);
          final key = call.arguments['key'] as String;
          if (key == persistedSeedKey) {
            await beforeSeedWrite?.call();
          }
          persistedPreferences[key] = call.arguments['value'] as Object;
          return true;
        case 'remove':
          persistedPreferences.remove(call.arguments['key']);
          return true;
        default:
          fail('Unexpected preferences method: ${call.method}');
      }
    });
    messenger.setMockMethodCallHandler(keychainChannel, (call) async {
      expect(call.method, 'read');
      expect(call.arguments['key'], seedKey);
      return null;
    });

    // Invalidate the real static caches without creating a replacement seed.
    final blocker = File(configPath);
    await blocker.writeAsString('existing encrypted configuration');
    await expectLater(
      ConfigKeyStore.reload(),
      throwsA(isA<ConfigKeyUnavailableException>()),
    );
    await blocker.delete();
    expect(persistedPreferences.containsKey(persistedSeedKey), isFalse);
    expect(preferenceWrites, isEmpty);
  });

  tearDown(() async {
    messenger.setMockMethodCallHandler(preferencesChannel, null);
    messenger.setMockMethodCallHandler(keychainChannel, null);
    debugDefaultTargetPlatformOverride = null;
    for (final suffix in ['', '.tmp', '.old']) {
      final file = File('$configPath$suffix');
      if (await file.exists()) {
        await file.delete();
      }
    }
  });

  for (final suffix in ['.tmp', '.old']) {
    test(
      'a lone config.age$suffix prevents creating a replacement seed',
      () async {
        final candidate = File('$configPath$suffix');
        await candidate.writeAsString('preserved encrypted configuration');

        await expectLater(
          ConfigKeyStore.seedBase64(),
          throwsA(isA<ConfigKeyUnavailableException>()),
        );

        expect(await File(configPath).exists(), isFalse);
        expect(
          await candidate.readAsString(),
          'preserved encrypted configuration',
        );
        expect(persistedPreferences.containsKey(persistedSeedKey), isFalse);
        expect(preferenceWrites, isEmpty);
        final prefs = await SharedPreferences.getInstance();
        expect(prefs.containsKey(seedKey), isFalse);
      },
    );
  }

  test(
    'reload replaces both cached seed and identity after external recovery',
    () async {
      persistedPreferences[persistedSeedKey] = seedA;
      await ConfigKeyStore.reload();
      expect(await ConfigKeyStore.seedBase64(), seedA);
      final identityA = await ConfigKeyStore.identity();
      final prefs = await SharedPreferences.getInstance();

      persistedPreferences[persistedSeedKey] = seedB;
      expect(prefs.getString(seedKey), seedA);
      expect(await ConfigKeyStore.seedBase64(), seedA);

      await ConfigKeyStore.reload();

      expect(prefs.getString(seedKey), seedB);
      expect(await ConfigKeyStore.seedBase64(), seedB);
      final identityB = await ConfigKeyStore.identity();
      expect(
        identityB.publicKeyBytes,
        isNot(orderedEquals(identityA.publicKeyBytes)),
      );
      expect(preferenceWrites, isEmpty);
    },
  );

  test('concurrent seed loads create and persist one seed', () async {
    final writing = Completer<void>();
    final releaseWrite = Completer<void>();
    beforeSeedWrite = () async {
      if (!writing.isCompleted) {
        writing.complete();
      }
      await releaseWrite.future;
    };

    final loads = List<Future<String>>.generate(
      12,
      (_) => ConfigKeyStore.seedBase64(),
    );
    await writing.future;
    releaseWrite.complete();
    final seeds = await Future.wait(loads);

    expect(seeds.toSet(), hasLength(1));
    expect(ConfigKeyStore.decodeSeed(seeds.first), isNotNull);
    expect(persistedPreferences[persistedSeedKey], seeds.first);
    expect(
      preferenceWrites.where(
        (call) => call.arguments['key'] == persistedSeedKey,
      ),
      hasLength(1),
    );
  });

  // Clearing intentionally invalidates the store for this isolate permanently.
  test(
    'clear waits for an in-flight recovery and prevents seed resurrection',
    () async {
      await File(configPath).writeAsString('existing encrypted configuration');
      final reading = Completer<void>();
      final legacyValue = Completer<String>();
      messenger.setMockMethodCallHandler(keychainChannel, (call) async {
        expect(call.method, 'read');
        reading.complete();
        return legacyValue.future;
      });

      final pending = ConfigKeyStore.seedBase64();
      final invalidated = expectLater(pending, throwsStateError);
      await reading.future;
      final clearing = ConfigKeyStore.clear();
      legacyValue.complete(seedA);
      await invalidated;
      await clearing;

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.containsKey(seedKey), isFalse);
      expect(persistedPreferences.containsKey(persistedSeedKey), isFalse);
      expect(prefs.getBool(SafeStorage.deletionMarkerKey(seedKey)), isTrue);
      await expectLater(ConfigKeyStore.seedBase64(), throwsStateError);
      expect(
        await SafeStorage.read(seedKey, retry: true, legacyEvidence: true),
        isNull,
      );
    },
  );
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

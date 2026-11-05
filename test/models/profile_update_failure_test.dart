import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fl_clash/common/path.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/services/age_crypto.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final configReader = Platform.environment['FLCLASH_TEST_ROUTING_CHECKER'];
  test(
    'Core starts from the encrypted runtime file without rawConfig',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'runtime-config-',
      );
      addTearDown(() => directory.delete(recursive: true));
      final seed = Uint8List(32)..fillRange(0, 32, 7);
      final identity = await AgeCrypto.identityFromSeed(seed);
      final ciphertext = await AgeCrypto.encrypt(
        utf8.encode(
          'mixed-port: 17890\nexternal-controller: ""\ngeo-auto-update: false\ndns: {enable: false}\nrules: ["MATCH,DIRECT"]\n',
        ),
        identity.publicKeyBytes,
      );
      final target = File('${directory.path}/config.yaml');
      await writeEncryptedProfileSnapshot(target.path, ciphertext);
      final process = await Process.start(
        configReader!,
        ['-test.run=^TestEncryptedRuntimeConfigFromDisk\$'],
        includeParentEnvironment: false,
        environment: {
          'FLCLASH_RUNTIME_CONFIG_FIXTURE': target.path,
          'FLCLASH_RUNTIME_CONFIG_TEST_KEY': base64Encode(seed),
        },
      );
      final output = process.stdout.transform(utf8.decoder).join();
      final errors = process.stderr.transform(utf8.decoder).join();
      final exitCode = await process.exitCode.timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          process.kill(ProcessSignal.sigkill);
          throw TimeoutException(
            'encrypted runtime configuration test timed out',
          );
        },
      );
      expect(exitCode, 0, reason: '${await output}\n${await errors}');
      expect(await target.readAsBytes(), ciphertext);
    },
    skip: configReader == null,
  );

  test(
    'encrypted snapshots replace atomically and remain device-bound',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'profile-snapshot-',
      );
      addTearDown(() => directory.delete(recursive: true));
      final identity = await AgeCrypto.identityFromSeed(
        Uint8List(32)..fillRange(0, 32, 7),
      );
      final otherIdentity = await AgeCrypto.identityFromSeed(
        Uint8List(32)..fillRange(0, 32, 8),
      );
      final target = File('${directory.path}/private/config.yaml');
      final first = await AgeCrypto.encrypt(
        utf8.encode('rules: [MATCH,DIRECT]'),
        identity.publicKeyBytes,
      );
      await writeEncryptedProfileSnapshot(target.path, first);
      const plaintext = 'mixed-port: 17890\nrules: [MATCH,REJECT]\n';
      final ciphertext = await AgeCrypto.encrypt(
        utf8.encode(plaintext),
        identity.publicKeyBytes,
      );

      await writeEncryptedProfileSnapshot(target.path, ciphertext);

      final stored = await target.readAsBytes();
      expect(AgeCrypto.isArmored(stored), isTrue);
      expect(utf8.decode(stored), isNot(contains('mixed-port')));
      expect(utf8.decode(await AgeCrypto.decrypt(stored, identity)), plaintext);
      await expectLater(
        AgeCrypto.decrypt(stored, otherIdentity),
        throwsA(isA<Exception>()),
      );
      expect(await target.parent.list().map((entry) => entry.path).toList(), [
        target.path,
      ]);

      await expectLater(
        writeEncryptedProfileSnapshot(
          target.path,
          Uint8List.fromList(utf8.encode(plaintext)),
        ),
        throwsArgumentError,
      );
      expect(await target.readAsBytes(), ciphertext);
    },
  );

  test(
    'failed encrypted snapshot replacement cleans its temporary file',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'profile-snapshot-failure-',
      );
      addTearDown(() => directory.delete(recursive: true));
      final target = Directory('${directory.path}/config.yaml');
      await target.create();
      final previous = File('${target.path}/previous');
      await previous.writeAsString('keep');
      final identity = await AgeCrypto.identityFromSeed(
        Uint8List(32)..fillRange(0, 32, 7),
      );
      final ciphertext = await AgeCrypto.encrypt(
        utf8.encode('rules: []'),
        identity.publicKeyBytes,
      );

      await expectLater(
        writeEncryptedProfileSnapshot(target.path, ciphertext),
        throwsA(isA<FileSystemException>()),
      );

      expect(await previous.readAsString(), 'keep');
      expect(await directory.list().map((entry) => entry.path).toList(), [
        target.path,
      ]);
    },
  );

  test(
    'failed managed updates report the error and preserve the snapshot',
    () async {
      final directory = Directory.systemTemp.createTempSync('profile-update-');
      addTearDown(() => directory.deleteSync(recursive: true));
      final originalPaths = PathProviderPlatform.instance;
      PathProviderPlatform.instance = _Paths(directory.path);
      addTearDown(() => PathProviderPlatform.instance = originalPaths);
      SharedPreferences.setMockInitialValues({});
      registerEnsureCloudReady(() async {});
      registerCanFetchManagedConfig(() => true);
      const failure = CloudApiException('Cloud sync request timed out');
      registerFetchManagedConfig((_, {validate}) async => throw failure);
      final timestamp = DateTime(2026, 8, 26);
      final profile = Profile(
        id: 123,
        url: 'oixcloud://managed',
        autoUpdateDuration: const Duration(hours: 1),
        lastUpdateDate: timestamp,
      );
      final snapshot = File(await appPath.getProfilePath('123'));
      await snapshot.parent.create(recursive: true);
      await snapshot.writeAsString('previous encrypted snapshot');

      expect(await profile.getExistingFilePath(validate: false), snapshot.path);
      await expectLater(profile.update(), throwsA(same(failure)));
      expect(await snapshot.readAsString(), 'previous encrypted snapshot');
      expect(profile.lastUpdateDate, timestamp);
    },
  );
}

class _Paths extends PathProviderPlatform {
  _Paths(this.path);
  final String path;
  @override
  Future<String?> getApplicationSupportPath() async => path;
  @override
  Future<String?> getApplicationCachePath() async => path;
  @override
  Future<String?> getTemporaryPath() async => path;
  @override
  Future<String?> getDownloadsPath() async => path;
}

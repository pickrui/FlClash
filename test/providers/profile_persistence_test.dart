import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:fl_clash/common/lock.dart';
import 'package:fl_clash/common/path.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/models/profile.dart';
import 'package:fl_clash/services/age_crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory directory;
  late PathProviderPlatform originalPaths;
  setUpAll(() async {
    directory = await Directory.systemTemp.createTemp('profile-persistence-');
    originalPaths = PathProviderPlatform.instance;
    PathProviderPlatform.instance = _Paths(directory.path);
    SharedPreferences.setMockInitialValues({});
    registerEnsureCloudReady(() async {});
    registerCanFetchManagedConfig(() => true);
  });
  tearDownAll(() async {
    PathProviderPlatform.instance = originalPaths;
    await directory.delete(recursive: true);
  });

  Future<File> snapshot(int id, String contents) async {
    final file = File(await appPath.getProfilePath('$id'));
    await file.parent.create(recursive: true);
    return file.writeAsString(contents);
  }

  test(
    'failed commit rolls back before another profile write enters',
    () async {
      const profile = Profile(id: 1, autoUpdateDuration: Duration(hours: 1));
      final file = await snapshot(profile.id, 'old');
      final entered = Completer<void>();
      final failCommit = Completer<void>();
      final operation = AppController().persistProfile(profile, () async {
        await file.writeAsString('uncommitted');
        entered.complete();
        await failCommit.future;
        throw StateError('metadata commit failed');
      });
      final rejected = expectLater(operation, throwsStateError);
      await entered.future;
      var saved = false;
      final other = storageLock.synchronized(() async {
        await file.writeAsString('new successful save');
        saved = true;
      });
      await pumpEventQueue();
      // Release the transaction even if this expectation fails on an old build.
      final overlapped = saved;
      failCommit.complete();
      await rejected;
      await other;
      expect(overlapped, isFalse);
      expect(await file.readAsString(), 'new successful save');
      expect(
        await file.parent
            .list()
            .where((entry) => entry.path.contains('write-backup'))
            .isEmpty,
        isTrue,
      );
    },
  );

  test('failed download leaves a concurrently saved snapshot intact', () async {
    const profile = Profile(
      id: 2,
      url: 'oixcloud://managed',
      autoUpdateDuration: Duration(hours: 1),
    );
    final file = await snapshot(profile.id, 'old');
    final entered = Completer<void>();
    final failed = Completer<void>();
    registerFetchManagedConfig((_, {validate}) async {
      entered.complete();
      await failed.future;
      throw const SocketException('fixture download failed');
    });
    final download = profile.prepareUpdate();
    final rejected = expectLater(download, throwsA(isA<SocketException>()));
    await entered.future;
    await storageLock.synchronized(
      () => file.writeAsString('new successful save'),
    );
    failed.complete();
    await rejected;
    expect(await file.readAsString(), 'new successful save');
  });

  test('prepared managed bytes are installed only by the commit', () async {
    const profile = Profile(
      id: 3,
      url: 'oixcloud://managed',
      autoUpdateDuration: Duration(hours: 1),
    );
    final file = await snapshot(profile.id, 'old');
    final identity = await AgeCrypto.identityFromSeed(
      Uint8List(32)..fillRange(0, 32, 7),
    );
    final bytes = await AgeCrypto.encrypt(
      Uint8List.fromList([1, 2, 3]),
      identity.publicKeyBytes,
    );
    registerFetchManagedConfig((_, {validate}) async {
      expect(validate, isNotNull);
      return (bytes, null);
    });
    final prepared = await profile.prepareUpdate();
    expect(await file.readAsString(), 'old');
    final saved = await storageLock.synchronized(prepared.save);
    expect(await file.readAsBytes(), bytes);
    expect(saved.lastUpdateDate, isNotNull);
    expect(profile.lastUpdateDate, isNull);
  });

  Future<Uint8List> encryptedBytes(int value) async {
    final identity = await AgeCrypto.identityFromSeed(
      Uint8List(32)..fillRange(0, 32, 7),
    );
    return AgeCrypto.encrypt(
      Uint8List.fromList([value]),
      identity.publicKeyBytes,
    );
  }

  test('an older download cannot overwrite a newer saved snapshot', () async {
    const profile = Profile(
      id: 4,
      url: 'oixcloud://managed',
      autoUpdateDuration: Duration(hours: 1),
    );
    final file = await snapshot(profile.id, 'original');
    final oldBytes = await encryptedBytes(1);
    final newBytes = await encryptedBytes(2);
    final entered = Completer<void>();
    final finish = Completer<void>();
    var requests = 0;
    registerFetchManagedConfig((_, {validate}) async {
      if (requests++ == 0) {
        entered.complete();
        await finish.future;
        return (oldBytes, null);
      }
      return (newBytes, null);
    });
    final oldDownload = profile.prepareUpdate();
    await entered.future;
    final latest = await profile.prepareUpdate();
    await latest.save();
    finish.complete();
    await expectLater((await oldDownload).save(), throwsStateError);
    expect(await file.readAsBytes(), newBytes);
  });

  test('restore invalidation keeps same-ID same-URL restored bytes', () async {
    const profile = Profile(
      id: 5,
      url: 'oixcloud://managed',
      autoUpdateDuration: Duration(hours: 1),
    );
    final file = await snapshot(profile.id, 'original');
    final downloaded = await encryptedBytes(3);
    final restored = await encryptedBytes(4);
    final entered = Completer<void>();
    final finish = Completer<void>();
    registerFetchManagedConfig((_, {validate}) async {
      entered.complete();
      await finish.future;
      return (downloaded, null);
    });
    final download = profile.prepareUpdate();
    await entered.future;
    await withProfileStorageMutation(
      () => writeEncryptedProfileSnapshot(file.path, restored),
    );
    finish.complete();
    await expectLater((await download).save(), throwsStateError);
    expect(await file.readAsBytes(), restored);
  });

  test(
    'deleted profile files cannot be recreated by an old download',
    () async {
      const profile = Profile(
        id: 6,
        url: 'oixcloud://managed',
        autoUpdateDuration: Duration(hours: 1),
      );
      final file = await snapshot(profile.id, 'original');
      final downloaded = await encryptedBytes(5);
      registerFetchManagedConfig((_, {validate}) async => (downloaded, null));
      final prepared = await profile.prepareUpdate();
      await AppController().clearEffect(profile.id);
      await expectLater(prepared.save(), throwsStateError);
      expect(await file.exists(), isFalse);
    },
  );

  for (final clear in [false, true]) {
    test(
      'requests started during ${clear ? 'clear' : 'restore'} are invalidated',
      () async {
        final profile = Profile(
          id: clear ? 8 : 7,
          url: 'oixcloud://managed',
          autoUpdateDuration: const Duration(hours: 1),
        );
        final file = await snapshot(profile.id, 'original');
        final downloaded = await encryptedBytes(6);
        final restored = await encryptedBytes(7);
        registerFetchManagedConfig((_, {validate}) async => (downloaded, null));
        final before = await profile.prepareUpdate();
        late PreparedProfileUpdate during;
        await withProfileStorageMutation(() async {
          during = await profile.prepareUpdate();
          if (clear) {
            await file.delete();
          } else {
            await writeEncryptedProfileSnapshot(file.path, restored);
          }
        });
        await expectLater(before.save(), throwsStateError);
        await expectLater(during.save(), throwsStateError);
        if (clear) {
          expect(await file.exists(), isFalse);
        } else {
          expect(await file.readAsBytes(), restored);
        }
      },
    );
  }

  test(
    'local edits invalidate only their own profile through commit',
    () async {
      const profile = Profile(
        id: 9,
        url: 'oixcloud://managed',
        autoUpdateDuration: Duration(hours: 1),
      );
      final other = profile.copyWith(id: 10);
      final file = await snapshot(profile.id, 'original');
      final downloaded = await encryptedBytes(8);
      final edited = await encryptedBytes(9);
      registerFetchManagedConfig((_, {validate}) async => (downloaded, null));
      final before = await profile.prepareUpdate();
      final unaffected = await other.prepareUpdate();
      late PreparedProfileUpdate during;
      await withProfileStorageMutation(() async {
        during = await profile.prepareUpdate();
        await writeEncryptedProfileSnapshot(file.path, edited);
      }, profileId: profile.id);
      await expectLater(before.save(), throwsStateError);
      await expectLater(during.save(), throwsStateError);
      expect(await file.readAsBytes(), edited);
      expect((await unaffected.save()).id, other.id);
    },
  );

  test(
    'saving a download preserves a newer request started during its write',
    () async {
      const profile = Profile(
        id: 11,
        url: 'oixcloud://managed',
        autoUpdateDuration: Duration(hours: 1),
      );
      final file = await snapshot(profile.id, 'original');
      final firstBytes = await encryptedBytes(10);
      final secondBytes = await encryptedBytes(11);
      var requests = 0;
      registerFetchManagedConfig(
        (_, {validate}) async =>
            (requests++ == 0 ? firstBytes : secondBytes, null),
      );
      final first = await profile.prepareUpdate();
      late PreparedProfileUpdate second;
      await storageLock.synchronized(() async {
        final saving = first.save();
        second = await profile.prepareUpdate();
        await saving;
      });
      expect(await file.readAsBytes(), firstBytes);
      await second.save();
      expect(await file.readAsBytes(), secondBytes);
    },
  );

  test('snapshot inspection waits for a concurrent replacement', () async {
    const profile = Profile(
      id: 12,
      url: 'oixcloud://managed',
      autoUpdateDuration: Duration(hours: 1),
    );
    final file = await snapshot(profile.id, 'old snapshot');
    final entered = Completer<void>();
    final release = Completer<void>();
    final write = storageLock.synchronized(() async {
      entered.complete();
      await release.future;
      await file.writeAsString('new snapshot');
    });
    await entered.future;
    var inspected = false;
    final inspection = profile.getExistingFilePath(validate: false).then((
      path,
    ) {
      inspected = true;
      return path;
    });
    await pumpEventQueue();
    final overlapped = inspected;
    release.complete();
    await write;
    expect(await inspection, file.path);
    expect(overlapped, isFalse);
    expect(await file.readAsString(), 'new snapshot');
  });
}

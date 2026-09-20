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
}

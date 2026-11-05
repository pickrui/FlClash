import 'dart:io';

import 'package:fl_clash/common/path.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
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

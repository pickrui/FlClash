import 'dart:io';

import 'package:fl_clash/common/path.dart';
import 'package:fl_clash/common/window.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() {
    PathProviderPlatform.instance = _UnwritableDataPathProvider();
  });

  test('an unavailable data directory fails its callers', () async {
    final paths = AppPath();

    await expectLater(
      paths.homeDirPath.timeout(const Duration(seconds: 5)),
      throwsA(isA<FileSystemException>()),
    );
    await expectLater(
      paths.downloadDirPath.timeout(const Duration(seconds: 5)),
      throwsA(isA<FileSystemException>()),
    );
    expect(await paths.tempPath, Directory.systemTemp.path);
  });

  test(
    'the single-instance check surfaces an unavailable data directory',
    () async {
      await expectLater(
        Window().ensureSingleInstance().timeout(const Duration(seconds: 5)),
        throwsA(isA<FileSystemException>()),
      );
    },
  );
}

class _UnwritableDataPathProvider extends PathProviderPlatform {
  @override
  Future<String?> getApplicationSupportPath() async {
    throw const FileSystemException('Creation failed', '/config/data');
  }

  @override
  Future<String?> getTemporaryPath() async => Directory.systemTemp.path;

  @override
  Future<String?> getDownloadsPath() async => null;
}

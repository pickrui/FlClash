import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'constant.dart';
import 'string.dart';
import 'system.dart';
import 'utils.dart';

class AppPath {
  static AppPath? _instance;
  Completer<Directory> dataDir = Completer();
  Completer<Directory> downloadDir = Completer();
  Completer<Directory> tempDir = Completer();
  Completer<Directory> cacheDir = Completer();
  RandomAccessFile? _legacyDataLock;
  late String appDirPath;

  AppPath._internal() {
    appDirPath = join(dirname(Platform.resolvedExecutable));
    getApplicationSupportDirectory().then((value) {
      dataDir.complete(value);
    });
    getTemporaryDirectory().then((value) {
      tempDir.complete(value);
    });
    getDownloadsDirectory().then((value) {
      downloadDir.complete(value);
    });
    getApplicationCacheDirectory().then((value) {
      cacheDir.complete(value);
    });
  }

  factory AppPath() {
    _instance ??= AppPath._internal();
    return _instance!;
  }

  String get executableExtension {
    return system.isWindows ? '.exe' : '';
  }

  String get executableDirPath {
    final currentExecutablePath = Platform.resolvedExecutable;
    return dirname(currentExecutablePath);
  }

  String get corePath {
    return join(executableDirPath, 'FlClashCore$executableExtension');
  }

  String get helperPath {
    return join(executableDirPath, '$appHelperService$executableExtension');
  }

  Future<String> get downloadDirPath async {
    final directory = await downloadDir.future;
    return directory.path;
  }

  Future<String> get homeDirPath async {
    final directory = await dataDir.future;
    return directory.path;
  }

  Future<String> get identityMigrationMarkerPath async {
    return join(await homeDirPath, identityMigrationMarkerName);
  }

  Future<bool> migrateLegacyApplicationSupportData() async {
    if (!system.isDesktop) return false;
    if (_legacyDataLock != null) return false;
    final currentPath = await homeDirPath;
    final legacyPath = legacyApplicationSupportPathFor(
      currentPath,
      isWindows: system.isWindows,
    );
    if (legacyPath == null) return false;
    final legacyDirectory = Directory(legacyPath);
    if (!await legacyDirectory.exists()) return false;
    final legacyLock = await _tryLockLegacyApplicationSupport(legacyDirectory);
    if (legacyLock == null) {
      throw FileSystemException(
        'Legacy application data is in use',
        legacyPath,
      );
    }
    try {
      final migrated = await migrateLegacyApplicationSupportDirectory(
        legacyPath: legacyPath,
        currentPath: currentPath,
        heldLegacyLock: legacyLock,
      );
      _legacyDataLock = legacyLock;
      return migrated;
    } catch (_) {
      await _releaseLegacyApplicationSupportLock(legacyLock);
      rethrow;
    }
  }

  Future<String> get databasePath async {
    final mHomeDirPath = await homeDirPath;
    return join(mHomeDirPath, 'database.sqlite');
  }

  Future<String> get durableConfigPath async {
    final mHomeDirPath = await homeDirPath;
    return join(mHomeDirPath, 'config.age');
  }

  Future<String> get backupFilePath async {
    final mHomeDirPath = await homeDirPath;
    return join(mHomeDirPath, 'backup.zip');
  }

  Future<String> get restoreDirPath async {
    final mHomeDirPath = await homeDirPath;
    return join(mHomeDirPath, 'restore');
  }

  Future<String> get tempFilePath async {
    final mTempDir = await tempDir.future;
    return join(mTempDir.path, 'temp${utils.id}');
  }

  Future<String> get lockFilePath async {
    final homeDirPath = await appPath.homeDirPath;
    return join(homeDirPath, 'FlClash.lock');
  }

  Future<String> get wakeupFilePath async {
    final homeDirPath = await appPath.homeDirPath;
    return join(homeDirPath, 'FlClash.wakeup');
  }

  Future<String> get configFilePath async {
    final mHomeDirPath = await homeDirPath;
    return join(mHomeDirPath, 'config.yaml');
  }

  Future<String> get sharedPreferencesPath async {
    final directory = await dataDir.future;
    return join(directory.path, 'shared_preferences.json');
  }

  Future<String> get profilesPath async {
    final directory = await dataDir.future;
    return join(directory.path, profilesDirectoryName);
  }

  Future<String> getProfilePath(String fileName) async {
    return join(await profilesPath, '$fileName.yaml');
  }

  Future<String> get scriptsDirPath async {
    final path = await homeDirPath;
    return join(path, 'scripts');
  }

  Future<String> getScriptPath(String fileName) async {
    final path = await scriptsDirPath;
    return join(path, '$fileName.js');
  }

  Future<String> getIconsCacheDir() async {
    final directory = await cacheDir.future;
    return join(directory.path, 'icons');
  }

  Future<String> getProvidersRootPath() async {
    final directory = await profilesPath;
    return join(directory, 'providers');
  }

  Future<String> getProvidersDirPath(String id) async {
    final directory = await profilesPath;
    return join(directory, 'providers', id);
  }

  Future<String> getProvidersFilePath(
    String id,
    String type,
    String url,
  ) async {
    final directory = await profilesPath;
    return join(directory, 'providers', id, type, url.toMd5());
  }

  Future<String> get tempPath async {
    final directory = await tempDir.future;
    return directory.path;
  }
}

String? legacyApplicationSupportPathFor(
  String currentPath, {
  required bool isWindows,
}) {
  if (!isWindows) {
    final pathContext = Context(style: Style.platform);
    final directoryName = pathContext.basename(currentPath);
    if (directoryName != packageName &&
        !directoryName.startsWith('$packageName.')) {
      return null;
    }
    return pathContext.join(
      pathContext.dirname(currentPath),
      directoryName.replaceFirst(packageName, legacyPackageName),
    );
  }
  final pathContext = Context(style: Style.windows);
  final packageSeparator = packageName.lastIndexOf('.');
  final legacySeparator = legacyPackageName.lastIndexOf('.');
  final company = packageName.substring(0, packageSeparator);
  final product = packageName.substring(packageSeparator + 1);
  if (pathContext.basename(currentPath).toLowerCase() !=
          product.toLowerCase() ||
      pathContext.basename(pathContext.dirname(currentPath)).toLowerCase() !=
          company.toLowerCase()) {
    return null;
  }
  return pathContext.join(
    pathContext.dirname(pathContext.dirname(currentPath)),
    legacyPackageName.substring(0, legacySeparator),
    legacyPackageName.substring(legacySeparator + 1),
  );
}

Future<bool> migrateLegacyApplicationSupportDirectory({
  required String legacyPath,
  required String currentPath,
  RandomAccessFile? heldLegacyLock,
}) async {
  final source = Directory(legacyPath);
  final destination = Directory(currentPath);
  if (legacyPath == currentPath || !await source.exists()) return false;
  if (await _directoryHasEntries(destination)) return false;

  final legacyLock =
      heldLegacyLock ?? await _tryLockLegacyApplicationSupport(source);
  if (legacyLock == null) {
    throw FileSystemException('Legacy application data is in use', legacyPath);
  }
  final temporary = Directory(
    '$currentPath.identity-migration-$pid-${DateTime.now().microsecondsSinceEpoch}',
  );
  try {
    if (await _directoryHasEntries(destination)) return false;
    await _copyApplicationSupportDirectory(source, temporary);
    await File(
      join(temporary.path, identityMigrationMarkerName),
    ).writeAsString(legacyPackageName, flush: true);
    if (await _directoryHasEntries(destination)) return false;
    if (await destination.exists()) {
      await destination.delete(recursive: true);
    }
    await temporary.rename(currentPath);
    return true;
  } finally {
    try {
      if (await temporary.exists()) {
        await temporary.delete(recursive: true);
      }
    } finally {
      if (heldLegacyLock == null) {
        await _releaseLegacyApplicationSupportLock(legacyLock);
      }
    }
  }
}

Future<void> _releaseLegacyApplicationSupportLock(
  RandomAccessFile legacyLock,
) async {
  try {
    await legacyLock.unlock();
  } finally {
    await legacyLock.close();
  }
}

Future<RandomAccessFile?> _tryLockLegacyApplicationSupport(
  Directory source,
) async {
  final lockFile = File(join(source.path, 'FlClash.lock'));
  await lockFile.create(recursive: true);
  final accessFile = await lockFile.open(mode: FileMode.write);
  try {
    await accessFile.lock(FileLock.exclusive);
    return accessFile;
  } catch (_) {
    await accessFile.close();
    return null;
  }
}

Future<bool> _directoryHasEntries(Directory directory) async {
  return await directory.exists() &&
      !await directory.list(followLinks: false).isEmpty;
}

Future<void> _copyApplicationSupportDirectory(
  Directory source,
  Directory destination,
) async {
  await destination.create(recursive: true);
  await for (final entity in source.list(followLinks: false)) {
    final name = basename(entity.path);
    if (name == 'FlClash.lock' || name == 'FlClash.wakeup') continue;
    final targetPath = join(destination.path, name);
    final type = await FileSystemEntity.type(entity.path, followLinks: false);
    if (type == FileSystemEntityType.directory) {
      await _copyApplicationSupportDirectory(
        Directory(entity.path),
        Directory(targetPath),
      );
    } else if (type == FileSystemEntityType.file) {
      await File(entity.path).copy(targetPath);
    }
  }
}

final appPath = AppPath();

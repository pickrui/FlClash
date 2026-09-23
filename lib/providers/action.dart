import 'dart:async';
import 'dart:convert';
import 'dart:ffi' hide Size;
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/geo_recovery.dart';
import 'package:fl_clash/common/core_launch_error.dart';
import 'package:fl_clash/common/delay_test.dart';
import 'package:fl_clash/common/network_failure_prompt.dart';
import 'package:fl_clash/common/update_download.dart';
import 'package:fl_clash/common/update_download_task.dart';
import 'package:fl_clash/providers/update_download.dart';
import 'package:fl_clash/core/core.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/plugins/app.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:fl_clash/services/config_key_store.dart';
import 'package:fl_clash/services/startup_recovery.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/utils/safe_storage.dart';
import 'package:fl_clash/views/cloud/cloud_login_page.dart';
import 'package:fl_clash/widgets/app_update.dart';
import 'package:fl_clash/widgets/geo_recovery_dialog.dart';
import 'package:fl_clash/widgets/linux_package_format_dialog.dart';
import 'package:fl_clash/widgets/port_conflict_dialog.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:url_launcher/url_launcher.dart';

import '../common/common.dart';
import '../common/proxy_auth.dart';
import '../database/database.dart';
import '../models/models.dart';
import 'database.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/action.g.dart';
part 'actions/update.dart';
part 'actions/app_state.dart';
part 'actions/profile.dart';
part 'actions/logs.dart';
part 'actions/proxies.dart';
part 'actions/setup.dart';
part 'actions/core.dart';
part 'actions/system.dart';
part 'actions/backup.dart';
part 'actions/back_block.dart';
part 'actions/store.dart';
part 'actions/common.dart';

/// All action domains share the existing lifecycle, persistence, and recovery
/// queues. A ProviderScope can override individual action notifiers in tests.
final actionControllerProvider = Provider<AppController>(
  (ref) => appController,
);

extension ActionContext on BuildContext {
  UpdateAction get updateAction => ProviderScope.containerOf(
    this,
    listen: false,
  ).read(updateActionProvider.notifier);
  AppStateAction get appStateAction => ProviderScope.containerOf(
    this,
    listen: false,
  ).read(appStateActionProvider.notifier);
  ProfileAction get profileAction => ProviderScope.containerOf(
    this,
    listen: false,
  ).read(profileActionProvider.notifier);
  LogsAction get logsAction => ProviderScope.containerOf(
    this,
    listen: false,
  ).read(logsActionProvider.notifier);
  ProxiesAction get proxiesAction => ProviderScope.containerOf(
    this,
    listen: false,
  ).read(proxiesActionProvider.notifier);
  SetupAction get setupAction => ProviderScope.containerOf(
    this,
    listen: false,
  ).read(setupActionProvider.notifier);
  CoreAction get coreAction => ProviderScope.containerOf(
    this,
    listen: false,
  ).read(coreActionProvider.notifier);
  SystemAction get systemAction => ProviderScope.containerOf(
    this,
    listen: false,
  ).read(systemActionProvider.notifier);
  BackupAction get backupAction => ProviderScope.containerOf(
    this,
    listen: false,
  ).read(backupActionProvider.notifier);
  BackBlockAction get backBlockAction => ProviderScope.containerOf(
    this,
    listen: false,
  ).read(backBlockActionProvider.notifier);
  StoreAction get storeAction => ProviderScope.containerOf(
    this,
    listen: false,
  ).read(storeActionProvider.notifier);
  CommonAction get commonAction => ProviderScope.containerOf(
    this,
    listen: false,
  ).read(commonActionProvider.notifier);
}

const _persistentLogFileName = 'app.log';
const _persistentLogMaxBytes = 1024 * 1024;
const _persistentLogKeepBytes = 768 * 1024;
const _coreDisconnectedMessage = 'Core is not connected';

@visibleForTesting
Uint8List retainCompleteLogLines(Uint8List bytes, int keepBytes) {
  if (bytes.length <= keepBytes) {
    return bytes;
  }
  final lineStart = bytes.indexOf(10, bytes.length - keepBytes);
  if (lineStart == -1 || lineStart + 1 >= bytes.length) {
    return Uint8List(0);
  }
  return Uint8List.sublistView(bytes, lineStart + 1);
}

@visibleForTesting
Uint8List limitLogLine(Uint8List bytes, int maxBytes) {
  if (bytes.length <= maxBytes) {
    return bytes;
  }
  const suffix = [46, 46, 46, 10];
  if (maxBytes <= suffix.length) {
    return Uint8List.fromList(suffix.sublist(0, maxBytes));
  }
  var end = maxBytes - suffix.length;
  while (end > 0 && bytes[end] & 0xc0 == 0x80) {
    end--;
  }
  return Uint8List.fromList([...bytes.sublist(0, end), ...suffix]);
}

class CandidateConfigValidationException extends ConfigValidationException {
  const CandidateConfigValidationException(super.message);
}

class _CoreStartCancelledException implements Exception {
  const _CoreStartCancelledException();
}

/// Keeps listener recovery inside the original action, so cancelling a start
/// does not turn an otherwise successful sign-in into an authentication error.
Future<bool> startCoreWithPortRecovery({
  required Future<void> Function() start,
  required Future<bool> Function() resolveConflict,
  required bool Function() shouldContinue,
}) async {
  while (shouldContinue()) {
    try {
      await start();
      return shouldContinue();
    } on PortConflictException {
      if (!shouldContinue() || !await resolveConflict()) {
        return false;
      }
    }
  }
  return false;
}

String formatConfigValidationMessage(
  String message,
  AppLocalizations localizations,
) {
  final normalized = message.trim().replaceFirst(
    RegExp(r'^Parse Error:\s*', caseSensitive: false),
    '',
  );
  final typeMismatchPattern = RegExp(
    r'line\s+(\d+):\s+cannot unmarshal\s+(!![a-z]+)(?:\s+.*)?\s+into\s+([^\r\n]+)',
    caseSensitive: false,
  );
  final matches = typeMismatchPattern.allMatches(normalized).toList();
  if (matches.isNotEmpty) {
    final issues = <String>[];
    for (final match in matches) {
      final actualType = _configValueTypeLabel(match.group(2)!, localizations);
      final expectedType = _configValueTypeLabel(
        match.group(3)!,
        localizations,
      );
      if (actualType == null || expectedType == null) {
        return normalized;
      }
      issues.add(
        '${localizations.configParseErrorAtLine(match.group(1)!)}\n'
        '${localizations.configTypeMismatch(expectedType, actualType)}',
      );
    }
    return '${issues.join('\n\n')}\n\n${localizations.configYamlFormatHint}';
  }

  final lineMatch = RegExp(
    r'(?:yaml:\s*)?line\s+(\d+):\s*(.+)',
    caseSensitive: false,
    multiLine: true,
  ).firstMatch(normalized);
  if (lineMatch == null) {
    return normalized;
  }
  return '${localizations.configParseErrorAtLine(lineMatch.group(1)!)}\n\n'
      '${lineMatch.group(2)!.trim()}\n\n'
      '${localizations.configYamlFormatHint}';
}

String? _configValueTypeLabel(String rawType, AppLocalizations localizations) {
  final type = rawType.trim().toLowerCase();
  if (type.startsWith('[]') || type == '!!seq') {
    return localizations.configValueTypeList;
  }
  if (type.startsWith('map[') || type == '!!map') {
    return localizations.configValueTypeObject;
  }
  if (type == 'string' || type == '!!str') {
    return localizations.configValueTypeText;
  }
  if (type == 'bool' || type == 'boolean' || type == '!!bool') {
    return localizations.configValueTypeBoolean;
  }
  if (type.startsWith('int') || type.startsWith('uint') || type == '!!int') {
    return localizations.configValueTypeInteger;
  }
  if (type.startsWith('float') || type == '!!float') {
    return localizations.configValueTypeNumber;
  }
  if (type == 'nil' || type == 'null' || type == '!!null') {
    return localizations.configValueTypeNull;
  }
  return null;
}

bool shouldStopCoreAfterApplyFailure({
  required bool isRunning,
  required bool candidateValidationFailed,
  bool coreSetupSucceeded = false,
}) {
  return isRunning && !candidateValidationFailed && !coreSetupSucceeded;
}

bool canPublishGroupsForProfile(int? profileId, SetupState? appliedState) {
  return profileId != null && appliedState?.profileId == profileId;
}

bool canChangeProxyForProfile({
  required int requestedProfileId,
  required int? currentProfileId,
  required SetupState? appliedState,
}) {
  return requestedProfileId == currentProfileId &&
      canPublishGroupsForProfile(requestedProfileId, appliedState);
}

@visibleForTesting
Future<bool> ensureInteractiveCoreReady({
  required Future<bool> Function() probe,
  required Future<bool> Function() recover,
}) async {
  try {
    if (await probe()) {
      return true;
    }
  } catch (_) {}
  return recover();
}

Profile mergeRefreshedProfile(Profile current, Profile refreshed) {
  return current.copyWith(
    label: current.label.isNotEmpty ? current.label : refreshed.label,
    lastUpdateDate: refreshed.lastUpdateDate,
    subscriptionInfo: refreshed.subscriptionInfo,
  );
}

/// Apply only the fields owned by the metadata editor to the latest profile.
/// Refresh results and personal routing may have changed while it was open.
@visibleForTesting
Profile mergeProfileMetadata(Profile current, Profile edited) {
  return current.copyWith(
    label: edited.label,
    url: edited.url,
    autoUpdate: edited.autoUpdate,
    autoUpdateDuration: edited.autoUpdateDuration,
  );
}

/// Preserve runtime and personal settings even when an explicit metadata edit
/// downloads or validates new profile content before it is saved.
@visibleForTesting
Profile mergePersistedProfile(
  Profile current,
  Profile updated, {
  required bool preserveCurrentState,
}) {
  final merged = mergeRefreshedProfile(current, updated);
  return preserveCurrentState ? merged : mergeProfileMetadata(merged, updated);
}

@visibleForTesting
Future<void> applyProfileAfterRefresh({
  required bool isCurrent,
  required bool force,
  required FutureOr<void> Function() applyImmediately,
  required void Function() applyDebounced,
}) async {
  if (!isCurrent) return;
  if (force) {
    await applyImmediately();
    return;
  }
  applyDebounced();
}

class ProfileApplyIntent {
  bool _requiresForce = false;
  FutureOr<void> Function()? _preloadInvoke;
  Future<void>? _preloadFuture;

  bool get requiresForce => _requiresForce || _preloadInvoke != null;

  FutureOr<void> Function()? get preloadInvoke {
    return _preloadInvoke == null ? null : _invokePreloadOnce;
  }

  Future<void> _invokePreloadOnce() {
    return _preloadFuture ??= Future.sync(_preloadInvoke!);
  }

  void merge({required bool force, FutureOr<void> Function()? preloadInvoke}) {
    _requiresForce = _requiresForce || force;
    if (preloadInvoke != null) {
      _preloadInvoke = preloadInvoke;
      _preloadFuture = null;
    }
  }

  void clear() {
    _requiresForce = false;
    _preloadInvoke = null;
    _preloadFuture = null;
  }
}

Map<String, dynamic> createBackupConfigMap(Config config, int version) {
  final configMap = Map<String, dynamic>.from(
    jsonDecode(jsonEncode(sanitizeConfigForPreferences(config))) as Map,
  );
  configMap['version'] = version;
  return configMap;
}

Future<void> validateRestoredProfileFiles(
  List<VM2<String, String>> migrations,
  String profilesPath,
  Future<String> Function(String path) validate,
) async {
  final normalizedProfilesPath = p.absolute(p.normalize(profilesPath));
  for (final migration in migrations) {
    final target = p.absolute(p.normalize(migration.b));
    if (p.dirname(target) != normalizedProfilesPath ||
        p.extension(target).toLowerCase() != '.yaml') {
      continue;
    }
    final source = File(migration.a);
    if (!await source.exists()) {
      throw const FormatException('restore profile source is missing');
    }
    final message = await validate(source.path);
    if (message.isNotEmpty) {
      throw FormatException('invalid restored profile: $message');
    }
  }
}

Future<String> validateProxyGroupFilters(
  ProxyGroup group,
  Future<String> Function(String data) validate,
) async {
  if ((group.filter?.isEmpty ?? true) &&
      (group.excludeFilter?.isEmpty ?? true)) {
    return '';
  }
  final validationGroup = <String, Object?>{
    'name': 'Filter validation',
    'type': 'select',
    'proxies': ['DIRECT'],
    if (group.filter?.isNotEmpty == true) 'filter': group.filter,
    if (group.excludeFilter?.isNotEmpty == true)
      'exclude-filter': group.excludeFilter,
  };
  final yaml = await encodeYamlTask({
    'proxy-groups': [validationGroup],
    'rules': ['MATCH,DIRECT'],
  });
  return validate(base64Encode(utf8.encode(yaml)));
}

Future<void> commitRestoredFiles(
  List<VM2<String, String>> migrations,
  Future<void> Function() commit, {
  List<String> deletePaths = const [],
  Future<void> Function(RestoreFilePlan plan)? prepare,
  Future<void> Function()? rollbackCompleted,
}) async {
  final targets = <String>{};
  for (final migration in migrations) {
    final target = p.absolute(p.normalize(migration.b));
    if (!targets.add(target)) {
      throw const FormatException('duplicate restore target');
    }
  }
  final normalizedDeletePaths = <String>{};
  for (final path in deletePaths) {
    final target = p.absolute(p.normalize(path));
    if (!normalizedDeletePaths.add(target) ||
        targets.any(
          (migrationTarget) =>
              migrationTarget == target ||
              p.isWithin(target, migrationTarget) ||
              p.isWithin(migrationTarget, target),
        )) {
      throw const FormatException('invalid restore deletion target');
    }
  }
  final backups = <String, String?>{};
  final deletedBackups = <String, ({String path, FileSystemEntityType type})>{};
  final cleanupBackups = <String>{};
  final temporaryFiles = <String>{};
  final replacementPlans = <String, RestoreReplacementPlan>{};
  for (final migration in migrations) {
    final source = File(migration.a);
    if (!await source.exists()) {
      throw FileSystemException(
        'Restore source file does not exist',
        source.path,
      );
    }
    final target = File(migration.b);
    final type = await FileSystemEntity.type(target.path, followLinks: false);
    if (type != FileSystemEntityType.notFound &&
        type != FileSystemEntityType.file) {
      throw const FormatException('unsupported restore replacement target');
    }
    replacementPlans[target.path] = RestoreReplacementPlan(
      target: target.path,
      backup: '${target.path}.restore-backup-${utils.id}',
      temporary: '${target.path}.restore-new-${utils.id}',
      existed: type == FileSystemEntityType.file,
    );
  }
  final deletionPlans = <String, RestoreDeletionPlan>{};
  for (final path in normalizedDeletePaths) {
    final type = await FileSystemEntity.type(path, followLinks: false);
    if (type == FileSystemEntityType.notFound) {
      continue;
    }
    if (type != FileSystemEntityType.file &&
        type != FileSystemEntityType.directory) {
      throw const FormatException('unsupported restore deletion target');
    }
    deletionPlans[path] = RestoreDeletionPlan(
      target: path,
      backup: '$path.restore-delete-backup-${utils.id}',
      isDirectory: type == FileSystemEntityType.directory,
    );
  }
  await prepare?.call(
    RestoreFilePlan(
      replacements: replacementPlans.values.toList(),
      deletions: deletionPlans.values.toList(),
    ),
  );
  try {
    for (final migration in migrations) {
      final source = File(migration.a);
      final target = File(migration.b);
      final plan = replacementPlans[target.path]!;
      await durableCreateDirectory(target.parent.path);
      final temporary = File(plan.temporary);
      temporaryFiles.add(temporary.path);
      await source.openRead().pipe(temporary.openWrite());
      final temporaryHandle = await temporary.open(mode: FileMode.append);
      try {
        await temporaryHandle.flush();
      } finally {
        await temporaryHandle.close();
      }
      String? backupPath;
      if (plan.existed) {
        backupPath = plan.backup;
        backups[target.path] = backupPath;
        await durableRename(target.path, backupPath);
      } else {
        backups[target.path] = null;
      }
      await durableRename(temporary.path, target.path);
      temporaryFiles.remove(temporary.path);
    }
    for (final plan in deletionPlans.values) {
      final type = plan.isDirectory
          ? FileSystemEntityType.directory
          : FileSystemEntityType.file;
      deletedBackups[plan.target] = (path: plan.backup, type: type);
      if (plan.isDirectory) {
        await durableRenameDirectory(plan.target, plan.backup);
      } else {
        await durableRename(plan.target, plan.backup);
      }
    }
    await commit();
    cleanupBackups.addAll(backups.values.whereType<String>());
    cleanupBackups.addAll(deletedBackups.values.map((backup) => backup.path));
  } catch (error, stackTrace) {
    Object? rollbackError;
    for (final entry in deletedBackups.entries.toList().reversed) {
      try {
        final backup = entry.value;
        final backupType = await FileSystemEntity.type(
          backup.path,
          followLinks: false,
        );
        if (backupType == FileSystemEntityType.notFound) {
          if (await FileSystemEntity.type(entry.key, followLinks: false) !=
              FileSystemEntityType.notFound) {
            continue;
          }
          throw const FileSystemException('Restore deletion backup is missing');
        }
        await durableDeleteEntity(entry.key);
        if (backup.type == FileSystemEntityType.file) {
          await durableRename(backup.path, entry.key);
        } else {
          await durableRenameDirectory(backup.path, entry.key);
        }
        cleanupBackups.add(backup.path);
      } catch (rollbackFailure) {
        rollbackError ??= rollbackFailure;
      }
    }
    for (final entry in backups.entries.toList().reversed) {
      try {
        final target = File(entry.key);
        final backupPath = entry.value;
        await durableDeleteFile(target.path);
        if (backupPath == null) {
          continue;
        } else {
          if (await File(backupPath).exists()) {
            await durableRename(backupPath, target.path);
          } else if (!await target.exists()) {
            throw const FileSystemException(
              'Restore replacement backup is missing',
            );
          }
          cleanupBackups.add(backupPath);
        }
      } catch (rollbackFailure) {
        rollbackError ??= rollbackFailure;
      }
    }
    if (rollbackError != null) {
      Error.throwWithStackTrace(
        StateError('$error; restore rollback failed: $rollbackError'),
        stackTrace,
      );
    }
    await rollbackCompleted?.call();
    Error.throwWithStackTrace(error, stackTrace);
  } finally {
    for (final temporaryPath in temporaryFiles) {
      try {
        await File(temporaryPath).safeDelete();
      } catch (_) {}
    }
    for (final backupPath in cleanupBackups) {
      try {
        final type = await FileSystemEntity.type(
          backupPath,
          followLinks: false,
        );
        if (type == FileSystemEntityType.directory) {
          await Directory(backupPath).safeDelete(recursive: true);
        } else if (type != FileSystemEntityType.notFound) {
          await File(backupPath).safeDelete();
        }
      } catch (_) {}
    }
  }
}

Future<void> runCleanupActions(
  Iterable<FutureOr<void> Function()> actions,
) async {
  Object? firstError;
  StackTrace? firstStackTrace;
  for (final action in actions) {
    try {
      await action();
    } catch (error, stackTrace) {
      firstError ??= error;
      firstStackTrace ??= stackTrace;
    }
  }
  if (firstError != null) {
    Error.throwWithStackTrace(
      firstError,
      firstStackTrace ?? StackTrace.current,
    );
  }
}

Dio createAppUpdateDownloadClient() =>
    Dio(
        BaseOptions(
          headers: {'User-Agent': browserUa},
          connectTimeout: const Duration(seconds: 10),
        ),
      )
      ..httpClientAdapter = createFlClashHttpClientAdapter(
        findProxy: FlClashHttpOverrides.handleResourceFindProxy,
      );

/// [linuxFormat] picks the Linux package; every other platform publishes one
/// installer per ABI, and arm64 Linux only ships a Debian package.
String? getAppUpdateDownloadUrl(
  Abi abi, {
  LinuxPackageFormat linuxFormat = LinuxPackageFormat.deb,
}) {
  if (linuxFormat.managed) return null;
  final name = switch (abi) {
    Abi.windowsX64 => 'windows-amd64-setup.exe',
    Abi.windowsArm64 => 'windows-arm64-setup.exe',
    Abi.macosX64 => 'macos-amd64.dmg',
    Abi.macosArm64 => 'macos-arm64.dmg',
    Abi.androidArm => 'android-armeabi-v7a.apk',
    Abi.androidArm64 => 'android-arm64-v8a.apk',
    Abi.androidX64 => 'android-x86_64.apk',
    Abi.linuxX64 => 'linux-amd64.${linuxFormat.extension}',
    Abi.linuxArm64 => 'linux-arm64.${LinuxPackageFormat.deb.extension}',
    _ => null,
  };
  return name == null ? null : 'https://dl.dler.io/flclash-$name';
}

/// An AppImage is not installed by a package manager: running the download
/// would only start a second copy, so the user replaces the image themselves.
bool isAppImageInstaller(File file) =>
    p.extension(file.path) == '.${LinuxPackageFormat.appImage.extension}';

/// The Linux package to act on before the user is asked. An install a package
/// manager owns outranks a stored answer; null leaves the question to the user.
LinuxPackageFormat? resolveLinuxUpdateFormat({
  required List<LinuxPackageFormat> published,
  required LinuxPackageFormat? detected,
  required LinuxPackageFormat? stored,
}) {
  if (detected != null && detected.managed) return detected;
  // An ABI with no Linux package at all falls through to the download page.
  if (published.isEmpty) return LinuxPackageFormat.deb;
  if (published.length == 1) return published.first;
  if (stored != null && published.contains(stored)) return stored;
  if (detected != null && published.contains(detected)) return detected;
  return null;
}

String getAppUpdateFallbackDownloadUrl(String downloadUrl) {
  final fileName = Uri.parse(downloadUrl).pathSegments.last;
  return Uri.https(
    'github.com',
    '/$releaseRepository/releases/latest/download/$fileName',
  ).toString();
}

enum AppUpdateOffer { prompt, notice, ignore }

AppUpdateOffer resolveAppUpdateOffer({
  required bool isUser,
  required int remoteBuildNumber,
  required int? declinedBuildNumber,
}) {
  if (isUser) return AppUpdateOffer.prompt;
  if (declinedBuildNumber != null && remoteBuildNumber <= declinedBuildNumber) {
    return AppUpdateOffer.ignore;
  }
  return AppUpdateOffer.notice;
}

/// The window has to be up before the release notes can be confirmed.
Future<T?> promptForAppUpdate<T>({
  required Future<void> Function()? showWindow,
  required Future<T?> Function() prompt,
}) async {
  await showWindow?.call();
  return prompt();
}

/// Called only after the user explicitly chooses to install a ready update.
Future<void> openAppUpdateDownload({
  required File file,
  required Future<bool> Function(File file) openFile,
  required Future<void> Function() openBrowser,
  required void Function(Object error) onError,
}) async {
  try {
    if (await openFile(file)) return;
    throw StateError('Unable to open downloaded update');
  } catch (error) {
    onError(error);
    await openBrowser();
  }
}

class AppController {
  late final BuildContext _context;
  late final WidgetRef _ref;
  Future<void> _logFileWrite = Future.value();
  Future<void> _preferencesWriteTail = Future.value();
  File? _persistentLogFile;
  int _persistentLogLength = 0;
  bool _persistentLogWritesSuspended = false;
  final _geoRecoveryLock = AsyncStorageLock();
  final _proxyAuthenticationLock = AsyncStorageLock();
  Future<void>? _updateDownloadsSweep;
  late final _appUpdateCheck = AppUpdateCheck(
    checkForUpdates: (isUser) => _checkUpdate(isUser: isUser),
  );
  Future<void>? _updateDetailsFuture;
  Future<void>? _startUpdateDownloadFuture;
  AppUpdateInfo? _appUpdateDownloadInfo;
  bool _openingUpdateInstaller = false;
  Future<bool>? _listenerStartFuture;
  int _startIntentGeneration = 0;
  final _coreLifecycleOperations = CoreLifecycleOperations();
  bool _preferencesWritesSuspended = false;
  bool _preferencesWriteRequestedWhileSuspended = false;
  int _autoIpv6CheckGeneration = 0;
  int _configUpdateGeneration = 0;
  final _providerUpdates = <(int?, int, String, String), Future<String>>{};
  final _providerUpdateCounts = <String, int>{};
  final _profileUpdateCounts = <String, int>{};
  int _groupsUpdateGeneration = 0;
  bool _groupsRefreshRequested = false;
  int? _activeDelayBatchGeneration;
  int _profileApplyGeneration = 0;
  int _pendingProfileApplies = 0;
  final ProfileApplyIntent _profileApplyIntent = ProfileApplyIntent();
  bool isAttach = false;
  bool _isCloudLoginDialogShowing = false;

  static AppController? _instance;

  AppController._internal();

  factory AppController() {
    _instance ??= AppController._internal();
    return _instance!;
  }

  Future<void> attach(BuildContext context, WidgetRef ref) async {
    _context = context;
    _ref = ref;
    try {
      await _init();
    } finally {
      isAttach = true;
    }
  }

  Future<bool> _saveConfigSerialized(Config value) {
    final operation = _preferencesWriteTail.then(
      (_) => preferences.saveConfig(value),
    );
    _preferencesWriteTail = operation.then<void>(
      (_) {},
      onError: (Object _, StackTrace _) {},
    );
    return operation;
  }

  Future<T> _serializeCoreLifecycle<T>(Future<T> Function() action) {
    return _coreLifecycleOperations.run(action);
  }

  void _synchronizeRestoredState({
    required List<Profile> profiles,
    required List<Script> scripts,
    required Config config,
    required bool restoreConfig,
  }) {
    _ref.read(profilesProvider.notifier).replaceFromDatabase(profiles);
    _ref.read(scriptsProvider.notifier).replaceFromDatabase(scripts);
    globalState.lastSetupState = null;
    _ref.invalidate(addedRuleStreamProvider);
    _ref.invalidate(setupStateProvider);
    _ref.read(currentProfileIdProvider.notifier).value =
        config.currentProfileId;
    if (!restoreConfig) {
      return;
    }
    _ref.read(patchClashConfigProvider.notifier).value =
        config.patchClashConfig;
    _ref.read(appSettingProvider.notifier).value = config.appSettingProps;
    _ref.read(davSettingProvider.notifier).value = config.davProps;
    _ref.read(themeSettingProvider.notifier).value = config.themeProps;
    _ref.read(windowSettingProvider.notifier).value = config.windowProps;
    _ref.read(vpnSettingProvider.notifier).value = config.vpnProps;
    _ref.read(proxiesStyleSettingProvider.notifier).value =
        config.proxiesStyleProps;
    _ref.read(overrideDnsProvider.notifier).value = config.overrideDns;
    _ref.read(networkSettingProvider.notifier).value = config.networkProps;
    _ref.read(hotKeyActionsProvider.notifier).value = config.hotKeyActions;
  }
}

({String scheme, String host, int? port, String path, String query})?
_normalizedDavEndpoint(String value) {
  final uri = Uri.tryParse(value.trim());
  if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
    return null;
  }
  var path = p.posix.normalize(uri.path);
  if (path == '.') {
    path = '/';
  }
  if (!path.startsWith('/')) {
    path = '/$path';
  }
  if (path.length > 1 && path.endsWith('/')) {
    path = path.substring(0, path.length - 1);
  }
  final scheme = uri.scheme.toLowerCase();
  final defaultPort = switch (scheme) {
    'http' => 80,
    'https' => 443,
    _ => null,
  };
  return (
    scheme: scheme,
    host: uri.host.toLowerCase(),
    port: uri.hasPort ? uri.port : defaultPort,
    path: path,
    query: uri.query,
  );
}

DAVProps? mergeRestoredDavProps(DAVProps? restored, DAVProps? previous) {
  if (restored == null) {
    return previous;
  }
  final restoredEndpoint = _normalizedDavEndpoint(restored.uri);
  final canReusePassword =
      previous != null &&
      restored.user == previous.user &&
      restoredEndpoint != null &&
      restoredEndpoint == _normalizedDavEndpoint(previous.uri);
  return restored.copyWith(password: canReusePassword ? previous.password : '');
}

Future<void> deleteApplicationSupportData(
  String homePath, {
  required Set<String> preservePaths,
}) async {
  final homeDirectory = Directory(homePath);
  if (!await homeDirectory.exists()) {
    return;
  }
  final normalizedPreservePaths = preservePaths
      .map((path) => p.absolute(p.normalize(path)))
      .toSet();
  await for (final entry in homeDirectory.list(followLinks: false)) {
    if (normalizedPreservePaths.contains(p.absolute(p.normalize(entry.path)))) {
      continue;
    }
    await durableDeleteEntity(entry.path);
  }
}

final appController = AppController();

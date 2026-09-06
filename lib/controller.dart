import 'dart:async';
import 'dart:convert';
import 'dart:ffi' hide Size;
import 'dart:io';
import 'dart:typed_data';

import 'package:fl_clash/core/core.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/plugins/app.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:fl_clash/services/config_key_store.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/utils/safe_storage.dart';
import 'package:fl_clash/views/cloud/cloud_login_page.dart';
import 'package:fl_clash/widgets/port_conflict_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:url_launcher/url_launcher.dart';

import 'common/common.dart';
import 'database/database.dart';
import 'models/models.dart';
import 'providers/database.dart';

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
}) {
  return isRunning && !candidateValidationFailed;
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

class AppController {
  late final BuildContext _context;
  late final WidgetRef _ref;
  Future<void> _logFileWrite = Future.value();
  Future<void> _preferencesWriteTail = Future.value();
  File? _persistentLogFile;
  int _persistentLogLength = 0;
  bool _persistentLogWritesSuspended = false;
  Future<bool>? _coreReadyFuture;
  Future<bool>? _listenerStartFuture;
  int _startIntentGeneration = 0;
  Future<void> _coreLifecycleTail = Future.value();
  final Object _coreLifecycleZoneKey = Object();
  Object? _activeCoreLifecycleToken;
  bool _preferencesWritesSuspended = false;
  bool _preferencesWriteRequestedWhileSuspended = false;
  int _autoIpv6CheckGeneration = 0;
  int _groupsUpdateGeneration = 0;
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
    await _init();
    isAttach = true;
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
    final inheritedToken = Zone.current[_coreLifecycleZoneKey];
    if (inheritedToken != null &&
        identical(inheritedToken, _activeCoreLifecycleToken)) {
      return action();
    }
    final token = Object();
    final operation = _coreLifecycleTail.then((_) async {
      _activeCoreLifecycleToken = token;
      try {
        return await runZoned(
          action,
          zoneValues: {_coreLifecycleZoneKey: token},
        );
      } finally {
        if (identical(_activeCoreLifecycleToken, token)) {
          _activeCoreLifecycleToken = null;
        }
      }
    });
    _coreLifecycleTail = operation.then<void>((_) {}, onError: (_, _) {});
    return operation;
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

extension InitControllerExt on AppController {
  Future<void> _init() async {
    FlutterError.onError = (details) {
      Future.microtask(() {
        commonPrint.log(
          'exception: ${details.exception} stack: ${details.stack}',
          logLevel: LogLevel.warning,
        );
      });
    };
    WidgetsBinding.instance.platformDispatcher.onError = (error, stack) {
      commonPrint.log(
        'platform exception: $error stack: $stack',
        logLevel: LogLevel.error,
      );
      return false;
    };
    updateTray();
    checkUpdate();
    await autoLaunch?.updateStatus(_ref.read(appSettingProvider).autoLaunch);
    final silentLaunch = shouldLaunchSilently(
      enabled: _ref.read(appSettingProvider).silentLaunch,
      arguments: globalState.launchArguments,
    );
    if (!silentLaunch) {
      await window?.show();
    } else {
      await window?.hide();
    }
    await _handleFailedPreference();
    await _connectCore();
    await _initCore();
    await _initStatus();
    autoUpdateProfiles();
    _ref.read(initProvider.notifier).value = true;
  }

  Future<void> _handleFailedPreference() async {
    if (await preferences.isInit) {
      return;
    }
    final res = await globalState.showMessage(
      title: appLocalizations.tip,
      message: TextSpan(text: appLocalizations.cacheCorrupt),
    );
    if (res == true) {
      final file = File(await appPath.sharedPreferencesPath);
      await file.safeDelete();
    }
    await handleExit();
  }

  Future<void> _initStatus() async {
    if (!globalState.needInitStatus) {
      commonPrint.log('init status cancel');
      return;
    }
    commonPrint.log('init status');
    if (system.isAndroid) {
      await globalState.updateStartTime();
    }
    final hasProfile = _ref.read(currentProfileIdProvider) != null;
    final status = globalState.isStart == true
        ? true
        : _ref.read(appSettingProvider).autoRun && hasProfile;
    if (status == true) {
      await updateStatus(true, isInit: true);
    } else {
      await applyProfile(force: true);
    }
  }

  Future<void> checkUpdate({bool isUser = false}) async {
    AppUpdateInfo? updateInfo;
    try {
      updateInfo = await request.checkForUpdate();
    } catch (error) {
      commonPrint.log(
        'check update failed: $error',
        logLevel: LogLevel.warning,
      );
      if (isUser) {
        globalState.showMessage(
          title: appLocalizations.checkUpdate,
          message: TextSpan(text: appLocalizations.checkUpdateFailed),
          cancelable: false,
        );
      }
      return;
    }
    if (updateInfo == null) {
      if (isUser) {
        globalState.showMessage(
          title: appLocalizations.checkUpdate,
          message: TextSpan(text: appLocalizations.checkUpdateError),
          cancelable: false,
        );
      }
      return;
    }
    window?.show();
    final res = await globalState.showMessage(
      title: appLocalizations.discovery,
      message: TextSpan(
        text: updateInfo.releaseNotes ?? appLocalizations.noInfo,
      ),
    );
    if (res != true) {
      return;
    }
    final downloadUrl = _getUpdateDownloadUrl() ?? 'https://dl.dler.io';
    await safeRun<void>(
      () => _openUpdateDownloadUrl(downloadUrl),
      title: appLocalizations.checkUpdate,
      silence: !isUser,
    );
  }

  Future<void> _openUpdateDownloadUrl(String downloadUrl) async {
    await launchUrl(Uri.parse(downloadUrl));
  }

  String? _getUpdateDownloadUrl() {
    if (system.isWindows) {
      return 'https://dl.dler.io/flclash-windows-amd64-setup.exe';
    }
    if (system.isMacOS) {
      final isArm = Abi.current() == Abi.macosArm64;
      final arch = isArm ? 'arm64' : 'amd64';
      return 'https://dl.dler.io/flclash-macos-$arch.dmg';
    }
    if (system.isAndroid) {
      final abi = Abi.current();
      String arch;
      if (abi == Abi.androidArm64) {
        arch = 'arm64-v8a';
      } else if (abi == Abi.androidArm) {
        arch = 'armeabi-v7a';
      } else if (abi == Abi.androidX64) {
        arch = 'x86_64';
      } else {
        arch = 'arm64-v8a';
      }
      return 'https://dl.dler.io/flclash-android-$arch.apk';
    }
    if (Platform.isLinux) {
      final isArm = Abi.current() == Abi.linuxArm64;
      final arch = isArm ? 'arm64' : 'amd64';
      return 'https://dl.dler.io/flclash-linux-$arch.deb';
    }
    return null;
  }
}

extension StateControllerExt on AppController {
  Config get config {
    return _ref.read(configProvider);
  }

  bool get isMobile {
    return _ref.read(isMobileViewProvider);
  }

  bool get isStart {
    return _ref.read(isStartProvider);
  }

  List<Group> get groups {
    return _ref.read(groupsProvider);
  }

  String get ua => _ref.read(patchClashConfigProvider).globalUa.takeFirstValid([
    globalState.packageInfo.ua,
  ]);

  Profile? get currentProfile {
    return _ref.read(currentProfileProvider);
  }

  String? getSelectedProxyName(String groupName) {
    return _ref.read(getSelectedProxyNameProvider(groupName));
  }

  String getRealTestUrl(String? url) {
    return _ref.read(realTestUrlProvider(url));
  }

  int getProxiesColumns() {
    return _ref.read(getProxiesColumnsProvider);
  }

  SharedState get sharedState {
    return _ref.read(sharedStateProvider);
  }

  SetupParams get setupParams {
    final selectedMap = _ref.read(selectedMapProvider);
    final testUrl = _ref.read(
      appSettingProvider.select((state) => state.testUrl),
    );
    return SetupParams(selectedMap: selectedMap, testUrl: testUrl);
  }

  List<Group> getCurrentGroups() {
    return _ref.read(currentGroupsStateProvider.select((state) => state.value));
  }

  String? getCurrentGroupName() {
    final currentGroupName = _ref.read(
      currentProfileProvider.select((state) => state?.currentGroupName),
    );
    return currentGroupName;
  }
}

extension ProfilesControllerExt on AppController {
  Future<void> deleteProfile(int id) async {
    await storageLock.synchronized(() async {
      await _ref.read(profilesProvider.notifier).del(id, reportOnWait: false);
      await clearEffect(id);
      final currentProfileId = _ref.read(currentProfileIdProvider);
      if (currentProfileId == id) {
        final profiles = _ref.read(profilesProvider);
        if (profiles.isNotEmpty) {
          final updateId = profiles.first.id;
          _ref.read(currentProfileIdProvider.notifier).value = updateId;
        } else {
          _ref.read(currentProfileIdProvider.notifier).value = null;
          updateStatus(false);
        }
      }
    });
  }

  Future<void> autoUpdateProfiles() async {
    for (final profile in _ref.read(profilesProvider)) {
      if (!profile.autoUpdate || profile.type == ProfileType.file) continue;

      bool shouldUpdate =
          profile.lastUpdateDate?.add(profile.autoUpdateDuration).isBeforeNow ??
          true;

      if (profile.isoixCloudProfile &&
          !await profile.hasLocalConfigSnapshot()) {
        shouldUpdate = true;
      }

      if (!shouldUpdate) continue;

      try {
        await updateProfile(profile);
      } catch (e) {
        commonPrint.log(e.toString(), logLevel: LogLevel.warning);
      }
    }
  }

  Future<void> putProfile(Profile profile, {bool reportOnWait = true}) async {
    await _ref
        .read(profilesProvider.notifier)
        .put(profile, reportOnWait: reportOnWait);
    if (_ref.read(currentProfileIdProvider) != null) return;
    _ref.read(currentProfileIdProvider.notifier).value = profile.id;
  }

  Future<Profile> persistProfile(
    Profile profile,
    Future<Profile> Function() update,
  ) {
    return storageLock.synchronized(() async {
      final previousProfileId = _ref.read(currentProfileIdProvider);
      Future<Profile> persist() async {
        try {
          final updatedProfile = await update();
          await putProfile(updatedProfile, reportOnWait: false);
          return updatedProfile;
        } catch (_) {
          _ref.read(currentProfileIdProvider.notifier).value =
              previousProfileId;
          rethrow;
        }
      }

      return withFileRollback(
        await appPath.getProfilePath(profile.id.toString()),
        persist,
      );
    });
  }

  Future<Profile> saveProfileFile(Profile profile, Uint8List bytes) {
    return persistProfile(profile, () => profile.saveFile(bytes));
  }

  Future<void> updateProfiles() async {
    await ensureCoreReadyOrThrow();
    final List<Profile> profiles = _ref.read(profilesProvider);
    final List<Future<void>> tasks = [];
    for (final profile in profiles) {
      if (profile.type == ProfileType.file) {
        continue;
      }
      tasks.add(() async {
        try {
          await updateProfile(profile);
        } catch (e, s) {
          final msg = profile.isoixCloudProfile
              ? 'Failed to update oixCloud profile: ${e.runtimeType}'
              : 'Failed to update profile ${profile.id}: $e\n$s';
          commonPrint.log(msg, logLevel: LogLevel.warning);
        }
      }());
    }
    await Future.wait(tasks);
  }

  Future<Profile> updateProfile(
    Profile profile, {
    bool showLoading = false,
    bool applyIfCurrent = true,
    bool forceApplyIfCurrent = false,
  }) async {
    try {
      await ensureCoreReadyOrThrow();
      if (showLoading) {
        _ref.read(isUpdatingProvider(profile.updatingKey).notifier).value =
            true;
      }
      final newProfile = await _updateProfileWithCertificateRetry(profile);
      await applyProfileAfterRefresh(
        isCurrent:
            applyIfCurrent && profile.id == _ref.read(currentProfileIdProvider),
        force: forceApplyIfCurrent,
        applyImmediately: () => applyProfile(silence: true, force: true),
        applyDebounced: () => applyProfileDebounce(silence: true),
      );
      return newProfile;
    } finally {
      _ref.read(isUpdatingProvider(profile.updatingKey).notifier).value = false;
    }
  }

  Future<Profile> _updateProfileWithCertificateRetry(Profile profile) {
    return _runWithCertificateRetry(() async {
      return persistProfile(profile, profile.update);
    }, handleCloudUnauthorized: profile.isoixCloudProfile);
  }

  Future<T> _runWithCertificateRetry<T>(
    Future<T> Function() action, {
    bool handleCloudUnauthorized = false,
  }) async {
    try {
      return await action();
    } catch (error, stackTrace) {
      await _throwHandledCloudUnauthorized(error, handleCloudUnauthorized);
      final cloudApiService = CloudApiService();
      final shouldRetry = await cloudApiService.confirmInsecureTlsRetry(error);
      if (!shouldRetry) {
        Error.throwWithStackTrace(error, stackTrace);
      }
      try {
        return await cloudApiService.runWithInsecureTls(action);
      } catch (retryError, retryStackTrace) {
        await _throwHandledCloudUnauthorized(
          retryError,
          handleCloudUnauthorized,
        );
        Error.throwWithStackTrace(retryError, retryStackTrace);
      }
    }
  }

  Future<void> _throwHandledCloudUnauthorized(
    Object error,
    bool handleCloudUnauthorized,
  ) async {
    if (!handleCloudUnauthorized || !CloudApiException.isUnauthorized(error)) {
      return;
    }
    await _ref.read(cloudAccountProvider.notifier).handleUnauthorized();
    throw const CloudApiUnauthorizedHandledException();
  }

  Future<void> requestStartCore() async {
    if (!this.isStart) {
      final res = await globalState.showMessage(
        title: appLocalizations.startCorePromptTitle,
        message: TextSpan(
          children: [
            TextSpan(text: appLocalizations.startCorePromptContent),
            const TextSpan(text: '\n\n', style: TextStyle(fontSize: 12)),
            TextSpan(
              text: appLocalizations.timeSyncTip,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      );
      if (res == true) {
        await updateStatus(true);
        if (_ref.read(isStartProvider)) {
          globalState.showNotifier(appLocalizations.startSuccess);
        }
      }
    }
  }

  Future<Profile?> addProfileFormURL(
    String url, {
    bool requestStartIfNeeded = true,
  }) async {
    if (globalState.navigatorKey.currentState?.canPop() ?? false) {
      globalState.navigatorKey.currentState?.popUntil((route) => route.isFirst);
    }
    toProfiles();
    final profile = await loadingRun(tag: LoadingTag.profiles, () async {
      return _runWithCertificateRetry(() {
        final profile = Profile.normal(url: url);
        return persistProfile(profile, profile.update);
      }, handleCloudUnauthorized: isoixCloudProfileUrl(url));
    }, title: appLocalizations.addProfile);
    if (profile != null) {
      globalState.showNotifier(appLocalizations.getProfileSuccess);
      if (requestStartIfNeeded) {
        await requestStartCore();
      }
    }
    return profile;
  }

  Future<void> addProfileFormFile() async {
    final platformFile = await safeRun(picker.pickerFile);
    if (platformFile == null) return;
    final bytes = await platformFile.readBytes();
    if (!_context.mounted) return;
    globalState.navigatorKey.currentState?.popUntil((route) => route.isFirst);
    toProfiles();
    final profile = await loadingRun(tag: LoadingTag.profiles, () async {
      return saveProfileFile(Profile.normal(label: platformFile.name), bytes);
    }, title: appLocalizations.addProfile);
    if (profile != null) {
      globalState.showNotifier(appLocalizations.getProfileSuccess);
      await requestStartCore();
    }
  }

  Future<void> addProfileFormQrCode() async {
    final url = await safeRun(picker.pickerConfigQRCode);
    if (url == null) return;
    addProfileFormURL(url);
  }

  void reorder(List<Profile> profiles) {
    _ref.read(profilesProvider.notifier).reorder(profiles);
  }

  Future<void> clearEffect(int profileId) async {
    final profilePath = await appPath.getProfilePath(profileId.toString());
    final hiddenProfilePath = await appPath.getProfilePath(
      '.${profileId.toString()}',
    );
    final providersDirPath = await appPath.getProvidersDirPath(
      profileId.toString(),
    );
    for (final path in [profilePath, hiddenProfilePath]) {
      final file = File(path);
      if (await file.exists()) {
        await file.safeDelete(recursive: true);
      }
    }
    final providersDir = Directory(providersDirPath);
    if (await providersDir.exists()) {
      await providersDir.safeDelete(recursive: true);
    }
  }
}

extension LogsControllerExt on AppController {
  void addLog(Log log, {bool persist = true}) {
    _ref.read(logsProvider).add(log);
    if (persist) {
      writePersistentLog(log);
    }
  }

  Future<bool> exportLogs() async {
    final logString = await encodeLogsTask(_ref.read(logsProvider).list);
    final tempFilePath = await appPath.tempFilePath;
    final file = File(tempFilePath);
    await file.safeWriteAsString(logString);
    bool res = false;
    res = await picker.saveFileWithPath(utils.logFile, tempFilePath) != null;
    return res;
  }

  void writePersistentLog(Log log) {
    if (_persistentLogWritesSuspended) {
      return;
    }
    _logFileWrite = _logFileWrite
        .then((_) => _appendPersistentLog(log))
        .catchError((error) {
          debugPrint('write persistent log failed: $error');
        });
  }

  Future<void> _appendPersistentLog(Log log) async {
    final file = await _preparePersistentLogFile();
    final line =
        '${log.dateTime} [${log.logLevel.name.toUpperCase()}] ${log.payload}\n';
    final encodedLine = limitLogLine(
      Uint8List.fromList(utf8.encode(line)),
      _persistentLogMaxBytes,
    );
    if (_persistentLogLength + encodedLine.length > _persistentLogMaxBytes) {
      final available = _persistentLogMaxBytes - encodedLine.length;
      await _rotatePersistentLog(
        file,
        available < _persistentLogKeepBytes
            ? available
            : _persistentLogKeepBytes,
      );
    }
    await file.writeAsBytes(encodedLine, mode: FileMode.append);
    _persistentLogLength += encodedLine.length;
  }

  Future<File> _preparePersistentLogFile() async {
    final cached = _persistentLogFile;
    if (cached != null) {
      return cached;
    }
    final homeDirPath = await appPath.homeDirPath;
    final logsDir = Directory(p.join(homeDirPath, 'logs'));
    await logsDir.create(recursive: true);
    final file = File(p.join(logsDir.path, _persistentLogFileName));
    _persistentLogLength = await file.exists() ? await file.length() : 0;
    _persistentLogFile = file;
    return file;
  }

  Future<void> _rotatePersistentLog(File file, int keepBytes) async {
    if (!await file.exists()) {
      _persistentLogLength = 0;
      return;
    }
    final bytes = await file.readAsBytes();
    final kept = retainCompleteLogLines(bytes, keepBytes);
    await file.writeAsBytes(kept);
    _persistentLogLength = kept.length;
  }
}

extension ProxiesControllerExt on AppController {
  void updateGroupsDebounce([Duration? duration]) {
    debouncer.call(FunctionTag.updateGroups, updateGroups, duration: duration);
  }

  bool _isCurrentGroupsUpdate(int? profileId, int generation) {
    return generation == _groupsUpdateGeneration &&
        profileId == _ref.read(currentProfileIdProvider) &&
        canPublishGroupsForProfile(profileId, globalState.lastSetupState);
  }

  Future<void> _syncCurrentProfileSelectedMap(
    List<Group> groups,
    int? profileId,
    int generation,
  ) async {
    final currentProfile = _ref.read(currentProfileProvider);
    if (currentProfile == null ||
        currentProfile.id != profileId ||
        !_isCurrentGroupsUpdate(profileId, generation)) {
      return;
    }
    final nextSelectedMap = <String, String>{};
    for (final entry in currentProfile.selectedMap.entries) {
      final group = groups.getGroup(entry.key);
      if (group == null) {
        continue;
      }
      final proxyName = group.getCurrentSelectedName(entry.value);
      if (proxyName.isNotEmpty) {
        nextSelectedMap[entry.key] = proxyName;
      }
    }
    if (!_isCurrentGroupsUpdate(profileId, generation)) {
      return;
    }
    if (stringAndStringMapEquality.equals(
      currentProfile.selectedMap,
      nextSelectedMap,
    )) {
      return;
    }
    await _ref
        .read(profilesProvider.notifier)
        .put(
          currentProfile.copyWith(selectedMap: nextSelectedMap),
          reportOnWait: false,
        );
  }

  void changeProxyDebounce(String groupName, String proxyName) {
    final profileId = _ref.read(currentProfileIdProvider);
    if (profileId == null) {
      return;
    }
    debouncer.call((FunctionTag.changeProxy, groupName), (
      int profileId,
      String groupName,
      String proxyName,
    ) async {
      bool isCurrentProfile() => canChangeProxyForProfile(
        requestedProfileId: profileId,
        currentProfileId: _ref.read(currentProfileIdProvider),
        appliedState: globalState.lastSetupState,
      );
      if (!isCurrentProfile()) {
        return;
      }
      final changed = await changeProxy(
        profileId: profileId,
        groupName: groupName,
        proxyName: proxyName,
      );
      if (!changed) {
        if (isCurrentProfile()) {
          await updateGroups();
        }
        return;
      }
      updateGroupsDebounce();
    }, args: [profileId, groupName, proxyName]);
  }

  Future<void> updateGroups() async {
    if (_pendingProfileApplies > 0) {
      return;
    }
    await _updateGroups(_ref.read(currentProfileIdProvider));
  }

  Future<bool> _updateGroups(int? profileId) async {
    final generation = ++_groupsUpdateGeneration;
    if (!_isCurrentGroupsUpdate(profileId, generation)) {
      return false;
    }
    try {
      commonPrint.log('updateGroups');
      if (!await ensureCoreReady()) {
        return false;
      }
      final groups = await retry(
        task: () async {
          final sortType = _ref.read(
            proxiesStyleSettingProvider.select((state) => state.sortType),
          );
          final delayMap = _ref.read(delayDataSourceProvider);
          final testUrl = _ref.read(
            appSettingProvider.select((state) => state.testUrl),
          );
          final selectedMap = _ref.read(
            currentProfileProvider.select((state) => state?.selectedMap ?? {}),
          );
          return coreController.getProxiesGroups(
            selectedMap: selectedMap,
            sortType: sortType,
            delayMap: delayMap,
            defaultTestUrl: testUrl,
          );
        },
        retryIf: (res) => res.isEmpty,
      );
      if (groups.isEmpty || !_isCurrentGroupsUpdate(profileId, generation)) {
        return false;
      }
      _ref.read(groupsProvider.notifier).value = groups;
      try {
        await _syncCurrentProfileSelectedMap(groups, profileId, generation);
      } catch (e) {
        commonPrint.log('sync selected map error: $e');
      }
      return true;
    } catch (e) {
      commonPrint.log('updateGroups error: $e');
      return false;
    }
  }

  void updateCurrentGroupName(String groupName) {
    final profile = _ref.read(currentProfileProvider);
    if (profile == null || profile.currentGroupName == groupName) {
      return;
    }
    _ref
        .read(profilesProvider.notifier)
        .put(profile.copyWith(currentGroupName: groupName));
  }

  void updateCurrentSelectedMap(String groupName, String proxyName) {
    final currentProfile = _ref.read(currentProfileProvider);
    if (currentProfile != null &&
        currentProfile.selectedMap[groupName] != proxyName) {
      final selectedMap = Map<String, String>.from(currentProfile.selectedMap)
        ..[groupName] = proxyName;
      _ref
          .read(profilesProvider.notifier)
          .put(currentProfile.copyWith(selectedMap: selectedMap));
    }
  }

  void updateCurrentUnfoldSet(Set<String> value) {
    final currentProfile = _ref.read(currentProfileProvider);
    if (currentProfile == null) {
      return;
    }
    _ref
        .read(profilesProvider.notifier)
        .put(currentProfile.copyWith(unfoldSet: value));
  }

  int beginDelayTest() {
    return _ref.read(delayDataSourceProvider.notifier).begin();
  }

  bool isCurrentDelayGeneration(int generation) {
    return _ref.read(delayDataSourceProvider.notifier).isCurrent(generation);
  }

  void setDelay(Delay delay, {int? generation}) {
    _ref
        .read(delayDataSourceProvider.notifier)
        .setDelay(delay, generation: generation);
  }

  void setDelays(Iterable<Delay> delays, {int? generation}) {
    _ref
        .read(delayDataSourceProvider.notifier)
        .setDelays(delays, generation: generation);
  }

  void clearDelay() {
    _ref.read(delayDataSourceProvider.notifier).clear();
  }

  Future<bool> changeProxy({
    required int profileId,
    required String groupName,
    required String proxyName,
  }) async {
    bool isCurrentProfile() => canChangeProxyForProfile(
      requestedProfileId: profileId,
      currentProfileId: _ref.read(currentProfileIdProvider),
      appliedState: globalState.lastSetupState,
    );
    if (!isCurrentProfile() || !await _ensureCoreReadyForInteractiveAction()) {
      return false;
    }
    if (!isCurrentProfile()) {
      return false;
    }
    final applyGeneration = _profileApplyGeneration;
    final profileApplyWasPending = _pendingProfileApplies > 0;
    try {
      await coreController.changeProxy(
        ChangeProxyParams(groupName: groupName, proxyName: proxyName),
      );
    } catch (error) {
      commonPrint.log('changeProxy error: $error', logLevel: LogLevel.warning);
      if (isCurrentProfile()) {
        globalState.showNotifier(error.toString());
      }
      return false;
    }
    if (!isCurrentProfile()) {
      return false;
    }
    updateCurrentSelectedMap(groupName, proxyName);
    if (profileApplyWasPending ||
        _pendingProfileApplies > 0 ||
        applyGeneration != _profileApplyGeneration) {
      _reconcileProxyChange(profileId, groupName, proxyName);
    }
    _handleProxyChangeApplied();
    return true;
  }

  void _handleProxyChangeApplied() {
    if (_ref.read(appSettingProvider).closeConnections) {
      coreController.closeConnections();
    } else {
      coreController.resetConnections();
    }
    addCheckIp();
  }

  void _reconcileProxyChange(
    int profileId,
    String groupName,
    String proxyName,
  ) {
    unawaited(
      _serializeCoreLifecycle(() async {
        try {
          bool isCurrentSelection() {
            final currentProfile = _ref.read(currentProfileProvider);
            return canChangeProxyForProfile(
                  requestedProfileId: profileId,
                  currentProfileId: _ref.read(currentProfileIdProvider),
                  appliedState: globalState.lastSetupState,
                ) &&
                currentProfile?.selectedMap[groupName] == proxyName;
          }

          if (!isCurrentSelection() ||
              !await _ensureCoreReadyForInteractiveAction()) {
            return;
          }
          if (!isCurrentSelection()) {
            return;
          }
          await coreController.changeProxy(
            ChangeProxyParams(groupName: groupName, proxyName: proxyName),
          );
          _handleProxyChangeApplied();
          updateGroupsDebounce();
        } catch (error) {
          commonPrint.log(
            'reconcile changeProxy error: $error',
            logLevel: LogLevel.warning,
          );
        }
      }),
    );
  }

  void setProvider(ExternalProvider? provider) {
    _ref.read(providersProvider.notifier).setProvider(provider);
  }

  Future<void> updateProviders() async {
    if (!await ensureCoreReady()) {
      _ref.read(providersProvider.notifier).value = [];
      return;
    }
    _ref.read(providersProvider.notifier).value = await coreController
        .getExternalProviders();
  }

  Future<String> updateProvider(
    ExternalProvider provider, {
    bool showLoading = false,
  }) async {
    try {
      if (!await ensureCoreReady()) {
        return _coreDisconnectedMessage;
      }
      if (showLoading) {
        _ref.read(isUpdatingProvider(provider.updatingKey).notifier).value =
            true;
      }
      final message = await coreController.updateExternalProvider(
        providerName: provider.name,
      );
      if (message.isNotEmpty) return message;
      setProvider(await coreController.getExternalProvider(provider.name));
      return '';
    } finally {
      _ref.read(isUpdatingProvider(provider.updatingKey).notifier).value =
          false;
    }
  }

  int addSortNum() {
    return _ref.read(sortNumProvider.notifier).add();
  }
}

extension SetupControllerExt on AppController {
  Future<bool> _startWithPortRecovery(int generation) {
    bool shouldContinue() => generation == _startIntentGeneration;
    if (!shouldContinue()) return Future.value(false);
    return _listenerStartFuture ??= startCoreWithPortRecovery(
      shouldContinue: shouldContinue,
      start: () => globalState.handleStart([updateRunTime, updateTraffic]),
      resolveConflict: () async {
        final patchConfig = _ref.read(patchClashConfigProvider);
        final port = await globalState.showCommonDialog<int>(
          child: PortConflictDialog(
            port: patchConfig.mixedPort,
            otherPorts: [
              patchConfig.port,
              patchConfig.socksPort,
              patchConfig.redirPort,
              patchConfig.tproxyPort,
            ],
          ),
        );
        if (port == null || !shouldContinue()) {
          return false;
        }
        _ref
            .read(patchClashConfigProvider.notifier)
            .update((state) => state.copyWith(mixedPort: port));
        // The normal provider listener is debounced. Apply the new port before
        // retrying, including when we are inside setupConfig's preload callback.
        final updateParams = _ref.read(updateParamsProvider);
        final message = await coreController.updateConfig(
          updateParams.copyWith.tun(enable: _ref.read(realTunEnableProvider)),
        );
        if (message.isNotEmpty) throw message;
        await savePreferences();
        return true;
      },
    ).whenComplete(() => _listenerStartFuture = null);
  }

  void fullSetup() {
    if (!_ref.read(initProvider)) {
      return;
    }
    clearDelay();
    applyProfile(force: true);
    _ref.read(logsProvider.notifier).value = FixedList(500);
    _ref.read(requestsProvider.notifier).value = FixedList(500);
  }

  Future<void> updateStatus(bool isStart, {bool isInit = false}) async {
    if (isStart) {
      final generation = _startIntentGeneration;
      if (isInit) {
        globalState.needInitStatus = false;
      } else if (!_ref.read(initProvider)) {
        return;
      }
      // Load the selected profile before opening listeners. A freshly initialized
      // Core also rejects startListener when no config has been applied yet.
      final started = await applyProfile(
        force: true,
        silence: !isInit,
        preloadInvoke: () async {
          if (!await _startWithPortRecovery(generation)) {
            throw const _CoreStartCancelledException();
          }
        },
      );
      if (!started && _ref.read(isStartProvider)) {
        await updateStatus(false);
      }
    } else {
      _startIntentGeneration++;
      await globalState.handleStop();
      if (coreController.isCompleted) {
        coreController.resetTraffic();
      }
      _ref.read(trafficsProvider.notifier).clear();
      _ref.read(totalTrafficProvider.notifier).value = const Traffic();
      _ref.read(runTimeProvider.notifier).value = null;
      addCheckIp();
    }
  }

  Future<Map<String, dynamic>> getRawProfileConfig(int profileId) async {
    var profile = _ref.read(profilesProvider).getProfile(profileId);
    var existingPath = await profile?.getExistingFilePath();

    if (profile != null && profile.isoixCloudProfile && existingPath == null) {
      profile = await _updateProfileWithCertificateRetry(profile);
      existingPath = await profile.getExistingFilePath();
    }

    if (profile?.isoixCloudProfile == true && existingPath == null) {
      throw Exception('oixCloud profile snapshot unavailable');
    }
    final path =
        existingPath ?? await appPath.getProfilePath(profileId.toString());
    return coreController.getConfig(path);
  }

  Future<String?> findRawProfileOutboundReference(
    int profileId,
    String name, {
    required bool includeTopLevelRules,
  }) async {
    final rawConfig = await getRawProfileConfig(profileId);
    return findRawOutboundReference(
      rawConfig,
      name,
      includeTopLevelRules: includeTopLevelRules,
    );
  }

  Future<bool> needSetup() async {
    final profileId = _ref.read(currentProfileIdProvider);
    if (profileId == null) {
      return false;
    }
    final setupState = await _ref.read(setupStateProvider(profileId).future);
    return setupState.needSetup(globalState.lastSetupState) == true;
  }

  Future<void> updateConfigDebounce() async {
    debouncer.call(FunctionTag.updateConfig, () async {
      await safeRun(() async {
        final updateParams = _ref.read(updateParamsProvider);
        final authorization = await _requestAdmin(updateParams.tun.enable);
        if (authorization == AuthorizeCode.success) {
          return;
        }
        if (!await ensureCoreReady()) {
          return;
        }
        final realTunEnable = _ref.read(realTunEnableProvider);
        final message = await coreController.updateConfig(
          updateParams.copyWith.tun(enable: realTunEnable),
        );
        if (message.isNotEmpty) throw message;
        addCheckIp();
      });
    });
  }

  Future<void> autoUpdateIpv6() async {
    final networkSetting = _ref.read(networkSettingProvider);
    if (!networkSetting.autoSetIpv6) {
      return;
    }
    final generation = ++_autoIpv6CheckGeneration;
    if (networkSetting.manualIpv6 == null) {
      final currentIpv6 = _ref.read(
        patchClashConfigProvider.select((state) => state.ipv6),
      );
      _ref
          .read(networkSettingProvider.notifier)
          .update((state) => state.copyWith(manualIpv6: currentIpv6));
    }
    final supported = await utils.hasGlobalIpv6();
    if (generation != _autoIpv6CheckGeneration) {
      return;
    }
    final stillAutoSetIpv6 = _ref.read(
      networkSettingProvider.select((state) => state.autoSetIpv6),
    );
    if (!stillAutoSetIpv6) {
      return;
    }
    final current = _ref.read(
      patchClashConfigProvider.select((state) => state.ipv6),
    );
    if (current == supported) {
      return;
    }
    _ref
        .read(patchClashConfigProvider.notifier)
        .update((state) => state.copyWith(ipv6: supported));
  }

  Future<void> setAutoIpv6(bool value) async {
    final currentIpv6 = _ref.read(
      patchClashConfigProvider.select((state) => state.ipv6),
    );
    final manualIpv6 = _ref.read(
      networkSettingProvider.select((state) => state.manualIpv6),
    );
    _ref
        .read(networkSettingProvider.notifier)
        .setAutoIpv6Enabled(value, currentIpv6: currentIpv6);
    if (value) {
      await autoUpdateIpv6();
      return;
    }
    if (manualIpv6 == null || manualIpv6 == currentIpv6) {
      return;
    }
    _ref
        .read(patchClashConfigProvider.notifier)
        .update((state) => state.copyWith(ipv6: manualIpv6));
  }

  void addCheckIp() {
    _ref.read(checkIpNumProvider.notifier).add();
  }

  void tryCheckIp() {
    final isTimeout = _ref.read(
      networkDetectionProvider.select(
        (state) => state.ipInfo == null && state.isLoading == false,
      ),
    );
    if (!isTimeout) {
      return;
    }
    _ref.read(checkIpNumProvider.notifier).add();
  }

  void applyProfileDebounce({bool silence = false, bool force = false}) {
    debouncer.call(FunctionTag.applyProfile, (silence, force) {
      applyProfile(silence: silence, force: force);
    }, args: [silence, force]);
  }

  void changeMode(Mode mode) {
    _ref
        .read(patchClashConfigProvider.notifier)
        .update((state) => state.copyWith(mode: mode));
    if (mode == Mode.global) {
      updateCurrentGroupName(GroupName.GLOBAL.name);
    }
    addCheckIp();
  }

  void autoApplyProfile() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      applyProfile();
    });
  }

  Future<bool> applyProfile({
    bool silence = false,
    bool force = false,
    FutureOr<void> Function()? preloadInvoke,
  }) {
    _profileApplyIntent.merge(force: force, preloadInvoke: preloadInvoke);
    final generation = ++_profileApplyGeneration;
    _groupsUpdateGeneration++;
    _pendingProfileApplies++;
    return _serializeCoreLifecycle(
      () => _applyProfileUnlocked(
        generation: generation,
        silence: silence,
        preloadInvoke: _profileApplyIntent.preloadInvoke,
      ),
    ).whenComplete(() => _pendingProfileApplies--);
  }

  Future<bool> _applyProfileUnlocked({
    required int generation,
    required bool silence,
    FutureOr<void> Function()? preloadInvoke,
  }) async {
    await autoUpdateIpv6();
    final profileId = _ref.read(currentProfileIdProvider);
    bool isCurrentApply() {
      return generation == _profileApplyGeneration &&
          profileId == _ref.read(currentProfileIdProvider);
    }

    if (!isCurrentApply()) {
      return true;
    }
    if (!_profileApplyIntent.requiresForce && !await needSetup()) {
      return true;
    }
    if (!isCurrentApply()) {
      return true;
    }
    var keepCurrentCore = false;
    final res = await loadingRun<bool>(
      () async {
        try {
          if (!await _setupConfig(profileId, generation, preloadInvoke)) {
            return !isCurrentApply();
          }
        } on CandidateConfigValidationException {
          keepCurrentCore = true;
          rethrow;
        }
        if (!isCurrentApply()) {
          return true;
        }
        if (!await _updateGroups(profileId)) {
          if (!isCurrentApply()) {
            return true;
          }
          _ref.read(groupsProvider.notifier).value = [];
          if (!_ref.read(initProvider)) return false;
          throw appLocalizations.noProxy;
        }
        if (!isCurrentApply()) {
          return true;
        }
        await updateProviders();

        final groups = _ref.read(groupsProvider);
        if (groups.isEmpty) {
          if (!_ref.read(initProvider)) return false;
          throw appLocalizations.noProxy;
        }

        final hasProxy = groups.any(
          (g) => g.all.any((p) {
            return ![
              'Selector',
              'URLTest',
              'Fallback',
              'LoadBalance',
              'Direct',
              'Reject',
              'Pass',
            ].contains(p.type);
          }),
        );

        if (!hasProxy) {
          if (!_ref.read(initProvider)) return false;
          throw appLocalizations.noProxy;
        }
        return true;
      },
      silence: true,
      tag: !silence ? LoadingTag.proxies : null,
    );
    if (!isCurrentApply()) {
      return true;
    }
    _profileApplyIntent.clear();
    if (res != true &&
        shouldStopCoreAfterApplyFailure(
          isRunning: _ref.read(isStartProvider),
          candidateValidationFailed: keepCurrentCore,
        )) {
      await updateStatus(false);
    }
    return res == true;
  }

  Future<Map<String, dynamic>> getProfile({
    required SetupState setupState,
    required ClashConfig patchConfig,
  }) async {
    final profileId = setupState.profileId;
    if (profileId == null) {
      return {};
    }
    final defaultUA = globalState.packageInfo.ua;
    final networkVM2 = _ref.read(
      networkSettingProvider.select(
        (state) => VM2(state.appendSystemDns, state.routeMode),
      ),
    );
    final overrideDns = _ref.read(overrideDnsProvider);
    final appendSystemDns = networkVM2.a;
    final routeMode = networkVM2.b;
    final configMap = await getRawProfileConfig(profileId);
    String? scriptContent;
    final List<Rule> addedRules = [];
    final List<ProxyGroup> customProxyGroups = [];
    final List<Rule> customRules = [];
    final proxyChains = List<ProxyChain>.from(setupState.proxyChains);
    if (setupState.overwriteType == OverwriteType.script) {
      scriptContent = await setupState.script?.content;
    } else if (setupState.overwriteType == OverwriteType.custom) {
      customProxyGroups.addAll(setupState.customProxyGroups);
      customRules.addAll(setupState.customRules);
    } else {
      addedRules.addAll(setupState.addedRules);
    }
    final realPatchConfig = patchConfig.copyWith(
      tun: patchConfig.tun.getRealTun(routeMode),
      allowLan: system.isDocker || patchConfig.allowLan,
    );
    Map<String, dynamic> rawConfig = configMap;
    if (scriptContent?.isNotEmpty == true) {
      rawConfig = await globalState.handleEvaluate(
        scriptContent!,
        rawConfig,
        onConsole: (level, output) {
          addLog(
            Log.app('[script] $output').copyWith(
              logLevel: level == 'error' ? LogLevel.error : LogLevel.info,
            ),
          );
        },
      );
    }
    final directory = await appPath.profilesPath;
    final res = makeRealProfileTask(
      MakeRealProfileState(
        profilesPath: directory,
        profileId: profileId,
        rawConfig: rawConfig,
        overwriteType: setupState.overwriteType,
        realPatchConfig: realPatchConfig,
        overrideDns: overrideDns,
        appendSystemDns: appendSystemDns,
        addedRules: addedRules,
        proxyChains: proxyChains,
        profileProxies: setupState.profileProxies,
        customProxyGroups: customProxyGroups,
        customRules: customRules,
        defaultUA: defaultUA,
        dockerMode: system.isDocker,
        blockQuic: setupState.blockQuic,
        blockWebRtc: setupState.blockWebRtc,
      ),
    );
    return res;
  }

  Future<Map<String, dynamic>> getProxyChainProfileConfig(int profileId) async {
    final setupState = await _ref.read(setupStateProvider(profileId).future);
    final patchClashConfig = _ref.read(patchClashConfigProvider);
    return getProfile(
      setupState: setupState.copyWith(proxyChains: const []),
      patchConfig: patchClashConfig,
    );
  }

  Future<Map> getProfileWithId(int profileId) async {
    var res = {};
    try {
      final setupState = await _ref.read(setupStateProvider(profileId).future);
      final patchClashConfig = _ref.read(patchClashConfigProvider);
      res = await getProfile(
        setupState: setupState,
        patchConfig: patchClashConfig,
      );
    } catch (e) {
      globalState.showNotifier(e.toString());
    }
    return res;
  }

  Future<bool> _setupConfig(
    int? profileId,
    int generation, [
    FutureOr<void> Function()? preloadInvoke,
  ]) async {
    bool isCurrentApply() {
      return generation == _profileApplyGeneration &&
          profileId == _ref.read(currentProfileIdProvider);
    }

    commonPrint.log('setup ===>');
    if (!await ensureCoreReady()) {
      return false;
    }
    var profile = _ref.read(profilesProvider).getProfile(profileId);
    await storageLock.synchronized(() async {
      profile = _ref.read(profilesProvider).getProfile(profileId);
      final nextProfile = await _checkAndUpdateProfileWithCertificateRetry(
        profile,
      );
      if (nextProfile == null || !isCurrentApply()) {
        return;
      }
      final currentProfile = _ref.read(profilesProvider).getProfile(profileId);
      if (currentProfile == null) {
        return;
      }
      profile = mergeRefreshedProfile(currentProfile, nextProfile);
      await _ref
          .read(profilesProvider.notifier)
          .put(profile!, reportOnWait: false);
    });
    if (!isCurrentApply()) {
      return false;
    }
    final patchConfig = _ref.read(patchClashConfigProvider);
    final authorization = await _requestAdmin(patchConfig.tun.enable);
    if (authorization == AuthorizeCode.success) {
      return false;
    }
    if (!await ensureCoreReady()) {
      return false;
    }
    final realTunEnable = _ref.read(realTunEnableProvider);
    final realPatchConfig = patchConfig.copyWith.tun(enable: realTunEnable);
    final setupState = await _ref.read(setupStateProvider(profile?.id).future);
    final config = await getProfile(
      setupState: setupState,
      patchConfig: realPatchConfig,
    );
    final configFilePath = await appPath.configFilePath;
    final yamlString = await encodeYamlTask(config);
    final validationMessage = await coreController.validateConfigWithBytes(
      base64Encode(utf8.encode(yamlString)),
    );
    if (validationMessage.isNotEmpty) {
      throw CandidateConfigValidationException(validationMessage);
    }
    if (!isCurrentApply()) {
      return false;
    }
    final isoixCloud = profile?.isoixCloudProfile ?? false;
    if (isoixCloud && system.isAndroid) {
      final encryptedBytes = await ensureEncryptedProfileBytes(
        Uint8List.fromList(utf8.encode(yamlString)),
      );
      await File(configFilePath).safeWriteAsBytes(encryptedBytes);
    } else if (!isoixCloud) {
      await File(configFilePath).safeWriteAsString(yamlString);
    }

    final latestProfile = _ref.read(profilesProvider).getProfile(profileId);
    final updatedSetupParams = SetupParams(
      selectedMap: latestProfile?.selectedMap ?? const {},
      testUrl: _ref.read(appSettingProvider).testUrl,
      rawConfig: isoixCloud ? yamlString : '',
    );

    if (!isCurrentApply()) {
      return false;
    }

    // WARNING: Do not print `updatedSetupParams.rawConfig` directly here.
    // It contains the full YAML plaintext and logging it would leak sensitive node information.
    commonPrint.log(
      '====== Sending rawConfig to Go: ${updatedSetupParams.rawConfig.length}',
    );

    final String message;
    try {
      message = await coreController.setupConfig(
        params: updatedSetupParams,
        preloadInvoke: preloadInvoke,
      );
    } on _CoreStartCancelledException {
      return false;
    }
    if (message.isNotEmpty) {
      throw message;
    }
    if (!isCurrentApply()) {
      return false;
    }
    globalState.lastSetupState = setupState;
    if (system.isAndroid) {
      globalState.lastVpnState = _ref.read(vpnStateProvider);
      preferences.saveShareState(this.sharedState);
    }
    addCheckIp();
    return true;
  }
}

extension CoreControllerExt on AppController {
  String get coreDisconnectedMessage => _coreDisconnectedMessage;

  Future<bool> _ensureCoreReadyForInteractiveAction() {
    return ensureInteractiveCoreReady(
      probe: _isCoreInitialized,
      recover: ensureCoreReady,
    );
  }

  Future<void> _initCore({bool refreshGroups = true}) async {
    final isInit = await coreController.isInit;
    final version = _ref.read(versionProvider);
    if (!await coreController.init(version)) {
      throw _coreDisconnectedMessage;
    }
    if (isInit && refreshGroups) {
      await updateGroups();
    }
  }

  Future<void> _connectCore() async {
    _ref.read(coreStatusProvider.notifier).value = CoreStatus.connecting;
    final result = await Future.wait([
      coreController.preload(),
      Future.delayed(const Duration(milliseconds: 300)),
    ]);
    final String message = result[0];
    if (message.isNotEmpty) {
      _ref.read(coreStatusProvider.notifier).value = CoreStatus.disconnected;
      if (_context.mounted) {
        _context.showNotifier(message);
      }
      return;
    }
    _ref.read(coreStatusProvider.notifier).value = CoreStatus.connected;
  }

  Future<bool> ensureCoreReady() {
    return _coreReadyFuture ??= _ensureCoreReady().whenComplete(() {
      _coreReadyFuture = null;
    });
  }

  Future<void> ensureCoreReadyOrThrow() async {
    if (!await ensureCoreReady()) {
      throw _coreDisconnectedMessage;
    }
  }

  Future<bool> _ensureCoreReady() async {
    return _serializeCoreLifecycle(() async {
      try {
        if (await _isCoreInitialized()) return true;
      } catch (error) {
        commonPrint.log(
          'Core initialization probe failed: $error',
          logLevel: LogLevel.warning,
        );
        await coreController.shutdown(false);
      }
      if (coreController.isCompleted) {
        await _initCore(refreshGroups: false);
        return _isCoreInitialized();
      }
      commonPrint.log('Core disconnected, reconnecting');
      _ref.read(coreStatusProvider.notifier).value = CoreStatus.disconnected;
      await coreController.shutdown(false);
      await _connectCore();
      if (!coreController.isCompleted) return false;
      await _initCore(refreshGroups: false);
      return _isCoreInitialized();
    });
  }

  Future<bool> _isCoreInitialized() async {
    if (!coreController.isCompleted) return false;
    return coreController.isInit;
  }

  Future<Profile?> _checkAndUpdateProfileWithCertificateRetry(
    Profile? profile,
  ) {
    if (profile == null) {
      return Future.value();
    }
    return _runWithCertificateRetry(
      profile.checkAndUpdateAndCopy,
      handleCloudUnauthorized: profile.isoixCloudProfile,
    );
  }

  Future<AuthorizeCode> _requestAdmin(bool enableTun) async {
    final realTunEnable = _ref.read(realTunEnableProvider);
    if (enableTun != realTunEnable && realTunEnable == false) {
      final code = await system.authorizeCore();
      switch (code) {
        case AuthorizeCode.success:
          _ref.read(realTunEnableProvider.notifier).value = enableTun;
          await restartCore();
          return code;
        case AuthorizeCode.none:
          break;
        case AuthorizeCode.error:
          _setPatchTunEnable(false);
          throw appLocalizations.tunAuthorizationFailed;
      }
    }
    _ref.read(realTunEnableProvider.notifier).value = enableTun;
    return AuthorizeCode.none;
  }

  void _setPatchTunEnable(bool enable) {
    final patchConfig = _ref.read(patchClashConfigProvider);
    if (patchConfig.tun.enable == enable) {
      return;
    }
    _ref
        .read(patchClashConfigProvider.notifier)
        .update((state) => state.copyWith.tun(enable: enable));
  }

  Future<void> restartCore([bool start = false]) async {
    await _serializeCoreLifecycle(() async {
      _ref.read(coreStatusProvider.notifier).value = CoreStatus.disconnected;
      await coreController.shutdown(true);
      clearDelay();
      await _connectCore();
      await _initCore();
    });
    if (start || _ref.read(isStartProvider)) {
      await updateStatus(true, isInit: true);
    } else {
      await applyProfile(force: true);
    }
  }

  Future<bool> tryStartCore([bool start = false]) async {
    if (coreController.isCompleted) {
      return false;
    }
    await restartCore(start);
    return true;
  }
}

extension SystemControllerExt on AppController {
  Future<List<Package>> getPackages() async {
    if (_ref.read(isMobileViewProvider)) {
      await Future.delayed(commonDuration);
    }
    if (_ref.read(packagesProvider).isEmpty) {
      _ref.read(packagesProvider.notifier).value =
          await app?.getPackages() ?? [];
    }
    return _ref.read(packagesProvider);
  }

  Future<void> handleExit([bool needSave = false]) async {
    Future.delayed(const Duration(seconds: 20), () {
      system.exit();
    });
    try {
      await runCleanupActions([
        waitForPendingDatabaseWrites,
        if (needSave) savePreferences,
        if (macOS != null) () => macOS!.updateDns(true),
        stopSystemProxyIfNeeded,
        if (tray != null) () => tray!.destroy(),
        coreController.destroy,
      ]);
      commonPrint.log('exit');
    } finally {
      system.exit();
    }
  }

  Future<void> handleBackOrExit({bool forceBack = false}) async {
    if (!system.isDesktop && _ref.read(backBlockProvider)) {
      return;
    }
    if (_ref.read(appSettingProvider).minimizeOnExit || forceBack) {
      if (system.isDesktop) {
        await savePreferences();
      }
      await system.back();
    } else {
      await handleExit();
    }
  }

  Future<void> updateVisible() async {
    final visible = await window?.isVisible;
    if (visible != null && !visible) {
      window?.show();
    } else {
      window?.hide();
    }
  }

  void updateBrightness() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ref.read(systemBrightnessProvider.notifier).value =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
    });
  }

  void updateViewSize(Size size) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ref.read(viewSizeProvider.notifier).value = size;
    });
  }

  void initLink() {
    linkManager.initAppLinksListen((url) async {
      final res = await globalState.showMessage(
        title: '${appLocalizations.add}${appLocalizations.profile}',
        message: TextSpan(
          children: [
            TextSpan(text: appLocalizations.doYouWantToPass),
            TextSpan(
              text: ' $url ',
              style: TextStyle(
                color: _context.colorScheme.primary,
                decoration: TextDecoration.underline,
                decorationColor: _context.colorScheme.primary,
              ),
            ),
            TextSpan(
              text: '${appLocalizations.create}${appLocalizations.profile}',
            ),
          ],
        ),
      );

      if (res != true) {
        return;
      }
      addProfileFormURL(url);
    });
  }

  void updateTun() {
    _ref
        .read(patchClashConfigProvider.notifier)
        .update((state) => state.copyWith.tun(enable: !state.tun.enable));
  }

  void updateSystemProxy() {
    _ref
        .read(networkSettingProvider.notifier)
        .update((state) => state.copyWith(systemProxy: !state.systemProxy));
  }

  void updateAutoLaunch() {
    _ref
        .read(appSettingProvider.notifier)
        .update((state) => state.copyWith(autoLaunch: !state.autoLaunch));
  }

  Future<void> updateTray() async {
    tray?.update(
      trayState: _ref.read(trayStateProvider),
      traffic: _ref.read(
        trafficsProvider.select(
          (state) => state.list.safeLast(const Traffic()),
        ),
      ),
    );
  }

  Future<void> updateLocalIp() async {
    _ref.read(localIpProvider.notifier).value = null;
    await Future.delayed(commonDuration);
    _ref.read(localIpProvider.notifier).value = await utils.getLocalIpAddress();
  }
}

extension BackupControllerExt on AppController {
  Future<void> shakingStore() async {
    final profileIds = _ref.read(
      profilesProvider.select((state) => state.map((item) => item.id)),
    );
    final scriptIds = await _ref.read(
      scriptsProvider.future.select(
        (state) async => (await state).map((item) => item.id),
      ),
    );
    final pathsToDelete = await shakingProfileTask(VM2(profileIds, scriptIds));
    if (pathsToDelete.isNotEmpty) {
      final deleteFutures = pathsToDelete.map((path) async {
        try {
          final res = await coreController.deleteFile(path);
          if (res.isNotEmpty) {
            throw res;
          }
        } catch (e) {
          rethrow;
        }
      });

      await Future.wait(deleteFutures);
    }
  }

  Future<String> backup() async {
    final backupData = await storageLock.synchronized(() async {
      final currentConfig = _ref.read(configProvider);
      final configMap = createBackupConfigMap(
        currentConfig,
        await preferences.getVersion(),
      );
      final storageSnapshotPath = await runExclusiveDatabaseOperation(() async {
        final snapshotPath = await appPath.tempFilePath;
        final snapshotDir = Directory(snapshotPath);
        try {
          await snapshotDir.create(recursive: true);
          final profiles = await database.profilesDao.all().get();
          final scripts = await database.scriptsDao.all().get();
          await database.createSnapshot(
            p.join(snapshotPath, backupDatabaseName),
          );
          for (final profile in profiles.where(
            (item) => item.includeInPortableBackup,
          )) {
            final source = File(
              await appPath.getProfilePath(profile.id.toString()),
            );
            final target = File(
              p.join(snapshotPath, profilesDirectoryName, profile.fileName),
            );
            await target.parent.create(recursive: true);
            await source.safeCopy(target.path);
          }
          for (final script in scripts) {
            final source = File(
              await appPath.getScriptPath(script.id.toString()),
            );
            final target = File(
              p.join(snapshotPath, 'scripts', script.fileName),
            );
            await target.parent.create(recursive: true);
            await source.safeCopy(target.path);
          }
          return snapshotPath;
        } catch (_) {
          await snapshotDir.safeDelete(recursive: true);
          rethrow;
        }
      });
      return VM2(configMap, storageSnapshotPath);
    });
    return backupTask(backupData.a, backupData.b);
  }

  Future<void> restore(RestoreOption option, {String? backupPath}) {
    return _serializeCoreLifecycle(
      () => _restoreUnlocked(option, backupPath: backupPath),
    );
  }

  Future<void> _restoreUnlocked(
    RestoreOption option, {
    String? backupPath,
  }) async {
    final restoreStrategy = _ref.read(
      appSettingProvider.select((state) => state.restoreStrategy),
    );
    final isOverride = restoreStrategy == RestoreStrategy.override;
    final wasRunning = _ref.read(isStartProvider);
    final wasCoreConnected = coreController.isCompleted;
    int? restoredProfileId;
    int? previousProfileId;
    var coreQuiesced = false;
    var restoreCommitted = false;
    var stateSynchronized = false;
    Config? committedConfig;
    var restoredAllSettings = false;
    Object? stateSynchronizationError;
    Object? restoreError;
    StackTrace? restoreStackTrace;
    RestoreJournal? restoreJournal;
    var recoveryRequired = false;
    try {
      await storageLock.synchronized(() async {
        final restoreDirPath = await appPath.tempFilePath;
        final restoreDir = Directory(restoreDirPath);
        try {
          _preferencesWritesSuspended = true;
          debouncer.cancel(FunctionTag.savePreferences);
          await _preferencesWriteTail;
          await suspendDatabaseWrites();
          final migrationData = await restoreTask(
            backupPath ?? await appPath.backupFilePath,
            restoreDirPath,
            await appPath.homeDirPath,
          );
          if (!await restoreDir.exists()) {
            throw appLocalizations.restoreException;
          }
          final configMap = migrationData.configMap;
          final restoredConfig =
              option == RestoreOption.all && configMap != null
              ? Config.fromJson(configMap)
              : null;
          await ensureCoreReadyOrThrow();
          await validateRestoredProfileFiles(
            migrationData.fileMigrations,
            await appPath.profilesPath,
            coreController.validateConfig,
          );
          final previousConfig = config;
          previousProfileId = previousConfig.currentProfileId;
          final previousProfiles = await database.profilesDao.all().get();
          final previousScripts = await database.scriptsDao.all().get();
          final previousRules = await database.select(database.rules).map((
            row,
          ) {
            return row.toRule();
          }).get();
          final previousLinks = await database
              .select(database.profileRuleLinks)
              .map((row) => row.toLink())
              .get();
          await preferences.saveDurableConfig(previousConfig);
          restoreJournal = await RestoreJournal.begin(
            homePath: await appPath.homeDirPath,
            durableConfigPath: await appPath.durableConfigPath,
            createDatabaseSnapshot: database.createSnapshot,
          );
          final deletePaths = <String>[];
          if (isOverride) {
            final restoredProfileFiles = migrationData.fileMigrations
                .map((migration) => p.absolute(p.normalize(migration.b)))
                .toSet();
            for (final profile in previousProfiles) {
              final profilePath = await appPath.getProfilePath(
                profile.id.toString(),
              );
              deletePaths.addAll([
                await appPath.getProfilePath('.${profile.id}'),
                await appPath.getProvidersDirPath(profile.id.toString()),
              ]);
              if (!restoredProfileFiles.contains(
                p.absolute(p.normalize(profilePath)),
              )) {
                deletePaths.add(profilePath);
              }
            }
            final restoredScriptIds = migrationData.scripts
                .map((script) => script.id)
                .toSet();
            for (final script in previousScripts) {
              if (!restoredScriptIds.contains(script.id)) {
                deletePaths.add(
                  await appPath.getScriptPath(script.id.toString()),
                );
              }
            }
          }
          coreQuiesced = true;
          if (wasRunning) {
            await updateStatus(false);
          }
          if (!await stopSystemProxyIfNeeded()) {
            throw StateError('failed to restore system proxy');
          }
          if (coreController.isCompleted) {
            if (!await coreController.shutdown(true)) {
              throw StateError('failed to stop core before restore');
            }
          }
          late Config configToApply;
          int? currentProfileId;
          var durableMutationStarted = false;
          var durableRollbackConfirmed = false;
          await runExclusiveDatabaseOperation(
            () => commitRestoredFiles(
              migrationData.fileMigrations,
              () async {
                durableMutationStarted = true;
                var databaseChanged = false;
                try {
                  await database.transaction(() async {
                    await database.restore(
                      migrationData.profiles,
                      migrationData.scripts,
                      migrationData.rules,
                      migrationData.links,
                      isOverride: isOverride,
                    );
                  });
                  databaseChanged = true;
                  final profileIds = (await database.profilesDao.all().get())
                      .map((profile) => profile.id)
                      .toSet();
                  if (wasRunning && profileIds.isEmpty) {
                    throw StateError(
                      'cannot restore an empty profile set while the core is running',
                    );
                  }
                  final requestedProfileId =
                      restoredConfig?.currentProfileId ??
                      previousConfig.currentProfileId;
                  currentProfileId = profileIds.contains(requestedProfileId)
                      ? requestedProfileId
                      : profileIds.firstOrNull;
                  if (restoredConfig == null) {
                    configToApply = previousConfig.copyWith(
                      currentProfileId: currentProfileId,
                    );
                  } else {
                    configToApply = restoredConfig.copyWith(
                      currentProfileId: currentProfileId,
                      patchClashConfig:
                          restoredConfig.patchClashConfig.secret.isEmpty
                          ? restoredConfig.patchClashConfig.copyWith(
                              secret: previousConfig.patchClashConfig.secret,
                            )
                          : restoredConfig.patchClashConfig,
                      davProps: mergeRestoredDavProps(
                        restoredConfig.davProps,
                        previousConfig.davProps,
                      ),
                    );
                  }
                  if (!await _saveConfigSerialized(configToApply)) {
                    throw appLocalizations.restoreException;
                  }
                  await restoreJournal!.markCommitted();
                } catch (error, stackTrace) {
                  Object? rollbackError;
                  if (databaseChanged) {
                    try {
                      await database.transaction(() async {
                        await database.restore(
                          previousProfiles,
                          previousScripts,
                          previousRules,
                          previousLinks,
                          isOverride: true,
                        );
                      });
                    } catch (failure) {
                      rollbackError = failure;
                    }
                  }
                  try {
                    if (!await _saveConfigSerialized(previousConfig)) {
                      rollbackError ??= StateError(
                        'failed to restore preferences',
                      );
                    }
                  } catch (failure) {
                    rollbackError ??= failure;
                  }
                  if (rollbackError != null) {
                    Error.throwWithStackTrace(
                      StateError(
                        '$error; restore rollback failed: $rollbackError',
                      ),
                      stackTrace,
                    );
                  }
                  durableRollbackConfirmed = true;
                  Error.throwWithStackTrace(error, stackTrace);
                }
              },
              deletePaths: deletePaths,
              prepare: (plan) => restoreJournal!.prepare(plan),
              rollbackCompleted: () async {
                if (!durableMutationStarted || durableRollbackConfirmed) {
                  await restoreJournal!.clearAfterRollback();
                  restoreJournal = null;
                }
              },
            ),
          );
          restoreCommitted = true;
          try {
            await restoreJournal!.clearAfterCommit();
            restoreJournal = null;
          } catch (error) {
            commonPrint.log(
              'restore journal cleanup failed: $error',
              logLevel: LogLevel.warning,
            );
          }
          restoredProfileId = currentProfileId;
          committedConfig = configToApply;
          restoredAllSettings = restoredConfig != null;
          final restoredProfiles = await database.profilesDao.all().get();
          final restoredScripts = await database.scriptsDao.all().get();
          try {
            _synchronizeRestoredState(
              profiles: restoredProfiles,
              scripts: restoredScripts,
              config: configToApply,
              restoreConfig: restoredAllSettings,
            );
            stateSynchronized = true;
          } catch (error) {
            stateSynchronizationError = error;
          }
        } finally {
          try {
            if (restoreCommitted &&
                !stateSynchronized &&
                committedConfig != null) {
              final profiles = await database.profilesDao.all().get();
              final scripts = await database.scriptsDao.all().get();
              try {
                _synchronizeRestoredState(
                  profiles: profiles,
                  scripts: scripts,
                  config: committedConfig!,
                  restoreConfig: restoredAllSettings,
                );
                stateSynchronized = true;
                stateSynchronizationError = null;
              } catch (error) {
                stateSynchronizationError = error;
              }
            } else if (!stateSynchronized) {
              _ref
                  .read(profilesProvider.notifier)
                  .replaceFromDatabase(await database.profilesDao.all().get());
              _ref
                  .read(scriptsProvider.notifier)
                  .replaceFromDatabase(await database.scriptsDao.all().get());
              _ref.invalidate(addedRuleStreamProvider);
              _ref.invalidate(setupStateProvider);
            }
            await restoreDir.safeDelete(recursive: true);
          } finally {
            recoveryRequired = restoreJournal?.hasPendingRollback == true;
            if (!recoveryRequired) {
              resumeDatabaseWrites();
              _preferencesWritesSuspended = false;
              if (_preferencesWriteRequestedWhileSuspended) {
                _preferencesWriteRequestedWhileSuspended = false;
                savePreferencesDebounce();
              }
            }
          }
        }
      });
    } catch (error, stackTrace) {
      restoreError = error;
      restoreStackTrace = stackTrace;
      try {
        await restoreJournal?.clearIfUnprepared();
      } catch (_) {}
      recoveryRequired = restoreJournal?.hasPendingRollback == true;
    }
    Object? coreRecoveryError;
    if (!recoveryRequired && coreQuiesced && (wasCoreConnected || wasRunning)) {
      try {
        if (!restoreCommitted) {
          _ref.read(currentProfileIdProvider.notifier).value =
              previousProfileId;
        }
        if (!coreController.isCompleted) {
          await _connectCore();
        }
        if (!coreController.isCompleted) {
          throw _coreDisconnectedMessage;
        }
        await _initCore();
        if (!restoreCommitted || stateSynchronized) {
          final profileId = restoreCommitted
              ? restoredProfileId
              : previousProfileId;
          if (profileId == null && wasRunning) {
            throw StateError('no profile is available after restore');
          }
          if (profileId != null) {
            bool activated;
            if (wasRunning) {
              await updateStatus(true, isInit: true);
              activated = _ref.read(isStartProvider);
            } else {
              activated = await applyProfile(force: true);
            }
            if (!activated) {
              throw appLocalizations.restoreException;
            }
          } else {
            _ref.read(groupsProvider.notifier).value = [];
            _ref.read(providersProvider.notifier).value = [];
            clearDelay();
          }
        }
      } catch (error) {
        coreRecoveryError = error;
      }
    } else if (recoveryRequired && coreController.isCompleted) {
      try {
        await coreController.shutdown(false);
      } catch (_) {}
    } else if (!wasCoreConnected && coreController.isCompleted) {
      try {
        if (!await coreController.shutdown(false)) {
          throw StateError('failed to restore disconnected core state');
        }
      } catch (error) {
        coreRecoveryError = error;
      }
    }
    if (stateSynchronizationError != null) {
      restoreError = StateError(
        'restore committed but state synchronization failed: '
        '$stateSynchronizationError',
      );
      restoreStackTrace ??= StackTrace.current;
    }
    if (recoveryRequired) {
      throw StateError(
        'restore recovery is required before the application can continue',
      );
    }
    if (restoreError != null) {
      final error = coreRecoveryError == null
          ? restoreError
          : StateError(
              '$restoreError; core recovery failed: $coreRecoveryError',
            );
      Error.throwWithStackTrace(error, restoreStackTrace ?? StackTrace.current);
    }
    if (coreRecoveryError != null) {
      throw StateError(
        'restore committed but core activation failed: $coreRecoveryError',
      );
    }
  }
}

extension BackBlockControllExt on AppController {
  void backBlock() {
    _ref.read(backBlockProvider.notifier).value = true;
  }

  void unBackBlock() {
    _ref.read(backBlockProvider.notifier).value = false;
  }
}

extension StoreControllerExt on AppController {
  void savePreferencesDebounce() {
    if (_preferencesWritesSuspended) {
      _preferencesWriteRequestedWhileSuspended = true;
      return;
    }
    debouncer.call(FunctionTag.savePreferences, () async {
      if (!_preferencesWritesSuspended) {
        await _saveConfigSerialized(config);
      }
    });
  }

  Future<void> savePreferences() async {
    if (_preferencesWritesSuspended) {
      _preferencesWriteRequestedWhileSuspended = true;
      return;
    }
    await _saveConfigSerialized(config);
  }

  Future handleClear() async {
    var irreversibleClearStarted = false;
    try {
      await _serializeCoreLifecycle(
        () => storageLock.synchronized(() async {
          _preferencesWritesSuspended = true;
          _persistentLogWritesSuspended = true;
          debouncer.cancel(FunctionTag.savePreferences);
          try {
            await _preferencesWriteTail;
            await suspendDatabaseWrites();
            await _logFileWrite;
            await globalState.handleStop();
            if (!await stopSystemProxyIfNeeded()) {
              throw StateError('failed to restore system proxy before clear');
            }
            if (coreController.isCompleted &&
                !await coreController.shutdown(true)) {
              throw StateError('failed to stop core before clear');
            }
            _ref.read(coreStatusProvider.notifier).value =
                CoreStatus.disconnected;

            irreversibleClearStarted = true;
            _persistentLogFile = null;
            _persistentLogLength = 0;
            await runCleanupActions([
              () => SafeStorage.delete('cloud_token'),
              ConfigKeyStore.clear,
              () => preferences.clearPreferences(
                preserveKeys: {
                  SafeStorage.deletionMarkerKey('cloud_token'),
                  SafeStorage.deletionMarkerKey('config_age_seed'),
                },
              ),
              database.close,
              () async => deleteApplicationSupportData(
                await appPath.homeDirPath,
                preservePaths: {
                  await appPath.lockFilePath,
                  await appPath.sharedPreferencesPath,
                },
              ),
            ]);
          } finally {
            if (!irreversibleClearStarted) {
              resumeDatabaseWrites();
              _preferencesWritesSuspended = false;
              _persistentLogWritesSuspended = false;
              if (_preferencesWriteRequestedWhileSuspended) {
                _preferencesWriteRequestedWhileSuspended = false;
                savePreferencesDebounce();
              }
            }
          }
        }),
      );
    } finally {
      if (irreversibleClearStarted) {
        await handleExit(false);
      }
    }
  }
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

extension CommonControllerExt on AppController {
  void toPage(PageLabel pageLabel) {
    _ref.read(currentPageLabelProvider.notifier).value = pageLabel;
  }

  void toProfiles() {
    toPage(PageLabel.profiles);
  }

  Future<void> openCloudLogin({bool navigateToCloud = true}) async {
    if (_isCloudLoginDialogShowing) {
      return;
    }
    _isCloudLoginDialogShowing = true;
    try {
      if (navigateToCloud) {
        toPage(PageLabel.oixCloud);
      }
      await Future<void>.delayed(Duration.zero);
      final context = globalState.navigatorKey.currentContext;
      if (context == null || !context.mounted) {
        return;
      }
      await showCloudLoginPage(context);
    } finally {
      _isCloudLoginDialogShowing = false;
    }
  }

  void updateStart() {
    updateStatus(!_ref.read(isStartProvider));
  }

  void updateSpeedStatistics() {
    _ref
        .read(appSettingProvider.notifier)
        .update((state) => state.copyWith(showTrayTitle: !state.showTrayTitle));
  }

  void updateMode() {
    _ref.read(patchClashConfigProvider.notifier).update((state) {
      final index = Mode.values.indexWhere((item) => item == state.mode);
      if (index == -1) {
        return null;
      }
      final nextIndex = index + 1 > Mode.values.length - 1 ? 0 : index + 1;
      return state.copyWith(mode: Mode.values[nextIndex]);
    });
  }

  void updateRunTime() {
    final startTime = globalState.startTime;
    if (startTime != null) {
      final startTimeStamp = startTime.millisecondsSinceEpoch;
      final nowTimeStamp = DateTime.now().millisecondsSinceEpoch;
      _ref.read(runTimeProvider.notifier).value = nowTimeStamp - startTimeStamp;
    } else {
      _ref.read(runTimeProvider.notifier).value = null;
    }
  }

  Future<void> updateTraffic() async {
    if (!coreController.isCompleted) {
      _ref.read(trafficsProvider.notifier).addTraffic(const Traffic());
      _ref.read(totalTrafficProvider.notifier).value = const Traffic();
      return;
    }
    final onlyStatisticsProxy = _ref.read(
      appSettingProvider.select((state) => state.onlyStatisticsProxy),
    );
    final traffic = await coreController.getTraffic(onlyStatisticsProxy);
    _ref.read(trafficsProvider.notifier).addTraffic(traffic);
    _ref.read(totalTrafficProvider.notifier).value = await coreController
        .getTotalTraffic(onlyStatisticsProxy);
  }

  Future<T?> loadingRun<T>(
    FutureOr<T> Function() futureFunction, {
    String? title,
    required LoadingTag? tag,
    bool silence = false,
  }) async {
    return safeRun(
      futureFunction,
      silence: silence,
      title: title,
      onStart: () {
        if (tag == null) {
          return;
        }
        _ref.read(loadingProvider(tag).notifier).start();
      },
      onEnd: () {
        if (tag == null) {
          return;
        }
        _ref.read(loadingProvider(tag).notifier).stop();
      },
    );
  }

  Future<T?> safeRun<T>(
    FutureOr<T> Function() futureFunction, {
    String? title,
    VoidCallback? onStart,
    VoidCallback? onEnd,
    bool silence = true,
  }) async {
    try {
      if (onStart != null) {
        onStart();
      }
      final res = await futureFunction();
      return res;
    } catch (e, s) {
      if (CloudApiException.isHandledUnauthorized(e)) {
        return null;
      }
      commonPrint.log('$title ===> $e, $s', logLevel: LogLevel.warning);
      final isConfigValidationError = e is ConfigValidationException;
      final message = isConfigValidationError
          ? formatConfigValidationMessage(e.message, appLocalizations)
          : Secrets.redactApiDomains(e.toString());
      if (silence) {
        globalState.showNotifier(message);
      } else {
        globalState.showMessage(
          title: isConfigValidationError
              ? appLocalizations.profileParseErrorDesc
              : title ?? appLocalizations.tip,
          message: TextSpan(text: message),
          cancelable: !isConfigValidationError,
        );
      }
      return null;
    } finally {
      if (onEnd != null) {
        onEnd();
      }
    }
  }
}

final appController = AppController();

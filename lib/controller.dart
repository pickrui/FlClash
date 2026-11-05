import 'dart:async';
import 'dart:convert';
import 'dart:ffi' hide Size;
import 'dart:io';
import 'dart:typed_data';

import 'package:fl_clash/core/core.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/plugins/app.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/cloud/cloud_login_page.dart';
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

class AppController {
  late final BuildContext _context;
  late final WidgetRef _ref;
  Future<void> _logFileWrite = Future.value();
  bool isAttach = false;
  bool _isUpdateDownloading = false;
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
}

extension InitControllerExt on AppController {
  Future<void> _init() async {
    FlutterError.onError = (details) {
      commonPrint.log(
        'exception: ${details.exception} stack: ${details.stack}',
        logLevel: LogLevel.warning,
      );
    };
    WidgetsBinding.instance.platformDispatcher.onError = (error, stack) {
      commonPrint.log(
        'platform exception: $error stack: $stack',
        logLevel: LogLevel.error,
      );
      return false;
    };
    updateTray();
    autoCheckUpdate();
    autoLaunch?.updateStatus(_ref.read(appSettingProvider).autoLaunch);
    if (!_ref.read(appSettingProvider).silentLaunch) {
      window?.show();
    } else {
      window?.hide();
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
    final status = globalState.isStart == true
        ? true
        : _ref.read(appSettingProvider).autoRun;
    if (status == true) {
      await updateStatus(true, isInit: true);
    } else {
      await applyProfile(force: true);
    }
  }

  Future<void> autoCheckUpdate() async {
    final res = await request.checkForUpdate();
    await checkUpdateResultHandle(data: res);
  }

  Future<void> checkUpdateResultHandle({
    Map<String, dynamic>? data,
    bool isUser = false,
  }) async {
    if (data != null) {
      final tagName = data['tag_name'] as String? ?? '';
      final body = data['body'] as String? ?? '';
      await safeRun<void>(
        () => _promptUpdateAndDownload(tagName: tagName, body: body),
        title: appLocalizations.checkUpdate,
        silence: !isUser,
      );
    } else if (isUser) {
      globalState.showMessage(
        title: appLocalizations.checkUpdate,
        message: TextSpan(text: appLocalizations.checkUpdateError),
      );
    }
  }

  Future<void> _promptUpdateAndDownload({
    required String tagName,
    required String body,
  }) async {
    if (_isUpdateDownloading) {
      globalState.showNotifier(appLocalizations.updateDownloading);
      return;
    }
    final textTheme = _context.textTheme;
    final submits = utils.parseReleaseBody(body);
    final shouldDownload = await globalState.showMessage(
      title: appLocalizations.discoverNewVersion,
      message: TextSpan(
        text: tagName.isEmpty ? '' : '$tagName \n',
        style: textTheme.headlineSmall,
        children: [
          if (submits.isNotEmpty)
            TextSpan(text: '\n', style: textTheme.bodyMedium),
          for (final submit in submits)
            TextSpan(text: '- $submit \n', style: textTheme.bodyMedium),
        ],
      ),
      confirmText: appLocalizations.download,
      cancelText: appLocalizations.remindLater,
    );
    if (shouldDownload != true) return;
    final downloadUrl = _getUpdateDownloadUrl();
    if (downloadUrl == null) {
      await _openUpdateDownloadUrl('https://dl.dler.io');
      return;
    }
    try {
      _isUpdateDownloading = true;
      globalState.showNotifier(appLocalizations.updateDownloading);
      final updateFile = await _downloadUpdatePackage(downloadUrl, tagName);
      final dialogResult = await globalState.showMessage(
        title: appLocalizations.discoverNewVersion,
        message: TextSpan(
          style: textTheme.bodyMedium,
          children: [
            TextSpan(
              text: '${appLocalizations.updateDownloadSuccess}\n',
              style: textTheme.bodyMedium,
            ),
            TextSpan(text: updateFile.path, style: textTheme.bodySmall),
          ],
        ),
        confirmText: appLocalizations.openInstaller,
        cancelText: appLocalizations.remindLater,
      );
      if (dialogResult == true) {
        await _openUpdatePackage(updateFile, downloadUrl);
      }
    } catch (error) {
      commonPrint.log(
        'download update package failed: $error',
        logLevel: LogLevel.warning,
      );
      globalState.showNotifier(appLocalizations.updateDownloadFallback);
      await _openUpdateDownloadUrl(downloadUrl);
    } finally {
      _isUpdateDownloading = false;
    }
  }

  Future<File> _downloadUpdatePackage(
    String downloadUrl,
    String tagName,
  ) async {
    final fileName = _getUpdatePackageFileName(downloadUrl, tagName);
    final downloadDirPath = await _getUpdateDownloadDirPath();
    final updateFile = File(p.join(downloadDirPath, fileName));
    if (await updateFile.exists() && await updateFile.length() > 0) {
      return updateFile;
    }
    final tempFile = File('${updateFile.path}.download');
    await tempFile.safeDelete();
    await request.downloadFile(downloadUrl, tempFile.path);
    await updateFile.safeDelete();
    return await tempFile.rename(updateFile.path);
  }

  String _getUpdatePackageFileName(String downloadUrl, String tagName) {
    final sourceFileName = p.basename(Uri.parse(downloadUrl).path);
    if (tagName.isEmpty) {
      return sourceFileName;
    }
    final extension = p.extension(sourceFileName);
    final name = p.basenameWithoutExtension(sourceFileName);
    final version = tagName
        .replaceAll(RegExp(r'[^0-9A-Za-z._-]+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
    return '$name-$version$extension';
  }

  Future<String> _getUpdateDownloadDirPath() async {
    try {
      final downloadDirPath = await appPath.downloadDirPath.timeout(
        const Duration(seconds: 3),
      );
      return p.join(downloadDirPath, 'FlClash');
    } catch (error) {
      commonPrint.log(
        'get update download dir failed: $error',
        logLevel: LogLevel.warning,
      );
      final homeDirPath = await appPath.homeDirPath;
      return p.join(homeDirPath, 'updates');
    }
  }

  Future<void> _openUpdatePackage(File updateFile, String fallbackUrl) async {
    bool opened = false;
    try {
      if (system.isAndroid) {
        opened = await app?.openFile(updateFile.path) ?? false;
      } else {
        opened = await launchUrl(
          Uri.file(updateFile.path),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (error) {
      commonPrint.log(
        'open update package failed: $error',
        logLevel: LogLevel.warning,
      );
    }
    if (opened) return;
    globalState.showNotifier(appLocalizations.openInstallerFailed);
    await _openUpdateDownloadUrl(fallbackUrl);
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

  Future<SetupState> getSetupState(int profileId) async {
    return await _ref.read(setupStateProvider(profileId).future);
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
    oixCloudConfigCache.remove(id);
    _ref.read(profilesProvider.notifier).del(id);
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

  void putProfile(Profile profile) {
    _ref.read(profilesProvider.notifier).put(profile);
    if (_ref.read(currentProfileIdProvider) != null) return;
    _ref.read(currentProfileIdProvider.notifier).value = profile.id;
  }

  Future<void> updateProfiles() async {
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
  }) async {
    try {
      if (showLoading) {
        _ref.read(isUpdatingProvider(profile.updatingKey).notifier).value =
            true;
      }
      final newProfile = await _updateProfileWithCertificateRetry(profile);
      if (applyIfCurrent && profile.id == _ref.read(currentProfileIdProvider)) {
        applyProfileDebounce(silence: true);
      }
      return newProfile;
    } finally {
      _ref.read(isUpdatingProvider(profile.updatingKey).notifier).value = false;
    }
  }

  Future<Profile> _updateProfileWithCertificateRetry(Profile profile) {
    return _runWithCertificateRetry(() async {
      final newProfile = await profile.update();
      _ref.read(profilesProvider.notifier).put(newProfile);
      return newProfile;
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
        updateStatus(true);
        globalState.showNotifier(appLocalizations.startSuccess);
      }
    }
  }

  Future<Profile?> addProfileFormURL(String url) async {
    if (globalState.navigatorKey.currentState?.canPop() ?? false) {
      globalState.navigatorKey.currentState?.popUntil((route) => route.isFirst);
    }
    toProfiles();
    final profile = await loadingRun(tag: LoadingTag.profiles, () async {
      return await _runWithCertificateRetry(
        () => Profile.normal(url: url).update(),
        handleCloudUnauthorized: isOixCloudProfileUrl(url),
      );
    }, title: appLocalizations.addProfile);
    if (profile != null) {
      putProfile(profile);
      globalState.showNotifier(appLocalizations.getProfileSuccess);
      await requestStartCore();
    }
    return profile;
  }

  void setProfileAndAutoApply(Profile profile) {
    _ref.read(profilesProvider.notifier).put(profile);
    if (profile.id == _ref.read(currentProfileIdProvider)) {
      applyProfileDebounce();
    }
  }

  Future<void> addProfileFormFile() async {
    final platformFile = await safeRun(picker.pickerFile);
    final bytes = platformFile?.bytes;
    if (bytes == null) {
      return;
    }
    if (!_context.mounted) return;
    globalState.navigatorKey.currentState?.popUntil((route) => route.isFirst);
    toProfiles();
    final profile = await loadingRun(tag: LoadingTag.profiles, () async {
      return await Profile.normal(label: platformFile?.name).saveFile(bytes);
    }, title: appLocalizations.addProfile);
    if (profile != null) {
      putProfile(profile);
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
    _logFileWrite = _logFileWrite
        .then((_) => _appendPersistentLog(log))
        .catchError((_) {});
  }

  Future<void> _appendPersistentLog(Log log) async {
    final homeDirPath = await appPath.homeDirPath;
    final logsDir = Directory(p.join(homeDirPath, 'logs'));
    await logsDir.create(recursive: true);
    final file = File(p.join(logsDir.path, _persistentLogFileName));
    await _rotatePersistentLog(file);
    await file.writeAsString(
      '${log.dateTime} [${log.logLevel.name.toUpperCase()}] ${log.payload}\n',
      mode: FileMode.append,
    );
  }

  Future<void> _rotatePersistentLog(File file) async {
    if (!await file.exists()) {
      return;
    }
    final length = await file.length();
    if (length <= _persistentLogMaxBytes) {
      return;
    }
    final bytes = await file.readAsBytes();
    final keepStart = bytes.length > _persistentLogKeepBytes
        ? bytes.length - _persistentLogKeepBytes
        : 0;
    final lineStart = bytes.indexOf(10, keepStart);
    await file.writeAsBytes(
      bytes.sublist(lineStart == -1 ? keepStart : lineStart + 1),
    );
  }
}

extension ProxiesControllerExt on AppController {
  void updateGroupsDebounce([Duration? duration]) {
    debouncer.call(FunctionTag.updateGroups, updateGroups, duration: duration);
  }

  void _syncCurrentProfileSelectedMap(List<Group> groups) {
    final currentProfile = _ref.read(currentProfileProvider);
    if (currentProfile == null) {
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
    if (stringAndStringMapEquality.equals(
      currentProfile.selectedMap,
      nextSelectedMap,
    )) {
      return;
    }
    _ref
        .read(profilesProvider.notifier)
        .put(currentProfile.copyWith(selectedMap: nextSelectedMap));
  }

  void changeProxyDebounce(String groupName, String proxyName) {
    debouncer.call(FunctionTag.changeProxy, (
      String groupName,
      String proxyName,
    ) async {
      await changeProxy(groupName: groupName, proxyName: proxyName);
      updateGroupsDebounce();
    }, args: [groupName, proxyName]);
  }

  Future<void> updateGroups() async {
    try {
      commonPrint.log('updateGroups');
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
          return await coreController.getProxiesGroups(
            selectedMap: selectedMap,
            sortType: sortType,
            delayMap: delayMap,
            defaultTestUrl: testUrl,
          );
        },
        retryIf: (res) => res.isEmpty,
      );
      _ref.read(groupsProvider.notifier).value = groups;
      _syncCurrentProfileSelectedMap(groups);
    } catch (e) {
      commonPrint.log('updateGroups error: $e');
      _ref.read(groupsProvider.notifier).value = [];
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

  void setDelay(Delay delay) {
    _ref.read(delayDataSourceProvider.notifier).setDelay(delay);
  }

  Future<void> changeProxy({
    required String groupName,
    required String proxyName,
  }) async {
    await coreController.changeProxy(
      ChangeProxyParams(groupName: groupName, proxyName: proxyName),
    );
    if (_ref.read(appSettingProvider).closeConnections) {
      coreController.closeConnections();
    } else {
      coreController.resetConnections();
    }
    addCheckIp();
  }

  void setProvider(ExternalProvider? provider) {
    _ref.read(providersProvider.notifier).setProvider(provider);
  }

  Future<void> updateProviders() async {
    _ref.read(providersProvider.notifier).value = await coreController
        .getExternalProviders();
  }

  Future<String> updateProvider(
    ExternalProvider provider, {
    bool showLoading = false,
  }) async {
    try {
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
  void fullSetup() {
    if (!_ref.read(initProvider)) {
      return;
    }
    _ref.read(delayDataSourceProvider.notifier).value = {};
    applyProfile(force: true);
    _ref.read(logsProvider.notifier).value = FixedList(500);
    _ref.read(requestsProvider.notifier).value = FixedList(500);
  }

  Future<void> updateStatus(bool isStart, {bool isInit = false}) async {
    if (isStart) {
      if (!isInit) {
        final res = await tryStartCore(true);
        if (res) {
          return;
        }
        if (!_ref.read(initProvider)) {
          return;
        }
        await globalState.handleStart([updateRunTime, updateTraffic]);
        applyProfileDebounce(force: true, silence: true);
      } else {
        globalState.needInitStatus = false;
        await applyProfile(
          force: true,
          preloadInvoke: () async {
            await globalState.handleStart([updateRunTime, updateTraffic]);
          },
        );
      }
    } else {
      await globalState.handleStop();
      coreController.resetTraffic();
      _ref.read(trafficsProvider.notifier).clear();
      _ref.read(totalTrafficProvider.notifier).value = Traffic();
      _ref.read(runTimeProvider.notifier).value = null;
      addCheckIp();
    }
  }

  Uint8List? _getCachedProfileBytes(Profile? profile) {
    if (profile == null || profile.useEncryptedDiskStore) {
      return null;
    }
    return oixCloudConfigCache[profile.id];
  }

  Future<Profile> _refreshOixCloudProfile(Profile profile) async {
    return _updateProfileWithCertificateRetry(profile);
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
        final res = await _requestAdmin(updateParams.tun.enable);
        if (res.isError) {
          return;
        }
        final realTunEnable = _ref.read(realTunEnableProvider);
        final message = await coreController.updateConfig(
          updateParams.copyWith.tun(enable: realTunEnable),
        );
        if (message.isNotEmpty) throw message;
      });
    });
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

  Future<void> applyProfile({
    bool silence = false,
    bool force = false,
    VoidCallback? preloadInvoke,
  }) async {
    if (!force && !await needSetup()) {
      return;
    }
    final res = await loadingRun<bool>(
      () async {
        await _setupConfig(preloadInvoke);
        await updateGroups();
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
    if (res != true && _ref.read(isStartProvider)) {
      updateStatus(false);
    }
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
    var profile = _ref.read(profilesProvider).getProfile(profileId);

    Map<String, dynamic> configMap;
    var cachedBytes = _getCachedProfileBytes(profile);
    String? existingPath;

    if (profile != null && profile.isoixCloudProfile) {
      if (profile.useEncryptedDiskStore) {
        existingPath = await profile.getExistingFilePath();
      }

      if (cachedBytes == null && existingPath == null) {
        profile = await _refreshOixCloudProfile(profile);
        cachedBytes = _getCachedProfileBytes(profile);
        if (profile.useEncryptedDiskStore) {
          existingPath = await profile.getExistingFilePath();
        }
      }
    }

    if (cachedBytes != null) {
      final raw = gzip.decode(cachedBytes);
      final base64String = base64Encode(raw);
      configMap = await coreController.getConfigFromBytes(base64String);
    } else {
      String path;
      if (profile != null) {
        existingPath ??=
            profile.isoixCloudProfile && !profile.useEncryptedDiskStore
            ? null
            : await profile.getExistingFilePath();
        if (existingPath != null) {
          path = existingPath;
        } else {
          if (profile.isoixCloudProfile) {
            throw Exception('oixCloud profile cache miss');
          }
          path = await appPath.getProfilePath(profileId.toString());
        }
      } else {
        path = await appPath.getProfilePath(profileId.toString());
      }
      configMap = await coreController.getConfig(path);
    }
    String? scriptContent;
    final List<Rule> addedRules = [];
    final proxyChains = List<ProxyChain>.from(setupState.proxyChains);
    if (setupState.overwriteType == OverwriteType.script) {
      scriptContent = await setupState.script?.content;
    } else {
      addedRules.addAll(setupState.addedRules);
    }
    final realPatchConfig = patchConfig.copyWith(
      tun: patchConfig.tun.getRealTun(routeMode),
    );
    Map<String, dynamic> rawConfig = configMap;
    if (scriptContent?.isNotEmpty == true) {
      rawConfig = await globalState.handleEvaluate(scriptContent!, rawConfig);
    }
    final directory = await appPath.profilesPath;
    final res = makeRealProfileTask(
      MakeRealProfileState(
        profilesPath: directory,
        profileId: profileId,
        rawConfig: rawConfig,
        realPatchConfig: realPatchConfig,
        overrideDns: overrideDns,
        appendSystemDns: appendSystemDns,
        addedRules: addedRules,
        proxyChains: proxyChains,
        profileProxies: setupState.profileProxies,
        defaultUA: defaultUA,
      ),
    );
    return res;
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

  Future<void> _setupConfig([VoidCallback? preloadInvoke]) async {
    commonPrint.log('setup ===>');
    var profile = _ref.read(currentProfileProvider);
    final nextProfile = await _checkAndUpdateProfileWithCertificateRetry(
      profile,
    );
    if (nextProfile != null) {
      profile = nextProfile;
      _ref.read(profilesProvider.notifier).put(nextProfile);
    }
    final patchConfig = _ref.read(patchClashConfigProvider);
    final res = await _requestAdmin(patchConfig.tun.enable);
    if (res.isError) {
      return;
    }
    final realTunEnable = _ref.read(realTunEnableProvider);
    final realPatchConfig = patchConfig.copyWith.tun(enable: realTunEnable);
    final setupState = await _ref.read(setupStateProvider(profile?.id).future);
    globalState.lastSetupState = setupState;
    if (system.isAndroid) {
      globalState.lastVpnState = _ref.read(vpnStateProvider);
      preferences.saveShareState(this.sharedState);
    }
    final config = await getProfile(
      setupState: setupState,
      patchConfig: realPatchConfig,
    );
    final configFilePath = await appPath.configFilePath;
    final yamlString = await encodeYamlTask(config);
    final isOixCloud = profile?.isoixCloudProfile ?? false;
    if (isOixCloud && system.isAndroid) {
      final encryptedBytes = await ensureEncryptedProfileBytes(
        Uint8List.fromList(utf8.encode(yamlString)),
      );
      await File(configFilePath).safeWriteAsBytes(encryptedBytes);
    } else if (!isOixCloud) {
      await File(configFilePath).safeWriteAsString(yamlString);
    }

    final updatedSetupParams = setupParams.copyWith(
      rawConfig: isOixCloud ? yamlString : '',
    );

    // WARNING: Do not print `updatedSetupParams.rawConfig` directly here.
    // It contains the full YAML plaintext and logging it would leak sensitive node information.
    commonPrint.log(
      '====== Sending rawConfig to Go: ${updatedSetupParams.rawConfig.length}',
    );

    final message = await coreController.setupConfig(
      setupState: setupState,
      params: updatedSetupParams,
      preloadInvoke: preloadInvoke,
    );
    if (message.isNotEmpty) {
      throw message;
    }
    addCheckIp();
  }
}

extension CoreControllerExt on AppController {
  Future<void> _initCore() async {
    final isInit = await coreController.isInit;
    final version = _ref.read(versionProvider);
    if (!isInit) {
      await coreController.init(version);
    } else {
      await updateGroups();
    }
  }

  Future<void> _connectCore() async {
    _ref.read(coreStatusProvider.notifier).value = CoreStatus.connecting;
    final result = await Future.wait([
      coreController.preload(),
      Future.delayed(Duration(milliseconds: 300)),
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

  Future<Result<bool>> _requestAdmin(bool enableTun) async {
    final realTunEnable = _ref.read(realTunEnableProvider);
    if (enableTun != realTunEnable && realTunEnable == false) {
      final code = await system.authorizeCore();
      switch (code) {
        case AuthorizeCode.success:
          _ref.read(realTunEnableProvider.notifier).value = enableTun;
          await restartCore();
          return Result.error('');
        case AuthorizeCode.none:
          break;
        case AuthorizeCode.error:
          enableTun = false;
          _setPatchTunEnable(false);
          break;
      }
    }
    _ref.read(realTunEnableProvider.notifier).value = enableTun;
    return Result.success(enableTun);
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
    _ref.read(coreStatusProvider.notifier).value = CoreStatus.disconnected;
    await coreController.shutdown(true);
    await _connectCore();
    await _initCore();
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

  void handleCoreDisconnected() {
    _ref.read(coreStatusProvider.notifier).value = CoreStatus.disconnected;
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
    Future.delayed(Duration(seconds: 3), () {
      system.exit();
    });
    try {
      await Future.wait([
        if (needSave) preferences.saveConfig(config),
        if (macOS != null) macOS!.updateDns(true),
        stopSystemProxyIfNeeded(),
        if (tray != null) tray!.destroy(),
      ]);
      await coreController.destroy();
      commonPrint.log('exit');
    } finally {
      system.exit();
    }
  }

  Future<void> handleBackOrExit() async {
    if (_ref.read(backBlockProvider)) {
      return;
    }
    if (_ref.read(appSettingProvider).minimizeOnExit) {
      if (system.isDesktop) {
        await preferences.saveConfig(config);
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
        trafficsProvider.select((state) => state.list.safeLast(Traffic())),
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
      profilesProvider.select(
        (state) => state
            .where(
              (item) => !item.isoixCloudProfile || item.useEncryptedDiskStore,
            )
            .map((item) => item.id),
      ),
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
    final profileFileNames = _ref.read(
      profilesProvider.select(
        (state) => state
            .where((item) => !item.isoixCloudProfile)
            .map((item) => item.fileName),
      ),
    );
    final scriptFileNames = await _ref.read(
      scriptsProvider.future.select(
        (state) async => (await state).map((item) => item.fileName),
      ),
    );
    final configMap = _ref.read(configProvider).toJson();
    configMap['version'] = await preferences.getVersion();
    return await backupTask(configMap, [
      ...profileFileNames,
      ...scriptFileNames,
    ]);
  }

  Future<void> restore(RestoreOption option) async {
    // Note: When restoring a backup, oixCloud profiles might be reloaded.
    // Since oixCloud cache is empty and tokens are not backed up (they reside in SharedPreferences),
    // restoring might prompt the user to login again when standard update fails.
    // This is an intended security design.
    final restoreDirPath = await appPath.restoreDirPath;
    final restoreDir = Directory(restoreDirPath);
    final restoreStrategy = _ref.read(
      appSettingProvider.select((state) => state.restoreStrategy),
    );
    final isOverride = restoreStrategy == RestoreStrategy.override;
    try {
      final migrationData = await restoreTask();
      if (!await restoreDir.exists()) {
        throw appLocalizations.restoreException;
      }
      await database.restore(
        migrationData.profiles,
        migrationData.scripts,
        migrationData.rules,
        migrationData.links,
        isOverride: isOverride,
      );
      final configMap = migrationData.configMap;
      if (option == RestoreOption.onlyProfiles || configMap == null) {
        return;
      }
      final config = Config.fromJson(configMap);
      _ref.read(patchClashConfigProvider.notifier).value =
          config.patchClashConfig;
      _ref.read(appSettingProvider.notifier).value = config.appSettingProps;
      _ref.read(currentProfileIdProvider.notifier).value =
          config.currentProfileId;
      _ref.read(davSettingProvider.notifier).value = config.davProps;
      _ref.read(themeSettingProvider.notifier).value = config.themeProps;
      _ref.read(windowSettingProvider.notifier).value = config.windowProps;
      _ref.read(vpnSettingProvider.notifier).value = config.vpnProps;
      _ref.read(proxiesStyleSettingProvider.notifier).value =
          config.proxiesStyleProps;
      _ref.read(overrideDnsProvider.notifier).value = config.overrideDns;
      _ref.read(networkSettingProvider.notifier).value = config.networkProps;
      _ref.read(hotKeyActionsProvider.notifier).value = config.hotKeyActions;
      return;
    } finally {
      await restoreDir.safeDelete(recursive: true);
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
    debouncer.call(FunctionTag.savePreferences, () async {
      await preferences.saveConfig(config);
    });
  }

  Future<void> savePreferences() async {
    await preferences.saveConfig(config);
  }

  Future handleClear() async {
    oixCloudConfigCache.clear();
    await preferences.clearPreferences();
    commonPrint.log('clear preferences');
    await database.close();
    await File(await appPath.databasePath).safeDelete(recursive: true);
    final homeDir = Directory(await appPath.profilesPath);
    await for (final file in homeDir.list(recursive: true)) {
      await coreController.deleteFile(file.path);
    }
    await preferences.clearPreferences();
    handleExit(false);
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
      if (silence) {
        globalState.showNotifier(e.toString());
      } else {
        globalState.showMessage(
          title: title ?? appLocalizations.tip,
          message: TextSpan(text: e.toString()),
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

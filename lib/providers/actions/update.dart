part of '../action.dart';

@Riverpod(keepAlive: true)
class UpdateAction extends _$UpdateAction {
  @override
  void build() {
    _controller = ref.watch(actionControllerProvider);
  }

  late AppController _controller;

  Future<void> checkUpdate({bool isUser = false}) =>
      _controller.checkUpdate(isUser: isUser);
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
    await autoLaunch?.updateStatus(_ref.read(appSettingProvider).autoLaunch);
    final silentLaunch = shouldLaunchSilently(
      enabled: _ref.read(appSettingProvider).silentLaunch,
      arguments: globalState.launchArguments,
    );
    commonPrint.log(
      'startup window: automatic=${globalState.launchArguments.contains(silentLaunchArgument)}, '
      'silentSetting=${_ref.read(appSettingProvider).silentLaunch}, '
      'silent=$silentLaunch',
    );
    if (!silentLaunch) {
      await window?.show();
    } else {
      await window?.hide();
    }
    unawaited(checkUpdate());
    await _handleFailedPreference();
    final bootAttempt = await startupRecovery.begin(
      profileId: _ref.read(currentProfileIdProvider),
      version:
          '${globalState.packageInfo.version}+${globalState.packageInfo.buildNumber}',
      processId: pid,
    );
    if (!startupRecovery.isCurrent(bootAttempt)) return;
    try {
      await _connectCore();
      if (!startupRecovery.isCurrent(bootAttempt)) return;
      await _initCore();
      if (!startupRecovery.isCurrent(bootAttempt)) return;
      await _initStatus();
      if (!startupRecovery.isCurrent(bootAttempt)) return;
      _ref.read(initProvider.notifier).value = true;
      await startupRecovery.markRunning(bootAttempt);
    } catch (_) {
      await startupRecovery.markFailed(bootAttempt);
      rethrow;
    }
    if (startupRecovery.automaticSetupPaused) {
      await window?.show();
      await globalState.showMessage(
        title: appLocalizations.startupRecoveryTitle,
        message: TextSpan(text: appLocalizations.startupRecoveryTip),
        cancelable: false,
      );
    }
  }

  /// An installer handed to the system outlives the launch that downloaded it,
  /// and a ready download does not survive a restart, so nothing in this launch
  /// can reach what an earlier one left behind.
  Future<void> _sweepUpdateDownloads() async {
    final task = _ref.read(appUpdateDownloadProvider);
    try {
      final directory = await appPath.tempDir.future;
      await task.cleanStaleDownloads(directory);
    } catch (error) {
      commonPrint.log(
        'update download sweep failed: $error',
        logLevel: LogLevel.warning,
      );
    }
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
    if (startupRecovery.automaticSetupPaused) {
      globalState.needInitStatus = false;
      if (globalState.isStart) {
        await globalState.startUpdateTasks([updateRunTime, updateTraffic]);
      }
      return;
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

  Future<void> checkUpdate({bool isUser = false}) =>
      _appUpdateCheck.run(isUser: isUser);

  Future<bool> _reuseAppUpdateDownload({required bool isUser}) async {
    final preparing = _startUpdateDownloadFuture;
    final task = _ref.read(appUpdateDownloadProvider);
    if (preparing == null && !task.hasDownload) return false;
    if (isUser) await (preparing ?? _showAppUpdateDownload(task));
    return true;
  }

  Future<void> _checkUpdate({required bool isUser}) async {
    // Every trigger waits for the one-time cleanup before starting a download.
    await (_updateDownloadsSweep ??= _sweepUpdateDownloads());
    if (await _reuseAppUpdateDownload(isUser: isUser)) return;
    final notice = _ref.read(appUpdateNoticeProvider);
    AppUpdateInfo? updateInfo;
    try {
      updateInfo = await request.checkForUpdate();
    } catch (error) {
      commonPrint.log(
        'check update failed: $error',
        logLevel: LogLevel.warning,
      );
      if (isUser) {
        await globalState.showMessage(
          title: appLocalizations.checkUpdate,
          message: TextSpan(text: appLocalizations.checkUpdateFailed),
          cancelable: false,
        );
      }
      return;
    }
    if (await _reuseAppUpdateDownload(isUser: isUser)) return;
    if (updateInfo == null) {
      if (isUser) {
        await globalState.showMessage(
          title: appLocalizations.checkUpdate,
          message: TextSpan(text: appLocalizations.checkUpdateError),
          cancelable: false,
        );
      }
      return;
    }
    final offer = resolveAppUpdateOffer(
      isUser: isUser,
      isUiVisible: await canPromptForAppUpdate(
        isUiVisible: globalState.isUiVisible,
        isWindowVisible: window == null ? null : () => window!.isVisible,
      ),
      remoteBuildNumber: updateInfo.remoteBuildNumber,
      declinedBuildNumber: notice.declinedBuildNumber,
    );
    if (await _reuseAppUpdateDownload(isUser: isUser)) return;
    if (offer == AppUpdateOffer.ignore) return;
    if (offer == AppUpdateOffer.notice) {
      // A hidden window is never brought forward; the notice holds the offer.
      _ref.read(appUpdateNoticeProvider).value = updateInfo;
      return;
    }
    final res = await promptForAppUpdate(
      showWindow: isUser ? window?.show : null,
      prompt: () => globalState.showMessage(
        title: appLocalizations.discovery,
        message: TextSpan(
          text: updateInfo!.releaseNotes ?? appLocalizations.noInfo,
        ),
        confirmText: appLocalizations.update,
      ),
    );
    if (res != true) {
      notice.decline(updateInfo.remoteBuildNumber);
      return;
    }
    _ref.read(appUpdateNoticeProvider).value = updateInfo;
    await _startAppUpdateDownload();
  }

  /// Fetches a release the notice reported but did not download itself.
  Future<void> acceptUpdateNotice() async {
    if (_ref.read(appUpdateNoticeProvider).value == null) return;
    await _startAppUpdateDownload();
  }

  Future<void> _startAppUpdateDownload() async {
    final pending = _startUpdateDownloadFuture;
    if (pending != null) return pending;
    final run = _startUpdateDownloadFuture = _prepareAppUpdateDownload();
    try {
      await run;
    } finally {
      if (identical(_startUpdateDownloadFuture, run)) {
        _startUpdateDownloadFuture = null;
      }
    }
  }

  Future<void> _prepareAppUpdateDownload() async {
    // Download errors live in the task state (notice / dialog / About); only
    // choosing a package, opening a browser or the dialog can throw here.
    await safeRun<void>(
      () async {
        var linuxFormat = LinuxPackageFormat.deb;
        if (system.isLinux) {
          final format = await _resolveLinuxPackageFormat();
          if (format == null) return;
          linuxFormat = format;
        }
        await _downloadAppUpdate(
          getAppUpdateDownloadUrl(Abi.current(), linuxFormat: linuxFormat),
        );
      },
      title: appLocalizations.checkUpdate,
      silence: false,
    );
  }

  /// Picks the package to download: a stored answer, then detection, then the
  /// user. Returns null while the question is still open.
  Future<LinuxPackageFormat?> _resolveLinuxPackageFormat() async {
    final formats = linuxPackageFormatsFor(Abi.current());
    // An ABI that publishes no Linux package at all (32-bit ARM, riscv) keeps
    // falling through to the download page rather than asking about formats.
    if (formats.isEmpty) return LinuxPackageFormat.deb;
    if (formats.length == 1) return formats.first;
    final stored = LinuxPackageFormat.fromName(
      await preferences.getLinuxPackageFormat(),
    );
    if (stored != null && formats.contains(stored)) return stored;
    final detected = await detectLinuxPackageFormat();
    if (detected != null && formats.contains(detected)) return detected;
    await window?.show();
    final picked = await globalState.showCommonDialog<LinuxPackageFormat>(
      child: LinuxPackageFormatDialog(formats: formats),
    );
    if (picked != null) await preferences.setLinuxPackageFormat(picked.name);
    return picked;
  }

  Future<void> _downloadAppUpdate(String? downloadUrl) async {
    if (downloadUrl == null) {
      await _openUpdateDownloadUrl('https://dl.dler.io');
      return;
    }
    final task = _ref.read(appUpdateDownloadProvider);
    final directory = await appPath.tempDir.future;
    unawaited(
      task.startDownload(
        (token, onProgress) async {
          // Route the transfer through the proxy once the core has started.
          await waitForAppUpdateStartup(
            isReady: () => _ref.read(initProvider),
            cancelToken: token,
          );
          final client = createAppUpdateDownloadClient();
          try {
            return await downloadAppUpdate(
              client: client,
              url: downloadUrl,
              fallbackUrls: [getAppUpdateFallbackDownloadUrl(downloadUrl)],
              directory: directory,
              cancelToken: token,
              onProgress: onProgress,
            );
          } catch (error) {
            commonPrint.log(
              'update download failed: '
              '${Secrets.redactApiDomains(error.toString())}',
              logLevel: LogLevel.warning,
            );
            rethrow;
          } finally {
            client.close(force: true);
          }
        },
        url: downloadUrl,
        directory: directory,
      ),
    );
    await _showAppUpdateDownload(task);
  }

  Future<void> _showAppUpdateDownload(AppUpdateDownloadTask task) async {
    if (_updateDialogOpen) return;
    _updateDialogOpen = true;
    UpdateDownloadAction? action;
    try {
      await window?.show();
      action = await globalState.showCommonDialog<UpdateDownloadAction>(
        dismissible: false,
        child: UpdateDownloadDialog(task: task),
      );
    } finally {
      _updateDialogOpen = false;
    }
    if (action == UpdateDownloadAction.install) {
      await installAppUpdate();
    } else if (action == UpdateDownloadAction.browser) {
      await safeRun(
        () => _openUpdateDownloadUrl(task.downloadUrl!),
        title: appLocalizations.checkUpdate,
      );
    }
  }

  Future<void> installAppUpdate() async {
    final task = _ref.read(appUpdateDownloadProvider);
    final file = task.value.file;
    if (file == null || _openingUpdateInstaller) return;
    _openingUpdateInstaller = true;
    try {
      await safeRun(() async {
        if (isAppImageInstaller(file)) {
          await _revealAppImageUpdate(file);
          task.dismissNotice();
          return;
        }
        await openAppUpdateDownload(
          file: file,
          openFile: (file) => system.isAndroid
              ? app!.openFile(file.path)
              : launchUrl(
                  Uri.file(file.path),
                  mode: LaunchMode.externalApplication,
                ),
          openBrowser: () => _openUpdateDownloadUrl(task.downloadUrl!),
          onError: (_) => commonPrint.log(
            'Unable to open downloaded update',
            logLevel: LogLevel.warning,
          ),
        );
        task.dismissNotice();
      }, title: appLocalizations.checkUpdate);
    } finally {
      _openingUpdateInstaller = false;
    }
  }

  /// An AppImage replaces itself by hand, so the download is only shown.
  Future<void> _revealAppImageUpdate(File file) async {
    await launchUrl(
      Uri.file(file.parent.path),
      mode: LaunchMode.externalApplication,
    );
    await globalState.showMessage(
      title: appLocalizations.updateReady,
      message: TextSpan(text: appLocalizations.updateAppImageTip),
      cancelable: false,
    );
  }

  Future<void> _openUpdateDownloadUrl(String downloadUrl) async {
    if (!await launchUrl(
      Uri.parse(downloadUrl),
      mode: LaunchMode.externalApplication,
    )) {
      throw StateError('Unable to open update download URL');
    }
  }
}

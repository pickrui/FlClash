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
    // Clear last launch's installers before a check can download a new one.
    unawaited(_sweepUpdateDownloads().then((_) => checkUpdate()));
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

  Future<void> checkUpdate({bool isUser = false}) async {
    final inFlight = _checkUpdateFuture;
    if (inFlight != null) {
      // A manual check must answer the user: let the background check finish
      // and run again, unless a manual check is already showing its result.
      if (!isUser || _checkUpdateForUser) return inFlight;
      await inFlight;
    }
    final run = _checkUpdateFuture = _checkUpdate(isUser: isUser);
    _checkUpdateForUser = isUser;
    try {
      await run;
    } finally {
      if (identical(_checkUpdateFuture, run)) _checkUpdateFuture = null;
    }
  }

  Future<void> _checkUpdate({required bool isUser}) async {
    final task = _ref.read(appUpdateDownloadProvider);
    if (task.hasDownload) {
      if (isUser) await _showAppUpdateDownload(task);
      return;
    }
    AppUpdateInfo? updateInfo;
    try {
      updateInfo = await request.checkForUpdate(includeReleaseNotes: isUser);
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
    if (!isUser) {
      // Name the release the automatic check found. The transfer starts on its
      // own, so the notice reports it instead of asking for a decision.
      _ref.read(appUpdateNoticeProvider).value = updateInfo;
      if (updateInfo.remoteBuildNumber <=
          await preferences.getLastSilentUpdateBuild()) {
        // Already downloaded once and not installed. The notice offers it
        // again rather than fetching the same installer on every launch.
        return;
      }
      await _startAppUpdateDownload(
        foreground: false,
        remoteBuildNumber: updateInfo.remoteBuildNumber,
      );
      return;
    }
    final res = await promptForAppUpdate(
      showWindow: window?.show,
      prompt: () => globalState.showMessage(
        title: appLocalizations.discovery,
        message: TextSpan(
          text: updateInfo!.releaseNotes ?? appLocalizations.noInfo,
        ),
      ),
    );
    if (res != true) {
      return;
    }
    await _startAppUpdateDownload(
      foreground: true,
      remoteBuildNumber: updateInfo.remoteBuildNumber,
    );
  }

  /// Fetches a release the notice reported but did not download itself.
  Future<void> acceptUpdateNotice() async {
    final updateInfo = _ref.read(appUpdateNoticeProvider).value;
    if (updateInfo == null) return;
    await _startAppUpdateDownload(
      foreground: true,
      remoteBuildNumber: updateInfo.remoteBuildNumber,
    );
  }

  Future<void> _startAppUpdateDownload({
    required bool foreground,
    required int remoteBuildNumber,
  }) async {
    // Download errors live in the task state (notice / dialog / About); only
    // choosing a package, opening a browser or the dialog can throw here.
    await safeRun<void>(
      () async {
        var linuxFormat = LinuxPackageFormat.deb;
        if (system.isLinux) {
          final format = await _resolveLinuxPackageFormat(
            foreground: foreground,
          );
          // Only the user can settle this, and only with the window in front.
          // The notice keeps offering the release until they answer.
          if (format == null) return;
          linuxFormat = format;
        }
        await _downloadAppUpdate(
          getAppUpdateDownloadUrl(Abi.current(), linuxFormat: linuxFormat),
          foreground: foreground,
          remoteBuildNumber: remoteBuildNumber,
        );
      },
      title: appLocalizations.checkUpdate,
      silence: !foreground,
    );
  }

  /// Picks the package to download: a stored answer, then detection, then the
  /// user. Returns null while the question is still open.
  Future<LinuxPackageFormat?> _resolveLinuxPackageFormat({
    required bool foreground,
  }) async {
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
    if (!foreground) return null;
    await window?.show();
    final picked = await globalState.showCommonDialog<LinuxPackageFormat>(
      child: LinuxPackageFormatDialog(formats: formats),
    );
    if (picked != null) await preferences.setLinuxPackageFormat(picked.name);
    return picked;
  }

  Future<void> _downloadAppUpdate(
    String? downloadUrl, {
    required bool foreground,
    required int remoteBuildNumber,
  }) async {
    if (downloadUrl == null) {
      if (foreground) await _openUpdateDownloadUrl('https://dl.dler.io');
      return;
    }
    final task = _ref.read(appUpdateDownloadProvider);
    if (!foreground) {
      // Let startup finish so the transfer uses the proxy once it is up,
      // instead of deciding the route before the core has started.
      await _waitForStartup();
    }
    final directory = await appPath.tempDir.future;
    unawaited(
      task
          .startDownload(
            (token, onProgress) async {
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
          )
          .then((_) async {
            if (!foreground &&
                task.value.phase == AppUpdateDownloadPhase.ready) {
              await preferences.setLastSilentUpdateBuild(remoteBuildNumber);
            }
          }),
    );
    if (foreground) await _showAppUpdateDownload(task);
  }

  Future<void> _waitForStartup() async {
    for (var i = 0; i < 120 && !_ref.read(initProvider); i++) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
    }
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

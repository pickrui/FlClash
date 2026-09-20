part of '../action.dart';

@Riverpod(keepAlive: true)
class SystemAction extends _$SystemAction {
  @override
  void build() {
    _controller = ref.watch(actionControllerProvider);
  }

  late AppController _controller;

  Future<List<Package>> getPackages() => _controller.getPackages();

  Future<void> handleExit([bool needSave = false]) =>
      _controller.handleExit(needSave);

  Future<void> handleBackOrExit({bool forceBack = false}) =>
      _controller.handleBackOrExit(forceBack: forceBack);

  Future<void> updateVisible() => _controller.updateVisible();

  void updateBrightness() => _controller.updateBrightness();

  void updateViewSize(Size size) => _controller.updateViewSize(size);

  void initLink() => _controller.initLink();

  void updateTun() => _controller.updateTun();

  /// Toggles the system proxy, or sets it to [enable] when given.
  void updateSystemProxy([bool? enable]) =>
      _controller.updateSystemProxy(enable);

  void updateAutoLaunch() => _controller.updateAutoLaunch();

  Future<void> updateTray() => _controller.updateTray();

  Future<void> updateLocalIp() => _controller.updateLocalIp();
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
        startupRecovery.markClosed,
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
    await windowPort?.toggle();
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

  void updateSystemProxy([bool? enable]) {
    if (_ref.read(networkSettingProvider).authentication.enable) {
      globalState.showNotifier(appLocalizations.authenticationSystemProxyDesc);
      return;
    }
    _ref
        .read(networkSettingProvider.notifier)
        .update(
          (state) => state.copyWith(systemProxy: enable ?? !state.systemProxy),
        );
  }

  void updateAutoLaunch() {
    _ref
        .read(appSettingProvider.notifier)
        .update((state) => state.copyWith(autoLaunch: !state.autoLaunch));
  }

  Future<void> updateTray() async {
    try {
      await tray?.update(trayState: _ref.read(trayStateProvider));
    } catch (error) {
      commonPrint.log('Tray update failed: $error', logLevel: LogLevel.warning);
    }
  }

  Future<void> updateLocalIp() async {
    _ref.read(localIpProvider.notifier).value = null;
    await Future.delayed(commonDuration);
    _ref.read(localIpProvider.notifier).value = await utils.getLocalIpAddress();
  }
}

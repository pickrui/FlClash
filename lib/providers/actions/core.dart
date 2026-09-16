part of '../action.dart';

@Riverpod(keepAlive: true)
class CoreAction extends _$CoreAction {
  @override
  void build() {
    _controller = ref.watch(actionControllerProvider);
  }

  late AppController _controller;

  String get coreDisconnectedMessage => _controller.coreDisconnectedMessage;

  Future<bool> ensureCoreReady() => _controller.ensureCoreReady();

  Future<void> ensureCoreReadyOrThrow() => _controller.ensureCoreReadyOrThrow();

  Future<void> restartCore([bool start = false]) =>
      _controller.restartCore(start);

  Future<bool> tryStartCore([bool start = false]) =>
      _controller.tryStartCore(start);
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
      if (!system.isAndroid) Future.delayed(const Duration(milliseconds: 300)),
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
    return _coreLifecycleOperations.ensureReady(_ensureCoreReady);
  }

  Future<void> ensureCoreReadyOrThrow() async {
    if (!await ensureCoreReady()) {
      throw _coreDisconnectedMessage;
    }
  }

  Future<bool> _ensureCoreReady() async {
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
    if (startupRecovery.automaticSetupPaused) {
      if (!start) return;
      startupRecovery.resumeAutomaticSetup();
    }
    await _serializeCoreLifecycle(() async {
      _ref.read(coreStatusProvider.notifier).value = CoreStatus.disconnected;
      clearDelay();
      await coreController.shutdown(true);
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

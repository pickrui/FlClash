part of '../action.dart';

@Riverpod(keepAlive: true)
class SetupAction extends _$SetupAction {
  @override
  void build() {
    _controller = ref.watch(actionControllerProvider);
  }

  late AppController _controller;

  Future<bool> updateGeoResource(
    GeoResource resource,
    String url, {
    Object? initialError,
    required bool Function() shouldContinue,
  }) => _controller.updateGeoResource(
    resource,
    url,
    initialError: initialError,
    shouldContinue: shouldContinue,
  );

  void fullSetup() => _controller.fullSetup();

  Future<void> updateStatus(bool isStart, {bool isInit = false}) =>
      _controller.updateStatus(isStart, isInit: isInit);

  Future<Map<String, dynamic>> getRawProfileConfig(int profileId) =>
      _controller.getRawProfileConfig(profileId);

  Future<String?> findRawProfileOutboundReference(
    int profileId,
    String name, {
    required bool includeTopLevelRules,
    bool includeProxyGroups = true,
  }) => _controller.findRawProfileOutboundReference(
    profileId,
    name,
    includeTopLevelRules: includeTopLevelRules,
    includeProxyGroups: includeProxyGroups,
  );

  Future<bool> needSetup() => _controller.needSetup();

  Future<void> updateProxyAuthentication(AuthenticationProps next) =>
      _controller.updateProxyAuthentication(next);

  Future<void> updateConfigDebounce() => _controller.updateConfigDebounce();

  Future<void> autoUpdateIpv6() => _controller.autoUpdateIpv6();

  Future<void> setAutoIpv6(bool value) => _controller.setAutoIpv6(value);

  void addCheckIp() => _controller.addCheckIp();

  void tryCheckIp() => _controller.tryCheckIp();

  void applyProfileDebounce({bool silence = false, bool force = false}) =>
      _controller.applyProfileDebounce(silence: silence, force: force);

  void changeMode(Mode mode) => _controller.changeMode(mode);

  void autoApplyProfile() => _controller.autoApplyProfile();

  Future<bool> applyProfile({
    bool silence = false,
    bool force = false,
    FutureOr<void> Function()? preloadInvoke,
  }) => _controller.applyProfile(
    silence: silence,
    force: force,
    preloadInvoke: preloadInvoke,
  );

  Future<Map<String, dynamic>> getProfile({
    required SetupState setupState,
    required ClashConfig patchConfig,
  }) =>
      _controller.getProfile(setupState: setupState, patchConfig: patchConfig);

  Future<Map<String, dynamic>> getProxyChainProfileConfig(int profileId) =>
      _controller.getProxyChainProfileConfig(profileId);

  Future<Map> getProfileWithId(int profileId) =>
      _controller.getProfileWithId(profileId);
}

extension SetupControllerExt on AppController {
  /// Serializes interactive downloads and recovery dialogs across resources.
  /// Offline validation dependencies first use the configured download URL.
  Future<bool> updateGeoResource(
    GeoResource resource,
    String url, {
    Object? initialError,
    required bool Function() shouldContinue,
  }) => _geoRecoveryLock.synchronized(() async {
    if (!shouldContinue()) return false;
    Future<String> download(String selected) => coreController.updateGeoData(
      UpdateGeoDataParams(
        geoName: geoFileName(resource),
        geoType: resource.name,
        url: selected,
      ),
    );

    return downloadGeoWithRecovery(
      initialError: initialError,
      download: () => download(url),
      shouldContinue: shouldContinue,
      recover: (failure) async =>
          await globalState.showCommonDialog<bool>(
            child: GeoRecoveryDialog(
              resource: resource,
              url: url,
              error: Secrets.redactApiDomains(failure.toString()),
              shouldContinue: shouldContinue,
              download: (selected) async {
                try {
                  return Secrets.redactApiDomains(await download(selected));
                } catch (error) {
                  return Secrets.redactApiDomains(error.toString());
                }
              },
            ),
          ) ==
          true,
    );
  });

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
      } else {
        startupRecovery.resumeAutomaticSetup();
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
      try {
        await globalState.handleStop();
      } finally {
        _ref.read(trafficsProvider.notifier).clear();
        _ref.read(totalTrafficProvider.notifier).value = const Traffic();
        _ref.read(runTimeProvider.notifier).value = null;
        addCheckIp();
        if (coreController.isCompleted) {
          coreController.resetTraffic();
        }
      }
    }
  }

  Future<Map<String, dynamic>> getRawProfileConfig(
    int profileId, {
    bool validateSnapshot = true,
  }) async {
    var profile = _ref.read(profilesProvider).getProfile(profileId);
    var existingPath = await profile?.getExistingFilePath(
      validate: validateSnapshot,
    );

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
    bool includeProxyGroups = true,
  }) async {
    final rawConfig = await getRawProfileConfig(profileId);
    return findRawOutboundReference(
      rawConfig,
      name,
      includeTopLevelRules: includeTopLevelRules,
      includeProxyGroups: includeProxyGroups,
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

  Future<void> updateProxyAuthentication(AuthenticationProps next) =>
      _proxyAuthenticationLock.synchronized(() async {
        next.credentials;
        final previous = _ref.read(networkSettingProvider).authentication;
        if (previous == next) return;
        final restart = needsVpnRestartForAuthentication(
          android: system.isAndroid,
          running: this.isStart,
          vpn: _ref.read(vpnSettingProvider),
          before: previous.enable,
          after: next.enable,
        );
        if (system.isDesktop &&
            next.enable &&
            !await stopSystemProxyIfNeeded()) {
          throw StateError('Could not restore the system proxy settings');
        }
        final generation = _startIntentGeneration + (restart ? 1 : 0);
        if (restart) await updateStatus(false);
        _ref
            .read(networkSettingProvider.notifier)
            .update((state) => state.copyWith(authentication: next));
        try {
          if (!await _saveConfigSerialized(config)) {
            throw StateError('Could not save authentication settings');
          }
        } catch (_) {
          _ref
              .read(networkSettingProvider.notifier)
              .update((state) => state.copyWith(authentication: previous));
          if (restart && generation == _startIntentGeneration) {
            await updateStatus(true);
          }
          rethrow;
        }
        if (system.isAndroid) {
          await preferences.saveShareState(this.sharedState);
        }
        // A later user Stop must win over this settings-triggered restart.
        if (restart && generation == _startIntentGeneration) {
          await updateStatus(true);
        }
      });

  Future<void> updateConfigDebounce() async {
    final generation = ++_configUpdateGeneration;
    debouncer.call(FunctionTag.updateConfig, () async {
      await safeRun(() async {
        final updateParams = _ref.read(updateParamsProvider);
        final authorization = await _requestAdmin(updateParams.tun.enable);
        if (authorization == AuthorizeCode.success ||
            generation != _configUpdateGeneration) {
          return;
        }
        if (!await ensureCoreReady()) {
          return;
        }
        if (generation != _configUpdateGeneration) {
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
    if (startupRecovery.automaticSetupPaused) return Future.value(false);
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
    final startGeneration = _startIntentGeneration;
    bool canRecover() =>
        isCurrentApply() && startGeneration == _startIntentGeneration;
    final previouslyAppliedState = globalState.lastSetupState;
    var keepCurrentCore = false;
    var setupAttempted = false;
    var coreSetupSucceeded = false;
    final res = await loadingRun<bool>(
      () async {
        try {
          if (!await withGeoRecovery(
            action: () => _setupConfig(
              profileId,
              generation,
              preloadInvoke: preloadInvoke,
              onApply: () => setupAttempted = true,
              shouldContinue: canRecover,
            ),
            shouldContinue: canRecover,
            recover: (resource, error) async {
              keepCurrentCore =
                  !setupAttempted &&
                  error is CandidateConfigValidationException;
              final recovered = await updateGeoResource(
                resource,
                failedGeoDownloadUrl(error) ??
                    _ref
                            .read(patchClashConfigProvider)
                            .geoXUrl
                            .toJson()[resource.key]
                        as String,
                initialError: error,
                shouldContinue: canRecover,
              );
              if (recovered) keepCurrentCore = false;
              return recovered;
            },
          )) {
            return !isCurrentApply();
          }
        } on CandidateConfigValidationException {
          keepCurrentCore = !setupAttempted;
          rethrow;
        }
        // The running config is valid now. A later UI/provider refresh failure
        // must not turn off forwarding or discard this profile's usable groups.
        coreSetupSucceeded = true;
        if (!isCurrentApply()) {
          return true;
        }
        if (!await _updateGroups(profileId)) {
          if (!isCurrentApply()) {
            return true;
          }
          if (!canPublishGroupsForProfile(profileId, previouslyAppliedState)) {
            // Groups from another subscription must not be shown as current.
            _ref.read(groupsProvider.notifier).value = [];
          }
          if (!_ref.read(initProvider)) return false;
          throw appLocalizations.noProxy;
        }
        if (!isCurrentApply()) {
          return true;
        }
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
        unawaited(
          updateProviders().catchError((Object error) {
            commonPrint.log('Provider refresh failed: $error');
          }),
        );
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
          coreSetupSucceeded: coreSetupSucceeded,
        )) {
      await updateStatus(false);
    }
    // Callers such as updateStatus also stop on false. Refreshing UI metadata
    // is best-effort once setup (including listener startup) has succeeded.
    return res == true || coreSetupSucceeded;
  }

  Future<Map<String, dynamic>> getProfile({
    required SetupState setupState,
    required ClashConfig patchConfig,
    bool validateSnapshot = true,
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
    final configMap = await getRawProfileConfig(
      profileId,
      validateSnapshot: validateSnapshot,
    );
    String? scriptContent;
    final List<Rule> addedRules = [];
    final List<ProxyGroup> customProxyGroups = [];
    final List<Rule> customRules = [];
    final proxyChains = List<ProxyChain>.from(setupState.proxyChains);
    if (setupState.overwriteType == OverwriteType.script) {
      scriptContent = await setupState.script?.content;
    } else {
      if (setupState.overwriteType == OverwriteType.custom ||
          setupState.overwriteType == OverwriteType.merge) {
        customProxyGroups.addAll(setupState.customProxyGroups);
        customRules.addAll(setupState.customRules);
      }
      if (setupState.overwriteType == OverwriteType.standard ||
          setupState.overwriteType == OverwriteType.merge) {
        addedRules.addAll(setupState.addedRules);
      }
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
        matchTarget: setupState.matchTarget,
        defaultUA: defaultUA,
        dockerMode: system.isDocker,
        blockQuic: setupState.blockQuic,
        blockWebRtc: setupState.blockWebRtc,
        authentication: _ref
            .read(networkSettingProvider)
            .authentication
            .credentials,
      ),
    );
    try {
      return await res;
    } on OverlayNameConflictException catch (error) {
      throw FormatException(appLocalizations.overlayNameConflict(error.name));
    } on EmptyCustomOverwriteException {
      throw FormatException(appLocalizations.emptyCustomOverwrite);
    }
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
    if (_ref.read(profilesProvider).getProfile(profileId)?.isoixCloudProfile ==
        true) {
      return {};
    }
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
    int generation, {
    FutureOr<void> Function()? preloadInvoke,
    required VoidCallback onApply,
    required bool Function() shouldContinue,
  }) async {
    bool isCurrentApply() {
      return shouldContinue() &&
          generation == _profileApplyGeneration &&
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
    final Map<String, dynamic> config;
    try {
      config = await getProfile(
        setupState: setupState,
        patchConfig: realPatchConfig,
        validateSnapshot: false,
      );
    } on FormatException catch (error) {
      // Composition errors have not touched the active core configuration.
      // Handle them like core validation failures to keep the connection alive.
      throw CandidateConfigValidationException(error.message);
    }
    final configFilePath = await appPath.configFilePath;
    final yamlString = await encodeYamlTask(config);
    if (!isCurrentApply()) return false;
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
      final encryptedBytes = await encryptProfileBytes(
        Uint8List.fromList(utf8.encode(yamlString)),
      );
      if (!isCurrentApply()) return false;
      await writeEncryptedProfileSnapshot(configFilePath, encryptedBytes);
    } else if (!isoixCloud) {
      await File(configFilePath).safeWriteAsString(yamlString);
    }

    final latestProfile = _ref.read(profilesProvider).getProfile(profileId);
    final updatedSetupParams = SetupParams(
      selectedMap: latestProfile?.selectedMap ?? const {},
      testUrl: _ref.read(appSettingProvider).testUrl,
      rawConfig: isoixCloud && !system.isAndroid ? yamlString : '',
      suspendOnIdle: _ref.read(networkSettingProvider).suspendOnIdle,
    );

    if (!isCurrentApply()) {
      return false;
    }

    final String message;
    try {
      onApply();
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

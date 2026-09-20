part of '../action.dart';

final _delayTestFailurePrompt = NetworkFailurePromptGate();

/// Group and built-in types that never count as a usable proxy node.
const _groupOnlyProxyTypes = {
  'Selector',
  'URLTest',
  'Fallback',
  'LoadBalance',
  'Direct',
  'Reject',
  'Pass',
};

@Riverpod(keepAlive: true)
class ProxiesAction extends _$ProxiesAction {
  @override
  void build() {
    _controller = ref.watch(actionControllerProvider);
  }

  late AppController _controller;

  void updateGroupsDebounce() => _controller.updateGroupsDebounce();

  void changeProxyDebounce(String groupName, String proxyName) =>
      _controller.changeProxyDebounce(groupName, proxyName);

  Future<void> updateGroups() => _controller.updateGroups();

  void updateCurrentGroupName(String groupName) =>
      _controller.updateCurrentGroupName(groupName);

  void updateCurrentSelectedMap(String groupName, String proxyName) =>
      _controller.updateCurrentSelectedMap(groupName, proxyName);

  void updateCurrentUnfoldSet(Set<String> value) =>
      _controller.updateCurrentUnfoldSet(value);

  int beginDelayTest() => _controller.beginDelayTest();

  bool isCurrentDelayGeneration(int generation) =>
      _controller.isCurrentDelayGeneration(generation);

  void setDelay(Delay delay, {int? generation}) =>
      _controller.setDelay(delay, generation: generation);

  void setDelays(Iterable<Delay> delays, {int? generation}) =>
      _controller.setDelays(delays, generation: generation);

  void clearDelay() => _controller.clearDelay();

  Future<bool> delayTest(List<Proxy> proxies, [String? testUrl]) =>
      _controller.delayTest(proxies, testUrl);

  Future<void> proxyDelayTest(Proxy proxy, [String? testUrl]) =>
      _controller.proxyDelayTest(proxy, testUrl);

  Future<bool> changeProxy({
    required int profileId,
    required String groupName,
    required String proxyName,
  }) => _controller.changeProxy(
    profileId: profileId,
    groupName: groupName,
    proxyName: proxyName,
  );

  void setProvider(ExternalProvider? provider) =>
      _controller.setProvider(provider);

  Future<void> updateProviders() => _controller.updateProviders();

  Future<String> updateProvider(
    ExternalProvider provider, {
    bool showLoading = false,
  }) => _controller.updateProvider(provider, showLoading: showLoading);

  int addSortNum() => _controller.addSortNum();
}

extension ProxiesControllerExt on AppController {
  void updateGroupsDebounce() {
    debouncer.call(FunctionTag.updateGroups, updateGroups);
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
      // The apply refreshes groups itself unless it turns out to be a no-op;
      // remember the request so applyProfile can replay it afterwards.
      _groupsRefreshRequested = true;
      return;
    }
    _groupsRefreshRequested = false;
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
      _groupsRefreshRequested = false;
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

  /// Tests one node. While a group test runs, the probe joins that batch
  /// instead of cancelling it, and a node already queued there is left alone.
  Future<void> proxyDelayTest(Proxy proxy, [String? testUrl]) async {
    final target = computeDelayTestTarget(
      proxy: proxy,
      groups: groups,
      selectedMap: this.currentProfile?.selectedMap ?? {},
      defaultTestUrl: getRealTestUrl(testUrl),
    );
    if (target == null) return;
    final batch = _activeDelayBatchGeneration;
    final joinsBatch = batch != null && isCurrentDelayGeneration(batch);
    if (joinsBatch &&
        _ref.read(delayDataSourceProvider)[target.url]?[target.name] == 0) {
      return;
    }
    final generation = joinsBatch ? batch : beginDelayTest();
    await _probeDelayTargets([target], generation);
    if (isCurrentDelayGeneration(generation)) updateGroupsDebounce();
  }

  /// Tests a group and returns whether every node failed, so the caller can
  /// offer the network self-check. Results are sorted and regrouped.
  Future<bool> delayTest(List<Proxy> proxies, [String? testUrl]) async {
    final targets = computeDelayTestTargets(
      proxies: proxies,
      groups: groups,
      selectedMap: this.currentProfile?.selectedMap ?? {},
      defaultTestUrl: getRealTestUrl(testUrl),
    );
    if (targets.isEmpty) return false;
    final profileId = this.currentProfile?.id;
    final runSession = globalState.startTime;
    final generation = beginDelayTest();
    _activeDelayBatchGeneration = generation;
    final completed = await _probeDelayTargets(targets, generation);
    if (_activeDelayBatchGeneration == generation) {
      _activeDelayBatchGeneration = null;
    }
    if (!isCurrentDelayGeneration(generation)) return false;
    addSortNum();
    updateGroupsDebounce();
    if (!system.isWindows && !system.isMacOS) return false;
    final nodeTargets = targets
        .where(
          (target) =>
              !const {'DIRECT', 'REJECT', 'COMPATIBLE'}.contains(target.name),
        )
        .toList();
    return _delayTestFailurePrompt.observe(
      session: (profileId, runSession),
      expected: nodeTargets.length,
      results: nodeTargets.map(
        (target) => completed[(target.name, target.url)],
      ),
      current:
          profileId == this.currentProfile?.id &&
          runSession == globalState.startTime,
      running: isProxyActive,
    );
  }

  Future<Map<(String, String), int?>> _probeDelayTargets(
    List<DelayTestTarget> targets,
    int generation,
  ) async {
    final completed = <(String, String), int?>{};
    setDelays(
      targets.map(
        (target) => Delay(url: target.url, name: target.name, value: 0),
      ),
      generation: generation,
    );
    await runDelayTestBatch(
      targets: targets,
      concurrency: normalizeDelayTestConcurrency(
        _ref.read(proxiesStyleSettingProvider).concurrencyLimit,
      ),
      probe: (target) => coreController.getDelay(
        target.url,
        target.name,
        isCurrent: () => isCurrentDelayGeneration(generation),
        generation: generation,
      ),
      isCurrent: () => isCurrentDelayGeneration(generation),
      onResult: (delay) {
        completed[(delay.name, delay.url)] = delay.value;
        setDelay(delay, generation: generation);
      },
    );
    return completed;
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
    final profileId = _ref.read(currentProfileIdProvider);
    final generation = _profileApplyGeneration;
    bool isCurrent() =>
        generation == _profileApplyGeneration &&
        profileId == _ref.read(currentProfileIdProvider);
    if (!await ensureCoreReady()) {
      if (isCurrent()) {
        _ref.read(providersProvider.notifier).value = [];
      }
      return;
    }
    if (!isCurrent()) return;
    final providers = await coreController.getExternalProviders();
    if (!isCurrent()) return;
    _ref.read(providersProvider.notifier).value = providers;
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

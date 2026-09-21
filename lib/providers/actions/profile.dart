part of '../action.dart';

@Riverpod(keepAlive: true)
class ProfileAction extends _$ProfileAction {
  @override
  void build() {
    _controller = ref.watch(actionControllerProvider);
  }

  late AppController _controller;

  Future<void> deleteProfile(int id) => _controller.deleteProfile(id);

  Future<void> autoUpdateProfiles() => _controller.autoUpdateProfiles();

  Future<void> putProfile(Profile profile, {bool reportOnWait = true}) =>
      _controller.putProfile(profile, reportOnWait: reportOnWait);

  Future<Profile> saveProfileMetadata(Profile edited) =>
      _controller.saveProfileMetadata(edited);

  Future<Profile> persistProfile(
    Profile profile,
    Future<Profile> Function() update, {
    bool preserveCurrentState = false,
  }) => _controller.persistProfile(
    profile,
    update,
    preserveCurrentState: preserveCurrentState,
  );

  Future<Profile> saveProfileFile(Profile profile, Uint8List bytes) =>
      _controller.saveProfileFile(profile, bytes);

  Future<void> updateProfiles() => _controller.updateProfiles();

  Future<Profile> updateProfile(
    Profile profile, {
    bool showLoading = false,
    bool applyIfCurrent = true,
    bool forceApplyIfCurrent = false,
    bool preserveCurrentState = true,
  }) => _controller.updateProfile(
    profile,
    showLoading: showLoading,
    applyIfCurrent: applyIfCurrent,
    forceApplyIfCurrent: forceApplyIfCurrent,
    preserveCurrentState: preserveCurrentState,
  );

  Future<void> requestStartCore() => _controller.requestStartCore();

  Future<Profile?> addProfileFormURL(
    String url, {
    bool requestStartIfNeeded = true,
  }) => _controller.addProfileFormURL(
    url,
    requestStartIfNeeded: requestStartIfNeeded,
  );

  Future<void> addProfileFormFile() => _controller.addProfileFormFile();

  Future<void> addProfileFormQrCode() => _controller.addProfileFormQrCode();

  void reorder(List<Profile> profiles) => _controller.reorder(profiles);

  Future<void> clearEffect(int profileId) => _controller.clearEffect(profileId);
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

  Future<Profile> saveProfileMetadata(Profile edited) {
    return storageLock.synchronized(() async {
      final current = _ref.read(profilesProvider).getProfile(edited.id);
      if (current == null) {
        throw StateError('profile is no longer available');
      }
      final profile = mergeProfileMetadata(current, edited);
      await putProfile(profile, reportOnWait: false);
      return profile;
    });
  }

  Future<Profile> persistProfile(
    Profile profile,
    Future<Profile> Function() update, {
    bool preserveCurrentState = false,
    bool invalidatePendingUpdates = false,
  }) async {
    // Account bootstrap may remove expired profiles using this same lock.
    if (profile.isoixCloudProfile) {
      await _ref.read(cloudAccountProvider.notifier).ensureReady();
    }
    // Callers prepare downloads first. Snapshot backup, replacement, metadata
    // commit and rollback must all hold the same lock as other profile edits.
    Future<Profile> commit() async {
      return withFileRollback(
        await appPath.getProfilePath(profile.id.toString()),
        () async {
          final updatedProfile = await update();
          final currentProfile = _ref
              .read(profilesProvider)
              .getProfile(profile.id);
          final profileToSave = currentProfile == null
              ? updatedProfile
              : mergePersistedProfile(
                  currentProfile,
                  updatedProfile,
                  preserveCurrentState: preserveCurrentState,
                );
          await putProfile(profileToSave, reportOnWait: false);
          return profileToSave;
        },
      );
    }

    return invalidatePendingUpdates
        ? withProfileStorageMutation(commit, profileId: profile.id)
        : storageLock.synchronized(commit);
  }

  Future<Profile> saveProfileFile(Profile profile, Uint8List bytes) {
    return persistProfile(
      profile,
      () => profile.saveFile(bytes),
      invalidatePendingUpdates: true,
    );
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
    bool preserveCurrentState = true,
  }) async {
    try {
      await ensureCoreReadyOrThrow();
      if (showLoading) {
        _ref.read(isUpdatingProvider(profile.updatingKey).notifier).value =
            true;
      }
      final newProfile = await _updateProfileWithCertificateRetry(
        profile,
        preserveCurrentState: preserveCurrentState,
      );
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

  Future<Profile> _updateProfileWithCertificateRetry(
    Profile profile, {
    bool preserveCurrentState = true,
  }) {
    return _runWithCertificateRetry(() async {
      if (profile.isoixCloudProfile) {
        await _ref
            .read(cloudAccountProvider.notifier)
            .prepareManagedConfigUpdate();
      }
      final current = _ref.read(profilesProvider).getProfile(profile.id);
      if (current == null) {
        throw StateError('profile is no longer available');
      }
      final source = preserveCurrentState ? current : profile;
      final prepared = await source.prepareUpdate();
      return persistProfile(profile, () {
        final latest = _ref.read(profilesProvider).getProfile(profile.id);
        if (latest == null) {
          throw StateError('profile is no longer available');
        }
        // A URL edit during the download invalidates its content; never save
        // an old subscription under the newly edited URL or revive a deletion.
        if (latest.url != current.url) {
          throw StateError('profile URL changed during download');
        }
        return prepared.save();
      }, preserveCurrentState: preserveCurrentState);
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
        message: TextSpan(text: appLocalizations.startCorePromptContent),
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
      return _runWithCertificateRetry(() async {
        final profile = Profile.normal(url: url);
        final prepared = await profile.prepareUpdate();
        return persistProfile(profile, prepared.save);
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

  Future<void> clearEffect(int profileId) {
    return withProfileStorageMutation(() async {
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
    }, profileId: profileId);
  }
}

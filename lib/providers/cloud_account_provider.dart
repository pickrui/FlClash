import 'dart:async';
import 'dart:convert';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/database/database.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/database.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/utils/safe_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CloudAccountNotifier extends Notifier<CloudAccountState> {
  DateTime? _lastRefreshTime;
  SharedPreferences? _prefs;
  Future<void>? _initFuture;
  Future<void>? _signInFuture;
  Future<void>? _managedProfileFuture;
  Future<void>? _unauthorizedFuture;
  Future<void>? _refreshFuture;

  bool get _canFetchManagedConfig {
    return _lastRefreshTime != null &&
        state.profile?.canFetchManagedConfig == true;
  }

  String _requireNormalizedToken(String token) {
    final normalizedToken = CloudApiService.normalizeToken(token);
    if (normalizedToken == null) {
      throw Exception('Access token is empty');
    }
    return normalizedToken;
  }

  Future<SharedPreferences> get _safePrefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<void> _clearStoredToken() async {
    CloudApiService().setToken(null);
    Object? cleanupError;
    StackTrace? cleanupStack;
    try {
      await SafeStorage.delete('cloud_token');
    } catch (e, stack) {
      cleanupError = e;
      cleanupStack = stack;
    }
    try {
      final prefs = await _safePrefs;
      await prefs.remove('cloud_token');
    } catch (e, stack) {
      cleanupError ??= e;
      cleanupStack ??= stack;
    }
    if (cleanupError != null) {
      Error.throwWithStackTrace(cleanupError, cleanupStack!);
    }
  }

  /// Awaitable handle to the one-shot init. Call sites that need the token
  /// before issuing API calls should `await ensureReady()` to avoid the
  /// race where `_init()` hasn't yet pushed the token into [CloudApiService].
  Future<void> ensureReady() => _initFuture ?? Future.value();

  @override
  CloudAccountState build() {
    _initFuture = _init();
    registerEnsureCloudReady(ensureReady);
    registerCanFetchManagedConfig(() => _canFetchManagedConfig);
    return const CloudAccountState();
  }

  Future<void> _init() async {
    final prefs = await _safePrefs;
    String? token = await SafeStorage.read('cloud_token');

    // Migrate plain-text token to secure storage if necessary.
    if (token == null || token.isEmpty) {
      final oldToken = prefs.getString('cloud_token');
      if (oldToken != null && oldToken.isNotEmpty) {
        token = oldToken;
        await SafeStorage.write('cloud_token', token);
        await prefs.remove('cloud_token');
      }
    }

    if (token == null || token.isEmpty) {
      CloudApiService().setToken(null);
      await _clearCache(clearParams: false);
      return;
    }

    CloudApiService().setToken(token);

    final cached = _readCachedProfile(prefs);
    state = state.copyWith(
      isLoggedIn: true,
      profile: cached.profile,
      latestNotification: cached.notification,
    );

    await refreshProfile(force: true);
  }

  ({CloudProfile? profile, CloudNotification? notification}) _readCachedProfile(
    SharedPreferences prefs,
  ) {
    CloudProfile? profile;
    CloudNotification? notification;
    try {
      final s = prefs.getString('cloud_profile');
      if (s != null) profile = CloudProfile.fromJson(jsonDecode(s));
    } catch (e) {
      commonPrint.log(
        'discarding corrupted cloud_profile cache: $e',
        logLevel: LogLevel.warning,
      );
      prefs.remove('cloud_profile');
    }
    try {
      final s = prefs.getString('cloud_notification');
      if (s != null) notification = CloudNotification.fromJson(jsonDecode(s));
    } catch (e) {
      commonPrint.log(
        'discarding corrupted cloud_notification cache: $e',
        logLevel: LogLevel.warning,
      );
      prefs.remove('cloud_notification');
    }
    return (profile: profile, notification: notification);
  }

  Future<void> _saveCache(
    CloudProfile profile,
    CloudNotification? notification,
  ) async {
    final prefs = await _safePrefs;
    await prefs.setString('cloud_profile', jsonEncode(profile.toJson()));
    if (notification != null) {
      await prefs.setString(
        'cloud_notification',
        jsonEncode(notification.toJson()),
      );
    }
  }

  Future<void> _clearCache({bool clearParams = true}) async {
    final prefs = await _safePrefs;
    await prefs.remove('cloud_profile');
    await prefs.remove('cloud_notification');
    if (clearParams) {
      await CloudParamsStorage.clear();
    }
  }

  Future<void> _deleteProfileLocally(
    int id, {
    required int? fallbackProfileId,
  }) async {
    await ref.read(profilesProvider.notifier).del(id, reportOnWait: false);
    await appController.clearEffect(id);
    if (ref.read(currentProfileIdProvider) != id) {
      return;
    }
    ref.read(currentProfileIdProvider.notifier).value = fallbackProfileId;
  }

  Future<void> _clearManagedProfiles() async {
    final currentProfiles = ref.read(profilesProvider);
    final sourceProfiles = currentProfiles.isNotEmpty
        ? currentProfiles
        : await database.profilesDao.all().get();
    final existing = sourceProfiles.where((p) => p.isoixCloudProfile).toList();
    final fallbackProfileId = sourceProfiles
        .where((p) => !p.isoixCloudProfile)
        .firstOrNull
        ?.id;
    await runCleanupActions(
      existing.map(
        (profile) => () async {
          if (appController.isAttach) {
            await appController.deleteProfile(profile.id);
          } else {
            await _deleteProfileLocally(
              profile.id,
              fallbackProfileId: fallbackProfileId,
            );
          }
        },
      ),
    );
  }

  Future<void> _activateManagedProfile(
    Profile profile, {
    bool requestStartIfNeeded = true,
    bool applyIfRunning = true,
  }) async {
    ref.read(currentProfileIdProvider.notifier).value = profile.id;
    if (!appController.isAttach) {
      return;
    }
    if (applyIfRunning && appController.isStart) {
      await appController.applyProfile(silence: true, force: true);
      return;
    }
    if (requestStartIfNeeded) {
      await appController.requestStartCore();
    }
  }

  Future<void> _addManagedProfile(String url) async {
    if (!_canFetchManagedConfig) return;

    await createAndActivateManagedProfile<Profile>(
      create: ({required requestStartIfNeeded}) {
        return appController.addProfileFormURL(
          url,
          requestStartIfNeeded: requestStartIfNeeded,
        );
      },
      activate: _activateManagedProfile,
    );
  }

  Future<void> _syncExistingManagedProfile(
    List<Profile> existing, {
    bool showLoading = false,
    bool showSuccessMessage = false,
  }) async {
    final updateFlow = CloudManagedProfileUpdateFlow<Profile>(
      deduplicate: _dedupCloudProfiles,
      refresh: (profile, {required showLoading, required applyIfCurrent}) {
        return appController.updateProfile(
          profile,
          showLoading: showLoading,
          applyIfCurrent: applyIfCurrent,
        );
      },
      activate: (profile, {required applyIfRunning}) {
        return _activateManagedProfile(profile, applyIfRunning: applyIfRunning);
      },
    );

    final updatedProfile = await updateFlow.refreshExisting(
      existing,
      showLoading: showLoading,
    );
    if (showSuccessMessage) {
      globalState.showNotifier(AppLocalizations.current.getProfileSuccess);
    }
    if (updatedProfile.id == ref.read(currentProfileIdProvider) &&
        appController.isStart) {
      appController.applyProfileDebounce(silence: true, force: true);
    }
  }

  Future<void> signInWithPassword({
    required String email,
    required String password,
  }) {
    return _runSignIn(() async {
      final result = await CloudApiService().login(email, password);
      await _completeSignIn(
        token: _requireNormalizedToken(result.token),
        profile: result.profile,
        announcement: result.announcement,
      );
    });
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    String? inviteCode,
    String? emailCode,
  }) {
    return _runSignIn(() async {
      final result = await CloudApiService().register(
        name: name,
        email: email,
        password: password,
        inviteCode: inviteCode,
        emailCode: emailCode,
      );
      await _completeSignIn(
        token: _requireNormalizedToken(result.token),
        profile: result.profile,
        announcement: result.announcement,
      );
    });
  }

  Future<void> signInWithToken(String token) {
    return _runSignIn(() async {
      final normalizedToken = _requireNormalizedToken(token);
      CloudApiService().setToken(normalizedToken);
      final userInfo = await CloudApiService().getUserInfo();
      await _completeSignIn(
        token: normalizedToken,
        profile: userInfo.profile,
        announcement: userInfo.announcement,
      );
    });
  }

  Future<void> _runSignIn(Future<void> Function() action) {
    final inFlight = _signInFuture;
    if (inFlight != null) {
      return inFlight;
    }

    final future = () async {
      state = state.copyWith(isLoading: true, error: null);
      try {
        await ensureReady();
        // Bootstrap may clear an expired session and reset the loading flag.
        state = state.copyWith(isLoading: true, error: null);
        await action();
      } catch (e) {
        if (CloudApiException.isHandledUnauthorized(e)) rethrow;
        await _rollbackFailedSignIn(e);
        rethrow;
      } finally {
        _signInFuture = null;
      }
    }();

    _signInFuture = future;
    return future;
  }

  Future<void> _rollbackFailedSignIn(Object error) async {
    _lastRefreshTime = null;
    try {
      await _clearStoredToken();
      await _clearCache();
    } catch (e, s) {
      commonPrint.log(
        'failed to rollback oixCloud sign-in: $e\n$s',
        logLevel: LogLevel.warning,
      );
    }
    state = CloudAccountState(error: CloudApiException.clean(error));
  }

  Future<void> _completeSignIn({
    required String token,
    required CloudProfile profile,
    required CloudNotification? announcement,
  }) async {
    CloudApiService().setToken(token);
    await SafeStorage.write('cloud_token', token);
    _lastRefreshTime = DateTime.now();
    await _saveCache(profile, announcement);
    await _injectDefaultParams(profile);
    state = state.copyWith(
      isLoading: false,
      isLoggedIn: true,
      profile: profile,
      latestNotification: announcement,
    );
    if (_canFetchManagedConfig) {
      await importManagedProfile(oixCloudManagedProfileUrl);
    } else {
      await _clearManagedProfiles();
    }
    globalState.showNotifier(AppLocalizations.current.loginSuccess);
  }

  Future<void> refreshProfile({bool force = false}) {
    final inFlight = _refreshFuture;
    if (inFlight != null) {
      return inFlight;
    }
    final future = _runRefreshProfile(force: force);
    _refreshFuture = future.whenComplete(() {
      _refreshFuture = null;
    });
    return _refreshFuture!;
  }

  Future<void> _runRefreshProfile({bool force = false}) async {
    if (!state.isLoggedIn || state.isLoading || state.isSyncing) return;
    if (!force && _lastRefreshTime != null) {
      if (DateTime.now().difference(_lastRefreshTime!) <
          const Duration(minutes: 30)) {
        return;
      }
    }

    state = state.copyWith(isRefreshing: true, error: null);
    try {
      final userInfo = await CloudApiService().getUserInfo();
      _lastRefreshTime = DateTime.now();
      await _saveCache(
        userInfo.profile,
        userInfo.announcement ?? state.latestNotification,
      );
      await _injectDefaultParams(userInfo.profile);

      state = state.copyWith(
        isRefreshing: false,
        profile: userInfo.profile,
        latestNotification: userInfo.announcement ?? state.latestNotification,
      );
      if (!_canFetchManagedConfig) {
        await _clearManagedProfiles();
      }
    } catch (e) {
      if (CloudApiException.isHandledUnauthorized(e)) {
        return;
      }
      final unauthorized = CloudApiException.isUnauthorized(e);
      if (unauthorized) {
        await handleUnauthorized();
        return;
      }
      state = state.copyWith(
        isRefreshing: false,
        isLoggedIn: state.isLoggedIn,
        error: CloudApiException.clean(e),
      );
    }
  }

  Future<void> _injectDefaultParams(CloudProfile profile) async {
    final tier = SubscriptionTier.fromServer(
      profile.subscription,
      planCode: profile.planCode,
      planRank: profile.planRank,
      nodeAccess: profile.nodeAccess,
    );
    await CloudParamsStorage.reconcileForTier(tier);
  }

  /// Refreshes the plan identity first so tier-dependent parameters are current
  /// before the managed subscription is regenerated.
  Future<void> refreshManagedSubscription() async {
    await refreshProfile(force: true);
    if (!state.isLoggedIn || state.error != null) return;
    await syncManagedConfig();
  }

  Future<void> syncManagedConfig() async {
    if (!state.isLoggedIn || state.isLoading || state.isRefreshing) return;
    if (!_canFetchManagedConfig) {
      await _clearManagedProfiles();
      return;
    }

    await _runManagedProfileTask(() async {
      state = state.copyWith(isSyncing: true, error: null);
      try {
        if (state.profile != null) {
          await _injectDefaultParams(state.profile!);
        }

        final existing = await _existingCloudProfiles();
        if (existing.isEmpty) {
          if (state.profile != null) {
            await _addManagedProfile(oixCloudManagedProfileUrl);
            await _dedupCloudProfiles(await _existingCloudProfiles());
          }
        } else {
          await _syncExistingManagedProfile(existing);
        }
      } catch (e) {
        if (CloudApiException.isHandledUnauthorized(e)) {
          return;
        }
        if (CloudApiException.isUnauthorized(e)) {
          await handleUnauthorized();
          return;
        }
        state = state.copyWith(error: CloudApiException.clean(e));
      } finally {
        state = state.copyWith(isSyncing: false);
      }
    });
  }

  Future<void> importManagedProfile(String url) async {
    if (!_canFetchManagedConfig) {
      await _clearManagedProfiles();
      return;
    }

    await _runManagedProfileTask(() async {
      final existing = await _existingCloudProfiles();
      if (existing.isEmpty) {
        await _addManagedProfile(url);
        await _dedupCloudProfiles(await _existingCloudProfiles());
        return;
      }

      try {
        await _syncExistingManagedProfile(
          existing,
          showLoading: true,
          showSuccessMessage: true,
        );
      } catch (e) {
        if (CloudApiException.isHandledUnauthorized(e)) {
          return;
        }
        if (CloudApiException.isUnauthorized(e)) {
          await handleUnauthorized();
          return;
        }
        globalState.showNotifier(CloudApiException.clean(e));
      }
    });
  }

  Future<T> _runManagedProfileTask<T>(Future<T> Function() action) async {
    while (_managedProfileFuture != null) {
      await _managedProfileFuture;
    }

    final task = action();
    final marker = task.then<void>((_) {}, onError: (_) {});
    _managedProfileFuture = marker;

    try {
      return await task;
    } finally {
      if (identical(_managedProfileFuture, marker)) {
        _managedProfileFuture = null;
      }
    }
  }

  Future<List<Profile>> _existingCloudProfiles() async {
    final byId = <int, Profile>{};
    final dbProfiles = await database.profilesDao.all().get();

    for (final profile in dbProfiles) {
      if (profile.isoixCloudProfile) {
        byId[profile.id] = profile;
      }
    }
    for (final profile in ref.read(profilesProvider)) {
      if (profile.isoixCloudProfile) {
        byId[profile.id] = profile;
      }
    }

    final profiles = byId.values.toList();
    profiles.sort((a, b) {
      final orderA = a.order;
      final orderB = b.order;
      if (orderA != null && orderB != null && orderA != orderB) {
        return orderA.compareTo(orderB);
      }
      if (orderA != null && orderB == null) return -1;
      if (orderA == null && orderB != null) return 1;
      return a.id.compareTo(b.id);
    });
    return profiles;
  }

  Future<void> _dedupCloudProfiles(List<Profile> existing) async {
    for (int i = 1; i < existing.length; i++) {
      await appController.deleteProfile(existing[i].id);
    }
  }

  Future<bool> signOut({bool revokeToken = false}) async {
    if (state.isLoading ||
        state.isRefreshing ||
        state.isSyncing ||
        _managedProfileFuture != null) {
      return false;
    }
    state = state.copyWith(isLoading: true, error: null);
    if (revokeToken) {
      try {
        await logoutRequest();
      } catch (e) {
        if (CloudApiException.isHandledUnauthorized(e)) return false;
        state = state.copyWith(
          isLoading: false,
          error: CloudApiException.clean(e),
        );
        return false;
      }
    }
    final cleanupError = await clearSession();
    if (cleanupError != null) {
      state = state.copyWith(error: cleanupError);
      return false;
    }
    return true;
  }

  @protected
  Future<void> Function() get logoutRequest => CloudApiService().logout;

  Future<bool> deleteAccount({
    required String password,
    String? twoFactorCode,
  }) async {
    if (!state.isLoggedIn ||
        state.isLoading ||
        state.isRefreshing ||
        state.isSyncing ||
        _managedProfileFuture != null) {
      return false;
    }
    state = state.copyWith(isLoading: true, error: null);
    try {
      await deleteAccountRequest(
        password: password,
        twoFactorCode: twoFactorCode,
      );
    } catch (e) {
      if (CloudApiException.isHandledUnauthorized(e)) return false;
      final error = CloudApiException.clean(e);
      if (CloudApiException.isUnauthorized(e)) {
        await clearSession();
        state = state.copyWith(error: error);
        return false;
      }
      state = state.copyWith(isLoading: false, error: error);
      return false;
    }
    final cleanupError = await clearSession();
    if (cleanupError != null) {
      state = state.copyWith(error: cleanupError);
      return false;
    }
    return true;
  }

  @protected
  Future<void> Function({required String password, String? twoFactorCode})
  get deleteAccountRequest => CloudApiService().deleteAccount;

  @protected
  Future<String?> clearSession() async {
    _lastRefreshTime = null;
    String? cleanupError;
    try {
      await _clearStoredToken();
    } catch (e) {
      CloudApiService().setToken(null);
      cleanupError = CloudApiException.clean(e);
      commonPrint.log(
        'failed to clear cloud token: $e',
        logLevel: LogLevel.warning,
      );
    }
    try {
      await _clearCache();
    } catch (e) {
      cleanupError ??= CloudApiException.clean(e);
      commonPrint.log(
        'failed to clear cloud cache: $e',
        logLevel: LogLevel.warning,
      );
    }

    state = const CloudAccountState();
    ref.read(storeProvider.notifier).reset();
    try {
      await _clearManagedProfiles();
    } catch (e) {
      cleanupError ??= CloudApiException.clean(e);
      commonPrint.log(
        'failed to clear managed cloud profiles: $e',
        logLevel: LogLevel.warning,
      );
    }
    return cleanupError;
  }

  Future<void> handleUnauthorized() {
    final inFlight = _unauthorizedFuture;
    if (inFlight != null) {
      return inFlight;
    }

    final future = () async {
      final cleanupError = await clearSession();
      if (cleanupError != null) {
        state = state.copyWith(error: cleanupError);
      }
    }();

    // Callers may hold the managed-profile queue while handling a 401. Release
    // them after cleanup so signing in can enqueue a fresh profile import.
    final cleanup = future.whenComplete(() {
      _unauthorizedFuture = null;
    });
    _unauthorizedFuture = cleanup;
    unawaited(
      cleanup.then((_) => showUnauthorizedLogin()).catchError((
        Object error,
        StackTrace stack,
      ) {
        commonPrint.log(
          'failed to show cloud login: $error\n$stack',
          logLevel: LogLevel.warning,
        );
        if (ref.mounted && !state.isLoggedIn && state.error == null) {
          state = state.copyWith(error: CloudApiException.clean(error));
        }
      }),
    );
    return cleanup;
  }

  @protected
  Future<void> showUnauthorizedLogin() async {
    if (appController.isAttach) {
      await appController.openCloudLogin();
    }
  }
}

final cloudAccountProvider =
    NotifierProvider<CloudAccountNotifier, CloudAccountState>(
      CloudAccountNotifier.new,
    );

import 'dart:async';

import 'package:fl_clash/common/oix_cloud.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/cloud_account_provider.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test(
    'a superseded sign-in still fails without clearing the new session',
    () async {
      final api = CloudApiService()..setToken('new-session');
      addTearDown(() => api.setToken(null));
      final revision = api.sessionRevision;
      final notifier = _SupersededSignInNotifier();
      final container = ProviderContainer(
        overrides: [cloudAccountProvider.overrideWith(() => notifier)],
      );
      addTearDown(container.dispose);
      container.read(cloudAccountProvider);

      await expectLater(
        notifier.signInWithToken('old-session'),
        throwsA(isA<CloudApiStaleSessionException>()),
      );

      expect(api.sessionRevision, revision);
      expect(container.read(cloudAccountProvider).isLoggedIn, isTrue);
      expect(container.read(cloudAccountProvider).isLoading, isFalse);
    },
  );

  for (final deleteAccount in [false, true]) {
    test(
      'an obsolete ${deleteAccount ? 'deletion' : 'logout'} does not clear the current session',
      () async {
        final notifier = _DeleteNotifier(
          requestError: const CloudApiStaleSessionException(),
          logoutError: const CloudApiStaleSessionException(),
        );
        final container = ProviderContainer(
          overrides: [cloudAccountProvider.overrideWith(() => notifier)],
        );
        addTearDown(container.dispose);
        container.read(cloudAccountProvider);

        final success = deleteAccount
            ? await notifier.deleteAccount(password: 'test-password')
            : await notifier.signOut(revokeToken: true);

        expect(success, isFalse);
        expect(notifier.didClearSession, isFalse);
        expect(container.read(cloudAccountProvider).isLoggedIn, isTrue);
        expect(container.read(cloudAccountProvider).error, isNull);
      },
    );
  }

  test(
    'token sign-in waits for bootstrap before beginning its action',
    () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
      addTearDown(() => debugDefaultTargetPlatformOverride = null);
      SharedPreferences.setMockInitialValues({});
      final ready = Completer<void>();
      final notifier = _InitializingNotifier(ready.future);
      final container = ProviderContainer(
        overrides: [cloudAccountProvider.overrideWith(() => notifier)],
      );
      addTearDown(container.dispose);
      container.read(cloudAccountProvider);
      final loadingStates = <bool>[];
      container.listen(cloudAccountProvider, (_, next) {
        loadingStates.add(next.isLoading);
      });
      var completed = false;

      // Invalid input fails as soon as the sign-in action begins, without HTTP.
      final signIn = notifier.signInWithToken('');
      final failure = expectLater(
        signIn,
        throwsA(
          predicate<Object>(
            (error) => error.toString().contains('Access token is empty'),
          ),
        ),
      ).then((_) => completed = true);
      await pumpEventQueue();
      expect(completed, isFalse);
      expect(container.read(cloudAccountProvider).isLoading, isTrue);
      ready.complete();
      await failure;
      expect(container.read(cloudAccountProvider).isLoading, isFalse);
      expect(loadingStates, [true, false, true, false]);
    },
  );

  test(
    'unauthorized cleanup completes while the login dialog remains open',
    () async {
      final cleanup = Completer<void>();
      final loginClosed = Completer<void>();
      final loginOpened = Completer<void>();
      final notifier = _UnauthorizedNotifier(
        cleanup: cleanup.future,
        showLogin: () {
          loginOpened.complete();
          return loginClosed.future;
        },
      );
      final container = ProviderContainer(
        overrides: [cloudAccountProvider.overrideWith(() => notifier)],
      );
      addTearDown(container.dispose);
      container.read(cloudAccountProvider);

      final first = notifier.handleUnauthorized();
      expect(identical(notifier.handleUnauthorized(), first), isTrue);
      expect(notifier.cleanupCount, 1);
      cleanup.complete();
      await loginOpened.future;
      await first.timeout(const Duration(seconds: 1));
      expect(loginClosed.isCompleted, isFalse);
      loginClosed.complete();
      await pumpEventQueue();
    },
  );

  test(
    'a new unauthorized session is cleared while the old dialog is open',
    () async {
      final loginClosed = Completer<void>();
      final notifier = _UnauthorizedNotifier(
        showLogin: () => loginClosed.future,
      );
      final container = ProviderContainer(
        overrides: [cloudAccountProvider.overrideWith(() => notifier)],
      );
      addTearDown(container.dispose);
      container.read(cloudAccountProvider);

      await notifier.handleUnauthorized();
      await notifier.handleUnauthorized();
      expect(notifier.cleanupCount, 2);
      loginClosed.complete();
      await pumpEventQueue();
    },
  );

  test(
    're-login can wait for the unauthorized managed task to release',
    () async {
      late Future<void> managedTask;
      final loginCompleted = Completer<void>();
      final notifier = _UnauthorizedNotifier(
        showLogin: () async {
          // Importing the new account's profile waits on the old sync task.
          await managedTask;
          loginCompleted.complete();
        },
      );
      final container = ProviderContainer(
        overrides: [cloudAccountProvider.overrideWith(() => notifier)],
      );
      addTearDown(container.dispose);
      container.read(cloudAccountProvider);

      managedTask = notifier.handleUnauthorized();
      await loginCompleted.future.timeout(const Duration(seconds: 1));
      expect(notifier.cleanupCount, 1);
      expect(container.read(cloudAccountProvider).isLoggedIn, isFalse);
    },
  );

  for (final cleanupError in [null, 'Failed to remove cached credentials']) {
    test(
      'login display failure preserves cleanup error: $cleanupError',
      () async {
        final notifier = _UnauthorizedNotifier(
          cleanupError: cleanupError,
          showLogin: () async => throw StateError('login dialog failed'),
        );
        final container = ProviderContainer(
          overrides: [cloudAccountProvider.overrideWith(() => notifier)],
        );
        addTearDown(container.dispose);
        container.read(cloudAccountProvider);

        await notifier.handleUnauthorized();
        await pumpEventQueue();
        expect(
          container.read(cloudAccountProvider).error,
          cleanupError ?? 'Bad state: login dialog failed',
        );
      },
    );
  }

  test('managed profile activates before any core start request', () async {
    final events = <String>[];

    final result = await createAndActivateManagedProfile<int>(
      create: ({required requestStartIfNeeded}) async {
        events.add('create:$requestStartIfNeeded');
        return 42;
      },
      activate: (profile) async {
        events.add('activate:$profile');
      },
    );

    expect(result, 42);
    expect(events, ['create:false', 'activate:42']);
  });

  test('managed profile does not activate when creation fails', () async {
    var activated = false;

    final result = await createAndActivateManagedProfile<int>(
      create: ({required requestStartIfNeeded}) async => null,
      activate: (_) async {
        activated = true;
      },
    );

    expect(result, isNull);
    expect(activated, false);
  });

  test('failed token revocation preserves the signed-in session', () async {
    final notifier = _DeleteNotifier(
      logoutError: const CloudApiException('Revocation failed'),
    );
    final container = ProviderContainer(
      overrides: [cloudAccountProvider.overrideWith(() => notifier)],
    );
    addTearDown(container.dispose);

    final success = await container
        .read(cloudAccountProvider.notifier)
        .signOut(revokeToken: true);
    final state = container.read(cloudAccountProvider);

    expect(success, false);
    expect(state.isLoggedIn, true);
    expect(state.isLoading, false);
    expect(state.error, 'Revocation failed');
    expect(notifier.didClearSession, false);
  });

  test('token revocation keeps the account busy until it completes', () async {
    final completer = Completer<void>();
    final notifier = _DeleteNotifier(logoutCompleter: completer);
    final container = ProviderContainer(
      overrides: [cloudAccountProvider.overrideWith(() => notifier)],
    );
    addTearDown(container.dispose);

    final signOut = container
        .read(cloudAccountProvider.notifier)
        .signOut(revokeToken: true);

    expect(container.read(cloudAccountProvider).isLoading, true);
    completer.complete();
    expect(await signOut, true);
    expect(notifier.didClearSession, true);
  });

  test('local cleanup failure is reported after signing out', () async {
    final notifier = _DeleteNotifier(cleanupError: 'Secure storage failed');
    final container = ProviderContainer(
      overrides: [cloudAccountProvider.overrideWith(() => notifier)],
    );
    addTearDown(container.dispose);

    final success = await container
        .read(cloudAccountProvider.notifier)
        .signOut();
    final state = container.read(cloudAccountProvider);

    expect(success, false);
    expect(state.isLoggedIn, false);
    expect(state.error, 'Secure storage failed');
  });

  test('sign out does not race an active managed profile sync', () async {
    final notifier = _DeleteNotifier(
      initialState: const CloudAccountState(isLoggedIn: true, isSyncing: true),
    );
    final container = ProviderContainer(
      overrides: [cloudAccountProvider.overrideWith(() => notifier)],
    );
    addTearDown(container.dispose);

    final success = await container
        .read(cloudAccountProvider.notifier)
        .signOut();

    expect(success, false);
    expect(notifier.didClearSession, false);
    expect(container.read(cloudAccountProvider).isLoggedIn, true);
  });

  test('unauthorized cleanup is not blocked by active sync state', () async {
    final notifier = _DeleteNotifier(
      initialState: const CloudAccountState(isLoggedIn: true, isSyncing: true),
    );
    final container = ProviderContainer(
      overrides: [cloudAccountProvider.overrideWith(() => notifier)],
    );
    addTearDown(container.dispose);

    await container.read(cloudAccountProvider.notifier).handleUnauthorized();

    expect(notifier.didClearSession, true);
    expect(container.read(cloudAccountProvider).isLoggedIn, false);
  });

  test('failed account deletion preserves the signed-in session', () async {
    final notifier = _DeleteNotifier(
      requestError: const CloudApiException('Incorrect password'),
    );
    final container = ProviderContainer(
      overrides: [cloudAccountProvider.overrideWith(() => notifier)],
    );
    addTearDown(container.dispose);

    final success = await container
        .read(cloudAccountProvider.notifier)
        .deleteAccount(password: 'wrong');
    final state = container.read(cloudAccountProvider);

    expect(success, false);
    expect(state.isLoggedIn, true);
    expect(state.isLoading, false);
    expect(state.error, 'Incorrect password');
    expect(notifier.didClearSession, false);
  });

  test('unauthorized account deletion clears the invalid session', () async {
    final notifier = _DeleteNotifier(
      requestError: const CloudApiException('Unauthorized'),
    );
    final container = ProviderContainer(
      overrides: [cloudAccountProvider.overrideWith(() => notifier)],
    );
    addTearDown(container.dispose);

    final success = await container
        .read(cloudAccountProvider.notifier)
        .deleteAccount(password: 'secret');
    final state = container.read(cloudAccountProvider);

    expect(success, false);
    expect(state.isLoggedIn, false);
    expect(state.isLoading, false);
    expect(state.error, 'Unauthorized');
    expect(notifier.didClearSession, true);
  });

  test('successful account deletion clears the local session', () async {
    final notifier = _DeleteNotifier();
    final container = ProviderContainer(
      overrides: [cloudAccountProvider.overrideWith(() => notifier)],
    );
    addTearDown(container.dispose);

    final success = await container
        .read(cloudAccountProvider.notifier)
        .deleteAccount(password: 'secret', twoFactorCode: '123456');

    expect(success, true);
    expect(container.read(cloudAccountProvider).isLoggedIn, false);
    expect(notifier.requestCount, 1);
    expect(notifier.didClearSession, true);
  });

  test('account deletion reports a local cleanup failure', () async {
    final notifier = _DeleteNotifier(cleanupError: 'Secure storage failed');
    final container = ProviderContainer(
      overrides: [cloudAccountProvider.overrideWith(() => notifier)],
    );
    addTearDown(container.dispose);

    final success = await container
        .read(cloudAccountProvider.notifier)
        .deleteAccount(password: 'secret');
    final state = container.read(cloudAccountProvider);

    expect(success, false);
    expect(state.isLoggedIn, false);
    expect(state.error, 'Secure storage failed');
    expect(notifier.didClearSession, true);
  });

  test('account deletion does not race an active refresh', () async {
    final notifier = _DeleteNotifier(
      initialState: const CloudAccountState(
        isLoggedIn: true,
        isRefreshing: true,
      ),
    );
    final container = ProviderContainer(
      overrides: [cloudAccountProvider.overrideWith(() => notifier)],
    );
    addTearDown(container.dispose);

    final success = await container
        .read(cloudAccountProvider.notifier)
        .deleteAccount(password: 'secret');

    expect(success, false);
    expect(notifier.requestCount, 0);
    expect(notifier.didClearSession, false);
  });

  test(
    'managed subscription refresh reloads the plan before syncing',
    () async {
      final notifier = _OrderNotifier();
      final container = ProviderContainer(
        overrides: [cloudAccountProvider.overrideWith(() => notifier)],
      );
      addTearDown(container.dispose);

      await container
          .read(cloudAccountProvider.notifier)
          .refreshManagedSubscription();

      expect(notifier.calls, ['refresh:true', 'sync']);
    },
  );

  test('a failed plan refresh never regenerates the subscription', () async {
    final notifier = _OrderNotifier(refreshError: 'Network unavailable');
    final container = ProviderContainer(
      overrides: [cloudAccountProvider.overrideWith(() => notifier)],
    );
    addTearDown(container.dispose);

    await container
        .read(cloudAccountProvider.notifier)
        .refreshManagedSubscription();

    expect(notifier.calls, ['refresh:true']);
    expect(container.read(cloudAccountProvider).error, 'Network unavailable');
  });
}

class _OrderNotifier extends CloudAccountNotifier {
  final String? refreshError;
  final calls = <String>[];

  _OrderNotifier({this.refreshError});

  @override
  CloudAccountState build() => const CloudAccountState(isLoggedIn: true);

  @override
  Future<void> refreshProfile({bool force = false}) async {
    calls.add('refresh:$force');
    if (refreshError != null) {
      state = state.copyWith(error: refreshError);
    }
  }

  @override
  Future<void> syncManagedConfig() async {
    calls.add('sync');
  }
}

class _UnauthorizedNotifier extends CloudAccountNotifier {
  final Future<void>? cleanup;
  final String? cleanupError;
  final Future<void> Function() showLogin;
  int cleanupCount = 0;

  _UnauthorizedNotifier({
    this.cleanup,
    this.cleanupError,
    required this.showLogin,
  });

  @override
  CloudAccountState build() => const CloudAccountState(isLoggedIn: true);

  @override
  Future<String?> clearSession() async {
    cleanupCount++;
    await cleanup;
    state = const CloudAccountState();
    return cleanupError;
  }

  @override
  Future<void> showUnauthorizedLogin() => showLogin();
}

class _InitializingNotifier extends CloudAccountNotifier {
  final Future<void> ready;

  _InitializingNotifier(this.ready);

  @override
  CloudAccountState build() => const CloudAccountState();

  @override
  Future<void> ensureReady() async {
    await ready;
    // An expired bootstrap token causes clearSession to reset the account.
    state = const CloudAccountState();
  }
}

class _SupersededSignInNotifier extends CloudAccountNotifier {
  @override
  CloudAccountState build() => const CloudAccountState();

  @override
  Future<void> ensureReady() async {
    state = const CloudAccountState(isLoggedIn: true);
    throw const CloudApiStaleSessionException();
  }
}

class _DeleteNotifier extends CloudAccountNotifier {
  final CloudAccountState initialState;
  final Object? requestError;
  final Object? logoutError;
  final Completer<void>? logoutCompleter;
  final String? cleanupError;
  var requestCount = 0;
  var didClearSession = false;

  _DeleteNotifier({
    this.initialState = const CloudAccountState(isLoggedIn: true),
    this.requestError,
    this.logoutError,
    this.logoutCompleter,
    this.cleanupError,
  });

  @override
  CloudAccountState build() => initialState;

  @override
  Future<void> Function({required String password, String? twoFactorCode})
  get deleteAccountRequest =>
      ({required String password, String? twoFactorCode}) async {
        requestCount++;
        if (requestError != null) throw requestError!;
      };

  @override
  Future<void> Function() get logoutRequest => () async {
    if (logoutError != null) throw logoutError!;
    await logoutCompleter?.future;
  };

  @override
  Future<String?> clearSession() async {
    didClearSession = true;
    state = const CloudAccountState();
    return cleanupError;
  }
}

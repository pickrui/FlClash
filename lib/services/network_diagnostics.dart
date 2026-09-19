import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/http.dart';
import 'package:fl_clash/core/controller.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'network_diagnostic_platform.dart';

enum DiagnosticStatus { passed, warning, failed, unknown, skipped }

/// A repair the app can perform itself for a failed check. The page maps each
/// value to an existing app action and re-runs the self-check afterwards.
enum DiagnosticFix {
  /// Load the selected profile into the core (and start when stopped).
  applyProfile,

  /// Start traffic forwarding through the normal connection switch path.
  startConnection,

  /// Restart an unresponsive core and reapply the current state.
  restartCore,

  /// Restart the core and reopen listeners; port conflicts prompt for a port.
  restartConnection,

  /// Rewrite the OS proxy settings to the expected local port.
  applySystemProxy,

  /// Turn the system proxy on when nothing captures traffic.
  enableSystemProxy,

  /// Restart with TUN so the interface is created and authorized again.
  applyTun,

  /// Re-run the delay test of the current group so a working node is chosen.
  retestProxies,
}

class NetworkDiagnosticCheck {
  final String id;
  final String title;
  final DiagnosticStatus status;
  final String detail;
  final String? suggestion;
  final DiagnosticFix? fix;
  const NetworkDiagnosticCheck(
    this.id,
    this.title,
    this.status,
    this.detail, [
    this.suggestion,
    this.fix,
  ]);
}

class NetworkDiagnosticSnapshot {
  final bool profileApplied, running, suspended, systemProxy, tun, oixCloud;
  final int port;

  /// Whether a profile is selected at all. Applying a profile can only be
  /// offered as a fix when one exists.
  final bool profileSelected;

  /// Proxy authentication disables the system proxy, so enabling it cannot
  /// be offered as a fix.
  final bool authenticated;
  const NetworkDiagnosticSnapshot({
    required this.profileApplied,
    required this.profileSelected,
    required this.running,
    required this.suspended,
    required this.systemProxy,
    required this.tun,
    required this.oixCloud,
    required this.port,
    this.authenticated = false,
  });
}

class DiagnosticWebResult {
  final int passed;
  final List<String> errors;
  final List<Duration> clockOffsets;
  const DiagnosticWebResult(
    this.passed,
    this.errors, [
    this.clockOffsets = const [],
  ]);
}

class DiagnosticDnsResult {
  final int passed;
  final List<String> errors;
  const DiagnosticDnsResult(this.passed, [this.errors = const []]);
}

abstract class NetworkDiagnosticBackend {
  Future<Map<String, dynamic>> core(CancelToken token);
  Future<bool> listener(int port, CancelToken token);
  Future<DiagnosticSystemState> system(
    int port,
    String? device,
    CancelToken token,
  );
  Future<DiagnosticDnsResult> dns(CancelToken token);
  Future<DiagnosticWebResult> web(int? proxyPort, CancelToken token);
}

class LiveNetworkDiagnosticBackend implements NetworkDiagnosticBackend {
  final NetworkDiagnosticPlatform platform;
  LiveNetworkDiagnosticBackend({NetworkDiagnosticPlatform? platform})
    : platform = platform ?? NetworkDiagnosticPlatform();
  @override
  Future<Map<String, dynamic>> core(CancelToken token) =>
      coreController.getNetworkDiagnostics();
  @override
  Future<DiagnosticSystemState> system(
    int port,
    String? device,
    CancelToken token,
  ) => platform.inspect(port, device, token);
  @override
  Future<bool> listener(int port, CancelToken token) async {
    if (port <= 0 || port > 65535 || token.isCancelled) return false;
    Socket? socket;
    StreamSubscription<DioException>? cancellation;
    try {
      socket = await Socket.connect(
        InternetAddress.loopbackIPv4,
        port,
        timeout: const Duration(seconds: 2),
      );
      if (token.isCancelled) return false;
      cancellation = token.whenCancel.asStream().listen(
        (_) => socket?.destroy(),
      );
      // Offer both methods so an authenticated mixed port is recognized too.
      socket.add(const [5, 2, 0, 2]);
      final response = await socket
          .expand<int>((Uint8List data) => data)
          .take(2)
          .timeout(const Duration(seconds: 2))
          .toList();
      return response.length == 2 &&
          response[0] == 5 &&
          (response[1] == 0 || response[1] == 2);
    } catch (_) {
      return false;
    } finally {
      socket?.destroy();
      await cancellation?.cancel();
    }
  }

  @override
  Future<DiagnosticDnsResult> dns(CancelToken token) async {
    final errors = <String>[];
    final results = await Future.wait(
      ['www.cloudflare.com', 'www.gstatic.com'].map((host) async {
        if (token.isCancelled) return false;
        try {
          return (await InternetAddress.lookup(
            host,
          ).timeout(const Duration(seconds: 4))).isNotEmpty;
        } catch (error) {
          if (!token.isCancelled) errors.add(CloudApiException.clean(error));
          return false;
        }
      }),
    );
    return DiagnosticDnsResult(
      results.where((result) => result).length,
      errors,
    );
  }

  @override
  Future<DiagnosticWebResult> web(int? proxyPort, CancelToken token) async {
    final route = proxyPort == null ? 'DIRECT' : 'PROXY localhost:$proxyPort';
    final dio =
        Dio(
            BaseOptions(
              connectTimeout: const Duration(seconds: 4),
              receiveTimeout: const Duration(seconds: 4),
              followRedirects: false,
              validateStatus: (_) => true,
              responseType: ResponseType.stream,
              headers: {'User-Agent': 'FlClash network diagnostics'},
            ),
          )
          ..httpClientAdapter = createFlClashHttpClientAdapter(
            findProxy: (_) => route,
          );
    final cancellation = token.whenCancel.asStream().listen(
      (_) => dio.close(force: true),
    );
    var passed = 0;
    final errors = <String>[];
    final offsets = <Duration>[];
    try {
      await Future.wait(
        [
          'https://cp.cloudflare.com/generate_204',
          'https://www.gstatic.com/generate_204',
        ].map((url) async {
          try {
            final response = await dio
                .get<ResponseBody>(url, cancelToken: token)
                .timeout(const Duration(seconds: 6));
            await response.data?.stream.listen(null).cancel();
            if (response.statusCode == 204) {
              passed++;
              final date = response.headers.value('date');
              final age =
                  int.tryParse(response.headers.value('age') ?? '0') ?? 1;
              if (date != null && age == 0) {
                try {
                  offsets.add(
                    HttpDate.parse(date).difference(DateTime.now().toUtc()),
                  );
                } catch (_) {}
              }
            } else {
              errors.add(
                AppLocalizations.current.cloudApiHttpError(
                  response.statusCode ?? '?',
                ),
              );
            }
          } catch (error) {
            if (!token.isCancelled) errors.add(CloudApiException.clean(error));
          }
        }),
      );
      return DiagnosticWebResult(passed, errors, offsets);
    } finally {
      dio.close(force: true);
      await cancellation.cancel();
    }
  }
}

class NetworkDiagnosticService {
  final NetworkDiagnosticBackend backend;
  NetworkDiagnosticService({NetworkDiagnosticBackend? backend})
    : backend = backend ?? LiveNetworkDiagnosticBackend();

  Future<List<NetworkDiagnosticCheck>> run(
    NetworkDiagnosticSnapshot state,
    CancelToken token, {
    required void Function(NetworkDiagnosticCheck) onResult,
  }) async {
    final l = AppLocalizations.current;
    final results = <NetworkDiagnosticCheck>[];
    if (token.isCancelled) return results;
    void emit(NetworkDiagnosticCheck check) {
      if (!token.isCancelled) {
        results.add(check);
        onResult(check);
      }
    }

    emit(
      NetworkDiagnosticCheck(
        'profile',
        l.diagProfile,
        state.profileApplied
            ? DiagnosticStatus.passed
            : DiagnosticStatus.failed,
        state.profileApplied ? l.diagProfileReady : l.diagProfileMissing,
        state.profileApplied ? null : l.diagProfileHint,
        !state.profileApplied && state.profileSelected
            ? DiagnosticFix.applyProfile
            : null,
      ),
    );
    Map<String, dynamic>? core;
    try {
      core = await Future.any<Map<String, dynamic>>([
        backend.core(token).timeout(const Duration(seconds: 9)),
        token.whenCancel.then((_) => <String, dynamic>{}),
      ]);
    } catch (_) {}
    if (token.isCancelled) return results;
    final validCore =
        core != null &&
        core['stale'] != true &&
        core['busy'] != true &&
        core['configured'] is bool &&
        core['running'] is bool;
    emit(
      NetworkDiagnosticCheck(
        'core',
        l.diagCore,
        !validCore
            ? DiagnosticStatus.unknown
            : core['running'] == true &&
                  core['configured'] == true &&
                  !state.suspended
            ? DiagnosticStatus.passed
            : DiagnosticStatus.failed,
        !validCore
            ? l.diagCoreUnknown
            : state.suspended
            ? l.diagSuspended
            : core['configured'] != true
            ? l.diagProfileMissing
            : core['running'] == true
            ? l.diagCoreReady
            : l.diagCoreStopped,
        !validCore ||
                core['running'] != true ||
                core['configured'] != true ||
                state.suspended
            ? l.diagCoreHint
            : null,
        !validCore
            // Only a core that did not answer at all warrants a restart; a
            // busy or stale reply is transient and often caused by re-running.
            ? (core == null ? DiagnosticFix.restartCore : null)
            // A Wi-Fi exclusion is a deliberate setting, not a fault.
            : state.suspended
            ? null
            : core['configured'] != true
            ? (state.profileSelected ? DiagnosticFix.applyProfile : null)
            : core['running'] != true
            ? DiagnosticFix.startConnection
            : null,
      ),
    );
    final coreRunning = validCore && core['running'] == true;
    final coreStopped = validCore && core['running'] != true;
    // A stopped connection only needs starting, and never while a Wi-Fi
    // exclusion suspends forwarding on purpose.
    final DiagnosticFix? startFix = state.suspended || !coreStopped
        ? null
        : DiagnosticFix.startConnection;
    final localReady = await backend.listener(state.port, token);
    if (token.isCancelled) return results;
    final portMatches = !validCore || core['mixedPort'] == state.port;
    emit(
      NetworkDiagnosticCheck(
        'listener',
        l.diagListener,
        localReady && portMatches
            ? DiagnosticStatus.passed
            : DiagnosticStatus.failed,
        localReady && portMatches ? l.diagListenerReady : l.diagListenerFailed,
        localReady && portMatches ? null : l.diagListenerHint,
        localReady && portMatches
            ? null
            // Reopening listeners (which offers a new port on conflict) only
            // helps a running core; an unknown core reply gets no fix here.
            : coreRunning && !state.suspended
            ? DiagnosticFix.restartConnection
            : startFix,
      ),
    );
    final os = await backend.system(
      state.port,
      validCore && state.tun && core['tunDevice'] is String
          ? core['tunDevice'] as String
          : null,
      token,
    );
    if (token.isCancelled) return results;
    final proxy = os.proxy;
    emit(
      NetworkDiagnosticCheck(
        'systemProxy',
        l.diagSystemProxy,
        !state.systemProxy
            ? DiagnosticStatus.skipped
            : proxy == DiagnosticProxyState.matching
            ? DiagnosticStatus.passed
            : proxy == DiagnosticProxyState.unknown
            ? DiagnosticStatus.unknown
            : DiagnosticStatus.warning,
        !state.systemProxy
            ? l.diagDisabled
            : switch (proxy) {
                DiagnosticProxyState.matching => l.diagProxyReady,
                DiagnosticProxyState.disabled => l.diagProxyDisabled,
                DiagnosticProxyState.different => l.diagProxyDifferent,
                DiagnosticProxyState.automatic => l.diagProxyAutomatic,
                DiagnosticProxyState.unknown => l.diagUnknown,
              },
        state.systemProxy && proxy != DiagnosticProxyState.matching
            ? l.diagProxyHint
            : null,
        // A PAC or unknown state may be an organization policy; only rewrite
        // settings the app itself is expected to own, and only while the
        // connection runs (the app removes the OS proxy when stopped).
        state.systemProxy &&
                (proxy == DiagnosticProxyState.disabled ||
                    proxy == DiagnosticProxyState.different)
            ? (state.running && !state.suspended
                  ? DiagnosticFix.applySystemProxy
                  : startFix)
            : null,
      ),
    );
    emit(
      NetworkDiagnosticCheck(
        'tun',
        l.diagTun,
        !state.tun
            ? DiagnosticStatus.skipped
            : !validCore
            ? DiagnosticStatus.unknown
            : core['tunInterfaceUp'] != true
            ? DiagnosticStatus.failed
            : os.tunRoute == true
            ? DiagnosticStatus.passed
            : DiagnosticStatus.warning,
        !state.tun
            ? l.diagDisabled
            : !validCore
            ? l.diagUnknown
            : core['tunInterfaceUp'] != true
            ? l.diagTunMissing
            : os.tunRoute == true
            ? l.diagTunReady
            : os.tunRoute == false
            ? l.diagTunRouteMismatch
            : l.diagTunRouteUnknown,
        state.tun && (core?['tunInterfaceUp'] != true || os.tunRoute != true)
            ? l.diagTunHint
            : null,
        // A route through another interface points at a competing VPN, which
        // restarting cannot resolve. A stopped connection has no interface
        // yet; starting it is the lighter fix.
        state.tun && validCore && core['tunInterfaceUp'] != true
            ? (coreRunning && !state.suspended
                  ? DiagnosticFix.applyTun
                  : startFix)
            : null,
      ),
    );
    if (!state.systemProxy && !state.tun) {
      emit(
        NetworkDiagnosticCheck(
          'capture',
          l.diagTrafficCapture,
          DiagnosticStatus.warning,
          l.diagNoCapture,
          l.diagCaptureHint,
          state.authenticated ? null : DiagnosticFix.enableSystemProxy,
        ),
      );
    }
    NetworkDiagnosticCheck dnsCheck(
      String id,
      String title,
      dynamic data, {
      bool managed = false,
    }) {
      final status = data is Map ? data['status'] : null;
      final hint = managed ? l.diagOixDnsHint : l.diagDnsHint;
      return NetworkDiagnosticCheck(
        id,
        title,
        switch (status) {
          'ok' => DiagnosticStatus.passed,
          'partial' => DiagnosticStatus.warning,
          'not_applicable' => DiagnosticStatus.skipped,
          'auth_unavailable' ||
          'timeout' ||
          'certificate' ||
          'no_answer' ||
          'refused' ||
          'failed' => DiagnosticStatus.failed,
          _ => DiagnosticStatus.unknown,
        },
        switch (status) {
          'ok' => l.diagDnsReady,
          'partial' => l.diagDnsPartial,
          'not_applicable' => l.diagOixDnsNoSample,
          'auth_unavailable' => l.diagOixDnsAuthMissing,
          'timeout' => l.cloudApiConnectTimeout,
          'certificate' => l.invalidCertificateTitle,
          'no_answer' => l.diagDnsNoAnswer,
          'refused' => l.diagDnsRefused,
          'failed' => l.cloudApiDnsFailed,
          _ => l.diagUnknown,
        },
        status == 'ok' || status == 'not_applicable' ? null : hint,
      );
    }

    emit(dnsCheck('coreDns', l.diagCoreDns, validCore ? core['dns'] : null));
    if (state.oixCloud ||
        (validCore &&
            core['oixDns'] is Map &&
            core['oixDns']['status'] != 'not_applicable')) {
      emit(
        dnsCheck(
          'oixDns',
          l.diagOixDns,
          validCore ? core['oixDns'] : null,
          managed: true,
        ),
      );
      if (validCore &&
          core['dnsAuthReady'] == false &&
          state.oixCloud &&
          (core['oixDns'] is! Map ||
              core['oixDns']['status'] != 'auth_unavailable')) {
        emit(
          NetworkDiagnosticCheck(
            'dnsSigning',
            l.diagOixDns,
            DiagnosticStatus.warning,
            l.diagOixDnsAuthMissing,
            l.diagOixDnsHint,
          ),
        );
      }
    }
    DiagnosticWebResult? systemWeb, proxyWeb;
    await Future.wait([
      () async {
        final resolved = await backend.dns(token);
        emit(
          NetworkDiagnosticCheck(
            'systemDns',
            l.diagSystemDns,
            resolved.passed == 2
                ? DiagnosticStatus.passed
                : DiagnosticStatus.warning,
            [
              resolved.passed == 2
                  ? l.diagDnsReady
                  : resolved.passed == 1
                  ? l.diagDnsPartial
                  : l.cloudApiDnsFailed,
              ...resolved.errors.toSet(),
            ].join('\n'),
            resolved.passed == 2 ? null : l.diagDnsHint,
          ),
        );
      }(),
      () async {
        systemWeb = await backend.web(null, token);
        emit(
          _webCheck(
            'systemPath',
            l.diagSystemPath,
            systemWeb!,
            l.diagSystemPathHint,
          ),
        );
      }(),
      () async {
        if (!localReady || !portMatches) {
          emit(
            NetworkDiagnosticCheck(
              'proxyPath',
              l.diagProxyPath,
              DiagnosticStatus.skipped,
              l.diagListenerFailed,
            ),
          );
          return;
        }
        proxyWeb = await backend.web(state.port, token);
        emit(
          _webCheck(
            'proxyPath',
            l.diagProxyPath,
            proxyWeb!,
            l.diagProxyPathHint,
            fix: DiagnosticFix.retestProxies,
          ),
        );
      }(),
    ]);
    if (token.isCancelled) return results;
    // Require two independent, uncached HTTPS responses from one path. One
    // cached Date header cannot diagnose the system clock or a DNS signature.
    final offsets =
        (proxyWeb?.clockOffsets.length == 2 ? proxyWeb : systemWeb)
            ?.clockOffsets ??
        [];
    final skewed =
        offsets.length == 2 &&
        offsets.every((o) => o.inMinutes.abs() >= 5) &&
        offsets[0].isNegative == offsets[1].isNegative;
    emit(
      NetworkDiagnosticCheck(
        'clock',
        l.diagClock,
        offsets.length != 2
            ? DiagnosticStatus.unknown
            : skewed
            ? DiagnosticStatus.warning
            : DiagnosticStatus.passed,
        offsets.length != 2
            ? l.diagClockUnknown
            : skewed
            ? l.diagClockSkew
            : l.diagClockReady,
        skewed ? l.diagClockHint : null,
      ),
    );
    return results;
  }

  NetworkDiagnosticCheck _webCheck(
    String id,
    String title,
    DiagnosticWebResult result,
    String hint, {
    DiagnosticFix? fix,
  }) {
    final l = AppLocalizations.current;
    return NetworkDiagnosticCheck(
      id,
      title,
      result.passed == 2
          ? DiagnosticStatus.passed
          : result.passed == 1
          ? DiagnosticStatus.warning
          : DiagnosticStatus.failed,
      '${l.diagWebResult(result.passed)}${result.errors.isEmpty ? '' : '\n${result.errors.toSet().join('\n')}'}',
      result.passed == 2 ? null : hint,
      result.passed == 2 ? null : fix,
    );
  }
}

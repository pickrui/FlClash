import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/services/network_diagnostic_platform.dart';
import 'package:fl_clash/services/network_diagnostics.dart';
import 'package:flutter/widgets.dart' show Locale;
import 'package:flutter_test/flutter_test.dart';

const snapshot = NetworkDiagnosticSnapshot(
  profileApplied: true,
  profileSelected: true,
  running: true,
  suspended: false,
  systemProxy: true,
  tun: true,
  oixCloud: true,
  port: 7890,
);

class FakeBackend implements NetworkDiagnosticBackend {
  final state = <String, dynamic>{
    'configured': true,
    'running': true,
    'mixedPort': 7890,
    'tunDevice': 'fixture-tun',
    'tunInterfaceUp': true,
    'dnsAuthReady': true,
    'dns': {'status': 'ok'},
    'oixDns': {'status': 'ok'},
  };
  bool listening = true, throwCore = false;
  DiagnosticSystemState os = const DiagnosticSystemState(
    proxy: DiagnosticProxyState.matching,
    tunRoute: true,
  );
  DiagnosticDnsResult dnsResult = const DiagnosticDnsResult(2);
  DiagnosticWebResult systemWeb = const DiagnosticWebResult(2, [], [
    Duration.zero,
    Duration.zero,
  ]);
  DiagnosticWebResult proxyWeb = const DiagnosticWebResult(2, [], [
    Duration.zero,
    Duration.zero,
  ]);
  final webPorts = <int?>[];
  Completer<Map<String, dynamic>>? pendingCore;
  int calls = 0;
  @override
  Future<Map<String, dynamic>> core(CancelToken token) async {
    calls++;
    if (throwCore) throw StateError('secret raw IPC error');
    return pendingCore?.future ?? state;
  }

  @override
  Future<bool> listener(int port, CancelToken token) async {
    calls++;
    return listening;
  }

  @override
  Future<DiagnosticSystemState> system(
    int port,
    String? device,
    CancelToken token,
  ) async {
    calls++;
    return os;
  }

  @override
  Future<DiagnosticDnsResult> dns(CancelToken token) async {
    calls++;
    return dnsResult;
  }

  @override
  Future<DiagnosticWebResult> web(int? proxyPort, CancelToken token) async {
    calls++;
    webPorts.add(proxyPort);
    return proxyPort == null ? systemWeb : proxyWeb;
  }
}

void main() {
  setUpAll(() => AppLocalizations.load(const Locale('en')));
  Future<Map<String, NetworkDiagnosticCheck>> run(
    FakeBackend backend, {
    NetworkDiagnosticSnapshot input = snapshot,
  }) async {
    final checks = await NetworkDiagnosticService(
      backend: backend,
    ).run(input, CancelToken(), onResult: (_) {});
    return {for (final check in checks) check.id: check};
  }

  NetworkDiagnosticSnapshot snap({
    bool profileApplied = true,
    bool profileSelected = true,
    bool running = true,
    bool suspended = false,
    bool systemProxy = true,
    bool tun = true,
    bool authenticated = false,
  }) => NetworkDiagnosticSnapshot(
    profileApplied: profileApplied,
    profileSelected: profileSelected,
    running: running,
    suspended: suspended,
    systemProxy: systemProxy,
    tun: tun,
    oixCloud: true,
    port: 7890,
    authenticated: authenticated,
  );

  test('healthy evidence passes each applicable layer', () async {
    final checks = await run(FakeBackend());
    expect(
      checks.keys,
      containsAll([
        'profile',
        'core',
        'listener',
        'systemProxy',
        'tun',
        'systemDns',
        'coreDns',
        'oixDns',
        'systemPath',
        'proxyPath',
        'clock',
      ]),
    );
    expect(
      checks.values.every((check) => check.status == DiagnosticStatus.passed),
      isTrue,
    );
    expect(checks.values.every((check) => check.fix == null), isTrue);
  });
  test(
    'an unapplied profile offers loading it only when one is selected',
    () async {
      var checks = await run(FakeBackend(), input: snap(profileApplied: false));
      expect(checks['profile']!.status, DiagnosticStatus.failed);
      expect(checks['profile']!.fix, DiagnosticFix.applyProfile);
      checks = await run(
        FakeBackend(),
        input: snap(profileApplied: false, profileSelected: false),
      );
      expect(checks['profile']!.fix, isNull);
      checks = await run(
        FakeBackend()..state['configured'] = false,
        input: snap(),
      );
      expect(checks['core']!.fix, DiagnosticFix.applyProfile);
      checks = await run(
        FakeBackend()..state['configured'] = false,
        input: snap(profileSelected: false),
      );
      expect(checks['core']!.fix, isNull);
    },
  );
  test('core fixes distinguish stopped, unresponsive and suspended', () async {
    var checks = await run(FakeBackend()..state['running'] = false);
    expect(checks['core']!.fix, DiagnosticFix.startConnection);
    checks = await run(FakeBackend()..throwCore = true);
    expect(checks['core']!.fix, DiagnosticFix.restartCore);
    checks = await run(FakeBackend(), input: snap(suspended: true));
    expect(checks['core']!.status, DiagnosticStatus.failed);
    expect(checks['core']!.fix, isNull);
  });
  test(
    'a busy or stale core reply never offers a disruptive restart',
    () async {
      for (final key in ['busy', 'stale']) {
        final checks = await run(
          FakeBackend()
            ..state[key] = true
            ..listening = false,
        );
        expect(checks['core']!.fix, isNull, reason: key);
        expect(checks['listener']!.fix, isNull, reason: key);
        expect(checks['tun']!.fix, isNull, reason: key);
      }
    },
  );
  test('listener fixes start a stopped core or reconnect otherwise', () async {
    var checks = await run(
      FakeBackend()
        ..listening = false
        ..state['running'] = false,
    );
    expect(checks['listener']!.fix, DiagnosticFix.startConnection);
    checks = await run(FakeBackend()..state['mixedPort'] = 7891);
    expect(checks['listener']!.fix, DiagnosticFix.restartConnection);
    checks = await run(
      FakeBackend()
        ..listening = false
        ..throwCore = true,
    );
    expect(checks['listener']!.fix, isNull);
    checks = await run(
      FakeBackend()..listening = false,
      input: snap(suspended: true),
    );
    expect(checks['listener']!.fix, isNull);
  });
  test(
    'a stopped connection is started instead of rewriting the OS proxy',
    () async {
      final backend = FakeBackend()
        ..state['running'] = false
        ..os = const DiagnosticSystemState(
          proxy: DiagnosticProxyState.disabled,
          tunRoute: true,
        );
      var checks = await run(backend, input: snap(running: false));
      expect(checks['systemProxy']!.fix, DiagnosticFix.startConnection);
      checks = await run(backend, input: snap(running: false, suspended: true));
      expect(checks['systemProxy']!.fix, isNull);
    },
  );
  test('only app-owned OS proxy states are rewritten by a fix', () async {
    for (final proxy in [
      DiagnosticProxyState.disabled,
      DiagnosticProxyState.different,
    ]) {
      final checks = await run(
        FakeBackend()..os = DiagnosticSystemState(proxy: proxy, tunRoute: true),
      );
      expect(checks['systemProxy']!.fix, DiagnosticFix.applySystemProxy);
    }
    for (final proxy in [
      DiagnosticProxyState.automatic,
      DiagnosticProxyState.unknown,
    ]) {
      final checks = await run(
        FakeBackend()..os = DiagnosticSystemState(proxy: proxy, tunRoute: true),
      );
      expect(checks['systemProxy']!.fix, isNull, reason: proxy.name);
    }
  });
  test(
    'a missing TUN interface is re-applied; a foreign route is not',
    () async {
      var checks = await run(FakeBackend()..state['tunInterfaceUp'] = false);
      expect(checks['tun']!.fix, DiagnosticFix.applyTun);
      checks = await run(
        FakeBackend()
          ..state['tunInterfaceUp'] = false
          ..state['running'] = false,
        input: snap(running: false),
      );
      expect(checks['tun']!.fix, DiagnosticFix.startConnection);
      checks = await run(
        FakeBackend()..os = const DiagnosticSystemState(tunRoute: false),
      );
      expect(checks['tun']!.fix, isNull);
      checks = await run(FakeBackend()..throwCore = true);
      expect(checks['tun']!.fix, isNull);
    },
  );
  test('no capture method offers enabling the system proxy', () async {
    var checks = await run(
      FakeBackend(),
      input: snap(systemProxy: false, tun: false),
    );
    expect(checks['capture']!.fix, DiagnosticFix.enableSystemProxy);
    checks = await run(
      FakeBackend(),
      input: snap(systemProxy: false, tun: false, authenticated: true),
    );
    expect(checks['capture']!.fix, isNull);
  });
  test('a failing local proxy path offers retesting nodes', () async {
    var checks = await run(
      FakeBackend()..proxyWeb = const DiagnosticWebResult(0, ['timeout']),
    );
    expect(checks['proxyPath']!.fix, DiagnosticFix.retestProxies);
    expect(checks['systemPath']!.fix, isNull);
    checks = await run(
      FakeBackend()..systemWeb = const DiagnosticWebResult(0, ['timeout']),
    );
    expect(checks['proxyPath']!.fix, isNull);
    checks = await run(FakeBackend()..listening = false);
    expect(checks['proxyPath']!.status, DiagnosticStatus.skipped);
    expect(checks['proxyPath']!.fix, isNull);
  });
  test(
    'a mismatched core port prevents testing the wrong local proxy',
    () async {
      final backend = FakeBackend()..state['mixedPort'] = 7891;
      final checks = await run(backend);
      expect(checks['listener']!.status, DiagnosticStatus.failed);
      expect(checks['proxyPath']!.status, DiagnosticStatus.skipped);
      expect(backend.webPorts, [null]);
    },
  );
  test('a missing local listener skips proxy requests', () async {
    final backend = FakeBackend()..listening = false;
    final checks = await run(backend);
    expect(checks['listener']!.status, DiagnosticStatus.failed);
    expect(backend.webPorts, [null]);
  });
  test('unknown core data never certifies TUN or core DNS', () async {
    for (final backend in [
      FakeBackend()..throwCore = true,
      FakeBackend()..state['stale'] = true,
      FakeBackend()..state['busy'] = true,
    ]) {
      final checks = await run(backend);
      for (final id in ['core', 'tun', 'coreDns', 'oixDns']) {
        expect(checks[id]!.status, DiagnosticStatus.unknown, reason: id);
      }
      expect(
        checks.values.map((c) => c.detail).join(),
        isNot(contains('secret')),
      );
    }
  });
  test('responsive but unconfigured or stopped core fails', () async {
    for (final key in ['configured', 'running']) {
      final checks = await run(FakeBackend()..state[key] = false);
      expect(checks['core']!.status, DiagnosticStatus.failed);
    }
  });
  test('OS proxy disagreement provides an actionable warning', () async {
    for (final proxy in [
      DiagnosticProxyState.different,
      DiagnosticProxyState.disabled,
      DiagnosticProxyState.automatic,
    ]) {
      final checks = await run(
        FakeBackend()..os = DiagnosticSystemState(proxy: proxy, tunRoute: true),
      );
      expect(checks['systemProxy']!.status, DiagnosticStatus.warning);
      expect(checks['systemProxy']!.suggestion, isNotEmpty);
    }
  });
  test(
    'TUN existence route mismatch and unavailable route stay distinct',
    () async {
      var checks = await run(FakeBackend()..state['tunInterfaceUp'] = false);
      expect(checks['tun']!.status, DiagnosticStatus.failed);
      checks = await run(
        FakeBackend()..os = const DiagnosticSystemState(tunRoute: false),
      );
      expect(checks['tun']!.status, DiagnosticStatus.warning);
      final mismatch = checks['tun']!.detail;
      checks = await run(FakeBackend()..os = const DiagnosticSystemState());
      expect(checks['tun']!.status, DiagnosticStatus.warning);
      expect(checks['tun']!.detail, isNot(mismatch));
    },
  );
  test(
    'disabled capture methods are skipped with a manual application hint',
    () async {
      final checks = await run(
        FakeBackend(),
        input: const NetworkDiagnosticSnapshot(
          profileApplied: true,
          profileSelected: true,
          running: true,
          suspended: false,
          systemProxy: false,
          tun: false,
          oixCloud: false,
          port: 7890,
        ),
      );
      expect(checks['systemProxy']!.status, DiagnosticStatus.skipped);
      expect(checks['tun']!.status, DiagnosticStatus.skipped);
      expect(checks['capture']!.status, DiagnosticStatus.warning);
    },
  );
  test('an unrecognized DNS result remains unknown', () async {
    final checks = await run(
      FakeBackend()..state['oixDns'] = {'status': 'future_status'},
    );
    expect(checks['oixDns']!.status, DiagnosticStatus.unknown);
    expect(checks['oixDns']!.detail, AppLocalizations.current.diagUnknown);
  });
  test('managed DNS failures remain distinct from general DNS', () async {
    final checks = await run(
      FakeBackend()..state['oixDns'] = {'status': 'no_answer'},
    );
    expect(checks['coreDns']!.status, DiagnosticStatus.passed);
    expect(checks['oixDns']!.status, DiagnosticStatus.failed);
    expect(checks['oixDns']!.detail, AppLocalizations.current.diagDnsNoAnswer);
    expect(checks['oixDns']!.suggestion, isNotEmpty);
  });
  test(
    'missing signatures with no managed DNS sample are not a false DNS failure',
    () async {
      final checks = await run(
        FakeBackend()
          ..state['dnsAuthReady'] = false
          ..state['oixDns'] = {'status': 'not_applicable'},
      );
      expect(checks['oixDns']!.status, DiagnosticStatus.skipped);
      expect(checks['dnsSigning']!.status, DiagnosticStatus.warning);
    },
  );
  test(
    'partial DNS resolution is a warning and retains a safe error code',
    () async {
      final checks = await run(
        FakeBackend()
          ..dnsResult = const DiagnosticDnsResult(1, [
            'DNS lookup failed (System error 11001)',
          ])
          ..state['dns'] = {'status': 'partial'},
      );
      expect(checks['systemDns']!.status, DiagnosticStatus.warning);
      expect(checks['systemDns']!.detail, contains('11001'));
      expect(checks['coreDns']!.status, DiagnosticStatus.warning);
    },
  );
  test(
    'two independent HTTPS results distinguish partial connectivity',
    () async {
      final checks = await run(
        FakeBackend()
          ..proxyWeb = const DiagnosticWebResult(1, ['TLS handshake failed']),
      );
      expect(checks['proxyPath']!.status, DiagnosticStatus.warning);
      expect(checks['systemPath']!.status, DiagnosticStatus.passed);
      expect(checks['proxyPath']!.detail, contains('TLS handshake failed'));
    },
  );
  test(
    'clock warning requires two independent offsets from one path',
    () async {
      final backend = FakeBackend()
        ..proxyWeb = const DiagnosticWebResult(2, [], [
          Duration(minutes: 8),
          Duration(minutes: 9),
        ]);
      var checks = await run(backend);
      expect(checks['clock']!.status, DiagnosticStatus.warning);
      backend.proxyWeb = const DiagnosticWebResult(1, [], [
        Duration(minutes: 8),
      ]);
      backend.systemWeb = const DiagnosticWebResult(1, [], [
        Duration(minutes: 9),
      ]);
      checks = await run(backend);
      expect(checks['clock']!.status, DiagnosticStatus.unknown);
    },
  );
  test(
    'missing signatures are reported once and missing fields stay unknown',
    () async {
      final backend = FakeBackend()
        ..state['dnsAuthReady'] = false
        ..state['oixDns'] = {'status': 'auth_unavailable'};
      var checks = await run(backend);
      expect(checks['oixDns']!.status, DiagnosticStatus.failed);
      expect(checks.containsKey('dnsSigning'), isFalse);
      backend.state.remove('dnsAuthReady');
      backend.state.remove('oixDns');
      checks = await run(backend);
      expect(checks['oixDns']!.status, DiagnosticStatus.unknown);
      expect(checks.containsKey('dnsSigning'), isFalse);
    },
  );
  test('cancel does not wait for a stalled core response', () async {
    final backend = FakeBackend()..pendingCore = Completer();
    final token = CancelToken();
    final result = NetworkDiagnosticService(
      backend: backend,
    ).run(snapshot, token, onResult: (_) {});
    token.cancel();
    await result.timeout(const Duration(milliseconds: 100));
    expect(backend.calls, 1);
    backend.pendingCore!.complete(backend.state);
  });
  test('cancel before starting makes no probes', () async {
    final backend = FakeBackend();
    final result = await NetworkDiagnosticService(backend: backend).run(
      snapshot,
      CancelToken()..cancel(),
      onResult: (_) => fail('late result'),
    );
    expect(result, isEmpty);
    expect(backend.calls, 0);
  });
  test(
    'cancel during core request prevents subsequent probes or late results',
    () async {
      final backend = FakeBackend()..pendingCore = Completer();
      final token = CancelToken();
      final emitted = <String>[];
      final future = NetworkDiagnosticService(
        backend: backend,
      ).run(snapshot, token, onResult: (check) => emitted.add(check.id));
      token.cancel();
      backend.pendingCore!.complete(backend.state);
      await future;
      expect(emitted, ['profile']);
      expect(backend.calls, 1);
    },
  );
  test(
    'listener checks proxy protocol instead of merely an open port',
    () async {
      for (final reply in [
        [5, 0],
        [5, 2],
        [5, 255],
        [72, 84],
      ]) {
        final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
        final subscription = server.listen((socket) {
          socket.listen((_) {
            socket.add(reply);
            socket.close();
          });
        });
        try {
          final result = await LiveNetworkDiagnosticBackend().listener(
            server.port,
            CancelToken(),
          );
          expect(result, reply[0] == 5 && reply[1] != 255);
        } finally {
          await subscription.cancel();
          await server.close();
        }
      }
    },
  );
}

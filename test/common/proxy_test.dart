import 'dart:async';
import 'dart:io';

import 'package:fl_clash/common/proxy.dart';
import 'package:test/test.dart';

void main() {
  test('recognizes a local SOCKS5 listener as ready', () async {
    final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
    final sockets = <Socket>[];
    final subscription = server.listen((socket) {
      sockets.add(socket);
      socket.listen((_) => socket.add(const [0x05, 0x00]));
    });
    addTearDown(() async {
      await subscription.cancel();
      for (final socket in sockets) {
        socket.destroy();
      }
      await server.close();
    });

    expect(await isLocalMixedProxyReady(server.port, attempts: 1), true);
  });

  test('rejects a local listener that is not a SOCKS5 proxy', () async {
    final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
    final sockets = <Socket>[];
    final subscription = server.listen((socket) {
      sockets.add(socket);
      socket.listen((_) => socket.add(const [0x00, 0x00]));
    });
    addTearDown(() async {
      await subscription.cancel();
      for (final socket in sockets) {
        socket.destroy();
      }
      await server.close();
    });

    expect(await isLocalMixedProxyReady(server.port, attempts: 1), false);
  });

  test('rejects a closed local port', () async {
    final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
    final port = server.port;
    await server.close();

    expect(await isLocalMixedProxyReady(port, attempts: 1), false);
  });

  test('rejects an incomplete SOCKS5 response', () async {
    final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
    final sockets = <Socket>[];
    final subscription = server.listen((socket) {
      sockets.add(socket);
      socket.listen((_) {
        socket.add(const [0x05]);
        socket.destroy();
      });
    });
    addTearDown(() async {
      await subscription.cancel();
      for (final socket in sockets) {
        socket.destroy();
      }
      await server.close();
    });

    expect(await isLocalMixedProxyReady(server.port, attempts: 1), false);
  });

  test(
    'does not enable system proxy before the mixed proxy is ready',
    () async {
      var starts = 0;
      var stops = 0;
      final controller = SystemProxyController(
        startProxy: (_, _) async {
          starts++;
          return true;
        },
        stopProxy: () async {
          stops++;
          return true;
        },
        readinessChecker: (_) async => false,
      );

      expect(
        await controller.start(7890, const []),
        SystemProxyStartResult.mixedProxyUnavailable,
      );
      expect(starts, 0);
      expect(stops, 1);
      expect(controller.startedByFlClash, false);
    },
  );

  test('restores system proxy when the readiness check throws', () async {
    var starts = 0;
    var stops = 0;
    final controller = SystemProxyController(
      startProxy: (_, _) async {
        starts++;
        return true;
      },
      stopProxy: () async {
        stops++;
        return true;
      },
      readinessChecker: (_) => throw StateError('readiness failed'),
    );

    expect(
      await controller.start(7890, const []),
      SystemProxyStartResult.mixedProxyUnavailable,
    );
    expect(starts, 0);
    expect(stops, 1);
    expect(controller.startedByFlClash, false);
  });

  test('enables system proxy after the mixed proxy is ready', () async {
    var starts = 0;
    final controller = SystemProxyController(
      startProxy: (_, _) async {
        starts++;
        return true;
      },
      stopProxy: () async => true,
      readinessChecker: (_) async => true,
    );

    expect(
      await controller.start(7890, const []),
      SystemProxyStartResult.success,
    );
    expect(starts, 1);
    expect(controller.startedByFlClash, true);
  });

  test('retries a transient system proxy setup failure', () async {
    var starts = 0;
    final controller = SystemProxyController(
      startProxy: (_, _) async => ++starts == 2,
      stopProxy: () async => true,
      readinessChecker: (_) async => true,
      setupAttempts: 2,
    );

    expect(
      await controller.start(7890, const []),
      SystemProxyStartResult.success,
    );
    expect(starts, 2);
    expect(controller.startedByFlClash, true);
  });

  test('reports a persistent system proxy setup failure', () async {
    var starts = 0;
    final controller = SystemProxyController(
      startProxy: (_, _) async {
        starts++;
        return false;
      },
      stopProxy: () async => true,
      readinessChecker: (_) async => true,
      setupAttempts: 2,
    );

    expect(
      await controller.start(7890, const []),
      SystemProxyStartResult.systemProxySetupFailed,
    );
    expect(starts, 2);
    expect(controller.startedByFlClash, false);
  });

  test(
    'reports a failed restore when the mixed proxy is unavailable',
    () async {
      final controller = SystemProxyController(
        startProxy: (_, _) async => true,
        stopProxy: () async => false,
        readinessChecker: (_) async => false,
      );

      expect(
        await controller.start(7890, const []),
        SystemProxyStartResult.systemProxyRestoreFailed,
      );
      expect(controller.startedByFlClash, false);
    },
  );

  test(
    'checks once for a persisted proxy even before a successful start',
    () async {
      var stops = 0;
      final controller = SystemProxyController(
        startProxy: (_, _) async => false,
        stopProxy: () async {
          stops++;
          return true;
        },
      );

      await controller.start(7890, const []);
      await controller.stopIfNeeded();
      await controller.stopIfNeeded();

      expect(controller.startedByFlClash, false);
      expect(stops, 1);
    },
  );

  test('keeps ownership until proxy restoration succeeds', () async {
    var restoreSucceeds = false;
    final controller = SystemProxyController(
      startProxy: (_, _) async => true,
      stopProxy: () async => restoreSucceeds,
    );

    await controller.start(7890, const []);
    expect(controller.startedByFlClash, true);

    await controller.stopIfNeeded();
    expect(controller.startedByFlClash, true);

    restoreSucceeds = true;
    await controller.stopIfNeeded();
    expect(controller.startedByFlClash, false);
  });

  test('rechecks persisted state after a failed start', () async {
    var stops = 0;
    final controller = SystemProxyController(
      startProxy: (_, _) async => false,
      stopProxy: () async {
        stops++;
        return true;
      },
    );

    await controller.stopIfNeeded();
    await controller.start(7890, const []);
    await controller.stopIfNeeded();

    expect(stops, 2);
  });

  test('serializes start and stop requests', () async {
    final releaseStart = Completer<void>();
    final events = <String>[];
    final controller = SystemProxyController(
      startProxy: (_, _) async {
        events.add('start');
        await releaseStart.future;
        events.add('started');
        return true;
      },
      stopProxy: () async {
        events.add('stop');
        return true;
      },
    );

    final start = controller.start(7890, const []);
    final stop = controller.stopIfNeeded();
    await Future<void>.delayed(Duration.zero);
    expect(events, ['start']);

    releaseStart.complete();
    await Future.wait([start, stop]);
    expect(events, ['start', 'started', 'stop']);
    expect(controller.startedByFlClash, false);
  });
}

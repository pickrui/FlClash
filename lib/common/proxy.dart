import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:fl_clash/common/system.dart';
import 'package:proxy/proxy.dart';

final proxy = system.isDesktop ? Proxy() : null;

typedef SystemProxyStarter =
    Future<bool?> Function(int port, List<String> bypassDomain);
typedef SystemProxyStopper = Future<bool?> Function();
typedef SystemProxyReadinessChecker = Future<bool> Function(int port);

enum SystemProxyStartResult {
  success,
  mixedProxyUnavailable,
  systemProxySetupFailed,
  systemProxyRestoreFailed,
}

class SystemProxyController {
  final SystemProxyStarter? _startProxy;
  final SystemProxyStopper? _stopProxy;
  final SystemProxyReadinessChecker? _readinessChecker;
  final int _setupAttempts;
  final Duration _setupRetryDelay;

  bool _startedByFlClash = false;
  bool _checkedPersistedState = false;
  Future<void> _task = Future.value();

  SystemProxyController({
    required SystemProxyStarter? startProxy,
    required SystemProxyStopper? stopProxy,
    SystemProxyReadinessChecker? readinessChecker,
    int setupAttempts = 1,
    Duration setupRetryDelay = Duration.zero,
  }) : _startProxy = startProxy,
       _stopProxy = stopProxy,
       _readinessChecker = readinessChecker,
       _setupAttempts = setupAttempts,
       _setupRetryDelay = setupRetryDelay,
       assert(setupAttempts > 0);

  bool get startedByFlClash => _startedByFlClash;

  Future<SystemProxyStartResult> start(int port, List<String> bypassDomain) {
    final startProxy = _startProxy;
    if (startProxy == null) {
      return Future.value(SystemProxyStartResult.success);
    }

    return _queue(() async {
      _checkedPersistedState = false;
      final readinessChecker = _readinessChecker;
      var isReady = true;
      if (readinessChecker != null) {
        try {
          isReady = await readinessChecker(port);
        } catch (_) {
          isReady = false;
        }
      }
      if (!isReady) {
        final success = await _stopProxy?.call();
        if (success == true) {
          _startedByFlClash = false;
          _checkedPersistedState = true;
        } else if (_stopProxy != null) {
          return SystemProxyStartResult.systemProxyRestoreFailed;
        }
        return SystemProxyStartResult.mixedProxyUnavailable;
      }
      for (var attempt = 0; attempt < _setupAttempts; attempt++) {
        final success = await startProxy(port, bypassDomain);
        if (success == true) {
          _startedByFlClash = true;
          _checkedPersistedState = true;
          return SystemProxyStartResult.success;
        }
        if (attempt + 1 < _setupAttempts && _setupRetryDelay > Duration.zero) {
          await Future<void>.delayed(_setupRetryDelay);
        }
      }
      return SystemProxyStartResult.systemProxySetupFailed;
    });
  }

  Future<bool> stopIfNeeded() {
    final stopProxy = _stopProxy;
    if (stopProxy == null) return Future.value(true);

    return _queue(() async {
      if (!_startedByFlClash && _checkedPersistedState) return true;

      final success = await stopProxy();
      if (success == true) {
        _startedByFlClash = false;
        _checkedPersistedState = true;
      }
      return success == true;
    });
  }

  Future<T> _queue<T>(Future<T> Function() task) {
    final operation = _task.then((_) => task());
    _task = operation.then<void>((_) {}, onError: (_, _) {});
    return operation;
  }
}

Future<bool> isLocalMixedProxyReady(
  int port, {
  int attempts = 10,
  Duration retryDelay = const Duration(milliseconds: 100),
}) async {
  for (var attempt = 0; attempt < attempts; attempt++) {
    if (await _supportsSocks5(port)) return true;
    if (attempt + 1 < attempts) {
      await Future<void>.delayed(retryDelay);
    }
  }
  return false;
}

Future<bool> _supportsSocks5(int port) async {
  Socket? socket;
  StreamSubscription<Uint8List>? subscription;
  final result = Completer<bool>();
  try {
    socket = await Socket.connect(
      InternetAddress.loopbackIPv4,
      port,
      timeout: const Duration(milliseconds: 300),
    );
    int? version;
    subscription = socket.listen(
      (data) {
        for (final byte in data) {
          if (version == null) {
            version = byte;
          } else if (!result.isCompleted) {
            result.complete(version == 0x05 && byte == 0x00);
            break;
          }
        }
      },
      onError: (_) {
        if (!result.isCompleted) result.complete(false);
      },
      onDone: () {
        if (!result.isCompleted) result.complete(false);
      },
      cancelOnError: true,
    );
    socket.add(const [0x05, 0x01, 0x00]);
    await socket.flush();
    return await result.future.timeout(
      const Duration(milliseconds: 300),
      onTimeout: () => false,
    );
  } catch (_) {
    return false;
  } finally {
    try {
      await subscription?.cancel();
    } catch (_) {
    } finally {
      socket?.destroy();
    }
  }
}

Future<SystemProxyStartResult> startSystemProxy(
  int port,
  List<String> bypassDomain,
) {
  return systemProxyController.start(port, bypassDomain);
}

Future<bool> stopSystemProxyIfNeeded() {
  return systemProxyController.stopIfNeeded();
}

final systemProxyController = SystemProxyController(
  startProxy: proxy?.startProxy,
  stopProxy: proxy?.stopProxy,
  readinessChecker: isLocalMixedProxyReady,
  setupAttempts: 2,
  setupRetryDelay: const Duration(milliseconds: 500),
);

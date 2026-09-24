import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:fl_clash/common/common.dart';

class SingleInstanceLock {
  static SingleInstanceLock? _instance;
  RandomAccessFile? _accessFile;

  SingleInstanceLock._internal();

  factory SingleInstanceLock() {
    _instance ??= SingleInstanceLock._internal();
    return _instance!;
  }

  Future<bool> acquire() async {
    if (_accessFile != null) return true;
    try {
      final lockFilePath = await appPath.lockFilePath;
      final lockFile = File(lockFilePath);
      await lockFile.create();
      _accessFile = await lockFile.open(mode: FileMode.write);
      await _accessFile?.lock();
      return true;
    } catch (_) {
      await _accessFile?.close();
      _accessFile = null;
      return false;
    }
  }
}

final singleInstanceLock = SingleInstanceLock();

class SingleInstanceWakeup {
  static const _timeout = Duration(seconds: 1);

  static Future<ServerSocket> listen({
    required File endpoint,
    required Future<void> Function() onWakeup,
    Duration requestTimeout = _timeout,
  }) async {
    final random = Random.secure();
    final token = base64Url.encode(
      List.generate(32, (_) => random.nextInt(256)),
    );
    final request = utf8.encode('FlClash.wakeup.v1 $token\n');
    final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
    try {
      await endpoint.writeAsString(
        jsonEncode({'version': 1, 'port': server.port, 'token': token}),
        flush: true,
      );
    } catch (_) {
      await server.close();
      rethrow;
    }
    final pending = <Socket>{};
    server.listen((socket) {
      if (pending.length >= 16) {
        socket.destroy();
        return;
      }
      pending.add(socket);
      unawaited(
        _receive(socket, request, requestTimeout, onWakeup).whenComplete(() {
          pending.remove(socket);
        }),
      );
    });
    return server;
  }

  static Future<void> _receive(
    Socket socket,
    List<int> request,
    Duration timeout,
    Future<void> Function() onWakeup,
  ) async {
    final deadline = Timer(timeout, socket.destroy);
    try {
      var received = 0;
      await for (final bytes in socket) {
        if (received + bytes.length > request.length) return;
        for (final byte in bytes) {
          if (byte != request[received++]) return;
        }
        if (received == request.length) {
          deadline.cancel();
          socket.destroy();
          await onWakeup();
          return;
        }
      }
    } catch (_) {
      // Probes and disconnected clients must not wake the window.
    } finally {
      deadline.cancel();
      socket.destroy();
    }
  }

  static Future<void> notify(File endpoint) async {
    final data = jsonDecode(await endpoint.readAsString());
    if (data is! Map || data['version'] != 1) return;
    final port = data['port'];
    final token = data['token'];
    if (port is! int || port < 1 || port > 65535 || token is! String) return;
    if (!RegExp(r'^[A-Za-z0-9_-]{43}=$').hasMatch(token)) return;
    final socket = await Socket.connect(
      InternetAddress.loopbackIPv4,
      port,
      timeout: _timeout,
    );
    try {
      socket.add(utf8.encode('FlClash.wakeup.v1 $token\n'));
      await socket.flush();
      await socket.close();
    } finally {
      socket.destroy();
    }
  }
}

class AsyncStorageLock {
  final Object _zoneKey = Object();
  Future<void> _tail = Future.value();

  bool get isActiveInCurrentZone {
    final parentContext = Zone.current[_zoneKey];
    return parentContext is _StorageLockContext &&
        parentContext.lock == this &&
        parentContext.active;
  }

  Future<T> synchronized<T>(
    Future<T> Function() action, {
    bool reentrant = true,
  }) {
    if (reentrant && isActiveInCurrentZone) {
      return action();
    }
    final context = _StorageLockContext(this);
    final operation = _tail.then((_) async {
      try {
        return await runZoned(action, zoneValues: {_zoneKey: context});
      } finally {
        context.active = false;
      }
    });
    _tail = operation.then<void>((_) {}, onError: (_, _) {});
    return operation;
  }
}

class _StorageLockContext {
  final AsyncStorageLock lock;
  bool active = true;

  _StorageLockContext(this.lock);
}

final storageLock = AsyncStorageLock();

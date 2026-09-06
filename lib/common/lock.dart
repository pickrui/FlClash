import 'dart:async';
import 'dart:io';

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

class AsyncStorageLock {
  final Object _zoneKey = Object();
  Future<void> _tail = Future.value();

  bool get isActiveInCurrentZone {
    final parentContext = Zone.current[_zoneKey];
    return parentContext is _StorageLockContext &&
        parentContext.lock == this &&
        parentContext.active;
  }

  Future<T> synchronized<T>(Future<T> Function() action) {
    if (isActiveInCurrentZone) {
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

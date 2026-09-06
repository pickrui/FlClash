import 'package:fl_clash/common/lock.dart';

/// Serializes application-level Core operations while allowing nested work.
class CoreLifecycleOperations {
  final _lock = AsyncStorageLock();
  Future<bool>? _readyFuture;

  Future<T> run<T>(Future<T> Function() action) => _lock.synchronized(action);

  Future<bool> ensureReady(Future<bool> Function() checkAndRecover) {
    // An external readiness check may be queued behind the current operation.
    // Waiting on its shared future here would make that operation await itself.
    if (_lock.isActiveInCurrentZone) {
      return checkAndRecover();
    }
    return _readyFuture ??= run(checkAndRecover).whenComplete(() {
      _readyFuture = null;
    });
  }
}

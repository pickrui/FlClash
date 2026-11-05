import 'dart:async';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/plugins/service.dart';

import 'desktop/model.dart';
import 'interface.dart';
import 'method.dart';

class CoreLib extends CoreHandlerInterface {
  static CoreLib? _instance;

  Completer<bool> _connectedCompleter = Completer<bool>();
  Future<CoreLifecycleResult>? _closeOperation;
  int _lifecycleRevision = 0;
  int _methodCallId = 0;
  bool _closed = false;

  CoreLib._internal();

  @override
  bool get isConnected => _connectedCompleter.isCompleted;

  @override
  Future<String> preload() async {
    try {
      await _start();
      return '';
    } catch (error) {
      return error.toString();
    }
  }

  factory CoreLib() {
    _instance ??= CoreLib._internal();
    return _instance!;
  }

  @override
  Future<bool> destroy() async {
    await (_closeOperation ??= _close());
    return true;
  }

  @override
  Future<bool> shutdown(_) async {
    if (!_connectedCompleter.isCompleted) {
      return false;
    }
    var coreStopped = true;
    Object? actionError;
    StackTrace? actionStackTrace;
    try {
      coreStopped = await shutdownCore();
    } catch (error, stackTrace) {
      actionError = error;
      actionStackTrace = stackTrace;
    } finally {
      await _stop();
    }
    if (actionError != null) {
      Error.throwWithStackTrace(
        actionError,
        actionStackTrace ?? StackTrace.current,
      );
    }
    return coreStopped;
  }

  Future<CoreLifecycleResult> _start() async {
    if (_closed) {
      throw StateError('Core lifecycle is closed');
    }
    final revision = ++_lifecycleRevision;
    if (_connectedCompleter.isCompleted) {
      return CoreLifecycleResult(
        revision: revision,
        outcome: CoreLifecycleOutcome.coalesced,
      );
    }
    final initializationError = await service?.init() ?? '';
    if (initializationError.isNotEmpty) {
      throw StateError(initializationError);
    }
    _connectedCompleter.complete(true);
    final syncError = await service?.syncState(appController.sharedState) ?? '';
    if (syncError.isNotEmpty) {
      _connectedCompleter = Completer<bool>();
      await service?.shutdown();
      throw StateError(syncError);
    }
    return CoreLifecycleResult(
      revision: revision,
      outcome: CoreLifecycleOutcome.applied,
    );
  }

  Future<CoreLifecycleResult> _stop({bool allowClosed = false}) async {
    if (_closed && !allowClosed) {
      throw StateError('Core lifecycle is closed');
    }
    final revision = ++_lifecycleRevision;
    if (!_connectedCompleter.isCompleted) {
      return CoreLifecycleResult(
        revision: revision,
        outcome: CoreLifecycleOutcome.coalesced,
      );
    }
    _connectedCompleter = Completer<bool>();
    final stopped = await service?.shutdown() ?? true;
    if (!stopped) {
      throw StateError('Android Core service shutdown failed');
    }
    return CoreLifecycleResult(
      revision: revision,
      outcome: CoreLifecycleOutcome.applied,
    );
  }

  Future<CoreLifecycleResult> _close() async {
    _closed = true;
    return _stop(allowClosed: true);
  }

  @override
  Future<T?> invokeMethod<T>({
    required CoreMethod method,
    Object? arguments,
    Duration? timeout,
  }) async {
    try {
      await _connectedCompleter.future.timeout(const Duration(seconds: 10));
    } catch (error) {
      commonPrint.log(
        'Invoke method ${method.name} before connection timed out: $error',
        logLevel: coreFailureLogLevel(error),
      );
      return null;
    }
    final id = '${++_methodCallId}';
    final result = await service
        ?.invokeMethod(
          CoreMethodCall(id: id, method: method, arguments: arguments),
        )
        .withTimeout(timeout: timeout, onTimeout: () => null);
    if (result == null) {
      return null;
    }
    return result.unwrap<T>();
  }
}

CoreLib? get coreLib => system.isAndroid ? CoreLib() : null;

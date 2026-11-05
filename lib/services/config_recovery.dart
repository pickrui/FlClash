import 'dart:async';

import 'package:fl_clash/services/config_key_store.dart';

/// Keeps the original startup suspended until its configuration is readable.
/// A retry resumes that startup, rather than initializing plugins and locks again.
Future<T> loadWithConfigRecovery<T>({
  required Future<T> Function(bool retry) load,
  required void Function(Future<void> Function() retry) showRecovery,
}) async {
  try {
    return await load(false);
  } on ConfigKeyUnavailableException {
    final recovered = Completer<T>();
    Future<void>? pending;
    Future<void> retry() {
      if (recovered.isCompleted) return Future.value();
      return pending ??= (() async {
        try {
          final value = await load(true);
          recovered.complete(value);
        } on ConfigKeyUnavailableException {
          rethrow;
        } catch (error, stackTrace) {
          recovered.completeError(error, stackTrace);
          rethrow;
        }
      })().whenComplete(() => pending = null);
    }

    showRecovery(retry);
    return recovered.future;
  }
}

import 'dart:async';

extension FutureExt<T> on Future<T> {
  Future<T> withTimeout({
    Duration? timeout,
    FutureOr<T> Function()? onTimeout,
  }) {
    return this.timeout(
      timeout ?? const Duration(minutes: 3),
      onTimeout: onTimeout,
    );
  }
}

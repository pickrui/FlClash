import 'dart:async';

import 'package:flutter/widgets.dart';

class AppUpdateScheduler with WidgetsBindingObserver {
  final Future<void> Function() checkForUpdates;
  final void Function(Object error, StackTrace stackTrace) onError;
  Timer? _timer;
  AppLifecycleState? _lifecycleState;
  bool _checking = false;

  AppUpdateScheduler({required this.checkForUpdates, required this.onError});

  void start() {
    if (_timer != null) return;
    _lifecycleState = WidgetsBinding.instance.lifecycleState;
    WidgetsBinding.instance.addObserver(this);
    // Startup already checks once; foreground checks do not reset this timer.
    _timer = Timer.periodic(
      const Duration(hours: 24),
      (_) => unawaited(_check()),
    );
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final previous = _lifecycleState;
    _lifecycleState = state;
    if (state == AppLifecycleState.resumed &&
        (previous == AppLifecycleState.inactive ||
            previous == AppLifecycleState.hidden ||
            previous == AppLifecycleState.paused)) {
      unawaited(_check());
    }
  }

  Future<void> _check() async {
    if (_timer == null || _checking) return;
    _checking = true;
    try {
      await checkForUpdates();
    } catch (error, stackTrace) {
      onError(error, stackTrace);
    } finally {
      _checking = false;
    }
  }
}

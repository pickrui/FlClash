import 'dart:async';

import 'package:fl_clash/common/print.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/widgets/inherited.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

typedef PollGuard = bool Function();

bool _isForegroundState(AppLifecycleState? state) => switch (state) {
  null || AppLifecycleState.resumed => true,
  AppLifecycleState.inactive => switch (defaultTargetPlatform) {
    TargetPlatform.macOS ||
    TargetPlatform.windows ||
    TargetPlatform.linux => true,
    _ => false,
  },
  _ => false,
};

mixin ActivePollingMixin<T extends StatefulWidget>
    on State<T>, WidgetsBindingObserver {
  Timer? _pollTimer;
  bool _isForeground = false;
  bool _isPageActive = true;
  bool _isPolling = false;
  int _pollGeneration = 0;

  Duration get pollInterval;

  Future<void> poll(PollGuard isCurrent);

  bool get canPoll => mounted && _isForeground && _isPageActive;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _isForeground = _isForegroundState(WidgetsBinding.instance.lifecycleState);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _syncPolling();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isPageActive = PageActivityScope.isActiveOf(context);
    if (_isPageActive == isPageActive) {
      return;
    }
    _isPageActive = isPageActive;
    _syncPolling();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    final isForeground = _isForegroundState(state);
    if (_isForeground == isForeground) {
      return;
    }
    _isForeground = isForeground;
    _syncPolling();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _isForeground = false;
    stopPolling();
    super.dispose();
  }

  void startPolling() {
    if (!canPoll || _isPolling) {
      return;
    }
    _isPolling = true;
    unawaited(_runPoll(++_pollGeneration));
  }

  void stopPolling() {
    _isPolling = false;
    _pollGeneration++;
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  void _syncPolling() {
    if (canPoll) {
      startPolling();
    } else {
      stopPolling();
    }
  }

  bool _isCurrentPoll(int generation) =>
      canPoll && _isPolling && generation == _pollGeneration;

  void _schedulePoll(int generation) {
    _pollTimer = Timer(pollInterval, () {
      _pollTimer = null;
      if (_isCurrentPoll(generation)) {
        unawaited(_runPoll(generation));
      }
    });
  }

  Future<void> _runPoll(int generation) async {
    try {
      await poll(() => _isCurrentPoll(generation));
    } catch (error) {
      commonPrint.log(
        '$runtimeType poll error: $error',
        logLevel: LogLevel.warning,
      );
    } finally {
      if (_isCurrentPoll(generation)) {
        _schedulePoll(generation);
      }
    }
  }
}

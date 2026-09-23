import 'dart:async';

import 'package:flutter/scheduler.dart';

import 'print.dart';
import 'render_binding.dart';
import 'system.dart';

class Render {
  Render({this._binding, this.pauseDelay = const Duration(seconds: 5)});

  final RenderSchedulerBinding? _binding;
  final Duration pauseDelay;
  Timer? _pauseTimer;
  bool _pauseRequested = false;
  bool _isPaused = false;

  void active() {
    if (!_pauseRequested) return;
    _cancelPause();
    _setPaused(false);
    _schedulePause();
  }

  void pause() {
    if (_pauseRequested) return;
    _pauseRequested = true;
    _schedulePause();
  }

  void resume() {
    _pauseRequested = false;
    _cancelPause();
    _setPaused(false);
  }

  void _schedulePause() {
    _pauseTimer = Timer(pauseDelay, () {
      _pauseTimer = null;
      if (_pauseRequested) _setPaused(true);
    });
  }

  void _cancelPause() {
    _pauseTimer?.cancel();
    _pauseTimer = null;
  }

  void _setPaused(bool value) {
    if (_isPaused == value) return;
    final binding =
        _binding ?? SchedulerBinding.instance as RenderSchedulerBinding;
    if (value) {
      binding.pauseRendering();
    } else {
      binding.resumeRendering();
    }
    _isPaused = value;
    commonPrint.log(value ? 'pause' : 'resume');
  }
}

final Render? render = system.isDesktop ? Render() : null;

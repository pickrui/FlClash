import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

mixin RenderSchedulerBinding on SchedulerBinding {
  bool _renderPaused = false;

  bool get renderPaused => _renderPaused;

  // Keep queued and startup frames intact; only block ordinary follow-up frames.
  @override
  bool get framesEnabled => !_renderPaused && super.framesEnabled;

  void pauseRendering() => _renderPaused = true;

  void resumeRendering() {
    if (!_renderPaused) return;
    _renderPaused = false;
    scheduleFrame();
  }
}

class FlClashWidgetsBinding extends WidgetsFlutterBinding
    with RenderSchedulerBinding {
  FlClashWidgetsBinding._();

  static FlClashWidgetsBinding? _instance;

  static FlClashWidgetsBinding ensureInitialized() =>
      _instance ??= FlClashWidgetsBinding._();
}

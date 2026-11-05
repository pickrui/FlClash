import 'package:fl_clash/models/config.dart';
import 'window.dart';

abstract interface class WindowPort {
  Future<WindowProps?> captureNormalGeometry(WindowProps current);
  Future<void> show();
  Future<void> hide();
  Future<void> toggle();
  Future<void> close();
  void forceExit();
}

WindowPort? windowPort = window;

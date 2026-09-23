import 'package:fl_clash/controller.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/common/secrets.dart';
import 'package:material_ui/material_ui.dart';

class CommonPrint {
  static CommonPrint? _instance;

  CommonPrint._internal();

  factory CommonPrint() {
    _instance ??= CommonPrint._internal();
    return _instance!;
  }

  void log(String? text, {LogLevel logLevel = LogLevel.info}) {
    if (Secrets.shouldSuppressOutput(text ?? 'null')) return;
    final payload = '[APP] ${text ?? 'null'}';
    final log = Log.app(payload).copyWith(logLevel: logLevel);
    debugPrint(payload);
    if (!appController.canRecordLogs) {
      return;
    }
    appController.writePersistentLog(log);
    appController.addLog(log, persist: false);
  }
}

final commonPrint = CommonPrint();

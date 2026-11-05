import 'package:fl_clash/common/boot_guard.dart';
import 'package:fl_clash/common/preferences.dart';
import 'package:fl_clash/common/print.dart';
import 'package:fl_clash/plugins/app.dart';

final startupRecovery = BootGuard(
  readRecord: preferences.getBootRecord,
  writeRecord: preferences.saveBootRecord,
  readExitInfo: () async => await app?.getLastExitInfo(),
  onError: (error) =>
      commonPrint.log('Startup journal unavailable: ${error.runtimeType}'),
);

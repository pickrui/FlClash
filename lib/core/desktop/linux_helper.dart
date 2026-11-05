import 'dart:async';
import 'dart:io';

import 'package:fl_clash/common/path.dart';
import 'package:fl_clash/enum/enum.dart';

import 'helper_client.dart';

typedef LinuxHelperReadinessProbe =
    Future<HelperReadiness> Function(Duration? timeout, bool logFailure);

class LinuxHelperInstaller {
  LinuxHelperInstaller({
    HelperClient? client,
    LinuxHelperReadinessProbe? probeReadiness,
    String? executable,
    Future<ProcessResult> Function(String, List<String>)? runProcess,
    bool Function()? hasSystemd,
  }) : _readiness =
           probeReadiness ??
           ((timeout, logFailure) => (client ?? linuxHelperClient).readiness(
             timeout: timeout,
             logFailure: logFailure,
           )),
       executable = executable ?? appPath.helperPath,
       _runProcess = runProcess ?? Process.run,
       _hasSystemd =
           hasSystemd ?? (() => Directory('/run/systemd/system').existsSync());

  final LinuxHelperReadinessProbe _readiness;
  final String executable;
  final Future<ProcessResult> Function(String, List<String>) _runProcess;
  final bool Function() _hasSystemd;

  bool get available => _hasSystemd() && File(executable).existsSync();

  Future<AuthorizeCode> install() async {
    if (!available) return AuthorizeCode.error;
    final ready = await _readiness(null, true);
    if (ready == HelperReadiness.ready) return AuthorizeCode.none;
    if (ready == HelperReadiness.manifestMissing) return AuthorizeCode.error;
    try {
      final result = await _runProcess('pkexec', [executable, 'install']);
      if (result.exitCode != 0) return AuthorizeCode.error;
      final deadline = Stopwatch()..start();
      const timeout = Duration(seconds: 10);
      while (deadline.elapsed < timeout) {
        if (await _readiness(timeout - deadline.elapsed, false) ==
            HelperReadiness.ready) {
          return AuthorizeCode.success;
        }
        if (deadline.elapsed + const Duration(milliseconds: 250) >= timeout) {
          break;
        }
        await Future<void>.delayed(const Duration(milliseconds: 250));
      }
    } on ProcessException {
      return AuthorizeCode.error;
    }
    return AuthorizeCode.error;
  }

  Future<bool> uninstall() async {
    if (!available) return false;
    try {
      return (await _runProcess('pkexec', [
            executable,
            'uninstall',
          ])).exitCode ==
          0;
    } on ProcessException {
      return false;
    }
  }
}

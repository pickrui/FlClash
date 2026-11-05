import 'dart:ffi';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:ffi/ffi.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/macos_dns.dart';
import 'package:fl_clash/core/desktop/helper_client.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/plugins/app.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/input.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

bool isFlClashDockerEnvironment(Map<String, String> environment) {
  final value = environment['FLCLASH_DOCKER']?.trim().toLowerCase();
  return value == 'true' || value == '1';
}

class System {
  static System? _instance;

  System._internal();

  factory System() {
    _instance ??= System._internal();
    return _instance!;
  }

  bool get isDesktop => isWindows || isMacOS || isLinux;

  bool get isWindows => Platform.isWindows;

  bool get isMacOS => Platform.isMacOS;

  bool get isAndroid => Platform.isAndroid;

  bool get isLinux => Platform.isLinux;

  bool get isDocker => isFlClashDockerEnvironment(Platform.environment);

  Future<void> hideFile(String path) async {
    try {
      if (isWindows) {
        await Process.run('attrib', ['+h', path]);
      } else if (isMacOS) {
        await Process.run('chflags', ['hidden', path]);
      }
    } catch (_) {}
  }

  Future<int> get version async {
    final deviceInfo = await DeviceInfoPlugin().deviceInfo;
    return switch (Platform.operatingSystem) {
      'macos' => (deviceInfo as MacOsDeviceInfo).majorVersion,
      'android' => (deviceInfo as AndroidDeviceInfo).version.sdkInt,
      'windows' => (deviceInfo as WindowsDeviceInfo).majorVersion,
      String() => 0,
    };
  }

  Future<bool> checkIsAdmin() async {
    final corePath = appPath.corePath;
    if (system.isWindows) {
      return await windowsHelperClient.readiness() ==
          WindowsHelperReadiness.ready;
    } else if (system.isMacOS) {
      final result = await Process.run('stat', ['-f', '%Su:%Sg %Sp', corePath]);
      final output = result.stdout.trim();
      if (output.startsWith('root:admin') && output.contains('rws')) {
        return true;
      }
      return false;
    } else if (Platform.isLinux) {
      final result = await Process.run('stat', ['-c', '%U:%G %A', corePath]);
      final output = result.stdout.trim();
      if (output.startsWith('root:') && output.contains('rws')) {
        return true;
      }
      return false;
    }
    return true;
  }

  Future<AuthorizeCode> authorizeCore() async {
    if (system.isAndroid) {
      return AuthorizeCode.error;
    }
    final corePath = appPath.corePath;
    final isAdmin = await checkIsAdmin();
    if (isAdmin) {
      return AuthorizeCode.none;
    }

    if (system.isWindows) {
      return await windows?.registerService() ?? AuthorizeCode.error;
    }

    if (system.isMacOS) {
      final escapedPath = corePath.replaceAll("'", "'\\''");
      final bashString =
          "chown root:admin '$escapedPath' && chmod +sx '$escapedPath'";
      final appleScriptString = bashString
          .replaceAll('\\', '\\\\')
          .replaceAll('"', '\\"');
      final arguments = [
        '-e',
        'do shell script "$appleScriptString" with administrator privileges',
      ];
      final result = await Process.run('osascript', arguments);
      if (result.exitCode != 0) {
        return AuthorizeCode.error;
      }
      return AuthorizeCode.success;
    } else if (Platform.isLinux) {
      try {
        final result = await Process.run('pkexec', [
          'sh',
          '-c',
          'chown root:root "\$1" && chmod u+s "\$1" && sync',
          'sh',
          corePath,
        ]);
        if (result.exitCode == 0) {
          return await checkIsAdmin()
              ? AuthorizeCode.success
              : AuthorizeCode.error;
        }
        if (result.exitCode != 127) {
          return AuthorizeCode.error;
        }
      } catch (error) {
        commonPrint.log('pkexec failed: $error');
      }
      await window?.show();
      final password = await globalState.showCommonDialog<String>(
        child: InputDialog(
          obscureText: true,
          title: appLocalizations.pleaseInputAdminPassword,
          value: '',
          inputFormatters: TextInputLimits.limit(TextInputLimits.password),
        ),
      );
      if (password == null || password.isEmpty) {
        return AuthorizeCode.error;
      }
      final chownResult = await _runSudo(password, [
        'chown',
        'root:root',
        corePath,
      ]);
      if (!chownResult) {
        return AuthorizeCode.error;
      }
      final chmodResult = await _runSudo(password, ['chmod', 'u+s', corePath]);
      if (!chmodResult) {
        return AuthorizeCode.error;
      }
      await Process.run('sync', []);
      return await checkIsAdmin() ? AuthorizeCode.success : AuthorizeCode.error;
    }
    return AuthorizeCode.error;
  }

  Future<bool> _runSudo(String password, List<String> arguments) async {
    try {
      final process = await Process.start('sudo', ['-S', ...arguments]);
      final stdoutDone = process.stdout.drain<void>();
      final stderrDone = process.stderr.drain<void>();
      process.stdin.writeln(password);
      await process.stdin.close();
      final exitCode = await process.exitCode;
      await Future.wait([stdoutDone, stderrDone]);
      return exitCode == 0;
    } catch (_) {
      return false;
    }
  }

  Future<void> back() async {
    await app?.moveTaskToBack();
    await window?.hide();
  }

  Future<void> exit() async {
    if (system.isAndroid) {
      await SystemNavigator.pop();
    }
    await window?.close();
    window?.forceExit();
  }
}

final system = System();

class Windows {
  static Windows? _instance;
  late DynamicLibrary _shell32;

  Windows._internal() {
    _shell32 = DynamicLibrary.open('shell32.dll');
  }

  factory Windows() {
    _instance ??= Windows._internal();
    return _instance!;
  }

  bool runas(String command, String arguments) {
    final commandPtr = command.toNativeUtf16();
    final argumentsPtr = arguments.toNativeUtf16();
    final operationPtr = 'runas'.toNativeUtf16();

    final shellExecute = _shell32
        .lookupFunction<
          Int32 Function(
            Pointer<Utf16> hwnd,
            Pointer<Utf16> lpOperation,
            Pointer<Utf16> lpFile,
            Pointer<Utf16> lpParameters,
            Pointer<Utf16> lpDirectory,
            Int32 nShowCmd,
          ),
          int Function(
            Pointer<Utf16> hwnd,
            Pointer<Utf16> lpOperation,
            Pointer<Utf16> lpFile,
            Pointer<Utf16> lpParameters,
            Pointer<Utf16> lpDirectory,
            int nShowCmd,
          )
        >('ShellExecuteW');

    final result = shellExecute(
      nullptr,
      operationPtr,
      commandPtr,
      argumentsPtr,
      nullptr,
      1,
    );

    calloc.free(commandPtr);
    calloc.free(argumentsPtr);
    calloc.free(operationPtr);

    commonPrint.log(
      'windows runas: [command masked] resultCode:$result',
      logLevel: LogLevel.warning,
    );

    if (result <= 32) {
      return false;
    }
    return true;
  }

  // Future<void> _killProcess(int port) async {
  //   final result = await Process.run('netstat', ['-ano']);
  //   final lines = result.stdout.toString().trim().split('\n');
  //   for (final line in lines) {
  //     if (!line.contains(':$port') || !line.contains('LISTENING')) {
  //       continue;
  //     }
  //     final parts = line.trim().split(RegExp(r'\s+'));
  //     final pid = int.tryParse(parts.last);
  //     if (pid != null) {
  //      await Process.run('taskkill', ['/PID', pid.toString(), '/F']);
  //     }
  //   }
  // }

  Future<AuthorizeCode> registerService() async {
    final readiness = await windowsHelperClient.readiness();
    switch (readiness) {
      case WindowsHelperReadiness.ready:
        return AuthorizeCode.none;
      case WindowsHelperReadiness.manifestMissing:
        commonPrint.log(
          'Core manifest is missing or invalid; Helper unavailable',
          logLevel: LogLevel.warning,
        );
        return AuthorizeCode.error;
      case WindowsHelperReadiness.notReady:
        break;
    }
    if (!runas(appPath.helperPath, 'install')) {
      return AuthorizeCode.error;
    }
    return await _waitForHelperService()
        ? AuthorizeCode.success
        : AuthorizeCode.error;
  }

  Future<bool> _waitForHelperService() async {
    const timeout = Duration(seconds: 6);
    const interval = Duration(seconds: 1);
    final stopwatch = Stopwatch()..start();
    while (stopwatch.elapsed < timeout) {
      final remaining = timeout - stopwatch.elapsed;
      if (await windowsHelperClient.readiness(
            timeout: remaining,
            logFailure: false,
          ) ==
          WindowsHelperReadiness.ready) {
        return true;
      }
      if (stopwatch.elapsed + interval >= timeout) {
        break;
      }
      await Future.delayed(interval);
    }
    return false;
  }

  Future<bool> registerTask(String appName) async {
    final taskXml =
        '''
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.3" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <Principals>
    <Principal id="Author">
      <LogonType>InteractiveToken</LogonType>
      <RunLevel>HighestAvailable</RunLevel>
    </Principal>
  </Principals>
  <Triggers>
    <LogonTrigger/>
  </Triggers>
  <Settings>
    <MultipleInstancesPolicy>Parallel</MultipleInstancesPolicy>
    <DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>
    <StopIfGoingOnBatteries>false</StopIfGoingOnBatteries>
    <AllowHardTerminate>false</AllowHardTerminate>
    <StartWhenAvailable>false</StartWhenAvailable>
    <RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
    <IdleSettings>
      <StopOnIdleEnd>false</StopOnIdleEnd>
      <RestartOnIdle>false</RestartOnIdle>
    </IdleSettings>
    <AllowStartOnDemand>true</AllowStartOnDemand>
    <Enabled>true</Enabled>
    <Hidden>false</Hidden>
    <RunOnlyIfIdle>false</RunOnlyIfIdle>
    <WakeToRun>false</WakeToRun>
    <ExecutionTimeLimit>PT72H</ExecutionTimeLimit>
    <Priority>7</Priority>
  </Settings>
  <Actions Context="Author">
    <Exec>
      <Command>"${Platform.resolvedExecutable}"</Command>
    </Exec>
  </Actions>
</Task>''';
    final taskPath = join(await appPath.tempPath, 'task.xml');
    await File(taskPath).create(recursive: true);
    await File(
      taskPath,
    ).writeAsBytes(taskXml.encodeUtf16LeWithBom, flush: true);
    final commandLine = [
      '/Create',
      '/TN',
      appName,
      '/XML',
      '%s',
      '/F',
    ].join(' ');
    return runas('schtasks', commandLine.replaceFirst('%s', taskPath));
  }
}

final windows = system.isWindows ? Windows() : null;

class MacOS extends MacosDnsController {
  static MacOS? _instance;

  MacOS._internal();

  factory MacOS() {
    _instance ??= MacOS._internal();
    return _instance!;
  }
}

final macOS = system.isMacOS ? MacOS() : null;

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:launch_at_startup/launch_at_startup.dart';

import 'constant.dart';
import 'system.dart';

const silentLaunchArgument = '--silent-launch';

Future<List<String>> resolveLaunchArguments({
  required List<String> arguments,
  required bool isMacOS,
}) async {
  if (!isMacOS || arguments.contains(silentLaunchArgument)) {
    return List.unmodifiable(arguments);
  }
  final launchedAtLogin = await const MethodChannel(
    'launch_at_startup',
  ).invokeMethod<bool>('launchAtStartupWasLaunchedAtLogin');
  return List.unmodifiable([
    ...arguments,
    if (launchedAtLogin == true) silentLaunchArgument,
  ]);
}

bool shouldLaunchSilently({
  required bool enabled,
  required List<String> arguments,
}) {
  return enabled && arguments.contains(silentLaunchArgument);
}

class AutoLaunch {
  static AutoLaunch? _instance;

  AutoLaunch._internal() {
    launchAtStartup.setup(
      appName: appName,
      appPath: Platform.resolvedExecutable,
      args: const [silentLaunchArgument],
    );
  }

  factory AutoLaunch() {
    _instance ??= AutoLaunch._internal();
    return _instance!;
  }

  Future<void> updateStatus(bool isAutoLaunch) async {
    if (kDebugMode) {
      return;
    }
    if (await launchAtStartup.isEnabled() == isAutoLaunch) return;
    if (isAutoLaunch) {
      await launchAtStartup.enable();
    } else {
      await launchAtStartup.disable();
    }
  }
}

final autoLaunch = system.isDesktop ? AutoLaunch() : null;

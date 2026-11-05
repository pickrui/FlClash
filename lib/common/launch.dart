import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:launch_at_startup/launch_at_startup.dart';

import 'constant.dart';
import 'system.dart';

const silentLaunchArgument = '--silent-launch';

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

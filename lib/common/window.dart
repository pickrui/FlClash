import 'dart:async';
import 'dart:io';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/config.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';

class Window {
  static Window? _instance;

  Window._internal();

  factory Window() {
    _instance ??= Window._internal();
    return _instance!;
  }

  Future<void> init(
    int version,
    WindowProps props, {
    bool silentLaunch = false,
  }) async {
    await ensureSingleInstance();
    if (!system.isMacOS) {
      unawaited(_startWakeupServer());
    }
    if (system.isWindows) {
      protocol.register('clash');
      protocol.register('clashmeta');
      protocol.register('flclash');
    }
    await windowManager.ensureInitialized();
    // kDebugMode ? Size(680, 580) :
    final WindowOptions windowOptions = WindowOptions(
      size: props.size,
      minimumSize: const Size(380, 400),
    );
    if (!system.isMacOS || version > 10) {
      await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
    }
    await windowManager.setMaximizable(true);
    await _windowPosition(props);
    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setPreventClose(true);
      if (system.isLinux) {
        if (silentLaunch) {
          await hide();
        } else {
          await show();
        }
      }
    });
  }

  Future<void> ensureSingleInstance() async {
    final acquire = await singleInstanceLock.acquire();
    if (!acquire) {
      await _showExistingInstance();
      exit(0);
    }
  }

  Future<void> _startWakeupServer() async {
    try {
      final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
      final file = File(await appPath.wakeupFilePath);
      await file.writeAsString(server.port.toString(), flush: true);
      server.listen((socket) {
        socket.destroy();
        show();
      });
    } catch (_) {}
  }

  Future<void> _showExistingInstance() async {
    if (system.isMacOS) {
      try {
        await Process.run('/usr/bin/open', [
          '-b',
          globalState.packageInfo.packageName,
        ]);
      } catch (_) {}
      return;
    }
    try {
      final content = await File(await appPath.wakeupFilePath).readAsString();
      final port = int.parse(content.trim());
      final socket = await Socket.connect(
        InternetAddress.loopbackIPv4,
        port,
        timeout: const Duration(seconds: 1),
      );
      socket.destroy();
    } catch (_) {}
  }

  Future<void> _windowPosition(WindowProps props) async {
    if (!system.isMacOS) {
      final left = props.left ?? 0;
      final top = props.top ?? 0;
      final right = left + props.width;
      final bottom = top + props.height;
      if (left == 0 && top == 0) {
        await windowManager.setAlignment(Alignment.center);
      } else {
        final displays = await screenRetriever.getAllDisplays();
        final isPositionValid = displays.any((display) {
          final displayBounds = Rect.fromLTWH(
            display.visiblePosition!.dx,
            display.visiblePosition!.dy,
            display.size.width,
            display.size.height,
          );
          return displayBounds.contains(Offset(left, top)) ||
              displayBounds.contains(Offset(right, bottom));
        });
        if (isPositionValid) {
          await windowManager.setPosition(Offset(left, top));
        }
      }
    }
  }

  Future<void> show() async {
    await windowManager.ensureInitialized();
    render?.resume();
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setSkipTaskbar(false);
  }

  Future<bool> get isVisible async {
    return windowManager.isVisible();
  }

  Future<void> close() async {
    await windowManager.close();
  }

  void forceExit() {
    exit(0);
  }

  Future<void> hide() async {
    render?.pause();
    await windowManager.hide();
    await windowManager.setSkipTaskbar(true);
  }
}

final window = system.isDesktop ? Window() : null;

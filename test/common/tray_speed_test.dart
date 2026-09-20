import 'dart:async';
import 'dart:io';

import 'package:fl_clash/l10n/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:fl_clash/common/tray.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:tray/tray.dart' as native;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('tray');
  const running = TrayState(
    mode: Mode.rule,
    port: 7890,
    autoLaunch: false,
    systemProxy: true,
    tunEnable: false,
    isStart: true,
    locale: 'en',
    brightness: Brightness.light,
    groups: [],
    selectedMap: {},
    showTrayTitle: true,
  );
  final calls = <MethodCall>[];
  setUp(() async {
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    await AppLocalizations.load(const Locale('en'));
    native.Tray.instance.resetForTesting();
    calls.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          calls.add(call);
          return true;
        });
  });
  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
    native.Tray.instance.resetForTesting();
  });

  test(
    'background speed survives menu changes and disabling then enabling its title',
    () async {
      final tray = Tray();
      await tray.update(trayState: running.copyWith(isStart: false));
      await tray.update(trayState: running);
      const speed = Traffic(up: 1024, down: 8192);
      await tray.updateTraffic(speed);
      expect(calls.last.arguments['title'], speed.trayTitle);
      await tray.update(trayState: running.copyWith(mode: Mode.global));
      expect(
        calls.where((call) => call.method == 'show').last.arguments['title'],
        speed.trayTitle,
      );
      await tray.update(trayState: running.copyWith(showTrayTitle: false));
      expect(calls.last.arguments['title'], '');
      await tray.update(trayState: running);
      expect(calls.last.arguments['title'], speed.trayTitle);
      await tray.update(trayState: running.copyWith(isStart: false));
      expect(calls.last.arguments['title'], const Traffic().trayTitle);
      final stoppedCalls = calls.length;
      await tray.updateTraffic(speed);
      expect(calls.length, stoppedCalls);
    },
    skip: !Platform.isMacOS,
  );

  test(
    'an older menu refresh cannot restore a disabled title',
    () async {
      final tray = Tray();
      await tray.update(trayState: running);
      const speed = Traffic(up: 1024, down: 8192);
      await tray.updateTraffic(speed);
      final showStarted = Completer<void>();
      final releaseShow = Completer<void>();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
            calls.add(call);
            if (call.method == 'show' && !showStarted.isCompleted) {
              showStarted.complete();
              await releaseShow.future;
            }
            return true;
          });
      final older = tray.update(trayState: running.copyWith(mode: Mode.global));
      await showStarted.future;
      final disabled = tray.update(
        trayState: running.copyWith(showTrayTitle: false),
      );
      final refresh = tray.updateTraffic(const Traffic(up: 2048, down: 16384));
      releaseShow.complete();
      await Future.wait([older, disabled, refresh]);
      expect(calls.last.arguments['title'], '');
      await tray.updateTraffic(speed);
      expect(calls.last.arguments['title'], '');
    },
    skip: !Platform.isMacOS,
  );
}

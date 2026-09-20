import 'package:fl_clash/controller.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tray/tray.dart' as native;

import 'app_localizations.dart';
import 'constant.dart';
import 'system.dart';
import 'window.dart';

class Tray {
  static Tray? _instance;
  Traffic _lastTraffic = const Traffic();
  bool _showTrayTitle = false;
  bool _isStarted = false;

  Tray._internal();

  factory Tray() {
    _instance ??= Tray._internal();
    return _instance!;
  }

  String get trayIconSuffix {
    return system.isWindows ? 'ico' : 'png';
  }

  Future<void> destroy() => native.Tray.instance.hide();

  String getTryIcon({required bool isStart, required bool tunEnable}) {
    if (system.isMacOS || !isStart) {
      return 'assets/images/icon/status_1.$trayIconSuffix';
    }
    if (!tunEnable) {
      return 'assets/images/icon/status_2.$trayIconSuffix';
    }
    return 'assets/images/icon/status_3.$trayIconSuffix';
  }

  Future<void> update({required TrayState trayState}) async {
    if (system.isAndroid) {
      return;
    }
    _showTrayTitle = trayState.showTrayTitle;
    _isStarted = trayState.isStart;
    if (!_isStarted) _lastTraffic = const Traffic();
    final menuItems = <native.TrayMenuItem>[];
    final showMenuItem = native.TrayMenuAction(
      label: appLocalizations.show,
      onSelected: () {
        window?.show();
      },
    );
    menuItems.add(showMenuItem);
    final startMenuItem = native.TrayMenuCheckbox(
      label: trayState.isStart ? appLocalizations.stop : appLocalizations.start,
      onSelected: () async {
        appController.updateStart();
      },
      checked: false,
    );
    menuItems.add(startMenuItem);
    if (system.isMacOS) {
      final speedStatistics = native.TrayMenuCheckbox(
        label: appLocalizations.speedStatistics,
        onSelected: () async {
          appController.updateSpeedStatistics();
        },
        checked: trayState.showTrayTitle,
      );
      menuItems.add(speedStatistics);
    }
    menuItems.add(const native.TrayMenuSeparator());
    for (final mode in Mode.values) {
      menuItems.add(
        native.TrayMenuCheckbox(
          label: Intl.message(mode.name),
          onSelected: () {
            appController.changeMode(mode);
          },
          checked: mode == trayState.mode,
        ),
      );
    }
    menuItems.add(const native.TrayMenuSeparator());
    if (system.isMacOS) {
      for (final group in trayState.groups) {
        final subMenuItems = <native.TrayMenuItem>[];
        for (final proxy in group.all) {
          subMenuItems.add(
            native.TrayMenuCheckbox(
              label: proxy.name,
              checked:
                  appController.getSelectedProxyName(group.name) == proxy.name,
              onSelected: () {
                appController.changeProxyDebounce(group.name, proxy.name);
              },
            ),
          );
        }
        menuItems.add(
          native.TrayMenuSubmenu(label: group.name, items: subMenuItems),
        );
      }
      if (trayState.groups.isNotEmpty) {
        menuItems.add(const native.TrayMenuSeparator());
      }
    }
    if (trayState.isStart) {
      menuItems.add(
        native.TrayMenuCheckbox(
          label: appLocalizations.tun,
          onSelected: () {
            appController.updateTun();
          },
          checked: trayState.tunEnable,
        ),
      );
      menuItems.add(
        native.TrayMenuCheckbox(
          label: appLocalizations.systemProxy,
          onSelected: () {
            appController.updateSystemProxy();
          },
          checked: trayState.systemProxy,
        ),
      );
      menuItems.add(const native.TrayMenuSeparator());
    }
    final autoStartMenuItem = native.TrayMenuCheckbox(
      label: appLocalizations.autoLaunch,
      onSelected: () async {
        appController.updateAutoLaunch();
      },
      checked: trayState.autoLaunch,
    );
    final copyEnvVarMenuItem = native.TrayMenuSubmenu(
      label: appLocalizations.copyEnvVar,
      enabled: trayState.port > 0,
      items: [
        for (final shell in _EnvShell.values)
          native.TrayMenuAction(
            label: shell.label,
            onSelected: () async {
              await _copyEnv(trayState.port, shell);
            },
          ),
      ],
    );
    menuItems.add(autoStartMenuItem);
    menuItems.add(copyEnvVarMenuItem);
    menuItems.add(const native.TrayMenuSeparator());
    final exitMenuItem = native.TrayMenuAction(
      label: appLocalizations.exit,
      onSelected: () async {
        await appController.handleExit();
      },
    );
    menuItems.add(exitMenuItem);
    await native.Tray.instance.show(
      native.TraySpec(
        icon: native.TrayIcon.asset(
          getTryIcon(
            isStart: trayState.isStart,
            tunEnable: trayState.tunEnable,
          ),
          isTemplate: system.isMacOS,
        ),
        toolTip: appName,
        menu: menuItems,
      ),
    );
    await _updateTitle();
  }

  Future<void> updateTraffic(Traffic traffic) async {
    if (!system.isMacOS || !_isStarted) return;
    _lastTraffic = traffic;
    await _updateTitle();
  }

  Future<void> _updateTitle() async {
    if (!system.isMacOS) return;
    await native.Tray.instance.setTitle(
      _showTrayTitle ? _lastTraffic.trayTitle : '',
    );
  }

  Future<void> _copyEnv(int port, _EnvShell shell) async {
    final url = 'http://127.0.0.1:$port';

    final cmdline = switch (shell) {
      _EnvShell.bash =>
        'export http_proxy=$url https_proxy=$url all_proxy=$url',
      _EnvShell.fish =>
        'set -gx http_proxy $url; set -gx https_proxy $url; set -gx all_proxy $url',
      _EnvShell.powerShell =>
        '\$env:http_proxy="$url"; \$env:https_proxy="$url"; \$env:all_proxy="$url"',
      _EnvShell.cmd =>
        'set http_proxy=$url && set https_proxy=$url && set all_proxy=$url',
    };

    await Clipboard.setData(ClipboardData(text: cmdline));
  }
}

enum _EnvShell {
  bash('Bash'),
  fish('Fish'),
  powerShell('PowerShell'),
  cmd('CMD');

  const _EnvShell(this.label);

  final String label;
}

final tray = system.isDesktop ? Tray() : null;

import 'dart:io';

import 'package:fl_clash/common/tray.dart';
import 'package:test/test.dart';

void main() {
  group('Tray.getTryIcon', () {
    final tray = Tray();
    final suffix = tray.trayIconSuffix;

    test('returns idle icon when core is not started', () {
      expect(
        tray.getTryIcon(isStart: false, tunEnable: false),
        'assets/images/icon/status_1.$suffix',
      );
    });

    test('returns normal mode icon when core is started without TUN', () {
      expect(
        tray.getTryIcon(isStart: true, tunEnable: false),
        Platform.isMacOS
            ? 'assets/images/icon/status_1.$suffix'
            : 'assets/images/icon/status_2.$suffix',
      );
    });

    test('returns enhanced mode icon when core is started with TUN', () {
      expect(
        tray.getTryIcon(isStart: true, tunEnable: true),
        Platform.isMacOS
            ? 'assets/images/icon/status_1.$suffix'
            : 'assets/images/icon/status_3.$suffix',
      );
    });
  });

  group('proxyEnvCommand', () {
    test('quotes cmd assignments so no value keeps a trailing space', () {
      final command = proxyEnvCommand(ProxyEnvShell.cmd, 7890);

      expect(
        command,
        'set "http_proxy=http://127.0.0.1:7890" && '
        'set "https_proxy=http://127.0.0.1:7890" && '
        'set "all_proxy=http://127.0.0.1:7890"',
      );
    });

    test('every shell exports the three proxy variables', () {
      for (final shell in ProxyEnvShell.values) {
        final command = proxyEnvCommand(shell, 7890);
        for (final name in ['http_proxy', 'https_proxy', 'all_proxy']) {
          expect(command, contains(name), reason: shell.label);
        }
        expect(command, contains('http://127.0.0.1:7890'));
      }
    });
  });
}

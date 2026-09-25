import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final preload in [false, true]) {
    test(
      'Docker autostart preserves the desktop and keyring with preload=$preload',
      () async {
        final root = Directory.systemTemp.createTempSync('flclash-docker-');
        addTearDown(() => root.deleteSync(recursive: true));
        final bin = Directory('${root.path}/bin')..createSync();
        Future<void> executable(String name, String body) async {
          final file = File('${bin.path}/$name')
            ..writeAsStringSync('#!/bin/bash\nset -eu\n$body\n');
          expect((await Process.run('chmod', ['755', file.path])).exitCode, 0);
        }

        const checkEnvironment = r'''
test -z "${LD_PRELOAD+x}"
test -z "${LD_AUDIT+x}"
test "$DISPLAY" = :1
test "$WAYLAND_DISPLAY" = wayland-1
test "$XDG_RUNTIME_DIR" = "$HOME/.XDG"
test "$LD_LIBRARY_PATH" = /fixture/graphics
''';
        await executable('dbus-run-session', '''
$checkEnvironment
test "\$1" = --
shift
export DBUS_SESSION_BUS_ADDRESS=unix:path=/fixture/session
exec "\$@"
''');
        await executable('gnome-keyring-daemon', '''
$checkEnvironment
test "\$*" = '--unlock --components=secrets'
read -r password
test -z "\$password"
echo 'export KEYRING_READY=1'
''');
        await executable('FlClash', '''
$checkEnvironment
test "\$DBUS_SESSION_BUS_ADDRESS" = unix:path=/fixture/session
test "\$KEYRING_READY" = 1
exit 23
''');
        final autostart = File('${root.path}/autostart')
          ..writeAsStringSync(
            File('docker/root/defaults/autostart')
                .readAsStringSync()
                .replaceAll('/usr/share/FlClash/FlClash', 'FlClash'),
          );
        final result = await Process.run(
          '/bin/bash',
          [
            '-c',
            if (preload)
              'export LD_PRELOAD=/fixture/selkies_v4l2_interposer.so '
                  'LD_AUDIT=/fixture/audit.so; source "\$1"'
            else
              'source "\$1"',
            'docker-autostart',
            autostart.path,
          ],
          environment: {
            'PATH': '${bin.path}:/usr/bin:/bin',
            'HOME': root.path,
            'DISPLAY': ':1',
            'WAYLAND_DISPLAY': 'wayland-1',
            'XDG_RUNTIME_DIR': '${root.path}/.XDG',
            'LD_LIBRARY_PATH': '/fixture/graphics',
          },
          includeParentEnvironment: false,
        );
        expect(
          result.exitCode,
          23,
          reason: '${result.stdout}\n${result.stderr}',
        );
      },
      skip: Platform.isWindows,
    );
  }
}

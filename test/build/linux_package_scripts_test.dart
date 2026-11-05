import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:yaml/yaml.dart';

void main() {
  for (final format in ['deb', 'rpm']) {
    test(
      '$format migrates installed Helpers and retains non-systemd startup',
      () async {
        final root = Directory.systemTemp.createTempSync('flclash-package-');
        addTearDown(() => root.deleteSync(recursive: true));
        final config =
            loadYaml(
                  File(
                    'linux/packaging/$format/make_config.yaml',
                  ).readAsStringSync(),
                )
                as YamlMap;
        String script(String key) => (config[key] as YamlList)
            .join('\n')
            .replaceAll('/usr/share/FlClash', '${root.path}/app')
            .replaceAll('/usr/local/libexec/flclash', '${root.path}/installed')
            .replaceAll('/etc/systemd/system', '${root.path}/units')
            .replaceAll('/run/systemd/system', '${root.path}/systemd');
        final bin = Directory('${root.path}/bin')..createSync();
        final app = Directory('${root.path}/app')..createSync();
        final units = Directory('${root.path}/units')..createSync();
        final log = File('${root.path}/log')..writeAsStringSync('');
        Future<void> executable(String path, String body) async {
          File(path).writeAsStringSync('#!/bin/sh\n$body\n');
          expect((await Process.run('chmod', ['755', path])).exitCode, 0);
        }

        for (final command in ['chmod', 'chown', 'systemctl']) {
          await executable(
            '${bin.path}/$command',
            'echo "$command \$*" >> "\$LOG"',
          );
        }
        await executable(
          '${app.path}/FlClashHelperService',
          'echo "helper \$* owner=\${PKEXEC_UID:-}" >> "\$LOG"',
        );
        File('${app.path}/FlClashCore').writeAsStringSync('core');
        Future<void> run(String key, String argument) async {
          final result = await Process.run(
            '/bin/sh',
            ['-c', script(key), 'package', argument],
            environment: {
              'PATH': '${bin.path}:${Platform.environment['PATH']}',
              'LOG': log.path,
            },
          );
          expect(
            result.exitCode,
            0,
            reason: '${result.stdout}\n${result.stderr}',
          );
        }

        await run('postinstall_scripts', 'configure');
        expect(log.readAsStringSync(), contains('chmod u+s'));
        Directory('${root.path}/systemd').createSync();
        log.writeAsStringSync('');
        await run('postinstall_scripts', 'configure');
        expect(log.readAsStringSync(), contains('chmod u-s'));
        expect(log.readAsStringSync(), isNot(contains('helper install')));
        final unit = File('${units.path}/flclash-helper.service')
          ..writeAsStringSync('Environment=FLCLASH_HELPER_OWNER_UID=1000\n');
        await run('postinstall_scripts', 'configure');
        expect(log.readAsStringSync(), contains('helper install owner=1000'));
        final installed = Directory('${root.path}/installed')..createSync();
        File(
          '${installed.path}/core',
        ).writeAsStringSync('retained until removal');
        log.writeAsStringSync('');
        await run('postuninstall_scripts', format == 'deb' ? 'upgrade' : '1');
        expect(unit.existsSync(), true);
        expect(installed.existsSync(), true);
        expect(log.readAsStringSync(), isEmpty);
        await run('postuninstall_scripts', format == 'deb' ? 'remove' : '0');
        expect(unit.existsSync(), false);
        expect(installed.existsSync(), false);
        expect(log.readAsStringSync(), contains('systemctl disable --now'));
      },
      skip: Platform.isWindows,
    );
  }
}

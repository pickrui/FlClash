import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:proxy/proxy.dart';

void main() {
  group('Linux proxy command builders', () {
    test('builds GNOME commands without duplicate port writes', () {
      final commands = Proxy.buildLinuxStartCommandsForTest(
        port: 7890,
        bypassDomain: ['localhost', '127.0.0.1'],
        desktop: 'GNOME',
        homeDir: '/home/user',
      );

      final portCommands = commands.where(
        (command) => command.args.length == 4 && command.args[2] == 'port',
      );
      final hostCommands = commands.where(
        (command) => command.args.length == 4 && command.args[2] == 'host',
      );

      expect(portCommands, hasLength(3));
      expect(hostCommands, hasLength(3));
      expect(
        commands
            .singleWhere(
              (command) =>
                  command.args.contains('org.gnome.system.proxy') &&
                  command.args.contains('ignore-hosts'),
            )
            .args
            .last,
        "['localhost', '127.0.0.1']",
      );
    });

    test('builds empty GNOME ignore-hosts as an empty list', () {
      final commands = Proxy.buildLinuxStartCommandsForTest(
        port: 7890,
        bypassDomain: const [],
        desktop: 'GNOME',
        homeDir: '/home/user',
      );

      expect(
        commands
            .singleWhere(
              (command) =>
                  command.args.contains('org.gnome.system.proxy') &&
                  command.args.contains('ignore-hosts'),
            )
            .args
            .last,
        '[]',
      );
    });

    test('builds MATE commands with MATE proxy schema', () {
      final commands = Proxy.buildLinuxStartCommandsForTest(
        port: 7890,
        bypassDomain: ['localhost'],
        desktop: 'MATE',
        homeDir: '/home/user',
      );

      expect(
        commands.any(
          (command) => command.args.contains('org.mate.system.proxy'),
        ),
        isTrue,
      );
      expect(
        commands.any(
          (command) => command.args.contains('org.gnome.system.proxy'),
        ),
        isFalse,
      );
    });

    test('falls back to GNOME gsettings commands for XFCE when available', () {
      final commands = Proxy.buildLinuxStartCommandsForTest(
        port: 7890,
        bypassDomain: ['localhost'],
        desktop: 'XFCE',
        homeDir: '/home/user',
        availableExecutables: {'gsettings'},
      );

      expect(commands.map((command) => command.executable).toSet(), {
        'gsettings',
      });
      expect(
        commands.any(
          (command) =>
              command.args.contains('org.gnome.system.proxy') &&
              command.args.contains('manual'),
        ),
        isTrue,
      );
    });

    test('prefers kwriteconfig6 for KDE when available', () {
      final commands = Proxy.buildLinuxStartCommandsForTest(
        port: 7890,
        bypassDomain: ['localhost'],
        desktop: 'KDE',
        homeDir: '/home/user',
        availableExecutables: {'kwriteconfig6', 'kwriteconfig5'},
      );

      expect(commands.map((command) => command.executable).toSet(), {
        'kwriteconfig6',
      });
    });

    test('falls back to kwriteconfig5 for KDE when kwriteconfig6 is missing',
        () {
      final commands = Proxy.buildLinuxStartCommandsForTest(
        port: 7890,
        bypassDomain: ['localhost'],
        desktop: 'KDE',
        homeDir: '/home/user',
        availableExecutables: {'kwriteconfig5'},
      );

      expect(commands.map((command) => command.executable).toSet(), {
        'kwriteconfig5',
      });
    });

    test('uses available backend for unknown desktops', () {
      final commands = Proxy.buildLinuxStartCommandsForTest(
        port: 7890,
        bypassDomain: ['localhost'],
        desktop: 'UNKNOWN',
        homeDir: '/home/user',
        availableExecutables: {'kwriteconfig5'},
      );

      expect(commands.map((command) => command.executable).toSet(), {
        'kwriteconfig5',
      });
    });
  });

  group('macOS proxy command builders', () {
    test(
        'filters networksetup service list headers, disabled services, and blanks',
        () {
      final services = Proxy.parseMacosNetworkServicesForTest('''
An asterisk (*) denotes that a network service is disabled.
Wi-Fi
*Thunderbolt Bridge
USB 10/100/1000 LAN

''');

      expect(services, ['Wi-Fi', 'USB 10/100/1000 LAN']);
    });

    test('passes bypass domains as separate networksetup arguments', () {
      final command = Proxy.buildMacosProxyBypassCommandForTest(
        'Wi-Fi',
        ['localhost', '127.0.0.1'],
      );

      expect(command.executable, '/usr/sbin/networksetup');
      expect(command.args, [
        '-setproxybypassdomains',
        'Wi-Fi',
        'localhost',
        '127.0.0.1',
      ]);
    });

    test('uses Empty when clearing bypass domains', () {
      final command = Proxy.buildMacosProxyBypassCommandForTest(
        'Wi-Fi',
        const [],
      );

      expect(command.args, ['-setproxybypassdomains', 'Wi-Fi', 'Empty']);
    });
  });

  group('proxy state transactions', () {
    test('a new process restores the persisted GNOME snapshot', () async {
      final root = await Directory.systemTemp.createTemp('proxy_state_');
      addTearDown(() => root.delete(recursive: true));
      final statePath = '${root.path}/restore.json';
      final original = _gnomeProxyState();
      final state = Map<String, String>.from(original);
      final runner = _gsettingsRunner(state);
      final firstProcess = Proxy(
        processRunner: runner,
        executableChecker: (executable) async => executable == 'gsettings',
        stateFilePath: statePath,
      );

      expect(
        await firstProcess.startLinuxProxyForTest(
          7890,
          const [],
          desktop: 'GNOME',
          homeDir: '/home/user',
        ),
        true,
      );
      expect(state, isNot(original));
      expect(File(statePath).existsSync(), true);

      final nextProcess = Proxy(
        processRunner: runner,
        executableChecker: (executable) async => executable == 'gsettings',
        stateFilePath: statePath,
      );
      expect(await nextProcess.restoreProxyForTest(), true);
      expect(state, original);
      expect(File(statePath).existsSync(), false);
    });

    test('a corrupt persisted snapshot blocks new proxy changes', () async {
      final root = await Directory.systemTemp.createTemp('proxy_corrupt_');
      addTearDown(() => root.delete(recursive: true));
      final statePath = '${root.path}/restore.json';
      final file = File(statePath)..writeAsStringSync('{corrupt');
      await Process.run('/bin/chmod', ['600', file.path]);
      final state = _gnomeProxyState();
      final original = Map<String, String>.from(state);
      final proxy = Proxy(
        processRunner: _gsettingsRunner(state),
        executableChecker: (executable) async => executable == 'gsettings',
        stateFilePath: statePath,
      );

      expect(
        await proxy.startLinuxProxyForTest(
          7890,
          const [],
          desktop: 'GNOME',
          homeDir: '/home/user',
        ),
        false,
      );
      expect(state, original);
      expect(file.existsSync(), true);
    });

    test('external GNOME changes are preserved on stop', () async {
      final root = await Directory.systemTemp.createTemp('proxy_external_');
      addTearDown(() => root.delete(recursive: true));
      final statePath = '${root.path}/restore.json';
      final state = _gnomeProxyState();
      final proxy = Proxy(
        processRunner: _gsettingsRunner(state),
        executableChecker: (executable) async => executable == 'gsettings',
        stateFilePath: statePath,
      );
      expect(
        await proxy.startLinuxProxyForTest(
          7890,
          const [],
          desktop: 'GNOME',
          homeDir: '/home/user',
        ),
        true,
      );
      state['org.gnome.system.proxy|mode'] = "'auto'";

      expect(await proxy.restoreProxyForTest(), true);
      expect(state['org.gnome.system.proxy|mode'], "'auto'");
      expect(
        Map<String, String>.from(state)..remove('org.gnome.system.proxy|mode'),
        Map<String, String>.from(_gnomeProxyState())
          ..remove('org.gnome.system.proxy|mode'),
      );
      expect(File(statePath).existsSync(), false);
    });

    test('GNOME stop restores the state captured before the first start',
        () async {
      final original = _gnomeProxyState();
      final state = Map<String, String>.from(original);
      final proxy = Proxy(
        processRunner: _gsettingsRunner(state),
        executableChecker: (executable) async => executable == 'gsettings',
      );

      expect(
        await proxy.startLinuxProxyForTest(
          7890,
          ['localhost'],
          desktop: 'GNOME',
          homeDir: '/home/user',
        ),
        true,
      );
      expect(
        await proxy.startLinuxProxyForTest(
          7891,
          ['127.0.0.1'],
          desktop: 'GNOME',
          homeDir: '/home/user',
        ),
        true,
      );
      expect(await proxy.restoreProxyForTest(), true);
      expect(state, original);
    });

    test('a new process restores a pending repeated GNOME start', () async {
      final root = await Directory.systemTemp.createTemp('proxy_pending_');
      addTearDown(() => root.delete(recursive: true));
      final statePath = '${root.path}/restore.json';
      final original = _gnomeProxyState();
      final state = Map<String, String>.from(original);
      final runner = _gsettingsRunner(state);
      final firstProcess = Proxy(
        processRunner: runner,
        executableChecker: (executable) async => executable == 'gsettings',
        stateFilePath: statePath,
      );
      expect(
        await firstProcess.startLinuxProxyForTest(
          7890,
          const [],
          desktop: 'GNOME',
          homeDir: '/home/user',
        ),
        true,
      );

      final snapshot = jsonDecode(File(statePath).readAsStringSync()) as Map;
      final pending = Proxy.buildLinuxStartCommandsForTest(
        port: 7891,
        bypassDomain: const ['localhost'],
        desktop: 'GNOME',
        homeDir: '/home/user',
      )
          .map((command) => {
                'executable': command.executable,
                'args': command.args,
              })
          .toList();
      snapshot['pendingCommands'] = pending;
      File(statePath).writeAsStringSync(jsonEncode(snapshot), flush: true);
      for (final command in pending) {
        final args = List<String>.from(command['args']! as List);
        await runner(command['executable']! as String, args);
      }

      final nextProcess = Proxy(
        processRunner: runner,
        executableChecker: (executable) async => executable == 'gsettings',
        stateFilePath: statePath,
      );
      expect(await nextProcess.restoreProxyForTest(), true);
      expect(state, original);
      expect(File(statePath).existsSync(), false);
    });

    test('GNOME start failure rolls every changed value back', () async {
      final original = _gnomeProxyState();
      final state = Map<String, String>.from(original);
      var failed = false;
      final proxy = Proxy(
        processRunner: _gsettingsRunner(
          state,
          fail: (args) {
            if (!failed && args.last == '7890') {
              failed = true;
              return true;
            }
            return false;
          },
        ),
        executableChecker: (executable) async => executable == 'gsettings',
      );

      expect(
        await proxy.startLinuxProxyForTest(
          7890,
          ['localhost'],
          desktop: 'GNOME',
          homeDir: '/home/user',
        ),
        false,
      );
      expect(state, original);
    });

    test('failed repeated GNOME start keeps the previous FlClash proxy',
        () async {
      final state = _gnomeProxyState();
      var failNextPort = false;
      final proxy = Proxy(
        processRunner: _gsettingsRunner(
          state,
          fail: (args) => failNextPort && args.last == '7891',
        ),
        executableChecker: (executable) async => executable == 'gsettings',
      );

      expect(
        await proxy.startLinuxProxyForTest(
          7890,
          const [],
          desktop: 'GNOME',
          homeDir: '/home/user',
        ),
        true,
      );
      failNextPort = true;
      expect(
        await proxy.startLinuxProxyForTest(
          7891,
          const [],
          desktop: 'GNOME',
          homeDir: '/home/user',
        ),
        false,
      );
      expect(state['org.gnome.system.proxy.http|port'], '7890');
      expect(state['org.gnome.system.proxy.https|port'], '7890');
      expect(state['org.gnome.system.proxy.socks|port'], '7890');
    });

    test('KDE stop deletes keys that did not exist before start', () async {
      final original = <String, String>{
        'NoProxyFor': 'old.local',
        'httpProxy': 'http://old:8080',
        'ReversedException': 'true',
        'ProxyType': '2',
      };
      final state = Map<String, String>.from(original);
      final calls = <List<String>>[];
      final proxy = Proxy(
        processRunner: _kdeRunner(state, calls: calls),
        executableChecker: (executable) async => {
          'kwriteconfig6',
          'kreadconfig6',
        }.contains(executable),
      );

      expect(
        await proxy.startLinuxProxyForTest(
          7890,
          ['localhost'],
          desktop: 'KDE',
          homeDir: '/home/user',
          configHome: '/custom/config',
        ),
        true,
      );
      expect(
        calls.every((args) {
          final fileIndex = args.indexOf('--file');
          return fileIndex == -1 ||
              args[fileIndex + 1] == '/custom/config/kioslaverc';
        }),
        true,
      );
      expect(await proxy.restoreProxyForTest(), true);
      expect(state, original);
    });

    test('KDE ignores relative XDG_CONFIG_HOME values', () {
      final commands = Proxy.buildLinuxStartCommandsForTest(
        port: 7890,
        bypassDomain: const [],
        desktop: 'KDE',
        homeDir: '/home/user',
        configHome: 'relative/config',
        availableExecutables: {'kwriteconfig6'},
      );

      expect(
        commands.every((command) {
          final index = command.args.indexOf('--file');
          return index == -1 ||
              command.args[index + 1] == '/home/user/.config/kioslaverc';
        }),
        true,
      );
    });

    test('KDE falls back to gsettings when its reader is unavailable',
        () async {
      final state = _gnomeProxyState();
      final commands = <String>[];
      final runner = _gsettingsRunner(state);
      final proxy = Proxy(
        processRunner: (
          executable,
          arguments, {
          runInShell = false,
        }) async {
          commands.add(executable);
          return runner(
            executable,
            arguments,
            runInShell: runInShell,
          );
        },
        executableChecker: (executable) async => {
          'kwriteconfig6',
          'gsettings',
        }.contains(executable),
      );

      expect(
        await proxy.startLinuxProxyForTest(
          7890,
          const [],
          desktop: 'KDE',
          homeDir: '/home/user',
        ),
        true,
      );
      expect(commands.toSet(), {'gsettings'});
    });

    test('macOS stop restores proxy endpoints, states, and bypass domains',
        () async {
      final calls = <List<String>>[];
      final outputs = {
        '-getwebproxy': _macosProxyOutput('No', 'old-http', '8080'),
        '-getsecurewebproxy': _macosProxyOutput('Yes', 'old-https', '8443'),
        '-getsocksfirewallproxy': _macosProxyOutput('No', 'old-socks', '1080'),
      };
      var autoProxyEnabled = true;
      var autoDiscoveryEnabled = true;
      var bypassDomains = <String>['old.local', '*.internal'];
      const proxyCommands = {
        '-setwebproxy': '-getwebproxy',
        '-setsecurewebproxy': '-getsecurewebproxy',
        '-setsocksfirewallproxy': '-getsocksfirewallproxy',
      };
      const stateCommands = {
        '-setwebproxystate': '-getwebproxy',
        '-setsecurewebproxystate': '-getsecurewebproxy',
        '-setsocksfirewallproxystate': '-getsocksfirewallproxy',
      };
      final proxy = Proxy(
        processRunner: (
          executable,
          arguments, {
          runInShell = false,
        }) async {
          calls.add(List<String>.from(arguments));
          if (arguments.first == '-listallnetworkservices') {
            return ProcessResult(1, 0, 'Wi-Fi\n', '');
          }
          if (arguments.first == '-getautoproxyurl') {
            return ProcessResult(
              1,
              0,
              _macosAutoProxyOutput(
                autoProxyEnabled ? 'Yes' : 'No',
                'https://old.local/proxy.pac',
              ),
              '',
            );
          }
          if (arguments.first == '-getproxyautodiscovery') {
            return ProcessResult(
              1,
              0,
              'Auto Proxy Discovery: ${autoDiscoveryEnabled ? 'On' : 'Off'}\n',
              '',
            );
          }
          if (outputs.containsKey(arguments.first)) {
            return ProcessResult(1, 0, outputs[arguments.first]!, '');
          }
          if (arguments.first == '-getproxybypassdomains') {
            return ProcessResult(1, 0, '${bypassDomains.join('\n')}\n', '');
          }
          final getProxyCommand = proxyCommands[arguments.first];
          if (getProxyCommand != null) {
            final current = outputs[getProxyCommand]!;
            final enabled = current.contains('Enabled: Yes') ? 'Yes' : 'No';
            outputs[getProxyCommand] = _macosProxyOutput(
              enabled,
              arguments[2],
              arguments[3],
            );
          } else if (stateCommands.containsKey(arguments.first)) {
            final key = stateCommands[arguments.first]!;
            final current = outputs[key]!;
            final values = current.split('\n');
            outputs[key] = values
                .map(
                  (line) => line.startsWith('Enabled:')
                      ? 'Enabled: ${arguments[2] == 'on' ? 'Yes' : 'No'}'
                      : line,
                )
                .join('\n');
          } else if (arguments.first == '-setautoproxystate') {
            autoProxyEnabled = arguments[2] == 'on';
          } else if (arguments.first == '-setproxyautodiscovery') {
            autoDiscoveryEnabled = arguments[2] == 'on';
          } else if (arguments.first == '-setproxybypassdomains') {
            bypassDomains = arguments.skip(2).toList();
            if (bypassDomains.length == 1 && bypassDomains.single == 'Empty') {
              bypassDomains = [];
            }
          }
          return ProcessResult(1, 0, '', '');
        },
      );

      expect(await proxy.startMacosProxyForTest(7890, ['localhost']), true);
      expect(await proxy.restoreProxyForTest(), true);
      expect(
        calls,
        contains(equals(['-setwebproxy', 'Wi-Fi', 'old-http', '8080'])),
      );
      expect(
        calls,
        contains(equals(['-setwebproxystate', 'Wi-Fi', 'off'])),
      );
      expect(
        calls,
        contains(equals(['-setsecurewebproxystate', 'Wi-Fi', 'on'])),
      );
      expect(
        calls,
        contains(
          equals([
            '-setproxybypassdomains',
            'Wi-Fi',
            'old.local',
            '*.internal',
          ]),
        ),
      );
      expect(calls.any((args) => args.first == '-setautoproxyurl'), false);
      expect(
        calls,
        contains(equals(['-setproxyautodiscovery', 'Wi-Fi', 'off'])),
      );
      expect(
        calls,
        contains(equals(['-setproxyautodiscovery', 'Wi-Fi', 'on'])),
      );
      expect(
        calls,
        contains(equals(['-setautoproxystate', 'Wi-Fi', 'on'])),
      );
    });

    test('macOS refuses to replace an authenticated proxy', () async {
      final calls = <List<String>>[];
      final proxy = Proxy(
        processRunner: (
          executable,
          arguments, {
          runInShell = false,
        }) async {
          calls.add(List<String>.from(arguments));
          if (arguments.first == '-listallnetworkservices') {
            return ProcessResult(1, 0, 'Wi-Fi\n', '');
          }
          if (arguments.first == '-getautoproxyurl') {
            return ProcessResult(
              1,
              0,
              _macosAutoProxyOutput('No', '(null)'),
              '',
            );
          }
          if (arguments.first == '-getproxyautodiscovery') {
            return ProcessResult(1, 0, 'Auto Proxy Discovery: Off\n', '');
          }
          return ProcessResult(
            1,
            0,
            _macosProxyOutput('Yes', 'authenticated', '8080',
                authenticated: true),
            '',
          );
        },
      );

      expect(await proxy.startMacosProxyForTest(7890, const []), false);
      expect(calls.any((args) => args.first.startsWith('-set')), false);
    });
  });
}

Map<String, String> _gnomeProxyState() {
  const root = 'org.gnome.system.proxy';
  return {
    '$root|ignore-hosts': "['old.local']",
    '$root.http|host': "'old-http'",
    '$root.http|port': '8080',
    '$root.https|host': "'old-https'",
    '$root.https|port': '8443',
    '$root.socks|host': "'old-socks'",
    '$root.socks|port': '1080',
    '$root|mode': "'auto'",
  };
}

ProxyProcessRunner _gsettingsRunner(
  Map<String, String> state, {
  bool Function(List<String> args)? fail,
}) {
  return (executable, arguments, {runInShell = false}) async {
    final key = '${arguments[1]}|${arguments[2]}';
    if (arguments.first == 'get') {
      final value = state[key];
      final isStringValue = arguments[2] == 'host' || arguments[2] == 'mode';
      final output = value == null ||
              !isStringValue ||
              (value.startsWith("'") && value.endsWith("'"))
          ? value
          : "'${value.replaceAll("'", r"\'")}'";
      return ProcessResult(1, value == null ? 1 : 0, output ?? '', '');
    }
    if (fail?.call(arguments) ?? false) {
      return ProcessResult(1, 1, '', 'failed');
    }
    if (arguments.first == 'set' && arguments.length == 4) {
      state[key] = arguments[3];
      return ProcessResult(1, 0, '', '');
    }
    return ProcessResult(1, 1, '', 'unsupported command');
  };
}

ProxyProcessRunner _kdeRunner(
  Map<String, String> state, {
  List<List<String>>? calls,
}) {
  return (executable, arguments, {runInShell = false}) async {
    calls?.add(List<String>.from(arguments));
    final key = arguments[arguments.indexOf('--key') + 1];
    if (executable.startsWith('kreadconfig')) {
      final defaultValue = arguments[arguments.indexOf('--default') + 1];
      return ProcessResult(1, 0, state[key] ?? defaultValue, '');
    }
    if (arguments.contains('--delete')) {
      state.remove(key);
    } else {
      state[key] = arguments.last;
    }
    return ProcessResult(1, 0, '', '');
  };
}

String _macosProxyOutput(
  String enabled,
  String server,
  String port, {
  bool authenticated = false,
}) {
  return '''
Enabled: $enabled
Server: $server
Port: $port
Authenticated Proxy Enabled: ${authenticated ? 1 : 0}
''';
}

String _macosAutoProxyOutput(String enabled, String url) {
  return '''
URL: $url
Enabled: $enabled
''';
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fl_clash/common/task.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

import 'profile_overlay_test.dart' show overlayState;

// Set FLCLASH_TEST_CORE to a bundled desktop Core executable to run these tests.
// For actual routing, also set FLCLASH_TEST_ROUTING_CHECKER to the executable
// produced by CGO_ENABLED=0 go test -c in core/.
// Every child uses a temporary home, synthetic nodes, and no network providers.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final corePath = Platform.environment['FLCLASH_TEST_CORE'];
  final routingChecker = Platform.environment['FLCLASH_TEST_ROUTING_CHECKER'];

  group(
    'personal overlay native validation',
    () {
      Future<(int, String)> validate(Map<String, dynamic> config) async {
        final home = await Directory.systemTemp.createTemp('flclash_overlay_');
        addTearDown(() => home.delete(recursive: true));
        final errorFile = File('${home.path}/validation-error');
        final process = await Process.start(
          corePath!,
          ['--validate-config', home.path, errorFile.path],
          includeParentEnvironment: false,
          environment: const {
            'SAFE_PATHS': '',
            'SKIP_SAFE_PATH_CHECK': 'false',
          },
        );
        final stdoutDone = process.stdout.drain<void>();
        final stderrDone = process.stderr.drain<void>();
        process.stdin.add(utf8.encode(await encodeYamlTask(config)));
        await process.stdin.close();
        final exitCode = await process.exitCode.timeout(
          const Duration(seconds: 10),
          onTimeout: () {
            process.kill(ProcessSignal.sigkill);
            throw TimeoutException('native overlay validation timed out');
          },
        );
        await Future.wait([stdoutDone, stderrDone]);
        return (
          exitCode,
          await errorFile.exists() ? await errorFile.readAsString() : '',
        );
      }

      Future<Map<String, dynamic>> candidate({
        List<ProxyGroup> groups = const [],
        List<Rule> rules = const [],
        List<Rule> addedRules = const [],
        bool addPersonalNode = false,
      }) => makeRealProfileTask(
        overlayState(
          rawConfig: const {
            'dns': {
              'enable': true,
              'nameserver': ['127.0.0.1'],
            },
            'proxies': [
              {
                'name': 'Japan fixture',
                'type': 'socks5',
                'server': '127.0.0.1',
                'port': 1080,
              },
            ],
            'proxy-groups': [
              {
                'name': 'Subscription',
                'type': 'select',
                'proxies': ['Japan fixture'],
              },
            ],
            'rules': ['MATCH,Subscription'],
          },
          groups: groups,
          rules: rules,
          addedRules: addedRules,
          profileProxies: addPersonalNode
              ? const [
                  ProfileProxy(
                    id: 1,
                    proxy: {'name': 'Personal node', 'type': 'direct'},
                  ),
                ]
              : const [],
        ).copyWith(realPatchConfig: const ClashConfig(geoAutoUpdate: false)),
      );

      test(
        'accepts emitted merged rules and exact personal selector members',
        () async {
          final config = await candidate(
            groups: const [
              ProxyGroup(
                name: 'Personal',
                type: GroupType.Selector,
                proxies: ['Japan fixture'],
              ),
            ],
            rules: const [
              Rule(id: 1, value: 'DOMAIN-SUFFIX,video.example,Personal'),
            ],
            addPersonalNode: true,
          );
          expect((config['proxy-groups'] as List).last['proxies'], [
            'Japan fixture',
          ]);
          expect(config['rules'], [
            'DOMAIN-SUFFIX,video.example,Personal',
            'MATCH,Subscription',
          ]);
          final (exitCode, error) = await validate(config);
          expect(exitCode, 0, reason: error);
        },
      );

      test('accepts an unmatched dynamic group with reject fallback', () async {
        final config = await candidate(
          groups: const [
            ProxyGroup(
              name: 'Empty',
              type: GroupType.URLTest,
              includeAllProxies: true,
              filter: r'^never-matches$',
            ),
          ],
          rules: const [
            Rule(id: 1, value: 'DOMAIN-SUFFIX,video.example,Empty'),
          ],
        );
        expect(
          (config['proxy-groups'] as List).last['empty-fallback'],
          'REJECT',
        );
        final (exitCode, error) = await validate(config);
        expect(exitCode, 0, reason: error);
      });

      test(
        'routes emitted rules by priority and rejects empty dynamic groups',
        () async {
          final config = await candidate(
            groups: const [
              ProxyGroup(
                name: 'Personal',
                type: GroupType.Selector,
                proxies: ['Japan fixture', 'DIRECT'],
              ),
              ProxyGroup(
                name: 'Empty',
                type: GroupType.URLTest,
                includeAllProxies: true,
                filter: r'^never-matches$',
              ),
            ],
            addedRules: const [
              Rule(id: 1, value: 'DOMAIN,priority.video.example,DIRECT'),
            ],
            rules: const [
              Rule(id: 2, value: 'DOMAIN-SUFFIX,video.example,Personal'),
              Rule(id: 3, value: 'DOMAIN,empty.example,Empty'),
            ],
            addPersonalNode: true,
          );
          final home = await Directory.systemTemp.createTemp(
            'flclash_overlay_runtime_',
          );
          addTearDown(() => home.delete(recursive: true));
          final fixture = File('${home.path}/fixture.json');
          await fixture.writeAsString(
            jsonEncode({
              'config': config,
              'checks': [
                {
                  'host': 'priority.video.example',
                  'target': 'DIRECT',
                  'outbound': 'DIRECT',
                },
                {
                  'host': 'watch.video.example',
                  'target': 'Personal',
                  'outbound': 'Japan fixture',
                },
                {
                  'host': 'subscription.example',
                  'target': 'Subscription',
                  'outbound': 'Japan fixture',
                },
                {
                  'host': 'empty.example',
                  'target': 'Empty',
                  'outbound': 'REJECT',
                  'reject': true,
                },
              ],
              'selections': [
                {'group': 'Personal', 'name': 'Personal node', 'valid': false},
                {'group': 'Personal', 'name': 'DIRECT', 'valid': true},
              ],
            }),
          );
          final process = await Process.start(
            routingChecker!,
            [
              '-test.run=^TestPersonalOverlayRuntimeFromGeneratedConfig\$',
              '-test.v',
            ],
            environment: {'FLCLASH_ROUTING_FIXTURE': fixture.path},
          );
          final output = process.stdout.transform(utf8.decoder).join();
          final errors = process.stderr.transform(utf8.decoder).join();
          final exitCode = await process.exitCode.timeout(
            const Duration(seconds: 20),
            onTimeout: () {
              process.kill(ProcessSignal.sigkill);
              throw TimeoutException('native overlay routing timed out');
            },
          );
          final stdout = await output;
          expect(exitCode, 0, reason: '$stdout\n${await errors}');
          expect(
            stdout,
            contains('--- PASS: TestPersonalOverlayRuntimeFromGeneratedConfig'),
            reason: 'The checker must execute the requested routing test',
          );
        },
        skip: routingChecker == null
            ? 'Set FLCLASH_TEST_ROUTING_CHECKER to a compiled core test binary'
            : false,
      );

      test('rejects a personal group with an unavailable member', () async {
        final config = await candidate(
          groups: const [
            ProxyGroup(
              name: 'Personal',
              type: GroupType.Selector,
              proxies: ['Unavailable'],
            ),
          ],
        );
        final (exitCode, error) = await validate(config);
        expect(exitCode, 2);
        expect(error, contains('Unavailable'));
        expect(error, contains('not found'));
      });

      test('rejects a personal rule with an unavailable target', () async {
        final config = await candidate(
          rules: const [
            Rule(id: 1, value: 'DOMAIN-SUFFIX,video.example,Unavailable'),
          ],
        );
        final (exitCode, error) = await validate(config);
        expect(exitCode, 2);
        expect(error, contains('Unavailable'));
        expect(error, contains('not found'));
      });

      test('rejects a cycle in personal groups', () async {
        final config = await candidate(
          groups: const [
            ProxyGroup(
              name: 'Personal A',
              type: GroupType.Selector,
              proxies: ['Personal B'],
            ),
            ProxyGroup(
              name: 'Personal B',
              type: GroupType.Selector,
              proxies: ['Personal A'],
            ),
          ],
        );
        final (exitCode, error) = await validate(config);
        expect(exitCode, 2);
        expect(error, contains('loop'));
      });
    },
    skip: corePath == null
        ? 'Set FLCLASH_TEST_CORE to run bundled-core validation'
        : false,
  );
}

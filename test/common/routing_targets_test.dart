import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/features/overwrite/routing_draft.dart';
import 'package:fl_clash/models/models.dart';
import 'package:test/test.dart';

void main() {
  const profile = Profile(
    id: 1,
    autoUpdateDuration: Duration(hours: 1),
    overwriteType: OverwriteType.merge,
    customProxyGroups: [
      ProxyGroup(
        name: 'Personal automatic',
        type: GroupType.URLTest,
        includeAllProxies: true,
      ),
    ],
    profileProxies: [
      ProfileProxy(id: 1, proxy: {'name': 'Personal node', 'type': 'socks5'}),
      ProfileProxy(
        id: 2,
        enable: false,
        proxy: {'name': 'Disabled node', 'type': 'socks5'},
      ),
      ProfileProxy(id: 3, proxy: {'name': 'Incomplete node'}),
      ProfileProxy(id: 4, proxy: {'name': '   ', 'type': 'socks5'}),
    ],
  );
  const rawConfig = <String, dynamic>{
    'proxy-groups': [
      {'name': 'Subscription group'},
    ],
    'proxies': [
      {'name': 'Subscription node'},
    ],
    'proxy-providers': {
      'Subscription provider': {'type': 'http'},
    },
  };

  test('merge destinations include subscription and personal outbounds', () {
    final targets = customRoutingTargets(profile, rawConfig);

    expect(
      targets,
      containsAll([
        'DIRECT',
        'REJECT',
        'REJECT-DROP',
        'PASS',
        'Personal automatic',
        'Subscription group',
        'Personal node',
        'Subscription node',
      ]),
    );
    expect(targets, isNot(contains('Subscription provider')));
    expect(targets, isNot(contains('Disabled node')));
    expect(targets, isNot(contains('Incomplete node')));
    expect(targets, isNot(contains('   ')));
  });

  test('replacement destinations exclude discarded subscription groups', () {
    final targets = customRoutingTargets(
      profile.copyWith(overwriteType: OverwriteType.custom),
      rawConfig,
    );

    expect(targets, isNot(contains('Subscription group')));
    expect(
      targets,
      containsAll([
        'DIRECT',
        'REJECT',
        'Personal automatic',
        'Personal node',
        'Subscription node',
      ]),
    );
  });

  test('malformed subscription entries do not become destination choices', () {
    final targets = customRoutingTargets(profile, {
      'proxy-groups': [
        {'name': ''},
        {'name': '   '},
        {'name': 7},
        {'name': 'Subscription group'},
        'invalid',
      ],
      'proxies': [
        {'name': '\t'},
        {'name': 'Subscription node'},
        {'type': 'socks5'},
      ],
    });

    expect(targets, containsAll(['Subscription group', 'Subscription node']));
    expect(targets.every((target) => target.trim().isNotEmpty), isTrue);
  });

  test('destination choices deduplicate shared outbound names', () {
    final targets = customRoutingTargets(profile, {
      'proxy-groups': [
        {'name': 'Personal automatic'},
        {'name': 'Subscription group'},
      ],
      'proxies': [
        {'name': 'DIRECT'},
        {'name': 'Personal node'},
        {'name': 'Subscription node'},
        {'name': 'Subscription node'},
      ],
    });

    for (final name in [
      'DIRECT',
      'Personal automatic',
      'Personal node',
      'Subscription node',
    ]) {
      expect(targets.where((target) => target == name), hasLength(1));
    }
  });
}

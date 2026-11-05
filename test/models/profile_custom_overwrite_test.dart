import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:test/test.dart';

void main() {
  test('managed profile skips fetch when account has no config access', () async {
    var fetched = false;
    registerEnsureCloudReady(() async {});
    registerCanFetchManagedConfig(() => false);
    registerFetchManagedConfig((_) async {
      fetched = true;
      throw StateError('fetch must not run');
    });

    const profile = Profile(
      id: 1,
      label: 'Managed',
      url: 'oixcloud://managed',
      autoUpdateDuration: Duration(hours: 1),
    );

    final result = await profile.update();

    expect(result, profile);
    expect(fetched, false);
    registerCanFetchManagedConfig(() => true);
  });

  test(
    'managed profiles exclude device-bound snapshots from portable backup',
    () {
      const managed = Profile(
        id: 1,
        label: 'Managed',
        url: 'oixcloud://managed',
        autoUpdateDuration: Duration(hours: 1),
      );
      const local = Profile(
        id: 2,
        label: 'Local',
        autoUpdateDuration: Duration(hours: 1),
      );

      expect(managed.includeInPortableBackup, false);
      expect(local.includeInPortableBackup, true);
    },
  );

  test('renaming a custom proxy group updates all profile references', () {
    const previous = ProxyGroup(
      name: 'Old',
      type: GroupType.Selector,
      proxies: ['DIRECT'],
    );
    const profile = Profile(
      id: 1,
      autoUpdateDuration: Duration(hours: 1),
      currentGroupName: 'Old',
      selectedMap: {'Old': 'DIRECT', 'Nested': 'Old'},
      unfoldSet: {'Old', 'Nested'},
      proxyChains: [
        ProxyChain(id: 1, proxies: ['Old', 'Proxy A']),
      ],
      customProxyGroups: [
        previous,
        ProxyGroup(name: 'Nested', type: GroupType.Selector, proxies: ['Old']),
      ],
      customRules: [
        Rule(id: 1, value: 'DOMAIN,example.com,Old'),
        Rule(id: 2, value: 'MATCH,Nested'),
        Rule(id: 3, value: 'DOMAIN-WILDCARD,test.*.com,Old'),
        Rule(id: 4, value: 'AND,((DOMAIN,a.com),(NETWORK,TCP)),Old'),
      ],
    );

    final result = profile.copyAndPutCustomProxyGroup(
      previous.copyWith(name: 'New'),
      previous: previous,
    );

    expect(result.currentGroupName, 'New');
    expect(result.selectedMap, {'New': 'DIRECT', 'Nested': 'New'});
    expect(result.unfoldSet, {'New', 'Nested'});
    expect(result.proxyChains.single.proxies, ['New', 'Proxy A']);
    expect(result.customProxyGroups[1].proxies, ['New']);
    expect(result.customRules[0].value, 'DOMAIN,example.com,New');
    expect(result.customRules[1].value, 'MATCH,Nested');
    expect(result.customRules[2].value, 'DOMAIN-WILDCARD,test.*.com,New');
    expect(
      result.customRules[3].value,
      'AND,((DOMAIN,a.com),(NETWORK,TCP)),New',
    );
  });

  test('renameRuleTarget preserves unrelated text and spacing', () {
    expect(renameRuleTarget('MATCH, Old ', 'Old', 'New'), 'MATCH, New ');
    expect(
      renameRuleTarget('DOMAIN-WILDCARD,test.*.com,Other', 'Old', 'New'),
      'DOMAIN-WILDCARD,test.*.com,Other',
    );
    expect(
      renameRuleTarget('SUB-RULE,(NETWORK,TCP),Old', 'Old', 'New'),
      'SUB-RULE,(NETWORK,TCP),Old',
    );
    expect(
      renameRuleTarget('FUTURE-RULE,payload,Old', 'Old', 'New'),
      'FUTURE-RULE,payload,Old',
    );
  });

  test('adding a custom proxy group preserves existing references', () {
    const profile = Profile(id: 1, autoUpdateDuration: Duration(hours: 1));
    const group = ProxyGroup(name: 'New', type: GroupType.Selector);

    final result = profile.copyAndPutCustomProxyGroup(group);

    expect(result.customProxyGroups, [group]);
  });

  test('raw proxy group names come from the edited profile config', () {
    expect(
      rawProxyGroupNames({
        'proxy-groups': [
          {'name': ' Target '},
          {'name': ''},
          {'name': 7},
          'invalid',
        ],
      }),
      {'Target'},
    );
    expect(rawProxyGroupNames(const {}), isEmpty);
  });

  test('detects semantic references before deleting an outbound', () {
    const profile = Profile(
      id: 1,
      autoUpdateDuration: Duration(hours: 1),
      customProxyGroups: [
        ProxyGroup(
          name: 'Nested',
          type: GroupType.Selector,
          proxies: ['Target'],
        ),
      ],
      customRules: [Rule(id: 1, value: 'MATCH,Target')],
      proxyChains: [
        ProxyChain(id: 1, proxies: ['Target', 'Proxy A']),
      ],
    );

    expect(profile.hasCustomOutboundReferences('Target'), true);
    expect(profile.hasCustomOutboundReferences('Other'), false);
  });

  test('removing an unreferenced group clears UI selection caches', () {
    const group = ProxyGroup(name: 'Target', type: GroupType.Selector);
    const profile = Profile(
      id: 1,
      autoUpdateDuration: Duration(hours: 1),
      currentGroupName: 'Target',
      selectedMap: {'Target': 'DIRECT', 'Nested': 'Target'},
      unfoldSet: {'Target', 'Nested'},
      customProxyGroups: [group],
    );

    final result = profile.copyAndRemoveCustomProxyGroup(group);

    expect(result.currentGroupName, isNull);
    expect(result.selectedMap, isEmpty);
    expect(result.unfoldSet, {'Nested'});
    expect(result.customProxyGroups, isEmpty);
  });

  test('renaming a custom node updates custom group and rule references', () {
    const profile = Profile(
      id: 1,
      autoUpdateDuration: Duration(hours: 1),
      customProxyGroups: [
        ProxyGroup(
          name: 'Group',
          type: GroupType.Selector,
          proxies: ['Node A'],
        ),
      ],
      customRules: [Rule(id: 1, value: 'MATCH,Node A')],
    );

    final result = profile.copyAndRenameOutboundReferences('Node A', 'Node B');

    expect(result.customProxyGroups.single.proxies, ['Node B']);
    expect(result.customRules.single.value, 'MATCH,Node B');
  });

  test('removing an outbound clears selected and visible caches', () {
    const profile = Profile(
      id: 1,
      autoUpdateDuration: Duration(hours: 1),
      currentGroupName: 'Node A',
      selectedMap: {'Group': 'Node A', 'Node A': 'DIRECT'},
      unfoldSet: {'Group', 'Node A'},
    );

    final result = profile.copyAndRemoveOutboundCaches({'Node A'});

    expect(result.currentGroupName, isNull);
    expect(result.selectedMap, isEmpty);
    expect(result.unfoldSet, {'Group'});
  });

  test('findRawOutboundReference reports exact mihomo reference paths', () {
    expect(
      findRawOutboundReference({
        'proxies': [
          {'name': 'Node', 'dialer-proxy': 'Target'},
        ],
      }, 'Target'),
      'proxies[0].dialer-proxy',
    );
    expect(
      findRawOutboundReference({
        'proxy-providers': {
          'Provider': {
            'override': {'dialer-proxy': 'Target'},
          },
        },
      }, 'Target'),
      'proxy-providers.Provider.override.dialer-proxy',
    );
    expect(
      findRawOutboundReference({
        'rule-providers': {
          'Rules': {'proxy': 'Target'},
        },
      }, 'Target'),
      'rule-providers.Rules.proxy',
    );
    expect(
      findRawOutboundReference({
        'sub-rules': {
          'nested': ['DOMAIN,example.com,Target'],
        },
      }, 'Target'),
      'sub-rules.nested[0]',
    );
  });

  test('findProxyGroupCycle detects self and indirect cycles', () {
    expect(
      findProxyGroupCycle(const [
        ProxyGroup(name: 'A', type: GroupType.Selector, proxies: ['A']),
      ]),
      'A',
    );
    expect(
      findProxyGroupCycle(const [
        ProxyGroup(name: 'A', type: GroupType.Selector, proxies: ['B']),
        ProxyGroup(name: 'B', type: GroupType.Selector, proxies: ['A']),
      ]),
      isNotNull,
    );
    expect(
      findProxyGroupCycle(const [
        ProxyGroup(name: 'A', type: GroupType.Selector, proxies: ['B']),
        ProxyGroup(name: 'B', type: GroupType.Selector, proxies: ['DIRECT']),
      ]),
      isNull,
    );
  });

  test('proxy chain conflict includes existing dialer-proxy relations', () {
    expect(
      findProxyChainConflictName(
        const [
          ProxyChain(id: 1, proxies: ['A', 'B']),
        ],
        existingRelations: const {'A': 'B'},
      ),
      isNotNull,
    );
  });

  test('DNS URL fragments are outbound references', () {
    expect(
      findRawOutboundReference({
        'dns': {
          'nameserver': ['https://dns.example/dns-query#Target'],
        },
      }, 'Target'),
      'dns.nameserver[0]',
    );
  });

  test(
    'raw top-level rules can be excluded when custom rules replace them',
    () {
      final rawConfig = {
        'rules': ['MATCH,Target'],
      };

      expect(findRawOutboundReference(rawConfig, 'Target'), 'rules[0]');
      expect(
        findRawOutboundReference(
          rawConfig,
          'Target',
          includeTopLevelRules: false,
        ),
        isNull,
      );
    },
  );
}

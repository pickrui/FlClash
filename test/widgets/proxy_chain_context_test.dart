import 'package:fl_clash/features/overwrite/proxy_chain.dart';
import 'package:test/test.dart';

void main() {
  test('processed overwrite nodes are available to proxy chains', () {
    final context = buildProxyChainRawContext(
      customNodesLabel: 'Custom',
      otherNodesLabel: 'Other',
      rawConfig: {
        'proxies': [
          {'name': 'Original Node', 'type': 'ss'},
          {'name': 'Override Node', 'type': 'vmess'},
        ],
        'proxy-groups': [
          {
            'name': 'Override Group',
            'type': 'select',
            'proxies': ['Override Node'],
          },
        ],
      },
    );

    expect(
      context.sections.expand((section) => section.proxies),
      contains('Override Node'),
    );
    expect(context.nameScope.targetNames, contains('Override Node'));
    expect(context.nameScope.dialerNames, contains('Override Group'));
    expect(context.existingRelations, isEmpty);
  });

  test('raw proxy-chain context excludes provider-expanded nodes', () {
    final context = buildProxyChainRawContext(
      customNodesLabel: 'Custom',
      otherNodesLabel: 'Other',
      rawConfig: {
        'proxies': [
          {'name': 'Node A', 'type': 'ss'},
        ],
        'proxy-providers': {
          'Airport': {'type': 'http'},
        },
        'proxy-groups': [
          {
            'name': 'Proxy',
            'type': 'select',
            'proxies': ['Node A'],
            'use': ['Airport'],
          },
        ],
      },
    );

    final candidates = context.sections
        .expand((section) => section.proxies)
        .toSet();
    expect(candidates, contains('Node A'));
    expect(candidates, isNot(contains('Airport')));
    expect(context.nameScope.targetNames, {'Node A'});
    expect(context.nameScope.dialerNames, {'Node A', 'Proxy'});
  });

  test('candidate sections do not depend on proxy-group order', () {
    const proxy = {
      'name': 'Proxy',
      'type': 'select',
      'proxies': ['Auto', 'A'],
    };
    const auto = {
      'name': 'Auto',
      'type': 'url-test',
      'proxies': ['A'],
    };
    Set<String> candidatesFor(List<Map<String, Object>> groups) {
      final context = buildProxyChainRawContext(
        customNodesLabel: 'Custom',
        otherNodesLabel: 'Other',
        rawConfig: {
          'proxies': [
            {'name': 'A', 'type': 'ss'},
          ],
          'proxy-groups': groups,
        },
      );
      expect(context.nameScope.dialerNames, {'A', 'Proxy', 'Auto'});
      return context.sections.expand((section) => section.proxies).toSet();
    }

    expect(candidatesFor([proxy, auto]), {'A'});
    expect(candidatesFor([auto, proxy]), {'A'});
  });
}

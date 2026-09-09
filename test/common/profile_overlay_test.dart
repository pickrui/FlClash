import 'package:fl_clash/common/task.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

MakeRealProfileState overlayState({
  required Map<String, dynamic> rawConfig,
  OverwriteType overwriteType = OverwriteType.merge,
  List<ProxyGroup> groups = const [],
  List<Rule> rules = const [],
  List<Rule> addedRules = const [],
  List<ProfileProxy> profileProxies = const [],
}) => MakeRealProfileState(
  profilesPath: '/profiles',
  profileId: 1,
  overwriteType: overwriteType,
  rawConfig: rawConfig,
  realPatchConfig: const ClashConfig(),
  overrideDns: false,
  appendSystemDns: false,
  addedRules: addedRules,
  proxyChains: const [],
  profileProxies: profileProxies,
  customProxyGroups: groups,
  customRules: rules,
  defaultUA: 'FlClash',
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const personalGroup = ProxyGroup(
    name: 'Personal',
    type: GroupType.URLTest,
    includeAllProxies: true,
    filter: 'Japan',
  );
  const personalRules = [
    Rule(id: 1, value: 'DOMAIN-SUFFIX,video.example,Personal'),
  ];

  test(
    'subscription refresh merges current data with the same personal overlay',
    () async {
      for (final revision in [1, 2]) {
        final raw = <String, dynamic>{
          'proxies': [
            {'name': 'Japan $revision', 'type': 'direct'},
          ],
          'proxy-groups': [
            {
              'name': 'Subscription',
              'type': 'select',
              'proxies': ['Japan $revision'],
            },
          ],
          'rules': [
            'DOMAIN-SUFFIX,revision$revision.example,REJECT',
            'MATCH,Subscription',
          ],
        };
        final result = await makeRealProfileTask(
          overlayState(
            rawConfig: raw,
            groups: const [personalGroup],
            rules: personalRules,
            addedRules: const [
              Rule(id: 2, value: 'DOMAIN,local.example,DIRECT'),
            ],
          ),
        );

        expect((result['proxy-groups'] as List).map((group) => group['name']), [
          'Subscription',
          'Personal',
        ]);
        expect(result['proxies'], [
          {'name': 'Japan $revision', 'type': 'direct'},
        ]);
        expect(result['rules'], [
          'DOMAIN,local.example,DIRECT',
          'DOMAIN-SUFFIX,video.example,Personal',
          'DOMAIN-SUFFIX,revision$revision.example,REJECT',
          'MATCH,Subscription',
        ]);
        expect((raw['proxy-groups'] as List).length, 1);
        expect((raw['rules'] as List).length, 2);
      }
    },
  );

  test(
    'empty dynamic personal groups block instead of switching to direct',
    () async {
      final result = await makeRealProfileTask(
        overlayState(
          rawConfig: const {
            'proxies': [],
            'rules': ['MATCH,DIRECT'],
          },
          groups: const [personalGroup],
          rules: personalRules,
        ),
      );
      expect((result['proxy-groups'] as List).single, {
        'name': 'Personal',
        'type': 'url-test',
        'include-all-proxies': true,
        'filter': 'Japan',
        'empty-fallback': 'REJECT',
      });
    },
  );

  test(
    'added MATCH placeholders still follow the subscription final target',
    () async {
      final result = await makeRealProfileTask(
        overlayState(
          rawConfig: const {
            'rules': ['MATCH,Subscription'],
          },
          groups: const [personalGroup],
          rules: personalRules,
          addedRules: const [Rule(id: 2, value: 'DOMAIN,local.example,MATCH')],
        ),
      );
      expect(
        (result['rules'] as List).first,
        'DOMAIN,local.example,Subscription',
      );
    },
  );

  test('an empty overlay preserves subscription groups and rules', () async {
    const raw = {
      'proxy-groups': [
        {
          'name': 'Subscription',
          'type': 'select',
          'proxies': ['DIRECT'],
        },
      ],
      'rules': ['MATCH,Subscription'],
    };
    final result = await makeRealProfileTask(overlayState(rawConfig: raw));
    expect(result['proxy-groups'], raw['proxy-groups']);
    expect(result['rules'], raw['rules']);
  });

  for (final name in [...reservedOutboundNames, 'Subscription', 'Japan']) {
    test('merge rejects occupied outbound name $name', () async {
      await expectLater(
        makeRealProfileTask(
          overlayState(
            rawConfig: const {
              'proxies': [
                {'name': 'Japan', 'type': 'direct'},
              ],
              'proxy-groups': [
                {
                  'name': 'Subscription',
                  'type': 'select',
                  'proxies': ['Japan'],
                },
              ],
              'rules': ['MATCH,Subscription'],
            },
            groups: [
              ProxyGroup(
                name: name,
                type: GroupType.Selector,
                proxies: const ['DIRECT'],
              ),
            ],
          ),
        ),
        throwsA(
          isA<OverlayNameConflictException>().having(
            (error) => error.name,
            'name',
            name,
          ),
        ),
      );
    });
  }

  test('merge rejects a group that shadows a subscription provider', () async {
    await expectLater(
      makeRealProfileTask(
        overlayState(
          rawConfig: const {
            'proxy-providers': {
              'Personal': {
                'type': 'inline',
                'payload': [
                  {'name': 'Japan', 'type': 'direct'},
                ],
              },
            },
            'rules': ['MATCH,DIRECT'],
          },
          groups: const [
            ProxyGroup(
              name: 'Personal',
              type: GroupType.Selector,
              proxies: ['DIRECT'],
            ),
          ],
        ),
      ),
      throwsA(
        isA<OverlayNameConflictException>().having(
          (error) => error.name,
          'name',
          'Personal',
        ),
      ),
    );
  });

  test('merge rejects duplicate personal groups', () async {
    await expectLater(
      makeRealProfileTask(
        overlayState(
          rawConfig: const {
            'rules': ['MATCH,DIRECT'],
          },
          groups: const [personalGroup, personalGroup],
        ),
      ),
      throwsA(isA<OverlayNameConflictException>()),
    );
  });

  test(
    'merge rejects personal group names shared by a personal node',
    () async {
      await expectLater(
        makeRealProfileTask(
          overlayState(
            rawConfig: const {
              'rules': ['MATCH,DIRECT'],
            },
            groups: const [personalGroup],
            profileProxies: const [
              ProfileProxy(
                id: 1,
                proxy: {'name': 'Personal', 'type': 'direct'},
              ),
            ],
          ),
        ),
        throwsA(isA<OverlayNameConflictException>()),
      );
    },
  );

  test('personal selectors retain the members selected by the user', () async {
    const rawConfig = {
      'proxy-groups': [
        {
          'name': 'Subscription',
          'type': 'select',
          'proxies': ['DIRECT'],
        },
      ],
      'rules': ['MATCH,Subscription'],
    };
    final result = await makeRealProfileTask(
      overlayState(
        rawConfig: rawConfig,
        groups: const [
          ProxyGroup(
            name: 'Personal',
            type: GroupType.Selector,
            proxies: ['DIRECT'],
          ),
        ],
        profileProxies: const [
          ProfileProxy(
            id: 1,
            proxy: {'name': 'Personal node', 'type': 'direct'},
          ),
        ],
      ),
    );
    final groups = result['proxy-groups'] as List;
    expect(groups.first['proxies'], ['DIRECT', 'Personal node']);
    expect(groups.last['proxies'], ['DIRECT']);
    expect((rawConfig['proxy-groups'] as List).single['proxies'], ['DIRECT']);
  });

  for (final raw in <Map<String, dynamic>>[
    {
      'proxy-groups': [
        {
          'name': 'Subscription',
          'type': 'select',
          'proxies': ['DIRECT'],
        },
      ],
      'rules': ['MATCH,Subscription'],
    },
    {
      'rules': ['MATCH,REJECT'],
    },
    {
      'proxy-groups': [
        {
          'name': 'Subscription',
          'type': 'select',
          'proxies': ['DIRECT'],
        },
      ],
    },
  ]) {
    test('empty replacement rejects existing routing: ${raw.keys}', () async {
      await expectLater(
        makeRealProfileTask(
          overlayState(rawConfig: raw, overwriteType: OverwriteType.custom),
        ),
        throwsA(isA<EmptyCustomOverwriteException>()),
      );
    });
  }

  test('an empty replacement accepts an already empty profile', () async {
    final result = await makeRealProfileTask(
      overlayState(
        rawConfig: const {'proxy-groups': [], 'rules': []},
        overwriteType: OverwriteType.custom,
      ),
    );
    expect(result['proxy-groups'], isEmpty);
    expect(result['rules'], isEmpty);
  });

  test('rule-only replacement keeps its intentional routing', () async {
    final result = await makeRealProfileTask(
      overlayState(
        rawConfig: const {
          'proxy-groups': [
            {
              'name': 'Subscription',
              'type': 'select',
              'proxies': ['DIRECT'],
            },
          ],
          'rules': ['MATCH,Subscription'],
        },
        overwriteType: OverwriteType.custom,
        rules: const [Rule(id: 1, value: 'MATCH,REJECT')],
      ),
    );
    expect(result['proxy-groups'], isEmpty);
    expect(result['rules'], ['MATCH,REJECT']);
  });

  test('group-only replacement keeps its intentional routing', () async {
    final result = await makeRealProfileTask(
      overlayState(
        rawConfig: const {
          'rules': ['MATCH,DIRECT'],
        },
        overwriteType: OverwriteType.custom,
        groups: const [
          ProxyGroup(
            name: 'Personal',
            type: GroupType.Selector,
            proxies: ['REJECT'],
          ),
        ],
      ),
    );
    expect((result['proxy-groups'] as List).single['name'], 'Personal');
    expect(result['rules'], isEmpty);
  });

  test('replace mode still replaces subscription groups and rules', () async {
    const replacement = ProxyGroup(
      name: 'Subscription',
      type: GroupType.Selector,
      proxies: ['REJECT'],
    );
    final result = await makeRealProfileTask(
      overlayState(
        overwriteType: OverwriteType.custom,
        rawConfig: const {
          'proxy-groups': [
            {
              'name': 'Subscription',
              'type': 'select',
              'proxies': ['DIRECT'],
            },
          ],
          'rules': ['MATCH,Subscription'],
        },
        groups: const [replacement],
        rules: const [Rule(id: 1, value: 'MATCH,REJECT')],
      ),
    );
    expect(result['proxy-groups'], [
      {
        'name': 'Subscription',
        'type': 'select',
        'proxies': ['REJECT'],
      },
    ]);
    expect(result['rules'], ['MATCH,REJECT']);
  });
}

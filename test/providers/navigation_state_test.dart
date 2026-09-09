import 'dart:convert';

import 'package:fl_clash/common/task.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/providers/database.dart';
import 'package:fl_clash/providers/state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

Future<List<Group>> _decodeGroups(Map<String, dynamic> snapshot) {
  return toGroupsTask(
    ComputeGroupsState(
      proxiesData: ProxiesData.fromJson(jsonDecode(jsonEncode(snapshot))),
      sortType: ProxiesSortType.none,
      delayMap: const {},
      selectedMap: const {},
      defaultTestUrl: '',
    ),
  );
}

Map<String, dynamic> _collidingSnapshot(String selected) {
  return {
    'proxies': {
      'Personal': {
        'name': 'Personal',
        'type': 'Selector',
        'hidden': false,
        'now': selected,
        'all': ['Personal', 'Backup'],
      },
      'Backup': {'name': 'Backup', 'type': 'Vmess'},
    },
    'all': ['Personal', 'Backup'],
    'groupMembers': {
      'Personal': {
        'Personal': {'name': 'Personal', 'type': 'Shadowsocks'},
      },
    },
  };
}

ProviderContainer _navigationContainer(List<Group> groups, double width) {
  return ProviderContainer(
    overrides: [
      initProvider.overrideWithBuild((_, _) => true),
      groupsProvider.overrideWithBuild((_, _) => groups),
      profilesProvider.overrideWithBuild(
        (_, _) => const [Profile(id: 1, autoUpdateDuration: Duration(days: 1))],
      ),
      patchClashConfigProvider.overrideWithBuild(
        (_, _) => const ClashConfig(mode: Mode.rule),
      ),
      appSettingProvider.overrideWithBuild((_, _) => const AppSettingProps()),
      viewWidthProvider.overrideWithValue(width),
    ],
  );
}

void _expectProxiesPage(ProviderContainer container, String groupName) {
  expect(
    container.read(currentGroupsStateProvider).value.map((group) => group.name),
    [groupName],
  );
  expect(
    container
        .read(currentNavigationItemsStateProvider)
        .value
        .map((item) => item.label),
    contains(PageLabel.proxies),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  for (final (layout, width) in [('mobile', 400.0), ('desktop', 1200.0)]) {
    group('$layout proxy navigation', () {
      test(
        'survives repeated snapshots with a member sharing its group name',
        () async {
          final initialGroups = await _decodeGroups(
            _collidingSnapshot('Personal'),
          );
          final container = _navigationContainer(initialGroups, width);
          addTearDown(container.dispose);
          final pageVisibility = <bool>[];
          container.listen(
            currentNavigationItemsStateProvider,
            (_, state) => pageVisibility.add(
              state.value.any((item) => item.label == PageLabel.proxies),
            ),
            fireImmediately: true,
          );

          for (final selected in ['Personal', 'Backup', 'Personal']) {
            final groups = await _decodeGroups(_collidingSnapshot(selected));
            expect(groups.single.type, GroupType.Selector);
            expect(groups.single.now, selected);
            expect(groups.single.all, const [
              Proxy(name: 'Personal', type: 'Shadowsocks'),
              Proxy(name: 'Backup', type: 'Vmess'),
            ]);

            container.read(groupsProvider.notifier).update((_) => groups);
            _expectProxiesPage(container, 'Personal');
            expect(
              container
                  .read(currentGroupsStateProvider)
                  .value
                  .single
                  .all
                  .first
                  .type,
              'Shadowsocks',
            );
          }

          expect(pageVisibility, isNotEmpty);
          expect(pageVisibility, everyElement(isTrue));
        },
      );

      test('honors explicitly hidden groups in rule mode', () async {
        final groups = await _decodeGroups({
          'proxies': {
            'Proxy': {
              'name': 'Proxy',
              'type': 'Selector',
              'hidden': false,
              'now': 'Node',
              'all': ['Node'],
            },
            'Hidden': {
              'name': 'Hidden',
              'type': 'Selector',
              'hidden': true,
              'now': 'Node',
              'all': ['Node'],
            },
            'Node': {'name': 'Node', 'type': 'Shadowsocks'},
          },
          'all': ['Proxy', 'Hidden', 'Node'],
        });
        final container = _navigationContainer(groups, width);
        addTearDown(container.dispose);

        expect(groups.last.hidden, isTrue);
        _expectProxiesPage(container, 'Proxy');

        container.read(groupsProvider.notifier).update((_) => [groups.last]);
        expect(container.read(currentGroupsStateProvider).value, isEmpty);
        expect(
          container
              .read(currentNavigationItemsStateProvider)
              .value
              .map((item) => item.label),
          isNot(contains(PageLabel.proxies)),
        );
      });

      test(
        'keeps the proxy page for legacy snapshots without scoped members',
        () async {
          final groups = await _decodeGroups({
            'proxies': {
              'Proxy': {
                'name': 'Proxy',
                'type': 'Selector',
                'now': 'Node',
                'all': ['Node'],
              },
              'Node': {'name': 'Node', 'type': 'Shadowsocks'},
            },
            'all': ['Proxy', 'Node'],
          });
          final container = _navigationContainer(groups, width);
          addTearDown(container.dispose);

          expect(
            groups.single.all.single,
            const Proxy(name: 'Node', type: 'Shadowsocks'),
          );
          expect(groups.single.hidden, isNull);
          _expectProxiesPage(container, 'Proxy');
        },
      );
    });
  }
}

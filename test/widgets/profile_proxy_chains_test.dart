import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/features/overwrite/overwrite.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/manager/status_manager.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/database.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';
import '../helpers/test_profiles.dart';

class _SetupAction extends SetupAction {
  final Map<String, dynamic> rawConfig;
  final Map<String, dynamic> chainConfig;
  Object? chainConfigError;
  var rawLoads = 0;
  var chainLoads = 0;
  var applies = 0;
  var autoApplies = 0;

  _SetupAction({this.rawConfig = const {}, this.chainConfig = const {}});

  @override
  Future<Map<String, dynamic>> getRawProfileConfig(int profileId) async {
    rawLoads++;
    return rawConfig;
  }

  @override
  Future<Map<String, dynamic>> getProxyChainProfileConfig(int profileId) async {
    chainLoads++;
    final error = chainConfigError;
    if (error != null) throw error;
    return chainConfig;
  }

  @override
  void applyProfileDebounce({bool silence = false, bool force = false}) {
    applies++;
  }

  @override
  void autoApplyProfile() {
    autoApplies++;
  }
}

class _Status extends StatusManager {
  final List<String> messages;

  const _Status({required this.messages, required super.child});

  @override
  State<StatusManager> createState() => _StatusState();
}

class _StatusState extends StatusManagerState {
  @override
  void message(String text, {MessageActionState? actionState}) {
    (widget as _Status).messages.add(text);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

const _baseProfile = Profile(id: 1, autoUpdateDuration: Duration(hours: 1));

AppLocalizations get _l10n => AppLocalizations.current;

Future<(TestProfiles, List<String>)> _pump(
  WidgetTester tester,
  _SetupAction setupAction,
  Profile profile, {
  Widget? child,
}) async {
  final profiles = TestProfiles([profile]);
  final messages = <String>[];
  await tester.pumpWidget(
    TestApp(
      locale: const Locale('en'),
      overrides: [
        profilesProvider.overrideWith(() => profiles),
        currentProfileIdProvider.overrideWithBuild((_, _) => 1),
        viewSizeProvider.overrideWithBuild((_, _) => const Size(800, 600)),
        setupActionProvider.overrideWith(() => setupAction),
      ],
      homeBuilder: (child) => _Status(messages: messages, child: child),
      child:
          child ??
          const Scaffold(
            body: CustomScrollView(
              slivers: [ProfileProxyChainsContent(profileId: 1)],
            ),
          ),
    ),
  );
  await tester.pumpAndSettle();
  return (profiles, messages);
}

Finder _tile(String title) =>
    find.widgetWithText(OverwriteEntryTile, title).first;

Finder _switchOf(String title) =>
    find.descendant(of: _tile(title), matching: find.byType(Switch));

Future<void> _deleteFromMenu(WidgetTester tester, String title) async {
  await tester.tap(
    find.descendant(of: _tile(title), matching: find.byIcon(Icons.more_vert)),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text(_l10n.delete));
  await tester.pumpAndSettle();
  await tester.tap(find.text(_l10n.confirm));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('enabling a chain through an unavailable node keeps it off', (
    tester,
  ) async {
    final setupAction = _SetupAction(
      chainConfig: {
        'proxies': [
          {'name': 'A', 'type': 'ss'},
        ],
      },
    );
    final (profiles, messages) = await _pump(
      tester,
      setupAction,
      _baseProfile.copyWith(
        profileProxies: const [
          ProfileProxy(
            id: 10,
            enable: false,
            proxy: {'name': 'N', 'type': 'ss'},
          ),
        ],
        proxyChains: const [
          ProxyChain(id: 20, name: 'Chain', enable: false, proxies: ['A', 'N']),
        ],
      ),
    );

    await tester.tap(_switchOf('Chain'));
    await tester.pumpAndSettle();

    expect(messages, [_l10n.proxyChainUnavailableNodeTip('N')]);
    expect(profiles.state.single.proxyChains.single.enable, isFalse);
    expect(setupAction.applies, 0);
  });

  testWidgets('a failing profile build is reported and does not block off', (
    tester,
  ) async {
    final setupAction = _SetupAction()
      ..chainConfigError = Exception('snapshot unavailable');
    final (profiles, messages) = await _pump(
      tester,
      setupAction,
      _baseProfile.copyWith(
        proxyChains: const [
          ProxyChain(id: 20, name: 'Chain', proxies: ['A', 'B']),
        ],
      ),
    );

    await tester.tap(_switchOf('Chain'));
    await tester.pumpAndSettle();
    expect(profiles.state.single.proxyChains.single.enable, isFalse);
    expect(setupAction.chainLoads, 0);
    expect(setupAction.applies, 1);

    await tester.tap(_switchOf('Chain'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, _l10n.add).last);
    await tester.pumpAndSettle();
    expect(messages, [
      'Exception: snapshot unavailable',
      'Exception: snapshot unavailable',
    ]);
    expect(profiles.state.single.proxyChains.single.enable, isFalse);
    expect(setupAction.applies, 1);
    expect(tester.takeException(), isNull);
  });

  group('custom node overriding a subscription node', () {
    final rawConfig = <String, dynamic>{
      'proxies': [
        {'name': 'HK', 'type': 'ss'},
      ],
      'proxy-groups': [
        {
          'name': 'Proxy',
          'type': 'select',
          'proxies': ['HK'],
        },
      ],
    };
    final profile = _baseProfile.copyWith(
      overwriteType: OverwriteType.custom,
      matchTarget: 'HK',
      selectedMap: const {'Personal': 'HK'},
      customProxyGroups: const [
        ProxyGroup(name: 'Personal', type: GroupType.Selector, proxies: ['HK']),
      ],
      profileProxies: const [
        ProfileProxy(id: 10, proxy: {'name': 'HK', 'type': 'vmess'}),
        ProfileProxy(id: 11, proxy: {'name': 'Solo', 'type': 'ss'}),
      ],
      proxyChains: const [
        ProxyChain(id: 20, name: 'Chain', proxies: ['HK', 'Exit']),
      ],
    );

    void expectReferencesKept(Profile next) {
      expect(next.matchTarget, 'HK');
      expect(next.selectedMap, {'Personal': 'HK'});
      expect(next.proxyChains.single, profile.proxyChains.single);
    }

    testWidgets('can be switched off', (tester) async {
      final setupAction = _SetupAction(rawConfig: rawConfig);
      final (profiles, messages) = await _pump(tester, setupAction, profile);

      await tester.tap(_switchOf('HK'));
      await tester.pumpAndSettle();

      expect(messages, isEmpty);
      final next = profiles.state.single;
      expect(next.profileProxies.first.enable, isFalse);
      expectReferencesKept(next);
    });

    testWidgets('can be deleted with others after one raw config load', (
      tester,
    ) async {
      final setupAction = _SetupAction(rawConfig: rawConfig);
      final (profiles, messages) = await _pump(tester, setupAction, profile);

      await tester.tap(find.text('Solo'));
      await tester.pumpAndSettle();
      await tester.tap(_tile('HK'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithIcon(IconButton, Icons.delete));
      await tester.pumpAndSettle();
      await tester.tap(find.text(_l10n.confirm));
      await tester.pumpAndSettle();

      expect(messages, isEmpty);
      expect(setupAction.rawLoads, 1);
      final next = profiles.state.single;
      expect(next.profileProxies, isEmpty);
      expectReferencesKept(next);
    });

    testWidgets('still guards a node only the custom config defines', (
      tester,
    ) async {
      final setupAction = _SetupAction(rawConfig: rawConfig);
      final (profiles, messages) = await _pump(
        tester,
        setupAction,
        profile.copyWith(matchTarget: 'Solo'),
      );

      await _deleteFromMenu(tester, 'Solo');

      expect(messages, [_l10n.customOutboundInUse('Solo')]);
      expect(profiles.state.single.profileProxies, hasLength(2));
    });
  });

  testWidgets('a raw reference still blocks deleting a custom-only node', (
    tester,
  ) async {
    final setupAction = _SetupAction(
      rawConfig: {
        'proxy-groups': [
          {
            'name': 'Proxy',
            'type': 'select',
            'proxies': ['Solo'],
          },
        ],
      },
    );
    final (profiles, messages) = await _pump(
      tester,
      setupAction,
      _baseProfile.copyWith(
        profileProxies: const [
          ProfileProxy(id: 11, proxy: {'name': 'Solo', 'type': 'ss'}),
        ],
      ),
    );

    await _deleteFromMenu(tester, 'Solo');

    expect(messages, [
      _l10n.rawOutboundInUse('Solo', 'proxy-groups[0].proxies[0]'),
    ]);
    expect(profiles.state.single.profileProxies, hasLength(1));
  });

  testWidgets('closing the proxy chain page applies the profile', (
    tester,
  ) async {
    final setupAction = _SetupAction();
    await _pump(
      tester,
      setupAction,
      _baseProfile,
      child: const ProfileProxyChainsView(profileId: 1),
    );
    expect(setupAction.autoApplies, 0);

    await tester.pumpWidget(const SizedBox());

    expect(tester.takeException(), isNull);
    expect(setupAction.autoApplies, 1);
  });

  test('renaming into a chain that already uses the name is a conflict', () {
    const chains = [
      ProxyChain(id: 1, proxies: ['A', 'B']),
      ProxyChain(id: 2, enable: false, proxies: ['C', 'B']),
    ];
    expect(findProxyChainRenameConflict(chains, 'A', 'B'), 'B');
    expect(findProxyChainRenameConflict(chains, 'C', 'B'), isNull);
    expect(findProxyChainRenameConflict(chains, 'A', 'D'), isNull);
  });
}

import 'package:fl_clash/common/measure.dart';
import 'package:fl_clash/common/theme.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/database.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/profiles/custom_overwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _profile = Profile(
  id: 1,
  label: 'Subscription',
  url: 'https://example.com/subscription',
  autoUpdateDuration: Duration(hours: 6),
  overwriteType: OverwriteType.custom,
  currentGroupName: 'Personal',
  selectedMap: {'Personal': 'Node'},
  unfoldSet: {'Personal'},
  scriptId: 4,
  order: 7,
  customProxyGroups: [
    ProxyGroup(name: 'Personal', type: GroupType.Selector, proxies: ['Node']),
  ],
  customRules: [Rule(id: 2, value: 'MATCH,Personal')],
  proxyChains: [
    ProxyChain(id: 3, name: 'Chain', proxies: ['Node', 'Exit']),
  ],
  profileProxies: [
    ProfileProxy(id: 5, proxy: {'name': 'Node', 'type': 'direct'}),
  ],
);
const _otherProfile = Profile(
  id: 2,
  label: 'Another subscription',
  autoUpdateDuration: Duration(hours: 1),
  customRules: [Rule(id: 6, value: 'MATCH,REJECT')],
);

void main() {
  for (final mode in [
    OverwriteType.standard,
    OverwriteType.merge,
    OverwriteType.script,
  ]) {
    testWidgets('$mode can open a custom draft without changing settings', (
      tester,
    ) async {
      final original = _profile.copyWith(overwriteType: mode);
      final profiles = await _pumpContent(tester, original, draftView: true);

      expect(
        find.text(AppLocalizations.current.editCustomRouting),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.current.customRoutingDraftHint),
        findsOneWidget,
      );
      expect(find.text(AppLocalizations.current.quickFill), findsOneWidget);
      expect(profiles.profile, original);
      expect(profiles.otherProfile, _otherProfile);
      expect(profiles.writes, 0);
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
      expect(profiles.writes, 0);
      expect(tester.takeException(), isNull);
    });
  }

  for (final mode in [OverwriteType.custom, OverwriteType.merge]) {
    testWidgets('$mode clears only this profile custom groups and rules', (
      tester,
    ) async {
      final original = _profile.copyWith(overwriteType: mode);
      final profiles = await _pumpContent(tester, original);
      await _openClear(tester);
      expect(profiles.profile, original);
      expect(profiles.writes, 0);
      expect(
        find.text(AppLocalizations.current.confirmClearCustomRouting),
        findsOneWidget,
      );
      await _confirmClear(tester);

      expect(
        profiles.profile,
        original.copyWith(customProxyGroups: [], customRules: []),
      );
      expect(profiles.otherProfile, _otherProfile);
      expect(profiles.writes, 1);
      expect(find.text('0'), findsNWidgets(2));
      expect(tester.widget<TextButton>(_clearButton).onPressed, isNull);
      expect(tester.takeException(), isNull);
    });
  }

  for (final locale in const [
    Locale('en'),
    Locale('zh', 'CN'),
    Locale('ja'),
    Locale('ru'),
  ]) {
    testWidgets('${locale.toLanguageTag()} clear fits narrow enlarged text', (
      tester,
    ) async {
      await _pumpContent(
        tester,
        _profile.copyWith(overwriteType: OverwriteType.merge),
        locale: locale,
        size: const Size(360, 800),
        textScale: 2,
      );
      final bounds = tester.getRect(_clearButton);
      expect(bounds.left, greaterThanOrEqualTo(0));
      expect(bounds.right, lessThanOrEqualTo(360));
      expect(tester.takeException(), isNull);
      await _openClear(tester);
      expect(tester.takeException(), isNull);
      await tester.tap(
        find.widgetWithText(TextButton, AppLocalizations.current.cancel),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('cancelling clear keeps every setting', (tester) async {
    final profiles = await _pumpContent(tester, _profile);
    await _openClear(tester);
    await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
    await tester.pumpAndSettle();

    expect(profiles.profile, _profile);
    expect(profiles.writes, 0);
    expect(tester.widget<TextButton>(_clearButton).onPressed, isNotNull);
  });

  testWidgets('clear is disabled for an empty custom draft', (tester) async {
    final empty = _profile.copyWith(customProxyGroups: [], customRules: []);
    final profiles = await _pumpContent(tester, empty);
    expect(tester.widget<TextButton>(_clearButton).onPressed, isNull);
    await tester.tap(_clearButton);
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(profiles.profile, empty);
    expect(profiles.writes, 0);
  });

  for (final profile in [
    _profile.copyWith(customProxyGroups: []),
    _profile.copyWith(customRules: []),
  ]) {
    testWidgets(
      'clear stays enabled with ${profile.customProxyGroups.length} groups '
      'and ${profile.customRules.length} rules',
      (tester) async {
        final profiles = await _pumpContent(tester, profile);
        expect(tester.widget<TextButton>(_clearButton).onPressed, isNotNull);
        await _openClear(tester);
        await _confirmClear(tester);
        expect(profiles.profile.customProxyGroups, isEmpty);
        expect(profiles.profile.customRules, isEmpty);
        expect(profiles.writes, 1);
      },
    );
  }

  final changedProfiles = <String, Profile>{
    'groups': _profile.copyWith(
      customProxyGroups: [
        ..._profile.customProxyGroups,
        const ProxyGroup(
          name: 'New group',
          type: GroupType.Selector,
          proxies: ['DIRECT'],
        ),
      ],
    ),
    'rules': _profile.copyWith(
      customRules: [
        ..._profile.customRules,
        const Rule(id: 8, value: 'DOMAIN,example.com,REJECT'),
      ],
    ),
    'mode': _profile.copyWith(overwriteType: OverwriteType.merge),
    'subscription URL': _profile.copyWith(url: 'https://example.com/new'),
    'subscription revision': _profile.copyWith(
      lastUpdateDate: DateTime.utc(2026, 9, 9),
    ),
  };
  for (final entry in changedProfiles.entries) {
    testWidgets('clear preserves ${entry.key} edited during confirmation', (
      tester,
    ) async {
      final profiles = await _pumpContent(tester, _profile);
      await _openClear(tester);
      profiles.replaceFromDatabase([entry.value, _otherProfile]);
      await tester.pump();
      await _confirmClear(tester);

      expect(profiles.profile, entry.value);
      expect(profiles.writes, 0);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('clear preserves unrelated changes made during confirmation', (
    tester,
  ) async {
    final profiles = await _pumpContent(tester, _profile);
    await _openClear(tester);
    final changed = _profile.copyWith(label: 'Renamed', autoUpdate: false);
    profiles.replaceFromDatabase([changed, _otherProfile]);
    await tester.pump();
    await _confirmClear(tester);

    expect(
      profiles.profile,
      changed.copyWith(customProxyGroups: [], customRules: []),
    );
    expect(profiles.writes, 1);
  });

  testWidgets('clear ignores a profile removed while confirmation is open', (
    tester,
  ) async {
    final profiles = await _pumpContent(tester, _profile);
    await _openClear(tester);
    profiles.replaceFromDatabase([_otherProfile]);
    await tester.pump();
    await _confirmClear(tester);

    expect(profiles.entries, [_otherProfile]);
    expect(profiles.writes, 0);
    expect(tester.widget<TextButton>(_clearButton).onPressed, isNull);
    expect(tester.takeException(), isNull);
  });

  testWidgets('quick fill does not overwrite edits made during confirmation', (
    tester,
  ) async {
    final profiles = await _pumpContent(tester, _profile);
    await tester.tap(find.text(AppLocalizations.current.quickFill));
    await tester.pumpAndSettle();
    final changed = _profile.copyWith(customProxyGroups: [], customRules: []);
    profiles.replaceFromDatabase([changed, _otherProfile]);
    await tester.pump();
    await tester.tap(find.widgetWithText(TextButton, 'Confirm'));
    await tester.pumpAndSettle();

    expect(profiles.profile, changed);
    expect(profiles.writes, 0);
    expect(tester.takeException(), isNull);
  });
}

Finder get _clearButton => find.byKey(const Key('clear-custom-routing'));

Future<void> _openClear(WidgetTester tester) async {
  await tester.tap(_clearButton);
  await tester.pumpAndSettle();
  expect(find.byType(AlertDialog), findsOneWidget);
}

Future<void> _confirmClear(WidgetTester tester) async {
  await tester.tap(
    find.descendant(
      of: find.byType(AlertDialog),
      matching: find.widgetWithText(
        TextButton,
        AppLocalizations.current.clearCustomRouting,
      ),
    ),
  );
  await tester.pumpAndSettle();
  expect(find.byType(AlertDialog), findsNothing);
}

Future<_TestProfiles> _pumpContent(
  WidgetTester tester,
  Profile profile, {
  Locale locale = const Locale('en'),
  Size size = const Size(800, 800),
  double textScale = 1,
  bool draftView = false,
}) async {
  final profiles = _TestProfiles([profile, _otherProfile]);
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        profilesProvider.overrideWith(() => profiles),
        viewSizeProvider.overrideWithBuild((_, _) => size),
      ],
      child: MaterialApp(
        locale: locale,
        navigatorKey: globalState.navigatorKey,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        builder: (context, child) {
          globalState.theme = CommonTheme.of(context, textScale);
          globalState.measure = Measure.of(context, textScale);
          return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(textScale)),
            child: child!,
          );
        },
        home: draftView
            ? const CustomOverwriteDraftView(profileId: 1)
            : Scaffold(
                body: CustomScrollView(
                  slivers: [
                    CustomOverwriteContent(
                      profileId: 1,
                      merge: profile.overwriteType == OverwriteType.merge,
                    ),
                  ],
                ),
              ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return profiles;
}

// Keep the real provider reads and notifications, with persistence isolated from
// the user's database. Tests exercise the widget's actual confirmation callback.
class _TestProfiles extends Profiles {
  final List<Profile> initial;
  int writes = 0;

  _TestProfiles(this.initial);

  @override
  List<Profile> build() => initial;

  List<Profile> get entries => state;
  Profile get profile => state.firstWhere((profile) => profile.id == 1);
  Profile get otherProfile => state.firstWhere((profile) => profile.id == 2);

  @override
  void updateProfile(int profileId, Profile Function(Profile) builder) {
    writes++;
    state = [
      for (final profile in state)
        profile.id == profileId ? builder(profile) : profile,
    ];
  }
}

import 'dart:async';

import 'package:fl_clash/common/measure.dart';
import 'package:fl_clash/common/theme.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/features/overwrite/routing_draft.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/database.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/profiles/overwrite.dart';
import 'package:fl_clash/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _profile = Profile(
  id: 1,
  label: 'Subscription',
  url: 'https://example.com/subscription',
  autoUpdateDuration: Duration(hours: 6),
  customProxyGroups: [
    ProxyGroup(name: 'Personal', type: GroupType.Selector, proxies: ['DIRECT']),
  ],
  customRules: [Rule(id: 2, value: 'MATCH,Personal')],
);

typedef _Validator = Future<String> Function(WidgetRef, Profile);

void main() {
  testWidgets('empty custom mode is rejected before changing the saved mode', (
    tester,
  ) async {
    final empty = _profile.copyWith(customProxyGroups: [], customRules: []);
    final profiles = await _pumpSelector(tester, empty);
    await _tapMode(tester, OverwriteType.custom);
    await tester.pumpAndSettle();

    expect(profiles.profile, empty);
    expect(profiles.writes, 0);
    expect(_modeCard(tester, OverwriteType.standard).isSelected, isTrue);
    expect(
      find.text(AppLocalizations.current.emptyCustomOverwrite),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  for (final mode in [OverwriteType.custom, OverwriteType.merge]) {
    testWidgets('$mode rejects unsupported relay groups before saving', (
      tester,
    ) async {
      final unsupported = _profile.copyWith(
        customProxyGroups: [
          const ProxyGroup(
            name: 'Personal',
            type: GroupType.Relay,
            proxies: ['DIRECT'],
          ),
        ],
      );
      final profiles = await _pumpSelector(tester, unsupported);
      await _tapMode(tester, mode);
      await tester.pumpAndSettle();

      expect(profiles.profile, unsupported);
      expect(profiles.writes, 0);
      expect(_modeCard(tester, OverwriteType.standard).isSelected, isTrue);
      expect(
        find.text(AppLocalizations.current.relayGroupUnsupported),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('$mode waits for validation and switches only after success', (
      tester,
    ) async {
      final validation = Completer<String>();
      final candidates = <Profile>[];
      final profiles = await _pumpSelector(
        tester,
        _profile,
        validator: (_, candidate) {
          candidates.add(candidate);
          return validation.future;
        },
      );
      await _tapMode(tester, mode);
      await tester.pump();

      expect(candidates, [_profile.copyWith(overwriteType: mode)]);
      expect(profiles.profile, _profile);
      expect(profiles.writes, 0);
      expect(_modeCard(tester, OverwriteType.standard).isSelected, isTrue);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(
        tester
            .widget<TextButton>(find.byKey(const Key('edit-custom-routing')))
            .onPressed,
        isNull,
      );
      for (final type in OverwriteType.values) {
        expect(_modeCard(tester, type).onPressed, isNull);
      }
      await _tapMode(tester, OverwriteType.script);
      expect(profiles.writes, 0);

      validation.complete('');
      await tester.pumpAndSettle();

      expect(profiles.profile, _profile.copyWith(overwriteType: mode));
      expect(profiles.writes, 1);
      expect(_modeCard(tester, mode).isSelected, isTrue);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      if (mode == OverwriteType.custom) {
        expect(find.byKey(const Key('edit-custom-routing')), findsNothing);
      } else {
        expect(
          tester
              .widget<TextButton>(find.byKey(const Key('edit-custom-routing')))
              .onPressed,
          isNotNull,
        );
      }
      for (final type in OverwriteType.values) {
        expect(_modeCard(tester, type).onPressed, isNotNull);
      }
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('a validation error keeps the old mode and shows its reason', (
    tester,
  ) async {
    final profiles = await _pumpSelector(
      tester,
      _profile,
      validator: (_, _) async => 'Unknown policy: Missing',
    );
    await _tapMode(tester, OverwriteType.custom);
    await tester.pumpAndSettle();

    expect(profiles.profile, _profile);
    expect(profiles.writes, 0);
    expect(find.text('Unknown policy: Missing'), findsOneWidget);
    expect(_modeCard(tester, OverwriteType.standard).isSelected, isTrue);
    expect(_modeCard(tester, OverwriteType.custom).onPressed, isNotNull);
  });

  testWidgets('an unexpected validator failure keeps the old mode', (
    tester,
  ) async {
    final profiles = await _pumpSelector(
      tester,
      _profile,
      validator: (_, _) async => throw StateError('Core unavailable'),
    );
    await _tapMode(tester, OverwriteType.custom);
    await tester.pumpAndSettle();

    expect(profiles.profile, _profile);
    expect(profiles.writes, 0);
    expect(find.text('Bad state: Core unavailable'), findsOneWidget);
    expect(_modeCard(tester, OverwriteType.custom).onPressed, isNotNull);
    expect(tester.takeException(), isNull);
  });

  final changedProfiles = <String, Profile>{
    'mode': _profile.copyWith(overwriteType: OverwriteType.script),
    'groups': _profile.copyWith(customProxyGroups: []),
    'rules': _profile.copyWith(customRules: []),
    'subscription URL': _profile.copyWith(url: 'https://example.com/new'),
    'subscription revision': _profile.copyWith(
      lastUpdateDate: DateTime.utc(2026, 9, 9),
    ),
    'nodes': _profile.copyWith(
      profileProxies: [
        const ProfileProxy(id: 3, proxy: {'name': 'Node', 'type': 'direct'}),
      ],
    ),
    'chains': _profile.copyWith(
      proxyChains: [
        const ProxyChain(id: 4, name: 'Chain', proxies: ['DIRECT']),
      ],
    ),
  };
  for (final entry in changedProfiles.entries) {
    testWidgets('changed ${entry.key} makes pending validation stale', (
      tester,
    ) async {
      final validation = Completer<String>();
      final profiles = await _pumpSelector(
        tester,
        _profile,
        validator: (_, _) => validation.future,
      );
      await _tapMode(tester, OverwriteType.custom);
      await tester.pump();
      profiles.replaceFromDatabase([entry.value]);
      await tester.pump();
      validation.complete('');
      await tester.pumpAndSettle();

      expect(profiles.profile, entry.value);
      expect(profiles.writes, 0);
      expect(
        find.text(AppLocalizations.current.routingChanged),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('removing the profile discards pending validation', (
    tester,
  ) async {
    final validation = Completer<String>();
    final profiles = await _pumpSelector(
      tester,
      _profile,
      validator: (_, _) => validation.future,
    );
    await _tapMode(tester, OverwriteType.custom);
    await tester.pump();
    profiles.replaceFromDatabase([]);
    await tester.pump();
    validation.complete('');
    await tester.pumpAndSettle();

    expect(profiles.entries, isEmpty);
    expect(profiles.writes, 0);
    expect(find.text(AppLocalizations.current.routingChanged), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('disposing the selector discards pending validation', (
    tester,
  ) async {
    final validation = Completer<String>();
    final profiles = await _pumpSelector(
      tester,
      _profile,
      validator: (_, _) => validation.future,
    );
    await _tapMode(tester, OverwriteType.custom);
    await tester.pump();
    await tester.pumpWidget(const SizedBox());
    validation.complete('');
    await tester.pumpAndSettle();

    expect(profiles.writes, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets('selecting the current mode does not validate or write', (
    tester,
  ) async {
    final profiles = await _pumpSelector(
      tester,
      _profile.copyWith(overwriteType: OverwriteType.custom),
      validator: (_, _) async => throw StateError('Should not validate'),
    );
    await _tapMode(tester, OverwriteType.custom);
    await tester.pumpAndSettle();

    expect(profiles.writes, 0);
    expect(find.byType(AlertDialog), findsNothing);
    expect(tester.takeException(), isNull);
  });

  for (final mode in [OverwriteType.standard, OverwriteType.script]) {
    testWidgets('$mode preserves immediate switching behavior', (tester) async {
      final profiles = await _pumpSelector(
        tester,
        _profile.copyWith(overwriteType: OverwriteType.custom),
        validator: (_, _) async => throw StateError('Should not validate'),
      );
      await _tapMode(tester, mode);
      await tester.pumpAndSettle();

      expect(profiles.profile.overwriteType, mode);
      expect(profiles.writes, 1);
      expect(find.byType(AlertDialog), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  for (final locale in const [
    Locale('en'),
    Locale('zh', 'CN'),
    Locale('ja'),
    Locale('ru'),
  ]) {
    testWidgets(
      '${locale.toLanguageTag()} rejection fits narrow enlarged text',
      (tester) async {
        await _pumpSelector(
          tester,
          _profile.copyWith(customProxyGroups: [], customRules: []),
          locale: locale,
          size: const Size(360, 800),
          textScale: 2,
        );
        await _tapMode(tester, OverwriteType.custom);
        await tester.pumpAndSettle();

        expect(
          find.text(AppLocalizations.current.emptyCustomOverwrite),
          findsOneWidget,
        );
        final bounds = tester.getRect(find.byType(AlertDialog));
        expect(bounds.left, greaterThanOrEqualTo(0));
        expect(bounds.right, lessThanOrEqualTo(360));
        expect(tester.takeException(), isNull);
      },
    );
  }
}

Finder _card(OverwriteType type) =>
    find.byKey(ValueKey('overwrite-mode-${type.name}'));

CommonCard _modeCard(WidgetTester tester, OverwriteType type) =>
    tester.widget<CommonCard>(_card(type));

Future<void> _tapMode(WidgetTester tester, OverwriteType type) async {
  await tester.ensureVisible(_card(type));
  await tester.tap(_card(type));
}

Future<_TestProfiles> _pumpSelector(
  WidgetTester tester,
  Profile profile, {
  _Validator validator = validateCustomRoutingDraft,
  Locale locale = const Locale('en'),
  Size size = const Size(800, 800),
  double textScale = 1,
}) async {
  final profiles = _TestProfiles([profile]);
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
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              OverwriteModeSelector(profileId: 1, validator: validator),
            ],
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return profiles;
}

class _TestProfiles extends Profiles {
  final List<Profile> initial;
  int writes = 0;

  _TestProfiles(this.initial);

  @override
  List<Profile> build() => initial;

  List<Profile> get entries => state;
  Profile get profile => state.single;

  @override
  void updateProfile(int profileId, Profile Function(Profile) builder) {
    writes++;
    state = [
      for (final profile in state)
        profile.id == profileId ? builder(profile) : profile,
    ];
  }
}

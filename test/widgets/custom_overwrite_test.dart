import 'dart:async';

import 'package:fl_clash/common/constant.dart';
import 'package:fl_clash/common/theme.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/features/overwrite/proxy_group_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ProxyGroupDialog scrolls on narrow screens', (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          viewSizeProvider.overrideWithBuild((_, _) => const Size(360, 640)),
        ],
        child: const _TestApp(child: ProxyGroupDialog(existingGroups: [])),
      ),
    );

    await tester.dragUntilVisible(
      find.text('Include all proxy providers'),
      find.byType(SingleChildScrollView),
      const Offset(0, -300),
    );

    expect(find.text('Include all proxy providers'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('ProxyGroupDialog preserves advanced values on edit', (
    tester,
  ) async {
    ProxyGroup? result;
    const original = ProxyGroup(
      name: 'Old',
      type: GroupType.LoadBalance,
      disableUdp: true,
      includeAllProviders: true,
      excludeFilter: 'Blocked',
      strategy: 'future-strategy',
      icon: 'https://example.com/icon.png',
      proxies: ['Node,A', 'Node B', 'Node B', ' Node C '],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          viewSizeProvider.overrideWithBuild((_, _) => const Size(800, 1000)),
        ],
        child: _TestApp(
          child: Builder(
            builder: (context) {
              return TextButton(
                onPressed: () async {
                  result = await showDialog<ProxyGroup>(
                    context: context,
                    builder: (_) => const ProxyGroupDialog(
                      group: original,
                      existingGroups: [original],
                    ),
                  );
                },
                child: const Text('Open group'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open group'));
    await tester.pumpAndSettle();
    final nameField = find.widgetWithText(TextFormField, 'Name');
    await tester.enterText(nameField, 'New');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(result?.name, 'New');
    expect(result?.disableUdp, true);
    expect(result?.includeAllProviders, true);
    expect(result?.excludeFilter, 'Blocked');
    expect(result?.strategy, 'future-strategy');
    expect(result?.icon, 'https://example.com/icon.png');
    expect(result?.lazy, true);
    expect(result?.proxies, ['Node,A', 'Node B', 'Node B', ' Node C ']);
  });

  testWidgets('ProxyGroupDialog opens legacy Relay groups for migration', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          viewSizeProvider.overrideWithBuild((_, _) => const Size(800, 600)),
        ],
        child: const _TestApp(
          child: ProxyGroupDialog(
            group: ProxyGroup(
              name: 'Legacy',
              type: GroupType.Relay,
              proxies: ['DIRECT'],
            ),
            existingGroups: [],
          ),
        ),
      ),
    );

    expect(find.text('Relay'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('ProxyGroupDialog rejects tolerance above uint16', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          viewSizeProvider.overrideWithBuild((_, _) => const Size(800, 1000)),
        ],
        child: const _TestApp(
          child: ProxyGroupDialog(
            group: ProxyGroup(
              name: 'Auto',
              type: GroupType.URLTest,
              proxies: ['DIRECT'],
            ),
            existingGroups: [],
          ),
        ),
      ),
    );

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Tolerance'),
      '100000',
    );
    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(find.text('0 - 65535'), findsOneWidget);
  });

  testWidgets('ProxyGroupDialog rejects reserved outbound names', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          viewSizeProvider.overrideWithBuild((_, _) => const Size(800, 800)),
        ],
        child: const _TestApp(
          child: ProxyGroupDialog(
            group: ProxyGroup(
              name: 'Initial',
              type: GroupType.Selector,
              includeAll: true,
            ),
            existingGroups: [],
            reservedNames: {'DIRECT'},
          ),
        ),
      ),
    );

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Name'),
      'DIRECT',
    );
    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(find.text('Current Name already exists'), findsOneWidget);
  });
  testWidgets(
    'ProxyGroupDialog preserves the draft and disables editing during validation',
    (tester) async {
      ProxyGroup? result;
      var calls = 0;
      final pending = Completer<String>();
      await _openGroupDialog(
        tester,
        group: const ProxyGroup(
          name: 'Original',
          type: GroupType.Selector,
          proxies: ['DIRECT'],
        ),
        validate: (_) {
          calls++;
          return calls == 1 ? pending.future : Future.value('');
        },
        onResult: (value) => result = value,
      );
      final name = find.widgetWithText(TextFormField, 'Name');
      await tester.enterText(name, 'Edited policy');
      await tester.tap(find.text('Save'));
      await tester.pump();

      expect(tester.widget<TextFormField>(name).enabled, isFalse);
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );
      expect(calls, 1);
      expect(result, isNull);

      pending.complete('An existing rule still refers to a missing group.');
      await tester.pumpAndSettle();
      expect(
        find.textContaining(
          'An existing rule still refers to a missing group.',
        ),
        findsOneWidget,
      );
      expect(
        tester.widget<TextFormField>(name).controller?.text,
        'Edited policy',
      );
      expect(tester.widget<TextFormField>(name).enabled, isTrue);
      expect(result, isNull);

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(result?.name, 'Edited policy');
      expect(result?.proxies, ['DIRECT']);
      expect(calls, 2);
    },
  );

  testWidgets(
    'ProxyGroupDialog explicitly saves current edits after configuration failure',
    (tester) async {
      ProxyGroup? result;
      var calls = 0;
      await _openGroupDialog(
        tester,
        group: const ProxyGroup(
          name: 'Original',
          type: GroupType.Selector,
          proxies: ['DIRECT'],
        ),
        validate: (_) async {
          calls++;
          return 'Other rules need repair before applying this configuration.';
        },
        onResult: (value) => result = value,
      );
      expect(find.text('Save draft'), findsNothing);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Name'),
        'First edit',
      );
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(result, isNull);
      expect(find.text('Save draft'), findsOneWidget);
      expect(
        find.textContaining('Settings are applied only after'),
        findsOneWidget,
      );

      final name = find.widgetWithText(TextFormField, 'Name');
      await tester.ensureVisible(name);
      await tester.enterText(name, 'Second edit');
      await tester.tap(find.text('Save draft'));
      await tester.pumpAndSettle();

      expect(result?.name, 'Second edit');
      expect(result?.proxies, ['DIRECT']);
      expect(calls, 2);
    },
  );

  testWidgets(
    'ProxyGroupDialog blocks draft bypass after an unsafe edit is detected',
    (tester) async {
      ProxyGroup? result;
      var calls = 0;
      const blockedMessage = 'The original group is still used by DNS';
      await _openGroupDialog(
        tester,
        group: const ProxyGroup(
          name: 'Original',
          type: GroupType.Selector,
          proxies: ['DIRECT'],
        ),
        validate: (candidate) async {
          calls++;
          if (candidate.name != 'Original') {
            throw const ProxyGroupEditBlocked(blockedMessage);
          }
          return 'Other rules need repair before applying this configuration.';
        },
        onResult: (value) => result = value,
      );
      final name = find.widgetWithText(TextFormField, 'Name');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(find.text('Save draft'), findsOneWidget);

      await tester.ensureVisible(name);
      await tester.enterText(name, 'Renamed');
      await tester.tap(find.text('Save draft'));
      await tester.pumpAndSettle();
      expect(find.text(blockedMessage), findsOneWidget);
      expect(find.text('Save draft'), findsNothing);
      expect(
        find.textContaining('Settings are applied only after'),
        findsNothing,
      );
      expect(tester.widget<TextFormField>(name).controller?.text, 'Renamed');
      expect(result, isNull);
      expect(calls, 2);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'ProxyGroupDialog gives provider-only automatic groups working defaults',
    (tester) async {
      ProxyGroup? result;
      await _openGroupDialog(
        tester,
        group: const ProxyGroup(
          name: 'Provider automatic',
          type: GroupType.URLTest,
          use: ['Subscription A'],
        ),
        availableProviders: const ['Subscription A', 'Subscription B'],
        onResult: (value) => result = value,
      );
      final providers = find.widgetWithText(
        OutlinedButton,
        'Proxy providers (1)',
      );
      await tester.ensureVisible(providers);
      await tester.tap(providers);
      await tester.pumpAndSettle();
      final selectedProvider = find.widgetWithText(
        CheckboxListTile,
        'Subscription A',
      );
      expect(tester.widget<CheckboxListTile>(selectedProvider).value, isTrue);
      await tester.tap(find.widgetWithText(CheckboxListTile, 'Subscription B'));
      await tester.pump();
      await tester.tap(find.text('Confirm (2)'));
      await tester.pumpAndSettle();
      expect(find.widgetWithText(InputChip, 'Subscription A'), findsOneWidget);
      expect(find.widgetWithText(InputChip, 'Subscription B'), findsOneWidget);
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(result?.type, GroupType.URLTest);
      expect(result?.proxies, isNull);
      expect(result?.use, ['Subscription A', 'Subscription B']);
      expect(result?.url, defaultTestUrl);
      expect(result?.interval, 300);
    },
  );
  testWidgets('ProxyGroupDialog accepts zero URL-test tolerance', (
    tester,
  ) async {
    ProxyGroup? result;
    await _openGroupDialog(
      tester,
      group: const ProxyGroup(
        name: 'Automatic',
        type: GroupType.URLTest,
        proxies: ['DIRECT'],
      ),
      onResult: (value) => result = value,
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Tolerance'),
      '0',
    );
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(result?.tolerance, 0);
  });

  testWidgets(
    'ProxyGroupDialog shows empty members inline without draft bypass',
    (tester) async {
      await _openGroupDialog(
        tester,
        group: const ProxyGroup(name: 'Empty', type: GroupType.Selector),
      );
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(
        find.text(AppLocalizations.current.proxyGroupMembersEmpty),
        findsOneWidget,
      );
      expect(find.text('Save draft'), findsNothing);
      expect(
        find.text(AppLocalizations.current.routingDraftHint),
        findsNothing,
      );
      expect(find.byType(ProxyGroupDialog), findsOneWidget);
    },
  );

  testWidgets(
    'ProxyGroupDialog cancels a pending check without closing the page below',
    (tester) async {
      final pending = Completer<String>();
      final results = <ProxyGroup?>[];
      await _openGroupDialog(
        tester,
        group: const ProxyGroup(
          name: 'Manual',
          type: GroupType.Selector,
          proxies: ['DIRECT'],
        ),
        validate: (_) => pending.future,
        onResult: results.add,
      );
      await tester.tap(find.text('Save'));
      await tester.pump();
      await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
      pending.complete('');
      await tester.pumpAndSettle();
      expect(results, [null]);
      expect(find.text('Open group'), findsOneWidget);
      expect(find.byType(ProxyGroupDialog), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'manual provider edits update candidates and filter controls immediately',
    (tester) async {
      await _openGroupDialog(
        tester,
        group: const ProxyGroup(
          name: 'Manual',
          type: GroupType.Selector,
          proxies: ['DIRECT'],
        ),
        availableProviders: const ['Subscription A'],
      );
      expect(find.widgetWithText(TextFormField, 'Proxy filter'), findsNothing);
      final field = find.widgetWithText(TextField, 'Proxy providers');
      await tester.ensureVisible(field);
      await tester.enterText(field, 'Subscription A');
      await tester.pump();
      expect(
        find.widgetWithText(OutlinedButton, 'Proxy providers (1)'),
        findsOneWidget,
      );
      expect(find.widgetWithText(InputChip, 'Subscription A'), findsOneWidget);
      expect(
        find.widgetWithText(TextFormField, 'Proxy filter'),
        findsOneWidget,
      );
    },
  );
}

Future<void> _openGroupDialog(
  WidgetTester tester, {
  required ProxyGroup group,
  List<String> availableProviders = const [],
  Future<String> Function(ProxyGroup)? validate,
  ValueChanged<ProxyGroup?>? onResult,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        viewSizeProvider.overrideWithBuild((_, _) => const Size(800, 800)),
      ],
      child: _TestApp(
        child: Builder(
          builder: (context) => TextButton(
            onPressed: () async {
              final result = await showDialog<ProxyGroup>(
                context: context,
                builder: (_) => ProxyGroupDialog(
                  group: group,
                  existingGroups: [group],
                  availableMembers: const ['DIRECT'],
                  availableProviders: availableProviders,
                  validate: validate,
                ),
              );
              onResult?.call(result);
            },
            child: const Text('Open group'),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('Open group'));
  await tester.pumpAndSettle();
}

class _TestApp extends StatelessWidget {
  final Widget child;

  const _TestApp({required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: globalState.navigatorKey,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.delegate.supportedLocales,
      builder: (context, child) {
        globalState.theme = CommonTheme.of(context, 1);
        return child!;
      },
      home: Scaffold(body: child),
    );
  }
}

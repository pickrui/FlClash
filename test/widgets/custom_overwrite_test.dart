import 'package:fl_clash/common/theme.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/profiles/custom_overwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CustomRuleDialog preserves raw MATCH rule syntax', (
    tester,
  ) async {
    Rule? result;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          viewSizeProvider.overrideWithBuild((_, _) => const Size(800, 600)),
        ],
        child: _TestApp(
          child: Builder(
            builder: (context) {
              return TextButton(
                onPressed: () async {
                  result = await showDialog<Rule>(
                    context: context,
                    builder: (_) => const CustomRuleDialog(),
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'MATCH,Proxy');
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();

    expect(result?.value, 'MATCH,Proxy');
  });

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
    await tester.tap(find.text('Confirm'));
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
    await tester.tap(find.text('Confirm'));
    await tester.pump();

    expect(find.text('1 - 65535'), findsOneWidget);
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
    await tester.tap(find.text('Confirm'));
    await tester.pump();

    expect(find.text('Current Name already exists'), findsOneWidget);
  });
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

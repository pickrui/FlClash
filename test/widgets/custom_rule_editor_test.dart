import 'dart:async';

import 'package:fl_clash/features/overwrite/custom_rule_editor.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/clash_config.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('chooses a searched policy group without typing its name', (
    tester,
  ) async {
    Rule? result;
    await _open(tester, onResult: (value) => result = value);

    await tester.enterText(_payload('DOMAIN_SUFFIX'), 'example.com');
    await _chooseTarget(tester, query: 'japan', name: 'Japan automatic');
    await _save(tester);

    expect(result?.value, 'DOMAIN-SUFFIX,example.com,Japan automatic');
  });

  for (final fillPayload in [true, false]) {
    testWidgets(
      'round-trips an unfinished form with ${fillPayload ? 'content' : 'target'} through rule text',
      (tester) async {
        Rule? result;
        await _open(tester, onResult: (value) => result = value);
        if (fillPayload) {
          await tester.enterText(_payload('DOMAIN_SUFFIX'), 'example.com');
        } else {
          await _chooseTarget(tester, name: 'DIRECT');
        }
        expect(
          find.byKey(const Key('custom-rule-option-search')),
          findsNothing,
        );
        await tester.ensureVisible(find.text('Rule text'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Rule text'));
        await tester.pumpAndSettle();
        expect(
          tester
              .widget<TextFormField>(find.byKey(const Key('custom-rule-raw')))
              .controller
              ?.text,
          fillPayload ? 'DOMAIN-SUFFIX,example.com,' : 'DOMAIN-SUFFIX,,DIRECT',
        );
        await tester.tap(find.text('Form'));
        await tester.pumpAndSettle();
        expect(find.byKey(const Key('custom-rule-raw')), findsNothing);
        expect(
          tester
              .widget<TextFormField>(_payload('DOMAIN_SUFFIX'))
              .controller
              ?.text,
          fillPayload ? 'example.com' : '',
        );
        if (fillPayload) {
          await _chooseTarget(tester, name: 'DIRECT');
        } else {
          await tester.enterText(_payload('DOMAIN_SUFFIX'), 'example.com');
        }
        await _save(tester);
        expect(result?.value, 'DOMAIN-SUFFIX,example.com,DIRECT');
      },
    );
  }

  for (final value in [
    'DOMAIN,src,no-resolve',
    'RULE-SET,src,no-resolve,src',
  ]) {
    testWidgets('keeps literal parameter names in the form: $value', (
      tester,
    ) async {
      Rule? result;
      await _open(
        tester,
        rule: Rule(id: 42, value: value),
        targets: const ['DIRECT', 'no-resolve'],
        ruleProviders: const ['src'],
        onResult: (value) => result = value,
      );
      expect(find.byKey(const Key('custom-rule-raw')), findsNothing);
      await _save(tester);
      expect(result?.value, value);
    });
  }

  testWidgets(
    'requires an explicit target and rejects a URL as domain content',
    (tester) async {
      var submitted = false;
      await _open(tester, onResult: (_) => submitted = true);
      await tester.enterText(
        _payload('DOMAIN_SUFFIX'),
        'https://example.com/path',
      );
      await _save(tester);
      expect(submitted, isFalse);
      expect(
        find.textContaining('Check the content for this rule type'),
        findsOneWidget,
      );

      await tester.enterText(_payload('DOMAIN_SUFFIX'), 'example.com');
      await _save(tester);
      expect(submitted, isFalse);
      expect(find.text('Choose a target'), findsWidgets);

      await _chooseTarget(tester, name: 'DIRECT');
      await _save(tester);
      expect(submitted, isTrue);
    },
  );

  testWidgets('keeps an unavailable existing target visible until replaced', (
    tester,
  ) async {
    Rule? result;
    const original = Rule(
      id: 42,
      order: 'a0',
      value: 'DOMAIN,example.com,Removed group',
    );
    await _open(tester, rule: original, onResult: (value) => result = value);

    expect(find.text('Removed group'), findsOneWidget);
    expect(find.textContaining('Removed group is unavailable'), findsOneWidget);
    await _save(tester);
    expect(result, isNull);

    await _chooseTarget(tester, name: 'Japan automatic');
    expect(find.textContaining('Removed group is unavailable'), findsNothing);
    await _save(tester);
    expect(result?.id, 42);
    expect(result?.order, 'a0');
    expect(result?.value, 'DOMAIN,example.com,Japan automatic');
  });

  testWidgets('validates CIDR and preserves no-resolve and source parameters', (
    tester,
  ) async {
    Rule? result;
    await _open(
      tester,
      rule: const Rule(
        id: 1,
        value: 'IP-CIDR,192.168.0.0/16,DIRECT,src,no-resolve',
      ),
      onResult: (value) => result = value,
    );
    await tester.enterText(_payload('IP_CIDR'), '192.168.0.0/33');
    await _save(tester);
    expect(result, isNull);
    expect(
      find.textContaining('Check the content for this rule type'),
      findsOneWidget,
    );

    await tester.enterText(_payload('IP_CIDR'), '10.0.0.0/8');
    await _save(tester);
    expect(result?.value, 'IP-CIDR,10.0.0.0/8,DIRECT,src,no-resolve');
  });

  testWidgets('retains the core-supported IPv4 form of the IP-CIDR6 alias', (
    tester,
  ) async {
    Rule? result;
    const value = 'IP-CIDR6,192.168.0.0/16,DIRECT,no-resolve';
    await _open(
      tester,
      rule: const Rule(id: 42, value: value),
      onResult: (value) => result = value,
    );
    await _save(tester);
    expect(result?.value, value);
  });

  testWidgets('rejects a leading dot that would break domain suffix matching', (
    tester,
  ) async {
    Rule? result;
    await _open(tester, onResult: (value) => result = value);
    await tester.enterText(_payload('DOMAIN_SUFFIX'), '.example.com');
    await _chooseTarget(tester, name: 'DIRECT');
    await _save(tester);
    expect(result, isNull);
    expect(
      find.textContaining('Check the content for this rule type'),
      findsOneWidget,
    );
    await tester.enterText(_payload('DOMAIN_SUFFIX'), 'example.com');
    await _save(tester);
    expect(result?.value, 'DOMAIN-SUFFIX,example.com,DIRECT');
  });

  testWidgets('uses a selector for existing rule providers', (tester) async {
    Rule? result;
    await _open(
      tester,
      rule: const Rule(id: 1, value: 'RULE-SET,Old provider,DIRECT,no-resolve'),
      onResult: (value) => result = value,
    );
    expect(find.textContaining('Old provider is unavailable'), findsOneWidget);
    await tester.tap(find.byKey(const Key('custom-rule-provider')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Streaming').last);
    await tester.pumpAndSettle();
    expect(find.textContaining('Old provider is unavailable'), findsNothing);
    await _save(tester);
    expect(result?.value, 'RULE-SET,Streaming,DIRECT,no-resolve');
  });

  testWidgets('MATCH form omits content and explains its position effect', (
    tester,
  ) async {
    Rule? result;
    await _open(
      tester,
      rule: const Rule(id: 1, value: 'MATCH,Japan automatic'),
      onResult: (value) => result = value,
    );
    expect(find.byType(TextFormField), findsNothing);
    expect(
      find.textContaining('Rules below it will not be reached'),
      findsOneWidget,
    );
    await _save(tester);
    expect(result?.value, 'MATCH,Japan automatic');
  });

  for (final value in [
    'AND,((DOMAIN,example.com),(IP-CIDR,192.168.0.0/16,no-resolve)),Japan automatic',
    r'DOMAIN-REGEX,^example[0-9]{1,3}\.com$,Japan automatic',
    'DOMAIN-WILDCARD,*.example.com,Japan automatic',
  ]) {
    testWidgets('keeps advanced rule text unchanged: $value', (tester) async {
      Rule? result;
      await _open(
        tester,
        rule: Rule(id: 42, value: value),
        onResult: (value) => result = value,
      );
      expect(find.byKey(const Key('custom-rule-raw')), findsOneWidget);
      await tester.tap(find.text('Form'));
      await tester.pumpAndSettle();
      expect(
        find.textContaining('This rule uses advanced syntax'),
        findsOneWidget,
      );
      expect(find.byKey(const Key('custom-rule-raw')), findsOneWidget);
      await _save(tester);
      expect(result?.value, value);
      expect(result?.id, 42);
    });
  }

  testWidgets('rejects malformed raw rules and missing raw targets', (
    tester,
  ) async {
    Rule? result;
    await _open(tester, onResult: (value) => result = value);
    await tester.tap(find.text('Rule text'));
    await tester.pumpAndSettle();
    for (final raw in [
      'not a rule',
      'MATCH,DIRECT,extra',
      'DOMAIN,,DIRECT',
      'DOMAIN,example.com,Missing',
      'DST-PORT,70000,DIRECT',
    ]) {
      await tester.enterText(find.byKey(const Key('custom-rule-raw')), raw);
      await _save(tester);
      expect(result, isNull, reason: raw);
      expect(find.byType(CustomRuleEditorDialog), findsOneWidget);
    }
    await tester.enterText(
      find.byKey(const Key('custom-rule-raw')),
      'MATCH,DIRECT',
    );
    await _save(tester);
    expect(result?.value, 'MATCH,DIRECT');
  });

  testWidgets(
    'keeps the draft after failed asynchronous validation and disables duplicate saves',
    (tester) async {
      Rule? result;
      var validationCount = 0;
      final pending = Completer<String>();
      await _open(
        tester,
        rule: const Rule(id: 1, value: 'DOMAIN,example.com,DIRECT'),
        validate: (_) {
          validationCount++;
          return validationCount == 1 ? pending.future : Future.value('');
        },
        onResult: (value) => result = value,
      );
      await tester.enterText(_payload('DOMAIN'), 'changed.example.com');
      await tester.tap(find.byKey(const Key('custom-rule-save')));
      await tester.pump();
      expect(
        tester
            .widget<FilledButton>(find.byKey(const Key('custom-rule-save')))
            .onPressed,
        isNull,
      );
      expect(validationCount, 1);
      pending.complete('The configuration references an unavailable provider.');
      await tester.pumpAndSettle();
      expect(result, isNull);
      expect(
        find.text('The configuration references an unavailable provider.'),
        findsOneWidget,
      );
      expect(
        tester.widget<TextFormField>(_payload('DOMAIN')).controller?.text,
        'changed.example.com',
      );
      await _save(tester);
      expect(result?.value, 'DOMAIN,changed.example.com,DIRECT');
      expect(validationCount, 2);
    },
  );

  testWidgets('can cancel pending validation without a late dialog result', (
    tester,
  ) async {
    final pending = Completer<String>();
    final results = <Rule?>[];
    await _open(
      tester,
      rule: const Rule(id: 1, value: 'DOMAIN,example.com,DIRECT'),
      validate: (_) => pending.future,
      onResult: results.add,
    );
    await tester.tap(find.byKey(const Key('custom-rule-save')));
    await tester.pump();
    await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
    // The closing route remains mounted during its exit animation. A check
    // completing now must not pop the route underneath it.
    pending.complete('');
    await tester.pumpAndSettle();
    expect(find.byType(CustomRuleEditorDialog), findsNothing);
    expect(results, [null]);
    expect(find.text('Open'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'offers an explicit draft only after configuration validation fails',
    (tester) async {
      Rule? result;
      const original = Rule(
        id: 42,
        order: 'a0',
        value: 'DOMAIN,example.com,DIRECT',
      );
      await _open(
        tester,
        rule: original,
        validate: (_) async =>
            'Another rule references a removed policy group.',
        onResult: (value) => result = value,
      );
      expect(find.byKey(const Key('custom-rule-save-draft')), findsNothing);
      await tester.enterText(_payload('DOMAIN'), 'https://invalid.example');
      await _save(tester);
      expect(find.byKey(const Key('custom-rule-save-draft')), findsNothing);

      await tester.enterText(_payload('DOMAIN'), 'changed.example.com');
      await _save(tester);
      expect(result, isNull);
      expect(find.byKey(const Key('custom-rule-save-draft')), findsOneWidget);
      expect(
        find.textContaining('Settings are applied only after'),
        findsOneWidget,
      );
      await tester.tap(find.byKey(const Key('custom-rule-save-draft')));
      await tester.pumpAndSettle();
      expect(
        result,
        original.copyWith(value: 'DOMAIN,changed.example.com,DIRECT'),
      );
    },
  );

  testWidgets('editing after a failed check clears the stale draft candidate', (
    tester,
  ) async {
    await _open(
      tester,
      rule: const Rule(id: 1, value: 'DOMAIN,example.com,DIRECT'),
      validate: (_) async => 'Another item needs repair.',
    );
    await _save(tester);
    expect(find.byKey(const Key('custom-rule-save-draft')), findsOneWidget);
    await tester.ensureVisible(_payload('DOMAIN'));
    await tester.enterText(_payload('DOMAIN'), 'new.example.com');
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('custom-rule-save-draft')), findsNothing);
  });

  testWidgets('remains scrollable on a narrow screen with long policy names', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await _open(
      tester,
      size: const Size(360, 640),
      rule: const Rule(
        id: 1,
        value: 'IP-CIDR,10.0.0.0/8,Japan automatic,no-resolve',
      ),
    );
    await tester.dragUntilVisible(
      find.text('Preview'),
      find.byType(SingleChildScrollView).first,
      const Offset(0, -200),
    );
    expect(find.text('Preview'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Finder _payload(String action) =>
    find.byKey(ValueKey('custom-rule-payload-$action'));

Future<void> _save(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key('custom-rule-save')));
  await tester.pumpAndSettle();
}

Future<void> _chooseTarget(
  WidgetTester tester, {
  required String name,
  String? query,
}) async {
  await tester.ensureVisible(find.byKey(const Key('custom-rule-target')));
  await tester.tap(find.byKey(const Key('custom-rule-target')));
  await tester.pumpAndSettle();
  if (query != null) {
    await tester.enterText(
      find.byKey(const Key('custom-rule-option-search')),
      query,
    );
    await tester.pumpAndSettle();
    expect(find.text('DIRECT'), findsNothing);
  }
  await tester.tap(find.widgetWithText(ListTile, name));
  await tester.pumpAndSettle();
}

Future<void> _open(
  WidgetTester tester, {
  Rule? rule,
  ValueChanged<Rule?>? onResult,
  Future<String> Function(Rule)? validate,
  List<String> targets = const [
    'DIRECT',
    'REJECT',
    'Japan automatic',
    'US fallback',
  ],
  List<String> ruleProviders = const ['Streaming', 'Advertising'],
  Size size = const Size(800, 600),
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [viewSizeProvider.overrideWithBuild((_, _) => size)],
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () async {
                final result = await showDialog<Rule>(
                  context: context,
                  builder: (_) => CustomRuleEditorDialog(
                    rule: rule,
                    targets: targets,
                    ruleProviders: ruleProviders,
                    validate: validate,
                  ),
                );
                onResult?.call(result);
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('Open'));
  await tester.pumpAndSettle();
}

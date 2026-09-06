import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/widgets/port_conflict_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('selects the current port and returns the edited port', (
    tester,
  ) async {
    int? result;
    await _openDialog(tester, onResult: (value) => result = value);

    expect(find.text('Port unavailable'), findsOneWidget);
    expect(find.textContaining('7890'), findsWidgets);
    final editable = tester.widget<EditableText>(find.byType(EditableText));
    expect(editable.focusNode.hasFocus, isTrue);
    expect(
      editable.controller.selection.textInside(editable.controller.text),
      '7890',
    );

    await tester.enterText(find.byType(TextFormField), '7895');
    await tester.tap(find.text('Save and retry'));
    await tester.pumpAndSettle();

    expect(result, 7895);
    expect(find.byType(PortConflictDialog), findsNothing);
  });

  testWidgets('cancel discards the edited port', (tester) async {
    int? result = -1;
    await _openDialog(tester, onResult: (value) => result = value);

    await tester.enterText(find.byType(TextFormField), '7895');
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(result, isNull);
    expect(find.byType(PortConflictDialog), findsNothing);
  });

  testWidgets('rejects empty, disabled, out of range, and duplicate ports', (
    tester,
  ) async {
    var submitted = false;
    await _openDialog(tester, onResult: (_) => submitted = true);

    final localizations = AppLocalizations.current;
    final cases = {
      '': localizations.emptyTip(localizations.mixedPort),
      '0': localizations.portTip(localizations.mixedPort),
      '1023': localizations.portTip(localizations.mixedPort),
      '49152': localizations.portTip(localizations.mixedPort),
      '07891': localizations.portConflictTip,
    };
    for (final entry in cases.entries) {
      await tester.enterText(find.byType(TextFormField), entry.key);
      await tester.tap(find.text('Save and retry'));
      await tester.pumpAndSettle();

      expect(find.text(entry.value), findsOneWidget, reason: entry.key);
      expect(find.byType(PortConflictDialog), findsOneWidget);
      expect(submitted, isFalse);
    }

    await tester.enterText(find.byType(TextFormField), '7895');
    await tester.tap(find.text('Save and retry'));
    await tester.pumpAndSettle();
    expect(submitted, isTrue);
  });

  for (final port in [1024, 49151]) {
    testWidgets('accepts boundary port $port with keyboard submit', (
      tester,
    ) async {
      int? result;
      await _openDialog(tester, onResult: (value) => result = value);

      await tester.enterText(find.byType(TextFormField), '$port');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(result, port);
    });
  }

  testWidgets('limits pasted input to five digits', (tester) async {
    int? result;
    await _openDialog(tester, onResult: (value) => result = value);

    await tester.enterText(find.byType(TextFormField), '12a3456');
    await tester.tap(find.text('Save and retry'));
    await tester.pumpAndSettle();

    expect(result, 12345);
  });
}

Future<void> _openDialog(
  WidgetTester tester, {
  required ValueChanged<int?> onResult,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        viewSizeProvider.overrideWithBuild((_, _) => const Size(800, 600)),
      ],
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
                final port = await showDialog<int>(
                  context: context,
                  builder: (_) => const PortConflictDialog(
                    port: 7890,
                    otherPorts: [7891, 0, 0, 0],
                  ),
                );
                onResult(port);
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

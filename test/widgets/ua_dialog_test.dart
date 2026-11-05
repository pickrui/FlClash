import 'package:fl_clash/common/input_limits.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/widgets/ua_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('custom choice opens and focuses the remembered value', (
    tester,
  ) async {
    await _openDialog(tester, customValue: 'Remembered/1.0');
    expect(find.byType(TextFormField), findsNothing);

    await tester.tap(find.text(AppLocalizations.current.customUserAgent));
    await tester.pumpAndSettle();

    expect(find.text('Remembered/1.0'), findsOneWidget);
    expect(_editable(tester).focusNode.hasFocus, isTrue);

    _editable(tester).focusNode.unfocus();
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppLocalizations.current.customUserAgent));
    await tester.pumpAndSettle();
    expect(_editable(tester).focusNode.hasFocus, isTrue);
  });

  testWidgets('active custom value takes precedence over remembered value', (
    tester,
  ) async {
    await _openDialog(
      tester,
      value: 'Active/2.0',
      customValue: 'Remembered/1.0',
    );

    expect(_editable(tester).controller.text, 'Active/2.0');
    expect(_editable(tester).focusNode.hasFocus, isTrue);
  });

  testWidgets('keyboard submit returns a trimmed custom value', (tester) async {
    UaDialogResult? result;
    await _openDialog(
      tester,
      value: 'Custom/1.0',
      onResult: (value) => result = value,
    );

    await tester.enterText(find.byType(TextFormField), '  Custom/2.0  ');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(result?.value, 'Custom/2.0');
    expect(result?.isCustom, isTrue);
  });

  testWidgets('rejects empty and invalid HTTP header values', (tester) async {
    var submitted = false;
    await _openDialog(
      tester,
      value: 'Custom/1.0',
      onResult: (_) => submitted = true,
    );

    for (final value in [
      '',
      '   ',
      'Custom/中文',
      'Custom/é',
      'Custom\rInjected',
      'Custom\u0000Agent',
      'Custom\u007fAgent',
    ]) {
      await tester.enterText(find.byType(TextFormField), value);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(submitted, isFalse, reason: value);
      expect(find.byType(UaDialog), findsOneWidget, reason: value);
      expect(
        tester
            .state<FormFieldState<String>>(find.byType(TextFormField))
            .hasError,
        isTrue,
        reason: value,
      );
    }

    await tester.enterText(
      find.byType(TextFormField),
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Test/1.0',
    );
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(submitted, isTrue);
  });

  for (final value in ['', 'clash-verge/v2.4.2', 'ClashforWindows/0.19.23']) {
    testWidgets('selecting "$value" discards unsaved custom edits', (
      tester,
    ) async {
      UaDialogResult? result;
      await _openDialog(
        tester,
        value: 'Custom/1.0',
        onResult: (value) => result = value,
      );
      await tester.enterText(find.byType(TextFormField), 'Unsaved/2.0');
      await tester.tap(
        find.text(value.isEmpty ? AppLocalizations.current.defaultText : value),
      );
      await tester.pumpAndSettle();
      expect(result?.value, value);
      expect(result?.isCustom, isFalse);
    });
  }

  testWidgets('cancel discards custom edits', (tester) async {
    UaDialogResult? result = const UaDialogResult(value: '', isCustom: false);
    await _openDialog(
      tester,
      value: 'Custom/1.0',
      onResult: (value) => result = value,
    );
    await tester.enterText(find.byType(TextFormField), 'Unsaved/2.0');
    await tester.tap(find.text(AppLocalizations.current.cancel));
    await tester.pumpAndSettle();
    expect(result, isNull);
  });

  testWidgets('limits pasted user agents', (tester) async {
    await _openDialog(tester, value: 'Custom/1.0');
    await tester.enterText(find.byType(TextFormField), 'A' * 600);
    expect(_editable(tester).controller.text.length, TextInputLimits.userAgent);
  });

  for (final locale in [
    const Locale('en'),
    const Locale('zh', 'CN'),
    const Locale('ja'),
    const Locale('ru'),
  ]) {
    testWidgets('custom input fits a narrow screen in $locale', (tester) async {
      tester.view.physicalSize = const Size(320, 700);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await _openDialog(tester, locale: locale, size: const Size(320, 700));
      await tester.tap(find.text(AppLocalizations.current.customUserAgent));
      await tester.pumpAndSettle();
      final hint = tester.renderObject<RenderParagraph>(
        find.text(AppLocalizations.current.customUserAgentHint),
      );
      expect(hint.didExceedMaxLines, isFalse);
      await tester.enterText(find.byType(TextFormField), 'Custom/中文');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      final error = tester.renderObject<RenderParagraph>(
        find.text(AppLocalizations.current.customUserAgentInvalid),
      );
      expect(error.didExceedMaxLines, isFalse);
      expect(tester.takeException(), isNull);
    });
  }
}

EditableText _editable(WidgetTester tester) =>
    tester.widget<EditableText>(find.byType(EditableText));

Future<void> _openDialog(
  WidgetTester tester, {
  String? value,
  String customValue = '',
  ValueChanged<UaDialogResult?>? onResult,
  Locale locale = const Locale('en'),
  Size size = const Size(800, 600),
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [viewSizeProvider.overrideWithBuild((_, _) => size)],
      child: MaterialApp(
        locale: locale,
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
                final result = await showDialog<UaDialogResult>(
                  context: context,
                  builder: (_) =>
                      UaDialog(value: value, customValue: customValue),
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

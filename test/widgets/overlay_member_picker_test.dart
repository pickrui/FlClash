import 'dart:io';
import 'dart:ui' as ui;

import 'package:fl_clash/common/theme.dart';
import 'package:fl_clash/features/overwrite/member_picker.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('search keeps members selected across different queries', (
    tester,
  ) async {
    List<String>? result;
    await _open(
      tester,
      available: const ['Japan Tokyo', 'Japan Osaka', 'US Seattle'],
      selected: const ['Japan Osaka'],
      onResult: (value) => result = value,
    );

    await _search(tester, 'JAPAN');
    expect(_isChecked(tester, 'Japan Osaka'), isTrue);
    expect(find.text('US Seattle'), findsNothing);
    await _toggle(tester, 'Japan Tokyo');

    await _search(tester, 'seattle');
    await _toggle(tester, 'US Seattle');
    await _search(tester, 'japan');
    expect(_isChecked(tester, 'Japan Tokyo'), isTrue);
    expect(_isChecked(tester, 'Japan Osaka'), isTrue);
    await _confirm(tester);

    expect(result, ['Japan Osaka', 'Japan Tokyo', 'US Seattle']);
  });

  testWidgets('unavailable selected members remain visible and removable', (
    tester,
  ) async {
    List<String>? result;
    await _open(
      tester,
      available: const ['Japan Tokyo', 'US Seattle'],
      selected: const ['Removed node', 'Japan Tokyo'],
      onResult: (value) => result = value,
    );

    final missing = _member('Removed node');
    expect(missing, findsOneWidget);
    expect(_isChecked(tester, 'Removed node'), isTrue);
    expect(
      find.descendant(
        of: missing,
        matching: find.text(AppLocalizations.current.outboundUnavailable),
      ),
      findsOneWidget,
    );
    await _toggle(tester, 'Removed node');
    expect(find.text('Removed node'), findsNothing);
    await _confirm(tester);

    expect(result, ['Japan Tokyo']);
  });

  testWidgets('keeps fallback order and moves reselected members to the end', (
    tester,
  ) async {
    List<String>? result;
    await _open(
      tester,
      available: const ['First', 'Second', 'Third'],
      selected: const ['Second', 'First'],
      onResult: (value) => result = value,
    );

    expect(
      find.descendant(of: _member('Second'), matching: find.text('#1')),
      findsOneWidget,
    );
    await _toggle(tester, 'Third');
    await _toggle(tester, 'Second');
    await _toggle(tester, 'Second');
    expect(
      find.descendant(of: _member('Second'), matching: find.text('#3')),
      findsOneWidget,
    );
    await _confirm(tester);

    expect(result, ['First', 'Third', 'Second']);
  });

  testWidgets('cancel keeps caller selection unchanged', (tester) async {
    final selected = ['Japan Tokyo'];
    List<String>? result = const ['not completed'];
    await _open(
      tester,
      available: const ['Japan Tokyo', 'US Seattle'],
      selected: selected,
      onResult: (value) => result = value,
    );

    await _toggle(tester, 'US Seattle');
    await tester.tap(find.text(AppLocalizations.current.cancel));
    await tester.pumpAndSettle();

    expect(result, isNull);
    expect(selected, ['Japan Tokyo']);
  });

  testWidgets('member picker fits 360 wide screens with long node names', (
    tester,
  ) async {
    final screenshotKey = GlobalKey();
    List<String>? result;
    await _open(
      tester,
      size: const Size(360, 640),
      available: const [
        'Japan Tokyo - Streaming and automatic failover',
        'US Seattle - Residential broadband',
        'DIRECT',
      ],
      selected: const ['Japan Tokyo - Streaming and automatic failover'],
      screenshotKey: screenshotKey,
      onResult: (value) => result = value,
    );

    expect(tester.takeException(), isNull);
    final dialogBounds = tester.getRect(find.byType(AlertDialog));
    expect(dialogBounds.left, greaterThanOrEqualTo(0));
    expect(dialogBounds.right, lessThanOrEqualTo(360));
    expect(dialogBounds.bottom, lessThanOrEqualTo(640));
    expect(find.byType(FilledButton).hitTestable(), findsOneWidget);
    await _saveScreenshot(tester, screenshotKey);
    await _search(tester, 'residential');
    await _toggle(tester, 'US Seattle - Residential broadband');
    await _confirm(tester);

    expect(result, [
      'Japan Tokyo - Streaming and automatic failover',
      'US Seattle - Residential broadband',
    ]);
    expect(tester.takeException(), isNull);
  });
}

Finder _member(String name) => find.widgetWithText(CheckboxListTile, name);

bool _isChecked(WidgetTester tester, String name) =>
    tester.widget<CheckboxListTile>(_member(name)).value == true;

Future<void> _search(WidgetTester tester, String query) async {
  await tester.enterText(find.byType(TextField), query);
  await tester.pumpAndSettle();
}

Future<void> _toggle(WidgetTester tester, String name) async {
  await tester.tap(_member(name));
  await tester.pumpAndSettle();
}

Future<void> _confirm(WidgetTester tester) async {
  await tester.tap(find.byType(FilledButton));
  await tester.pumpAndSettle();
}

Future<void> _open(
  WidgetTester tester, {
  required List<String> available,
  required List<String> selected,
  required ValueChanged<List<String>?> onResult,
  Size size = const Size(800, 800),
  GlobalKey? screenshotKey,
}) async {
  final previewFont = await _loadPreviewFont(tester);
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    ProviderScope(
      overrides: [viewSizeProvider.overrideWithBuild((_, _) => size)],
      child: MaterialApp(
        locale: const Locale('en'),
        theme: ThemeData(fontFamily: previewFont),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        builder: (context, child) {
          globalState.theme = CommonTheme.of(context, 1);
          return RepaintBoundary(key: screenshotKey, child: child!);
        },
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () async {
                final result = await showDialog<List<String>>(
                  context: context,
                  builder: (_) => ProxyMemberPicker(
                    title: 'Choose members',
                    available: available,
                    selected: selected,
                  ),
                );
                onResult(result);
              },
              child: const Text('Open members'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('Open members'));
  await tester.pumpAndSettle();
}

Future<void> _saveScreenshot(WidgetTester tester, GlobalKey key) async {
  final directory = Platform.environment['FLCLASH_WIDGET_SCREENSHOT_DIR'];
  if (directory == null || directory.isEmpty) return;
  final boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  await tester.runAsync(() async {
    await Directory(directory).create(recursive: true);
    final image = await boundary.toImage(pixelRatio: 2);
    try {
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      await File('$directory/overlay-member-picker-360.png').writeAsBytes(
        bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
      );
    } finally {
      image.dispose();
    }
  });
}

Future<String?> _loadPreviewFont(WidgetTester tester) async {
  final fontPath = Platform.environment['FLCLASH_WIDGET_FONT'];
  if (fontPath == null || fontPath.isEmpty) return null;
  await tester.runAsync(() async {
    final bytes = await File(fontPath).readAsBytes();
    final loader = FontLoader('OverlayPreview')
      ..addFont(
        Future.value(
          bytes.buffer.asByteData(bytes.offsetInBytes, bytes.lengthInBytes),
        ),
      );
    await loader.load();
    await (FontLoader(
      'MaterialIcons',
    )..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
    await (FontLoader('JetBrainsMono')
          ..addFont(rootBundle.load('assets/fonts/JetBrainsMono-Regular.ttf')))
        .load();
  });
  return 'OverlayPreview';
}

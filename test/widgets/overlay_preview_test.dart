import 'dart:io';
import 'dart:ui' as ui;

import 'package:fl_clash/common/theme.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/features/overwrite/custom_rule_editor.dart';
import 'package:fl_clash/features/overwrite/member_picker.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/dialog.dart';
import 'package:fl_clash/features/overwrite/proxy_group_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final screenshotDirectory =
      Platform.environment['FLCLASH_WIDGET_SCREENSHOT_DIR'];
  final skip = screenshotDirectory == null || screenshotDirectory.isEmpty;

  testWidgets('capture new personal group at 360 pixels', (tester) async {
    final key = await _open(
      tester,
      const ProxyGroupDialog(
        existingGroups: [],
        availableMembers: ['DIRECT', 'REJECT', 'Japan Tokyo', 'US Seattle'],
        availableProviders: ['Subscription nodes'],
      ),
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, AppLocalizations.current.name),
      'Japan automatic',
    );
    await tester.tap(find.byType(DropdownButtonFormField<GroupType>));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppLocalizations.current.groupTypeUrlTest).last);
    await tester.pumpAndSettle();
    await _capture(tester, key, 'overlay-new-group-360.png');
  }, skip: skip);

  testWidgets('capture retained group draft after validation fails', (
    tester,
  ) async {
    final key = await _open(
      tester,
      ProxyGroupDialog(
        group: const ProxyGroup(
          name: 'Japan automatic',
          type: GroupType.URLTest,
          use: ['Retired subscription'],
          filter: 'Japan|JP',
        ),
        existingGroups: const [],
        availableMembers: const ['DIRECT', 'Japan Tokyo'],
        availableProviders: const ['Subscription nodes'],
        validate: (_) async =>
            "Japan automatic: 'Retired subscription' not found. Choose an available provider.",
      ),
    );
    await tester.tap(find.text(AppLocalizations.current.save));
    await tester.pumpAndSettle();
    expect(find.textContaining('Retired subscription'), findsWidgets);
    await _capture(tester, key, 'overlay-group-error-360.png');
  }, skip: skip);

  testWidgets('capture visual rule form at 360 pixels', (tester) async {
    final key = await _open(
      tester,
      const CustomRuleEditorDialog(
        rule: Rule(id: 1, value: 'DOMAIN-SUFFIX,youtube.com,Japan automatic'),
        targets: ['DIRECT', 'REJECT', 'Japan automatic', 'US fallback'],
        ruleProviders: ['Streaming', 'Advertising'],
      ),
    );
    await _capture(tester, key, 'overlay-rule-form-360.png');
  }, skip: skip);
  testWidgets('CommonDialog retains its existing default dimensions', (
    tester,
  ) async {
    for (final scenario in const [
      (size: Size(360, 640), width: 280.0),
      (size: Size(1280, 800), width: 348.0),
    ]) {
      await _open(
        tester,
        const CommonDialog(title: 'Dialog', child: Text('Existing content')),
        size: scenario.size,
      );
      final surface = find
          .descendant(
            of: find.byType(AlertDialog),
            matching: find.byType(Material),
          )
          .first;
      expect(tester.getSize(surface).width, scenario.width);
      expect(tester.takeException(), isNull);
    }
  });

  for (final locale in const [
    Locale('en'),
    Locale('zh', 'CN'),
    Locale('ja'),
    Locale('ru'),
  ]) {
    for (final scenario in const [
      (name: 'compact', size: Size(360, 640), scale: 1.0, keyboard: 0.0),
      (name: 'desktop', size: Size(1280, 800), scale: 1.0, keyboard: 0.0),
      (name: 'large-text', size: Size(360, 740), scale: 2.0, keyboard: 0.0),
      (name: 'keyboard', size: Size(360, 740), scale: 1.3, keyboard: 300.0),
    ]) {
      testWidgets(
        '${locale.toLanguageTag()} ${scenario.name} routing editors remain usable',
        (tester) async {
          final prefix = '${locale.toLanguageTag()}-${scenario.name}';
          Object? result;
          Future<GlobalKey> open(Widget dialog) => _open(
            tester,
            dialog,
            locale: locale,
            size: scenario.size,
            textScale: scenario.scale,
            keyboardHeight: scenario.keyboard,
            onResult: (value) => result = value,
          );

          var key = await open(
            const CustomRuleEditorDialog(
              rule: Rule(
                id: 1,
                value: 'DOMAIN-SUFFIX,example.com,Japan automatic',
              ),
              targets: ['DIRECT', 'REJECT', 'Japan automatic'],
            ),
          );
          _expectActionsVisible(tester, scenario.size, scenario.keyboard);
          if (!skip) await _capture(tester, key, '$prefix-rule.png');
          await tester.ensureVisible(
            find.byKey(const Key('custom-rule-target')),
          );
          await tester.tap(find.byKey(const Key('custom-rule-target')));
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
          await tester.enterText(
            find.byKey(const Key('custom-rule-option-search')),
            'DIRECT',
          );
          await tester.pumpAndSettle();
          await tester.tap(find.widgetWithText(ListTile, 'DIRECT'));
          await tester.pumpAndSettle();
          await tester.tap(find.byKey(const Key('custom-rule-save')));
          await tester.pumpAndSettle();
          expect(find.byType(CustomRuleEditorDialog), findsNothing);
          expect((result as Rule).value, 'DOMAIN-SUFFIX,example.com,DIRECT');
          expect(tester.takeException(), isNull);

          key = await open(
            ProxyGroupDialog(
              group: const ProxyGroup(
                name: 'Japan automatic',
                type: GroupType.URLTest,
                use: ['Retired subscription'],
                filter: 'Japan|JP',
              ),
              existingGroups: const [],
              availableMembers: const ['DIRECT', 'Japan Tokyo'],
              availableProviders: const ['Subscription nodes'],
              validate: (_) async => AppLocalizations.current.routingChanged,
            ),
          );
          await tester.tap(find.text(AppLocalizations.current.save));
          await tester.pumpAndSettle();
          _expectActionsVisible(tester, scenario.size, scenario.keyboard);
          expect(
            find.text(AppLocalizations.current.routingChanged),
            findsOneWidget,
          );
          if (!skip) await _capture(tester, key, '$prefix-group-error.png');
          await tester.tap(find.text(AppLocalizations.current.cancel));
          await tester.pumpAndSettle();
          expect(find.byType(ProxyGroupDialog), findsNothing);

          key = await open(
            ProxyMemberPicker(
              title: AppLocalizations.current.chooseMembers,
              available: const [
                'Japan Tokyo - Streaming and automatic failover',
                'US Seattle - Residential broadband',
                'DIRECT',
              ],
              selected: const [
                'Japan Tokyo - Streaming and automatic failover',
              ],
            ),
          );
          _expectActionsVisible(tester, scenario.size, scenario.keyboard);
          if (!skip) await _capture(tester, key, '$prefix-members.png');
          await tester.enterText(find.byType(TextField), 'residential');
          await tester.pumpAndSettle();
          await tester.ensureVisible(find.byType(Checkbox));
          await tester.pumpAndSettle();
          expect(find.byType(Checkbox).hitTestable(), findsOneWidget);
          await tester.tap(find.byType(Checkbox));
          await tester.pumpAndSettle();
          await tester.tap(find.byType(FilledButton));
          await tester.pumpAndSettle();
          expect(find.byType(ProxyMemberPicker), findsNothing);
          expect(result, [
            'Japan Tokyo - Streaming and automatic failover',
            'US Seattle - Residential broadband',
          ]);
          expect(tester.takeException(), isNull);
        },
      );
    }
  }
}

Future<GlobalKey> _open(
  WidgetTester tester,
  Widget dialog, {
  Size size = const Size(360, 740),
  Locale? locale,
  double textScale = 1,
  double keyboardHeight = 0,
  ValueChanged<Object?>? onResult,
}) async {
  final key = GlobalKey();
  String? previewFont;
  final localeParts = (Platform.environment['FLCLASH_WIDGET_LOCALE'] ?? 'en')
      .split('_');
  locale ??= Locale(
    localeParts.first,
    localeParts.length > 1 ? localeParts[1] : null,
  );
  final fontPath = Platform.environment['FLCLASH_WIDGET_FONT'];
  if (fontPath != null && fontPath.isNotEmpty) {
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
      await (FontLoader(
            'JetBrainsMono',
          )..addFont(rootBundle.load('assets/fonts/JetBrainsMono-Regular.ttf')))
          .load();
    });
    previewFont = 'OverlayPreview';
  }
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    ProviderScope(
      overrides: [viewSizeProvider.overrideWithBuild((_, _) => size)],
      child: MaterialApp(
        key: UniqueKey(),
        locale: locale,
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
          return RepaintBoundary(
            key: key,
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(textScale),
                viewInsets: EdgeInsets.only(bottom: keyboardHeight),
              ),
              child: child!,
            ),
          );
        },
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () async {
                final result = await showDialog<Object>(
                  context: context,
                  builder: (_) => dialog,
                );
                onResult?.call(result);
              },
              child: const Text('Open preview'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('Open preview'));
  await tester.pumpAndSettle();
  return key;
}

Future<void> _capture(WidgetTester tester, GlobalKey key, String name) async {
  expect(tester.takeException(), isNull);
  final boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  final directory = Platform.environment['FLCLASH_WIDGET_SCREENSHOT_DIR']!;
  await tester.runAsync(() async {
    await Directory(directory).create(recursive: true);
    final image = await boundary.toImage(pixelRatio: 2);
    try {
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      await File('$directory/$name').writeAsBytes(
        bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
      );
    } finally {
      image.dispose();
    }
  });
}

void _expectActionsVisible(WidgetTester tester, Size size, double keyboard) {
  expect(tester.takeException(), isNull);
  final bounds = tester.getRect(find.byType(AlertDialog));
  expect(bounds.left, greaterThanOrEqualTo(0));
  expect(bounds.right, lessThanOrEqualTo(size.width));
  expect(bounds.top, greaterThanOrEqualTo(0));
  expect(bounds.bottom, lessThanOrEqualTo(size.height));
  for (final button
      in find
          .byType(TextButton)
          .evaluate()
          .where(
            (element) =>
                element.findAncestorWidgetOfExactType<AlertDialog>() != null,
          )) {
    final finder = find.byWidget(button.widget);
    expect(finder.hitTestable(), findsOneWidget);
    expect(
      tester.getRect(finder).bottom,
      lessThanOrEqualTo(size.height - keyboard),
    );
  }
  expect(find.byType(FilledButton).hitTestable(), findsOneWidget);
  expect(
    tester.getRect(find.byType(FilledButton)).bottom,
    lessThanOrEqualTo(size.height - keyboard),
  );
}

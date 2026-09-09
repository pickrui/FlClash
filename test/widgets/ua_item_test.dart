import 'package:fl_clash/common/theme.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/config/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('remembers custom values when switching to preset and default', (
    tester,
  ) async {
    final container = await _showSettings(tester);
    await tester.tap(find.byType(UaItem));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppLocalizations.current.customUserAgent));
    await tester.pumpAndSettle();
    expect(find.text('Remembered/1.0'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), '  Saved/2.0  ');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(container.read(patchClashConfigProvider).globalUa, 'Saved/2.0');
    expect(container.read(appSettingProvider).customUserAgent, 'Saved/2.0');

    await tester.tap(find.byType(UaItem));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'Unsaved/3.0');
    await tester.tap(find.text('clash-verge/v2.4.2'));
    await tester.pumpAndSettle();
    expect(
      container.read(patchClashConfigProvider).globalUa,
      'clash-verge/v2.4.2',
    );
    expect(container.read(appSettingProvider).customUserAgent, 'Saved/2.0');

    await tester.tap(find.byType(UaItem));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppLocalizations.current.defaultText));
    await tester.pumpAndSettle();
    expect(container.read(patchClashConfigProvider).globalUa, isNull);
    expect(container.read(appSettingProvider).customUserAgent, 'Saved/2.0');

    await tester.tap(find.byType(UaItem));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppLocalizations.current.customUserAgent));
    await tester.pumpAndSettle();
    expect(find.text('Saved/2.0'), findsOneWidget);
  });

  testWidgets('discards dialog result when settings item was removed', (
    tester,
  ) async {
    final visible = ValueNotifier(true);
    addTearDown(visible.dispose);
    final container = await _showSettings(tester, visible: visible);
    await tester.tap(find.byType(UaItem));
    await tester.pumpAndSettle();

    visible.value = false;
    await tester.pumpAndSettle();
    await tester.tap(find.text('clash-verge/v2.4.2'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(container.read(patchClashConfigProvider).globalUa, isNull);
    expect(
      container.read(appSettingProvider).customUserAgent,
      'Remembered/1.0',
    );
  });
}

Future<ProviderContainer> _showSettings(
  WidgetTester tester, {
  ValueNotifier<bool>? visible,
}) async {
  final container = ProviderContainer(
    overrides: [
      viewSizeProvider.overrideWithBuild((_, _) => const Size(800, 600)),
      appSettingProvider.overrideWithBuild(
        (_, _) => const AppSettingProps(customUserAgent: 'Remembered/1.0'),
      ),
    ],
  );
  addTearDown(container.dispose);
  container.listen(appSettingProvider, (_, _) {});
  container.listen(patchClashConfigProvider, (_, _) {});
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        navigatorKey: globalState.navigatorKey,
        locale: const Locale('en'),
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
        home: Scaffold(
          body: visible == null
              ? const UaItem()
              : ValueListenableBuilder<bool>(
                  valueListenable: visible,
                  builder: (_, value, _) =>
                      value ? const UaItem() : const SizedBox.shrink(),
                ),
        ),
      ),
    ),
  );
  return container;
}

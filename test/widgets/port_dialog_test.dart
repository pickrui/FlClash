import 'package:fl_clash/common/theme.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/config/general.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('a hidden port left empty reopens the extra ports on submit', (
    tester,
  ) async {
    final container = await _openPortDialog(tester);
    final l10n = AppLocalizations.current;
    await tester.tap(find.byType(CommonExpandIcon));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextFormField, l10n.socksPort),
      '',
    );
    await tester.tap(find.byType(CommonExpandIcon));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(TextFormField, l10n.socksPort), findsNothing);

    await tester.tap(find.text(l10n.submit));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text(l10n.emptyTip(l10n.socksPort)), findsOneWidget);
    expect(container.read(patchClashConfigProvider), const ClashConfig());
  });

  testWidgets('ports that differ only by leading zeros conflict', (
    tester,
  ) async {
    final container = await _openPortDialog(tester);
    final l10n = AppLocalizations.current;
    await tester.tap(find.byType(CommonExpandIcon));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextFormField, l10n.port).last,
      '0$defaultMixedPort',
    );
    await tester.tap(find.text(l10n.submit));
    await tester.pumpAndSettle();

    expect(find.text(l10n.portConflictTip), findsWidgets);
    expect(container.read(patchClashConfigProvider).port, 0);
  });
}

Future<ProviderContainer> _openPortDialog(WidgetTester tester) async {
  tester.view.physicalSize = const Size(800, 1200);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final container = ProviderContainer(
    overrides: [
      viewSizeProvider.overrideWithBuild((_, _) => const Size(800, 1200)),
    ],
  );
  addTearDown(container.dispose);
  container.listen(patchClashConfigProvider, (_, _) {});
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        navigatorKey: globalState.navigatorKey,
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        builder: (context, child) {
          globalState.theme = CommonTheme.of(context, 1);
          return child!;
        },
        home: const Scaffold(body: PortItem()),
      ),
    ),
  );
  await tester.tap(find.byType(PortItem));
  await tester.pumpAndSettle();
  return container;
}

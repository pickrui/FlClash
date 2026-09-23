import 'package:fl_clash/common/theme.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/hotkey.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

final _modeBinding = HotKeyAction(
  action: HotAction.mode,
  key: PhysicalKeyboardKey.keyM.usbHidUsage,
  modifiers: const {KeyboardModifier.control},
);

void main() {
  testWidgets('confirming an action with its own binding is not a conflict', (
    tester,
  ) async {
    final container = await _openRecorder(tester, _modeBinding);
    final writes = <List<HotKeyAction>>[];
    container.listen(hotKeyActionsProvider, (_, next) => writes.add(next));

    await tester.tap(find.text(AppLocalizations.current.confirm));
    await tester.pumpAndSettle();

    expect(find.text(AppLocalizations.current.hotkeyConflict), findsNothing);
    expect(writes, hasLength(1));
    expect(container.read(hotKeyActionsProvider), [_modeBinding]);
  });

  testWidgets('a binding owned by another action is still a conflict', (
    tester,
  ) async {
    final container = await _openRecorder(
      tester,
      _modeBinding.copyWith(action: HotAction.start),
    );

    await tester.tap(find.text(AppLocalizations.current.confirm));
    await tester.pumpAndSettle();

    expect(find.text(AppLocalizations.current.hotkeyConflict), findsOneWidget);
    expect(container.read(hotKeyActionsProvider), [_modeBinding]);
  });
}

Future<ProviderContainer> _openRecorder(
  WidgetTester tester,
  HotKeyAction recorded,
) async {
  final container = ProviderContainer(
    overrides: [
      viewSizeProvider.overrideWithBuild((_, _) => const Size(800, 600)),
      hotKeyActionsProvider.overrideWithBuild((_, _) => [_modeBinding]),
    ],
  );
  addTearDown(container.dispose);
  container.listen(hotKeyActionsProvider, (_, _) {});
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
        home: const Scaffold(),
      ),
    ),
  );
  globalState.showCommonDialog(child: HotKeyRecorder(hotKeyAction: recorded));
  await tester.pumpAndSettle();
  return container;
}

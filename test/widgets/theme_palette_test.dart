import 'package:fl_clash/common/constant.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/theme.dart';
import 'package:fl_clash/widgets/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/test_app.dart';

void main() {
  testWidgets('a color picked on the palette is saved opaque', (tester) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    globalState.accentColor = const Color(defaultPrimaryColor);
    final container = ProviderContainer(
      overrides: [
        viewSizeProvider.overrideWithBuild((_, _) => const Size(800, 1200)),
      ],
    );
    addTearDown(container.dispose);
    container.listen(themeSettingProvider, (_, _) {});
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const TestApp(locale: Locale('en'), child: ThemeView()),
      ),
    );
    await tester.pumpAndSettle();
    final before = container.read(themeSettingProvider).primaryColors;

    await tester.tap(find.byTooltip(AppLocalizations.current.add));
    await tester.pumpAndSettle();
    await tester.dragFrom(
      tester.getCenter(find.byType(Palette)) + const Offset(20, -20),
      const Offset(4, 4),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppLocalizations.current.confirm));
    await tester.pumpAndSettle();

    final added = container
        .read(themeSettingProvider)
        .primaryColors
        .where((color) => !before.contains(color))
        .toList();
    expect(added, hasLength(1));
    expect(added.single >>> 24, 0xFF);
  });
}

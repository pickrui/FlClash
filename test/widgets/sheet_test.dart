import 'package:fl_clash/widgets/inherited.dart';
import 'package:fl_clash/widgets/sheet.dart';
import 'package:fl_clash/widgets/side_sheet.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/test_app.dart';

Future<BuildContext> _pumpHost(WidgetTester tester) async {
  late BuildContext host;
  await tester.pumpWidget(
    TestApp(
      locale: const Locale('en'),
      wrapInProviderScope: true,
      child: Builder(
        builder: (context) {
          host = context;
          return const Scaffold(body: SizedBox.expand());
        },
      ),
    ),
  );
  return host;
}

Future<void> _openSheet(
  BuildContext host,
  SheetType type, {
  List<Widget> actions = const [],
}) {
  Widget builder(BuildContext _) => SheetProvider(
    type: type,
    child: AdaptiveSheetScaffold(
      title: 'Sheet',
      body: const Text('body'),
      actions: actions,
    ),
  );
  return switch (type) {
    SheetType.bottomSheet => showModalBottomSheet<void>(
      context: host,
      builder: builder,
    ),
    _ => showModalSideSheet<void>(context: host, builder: builder),
  };
}

void main() {
  for (final type in [SheetType.sideSheet, SheetType.bottomSheet]) {
    for (final withActions in [false, true]) {
      final label = withActions ? 'with actions' : 'without actions';
      testWidgets('${type.name} close button pops the sheet $label', (
        tester,
      ) async {
        final host = await _pumpHost(tester);
        var closed = false;
        _openSheet(
          host,
          type,
          actions: [
            if (withActions)
              IconButton(onPressed: () {}, icon: const Icon(Icons.check)),
          ],
        ).then((_) => closed = true);
        await tester.pumpAndSettle();
        expect(find.text('body'), findsOneWidget);
        expect(find.byIcon(Icons.check), withActions ? findsOne : findsNothing);

        await tester.tap(find.byIcon(Icons.close));
        await tester.pumpAndSettle();

        expect(find.text('body'), findsNothing);
        expect(closed, isTrue);
        expect(tester.takeException(), isNull);
      });
    }
  }

  test('SheetProvider notifies dependents only when the type changes', () {
    const page = SheetProvider(type: SheetType.page, child: SizedBox());
    expect(
      page.updateShouldNotify(
        const SheetProvider(type: SheetType.page, child: SizedBox()),
      ),
      isFalse,
    );
    expect(
      page.updateShouldNotify(
        const SheetProvider(type: SheetType.sideSheet, child: SizedBox()),
      ),
      isTrue,
    );
  });
}

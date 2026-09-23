import 'package:fl_clash/widgets/palette.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  Future<Offset> pumpPalette(
    WidgetTester tester,
    ValueNotifier<Color> controller,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: SizedBox(
            width: 250,
            height: 250,
            child: Palette(controller: controller),
          ),
        ),
      ),
    );
    return tester.getCenter(find.byType(Palette));
  }

  testWidgets('hue ring keeps a color set from outside the palette', (
    tester,
  ) async {
    final controller = ValueNotifier<Color>(const Color(0xFF919191));
    addTearDown(controller.dispose);
    final center = await pumpPalette(tester, controller);

    controller.value = const Color(0xFF00FF00);
    await tester.pump();

    final ring = await tester.startGesture(center + const Offset(0, -115));
    await ring.up();
    await tester.pump();

    final picked = HSVColor.fromColor(controller.value);
    expect(picked.saturation, closeTo(1, 0.01));
    expect(picked.value, closeTo(1, 0.01));
    expect(picked.hue, closeTo(270, 5));
  });

  testWidgets('palette gestures keep the hue of a gray pick', (tester) async {
    final controller = ValueNotifier<Color>(const Color(0xFF919191));
    addTearDown(controller.dispose);
    final center = await pumpPalette(tester, controller);

    final ring = await tester.startGesture(center + const Offset(0, -115));
    await ring.up();
    await tester.pump();
    final square = await tester.startGesture(center + const Offset(-60, 0));
    await square.up();
    await tester.pump();
    final square2 = await tester.startGesture(center + const Offset(30, 0));
    await square2.up();
    await tester.pump();

    expect(HSVColor.fromColor(controller.value).hue, closeTo(270, 5));
  });

  testWidgets('palette is not a keyboard focus stop', (tester) async {
    final controller = ValueNotifier<Color>(const Color(0xFF919191));
    addTearDown(controller.dispose);
    await pumpPalette(tester, controller);

    final nodes = FocusManager.instance.rootScope.traversalDescendants.where(
      (node) => node.context?.findAncestorWidgetOfExactType<Palette>() != null,
    );
    expect(nodes, isEmpty);
  });
}

import 'package:fl_clash/widgets/grid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  const first = Key('first');
  const second = Key('second');

  Widget app(Grid grid) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Align(
        alignment: Alignment.topLeft,
        child: SizedBox(width: 300, child: grid),
      ),
    );
  }

  Offset offsetOf(WidgetTester tester, Key key) {
    return tester.getTopLeft(find.byKey(key)) -
        tester.getTopLeft(find.byType(Grid));
  }

  testWidgets('right-to-left grids mirror each child by its own span', (
    tester,
  ) async {
    await tester.pumpWidget(
      app(
        const Grid(
          crossAxisCount: 3,
          textDirection: TextDirection.rtl,
          children: [
            GridItem(
              crossAxisCellCount: 2,
              child: SizedBox(key: first, height: 10),
            ),
            GridItem(child: SizedBox(key: second, height: 10)),
          ],
        ),
      ),
    );

    expect(offsetOf(tester, first), const Offset(100, 0));
    expect(offsetOf(tester, second), Offset.zero);
  });

  testWidgets('reversed grids place fit-content children from the end', (
    tester,
  ) async {
    await tester.pumpWidget(
      app(
        const Grid(
          axisDirection: AxisDirection.up,
          children: [
            GridItem(child: SizedBox(key: first, height: 10)),
            GridItem(child: SizedBox(key: second, height: 20)),
          ],
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(offsetOf(tester, first), const Offset(0, 20));
    expect(offsetOf(tester, second), Offset.zero);
  });

  testWidgets('a misplaced GridItem names Grid as its expected parent', (
    tester,
  ) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: Column(children: [GridItem(child: SizedBox())]),
      ),
    );

    expect(
      tester.takeException().toString(),
      contains('GridItem widgets are placed directly inside Grid widgets'),
    );
  });
}

import 'package:fl_clash/widgets/grid.dart';
import 'package:fl_clash/widgets/super_grid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  Future<GlobalKey<SuperGridState>> pumpGrid(WidgetTester tester) async {
    final key = GlobalKey<SuperGridState>();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: SuperGrid(
              key: key,
              crossAxisCount: 8,
              children: [
                for (var i = 0; i < 4; i++)
                  GridItem(
                    crossAxisCellCount: 4,
                    child: SizedBox(height: 60, child: Text('item$i')),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 50));
    return key;
  }

  List<String?> labels(GlobalKey<SuperGridState> key) {
    return key.currentState!.children
        .map((item) => ((item.child as SizedBox).child as Text).data)
        .toList();
  }

  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 30; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  testWidgets('a second delete waits until the first one lands', (
    tester,
  ) async {
    final key = await pumpGrid(tester);

    await tester.tap(find.byIcon(Icons.close).at(1));
    await tester.pump(const Duration(milliseconds: 100));
    final pending = tester.widgetList<IconButton>(find.byType(IconButton));
    expect(pending.every((button) => button.onPressed == null), isTrue);
    await tester.tap(find.byIcon(Icons.close).last, warnIfMissed: false);
    await settle(tester);

    expect(labels(key), ['item0', 'item2', 'item3']);

    await tester.tap(find.byIcon(Icons.close).last);
    await settle(tester);

    expect(labels(key), ['item0', 'item2']);
  });

  testWidgets('a second delete in the same frame leaves its item alone', (
    tester,
  ) async {
    final key = await pumpGrid(tester);

    await tester.tap(find.byIcon(Icons.close).at(1));
    await tester.tap(find.byIcon(Icons.close).last);
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byIcon(Icons.close), findsNWidgets(3));
    await settle(tester);

    expect(labels(key), ['item0', 'item2', 'item3']);
  });

  testWidgets('dragging an item onto another reorders the grid', (
    tester,
  ) async {
    final key = await pumpGrid(tester);
    final from = tester.getCenter(find.text('item0'));
    final to = tester.getCenter(find.text('item3'));

    final gesture = await tester.startGesture(from);
    await tester.pump(const Duration(milliseconds: 600));
    await gesture.moveTo(from + const Offset(10, 10));
    await tester.pump(const Duration(milliseconds: 50));
    await gesture.moveTo(to);
    await settle(tester);
    await gesture.moveTo(to + const Offset(1, 1));
    await settle(tester);
    await gesture.up();
    await settle(tester);

    expect(labels(key), ['item1', 'item2', 'item3', 'item0']);
  });
}

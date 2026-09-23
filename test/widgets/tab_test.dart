import 'package:fl_clash/widgets/tab.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('a tap on a segment separator selects the nearest segment', (
    tester,
  ) async {
    final changes = <int?>[];
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 300,
              child: CommonTabBar<int>(
                children: const {
                  0: SizedBox(height: 48, child: Center(child: Text('Rule'))),
                  1: SizedBox(height: 48, child: Center(child: Text('Global'))),
                  2: SizedBox(height: 48, child: Center(child: Text('Direct'))),
                },
                groupValue: 0,
                thumbColor: Colors.blue,
                onValueChanged: changes.add,
              ),
            ),
          ),
        ),
      ),
    );

    final separators = find.byWidgetPredicate(
      (widget) => widget.runtimeType.toString() == '_SegmentSeparator',
    );
    expect(separators, findsNWidgets(2));

    await tester.tapAt(tester.getCenter(separators.last));
    await tester.pumpAndSettle();

    expect(changes, [2]);
  });
}

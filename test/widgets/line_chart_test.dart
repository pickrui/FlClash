import 'package:fl_clash/widgets/line_chart.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> show(
    WidgetTester tester,
    List<Point> points, {
    Duration duration = Duration.zero,
    Color color = Colors.blue,
  }) => tester.pumpWidget(
    MaterialApp(
      home: SizedBox(
        width: 240,
        height: 100,
        child: LineChart(
          points: points,
          color: color,
          duration: duration,
          gradient: true,
        ),
      ),
    ),
  );
  LineChartPainter painter(WidgetTester tester) =>
      tester
              .widget<CustomPaint>(
                find.descendant(
                  of: find.byType(LineChart),
                  matching: find.byType(CustomPaint),
                ),
              )
              .painter!
          as LineChartPainter;

  testWidgets(
    'zero-duration chart draws final data without animation or redundant repaint',
    (tester) async {
      await show(tester, [const Point(0, 0), const Point(1, 3)]);
      expect(
        find.descendant(
          of: find.byType(LineChart),
          matching: find.byType(AnimatedBuilder),
        ),
        findsNothing,
      );
      final previous = painter(tester);
      expect(previous.progress, 1);
      await show(tester, [const Point(0, 0), const Point(1, 3)]);
      expect(painter(tester).shouldRepaint(previous), isFalse);
      await show(tester, [
        const Point(0, 0),
        const Point(1, 3),
      ], color: Colors.red);
      expect(painter(tester).shouldRepaint(previous), isTrue);
      await show(tester, []);
      expect(painter(tester).currentRenderPoints, isEmpty);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'animation can be enabled disabled and enabled again on the same chart',
    (tester) async {
      const duration = Duration(seconds: 1);
      await show(tester, [const Point(0, 0), const Point(1, 1)]);
      await show(tester, [
        const Point(0, 1),
        const Point(1, 0),
      ], duration: duration);
      expect(painter(tester).progress, 0);
      await tester.pump(const Duration(milliseconds: 500));
      expect(painter(tester).progress, closeTo(0.5, 0.01));
      await show(tester, [const Point(0, 1), const Point(1, 0)]);
      expect(painter(tester).progress, 1);
      await show(tester, [
        const Point(0, 0),
        const Point(1, 2),
      ], duration: duration);
      await tester.pump(duration);
      expect(painter(tester).progress, 1);
      expect(tester.takeException(), isNull);
    },
  );
}

import 'package:fl_clash/pages/error.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('startup errors remain visible before localizations are loaded', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: InitErrorScreen(
          error: StateError('early startup failure'),
          stack: StackTrace.empty,
        ),
      ),
    );
    expect(tester.takeException(), isNull);
    expect(find.text('Bad state: early startup failure'), findsOneWidget);
  });
}

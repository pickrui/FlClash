import 'package:fl_clash/widgets/side_sheet.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('side sheet scrim stays reachable by screen readers', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    late BuildContext hostContext;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            hostContext = context;
            return const Scaffold(body: SizedBox.expand());
          },
        ),
      ),
    );

    showModalSideSheet<void>(
      context: hostContext,
      constraints: const BoxConstraints(maxWidth: 360),
      builder: (_) => const Scaffold(body: Text('sheet')),
    );
    await tester.pumpAndSettle();
    expect(find.text('sheet'), findsOneWidget);

    SemanticsNode? scrim;
    void visit(SemanticsNode node) {
      if (node.label == 'Scrim') {
        scrim = node;
      }
      node.visitChildren((child) {
        visit(child);
        return true;
      });
    }

    var root = tester.getSemantics(find.text('sheet'));
    while (root.parent != null) {
      root = root.parent!;
    }
    visit(root);
    expect(scrim, isNotNull);
    expect(scrim!.rect.width, closeTo(800 - 360, 0.1));
    expect(scrim!.rect.height, 600);

    await tester.tapAt(const Offset(20, 300));
    await tester.pumpAndSettle();
    expect(find.text('sheet'), findsNothing);
    handle.dispose();
  });
}

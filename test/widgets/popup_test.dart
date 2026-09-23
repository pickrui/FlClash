import 'package:fl_clash/models/common.dart';
import 'package:fl_clash/widgets/popup.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  Future<void> pumpMenu(WidgetTester tester, List<String> pressed) {
    return tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Align(
            alignment: Alignment.topRight,
            child: CommonPopupBox(
              targetBuilder: (open) => IconButton(
                onPressed: () => open(),
                icon: const Icon(Icons.more_vert),
              ),
              popup: CommonPopupMenu(
                items: [
                  PopupMenuItemData(
                    label: 'Edit',
                    onPressed: () => pressed.add('Edit'),
                  ),
                  PopupMenuItemData(
                    label: 'More',
                    subItems: [
                      PopupMenuItemData(
                        label: 'Delete',
                        onPressed: () => pressed.add('Delete'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('popup menu runs an item and closes', (tester) async {
    final pressed = <String>[];
    await pumpMenu(tester, pressed);

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    expect(find.text('Edit'), findsOneWidget);
    expect(find.byType(Divider), findsOneWidget);

    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();
    expect(pressed, ['Edit']);
    expect(find.text('Edit'), findsNothing);
  });

  testWidgets('popup menu opens a sub menu and closes on the barrier', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    final pressed = <String>[];
    await pumpMenu(tester, pressed);

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel('Dismiss'), findsOneWidget);
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    expect(find.text('Delete'), findsOneWidget);

    await tester.tapAt(const Offset(8, 500));
    await tester.pumpAndSettle();
    expect(find.text('Delete'), findsNothing);
    expect(pressed, isEmpty);
    semantics.dispose();
  });
}

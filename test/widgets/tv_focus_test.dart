import 'package:fl_clash/manager/app_manager.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('navigation rail handles remote navigation and boundary exit', (
    tester,
  ) async {
    final harnessKey = GlobalKey<_NavigationHarnessState>();
    await tester.pumpWidget(
      MaterialApp(home: _NavigationHarness(key: harnessKey)),
    );
    await tester.pump();

    expect(_primaryFocusIsInside<NavigationRailFocus>(), isTrue);

    await tester.sendKeyDownEvent(LogicalKeyboardKey.arrowDown);
    await tester.pump();
    await tester.sendKeyRepeatEvent(LogicalKeyboardKey.arrowDown);
    await tester.pump();
    await tester.sendKeyUpEvent(LogicalKeyboardKey.arrowDown);
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
    await tester.pump();

    expect(harnessKey.currentState!.selectedIndexes, [1, 2]);
    expect(_primaryFocusIsInside<IconButton>(), isTrue);

    await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
    await tester.pump();
    expect(_primaryFocusIsInside<NavigationRailFocus>(), isTrue);

    await tester.sendKeyEvent(LogicalKeyboardKey.select);
    await tester.pump();
    expect(harnessKey.currentState!.selectedIndexes, [1, 2, 2]);

    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pump();
    expect(_primaryFocusIsInside<TextButton>(), isTrue);

    await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
    await tester.pump();
    expect(_primaryFocusIsInside<NavigationRailFocus>(), isTrue);
  });

  testWidgets('segmented control supports selection and boundary exit', (
    tester,
  ) async {
    final harnessKey = GlobalKey<_TabHarnessState>();
    await tester.pumpWidget(MaterialApp(home: _TabHarness(key: harnessKey)));

    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.select);
    await tester.pump();

    expect(harnessKey.currentState!.selected, 1);
    expect(harnessKey.currentState!.changes, [1]);

    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pump();
    expect(_primaryFocusIsInside<TextButton>(), isTrue);
    expect(harnessKey.currentState!.changes, [1]);
  });

  testWidgets('segmented control pointer selection fires once', (tester) async {
    final harnessKey = GlobalKey<_TabHarnessState>();
    await tester.pumpWidget(MaterialApp(home: _TabHarness(key: harnessKey)));

    await tester.tap(find.text('Global'));
    await tester.pump();

    expect(harnessKey.currentState!.selected, 1);
    expect(harnessKey.currentState!.changes, [1]);
  });

  testWidgets('segmented control keeps drag selection', (tester) async {
    final harnessKey = GlobalKey<_TabHarnessState>();
    await tester.pumpWidget(MaterialApp(home: _TabHarness(key: harnessKey)));

    await tester.drag(find.text('Rule'), const Offset(200, 0));
    await tester.pumpAndSettle();

    expect(harnessKey.currentState!.selected, 2);
    expect(harnessKey.currentState!.changes, [2]);
  });

  testWidgets('radio list item exposes one remote focus target', (
    tester,
  ) async {
    var activations = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RadioGroup<int>(
            groupValue: 0,
            onChanged: (_) {},
            child: ListItem.radio(
              title: const Text('Rule'),
              delegate: RadioDelegate(value: 0, onTap: () => activations++),
            ),
          ),
        ),
      ),
    );

    final focusNodes = FocusManager.instance.rootScope.descendants.where((
      node,
    ) {
      final context = node.context;
      return context != null && node.canRequestFocus;
    }).toList();
    final rowFocusNodes = focusNodes.where((node) {
      return node.context!.findAncestorWidgetOfExactType<ListTile>() != null;
    });
    final radioFocusNodes = focusNodes.where((node) {
      return node.context!.findAncestorWidgetOfExactType<Radio<int>>() != null;
    });

    expect(rowFocusNodes, hasLength(1));
    expect(radioFocusNodes, isEmpty);

    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.select);
    expect(activations, 1);
  });
}

bool _primaryFocusIsInside<T extends Widget>() {
  final context = FocusManager.instance.primaryFocus?.context;
  return context != null &&
      (context.widget is T ||
          context.findAncestorWidgetOfExactType<T>() != null);
}

class _NavigationHarness extends StatefulWidget {
  const _NavigationHarness({super.key});

  @override
  State<_NavigationHarness> createState() => _NavigationHarnessState();
}

class _NavigationHarnessState extends State<_NavigationHarness> {
  int currentIndex = 0;
  final selectedIndexes = <int>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Column(
            children: [
              NavigationRailFocus(
                autofocus: true,
                currentIndex: currentIndex,
                itemCount: 3,
                onSelected: (index) {
                  setState(() {
                    currentIndex = index;
                    selectedIndexes.add(index);
                  });
                },
                child: const SizedBox(width: 80, height: 240),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
            ],
          ),
          const Spacer(),
          TextButton(onPressed: () {}, child: const Text('Content')),
          const Spacer(),
        ],
      ),
    );
  }
}

class _TabHarness extends StatefulWidget {
  const _TabHarness({super.key});

  @override
  State<_TabHarness> createState() => _TabHarnessState();
}

class _TabHarnessState extends State<_TabHarness> {
  int selected = 0;
  final changes = <int>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            child: CommonTabBar<int>(
              children: const {
                0: SizedBox(height: 48, child: Center(child: Text('Rule'))),
                1: SizedBox(height: 48, child: Center(child: Text('Global'))),
                2: SizedBox(height: 48, child: Center(child: Text('Direct'))),
              },
              groupValue: selected,
              thumbColor: Theme.of(context).colorScheme.secondaryContainer,
              onValueChanged: (value) {
                if (value == null) return;
                setState(() {
                  selected = value;
                  changes.add(value);
                });
              },
            ),
          ),
          TextButton(onPressed: () {}, child: const Text('Next')),
        ],
      ),
    );
  }
}

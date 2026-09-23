import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/action.dart';
import 'package:fl_clash/widgets/scaffold.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/test_app.dart';

class _BackAction extends BackBlockAction {
  int balance = 0;

  @override
  void backBlock() => balance++;

  @override
  void unBackBlock() => balance--;
}

void main() {
  testWidgets('keyword chips report every change to the page', (tester) async {
    final updates = <List<String>>[];
    final key = GlobalKey<CommonScaffoldState>();
    await tester.pumpWidget(
      TestApp(
        locale: const Locale('en'),
        wrapInProviderScope: true,
        child: CommonScaffold(
          key: key,
          title: 'Logs',
          onKeywordsUpdate: updates.add,
          body: const SizedBox.expand(),
        ),
      ),
    );

    key.currentState!.addKeyword('dns');
    key.currentState!.addKeyword('dns');
    key.currentState!.addKeyword('tcp');
    await tester.pump();
    expect(updates, [
      ['dns'],
      ['dns', 'tcp'],
    ]);

    await tester.tap(find.byTooltip('Delete').first);
    await tester.pump();
    expect(updates.last, ['tcp']);
    expect(find.text('dns'), findsNothing);

    await tester.pumpWidget(
      TestApp(
        locale: const Locale('en'),
        wrapInProviderScope: true,
        child: CommonScaffold(
          key: key,
          title: 'Logs',
          onKeywordsUpdate: updates.add,
          body: const SizedBox(),
        ),
      ),
    );
    expect(updates, hasLength(3));
  });

  testWidgets('search opens, forwards queries and exits on back', (
    tester,
  ) async {
    final queries = <String>[];
    final backAction = _BackAction();
    void onSearch(String value) => queries.add(value);
    await tester.pumpWidget(
      TestApp(
        locale: const Locale('en'),
        overrides: [backBlockActionProvider.overrideWith(() => backAction)],
        child: CommonScaffold(
          title: 'Proxies',
          searchState: AppBarSearchState(onSearch: onSearch),
          actions: const [Icon(Icons.tune)],
          body: const SizedBox.expand(),
        ),
      ),
    );

    expect(find.byIcon(Icons.tune), findsOneWidget);
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.tune), findsNothing);

    await tester.enterText(find.byType(TextField), 'hk');
    expect(queries, ['hk']);
    expect(backAction.balance, 1);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(queries.last, '');
    expect(find.byType(TextField), findsNothing);
    expect(find.text('Proxies'), findsOneWidget);
    expect(find.byIcon(Icons.tune), findsOneWidget);
    expect(backAction.balance, 0);
  });
}

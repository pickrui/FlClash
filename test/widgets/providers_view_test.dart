import 'dart:async';

import 'package:fl_clash/models/core.dart';
import 'package:fl_clash/providers/action.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/views/proxies/providers.dart';
import 'package:fl_clash/widgets/sheet.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/test_app.dart';

final _providers = [
  for (final name in ['first', 'second'])
    ExternalProvider(
      name: name,
      type: 'Proxy',
      count: 1,
      vehicleType: 'HTTP',
      updateAt: DateTime.fromMillisecondsSinceEpoch(0),
    ),
];

class _ProxiesAction extends ProxiesAction {
  final calls = <String>[];
  final pending = {for (final p in _providers) p.name: Completer<String>()};
  int groupRefreshes = 0;

  @override
  Future<String> updateProvider(ExternalProvider provider) {
    calls.add(provider.name);
    return pending[provider.name]!.future;
  }

  @override
  void updateGroupsDebounce() => groupRefreshes++;
}

void main() {
  Future<_ProxiesAction> mount(WidgetTester tester) async {
    final action = _ProxiesAction();
    await tester.pumpWidget(
      TestApp(
        locale: const Locale('en'),
        overrides: [
          viewSizeProvider.overrideWithBuild((_, _) => const Size(800, 600)),
          providersProvider.overrideWithBuild((_, _) => _providers),
          proxiesActionProvider.overrideWith(() => action),
        ],
        child: const ProvidersView(type: SheetType.page),
      ),
    );
    await tester.pumpAndSettle();
    return action;
  }

  testWidgets(
    'batch refresh aggregates thrown and returned failures after all items finish',
    (tester) async {
      final action = await mount(tester);
      await tester.tap(find.widgetWithIcon(IconButton, Icons.sync).first);
      await tester.pump();
      expect(action.calls, ['first', 'second']);
      action.pending['first']!.completeError(StateError('transport lost'));
      await tester.pump();
      expect(tester.takeException(), isNull);
      expect(find.text('transport lost', findRichText: true), findsNothing);
      action.pending['second']!.complete('invalid rules');
      await tester.pumpAndSettle();
      expect(find.text('Bad state: transport lost'), findsOneWidget);
      expect(find.text('invalid rules'), findsOneWidget);
      expect(action.groupRefreshes, 1);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('batch refresh disables every batch button until completion', (
    tester,
  ) async {
    final action = await mount(tester);
    final buttons = find.widgetWithIcon(IconButton, Icons.sync);
    await tester.tap(buttons.first);
    await tester.pump();
    for (final button in tester.widgetList<IconButton>(buttons)) {
      expect(button.onPressed, isNull);
    }
    for (final pending in action.pending.values) {
      pending.complete('');
    }
    await tester.pumpAndSettle();
    for (final button in tester.widgetList<IconButton>(buttons)) {
      expect(button.onPressed, isNotNull);
    }
    expect(action.calls, ['first', 'second']);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'closing the view during refresh leaves no late dialog or state write',
    (tester) async {
      final action = await mount(tester);
      await tester.tap(find.widgetWithIcon(IconButton, Icons.sync).first);
      await tester.pump();
      await tester.pumpWidget(const SizedBox.shrink());
      for (final pending in action.pending.values) {
        pending.complete('offline');
      }
      await tester.pumpAndSettle();
      expect(find.text('offline'), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );
}

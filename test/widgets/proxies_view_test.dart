import 'dart:async';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/theme.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/proxies/list.dart';
import 'package:fl_clash/views/proxies/tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('delay test button stays locked until the request completes', (
    tester,
  ) async {
    final requests = <Completer<void>>[];
    await tester.pumpWidget(
      ProviderScope(
        child: _TestApp(
          child: DelayTestButton(
            onClick: () {
              final request = Completer<void>();
              requests.add(request);
              return request.future;
            },
          ),
        ),
      ),
    );
    final button = tester.widget<FloatingActionButton>(
      find.byType(FloatingActionButton),
    );

    button.onPressed!();
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    button.onPressed!();
    expect(requests, hasLength(1));

    requests.single.complete();
    await tester.pumpAndSettle();
    button.onPressed!();
    expect(requests, hasLength(2));
    requests.last.complete();
    await tester.pumpAndSettle();
  });

  testWidgets(
    'delay test completion after disposal does not restart animation',
    (tester) async {
      final request = Completer<void>();
      await tester.pumpWidget(
        ProviderScope(
          child: _TestApp(
            child: DelayTestButton(onClick: () => request.future),
          ),
        ),
      );
      tester
          .widget<FloatingActionButton>(find.byType(FloatingActionButton))
          .onPressed!();
      await tester.pumpWidget(const SizedBox.shrink());
      request.complete();
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'filtered tabs report the visible group and follow saved selection',
    (tester) async {
      const first = Group(name: 'First', type: GroupType.Selector);
      const second = Group(name: 'Second', type: GroupType.Selector);
      const third = Group(name: 'Third', type: GroupType.Selector);
      var state = const ProxiesTabState(
        groups: [second, third],
        currentGroupName: 'First',
        proxyCardType: ProxyCardType.min,
        columns: 1,
      );
      final selectedGroups = <String>[];
      final container = ProviderContainer(
        overrides: [
          currentProfileProvider.overrideWith((_) => null),
          currentGroupsStateProvider.overrideWith(
            (_) => const GroupsState(value: [first, second, third]),
          ),
          proxiesTabStateProvider.overrideWith((_) => state),
        ],
      );
      addTearDown(container.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: _TestApp(
            child: ProxiesTabView(onGroupChanged: selectedGroups.add),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(selectedGroups.last, 'Second');

      state = state.copyWith(currentGroupName: 'Third');
      container.invalidate(proxiesTabStateProvider);
      await tester.pumpAndSettle();
      expect(tester.widget<TabBar>(find.byType(TabBar)).controller!.index, 1);
      expect(selectedGroups.last, 'Third');

      state = state.copyWith(groups: []);
      container.invalidate(proxiesTabStateProvider);
      await tester.pumpAndSettle();
      expect(find.byType(TabBar), findsNothing);
      expect(tester.takeException(), isNull);

      state = state.copyWith(groups: [third]);
      container.invalidate(proxiesTabStateProvider);
      container.read(proxiesTabControllerStateProvider);
      final changesBeforeDisposal = selectedGroups.length;
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      expect(selectedGroups, hasLength(changesBeforeDisposal));
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'filtered list expands the visible group without indexing all groups',
    (tester) async {
      const hidden = Group(name: 'Hidden', type: GroupType.Selector);
      final visible = List.generate(
        15,
        (index) => Group(name: 'Visible $index', type: GroupType.Selector),
      );
      Set<String>? unfolded;
      final container = ProviderContainer(
        overrides: [
          currentProfileProvider.overrideWith((_) => null),
          currentGroupsStateProvider.overrideWith(
            (_) => GroupsState(value: [...List.filled(20, hidden), ...visible]),
          ),
          proxiesListStateProvider.overrideWith(
            (_) => ProxiesListState(
              groups: visible,
              currentUnfoldSet: {},
              proxyCardType: ProxyCardType.min,
              columns: 1,
            ),
          ),
        ],
      );
      addTearDown(container.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: _TestApp(
            child: ProxiesListView(
              onUnfoldChanged: (value) => unfolded = value,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final header = tester
          .widgetList<ListHeader>(find.byType(ListHeader))
          .first;
      header.onChange(header.group.name);
      expect(unfolded, {header.group.name});
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
  );
}

class _TestApp extends StatelessWidget {
  final Widget child;

  const _TestApp({required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.delegate.supportedLocales,
      builder: (context, child) {
        globalState.measure = Measure.of(context, 1);
        globalState.theme = CommonTheme.of(context, 1);
        return child!;
      },
      home: Scaffold(body: child),
    );
  }
}

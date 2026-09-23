import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/pages/home.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/state.dart';
import 'package:fl_clash/widgets/inherited.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../helpers/test_app.dart';

class _Probe extends StatelessWidget {
  final PageLabel label;

  const _Probe(this.label);

  @override
  Widget build(BuildContext context) {
    return Text('${label.name}:${PageActivityScope.isActiveOf(context)}');
  }
}

NavigationItem _item(PageLabel label) => NavigationItem(
  icon: const Icon(Icons.circle),
  label: label,
  keep: false,
  builder: (_) => _Probe(label),
);

Override _items(List<PageLabel> labels) =>
    currentNavigationItemsStateProvider.overrideWithValue(
      NavigationItemsState(value: [for (final label in labels) _item(label)]),
    );

void main() {
  testWidgets('a page that leaves the navigation falls back to the first tab', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final viewSize = viewSizeProvider.overrideWithBuild(
      (_, _) => const Size(400, 800),
    );
    const all = [PageLabel.dashboard, PageLabel.proxies, PageLabel.tools];
    final container = ProviderContainer(overrides: [viewSize, _items(all)]);
    addTearDown(container.dispose);
    container.read(currentPageLabelProvider.notifier).value = PageLabel.proxies;
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const TestApp(locale: Locale('en'), child: HomePage()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('proxies:true'), findsOneWidget);

    container.updateOverrides([
      viewSize,
      _items(const [PageLabel.dashboard, PageLabel.tools]),
    ]);
    await tester.pumpAndSettle();
    expect(find.text('dashboard:true'), findsOneWidget);
    expect(find.textContaining('tools:'), findsNothing);
    final bar = tester.widget<NavigationBar>(find.byType(NavigationBar));
    expect(bar.selectedIndex, 0);

    container.updateOverrides([viewSize, _items(all)]);
    await tester.pumpAndSettle();
    expect(find.text('proxies:true'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

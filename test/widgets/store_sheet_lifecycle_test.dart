import 'dart:async';

import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/cloud/store_page.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

void main() {
  for (final recharge in [false, true]) {
    testWidgets(
      '${recharge ? 'recharge' : 'purchase'} sheet survives keyboard changes during dismissal',
      (tester) async {
        final container = ProviderContainer(
          overrides: [
            storeProvider.overrideWith(_Store.new),
            cloudAccountProvider.overrideWith(_Account.new),
          ],
        );
        globalState.container = container;
        addTearDown(container.dispose);
        tester.view.physicalSize = const Size(1000, 1400);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.view.resetViewInsets);
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: const TestApp(locale: Locale('en'), child: CloudStorePage()),
          ),
        );
        await tester.pumpAndSettle();
        final open = recharge
            ? find.byTooltip('Recharge')
            : find.text('Use balance');
        await tester.ensureVisible(open);
        await tester.tap(open);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 400));
        final field = find.byType(TextField);
        expect(field, findsOneWidget);
        await tester.enterText(field, recharge ? '20' : 'SAVE');
        await tester.pump();
        Navigator.of(tester.element(field)).pop();
        await tester.pump();
        expect(field, findsOneWidget);
        tester.view.viewInsets = const FakeViewPadding(bottom: 100);
        await tester.pump();
        expect(tester.takeException(), isNull);
        await tester.pumpAndSettle();
        expect(field, findsNothing);
        await tester.pumpWidget(const SizedBox.shrink());
      },
    );
  }

  testWidgets('a refresh still syncs the subscription after the page closes', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [
        storeProvider.overrideWith(_Store.new),
        cloudAccountProvider.overrideWith(_Account.new),
      ],
    );
    globalState.container = container;
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const TestApp(locale: Locale('en'), child: SizedBox.shrink()),
      ),
    );
    final navigator = globalState.navigatorKey.currentState!;
    unawaited(
      navigator.push(
        MaterialPageRoute<void>(builder: (_) => const CloudStorePage()),
      ),
    );
    await tester.pumpAndSettle();

    final store = container.read(storeProvider.notifier) as _Store;
    final account = container.read(cloudAccountProvider.notifier) as _Account;
    final load = store.loadGate = Completer<void>();
    await tester.tap(find.byTooltip('Refresh'));
    await tester.pump();
    navigator.pop();
    await tester.pumpAndSettle();
    expect(find.byType(CloudStorePage), findsNothing);

    load.complete();
    await tester.pumpAndSettle();
    expect(account.managedRefreshes, 1);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}

class _Store extends StoreNotifier {
  Completer<void>? loadGate;

  @override
  StoreState build() => StoreState(
    plans: [
      StorePlan.fromJson({
        'id': 1,
        'name': 'Fixture plan',
        'price': 10,
        'inventory': -1,
        'can_buy': true,
      }),
    ],
    paymentMethods: const [
      PaymentMethodOption(
        payment: 'fixture',
        type: 'fixture',
        name: 'Fixture payment',
        min: 1,
        max: 100,
      ),
    ],
  );
  @override
  Future<void> load() => loadGate?.future ?? Future.value();
}

class _Account extends CloudAccountNotifier {
  var managedRefreshes = 0;

  @override
  CloudAccountState build() => const CloudAccountState();

  @override
  Future<void> refreshManagedSubscription() async => managedRefreshes++;
}

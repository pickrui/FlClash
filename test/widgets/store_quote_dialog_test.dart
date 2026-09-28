import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/views/cloud/store_quote_dialog.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

class _Account extends CloudAccountNotifier {
  @override
  CloudAccountState build() => const CloudAccountState(isLoggedIn: true);
}

class _Panel {
  var sufficient = false;
  var quotes = 0;
  var recharges = 0;
  var rechargeSucceeds = true;

  Future<StoreQuote> quote(String coupon) async {
    quotes++;
    return StoreQuote(
      authorizedPrice: 30,
      sufficientBalance: sufficient,
      recurring: false,
      rows: const [StoreQuoteRow('Amount payable', 30)],
    );
  }

  Future<bool> recharge(BuildContext context) async {
    recharges++;
    if (rechargeSucceeds) sufficient = true;
    return rechargeSucceeds;
  }
}

Future<List<StoreQuoteChoice?>> _open(
  WidgetTester tester,
  _Panel panel, {
  bool offerRecharge = true,
}) async {
  tester.view.physicalSize = const Size(800, 1200);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final results = <StoreQuoteChoice?>[];
  await tester.pumpWidget(
    TestApp(
      locale: const Locale('en'),
      overrides: [
        viewSizeProvider.overrideWithBuild((_, _) => const Size(800, 1200)),
        cloudAccountProvider.overrideWith(_Account.new),
      ],
      child: Builder(
        builder: (context) => Scaffold(
          body: TextButton(
            onPressed: () async => results.add(
              await showDialog<StoreQuoteChoice>(
                context: context,
                builder: (_) => StoreQuoteDialog(
                  title: 'Upgrade',
                  loadQuote: panel.quote,
                  onRecharge: offerRecharge ? panel.recharge : null,
                ),
              ),
            ),
            child: const Text('open'),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
  return results;
}

VoidCallback? _action(WidgetTester tester, String label) =>
    tester.widget<TextButton>(find.widgetWithText(TextButton, label)).onPressed;

void main() {
  testWidgets('a short balance offers a recharge, then quotes again', (
    tester,
  ) async {
    final panel = _Panel();
    final results = await _open(tester, panel);
    expect(panel.quotes, 1);
    expect(
      find.text('Insufficient balance. Top up before continuing.'),
      findsOneWidget,
    );
    expect(find.widgetWithText(TextButton, 'Confirm'), findsNothing);

    await tester.tap(find.widgetWithText(TextButton, 'Recharge'));
    await tester.pumpAndSettle();
    expect(panel.recharges, 1);
    expect(panel.quotes, 2);
    expect(find.widgetWithText(TextButton, 'Recharge'), findsNothing);

    await tester.tap(find.widgetWithText(TextButton, 'Confirm'));
    await tester.pumpAndSettle();
    expect(results.single?.authorizedPrice, 30);
    expect(tester.takeException(), isNull);
  });

  testWidgets('an abandoned recharge keeps the quote as it was', (
    tester,
  ) async {
    final panel = _Panel()..rechargeSucceeds = false;
    await _open(tester, panel);

    await tester.tap(find.widgetWithText(TextButton, 'Recharge'));
    await tester.pumpAndSettle();
    expect(panel.recharges, 1);
    expect(panel.quotes, 1);
    expect(_action(tester, 'Recharge'), isNotNull);
  });

  testWidgets('without a recharge the short quote only blocks confirm', (
    tester,
  ) async {
    await _open(tester, _Panel(), offerRecharge: false);

    expect(find.widgetWithText(TextButton, 'Recharge'), findsNothing);
    expect(_action(tester, 'Confirm'), isNull);
  });
}

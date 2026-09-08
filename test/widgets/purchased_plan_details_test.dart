import 'dart:io';
import 'dart:ui' as ui;

import 'package:fl_clash/common/cloud_panel_time.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/views/cloud/purchased_plan_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  BoughtRecord record(int status) => BoughtRecord.fromJson({
    'id': 1,
    'shop_id': 1,
    'shop_name': 'Pass Silver',
    'status': status,
    'buy_time': '2026-09-08 20:35:12',
    'buy_price': '88.50',
    'renew_price': 100,
    'duration_minutes': 525600,
    'bandwidth': 2000,
    'billing_period_text': '年付',
  });
  final profile = CloudProfile(
    subscription: 'Pass Silver',
    expireTime: DateTime.utc(2026, 9, 9),
    todayUsed: '1 GiB',
    totalUsed: '77 GiB',
    totalTraffic: '200 GiB',
    usageProgress: .385,
    remaining: '123 GiB',
    balance: '0',
    commission: '0',
    points: '0',
  );

  test(
    'purchase data retains zero and leaves missing/invalid data unknown',
    () {
      expect(record(0).buyPrice, 88.5);
      expect(record(0).durationMinutes, 525600);
      final invalid = BoughtRecord.fromJson({
        'buy_price': 'NaN',
        'renew_price': -1,
        'bandwidth': -1,
      });
      expect(invalid.buyPrice, isNull);
      expect(invalid.renewPrice, isNull);
      expect(invalid.bandwidthGiB, isNull);
      expect(invalid.durationMinutes, isNull);
      expect(BoughtRecord.fromJson({'buy_price': 0}).buyPrice, 0);
    },
  );
  test(
    'remaining values respect pending, active and ended purchase states',
    () {
      for (final status in [0, 1, -1]) {
        final summary = PurchasedPlanSummary(
          bought: record(status),
          profile: profile,
          now: DateTime.utc(2026, 9, 8),
        );
        expect(
          summary.remainingMinutes,
          status == 0
              ? 525600
              : status == 1
              ? 1440
              : null,
        );
        expect(
          summary.remainingTraffic,
          status == 0
              ? '2000 GiB'
              : status == 1
              ? '123 GiB'
              : null,
        );
      }
      final missing = PurchasedPlanSummary(bought: record(1));
      expect(missing.remainingMinutes, isNull);
      expect(missing.remainingTraffic, isNull);
    },
  );
  test('panel timestamps retain timezone and reject invalid dates', () {
    expect(
      parseCloudPanelTime('2026-09-09 08:00:00'),
      DateTime.utc(2026, 9, 9),
    );
    expect(
      parseCloudPanelTime('2026-09-09T00:00:00Z'),
      DateTime.utc(2026, 9, 9),
    );
    expect(parseCloudPanelTime('2026-02-30 08:00:00'), isNull);
    expect(parseCloudPanelTime(''), isNull);
  });
  for (final scale in [1.0, 2.0]) {
    testWidgets('purchase details fit narrow screen at text scale $scale', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(360, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final fontPath = Platform.environment['FLCLASH_UI_FONT'];
      if (fontPath != null) {
        await tester.runAsync(() async {
          final loader = FontLoader('PurchasedPlanTest');
          loader.addFont(
            Future.value(
              ByteData.sublistView(await File(fontPath).readAsBytes()),
            ),
          );
          await loader.load();
        });
      }
      final key = GlobalKey();
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('zh', 'CN'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.delegate.supportedLocales,
          theme: ThemeData(
            brightness: Brightness.dark,
            useMaterial3: true,
            fontFamily: fontPath == null ? null : 'PurchasedPlanTest',
          ),
          home: MediaQuery(
            data: MediaQueryData(textScaler: TextScaler.linear(scale)),
            child: Scaffold(
              body: SingleChildScrollView(
                child: RepaintBoundary(
                  key: key,
                  child: ColoredBox(
                    color: const Color(0xff1c1c1e),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Pass Silver',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          PurchasedPlanDetails(bought: record(0)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('购买价格'), findsOneWidget);
      expect(find.text('¥88.50'), findsOneWidget);
      expect(find.text('2000 GiB'), findsOneWidget);
      expect(find.text('365天'), findsOneWidget);
      expect(find.text('关闭'), findsOneWidget);
      expect(find.text('2026-09-08 20:35:12'), findsOneWidget);
      expect(tester.takeException(), isNull);
      final boundary =
          key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      expect(boundary.size.width, lessThanOrEqualTo(360));
      final screenshotDirectory =
          Platform.environment['FLCLASH_UI_SCREENSHOT_DIR'];
      if (screenshotDirectory != null) {
        await tester.runAsync(() async {
          final image = await boundary.toImage(pixelRatio: 2);
          final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
          await File(
            '$screenshotDirectory/flclash-purchased-plan-$scale.png',
          ).writeAsBytes(bytes!.buffer.asUint8List());
          image.dispose();
        });
      }
    });
  }
}

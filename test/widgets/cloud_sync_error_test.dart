import 'dart:async';

import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/views/cloud/cloud_account_page.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets(
    'failed account refresh ends the empty-page spinner and allows retry',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      final account = _FailedAccount();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            cloudAccountProvider.overrideWith(() => account),
            cloudServiceHealthCheckProvider.overrideWithValue(() async {}),
          ],
          child: MaterialApp(
            locale: const Locale('en'),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              ...GlobalMaterialLocalizations.delegates,
            ],
            supportedLocales: AppLocalizations.delegate.supportedLocales,
            home: const CloudAccountPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Cloud sync request timed out'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      await tester.tap(find.text('Refresh'));
      await tester.pumpAndSettle();
      expect(account.retries, 1);
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets('a single failed attempt does not blame the service', (
    tester,
  ) async {
    var checks = 0;
    await _pumpCloudPage(tester, () async {
      if (++checks == 1) throw const CloudApiException('Connection timed out');
    });
    await tester.pumpAndSettle();
    expect(checks, 2);
    expect(find.byType(MaterialBanner), findsNothing);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('API failure shows its cause and manual retry clears it', (
    tester,
  ) async {
    var checks = 0;
    // Only a check whose every attempt fails reaches the banner.
    await _pumpCloudPage(tester, () async {
      if (++checks <= 2) throw const CloudApiException('Connection timed out');
    });
    await tester.pumpAndSettle();
    expect(
      find.text('Service Check Failed: Connection timed out'),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.error), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Check API'));
    await tester.pumpAndSettle();
    expect(checks, 3);
    expect(find.byType(MaterialBanner), findsNothing);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('returning to the cloud tab refreshes an old API failure', (
    tester,
  ) async {
    var checks = 0;
    final container = await _pumpCloudPage(tester, () async {
      if (++checks <= 2) throw const CloudApiException('Connection failed');
    });
    await tester.pumpAndSettle();
    container
        .read(currentPageLabelProvider.notifier)
        .toPage(PageLabel.oixCloud);
    await tester.pumpAndSettle();
    expect(checks, 3);
    expect(find.byType(MaterialBanner), findsNothing);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
  });

  testWidgets(
    'tab reentry queues a fresh check after an older check finishes',
    (tester) async {
      var checks = 0;
      final first = Completer<void>();
      final container = await _pumpCloudPage(tester, () async {
        if (++checks == 1) await first.future;
      });
      await tester.pump();
      container
          .read(currentPageLabelProvider.notifier)
          .toPage(PageLabel.oixCloud);
      await tester.pump();
      expect(checks, 1);
      first.completeError(const CloudApiException('Old connection failed'));
      await tester.pumpAndSettle();
      expect(checks, 3);
      expect(find.byType(MaterialBanner), findsNothing);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    },
  );

  testWidgets('a completed check cannot update a disposed cloud page', (
    tester,
  ) async {
    final pending = Completer<void>();
    await _pumpCloudPage(tester, () => pending.future);
    await tester.pumpWidget(const SizedBox.shrink());
    pending.completeError(const CloudApiException('Connection failed'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}

Future<ProviderContainer> _pumpCloudPage(
  WidgetTester tester,
  Future<void> Function() healthCheck,
) async {
  SharedPreferences.setMockInitialValues({});
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        cloudAccountProvider.overrideWith(_FailedAccount.new),
        cloudServiceHealthCheckProvider.overrideWithValue(healthCheck),
      ],
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        home: const CloudAccountPage(),
      ),
    ),
  );
  return ProviderScope.containerOf(
    tester.element(find.byType(CloudAccountPage)),
  );
}

class _FailedAccount extends CloudAccountNotifier {
  int retries = 0;
  @override
  CloudAccountState build() => const CloudAccountState(
    isLoggedIn: true,
    error: 'Cloud sync request timed out',
  );
  @override
  Future<void> refreshProfile({bool force = false}) async {
    retries++;
  }
}

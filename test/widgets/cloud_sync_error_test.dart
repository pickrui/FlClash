import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/views/cloud/cloud_account_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
          overrides: [cloudAccountProvider.overrideWith(() => account)],
          child: MaterialApp(
            locale: const Locale('en'),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
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

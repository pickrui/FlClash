import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/views/profiles/edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets(
    'managed profile exposes automatic updates and rejects zero minutes',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      await tester.binding.setSurfaceSize(const Size(800, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            cloudAccountProvider.overrideWith(_IdleAccount.new),
            viewSizeProvider.overrideWithBuild((_, _) => const Size(800, 1200)),
          ],
          child: MaterialApp(
            locale: const Locale('en'),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.delegate.supportedLocales,
            home: Scaffold(
              body: Builder(
                builder: (context) => EditProfileView(
                  context: context,
                  profile: const Profile(
                    id: 1,
                    label: 'oixCloud',
                    url: 'oixcloud://managed',
                    autoUpdateDuration: Duration(minutes: 60),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Auto update'), findsOneWidget);
      final interval = find.widgetWithText(
        TextFormField,
        'Auto update interval (minutes)',
      );
      expect(interval, findsOneWidget);
      await tester.enterText(interval, '0');
      expect(tester.state<FormState>(find.byType(Form)).validate(), false);
      await tester.enterText(interval, '30');
      expect(tester.state<FormState>(find.byType(Form)).validate(), true);
      await tester.tap(find.text('Auto update'));
      await tester.pumpAndSettle();
      expect(interval, findsNothing);
      await tester.tap(find.text('Auto update'));
      await tester.pumpAndSettle();
      expect(interval, findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}

class _IdleAccount extends CloudAccountNotifier {
  @override
  CloudAccountState build() => const CloudAccountState();
}

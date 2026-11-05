import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/config.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/widgets/proxy_authentication.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(Locale locale, Future<void> Function(AuthenticationProps) save) =>
    ProviderScope(
      overrides: [
        viewSizeProvider.overrideWithBuild((_, _) => const Size(400, 800)),
      ],
      child: MaterialApp(
        locale: locale,
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        home: Scaffold(
          body: Builder(
            builder: (context) => FilledButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (_) => ProxyAuthenticationDialog(
                  value: const AuthenticationProps(
                    enable: true,
                    username: 'local',
                    password: 'original',
                  ),
                  onSave: save,
                ),
              ),
              child: const Text('edit'),
            ),
          ),
        ),
      ),
    );

void main() {
  for (final locale in [
    const Locale('en'),
    const Locale('zh', 'CN'),
    const Locale('ja'),
    const Locale('ru'),
  ]) {
    testWidgets(
      '$locale authentication fields stay usable and password stays hidden',
      (tester) async {
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await tester.pumpWidget(_app(locale, (_) async {}));
        await tester.tap(find.text('edit'));
        await tester.pumpAndSettle();
        expect(
          tester
              .widgetList<EditableText>(find.byType(EditableText))
              .last
              .obscureText,
          isTrue,
        );
        await tester.tap(find.byIcon(Icons.visibility_outlined));
        await tester.pump();
        expect(
          tester
              .widgetList<EditableText>(find.byType(EditableText))
              .last
              .obscureText,
          isFalse,
        );
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets(
    'rejects invalid credentials and preserves special password characters',
    (tester) async {
      AuthenticationProps? saved;
      await tester.pumpWidget(
        _app(const Locale('en'), (value) async {
          saved = value;
        }),
      );
      await tester.tap(find.text('edit'));
      await tester.pumpAndSettle();
      final fields = find.byType(TextFormField);
      await tester.enterText(fields.first, 'invalid:name');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(saved, isNull);
      expect(find.textContaining('without colons'), findsOneWidget);
      await tester.enterText(fields.first, 'local');
      await tester.enterText(fields.last, ' ;:@ 中文 ');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(saved?.password, ' ;:@ 中文 ');
      expect(find.byType(ProxyAuthenticationDialog), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );
}

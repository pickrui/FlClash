import 'package:fl_clash/common/theme.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/cloud_account_provider.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/cloud/cloud_login_page.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('InputDialog toggles obscured text visibility', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          viewSizeProvider.overrideWithBuild((_, _) => const Size(1200, 1000)),
        ],
        child: const _TestApp(
          child: InputDialog(
            title: 'Password',
            value: 'secret',
            obscureText: true,
          ),
        ),
      ),
    );

    expect(
      tester.widget<EditableText>(find.byType(EditableText)).obscureText,
      isTrue,
    );
    expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    expect(find.byTooltip('Show'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.visibility_outlined));
    await tester.pump();

    expect(
      tester.widget<EditableText>(find.byType(EditableText)).obscureText,
      isFalse,
    );
    expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    expect(find.byTooltip('Hide'), findsOneWidget);
  });

  testWidgets('access token visibility does not reveal the password', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          cloudAccountProvider.overrideWith(_TestCloudAccountNotifier.new),
        ],
        child: const _TestApp(child: CloudLoginPage()),
      ),
    );

    expect(
      tester.widget<EditableText>(find.byType(EditableText)).obscureText,
      isTrue,
    );

    await tester.tap(find.byIcon(Icons.visibility_outlined));
    await tester.pump();
    expect(
      tester.widget<EditableText>(find.byType(EditableText)).obscureText,
      isFalse,
    );

    await tester.tap(find.text('Email & Password'));
    await tester.pump();

    final fields = tester.widgetList<EditableText>(find.byType(EditableText));
    expect(fields, hasLength(2));
    expect(fields.last.obscureText, isTrue);
  });

  testWidgets('ListItem.input limits dialog text by maxLength', (tester) async {
    String? changedValue;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          viewSizeProvider.overrideWithBuild((_, _) => const Size(1200, 1000)),
        ],
        child: _TestApp(
          child: Scaffold(
            body: ListItem.input(
              title: const Text('Port'),
              delegate: InputDelegate(
                title: 'Port',
                value: '',
                maxLength: 5,
                onChanged: (value) {
                  changedValue = value;
                },
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Port'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), '123456789');
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    expect(changedValue, '12345');
  });
}

class _TestCloudAccountNotifier extends CloudAccountNotifier {
  @override
  CloudAccountState build() => const CloudAccountState();
}

class _TestApp extends StatelessWidget {
  final Widget child;

  const _TestApp({required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: globalState.navigatorKey,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.delegate.supportedLocales,
      builder: (context, child) {
        globalState.theme = CommonTheme.of(context, 1);
        return child!;
      },
      home: child,
    );
  }
}

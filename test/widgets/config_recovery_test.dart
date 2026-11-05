import 'dart:async';

import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/pages/config_recovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final titles = {
    const Locale('en'): 'Recover local configuration',
    const Locale('zh', 'CN'): '恢复本地配置',
    const Locale('ja'): 'ローカル設定の復元',
    const Locale('ru'): 'Восстановление локальных настроек',
  };
  for (final entry in titles.entries) {
    testWidgets('shows recovery guidance in ${entry.key}', (tester) async {
      await _showRecovery(tester, locale: entry.key, onRetry: () async {});

      expect(find.text(entry.value), findsOneWidget);
      expect(
        find.text(AppLocalizations.current.configRecoveryMessage),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.current.configRecoveryRetry),
        findsOneWidget,
      );
      expect(find.byType(SelectableText), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('keeps recovery guidance after failure without exposing errors', (
    tester,
  ) async {
    var attempts = 0;
    await _showRecovery(
      tester,
      onRetry: () async {
        attempts++;
        throw StateError('sensitive configuration seed');
      },
    );

    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();

    expect(attempts, 1);
    expect(
      find.textContaining('Your existing data has been kept'),
      findsOneWidget,
    );
    expect(find.textContaining('sensitive configuration seed'), findsNothing);
    expect(find.textContaining('Bad state'), findsNothing);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNotNull,
    );
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(attempts, 2);
  });

  testWidgets('shows progress and prevents concurrent retries', (tester) async {
    final pending = Completer<void>();
    var attempts = 0;
    await _showRecovery(
      tester,
      onRetry: () {
        attempts++;
        return pending.future;
      },
    );

    await tester.tap(find.text('Retry'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
    await tester.tap(find.text('Retry'));
    await tester.pump();
    expect(attempts, 1);

    pending.complete();
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('completes safely when successful recovery removes the screen', (
    tester,
  ) async {
    final pending = Completer<void>();
    await _showRecovery(tester, onRetry: () => pending.future);
    await tester.tap(find.text('Retry'));
    await tester.pump();

    await tester.pumpWidget(const MaterialApp(home: Text('Ready')));
    pending.complete();
    await tester.pumpAndSettle();

    expect(find.text('Ready'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('offers exit and disables it while retrying', (tester) async {
    final pending = Completer<void>();
    var exits = 0;
    await _showRecovery(
      tester,
      onRetry: () => pending.future,
      onExit: () => exits++,
    );

    await tester.tap(find.text('Exit'));
    expect(exits, 1);

    await tester.tap(find.text('Retry'));
    await tester.pump();
    expect(
      tester.widget<TextButton>(find.byType(TextButton)).onPressed,
      isNull,
    );
    await tester.tap(find.text('Exit'));
    expect(exits, 1);

    pending.complete();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Exit'));
    expect(exits, 2);
  });
}

Future<void> _showRecovery(
  WidgetTester tester, {
  required Future<void> Function() onRetry,
  VoidCallback? onExit,
  Locale locale = const Locale('en'),
}) async {
  await tester.pumpWidget(
    MaterialApp(
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.delegate.supportedLocales,
      home: ConfigRecoveryScreen(onRetry: onRetry, onExit: onExit),
    ),
  );
  await tester.pumpAndSettle();
}

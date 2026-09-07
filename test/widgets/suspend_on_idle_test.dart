import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/views/config/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final titles = {
    const Locale('en'): 'Pause proxy when idle',
    const Locale('zh', 'CN'): '空闲时暂停代理',
    const Locale('ja'): 'アイドル時にプロキシを一時停止',
    const Locale('ru'): 'Приостанавливать прокси при бездействии',
  };

  for (final entry in titles.entries) {
    testWidgets('shows idle suspension guidance in ${entry.key}', (
      tester,
    ) async {
      await _showSetting(tester, locale: entry.key);

      expect(find.text(entry.value), findsOneWidget);
      expect(
        find.text(AppLocalizations.current.suspendOnIdleDesc),
        findsOneWidget,
      );
      expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('switch and row taps update the setting in both directions', (
    tester,
  ) async {
    final container = await _showSetting(
      tester,
      initial: const NetworkProps(blockQuic: true),
    );

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(container.read(networkSettingProvider).suspendOnIdle, isTrue);
    expect(container.read(networkSettingProvider).blockQuic, isTrue);
    expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);

    await tester.tap(find.text('Pause proxy when idle'));
    await tester.pumpAndSettle();

    expect(container.read(networkSettingProvider).suspendOnIdle, isFalse);
    expect(container.read(networkSettingProvider).blockQuic, isTrue);
    expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);
    expect(tester.takeException(), isNull);
  });

  testWidgets('reflects an enabled setting when opened', (tester) async {
    await _showSetting(
      tester,
      initial: const NetworkProps(suspendOnIdle: true),
    );

    expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);
    expect(tester.takeException(), isNull);
  });
}

Future<ProviderContainer> _showSetting(
  WidgetTester tester, {
  Locale locale = const Locale('en'),
  NetworkProps initial = const NetworkProps(),
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [networkSettingProvider.overrideWithBuild((_, _) => initial)],
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        home: const Scaffold(body: SuspendOnIdleItem()),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return ProviderScope.containerOf(
    tester.element(find.byType(SuspendOnIdleItem)),
  );
}

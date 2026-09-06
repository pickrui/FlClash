import 'dart:async';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/theme.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/database.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/dashboard/widgets/start_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  tearDown(() => debouncer.cancel(FunctionTag.updateStatus));

  testWidgets('cancelled startup restores the play button and permits retry', (
    tester,
  ) async {
    final requests = <bool>[];
    final pendingStart = Completer<void>();
    await _pumpButton(tester, (isStart) async {
      requests.add(isStart);
      await pendingStart.future;
    });

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.pump(commonDuration);
    expect(requests, [true]);
    expect(_progress(tester), 1);

    pendingStart.complete();
    await tester.pumpAndSettle();
    expect(_progress(tester), 0);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.pump(commonDuration);
    expect(requests, [true, true]);
    await tester.pumpAndSettle();
  });

  testWidgets('an older completion does not replace a newer toggle', (
    tester,
  ) async {
    final requests = <bool>[];
    final completions = <Completer<void>>[];
    await _pumpButton(tester, (isStart) {
      requests.add(isStart);
      final completion = Completer<void>();
      completions.add(completion);
      return completion.future;
    });

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.pump(commonDuration);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.pump(commonDuration);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.pump(commonDuration);
    expect(requests, [true, false, true]);

    completions.first.complete();
    await tester.pumpAndSettle();
    expect(_progress(tester), 1);

    completions[1].complete();
    completions.last.complete();
    await tester.pumpAndSettle();
    expect(_progress(tester), 0);
  });
}

double _progress(WidgetTester tester) {
  return tester.widget<AnimatedIcon>(find.byType(AnimatedIcon)).progress.value;
}

Future<void> _pumpButton(
  WidgetTester tester,
  Future<void> Function(bool) statusUpdater,
) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: [
        profilesProvider.overrideWithBuild(
          (_, _) => [Profile.normal(label: 'Profile')],
        ),
      ],
      child: MaterialApp(
        locale: const Locale('en'),
        theme: ThemeData(
          textTheme: const TextTheme(titleMedium: TextStyle(fontSize: 12)),
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        builder: (context, child) {
          globalState.theme = CommonTheme.of(context, 1);
          globalState.measure = Measure.of(context, 1);
          return child!;
        },
        home: Scaffold(body: StartButton(statusUpdater: statusUpdater)),
      ),
    ),
  );
}

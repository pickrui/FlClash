import 'dart:async';

import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/widgets/geo_recovery_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('choose GitHub and download before returning success', (
    tester,
  ) async {
    String? downloadedUrl;
    bool? result;
    await _openDialog(
      tester,
      download: (url) async {
        downloadedUrl = url;
        return null;
      },
      onResult: (value) => result = value,
    );
    await tester.tap(find.text('GitHub'));
    await tester.tap(find.text('Download'));
    await tester.pumpAndSettle();
    expect(
      downloadedUrl,
      'https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest/geoip.dat',
    );
    expect(result, isTrue);
    expect(find.byType(GeoRecoveryDialog), findsNothing);
  });

  testWidgets('waiting download shows progress and prevents repeated changes', (
    tester,
  ) async {
    final pending = Completer<String?>();
    var calls = 0;
    await _openDialog(
      tester,
      download: (_) {
        calls++;
        return pending.future;
      },
    );
    await tester.tap(find.text('Download'));
    await tester.tap(find.text('Download'));
    await tester.pump();
    expect(calls, 1);
    expect(find.byType(GeoRecoveryDialog), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
    expect(
      tester.widget<TextFormField>(find.byType(TextFormField)).enabled,
      isFalse,
    );
    for (final chip in tester.widgetList<ActionChip>(find.byType(ActionChip))) {
      expect(chip.onPressed, isNull);
    }
    pending.complete(null);
    await tester.pumpAndSettle();
    expect(find.byType(GeoRecoveryDialog), findsNothing);
  });

  testWidgets('failed download stays in the same dialog and allows retry', (
    tester,
  ) async {
    final attemptedUrls = <String>[];
    bool? result;
    await _openDialog(
      tester,
      download: (url) async {
        attemptedUrls.add(url);
        return attemptedUrls.length == 1 ? 'The latest download failed' : '';
      },
      onResult: (value) => result = value,
    );
    final dialogState = tester.state(find.byType(GeoRecoveryDialog));
    await tester.enterText(
      find.byType(TextFormField),
      '  https://example.net/custom.dat  ',
    );
    await tester.tap(find.text('Download'));
    await tester.pumpAndSettle();
    expect(tester.state(find.byType(GeoRecoveryDialog)), same(dialogState));
    expect(find.text('The latest download failed'), findsOneWidget);
    expect(find.text('TLS handshake timeout'), findsNothing);
    expect(find.byType(LinearProgressIndicator), findsNothing);
    expect(result, isNull);
    await tester.tap(find.text('Download'));
    await tester.pumpAndSettle();
    expect(attemptedUrls, List.filled(2, 'https://example.net/custom.dat'));
    expect(result, isTrue);
  });

  testWidgets('invalid custom URLs stay open without downloading', (
    tester,
  ) async {
    var calls = 0;
    bool? result;
    await _openDialog(
      tester,
      download: (_) async {
        calls++;
        return null;
      },
      onResult: (value) => result = value,
    );
    for (final url in ['', 'file:///geoip.dat', 'https:///geoip.dat']) {
      await tester.enterText(find.byType(TextFormField), url);
      await tester.tap(find.text('Download'));
      await tester.pumpAndSettle();
      expect(find.text('Enter a valid HTTP or HTTPS URL'), findsOneWidget);
    }
    expect(calls, 0);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(result, isFalse);
  });

  for (final useBack in [false, true]) {
    testWidgets(
      'download completion after ${useBack ? 'back' : 'cancel'} leaves the underlying page open',
      (tester) async {
        final pending = Completer<String?>();
        await _openDialog(tester, download: (_) => pending.future);
        await tester.tap(find.text('Download'));
        await tester.pump();
        if (useBack) {
          await tester.binding.handlePopRoute();
        } else {
          await tester.tap(find.text('Cancel'));
        }
        pending.complete(null);
        await tester.pumpAndSettle();
        expect(find.byType(GeoRecoveryDialog), findsNothing);
        expect(find.text('Resource page'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  }

  for (final stale in [false, true]) {
    testWidgets(
      '${stale ? 'stale' : 'successful'} download removes only its own covered dialog',
      (tester) async {
        final pending = Completer<String?>();
        var current = true;
        var upperClosed = false;
        bool? result;
        await _openDialog(
          tester,
          download: (_) => pending.future,
          shouldContinue: () => current,
          onResult: (value) => result = value,
        );
        await tester.tap(find.text('Download'));
        await tester.pump();
        unawaited(
          showDialog<void>(
            context: tester.element(find.byType(GeoRecoveryDialog)),
            builder: (context) => AlertDialog(
              title: const Text('Other message'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close message'),
                ),
              ],
            ),
          ).then((_) => upperClosed = true),
        );
        await tester.pump();
        current = !stale;
        pending.complete(null);
        await tester.pumpAndSettle();
        expect(result, !stale);
        expect(find.byType(GeoRecoveryDialog), findsNothing);
        expect(find.text('Other message'), findsOneWidget);
        expect(upperClosed, isFalse);
        await tester.tap(find.text('Close message'));
        await tester.pumpAndSettle();
        expect(find.text('Resource page'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('stale guard prevents starting a download', (tester) async {
    var calls = 0;
    bool? result;
    await _openDialog(
      tester,
      shouldContinue: () => false,
      download: (_) async {
        calls++;
        return null;
      },
      onResult: (value) => result = value,
    );
    await tester.tap(find.text('Download'));
    await tester.pumpAndSettle();
    expect(calls, 0);
    expect(result, isFalse);
  });

  testWidgets('stale guard rejects a completed download', (tester) async {
    final pending = Completer<String?>();
    var current = true;
    bool? result;
    await _openDialog(
      tester,
      shouldContinue: () => current,
      download: (_) => pending.future,
      onResult: (value) => result = value,
    );
    await tester.tap(find.text('Download'));
    await tester.pump();
    current = false;
    pending.complete(null);
    await tester.pumpAndSettle();
    expect(result, isFalse);
    expect(find.byType(GeoRecoveryDialog), findsNothing);
  });

  testWidgets(
    'unexpected callback errors remain retryable without leaking details',
    (tester) async {
      await _openDialog(
        tester,
        download: (_) async => throw StateError('sensitive error detail'),
      );
      await tester.tap(find.text('Download'));
      await tester.pumpAndSettle();
      expect(find.byType(GeoRecoveryDialog), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsNothing);
      expect(find.textContaining('sensitive error detail'), findsNothing);
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNotNull,
      );
      expect(tester.takeException(), isNull);
    },
  );
}

Future<void> _openDialog(
  WidgetTester tester, {
  required Future<String?> Function(String url) download,
  ValueChanged<bool?>? onResult,
  bool Function()? shouldContinue,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        viewSizeProvider.overrideWithBuild((_, _) => const Size(800, 600)),
      ],
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => Scaffold(
                    appBar: AppBar(title: const Text('Resource page')),
                    body: TextButton(
                      onPressed: () async {
                        final result = await showDialog<bool>(
                          context: context,
                          builder: (_) => GeoRecoveryDialog(
                            resource: GeoResource.GEOIP,
                            url: 'https://example.org/geoip.dat',
                            error: 'TLS handshake timeout',
                            download: download,
                            shouldContinue: shouldContinue,
                          ),
                        );
                        onResult?.call(result);
                      },
                      child: const Text('Open'),
                    ),
                  ),
                ),
              ),
              child: const Text('Resources'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('Resources'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Open'));
  await tester.pumpAndSettle();
}

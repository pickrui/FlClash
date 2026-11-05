import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/widgets/update_download_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows progress and returns the local installer', (tester) async {
    final pending = Completer<File>();
    late ProgressCallback progress;
    UpdateDownloadResult? result;
    await openDialog(tester, (token, onProgress) {
      progress = onProgress;
      return pending.future;
    }, (value) => result = value);
    progress(50, 100);
    await tester.pump();
    expect(find.text('50%'), findsOneWidget);
    final file = File('/tmp/update.apk');
    pending.complete(file);
    await tester.pumpAndSettle();
    expect(result?.file, file);
    expect(result?.error, isNull);
  });

  testWidgets('cancel aborts download and ignores late completion', (
    tester,
  ) async {
    final pending = Completer<File>();
    late CancelToken token;
    UpdateDownloadResult? result;
    var returned = false;
    await openDialog(
      tester,
      (value, _) {
        token = value;
        return pending.future;
      },
      (value) {
        result = value;
        returned = true;
      },
    );
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(token.isCancelled, isTrue);
    expect(returned, isTrue);
    expect(result, isNull);
    final file = _DownloadedFile();
    pending.complete(file);
    await tester.pumpAndSettle();
    expect(file.deleted, isTrue);
    expect(result, isNull);
    expect(find.text('Open'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('system back cancels and ignores late progress and failure', (
    tester,
  ) async {
    final pending = Completer<File>();
    late CancelToken token;
    late ProgressCallback progress;
    var returned = false;
    await openDialog(
      tester,
      (value, onProgress) {
        token = value;
        progress = onProgress;
        return pending.future;
      },
      (result) {
        returned = true;
        expect(result, isNull);
      },
    );

    await tester.binding.handlePopRoute();
    expect(token.isCancelled, isTrue);
    progress(100, 100);
    pending.completeError(StateError('cancelled transport'));
    await tester.pumpAndSettle();
    expect(returned, isTrue);
    expect(find.text('Open'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'completion removes only its download route beneath another dialog',
    (tester) async {
      final pending = Completer<File>();
      UpdateDownloadResult? result;
      await openDialog(
        tester,
        (_, _) => pending.future,
        (value) => result = value,
      );
      unawaited(
        showDialog<void>(
          context: tester.element(find.byType(UpdateDownloadDialog)),
          builder: (_) => const AlertDialog(title: Text('Another dialog')),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      final file = File('/tmp/update.apk');
      pending.complete(file);
      await tester.pumpAndSettle();

      expect(result?.file, same(file));
      expect(find.text('Another dialog'), findsOneWidget);
      expect(
        find.byType(UpdateDownloadDialog, skipOffstage: false),
        findsNothing,
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('indeterminate and out of range progress remain valid', (
    tester,
  ) async {
    final pending = Completer<File>();
    late ProgressCallback progress;
    await openDialog(tester, (_, onProgress) {
      progress = onProgress;
      return pending.future;
    }, (_) {});
    progress(12, -1);
    await tester.pump();
    expect(
      tester
          .widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator))
          .value,
      isNull,
    );
    progress(120, 100);
    await tester.pump();
    expect(find.text('100%'), findsOneWidget);
    progress(-10, 100);
    await tester.pump();
    expect(find.text('0%'), findsOneWidget);
    pending.complete(File('/tmp/update.apk'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('failure returns an error for browser fallback', (tester) async {
    final error = StateError('download failed');
    UpdateDownloadResult? result;
    await openDialog(
      tester,
      (_, _) async => throw error,
      (value) => result = value,
    );
    await tester.pumpAndSettle();
    expect(result?.error, same(error));
    expect(result?.file, isNull);
    expect(tester.takeException(), isNull);
  });
}

Future<void> openDialog(
  WidgetTester tester,
  Future<File> Function(CancelToken, ProgressCallback) download,
  void Function(UpdateDownloadResult?) onResult,
) async {
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
              onPressed: () async {
                onResult(
                  await showDialog<UpdateDownloadResult>(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => UpdateDownloadDialog(download: download),
                  ),
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('Open'));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
}

class _DownloadedFile extends Fake implements File {
  bool deleted = false;

  @override
  Future<File> delete({bool recursive = false}) async {
    deleted = true;
    return this;
  }
}

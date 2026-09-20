import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fl_clash/common/update_download_task.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/update_download.dart';
import 'package:fl_clash/widgets/app_update.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

void main() {
  testWidgets('foreground progress becomes an explicit install choice', (
    tester,
  ) async {
    final pending = Completer<File>();
    late ProgressCallback progress;
    UpdateDownloadAction? result;
    final task = await openDialog(tester, (_, value) {
      progress = value;
      return pending.future;
    }, (value) => result = value);
    progress(50, 100);
    await tester.pump();
    expect(find.text('50%'), findsOneWidget);
    final file = File('/tmp/update.exe');
    pending.complete(file);
    await tester.pumpAndSettle();
    expect(task.value.file, same(file));
    expect(find.text('Install update'), findsOneWidget);
    expect(result, isNull);
    await tester.tap(find.text('Install update'));
    await tester.pumpAndSettle();
    expect(result, UpdateDownloadAction.install);
    expect(task.value.phase, AppUpdateDownloadPhase.ready);
  });
  testWidgets(
    'background downloads can be reopened during transfer and after completion',
    (tester) async {
      final pending = Completer<File>();
      late CancelToken token;
      var returned = false;
      var downloads = 0;
      final task = await openDialog(tester, (value, _) {
        downloads++;
        token = value;
        return pending.future;
      }, (_) => returned = true);
      await tester.tap(find.text('Download in background'));
      await tester.pumpAndSettle();
      expect(returned, isTrue);
      expect(token.isCancelled, isFalse);
      expect(find.byType(UpdateDownloadDialog), findsNothing);
      await tester.tap(find.text('Open'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(UpdateDownloadDialog), findsOneWidget);
      expect(downloads, 1);
      await tester.tap(find.text('Download in background'));
      await tester.pumpAndSettle();
      final file = File('/tmp/update.exe');
      pending.complete(file);
      await tester.pumpAndSettle();
      expect(task.value.phase, AppUpdateDownloadPhase.ready);
      expect(task.value.file, same(file));
      expect(find.text('Install update'), findsNothing);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('Install update'), findsOneWidget);
      expect(downloads, 1);
      expect(token.isCancelled, isFalse);
    },
  );
  testWidgets('cancel aborts download and deletes a late completion', (
    tester,
  ) async {
    final pending = Completer<File>();
    late CancelToken token;
    final task = await openDialog(tester, (value, _) {
      token = value;
      return pending.future;
    }, (_) {});
    await tester.tap(find.text('Cancel download'));
    await tester.pumpAndSettle();
    expect(token.isCancelled, isTrue);
    final file = _DownloadedFile();
    pending.complete(file);
    await tester.pumpAndSettle();
    expect(file.deleted, isTrue);
    expect(task.value.phase, AppUpdateDownloadPhase.canceled);
    expect(tester.takeException(), isNull);
  });
  testWidgets('system back also backgrounds the application-owned task', (
    tester,
  ) async {
    final pending = Completer<File>();
    late CancelToken token;
    final task = await openDialog(tester, (value, _) {
      token = value;
      return pending.future;
    }, (_) {});
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(token.isCancelled, isFalse);
    pending.complete(File('/tmp/update.exe'));
    await tester.pumpAndSettle();
    expect(task.value.phase, AppUpdateDownloadPhase.ready);
  });
  testWidgets('completion never dismisses a different dialog', (tester) async {
    final pending = Completer<File>();
    await openDialog(tester, (_, _) => pending.future, (_) {});
    unawaited(
      showDialog<void>(
        context: tester.element(find.byType(UpdateDownloadDialog)),
        builder: (_) => const AlertDialog(title: Text('Another dialog')),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    pending.complete(File('/tmp/update.exe'));
    await tester.pumpAndSettle();
    expect(find.text('Another dialog'), findsOneWidget);
    expect(
      find.byType(UpdateDownloadDialog, skipOffstage: false),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
  testWidgets(
    'failure offers retry and browser without launching either automatically',
    (tester) async {
      var attempts = 0;
      UpdateDownloadAction? result;
      final task = await openDialog(tester, (_, _) async {
        attempts++;
        throw StateError('private raw failure');
      }, (value) => result = value);
      await tester.pumpAndSettle();
      expect(find.text('Update download failed'), findsOneWidget);
      expect(find.textContaining('private raw'), findsNothing);
      expect(result, isNull);
      await tester.tap(find.text(AppLocalizations.current.configRecoveryRetry));
      await tester.pumpAndSettle();
      expect(attempts, 2);
      expect(task.value.phase, AppUpdateDownloadPhase.failed);
      await tester.tap(find.text('Download in browser'));
      await tester.pumpAndSettle();
      expect(result, UpdateDownloadAction.browser);
    },
  );
  for (final locale in AppLocalizations.delegate.supportedLocales) {
    testWidgets('download and install actions fit 320px in $locale', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final pending = Completer<File>();
      UpdateDownloadAction? result;
      final task = await openDialog(
        tester,
        (_, _) => pending.future,
        (value) => result = value,
        locale: locale,
      );
      expect(
        find
            .text(AppLocalizations.current.updateDownloadBackground)
            .hitTestable(),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.current.updateCancelDownload).hitTestable(),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
      pending.complete(File('/tmp/update.exe'));
      await tester.pumpAndSettle();
      expect(
        find
            .widgetWithText(
              FilledButton,
              AppLocalizations.current.updateInstall,
            )
            .hitTestable(),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
      await tester.tap(find.text(AppLocalizations.current.updateLater));
      await tester.pumpAndSettle();
      expect(result, isNull);
      expect(task.value.phase, AppUpdateDownloadPhase.ready);
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text(AppLocalizations.current.updateInstall), findsOneWidget);
    });

    testWidgets('retry stays primary when download fails at 320px in $locale', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await openDialog(
        tester,
        (_, _) async => throw StateError('fixture failure'),
        (_) {},
        locale: locale,
      );
      await tester.pumpAndSettle();
      expect(
        find
            .widgetWithText(
              FilledButton,
              AppLocalizations.current.configRecoveryRetry,
            )
            .hitTestable(),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.current.updateDownloadBrowser).hitTestable(),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });
  }
}

Future<AppUpdateDownloadTask> openDialog(
  WidgetTester tester,
  AppUpdateDownloader download,
  void Function(UpdateDownloadAction?) onResult, {
  Locale locale = const Locale('en'),
}) async {
  final task = AppUpdateDownloadTask();
  addTearDown(task.dispose);
  await tester.pumpWidget(
    TestApp(
      includeNavigatorKey: false,
      locale: locale,
      textScaler: const TextScaler.linear(1.5),
      overrides: [
        viewSizeProvider.overrideWithBuild((_, _) => const Size(800, 600)),
        appUpdateDownloadProvider.overrideWithValue(task),
      ],
      child: Scaffold(
        body: Builder(
          builder: (context) => TextButton(
            onPressed: () async {
              unawaited(
                task.start(download, url: 'https://fixture/update.exe'),
              );
              onResult(
                await showDialog<UpdateDownloadAction>(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => UpdateDownloadDialog(task: task),
                ),
              );
            },
            child: const Text('Open'),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('Open'));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
  return task;
}

class _DownloadedFile extends Fake implements File {
  bool deleted = false;
  @override
  Directory get parent => Directory('/tmp');
  @override
  Future<File> delete({bool recursive = false}) async {
    deleted = true;
    return this;
  }
}

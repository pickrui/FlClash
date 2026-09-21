import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fl_clash/common/request.dart';
import 'package:fl_clash/common/update_download_task.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/widgets/app_update.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

const _release = AppUpdateInfo(
  version: 'v0.8.98+2026092110',
  releaseNotes: 'Improved connection stability',
  remoteBuildNumber: 2026092110,
);

void main() {
  testWidgets('the details page downloads in place and then offers install', (
    tester,
  ) async {
    final pending = Completer<File>();
    late ProgressCallback progress;
    UpdateDownloadAction? result;
    final task = await openUpdatePage(tester, (_, value) {
      progress = value;
      return pending.future;
    }, (value) => result = value);
    await startDownload(tester);
    expect(find.byType(AppUpdatePage), findsOneWidget);
    expect(find.text(_release.releaseNotes!), findsOneWidget);
    progress(50, 100);
    await tester.pump();
    expect(find.text('50%'), findsOneWidget);
    final file = File('/tmp/update.exe');
    pending.complete(file);
    await tester.pumpAndSettle();
    expect(task.value.file, same(file));
    expect(find.text('Install update'), findsOneWidget);
    expect(find.byType(AppUpdatePage), findsOneWidget);
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
      final task = await openUpdatePage(tester, (value, _) {
        downloads++;
        token = value;
        return pending.future;
      }, (_) => returned = true);
      await startDownload(tester);
      await tester.tap(find.text('Download in background'));
      await tester.pumpAndSettle();
      expect(returned, isTrue);
      expect(token.isCancelled, isFalse);
      expect(find.byType(AppUpdatePage), findsNothing);
      await tester.tap(find.text('Open'));
      await pumpTransition(tester);
      expect(find.byType(AppUpdatePage), findsOneWidget);
      expect(
        find.text(AppLocalizations.current.updateDownloading),
        findsOneWidget,
      );
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
    final task = await openUpdatePage(tester, (value, _) {
      token = value;
      return pending.future;
    }, (_) {});
    await startDownload(tester);
    await tester.tap(find.text('Cancel download'));
    await tester.pumpAndSettle();
    expect(token.isCancelled, isTrue);
    final file = _DownloadedFile();
    pending.complete(file);
    await tester.pumpAndSettle();
    expect(file.deleted, isTrue);
    expect(task.value.phase, AppUpdateDownloadPhase.canceled);
    expect(find.byType(AppUpdatePage), findsOneWidget);
    expect(
      find.text(AppLocalizations.current.updateDownloadConfirm),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
  testWidgets('system back also backgrounds the application-owned task', (
    tester,
  ) async {
    final pending = Completer<File>();
    late CancelToken token;
    final task = await openUpdatePage(tester, (value, _) {
      token = value;
      return pending.future;
    }, (_) {});
    await startDownload(tester);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byType(AppUpdatePage), findsNothing);
    expect(token.isCancelled, isFalse);
    pending.complete(File('/tmp/update.exe'));
    await tester.pumpAndSettle();
    expect(task.value.phase, AppUpdateDownloadPhase.ready);
  });
  testWidgets(
    'failure offers retry and browser without launching either automatically',
    (tester) async {
      var attempts = 0;
      UpdateDownloadAction? result;
      final task = await openUpdatePage(tester, (_, _) async {
        attempts++;
        throw StateError('private raw failure');
      }, (value) => result = value);
      await startDownload(tester);
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
      final task = await openUpdatePage(
        tester,
        (_, _) => pending.future,
        (value) => result = value,
        locale: locale,
      );
      await startDownload(tester);
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
      await openUpdatePage(
        tester,
        (_, _) async => throw StateError('fixture failure'),
        (_) {},
        locale: locale,
      );
      await startDownload(tester);
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

Future<AppUpdateDownloadTask> openUpdatePage(
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
      child: Scaffold(
        body: Builder(
          builder: (context) => TextButton(
            onPressed: () async => onResult(
              await Navigator.of(context).push<UpdateDownloadAction>(
                MaterialPageRoute(
                  builder: (_) => AppUpdatePage(
                    info: _release,
                    task: task,
                    loadReleaseNotes: () async =>
                        throw StateError('cached notes fetched again'),
                    onDownload: () async => unawaited(
                      task.start(download, url: 'https://fixture/update.exe'),
                    ),
                  ),
                ),
              ),
            ),
            child: const Text('Open'),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('Open'));
  await tester.pumpAndSettle();
  return task;
}

/// An indeterminate progress bar never settles, so the transfer states are
/// reached by pumping past the frames they schedule.
Future<void> startDownload(WidgetTester tester) async {
  await tester.tap(find.text(AppLocalizations.current.updateDownloadConfirm));
  await pumpTransition(tester);
}

Future<void> pumpTransition(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
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

import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fl_clash/common/request.dart';
import 'package:fl_clash/common/update_download_task.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/update_download.dart';
import 'package:fl_clash/widgets/update_download_dialog.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

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
    'move to background detaches the dialog and preserves completion',
    (tester) async {
      final pending = Completer<File>();
      late CancelToken token;
      var returned = false;
      final task = await openDialog(tester, (value, _) {
        token = value;
        return pending.future;
      }, (_) => returned = true);
      await tester.tap(find.text('Download in background'));
      await tester.pumpAndSettle();
      expect(returned, isTrue);
      expect(token.isCancelled, isFalse);
      expect(find.byType(UpdateDownloadDialog), findsNothing);
      pending.complete(File('/tmp/update.exe'));
      await tester.pumpAndSettle();
      expect(task.value.phase, AppUpdateDownloadPhase.ready);
      expect(task.value.showReadyNotice, isTrue);
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
    await tester.tap(find.text('Cancel'));
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
  testWidgets(
    'ready notice persists until dismissed and retains the installer',
    (tester) async {
      final task = AppUpdateDownloadTask();
      addTearDown(task.dispose);
      await task.start((_, _) async => File('/tmp/update.exe'), url: 'fixture');
      await tester.pumpWidget(
        ProviderScope(
          overrides: [appUpdateDownloadProvider.overrideWithValue(task)],
          child: _app(const Scaffold(body: AppUpdateReadyNotice())),
        ),
      );
      await tester.pumpAndSettle();
      await tester.pump(const Duration(minutes: 1));
      expect(find.text('Update ready to install'), findsOneWidget);
      await tester.tap(find.text(AppLocalizations.current.close));
      await tester.pumpAndSettle();
      expect(find.text('Update ready to install'), findsNothing);
      expect(task.value.file, isNotNull);
    },
  );
  testWidgets('a discovered release reports the download it started', (
    tester,
  ) async {
    final pending = Completer<File>();
    final task = AppUpdateDownloadTask();
    addTearDown(task.dispose);
    unawaited(task.start((_, _) => pending.future, url: 'fixture'));
    final notice = await pumpAvailableNotice(tester, task);
    expect(find.text('Discovery a new version'), findsOneWidget);
    expect(find.text('0.8.98+2026091910'), findsOneWidget);
    expect(find.text('Downloading update'), findsOneWidget);
    expect(find.text(AppLocalizations.current.download), findsNothing);
    // A finished transfer is reported by the ready notice instead.
    pending.complete(File('/tmp/update.exe'));
    await tester.pumpAndSettle();
    expect(find.text('Discovery a new version'), findsNothing);
    expect(notice.value, isNotNull);
  });
  testWidgets(
    'a hidden-window offer waits for consent and dismissal suppresses it',
    (tester) async {
      final task = AppUpdateDownloadTask();
      addTearDown(task.dispose);
      var started = 0;
      task.addListener(() => started++);
      final notice = await pumpAvailableNotice(tester, task);
      await tester.pump(const Duration(minutes: 1));
      expect(find.text('0.8.98+2026091910'), findsOneWidget);
      expect(find.text('Downloading update'), findsNothing);
      expect(find.text(AppLocalizations.current.download), findsOneWidget);
      expect(task.value.phase, AppUpdateDownloadPhase.idle);
      expect(started, 0);
      await tester.tap(find.text(AppLocalizations.current.close));
      await tester.pumpAndSettle();
      expect(find.text('Discovery a new version'), findsNothing);
      expect(notice.value, isNull);
      expect(notice.declinedBuildNumber, 2026091910);
      expect(task.value.phase, AppUpdateDownloadPhase.idle);
    },
  );
  testWidgets('background action and ready notice fit a narrow window', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 740);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final pending = Completer<File>();
    await openDialog(tester, (_, _) => pending.future, (_) {});
    expect(find.text('Download in background'), findsOneWidget);
    expect(tester.takeException(), isNull);
    pending.complete(File('/tmp/update.exe'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}

Widget _app(Widget home) => MaterialApp(
  locale: const Locale('en'),
  localizationsDelegates: const [
    AppLocalizations.delegate,
    ...GlobalMaterialLocalizations.delegates,
  ],
  supportedLocales: AppLocalizations.delegate.supportedLocales,
  home: home,
);

Future<AppUpdateDownloadTask> openDialog(
  WidgetTester tester,
  AppUpdateDownloader download,
  void Function(UpdateDownloadAction?) onResult,
) async {
  final task = AppUpdateDownloadTask();
  addTearDown(task.dispose);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        viewSizeProvider.overrideWithBuild((_, _) => const Size(800, 600)),
        appUpdateDownloadProvider.overrideWithValue(task),
      ],
      child: _app(
        Scaffold(
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

Future<AppUpdateNotice> pumpAvailableNotice(
  WidgetTester tester,
  AppUpdateDownloadTask task,
) async {
  final notice = AppUpdateNotice()
    ..value = const AppUpdateInfo(
      version: '0.8.98+2026091910',
      remoteBuildNumber: 2026091910,
    );
  addTearDown(notice.dispose);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        appUpdateDownloadProvider.overrideWithValue(task),
        appUpdateNoticeProvider.overrideWithValue(notice),
      ],
      child: _app(const Scaffold(body: AppUpdateAvailableNotice())),
    ),
  );
  await tester.pumpAndSettle();
  return notice;
}

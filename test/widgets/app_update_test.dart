import 'dart:async';

import 'package:fl_clash/common/request.dart';
import 'package:fl_clash/common/update_download_task.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/providers/action.dart';
import 'package:fl_clash/providers/update_download.dart';
import 'package:fl_clash/widgets/app_update.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/test_app.dart';

const _release = AppUpdateInfo(
  version: 'v0.8.98+2026092110',
  releaseNotes: 'Improved connection stability\nUpdated translations',
  remoteBuildNumber: 2026092110,
);

void main() {
  testWidgets('a new release remains a notice until the user opens details', (
    tester,
  ) async {
    final action = _UpdateAction();
    final notice = ValueNotifier<AppUpdateInfo?>(null);
    addTearDown(notice.dispose);
    await tester.pumpWidget(
      TestApp(
        includeNavigatorKey: false,
        locale: const Locale('en'),
        textScaler: const TextScaler.linear(1.5),
        overrides: [
          appUpdateNoticeProvider.overrideWithValue(notice),
          updateActionProvider.overrideWith(() => action),
        ],
        child: const Scaffold(body: AppUpdateAvailableNotice()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(Card), findsNothing);
    notice.value = _release;
    await tester.pumpAndSettle();
    expect(find.text(_release.version), findsNothing);
    expect(find.text('v0.8.98'), findsNothing);
    expect(find.textContaining('${_release.remoteBuildNumber}'), findsNothing);
    expect(find.text(AppLocalizations.current.updateNotice), findsOneWidget);
    expect(action.opened, isEmpty);
    expect(find.byType(AppUpdatePage), findsNothing);
    expect(find.byType(AlertDialog), findsNothing);
    await tester.tap(find.text(AppLocalizations.current.updateNotice));
    expect(action.opened, [_release]);
    notice.value = null;
    await tester.pumpAndSettle();
    expect(find.byType(Card), findsNothing);
  });

  testWidgets('closing the notice dismisses that release without opening it', (
    tester,
  ) async {
    final action = _UpdateAction();
    final notice = ValueNotifier<AppUpdateInfo?>(_release);
    addTearDown(notice.dispose);
    await tester.pumpWidget(
      TestApp(
        includeNavigatorKey: false,
        locale: const Locale('en'),
        textScaler: const TextScaler.linear(1.5),
        overrides: [
          appUpdateNoticeProvider.overrideWithValue(notice),
          updateActionProvider.overrideWith(() => action),
        ],
        child: const Scaffold(body: AppUpdateAvailableNotice()),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip(AppLocalizations.current.close));
    expect(action.dismissed, [_release]);
    expect(action.opened, isEmpty);
  });

  for (final choice in ['download', 'later', 'back']) {
    testWidgets(
      'details start the download in place and close only for $choice',
      (tester) async {
        UpdateDownloadAction? result;
        var returned = false;
        var downloads = 0;
        await _openDetails(tester, _release, (value) {
          result = value;
          returned = true;
        }, onDownload: () async => downloads++);
        expect(find.text('v0.8.98'), findsOneWidget);
        expect(
          find.text(
            AppLocalizations.current.updateBuildNumber(
              _release.remoteBuildNumber,
            ),
          ),
          findsOneWidget,
        );
        expect(find.text(_release.releaseNotes!), findsOneWidget);
        expect(find.byType(SelectableText), findsOneWidget);
        expect(returned, isFalse);
        if (choice == 'back') {
          await tester.binding.handlePopRoute();
        } else {
          await tester.tap(
            find.text(
              choice == 'download'
                  ? AppLocalizations.current.updateDownloadConfirm
                  : AppLocalizations.current.updateLater,
            ),
          );
        }
        await tester.pumpAndSettle();
        expect(downloads, choice == 'download' ? 1 : 0);
        expect(returned, choice != 'download');
        expect(result, isNull);
        expect(
          find.byType(AppUpdatePage),
          choice == 'download' ? findsOneWidget : findsNothing,
        );
      },
    );
  }

  testWidgets('opening a notice with missing notes loads them again', (
    tester,
  ) async {
    final pending = Completer<String?>();
    var calls = 0;
    await _openDetails(
      tester,
      const AppUpdateInfo(version: '0.8.98+2026092110'),
      (_) {},
      loadReleaseNotes: () {
        calls++;
        return pending.future;
      },
      settle: false,
    );
    expect(calls, 1);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    expect(find.text('v0.8.98'), findsOneWidget);
    expect(
      find.text(AppLocalizations.current.updateBuildNumber(2026092110)),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizations.current.updateDownloadConfirm).hitTestable(),
      findsOneWidget,
    );
    pending.complete('Recovered release notes');
    await tester.pumpAndSettle();
    expect(find.text('Recovered release notes'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsNothing);
    expect(calls, 1);
  });

  for (final result in ['empty', 'error']) {
    testWidgets('$result notes show a retry that can recover', (tester) async {
      var calls = 0;
      await _openDetails(
        tester,
        const AppUpdateInfo(releaseNotes: '  '),
        (_) {},
        loadReleaseNotes: () async {
          if (++calls == 1) {
            if (result == 'error') throw StateError('offline');
            return '  ';
          }
          return 'Recovered after retry';
        },
      );
      expect(
        find.text(AppLocalizations.current.updateReleaseNotesFailed),
        findsOneWidget,
      );
      expect(find.text(AppLocalizations.current.noInfo), findsNothing);
      expect(
        find.text(AppLocalizations.current.updateDownloadConfirm),
        findsOneWidget,
      );
      await tester.tap(find.text(AppLocalizations.current.configRecoveryRetry));
      await tester.pumpAndSettle();
      expect(calls, 2);
      expect(find.text('Recovered after retry'), findsOneWidget);
      expect(
        find.text(AppLocalizations.current.updateReleaseNotesFailed),
        findsNothing,
      );
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('closing details while notes load ignores late completion', (
    tester,
  ) async {
    final pending = Completer<String?>();
    await _openDetails(
      tester,
      const AppUpdateInfo(),
      (_) {},
      loadReleaseNotes: () => pending.future,
      settle: false,
    );
    await tester.tap(find.text(AppLocalizations.current.updateLater));
    await tester.pumpAndSettle();
    pending.completeError(StateError('late network error'));
    await tester.pumpAndSettle();
    expect(find.byType(AppUpdatePage), findsNothing);
    expect(tester.takeException(), isNull);
  });

  for (final locale in AppLocalizations.delegate.supportedLocales) {
    testWidgets('long notes keep confirmation visible at 320px in $locale', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final release = AppUpdateInfo(
        version: _release.version,
        releaseNotes: List.filled(100, _release.releaseNotes).join('\n'),
      );
      var downloads = 0;
      await _openDetails(
        tester,
        release,
        (_) {},
        locale: locale,
        onDownload: () async => downloads++,
      );
      final button = find.widgetWithText(
        FilledButton,
        AppLocalizations.current.updateDownloadConfirm,
      );
      final before = tester.getRect(button);
      expect(before.bottom, lessThanOrEqualTo(640));
      expect(button.hitTestable(), findsOneWidget);
      await tester.drag(
        find.byType(SingleChildScrollView).first,
        const Offset(0, -800),
      );
      await tester.pumpAndSettle();
      expect(tester.getRect(button), before);
      expect(tester.takeException(), isNull);
      await tester.tap(button);
      await tester.pumpAndSettle();
      expect(downloads, 1);
    });
  }
}

class _UpdateAction extends UpdateAction {
  final opened = <AppUpdateInfo>[];
  final dismissed = <AppUpdateInfo>[];

  @override
  void build() {}

  @override
  Future<void> showDetails(AppUpdateInfo info) async => opened.add(info);

  @override
  void dismissNotice(AppUpdateInfo info) => dismissed.add(info);
}

Future<void> _openDetails(
  WidgetTester tester,
  AppUpdateInfo release,
  void Function(UpdateDownloadAction?) onResult, {
  Locale locale = const Locale('en'),
  Future<String?> Function()? loadReleaseNotes,
  Future<void> Function()? onDownload,
  bool settle = true,
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
                    info: release,
                    task: task,
                    loadReleaseNotes:
                        loadReleaseNotes ??
                        () async =>
                            throw StateError('cached notes fetched again'),
                    onDownload: onDownload ?? () async {},
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
  if (settle) {
    await tester.pumpAndSettle();
  } else {
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
  }
}

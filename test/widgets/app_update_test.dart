import 'package:fl_clash/common/request.dart';
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
    expect(find.text(_release.version), findsOneWidget);
    expect(action.opened, isEmpty);
    expect(find.byType(AppUpdatePage), findsNothing);
    expect(find.byType(AlertDialog), findsNothing);
    await tester.tap(find.text(AppLocalizations.current.updateViewDetails));
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
    testWidgets('native details return confirmation only for $choice', (
      tester,
    ) async {
      bool? result;
      var returned = false;
      await _openDetails(tester, _release, (value) {
        result = value;
        returned = true;
      });
      expect(find.text(_release.version), findsOneWidget);
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
      expect(returned, isTrue);
      expect(result, choice == 'download' ? isTrue : isNot(true));
      expect(find.byType(AppUpdatePage), findsNothing);
    });
  }

  testWidgets('missing release notes have a native empty state', (
    tester,
  ) async {
    await _openDetails(tester, const AppUpdateInfo(releaseNotes: '  '), (_) {});
    expect(find.text(AppLocalizations.current.noInfo), findsOneWidget);
    expect(
      find.text(AppLocalizations.current.updateDownloadConfirm),
      findsOneWidget,
    );
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
      bool? result;
      await _openDetails(
        tester,
        release,
        (value) => result = value,
        locale: locale,
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
      expect(result, isTrue);
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
  void Function(bool?) onResult, {
  Locale locale = const Locale('en'),
}) async {
  await tester.pumpWidget(
    TestApp(
      includeNavigatorKey: false,
      locale: locale,
      textScaler: const TextScaler.linear(1.5),
      child: Scaffold(
        body: Builder(
          builder: (context) => TextButton(
            onPressed: () async => onResult(
              await Navigator.of(context).push<bool>(
                MaterialPageRoute(builder: (_) => AppUpdatePage(info: release)),
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
}

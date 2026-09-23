import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/views/backup_and_restore.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

Future<ProviderContainer> _pumpPage(WidgetTester tester, DAVProps dav) async {
  const size = Size(800, 1200);
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  final container = ProviderContainer(
    overrides: [
      davSettingProvider.overrideWithBuild((_, _) => dav),
      viewSizeProvider.overrideWithBuild((_, _) => size),
    ],
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const TestApp(child: BackupAndRestore()),
    ),
  );
  await tester.pump();
  return container;
}

void main() {
  for (final (name, dav, message) in [
    (
      'a non-http address',
      const DAVProps(uri: 'ftp://dav.example.com', user: 'me', password: 'p'),
      () => appLocalizations.addressTip,
    ),
    (
      'an unsafe file name',
      const DAVProps(
        uri: 'https://dav.example.com',
        user: 'me',
        password: 'p',
        fileName: 'nested/backup.zip',
      ),
      () => appLocalizations.invalidBackupFile,
    ),
  ]) {
    testWidgets('a stored setting with $name keeps the page usable', (
      tester,
    ) async {
      await _pumpPage(tester, dav);

      expect(tester.takeException(), isNull);
      expect(find.text('me'), findsOneWidget);
      expect(find.text(appLocalizations.edit), findsOneWidget);

      await tester.tap(find.text(appLocalizations.remoteBackupDesc));
      await tester.pumpAndSettle();
      expect(find.text(message()), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('editing the account keeps the chosen backup file name', (
    tester,
  ) async {
    final container = await _pumpPage(
      tester,
      const DAVProps(
        uri: 'ftp://dav.example.com',
        user: 'me',
        password: 'old',
        fileName: 'custom.zip',
      ),
    );

    await tester.tap(find.text(appLocalizations.edit));
    await tester.pumpAndSettle();
    final address = find.widgetWithText(
      TextFormField,
      appLocalizations.address,
    );
    await tester.tap(find.text(appLocalizations.save));
    await tester.pumpAndSettle();
    expect(find.text(appLocalizations.addressTip), findsOneWidget);
    expect(container.read(davSettingProvider)?.uri, 'ftp://dav.example.com');

    await tester.enterText(address, 'https://dav.example.com');
    await tester.tap(find.text(appLocalizations.save));
    await tester.pumpAndSettle();

    expect(
      container.read(davSettingProvider),
      const DAVProps(
        uri: 'https://dav.example.com',
        user: 'me',
        password: 'old',
        fileName: 'custom.zip',
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('a loading toggle reuses the running connectivity check', (
    tester,
  ) async {
    final container = await _pumpPage(
      tester,
      const DAVProps(uri: 'http://127.0.0.1:1', user: 'me', password: 'p'),
    );
    Future<bool>? pingFuture() => tester
        .widget<FutureBuilder<bool>>(find.byType(FutureBuilder<bool>))
        .future;
    final ping = pingFuture();
    expect(ping, isNotNull);

    final loading = container.read(
      loadingProvider(LoadingTag.backup_restore).notifier,
    );
    loading.start();
    await tester.pump();
    loading.stop();
    await tester.pump(const Duration(seconds: 1));

    expect(container.read(loadingProvider(LoadingTag.backup_restore)), false);
    expect(pingFuture(), same(ping));
  });
}

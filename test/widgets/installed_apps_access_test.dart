import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/providers/installed_apps.dart';
import 'package:fl_clash/views/access.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/installed_apps_fake.dart';

Future<ProviderContainer> openAccess(
  WidgetTester tester,
  InstalledAppsFake api, {
  Locale locale = const Locale('en'),
  AccessControlProps props = const AccessControlProps(enable: true),
}) async {
  tester.view.physicalSize = const Size(400, 800);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final container = ProviderContainer(
    overrides: [
      installedAppsAppProvider.overrideWithValue(api),
      viewSizeProvider.overrideWithBuild((_, _) => const Size(400, 800)),
      vpnSettingProvider.overrideWithBuild(
        (_, _) => VpnProps(accessControlProps: props),
      ),
    ],
  );
  addTearDown(() async {
    container.dispose();
    await api.changes.close();
  });
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        locale: locale,
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        home: const AccessView(),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return container;
}

void main() {
  for (final locale in const [
    Locale('en'),
    Locale('zh', 'CN'),
    Locale('ja'),
    Locale('ru'),
  ]) {
    testWidgets(
      '$locale can grant installed apps access from the empty state',
      (tester) async {
        final api = InstalledAppsFake()
          ..granted = false
          ..packages = [installedPackage('new.app')];
        await openAccess(tester, api, locale: locale);
        expect(
          find.text(AppLocalizations.current.installedAppsPermissionRequired),
          findsOneWidget,
        );
        expect(find.text('new.app'), findsNothing);
        await tester.tap(
          find.text(AppLocalizations.current.installedAppsPermissionGrant),
        );
        await tester.pumpAndSettle();
        expect(api.requests, 1);
        expect(find.text('new.app'), findsWidgets);
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('denied permission opens settings and refreshes after resume', (
    tester,
  ) async {
    final api = InstalledAppsFake()
      ..granted = false
      ..requestResult = false;
    await openAccess(tester, api);
    await tester.tap(
      find.text(AppLocalizations.current.installedAppsPermissionGrant),
    );
    await tester.pumpAndSettle();
    expect(
      find.text(AppLocalizations.current.installedAppsPermissionDeniedMessage),
      findsOneWidget,
    );
    await tester.tap(find.text(AppLocalizations.current.settings));
    await tester.pumpAndSettle();
    expect(api.settings, 1);
    api.granted = true;
    api.packages = [installedPackage('after.settings')];
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();
    expect(find.text('after.settings'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('query failure has a retry action and is not shown as no data', (
    tester,
  ) async {
    final api = InstalledAppsFake()..fail = true;
    await openAccess(tester, api);
    expect(
      find.text(AppLocalizations.current.installedAppsLoadFailed),
      findsOneWidget,
    );
    api.fail = false;
    api.packages = [installedPackage('retried.app')];
    await tester.tap(find.text(AppLocalizations.current.refresh));
    await tester.pumpAndSettle();
    expect(find.text('retried.app'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'refresh and save retain hidden and temporarily missing selections',
    (tester) async {
      final api = InstalledAppsFake()
        ..packages = [
          installedPackage('visible.app'),
          installedPackage('system.app', system: true),
        ];
      final container = await openAccess(
        tester,
        api,
        props: const AccessControlProps(
          enable: true,
          mode: AccessControlMode.acceptSelected,
          acceptList: ['system.app', 'temporarily.missing'],
          isFilterSystemApp: true,
        ),
      );
      expect(find.text('system.app'), findsNothing);
      api.changes.add(null);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(Checkbox).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text(AppLocalizations.current.save));
      await tester.pumpAndSettle();
      expect(
        container.read(vpnSettingProvider).accessControlProps.acceptList,
        containsAll(['system.app', 'temporarily.missing', 'visible.app']),
      );
      api.packages = [installedPackage('new.install')];
      api.changes.add(null);
      await tester.pumpAndSettle();
      expect(find.text('visible.app'), findsNothing);
      expect(find.text('new.install'), findsWidgets);
      expect(
        container.read(vpnSettingProvider).accessControlProps.acceptList,
        contains('visible.app'),
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('search ignores the case of the typed query', (tester) async {
    final api = InstalledAppsFake()
      ..packages = [
        installedPackage('org.chromium.chrome'),
        installedPackage('other.app'),
      ];
    final container = await openAccess(tester, api);
    container.read(queryProvider(QueryTag.access).notifier).value = 'Chrome';
    await tester.pumpAndSettle();
    expect(find.text('org.chromium.chrome'), findsWidgets);
    expect(find.text('other.app'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  test('clipboard package lists tolerate CRLF, padding and blank lines', () {
    expect(parsePackageNames('a.app\r\n  b.app \r\n\r\na.app\n'), [
      'a.app',
      'b.app',
    ]);
    expect(parsePackageNames(''), isEmpty);
  });
}

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/http.dart';

import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/views/cloud/cloud_account_page.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/test_app.dart';

void main() {
  testWidgets(
    'failed account refresh ends the empty-page spinner and allows retry',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      final account = _FailedAccount();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            cloudAccountProvider.overrideWith(() => account),
            cloudServiceHealthCheckProvider.overrideWithValue(() async {}),
          ],
          child: MaterialApp(
            locale: const Locale('en'),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              ...GlobalMaterialLocalizations.delegates,
            ],
            supportedLocales: AppLocalizations.delegate.supportedLocales,
            home: const CloudAccountPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Cloud sync request timed out'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      await tester.tap(find.text('Refresh'));
      await tester.pumpAndSettle();
      expect(account.retries, 1);
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets('a single failed attempt does not blame the service', (
    tester,
  ) async {
    var checks = 0;
    await _pumpCloudPage(tester, () async {
      if (++checks == 1) throw const CloudApiException('Connection timed out');
    });
    await tester.pumpAndSettle();
    expect(checks, 2);
    expect(find.byType(MaterialBanner), findsNothing);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('API failure shows its cause and manual retry clears it', (
    tester,
  ) async {
    var checks = 0;
    // Only a check whose every attempt fails reaches the banner.
    await _pumpCloudPage(tester, () async {
      if (++checks <= 2) throw const CloudApiException('Connection timed out');
    });
    await tester.pumpAndSettle();
    expect(
      find.text('Service Check Failed: Connection timed out'),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.error), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Check API'));
    await tester.pumpAndSettle();
    expect(checks, 3);
    expect(find.byType(MaterialBanner), findsNothing);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'certificate retry requires consent and cancel preserves the error',
    (tester) async {
      var checks = 0;
      await _pumpCloudPage(tester, () async {
        checks++;
        throw _certificateError();
      });
      await tester.pumpAndSettle();
      expect(checks, 1);
      expect(find.text('Allow Temporarily'), findsNothing);
      expect(
        find.text('Service Check Failed: Direct: Certificate has expired'),
        findsOneWidget,
      );
      await tester.tap(find.text('Skip Verification and Retry'));
      await tester.pumpAndSettle();
      expect(find.text('Certificate has expired'), findsOneWidget);
      expect(
        find.textContaining('could be stolen or altered', findRichText: true),
        findsOneWidget,
      );
      expect(
        find.textContaining(
          'synchronize the system date and time',
          findRichText: true,
        ),
        findsOneWidget,
      );
      expect(checks, 1);
      await tester.tap(find.text('Cancel').last);
      await tester.pumpAndSettle();
      expect(checks, 1);
      expect(find.text('Skip Verification and Retry'), findsOneWidget);
      expect(FlClashTemporaryTls.allowBadCertificate, isFalse);
    },
  );

  testWidgets('temporary success stays marked and the next check is strict', (
    tester,
  ) async {
    final attempts = <bool>[];
    await _pumpCloudPage(tester, () async {
      attempts.add(FlClashTemporaryTls.allowBadCertificate);
      if (attempts.length == 1) throw _certificateError();
    });
    await tester.pumpAndSettle();
    await tester.tap(find.text('Skip Verification and Retry'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Allow Temporarily'));
    await tester.pumpAndSettle();
    expect(attempts, [false, true]);
    expect(FlClashTemporaryTls.allowBadCertificate, isFalse);
    expect(find.byIcon(Icons.check_circle), findsNothing);
    expect(find.byIcon(Icons.warning_amber), findsNWidgets(2));
    expect(
      find.text(AppLocalizations.current.apiAvailableWithCertificateException),
      findsOneWidget,
    );
    await tester.tap(find.widgetWithText(TextButton, 'Check API'));
    await tester.pumpAndSettle();
    expect(attempts, [false, true, false]);
    expect(find.byType(MaterialBanner), findsNothing);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
  });

  testWidgets(
    'a failed temporary retry shows its new cause without retrying again',
    (tester) async {
      final attempts = <bool>[];
      await _pumpCloudPage(tester, () async {
        attempts.add(FlClashTemporaryTls.allowBadCertificate);
        throw _certificateError(
          attempts.length == 1
              ? 'certificate has expired'
              : 'hostname mismatch',
        );
      });
      await tester.pumpAndSettle();
      await tester.tap(find.text('Skip Verification and Retry'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Allow Temporarily'));
      await tester.pumpAndSettle();
      expect(attempts, [false, true]);
      expect(find.text('Allow Temporarily'), findsNothing);
      expect(
        find.text(
          'Service Check Failed: Direct: Certificate does not match the requested domain',
        ),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.check_circle), findsNothing);
      expect(FlClashTemporaryTls.allowBadCertificate, isFalse);
    },
  );

  testWidgets('a certificate message alone cannot enable bypass', (
    tester,
  ) async {
    await _pumpCloudPage(
      tester,
      () async => throw Exception('CERTIFICATE_VERIFY_FAILED'),
    );
    await tester.pumpAndSettle();
    expect(find.text('Skip Verification and Retry'), findsNothing);
    expect(find.byType(MaterialBanner), findsOneWidget);
  });

  testWidgets(
    'a check queued during consent runs with certificate verification',
    (tester) async {
      final attempts = <bool>[];
      final container = await _pumpCloudPage(tester, () async {
        attempts.add(FlClashTemporaryTls.allowBadCertificate);
        if (attempts.length == 1) throw _certificateError();
      });
      await tester.pumpAndSettle();
      await tester.tap(find.text('Skip Verification and Retry'));
      await tester.pumpAndSettle();
      container
          .read(currentPageLabelProvider.notifier)
          .toPage(PageLabel.oixCloud);
      await tester.pump();
      expect(attempts, [false]);
      await tester.tap(find.text('Allow Temporarily'));
      await tester.pumpAndSettle();
      expect(attempts, [false, true, false]);
      expect(find.byType(MaterialBanner), findsNothing);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    },
  );

  for (final locale in [
    const Locale('en'),
    const Locale('zh', 'CN'),
    const Locale('ja'),
    const Locale('ru'),
  ]) {
    testWidgets('certificate warning fits a narrow screen in $locale', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await _pumpCloudPage(
        tester,
        () async => throw _certificateError(),
        locale: locale,
      );
      await tester.pumpAndSettle();
      final l = AppLocalizations.current;
      await tester.tap(find.text(l.retryWithoutCertificateVerification));
      await tester.pumpAndSettle();
      expect(find.text(l.certificateExpired), findsOneWidget);
      expect(find.text(l.allowTemporarily), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.tap(find.text(l.cancel).last);
      await tester.pumpAndSettle();
      expect(find.byType(MaterialBanner), findsOneWidget);
    });
  }

  testWidgets('returning to the cloud tab refreshes an old API failure', (
    tester,
  ) async {
    var checks = 0;
    final container = await _pumpCloudPage(tester, () async {
      if (++checks <= 2) throw const CloudApiException('Connection failed');
    });
    await tester.pumpAndSettle();
    container
        .read(currentPageLabelProvider.notifier)
        .toPage(PageLabel.oixCloud);
    await tester.pumpAndSettle();
    expect(checks, 3);
    expect(find.byType(MaterialBanner), findsNothing);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
  });

  testWidgets(
    'tab reentry queues a fresh check after an older check finishes',
    (tester) async {
      var checks = 0;
      final first = Completer<void>();
      final container = await _pumpCloudPage(tester, () async {
        if (++checks == 1) await first.future;
      });
      await tester.pump();
      container
          .read(currentPageLabelProvider.notifier)
          .toPage(PageLabel.oixCloud);
      await tester.pump();
      expect(checks, 1);
      first.completeError(const CloudApiException('Old connection failed'));
      await tester.pumpAndSettle();
      expect(checks, 3);
      expect(find.byType(MaterialBanner), findsNothing);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    },
  );

  testWidgets('a completed check cannot update a disposed cloud page', (
    tester,
  ) async {
    final pending = Completer<void>();
    await _pumpCloudPage(tester, () => pending.future);
    await tester.pumpWidget(const SizedBox.shrink());
    pending.completeError(const CloudApiException('Connection failed'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}

Future<ProviderContainer> _pumpCloudPage(
  WidgetTester tester,
  Future<void> Function() healthCheck, {
  Locale locale = const Locale('en'),
}) async {
  SharedPreferences.setMockInitialValues({});
  await tester.pumpWidget(
    TestApp(
      locale: locale,
      overrides: [
        viewSizeProvider.overrideWithBuild(
          (_, _) => tester.view.physicalSize / tester.view.devicePixelRatio,
        ),
        cloudAccountProvider.overrideWith(_FailedAccount.new),
        cloudServiceHealthCheckProvider.overrideWithValue(healthCheck),
      ],
      child: const CloudAccountPage(),
    ),
  );
  return ProviderScope.containerOf(
    tester.element(find.byType(CloudAccountPage)),
  );
}

class _FailedAccount extends CloudAccountNotifier {
  int retries = 0;
  @override
  CloudAccountState build() => const CloudAccountState(
    isLoggedIn: true,
    error: 'Cloud sync request timed out',
  );
  @override
  Future<void> refreshProfile({bool force = false}) async {
    retries++;
  }
}

class _Certificate implements X509Certificate {
  @override
  Uint8List get der => Uint8List.fromList([1, 2, 3]);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

DioException _certificateError([String reason = 'certificate has expired']) =>
    DioException.badCertificate(
      requestOptions: RequestOptions(
        path: 'https://api.test/check',
        extra: {cloudReadRouteExtraKey: 'DIRECT'},
      ),
      error: TlsCertificateFailure(_Certificate(), 'api.test', 443)
          .withVerificationError(
            HandshakeException('CERTIFICATE_VERIFY_FAILED: $reason'),
          ),
    );

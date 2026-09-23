import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/http.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:fl_clash/views/cloud/cloud_login_page.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

class _Certificate implements X509Certificate {
  @override
  Uint8List get der => Uint8List.fromList([1, 2, 3]);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<bool> _run(
  WidgetTester tester,
  Future<void> Function() submit, {
  String? tapText,
}) async {
  await tester.pumpWidget(
    TestApp(
      locale: const Locale('en'),
      overrides: [
        viewSizeProvider.overrideWithBuild((_, _) => const Size(800, 600)),
      ],
      child: const SizedBox.shrink(),
    ),
  );
  bool? result;
  submitCloudAuth(
    submit,
    errorTitle: 'Fixture failed',
  ).then((value) => result = value);
  await tester.pumpAndSettle();
  if (tapText != null) {
    await tester.tap(find.text(tapText));
    await tester.pumpAndSettle();
  }
  expect(result, isNotNull);
  return result!;
}

void main() {
  testWidgets('a successful submission reports success without a dialog', (
    tester,
  ) async {
    expect(await _run(tester, () async {}), isTrue);
    expect(find.text('Fixture failed'), findsNothing);
  });

  testWidgets('a handled unauthorized error stays silent', (tester) async {
    final ok = await _run(
      tester,
      () async => throw const CloudApiUnauthorizedHandledException(),
    );
    expect(ok, isFalse);
    expect(find.text('Fixture failed'), findsNothing);
  });

  testWidgets('any other error is shown under the given title', (tester) async {
    final ok = await _run(tester, () async => throw Exception('boom'));
    expect(ok, isFalse);
    expect(find.text('Fixture failed'), findsOneWidget);
  });

  testWidgets('a certificate failure retries the same submission', (
    tester,
  ) async {
    final insecureAttempts = <bool>[];
    final ok = await _run(tester, () async {
      insecureAttempts.add(FlClashTemporaryTls.allowBadCertificate);
      if (insecureAttempts.length == 1) {
        throw DioException.badCertificate(
          requestOptions: RequestOptions(path: 'https://api.test/login'),
          error: TlsCertificateFailure(_Certificate(), 'api.test', 443),
        );
      }
    }, tapText: 'Allow Temporarily');
    expect(ok, isTrue);
    expect(insecureAttempts, [false, true]);
    expect(find.text('Fixture failed'), findsNothing);
  });
  testWidgets(
    'a certificate message without a verified target cannot grant a retry',
    (tester) async {
      var attempts = 0;
      final ok = await _run(tester, () async {
        attempts++;
        throw Exception('CERTIFICATE_VERIFY_FAILED');
      });
      expect(ok, isFalse);
      expect(attempts, 1);
      expect(find.text('Allow Temporarily'), findsNothing);
      expect(find.text('Fixture failed'), findsOneWidget);
    },
  );
}

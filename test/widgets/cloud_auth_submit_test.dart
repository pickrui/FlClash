import 'package:fl_clash/common/http.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:fl_clash/views/cloud/cloud_login_page.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

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
        throw Exception('CERTIFICATE_VERIFY_FAILED');
      }
    }, tapText: 'Allow Temporarily');
    expect(ok, isTrue);
    expect(insecureAttempts, [false, true]);
    expect(find.text('Fixture failed'), findsNothing);
  });
}

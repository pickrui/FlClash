import 'dart:ffi' hide Size;

import 'package:fl_clash/common/linux_package_format.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/widgets/linux_package_format_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

/// Collects what the dialog answers, one entry per time it is closed.
Future<List<LinuxPackageFormat?>> _openDialog(
  WidgetTester tester,
  List<LinuxPackageFormat> formats,
) async {
  final answers = <LinuxPackageFormat?>[];
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        viewSizeProvider.overrideWithBuild((_, _) => const Size(800, 600)),
      ],
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () async => answers.add(
                await showDialog<LinuxPackageFormat>(
                  context: context,
                  builder: (_) => LinuxPackageFormatDialog(formats: formats),
                ),
              ),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
  return answers;
}

void main() {
  testWidgets('only the formats this ABI publishes are offered', (
    tester,
  ) async {
    await _openDialog(tester, linuxPackageFormatsFor(Abi.linuxArm64));
    expect(
      find.text(AppLocalizations.current.updatePackageFormat),
      findsOneWidget,
    );
    expect(find.text(LinuxPackageFormat.deb.extension), findsOneWidget);
    expect(find.text(LinuxPackageFormat.rpm.extension), findsNothing);
    expect(find.text(LinuxPackageFormat.appImage.extension), findsNothing);
  });

  testWidgets('the tapped format is the answer', (tester) async {
    final answers = await _openDialog(tester, LinuxPackageFormat.values);
    await tester.tap(find.text(LinuxPackageFormat.rpm.extension));
    await tester.pumpAndSettle();
    expect(find.byType(LinuxPackageFormatDialog), findsNothing);
    expect(answers, [LinuxPackageFormat.rpm]);
  });

  testWidgets('cancelling leaves the question unanswered', (tester) async {
    final answers = await _openDialog(tester, LinuxPackageFormat.values);
    await tester.tap(find.text(AppLocalizations.current.cancel));
    await tester.pumpAndSettle();
    expect(find.byType(LinuxPackageFormatDialog), findsNothing);
    expect(answers, [null]);
  });
}

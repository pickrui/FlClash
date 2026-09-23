import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/providers/network_diagnostic_fix.dart';
import 'package:fl_clash/services/network_diagnostics.dart';
import 'package:fl_clash/views/network_diagnostics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _snapshot = NetworkDiagnosticSnapshot(
  profileApplied: true,
  profileSelected: true,
  running: true,
  suspended: false,
  systemProxy: true,
  tun: false,
  oixCloud: true,
  port: 7890,
);

class _ControlledService extends NetworkDiagnosticService {
  final completion = Completer<void>();
  CancelToken? token;
  int runs = 0;
  @override
  Future<List<NetworkDiagnosticCheck>> run(
    NetworkDiagnosticSnapshot state,
    CancelToken cancellation, {
    required void Function(NetworkDiagnosticCheck) onResult,
  }) async {
    runs++;
    token = cancellation;
    onResult(
      const NetworkDiagnosticCheck(
        'fixture',
        'oixCloud DNS',
        DiagnosticStatus.failed,
        'DNS lookup failed (System error 11001)',
        'Check DNS settings and system time',
      ),
    );
    onResult(
      const NetworkDiagnosticCheck(
        'tun',
        'TUN',
        DiagnosticStatus.failed,
        'TUN interface missing',
        'Turn TUN off and on',
        DiagnosticFix.applyTun,
      ),
    );
    await completion.future;
    onResult(
      const NetworkDiagnosticCheck(
        'late',
        'Late check',
        DiagnosticStatus.passed,
        'Late result',
      ),
    );
    return [];
  }
}

class _FailingService extends _ControlledService {
  @override
  Future<List<NetworkDiagnosticCheck>> run(
    NetworkDiagnosticSnapshot state,
    CancelToken cancellation, {
    required void Function(NetworkDiagnosticCheck) onResult,
  }) async {
    runs++;
    token = cancellation;
    throw StateError('probe backend missing');
  }
}

Future<ProviderContainer> _pump(
  WidgetTester tester,
  _ControlledService service, {
  NetworkDiagnosticFixHandler? onFix,
}) async {
  SharedPreferences.setMockInitialValues({});
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        networkDiagnosticReportHeaderProvider.overrideWithValue(
          'FlClash 0.8.97+fixture (windows)',
        ),
        networkDiagnosticServiceProvider.overrideWithValue(service),
        networkDiagnosticSnapshotProvider.overrideWithValue(_snapshot),
        networkDiagnosticFixHandlerProvider.overrideWithValue(
          onFix ?? (fix) async => fail('unexpected fix $fix'),
        ),
      ],
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        home: const NetworkDiagnosticsPage(),
      ),
    ),
  );
  await tester.pump();
  return ProviderScope.containerOf(
    tester.element(find.byType(NetworkDiagnosticsPage)),
  );
}

void main() {
  testWidgets(
    'shows concrete cause and suggestion, then copies a bounded report',
    (tester) async {
      final service = _ControlledService();
      String? clipboard;
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (call) async {
          if (call.method == 'Clipboard.setData') {
            clipboard = (call.arguments as Map)['text'] as String;
          }
          return null;
        },
      );
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          null,
        ),
      );
      await _pump(tester, service);
      expect(
        find.text('DNS lookup failed (System error 11001)'),
        findsOneWidget,
      );
      expect(find.text('Check DNS settings and system time'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
      service.completion.complete();
      await tester.pumpAndSettle();
      expect(find.byType(LinearProgressIndicator), findsNothing);
      await tester.tap(find.byTooltip(AppLocalizations.current.diagCopy));
      await tester.pump();
      expect(clipboard, contains('[Failed] oixCloud DNS'));
      expect(clipboard, contains('0.8.97+fixture (windows)'));
      expect(clipboard, contains('11001'));
      expect(clipboard, isNot(contains('7890')));
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets('cancel prevents late results and allows a fresh run', (
    tester,
  ) async {
    final service = _ControlledService();
    await _pump(tester, service);
    await tester.tap(find.text(AppLocalizations.current.cancel));
    await tester.pump();
    expect(service.token!.isCancelled, isTrue);
    service.completion.complete();
    await tester.pumpAndSettle();
    expect(find.text('Late result'), findsNothing);
    expect(find.text(AppLocalizations.current.diagCanceled), findsOneWidget);
    await tester.tap(find.text(AppLocalizations.current.diagRun));
    await tester.pumpAndSettle();
    expect(service.runs, 2);
    expect(find.text(AppLocalizations.current.diagCanceled), findsNothing);
  });
  testWidgets('configuration changes cancel a running snapshot', (
    tester,
  ) async {
    final service = _ControlledService();
    final container = await _pump(tester, service);
    container.updateOverrides([
      networkDiagnosticReportHeaderProvider.overrideWithValue(
        'FlClash 0.8.97+fixture (windows)',
      ),
      networkDiagnosticServiceProvider.overrideWithValue(service),
      networkDiagnosticFixHandlerProvider.overrideWithValue(
        (fix) async => fail('unexpected fix $fix'),
      ),
      networkDiagnosticSnapshotProvider.overrideWithValue(
        const NetworkDiagnosticSnapshot(
          profileApplied: true,
          profileSelected: true,
          running: true,
          suspended: false,
          systemProxy: true,
          tun: true,
          oixCloud: true,
          port: 7890,
        ),
      ),
    ]);
    await tester.pump();
    expect(service.token!.isCancelled, isTrue);
    service.completion.complete();
    await tester.pumpAndSettle();
    expect(find.text('Late result'), findsNothing);
  });
  testWidgets(
    'closing the page cancels probes without updating disposed state',
    (tester) async {
      final service = _ControlledService();
      await _pump(tester, service);
      await tester.pumpWidget(const SizedBox());
      expect(service.token!.isCancelled, isTrue);
      service.completion.complete();
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    },
  );
  Finder fixButton() => find.ancestor(
    of: find.text(AppLocalizations.current.diagFixTun),
    matching: find.byWidgetPredicate((widget) => widget is FilledButton),
  );
  testWidgets('a fix runs the mapped action, then re-checks', (tester) async {
    final service = _ControlledService();
    final fixes = <DiagnosticFix>[];
    await _pump(tester, service, onFix: (fix) async => fixes.add(fix));
    // Fixes wait until the current run has finished.
    expect(tester.widget<FilledButton>(fixButton()).onPressed, isNull);
    service.completion.complete();
    await tester.pumpAndSettle();
    expect(tester.widget<FilledButton>(fixButton()).onPressed, isNotNull);
    await tester.tap(fixButton());
    await tester.pump();
    expect(fixes, [DiagnosticFix.applyTun]);
    expect(find.text(AppLocalizations.current.diagFixing), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    expect(tester.widget<FilledButton>(fixButton()).onPressed, isNull);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(service.runs, 2);
    expect(find.text(AppLocalizations.current.diagFixing), findsNothing);
    expect(tester.takeException(), isNull);
  });
  testWidgets('a failing fix still re-checks without crashing', (tester) async {
    final service = _ControlledService()..completion.complete();
    await _pump(
      tester,
      service,
      onFix: (fix) async => throw StateError('system proxy restore failed'),
    );
    await tester.pumpAndSettle();
    await tester.tap(fixButton());
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(service.runs, 2);
    expect(find.text(AppLocalizations.current.diagFixing), findsNothing);
    expect(tester.takeException(), isNull);
  });
  testWidgets('a failing run logs its cause and shows an unknown result', (
    tester,
  ) async {
    final printed = <String?>[];
    final originalDebugPrint = debugPrint;
    debugPrint = (message, {wrapWidth}) => printed.add(message);
    try {
      await _pump(tester, _FailingService());
      await tester.pumpAndSettle();
    } finally {
      debugPrint = originalDebugPrint;
    }
    expect(find.text(AppLocalizations.current.diagUnknown), findsWidgets);
    expect(find.byType(LinearProgressIndicator), findsNothing);
    expect(printed, contains(contains('probe backend missing')));
    expect(tester.takeException(), isNull);
  });
  testWidgets('the report lists suggestions but no fix buttons', (
    tester,
  ) async {
    final service = _ControlledService()..completion.complete();
    String? clipboard;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          clipboard = (call.arguments as Map)['text'] as String;
        }
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );
    await _pump(tester, service);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip(AppLocalizations.current.diagCopy));
    await tester.pump();
    expect(clipboard, contains('Turn TUN off and on'));
    expect(clipboard, isNot(contains(AppLocalizations.current.diagFixTun)));
  });
  testWidgets('results fit a narrow window and large text', (tester) async {
    tester.view.physicalSize = const Size(360, 760);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 1.5;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    final service = _ControlledService()..completion.complete();
    await _pump(tester, service);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}

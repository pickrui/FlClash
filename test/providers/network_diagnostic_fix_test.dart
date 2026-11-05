import 'dart:async';

import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/services/network_diagnostics.dart';
import 'package:fl_clash/providers/network_diagnostic_fix.dart';
import 'package:flutter/widgets.dart' show Locale;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

final _calls = <String>[];

class _RecordingSetupAction extends SetupAction {
  static bool applyResult = true;

  @override
  Future<void> updateStatus(bool isStart, {bool isInit = false}) async {
    _calls.add('updateStatus:$isStart:$isInit');
  }

  @override
  Future<bool> applyProfile({
    bool silence = false,
    bool force = false,
    FutureOr<void> Function()? preloadInvoke,
  }) async {
    _calls.add('applyProfile:$force');
    return applyResult;
  }
}

class _RecordingCoreAction extends CoreAction {
  @override
  Future<void> restartCore([bool start = false]) async {
    _calls.add('restartCore:$start');
  }
}

class _RecordingSystemAction extends SystemAction {
  @override
  void updateSystemProxy([bool? enable]) {
    _calls.add('updateSystemProxy:$enable');
  }
}

class _RecordingAppStateAction extends AppStateAction {
  @override
  List<Group> get groups => const [];

  @override
  String? getCurrentGroupName() => null;
}

class _RecordingProxiesAction extends ProxiesAction {
  @override
  Future<bool> delayTest(List<Proxy> proxies, [String? testUrl]) async {
    _calls.add('delayTest:${proxies.length}');
    return false;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => AppLocalizations.load(const Locale('en')));

  ProviderContainer container({bool isStart = false}) {
    _calls.clear();
    final container = ProviderContainer(
      overrides: [
        isStartProvider.overrideWith((ref) => isStart),
        setupActionProvider.overrideWith(_RecordingSetupAction.new),
        coreActionProvider.overrideWith(_RecordingCoreAction.new),
        systemActionProvider.overrideWith(_RecordingSystemAction.new),
        appStateActionProvider.overrideWith(_RecordingAppStateAction.new),
        proxiesActionProvider.overrideWith(_RecordingProxiesAction.new),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  Future<void> apply(ProviderContainer container, DiagnosticFix fix) =>
      container.read(networkDiagnosticFixHandlerProvider)(fix);

  test('loading a profile starts a stopped connection first', () async {
    await apply(container(), DiagnosticFix.applyProfile);
    expect(_calls, ['updateStatus:true:true']);
    await apply(container(isStart: true), DiagnosticFix.applyProfile);
    expect(_calls, ['applyProfile:true']);
  });
  test('a rejected profile apply is reported as a failed fix', () async {
    _RecordingSetupAction.applyResult = false;
    addTearDown(() => _RecordingSetupAction.applyResult = true);
    await expectLater(
      apply(container(isStart: true), DiagnosticFix.applyProfile),
      throwsStateError,
    );
  });
  test('starting uses the connection switch path', () async {
    await apply(container(), DiagnosticFix.startConnection);
    expect(_calls, ['updateStatus:true:true']);
  });
  test('core fixes restart through the lifecycle owner', () async {
    await apply(container(), DiagnosticFix.restartCore);
    expect(_calls, ['restartCore:false']);
    for (final fix in [
      DiagnosticFix.restartConnection,
      DiagnosticFix.applyTun,
    ]) {
      await apply(container(isStart: true), fix);
      expect(_calls, ['restartCore:true'], reason: fix.name);
    }
  });
  test('enabling the system proxy sets it rather than toggling', () async {
    await apply(container(), DiagnosticFix.enableSystemProxy);
    expect(_calls, ['updateSystemProxy:true']);
  });
  test('retesting without groups is a safe no-op', () async {
    await apply(container(isStart: true), DiagnosticFix.retestProxies);
    expect(_calls, isEmpty);
  });
}

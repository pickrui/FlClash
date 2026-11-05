import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/services/network_diagnostics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef NetworkDiagnosticFixHandler = Future<void> Function(DiagnosticFix fix);

/// Performs a [DiagnosticFix]. Tests override this to observe which fix the
/// page requested without driving the real core.
final networkDiagnosticFixHandlerProvider =
    Provider<NetworkDiagnosticFixHandler>(
      (ref) =>
          (fix) => applyNetworkDiagnosticFix(ref, fix),
    );

/// Maps each fix to the app action that the manual suggestion would have the
/// user perform. Every branch reuses the existing lifecycle owner so the fix
/// cannot race a user-initiated start, stop or restart.
Future<void> applyNetworkDiagnosticFix(Ref ref, DiagnosticFix fix) async {
  Future<void> start() => ref
      .read(setupActionProvider.notifier)
      .updateStatus(true, isInit: !ref.read(initProvider));
  switch (fix) {
    case DiagnosticFix.applyProfile:
      if (!ref.read(isStartProvider)) {
        await start();
      } else if (!await ref
          .read(setupActionProvider.notifier)
          .applyProfile(force: true)) {
        throw StateError('profile not applied');
      }
    case DiagnosticFix.startConnection:
      await start();
    case DiagnosticFix.restartCore:
      await ref.read(coreActionProvider.notifier).restartCore();
    case DiagnosticFix.restartConnection:
    case DiagnosticFix.applyTun:
      // Restarting with start=true reopens listeners (prompting for a port on
      // conflict) and reapplies TUN, requesting authorization when missing.
      await ref.read(coreActionProvider.notifier).restartCore(true);
    case DiagnosticFix.applySystemProxy:
      final proxyState = ref.read(proxyStateProvider);
      final result = await startSystemProxy(
        proxyState.port,
        proxyState.bassDomain,
      );
      if (result != SystemProxyStartResult.success) {
        throw StateError('system proxy ${result.name}');
      }
    case DiagnosticFix.enableSystemProxy:
      ref.read(systemActionProvider.notifier).updateSystemProxy(true);
    case DiagnosticFix.retestProxies:
      final appState = ref.read(appStateActionProvider.notifier);
      final groups = appState.groups;
      if (groups.isEmpty) return;
      final name = appState.getCurrentGroupName();
      final group = groups.firstWhere(
        (group) => group.name == name,
        orElse: () => groups.first,
      );
      await ref
          .read(proxiesActionProvider.notifier)
          .delayTest(group.all, group.testUrl);
  }
}

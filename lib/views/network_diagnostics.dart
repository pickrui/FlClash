import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/providers/network_diagnostic_fix.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/models/profile.dart';
import 'package:fl_clash/services/network_diagnostics.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final networkDiagnosticReportHeaderProvider = Provider<String>((ref) {
  final info = globalState.packageInfo;
  return 'FlClash ${info.version}+${info.buildNumber} (${Platform.operatingSystem})';
});

final networkDiagnosticServiceProvider = Provider<NetworkDiagnosticService>(
  (ref) => NetworkDiagnosticService(),
);
final networkDiagnosticSnapshotProvider = Provider<NetworkDiagnosticSnapshot>((
  ref,
) {
  final profile = ref.watch(currentProfileProvider);
  final patch = ref.watch(patchClashConfigProvider);
  return NetworkDiagnosticSnapshot(
    profileSelected: profile != null,
    profileApplied:
        profile != null && globalState.lastSetupState?.profileId == profile.id,
    running: ref.watch(isStartProvider),
    suspended: ref.watch(suspendProvider),
    systemProxy: ref.watch(proxyStateProvider).systemProxy,
    tun: patch.tun.enable,
    oixCloud: profile?.isoixCloudProfile ?? false,
    port: patch.mixedPort,
    authenticated: ref.watch(
      networkSettingProvider.select((state) => state.authentication.enable),
    ),
  );
});

/// Waits for the system proxy queue that a start/restart fix triggers through
/// ProxyManager, so the re-check samples the OS after the write.
Future<void> _settleSystemProxy() => systemProxyController.idle.timeout(
  const Duration(seconds: 5),
  onTimeout: () {},
);

void showNetworkDiagnostics(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => const NetworkDiagnosticsPage()),
  );
}

class NetworkDiagnosticsPage extends ConsumerStatefulWidget {
  const NetworkDiagnosticsPage({super.key});
  @override
  ConsumerState<NetworkDiagnosticsPage> createState() =>
      _NetworkDiagnosticsPageState();
}

class _NetworkDiagnosticsPageState
    extends ConsumerState<NetworkDiagnosticsPage> {
  /// Lets debounced provider listeners (config updates) act on the state a
  /// fix changed before the next run samples the OS again.
  static const _fixSettleDelay = Duration(seconds: 1);

  final _checks = <NetworkDiagnosticCheck>[];
  CancelToken? _token;
  bool _running = false;
  bool _canceled = false;
  bool _fixing = false;
  DateTime? _started;

  bool get _busy => _running || _fixing;

  @override
  void initState() {
    super.initState();
    ref.listenManual(networkDiagnosticSnapshotProvider, (_, _) {
      if (_running && mounted) {
        _token?.cancel();
        setState(() => _canceled = true);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) unawaited(_run());
    });
  }

  @override
  void dispose() {
    _token?.cancel();
    super.dispose();
  }

  Future<void> _run() async {
    if (_busy) return;
    // The applied-profile part of the snapshot is not reactive; rebuild it
    // before marking the run active so this refresh cannot cancel the run.
    ref.invalidate(networkDiagnosticSnapshotProvider);
    final snapshot = ref.read(networkDiagnosticSnapshotProvider);
    final token = CancelToken();
    _token = token;
    setState(() {
      _checks.clear();
      _running = true;
      _canceled = false;
      _started = DateTime.now();
    });
    try {
      await ref
          .read(networkDiagnosticServiceProvider)
          .run(
            snapshot,
            token,
            onResult: (check) {
              if (mounted && !token.isCancelled) {
                setState(() => _checks.add(check));
              }
            },
          );
    } catch (_) {
      if (mounted && !token.isCancelled) {
        setState(
          () => _checks.add(
            NetworkDiagnosticCheck(
              'unavailable',
              context.appLocalizations.diagTitle,
              DiagnosticStatus.unknown,
              context.appLocalizations.diagUnknown,
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _running = false);
    }
  }

  Future<void> _fix(DiagnosticFix fix) async {
    if (_busy) return;
    setState(() => _fixing = true);
    var applied = false;
    try {
      await ref.read(networkDiagnosticFixHandlerProvider)(fix);
      applied = true;
    } catch (error) {
      commonPrint.log(
        'network diagnostic fix ${fix.name} failed: $error',
        logLevel: LogLevel.warning,
      );
      if (mounted) context.showNotifier(context.appLocalizations.diagFixFailed);
    }
    if (applied) {
      await _settleSystemProxy();
      await Future<void>.delayed(_fixSettleDelay);
    }
    if (!mounted) return;
    setState(() => _fixing = false);
    // Re-check either way: a failed fix may still have changed the state.
    await _run();
  }

  String _status(DiagnosticStatus status) => switch (status) {
    DiagnosticStatus.passed => context.appLocalizations.diagPassed,
    DiagnosticStatus.warning => context.appLocalizations.diagWarning,
    DiagnosticStatus.failed => context.appLocalizations.diagFailed,
    DiagnosticStatus.unknown => context.appLocalizations.diagUnknown,
    DiagnosticStatus.skipped => context.appLocalizations.diagSkipped,
  };

  String _fixLabel(DiagnosticFix fix) {
    final l = context.appLocalizations;
    return switch (fix) {
      DiagnosticFix.applyProfile => l.diagFixApplyProfile,
      DiagnosticFix.startConnection => l.diagFixStart,
      DiagnosticFix.restartCore => l.diagFixRestartCore,
      DiagnosticFix.restartConnection => l.diagFixRestartConnection,
      DiagnosticFix.applySystemProxy => l.diagFixSystemProxy,
      DiagnosticFix.enableSystemProxy => l.diagFixEnableSystemProxy,
      DiagnosticFix.applyTun => l.diagFixTun,
      DiagnosticFix.retestProxies => l.diagFixRetest,
    };
  }

  String _report() => [
    '${ref.read(networkDiagnosticReportHeaderProvider)} — ${context.appLocalizations.diagTitle}',
    _started?.toIso8601String() ?? '',
    if (_canceled) context.appLocalizations.diagCanceled,
    context.appLocalizations.diagScope,
    for (final check in _checks) ...[
      '\n[${_status(check.status)}] ${check.title}',
      check.detail,
      if (check.suggestion != null) check.suggestion!,
    ],
  ].join('\n');

  @override
  Widget build(BuildContext context) {
    final l = context.appLocalizations;
    return CommonScaffold(
      title: l.diagTitle,
      actions: [
        IconButton(
          tooltip: l.diagCopy,
          onPressed: _checks.isEmpty || _busy
              ? null
              : () async {
                  await Clipboard.setData(ClipboardData(text: _report()));
                  if (context.mounted) context.showNotifier(l.copySuccess);
                },
          icon: const Icon(Icons.copy),
        ),
      ],
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l.diagScope),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton.icon(
                onPressed: _busy ? null : _run,
                icon: const Icon(Icons.network_check),
                label: Text(l.diagRun),
              ),
              if (_running)
                OutlinedButton(
                  onPressed: () {
                    _token?.cancel();
                    setState(() {
                      _canceled = true;
                    });
                  },
                  child: Text(l.cancel),
                ),
            ],
          ),
          const SizedBox(height: 12),
          if (_busy) const LinearProgressIndicator(),
          if (_fixing)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(l.diagFixing),
            ),
          if (_canceled)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(l.diagCanceled),
            ),
          for (final check in _checks)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          switch (check.status) {
                            DiagnosticStatus.passed =>
                              Icons.check_circle_outline,
                            DiagnosticStatus.failed => Icons.error_outline,
                            DiagnosticStatus.warning => Icons.warning_amber,
                            _ => Icons.help_outline,
                          },
                          color: switch (check.status) {
                            DiagnosticStatus.passed => Colors.green,
                            DiagnosticStatus.failed =>
                              context.colorScheme.error,
                            DiagnosticStatus.warning => Colors.orange,
                            _ => context.colorScheme.onSurfaceVariant,
                          },
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${check.title} · ${_status(check.status)}',
                            style: context.textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SelectableText(check.detail),
                    if (check.suggestion != null) ...[
                      const SizedBox(height: 8),
                      Text(check.suggestion!),
                    ],
                    if (check.fix case final fix?) ...[
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FilledButton.tonalIcon(
                          onPressed: _busy ? null : () => _fix(fix),
                          icon: const Icon(Icons.auto_fix_high),
                          label: Text(_fixLabel(fix)),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

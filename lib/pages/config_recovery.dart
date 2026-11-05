import 'dart:developer' as developer;

import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/services/config_key_store.dart';
import 'package:material_ui/material_ui.dart';

class ConfigRecoveryScreen extends StatefulWidget {
  final Future<void> Function() onRetry;
  final VoidCallback? onExit;
  final Future<String> Function()? onReset;
  final ConfigRecoveryReason? initialReason;

  const ConfigRecoveryScreen({
    super.key,
    required this.onRetry,
    this.onExit,
    this.onReset,
    this.initialReason,
  });

  @override
  State<ConfigRecoveryScreen> createState() => _ConfigRecoveryScreenState();
}

class _ConfigRecoveryScreenState extends State<ConfigRecoveryScreen> {
  bool _isRetrying = false;
  bool _isConfirming = false;
  bool get _busy => _isRetrying || _isConfirming;
  bool _resetRequested = false;
  bool _resetFailed = false;
  String? _backupPath;
  late ConfigRecoveryReason? _reason = widget.initialReason;

  Future<void> _reset() async {
    if (_busy || _backupPath != null) return;
    final localizations = AppLocalizations.of(context);
    if (!_resetRequested) {
      // Lock every action while the confirmation dialog is open too.
      setState(() => _isConfirming = true);
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(localizations.configRecoveryReset),
          content: Text(localizations.configRecoveryResetConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(localizations.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(localizations.configRecoveryReset),
            ),
          ],
        ),
      );
      if (!mounted) return;
      setState(() => _isConfirming = false);
      if (confirmed != true) return;
    }
    setState(() {
      _isRetrying = true;
      _resetRequested = true;
      _resetFailed = false;
    });
    try {
      final backupPath = await widget.onReset!();
      if (mounted) setState(() => _backupPath = backupPath);
    } catch (error) {
      developer.log(
        'Configuration reset failed (${error.runtimeType}).',
        name: 'ConfigRecoveryScreen',
      );
      if (mounted) setState(() => _resetFailed = true);
    } finally {
      if (mounted) setState(() => _isRetrying = false);
    }
  }

  String _guidance(AppLocalizations localizations) {
    if (_backupPath != null) return localizations.configRecoveryResetDone;
    if (_resetFailed) return localizations.configRecoveryResetFailed;
    return switch (_reason) {
      ConfigRecoveryReason.missingKey => localizations.configRecoveryMissingKey,
      ConfigRecoveryReason.unreadableConfig =>
        localizations.configRecoveryUnreadable,
      ConfigRecoveryReason.storageUnavailable =>
        localizations.configRecoveryStorage,
      null => localizations.configRecoveryMessage,
    };
  }

  Future<void> _retry() async {
    if (_busy || _resetRequested) return;
    setState(() => _isRetrying = true);
    try {
      await widget.onRetry();
    } catch (error) {
      if (mounted && error is ConfigKeyUnavailableException) {
        setState(() => _reason = error.reason);
      }
      // Error messages may contain configuration data; log only the type.
      developer.log(
        'Local configuration recovery is still unavailable (${error.runtimeType}).',
        name: 'ConfigRecoveryScreen',
      );
    } finally {
      if (mounted) setState(() => _isRetrying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    localizations.configRecoveryTitle,
                    style: theme.textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _guidance(localizations),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (_backupPath != null) ...[
                    const SizedBox(height: 16),
                    SelectableText(_backupPath!, textAlign: TextAlign.center),
                  ],
                  const SizedBox(height: 24),
                  if (!_resetRequested)
                    FilledButton.icon(
                      onPressed: _busy ? null : _retry,
                      icon: _isRetrying
                          ? SizedBox.square(
                              dimension: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                semanticsLabel: localizations.loading,
                              ),
                            )
                          : const Icon(Icons.refresh_rounded),
                      label: Text(localizations.configRecoveryRetry),
                    ),
                  if (widget.onReset != null && _backupPath == null) ...[
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: _busy ? null : _reset,
                      icon: _isRetrying && _resetRequested
                          ? const SizedBox.square(
                              dimension: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.settings_backup_restore),
                      label: Text(localizations.configRecoveryReset),
                    ),
                  ],
                  if (widget.onExit != null) ...[
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: _busy ? null : widget.onExit,
                      child: Text(localizations.exit),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

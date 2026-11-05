import 'dart:developer' as developer;

import 'package:fl_clash/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ConfigRecoveryScreen extends StatefulWidget {
  final Future<void> Function() onRetry;
  final VoidCallback? onExit;

  const ConfigRecoveryScreen({super.key, required this.onRetry, this.onExit});

  @override
  State<ConfigRecoveryScreen> createState() => _ConfigRecoveryScreenState();
}

class _ConfigRecoveryScreenState extends State<ConfigRecoveryScreen> {
  bool _isRetrying = false;

  Future<void> _retry() async {
    if (_isRetrying) return;
    setState(() => _isRetrying = true);
    try {
      await widget.onRetry();
    } catch (error) {
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
                    localizations.configRecoveryMessage,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: _isRetrying ? null : _retry,
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
                  if (widget.onExit != null) ...[
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: _isRetrying ? null : widget.onExit,
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

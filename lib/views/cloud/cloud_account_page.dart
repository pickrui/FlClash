import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'cloud_login_page.dart';
import 'cloud_profile_card.dart';

class CloudAccountPage extends ConsumerStatefulWidget {
  const CloudAccountPage({super.key});

  @override
  ConsumerState<CloudAccountPage> createState() => _CloudAccountPageState();
}

class _CloudAccountPageState extends ConsumerState<CloudAccountPage> {
  var _serviceStatus = _ServiceStatus.unknown;
  var _isCheckingService = false;
  var _hasAutoChecked = false;
  var _isOverseasSaving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasAutoChecked) {
        _hasAutoChecked = true;
        _checkServiceStatus();
      }
    });
  }

  Future<void> _checkServiceStatus() async {
    if (_isCheckingService) return;

    setState(() {
      _isCheckingService = true;
      _serviceStatus = _ServiceStatus.checking;
    });

    try {
      final error = await CloudApiService().checkServiceHealth();
      if (mounted) {
        setState(() {
          _serviceStatus = error == null
              ? _ServiceStatus.available
              : _ServiceStatus.unavailable;
          _isCheckingService = false;
        });

        if (error != null) {
          globalState.showMessage(
            title: AppLocalizations.current.serviceCheckFailed,
            message: TextSpan(text: error),
          );
        }
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _serviceStatus = _ServiceStatus.unavailable;
          _isCheckingService = false;
        });
      }
    }
  }

  Future<void> _handleRefresh() async {
    await ref.read(cloudAccountProvider.notifier).refreshProfile(force: true);
    if (mounted) {
      globalState.showNotifier(AppLocalizations.current.refreshSuccess);
    }
  }

  Future<void> _handleOverseasNetworkChanged(bool value) async {
    if (_isOverseasSaving) return;
    
    setState(() {
      _isOverseasSaving = true;
    });

    try {
      final notifier = ref.read(cloudAccountProvider.notifier);
      if (value) {
        await notifier.saveAndEnableOverseasNetwork();
      } else {
        await notifier.disableOverseasNetwork();
      }
    } finally {
      if (mounted) {
        setState(() {
          _isOverseasSaving = false;
        });
      }
    }
  }

  void _showLoginDialog() {
    showDialog(context: context, builder: (_) => const CloudLoginPage());
  }

  Future<void> _handleLogout() async {
    bool revokeToken = false;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(AppLocalizations.current.logoutTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.current.logoutContent),
              const SizedBox(height: 16),
              CheckboxListTile(
                value: revokeToken,
                onChanged: (value) {
                  setState(() {
                    revokeToken = value ?? false;
                  });
                },
                title: Text(AppLocalizations.current.revokeAccessToken),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(AppLocalizations.current.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(AppLocalizations.current.confirm),
            ),
          ],
        ),
      ),
    );

    if (confirmed == true) {
      await ref
          .read(cloudAccountProvider.notifier)
          .signOut(revokeToken: revokeToken);
      if (mounted) {
        globalState.showNotifier(AppLocalizations.current.logoutSuccess);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(currentPageLabelProvider, (prev, next) {
      if (prev != next && next == PageLabel.oixCloud) {
        ref.read(cloudAccountProvider.notifier).refreshProfile();
      }
    });

    final accountState = ref.watch(cloudAccountProvider);

    return CommonScaffold(
      title: AppLocalizations.current.loggedOutViewTitle,
      actions: [
        _buildServiceStatusButton(),
        if (accountState.isLoggedIn) ...[
          IconButton(
            icon: accountState.isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh),
            onPressed: accountState.isLoading ? null : _handleRefresh,
            tooltip: AppLocalizations.current.sync,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _handleLogout,
            tooltip: AppLocalizations.current.logoutTitle,
          ),
        ],
      ],
      body: accountState.isLoggedIn
          ? _buildLoggedInView(accountState)
          : _buildNotLoggedInView(),
    );
  }

  Widget _buildServiceStatusButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Tooltip(
        message: switch (_serviceStatus) {
          _ServiceStatus.available => AppLocalizations.current.apiAvailable,
          _ServiceStatus.checking => AppLocalizations.current.checking,
          _ServiceStatus.unavailable => AppLocalizations.current.apiUnavailable,
          _ServiceStatus.unknown => AppLocalizations.current.checkApi,
        },
        child: FadeScaleBox(
          alignment: Alignment.centerRight,
          child: _serviceStatus == _ServiceStatus.available
              ? IconButton.filled(
                  visualDensity: VisualDensity.compact,
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    foregroundColor: switch (Theme.brightnessOf(context)) {
                      Brightness.light => context.colorScheme.onSurfaceVariant,
                      Brightness.dark =>
                        context.colorScheme.onPrimaryFixedVariant,
                    },
                  ),
                  onPressed: _checkServiceStatus,
                  icon: const Icon(Icons.check, weight: 900),
                )
              : FilledButton.icon(
                  key: ValueKey(_serviceStatus),
                  onPressed: _checkServiceStatus,
                  style: FilledButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    backgroundColor: switch (_serviceStatus) {
                      _ServiceStatus.checking => null,
                      _ServiceStatus.unavailable => context.colorScheme.error,
                      _ServiceStatus.unknown => null,
                      _ServiceStatus.available => Colors.greenAccent,
                    },
                    foregroundColor: switch (_serviceStatus) {
                      _ServiceStatus.checking => null,
                      _ServiceStatus.unavailable => context.colorScheme.onError,
                      _ServiceStatus.unknown => null,
                      _ServiceStatus.available => switch (Theme.brightnessOf(
                        context,
                      )) {
                        Brightness.light =>
                          context.colorScheme.onSurfaceVariant,
                        Brightness.dark => null,
                      },
                    },
                  ),
                  icon: SizedBox(
                    height: globalState.measure.bodyMediumHeight,
                    width: globalState.measure.bodyMediumHeight,
                    child: switch (_serviceStatus) {
                      _ServiceStatus.checking => Padding(
                        padding: const EdgeInsets.all(2),
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: context.colorScheme.onPrimary,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      _ServiceStatus.available => const Icon(
                        Icons.check_sharp,
                        weight: 900,
                      ),
                      _ServiceStatus.unavailable => const Icon(
                        Icons.error_outline,
                        weight: 900,
                      ),
                      _ServiceStatus.unknown => const SizedBox.shrink(),
                    },
                  ),
                  label: Text(switch (_serviceStatus) {
                    _ServiceStatus.checking =>
                      AppLocalizations.current.checking,
                    _ServiceStatus.available =>
                      AppLocalizations.current.apiAvailable,
                    _ServiceStatus.unavailable =>
                      AppLocalizations.current.apiUnavailable,
                    _ServiceStatus.unknown => AppLocalizations.current.checkApi,
                  }),
                ),
        ),
      ),
    );
  }

  Widget _buildNotLoggedInView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_off_outlined,
            size: 80,
            color: context.colorScheme.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.current.loggedOutViewTitle,
            style: context.textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.current.loggedOutViewDesc,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: _showLoginDialog,
            icon: const Icon(Icons.login),
            label: Text(AppLocalizations.current.loginTitle),
          ),
        ],
      ),
    );
  }

  Widget _buildLoggedInView(CloudAccountState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (state.profile != null) CloudProfileCard(profile: state.profile!),
          const SizedBox(height: 16),
          if (state.profile != null)
            Consumer(
              builder: (_, ref, _) {
                final subscription = state.profile?.subscription;
                final shouldShowOverseas = subscription != null &&
                    subscription.isNotEmpty &&
                    subscription != 'Pass Iron' &&
                    subscription != 'null';

                if (!shouldShowOverseas) {
                  return const SizedBox.shrink();
                }

                return FutureBuilder<Map<String, String>?>(
                  future: ref
                      .read(cloudAccountProvider.notifier)
                      .getSavedParams(),
                  builder: (context, snapshot) {
                    final params = snapshot.data;
                    final isOverseasEnabled =
                        params != null && params['lv'] == '1' && params.length == 1;

                    return AnimatedOpacity(
                      opacity: _isOverseasSaving ? 0.7 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOutCubic,
                      child: CommonCard(
                        child: ListTile(
                          title: Text(AppLocalizations.current.overseasNetwork),
                          subtitle: Text(
                            AppLocalizations.current.overseasNetworkDesc,
                            style: TextStyle(
                              fontSize: 12,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          trailing: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            child: _isOverseasSaving
                                ? SizedBox(
                                    key: const ValueKey('loading'),
                                    width: 56,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          context.colorScheme.primary,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    key: const ValueKey('switch'),
                                    width: 56,
                                    child: Switch(
                                      value: isOverseasEnabled,
                                      onChanged: _handleOverseasNetworkChanged,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          const SizedBox(height: 16),
          if (state.latestNotification != null)
            _buildNotificationCard(state.latestNotification!),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(CloudNotification notification) {
    return CommonCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.notifications, color: context.colorScheme.primary),
                const SizedBox(width: 12),
                Text(
                  AppLocalizations.current.announcement,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              notification.cleanMessage,
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Text(
              DateFormat.yMMMd().format(notification.publishTime),
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _ServiceStatus { unknown, checking, available, unavailable }

import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cloud_layout.dart';
import 'cloud_profile_card.dart';
import 'cloud_register_page.dart';

/// Bound at startup, so the navigation barrel that carries this page does not
/// also compile the whole store.
WidgetBuilder? cloudStorePageBuilder;

final cloudServiceHealthCheckProvider = Provider<Future<void> Function()>(
  (ref) => CloudApiService().checkServiceHealth,
);

class CloudAccountPage extends ConsumerStatefulWidget {
  const CloudAccountPage({super.key});

  @override
  ConsumerState<CloudAccountPage> createState() => _CloudAccountPageState();
}

class _CloudAccountPageState extends ConsumerState<CloudAccountPage> {
  /// One retry: enough to ride out a resume, still quick to report a real outage.
  static const _healthCheckAttempts = 2;
  static const _healthCheckRetryDelay = Duration(seconds: 1);

  var _isCheckingService = false;
  var _healthCheckPending = false;
  Object? _serviceError;
  bool _serviceCheckUsedTlsException = false;
  bool _checkedStatus = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkHealth();
    });

    // If the page comes to view, attempt to refresh profile if logged in
    ref.listenManual(currentPageLabelProvider, (prev, next) {
      if (prev != next && next == PageLabel.oixCloud) {
        _checkHealth();
        ref.read(cloudAccountProvider.notifier).refreshProfile();
      }
    });
  }

  Future<void> _checkHealth({Object? certificateError}) async {
    if (!mounted) return;
    if (_isCheckingService) {
      if (certificateError == null) _healthCheckPending = true;
      return;
    }
    setState(() => _isCheckingService = true);
    try {
      final service = CloudApiService();
      if (certificateError != null) {
        final allow = await service.confirmInsecureTlsRetry(certificateError);
        if (!allow || !mounted) return;
      }
      setState(() {
        _serviceError = null;
        _serviceCheckUsedTlsException = false;
      });
      Object? error;
      for (var attempt = 0; attempt < _healthCheckAttempts; attempt++) {
        try {
          final check = ref.read(cloudServiceHealthCheckProvider);
          if (certificateError != null) {
            await service.runWithInsecureTls(certificateError, check);
          } else {
            await check();
          }
          error = null;
          break;
        } catch (e) {
          error = e;
        }
        if (!mounted) return;
        if (certificateError != null ||
            CloudApiException.isCertificateVerifyFailed(error)) {
          break;
        }
        if (attempt < _healthCheckAttempts - 1) {
          await Future<void>.delayed(_healthCheckRetryDelay);
          if (!mounted) return;
        }
      }
      if (mounted) {
        setState(() {
          _serviceError = error;
          _serviceCheckUsedTlsException =
              certificateError != null && error == null;
          _checkedStatus = true;
        });
      }
    } finally {
      if (mounted) {
        setState(() => _isCheckingService = false);
        if (_healthCheckPending) {
          _healthCheckPending = false;
          await _checkHealth();
        }
      }
    }
  }

  String? get _serviceWarning {
    if (_serviceError case final error?) {
      return '${AppLocalizations.current.serviceCheckFailed}: ${CloudApiException.clean(error)}';
    }
    return _serviceCheckUsedTlsException
        ? AppLocalizations.current.apiAvailableWithCertificateException
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final accountState = ref.watch(cloudAccountProvider);
    final accountBusy =
        accountState.isLoading ||
        accountState.isRefreshing ||
        accountState.isSyncing;

    final serviceError = _serviceError;
    final serviceWarning = _serviceWarning;
    final canRetryCertificate =
        serviceError != null &&
        CloudApiException.certificateFailure(serviceError) != null;

    return CommonScaffold(
      title: AppLocalizations.current.loggedOutViewTitle, // oixCloud title text
      actions: [
        _buildHealthButton(),
        if (accountState.isLoggedIn) ...[
          IconButton(
            icon: accountState.isRefreshing
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh),
            tooltip: AppLocalizations.current.refresh,
            onPressed: accountBusy
                ? null
                : () => ref
                      .read(cloudAccountProvider.notifier)
                      .refreshProfile(force: true),
          ),
          IconButton(
            icon: accountState.isSyncing
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.sync_alt),
            tooltip: AppLocalizations.current.sync,
            onPressed: accountBusy
                ? null
                : () => ref
                      .read(cloudAccountProvider.notifier)
                      .refreshManagedSubscription(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: AppLocalizations.current.logoutTitle,
            onPressed: accountBusy ? null : _handleLogout,
          ),
        ],
      ],
      body: Column(
        children: [
          if (serviceWarning != null)
            MaterialBanner(
              leading: Icon(
                serviceError != null
                    ? Icons.error_outline
                    : Icons.warning_amber,
                color: serviceError != null
                    ? context.colorScheme.error
                    : Colors.orange,
              ),
              content: Text(serviceWarning),
              actions: [
                if (canRetryCertificate)
                  TextButton(
                    onPressed: _isCheckingService
                        ? null
                        : () => _checkHealth(certificateError: serviceError),
                    child: Text(
                      AppLocalizations
                          .current
                          .retryWithoutCertificateVerification,
                    ),
                  ),
                TextButton(
                  onPressed: _isCheckingService ? null : _checkHealth,
                  child: Text(AppLocalizations.current.checkApi),
                ),
              ],
            ),
          Expanded(
            child: accountState.isLoggedIn
                ? _buildLoggedIn(accountState)
                : _buildLoggedOut(),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthButton() {
    IconData icon;
    Color color;
    if (!_checkedStatus) {
      icon = Icons.help_outline;
      color = Colors.grey;
    } else if (_serviceCheckUsedTlsException) {
      icon = Icons.warning_amber;
      color = Colors.orange;
    } else if (_serviceError == null) {
      icon = Icons.check_circle;
      color = Colors.green;
    } else {
      icon = Icons.error;
      color = Colors.red;
    }

    final String tooltip;
    if (_isCheckingService || !_checkedStatus) {
      tooltip = AppLocalizations.current.checkApi;
    } else {
      tooltip = _serviceWarning ?? AppLocalizations.current.apiAvailable;
    }

    return IconButton(
      icon: _isCheckingService && _serviceError == null
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(icon, color: color),
      onPressed: _isCheckingService ? null : _checkHealth,
      tooltip: tooltip,
    );
  }

  Widget _buildLoggedIn(CloudAccountState state) {
    final busy = state.isLoading || state.isRefreshing || state.isSyncing;
    final notifier = ref.read(cloudAccountProvider.notifier);
    final profile = state.profile;
    if (profile == null) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: busy
              ? const CircularProgressIndicator()
              : ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 360),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.cloud_off,
                        size: 40,
                        color: context.colorScheme.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.error ?? AppLocalizations.current.noInfo,
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonalIcon(
                            icon: const Icon(Icons.refresh),
                            label: Text(AppLocalizations.current.refresh),
                            onPressed: () =>
                                notifier.refreshProfile(force: true),
                          ),
                          OutlinedButton.icon(
                            icon: const Icon(Icons.logout),
                            label: Text(AppLocalizations.current.logoutTitle),
                            onPressed: _handleLogout,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () => notifier.refreshProfile(force: true),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: CloudContentWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (state.error case final error?) ...[
                CommonCard(
                  isError: true,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: context.colorScheme.error,
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(error)),
                        IconButton(
                          onPressed: busy
                              ? null
                              : () => notifier.refreshManagedSubscription(),
                          icon: const Icon(Icons.refresh),
                          tooltip: AppLocalizations.current.refresh,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              CloudProfileCard(profile: profile),
              const SizedBox(height: 16),
              _buildStoreEntry(),
              if (state.latestNotification case final notice?
                  when notice.cleanMessage.isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildAnnouncement(notice),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoreEntry() {
    final storePage = cloudStorePageBuilder;
    return CommonCard(
      onPressed: storePage == null
          ? null
          : () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: storePage)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CloudIconTile(icon: Icons.storefront),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.current.store,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    AppLocalizations.current.storeSubtitle,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: context.colorScheme.outline),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncement(CloudNotification notice) {
    return CommonCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.campaign, color: context.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.current.announcement,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                Text(
                  DateFormat('yyyy-MM-dd').format(notice.publishTime),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildAnnouncementBody(context, notice.cleanMessage),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementBody(BuildContext context, String message) {
    return SelectionArea(
      child: Html(
        data: message,
        onLinkTap: (url, attributes, element) {
          if (url != null) launchUrl(Uri.parse(url));
        },
        style: {
          // The card is a disabled button, so inherited text would take its dimmed foreground.
          'body': Style(
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
            color: context.colorScheme.onSurface,
            lineHeight: const LineHeight(1.5),
          ),
          'p': Style(margin: Margins.only(top: 0, bottom: 8)),
          'hr': Style(
            margin: Margins.only(top: 8, bottom: 8),
            padding: HtmlPaddings.zero,
            height: Height(1),
          ),
          'a': Style(color: context.colorScheme.primary),
          'img': Style(width: Width(100, Unit.percent)),
        },
      ),
    );
  }

  Widget _buildLoggedOut() {
    final commonAction = context.commonAction;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.cloud_outlined,
                size: 80,
                color: context.colorScheme.primary.withValues(alpha: 0.6),
              ),
              const SizedBox(height: 24),
              Text(
                AppLocalizations.current.loggedOutViewTitle,
                style: context.textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(
                AppLocalizations.current.loggedOutViewDesc,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 32),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  FilledButton.icon(
                    onPressed: () =>
                        commonAction.openCloudLogin(navigateToCloud: false),
                    icon: const Icon(Icons.login),
                    label: Text(AppLocalizations.current.loginTitle),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => showCloudRegisterPage(context),
                    icon: const Icon(Icons.person_add_alt_1_outlined),
                    label: Text(AppLocalizations.current.register),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogout() async {
    final choice = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.current.logoutTitle),
        content: Text(AppLocalizations.current.logoutContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.current.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppLocalizations.current.logoutTitle),
          ),
        ],
      ),
    );
    if (!mounted) return;
    if (choice != true) return;
    final success = await ref.read(cloudAccountProvider.notifier).signOut();
    if (!mounted) return;
    if (!success) {
      final error = ref.read(cloudAccountProvider).error;
      globalState.showMessage(
        title: AppLocalizations.current.operationFailed,
        message: TextSpan(
          text: error ?? AppLocalizations.current.operationFailed,
        ),
      );
    }
  }
}

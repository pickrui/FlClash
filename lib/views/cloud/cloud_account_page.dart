import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cloud_profile_card.dart';
import 'cloud_register_page.dart';
import 'store_page.dart';

enum _LogoutChoice { localOnly, deleteToken }

class CloudAccountPage extends ConsumerStatefulWidget {
  const CloudAccountPage({super.key});

  @override
  ConsumerState<CloudAccountPage> createState() => _CloudAccountPageState();
}

class _CloudAccountPageState extends ConsumerState<CloudAccountPage> {
  var _isCheckingService = false;
  String? _serviceError;
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
        ref.read(cloudAccountProvider.notifier).refreshProfile();
      }
    });
  }

  Future<void> _checkHealth() async {
    if (_isCheckingService) return;
    setState(() {
      _isCheckingService = true;
      _serviceError = null;
    });

    String? error;
    try {
      await CloudApiService().checkServiceHealth();
    } catch (e) {
      error = CloudApiException.clean(e);
    }

    if (mounted) {
      setState(() {
        _isCheckingService = false;
        _serviceError = error;
        _checkedStatus = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final accountState = ref.watch(cloudAccountProvider);
    final accountBusy =
        accountState.isLoading ||
        accountState.isRefreshing ||
        accountState.isSyncing;

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
      body: accountState.isLoggedIn
          ? _buildLoggedIn(accountState)
          : _buildLoggedOut(),
    );
  }

  Widget _buildHealthButton() {
    IconData icon;
    Color color;
    if (!_checkedStatus) {
      icon = Icons.help_outline;
      color = Colors.grey;
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
    } else if (_serviceError == null) {
      tooltip = AppLocalizations.current.apiAvailable;
    } else {
      tooltip = AppLocalizations.current.serviceCheckFailed;
    }

    return IconButton(
      icon: _isCheckingService
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(icon, color: color),
      onPressed: _checkHealth,
      tooltip: tooltip,
    );
  }

  Widget _buildLoggedIn(CloudAccountState state) {
    if (state.profile == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            TextButton.icon(
              icon: const Icon(Icons.refresh),
              label: Text(AppLocalizations.current.refresh),
              onPressed: () {
                ref
                    .read(cloudAccountProvider.notifier)
                    .refreshProfile(force: true);
              },
            ),
          ],
        ),
      );
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CloudProfileCard(profile: state.profile!),
          const SizedBox(height: 16),
          CommonCard(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const CloudStorePage()));
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(Icons.storefront, color: context.colorScheme.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.current.store,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
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
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
          if (state.latestNotification != null &&
              state.latestNotification!.cleanMessage.isNotEmpty) ...[
            const SizedBox(height: 16),
            CommonCard(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.campaign,
                          color: context.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppLocalizations.current.announcement,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        if (state.latestNotification?.publishTime != null)
                          Text(
                            DateFormat(
                              'yyyy-MM-dd',
                            ).format(state.latestNotification!.publishTime),
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildAnnouncementBody(
                      context,
                      state.latestNotification!.cleanMessage,
                    ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton.icon(
              onPressed:
                  state.isLoading || state.isRefreshing || state.isSyncing
                  ? null
                  : _handleDeleteAccount,
              icon: const Icon(Icons.person_remove_outlined),
              label: Text(AppLocalizations.current.deleteAccount),
              style: OutlinedButton.styleFrom(
                foregroundColor: context.colorScheme.error,
                side: BorderSide(color: context.colorScheme.error),
              ),
            ),
          ),
        ],
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
          'body': Style(margin: Margins.zero, padding: HtmlPaddings.zero),
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_off,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton.icon(
                onPressed: () =>
                    appController.openCloudLogin(navigateToCloud: false),
                icon: const Icon(Icons.login),
                label: Text(AppLocalizations.current.loginTitle),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () => showCloudRegisterPage(context),
                icon: const Icon(Icons.person_add_alt_1_outlined),
                label: Text(AppLocalizations.current.register),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogout() async {
    final choice = await showDialog<_LogoutChoice>(
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
            onPressed: () => Navigator.pop(context, _LogoutChoice.localOnly),
            child: Text(AppLocalizations.current.logoutLocalOnly),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, _LogoutChoice.deleteToken),
            child: Text(AppLocalizations.current.logoutAndDeleteToken),
          ),
        ],
      ),
    );
    if (!mounted) return;
    if (choice == null) return;
    final success = await ref
        .read(cloudAccountProvider.notifier)
        .signOut(revokeToken: choice == _LogoutChoice.deleteToken);
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

  Future<void> _handleDeleteAccount() async {
    final request = await showDialog<DeleteAccountRequest>(
      context: context,
      builder: (_) => const DeleteAccountDialog(),
    );
    if (!mounted) return;
    if (request == null) return;

    final success = await ref
        .read(cloudAccountProvider.notifier)
        .deleteAccount(
          password: request.password,
          twoFactorCode: request.twoFactorCode,
        );
    if (!mounted) return;
    if (success) {
      globalState.showNotifier(AppLocalizations.current.deleteAccountSuccess);
      return;
    }
    final error = ref.read(cloudAccountProvider).error;
    globalState.showMessage(
      title: AppLocalizations.current.deleteAccountFailed,
      message: TextSpan(
        text: error ?? AppLocalizations.current.deleteAccountFailed,
      ),
    );
  }
}

class DeleteAccountRequest {
  final String password;
  final String? twoFactorCode;

  const DeleteAccountRequest({required this.password, this.twoFactorCode});
}

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({super.key});

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  final _passwordController = TextEditingController();
  final _twoFactorController = TextEditingController();
  var _acknowledged = false;
  var _obscurePassword = true;

  bool get _canSubmit =>
      _acknowledged &&
      _passwordController.text.trim().isNotEmpty &&
      (_twoFactorController.text.isEmpty ||
          _twoFactorController.text.length == 6);

  @override
  void dispose() {
    _passwordController.dispose();
    _twoFactorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.current;
    return AlertDialog(
      title: Text(l10n.deleteAccount),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.deleteAccountWarning,
              style: TextStyle(color: context.colorScheme.error),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              autofocus: true,
              autocorrect: false,
              enableSuggestions: false,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: l10n.passwordLabel,
                suffixIcon: IconButton(
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _twoFactorController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: l10n.twoFactorCodeOptional,
              ),
            ),
            const SizedBox(height: 8),
            CheckboxListTile(
              value: _acknowledged,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(l10n.deleteAccountAcknowledgement),
              onChanged: (value) =>
                  setState(() => _acknowledged = value ?? false),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: _canSubmit
              ? () {
                  final twoFactorCode = _twoFactorController.text.trim();
                  Navigator.pop(
                    context,
                    DeleteAccountRequest(
                      password: _passwordController.text,
                      twoFactorCode: twoFactorCode.isEmpty
                          ? null
                          : twoFactorCode,
                    ),
                  );
                }
              : null,
          style: FilledButton.styleFrom(
            backgroundColor: context.colorScheme.error,
            foregroundColor: context.colorScheme.onError,
          ),
          child: Text(l10n.deleteAccount),
        ),
      ],
    );
  }
}

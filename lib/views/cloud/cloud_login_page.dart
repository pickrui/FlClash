import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<T?> showCloudLoginPage<T>(BuildContext context) {
  return showDialog<T>(
    context: context,
    builder: (_) => const CloudLoginPage(),
  );
}

class CloudLoginPage extends ConsumerStatefulWidget {
  const CloudLoginPage({super.key});

  @override
  ConsumerState<CloudLoginPage> createState() => _CloudLoginPageState();
}

class _CloudLoginPageState extends ConsumerState<CloudLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _tokenController = TextEditingController();

  var _loginMode = _LoginMode.token;
  var _obscurePassword = true;
  var _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _tokenController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_isSubmitting || ref.read(cloudAccountProvider).isLoading) {
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final navigator = Navigator.of(context);

    try {
      await _submitLogin();
      if (mounted) {
        // If existingProfiles.isEmpty, addProfileFormURL might have already popped.
        // We only pop if we're still effectively able to pop.
        navigator.popUntil((route) => route.isFirst);
      }
    } catch (error) {
      final retry = await CloudApiService().confirmInsecureTlsRetry(error);
      if (!retry) {
        _showLoginError(error);
        return;
      }

      try {
        await CloudApiService().runWithInsecureTls(_submitLogin);
        if (mounted) {
          navigator.popUntil((route) => route.isFirst);
        }
      } catch (retryError) {
        _showLoginError(retryError);
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      } else {
        _isSubmitting = false;
      }
    }
  }

  Future<void> _submitLogin() {
    final notifier = ref.read(cloudAccountProvider.notifier);
    switch (_loginMode) {
      case _LoginMode.emailPassword:
        return notifier.signInWithPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
      case _LoginMode.token:
        return notifier.signInWithToken(_tokenController.text.trim());
    }
  }

  void _showLoginError(Object error) {
    globalState.showMessage(
      title: AppLocalizations.current.loginFailed,
      message: TextSpan(text: CloudApiException.clean(error)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountState = ref.watch(cloudAccountProvider);
    final isLoading = accountState.isLoading || _isSubmitting;

    return Dialog(
      child: Container(
        width: 450,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.current.loginTitle,
              style: context.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SegmentedButton<_LoginMode>(
              selected: {_loginMode},
              onSelectionChanged: isLoading
                  ? null
                  : (v) => setState(() => _loginMode = v.first),
              segments: [
                ButtonSegment(
                  value: _LoginMode.token,
                  label: Text(AppLocalizations.current.accessToken),
                  icon: const Icon(Icons.key),
                ),
                ButtonSegment(
                  value: _LoginMode.emailPassword,
                  label: Text(AppLocalizations.current.emailPassword),
                  icon: const Icon(Icons.mail_outline),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: _loginMode == _LoginMode.emailPassword
                  ? _buildEmailPasswordForm(isLoading)
                  : _buildTokenForm(isLoading),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () => Navigator.of(context).pop(),
                  child: Text(AppLocalizations.current.cancel),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: isLoading ? null : _handleLogin,
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(AppLocalizations.current.loginTitle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailPasswordForm(bool isLoading) {
    return Column(
      children: [
        TextFormField(
          controller: _emailController,
          enabled: !isLoading,
          decoration: InputDecoration(
            labelText: AppLocalizations.current.emailLabel,
            prefixIcon: const Icon(Icons.mail_outline),
            border: const OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (v) => v?.isEmpty == true
              ? AppLocalizations.current.emailValidation
              : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _passwordController,
          enabled: !isLoading,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: AppLocalizations.current.passwordLabel,
            prefixIcon: const Icon(Icons.lock_outline),
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: isLoading
                  ? null
                  : () => setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          validator: (v) => v?.isEmpty == true
              ? AppLocalizations.current.passwordValidation
              : null,
        ),
      ],
    );
  }

  Widget _buildTokenForm(bool isLoading) {
    return TextFormField(
      controller: _tokenController,
      enabled: !isLoading,
      maxLines: _obscurePassword ? 1 : 4,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: AppLocalizations.current.tokenLabel,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: isLoading
              ? null
              : () => setState(() => _obscurePassword = !_obscurePassword),
        ),
      ),
      validator: (v) =>
          v?.isEmpty == true ? AppLocalizations.current.tokenValidation : null,
    );
  }
}

enum _LoginMode { emailPassword, token }

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/providers/cloud_account_provider.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _tokenController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(cloudAccountProvider.notifier);

    try {
      switch (_loginMode) {
        case _LoginMode.emailPassword:
          await notifier.signInWithPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
          break;

        case _LoginMode.token:
          await notifier.signInWithToken(_tokenController.text.trim());
          break;
      }

      if (mounted) {
        Navigator.of(context).pop();
        globalState.showNotifier(AppLocalizations.current.loginSuccess);
      }
    } catch (error) {
      if (mounted) {
        globalState.showMessage(
          title: AppLocalizations.current.loginFailed,
          message: TextSpan(text: error.toString()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final accountState = ref.watch(cloudAccountProvider);
    final isLoading = accountState.isLoading;

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
                  : (selection) {
                      setState(() {
                        _loginMode = selection.first;
                      });
                    },
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
            hintText: AppLocalizations.current.emailHint,
            prefixIcon: const Icon(Icons.mail_outline),
            border: const OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return AppLocalizations.current.emailValidation;
            }
            if (!value.contains('@')) {
              return AppLocalizations.current.emailFormatValidation;
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _passwordController,
          enabled: !isLoading,
          decoration: InputDecoration(
            labelText: AppLocalizations.current.passwordLabel,
            hintText: AppLocalizations.current.passwordHint,
            prefixIcon: const Icon(Icons.lock_outline),
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
          obscureText: _obscurePassword,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _handleLogin(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.current.passwordValidation;
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildTokenForm(bool isLoading) {
    return TextFormField(
      controller: _tokenController,
      enabled: !isLoading,
      decoration: InputDecoration(
        labelText: AppLocalizations.current.tokenLabel,
        alignLabelWithHint: true,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.all(16),
      ),
      style: context.textTheme.bodyMedium?.copyWith(fontFamily: 'monospace'),
      minLines: 5,
      maxLines: 10,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => _handleLogin(),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return AppLocalizations.current.tokenValidation;
        }
        return null;
      },
    );
  }
}

enum _LoginMode { emailPassword, token }

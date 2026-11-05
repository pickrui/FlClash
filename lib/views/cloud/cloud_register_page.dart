import 'dart:async';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<T?> showCloudRegisterPage<T>(BuildContext context) {
  return showDialog<T>(
    context: context,
    builder: (_) => const CloudRegisterPage(),
  );
}

class CloudRegisterPage extends ConsumerStatefulWidget {
  const CloudRegisterPage({super.key});

  @override
  ConsumerState<CloudRegisterPage> createState() => _CloudRegisterPageState();
}

class _CloudRegisterPageState extends ConsumerState<CloudRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _emailCodeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _inviteCodeController = TextEditingController();

  CloudRegisterConfig? _config;
  bool _loadingConfig = true;
  String? _configError;
  bool _isSubmitting = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _sendingCode = false;
  int _resendCountdown = 0;
  Timer? _resendTimer;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    _nicknameController.dispose();
    _emailController.dispose();
    _emailCodeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _inviteCodeController.dispose();
    super.dispose();
  }

  Future<void> _loadConfig() async {
    setState(() {
      _loadingConfig = true;
      _configError = null;
    });
    try {
      final config = await CloudApiService().fetchRegisterConfig();
      if (!mounted) return;
      setState(() {
        _config = config;
        _loadingConfig = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _configError = CloudApiException.clean(e);
        _loadingConfig = false;
      });
    }
  }

  void _startResendCountdown() {
    _resendTimer?.cancel();
    setState(() => _resendCountdown = 60);
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _resendCountdown--;
        if (_resendCountdown <= 0) {
          timer.cancel();
        }
      });
    });
  }

  Future<void> _sendEmailCode() async {
    if (_sendingCode || _resendCountdown > 0) return;
    final email = _emailController.text.trim();
    if (email.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      globalState.showNotifier(AppLocalizations.current.emailFormatValidation);
      return;
    }
    setState(() => _sendingCode = true);
    try {
      await CloudApiService().sendEmailVerify(email);
      globalState.showNotifier(AppLocalizations.current.codeSent);
      _startResendCountdown();
    } catch (e) {
      globalState.showMessage(
        title: AppLocalizations.current.registerFailed,
        message: TextSpan(text: CloudApiException.clean(e)),
      );
    } finally {
      if (mounted) setState(() => _sendingCode = false);
    }
  }

  Future<void> _handleRegister() async {
    if (_isSubmitting || ref.read(cloudAccountProvider).isLoading) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    final navigator = Navigator.of(context);
    try {
      await _submitRegister();
      if (mounted) navigator.popUntil((route) => route.isFirst);
    } catch (error) {
      final retry = await CloudApiService().confirmInsecureTlsRetry(error);
      if (!retry) {
        _showError(error);
        return;
      }
      try {
        await CloudApiService().runWithInsecureTls(_submitRegister);
        if (mounted) navigator.popUntil((route) => route.isFirst);
      } catch (retryError) {
        _showError(retryError);
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      } else {
        _isSubmitting = false;
      }
    }
  }

  Future<void> _submitRegister() {
    final config = _config;
    final invite = _inviteCodeController.text.trim();
    return ref.read(cloudAccountProvider.notifier).signUp(
          name: _nicknameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
          inviteCode: invite.isEmpty ? null : invite,
          emailCode: (config?.emailVerify ?? false)
              ? _emailCodeController.text.trim()
              : null,
        );
  }

  void _showError(Object error) {
    globalState.showMessage(
      title: AppLocalizations.current.registerFailed,
      message: TextSpan(text: CloudApiException.clean(error)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountState = ref.watch(cloudAccountProvider);
    final isLoading = accountState.isLoading || _isSubmitting;

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450, maxHeight: 640),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _buildContent(isLoading),
        ),
      ),
    );
  }

  Widget _buildContent(bool isLoading) {
    if (_loadingConfig) {
      return const SizedBox(
        height: 180,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (_configError != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.current.registerFailed,
            style: context.textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          Text(_configError!, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(AppLocalizations.current.cancel),
              ),
              const SizedBox(width: 12),
              FilledButton(
                onPressed: _loadConfig,
                child: Text(AppLocalizations.current.refresh),
              ),
            ],
          ),
        ],
      );
    }
    final config = _config!;
    if (!config.registerEnabled) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.current.registerTitle,
            style: context.textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.current.registerClosed,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.current.cancel),
            ),
          ),
        ],
      );
    }
    return _buildForm(config, isLoading);
  }

  Widget _buildForm(CloudRegisterConfig config, bool isLoading) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.current.registerTitle,
            style: context.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nicknameController,
                  enabled: !isLoading,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.current.nicknameLabel,
                    hintText: AppLocalizations.current.nicknameHint,
                    prefixIcon: const Icon(Icons.person_outline),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (v) => v?.trim().isEmpty == true
                      ? AppLocalizations.current.nicknameValidation
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  enabled: !isLoading,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.current.emailLabel,
                    hintText: AppLocalizations.current.emailHint,
                    prefixIcon: const Icon(Icons.mail_outline),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (v) {
                    final value = v?.trim() ?? '';
                    if (value.isEmpty) {
                      return AppLocalizations.current.emailValidation;
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return AppLocalizations.current.emailFormatValidation;
                    }
                    return null;
                  },
                ),
                if (config.emailVerify) ...[
                  const SizedBox(height: 16),
                  _buildEmailCodeField(isLoading),
                ],
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  enabled: !isLoading,
                  obscureText: _obscurePassword,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.current.passwordLabel,
                    helperText: AppLocalizations.current.passwordRuleHint,
                    helperMaxLines: 2,
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                    suffixIcon: VisibilityToggleButton(
                      obscureText: _obscurePassword,
                      onPressed: isLoading
                          ? null
                          : () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                    ),
                  ),
                  validator: (v) => v?.isEmpty == true
                      ? AppLocalizations.current.passwordValidation
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordController,
                  enabled: !isLoading,
                  obscureText: _obscureConfirmPassword,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.current.confirmPasswordLabel,
                    hintText: AppLocalizations.current.confirmPasswordHint,
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                    suffixIcon: VisibilityToggleButton(
                      obscureText: _obscureConfirmPassword,
                      onPressed: isLoading
                          ? null
                          : () => setState(
                              () => _obscureConfirmPassword =
                                  !_obscureConfirmPassword,
                            ),
                    ),
                  ),
                  validator: (v) {
                    if (v?.isEmpty == true) {
                      return AppLocalizations.current.confirmPasswordValidation;
                    }
                    if (v != _passwordController.text) {
                      return AppLocalizations.current.passwordMismatch;
                    }
                    return null;
                  },
                ),
                if (config.inviteRequired) ...[
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _inviteCodeController,
                    enabled: !isLoading,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.current.inviteCodeLabel,
                      hintText: AppLocalizations.current.inviteCodeHint,
                      prefixIcon:
                          const Icon(Icons.confirmation_number_outlined),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (v) => v?.trim().isEmpty == true
                        ? AppLocalizations.current.inviteCodeValidation
                        : null,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: isLoading ? null : _handleRegister,
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(AppLocalizations.current.register),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.current.haveAccountAlready),
              TextButton(
                onPressed:
                    isLoading ? null : () => Navigator.of(context).pop(),
                child: Text(AppLocalizations.current.goLogin),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmailCodeField(bool isLoading) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            controller: _emailCodeController,
            enabled: !isLoading,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: AppLocalizations.current.emailCodeLabel,
              hintText: AppLocalizations.current.emailCodeHint,
              prefixIcon: const Icon(Icons.verified_outlined),
              border: const OutlineInputBorder(),
            ),
            validator: (v) => v?.trim().isEmpty == true
                ? AppLocalizations.current.emailCodeValidation
                : null,
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          height: 56,
          child: OutlinedButton(
            onPressed: (isLoading || _sendingCode || _resendCountdown > 0)
                ? null
                : _sendEmailCode,
            child: _sendingCode
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    _resendCountdown > 0
                        ? AppLocalizations.current.resendCodeIn(_resendCountdown)
                        : AppLocalizations.current.sendCode,
                  ),
          ),
        ),
      ],
    );
  }
}

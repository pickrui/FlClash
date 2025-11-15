import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/dler_cloud.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DlerCloudLoginDialog extends ConsumerStatefulWidget {
  const DlerCloudLoginDialog({super.key});

  @override
  ConsumerState<DlerCloudLoginDialog> createState() =>
      _DlerCloudLoginDialogState();
}

class _DlerCloudLoginDialogState
    extends ConsumerState<DlerCloudLoginDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _tokenController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _useTokenLogin = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _tokenController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final accountNotifier = ref.read(dlerCloudAccountProvider.notifier);
      Result<DlerCloudLoginData> result;
      
      if (_useTokenLogin) {
        result = await accountNotifier.loginWithToken(
          token: _tokenController.text.trim(),
        );
      } else {
        result = await accountNotifier.login(
          email: _emailController.text.trim(),
          passwd: _passwordController.text,
        );
      }

      if (mounted) {
        if (result.type == ResultType.success) {
          Navigator.of(context).pop();
          context.showNotifier('登录成功');
        } else {
          globalState.showMessage(
            title: '登录失败',
            message: TextSpan(text: result.message),
          );
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('登录'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SegmentedButton<bool>(
                segments: const [
                  ButtonSegment<bool>(
                    value: false,
                    label: Text('邮箱/密码'),
                    icon: Icon(Icons.email),
                  ),
                  ButtonSegment<bool>(
                    value: true,
                    label: Text('Access Token'),
                    icon: Icon(Icons.vpn_key),
                  ),
                ],
                selected: {_useTokenLogin},
                onSelectionChanged: (Set<bool> newSelection) {
                  setState(() {
                    _useTokenLogin = newSelection.first;
                  });
                },
              ),
              const SizedBox(height: 16),
              
              if (_useTokenLogin) ...[
                TextFormField(
                  controller: _tokenController,
                  decoration: const InputDecoration(
                    labelText: 'Access Token',
                    hintText: '请输入 Access Token',
                    prefixIcon: Icon(Icons.vpn_key),
                  ),
                  textInputAction: TextInputAction.done,
                  enabled: !_isLoading,
                  maxLines: 3,
                  onFieldSubmitted: (_) => _handleLogin(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return '请输入 Access Token';
                    }
                    return null;
                  },
                ),
              ] else ...[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: '邮箱',
                    hintText: '请输入邮箱地址',
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  enabled: !_isLoading,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return '请输入邮箱';
                    }
                    if (!value.contains('@')) {
                      return '请输入有效的邮箱地址';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: '密码',
                    hintText: '请输入密码',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
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
                  enabled: !_isLoading,
                  onFieldSubmitted: (_) => _handleLogin(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入密码';
                    }
                    return null;
                  },
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _handleLogin,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('登录'),
        ),
      ],
    );
  }
}


import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/proxy_auth.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/dialog.dart';
import 'package:fl_clash/widgets/input.dart';
import 'package:fl_clash/widgets/list.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProxyAuthenticationItem extends ConsumerStatefulWidget {
  const ProxyAuthenticationItem({super.key});
  @override
  ConsumerState<ProxyAuthenticationItem> createState() =>
      _ProxyAuthenticationItemState();
}

class _ProxyAuthenticationItemState
    extends ConsumerState<ProxyAuthenticationItem> {
  bool _busy = false;

  Future<void> _toggle(AuthenticationProps current, bool enable) async {
    final setupAction = context.setupAction;

    setState(() => _busy = true);
    try {
      await setupAction.updateProxyAuthentication(
        enable
            ? enableProxyAuthentication(current)
            : current.copyWith(enable: false),
      );
    } catch (_) {
      if (mounted) {
        globalState.showNotifier(
          context.appLocalizations.authenticationApplyFailed,
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final setupAction = context.setupAction;

    final l = context.appLocalizations;
    final auth = ref.watch(
      networkSettingProvider.select((state) => state.authentication),
    );
    return Column(
      children: [
        ListItem.switchItem(
          leading: const Icon(Icons.key_outlined),
          title: Text(l.authentication),
          subtitle: Text(l.authenticationDesc),
          delegate: SwitchDelegate(
            value: auth.enable,
            onChanged: _busy ? null : (value) => _toggle(auth, value),
          ),
        ),
        if (auth.enable)
          ListItem(
            padding: const EdgeInsets.only(left: 56, right: 16),
            title: Text('${l.account} / ${l.password}'),
            subtitle: Text(auth.username),
            onTap: _busy
                ? null
                : () => globalState.showCommonDialog(
                    child: ProxyAuthenticationDialog(
                      value: auth,
                      onSave: setupAction.updateProxyAuthentication,
                    ),
                  ),
          ),
      ],
    );
  }
}

class ProxyAuthenticationDialog extends StatefulWidget {
  final AuthenticationProps value;
  final Future<void> Function(AuthenticationProps) onSave;
  const ProxyAuthenticationDialog({
    super.key,
    required this.value,
    required this.onSave,
  });
  @override
  State<ProxyAuthenticationDialog> createState() =>
      _ProxyAuthenticationDialogState();
}

class _ProxyAuthenticationDialogState extends State<ProxyAuthenticationDialog> {
  final _form = GlobalKey<FormState>();
  late final _username = TextEditingController(text: widget.value.username);
  late final _password = TextEditingController(text: widget.value.password);
  bool _obscure = true;
  bool _busy = false;
  bool _failed = false;

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    setState(() {
      _busy = true;
      _failed = false;
    });
    try {
      await widget.onSave(
        widget.value.copyWith(
          username: _username.text,
          password: _password.text,
        ),
      );
      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.appLocalizations;
    return PopScope(
      canPop: !_busy,
      child: CommonDialog(
        title: l.authentication,
        actions: [
          TextButton(
            onPressed: _busy ? null : () => Navigator.of(context).pop(),
            child: Text(l.cancel),
          ),
          FilledButton(onPressed: _busy ? null : _save, child: Text(l.save)),
        ],
        child: Form(
          key: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _username,
                enabled: !_busy,
                maxLength: 255,
                autocorrect: false,
                enableSuggestions: false,
                decoration: InputDecoration(labelText: l.account),
                validator: (value) =>
                    AuthenticationProps.validUsername(value ?? '')
                    ? null
                    : l.authenticationUsernameInvalid,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _password,
                enabled: !_busy,
                maxLength: 255,
                obscureText: _obscure,
                autocorrect: false,
                enableSuggestions: false,
                decoration: InputDecoration(
                  labelText: l.password,
                  suffixIcon: VisibilityToggleButton(
                    obscureText: _obscure,
                    onPressed: _busy
                        ? null
                        : () => setState(() => _obscure = !_obscure),
                  ),
                ),
                validator: (value) =>
                    AuthenticationProps.validPassword(value ?? '')
                    ? null
                    : l.authenticationPasswordInvalid,
              ),
              if (_failed)
                Text(
                  l.authenticationApplyFailed,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

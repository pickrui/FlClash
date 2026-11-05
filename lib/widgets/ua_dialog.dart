import 'package:fl_clash/common/input_limits.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/widgets/dialog.dart';
import 'package:fl_clash/widgets/list.dart';
import 'package:flutter/material.dart';

const _defaultUaValue = '';
const _customUaValue = '__custom_ua__';
const _presetUas = ['clash-verge/v2.4.2', 'ClashforWindows/0.19.23'];

class UaDialogResult {
  final String value;
  final bool isCustom;

  const UaDialogResult({required this.value, required this.isCustom});
}

class UaDialog extends StatefulWidget {
  final String? value;
  final String customValue;

  const UaDialog({super.key, this.value, required this.customValue});

  @override
  State<UaDialog> createState() => _UaDialogState();
}

class _UaDialogState extends State<UaDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _customController;
  final _customFocusNode = FocusNode();
  late String _groupValue;

  @override
  void initState() {
    super.initState();
    final value = widget.value ?? _defaultUaValue;
    _groupValue = _presetUas.contains(value) || value.isEmpty
        ? value
        : _customUaValue;
    _customController = TextEditingController(
      text: _groupValue == _customUaValue ? value : widget.customValue,
    );
  }

  void _handleChanged(String? value) {
    if (value == null) return;
    if (value == _customUaValue) {
      setState(() {
        _groupValue = value;
      });
      _customFocusNode.requestFocus();
      return;
    }
    Navigator.of(context).pop(UaDialogResult(value: value, isCustom: false));
  }

  void _handleSubmit() {
    if (_groupValue == _customUaValue &&
        _formKey.currentState?.validate() != true) {
      return;
    }
    Navigator.of(context).pop(
      UaDialogResult(
        value: _groupValue == _customUaValue
            ? _customController.text.trim()
            : _groupValue,
        isCustom: _groupValue == _customUaValue,
      ),
    );
  }

  @override
  void dispose() {
    _customController.dispose();
    _customFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return CommonDialog(
      title: appLocalizations.userAgent,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(appLocalizations.cancel),
        ),
        TextButton(
          onPressed: _handleSubmit,
          child: Text(appLocalizations.submit),
        ),
      ],
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: RadioGroup<String>(
          groupValue: _groupValue,
          onChanged: _handleChanged,
          child: Wrap(
            runSpacing: 8,
            children: [
              ListItem.radio(
                delegate: RadioDelegate(
                  value: _defaultUaValue,
                  onTap: () => _handleChanged(_defaultUaValue),
                ),
                title: Text(appLocalizations.defaultText),
              ),
              for (final ua in _presetUas)
                ListItem.radio(
                  delegate: RadioDelegate(
                    value: ua,
                    onTap: () => _handleChanged(ua),
                  ),
                  title: Text(ua),
                ),
              ListItem.radio(
                delegate: RadioDelegate(
                  value: _customUaValue,
                  onTap: () => _handleChanged(_customUaValue),
                ),
                title: Text(appLocalizations.customUserAgent),
              ),
              if (_groupValue == _customUaValue)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    autofocus: true,
                    focusNode: _customFocusNode,
                    maxLength: TextInputLimits.userAgent,
                    inputFormatters: TextInputLimits.limit(
                      TextInputLimits.userAgent,
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'User-Agent',
                      helper: Text(
                        appLocalizations.customUserAgentHint,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      counterText: '',
                    ),
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    enableSuggestions: false,
                    textInputAction: TextInputAction.done,
                    maxLines: 1,
                    controller: _customController,
                    onFieldSubmitted: (_) => _handleSubmit(),
                    errorBuilder: (_, error) => Text(error),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return appLocalizations.emptyTip(
                          appLocalizations.userAgent,
                        );
                      }
                      // Both Dart and the core send this value as an HTTP header.
                      if (value.trim().codeUnits.any(
                        (char) => char != 9 && (char < 32 || char > 126),
                      )) {
                        return appLocalizations.customUserAgentInvalid;
                      }
                      return null;
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

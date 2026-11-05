import 'package:fl_clash/common/input_limits.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/widgets/dialog.dart';
import 'package:flutter/material.dart';

class PortConflictDialog extends StatefulWidget {
  final int port;
  final Iterable<int> otherPorts;

  const PortConflictDialog({
    super.key,
    required this.port,
    required this.otherPorts,
  });

  @override
  State<PortConflictDialog> createState() => _PortConflictDialogState();
}

class _PortConflictDialogState extends State<PortConflictDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final text = widget.port.toString();
    _controller = TextEditingController.fromValue(
      TextEditingValue(
        text: text,
        selection: TextSelection(baseOffset: 0, extentOffset: text.length),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) return;
    Navigator.of(context).pop<int>(int.parse(_controller.text));
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return CommonDialog(
      title: localizations.portUnavailableTitle,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(localizations.cancel),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(localizations.saveAndRetry),
        ),
      ],
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(localizations.portUnavailableMessage(widget.port)),
            const SizedBox(height: 20),
            TextFormField(
              controller: _controller,
              autofocus: true,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              inputFormatters: TextInputLimits.digitsOnly(TextInputLimits.port),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: localizations.mixedPort,
                errorMaxLines: 3,
              ),
              onFieldSubmitted: (_) => _submit(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localizations.emptyTip(localizations.mixedPort);
                }
                final port = int.tryParse(value);
                if (port == null || port < 1024 || port > 49151) {
                  return localizations.portTip(localizations.mixedPort);
                }
                if (widget.otherPorts.contains(port)) {
                  return localizations.portConflictTip;
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}

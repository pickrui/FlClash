import 'dart:io';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/clash_config.dart';
import 'package:fl_clash/widgets/dialog.dart';
import 'package:flutter/material.dart';

/// A visual editor for common rules, with a lossless text editor for advanced
/// expressions. [validate] can check the candidate in its complete configuration
/// before this dialog closes, so a failed check never discards the user's draft.
class CustomRuleEditorDialog extends StatefulWidget {
  final Rule? rule;
  final List<String> targets;
  final List<String> ruleProviders;
  final Future<String> Function(Rule)? validate;

  const CustomRuleEditorDialog({
    super.key,
    this.rule,
    required this.targets,
    this.ruleProviders = const [],
    this.validate,
  });

  @override
  State<CustomRuleEditorDialog> createState() => _CustomRuleEditorDialogState();
}

class _CustomRuleEditorDialogState extends State<CustomRuleEditorDialog> {
  static const _formActions = [
    RuleAction.DOMAIN_SUFFIX,
    RuleAction.DOMAIN,
    RuleAction.DOMAIN_KEYWORD,
    RuleAction.IP_CIDR,
    RuleAction.IP_CIDR6,
    RuleAction.SRC_IP_CIDR,
    RuleAction.PROCESS_NAME,
    RuleAction.PROCESS_PATH,
    RuleAction.DST_PORT,
    RuleAction.SRC_PORT,
    RuleAction.NETWORK,
    RuleAction.GEOSITE,
    RuleAction.GEOIP,
    RuleAction.IP_ASN,
    RuleAction.RULE_SET,
    RuleAction.MATCH,
  ];
  static const _commaPayloadTypes = {
    'AND',
    'OR',
    'NOT',
    'SUB-RULE',
    'DOMAIN-REGEX',
    'PROCESS-NAME-REGEX',
    'PROCESS-PATH-REGEX',
  };
  // These core-supported types have no RuleAction enum entry yet. They must
  // remain editable without guessing a different action in ParsedRule.
  static const _additionalRawTypes = {
    'DOMAIN-WILDCARD',
    'PROCESS-NAME-WILDCARD',
    'PROCESS-PATH-WILDCARD',
    'SNIFF-PROTOCOL',
  };

  final _formKey = GlobalKey<FormState>();
  final _errorKey = GlobalKey();
  final _payloadController = TextEditingController();
  final _rawController = TextEditingController();
  RuleAction _action = RuleAction.DOMAIN_SUFFIX;
  String? _target;
  bool _noResolve = false;
  bool _src = false;
  bool _rawMode = false;
  bool _saving = false;
  String? _error;
  Rule? _failedCandidate;

  List<String> get _targets =>
      widget.targets.where((name) => name.trim().isNotEmpty).toSet().toList();

  @override
  void initState() {
    super.initState();
    final value = widget.rule?.value;
    if (value != null) {
      _rawController.text = value;
      final parsed = _parseForForm(value);
      if (parsed == null) {
        _rawMode = true;
      } else {
        _loadParsedRule(parsed);
      }
    }
  }

  @override
  void dispose() {
    _payloadController.dispose();
    _rawController.dispose();
    super.dispose();
  }

  ParsedRule? _parseForForm(String value) {
    final fields = value.trim().split(',').map((item) => item.trim()).toList();
    final actions = _formActions.where(
      (action) => action.value == fields.first,
    );
    if (actions.isEmpty) return null;
    final action = actions.first;
    final requiredFields = action == RuleAction.MATCH ? 2 : 3;
    if (fields.length < requiredFields) {
      return null;
    }
    final params = fields.skip(requiredFields).toList();
    if (params.isNotEmpty &&
        (!action.hasParams ||
            params.any((item) => item != 'src' && item != 'no-resolve') ||
            params.length != params.toSet().length)) {
      return null;
    }
    // Read parameters only after the target: providers and targets can also
    // legitimately be named src or no-resolve. Empty fields stay editable so an
    // unfinished rule can move between the form and text without losing input.
    return ParsedRule(
      ruleAction: action,
      content: action == RuleAction.MATCH ? null : fields[1],
      ruleProvider: action == RuleAction.RULE_SET ? fields[1] : null,
      ruleTarget: fields[requiredFields - 1].isEmpty
          ? null
          : fields[requiredFields - 1],
      src: params.contains('src'),
      noResolve: params.contains('no-resolve'),
    );
  }

  void _loadParsedRule(ParsedRule rule) {
    _action = rule.ruleAction;
    _payloadController.text = rule.ruleProvider ?? rule.content ?? '';
    _target = rule.ruleTarget;
    _noResolve = rule.noResolve;
    _src = rule.src;
  }

  String get _formValue => [
    _action.value,
    if (_action != RuleAction.MATCH) _payloadController.text.trim(),
    _target ?? '',
    if (_action.hasParams) ...[if (_src) 'src', if (_noResolve) 'no-resolve'],
  ].join(',');

  void _setMode(bool raw) {
    if (raw == _rawMode || _saving) return;
    if (raw) {
      _rawController.text = _formValue;
    } else {
      final parsed = _parseForForm(_rawController.text);
      if (parsed == null) {
        _showError(context.appLocalizations.customRuleFormUnavailable);
        return;
      }
      _loadParsedRule(parsed);
    }
    setState(() {
      _rawMode = raw;
      _clearError();
    });
  }

  String _example(RuleAction action) => switch (action) {
    RuleAction.IP_CIDR || RuleAction.SRC_IP_CIDR => '192.168.0.0/16',
    RuleAction.IP_CIDR6 => '2001:db8::/32',
    RuleAction.DST_PORT || RuleAction.SRC_PORT => '80/443/8000-9000',
    RuleAction.PROCESS_NAME => 'curl',
    RuleAction.PROCESS_PATH =>
      '/Applications/Example.app/Contents/MacOS/Example',
    RuleAction.GEOIP => 'CN',
    RuleAction.GEOSITE => 'geolocation-!cn',
    RuleAction.IP_ASN => '13335',
    RuleAction.NETWORK => 'TCP',
    RuleAction.DOMAIN_KEYWORD => 'example',
    _ => 'example.com',
  };

  String? _validatePayload(
    RuleAction action,
    String value, {
    bool raw = false,
  }) {
    final l10n = context.appLocalizations;
    if (action == RuleAction.MATCH) return null;
    if (value.isEmpty) return l10n.emptyTip(l10n.content);
    if (RegExp(r'[,\r\n\x00]').hasMatch(value)) {
      return l10n.customRuleInvalidSyntax;
    }
    if (action == RuleAction.RULE_SET) {
      return widget.ruleProviders.contains(value)
          ? null
          : l10n.customRuleUnavailableProvider(value);
    }
    bool valid = true;
    switch (action) {
      case RuleAction.DOMAIN:
      case RuleAction.DOMAIN_SUFFIX:
        if (raw) break;
        valid =
            !RegExp(r'[\s/:?#@*]').hasMatch(value) &&
            value.split('.').every((part) => part.isNotEmpty);
      case RuleAction.DOMAIN_KEYWORD:
        if (raw) break;
        valid = !RegExp(r'[\s/:?#@]').hasMatch(value);
      case RuleAction.IP_CIDR:
      case RuleAction.IP_CIDR6:
      case RuleAction.SRC_IP_CIDR:
        final parts = value.split('/');
        final address = InternetAddress.tryParse(parts.first);
        final prefix = parts.length == 2 ? int.tryParse(parts.last) : null;
        valid =
            address != null &&
            !parts.first.contains('%') &&
            prefix != null &&
            prefix >= 0 &&
            prefix <= (address.type == InternetAddressType.IPv4 ? 32 : 128);
      case RuleAction.DST_PORT:
      case RuleAction.SRC_PORT:
        final ranges = value.split('/');
        valid =
            ranges.length <= 28 &&
            ranges.every((range) {
              if (!RegExp(r'^\d+(?:-\d+)?$').hasMatch(range)) return false;
              final bounds = range.split('-').map(int.tryParse).toList();
              return bounds.every(
                    (port) => port != null && port >= 0 && port <= 65535,
                  ) &&
                  (bounds.length == 1 || bounds.first! <= bounds.last!);
            });
      case RuleAction.NETWORK:
        valid = const ['TCP', 'UDP'].contains(value.toUpperCase());
      case RuleAction.IP_ASN:
        final asn = int.tryParse(value);
        valid =
            RegExp(r'^\d+$').hasMatch(value) &&
            asn != null &&
            asn >= 0 &&
            asn <= 0xffffffff;
      case RuleAction.GEOIP:
      case RuleAction.GEOSITE:
        valid = !RegExp(r'[\s/]').hasMatch(value);
      default:
        break;
    }
    return valid ? null : l10n.customRuleInvalidContent(_example(action));
  }

  String? _validateTarget(String? value) {
    final l10n = context.appLocalizations;
    if (value == null || value.isEmpty) return l10n.customRuleChooseTarget;
    if (RegExp(r'[,\r\n\x00]').hasMatch(value)) {
      return l10n.customRuleInvalidSyntax;
    }
    return _targets.contains(value)
        ? null
        : l10n.customRuleUnavailableTarget(value);
  }

  String? _validateRaw(String? value) {
    final l10n = context.appLocalizations;
    final text = (value ?? '').trim();
    if (text.isEmpty) return l10n.emptyTip(l10n.rule);
    if (RegExp(r'[\r\n\x00]').hasMatch(text)) {
      return l10n.customRuleInvalidSyntax;
    }
    final fields = text.split(',').map((item) => item.trim()).toList();
    final type = fields.first.toUpperCase();
    final actions = RuleAction.values.where((action) => action.value == type);
    final action = actions.isEmpty ? null : actions.first;
    if (action == null && !_additionalRawTypes.contains(type)) {
      return l10n.customRuleInvalidSyntax;
    }
    final match = type == 'MATCH';
    if (fields.length < (match ? 2 : 3) || (match && fields.length != 2)) {
      return l10n.customRuleInvalidSyntax;
    }
    final commaPayload = _commaPayloadTypes.contains(type);
    final target = commaPayload ? fields.last : fields[match ? 1 : 2];
    if (target.isEmpty) return l10n.customRuleChooseTarget;
    if (type != 'SUB-RULE') {
      final error = _validateTarget(target);
      if (error != null) return error;
    }
    if (match) return null;
    final payload = commaPayload
        ? fields.sublist(1, fields.length - 1).join(',')
        : fields[1];
    if (payload.isEmpty) return l10n.emptyTip(l10n.content);
    if (!commaPayload && fields.skip(3).any((item) => item.isEmpty)) {
      return l10n.customRuleInvalidSyntax;
    }
    if (action != null && _formActions.contains(action)) {
      return _validatePayload(action, payload, raw: true);
    }
    return null;
  }

  void _saveDraft() {
    if (_saving ||
        _failedCandidate == null ||
        _formKey.currentState?.validate() != true) {
      return;
    }
    Navigator.of(context).pop(_failedCandidate);
  }

  Future<void> _submit() async {
    if (_saving || _formKey.currentState?.validate() != true) return;
    final value = _rawMode ? _rawController.text.trim() : _formValue;
    final rule = widget.rule?.copyWith(value: value) ?? Rule.value(value);
    setState(() {
      _saving = true;
      _clearError();
    });
    try {
      final error = await widget.validate?.call(rule) ?? '';
      if (!mounted || ModalRoute.of(context)?.isCurrent != true) return;
      if (error.isNotEmpty) {
        _showError(error, candidate: rule);
        return;
      }
      Navigator.of(context).pop(rule);
    } catch (error) {
      if (!mounted || ModalRoute.of(context)?.isCurrent != true) return;
      _showError(
        error.toString(),
        candidate: widget.validate == null ? null : rule,
      );
    }
  }

  void _clearError() {
    _error = null;
    _failedCandidate = null;
  }

  void _showError(String error, {Rule? candidate}) {
    setState(() {
      _saving = false;
      _error = error;
      _failedCandidate = candidate;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final errorContext = _errorKey.currentContext;
      if (!mounted || errorContext == null) return;
      Scrollable.ensureVisible(
        errorContext,
        alignment: 1,
        duration: const Duration(milliseconds: 180),
      );
    });
  }

  Future<String?> _choose({
    required String title,
    required List<String> options,
    String? value,
  }) => showDialog<String>(
    context: context,
    builder: (_) =>
        _RuleOptionDialog(title: title, options: options, value: value),
  );

  Widget _selectionField({
    required Key key,
    required String label,
    required String placeholder,
    required String? value,
    required List<String> options,
    required String? Function(String?) validator,
    required ValueChanged<String> onChanged,
    String? helperText,
  }) => FormField<String>(
    key: key,
    initialValue: value,
    validator: validator,
    builder: (field) => Semantics(
      button: true,
      enabled: !_saving,
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: _saving
            ? null
            : () async {
                final selected = await _choose(
                  title: label,
                  options: options,
                  value: value,
                );
                if (selected != null && mounted) {
                  setState(() {
                    onChanged(selected);
                    _clearError();
                  });
                  field.didChange(selected);
                  field.validate();
                }
              },
        child: InputDecorator(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: label,
            helperText: helperText,
            helperMaxLines: 3,
            errorText:
                field.errorText ??
                (value != null && !options.contains(value)
                    ? validator(value)
                    : null),
            errorMaxLines: 4,
            suffixIcon: const Icon(Icons.expand_more),
          ),
          child: Text(value?.isNotEmpty == true ? value! : placeholder),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.appLocalizations;
    return CommonDialog(
      maxWidth: 480,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      title: widget.rule == null ? l10n.addRule : l10n.editRule,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        if (_failedCandidate != null)
          TextButton(
            key: const Key('custom-rule-save-draft'),
            onPressed: _saving ? null : _saveDraft,
            child: Text(l10n.saveRoutingDraft),
          ),
        FilledButton(
          key: const Key('custom-rule-save'),
          onPressed: _saving ? null : _submit,
          child: _saving
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(l10n.save),
        ),
      ],
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SegmentedButton<bool>(
              showSelectedIcon: false,
              segments: [
                ButtonSegment(value: false, label: Text(l10n.customRuleForm)),
                ButtonSegment(value: true, label: Text(l10n.customRuleRaw)),
              ],
              selected: {_rawMode},
              onSelectionChanged: _saving
                  ? null
                  : (selection) => _setMode(selection.single),
            ),
            const SizedBox(height: 20),
            if (_rawMode) ...[
              TextFormField(
                key: const Key('custom-rule-raw'),
                controller: _rawController,
                enabled: !_saving,
                minLines: 3,
                maxLines: 8,
                keyboardType: TextInputType.multiline,
                autocorrect: false,
                enableSuggestions: false,
                smartDashesType: SmartDashesType.disabled,
                smartQuotesType: SmartQuotesType.disabled,
                style: context.textTheme.bodyMedium?.toJetBrainsMono,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: l10n.rule,
                  helperText: l10n.customRuleRawHint,
                  helperMaxLines: 3,
                  errorMaxLines: 5,
                ),
                validator: _validateRaw,
                onChanged: (_) {
                  if (_error != null) setState(_clearError);
                },
              ),
            ] else ...[
              DropdownButtonFormField<RuleAction>(
                key: ValueKey('custom-rule-type-${_action.name}'),
                initialValue: _action,
                isExpanded: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: l10n.customRuleType,
                ),
                items: [
                  for (final action in _formActions)
                    DropdownMenuItem(value: action, child: Text(action.value)),
                ],
                onChanged: _saving
                    ? null
                    : (action) {
                        if (action == null) return;
                        setState(() {
                          _action = action;
                          if (!action.hasParams) {
                            _noResolve = false;
                            _src = false;
                          }
                          _clearError();
                        });
                      },
              ),
              const SizedBox(height: 20),
              if (_action == RuleAction.MATCH)
                Text(l10n.customRuleMatchHint)
              else if (_action == RuleAction.RULE_SET)
                _selectionField(
                  key: const Key('custom-rule-provider'),
                  label: l10n.ruleProviders,
                  placeholder: l10n.customRuleChooseProvider,
                  value: _payloadController.text.isEmpty
                      ? null
                      : _payloadController.text,
                  options: widget.ruleProviders,
                  validator: (value) => _validatePayload(_action, value ?? ''),
                  onChanged: (value) => _payloadController.text = value,
                )
              else
                TextFormField(
                  key: ValueKey('custom-rule-payload-${_action.name}'),
                  controller: _payloadController,
                  enabled: !_saving,
                  autocorrect: false,
                  enableSuggestions: false,
                  smartDashesType: SmartDashesType.disabled,
                  smartQuotesType: SmartQuotesType.disabled,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: l10n.content,
                    hintText: _example(_action),
                    helperText: _action == RuleAction.DOMAIN_SUFFIX
                        ? l10n.customRuleDomainSuffixHint
                        : null,
                    helperMaxLines: 4,
                    errorMaxLines: 4,
                  ),
                  validator: (value) =>
                      _validatePayload(_action, (value ?? '').trim()),
                  onChanged: (_) => setState(_clearError),
                  onFieldSubmitted: (_) => _submit(),
                ),
              const SizedBox(height: 20),
              _selectionField(
                key: const Key('custom-rule-target'),
                label: l10n.ruleTarget,
                placeholder: l10n.customRuleChooseTarget,
                value: _target,
                options: _targets,
                validator: _validateTarget,
                onChanged: (value) => _target = value,
                helperText: l10n.customRuleTargetHint,
              ),
              if (_action.hasParams) ...[
                const SizedBox(height: 8),
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.noResolve),
                  subtitle: Text(l10n.customRuleNoResolveHint),
                  value: _noResolve,
                  onChanged: _saving
                      ? null
                      : (value) => setState(() {
                          _noResolve = value;
                          _clearError();
                        }),
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.sourceIp),
                  value: _src,
                  onChanged: _saving
                      ? null
                      : (value) => setState(() {
                          _src = value ?? false;
                          _clearError();
                        }),
                ),
              ],
              const SizedBox(height: 20),
              Text(l10n.preview, style: context.textTheme.labelMedium),
              const SizedBox(height: 4),
              SelectableText(
                _formValue,
                style: context.textTheme.bodySmall?.toJetBrainsMono,
              ),
            ],
            if (_error != null) ...[
              const SizedBox(height: 16),
              Semantics(
                key: _errorKey,
                liveRegion: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _error!,
                      style: TextStyle(color: context.colorScheme.error),
                    ),
                    if (_failedCandidate != null) ...[
                      const SizedBox(height: 8),
                      Text(l10n.routingDraftHint),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _RuleOptionDialog extends StatefulWidget {
  final String title;
  final List<String> options;
  final String? value;

  const _RuleOptionDialog({
    required this.title,
    required this.options,
    this.value,
  });

  @override
  State<_RuleOptionDialog> createState() => _RuleOptionDialogState();
}

class _RuleOptionDialogState extends State<_RuleOptionDialog> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l10n = context.appLocalizations;
    final options = widget.options
        .toSet()
        .where(
          (item) => item.toLowerCase().contains(_query.trim().toLowerCase()),
        )
        .toList();
    return CommonDialog(
      maxWidth: 480,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      title: widget.title,
      overrideScroll: true,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
      ],
      child: SizedBox(
        height: 360,
        child: Column(
          children: [
            TextField(
              key: const Key('custom-rule-option-search'),
              autofocus: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: l10n.search,
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) => setState(() => _query = value),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: options.isEmpty
                  ? Center(child: Text(l10n.noData))
                  : ListView.builder(
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final option = options[index];
                        return ListTile(
                          title: Text(option),
                          selected: option == widget.value,
                          trailing: option == widget.value
                              ? const Icon(Icons.check)
                              : null,
                          onTap: () => Navigator.of(context).pop(option),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

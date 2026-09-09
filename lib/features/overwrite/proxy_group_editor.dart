import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'member_picker.dart';

String customProxyGroupTypeLabel(GroupType type) => switch (type) {
  GroupType.Selector => appLocalizations.groupTypeSelect,
  GroupType.URLTest => appLocalizations.groupTypeUrlTest,
  GroupType.Fallback => appLocalizations.groupTypeFallback,
  GroupType.LoadBalance => appLocalizations.groupTypeLoadBalance,
  GroupType.Relay => 'Relay',
};

String _groupTypeHint(GroupType type) => switch (type) {
  GroupType.Selector => appLocalizations.groupTypeSelectHint,
  GroupType.URLTest => appLocalizations.groupTypeUrlTestHint,
  GroupType.Fallback => appLocalizations.groupTypeFallbackHint,
  GroupType.LoadBalance => appLocalizations.groupTypeLoadBalanceHint,
  GroupType.Relay => appLocalizations.relayGroupUnsupported,
};

/// An edit that cannot safely be persisted, even as a draft.
class ProxyGroupEditBlocked implements Exception {
  final String message;

  const ProxyGroupEditBlocked(this.message);

  @override
  String toString() => message;
}

class ProxyGroupDialog extends StatefulWidget {
  final ProxyGroup? group;
  final List<ProxyGroup> existingGroups;
  final Set<String> reservedNames;
  final List<String> availableMembers;
  final List<String> availableProviders;
  final Future<String> Function(ProxyGroup)? validate;

  const ProxyGroupDialog({
    super.key,
    this.group,
    required this.existingGroups,
    this.reservedNames = const {},
    this.availableMembers = const [],
    this.availableProviders = const [],
    this.validate,
  });

  @override
  State<ProxyGroupDialog> createState() => _ProxyGroupDialogState();
}

class _ProxyGroupDialogState extends State<ProxyGroupDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _proxiesController;
  late final TextEditingController _providersController;
  late final TextEditingController _urlController;
  late final TextEditingController _intervalController;
  late final TextEditingController _toleranceController;
  late final TextEditingController _timeoutController;
  late final TextEditingController _maxFailedTimesController;
  late final TextEditingController _filterController;
  late final TextEditingController _excludeFilterController;
  late final TextEditingController _excludeTypeController;
  late final TextEditingController _expectedStatusController;
  late final TextEditingController _iconController;
  late GroupType _type;
  late String _strategy;
  late bool _lazy;
  late bool _disableUdp;
  late bool _includeAll;
  late bool _includeAllProxies;
  late bool _includeAllProviders;
  late bool _hidden;
  bool _saving = false;
  String? _error;
  bool _canSaveDraft = false;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final group = widget.group;
    _nameController = TextEditingController(text: group?.name ?? '');
    _proxiesController = TextEditingController(
      text: group?.proxies?.join('\n') ?? '',
    );
    _providersController = TextEditingController(
      text: group?.use?.join('\n') ?? '',
    );
    _urlController = TextEditingController(text: group?.url ?? '');
    _intervalController = TextEditingController(
      text: group?.interval?.toString() ?? '',
    );
    _toleranceController = TextEditingController(
      text: group?.tolerance?.toString() ?? '',
    );
    _timeoutController = TextEditingController(
      text: group?.timeout?.toString() ?? '',
    );
    _maxFailedTimesController = TextEditingController(
      text: group?.maxFailedTimes?.toString() ?? '',
    );
    _filterController = TextEditingController(text: group?.filter ?? '');
    _excludeFilterController = TextEditingController(
      text: group?.excludeFilter ?? '',
    );
    _excludeTypeController = TextEditingController(
      text: group?.excludeType ?? '',
    );
    _expectedStatusController = TextEditingController(
      text: group?.expectedStatus?.toString() ?? '',
    );
    _iconController = TextEditingController(text: group?.icon ?? '');
    _type = group?.type ?? GroupType.Selector;
    _strategy = group?.strategy ?? 'consistent-hashing';
    _lazy = group?.lazy ?? true;
    _disableUdp = group?.disableUdp ?? false;
    _includeAll = group?.includeAll ?? false;
    _includeAllProxies = group?.includeAllProxies ?? false;
    _includeAllProviders = group?.includeAllProviders ?? false;
    _hidden = group?.hidden ?? false;
  }

  List<String>? _parseList(String value) {
    final result = value
        .split('\n')
        .map(
          (item) =>
              item.endsWith('\r') ? item.substring(0, item.length - 1) : item,
        )
        .where((item) => item.trim().isNotEmpty)
        .toList();
    return result.isEmpty ? null : result;
  }

  String? _textOrNull(TextEditingController controller) {
    final value = controller.text.trim();
    return value.isEmpty ? null : value;
  }

  int? _intOrNull(TextEditingController controller) {
    final value = controller.text.trim();
    return value.isEmpty ? null : int.parse(value);
  }

  Future<void> _submit({bool saveDraft = false}) async {
    if (_saving) return;
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    if (_type == GroupType.Relay) {
      _showError(appLocalizations.relayGroupUnsupported);
      return;
    }
    final proxies = _parseList(_proxiesController.text);
    final providers = _parseList(_providersController.text);
    if ((proxies == null || proxies.isEmpty) &&
        (providers == null || providers.isEmpty) &&
        !_includeAll &&
        !_includeAllProxies &&
        !_includeAllProviders) {
      _showError(appLocalizations.proxyGroupMembersEmpty);
      return;
    }
    final name = _nameController.text.trim();
    final original = widget.group;
    final result = (original ?? ProxyGroup(name: name, type: _type)).copyWith(
      name: name,
      type: _type,
      proxies: proxies,
      use: providers,
      url:
          _textOrNull(_urlController) ??
          (_type != GroupType.Selector ? defaultTestUrl : null),
      interval:
          _intOrNull(_intervalController) ??
          (_type != GroupType.Selector ? 300 : null),
      tolerance: _type == GroupType.URLTest
          ? _intOrNull(_toleranceController)
          : null,
      timeout: _intOrNull(_timeoutController),
      maxFailedTimes: _intOrNull(_maxFailedTimesController),
      filter: _textOrNull(_filterController),
      excludeFilter: _textOrNull(_excludeFilterController),
      excludeType: _textOrNull(_excludeTypeController),
      expectedStatus: _textOrNull(_expectedStatusController),
      icon: _textOrNull(_iconController),
      strategy: _type == GroupType.LoadBalance ? _strategy : null,
      lazy: _lazy,
      disableUdp: _disableUdp,
      includeAll: _includeAll,
      includeAllProxies: _includeAllProxies,
      includeAllProviders: _includeAllProviders,
      hidden: _hidden,
    );
    setState(() {
      _saving = true;
      _error = null;
      _canSaveDraft = false;
    });
    try {
      final message = await widget.validate?.call(result) ?? '';
      if (!mounted || ModalRoute.of(context)?.isCurrent != true) return;
      if (message.isNotEmpty && !saveDraft) {
        _showError(message, canSaveDraft: true);
        return;
      }
      Navigator.of(context).pop(result);
    } catch (error) {
      if (mounted && ModalRoute.of(context)?.isCurrent == true) {
        _showError(
          error.toString(),
          canSaveDraft: error is! ProxyGroupEditBlocked,
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _showError(String message, {bool canSaveDraft = false}) {
    setState(() {
      _error = message;
      _canSaveDraft = canSaveDraft;
    });
    if (_scrollController.hasClients) _scrollController.jumpTo(0);
  }

  bool get _hasDynamicMembers =>
      _includeAll ||
      _includeAllProxies ||
      _includeAllProviders ||
      _providersController.text.isNotEmpty;

  Future<void> _pickMembers(
    TextEditingController controller,
    List<String> available,
    String title,
  ) async {
    final selected = await showDialog<List<String>>(
      context: context,
      builder: (_) => ProxyMemberPicker(
        title: title,
        available: available,
        selected: _parseList(controller.text) ?? [],
      ),
    );
    if (selected == null || !mounted) return;
    setState(() => controller.text = selected.join('\n'));
  }

  Widget _memberField(
    TextEditingController controller,
    List<String> available,
    String title,
  ) {
    final selected = _parseList(controller.text) ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton.icon(
          onPressed: _saving
              ? null
              : () => _pickMembers(controller, available, title),
          icon: const Icon(Icons.playlist_add),
          label: Text('$title (${selected.length})'),
        ),
        if (selected.isNotEmpty)
          Wrap(
            spacing: 4,
            children: [
              for (final name in selected)
                InputChip(
                  label: Text(name, overflow: TextOverflow.ellipsis),
                  tooltip: available.contains(name)
                      ? name
                      : appLocalizations.outboundUnavailable,
                  avatar: available.contains(name)
                      ? null
                      : const Icon(Icons.warning_amber, size: 16),
                  onDeleted: _saving
                      ? null
                      : () => setState(() {
                          final next = List<String>.from(selected)
                            ..remove(name);
                          controller.text = next.join('\n');
                        }),
                ),
            ],
          ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _proxiesController.dispose();
    _providersController.dispose();
    _urlController.dispose();
    _intervalController.dispose();
    _toleranceController.dispose();
    _timeoutController.dispose();
    _maxFailedTimesController.dispose();
    _filterController.dispose();
    _excludeFilterController.dispose();
    _excludeTypeController.dispose();
    _expectedStatusController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget textField({
      required TextEditingController controller,
      required String label,
      TextInputType? keyboardType,
      int maxLength = TextInputLimits.filter,
      String? Function(String? value)? validator,
    }) {
      return TextFormField(
        enabled: !_saving,
        autocorrect: false,
        smartDashesType: SmartDashesType.disabled,
        smartQuotesType: SmartQuotesType.disabled,
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: TextInputLimits.limit(maxLength),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      );
    }

    Widget switchField({
      required String label,
      required bool value,
      required ValueChanged<bool> onChanged,
    }) {
      return SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(label),
        value: value,
        onChanged: onChanged,
      );
    }

    String? positiveIntValidator(String? value) {
      final text = value?.trim() ?? '';
      if (text.isNotEmpty && (int.tryParse(text) ?? 0) <= 0) {
        return appLocalizations.numberTip(appLocalizations.value);
      }
      return null;
    }

    String? toleranceValidator(String? value) {
      final text = value?.trim() ?? '';
      if (text.isEmpty) {
        return null;
      }
      final tolerance = int.tryParse(text);
      if (tolerance == null || tolerance < 0 || tolerance > 65535) {
        return '0 - 65535';
      }
      return null;
    }

    final strategyOptions = <String>{
      'consistent-hashing',
      'round-robin',
      'sticky-sessions',
      _strategy,
    };

    return CommonDialog(
      maxWidth: 480,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      title: widget.group == null
          ? appLocalizations.addProxyGroup
          : appLocalizations.editProxyGroup,
      actions: [
        if (_canSaveDraft && !_saving)
          TextButton(
            onPressed: () => _submit(saveDraft: true),
            child: Text(appLocalizations.saveRoutingDraft),
          ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(appLocalizations.cancel),
        ),
        FilledButton(
          onPressed: _saving ? null : _submit,
          child: _saving
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(appLocalizations.save),
        ),
      ],
      overrideScroll: true,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: ExcludeFocus(
          excluding: _saving,
          child: AbsorbPointer(
            absorbing: _saving,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _error!,
                            style: TextStyle(color: context.colorScheme.error),
                          ),
                          if (_canSaveDraft) ...[
                            const SizedBox(height: 8),
                            Text(
                              appLocalizations.routingDraftHint,
                              style: context.textTheme.bodySmall,
                            ),
                          ],
                        ],
                      ),
                    ),
                  TextFormField(
                    enabled: !_saving,
                    autocorrect: false,
                    smartDashesType: SmartDashesType.disabled,
                    smartQuotesType: SmartQuotesType.disabled,
                    controller: _nameController,
                    inputFormatters: TextInputLimits.limit(
                      TextInputLimits.groupName,
                    ),
                    decoration: InputDecoration(
                      labelText: appLocalizations.name,
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final name = value?.trim() ?? '';
                      if (RegExp(r'[,\r\n\x00]').hasMatch(name)) {
                        return appLocalizations.customRuleInvalidSyntax;
                      }
                      if (name.isEmpty) {
                        return appLocalizations.proxyGroupNameEmpty;
                      }
                      final duplicate = widget.existingGroups.any(
                        (item) => item != widget.group && item.name == name,
                      );
                      if (duplicate) {
                        return appLocalizations.existsTip(
                          appLocalizations.name,
                        );
                      }
                      if (name != widget.group?.name &&
                          widget.reservedNames.contains(name)) {
                        return appLocalizations.existsTip(
                          appLocalizations.name,
                        );
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<GroupType>(
                    isExpanded: true,
                    initialValue: _type,
                    decoration: InputDecoration(
                      labelText: appLocalizations.routingGroupType,
                      border: const OutlineInputBorder(),
                    ),
                    items: GroupType.values
                        .where(
                          (type) =>
                              type != GroupType.Relay ||
                              _type == GroupType.Relay,
                        )
                        .map(
                          (type) => DropdownMenuItem(
                            value: type,
                            child: Text(
                              customProxyGroupTypeLabel(type),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _type = value);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _groupTypeHint(_type),
                    style: context.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  _memberField(
                    _proxiesController,
                    widget.availableMembers,
                    appLocalizations.chooseMembers,
                  ),
                  if (_type == GroupType.Fallback)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        appLocalizations.memberOrderHint,
                        style: context.textTheme.bodySmall,
                      ),
                    ),
                  if (widget.availableProviders.isNotEmpty ||
                      _providersController.text.isNotEmpty)
                    _memberField(
                      _providersController,
                      widget.availableProviders,
                      appLocalizations.proxyProviders,
                    ),
                  switchField(
                    label: appLocalizations.includeAllProxies,
                    value: _includeAllProxies,
                    onChanged: (value) =>
                        setState(() => _includeAllProxies = value),
                  ),
                  switchField(
                    label: appLocalizations.includeAllProxyProviders,
                    value: _includeAllProviders,
                    onChanged: (value) =>
                        setState(() => _includeAllProviders = value),
                  ),
                  if (_includeAllProxies ||
                      _includeAllProviders ||
                      _includeAll) ...[
                    Text(
                      appLocalizations.dynamicMembersHint,
                      style: context.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (_hasDynamicMembers)
                    textField(
                      controller: _filterController,
                      label: appLocalizations.proxyFilter,
                    ),
                  if (_hasDynamicMembers)
                    Text(
                      appLocalizations.groupFilterHint,
                      style: context.textTheme.bodySmall,
                    ),
                  const SizedBox(height: 8),
                  ExpansionTile(
                    title: Text(appLocalizations.advancedConfig),
                    tilePadding: EdgeInsets.zero,
                    initiallyExpanded: widget.group != null,
                    maintainState: true,
                    children: [
                      TextField(
                        enabled: !_saving,
                        autocorrect: false,
                        smartDashesType: SmartDashesType.disabled,
                        smartQuotesType: SmartQuotesType.disabled,
                        controller: _proxiesController,
                        onChanged: (_) => setState(() {}),
                        minLines: 2,
                        maxLines: 4,
                        inputFormatters: TextInputLimits.limit(65536),
                        decoration: InputDecoration(
                          labelText: appLocalizations.proxies,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        enabled: !_saving,
                        autocorrect: false,
                        smartDashesType: SmartDashesType.disabled,
                        smartQuotesType: SmartQuotesType.disabled,
                        controller: _providersController,
                        onChanged: (_) => setState(() {}),
                        minLines: 2,
                        maxLines: 4,
                        inputFormatters: TextInputLimits.limit(65536),
                        decoration: InputDecoration(
                          labelText: appLocalizations.proxyProviders,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        enabled: !_saving,
                        autocorrect: false,
                        smartDashesType: SmartDashesType.disabled,
                        smartQuotesType: SmartQuotesType.disabled,
                        controller: _urlController,
                        keyboardType: TextInputType.url,
                        inputFormatters: TextInputLimits.limit(
                          TextInputLimits.url,
                        ),
                        decoration: InputDecoration(
                          labelText: appLocalizations.url,
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          final url = value?.trim() ?? '';
                          if (url.isNotEmpty && !url.isUrl) {
                            return appLocalizations.urlTip(
                              appLocalizations.url,
                            );
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      textField(
                        controller: _intervalController,
                        label: appLocalizations.interval,
                        keyboardType: TextInputType.number,
                        maxLength: TextInputLimits.interval,
                        validator: positiveIntValidator,
                      ),
                      if (_type == GroupType.URLTest) ...[
                        const SizedBox(height: 16),
                        textField(
                          controller: _toleranceController,
                          label: appLocalizations.tolerance,
                          keyboardType: TextInputType.number,
                          maxLength: TextInputLimits.interval,
                          validator: toleranceValidator,
                        ),
                      ],
                      const SizedBox(height: 16),
                      textField(
                        controller: _timeoutController,
                        label: appLocalizations.timeout,
                        keyboardType: TextInputType.number,
                        maxLength: TextInputLimits.interval,
                        validator: positiveIntValidator,
                      ),
                      const SizedBox(height: 16),
                      textField(
                        controller: _maxFailedTimesController,
                        label: appLocalizations.maxFailedTimes,
                        keyboardType: TextInputType.number,
                        maxLength: TextInputLimits.interval,
                        validator: positiveIntValidator,
                      ),
                      const SizedBox(height: 16),
                      textField(
                        controller: _excludeFilterController,
                        label: appLocalizations.excludeProxyFilter,
                      ),
                      const SizedBox(height: 16),
                      textField(
                        controller: _excludeTypeController,
                        label: appLocalizations.excludeType,
                      ),
                      const SizedBox(height: 16),
                      textField(
                        controller: _expectedStatusController,
                        label: appLocalizations.expectedStatus,
                      ),
                      const SizedBox(height: 16),
                      textField(
                        controller: _iconController,
                        label: appLocalizations.iconUrl,
                        keyboardType: TextInputType.url,
                        maxLength: TextInputLimits.iconUrl,
                        validator: (value) {
                          final url = value?.trim() ?? '';
                          if (url.isNotEmpty && !url.isUrl) {
                            return appLocalizations.urlTip(
                              appLocalizations.iconUrl,
                            );
                          }
                          return null;
                        },
                      ),
                      if (_type == GroupType.LoadBalance) ...[
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          isExpanded: true,
                          initialValue: _strategy,
                          decoration: InputDecoration(
                            labelText: appLocalizations.strategy,
                            border: const OutlineInputBorder(),
                          ),
                          items: strategyOptions
                              .map(
                                (strategy) => DropdownMenuItem(
                                  value: strategy,
                                  child: Text(strategy),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _strategy = value);
                            }
                          },
                        ),
                      ],
                      const SizedBox(height: 4),
                      switchField(
                        label: appLocalizations.lazy,
                        value: _lazy,
                        onChanged: (value) => setState(() => _lazy = value),
                      ),
                      switchField(
                        label: appLocalizations.disableUDP,
                        value: _disableUdp,
                        onChanged: (value) =>
                            setState(() => _disableUdp = value),
                      ),
                      switchField(
                        label: appLocalizations.hideFromList,
                        value: _hidden,
                        onChanged: (value) => setState(() => _hidden = value),
                      ),
                      switchField(
                        label: appLocalizations.includeAll,
                        value: _includeAll,
                        onChanged: (value) =>
                            setState(() => _includeAll = value),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

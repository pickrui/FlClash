import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/core/controller.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/database.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomOverwriteContent extends ConsumerWidget {
  final int profileId;

  const CustomOverwriteContent({super.key, required this.profileId});

  Future<void> _quickFill(BuildContext context, WidgetRef ref) async {
    final confirmed = await globalState.showMessage(
      message: TextSpan(text: appLocalizations.confirmOverwriteTip),
    );
    if (confirmed != true || !context.mounted) {
      return;
    }
    await appController.safeRun<void>(() async {
      final rawConfig = await appController.getRawProfileConfig(profileId);
      if (!context.mounted) {
        return;
      }
      final snippet = ClashConfigSnippet.fromJson(rawConfig);
      if (snippet.proxyGroups.any((group) => group.type == GroupType.Relay)) {
        globalState.showNotifier(appLocalizations.relayGroupUnsupported);
        return;
      }
      for (final group in snippet.proxyGroups) {
        final message = await validateProxyGroupFilters(
          group,
          coreController.validateConfigWithBytes,
        );
        if (message.isNotEmpty) {
          globalState.showNotifier(message);
          return;
        }
      }
      ref.read(profilesProvider.notifier).updateProfile(profileId, (profile) {
        return profile.copyWith(
          customProxyGroups: snippet.proxyGroups,
          customRules: snippet.rule,
        );
      });
    }, silence: false);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider(profileId));
    final groups = profile?.customProxyGroups ?? const <ProxyGroup>[];
    final rules = profile?.customRules ?? const <Rule>[];
    return SliverMainAxisGroup(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverToBoxAdapter(
          child: InfoHeader(info: Info(label: appLocalizations.custom)),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        SliverToBoxAdapter(
          child: MoreActionButton(
            label: appLocalizations.proxyGroup,
            trailing: _CountBadge(groups.length),
            onPressed: () {
              BaseNavigator.push(
                context,
                CustomProxyGroupsView(profileId: profileId),
              );
            },
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 4)),
        SliverToBoxAdapter(
          child: MoreActionButton(
            label: appLocalizations.rule,
            trailing: _CountBadge(rules.length),
            onPressed: () {
              BaseNavigator.push(
                context,
                CustomRulesView(profileId: profileId),
              );
            },
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: MaterialBanner(
              elevation: 0,
              dividerColor: Colors.transparent,
              content: Text(appLocalizations.configDataDetected),
              actions: [
                FilledButton.tonalIcon(
                  onPressed: () => _quickFill(context, ref),
                  icon: const Icon(Icons.auto_fix_high),
                  label: Text(appLocalizations.quickFill),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CountBadge extends StatelessWidget {
  final int count;

  const _CountBadge(this.count);

  @override
  Widget build(BuildContext context) {
    return Badge(
      backgroundColor: context.colorScheme.secondaryContainer,
      textColor: context.colorScheme.onSecondaryContainer,
      label: Text('$count'),
      largeSize: 28,
      padding: const EdgeInsets.symmetric(horizontal: 10),
    );
  }
}

class CustomProxyGroupsView extends ConsumerWidget {
  final int profileId;

  const CustomProxyGroupsView({super.key, required this.profileId});

  void _update(WidgetRef ref, List<ProxyGroup> groups) {
    ref.read(profilesProvider.notifier).updateProfile(profileId, (profile) {
      return profile.copyWith(customProxyGroups: groups);
    });
  }

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref, [
    ProxyGroup? group,
  ]) async {
    final groups =
        ref.read(profileProvider(profileId))?.customProxyGroups ?? [];
    final profile = ref.read(profileProvider(profileId));
    final reservedNames = <String>{
      ...reservedOutboundNames,
      ...?profile?.profileProxies.map((item) => item.name),
    };
    try {
      final rawConfig = await appController.getRawProfileConfig(profileId);
      final proxies = rawConfig['proxies'];
      if (proxies is List) {
        reservedNames.addAll(
          proxies
              .whereType<Map>()
              .map((proxy) => proxy['name'])
              .whereType<String>(),
        );
      }
      final providers = rawConfig['proxy-providers'];
      if (providers is Map) {
        reservedNames.addAll(providers.keys.whereType<String>());
      }
    } catch (error) {
      if (context.mounted) {
        context.showNotifier(error.toString());
      }
      return;
    }
    if (!context.mounted) {
      return;
    }
    final result = await globalState.showCommonDialog<ProxyGroup>(
      child: ProxyGroupDialog(
        group: group,
        existingGroups: groups,
        reservedNames: reservedNames,
      ),
    );
    if (result == null || !context.mounted) {
      return;
    }
    final filterValidation = await validateProxyGroupFilters(
      result,
      coreController.validateConfigWithBytes,
    );
    if (filterValidation.isNotEmpty) {
      if (context.mounted) context.showNotifier(filterValidation);
      return;
    }
    final nextGroups = List<ProxyGroup>.from(groups);
    if (group == null) {
      nextGroups.add(result);
    } else {
      final index = nextGroups.indexOf(group);
      if (index == -1) {
        return;
      }
      nextGroups[index] = result;
    }
    final cycle = findProxyGroupCycle(nextGroups);
    if (cycle != null) {
      if (context.mounted) {
        context.showNotifier(appLocalizations.existsTip(cycle));
      }
      return;
    }
    if (group != null && group.name != result.name) {
      String? rawReference;
      try {
        rawReference = await appController.findRawProfileOutboundReference(
          profileId,
          group.name,
          includeTopLevelRules: profile?.overwriteType != OverwriteType.custom,
        );
      } catch (error) {
        if (context.mounted) {
          context.showNotifier(error.toString());
        }
        return;
      }
      if (rawReference != null) {
        if (context.mounted) {
          context.showNotifier(
            appLocalizations.rawOutboundInUse(group.name, rawReference),
          );
        }
        return;
      }
    }
    ref.read(profilesProvider.notifier).updateProfile(profileId, (profile) {
      return profile.copyAndPutCustomProxyGroup(result, previous: group);
    });
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    ProxyGroup group,
  ) async {
    final profile = ref.read(profileProvider(profileId));
    if (profile == null) {
      return;
    }
    if (profile.hasCustomOutboundReferences(
      group.name,
      excludingGroup: group,
    )) {
      context.showNotifier(appLocalizations.customOutboundInUse(group.name));
      return;
    }
    try {
      final rawReference = await appController.findRawProfileOutboundReference(
        profileId,
        group.name,
        includeTopLevelRules: profile.overwriteType != OverwriteType.custom,
      );
      if (rawReference != null) {
        if (context.mounted) {
          context.showNotifier(
            appLocalizations.rawOutboundInUse(group.name, rawReference),
          );
        }
        return;
      }
    } catch (error) {
      if (context.mounted) {
        context.showNotifier(error.toString());
      }
      return;
    }
    if (!context.mounted) {
      return;
    }
    final confirmed = await globalState.showMessage(
      message: TextSpan(
        text: appLocalizations.deleteMultipTip(appLocalizations.proxyGroup),
      ),
    );
    if (confirmed != true || !context.mounted) {
      return;
    }
    ref.read(profilesProvider.notifier).updateProfile(profileId, (profile) {
      return profile.copyAndRemoveCustomProxyGroup(group);
    });
  }

  void _reorder(WidgetRef ref, int oldIndex, int newIndex) {
    final groups = List<ProxyGroup>.from(
      ref.read(profileProvider(profileId))?.customProxyGroups ?? [],
    );
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final group = groups.removeAt(oldIndex);
    groups.insert(newIndex, group);
    _update(ref, groups);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups =
        ref.watch(profileProvider(profileId))?.customProxyGroups ??
        const <ProxyGroup>[];
    return CommonScaffold(
      title: appLocalizations.proxyGroup,
      actions: [
        IconButton(
          tooltip: appLocalizations.add,
          onPressed: () => _edit(context, ref),
          icon: const Icon(Icons.add),
        ),
      ],
      body: groups.isEmpty
          ? NullStatus(label: appLocalizations.proxyGroupEmpty)
          : ReorderableListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              buildDefaultDragHandles: false,
              itemCount: groups.length,
              itemBuilder: (context, index) {
                final group = groups[index];
                return ReorderableDelayedDragStartListener(
                  key: ObjectKey(group),
                  index: index,
                  child: ListItem(
                    title: Text(group.name),
                    subtitle: Text(group.type.name),
                    onTap: () => _edit(context, ref, group),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: appLocalizations.delete,
                          onPressed: () => _delete(context, ref, group),
                          icon: const Icon(Icons.delete_outline),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.drag_handle),
                        ),
                      ],
                    ),
                  ),
                );
              },
              onReorder: (oldIndex, newIndex) {
                _reorder(ref, oldIndex, newIndex);
              },
            ),
    );
  }
}

class ProxyGroupDialog extends StatefulWidget {
  final ProxyGroup? group;
  final List<ProxyGroup> existingGroups;
  final Set<String> reservedNames;

  const ProxyGroupDialog({
    super.key,
    this.group,
    required this.existingGroups,
    this.reservedNames = const {},
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

  void _submit() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    if (_type == GroupType.Relay) {
      globalState.showNotifier(appLocalizations.relayGroupUnsupported);
      return;
    }
    final proxies = _parseList(_proxiesController.text);
    final providers = _parseList(_providersController.text);
    if ((proxies == null || proxies.isEmpty) &&
        (providers == null || providers.isEmpty) &&
        !_includeAll &&
        !_includeAllProxies &&
        !_includeAllProviders) {
      globalState.showNotifier(appLocalizations.proxyGroupMembersEmpty);
      return;
    }
    final name = _nameController.text.trim();
    final original = widget.group;
    final result = (original ?? ProxyGroup(name: name, type: _type)).copyWith(
      name: name,
      type: _type,
      proxies: proxies,
      use: providers,
      url: _textOrNull(_urlController),
      interval: _intOrNull(_intervalController),
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
    Navigator.of(context).pop(result);
  }

  @override
  void dispose() {
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
      if (tolerance == null || tolerance <= 0 || tolerance > 65535) {
        return '1 - 65535';
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
      title: widget.group == null
          ? appLocalizations.addProxyGroup
          : appLocalizations.editProxyGroup,
      actions: [
        TextButton(onPressed: _submit, child: Text(appLocalizations.confirm)),
      ],
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              inputFormatters: TextInputLimits.limit(TextInputLimits.groupName),
              decoration: InputDecoration(
                labelText: appLocalizations.name,
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                final name = value?.trim() ?? '';
                if (name.isEmpty) {
                  return appLocalizations.proxyGroupNameEmpty;
                }
                final duplicate = widget.existingGroups.any(
                  (item) => item != widget.group && item.name == name,
                );
                if (duplicate) {
                  return appLocalizations.existsTip(appLocalizations.name);
                }
                if (name != widget.group?.name &&
                    widget.reservedNames.contains(name)) {
                  return appLocalizations.existsTip(appLocalizations.name);
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<GroupType>(
              isExpanded: true,
              initialValue: _type,
              decoration: InputDecoration(
                labelText: appLocalizations.networkType,
                border: const OutlineInputBorder(),
              ),
              items: GroupType.values
                  .where(
                    (type) =>
                        type != GroupType.Relay || _type == GroupType.Relay,
                  )
                  .map(
                    (type) =>
                        DropdownMenuItem(value: type, child: Text(type.name)),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _type = value);
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _proxiesController,
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
              controller: _providersController,
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
              controller: _urlController,
              keyboardType: TextInputType.url,
              inputFormatters: TextInputLimits.limit(TextInputLimits.url),
              decoration: InputDecoration(
                labelText: appLocalizations.url,
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                final url = value?.trim() ?? '';
                if (url.isNotEmpty && !url.isUrl) {
                  return appLocalizations.urlTip(appLocalizations.url);
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
              controller: _filterController,
              label: appLocalizations.proxyFilter,
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
                  return appLocalizations.urlTip(appLocalizations.iconUrl);
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
              onChanged: (value) => setState(() => _disableUdp = value),
            ),
            switchField(
              label: appLocalizations.hideFromList,
              value: _hidden,
              onChanged: (value) => setState(() => _hidden = value),
            ),
            switchField(
              label: appLocalizations.includeAll,
              value: _includeAll,
              onChanged: (value) => setState(() => _includeAll = value),
            ),
            switchField(
              label: appLocalizations.includeAllProxies,
              value: _includeAllProxies,
              onChanged: (value) => setState(() => _includeAllProxies = value),
            ),
            switchField(
              label: appLocalizations.includeAllProxyProviders,
              value: _includeAllProviders,
              onChanged: (value) =>
                  setState(() => _includeAllProviders = value),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRulesView extends ConsumerWidget {
  final int profileId;

  const CustomRulesView({super.key, required this.profileId});

  void _update(WidgetRef ref, List<Rule> rules) {
    ref.read(profilesProvider.notifier).updateProfile(profileId, (profile) {
      return profile.copyWith(customRules: rules);
    });
  }

  Future<void> _edit(BuildContext context, WidgetRef ref, [Rule? rule]) async {
    final result = await globalState.showCommonDialog<Rule>(
      child: CustomRuleDialog(rule: rule),
    );
    if (result == null) {
      return;
    }
    final rules = List<Rule>.from(
      ref.read(profileProvider(profileId))?.customRules ?? [],
    );
    if (rule == null) {
      rules.add(result);
    } else {
      final index = rules.indexOf(rule);
      if (index == -1) {
        return;
      }
      rules[index] = result;
    }
    _update(ref, rules);
  }

  Future<void> _delete(BuildContext context, WidgetRef ref, Rule rule) async {
    final confirmed = await globalState.showMessage(
      message: TextSpan(
        text: appLocalizations.deleteMultipTip(appLocalizations.rule),
      ),
    );
    if (confirmed != true || !context.mounted) {
      return;
    }
    final rules = ref.read(profileProvider(profileId))?.customRules ?? [];
    _update(ref, rules.where((item) => item != rule).toList());
  }

  void _reorder(WidgetRef ref, int oldIndex, int newIndex) {
    final rules = List<Rule>.from(
      ref.read(profileProvider(profileId))?.customRules ?? [],
    );
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final rule = rules.removeAt(oldIndex);
    rules.insert(newIndex, rule);
    _update(ref, rules);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rules =
        ref.watch(profileProvider(profileId))?.customRules ?? const <Rule>[];
    return CommonScaffold(
      title: appLocalizations.rule,
      actions: [
        IconButton(
          tooltip: appLocalizations.add,
          onPressed: () => _edit(context, ref),
          icon: const Icon(Icons.add),
        ),
      ],
      body: rules.isEmpty
          ? NullStatus(label: appLocalizations.ruleEmpty)
          : ReorderableListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              buildDefaultDragHandles: false,
              itemCount: rules.length,
              itemBuilder: (context, index) {
                final rule = rules[index];
                return ReorderableDelayedDragStartListener(
                  key: ObjectKey(rule),
                  index: index,
                  child: ListItem(
                    title: Text(
                      rule.value,
                      style: context.textTheme.bodyMedium?.toJetBrainsMono,
                    ),
                    onTap: () => _edit(context, ref, rule),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: appLocalizations.delete,
                          onPressed: () => _delete(context, ref, rule),
                          icon: const Icon(Icons.delete_outline),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.drag_handle),
                        ),
                      ],
                    ),
                  ),
                );
              },
              onReorder: (oldIndex, newIndex) {
                _reorder(ref, oldIndex, newIndex);
              },
            ),
    );
  }
}

class CustomRuleDialog extends StatefulWidget {
  final Rule? rule;

  const CustomRuleDialog({super.key, this.rule});

  @override
  State<CustomRuleDialog> createState() => _CustomRuleDialogState();
}

class _CustomRuleDialogState extends State<CustomRuleDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.rule?.value ?? '');
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    final value = _controller.text.trim();
    final rule = widget.rule?.copyWith(value: value) ?? Rule.value(value);
    Navigator.of(context).pop(rule);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: widget.rule == null
          ? appLocalizations.addRule
          : appLocalizations.editRule,
      actions: [
        TextButton(onPressed: _submit, child: Text(appLocalizations.confirm)),
      ],
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          minLines: 2,
          maxLines: 6,
          autofocus: true,
          inputFormatters: TextInputLimits.limit(TextInputLimits.rule),
          decoration: InputDecoration(
            labelText: appLocalizations.content,
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return appLocalizations.emptyTip(appLocalizations.rule);
            }
            return null;
          },
          onFieldSubmitted: (_) => _submit(),
        ),
      ),
    );
  }
}

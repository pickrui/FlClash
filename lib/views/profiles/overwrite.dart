// ignore_for_file: deprecated_member_use

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/features/overwrite/proxy_chain.dart';
import 'package:fl_clash/features/overwrite/rule.dart';
import 'package:fl_clash/features/overwrite/routing_draft.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/database.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/config/scripts.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'custom_overwrite.dart';

class OverwriteView extends ConsumerStatefulWidget {
  final int profileId;

  const OverwriteView({super.key, required this.profileId});

  @override
  ConsumerState<OverwriteView> createState() => _OverwriteViewState();
}

class _OverwriteViewState extends ConsumerState<OverwriteView> {
  bool _checking = false;

  Future<void> _checkAndApply() async {
    final profile = ref.read(profileProvider(widget.profileId));
    if (profile == null || _checking) return;
    setState(() => _checking = true);
    try {
      final error = await validateCustomRoutingDraft(ref, profile);
      if (!mounted) return;
      if (error.isNotEmpty) {
        globalState.showMessage(message: TextSpan(text: error));
        return;
      }
      if (ref.read(currentProfileIdProvider) == profile.id) {
        final applied = await appController.applyProfile(force: true);
        if (!mounted || ref.read(currentProfileIdProvider) != profile.id) {
          return;
        }
        final latest = await ref.read(setupStateProvider(profile.id).future);
        if (!mounted || ref.read(currentProfileIdProvider) != profile.id) {
          return;
        }
        final lastApplied = globalState.lastSetupState;
        final isApplied =
            applied && lastApplied != null && !latest.needSetup(lastApplied);
        if (!mounted) return;
        context.showNotifier(
          isApplied
              ? appLocalizations.routingApplied
              : appLocalizations.routingApplyFailed,
        );
      } else {
        context.showNotifier(appLocalizations.routingChecked);
      }
    } catch (error) {
      if (mounted) context.showNotifier(error.toString());
    } finally {
      if (mounted) setState(() => _checking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: appLocalizations.override,
      actions: [
        IconButton(
          tooltip: appLocalizations.checkRouting,
          onPressed: _checking ? null : _checkAndApply,
          icon: _checking
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.fact_check_outlined),
        ),
      ],
      body: CustomScrollView(
        slivers: [
          OverwriteModeSelector(profileId: widget.profileId),
          if (ref.watch(
                patchClashConfigProvider.select((config) => config.mode),
              ) !=
              Mode.rule)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  appLocalizations.rulesRequireRuleMode,
                  style: TextStyle(color: context.colorScheme.error),
                ),
              ),
            ),
          ProfileProxyChainsContent(profileId: widget.profileId),
          _Content(widget.profileId),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    appController.autoApplyProfile();
  }
}

class OverwriteModeSelector extends ConsumerStatefulWidget {
  final int profileId;

  @visibleForTesting
  final Future<String> Function(WidgetRef, Profile) validator;

  const OverwriteModeSelector({
    super.key,
    required this.profileId,
    this.validator = validateCustomRoutingDraft,
  });

  @override
  ConsumerState<OverwriteModeSelector> createState() =>
      _OverwriteModeSelectorState();
}

class _OverwriteModeSelectorState extends ConsumerState<OverwriteModeSelector> {
  OverwriteType? _checkingType;
  int _validationId = 0;

  @override
  void didUpdateWidget(covariant OverwriteModeSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.profileId != widget.profileId) {
      _validationId++;
      _checkingType = null;
    }
  }

  String _getTitle(OverwriteType type) {
    return switch (type) {
      OverwriteType.standard => appLocalizations.standard,
      OverwriteType.script => appLocalizations.script,
      OverwriteType.custom => appLocalizations.overwriteTypeCustom,
      OverwriteType.merge => appLocalizations.overwriteTypeMerge,
    };
  }

  IconData _getIcon(OverwriteType type) {
    return switch (type) {
      OverwriteType.standard => Icons.stars,
      OverwriteType.script => Icons.rocket,
      OverwriteType.custom => Icons.dashboard_customize,
      OverwriteType.merge => Icons.layers_outlined,
    };
  }

  String _getDesc(OverwriteType type) {
    return switch (type) {
      OverwriteType.standard => appLocalizations.standardModeDesc,
      OverwriteType.script => appLocalizations.scriptModeDesc,
      OverwriteType.custom => appLocalizations.overwriteTypeCustomDesc,
      OverwriteType.merge => appLocalizations.overwriteTypeMergeDesc,
    };
  }

  void _showError(String error) {
    globalState.showMessage(
      context: context,
      message: TextSpan(text: error),
    );
  }

  Future<void> _handleChangeType(OverwriteType type) async {
    final profileId = widget.profileId;
    final original = ref.read(profileProvider(profileId));
    if (_checkingType != null ||
        original == null ||
        original.overwriteType == type) {
      return;
    }
    final validationId = ++_validationId;
    if (type == OverwriteType.custom || type == OverwriteType.merge) {
      setState(() => _checkingType = type);
      try {
        final error = await widget.validator(
          ref,
          original.copyWith(overwriteType: type),
        );
        if (!mounted || validationId != _validationId) return;
        if (ref.read(profileProvider(profileId)) != original) {
          _showError(appLocalizations.routingChanged);
          return;
        }
        if (error.isNotEmpty) {
          _showError(error);
          return;
        }
      } catch (error) {
        if (mounted && validationId == _validationId) {
          _showError(error.toString());
        }
        return;
      } finally {
        if (mounted && validationId == _validationId) {
          setState(() => _checkingType = null);
        }
      }
    }
    ref.read(profilesProvider.notifier).updateProfile(profileId, (state) {
      return state.copyWith(overwriteType: type);
    });
  }

  @override
  Widget build(BuildContext context) {
    final overwriteType = ref.watch(overwriteTypeProvider(widget.profileId));
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoHeader(info: Info(label: appLocalizations.overrideMode)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 16,
              children: [
                for (final type in [
                  OverwriteType.standard,
                  OverwriteType.merge,
                  OverwriteType.custom,
                  OverwriteType.script,
                ])
                  CommonCard(
                    key: ValueKey('overwrite-mode-${type.name}'),
                    isSelected: overwriteType == type,
                    onPressed: _checkingType != null
                        ? null
                        : () => _handleChangeType(type),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (_checkingType == type)
                            const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          else
                            Icon(_getIcon(type)),
                          const SizedBox(width: 8),
                          Flexible(child: Text(_getTitle(type))),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _getDesc(overwriteType),
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant.opacity80,
              ),
            ),
          ),
          if (overwriteType != OverwriteType.custom)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextButton.icon(
                key: const Key('edit-custom-routing'),
                onPressed: _checkingType != null
                    ? null
                    : () => BaseNavigator.push(
                        context,
                        CustomOverwriteDraftView(profileId: widget.profileId),
                      ),
                icon: const Icon(Icons.edit_outlined),
                label: Text(appLocalizations.editCustomRouting),
              ),
            ),
        ],
      ),
    );
  }
}

class _Content extends ConsumerWidget {
  final int profileId;

  const _Content(this.profileId);

  @override
  Widget build(BuildContext context, ref) {
    final overwriteType = ref.watch(overwriteTypeProvider(profileId));
    return switch (overwriteType) {
      OverwriteType.standard => _StandardContent(profileId),
      OverwriteType.script => _ScriptContent(profileId),
      OverwriteType.custom => CustomOverwriteContent(profileId: profileId),
      OverwriteType.merge => SliverMainAxisGroup(
        slivers: [
          CustomOverwriteContent(profileId: profileId, merge: true),
          _StandardContent(profileId),
        ],
      ),
    };
  }
}

class _StandardContent extends ConsumerStatefulWidget {
  final int profileId;

  const _StandardContent(this.profileId);

  @override
  ConsumerState createState() => __StandardContentState();
}

class __StandardContentState extends ConsumerState<_StandardContent> {
  final _key = utils.id;

  Future<void> _handleAddOrUpdate([Rule? rule]) async {
    final res = await globalState.showCommonDialog<Rule>(
      child: AddOrEditRuleDialog(rule: rule),
    );
    if (res == null) {
      return;
    }
    ref.read(profileAddedRulesProvider(widget.profileId).notifier).put(res);
  }

  void _handleSelected(int ruleId) {
    ref.read(selectedItemsProvider(_key).notifier).update((selectedRules) {
      final newSelectedRules = Set<int>.from(selectedRules)
        ..addOrRemove(ruleId);
      return newSelectedRules;
    });
  }

  void _handleSelectAll() {
    final ids =
        ref
            .read(profileAddedRulesProvider(widget.profileId))
            .value
            ?.map((item) => item.id)
            .toSet() ??
        {};
    ref.read(selectedItemsProvider(_key).notifier).update((selected) {
      return selected.containsAll(ids) ? {} : ids;
    });
  }

  Future<void> _handleDelete() async {
    final res = await globalState.showMessage(
      title: appLocalizations.tip,
      message: TextSpan(
        text: appLocalizations.deleteMultipTip(appLocalizations.rule),
      ),
    );
    if (res != true) {
      return;
    }
    final selectedRules = ref.read(selectedItemsProvider(_key));
    ref
        .read(profileAddedRulesProvider(widget.profileId).notifier)
        .delAll(selectedRules.cast<int>());
    ref.read(selectedItemsProvider(_key).notifier).value = {};
  }

  @override
  Widget build(BuildContext context) {
    final addedRules =
        ref.watch(profileAddedRulesProvider(widget.profileId)).value ?? [];
    final selectedRules = ref.watch(selectedItemsProvider(_key));
    return CommonPopScope(
      onPop: (_) {
        if (selectedRules.isNotEmpty) {
          ref.read(selectedItemsProvider(_key).notifier).value = {};
          return false;
        }
        Navigator.of(context).pop();
        return false;
      },
      child: SliverMainAxisGroup(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: Column(
              children: [
                InfoHeader(
                  info: Info(label: appLocalizations.addedRules),
                  actions: [
                    if (selectedRules.isNotEmpty) ...[
                      CommonMinIconButtonTheme(
                        child: IconButton.filledTonal(
                          onPressed: () {
                            _handleDelete();
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    CommonMinFilledButtonTheme(
                      child: selectedRules.isNotEmpty
                          ? FilledButton(
                              onPressed: () {
                                _handleSelectAll();
                              },
                              child: Text(appLocalizations.selectAll),
                            )
                          : FilledButton.tonal(
                              onPressed: () {
                                _handleAddOrUpdate();
                              },
                              child: Text(appLocalizations.add),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          Consumer(
            builder: (_, ref, _) {
              return SliverReorderableList(
                itemCount: addedRules.length,
                itemBuilder: (_, index) {
                  final rule = addedRules[index];
                  return ReorderableDelayedDragStartListener(
                    key: ObjectKey(rule),
                    index: index,
                    child: RuleItem(
                      isEditing: selectedRules.isNotEmpty,
                      isSelected: selectedRules.contains(rule.id),
                      rule: rule,
                      onSelected: () {
                        _handleSelected(rule.id);
                      },
                      onEdit: (rule) {
                        _handleAddOrUpdate(rule);
                      },
                    ),
                  );
                },
                onReorderItem: ref
                    .read(profileAddedRulesProvider(widget.profileId).notifier)
                    .order,
              );
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: CommonCard(
                padding: EdgeInsets.zero,
                radius: 18,
                child: ListTile(
                  minTileHeight: 0,
                  minVerticalPadding: 0,
                  titleTextStyle: context.textTheme.bodyMedium?.toJetBrainsMono,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          appLocalizations.controlGlobalAddedRules,
                          style: context.textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
                onPressed: () {
                  BaseNavigator.push(
                    context,
                    _EditGlobalAddedRules(profileId: widget.profileId),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScriptContent extends ConsumerWidget {
  final int profileId;

  const _ScriptContent(this.profileId);

  void _handleChange(WidgetRef ref, int scriptId) {
    ref.read(profilesProvider.notifier).updateProfile(profileId, (state) {
      return state.copyWith(
        scriptId: state.scriptId == scriptId ? null : scriptId,
      );
    });
  }

  @override
  Widget build(BuildContext context, ref) {
    final scriptId = ref.watch(
      profileProvider(profileId).select((state) => state?.scriptId),
    );
    final scripts = ref.watch(scriptsProvider).value ?? [];
    return SliverMainAxisGroup(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverToBoxAdapter(
          child: Column(
            children: [
              InfoHeader(info: Info(label: appLocalizations.overrideScript)),
            ],
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        Consumer(
          builder: (_, ref, _) {
            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList.builder(
                itemCount: scripts.length,
                itemBuilder: (_, index) {
                  final script = scripts[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: CommonCard(
                      padding: EdgeInsets.zero,
                      type: CommonCardType.filled,
                      radius: 18,
                      child: ListTile(
                        minLeadingWidth: 0,
                        minTileHeight: 0,
                        minVerticalPadding: 16,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                        ),
                        title: Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Radio(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity.compact,
                                toggleable: true,
                                value: script.id,
                                groupValue: scriptId,
                                onChanged: (_) {
                                  _handleChange(ref, script.id);
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(child: Text(script.label)),
                          ],
                        ),
                        onTap: () {
                          _handleChange(ref, script.id);
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: CommonCard(
              padding: EdgeInsets.zero,
              radius: 18,
              child: ListTile(
                minTileHeight: 0,
                minVerticalPadding: 0,
                titleTextStyle: context.textTheme.bodyMedium?.toJetBrainsMono,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        appLocalizations.goToConfigureScript,
                        style: context.textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward, size: 18),
                  ],
                ),
              ),
              onPressed: () {
                BaseNavigator.push(context, const ScriptsView());
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _EditGlobalAddedRules extends ConsumerWidget {
  final int profileId;

  const _EditGlobalAddedRules({required this.profileId});

  void _handleChange(WidgetRef ref, bool status, int ruleId) {
    if (status) {
      ref.read(profileDisabledRuleIdsProvider(profileId).notifier).put(ruleId);
    } else {
      ref.read(profileDisabledRuleIdsProvider(profileId).notifier).del(ruleId);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final disabledRuleIds =
        ref.watch(profileDisabledRuleIdsProvider(profileId)).value ?? [];
    final rules = ref.watch(globalRulesProvider).value ?? [];
    return BaseScaffold(
      title: appLocalizations.editGlobalRules,
      body: rules.isEmpty
          ? NullStatus(
              label: appLocalizations.nullTip(appLocalizations.rule),
              illustration: const RuleEmptyIllustration(),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final rule = rules[index];
                return RuleStatusItem(
                  status: !disabledRuleIds.contains(rule.id),
                  rule: rule,
                  onChange: (status) {
                    _handleChange(ref, !status, rule.id);
                  },
                );
              },
              itemCount: rules.length,
            ),
    );
  }
}

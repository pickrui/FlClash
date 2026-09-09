import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/features/overwrite/proxy_group_editor.dart';
import 'package:fl_clash/features/overwrite/routing_draft.dart';
import 'package:fl_clash/features/overwrite/custom_rule_editor.dart';
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

class CustomOverwriteDraftView extends StatelessWidget {
  final int profileId;

  const CustomOverwriteDraftView({super.key, required this.profileId});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: context.appLocalizations.editCustomRouting,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(context.appLocalizations.customRoutingDraftHint),
            ),
          ),
          CustomOverwriteContent(profileId: profileId),
        ],
      ),
    );
  }
}

class CustomOverwriteContent extends ConsumerWidget {
  final int profileId;

  final bool merge;

  const CustomOverwriteContent({
    super.key,
    required this.profileId,
    this.merge = false,
  });

  bool _hasSameRouting(Profile original, Profile? latest) {
    return latest != null &&
        latest.overwriteType == original.overwriteType &&
        latest.lastUpdateDate == original.lastUpdateDate &&
        latest.url == original.url &&
        proxyGroupsEquality.equals(
          latest.customProxyGroups,
          original.customProxyGroups,
        ) &&
        ruleListEquality.equals(latest.customRules, original.customRules);
  }

  Future<void> _clear(BuildContext context, WidgetRef ref) async {
    final original = ref.read(profileProvider(profileId));
    if (original == null ||
        (original.customProxyGroups.isEmpty && original.customRules.isEmpty)) {
      return;
    }
    final confirmed = await globalState.showMessage(
      context: context,
      message: TextSpan(text: appLocalizations.confirmClearCustomRouting),
      confirmText: appLocalizations.clearCustomRouting,
    );
    if (confirmed != true || !context.mounted) return;
    if (!_hasSameRouting(original, ref.read(profileProvider(profileId)))) {
      context.showNotifier(appLocalizations.routingChanged);
      return;
    }
    ref.read(profilesProvider.notifier).updateProfile(profileId, (profile) {
      return profile.copyWith(customProxyGroups: [], customRules: []);
    });
  }

  Future<void> _quickFill(BuildContext context, WidgetRef ref) async {
    final original = ref.read(profileProvider(profileId));
    if (original == null) return;
    final confirmed = await globalState.showMessage(
      context: context,
      message: TextSpan(text: appLocalizations.confirmOverwriteTip),
    );
    if (confirmed != true || !context.mounted) {
      return;
    }
    if (!_hasSameRouting(original, ref.read(profileProvider(profileId)))) {
      context.showNotifier(appLocalizations.routingChanged);
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
        if (!context.mounted) return;
        if (message.isNotEmpty) {
          globalState.showNotifier(message);
          return;
        }
      }
      final latest = ref.read(profileProvider(profileId));
      if (!_hasSameRouting(original, latest)) {
        globalState.showNotifier(appLocalizations.routingChanged);
        return;
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
          child: LayoutBuilder(
            builder: (context, constraints) => InfoHeader(
              info: Info(
                label: merge
                    ? appLocalizations.personalRouting
                    : appLocalizations.custom,
              ),
              actions: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: constraints.maxWidth / 2,
                  ),
                  child: Tooltip(
                    message: appLocalizations.clearCustomRouting,
                    child: TextButton.icon(
                      key: const Key('clear-custom-routing'),
                      onPressed: groups.isEmpty && rules.isEmpty
                          ? null
                          : () => _clear(context, ref),
                      icon: const Icon(Icons.delete_sweep_outlined),
                      label: Text(
                        appLocalizations.clearCustomRouting,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (merge)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(appLocalizations.overlayHint),
            ),
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
        if (!merge)
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
    if (profile == null) return;
    Map<String, dynamic> rawConfig;
    final reservedNames = <String>{
      ...reservedOutboundNames,
      ...profile.profileProxies.map((item) => item.name),
    };
    try {
      rawConfig = await appController.getRawProfileConfig(profileId);
      if (profile.overwriteType != OverwriteType.custom) {
        reservedNames.addAll(rawProxyGroupNames(rawConfig));
      }
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
        availableMembers: customRoutingTargets(
          profile,
          rawConfig,
        ).where((name) => name != group?.name).toList(),
        availableProviders: (rawConfig['proxy-providers'] is Map)
            ? (rawConfig['proxy-providers'] as Map).keys
                  .whereType<String>()
                  .toList()
            : const [],
        validate: (result) async {
          if (!context.mounted) {
            throw ProxyGroupEditBlocked(appLocalizations.routingChanged);
          }
          final current = ref.read(profileProvider(profileId));
          if (current == null ||
              current.overwriteType != profile.overwriteType ||
              current.lastUpdateDate != profile.lastUpdateDate ||
              current.url != profile.url ||
              (group != null && !current.customProxyGroups.contains(group))) {
            throw ProxyGroupEditBlocked(appLocalizations.routingChanged);
          }
          if (group != null && group.name != result.name) {
            final String? rawReference;
            try {
              rawReference = await appController
                  .findRawProfileOutboundReference(
                    profileId,
                    group.name,
                    includeTopLevelRules:
                        current.overwriteType != OverwriteType.custom,
                    includeProxyGroups:
                        current.overwriteType != OverwriteType.custom,
                  );
            } catch (error) {
              throw ProxyGroupEditBlocked(error.toString());
            }
            if (!context.mounted) {
              throw ProxyGroupEditBlocked(appLocalizations.routingChanged);
            }
            if (rawReference != null) {
              throw ProxyGroupEditBlocked(
                appLocalizations.rawOutboundInUse(group.name, rawReference),
              );
            }
            final latest = ref.read(profileProvider(profileId));
            if (latest == null ||
                latest.overwriteType != current.overwriteType ||
                latest.lastUpdateDate != current.lastUpdateDate ||
                latest.url != current.url ||
                !proxyGroupsEquality.equals(
                  latest.customProxyGroups,
                  current.customProxyGroups,
                ) ||
                !ruleListEquality.equals(
                  latest.customRules,
                  current.customRules,
                ) ||
                !profileProxyListEquality.equals(
                  latest.profileProxies,
                  current.profileProxies,
                ) ||
                !proxyChainListEquality.equals(
                  latest.proxyChains,
                  current.proxyChains,
                )) {
              throw ProxyGroupEditBlocked(appLocalizations.routingChanged);
            }
          }
          final candidate = current.copyAndPutCustomProxyGroup(
            result,
            previous: group,
          );
          final cycle = findProxyGroupCycle(candidate.customProxyGroups);
          if (cycle != null) return appLocalizations.groupCycleError(cycle);
          final message = await validateCustomRoutingDraft(ref, candidate);
          if (message == appLocalizations.routingChanged) {
            throw ProxyGroupEditBlocked(message);
          }
          return message;
        },
      ),
    );
    if (result == null || !context.mounted) {
      return;
    }
    final latest = ref.read(profileProvider(profileId));
    if (latest == null ||
        latest.overwriteType != profile.overwriteType ||
        latest.lastUpdateDate != profile.lastUpdateDate ||
        latest.url != profile.url ||
        (group != null && !latest.customProxyGroups.contains(group))) {
      context.showNotifier(appLocalizations.routingChanged);
      return;
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
        includeProxyGroups: profile.overwriteType != OverwriteType.custom,
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
    final current = ref.read(profileProvider(profileId));
    if (current == null) return;
    final setup = await ref.read(setupStateProvider(profileId).future);
    if (!context.mounted) return;
    final latest = ref.read(profileProvider(profileId));
    if (latest == null ||
        !latest.customProxyGroups.contains(group) ||
        latest.overwriteType != profile.overwriteType ||
        latest.lastUpdateDate != profile.lastUpdateDate) {
      context.showNotifier(appLocalizations.routingChanged);
      return;
    }
    if (latest.hasCustomOutboundReferences(group.name, excludingGroup: group)) {
      context.showNotifier(appLocalizations.customOutboundInUse(group.name));
      return;
    }
    if (latest.overwriteType == OverwriteType.merge &&
        setup.addedRules.any((rule) => ruleTarget(rule.value) == group.name)) {
      context.showNotifier(appLocalizations.customOutboundInUse(group.name));
      return;
    }
    ref.read(profilesProvider.notifier).updateProfile(profileId, (profile) {
      return profile.copyAndRemoveCustomProxyGroup(group);
    });
  }

  void _reorder(
    WidgetRef ref,
    int oldIndex,
    int newIndex,
    List<ProxyGroup> expected,
  ) {
    final groups = List<ProxyGroup>.from(
      ref.read(profileProvider(profileId))?.customProxyGroups ?? [],
    );
    if (oldIndex == newIndex) return;
    if (!proxyGroupsEquality.equals(groups, expected)) {
      globalState.showNotifier(appLocalizations.routingChanged);
      return;
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
                    subtitle: Text(customProxyGroupTypeLabel(group.type)),
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
              onReorderItem: (oldIndex, newIndex) {
                _reorder(ref, oldIndex, newIndex, groups);
              },
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
    final profile = ref.read(profileProvider(profileId));
    if (profile == null) return;
    Map<String, dynamic> raw;
    try {
      raw = await appController.getRawProfileConfig(profileId);
    } catch (error) {
      if (context.mounted) context.showNotifier(error.toString());
      return;
    }
    if (!context.mounted) return;
    final result = await globalState.showCommonDialog<Rule>(
      child: CustomRuleEditorDialog(
        rule: rule,
        targets: customRoutingTargets(profile, raw),
        ruleProviders: raw['rule-providers'] is Map
            ? (raw['rule-providers'] as Map).keys.whereType<String>().toList()
            : const [],
        validate: (result) {
          if (!context.mounted) {
            return Future.value(appLocalizations.routingChanged);
          }
          final current = ref.read(profileProvider(profileId));
          if (current == null ||
              current.overwriteType != profile.overwriteType) {
            return Future.value(appLocalizations.routingChanged);
          }
          final rules = List<Rule>.from(current.customRules);
          if (rule == null) {
            rules.add(result);
          } else {
            final index = rules.indexOf(rule);
            if (index == -1) {
              return Future.value(appLocalizations.routingApplyFailed);
            }
            rules[index] = result;
          }
          return validateCustomRoutingDraft(
            ref,
            current.copyWith(customRules: rules),
          );
        },
      ),
    );
    if (result == null || !context.mounted) {
      return;
    }
    final current = ref.read(profileProvider(profileId));
    if (current == null || current.overwriteType != profile.overwriteType) {
      context.showNotifier(appLocalizations.routingChanged);
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
        context.showNotifier(appLocalizations.routingChanged);
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

  void _reorder(
    WidgetRef ref,
    int oldIndex,
    int newIndex,
    List<Rule> expected,
  ) {
    final rules = List<Rule>.from(
      ref.read(profileProvider(profileId))?.customRules ?? [],
    );
    if (oldIndex == newIndex) return;
    if (!ruleListEquality.equals(rules, expected)) {
      globalState.showNotifier(appLocalizations.routingChanged);
      return;
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
              onReorderItem: (oldIndex, newIndex) {
                _reorder(ref, oldIndex, newIndex, rules);
              },
            ),
    );
  }
}

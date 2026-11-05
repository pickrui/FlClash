import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/features/overwrite/profile_proxy.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/database.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProxyChainCandidateSection {
  final String label;
  final IconData iconData;
  final List<String> proxies;

  const ProxyChainCandidateSection({
    required this.label,
    required this.iconData,
    required this.proxies,
  });
}

class ProxyChainNodeInfo {
  final String type;
  final String? testUrl;

  const ProxyChainNodeInfo({required this.type, this.testUrl});
}

class ProxyChainRawContext {
  final List<ProxyChainCandidateSection> sections;
  final ProxyChainNameScope nameScope;
  final Map<String, ProxyChainNodeInfo> nodeInfoMap;
  final Map<String, String> existingRelations;
  final Set<String> groupNames;

  const ProxyChainRawContext({
    required this.sections,
    required this.nameScope,
    required this.nodeInfoMap,
    required this.existingRelations,
    required this.groupNames,
  });
}

Iterable<ProfileProxy> _getValidProfileProxies(
  Iterable<ProfileProxy> profileProxies,
) {
  return profileProxies.where((item) => item.isValid);
}

List<String> _addUniqueProxyNames(Set<String> seen, Iterable<String> proxies) {
  final names = <String>[];
  for (final proxy in normalizeProxyChainProxies(proxies)) {
    if (seen.add(proxy)) {
      names.add(proxy);
    }
  }
  return names;
}

ProxyChainRawContext buildProxyChainRawContext({
  required Map<String, dynamic> rawConfig,
  Iterable<ProfileProxy> profileProxies = const [],
  Iterable<String> extra = const [],
  String? customNodesLabel,
  String? otherNodesLabel,
}) {
  final validCustom = _getValidProfileProxies(profileProxies).toList();
  final proxyInfo = <String, ProxyChainNodeInfo>{};
  final existingRelations = <String, String>{};
  final rawProxies = rawConfig['proxies'];
  if (rawProxies is List) {
    for (final proxy in rawProxies.whereType<Map>()) {
      final name = proxy['name'];
      if (name is! String || name.isEmpty) continue;
      proxyInfo[name] = ProxyChainNodeInfo(
        type: proxy['type']?.toString() ?? '',
      );
      if (proxy['dialer-proxy'] case final String dialer) {
        if (dialer.isNotEmpty) existingRelations[name] = dialer;
      }
    }
  }
  for (final proxy in validCustom) {
    proxyInfo[proxy.name] = ProxyChainNodeInfo(type: proxy.type);
  }
  final groupNames = <String>{};
  final groupMembers = <String, List<String>>{};
  final groups = rawConfig['proxy-groups'];
  if (groups is List) {
    for (final group in groups.whereType<Map>()) {
      final name = group['name'];
      if (name is! String || name.isEmpty) continue;
      groupNames.add(name);
      proxyInfo[name] = ProxyChainNodeInfo(
        type: group['type']?.toString() ?? '',
        testUrl: group['url'] as String?,
      );
      final members = group['proxies'];
      groupMembers[name] = members is List
          ? members.whereType<String>().where(proxyInfo.containsKey).toList()
          : const [];
    }
  }
  final sections = <ProxyChainCandidateSection>[];
  final seen = <String>{};
  void addSection(String label, IconData icon, Iterable<String> names) {
    final proxies = _addUniqueProxyNames(seen, names);
    if (proxies.isNotEmpty) {
      sections.add(
        ProxyChainCandidateSection(
          label: label,
          iconData: icon,
          proxies: proxies,
        ),
      );
    }
  }

  addSection(
    customNodesLabel ?? appLocalizations.proxyChainCustomNodes,
    Icons.add_link,
    validCustom.map((item) => item.name),
  );
  for (final entry in groupMembers.entries) {
    addSection(entry.key, Icons.account_tree_outlined, entry.value);
  }
  addSection(
    otherNodesLabel ?? appLocalizations.proxyChainOtherNodes,
    Icons.more_horiz,
    [...proxyInfo.keys.where((name) => !groupNames.contains(name)), ...extra],
  );
  final targetNames = {
    ...proxyInfo.keys.where((name) => !groupNames.contains(name)),
  };
  return ProxyChainRawContext(
    sections: sections,
    nameScope: ProxyChainNameScope(
      targetNames: targetNames,
      dialerNames: {...targetNames, ...groupNames},
    ),
    nodeInfoMap: proxyInfo,
    existingRelations: existingRelations,
    groupNames: groupNames,
  );
}

Color _getProxyChainRoleColor(
  BuildContext context,
  int index,
  int totalLength,
) {
  if (index == 0) {
    return Colors.green;
  }
  if (index == totalLength - 1 && totalLength > 1) {
    return Colors.orange;
  }
  return context.colorScheme.primary;
}

String _getProxyChainRoleLabel(int index, int totalLength) {
  if (index == 0) {
    return appLocalizations.proxyChainEntry;
  }
  if (index == totalLength - 1 && totalLength > 1) {
    return appLocalizations.proxyChainExit;
  }
  return '${index + 1}';
}

class ProxyChainRoleBadge extends StatelessWidget {
  final int index;
  final int totalLength;

  const ProxyChainRoleBadge({
    super.key,
    required this.index,
    required this.totalLength,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getProxyChainRoleColor(context, index, totalLength);
    return Container(
      constraints: const BoxConstraints(minWidth: 42),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        _getProxyChainRoleLabel(index, totalLength),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ProxyChainPathPreview extends StatelessWidget {
  final List<String> proxies;

  const _ProxyChainPathPreview({required this.proxies});

  @override
  Widget build(BuildContext context) {
    if (proxies.isEmpty) {
      return Text(
        appLocalizations.nullTip(appLocalizations.proxies),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.bodySmall?.copyWith(
          color: context.colorScheme.onSurfaceVariant.opacity80,
        ),
      );
    }
    final children = <Widget>[];
    for (var i = 0; i < proxies.length; i++) {
      children.add(
        _ProxyChainPathChip(
          proxy: proxies[i],
          index: i,
          totalLength: proxies.length,
        ),
      );
      if (i < proxies.length - 1) {
        children.add(
          Icon(
            Icons.arrow_forward,
            size: 18,
            color: context.colorScheme.primary.opacity80,
          ),
        );
      }
    }
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: children,
    );
  }
}

class _ProxyChainPathChip extends StatelessWidget {
  final String proxy;
  final int index;
  final int totalLength;

  const _ProxyChainPathChip({
    required this.proxy,
    required this.index,
    required this.totalLength,
  });

  @override
  Widget build(BuildContext context) {
    final roleColor = _getProxyChainRoleColor(context, index, totalLength);
    final isRole = index == 0 || (index == totalLength - 1 && totalLength > 1);
    return Container(
      constraints: const BoxConstraints(maxWidth: 220),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: isRole
            ? roleColor.opacity15
            : context.colorScheme.surfaceContainerHighest,
        border: Border.all(
          color: isRole
              ? roleColor.opacity80
              : context.colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _getProxyChainRoleLabel(index, totalLength),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.labelSmall?.copyWith(
              color: isRole
                  ? roleColor
                  : context.colorScheme.onSurfaceVariant.opacity80,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              proxy,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelSmall?.toJetBrainsMono.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProxyChainItem extends StatelessWidget {
  final bool isSelected;
  final bool isEditing;
  final ProxyChain proxyChain;
  final VoidCallback onSelected;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ValueChanged<bool> onToggle;

  const ProxyChainItem({
    super.key,
    required this.isSelected,
    required this.isEditing,
    required this.proxyChain,
    required this.onSelected,
    required this.onEdit,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        color: Colors.transparent,
        child: CommonCard(
          padding: EdgeInsets.zero,
          radius: 18,
          type: CommonCardType.filled,
          isSelected: isSelected,
          onPressed: onSelected,
          child: ListTile(
            minTileHeight: 32 + globalState.measure.bodyMediumHeight,
            minVerticalPadding: 12,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            title: Text(
              proxyChain.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodyMedium?.toJetBrainsMono,
            ),
            subtitle: proxyChain.proxies.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: _ProxyChainPathPreview(
                      proxies: proxyChain.normalizedProxies,
                    ),
                  )
                : null,
            trailing: isEditing
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CommonCheckBox(
                      value: isSelected,
                      isCircle: true,
                      onChanged: (_) {
                        onSelected();
                      },
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Switch(value: proxyChain.enable, onChanged: onToggle),
                      CommonPopupBox(
                        popup: CommonPopupMenu(
                          items: [
                            PopupMenuItemData(
                              icon: Icons.edit_outlined,
                              label: appLocalizations.edit,
                              onPressed: onEdit,
                            ),
                            PopupMenuItemData(
                              danger: true,
                              icon: Icons.delete_outline,
                              label: appLocalizations.delete,
                              onPressed: onDelete,
                            ),
                          ],
                        ),
                        targetBuilder: (open) {
                          return IconButton(
                            onPressed: () {
                              open();
                            },
                            icon: const Icon(Icons.more_vert),
                          );
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class ProfileProxyChainsView extends StatefulWidget {
  final int profileId;

  const ProfileProxyChainsView({super.key, required this.profileId});

  @override
  State<ProfileProxyChainsView> createState() => _ProfileProxyChainsViewState();
}

class _ProfileProxyChainsViewState extends State<ProfileProxyChainsView> {
  @override
  void dispose() {
    super.dispose();
    appController.autoApplyProfile();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: appLocalizations.proxyChains,
      body: CustomScrollView(
        slivers: [
          ProfileProxyChainsContent(
            profileId: widget.profileId,
            showEmptyStatus: true,
            handlePop: true,
          ),
        ],
      ),
    );
  }
}

class ProfileProxyChainsContent extends ConsumerStatefulWidget {
  final int profileId;
  final bool showEmptyStatus;
  final bool handlePop;

  const ProfileProxyChainsContent({
    super.key,
    required this.profileId,
    this.showEmptyStatus = false,
    this.handlePop = false,
  });

  @override
  ConsumerState<ProfileProxyChainsContent> createState() =>
      _ProfileProxyChainsContentState();
}

class _ProfileProxyChainsContentState
    extends ConsumerState<ProfileProxyChainsContent> {
  final _proxyChainKey = utils.id;

  Future<ProxyChainRawContext> _loadRawContext({
    Iterable<String> extra = const [],
  }) async {
    final rawConfig = await appController.getProxyChainProfileConfig(
      widget.profileId,
    );
    return buildProxyChainRawContext(
      rawConfig: rawConfig,
      profileProxies:
          ref.read(profileProvider(widget.profileId))?.profileProxies ??
          const [],
      extra: extra,
    );
  }

  Set<int> _getSelectedProxyChainIds() {
    return ref
        .read(selectedItemsProvider(_proxyChainKey))
        .whereType<int>()
        .toSet();
  }

  Future<void> _handleAddOrUpdateProxyChain([ProxyChain? proxyChain]) async {
    final rawConfig = await appController.getProxyChainProfileConfig(
      widget.profileId,
    );
    if (!mounted) return;
    final profileProxies =
        ref.read(profileProvider(widget.profileId))?.profileProxies ?? [];
    final rawContext = buildProxyChainRawContext(
      rawConfig: rawConfig,
      profileProxies: profileProxies,
      extra: proxyChain?.proxies ?? [],
    );
    final res = await BaseNavigator.push<ProxyChain>(
      context,
      ProxyChainEditView(
        profileId: widget.profileId,
        proxyChain: proxyChain,
        rawConfig: rawConfig,
        candidateSections: rawContext.sections,
      ),
    );
    if (res == null) {
      return;
    }
    if (!mounted) {
      return;
    }
    final proxyChains =
        ref.read(profileProvider(widget.profileId))?.proxyChains ?? [];
    final resolved = proxyChains.copyAndPutResolvingTargetConflicts(res);
    if (!_canPutProxyChains(
      resolved.proxyChains,
      rawContext.existingRelations,
    )) {
      return;
    }
    _putProxyChains(resolved.proxyChains);
    _applyProfileChanges();
    if (_isCurrentProfile) {
      context.showNotifier(appLocalizations.proxyChainSavedAndApplied);
    }
    if (resolved.hasDisabledConflicts) {
      context.showNotifier(appLocalizations.proxyChainRelatedChainsUpdated);
    }
  }

  void _putProxyChains(List<ProxyChain> proxyChains) {
    ref.read(profilesProvider.notifier).updateProfile(widget.profileId, (
      state,
    ) {
      return state.copyWith(proxyChains: proxyChains);
    });
  }

  void _applyProfileChanges() {
    if (_isCurrentProfile) {
      appController.applyProfileDebounce(silence: true);
    }
  }

  bool get _isCurrentProfile =>
      ref.read(currentProfileIdProvider) == widget.profileId;

  bool _canPutProxyChains(
    List<ProxyChain> proxyChains,
    Map<String, String> existingRelations,
  ) {
    final conflictName = findProxyChainConflictName(
      proxyChains,
      existingRelations: existingRelations,
    );
    if (conflictName == null) {
      return true;
    }
    context.showNotifier(appLocalizations.proxyChainConflictTip(conflictName));
    return false;
  }

  void _handleProxyChainSelected(int proxyChainId) {
    ref.read(selectedItemsProvider(_proxyChainKey).notifier).update((
      selectedProxyChains,
    ) {
      final nextProxyChains = Set<int>.from(selectedProxyChains)
        ..addOrRemove(proxyChainId);
      return nextProxyChains;
    });
  }

  void _handleSelectAllProxyChains() {
    final ids =
        ref
            .read(profileProvider(widget.profileId))
            ?.proxyChains
            .map((item) => item.id)
            .toSet() ??
        {};
    ref.read(selectedItemsProvider(_proxyChainKey).notifier).update((selected) {
      return selected.containsAll(ids) ? {} : ids;
    });
  }

  Future<void> _handleDeleteProxyChains([Set<int>? proxyChainIds]) async {
    final targetProxyChainIds = proxyChainIds != null
        ? Set<int>.from(proxyChainIds)
        : _getSelectedProxyChainIds();
    if (targetProxyChainIds.isEmpty) {
      return;
    }
    final res = await globalState.showMessage(
      title: appLocalizations.tip,
      message: TextSpan(
        text: proxyChainIds == null
            ? appLocalizations.deleteMultipTip(appLocalizations.proxyChains)
            : appLocalizations.deleteTip(appLocalizations.proxyChains),
      ),
    );
    if (res != true) {
      return;
    }
    ref.read(profilesProvider.notifier).updateProfile(widget.profileId, (
      state,
    ) {
      return state.copyWith(
        proxyChains: state.proxyChains
            .where((item) => !targetProxyChainIds.contains(item.id))
            .toList(),
      );
    });
    ref.read(selectedItemsProvider(_proxyChainKey).notifier).update((
      selectedProxyChains,
    ) {
      return selectedProxyChains
          .where((item) => !targetProxyChainIds.contains(item))
          .toSet();
    });
    _applyProfileChanges();
  }

  Future<void> _handleProxyChainToggle(
    ProxyChain proxyChain,
    bool value,
  ) async {
    final nextProxyChain = proxyChain.copyWith(enable: value);
    if (value && !nextProxyChain.isValid) {
      final proxies = nextProxyChain.normalizedProxies;
      context.showNotifier(
        proxies.length < 2
            ? appLocalizations.proxyChainMinimumNodes
            : appLocalizations.existsTip(appLocalizations.proxies),
      );
      return;
    }
    final proxyChains =
        ref.read(profileProvider(widget.profileId))?.proxyChains ?? [];
    final nextProxyChains = value
        ? proxyChains.copyAndPutResolvingTargetConflicts(nextProxyChain)
        : (
            hasDisabledConflicts: false,
            proxyChains: proxyChains.copyAndPut(nextProxyChain),
          );
    final rawContext = await _loadRawContext();
    if (!mounted) return;
    if (value &&
        !_canPutProxyChains(
          nextProxyChains.proxyChains,
          rawContext.existingRelations,
        )) {
      return;
    }
    _putProxyChains(nextProxyChains.proxyChains);
    _applyProfileChanges();
    if (nextProxyChains.hasDisabledConflicts) {
      context.showNotifier(appLocalizations.proxyChainRelatedChainsUpdated);
    }
  }

  Future<void> _handleProxyChainReorder(int oldIndex, int newIndex) async {
    final proxyChains =
        ref.read(profileProvider(widget.profileId))?.proxyChains ?? [];
    final nextProxyChains = proxyChains.copyAndReorder(oldIndex, newIndex);
    final rawContext = await _loadRawContext();
    if (!mounted) return;
    final conflictName = findProxyChainConflictName(
      nextProxyChains,
      existingRelations: rawContext.existingRelations,
    );
    if (conflictName != null) {
      context.showNotifier(
        appLocalizations.proxyChainConflictTip(conflictName),
      );
      return;
    }
    ref.read(profilesProvider.notifier).updateProfile(widget.profileId, (
      state,
    ) {
      return state.copyWith(proxyChains: nextProxyChains);
    });
    _applyProfileChanges();
  }

  @override
  Widget build(BuildContext context) {
    final proxyChains =
        ref.watch(profileProvider(widget.profileId))?.proxyChains ?? [];
    final selectedProxyChains = ref.watch(
      selectedItemsProvider(_proxyChainKey),
    );
    final child = SliverMainAxisGroup(
      slivers: [
        ProfileProxiesContent(profileId: widget.profileId),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverToBoxAdapter(
          child: InfoHeader(
            info: Info(label: appLocalizations.proxyChains),
            actions: [
              if (selectedProxyChains.isNotEmpty) ...[
                CommonMinIconButtonTheme(
                  child: IconButton.filledTonal(
                    onPressed: _handleDeleteProxyChains,
                    icon: const Icon(Icons.delete),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              CommonMinFilledButtonTheme(
                child: selectedProxyChains.isNotEmpty
                    ? FilledButton(
                        onPressed: _handleSelectAllProxyChains,
                        child: Text(appLocalizations.selectAll),
                      )
                    : FilledButton.icon(
                        onPressed: () {
                          _handleAddOrUpdateProxyChain();
                        },
                        icon: const Icon(Icons.add),
                        label: Text(appLocalizations.add),
                      ),
              ),
            ],
          ),
        ),
        if (proxyChains.isNotEmpty) ...[
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverReorderableList(
            itemCount: proxyChains.length,
            itemBuilder: (_, index) {
              final proxyChain = proxyChains[index];
              return ReorderableDelayedDragStartListener(
                key: ObjectKey(proxyChain),
                index: index,
                child: ProxyChainItem(
                  isEditing: selectedProxyChains.isNotEmpty,
                  isSelected: selectedProxyChains.contains(proxyChain.id),
                  proxyChain: proxyChain,
                  onSelected: () {
                    _handleProxyChainSelected(proxyChain.id);
                  },
                  onEdit: () {
                    _handleAddOrUpdateProxyChain(proxyChain);
                  },
                  onDelete: () {
                    _handleDeleteProxyChains({proxyChain.id});
                  },
                  onToggle: (value) {
                    _handleProxyChainToggle(proxyChain, value);
                  },
                ),
              );
            },
            onReorderItem: _handleProxyChainReorder,
          ),
        ] else if (widget.showEmptyStatus)
          SliverFillRemaining(
            hasScrollBody: false,
            child: NullStatus(
              label: appLocalizations.nullTip(appLocalizations.proxyChains),
            ),
          ),
      ],
    );
    if (!widget.handlePop) {
      return child;
    }
    return CommonPopScope(
      onPop: (_) {
        if (selectedProxyChains.isNotEmpty) {
          ref.read(selectedItemsProvider(_proxyChainKey).notifier).value = {};
          return false;
        }
        Navigator.of(context).pop();
        return false;
      },
      child: child,
    );
  }
}

class ProxyChainEditView extends ConsumerStatefulWidget {
  final int profileId;
  final ProxyChain? proxyChain;
  final List<ProxyChainCandidateSection> candidateSections;
  final Map<String, dynamic> rawConfig;

  const ProxyChainEditView({
    super.key,
    required this.profileId,
    this.proxyChain,
    required this.candidateSections,
    required this.rawConfig,
  });

  @override
  ConsumerState<ProxyChainEditView> createState() => _ProxyChainEditViewState();
}

class _ProxyChainEditViewState extends ConsumerState<ProxyChainEditView> {
  final _nameController = TextEditingController();
  List<String> _proxies = [];
  late List<ProxyChainCandidateSection> _candidateSections;
  late ProxyChainNameScope _nameScope;
  late Map<String, ProxyChainNodeInfo> _nodeInfoMap;

  @override
  void initState() {
    super.initState();
    final proxyChain = widget.proxyChain;
    _nameController.text = proxyChain?.name ?? '';
    _proxies = List<String>.from(proxyChain?.proxies ?? []);
    _candidateSections = widget.candidateSections;
    _nameScope = _buildNameScope();
    _nodeInfoMap = _buildNodeInfoMap();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  bool _containsProxy(String proxyName) {
    return normalizeProxyChainProxies(_proxies).contains(proxyName.trim());
  }

  List<ProfileProxy> _getProfileProxies() {
    return ref.read(profileProvider(widget.profileId))?.profileProxies ?? [];
  }

  ProxyChainNameScope _buildNameScope() {
    return buildProxyChainRawContext(
      rawConfig: widget.rawConfig,
      profileProxies: _getProfileProxies(),
    ).nameScope;
  }

  Map<String, ProxyChainNodeInfo> _buildNodeInfoMap() {
    return buildProxyChainRawContext(
      rawConfig: widget.rawConfig,
      profileProxies: _getProfileProxies(),
    ).nodeInfoMap;
  }

  bool _validateProxies(List<String> proxies) {
    final invalidProxyName = _nameScope.getInvalidName(proxies);
    if (invalidProxyName == null) {
      return true;
    }
    context.showNotifier(
      appLocalizations.proxyChainUnavailableNodeTip(invalidProxyName),
    );
    return false;
  }

  void _appendProxy(String proxyName) {
    _proxies = [..._proxies, proxyName];
  }

  bool _addProxy(String value) {
    final proxyName = value.trim();
    if (proxyName.isEmpty) {
      return false;
    }
    if (_containsProxy(proxyName)) {
      context.showNotifier(
        appLocalizations.existsTip(appLocalizations.proxies),
      );
      return false;
    }
    if (!_validateProxies([..._proxies, proxyName])) {
      return false;
    }
    _appendProxy(proxyName);
    return true;
  }

  void _handleAdd(String value) {
    if (_addProxy(value)) {
      setState(() {});
    }
  }

  void _refreshCandidateSections() {
    final profileProxies = _getProfileProxies();
    final rawContext = buildProxyChainRawContext(
      rawConfig: widget.rawConfig,
      profileProxies: profileProxies,
      extra: _proxies,
    );
    _candidateSections = rawContext.sections;
    _nameScope = rawContext.nameScope;
    _nodeInfoMap = rawContext.nodeInfoMap;
  }

  Future<void> _handleAddProfileProxy() async {
    final res = await BaseNavigator.push<ProfileProxy>(
      context,
      const ProfileProxyEditView(),
    );
    if (res == null || !mounted) {
      return;
    }
    final proxyName = res.name;
    if (_containsProxy(proxyName)) {
      context.showNotifier(
        appLocalizations.existsTip(appLocalizations.proxies),
      );
      return;
    }
    final profileProxies =
        ref.read(profileProvider(widget.profileId))?.profileProxies ?? [];
    if (hasDuplicateProfileProxyName(profileProxies, res)) {
      context.showNotifier(
        appLocalizations.existsTip(appLocalizations.proxies),
      );
      return;
    }
    final profile = ref.read(profileProvider(widget.profileId));
    if (profile != null && hasProfileProxyCustomNameConflict(profile, res)) {
      context.showNotifier(
        appLocalizations.existsTip(appLocalizations.proxies),
      );
      return;
    }
    if (buildProxyChainRawContext(
      rawConfig: widget.rawConfig,
    ).groupNames.contains(res.name)) {
      context.showNotifier(
        appLocalizations.proxyChainUnavailableNodeTip(res.name),
      );
      return;
    }
    ref.read(profilesProvider.notifier).updateProfile(widget.profileId, (
      state,
    ) {
      return state.copyWith(
        profileProxies: state.profileProxies.copyAndPut(res),
      );
    });
    _appendProxy(proxyName);
    _refreshCandidateSections();
    setState(() {});
    appController.applyProfileDebounce(silence: true);
    context.showNotifier(appLocalizations.proxyChainNodeAdded);
  }

  void _handleDelete(String value) {
    _proxies = _proxies.where((item) => item.trim() != value).toList();
    setState(() {});
  }

  void _handleClear() {
    _proxies = [];
    setState(() {});
  }

  void _handleReorder(int oldIndex, int newIndex) {
    final proxies = List<String>.from(_proxies);
    final proxy = proxies.removeAt(oldIndex);
    proxies.insert(newIndex, proxy);
    _proxies = proxies;
    setState(() {});
  }

  void _handleSubmit() {
    final proxies = normalizeProxyChainProxies(_proxies);
    if (proxies.length < 2) {
      context.showNotifier(appLocalizations.proxyChainMinimumNodes);
      return;
    }
    if (!_validateProxies(proxies)) {
      return;
    }
    if (proxies.toSet().length != proxies.length) {
      context.showNotifier(
        appLocalizations.existsTip(appLocalizations.proxies),
      );
      return;
    }
    final proxyChain = (widget.proxyChain ?? ProxyChain.create()).copyWith(
      enable: true,
      name: _nameController.text.trim(),
      proxies: proxies,
    );
    Navigator.of(context).pop(proxyChain);
  }

  Widget _buildProxyDelay(String proxy, String? testUrl) {
    return Consumer(
      builder: (_, ref, _) {
        final delay = ref.watch(
          getDelayProvider(proxyName: proxy, testUrl: testUrl),
        );
        if (delay == null) {
          return const SizedBox.shrink();
        }
        if (delay == 0) {
          return const SizedBox.square(
            dimension: 14,
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        }
        return Text(
          delay > 0 ? '$delay ms' : 'Timeout',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.labelSmall?.copyWith(
            color: utils.getDelayColor(delay),
            fontWeight: FontWeight.w600,
          ),
        );
      },
    );
  }

  Widget _buildProxyItem({
    required String proxy,
    required int index,
    required int totalLength,
    bool isDecorator = false,
  }) {
    final nodeInfo = _nodeInfoMap[proxy];
    final role = index == 0
        ? appLocalizations.proxyChainEntry
        : index == totalLength - 1 && totalLength > 1
        ? appLocalizations.proxyChainExit
        : null;
    final nodeType = nodeInfo?.type;
    final meta = [?role, if (nodeType?.isNotEmpty == true) nodeType!];
    return ReorderableDelayedDragStartListener(
      key: ValueKey(proxy),
      index: index,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonCard(
            padding: EdgeInsets.zero,
            radius: 18,
            type: CommonCardType.filled,
            child: ListTile(
              minTileHeight: 32 + globalState.measure.bodyMediumHeight,
              minVerticalPadding: 12,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: ProxyChainRoleBadge(
                index: index,
                totalLength: totalLength,
              ),
              title: Text(
                proxy,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodyMedium?.toJetBrainsMono,
              ),
              subtitle: meta.isEmpty
                  ? null
                  : Text(
                      meta.join(' · '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant.opacity80,
                      ),
                    ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildProxyDelay(proxy, nodeInfo?.testUrl),
                  if (nodeInfo != null) const SizedBox(width: 8),
                  Icon(
                    Icons.drag_indicator,
                    color: context.colorScheme.onSurfaceVariant.opacity80,
                  ),
                  IconButton(
                    onPressed: isDecorator
                        ? null
                        : () {
                            _handleDelete(proxy);
                          },
                    color: context.colorScheme.error,
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ),
            ),
          ),
          if (index < totalLength - 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Icon(
                Icons.arrow_downward,
                size: 20,
                color: context.colorScheme.primary.opacity80,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildChainHint() {
    final isWarning = _proxies.length == 1;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CommonCard(
        type: CommonCardType.filled,
        radius: 18,
        child: ListTile(
          minTileHeight: 64,
          leading: Icon(
            isWarning ? Icons.warning_amber_rounded : Icons.info_outline,
            color: isWarning
                ? context.colorScheme.error
                : context.colorScheme.primary,
          ),
          title: Text(
            isWarning
                ? appLocalizations.proxyChainMinimumNodesHint
                : appLocalizations.proxyChainInstruction,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCandidateItem({
    required String proxy,
    required IconData iconData,
    required int index,
    required int totalLength,
  }) {
    return CommonInputListItem(
      isFirst: index == 0,
      isLast: index == totalLength - 1,
      onPressed: () {
        _handleAdd(proxy);
      },
      leading: Icon(iconData),
      title: Text(
        proxy,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.bodyMedium?.toJetBrainsMono,
      ),
      trailing: const Icon(Icons.add),
    );
  }

  List<ProxyChainCandidateSection> _getVisibleCandidateSections(
    List<String> selectedProxies,
  ) {
    return _candidateSections
        .map((section) {
          final proxies = section.proxies.where((item) {
            return !selectedProxies.contains(item);
          }).toList();
          return ProxyChainCandidateSection(
            label: section.label,
            iconData: section.iconData,
            proxies: proxies,
          );
        })
        .where((section) => section.proxies.isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final selectedProxies = normalizeProxyChainProxies(_proxies);
    final candidateSections = _getVisibleCandidateSections(selectedProxies);
    final canSubmit = selectedProxies.length >= 2;
    return CommonScaffold(
      title: appLocalizations.proxyChains,
      actions: [
        CommonMinIconButtonTheme(
          child: IconButton.filled(
            style:
                IconButton.styleFrom(
                  backgroundColor: canSubmit ? Colors.green : null,
                  foregroundColor: canSubmit ? Colors.white : null,
                ).copyWith(
                  mouseCursor: WidgetStatePropertyAll(
                    canSubmit
                        ? SystemMouseCursors.click
                        : SystemMouseCursors.basic,
                  ),
                ),
            onPressed: canSubmit ? _handleSubmit : null,
            icon: const Icon(Icons.check),
          ),
        ),
        const SizedBox(width: 8),
      ],
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                children: [
                  CommonCard(
                    padding: EdgeInsets.zero,
                    type: CommonCardType.filled,
                    radius: 18,
                    child: ListTile(
                      minTileHeight: 64,
                      leading: Icon(
                        Icons.warning_amber_rounded,
                        color: context.colorScheme.error,
                      ),
                      title: Text(appLocalizations.proxyChainWarning),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _nameController,
                    inputFormatters: TextInputLimits.limit(
                      TextInputLimits.groupName,
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: appLocalizations.name,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: InfoHeader(
              info: Info(label: appLocalizations.proxyChainSelectedNodes),
              actions: [
                CommonMinFilledButtonTheme(
                  child: FilledButton.icon(
                    onPressed: _handleAddProfileProxy,
                    icon: const Icon(Icons.add_link),
                    label: Text(appLocalizations.addProxyChainNode),
                  ),
                ),
                if (_proxies.isNotEmpty) const SizedBox(width: 8),
                if (_proxies.isNotEmpty)
                  CommonMinIconButtonTheme(
                    child: IconButton.filledTonal(
                      tooltip: appLocalizations.clearProxyChain,
                      onPressed: _handleClear,
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: _buildChainHint()),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          if (_proxies.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CommonCard(
                  type: CommonCardType.filled,
                  radius: 18,
                  child: ListTile(
                    minTileHeight: 64,
                    title: Text(
                      appLocalizations.proxyChainEmpty,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant.opacity80,
                      ),
                    ),
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverReorderableList(
                itemCount: _proxies.length,
                itemBuilder: (context, index) {
                  return _buildProxyItem(
                    proxy: _proxies[index],
                    index: index,
                    totalLength: _proxies.length,
                  );
                },
                proxyDecorator: (child, index, animation) {
                  return commonProxyDecorator(
                    _buildProxyItem(
                      proxy: _proxies[index],
                      index: index,
                      totalLength: _proxies.length,
                      isDecorator: true,
                    ),
                    index,
                    animation,
                  );
                },
                onReorderItem: _handleReorder,
              ),
            ),
          if (candidateSections.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: CommonCard(
                  type: CommonCardType.filled,
                  radius: 18,
                  child: ListTile(
                    minTileHeight: 64,
                    title: Text(
                      appLocalizations.nullTip(appLocalizations.proxies),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant.opacity80,
                      ),
                    ),
                  ),
                ),
              ),
            )
          else ...[
            SliverToBoxAdapter(
              child: InfoHeader(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                info: Info(
                  label: appLocalizations.proxyChainAvailableNodes,
                  iconData: Icons.list_alt_outlined,
                ),
              ),
            ),
            for (final section in candidateSections) ...[
              SliverToBoxAdapter(
                child: InfoHeader(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  info: Info(label: section.label, iconData: section.iconData),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList.builder(
                  itemCount: section.proxies.length,
                  itemBuilder: (context, index) {
                    return _buildCandidateItem(
                      proxy: section.proxies[index],
                      iconData: section.iconData,
                      index: index,
                      totalLength: section.proxies.length,
                    );
                  },
                ),
              ),
            ],
          ],
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }
}

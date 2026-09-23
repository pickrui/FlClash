import 'dart:convert';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/providers/installed_apps.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<String> parsePackageNames(String text) {
  return LineSplitter.split(text)
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty)
      .toSet()
      .toList();
}

class AccessView extends ConsumerStatefulWidget {
  const AccessView({super.key});

  @override
  ConsumerState<AccessView> createState() => _AccessViewState();
}

class _AccessViewState extends ConsumerState<AccessView>
    with WidgetsBindingObserver {
  final GlobalKey<CommonScaffoldState> _scaffoldKey = GlobalKey();
  late ScrollController _controller;
  List<String>? _pinedList;
  bool _isInit = false;
  AccessControlMode? _lastMode;

  bool _requestingPermission = false;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    WidgetsBinding.instance.addObserver(this);
    final accessControl = ref
        .read(vpnSettingProvider.select((state) => state.accessControlProps))
        .copyWith();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(accessControlStateProvider.notifier).value = accessControl;
      _isInit = true;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _reloadPackages();
  }

  void _reloadPackages() {
    ref.read(installedAppsAppProvider)?.clearPackageIconCache();
    ref.invalidate(installedAppsProvider);
  }

  List<Package> get _loadedPackages {
    final result = ref.read(installedAppsProvider);
    if (result.isLoading ||
        result.hasError ||
        result.value?.permissionGranted != true) {
      return const [];
    }
    return result.value!.packages;
  }

  Future<void> _requestPermission() async {
    if (_requestingPermission) return;
    setState(() => _requestingPermission = true);
    var granted = false;
    try {
      granted =
          await ref
              .read(installedAppsAppProvider)
              ?.requestInstalledAppsPermission() ??
          false;
    } catch (_) {
      granted = false;
    } finally {
      if (mounted) {
        setState(() {
          _requestingPermission = false;
          _permissionDenied = !granted;
        });
        _reloadPackages();
      }
    }
  }

  Future<void> _openSettings() async {
    try {
      final opened =
          await ref.read(installedAppsAppProvider)?.openAppSettings() ?? false;
      if (mounted && !opened) setState(() => _permissionDenied = true);
    } catch (_) {
      if (mounted) setState(() => _permissionDenied = true);
    }
  }

  Widget _buildSelectedAllButton({
    required bool isSelectedAll,
    required List<String> allValueList,
  }) {
    void onPressed() {
      ref.read(accessControlStateProvider.notifier).update((state) {
        final newSet = Set<String>.from(state.currentList);
        final isSelectedAll = newSet.containsAll(allValueList);
        if (isSelectedAll) {
          newSet.removeAll(allValueList);
        } else {
          newSet.addAll(allValueList);
        }
        return state.copyWithNewList(newSet.toList());
      });
    }

    return FadeRotationScaleBox(
      alignment: Alignment.centerRight,
      child: isSelectedAll
          ? FloatingActionButton.extended(
              key: const ValueKey(true),
              onPressed: onPressed,
              label: Text(appLocalizations.cancelSelectAll),
              icon: const Icon(Icons.deselect),
            )
          : FloatingActionButton.extended(
              key: const ValueKey(false),
              tooltip: appLocalizations.selectAll,
              onPressed: onPressed,
              label: Text(appLocalizations.selectAll),
              icon: const Icon(Icons.select_all),
            ),
    );
  }

  Future<void> _intelligentSelected() async {
    final commonAction = context.commonAction;

    final packageNames = _loadedPackages
        .map((item) => item.packageName)
        .toList();
    if (packageNames.isEmpty) {
      return;
    }
    final api = ref.read(installedAppsAppProvider);
    if (api == null) return;
    final selected = await commonAction.loadingRun<List<String>>(
      api.getChinaPackageNames,
      tag: LoadingTag.access,
    );
    if (!mounted || selected == null || _loadedPackages.isEmpty) return;
    final selectedPackageNames = selected.toSet();
    final acceptList = packageNames
        .where((item) => !selectedPackageNames.contains(item))
        .toList();
    final rejectList = packageNames
        .where((item) => selectedPackageNames.contains(item))
        .toList();
    ref
        .read(accessControlStateProvider.notifier)
        .update(
          (state) =>
              state.copyWith(acceptList: acceptList, rejectList: rejectList),
        );
  }

  Future<void> _handleToSetting() async {
    await showSheet<int>(
      context: context,
      props: const SheetProps(isScrollControlled: true),
      builder: (_, type) {
        return AdaptiveSheetScaffold(
          type: type,
          body: const AccessControlPanel(),
          title: appLocalizations.accessControlSettings,
        );
      },
    );
  }

  void _handleSelected(String packageName) {
    ref.read(accessControlStateProvider.notifier).update((state) {
      final newSet = Set<String>.from(state.currentList)
        ..addOrRemove(packageName);
      return state.copyWithNewList(newSet.toList());
    });
  }

  void _handleToggle() {
    ref.read(accessControlStateProvider.notifier).update((state) {
      return state.copyWith(enable: !state.enable);
    });
  }

  void _handleSearch() {
    _scaffoldKey.currentState?.handleToSearch();
  }

  Future<void> _handleBack() async {
    final res = await globalState.showMessage(
      title: appLocalizations.tip,
      message: TextSpan(text: appLocalizations.saveChanges),
    );
    if (res == true) {
      _handleSave();
    }
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void _handleSave() {
    final accessControl = ref.read(accessControlStateProvider);
    ref
        .read(vpnSettingProvider.notifier)
        .update((state) => state.copyWith(accessControlProps: accessControl));
  }

  Widget _buildConfirm() {
    return Consumer(
      builder: (_, ref, child) {
        final accessControl = ref.watch(accessControlStateProvider);
        final noSave = ref.watch(
          vpnSettingProvider.select(
            (state) => state.accessControlProps == accessControl,
          ),
        );
        if (noSave) {
          return const SizedBox();
        }
        return child!;
      },
      child: CommonPopScope(
        onPop: (_) {
          _handleBack();
          return false;
        },
        child: CommonMinFilledButtonTheme(
          child: FilledButton.tonal(
            onPressed: _handleSave,
            child: Text(context.appLocalizations.save),
          ),
        ),
      ),
    );
  }

  Future<void> _exportToClipboard() async {
    final commonAction = context.commonAction;

    await commonAction.safeRun(() async {
      final currentList = ref.read(
        accessControlStateProvider.select((state) => state.currentList),
      );
      await Clipboard.setData(ClipboardData(text: currentList.join('\n')));
    });
  }

  Future<void> _importFormClipboard() async {
    final commonAction = context.commonAction;

    await commonAction.safeRun(() async {
      final data = await Clipboard.getData('text/plain');
      final text = data?.text;
      if (text == null) return;
      ref
          .read(accessControlStateProvider.notifier)
          .update((state) => state.copyWithNewList(parsePackageNames(text)));
    });
  }

  List<Widget> _buildActions({required bool enable}) {
    return [
      _buildConfirm(),
      CommonPopupBox(
        targetBuilder: (open) {
          return IconButton(
            onPressed: () {
              open(offset: const Offset(0, 0));
            },
            icon: const Icon(Icons.more_vert),
          );
        },
        popup: CommonPopupMenu(
          items: [
            PopupMenuItemData(
              icon: Icons.swap_horiz,
              label: enable
                  ? appLocalizations.turnOff
                  : appLocalizations.turnOn,
              onPressed: _handleToggle,
            ),
            PopupMenuItemData(
              icon: Icons.refresh,
              label: appLocalizations.refresh,
              onPressed: _reloadPackages,
            ),
            PopupMenuItemData(
              icon: Icons.search,
              label: appLocalizations.search,
              onPressed: _handleSearch,
            ),
            PopupMenuItemData(
              icon: Icons.tune,
              label: appLocalizations.settings,
              onPressed: _handleToSetting,
            ),
            PopupMenuItemData(
              icon: Icons.emergency_outlined,
              label: appLocalizations.action,
              subItems: [
                PopupMenuItemData(
                  icon: Icons.auto_awesome,
                  label: appLocalizations.intelligentSelected,
                  onPressed: _intelligentSelected,
                ),
                PopupMenuItemData(
                  icon: Icons.content_copy,
                  label: appLocalizations.clipboardExport,
                  onPressed: _exportToClipboard,
                ),
                PopupMenuItemData(
                  icon: Icons.paste,
                  label: appLocalizations.clipboardImport,
                  onPressed: _importFormClipboard,
                ),
              ],
            ),
          ],
        ),
      ),
    ];
  }

  Widget _buildContent({
    required List<Package> packages,
    required List<String> valueList,
  }) {
    final status = ref.watch(installedAppsProvider);
    if (status.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (status.hasError) {
      return _buildPackageStatus(permission: false);
    }
    if (status.value?.permissionGranted != true) {
      return _buildPackageStatus(permission: true);
    }
    return packages.isEmpty
        ? NullStatus(label: appLocalizations.noData)
        : CommonScrollBar(
            controller: _controller,
            child: ListView.builder(
              controller: _controller,
              itemCount: packages.length,
              itemExtent: 72,
              itemBuilder: (_, index) {
                final package = packages[index];
                return PackageListItem(
                  key: ValueKey((package.packageName, package.lastUpdateTime)),
                  package: package,
                  value: valueList.contains(package.packageName),
                  onChanged: (_) => _handleSelected(package.packageName),
                );
              },
            ),
          );
  }

  Widget _buildPackageStatus({required bool permission}) {
    final l10n = context.appLocalizations;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                permission
                    ? l10n.installedAppsPermissionRequired
                    : l10n.installedAppsLoadFailed,
                style: context.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              if (permission) ...[
                const SizedBox(height: 12),
                Text(
                  _permissionDenied
                      ? l10n.installedAppsPermissionDeniedMessage
                      : l10n.installedAppsPermissionDesc,
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 8,
                children: [
                  FilledButton(
                    onPressed: _requestingPermission
                        ? null
                        : permission
                        ? _requestPermission
                        : _reloadPackages,
                    child: Text(
                      permission
                          ? l10n.installedAppsPermissionGrant
                          : l10n.refresh,
                    ),
                  ),
                  if (permission)
                    OutlinedButton(
                      onPressed: _requestingPermission ? null : _openSettings,
                      child: Text(l10n.settings),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBannerBar(AccessControlMode mode, int count) {
    final describe = mode == AccessControlMode.acceptSelected
        ? appLocalizations.accessControlAllowDesc
        : appLocalizations.accessControlNotAllowDesc;
    final textStyle = context.textTheme.labelLarge?.copyWith(
      color: context.colorScheme.onPrimary,
    );
    return MaterialBanner(
      content: Text(describe),
      actions: [
        Card.filled(
          color: context.colorScheme.primary,
          elevation: 0,
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(appLocalizations.selected, style: textStyle),
                const SizedBox(width: 4),
                Flexible(child: Text('$count', style: textStyle)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onSearch(String value) {
    ref.read(queryProvider(QueryTag.access).notifier).value = value;
    _pinedList = null;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loadingProvider(LoadingTag.access));
    final query = ref.watch(queryProvider(QueryTag.access)).toLowerCase();
    final installed = ref.watch(installedAppsProvider);
    final packages = installed.value?.permissionGranted == true
        ? installed.value!.packages
        : const <Package>[];
    final accessControl = ref.watch(accessControlStateProvider);
    if (_isInit) {
      if (_lastMode != accessControl.mode) {
        _lastMode = accessControl.mode;
        _pinedList = accessControl.currentList;
      } else {
        _pinedList ??= accessControl.currentList;
      }
    }
    final viewPackages = packages
        .getViewList(
          pinedList: _pinedList ?? [],
          sortType: accessControl.sort,
          isFilterNonInternetApp: accessControl.isFilterNonInternetApp,
          isFilterSystemApp: accessControl.isFilterSystemApp,
        )
        .where(
          (package) =>
              package.label.toLowerCase().contains(query) ||
              package.packageName.toLowerCase().contains(query),
        )
        .toList();
    final mode = accessControl.mode;
    final currentList = accessControl.currentList;
    final viewPackageNameList = viewPackages.map((e) => e.packageName).toList();
    final valueList = currentList.intersection(viewPackageNameList);
    return CommonScaffold(
      key: _scaffoldKey,
      isLoading: isLoading,
      searchState: AppBarSearchState(onSearch: _onSearch, autoAddSearch: false),
      title: appLocalizations.appAccessControl,
      actions: _buildActions(enable: accessControl.enable),
      body: DisabledMask(
        status: !accessControl.enable,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBannerBar(mode, valueList.length),
            const SizedBox(height: 8),
            Expanded(
              child: _buildContent(
                packages: viewPackages,
                valueList: valueList,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton:
          accessControl.enable &&
              !installed.isLoading &&
              !installed.hasError &&
              installed.value?.permissionGranted == true &&
              viewPackages.isNotEmpty
          ? _buildSelectedAllButton(
              isSelectedAll: valueList.length == viewPackageNameList.length,
              allValueList: viewPackageNameList,
            )
          : null,
    );
  }
}

class PackageListItem extends StatelessWidget {
  final Package package;
  final bool value;
  final void Function(bool?) onChanged;

  const PackageListItem({
    super.key,
    required this.package,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListItem.checkbox(
      leading: PackageIcon(packageName: package.packageName, size: 48),
      title: Text(
        package.label,
        style: const TextStyle(overflow: TextOverflow.ellipsis),
        maxLines: 1,
      ),
      subtitle: Text(
        package.packageName,
        style: const TextStyle(overflow: TextOverflow.ellipsis),
        maxLines: 1,
      ),
      delegate: CheckboxDelegate(value: value, onChanged: onChanged),
    );
  }
}

class AccessControlPanel extends ConsumerStatefulWidget {
  const AccessControlPanel({super.key});

  @override
  ConsumerState createState() => _AccessControlPanelState();
}

class _AccessControlPanelState extends ConsumerState<AccessControlPanel> {
  IconData _getIconWithAccessControlMode(AccessControlMode mode) {
    return switch (mode) {
      AccessControlMode.acceptSelected => Icons.adjust_outlined,
      AccessControlMode.rejectSelected => Icons.block_outlined,
    };
  }

  String _getTextWithAccessControlMode(AccessControlMode mode) {
    return switch (mode) {
      AccessControlMode.acceptSelected => appLocalizations.whitelistMode,
      AccessControlMode.rejectSelected => appLocalizations.blacklistMode,
    };
  }

  String _getTextWithAccessSortType(AccessSortType type) {
    return switch (type) {
      AccessSortType.none => appLocalizations.defaultText,
      AccessSortType.name => appLocalizations.name,
      AccessSortType.time => appLocalizations.time,
    };
  }

  IconData _getIconWithProxiesSortType(AccessSortType type) {
    return switch (type) {
      AccessSortType.none => Icons.sort,
      AccessSortType.name => Icons.sort_by_alpha,
      AccessSortType.time => Icons.timeline,
    };
  }

  List<Widget> _buildModeSetting() {
    return generateSection(
      isFirst: true,
      title: appLocalizations.mode,
      items: [
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          child: Consumer(
            builder: (_, ref, _) {
              final accessControlMode = ref.watch(
                accessControlStateProvider.select((state) => state.mode),
              );
              return Wrap(
                spacing: 16,
                children: [
                  for (final item in AccessControlMode.values)
                    SettingInfoCard(
                      Info(
                        label: _getTextWithAccessControlMode(item),
                        iconData: _getIconWithAccessControlMode(item),
                      ),
                      isSelected: accessControlMode == item,
                      onPressed: () {
                        ref
                            .read(accessControlStateProvider.notifier)
                            .update((state) => state.copyWith(mode: item));
                      },
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _buildSortSetting() {
    return generateSection(
      title: appLocalizations.sort,
      items: [
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          child: Consumer(
            builder: (_, ref, _) {
              final accessSortType = ref.watch(
                accessControlStateProvider.select((state) => state.sort),
              );
              return Wrap(
                spacing: 16,
                children: [
                  for (final item in AccessSortType.values)
                    SettingInfoCard(
                      Info(
                        label: _getTextWithAccessSortType(item),
                        iconData: _getIconWithProxiesSortType(item),
                      ),
                      isSelected: accessSortType == item,
                      onPressed: () {
                        ref
                            .read(accessControlStateProvider.notifier)
                            .update((state) => state.copyWith(sort: item));
                      },
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _buildSourceSetting() {
    return generateSection(
      title: appLocalizations.source,
      items: [
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          child: Consumer(
            builder: (_, ref, _) {
              final vm2 = ref.watch(
                accessControlStateProvider.select(
                  (state) => VM2(
                    state.isFilterSystemApp,
                    state.isFilterNonInternetApp,
                  ),
                ),
              );
              return Wrap(
                spacing: 16,
                children: [
                  SettingTextCard(
                    appLocalizations.systemApp,
                    isSelected: vm2.a == false,
                    onPressed: () {
                      ref
                          .read(accessControlStateProvider.notifier)
                          .update(
                            (state) =>
                                state.copyWith(isFilterSystemApp: !vm2.a),
                          );
                    },
                  ),
                  SettingTextCard(
                    appLocalizations.noNetworkApp,
                    isSelected: vm2.b == false,
                    onPressed: () {
                      ref
                          .read(accessControlStateProvider.notifier)
                          .update(
                            (state) =>
                                state.copyWith(isFilterNonInternetApp: !vm2.b),
                          );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildModeSetting(),
            ..._buildSortSetting(),
            ..._buildSourceSetting(),
          ],
        ),
      ),
    );
  }
}

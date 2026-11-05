import 'dart:ui';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/profiles/edit_profile.dart';
import 'package:fl_clash/views/profiles/override_profile.dart';
import 'package:fl_clash/views/profiles/scripts.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_profile.dart';

class ProfilesView extends StatefulWidget {
  const ProfilesView({super.key});

  @override
  State<ProfilesView> createState() => _ProfilesViewState();
}

class _ProfilesViewState extends State<ProfilesView> {
  Function? applyConfigDebounce;

  void _handleShowAddExtendPage() {
    showExtend(
      globalState.navigatorKey.currentState!.context,
      builder: (_, type) {
        return AdaptiveSheetScaffold(
          type: type,
          body: AddProfileView(
            context: globalState.navigatorKey.currentState!.context,
          ),
          title: '${appLocalizations.add}${appLocalizations.profile}',
        );
      },
    );
  }

  Future<void> _updateProfiles() async {
    final profiles = globalState.config.profiles;
    final messages = [];
    final updateProfiles = profiles.map<Future>((profile) async {
      if (profile.type == ProfileType.file) return;
      globalState.appController.setProfile(profile.copyWith(isUpdating: true));
      try {
        await globalState.appController.updateProfile(profile);
      } catch (e) {
        messages.add('${profile.label ?? profile.id}: $e \n');
        globalState.appController.setProfile(
          profile.copyWith(isUpdating: false),
        );
      }
    });
    final titleMedium = context.textTheme.titleMedium;
    await Future.wait(updateProfiles);
    if (messages.isNotEmpty) {
      globalState.showMessage(
        title: appLocalizations.tip,
        message: TextSpan(
          children: [
            for (final message in messages)
              TextSpan(text: message, style: titleMedium),
          ],
        ),
      );
    }
  }

  List<Widget> _buildActions() {
    return [
      IconButton(
        onPressed: () {
          _updateProfiles();
        },
        icon: const Icon(Icons.sync),
      ),
      IconButton(
        onPressed: () {
          showExtend(
            context,
            builder: (_, type) {
              return ScriptsView();
            },
          );
        },
        icon: Consumer(
          builder: (context, ref, _) {
            final isScriptMode = ref.watch(
              scriptStateProvider.select((state) => state.realId != null),
            );
            return Icon(
              Icons.functions,
              color: isScriptMode ? context.colorScheme.primary : null,
            );
          },
        ),
      ),
      IconButton(
        onPressed: () {
          final profiles = globalState.config.profiles;
          showSheet(
            context: context,
            builder: (_, type) {
              return ReorderableProfilesSheet(type: type, profiles: profiles);
            },
          );
        },
        icon: const Icon(Icons.sort),
        iconSize: 26,
      ),
    ];
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      heroTag: null,
      onPressed: _handleShowAddExtendPage,
      child: const Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: appLocalizations.profiles,
      floatingActionButton: _buildFAB(),
      actions: _buildActions(),
      body: Consumer(
        builder: (_, ref, _) {
          final profilesSelectorState = ref.watch(
            profilesSelectorStateProvider,
          );
          if (profilesSelectorState.profiles.isEmpty) {
            return NullStatus(label: appLocalizations.nullProfileDesc);
          }
          return Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              key: profilesStoreKey,
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 88,
              ),
              child: Grid(
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                crossAxisCount: profilesSelectorState.columns,
                children: [
                  for (
                    int i = 0;
                    i < profilesSelectorState.profiles.length;
                    i++
                  )
                    GridItem(
                      crossAxisCellCount: profilesSelectorState.profiles[i].type == ProfileType.url &&
                          profilesSelectorState.profiles[i].url.toLowerCase().contains('dler.cloud')
                          ? 2
                          : 1,
                      child: ProfileItem(
                        key: Key(profilesSelectorState.profiles[i].id),
                        profile: profilesSelectorState.profiles[i],
                        groupValue: profilesSelectorState.currentProfileId,
                        onChanged: (profileId) {
                          ref.read(currentProfileIdProvider.notifier).value =
                              profileId;
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProfileItem extends ConsumerStatefulWidget {
  final Profile profile;
  final String? groupValue;
  final void Function(String? value) onChanged;

  const ProfileItem({
    super.key,
    required this.profile,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  ConsumerState<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends ConsumerState<ProfileItem> {
  late TextEditingController _paramsController;

  @override
  void initState() {
    super.initState();
    _paramsController = TextEditingController(text: widget.profile.urlParams);
  }

  @override
  void didUpdateWidget(ProfileItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.profile.urlParams != widget.profile.urlParams) {
      if (_paramsController.text != widget.profile.urlParams) {
        _paramsController.text = widget.profile.urlParams;
      }
    }
  }

  @override
  void dispose() {
    _paramsController.dispose();
    super.dispose();
  }

  Future<void> _handleDeleteProfile(BuildContext context) async {
    final res = await globalState.showMessage(
      title: appLocalizations.tip,
      message: TextSpan(
        text: appLocalizations.deleteTip(appLocalizations.profile),
      ),
    );
    if (res != true) return;
    await globalState.appController.deleteProfile(widget.profile.id);
  }

  Future<void> _updateProfile() async {
    if (widget.profile.type == ProfileType.file) return;
    
    Profile profileToUpdate = widget.profile;
    if (_isDlerCloudProfile) {
      _saveUrlParamsIfChanged();
      final updatedProfile = globalState.config.profiles.getProfile(widget.profile.id);
      if (updatedProfile != null) {
        profileToUpdate = updatedProfile;
      }
    }
    
    final appController = globalState.appController;
    final result = await appController.safeRun(silence: false, () async {
      try {
        appController.setProfile(profileToUpdate.copyWith(isUpdating: true));
        await appController.updateProfile(profileToUpdate);
        return true;
      } catch (e) {
        appController.setProfile(profileToUpdate.copyWith(isUpdating: false));
        rethrow;
      }
    });
    
    if (result == true && mounted && context.mounted) {
      context.showNotifier('同步成功');
    }
  }


  void _handleShowEditExtendPage(BuildContext context) {
    showExtend(
      context,
      builder: (_, type) => AdaptiveSheetScaffold(
          type: type,
        body: EditProfileView(profile: widget.profile, context: context),
          title: '${appLocalizations.edit}${appLocalizations.profile}',
      ),
    );
  }

  List<Widget> _buildUrlProfileInfo(BuildContext context) {
    final subscriptionInfo = widget.profile.subscriptionInfo;
    return [
      const SizedBox(height: 8),
      if (subscriptionInfo != null)
        SubscriptionInfoView(subscriptionInfo: subscriptionInfo),
      Text(
        widget.profile.lastUpdateDate?.lastUpdateTimeDesc ?? '',
        style: context.textTheme.labelMedium?.toLighter,
      ),
    ];
  }

  List<Widget> _buildFileProfileInfo(BuildContext context) {
    return [
      const SizedBox(height: 8),
      Text(
        widget.profile.lastUpdateDate?.lastUpdateTimeDesc ?? '',
        style: context.textTheme.labelMedium?.toLight,
      ),
    ];
  }


  Future<void> _handleExportFile(BuildContext context) async {
    final profile = widget.profile;
    final res = await globalState.appController.safeRun<bool>(
      () async {
        final file = await profile.getFile();
        final value = await picker.saveFile(
          profile.label ?? profile.id,
          file.readAsBytesSync(),
        );
        return value != null;
      },
      needLoading: true,
      title: appLocalizations.tip,
    );
    if (res == true && context.mounted) {
      context.showNotifier(appLocalizations.exportSuccess);
    }
  }

  void _handlePushGenProfilePage(BuildContext context, String id) {
    BaseNavigator.push(context, OverrideProfileView(profileId: id));
  }

  bool get _isDlerCloudProfile =>
      widget.profile.type == ProfileType.url &&
      widget.profile.url.toLowerCase().contains('dler.cloud');

  void _saveUrlParamsIfChanged() {
    if (_paramsController.text != widget.profile.urlParams) {
      globalState.appController.setProfile(
        widget.profile.copyWith(urlParams: _paramsController.text),
      );
    }
  }

  Widget _buildDlerCloudParamsInput(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.tune,
            size: 16,
            color: context.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _paramsController,
              decoration: InputDecoration(
                hintText: '可选参数 (如: &type=love)',
                hintStyle: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: context.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = widget.profile;
    return CommonCard(
      isSelected: profile.id == widget.groupValue,
      onPressed: () => widget.onChanged(profile.id),
      child: ListItem(
        key: Key(profile.id),
        horizontalTitleGap: 16,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        trailing: SizedBox(
          height: 40,
          width: 40,
          child: FadeThroughBox(
            child: profile.isUpdating
                ? const Padding(
                    key: ValueKey('loading'),
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  )
                : _isDlerCloudProfile
                    ? IconButton(
                        key: const ValueKey('sync'),
                        onPressed: _updateProfile,
                        icon: const Icon(Icons.sync_alt_sharp),
                        tooltip: appLocalizations.sync,
                  )
                : CommonPopupBox(
                        key: const ValueKey('menu'),
                    popup: CommonPopupMenu(
                      items: [
                        PopupMenuItemData(
                          icon: Icons.edit_outlined,
                          label: appLocalizations.edit,
                              onPressed: () => _handleShowEditExtendPage(context),
                        ),
                            if (profile.type == ProfileType.url)
                          PopupMenuItemData(
                            icon: Icons.sync_alt_sharp,
                            label: appLocalizations.sync,
                                onPressed: _updateProfile,
                          ),
                        PopupMenuItemData(
                          icon: Icons.extension_outlined,
                          label: appLocalizations.override,
                              onPressed: () => _handlePushGenProfilePage(context, profile.id),
                        ),
                        PopupMenuItemData(
                          icon: Icons.file_copy_outlined,
                          label: appLocalizations.exportFile,
                              onPressed: () => _handleExportFile(context),
                        ),
                        PopupMenuItemData(
                          danger: true,
                          icon: Icons.delete_outlined,
                          label: appLocalizations.delete,
                              onPressed: () => _handleDeleteProfile(context),
                        ),
                      ],
                    ),
                        targetBuilder: (open) => IconButton(
                          onPressed: open,
                          icon: const Icon(Icons.more_vert),
                        ),
                  ),
          ),
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                profile.label ?? profile.id,
                style: context.textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...switch (profile.type) {
                    ProfileType.file => _buildFileProfileInfo(context),
                    ProfileType.url => _buildUrlProfileInfo(context),
                  },
                  if (_isDlerCloudProfile) _buildDlerCloudParamsInput(context),
                ],
              ),
            ],
          ),
        ),
        tileTitleAlignment: ListTileTitleAlignment.titleHeight,
      ),
    );
  }
}

class ReorderableProfilesSheet extends StatefulWidget {
  final List<Profile> profiles;
  final SheetType type;

  const ReorderableProfilesSheet({
    super.key,
    required this.profiles,
    required this.type,
  });

  @override
  State<ReorderableProfilesSheet> createState() =>
      _ReorderableProfilesSheetState();
}

class _ReorderableProfilesSheetState extends State<ReorderableProfilesSheet> {
  late List<Profile> profiles;

  @override
  void initState() {
    super.initState();
    profiles = List.from(widget.profiles);
  }

  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    final profile = profiles[index];
    return AnimatedBuilder(
      animation: animation,
      builder: (_, Widget? child) {
        final double animValue = Curves.easeInOut.transform(animation.value);
        final double scale = lerpDouble(1, 1.02, animValue)!;
        return Transform.scale(scale: scale, child: child);
      },
      child: Container(
        key: Key(profile.id),
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: CommonCard(
          type: CommonCardType.filled,
          child: ListTile(
            contentPadding: const EdgeInsets.only(right: 44, left: 16),
            title: Text(profile.label ?? profile.id),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveSheetScaffold(
      type: widget.type,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            globalState.appController.setProfiles(profiles);
          },
          icon: const Icon(Icons.save),
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.only(bottom: 32, top: 16),
        child: ReorderableListView.builder(
          buildDefaultDragHandles: false,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          proxyDecorator: proxyDecorator,
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final profile = profiles.removeAt(oldIndex);
              profiles.insert(newIndex, profile);
            });
          },
          itemBuilder: (_, index) {
            final profile = profiles[index];
            return Container(
              key: Key(profile.id),
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: CommonCard(
                type: CommonCardType.filled,
                child: ListTile(
                  contentPadding: const EdgeInsets.only(right: 16, left: 16),
                  title: Text(profile.label ?? profile.id),
                  trailing: ReorderableDragStartListener(
                    index: index,
                    child: const Icon(Icons.drag_handle),
                  ),
                ),
              ),
            );
          },
          itemCount: profiles.length,
        ),
      ),
      title: appLocalizations.profilesSort,
    );
  }
}

import 'dart:io';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/core/core.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' hide context;

@immutable
class GeoItem {
  final GeoResource type;
  final String fileName;

  const GeoItem({required this.type, required this.fileName});

  String get label => type.name;

  String get key => type.key;
}

class ResourcesView extends StatelessWidget {
  const ResourcesView({super.key});

  @override
  Widget build(BuildContext context) {
    const geoItems = <GeoItem>[
      GeoItem(type: GeoResource.GEOIP, fileName: GEOIP),
      GeoItem(type: GeoResource.GEOSITE, fileName: GEOSITE),
      GeoItem(type: GeoResource.MMDB, fileName: MMDB),
      GeoItem(type: GeoResource.ASN, fileName: ASN),
    ];

    return CommonScaffold(
      title: appLocalizations.resources,
      body: Consumer(
        builder: (_, ref, _) {
          final vm2 = ref.watch(
            patchClashConfigProvider.select(
              (state) => VM2(state.geoAutoUpdate, state.geoUpdateInterval),
            ),
          );
          return generateListView([
            ...generateSection(
              title: appLocalizations.geoOptions,
              items: [
                ListItem.switchItem(
                  title: Text(appLocalizations.geoAutoUpdate),
                  delegate: SwitchDelegate(
                    value: vm2.a,
                    onChanged: (value) {
                      ref
                          .read(patchClashConfigProvider.notifier)
                          .update(
                            (state) => state.copyWith(geoAutoUpdate: value),
                          );
                    },
                  ),
                ),
                ListItem.input(
                  title: Text(appLocalizations.geoAutoUpdateInterval),
                  trailing: Text(
                    appLocalizations.hoursCount(vm2.b),
                    style: context.textTheme.bodyMedium?.toSoftBold,
                  ),
                  delegate: InputDelegate(
                    title: appLocalizations.geoAutoUpdateInterval,
                    value: vm2.b.toString(),
                    suffixText: appLocalizations.hours,
                    maxLength: TextInputLimits.interval,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      final interval = int.tryParse(value ?? '');
                      if (interval == null ||
                          interval <= 0 ||
                          interval > maxGeoUpdateInterval) {
                        return appLocalizations.geoAutoUpdateIntervalTip;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      final interval = int.tryParse(value ?? '');
                      if (interval == null ||
                          interval <= 0 ||
                          interval > maxGeoUpdateInterval) {
                        return;
                      }
                      ref
                          .read(patchClashConfigProvider.notifier)
                          .update(
                            (state) =>
                                state.copyWith(geoUpdateInterval: interval),
                          );
                    },
                  ),
                ),
              ],
            ),
            ...generateSection(
              title: appLocalizations.geoResources,
              items: [
                for (final geoItem in geoItems)
                  GeoDataListItem(geoItem: geoItem),
              ],
            ),
          ]);
        },
      ),
    );
  }
}

class GeoDataListItem extends ConsumerStatefulWidget {
  final GeoItem geoItem;

  const GeoDataListItem({super.key, required this.geoItem});

  @override
  ConsumerState<GeoDataListItem> createState() => _GeoDataListItemState();
}

class _GeoDataListItemState extends ConsumerState<GeoDataListItem> {
  GeoItem get geoItem => widget.geoItem;

  Future<void> _updateUrl(String url, WidgetRef ref) async {
    final defaultMap = defaultGeoXUrl.toJson();
    final newUrl = await globalState.showCommonDialog<String>(
      child: UpdateGeoUrlFormDialog(
        title: geoItem.label,
        url: url,
        defaultValue: defaultMap[geoItem.key],
      ),
    );
    if (newUrl != null && newUrl != url && mounted) {
      try {
        if (!newUrl.isUrl) {
          throw 'Invalid url';
        }
        ref.read(patchClashConfigProvider.notifier).update((state) {
          final map = state.geoXUrl.toJson();
          map[geoItem.key] = newUrl;
          return state.copyWith(geoXUrl: GeoXUrl.fromJson(map));
        });
      } catch (e) {
        globalState.showMessage(
          title: geoItem.label,
          message: TextSpan(text: e.toString()),
        );
      }
    }
  }

  Future<FileInfo> _getGeoFileLastModified(String fileName) async {
    final homePath = await appPath.homeDirPath;
    final file = File(join(homePath, fileName));
    final lastModified = await file.lastModified();
    final size = await file.length();
    return FileInfo(size: size, lastModified: lastModified);
  }

  Widget _buildSubtitle() {
    final url = ref.watch(
      patchClashConfigProvider.select(
        (state) => state.geoXUrl.toJson()[geoItem.key],
      ),
    );
    if (url == null) {
      return const SizedBox();
    }
    final isUpdating = ref.watch(isUpdatingProvider(geoItem.type.updatingKey));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 6),
        FutureBuilder<FileInfo>(
          future: _getGeoFileLastModified(geoItem.fileName),
          builder: (_, snapshot) {
            final height = globalState.measure.bodyMediumHeight;
            return SizedBox(
              height: height,
              child: snapshot.data == null
                  ? SizedBox(width: height, height: height)
                  : Text(
                      snapshot.data!.desc,
                      style: context.textTheme.bodyMedium,
                    ),
            );
          },
        ),
        const SizedBox(height: 4),
        Text(url, style: context.textTheme.bodyMedium?.toLight),
        const SizedBox(height: 12),
        Wrap(
          runSpacing: 6,
          spacing: 12,
          runAlignment: WrapAlignment.center,
          children: [
            CommonChip(
              avatar: const Icon(Icons.edit),
              label: appLocalizations.edit,
              onPressed: () {
                _updateUrl(url, ref);
              },
            ),
            SizedBox(
              child: isUpdating
                  ? const SizedBox(
                      height: 30,
                      width: 30,
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : CommonChip(
                      avatar: const Icon(Icons.sync),
                      label: appLocalizations.sync,
                      onPressed: () => _handleUpdateGeoDataItem(url),
                    ),
            ),
          ],
        ),
        const SizedBox(height: 6),
      ],
    );
  }

  Future<void> _handleUpdateGeoDataItem(String url) async {
    await appController.safeRun<void>(() async {
      await updateGeoDateItem(url);
    }, silence: false);
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> updateGeoDateItem(String url) async {
    final message = await coreController.updateGeoData(
      UpdateGeoDataParams(
        geoName: geoItem.fileName,
        geoType: geoItem.label,
        url: url,
      ),
    );
    if (message.isNotEmpty) throw message;
  }

  @override
  Widget build(BuildContext context) {
    return ListItem(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      title: Text(geoItem.label),
      subtitle: _buildSubtitle(),
    );
  }
}

class UpdateGeoUrlFormDialog extends StatefulWidget {
  final String title;
  final String url;
  final String? defaultValue;

  const UpdateGeoUrlFormDialog({
    super.key,
    required this.title,
    required this.url,
    this.defaultValue,
  });

  @override
  State<UpdateGeoUrlFormDialog> createState() => _UpdateGeoUrlFormDialogState();
}

class _UpdateGeoUrlFormDialogState extends State<UpdateGeoUrlFormDialog> {
  late final TextEditingController _urlController;

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController(text: widget.url);
  }

  Future<void> _handleReset() async {
    if (widget.defaultValue == null) {
      return;
    }
    Navigator.of(context).pop<String>(widget.defaultValue);
  }

  Future<void> _handleUpdate() async {
    final url = _urlController.value.text;
    if (url.isEmpty) return;
    Navigator.of(context).pop<String>(url);
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: widget.title,
      actions: [
        if (widget.defaultValue != null &&
            _urlController.value.text != widget.defaultValue) ...[
          TextButton(
            onPressed: _handleReset,
            child: Text(appLocalizations.reset),
          ),
          const SizedBox(width: 4),
        ],
        TextButton(
          onPressed: _handleUpdate,
          child: Text(appLocalizations.submit),
        ),
      ],
      child: Wrap(
        runSpacing: 16,
        children: [
          TextField(
            maxLines: 5,
            minLines: 1,
            controller: _urlController,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }
}

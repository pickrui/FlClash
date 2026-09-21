import 'dart:convert';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/models/common.dart';
import 'package:fl_clash/models/core.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProvidersView extends ConsumerStatefulWidget {
  final SheetType type;

  const ProvidersView({super.key, required this.type});

  @override
  ConsumerState<ProvidersView> createState() => _ProvidersViewState();
}

class _ProvidersViewState extends ConsumerState<ProvidersView> {
  bool _updating = false;

  Future<void> _updateProviders([String? type]) async {
    if (_updating) return;
    setState(() => _updating = true);
    try {
      final proxiesAction = context.proxiesAction;

      final providers = ref
          .read(providersProvider)
          .where((provider) => type == null || provider.type == type);
      final results = await Future.wait(
        providers.map((provider) async {
          try {
            final message = await proxiesAction.updateProvider(provider);
            return message.isEmpty
                ? null
                : UpdatingMessage(label: provider.name, message: message);
          } catch (error) {
            return UpdatingMessage(
              label: provider.name,
              message: error.toString(),
            );
          }
        }),
      );
      proxiesAction.updateGroupsDebounce();
      final messages = results.whereType<UpdatingMessage>().toList();
      if (mounted && messages.isNotEmpty) {
        await globalState.showAllUpdatingMessagesDialog(messages);
      }
    } finally {
      if (mounted) setState(() => _updating = false);
    }
  }

  Widget _buildSectionSyncButton(String type) {
    return IconButton(
      iconSize: 20,
      visualDensity: VisualDensity.compact,
      onPressed: _updating ? null : () => _updateProviders(type),
      icon: const Icon(Icons.sync),
    );
  }

  @override
  Widget build(BuildContext context) {
    final providers = ref.watch(providersProvider);
    final proxyProviders = providers
        .where((item) => item.type == 'Proxy')
        .map((item) => ProviderItem(provider: item));
    final ruleProviders = providers
        .where((item) => item.type == 'Rule')
        .map((item) => ProviderItem(provider: item));
    final proxySection = generateSection(
      title: appLocalizations.proxyProviders,
      actions: [_buildSectionSyncButton('Proxy')],
      items: proxyProviders,
    );
    final ruleSection = generateSection(
      title: appLocalizations.ruleProviders,
      actions: [_buildSectionSyncButton('Rule')],
      items: ruleProviders,
    );
    return AdaptiveSheetScaffold(
      actions: [
        IconButton(
          onPressed: _updating ? null : () => _updateProviders(),
          icon: const Icon(Icons.sync),
        ),
      ],
      type: widget.type,
      body: generateListView([...proxySection, ...ruleSection]),
      title: appLocalizations.providers,
    );
  }
}

class ProviderItem extends StatelessWidget {
  final ExternalProvider provider;

  const ProviderItem({super.key, required this.provider});

  Future<void> _handleUpdateProvider(BuildContext context) async {
    final commonAction = context.commonAction;
    final proxiesAction = context.proxiesAction;

    if (provider.vehicleType != 'HTTP') return;
    await commonAction.safeRun(() async {
      final message = await proxiesAction.updateProvider(provider);
      if (message.isNotEmpty) throw message;
    }, silence: false);
    proxiesAction.updateGroupsDebounce();
  }

  Future<void> _handleSideLoadProvider(BuildContext context) async {
    final commonAction = context.commonAction;
    final proxiesAction = context.proxiesAction;

    await commonAction.safeRun<void>(() async {
      final message = await proxiesAction.sideLoadProvider(provider, () async {
        final platformFile = await picker.pickerFile();
        if (platformFile == null) return null;
        return utf8.decode(await platformFile.readBytes());
      });
      if (message.isNotEmpty) throw message;
    });
    proxiesAction.updateGroupsDebounce();
  }

  String _buildProviderDesc() {
    final baseInfo = provider.updateAt.lastUpdateTimeDesc;
    final count = provider.count;
    return switch (count == 0) {
      true => baseInfo,
      false => '$baseInfo  ·  ${appLocalizations.entriesCount(count)}',
    };
  }

  @override
  Widget build(BuildContext context) {
    return ListItem(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      title: Text(provider.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          if (provider.updateAt.microsecondsSinceEpoch > 0)
            Text(_buildProviderDesc()),
          const SizedBox(height: 4),
          if (provider.subscriptionInfo != null)
            SubscriptionInfoView(subscriptionInfo: provider.subscriptionInfo),
          const SizedBox(height: 8),
          Wrap(
            runSpacing: 6,
            spacing: 12,
            runAlignment: WrapAlignment.center,
            children: [
              CommonChip(
                avatar: const Icon(Icons.upload),
                label: appLocalizations.upload,
                onPressed: () => _handleSideLoadProvider(context),
              ),
              if (provider.vehicleType == 'HTTP')
                Consumer(
                  builder: (_, ref, _) {
                    final isUpdating = ref.watch(
                      isUpdatingProvider(provider.updatingKey),
                    );
                    return isUpdating
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
                            onPressed: () => _handleUpdateProvider(context),
                          );
                  },
                ),
            ],
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

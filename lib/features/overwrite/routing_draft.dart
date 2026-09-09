import 'dart:convert';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/core/controller.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<String> customRoutingTargets(Profile profile, Map<String, dynamic> raw) {
  Iterable<String> names(String key) => raw[key] is List
      ? (raw[key] as List)
            .whereType<Map>()
            .map((item) => item['name'])
            .whereType<String>()
            .where((name) => name.trim().isNotEmpty)
      : const [];
  return <String>{
    'DIRECT',
    'REJECT',
    'REJECT-DROP',
    'PASS',
    ...profile.customProxyGroups.map((group) => group.name),
    if (profile.overwriteType != OverwriteType.custom) ...names('proxy-groups'),
    ...profile.profileProxies
        .where((node) => node.isValid)
        .map((node) => node.name),
    ...names('proxies'),
  }.toList();
}

/// Build and check the complete candidate without persisting or applying it.
Future<String> validateCustomRoutingDraft(
  WidgetRef ref,
  Profile profile,
) async {
  try {
    // Capture the editor's configuration before yielding: its WidgetRef may
    // already be disposed when the core finishes connecting.
    final context = ref.context;
    final patchConfig = ref.read(patchClashConfigProvider);
    final network = ref.read(networkSettingProvider);
    final state = await ref.read(setupStateProvider(profile.id).future);
    if (!context.mounted || !await appController.ensureCoreReady()) {
      return appLocalizations.routingApplyFailed;
    }
    if (!context.mounted) return appLocalizations.routingApplyFailed;
    final config = await appController.getProfile(
      setupState: state.copyWith(
        overwriteType: profile.overwriteType,
        customProxyGroups: profile.customProxyGroups,
        customRules: profile.customRules,
        proxyChains: profile.proxyChains,
        profileProxies: profile.profileProxies,
      ),
      patchConfig: patchConfig,
    );
    final yaml = await encodeYamlTask(config);
    final result = await coreController.validateConfigWithBytes(
      base64Encode(utf8.encode(yaml)),
    );
    if (!context.mounted) return appLocalizations.routingApplyFailed;
    final currentState = await ref.read(setupStateProvider(profile.id).future);
    if (!context.mounted) return appLocalizations.routingApplyFailed;
    final currentNetwork = ref.read(networkSettingProvider);
    if (currentState != state ||
        ref.read(patchClashConfigProvider) != patchConfig ||
        currentNetwork.appendSystemDns != network.appendSystemDns ||
        currentNetwork.routeMode != network.routeMode) {
      return appLocalizations.routingChanged;
    }
    return result;
  } catch (error) {
    return error.toString();
  }
}

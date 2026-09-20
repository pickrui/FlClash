import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/plugins/app.dart';
import 'package:fl_clash/state.dart';
import 'package:wifi_ssid/wifi_ssid.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class VPNItem extends ConsumerWidget {
  const VPNItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final enable = ref.watch(
      vpnSettingProvider.select((state) => state.enable),
    );
    return ListItem.switchItem(
      title: const Text('VPN'),
      subtitle: Text(appLocalizations.vpnEnableDesc),
      delegate: SwitchDelegate(
        value: enable,
        onChanged: (value) async {
          ref
              .read(vpnSettingProvider.notifier)
              .update((state) => state.copyWith(enable: value));
        },
      ),
    );
  }
}

class TUNItem extends ConsumerWidget {
  const TUNItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final enable = ref.watch(
      patchClashConfigProvider.select((state) => state.tun.enable),
    );

    return ListItem.switchItem(
      title: Text(appLocalizations.tun),
      subtitle: Text(appLocalizations.tunDesc),
      delegate: SwitchDelegate(
        value: enable,
        onChanged: (value) async {
          ref
              .read(patchClashConfigProvider.notifier)
              .update((state) => state.copyWith.tun(enable: value));
        },
      ),
    );
  }
}

class AllowBypassItem extends ConsumerWidget {
  const AllowBypassItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final allowBypass = ref.watch(
      vpnSettingProvider.select((state) => state.allowBypass),
    );
    return ListItem.switchItem(
      title: Text(appLocalizations.allowBypass),
      subtitle: Text(appLocalizations.allowBypassDesc),
      delegate: SwitchDelegate(
        value: allowBypass,
        onChanged: (bool value) async {
          ref
              .read(vpnSettingProvider.notifier)
              .update((state) => state.copyWith(allowBypass: value));
        },
      ),
    );
  }
}

class VpnSystemProxyItem extends ConsumerWidget {
  const VpnSystemProxyItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final authenticated = ref.watch(
      networkSettingProvider.select((state) => state.authentication.enable),
    );
    final systemProxy = ref.watch(
      vpnSettingProvider.select((state) => state.systemProxy),
    );
    return ListItem.switchItem(
      title: Text(appLocalizations.systemProxy),
      subtitle: Text(
        authenticated
            ? appLocalizations.authenticationSystemProxyDesc
            : appLocalizations.systemProxyDesc,
      ),
      delegate: SwitchDelegate(
        value: systemProxy && !authenticated,
        onChanged: authenticated
            ? null
            : (bool value) async {
                ref
                    .read(vpnSettingProvider.notifier)
                    .update((state) => state.copyWith(systemProxy: value));
              },
      ),
    );
  }
}

class SystemProxyItem extends ConsumerWidget {
  const SystemProxyItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final authenticated = ref.watch(
      networkSettingProvider.select((state) => state.authentication.enable),
    );
    final systemProxy = ref.watch(
      networkSettingProvider.select((state) => state.systemProxy),
    );

    return ListItem.switchItem(
      title: Text(appLocalizations.systemProxy),
      subtitle: Text(
        authenticated
            ? appLocalizations.authenticationSystemProxyDesc
            : appLocalizations.systemProxyDesc,
      ),
      delegate: SwitchDelegate(
        value: systemProxy && !authenticated,
        onChanged: authenticated
            ? null
            : (bool value) async {
                ref
                    .read(networkSettingProvider.notifier)
                    .update((state) => state.copyWith(systemProxy: value));
              },
      ),
    );
  }
}

class Ipv6Item extends ConsumerWidget {
  const Ipv6Item({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final ipv6 = ref.watch(vpnSettingProvider.select((state) => state.ipv6));
    return ListItem.switchItem(
      title: const Text('IPv6'),
      subtitle: Text(appLocalizations.ipv6InboundDesc),
      delegate: SwitchDelegate(
        value: ipv6,
        onChanged: (bool value) async {
          ref
              .read(vpnSettingProvider.notifier)
              .update((state) => state.copyWith(ipv6: value));
        },
      ),
    );
  }
}

class AutoSetSystemDnsItem extends ConsumerWidget {
  const AutoSetSystemDnsItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final autoSetSystemDns = ref.watch(
      networkSettingProvider.select((state) => state.autoSetSystemDns),
    );
    return ListItem.switchItem(
      title: Text(appLocalizations.autoSetSystemDns),
      delegate: SwitchDelegate(
        value: autoSetSystemDns,
        onChanged: (bool value) async {
          ref
              .read(networkSettingProvider.notifier)
              .update((state) => state.copyWith(autoSetSystemDns: value));
        },
      ),
    );
  }
}

class SuspendOnIdleItem extends ConsumerWidget {
  const SuspendOnIdleItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final suspendOnIdle = ref.watch(
      networkSettingProvider.select((state) => state.suspendOnIdle),
    );
    return ListItem.switchItem(
      title: Text(appLocalizations.suspendOnIdle),
      subtitle: Text(appLocalizations.suspendOnIdleDesc),
      delegate: SwitchDelegate(
        value: suspendOnIdle,
        onChanged: (bool value) {
          ref
              .read(networkSettingProvider.notifier)
              .update((state) => state.copyWith(suspendOnIdle: value));
        },
      ),
    );
  }
}

class ExcludeSsidsItem extends ConsumerWidget {
  const ExcludeSsidsItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.appLocalizations;
    final ssids = ref.watch(
      networkSettingProvider.select((s) => s.excludeSSIDs),
    );
    return ListItem.open(
      title: Text(l10n.excludeSsids),
      subtitle: Text(l10n.excludeSsidsDesc),
      delegate: OpenDelegate(
        blur: false,
        widget: ListInputPage(
          title: l10n.excludeSsids,
          items: ssids,
          itemMaxLength: 32,
          titleBuilder: Text.new,
        ),
        onChanged: (items) {
          ref
              .read(networkSettingProvider.notifier)
              .update(
                (s) => s.copyWith(
                  excludeSSIDs: List<String>.from(
                    items,
                  ).where((s) => s.isNotEmpty).toSet().toList(),
                ),
              );
        },
      ),
    );
  }
}

class SsidPermissionItem extends ConsumerStatefulWidget {
  const SsidPermissionItem({super.key});

  @override
  ConsumerState<SsidPermissionItem> createState() => _SsidPermissionItemState();
}

class _SsidPermissionItemState extends ConsumerState<SsidPermissionItem> {
  bool _requesting = false;

  Future<void> _request() async {
    if (_requesting) return;
    setState(() => _requesting = true);
    try {
      var permission = await wifiSsidManager.checkPermission();
      if (permission != WifiSsidPermission.granted) {
        permission = await wifiSsidManager.requestPermission();
      }
      if (!mounted) return;
      ref.read(ssidRefreshProvider.notifier).update((v) => v + 1);
      if (permission != WifiSsidPermission.granted) {
        final l10n = context.appLocalizations;
        final open = await globalState.showMessage(
          title: l10n.locationPermissionRequired,
          message: TextSpan(
            text: system.isMacOS
                ? l10n.locationPermissionGuide(appName)
                : l10n.ssidPermissionGuide,
          ),
        );
        if (open == true && system.isAndroid) await app?.openAppSettings();
      }
    } catch (error) {
      if (mounted) context.showNotifier(error.toString());
    } finally {
      if (mounted) setState(() => _requesting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ref.watch(networkSettingProvider).excludeSSIDs.isEmpty) {
      return const SizedBox.shrink();
    }
    final l10n = context.appLocalizations;
    return ListItem(
      title: Text(l10n.locationPermission),
      subtitle: Text(l10n.ssidPermissionGuide),
      onTap: _requesting ? null : _request,
      trailing: _requesting
          ? const SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.location_on_outlined),
    );
  }
}

class ExcludeNetworksItem extends ConsumerWidget {
  const ExcludeNetworksItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.appLocalizations;
    final rules = ref.watch(networkSettingProvider).excludeNetworks;
    return ListItem.input(
      title: Text(l10n.excludeNetworks),
      subtitle: Text(l10n.excludeNetworksDesc),
      delegate: InputDelegate(
        title: l10n.excludeNetworks,
        value: rules.join(','),
        maxLength: 1024,
        resetValue: '',
        keyboardType: TextInputType.text,
        validator: (value) =>
            validNetworkRules(value ?? '') ? null : l10n.excludeNetworksInvalid,
        onChanged: (value) {
          if (value == null || !validNetworkRules(value)) return;
          ref
              .read(networkSettingProvider.notifier)
              .update(
                (state) =>
                    state.copyWith(excludeNetworks: parseNetworkRules(value)),
              );
        },
      ),
    );
  }
}

class TunMtuItem extends ConsumerWidget {
  const TunMtuItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mtu = ref.watch(
      patchClashConfigProvider.select(
        (state) => normalizeTunMtu(state.tun.mtu),
      ),
    );
    final l10n = context.appLocalizations;
    return ListItem.input(
      title: const Text('MTU'),
      subtitle: Text('$mtu · ${l10n.tunMtuDesc}'),
      delegate: InputDelegate(
        title: 'MTU',
        value: '$mtu',
        resetValue: '$defaultTunMtu',
        maxLength: 5,
        keyboardType: TextInputType.number,
        validator: (value) {
          final parsed = int.tryParse(value ?? '');
          return parsed == null || parsed < minTunMtu || parsed > maxTunMtu
              ? l10n.tunMtuInvalid
              : null;
        },
        onChanged: (value) {
          final parsed = int.tryParse(value ?? '');
          if (parsed == null) return;
          ref
              .read(patchClashConfigProvider.notifier)
              .update(
                (state) => state.copyWith.tun(mtu: normalizeTunMtu(parsed)),
              );
        },
      ),
    );
  }
}

class TunStackItem extends ConsumerWidget {
  const TunStackItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final stack = ref.watch(
      patchClashConfigProvider.select((state) => state.tun.stack),
    );

    return ListItem.options(
      title: Text(appLocalizations.stackMode),
      subtitle: Text(stack.name),
      delegate: OptionsDelegate<TunStack>(
        value: stack,
        options: TunStack.values,
        textBuilder: (value) => value.name,
        onChanged: (value) {
          if (value == null) {
            return;
          }
          ref
              .read(patchClashConfigProvider.notifier)
              .update((state) => state.copyWith.tun(stack: value));
        },
        title: appLocalizations.stackMode,
      ),
    );
  }
}

class BypassDomainItem extends ConsumerWidget {
  const BypassDomainItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final bypassDomain = ref.watch(
      networkSettingProvider.select((state) => state.bypassDomain),
    );
    return ListItem.open(
      title: Text(appLocalizations.bypassDomain),
      subtitle: Text(appLocalizations.bypassDomainDesc),
      delegate: OpenDelegate(
        blur: false,
        widget: ListInputPage(
          title: appLocalizations.bypassDomain,
          items: bypassDomain,
          itemMaxLength: TextInputLimits.domain,
          titleBuilder: (item) => Text(item),
        ),
        onChanged: (items) {
          ref
              .read(networkSettingProvider.notifier)
              .update(
                (state) => state.copyWith(bypassDomain: List.from(items)),
              );
        },
      ),
    );
  }
}

class DNSHijackingItem extends ConsumerWidget {
  const DNSHijackingItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final dnsHijacking = ref.watch(
      vpnSettingProvider.select((state) => state.dnsHijacking),
    );
    return ListItem<RouteMode>.switchItem(
      title: Text(appLocalizations.dnsHijacking),
      delegate: SwitchDelegate(
        value: dnsHijacking,
        onChanged: (value) async {
          ref
              .read(vpnSettingProvider.notifier)
              .update((state) => state.copyWith(dnsHijacking: value));
        },
      ),
    );
  }
}

class RouteModeItem extends ConsumerWidget {
  const RouteModeItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final routeMode = ref.watch(
      networkSettingProvider.select((state) => state.routeMode),
    );
    return ListItem<RouteMode>.options(
      title: Text(appLocalizations.routeMode),
      subtitle: Text(Intl.message('routeMode_${routeMode.name}')),
      delegate: OptionsDelegate<RouteMode>(
        title: appLocalizations.routeMode,
        options: RouteMode.values,
        onChanged: (RouteMode? value) {
          if (value == null) {
            return;
          }
          ref
              .read(networkSettingProvider.notifier)
              .update((state) => state.copyWith(routeMode: value));
        },
        textBuilder: (routeMode) => Intl.message('routeMode_${routeMode.name}'),
        value: routeMode,
      ),
    );
  }
}

class RouteAddressItem extends ConsumerWidget {
  const RouteAddressItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final bypassPrivate = ref.watch(
      networkSettingProvider.select(
        (state) => state.routeMode == RouteMode.bypassPrivate,
      ),
    );
    if (bypassPrivate) {
      return Container();
    }
    final routeAddress = ref.watch(
      patchClashConfigProvider.select((state) => state.tun.routeAddress),
    );
    return ListItem.open(
      title: Text(appLocalizations.routeAddress),
      subtitle: Text(appLocalizations.routeAddressDesc),
      delegate: OpenDelegate(
        blur: false,
        maxWidth: 360,
        widget: ListInputPage(
          title: appLocalizations.routeAddress,
          items: routeAddress,
          itemMaxLength: TextInputLimits.cidr,
          titleBuilder: (item) => Text(item),
        ),
        onChanged: (items) {
          ref
              .read(patchClashConfigProvider.notifier)
              .update(
                (state) => state.copyWith.tun(routeAddress: List.from(items)),
              );
        },
      ),
    );
  }
}

class BlockQuicItem extends ConsumerWidget {
  const BlockQuicItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final setupAction = context.setupAction;

    final appLocalizations = context.appLocalizations;
    final blockQuic = ref.watch(
      networkSettingProvider.select((state) => state.blockQuic),
    );
    return ListItem.switchItem(
      title: Text(appLocalizations.blockQuic),
      subtitle: Text(appLocalizations.blockQuicDesc),
      delegate: SwitchDelegate(
        value: blockQuic,
        onChanged: (bool value) async {
          ref
              .read(networkSettingProvider.notifier)
              .update((state) => state.copyWith(blockQuic: value));
          setupAction.applyProfileDebounce(silence: true);
        },
      ),
    );
  }
}

class BlockWebRtcItem extends ConsumerWidget {
  const BlockWebRtcItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final setupAction = context.setupAction;

    final appLocalizations = context.appLocalizations;
    final blockWebRtc = ref.watch(
      networkSettingProvider.select((state) => state.blockWebRtc),
    );
    return ListItem.switchItem(
      title: Text(appLocalizations.blockWebRtc),
      subtitle: Text(appLocalizations.blockWebRtcDesc),
      delegate: SwitchDelegate(
        value: blockWebRtc,
        onChanged: (bool value) async {
          ref
              .read(networkSettingProvider.notifier)
              .update((state) => state.copyWith(blockWebRtc: value));
          setupAction.applyProfileDebounce(silence: true);
        },
      ),
    );
  }
}

class NetworkListView extends StatelessWidget {
  const NetworkListView({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    return generateListView([
      if (system.isAndroid) const VPNItem(),
      if (system.isAndroid)
        ...generateSection(
          title: 'VPN',
          items: [
            const VpnSystemProxyItem(),
            const BypassDomainItem(),
            const AllowBypassItem(),
            const Ipv6Item(),
            const DNSHijackingItem(),
          ],
        ),
      if (system.isDesktop)
        ...generateSection(
          title: appLocalizations.system,
          items: [const SystemProxyItem(), const BypassDomainItem()],
        ),
      ...generateSection(
        title: appLocalizations.options,
        items: [
          if (system.isDesktop) const TUNItem(),
          if (system.isMacOS) const AutoSetSystemDnsItem(),
          if (system.isAndroid) const SuspendOnIdleItem(),
          const ExcludeSsidsItem(),
          if (system.isAndroid) const ExcludeNetworksItem(),
          if (system.isAndroid || system.isMacOS) const SsidPermissionItem(),
          const TunStackItem(),
          const TunMtuItem(),
          const BlockQuicItem(),
          const BlockWebRtcItem(),
          if (!system.isDesktop) ...[
            const RouteModeItem(),
            const RouteAddressItem(),
          ],
        ],
      ),
    ]);
  }
}

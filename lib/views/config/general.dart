import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/ua_dialog.dart';
import 'package:fl_clash/widgets/proxy_authentication.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class LogLevelItem extends ConsumerWidget {
  const LogLevelItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final logLevel = ref.watch(
      patchClashConfigProvider.select((state) => state.logLevel),
    );
    return ListItem<LogLevel>.options(
      leading: const Icon(Icons.info_outline),
      title: Text(appLocalizations.logLevel),
      subtitle: Text(logLevel.name),
      delegate: OptionsDelegate<LogLevel>(
        title: appLocalizations.logLevel,
        options: LogLevel.values,
        onChanged: (LogLevel? value) {
          if (value == null) {
            return;
          }
          ref
              .read(patchClashConfigProvider.notifier)
              .update((state) => state.copyWith(logLevel: value));
        },
        textBuilder: (logLevel) => logLevel.name,
        value: logLevel,
      ),
    );
  }
}

class UaItem extends ConsumerWidget {
  const UaItem({super.key});

  Future<void> _handleShowUaDialog(WidgetRef ref) async {
    final result = await globalState.showCommonDialog<UaDialogResult>(
      child: UaDialog(
        value: ref.read(patchClashConfigProvider).globalUa,
        customValue: ref.read(appSettingProvider).customUserAgent,
      ),
    );
    if (result == null || !ref.context.mounted) return;
    final userAgent = result.value;
    if (result.isCustom) {
      ref
          .read(appSettingProvider.notifier)
          .update((state) => state.copyWith(customUserAgent: userAgent));
    }
    ref
        .read(patchClashConfigProvider.notifier)
        .update(
          (state) =>
              state.copyWith(globalUa: userAgent.isEmpty ? null : userAgent),
        );
  }

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final globalUa = ref.watch(
      patchClashConfigProvider.select((state) => state.globalUa),
    );
    return ListItem(
      leading: const Icon(Icons.computer_outlined),
      title: Text(appLocalizations.userAgent),
      subtitle: Text(globalUa ?? appLocalizations.defaultText),
      onTap: () => _handleShowUaDialog(ref),
    );
  }
}

class KeepAliveIntervalItem extends ConsumerWidget {
  const KeepAliveIntervalItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final keepAliveInterval = ref.watch(
      patchClashConfigProvider.select((state) => state.keepAliveInterval),
    );
    return ListItem.input(
      leading: const Icon(Icons.timer_outlined),
      title: Text(appLocalizations.keepAliveIntervalDesc),
      subtitle: Text(appLocalizations.secondsCount(keepAliveInterval)),
      delegate: InputDelegate(
        title: appLocalizations.keepAliveIntervalDesc,
        suffixText: appLocalizations.seconds,
        resetValue: '$defaultKeepAliveInterval',
        value: '$keepAliveInterval',
        maxLength: TextInputLimits.interval,
        keyboardType: TextInputType.number,
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return appLocalizations.emptyTip(appLocalizations.interval);
          }
          final intValue = int.tryParse(value);
          if (intValue == null) {
            return appLocalizations.numberTip(appLocalizations.interval);
          }
          return null;
        },
        onChanged: (String? value) {
          if (value == null) {
            return;
          }
          final intValue = int.parse(value);
          ref
              .read(patchClashConfigProvider.notifier)
              .update((state) => state.copyWith(keepAliveInterval: intValue));
        },
      ),
    );
  }
}

class TestUrlItem extends ConsumerWidget {
  const TestUrlItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final testUrl = ref.watch(
      appSettingProvider.select((state) => state.testUrl),
    );
    return ListItem.input(
      leading: const Icon(Icons.timeline),
      title: Text(appLocalizations.testUrl),
      subtitle: Text(testUrl),
      delegate: InputDelegate(
        resetValue: defaultTestUrl,
        title: appLocalizations.testUrl,
        value: testUrl,
        maxLength: TextInputLimits.url,
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return appLocalizations.emptyTip(appLocalizations.testUrl);
          }
          if (!value.isUrl) {
            return appLocalizations.urlTip(appLocalizations.testUrl);
          }
          return null;
        },
        onChanged: (String? value) {
          if (value == null) {
            return;
          }
          ref
              .read(appSettingProvider.notifier)
              .update((state) => state.copyWith(testUrl: value));
        },
      ),
    );
  }
}

class PortItem extends ConsumerWidget {
  const PortItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final mixedPort = ref.watch(
      patchClashConfigProvider.select((state) => state.mixedPort),
    );
    return ListItem(
      leading: const Icon(Icons.adjust_outlined),
      title: Text(appLocalizations.port),
      subtitle: Text('$mixedPort'),
      onTap: () {
        globalState.showCommonDialog(child: const _PortDialog());
      },
    );
  }
}

class HostsItem extends ConsumerWidget {
  const HostsItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final hosts = ref.watch(
      patchClashConfigProvider.select((state) => state.hosts),
    );
    return ListItem.open(
      leading: const Icon(Icons.view_list_outlined),
      title: const Text('Hosts'),
      subtitle: Text(appLocalizations.hostsDesc),
      delegate: OpenDelegate(
        blur: false,
        widget: MapInputPage(
          title: 'Hosts',
          map: hosts,
          keyMaxLength: TextInputLimits.domain,
          valueMaxLength: TextInputLimits.hostValue,
          titleBuilder: (item) => Text(item.key),
          subtitleBuilder: (item) => Text(item.value),
        ),
        onChanged: (value) {
          ref
              .read(patchClashConfigProvider.notifier)
              .update((state) => state.copyWith(hosts: value));
        },
      ),
    );
  }
}

class AutoIpv6Item extends ConsumerWidget {
  const AutoIpv6Item({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final setupAction = context.setupAction;

    final appLocalizations = context.appLocalizations;
    final autoSetIpv6 = ref.watch(
      networkSettingProvider.select((state) => state.autoSetIpv6),
    );
    return ListItem.switchItem(
      leading: const Icon(Icons.autorenew_outlined),
      title: Text(appLocalizations.autoIpv6),
      subtitle: Text(appLocalizations.autoIpv6Desc),
      delegate: SwitchDelegate(
        value: autoSetIpv6,
        onChanged: (bool value) async {
          await setupAction.setAutoIpv6(value);
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
    final ipv6 = ref.watch(
      patchClashConfigProvider.select((state) => state.ipv6),
    );
    final autoSetIpv6 = ref.watch(
      networkSettingProvider.select((state) => state.autoSetIpv6),
    );
    return ListItem.switchItem(
      leading: const Icon(Icons.water_outlined),
      title: const Text('IPv6'),
      subtitle: Text(appLocalizations.ipv6Desc),
      delegate: SwitchDelegate(
        value: ipv6,
        onChanged: autoSetIpv6
            ? null
            : (bool value) async {
                ref
                    .read(patchClashConfigProvider.notifier)
                    .update((state) => state.copyWith(ipv6: value));
              },
      ),
    );
  }
}

class AppendSystemDNSItem extends ConsumerWidget {
  const AppendSystemDNSItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final appendSystemDNS = ref.watch(
      networkSettingProvider.select((state) => state.appendSystemDns),
    );
    return ListItem.switchItem(
      leading: const Icon(Icons.dns_outlined),
      title: Text(appLocalizations.appendSystemDns),
      subtitle: Text(appLocalizations.appendSystemDnsTip),
      delegate: SwitchDelegate(
        value: appendSystemDNS,
        onChanged: (bool value) async {
          ref
              .read(networkSettingProvider.notifier)
              .update((state) => state.copyWith(appendSystemDns: value));
        },
      ),
    );
  }
}

class AllowLanItem extends ConsumerWidget {
  const AllowLanItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final allowLan = ref.watch(
      patchClashConfigProvider.select((state) => state.allowLan),
    );
    return ListItem.switchItem(
      leading: const Icon(Icons.device_hub),
      title: Text(appLocalizations.allowLan),
      subtitle: Text(appLocalizations.allowLanDesc),
      delegate: SwitchDelegate(
        value: allowLan,
        onChanged: (bool value) async {
          ref
              .read(patchClashConfigProvider.notifier)
              .update((state) => state.copyWith(allowLan: value));
        },
      ),
    );
  }
}

class UnifiedDelayItem extends ConsumerWidget {
  const UnifiedDelayItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final unifiedDelay = ref.watch(
      patchClashConfigProvider.select((state) => state.unifiedDelay),
    );

    return ListItem.switchItem(
      leading: const Icon(Icons.compress_outlined),
      title: Text(appLocalizations.unifiedDelay),
      subtitle: Text(appLocalizations.unifiedDelayDesc),
      delegate: SwitchDelegate(
        value: unifiedDelay,
        onChanged: (bool value) async {
          ref
              .read(patchClashConfigProvider.notifier)
              .update((state) => state.copyWith(unifiedDelay: value));
        },
      ),
    );
  }
}

class FindProcessItem extends ConsumerWidget {
  const FindProcessItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final findProcess = ref.watch(
      patchClashConfigProvider.select(
        (state) => state.findProcessMode == FindProcessMode.always,
      ),
    );

    return ListItem.switchItem(
      leading: const Icon(Icons.polymer_outlined),
      title: Text(appLocalizations.findProcessMode),
      subtitle: Text(appLocalizations.findProcessModeDesc),
      delegate: SwitchDelegate(
        value: findProcess,
        onChanged: (bool value) async {
          ref
              .read(patchClashConfigProvider.notifier)
              .update(
                (state) => state.copyWith(
                  findProcessMode: value
                      ? FindProcessMode.always
                      : FindProcessMode.off,
                ),
              );
        },
      ),
    );
  }
}

class TcpConcurrentItem extends ConsumerWidget {
  const TcpConcurrentItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final tcpConcurrent = ref.watch(
      patchClashConfigProvider.select((state) => state.tcpConcurrent),
    );
    return ListItem.switchItem(
      leading: const Icon(Icons.double_arrow_outlined),
      title: Text(appLocalizations.tcpConcurrent),
      subtitle: Text(appLocalizations.tcpConcurrentDesc),
      delegate: SwitchDelegate(
        value: tcpConcurrent,
        onChanged: (value) async {
          ref
              .read(patchClashConfigProvider.notifier)
              .update((state) => state.copyWith(tcpConcurrent: value));
        },
      ),
    );
  }
}

class GeodataLoaderItem extends ConsumerWidget {
  const GeodataLoaderItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final isMemconservative = ref.watch(
      patchClashConfigProvider.select(
        (state) => state.geodataLoader == GeodataLoader.memconservative,
      ),
    );
    return ListItem.switchItem(
      leading: const Icon(Icons.memory),
      title: Text(appLocalizations.geodataLoader),
      subtitle: Text(appLocalizations.geodataLoaderDesc),
      delegate: SwitchDelegate(
        value: isMemconservative,
        onChanged: (bool value) async {
          ref
              .read(patchClashConfigProvider.notifier)
              .update(
                (state) => state.copyWith(
                  geodataLoader: value
                      ? GeodataLoader.memconservative
                      : GeodataLoader.standard,
                ),
              );
        },
      ),
    );
  }
}

class ExternalControllerItem extends ConsumerWidget {
  const ExternalControllerItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final hasExternalController = ref.watch(
      patchClashConfigProvider.select(
        (state) => state.externalController == ExternalControllerStatus.open,
      ),
    );
    final item = ListItem.switchItem(
      leading: const Icon(Icons.api_outlined),
      title: Text(appLocalizations.externalController),
      subtitle: Text(appLocalizations.externalControllerDesc),
      delegate: SwitchDelegate(
        value: hasExternalController,
        onChanged: (bool value) async {
          ref
              .read(patchClashConfigProvider.notifier)
              .update(
                (state) => state.copyWith(
                  externalController: value
                      ? ExternalControllerStatus.open
                      : ExternalControllerStatus.close,
                ),
              );
        },
      ),
    );
    if (!hasExternalController) {
      return item;
    }
    return Column(
      children: [
        item,
        const Divider(height: 0, indent: 56),
        const ExternalControllerConfigItem(),
      ],
    );
  }
}

class ExternalControllerConfigItem extends ConsumerWidget {
  const ExternalControllerConfigItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = context.appLocalizations;
    final vm = ref.watch(
      patchClashConfigProvider.select(
        (state) => VM2(state.externalControllerAddress, state.secret),
      ),
    );
    final effectiveAddress = resolveExternalControllerAddress(vm.a);
    return ListItem(
      padding: const EdgeInsets.only(left: 56, right: 16),
      title: Text('${appLocalizations.address} / ${appLocalizations.password}'),
      subtitle: Text(effectiveAddress),
      onTap: () {
        globalState.showCommonDialog(child: const _ExternalControllerDialog());
      },
      trailing: IconButton(
        icon: const Icon(Icons.open_in_new),
        tooltip: appLocalizations.openDashboard,
        onPressed: () {
          _openExternalControllerDashboard(vm.a, vm.b);
        },
      ),
    );
  }
}

Future<void> _openExternalControllerDashboard(
  String address,
  String secret,
) async {
  final url = resolveExternalControllerDashboardUrl(address, secret);
  await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
}

class _ExternalControllerDialog extends ConsumerStatefulWidget {
  const _ExternalControllerDialog();

  @override
  ConsumerState<_ExternalControllerDialog> createState() =>
      _ExternalControllerDialogState();
}

class _ExternalControllerDialogState
    extends ConsumerState<_ExternalControllerDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _addressController;
  late final TextEditingController _secretController;
  bool _obscureSecret = true;

  @override
  void initState() {
    super.initState();
    final vm = ref.read(
      patchClashConfigProvider.select(
        (state) => VM2(state.externalControllerAddress, state.secret),
      ),
    );
    _addressController = TextEditingController(
      text: resolveExternalControllerAddress(vm.a),
    );
    _secretController = TextEditingController(text: vm.b);
  }

  @override
  void dispose() {
    _addressController.dispose();
    _secretController.dispose();
    super.dispose();
  }

  Future<void> _handleReset() async {
    final res = await globalState.showMessage(
      message: TextSpan(text: context.appLocalizations.resetTip),
    );
    if (res != true) {
      return;
    }
    ref
        .read(patchClashConfigProvider.notifier)
        .update(
          (state) => state.copyWith(
            externalControllerAddress: defaultExternalControllerAddress,
            secret: defaultExternalControllerSecret,
          ),
        );
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  bool _save() {
    if (_formKey.currentState?.validate() == false) {
      return false;
    }
    final address = resolveExternalControllerAddress(_addressController.text);
    final secret = resolveExternalControllerSecret(_secretController.text);
    ref
        .read(patchClashConfigProvider.notifier)
        .update(
          (state) => state.copyWith(
            externalControllerAddress: address,
            secret: secret,
          ),
        );
    return true;
  }

  void _handleUpdate() {
    if (!_save()) {
      return;
    }
    Navigator.of(context).pop();
  }

  void _handleOpen() {
    if (!_save()) {
      return;
    }
    _openExternalControllerDashboard(
      _addressController.text,
      _secretController.text,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    return CommonDialog(
      title: appLocalizations.externalController,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: _handleOpen,
              icon: const Icon(Icons.open_in_new, size: 18),
              label: Text(appLocalizations.openDashboard),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: _handleReset,
                  child: Text(appLocalizations.reset),
                ),
                const SizedBox(width: 4),
                TextButton(
                  onPressed: _handleUpdate,
                  child: Text(appLocalizations.submit),
                ),
              ],
            ),
          ],
        ),
      ],
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            spacing: 24,
            children: [
              TextFormField(
                keyboardType: TextInputType.url,
                maxLines: 1,
                minLines: 1,
                controller: _addressController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalizations.address,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return appLocalizations.emptyTip(appLocalizations.address);
                  }
                  if (!isExternalControllerAddress(value)) {
                    return defaultExternalControllerAddress;
                  }
                  return null;
                },
              ),
              TextFormField(
                maxLines: 1,
                minLines: 1,
                controller: _secretController,
                obscureText: _obscureSecret,
                enableSuggestions: false,
                autocorrect: false,
                onFieldSubmitted: (_) {
                  _handleUpdate();
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalizations.password,
                  suffixIcon: VisibilityToggleButton(
                    obscureText: _obscureSecret,
                    onPressed: () {
                      setState(() => _obscureSecret = !_obscureSecret);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final generalItems = <Widget>[
  const LogLevelItem(),
  const UaItem(),
  if (system.isDesktop) const KeepAliveIntervalItem(),
  const TestUrlItem(),
  const PortItem(),
  const HostsItem(),
  const AutoIpv6Item(),
  const Ipv6Item(),
  const AllowLanItem(),
  const ProxyAuthenticationItem(),
  const UnifiedDelayItem(),
  const AppendSystemDNSItem(),
  const FindProcessItem(),
  const TcpConcurrentItem(),
  const GeodataLoaderItem(),
  const ExternalControllerItem(),
].separated(const Divider(height: 0)).toList();

class _PortDialog extends ConsumerStatefulWidget {
  const _PortDialog();

  @override
  ConsumerState<_PortDialog> createState() => _PortDialogState();
}

class _PortDialogState extends ConsumerState<_PortDialog> {
  final _formKey = GlobalKey<FormState>();
  bool _isMore = false;

  late final TextEditingController _mixedPortController;
  late final TextEditingController _portController;
  late final TextEditingController _socksPortController;
  late final TextEditingController _redirPortController;
  late final TextEditingController _tProxyPortController;

  @override
  void initState() {
    super.initState();
    final vm5 = ref.read(
      patchClashConfigProvider.select((state) {
        return VM5(
          state.mixedPort,
          state.port,
          state.socksPort,
          state.redirPort,
          state.tproxyPort,
        );
      }),
    );
    _mixedPortController = TextEditingController(text: vm5.a.toString());
    _portController = TextEditingController(text: vm5.b.toString());
    _socksPortController = TextEditingController(text: vm5.c.toString());
    _redirPortController = TextEditingController(text: vm5.d.toString());
    _tProxyPortController = TextEditingController(text: vm5.e.toString());
  }

  List<(TextEditingController, String)> get _portFields {
    final appLocalizations = context.appLocalizations;
    return [
      (_mixedPortController, appLocalizations.mixedPort),
      (_portController, appLocalizations.port),
      (_socksPortController, appLocalizations.socksPort),
      (_redirPortController, appLocalizations.redirPort),
      (_tProxyPortController, appLocalizations.tproxyPort),
    ];
  }

  String? _validatePort(TextEditingController controller, String label) {
    final appLocalizations = context.appLocalizations;
    final text = controller.text;
    if (text.isEmpty) {
      return appLocalizations.emptyTip(label);
    }
    final port = int.tryParse(text);
    if (port == null) {
      return appLocalizations.numberTip(label);
    }
    if (port == 0) {
      return null;
    }
    if (port < 1024 || port > 49151) {
      return appLocalizations.portTip(label);
    }
    final conflict = _portFields.any(
      (field) => field.$1 != controller && int.tryParse(field.$1.text) == port,
    );
    return conflict ? appLocalizations.portConflictTip : null;
  }

  Future<void> _handleReset() async {
    final res = await globalState.showMessage(
      message: TextSpan(text: context.appLocalizations.resetTip),
    );
    if (res != true) {
      return;
    }
    ref
        .read(patchClashConfigProvider.notifier)
        .update(
          (state) => state.copyWith(
            mixedPort: defaultClashConfig.mixedPort,
            port: defaultClashConfig.port,
            socksPort: defaultClashConfig.socksPort,
            redirPort: defaultClashConfig.redirPort,
            tproxyPort: defaultClashConfig.tproxyPort,
          ),
        );
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void _handleUpdate() {
    if (_formKey.currentState?.validate() == false) return;
    final hiddenInvalid =
        !_isMore &&
        _portFields
            .skip(1)
            .any((field) => _validatePort(field.$1, field.$2) != null);
    if (hiddenInvalid) {
      setState(() => _isMore = true);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _formKey.currentState?.validate();
      });
      return;
    }
    ref
        .read(patchClashConfigProvider.notifier)
        .update(
          (state) => state.copyWith(
            mixedPort: int.parse(_mixedPortController.text),
            port: int.parse(_portController.text),
            socksPort: int.parse(_socksPortController.text),
            redirPort: int.parse(_redirPortController.text),
            tproxyPort: int.parse(_tProxyPortController.text),
          ),
        );
    Navigator.of(context).pop();
  }

  void _handleMore() {
    setState(() {
      _isMore = !_isMore;
    });
  }

  @override
  void dispose() {
    _mixedPortController.dispose();
    _portController.dispose();
    _socksPortController.dispose();
    _redirPortController.dispose();
    _tProxyPortController.dispose();
    super.dispose();
  }

  Widget _buildPortField(TextEditingController controller, String label) {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: TextInputLimits.digitsOnly(TextInputLimits.port),
      maxLines: 1,
      minLines: 1,
      controller: controller,
      onFieldSubmitted: (_) {
        _handleUpdate();
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
      validator: (_) => _validatePort(controller, label),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    final fields = _portFields;
    return CommonDialog(
      title: appLocalizations.port,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton.filledTonal(
              onPressed: _handleMore,
              icon: CommonExpandIcon(expand: _isMore),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: _handleReset,
                  child: Text(appLocalizations.reset),
                ),
                const SizedBox(width: 4),
                TextButton(
                  onPressed: _handleUpdate,
                  child: Text(appLocalizations.submit),
                ),
              ],
            ),
          ],
        ),
      ],
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: AnimatedSize(
            duration: midDuration,
            curve: Curves.easeOutQuad,
            alignment: Alignment.topCenter,
            child: Column(
              spacing: 24,
              children: [
                for (final (controller, label)
                    in _isMore ? fields : fields.take(1))
                  _buildPortField(controller, label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

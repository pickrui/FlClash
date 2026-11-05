import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wifi_ssid/wifi_ssid.dart';

typedef SsidReader = Future<String?> Function();

class ConnectivityManager extends ConsumerStatefulWidget {
  final void Function(List<ConnectivityResult>)? onConnectivityChanged;
  final Stream<List<ConnectivityResult>>? connectivityStream;
  final Future<List<ConnectivityResult>> Function()? checkConnectivity;
  final SsidReader? readSsid;
  final Widget child;

  const ConnectivityManager({
    super.key,
    this.onConnectivityChanged,
    this.connectivityStream,
    this.checkConnectivity,
    this.readSsid,
    required this.child,
  });

  @override
  ConsumerState<ConnectivityManager> createState() =>
      _ConnectivityManagerState();
}

class _ConnectivityManagerState extends ConsumerState<ConnectivityManager>
    with WidgetsBindingObserver {
  late final StreamSubscription<List<ConnectivityResult>> _subscription;
  Timer? _timer;
  int _revision = 0;
  int _networkRevision = 0;
  bool _onWifi = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _subscription =
        (widget.connectivityStream ?? Connectivity().onConnectivityChanged)
            .listen(
              _handleResults,
              onError: (Object error) {
                commonPrint.log(
                  'Connectivity lookup failed: ${error.runtimeType}',
                );
              },
            );
    ref.listenManual(
      networkSettingProvider.select((s) => s.excludeSSIDs.isNotEmpty),
      (_, enabled) {
        _timer?.cancel();
        // connectivity_plus deduplicates Wi-Fi -> Wi-Fi changes. Refresh while
        // this feature is enabled, including when the same transport roams.
        _timer = enabled
            ? Timer.periodic(const Duration(seconds: 10), (_) {
                unawaited(_refreshNetwork());
              })
            : null;
        Future.microtask(_refreshNetwork);
      },
      fireImmediately: true,
    );
    ref.listenManual(
      ssidRefreshProvider,
      (_, _) => unawaited(_refreshNetwork()),
    );
  }

  Future<void> _refreshNetwork() async {
    final revision = ++_networkRevision;
    ++_revision;
    try {
      final results =
          await (widget.checkConnectivity ??
              Connectivity().checkConnectivity)();
      if (!mounted || revision != _networkRevision) return;
      _onWifi = results.contains(ConnectivityResult.wifi);
      await _updateSsid();
    } catch (error) {
      if (!mounted || revision != _networkRevision) return;
      _onWifi = false;
      await _updateSsid();
    }
  }

  void _handleResults(List<ConnectivityResult> results) {
    ++_networkRevision;
    _onWifi = results.contains(ConnectivityResult.wifi);
    unawaited(_updateSsid());
    widget.onConnectivityChanged?.call(results);
  }

  Future<void> _updateSsid() async {
    final revision = ++_revision;
    String? ssid;
    if (_onWifi && ref.read(networkSettingProvider).excludeSSIDs.isNotEmpty) {
      try {
        ssid =
            await (widget.readSsid ??
                () async {
                  if (await wifiSsidManager.checkPermission() !=
                      WifiSsidPermission.granted) {
                    return null;
                  }
                  return wifiSsidManager.getSsid();
                })();
      } catch (error) {
        commonPrint.log('SSID lookup failed: ${error.runtimeType}');
      }
    }
    if (!mounted || revision != _revision) return;
    ref.read(currentSSIDProvider.notifier).value =
        ssid == null || ssid.isEmpty || ssid == '<unknown ssid>' ? null : ssid;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) unawaited(_refreshNetwork());
  }

  @override
  void dispose() {
    ++_revision;
    ++_networkRevision;
    _timer?.cancel();
    _subscription.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

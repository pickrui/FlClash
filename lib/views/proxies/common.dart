import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/views/network_diagnostics.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/state.dart';

double get listHeaderHeight {
  final measure = globalState.measure;
  return 20 + measure.titleMediumHeight + 4 + measure.bodyMediumHeight + 2;
}

double getItemHeight(ProxyCardType proxyCardType) {
  final measure = globalState.measure;
  final baseHeight =
      16 + measure.bodyMediumHeight * 2 + measure.bodySmallHeight + 8 + 4;
  return switch (proxyCardType) {
    ProxyCardType.expand => baseHeight + measure.labelSmallHeight + 6,
    ProxyCardType.shrink => baseHeight,
    ProxyCardType.min => baseHeight - measure.bodyMediumHeight,
  };
}

Future<void> proxyDelayTest(Proxy proxy, [String? testUrl]) {
  return appController.proxyDelayTest(proxy, testUrl);
}

/// Tests a group; when every node failed, offers the network self-check.
Future<void> delayTest(List<Proxy> proxies, [String? testUrl]) async {
  if (!await appController.delayTest(proxies, testUrl)) return;
  globalState.showNotifier(
    appLocalizations.diagAllFailed,
    actionState: MessageActionState(
      actionText: appLocalizations.diagTitle,
      action: () {
        final context = globalState.navigatorKey.currentContext;
        if (context != null && context.mounted) {
          showNetworkDiagnostics(context);
        }
      },
    ),
  );
}

double getScrollToSelectedOffset({
  required String groupName,
  required List<Proxy> proxies,
}) {
  final columns = appController.getProxiesColumns();
  final proxyCardType = appController.config.proxiesStyleProps.cardType;
  final selectedProxyName = appController.getSelectedProxyName(groupName);
  final findSelectedIndex = proxies.indexWhere(
    (proxy) => proxy.name == selectedProxyName,
  );
  final selectedIndex = findSelectedIndex != -1 ? findSelectedIndex : 0;
  final rows = (selectedIndex / columns).floor();
  return rows * getItemHeight(proxyCardType) + (rows - 1) * 8;
}

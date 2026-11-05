import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/delay_test.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/core/core.dart';
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

Future<Delay> _testDelayTarget(DelayTestTarget target, int generation) async {
  try {
    return await coreController.getDelay(
      target.url,
      target.name,
      isCurrent: () => appController.isCurrentDelayGeneration(generation),
    );
  } catch (_) {
    return Delay(url: target.url, name: target.name, value: -1);
  }
}

Future<void> proxyDelayTest(Proxy proxy, [String? testUrl]) async {
  final target = computeDelayTestTarget(
    proxy: proxy,
    groups: appController.groups,
    selectedMap: appController.currentProfile?.selectedMap ?? {},
    defaultTestUrl: appController.getRealTestUrl(testUrl),
  );
  if (target == null) {
    return;
  }
  final generation = appController.beginDelayTest();
  appController.setDelay(
    Delay(url: target.url, name: target.name, value: 0),
    generation: generation,
  );
  appController.setDelay(
    await _testDelayTarget(target, generation),
    generation: generation,
  );
  if (appController.isCurrentDelayGeneration(generation)) {
    appController.updateGroupsDebounce();
  }
}

Future<void> delayTest(List<Proxy> proxies, [String? testUrl]) async {
  final delayTargets = computeDelayTestTargets(
    proxies: proxies,
    groups: appController.groups,
    selectedMap: appController.currentProfile?.selectedMap ?? {},
    defaultTestUrl: appController.getRealTestUrl(testUrl),
  );
  if (delayTargets.isEmpty) {
    return;
  }
  final generation = appController.beginDelayTest();
  appController.setDelays(
    delayTargets.map(
      (target) => Delay(url: target.url, name: target.name, value: 0),
    ),
    generation: generation,
  );

  await runDelayTestBatch(
    targets: delayTargets,
    concurrency: maxConcurrentDelayTests,
    probe: (target) => _testDelayTarget(target, generation),
    isCurrent: () => appController.isCurrentDelayGeneration(generation),
    onResult: (delay) => appController.setDelay(delay, generation: generation),
  );
  if (appController.isCurrentDelayGeneration(generation)) {
    appController.addSortNum();
    appController.updateGroupsDebounce();
  }
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

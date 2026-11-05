import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';

List<Group> computeSort({
  required List<Group> groups,
  required ProxiesSortType sortType,
  required DelayMap delayMap,
  required Map<String, String> selectedMap,
  required String defaultTestUrl,
}) {
  List<Proxy> sortOfDelay({
    required List<Group> groups,
    required List<Proxy> proxies,
    required DelayMap delayMap,
    required Map<String, String> selectedMap,
    required String testUrl,
  }) {
    return List.from(proxies)..sort((a, b) {
      final aDelayState = computeProxyDelayState(
        proxyName: a.name,
        testUrl: testUrl,
        groups: groups,
        selectedMap: selectedMap,
        delayMap: delayMap,
      );
      final bDelayState = computeProxyDelayState(
        proxyName: b.name,
        testUrl: testUrl,
        groups: groups,
        selectedMap: selectedMap,
        delayMap: delayMap,
      );
      return aDelayState.compareTo(bDelayState);
    });
  }

  List<Proxy> sortOfName(List<Proxy> proxies) {
    return List.of(proxies)..sort((a, b) => a.name.compareTo(b.name));
  }

  return groups.map((group) {
    final proxies = group.all;
    final newProxies = switch (sortType) {
      ProxiesSortType.none => proxies,
      ProxiesSortType.delay => sortOfDelay(
        groups: groups,
        proxies: proxies,
        delayMap: delayMap,
        selectedMap: selectedMap,
        testUrl: group.testUrl.takeFirstValid([defaultTestUrl]),
      ),
      ProxiesSortType.name => sortOfName(proxies),
    };
    return group.copyWith(all: newProxies);
  }).toList();
}

SelectedProxyState getRealSelectedProxyState(
  SelectedProxyState state, {
  required List<Group> groups,
  required Map<String, String> selectedMap,
}) {
  return _getRealSelectedProxyState(
    state,
    groups: groups,
    selectedMap: selectedMap,
    visited: {},
  );
}

SelectedProxyState _getRealSelectedProxyState(
  SelectedProxyState state, {
  required List<Group> groups,
  required Map<String, String> selectedMap,
  required Set<String> visited,
}) {
  if (state.proxyName.isEmpty) return state;
  if (!visited.add(state.proxyName)) {
    return state.copyWith(proxyName: '', group: true);
  }
  final index = groups.indexWhere((element) => element.name == state.proxyName);
  final newState = state.copyWith(group: true);
  if (index == -1) return newState;
  final group = groups[index];
  final currentSelectedName = group.getCurrentSelectedName(
    selectedMap[newState.proxyName] ?? '',
  );
  if (currentSelectedName.isEmpty) {
    return newState;
  }
  final groupTestUrl = group.testUrl?.trim();
  final inheritedTestUrl = newState.testUrl?.trim();
  return _getRealSelectedProxyState(
    newState.copyWith(
      proxyName: currentSelectedName,
      testUrl: groupTestUrl != null && groupTestUrl.isNotEmpty
          ? groupTestUrl
          : (inheritedTestUrl != null && inheritedTestUrl.isNotEmpty
                ? inheritedTestUrl
                : null),
    ),
    groups: groups,
    selectedMap: selectedMap,
    visited: visited,
  );
}

SelectedProxyState computeRealSelectedProxyState(
  String proxyName, {
  required List<Group> groups,
  required Map<String, String> selectedMap,
}) {
  return getRealSelectedProxyState(
    SelectedProxyState(proxyName: proxyName),
    groups: groups,
    selectedMap: selectedMap,
  );
}

typedef DelayTestTarget = ({String name, String url});

DelayTestTarget? computeDelayTestTarget({
  required Proxy proxy,
  required List<Group> groups,
  required Map<String, String> selectedMap,
  required String defaultTestUrl,
}) {
  final state = computeRealSelectedProxyState(
    proxy.name,
    groups: groups,
    selectedMap: selectedMap,
  );
  if (state.proxyName.isEmpty) {
    return null;
  }
  final url = getDelayTestUrl(
    proxyName: state.proxyName,
    testUrl: state.testUrl.takeFirstValid([defaultTestUrl]),
  );
  return (name: state.proxyName, url: url);
}

List<DelayTestTarget> computeDelayTestTargets({
  required Iterable<Proxy> proxies,
  required List<Group> groups,
  required Map<String, String> selectedMap,
  required String defaultTestUrl,
}) {
  final targets = <DelayTestTarget>{};
  for (final proxy in proxies) {
    final target = computeDelayTestTarget(
      proxy: proxy,
      groups: groups,
      selectedMap: selectedMap,
      defaultTestUrl: defaultTestUrl,
    );
    if (target != null) {
      targets.add(target);
    }
  }
  return targets.toList();
}

DelayState computeProxyDelayState({
  required String proxyName,
  required String testUrl,
  required List<Group> groups,
  required Map<String, String> selectedMap,
  required DelayMap delayMap,
}) {
  final state = computeRealSelectedProxyState(
    proxyName,
    groups: groups,
    selectedMap: selectedMap,
  );
  final currentTestUrl = getDelayTestUrl(
    proxyName: state.proxyName,
    testUrl: state.testUrl.takeFirstValid([testUrl]),
  );
  final currentDelayMap = delayMap[currentTestUrl] ?? {};
  final delay = currentDelayMap[state.proxyName];
  return DelayState(delay: delay ?? 0, group: state.group);
}

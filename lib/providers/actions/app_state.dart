part of '../action.dart';

@Riverpod(keepAlive: true)
class AppStateAction extends _$AppStateAction {
  @override
  void build() {
    _controller = ref.watch(actionControllerProvider);
  }

  late AppController _controller;

  Config get config => _controller.config;

  bool get isMobile => _controller.isMobile;

  bool get isProxyActive => _controller.isProxyActive;

  bool get isStart => _controller.isStart;

  List<Group> get groups => _controller.groups;

  String get ua => _controller.ua;

  Profile? get currentProfile => _controller.currentProfile;

  String? getSelectedProxyName(String groupName) =>
      _controller.getSelectedProxyName(groupName);

  String getRealTestUrl(String? url) => _controller.getRealTestUrl(url);

  int getProxiesColumns() => _controller.getProxiesColumns();

  SharedState get sharedState => _controller.sharedState;

  SetupParams get setupParams => _controller.setupParams;

  List<Group> getCurrentGroups() => _controller.getCurrentGroups();

  String? getCurrentGroupName() => _controller.getCurrentGroupName();
}

extension StateControllerExt on AppController {
  Config get config {
    return _ref.read(configProvider);
  }

  bool get isMobile {
    return _ref.read(isMobileViewProvider);
  }

  bool get isProxyActive => isStart && !_ref.read(suspendProvider);

  bool get isStart {
    return _ref.read(isStartProvider);
  }

  List<Group> get groups {
    return _ref.read(groupsProvider);
  }

  String get ua => _ref.read(patchClashConfigProvider).globalUa.takeFirstValid([
    globalState.packageInfo.ua,
  ]);

  Profile? get currentProfile {
    return _ref.read(currentProfileProvider);
  }

  String? getSelectedProxyName(String groupName) {
    return _ref.read(getSelectedProxyNameProvider(groupName));
  }

  String getRealTestUrl(String? url) {
    return _ref.read(realTestUrlProvider(url));
  }

  int getProxiesColumns() {
    return _ref.read(getProxiesColumnsProvider);
  }

  SharedState get sharedState {
    return _ref.read(sharedStateProvider);
  }

  SetupParams get setupParams {
    final selectedMap = _ref.read(selectedMapProvider);
    final testUrl = _ref.read(
      appSettingProvider.select((state) => state.testUrl),
    );
    return SetupParams(
      selectedMap: selectedMap,
      testUrl: testUrl,
      suspendOnIdle: _ref.read(networkSettingProvider).suspendOnIdle,
    );
  }

  List<Group> getCurrentGroups() {
    return _ref.read(currentGroupsStateProvider.select((state) => state.value));
  }

  String? getCurrentGroupName() {
    final currentGroupName = _ref.read(
      currentProfileProvider.select((state) => state?.currentGroupName),
    );
    return currentGroupName;
  }
}

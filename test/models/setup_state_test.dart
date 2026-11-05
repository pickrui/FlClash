import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:test/test.dart';

void main() {
  SetupState buildState({
    List<ProxyGroup> customProxyGroups = const [],
    List<Rule> customRules = const [],
    bool blockQuic = false,
    bool blockWebRtc = false,
  }) {
    return SetupState(
      profileId: 1,
      profileLastUpdateDate: 1,
      overwriteType: OverwriteType.custom,
      addedRules: const [],
      proxyChains: const [],
      profileProxies: const [],
      customProxyGroups: customProxyGroups,
      customRules: customRules,
      script: null,
      overrideDns: false,
      dns: const Dns(),
      blockQuic: blockQuic,
      blockWebRtc: blockWebRtc,
    );
  }

  group('SetupState custom overwrite changes', () {
    test('unchanged custom data does not require setup', () {
      final state = buildState();
      expect(state.needSetup(state), false);
    });

    test('proxy group changes require setup', () {
      final previous = buildState();
      final next = buildState(
        customProxyGroups: const [
          ProxyGroup(name: 'Auto', type: GroupType.URLTest),
        ],
      );
      expect(next.needSetup(previous), true);
    });

    test('rule changes require setup', () {
      final previous = buildState();
      final next = buildState(
        customRules: const [Rule(id: 1, value: 'MATCH,DIRECT')],
      );
      expect(next.needSetup(previous), true);
    });

    test('transport block changes require setup', () {
      final previous = buildState();
      expect(buildState(blockQuic: true).needSetup(previous), true);
      expect(buildState(blockWebRtc: true).needSetup(previous), true);
    });
  });
}

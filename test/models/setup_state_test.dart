import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:test/test.dart';

void main() {
  SetupState buildState({
    List<ProxyGroup> customProxyGroups = const [],
    List<Rule> customRules = const [],
    List<Rule> addedRules = const [],
    OverwriteType overwriteType = OverwriteType.custom,
    bool blockQuic = false,
    bool blockWebRtc = false,
  }) {
    return SetupState(
      profileId: 1,
      profileLastUpdateDate: 1,
      overwriteType: overwriteType,
      addedRules: addedRules,
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

  group('SetupState personal overlay changes', () {
    final previous = buildState(overwriteType: OverwriteType.merge);

    test('unchanged overlay does not require setup', () {
      expect(
        buildState(overwriteType: OverwriteType.merge).needSetup(previous),
        false,
      );
    });

    test('existing added rules continue to trigger setup', () {
      expect(
        buildState(
          overwriteType: OverwriteType.merge,
          addedRules: const [Rule(id: 1, value: 'DOMAIN,local.example,DIRECT')],
        ).needSetup(previous),
        true,
      );
    });

    test('personal group and rule changes each trigger setup', () {
      expect(
        buildState(
          overwriteType: OverwriteType.merge,
          customProxyGroups: const [
            ProxyGroup(name: 'Personal', type: GroupType.URLTest),
          ],
        ).needSetup(previous),
        true,
      );
      expect(
        buildState(
          overwriteType: OverwriteType.merge,
          customRules: const [
            Rule(id: 1, value: 'DOMAIN,video.example,Personal'),
          ],
        ).needSetup(previous),
        true,
      );
    });

    test('switching from replace mode requires setup', () {
      expect(previous.needSetup(buildState()), true);
    });
  });

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

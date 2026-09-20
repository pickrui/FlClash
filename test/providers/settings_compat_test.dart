import 'dart:convert';
import 'package:fl_clash/common/constant.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() async => AppLocalizations.load(const Locale('en')));
  test(
    'Android adopts 16 while other platforms retain their saved concurrency',
    () {
      for (final legacy in delayTestConcurrencyOptions) {
        final props = ProxiesStyleProps.fromJson({'concurrencyLimit': legacy});
        expect(
          props.delayTestConcurrency(isAndroid: true),
          legacy == 50 ? 16 : legacy,
        );
        expect(props.delayTestConcurrency(isAndroid: false), legacy);
        expect(props.concurrencyLimit, legacy);
      }
      expect(
        ProxiesStyleProps.fromJson({}).delayTestConcurrency(isAndroid: true),
        16,
      );
      expect(
        ProxiesStyleProps.fromJson({}).delayTestConcurrency(isAndroid: false),
        50,
      );
    },
  );

  test('an explicit Android setting round-trips independently of desktop', () {
    for (final limit in delayTestConcurrencyOptions) {
      final restored = ProxiesStyleProps.fromJson(
        jsonDecode(
          jsonEncode(
            ProxiesStyleProps(
              concurrencyLimit: 100,
              androidConcurrencyLimit: limit,
            ),
          ),
        ),
      );
      expect(restored.delayTestConcurrency(isAndroid: true), limit);
      expect(restored.delayTestConcurrency(isAndroid: false), 100);
    }
    for (final invalid in [0, -1, 250]) {
      final props = ProxiesStyleProps.fromJson({
        'androidConcurrencyLimit': invalid,
      });
      expect(props.androidConcurrencyLimit, isNull);
      expect(props.delayTestConcurrency(isAndroid: true), 16);
    }
  });

  test('old preferences retain MTU and no new automatic policy', () {
    expect(Tun.fromJson({}).mtu, 9000);
    expect(NetworkProps.fromJson({}).excludeNetworks, isEmpty);
    expect(AppSettingProps.fromJson({}).scriptOptions, isEmpty);
    expect(maxConcurrentDelayTests, 150);
    expect(delayTestConcurrencyOptions.last, maxConcurrentDelayTests);
    expect(ProxiesStyleProps.fromJson({}).concurrencyLimit, 50);
    for (final limit in delayTestConcurrencyOptions) {
      final restored = ProxiesStyleProps.fromJson(
        jsonDecode(jsonEncode(ProxiesStyleProps(concurrencyLimit: limit))),
      );
      expect(restored.concurrencyLimit, limit);
    }
    expect(
      ProxiesStyleProps.fromJson({'concurrencyLimit': 250}).concurrencyLimit,
      50,
    );
    expect(maxInFlightDelayTests, greaterThan(maxConcurrentDelayTests));
    for (final mtu in [0, -1, 1279, 65536]) {
      expect(Tun.fromJson({'mtu': mtu}).mtu, 9000);
    }
    for (final mtu in [1280, 1480, 4064, 9000, 65535]) {
      expect(Tun.fromJson({'mtu': mtu}).mtu, mtu);
    }
  });
  test('script-specific switches round-trip through saved preferences', () {
    final config = Config.realFromJson(
      jsonDecode(
        jsonEncode(
          const Config(
            themeProps: defaultThemeProps,
            appSettingProps: AppSettingProps(
              scriptOptions: {
                '42': {'服务 A': false},
                '43': {'服务 A': true},
              },
            ),
          ),
        ),
      ),
    );
    expect(config.appSettingProps.scriptOptions['42'], {'服务 A': false});
    expect(config.appSettingProps.scriptOptions['43'], {'服务 A': true});
  });
  test(
    'MTU and network rules reach Android headless options; MTU changes VPN state',
    () {
      final container = ProviderContainer(
        overrides: [currentProfileProvider.overrideWith((_) => null)],
      );
      addTearDown(container.dispose);
      final before = container.read(vpnStateProvider);
      container
          .read(patchClashConfigProvider.notifier)
          .update((s) => s.copyWith.tun(mtu: 1480));
      container
          .read(networkSettingProvider.notifier)
          .update(
            (s) => s.copyWith(
              excludeNetworks: ['192.168.1.0/24', 'gateway:10.0.0.1'],
            ),
          );
      expect(container.read(vpnStateProvider), isNot(before));
      expect(container.read(vpnStateProvider).mtu, 1480);
      final shared = jsonDecode(
        jsonEncode(container.read(sharedStateProvider)),
      );
      expect(shared['vpnOptions']['mtu'], 1480);
      expect(shared['vpnOptions']['excludeNetworks'], [
        '192.168.1.0/24',
        'gateway:10.0.0.1',
      ]);
      expect(container.read(isStartProvider), false);
    },
  );
}

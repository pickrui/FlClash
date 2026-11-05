import 'dart:convert';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:flutter/widgets.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() async => AppLocalizations.load(const Locale('en')));
  test('old preferences default to no exclusions; new settings round-trip', () {
    expect(NetworkProps.fromJson({}).excludeSSIDs, isEmpty);
    final config = NetworkProps.fromJson(
      jsonDecode(
        jsonEncode(
          const NetworkProps(excludeSSIDs: ['家庭网络', ' Wi-Fi ', '日本語']),
        ),
      ),
    );
    expect(config.excludeSSIDs, ['家庭网络', ' Wi-Fi ', '日本語']);
  });

  test(
    'exclusion is exact, unknown SSID cannot match, manual stop stays stopped',
    () {
      final c = ProviderContainer(
        overrides: [currentProfileProvider.overrideWith((_) => null)],
      );
      addTearDown(c.dispose);
      final settings = c.read(networkSettingProvider.notifier);
      settings.update((s) => s.copyWith(excludeSSIDs: ['Home', '']));
      final ssid = c.read(currentSSIDProvider.notifier);
      expect(c.read(suspendProvider), false);
      ssid.value = 'Home';
      expect(c.read(suspendProvider), true);
      expect(c.read(isStartProvider), false);
      ssid.value = 'home';
      expect(c.read(suspendProvider), false);
      ssid.value = ' Home ';
      expect(c.read(suspendProvider), false);
      ssid.value = 'Home';
      settings.update((s) => s.copyWith(excludeSSIDs: []));
      expect(c.read(suspendProvider), false);
      expect(c.read(isStartProvider), false);
    },
  );

  test('headless Android shortcuts persist the exclusion list', () {
    final c = ProviderContainer(
      overrides: [currentProfileProvider.overrideWith((_) => null)],
    );
    addTearDown(c.dispose);
    c
        .read(networkSettingProvider.notifier)
        .update((s) => s.copyWith(excludeSSIDs: ['Home']));
    final shared = jsonDecode(jsonEncode(c.read(sharedStateProvider)));
    expect(shared['vpnOptions']['excludeSSIDs'], ['Home']);
  });
}

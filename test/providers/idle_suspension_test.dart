import 'dart:convert';

import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/providers/state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'idle preference reaches the persisted Android shortcut state',
    () async {
      await AppLocalizations.load(const Locale('en'));
      final container = ProviderContainer(
        overrides: [currentProfileProvider.overrideWith((_) => null)],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(sharedStateProvider, (_, _) {});
      addTearDown(subscription.close);

      for (final enabled in [false, true, false]) {
        container
            .read(networkSettingProvider.notifier)
            .update((state) => state.copyWith(suspendOnIdle: enabled));
        final shared = container.read(sharedStateProvider);
        final persisted =
            jsonDecode(jsonEncode(shared)) as Map<String, dynamic>;

        expect(shared.setupParams?.suspendOnIdle, enabled);
        expect(persisted['setupParams']['suspend-on-idle'], enabled);
      }
    },
  );

  test(
    'idle preference updates core parameters without changing the profile',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final subscription = container.listen(updateParamsProvider, (_, _) {});
      addTearDown(subscription.close);
      final originalConfig = container.read(patchClashConfigProvider);

      expect(container.read(updateParamsProvider).suspendOnIdle, false);

      final settings = container.read(networkSettingProvider.notifier);
      settings.update((state) => state.copyWith(suspendOnIdle: true));
      expect(container.read(updateParamsProvider).suspendOnIdle, true);
      expect(
        container.read(updateParamsProvider).toJson()['suspend-on-idle'],
        true,
      );

      settings.update((state) => state.copyWith(suspendOnIdle: false));
      expect(container.read(updateParamsProvider).suspendOnIdle, false);
      expect(container.read(patchClashConfigProvider), originalConfig);
    },
  );
}

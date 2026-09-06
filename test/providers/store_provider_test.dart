import 'package:fl_clash/providers/store_provider.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/cloud_api_adapter.dart';

void main() {
  test(
    'refreshing store data does not cancel payment-method loading',
    () async {
      final adapter = QueuedCloudAdapter();
      final service = CloudApiService.forTesting(
        client: adapter.createClient(),
      );
      final notifier = _StoreNotifier(service);
      final container = ProviderContainer(
        overrides: [storeProvider.overrideWith(() => notifier)],
      );
      addTearDown(container.dispose);
      container.read(storeProvider);

      final methods = notifier.ensurePaymentMethods();
      final pendingMethods = await adapter.takeRequest();
      final load = notifier.load();
      (await adapter.takeRequest()).respond({
        'ret': 200,
        'data': {'shops': []},
      });
      (await adapter.takeRequest()).respond({
        'ret': 200,
        'data': {'boughts': []},
      });
      await load;
      pendingMethods.respond({
        'result': [
          {'payment': 'card', 'name': 'Card'},
        ],
      });

      expect((await methods).single.payment, 'card');
      expect(
        container.read(storeProvider).paymentMethods.single.payment,
        'card',
      );
    },
  );

  test(
    'account A orders cannot replace account B after logout and login',
    () async {
      final adapter = QueuedCloudAdapter();
      final service = CloudApiService.forTesting(
        client: adapter.createClient(),
      );
      service.setToken('account-a');
      final notifier = _StoreNotifier(service);
      final container = ProviderContainer(
        overrides: [storeProvider.overrideWith(() => notifier)],
      );
      addTearDown(container.dispose);
      container.read(storeProvider);

      final oldLoad = notifier.load();
      (await adapter.takeRequest()).respond({
        'ret': 200,
        'data': {
          'shops': [
            {'id': 1, 'name': 'A plan'},
          ],
        },
      });
      final oldOrders = await adapter.takeRequest();
      service.setToken(null);
      notifier.reset();
      service.setToken('account-b');

      final newLoad = notifier.load();
      (await adapter.takeRequest()).respond({
        'ret': 200,
        'data': {
          'shops': [
            {'id': 2, 'name': 'B plan'},
          ],
        },
      });
      (await adapter.takeRequest()).respond({
        'ret': 200,
        'data': {
          'boughts': [
            {'id': 202, 'shop_id': 2, 'shop_name': 'B order'},
          ],
        },
      });
      await newLoad;
      oldOrders.respond({
        'ret': 200,
        'data': {
          'boughts': [
            {'id': 101, 'shop_id': 1, 'shop_name': 'A order'},
          ],
        },
      });
      await oldLoad;

      final state = container.read(storeProvider);
      expect(state.plans.single.name, 'B plan');
      expect(state.bought.single.id, 202);
      expect(state.error, isNull);
      expect(state.isLoading, isFalse);
    },
  );

  test('reset discards a pending payment-method cache fill', () async {
    final adapter = QueuedCloudAdapter();
    final service = CloudApiService.forTesting(client: adapter.createClient());
    final notifier = _StoreNotifier(service);
    final container = ProviderContainer(
      overrides: [storeProvider.overrideWith(() => notifier)],
    );
    addTearDown(container.dispose);
    container.read(storeProvider);

    final methods = notifier.ensurePaymentMethods();
    final pending = await adapter.takeRequest();
    notifier.reset();
    final rejected = expectLater(
      methods,
      throwsA(isA<CloudApiStaleSessionException>()),
    );
    pending.respond({
      'result': [
        {'payment': 'old-method', 'name': 'Old'},
      ],
    });
    await rejected;

    expect(container.read(storeProvider).paymentMethods, isEmpty);
  });
}

class _StoreNotifier extends StoreNotifier {
  final CloudApiService service;

  _StoreNotifier(this.service);

  @override
  CloudApiService get apiService => service;
}

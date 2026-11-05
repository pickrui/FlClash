import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoreState {
  final bool isLoading;
  final List<StorePlan> plans;
  final List<BoughtRecord> bought;
  final List<PaymentMethodOption> paymentMethods;
  final List<int> upgradeShopIds;
  final String? error;

  const StoreState({
    this.isLoading = false,
    this.plans = const [],
    this.bought = const [],
    this.paymentMethods = const [],
    this.upgradeShopIds = const [],
    this.error,
  });

  StoreState copyWith({
    bool? isLoading,
    List<StorePlan>? plans,
    List<BoughtRecord>? bought,
    List<PaymentMethodOption>? paymentMethods,
    List<int>? upgradeShopIds,
    String? error,
    bool clearError = false,
  }) {
    return StoreState(
      isLoading: isLoading ?? this.isLoading,
      plans: plans ?? this.plans,
      bought: bought ?? this.bought,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      upgradeShopIds: upgradeShopIds ?? this.upgradeShopIds,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

class StoreNotifier extends Notifier<StoreState> {
  @override
  StoreState build() => const StoreState();

  Future<void> load({bool silent = false}) async {
    if (!silent) {
      state = state.copyWith(isLoading: true, clearError: true);
    }
    try {
      final plans = await CloudApiService().fetchPlans();
      final bought = await CloudApiService().fetchBought();
      state = state.copyWith(
        isLoading: false,
        plans: plans,
        bought: bought,
        clearError: true,
      );
    } catch (e) {
      if (CloudApiException.isHandledUnauthorized(e)) {
        return;
      }
      state = state.copyWith(
        isLoading: false,
        error: CloudApiException.clean(e),
      );
    }
  }

  Future<List<PaymentMethodOption>> ensurePaymentMethods({
    bool force = false,
  }) async {
    if (!force && state.paymentMethods.isNotEmpty) {
      return state.paymentMethods;
    }
    final methods = await CloudApiService().fetchPaymentMethods();
    state = state.copyWith(paymentMethods: methods);
    return methods;
  }
}

final storeProvider = NotifierProvider<StoreNotifier, StoreState>(
  StoreNotifier.new,
);

import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoreState {
  final bool isLoading;
  final List<StorePlan> plans;
  final List<BoughtRecord> bought;
  final List<PaymentMethodOption> paymentMethods;
  final String? error;

  const StoreState({
    this.isLoading = false,
    this.plans = const [],
    this.bought = const [],
    this.paymentMethods = const [],
    this.error,
  });

  StoreState copyWith({
    bool? isLoading,
    List<StorePlan>? plans,
    List<BoughtRecord>? bought,
    List<PaymentMethodOption>? paymentMethods,
    String? error,
    bool clearError = false,
  }) {
    return StoreState(
      isLoading: isLoading ?? this.isLoading,
      plans: plans ?? this.plans,
      bought: bought ?? this.bought,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

class StoreNotifier extends Notifier<StoreState> {
  int _loadRevision = 0;
  int _sessionRevision = 0;

  @protected
  CloudApiService get apiService => CloudApiService();

  @override
  StoreState build() => const StoreState();

  Future<void> load() async {
    final revision = ++_loadRevision;
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final plans = await apiService.fetchPlans();
      if (!ref.mounted || revision != _loadRevision) return;
      final bought = await apiService.fetchBought();
      if (!ref.mounted || revision != _loadRevision) return;
      state = state.copyWith(
        isLoading: false,
        plans: plans,
        bought: bought,
        clearError: true,
      );
    } catch (e) {
      if (!ref.mounted || revision != _loadRevision) return;
      if (CloudApiException.isHandledUnauthorized(e)) {
        state = state.copyWith(isLoading: false);
        return;
      }
      state = state.copyWith(
        isLoading: false,
        error: CloudApiException.clean(e),
      );
      if (CloudApiException.isUnauthorized(e)) rethrow;
    }
  }

  Future<List<PaymentMethodOption>> ensurePaymentMethods({
    bool force = false,
  }) async {
    if (!force && state.paymentMethods.isNotEmpty) {
      return state.paymentMethods;
    }
    final revision = _sessionRevision;
    final methods = await apiService.fetchPaymentMethods();
    if (!ref.mounted || revision != _sessionRevision) {
      throw const CloudApiStaleSessionException();
    }
    state = state.copyWith(paymentMethods: methods);
    return methods;
  }

  void reset() {
    _loadRevision++;
    _sessionRevision++;
    state = const StoreState();
  }
}

final storeProvider = NotifierProvider<StoreNotifier, StoreState>(
  StoreNotifier.new,
);

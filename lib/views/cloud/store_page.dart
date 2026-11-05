import 'dart:async';

import 'package:collection/collection.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CloudStorePage extends ConsumerStatefulWidget {
  const CloudStorePage({super.key});

  @override
  ConsumerState<CloudStorePage> createState() => _CloudStorePageState();
}

class _CloudStorePageState extends ConsumerState<CloudStorePage> {
  bool _busy = false;
  _StoreSection _section = _StoreSection.plans;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _loadStore();
    });
  }

  Future<bool> _loadStore() async {
    final accountNotifier = ref.read(cloudAccountProvider.notifier);
    try {
      await ref.read(storeProvider.notifier).load();
      return mounted;
    } catch (e) {
      if (!CloudApiException.isUnauthorized(e)) rethrow;
      await accountNotifier.handleUnauthorized();
      return false;
    }
  }

  Future<void> _refresh() async {
    if (!await _loadStore() || !mounted) return;
    // Plan changes must regenerate the managed subscription, not just the card.
    await ref
        .read(cloudAccountProvider.notifier)
        .refreshManagedSubscription();
  }

  Future<void> _runGuarded(Future<void> Function() action) async {
    if (_busy) return;
    final accountNotifier = ref.read(cloudAccountProvider.notifier);
    setState(() => _busy = true);
    try {
      await action();
    } catch (e) {
      if (CloudApiException.isHandledUnauthorized(e)) return;
      if (CloudApiException.isUnauthorized(e)) {
        await accountNotifier.handleUnauthorized();
        return;
      }
      globalState.showNotifier(CloudApiException.clean(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final storeState = ref.watch(storeProvider);
    final account = ref.watch(cloudAccountProvider);

    return CommonScaffold(
      title: appLocalizations.store,
      isLoading: _busy,
      actions: [
        IconButton(
          icon: const Icon(Icons.account_balance_wallet_outlined),
          tooltip: appLocalizations.recharge,
          onPressed: () => _runGuarded(_rechargeFlow),
        ),
        IconButton(
          icon: const Icon(Icons.refresh),
          tooltip: appLocalizations.refresh,
          onPressed: () => _runGuarded(_refresh),
        ),
      ],
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: storeState.isLoading && storeState.plans.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildBalanceCard(account.profile),
                  if (storeState.error != null) ...[
                    const SizedBox(height: 12),
                    _buildErrorCard(storeState.error!),
                  ],
                  const SizedBox(height: 16),
                  _buildSectionPicker(),
                  const SizedBox(height: 12),
                  if (_section == _StoreSection.plans) ...[
                    if (storeState.plans.isEmpty)
                      _buildEmptyHint(
                        appLocalizations.noAvailablePlans,
                        Icons.inventory_2_outlined,
                      )
                    else
                      ...storeState.plans.map(_buildPlanCard),
                  ] else ...[
                    if (storeState.bought.isEmpty)
                      _buildEmptyHint(
                        appLocalizations.noPurchaseRecords,
                        Icons.receipt_long_outlined,
                      )
                    else
                      ...storeState.bought.map(_buildBoughtCard),
                  ],
                  const SizedBox(height: 32),
                ],
              ),
      ),
    );
  }

  Widget _buildSectionPicker() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final showIcons = constraints.maxWidth >= 420;
        return SegmentedButton<_StoreSection>(
          selected: {_section},
          showSelectedIcon: false,
          onSelectionChanged: (selection) =>
              setState(() => _section = selection.first),
          segments: [
            ButtonSegment(
              value: _StoreSection.plans,
              icon: showIcons ? const Icon(Icons.inventory_2_outlined) : null,
              label: Text(appLocalizations.availablePlans),
            ),
            ButtonSegment(
              value: _StoreSection.orders,
              icon: showIcons ? const Icon(Icons.receipt_long_outlined) : null,
              label: Text(appLocalizations.myOrders),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyHint(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Icon(icon, size: 30, color: context.colorScheme.onSurfaceVariant),
          const SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  String _priceText(double price) {
    final decimals = price == price.roundToDouble() ? 0 : 2;
    return '¥ ${price.toStringAsFixed(decimals)}';
  }

  Widget _orderMetadata(IconData icon, String text, {Color? color}) {
    final foreground = color ?? context.colorScheme.onSurfaceVariant;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: foreground),
        const SizedBox(width: 4),
        Text(
          text,
          style: context.textTheme.bodySmall?.copyWith(color: foreground),
        ),
      ],
    );
  }

  Widget _buildErrorCard(String error) {
    return CommonCard(
      isError: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: context.colorScheme.error),
            const SizedBox(width: 12),
            Expanded(child: Text(error)),
            IconButton(
              onPressed: _busy ? null : () => _runGuarded(_refresh),
              icon: const Icon(Icons.refresh),
              tooltip: appLocalizations.refresh,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(CloudProfile? profile) {
    return CommonCard(
      type: CommonCardType.filled,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(
              Icons.account_balance_wallet,
              color: context.colorScheme.primary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocalizations.accountBalance,
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '¥ ${profile?.balance ?? '0.00'}',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (profile != null)
                    Text(
                      appLocalizations.commissionBalance(profile.commission),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
            FilledButton.tonalIcon(
              onPressed: () => _runGuarded(_rechargeFlow),
              icon: const Icon(Icons.add),
              label: Text(appLocalizations.recharge),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(StorePlan plan) {
    final defaultPeriod = plan.defaultPeriod;
    final displayPrice = defaultPeriod?.price ?? plan.price;
    final priceText = _priceText(displayPrice);
    final summary = compactStorePlanSummary(plan.tags);
    final lowStock = !plan.soldOut && plan.inventory > 0 && plan.inventory <= 5;

    final card = Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: CommonCard(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      plan.name,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        priceText,
                        style: context.textTheme.headlineSmall?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (defaultPeriod != null &&
                          defaultPeriod.label.isNotEmpty)
                        Text(
                          defaultPeriod.label,
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              if (summary.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  summary,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              if (plan.planCode == 'iron') ...[
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      size: 16,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        appLocalizations.mainlandNetworkWarning,
                        style: context.textTheme.labelMedium?.copyWith(
                          color: Colors.orange.shade800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              if (lowStock) ...[
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      size: 16,
                      color: Colors.deepOrange,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      appLocalizations.remainingStock(plan.inventory),
                      style: context.textTheme.labelMedium?.copyWith(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 10),
              if (plan.soldOut)
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.tonalIcon(
                    onPressed: null,
                    icon: const Icon(Icons.inventory_2_outlined),
                    label: Text(appLocalizations.soldOut),
                  ),
                )
              else
                _buildPurchaseActions(plan),
            ],
          ),
        ),
      ),
    );
    return plan.soldOut ? Opacity(opacity: 0.55, child: card) : card;
  }

  Widget _buildPurchaseActions(StorePlan plan) {
    final balanceButton = OutlinedButton.icon(
      onPressed: (plan.canBuy && !_busy)
          ? () => _runGuarded(() => _buyWithBalanceFlow(plan))
          : null,
      icon: const Icon(Icons.account_balance_wallet_outlined),
      label: Text(appLocalizations.buyWithBalance),
    );
    final onlineButton = FilledButton.icon(
      onPressed: (plan.canBuy && !_busy)
          ? () => _runGuarded(() => _orderFlow(plan))
          : null,
      icon: const Icon(Icons.payment),
      label: Text(appLocalizations.orderAndPay),
    );

    return Align(
      alignment: Alignment.centerRight,
      child: Wrap(
        alignment: WrapAlignment.end,
        spacing: 8,
        runSpacing: 8,
        children: [balanceButton, onlineButton],
      ),
    );
  }

  Icon _paymentIcon(PaymentMethodOption m) {
    final key = '${m.payment} ${m.type}'.toLowerCase();
    if (m.isCrypto ||
        key.contains('usdt') ||
        key.contains('crypto') ||
        key.contains('coin')) {
      return const Icon(
        Icons.currency_bitcoin,
        size: 18,
        color: Color(0xFF26A17B),
      );
    }
    if (key.contains('alipay')) {
      return const Icon(
        Icons.account_balance_wallet,
        size: 18,
        color: Color(0xFF1677FF),
      );
    }
    if (key.contains('wx') ||
        key.contains('wechat') ||
        key.contains('weixin')) {
      return const Icon(Icons.chat, size: 18, color: Color(0xFF07C160));
    }
    return Icon(Icons.payment, size: 18, color: context.colorScheme.primary);
  }

  Widget _buildBoughtCard(BoughtRecord bought) {
    final actions = _buildBoughtActions(bought);
    final statusLabel = bought.isActive
        ? appLocalizations.planInUse
        : bought.isPending
        ? appLocalizations.planNotActivated
        : appLocalizations.planEnded;
    final statusColor = bought.isActive
        ? Colors.green
        : bought.isPending
        ? Colors.orange
        : context.colorScheme.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: CommonCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      bought.shopName.isEmpty
                          ? appLocalizations.planNumber(bought.shopId)
                          : bought.shopName,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          bought.isActive
                              ? Icons.check_circle
                              : bought.isPending
                              ? Icons.schedule
                              : Icons.archive_outlined,
                          size: 13,
                          color: statusColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          statusLabel,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 12,
                runSpacing: 6,
                children: [
                  if (bought.buyTime.isNotEmpty)
                    _orderMetadata(
                      Icons.calendar_today_outlined,
                      appLocalizations.purchaseTime(bought.buyTime),
                    ),
                  if (bought.billingPeriodText.isNotEmpty)
                    _orderMetadata(
                      Icons.date_range_outlined,
                      bought.billingPeriodText,
                    ),
                  if (bought.isActive)
                    _orderMetadata(
                      bought.autoRenew ? Icons.autorenew : Icons.sync_disabled,
                      bought.autoRenew
                          ? appLocalizations.autoRenewOn
                          : appLocalizations.autoRenewOff,
                      color: bought.autoRenew ? Colors.green : null,
                    ),
                ],
              ),
              if (actions.isNotEmpty) ...[
                const SizedBox(height: 14),
                Wrap(spacing: 8, runSpacing: 8, children: actions),
              ],
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBoughtActions(BoughtRecord bought) {
    final actions = <Widget>[];

    if (bought.canActivate) {
      actions.add(
        FilledButton.icon(
          onPressed: _busy
              ? null
              : () => _runGuarded(() => _activateFlow(bought)),
          icon: const Icon(Icons.check_circle_outline),
          label: Text(appLocalizations.activate),
        ),
      );
    }

    if (bought.canEarlyRenew) {
      actions.add(
        OutlinedButton.icon(
          onPressed: _busy
              ? null
              : () => _runGuarded(() => _earlyRenewFlow(bought)),
          icon: const Icon(Icons.update),
          label: Text(appLocalizations.earlyRenew),
        ),
      );
    }

    if (storeUpgradeTargets(bought, ref.read(storeProvider).plans).isNotEmpty) {
      actions.add(
        OutlinedButton.icon(
          onPressed: _busy
              ? null
              : () => _runGuarded(() => _upgradeFlow(bought)),
          icon: const Icon(Icons.upgrade),
          label: Text(appLocalizations.upgradePlan),
        ),
      );
    }

    return actions;
  }

  // -- Flows --

  Future<void> _buyWithBalanceFlow(StorePlan plan) async {
    final result = await _showPurchaseSheet(plan, withPayment: false);
    if (result == null) return;

    final res = await CloudApiService().buyPlanWithBalance(
      plan.id,
      billingPeriod: result.billingPeriod,
      coupon: result.coupon,
      autoRenew: result.autoRenew,
    );
    _showResultHtml(res.success, res.message);
    if (res.success) {
      await _refresh();
    }
  }

  Future<void> _orderFlow(StorePlan plan) async {
    final result = await _showPurchaseSheet(plan, withPayment: true);
    if (result == null || result.method == null) return;

    final init = await CloudApiService().createOrder(
      shopId: plan.id,
      payment: result.method!.payment,
      billingPeriod: result.billingPeriod,
      type: result.method!.type,
      coin: result.coin,
      coupon: result.coupon,
      autoRenew: result.autoRenew,
    );
    await _handlePaymentInitiation(init, payment: result.method!.payment);
  }

  Future<void> _rechargeFlow() async {
    final methods = await ref
        .read(storeProvider.notifier)
        .ensurePaymentMethods();
    if (methods.isEmpty) {
      globalState.showNotifier(appLocalizations.noPaymentMethods);
      return;
    }

    final result = await _showRechargeSheet(methods);
    if (result == null) return;

    final init = await CloudApiService().createRecharge(
      payment: result.method.payment,
      amount: result.amount,
      type: result.method.type,
      coin: result.coin,
    );
    await _handlePaymentInitiation(init, payment: result.method.payment);
  }

  Future<void> _activateFlow(BoughtRecord bought) async {
    final ok = await globalState.showMessage(
      title: appLocalizations.activatePlanTitle,
      message: TextSpan(text: appLocalizations.activatePlanConfirm),
      confirmText: appLocalizations.activate,
    );
    if (ok != true) return;
    final res = await CloudApiService().activatePlan(bought.id);
    _showResultHtml(res.success, res.message);
    if (res.success) await _refresh();
  }

  Future<void> _earlyRenewFlow(BoughtRecord bought) async {
    final coupon = await _promptCoupon(appLocalizations.earlyRenew);
    if (coupon == null) return;
    final res = await CloudApiService().earlyRenewPlan(
      bought.id,
      coupon: coupon.isEmpty ? null : coupon,
    );
    _showResultHtml(res.success, res.message);
    if (res.success) await _refresh();
  }

  Future<void> _upgradeFlow(BoughtRecord bought) async {
    final targets = storeUpgradeTargets(bought, ref.read(storeProvider).plans);

    if (targets.isEmpty) {
      globalState.showNotifier(appLocalizations.noUpgradablePlans);
      return;
    }

    final target = await _showPlanPicker(
      appLocalizations.selectUpgradeTarget,
      targets,
    );
    if (target == null) return;

    final res = await CloudApiService().upgradePlan(bought.id, target.id);
    _showResultHtml(res.success, res.message);
    if (res.success) await _refresh();
  }

  // -- Payment initiation handling --

  Future<void> _handlePaymentInitiation(
    PaymentInitiation init, {
    required String payment,
  }) async {
    switch (init.kind) {
      case PaymentInitiationKind.balanceDone:
        _showResultHtml(
          true,
          init.message ?? appLocalizations.operationSuccess,
        );
        await _refresh();
        break;
      case PaymentInitiationKind.externalUrl:
        if (init.url != null) {
          await _showCryptoPaymentDialog(init, payment: payment);
        }
        break;
      case PaymentInitiationKind.cryptoAddress:
        await _showCryptoPaymentDialog(init, payment: payment);
        break;
      case PaymentInitiationKind.error:
        globalState.showNotifier(
          init.message ?? appLocalizations.paymentRequestFailed,
        );
        break;
    }
  }

  Future<void> _showCryptoPaymentDialog(
    PaymentInitiation init, {
    required String payment,
  }) async {
    final paid = await globalState.showCommonDialog<bool>(
      child: _CryptoPaymentDialog(init: init, payment: payment),
    );
    if (paid == true) {
      _showResultHtml(true, appLocalizations.paymentSuccess);
      await _refresh();
    }
  }

  // -- Sheets / dialogs --

  Future<_PurchaseChoice?> _showPurchaseSheet(
    StorePlan plan, {
    required bool withPayment,
  }) async {
    final couponController = TextEditingController();
    final periods = plan.enabledBillingPeriods;
    var selectedPeriodKey = plan.defaultPeriod?.key ?? '';
    var autoRenew = false;
    PaymentMethodOption? method;
    List<PaymentMethodOption> methods = const [];

    if (withPayment) {
      methods = await ref.read(storeProvider.notifier).ensurePaymentMethods();
      if (methods.isEmpty) {
        globalState.showNotifier(appLocalizations.noPaymentMethods);
        return null;
      }
      method = methods.first;
    }

    if (!mounted) return null;

    return showModalBottomSheet<_PurchaseChoice>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (sheetContext, setSheetState) {
            final selectedPeriod =
                periods
                    .where((period) => period.key == selectedPeriodKey)
                    .firstOrNull ??
                plan.defaultPeriod;
            final displayPrice = selectedPeriod?.price ?? plan.price;
            return SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 8,
                  bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan.name,
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _priceText(displayPrice),
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.primary,
                      ),
                    ),
                    if (selectedPeriod != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        [
                          if (selectedPeriod.bandwidth > 0)
                            '${selectedPeriod.bandwidth} GiB',
                          if (selectedPeriod.discountLabel.isNotEmpty)
                            selectedPeriod.discountLabel,
                        ].join(' · '),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    if (periods.length == 1 &&
                        selectedPeriod != null &&
                        selectedPeriod.label.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        selectedPeriod.label,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    if (periods.length > 1) ...[
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: periods.map((period) {
                          return ChoiceChip(
                            label: Text(
                              [
                                period.label,
                                _priceText(period.price),
                                if (period.bandwidth > 0)
                                  '${period.bandwidth} GiB',
                                if (period.discountLabel.isNotEmpty)
                                  period.discountLabel,
                              ].join(' · '),
                            ),
                            selected: period.key == selectedPeriodKey,
                            onSelected: (_) => setSheetState(() {
                              selectedPeriodKey = period.key;
                              if (period.key == 'legacy') autoRenew = false;
                            }),
                          );
                        }).toList(),
                      ),
                    ],
                    const SizedBox(height: 16),
                    TextField(
                      controller: couponController,
                      decoration: InputDecoration(
                        labelText: appLocalizations.discountCodeOptional,
                        border: const OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (plan.autoRenew != 0 && selectedPeriod?.key != 'legacy')
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(appLocalizations.enableAutoRenew),
                        value: autoRenew,
                        onChanged: (v) => setSheetState(() => autoRenew = v),
                      ),
                    if (withPayment) ...[
                      const SizedBox(height: 4),
                      Text(
                        appLocalizations.paymentMethod,
                        style: context.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: methods.map((m) {
                          final selected = m.payment == method?.payment;
                          return ChoiceChip(
                            avatar: _paymentIcon(m),
                            label: Text(m.name),
                            selected: selected,
                            onSelected: (_) => setSheetState(() => method = m),
                          );
                        }).toList(),
                      ),
                    ],
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(
                            sheetContext,
                            _PurchaseChoice(
                              billingPeriod:
                                  selectedPeriodKey.isEmpty ||
                                      selectedPeriodKey == 'legacy'
                                  ? null
                                  : selectedPeriodKey,
                              coupon: couponController.text.trim(),
                              autoRenew: autoRenew,
                              method: withPayment ? method : null,
                              coin: null,
                            ),
                          );
                        },
                        icon: Icon(
                          withPayment
                              ? Icons.payment
                              : Icons.account_balance_wallet_outlined,
                        ),
                        label: Text(
                          withPayment
                              ? appLocalizations.goPay
                              : appLocalizations.confirmPurchase,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<_RechargeChoice?> _showRechargeSheet(
    List<PaymentMethodOption> methods,
  ) async {
    final amountController = TextEditingController();
    PaymentMethodOption method = methods.first;

    return showModalBottomSheet<_RechargeChoice>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (sheetContext, setSheetState) {
            return SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 8,
                  bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLocalizations.recharge,
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: amountController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        labelText: appLocalizations.rechargeAmount,
                        hintText:
                            '${method.min.toInt()} - ${method.max.toInt()}',
                        border: const OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      appLocalizations.paymentMethod,
                      style: context.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: methods.map((m) {
                        final selected = m.payment == method.payment;
                        return ChoiceChip(
                          avatar: _paymentIcon(m),
                          label: Text(m.name),
                          selected: selected,
                          onSelected: (_) => setSheetState(() => method = m),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          final amount =
                              double.tryParse(amountController.text.trim()) ??
                              0;
                          if (amount <= 0) {
                            globalState.showNotifier(
                              appLocalizations.invalidAmount,
                            );
                            return;
                          }
                          Navigator.pop(
                            sheetContext,
                            _RechargeChoice(
                              amount: amount,
                              method: method,
                              coin: null,
                            ),
                          );
                        },
                        icon: const Icon(Icons.payment),
                        label: Text(appLocalizations.goPay),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<StorePlan?> _showPlanPicker(
    String title,
    List<StorePlan> plans,
  ) async {
    return globalState.showCommonDialog<StorePlan>(
      child: CommonDialog(
        title: title,
        actions: const [],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: plans.map((p) {
            final period =
                p.enabledBillingPeriods
                    .where((period) => period.key == 'yearly')
                    .firstOrNull ??
                p.defaultPeriod;
            return ListTile(
              title: Text(p.name),
              subtitle: period?.label.isNotEmpty == true
                  ? Text(period!.label)
                  : null,
              trailing: Text(_priceText(period?.price ?? p.price)),
              onTap: () =>
                  Navigator.pop(globalState.navigatorKey.currentContext!, p),
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<String?> _promptCoupon(String title) async {
    final controller = TextEditingController();
    return globalState.showCommonDialog<String>(
      child: CommonDialog(
        title: title,
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(globalState.navigatorKey.currentContext!),
            child: Text(appLocalizations.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(
              globalState.navigatorKey.currentContext!,
              controller.text.trim(),
            ),
            child: Text(appLocalizations.confirm),
          ),
        ],
        child: SizedBox(
          width: 300,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: appLocalizations.discountCodeOptional,
              border: const OutlineInputBorder(),
              isDense: true,
            ),
          ),
        ),
      ),
    );
  }

  void _showResultHtml(bool success, String message) {
    final plain = message.replaceAll(RegExp(r'<[^>]*>'), ' ').trim();
    globalState.showNotifier(
      plain.isEmpty
          ? (success
                ? appLocalizations.operationSuccess
                : appLocalizations.operationFailed)
          : plain,
    );
  }
}

enum _StoreSection { plans, orders }

class _PurchaseChoice {
  final String? billingPeriod;
  final String coupon;
  final bool autoRenew;
  final PaymentMethodOption? method;
  final String? coin;

  const _PurchaseChoice({
    required this.billingPeriod,
    required this.coupon,
    required this.autoRenew,
    required this.method,
    required this.coin,
  });
}

class _RechargeChoice {
  final double amount;
  final PaymentMethodOption method;
  final String? coin;

  const _RechargeChoice({
    required this.amount,
    required this.method,
    required this.coin,
  });
}

class _CryptoPaymentDialog extends ConsumerStatefulWidget {
  final PaymentInitiation init;
  final String payment;

  const _CryptoPaymentDialog({required this.init, required this.payment});

  @override
  ConsumerState<_CryptoPaymentDialog> createState() =>
      _CryptoPaymentDialogState();
}

class _CryptoPaymentDialogState extends ConsumerState<_CryptoPaymentDialog> {
  Timer? _timer;
  bool _checking = false;

  @override
  void initState() {
    super.initState();
    final pid = widget.init.pid;
    if (pid != null && pid.isNotEmpty) {
      _timer = Timer.periodic(const Duration(seconds: 6), (_) => _check());
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _check({bool reportError = false}) async {
    final pid = widget.init.pid;
    if (pid == null || pid.isEmpty || _checking) return;
    final accountNotifier = ref.read(cloudAccountProvider.notifier);
    setState(() => _checking = true);
    try {
      final paid = await CloudApiService().queryPaymentPaid(
        pid,
        payment: widget.payment,
      );
      if (paid && mounted) {
        _timer?.cancel();
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (CloudApiException.isUnauthorized(e)) {
        if (mounted) Navigator.of(context).pop(false);
        await accountNotifier.handleUnauthorized();
        return;
      }
      if (reportError) {
        globalState.showNotifier(CloudApiException.clean(e));
      }
    } finally {
      if (mounted) setState(() => _checking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final init = widget.init;
    final isUrl = init.kind == PaymentInitiationKind.externalUrl;
    final hasPaymentId = init.pid != null && init.pid!.isNotEmpty;
    final qrData = isUrl ? (init.renderQrcode ? init.url : null) : init.address;
    return CommonDialog(
      title: appLocalizations.scanOrTransferPay,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(appLocalizations.close),
        ),
        if (isUrl && init.url != null)
          TextButton(
            onPressed: () => globalState.openUrl(init.url!),
            child: Text(appLocalizations.openInBrowser),
          ),
        if (hasPaymentId)
          TextButton(
            onPressed: _checking ? null : () => _check(reportError: true),
            child: Text(
              _checking
                  ? appLocalizations.checkingPayment
                  : appLocalizations.iHavePaid,
            ),
          ),
      ],
      child: SizedBox(
        width: 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (qrData != null && qrData.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                  size: 200,
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
            ],
            if (init.amountText != null) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  appLocalizations.paymentAmount,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 4),
              SelectableText(
                '${init.amountText} ${init.coin ?? ''}'.trim(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
            ],
            if (isUrl) ...[
              Text(
                init.renderQrcode
                    ? appLocalizations.scanToPayNotice
                    : appLocalizations.refreshAfterPayment,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ] else ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  appLocalizations.receivingAddress,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: SelectableText(
                      init.address ?? '',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 18),
                    tooltip: appLocalizations.copy,
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: init.address ?? ''),
                      );
                      globalState.showNotifier(appLocalizations.addressCopied);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                appLocalizations.transferConfirmNotice,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

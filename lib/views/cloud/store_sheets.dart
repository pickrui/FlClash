import 'package:collection/collection.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';

import 'store_widgets.dart';

const _sheetProps = SheetProps(isScrollControlled: true, maxWidth: 420);
const _quickRechargeAmounts = [10.0, 30.0, 50.0, 100.0, 200.0];

/// What the purchase sheet returns; a null [method] pays from the balance.
class StorePurchaseChoice {
  final String? billingPeriod;
  final String coupon;
  final bool autoRenew;
  final PaymentMethodOption? method;

  const StorePurchaseChoice({
    required this.billingPeriod,
    required this.coupon,
    required this.autoRenew,
    required this.method,
  });
}

class StoreRechargeChoice {
  final double amount;
  final PaymentMethodOption method;

  const StoreRechargeChoice({required this.amount, required this.method});
}

Future<StorePurchaseChoice?> showStorePurchaseSheet(
  BuildContext context, {
  required StorePlan plan,
  required List<PaymentMethodOption> methods,
  String? balance,
}) {
  return showSheet<StorePurchaseChoice>(
    context: context,
    props: _sheetProps,
    builder: (_, type) => StorePurchaseSheet(
      type: type,
      plan: plan,
      methods: methods,
      balance: balance,
    ),
  );
}

Future<StoreRechargeChoice?> showStoreRechargeSheet(
  BuildContext context, {
  required List<PaymentMethodOption> methods,
}) {
  return showSheet<StoreRechargeChoice>(
    context: context,
    props: _sheetProps,
    builder: (_, type) => StoreRechargeSheet(type: type, methods: methods),
  );
}

class StorePurchaseSheet extends StatefulWidget {
  final SheetType type;
  final StorePlan plan;
  final List<PaymentMethodOption> methods;
  final String? balance;

  const StorePurchaseSheet({
    super.key,
    required this.type,
    required this.plan,
    required this.methods,
    this.balance,
  });

  @override
  State<StorePurchaseSheet> createState() => _StorePurchaseSheetState();
}

class _StorePurchaseSheetState extends State<StorePurchaseSheet> {
  final _coupon = TextEditingController();
  late String _periodKey = widget.plan.defaultPeriod?.key ?? '';
  var _autoRenew = true;
  PaymentMethodOption? _method;

  @override
  void dispose() {
    _coupon.dispose();
    super.dispose();
  }

  BillingPeriod? get _period =>
      widget.plan.enabledBillingPeriods
          .where((period) => period.key == _periodKey)
          .firstOrNull ??
      widget.plan.defaultPeriod;

  bool get _allowsAutoRenew =>
      widget.plan.autoRenew != 0 && _period?.key != 'legacy';

  void _confirm() {
    final key = _period?.key ?? '';
    Navigator.of(context).pop(
      StorePurchaseChoice(
        billingPeriod: key.isEmpty || key == 'legacy' ? null : key,
        coupon: _coupon.text.trim(),
        // A hidden switch must not submit a stale value.
        autoRenew: _allowsAutoRenew && _autoRenew,
        method: _method,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final plan = widget.plan;
    final periods = plan.enabledBillingPeriods;
    final period = _period;
    final details = [
      if (period != null && period.bandwidth > 0) '${period.bandwidth} GiB',
      if (period != null && period.discountLabel.isNotEmpty)
        period.discountLabel,
    ].join(' · ');
    final payWithBalance = _method == null;
    return AdaptiveSheetScaffold(
      type: widget.type,
      title: appLocalizations.confirmPurchase,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plan.name,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              spacing: 8,
              children: [
                Text(
                  storePriceText(period?.price ?? plan.price),
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (period != null && period.label.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text(
                      period.label,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
              ],
            ),
            if (details.isNotEmpty)
              Text(
                details,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            if (periods.length > 1) ...[
              _SectionLabel(appLocalizations.billingPeriodLabel),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final option in periods)
                    ChoiceChip(
                      label: Text(
                        '${option.label} · ${storePriceText(option.price)}',
                      ),
                      selected: option.key == period?.key,
                      onSelected: (_) =>
                          setState(() => _periodKey = option.key),
                    ),
                ],
              ),
            ],
            const SizedBox(height: 20),
            TextField(
              controller: _coupon,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: appLocalizations.discountCodeOptional,
                prefixIcon: const Icon(Icons.sell_outlined),
                border: const OutlineInputBorder(),
                isDense: true,
              ),
            ),
            if (_allowsAutoRenew)
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(appLocalizations.enableAutoRenew),
                value: _autoRenew,
                onChanged: (value) => setState(() => _autoRenew = value),
              ),
            _SectionLabel(appLocalizations.paymentMethod),
            StorePaymentOptionTile(
              leading: Icon(
                Icons.account_balance_wallet_outlined,
                color: context.colorScheme.primary,
              ),
              title: appLocalizations.payWithBalance,
              subtitle: widget.balance == null
                  ? null
                  : appLocalizations.availableBalance(
                      storeMoneyText(widget.balance),
                    ),
              selected: payWithBalance,
              onTap: () => setState(() => _method = null),
            ),
            for (final method in widget.methods)
              StorePaymentOptionTile(
                leading: StorePaymentIcon(method: method),
                title: method.displayName,
                selected: identical(method, _method),
                onTap: () => setState(() => _method = method),
              ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _confirm,
                icon: Icon(
                  payWithBalance
                      ? Icons.account_balance_wallet_outlined
                      : Icons.payment,
                ),
                label: Text(
                  payWithBalance
                      ? appLocalizations.buy
                      : appLocalizations.goPay,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoreRechargeSheet extends StatefulWidget {
  final SheetType type;
  final List<PaymentMethodOption> methods;

  const StoreRechargeSheet({
    super.key,
    required this.type,
    required this.methods,
  });

  @override
  State<StoreRechargeSheet> createState() => _StoreRechargeSheetState();
}

class _StoreRechargeSheetState extends State<StoreRechargeSheet> {
  final _amount = TextEditingController();
  late PaymentMethodOption _method = widget.methods.first;

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  void _setAmount(double value) {
    final text = storePriceText(value).substring(1);
    _amount.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final amount = parseRechargeAmount(_amount.text);
    final invalid = amount == null && _amount.text.trim().isNotEmpty;
    final outOfRange = amount != null && !_method.accepts(amount);
    final quickAmounts = _quickRechargeAmounts.where(_method.accepts);
    return AdaptiveSheetScaffold(
      type: widget.type,
      title: appLocalizations.recharge,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _amount,
              onChanged: (_) => setState(() {}),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: appLocalizations.rechargeAmount,
                border: const OutlineInputBorder(),
                isDense: true,
                helperText: _method.max > 0
                    ? appLocalizations.rechargeAllowedRange(
                        storePriceText(_method.min),
                        storePriceText(_method.max),
                      )
                    : null,
                errorText: invalid
                    ? appLocalizations.invalidAmount
                    : outOfRange
                    ? appLocalizations.rechargeAmountOutOfRange
                    : null,
              ),
            ),
            if (quickAmounts.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final value in quickAmounts)
                    ChoiceChip(
                      label: Text(storePriceText(value)),
                      selected: amount == value,
                      onSelected: (_) => _setAmount(value),
                    ),
                ],
              ),
            ],
            _SectionLabel(appLocalizations.paymentMethod),
            for (final method in widget.methods)
              StorePaymentOptionTile(
                leading: StorePaymentIcon(method: method),
                title: method.displayName,
                selected: identical(method, _method),
                onTap: () => setState(() => _method = method),
              ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: amount != null && !outOfRange
                    ? () => Navigator.of(context).pop(
                        StoreRechargeChoice(amount: amount, method: _method),
                      )
                    : null,
                icon: const Icon(Icons.payment),
                label: Text(appLocalizations.goPay),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;

  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        text,
        style: context.textTheme.titleSmall?.copyWith(
          color: context.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class StorePaymentOptionTile extends StatelessWidget {
  final Widget leading;
  final String title;
  final String? subtitle;
  final bool selected;
  final VoidCallback onTap;

  const StorePaymentOptionTile({
    super.key,
    required this.leading,
    required this.title,
    this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: selected ? scheme.primary : scheme.outlineVariant,
        width: selected ? 1.5 : 1,
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Semantics(
        selected: selected,
        inMutuallyExclusiveGroup: true,
        child: Material(
          color: selected
              ? scheme.primaryContainer.withValues(alpha: 0.4)
              : Colors.transparent,
          shape: shape,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  leading,
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: context.textTheme.bodyLarge),
                        if (subtitle case final subtitle?)
                          Text(
                            subtitle,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Icon(
                    selected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    size: 20,
                    color: selected ? scheme.primary : scheme.outline,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:fl_clash/l10n/l10n.dart';

class BillingPeriod {
  final String key;
  final String label;
  final double price;
  final int bandwidth;
  final String discountLabel;
  final bool enabled;

  const BillingPeriod({
    required this.key,
    required this.label,
    required this.price,
    required this.bandwidth,
    required this.discountLabel,
    required this.enabled,
  });

  factory BillingPeriod.fromJson(Map<dynamic, dynamic> json) {
    return BillingPeriod(
      key: json['key']?.toString().trim() ?? '',
      label: json['label']?.toString() ?? '',
      price: _asDouble(json['price']),
      bandwidth: _asInt(json['bandwidth']),
      discountLabel: json['discount_label']?.toString() ?? '',
      enabled: _asBool(json['enabled']),
    );
  }
}

/// 商店套餐（对应面板 /api/v1/shop/list 返回项）
class StorePlan {
  final int id;
  final String name;
  final double price;
  final String planCode;
  final int planRank;
  final String defaultBillingPeriod;
  final List<BillingPeriod> billingPeriods;
  final int autoRenew;
  final bool supportsAnnual;
  final bool canBuy;
  final bool? canUpgradeTo;
  final int inventory;
  final List<String> tags;

  const StorePlan({
    required this.id,
    required this.name,
    required this.price,
    required this.planCode,
    required this.planRank,
    required this.defaultBillingPeriod,
    required this.billingPeriods,
    required this.autoRenew,
    required this.supportsAnnual,
    required this.canBuy,
    required this.canUpgradeTo,
    required this.inventory,
    this.tags = const [],
  });

  bool get soldOut => inventory == 0;

  List<BillingPeriod> get enabledBillingPeriods {
    final enabled = billingPeriods.where((period) => period.enabled).toList();
    return enabled.isEmpty ? billingPeriods : enabled;
  }

  BillingPeriod? get defaultPeriod {
    return enabledBillingPeriods
            .where((period) => period.key == defaultBillingPeriod)
            .firstOrNull ??
        enabledBillingPeriods.firstOrNull;
  }

  factory StorePlan.fromJson(Map<dynamic, dynamic> json) {
    final legacyClass = _asInt(json['class']);
    final stablePlanCode = json['plan_code']?.toString();
    final planCode = stablePlanCode ?? _legacyPlanCode(legacyClass);
    final periods = _asMapList(json['billing_periods'])
        .map(BillingPeriod.fromJson)
        .where((period) => period.key.isNotEmpty)
        .toList();
    final isAnnual = _asBool(json['is_annual']);
    return StorePlan(
      id: _asInt(json['id']),
      name: json['name']?.toString() ?? '',
      price: _asDouble(json['price']),
      planCode: planCode,
      planRank: json['plan_rank'] != null
          ? _asInt(json['plan_rank'])
          : _planRank(planCode) ?? _legacyPlanRank(legacyClass),
      defaultBillingPeriod: json['default_billing_period']?.toString() ?? '',
      billingPeriods: periods,
      autoRenew: _asInt(json['auto_renew']),
      supportsAnnual: _asBool(json['supports_annual']) || isAnnual,
      canBuy: _asBool(json['can_buy']),
      canUpgradeTo: json.containsKey('can_upgrade_to')
          ? _asBool(json['can_upgrade_to'])
          : null,
      inventory: _asInt(json['inventory']),
      tags: _asStringList(json['tags']),
    );
  }
}

/// 购买记录（对应 /api/v1/shop/bought 返回项）
class BoughtRecord {
  final int id;
  final int shopId;
  final String shopName;
  final int? planRank;
  final bool autoRenew;
  final int status;
  final String buyTime;
  final String billingPeriodText;
  final bool canActivate;
  final bool canEarlyRenew;
  final List<int>? upgradeShopIds;

  const BoughtRecord({
    required this.id,
    required this.shopId,
    required this.shopName,
    required this.planRank,
    required this.autoRenew,
    required this.status,
    required this.buyTime,
    required this.billingPeriodText,
    required this.canActivate,
    required this.canEarlyRenew,
    required this.upgradeShopIds,
  });

  bool get isActive => status == 1;
  bool get isPending => status == 0;

  factory BoughtRecord.fromJson(Map<dynamic, dynamic> json) {
    return BoughtRecord(
      id: _asInt(json['id']),
      shopId: _asInt(json['shop_id']),
      shopName: json['shop_name']?.toString() ?? '',
      planRank: json['plan_rank'] == null ? null : _asInt(json['plan_rank']),
      autoRenew: _asBool(json['auto_renew']),
      status: _asInt(json['status']),
      buyTime: json['buy_time']?.toString() ?? '',
      billingPeriodText: json['billing_period_text']?.toString() ?? '',
      canActivate: json['can_activate'] == null
          ? _asInt(json['status']) == 0
          : _asBool(json['can_activate']),
      canEarlyRenew: json['can_early_renew'] == null
          ? _asInt(json['status']) != -1 && _asBool(json['auto_renew'])
          : _asBool(json['can_early_renew']),
      upgradeShopIds: json.containsKey('upgrade_shop_ids')
          ? _asIntList(json['upgrade_shop_ids'])
          : null,
    );
  }
}

List<StorePlan> decodeStorePlans(dynamic value) {
  return _asMapList(value)
      .where((json) => (_tryAsInt(json['id']) ?? 0) > 0)
      .map(StorePlan.fromJson)
      .toList();
}

List<BoughtRecord> decodeBoughtRecords(dynamic value) {
  return _asMapList(value)
      .where(
        (json) =>
            (_tryAsInt(json['id']) ?? 0) > 0 &&
            (_tryAsInt(json['shop_id']) ?? 0) > 0,
      )
      .map(BoughtRecord.fromJson)
      .toList();
}

String compactStorePlanSummary(List<String> tags) {
  return tags.where((tag) => !tag.trim().startsWith('周期')).join(' · ');
}

List<StorePlan> storeUpgradeTargets(
  BoughtRecord bought,
  List<StorePlan> plans,
) {
  final exactIds = bought.upgradeShopIds;
  if (exactIds != null) {
    final allowedIds = exactIds.toSet();
    return plans
        .where((plan) => allowedIds.contains(plan.id) && !plan.soldOut)
        .toList();
  }

  if (plans.any((plan) => plan.canUpgradeTo != null)) {
    return plans
        .where((plan) => plan.canUpgradeTo == true && !plan.soldOut)
        .toList();
  }

  final current = plans.where((plan) => plan.id == bought.shopId).firstOrNull;
  final currentRank = bought.planRank ?? current?.planRank ?? 0;
  return plans.where((plan) {
    return plan.supportsAnnual &&
        !plan.soldOut &&
        plan.id != bought.shopId &&
        plan.planRank > currentRank;
  }).toList();
}

/// 支付方式（对应 /api/v1/pay/methods 返回项）
class PaymentMethodOption {
  final String payment;
  final String type;
  final String name;
  final double min;
  final double max;

  const PaymentMethodOption({
    required this.payment,
    required this.type,
    required this.name,
    required this.min,
    required this.max,
  });

  bool get isCrypto =>
      payment == 'cryptapi' ||
      payment.startsWith('usdt_') ||
      type == 'cryptapi' ||
      type.startsWith('usdt_');

  factory PaymentMethodOption.fromJson(Map<dynamic, dynamic> json) {
    return PaymentMethodOption(
      payment: json['payment']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      min: _asDouble(json['min']),
      max: _asDouble(json['max']),
    );
  }
}

enum PaymentInitiationKind { cryptoAddress, externalUrl, balanceDone, error }

/// 统一的发起支付结果，兼容 Cryptapi(result.address)、USDT(qrcode/url+tradeno)、
/// Futoon/alpha(url/qrcode 或 302 跳转) 三种网关返回。
class PaymentInitiation {
  final PaymentInitiationKind kind;
  final String? address;
  final String? amountText;
  final String? coin;
  final String? url;
  final bool renderQrcode;
  final String? pid;
  final String? message;

  const PaymentInitiation({
    required this.kind,
    this.address,
    this.amountText,
    this.coin,
    this.url,
    this.renderQrcode = false,
    this.pid,
    this.message,
  });

  static PaymentInitiation parse(
    dynamic data, {
    int? statusCode,
    String? redirectLocation,
  }) {
    if (statusCode == 302 &&
        redirectLocation != null &&
        redirectLocation.isNotEmpty) {
      return PaymentInitiation(
        kind: PaymentInitiationKind.externalUrl,
        url: redirectLocation,
      );
    }

    dynamic decoded = data;
    if (decoded is String) {
      try {
        decoded = jsonDecode(decoded);
      } catch (_) {}
    }
    if (decoded is! Map) {
      return PaymentInitiation(
        kind: PaymentInitiationKind.error,
        message: AppLocalizations.current.paymentUnknownResponse,
      );
    }

    final ret = _asInt(decoded['ret']);
    final result = decoded['result'];

    // Cryptapi：result.address
    if (result is Map && result['address'] != null) {
      return PaymentInitiation(
        kind: PaymentInitiationKind.cryptoAddress,
        address: result['address']?.toString(),
        amountText: result['amount']?.toString(),
        coin: result['coin']?.toString(),
        pid: result['pid']?.toString(),
      );
    }

    final url = decoded['url']?.toString();
    final qrcode = decoded['qrcode']?.toString();
    final rawUrl = url != null && url.isNotEmpty ? url : qrcode;
    if (rawUrl != null && rawUrl.isNotEmpty) {
      final pid = decoded['tradeno']?.toString();
      final amount = decoded['amount']?.toString();
      final render =
          (qrcode != null && qrcode.isNotEmpty) ||
          _asBool(decoded['render_qrcode']);
      final isAddress =
          !(rawUrl.startsWith('http://') || rawUrl.startsWith('https://'));
      if (isAddress) {
        // USDT 链上地址
        return PaymentInitiation(
          kind: PaymentInitiationKind.cryptoAddress,
          address: rawUrl,
          amountText: amount,
          coin: 'USDT',
          pid: pid,
        );
      }
      return PaymentInitiation(
        kind: PaymentInitiationKind.externalUrl,
        url: rawUrl,
        amountText: amount,
        pid: pid,
        renderQrcode: render,
      );
    }

    if (ret == 200) {
      return PaymentInitiation(
        kind: PaymentInitiationKind.balanceDone,
        message:
            decoded['msg']?.toString() ??
            AppLocalizations.current.operationSuccess,
      );
    }

    final msg = (decoded['errmsg'] ?? decoded['msg'] ?? decoded['message'])
        ?.toString();
    return PaymentInitiation(
      kind: PaymentInitiationKind.error,
      message: msg ?? AppLocalizations.current.paymentRequestFailed,
    );
  }
}

int _asInt(dynamic value) => _tryAsInt(value) ?? 0;

double _asDouble(dynamic v) {
  if (v is double) return v;
  if (v is num) return v.toDouble();
  return double.tryParse(v?.toString() ?? '') ?? 0.0;
}

bool _asBool(dynamic v) {
  if (v is bool) return v;
  if (v is num) return v != 0;
  final s = v?.toString().toLowerCase();
  return s == '1' || s == 'true' || s == 'yes';
}

List<String> _asStringList(dynamic v) {
  if (v is List) {
    return v
        .map((e) => e?.toString() ?? '')
        .where((e) => e.isNotEmpty)
        .toList();
  }
  return const [];
}

List<int> _asIntList(dynamic v) {
  if (v is List) {
    return v
        .map(_tryAsInt)
        .whereType<int>()
        .where((value) => value > 0)
        .toList();
  }
  return const [];
}

int? _tryAsInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '');
}

List<Map<dynamic, dynamic>> _asMapList(dynamic value) {
  if (value is! List) return const [];
  return value.whereType<Map>().toList();
}

String _legacyPlanCode(int legacyClass) => switch (legacyClass) {
  1 => 'iron',
  2 => 'alu',
  3 => 'bronze',
  4 => 'silver',
  5 => 'gold',
  6 => 'platinum',
  7 => 'developer',
  8 => 'team',
  9 => 'enterprise',
  10 => 'realtime',
  11 => 'titanium',
  _ => 'no_plan',
};

int? _planRank(String planCode) => switch (planCode.toLowerCase()) {
  'no_plan' => 0,
  'iron' => 10,
  'alu' => 20,
  'bronze' => 30,
  'silver' => 40,
  'gold' => 50,
  'platinum' => 60,
  'diamond' || 'developer' => 70,
  'team' => 80,
  'enterprise' => 90,
  'realtime' => 100,
  'titanium' => 110,
  _ => null,
};

int _legacyPlanRank(int legacyClass) => switch (legacyClass) {
  1 => 10,
  2 => 20,
  3 => 30,
  4 => 40,
  5 => 50,
  6 => 60,
  7 => 70,
  8 => 80,
  9 => 90,
  10 => 100,
  11 => 110,
  _ => 0,
};

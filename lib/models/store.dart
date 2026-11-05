import 'dart:convert';

import 'package:fl_clash/l10n/l10n.dart';

/// 商店套餐（对应面板 /api/v1/shop/list 返回项）
class StorePlan {
  final int id;
  final String name;
  final double price;
  final String content;
  final int bandwidth;
  final int userClass;
  final int classExpireDays;
  final int autoRenew;
  final bool realtimePay;
  final bool isTeamPackage;
  final bool isAnnual;
  final bool canBuy;
  final bool canUpgradeTo;
  final int inventory;
  final List<String> tags;

  const StorePlan({
    required this.id,
    required this.name,
    required this.price,
    required this.content,
    required this.bandwidth,
    required this.userClass,
    required this.classExpireDays,
    required this.autoRenew,
    required this.realtimePay,
    required this.isTeamPackage,
    required this.isAnnual,
    required this.canBuy,
    required this.canUpgradeTo,
    required this.inventory,
    this.tags = const [],
  });

  bool get soldOut => inventory == 0;

  factory StorePlan.fromJson(Map<dynamic, dynamic> json) {
    return StorePlan(
      id: _asInt(json['id']),
      name: json['name']?.toString() ?? '',
      price: _asDouble(json['price']),
      content: json['content']?.toString() ?? '',
      bandwidth: _asInt(json['bandwidth']),
      userClass: _asInt(json['class']),
      classExpireDays: _asInt(json['class_expire_days']),
      autoRenew: _asInt(json['auto_renew']),
      realtimePay: _asBool(json['realtime_pay']),
      isTeamPackage: _asBool(json['is_team_package']),
      isAnnual: _asBool(json['is_annual']),
      canBuy: _asBool(json['can_buy']),
      canUpgradeTo: _asBool(json['can_upgrade_to']),
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
  final double buyPrice;
  final double renewPrice;
  final int bandwidth;
  final String coupon;
  final bool autoRenew;
  final int status;
  final String buyTime;
  final bool canUpgrade;

  const BoughtRecord({
    required this.id,
    required this.shopId,
    required this.shopName,
    required this.buyPrice,
    required this.renewPrice,
    required this.bandwidth,
    required this.coupon,
    required this.autoRenew,
    required this.status,
    required this.buyTime,
    required this.canUpgrade,
  });

  bool get isActive => status == 1;
  bool get isPending => status == 0;
  bool get isExpired => status == -1;

  factory BoughtRecord.fromJson(Map<dynamic, dynamic> json) {
    return BoughtRecord(
      id: _asInt(json['id']),
      shopId: _asInt(json['shop_id']),
      shopName: json['shop_name']?.toString() ?? '',
      buyPrice: _asDouble(json['buy_price']),
      renewPrice: _asDouble(json['renew_price']),
      bandwidth: _asInt(json['bandwidth']),
      coupon: json['coupon']?.toString() ?? '',
      autoRenew: _asBool(json['auto_renew']),
      status: _asInt(json['status']),
      buyTime: json['buy_time']?.toString() ?? '',
      canUpgrade: _asBool(json['can_upgrade']),
    );
  }
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

    final rawUrl = (decoded['url'] ?? decoded['qrcode'])?.toString();
    if (rawUrl != null && rawUrl.isNotEmpty) {
      final pid = decoded['tradeno']?.toString();
      final amount = decoded['amount']?.toString();
      final render = decoded['render_qrcode'] == true ||
          decoded['render_qrcode'] == 'true';
      final isAddress = !(rawUrl.startsWith('http://') ||
          rawUrl.startsWith('https://'));
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
        message: decoded['msg']?.toString() ?? AppLocalizations.current.operationSuccess,
      );
    }

    final msg = (decoded['errmsg'] ??
            decoded['msg'] ??
            decoded['message'])
        ?.toString();
    return PaymentInitiation(
      kind: PaymentInitiationKind.error,
      message: msg ?? AppLocalizations.current.paymentRequestFailed,
    );
  }
}

int _asInt(dynamic v) {
  if (v is int) return v;
  if (v is num) return v.toInt();
  return int.tryParse(v?.toString() ?? '') ?? 0;
}

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

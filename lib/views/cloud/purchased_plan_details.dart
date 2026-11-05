import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/cloud_account.dart';
import 'package:fl_clash/models/store.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PurchasedPlanSummary {
  final BoughtRecord bought;
  final CloudProfile? profile;
  final DateTime now;

  PurchasedPlanSummary({required this.bought, this.profile, DateTime? now})
    : now = now ?? DateTime.now();

  int? get remainingMinutes {
    if (bought.isPending) return bought.durationMinutes;
    if (!bought.isActive ||
        profile == null ||
        profile!.expireTime.millisecondsSinceEpoch <= 0) {
      return null;
    }
    final seconds = profile!.expireTime.difference(now).inSeconds;
    return seconds <= 0 ? 0 : (seconds / 60).ceil();
  }

  String? get remainingTraffic {
    if (bought.isPending) {
      return bought.bandwidthGiB == null ? null : '${bought.bandwidthGiB} GiB';
    }
    return bought.isActive ? nonempty(profile?.remaining) : null;
  }

  static String? nonempty(String? value) =>
      value == null || value.trim().isEmpty ? null : value.trim();
}

class PurchasedPlanDetails extends StatelessWidget {
  final BoughtRecord bought;
  final CloudProfile? profile;
  final DateTime? now;

  const PurchasedPlanDetails({
    super.key,
    required this.bought,
    this.profile,
    this.now,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final summary = PurchasedPlanSummary(
      bought: bought,
      profile: profile,
      now: now,
    );
    final minutes = summary.remainingMinutes;
    final ended = !bought.isActive && !bought.isPending;
    final duration = minutes == null
        ? null
        : [
            if (minutes >= 1440) l10n.purchaseDays(minutes ~/ 1440),
            if (minutes % 1440 >= 60)
              l10n.purchaseHours((minutes % 1440) ~/ 60),
            if (minutes % 60 > 0 || minutes == 0)
              l10n.purchaseMinutes(minutes % 60),
          ].join(' ');
    String? price(double? value) => value == null
        ? null
        : '¥${value.toStringAsFixed(value == value.roundToDouble() ? 0 : 2)}';
    final details = <(String, String?)>[
      (l10n.purchasedAtLabel, PurchasedPlanSummary.nonempty(bought.buyTime)),
      (l10n.purchasePriceLabel, price(bought.buyPrice)),
      (
        l10n.billingPeriodLabel,
        PurchasedPlanSummary.nonempty(bought.billingPeriodText),
      ),
      (l10n.remainingTimeLabel, ended ? l10n.planEnded : duration),
      (
        l10n.remainingTrafficLabel,
        ended ? l10n.planEnded : summary.remainingTraffic,
      ),
      if (bought.isActive && profile != null) ...[
        if (profile!.expireTime.millisecondsSinceEpoch > 0)
          (
            l10n.expiresAtLabel,
            DateFormat(
              'yyyy-MM-dd HH:mm',
            ).format(profile!.expireTime.toLocal()),
          ),
        (
          l10n.usedTrafficLabel,
          PurchasedPlanSummary.nonempty(profile!.totalUsed),
        ),
        (
          l10n.purchaseTotalTrafficLabel,
          PurchasedPlanSummary.nonempty(profile!.totalTraffic),
        ),
      ],
      if (!ended) ...[
        (
          l10n.purchaseAutoRenewLabel,
          bought.autoRenew ? l10n.purchaseRenewOn : l10n.purchaseRenewOff,
        ),
        if (bought.autoRenew && bought.renewPrice != null)
          (l10n.purchaseRenewalPriceLabel, price(bought.renewPrice)),
      ],
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final stacked =
            constraints.maxWidth < 360 ||
            MediaQuery.textScalerOf(context).scale(14) > 20;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final (label, value) in details)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: stacked
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                          const SizedBox(height: 2),
                          Text(value ?? l10n.noData),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              label,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              value ?? l10n.noData,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
              ),
          ],
        );
      },
    );
  }
}

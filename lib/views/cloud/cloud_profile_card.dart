import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cloud_layout.dart';

class CloudProfileCard extends StatelessWidget {
  final CloudProfile profile;

  const CloudProfileCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final secondary = context.textTheme.bodySmall?.copyWith(
      color: context.colorScheme.onSurfaceVariant,
    );

    return CommonCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => launchUrl(
                    Uri.parse('https://${Secrets.primarySiteDomain}/user'),
                  ),
                  child: const CloudIconTile(
                    icon: Icons.account_circle,
                    size: 52,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.subscription,
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      if (_expiryText(profile) case final expiry?)
                        Text(
                          AppLocalizations.current.expireDate(expiry),
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildInfo(
              context,
              Icons.today,
              AppLocalizations.current.todayUsed,
              profile.todayUsed,
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: profile.usageProgress,
              borderRadius: BorderRadius.circular(2),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 16,
                runSpacing: 2,
                children: [
                  Text(
                    '${AppLocalizations.current.usedTrafficLabel} '
                    '${profile.totalUsed} / ${profile.totalTraffic}',
                    style: secondary,
                  ),
                  Text(
                    AppLocalizations.current.remaining(profile.remaining),
                    style: secondary,
                  ),
                ],
              ),
            ),
            const Divider(height: 32),
            _buildInfo(
              context,
              Icons.account_balance_wallet,
              AppLocalizations.current.balance,
              storeMoneyText(profile.balance),
            ),
            const SizedBox(height: 12),
            _buildInfo(
              context,
              Icons.monetization_on,
              AppLocalizations.current.commission,
              storeMoneyText(profile.commission),
            ),
            const SizedBox(height: 12),
            _buildInfo(
              context,
              Icons.stars,
              AppLocalizations.current.points,
              profile.points,
            ),
          ],
        ),
      ),
    );
  }

  static String? _expiryText(CloudProfile profile) {
    if (profile.expireTime.millisecondsSinceEpoch <= 0) return null;
    return DateFormat('yyyy-MM-dd HH:mm').format(profile.expireTime.toLocal());
  }

  Widget _buildInfo(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(icon, size: 20, color: context.colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          value,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurface,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}

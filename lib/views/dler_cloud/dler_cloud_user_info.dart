import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/dler_cloud.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DlerCloudUserInfoWidget extends StatelessWidget {
  final DlerCloudUserInfo userInfo;

  const DlerCloudUserInfoWidget({
    super.key,
    required this.userInfo,
  });

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.account_circle,
                  size: 32,
                  color: context.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userInfo.plan,
                        style: context.textTheme.titleLarge,
                      ),
                      if (userInfo.planTime.isNotEmpty)
                        Text(
                          '到期时间: ${userInfo.planTime}',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildInfoRow(
              context,
              '今日使用',
              userInfo.todayUsed,
              Icons.today,
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              '已用流量',
              userInfo.used,
              Icons.data_usage,
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              '剩余流量',
              userInfo.unused,
              Icons.storage,
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              '积分',
              userInfo.integral,
              Icons.stars,
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              '余额',
              userInfo.money,
              Icons.account_balance_wallet,
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              '返利',
              userInfo.affMoney,
              Icons.monetization_on,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    Color? color,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: color ?? context.colorScheme.onSurface.withValues(alpha: 0.7),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: context.textTheme.bodyMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}


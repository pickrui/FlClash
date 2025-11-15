import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/dler_cloud.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dler_cloud_login_dialog.dart';
import 'dler_cloud_user_info.dart';

final _announcementProvider = FutureProvider<Result<DlerCloudAnnouncement>>((ref) async {
  final accountNotifier = ref.read(dlerCloudAccountProvider.notifier);
  return await accountNotifier.getAnnouncement();
});

class DlerCloudView extends ConsumerStatefulWidget {
  const DlerCloudView({super.key});

  @override
  ConsumerState<DlerCloudView> createState() => _DlerCloudViewState();
}

class _DlerCloudViewState extends ConsumerState<DlerCloudView> {
  bool _isRefreshing = false;
  bool _isRequestingManaged = false;

  @override
  Widget build(BuildContext context) {
    final accountState = ref.watch(dlerCloudAccountProvider);

    return accountState.when(
      data: (state) {
        if (state.token == null) {
          return _buildNotLoggedInView(context);
        }
        return _buildLoggedInView(context, ref, state);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('错误: $error'),
      ),
    );
  }

  Widget _buildNotLoggedInView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_off,
            size: 64,
            color: context.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'Dler Cloud',
            style: context.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            '登录后可查看账户信息和流量使用情况',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const DlerCloudLoginDialog(),
              );
            },
            icon: const Icon(Icons.login),
            label: const Text('登录'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoggedInView(
    BuildContext context,
    WidgetRef ref,
    DlerCloudAccountState state,
  ) {
    final accountNotifier = ref.read(dlerCloudAccountProvider.notifier);
    final l10n = AppLocalizations.of(context);

    return CommonScaffold(
      title: l10n.dlerCloud,
      actions: _buildAppBarActions(context, ref, accountNotifier),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.userInfo != null)
              DlerCloudUserInfoWidget(
                userInfo: state.userInfo!,
              ),
            const SizedBox(height: 16),
            _buildAnnouncementCard(context, ref),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAppBarActions(
    BuildContext context,
    WidgetRef ref,
    DlerCloudAccount accountNotifier,
  ) {
    return [
      IconButton(
        icon: _isRefreshing
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.refresh),
        onPressed: _isRefreshing
            ? null
            : () async {
                setState(() {
                  _isRefreshing = true;
                });
                try {
                  final userInfoResult = await accountNotifier.refreshUserInfo();
                  ref.invalidate(_announcementProvider);
                  if (mounted && context.mounted) {
                    if (userInfoResult.type == ResultType.success) {
                      context.showNotifier('刷新成功');
                    } else {
                      context.showNotifier('刷新失败: ${userInfoResult.message}');
                    }
                  }
                } finally {
                  if (mounted) {
                    setState(() {
                      _isRefreshing = false;
                    });
                  }
                }
              },
        tooltip: '刷新用户信息',
      ),
      IconButton(
        icon: _isRequestingManaged
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.cloud_download),
        onPressed: _isRequestingManaged
            ? null
            : () async {
                setState(() {
                  _isRequestingManaged = true;
                });
                try {
                  final managedResult = await accountNotifier.getManaged();
                  if (mounted && context.mounted) {
                    if (managedResult.type == ResultType.success) {
                      context.showNotifier('更新订阅地址成功');
                    } else {
                      context.showNotifier('更新订阅地址失败: ${managedResult.message}');
                    }
                  }
                } finally {
                  if (mounted) {
                    setState(() {
                      _isRequestingManaged = false;
                    });
                  }
                }
              },
        tooltip: '更新订阅地址',
      ),
      IconButton(
        icon: const Icon(Icons.exit_to_app),
        onPressed: () async {
          final result = await accountNotifier.logout();
          if (context.mounted) {
            if (result.type == ResultType.success) {
              context.showNotifier('已退出登录');
            } else {
              context.showNotifier('退出失败: ${result.message}');
            }
          }
        },
        tooltip: '退出登录',
      ),
      IconButton(
        icon: const Icon(Icons.delete_forever),
        onPressed: () async {
          final result = await accountNotifier.logoutAndDeleteToken();
          if (context.mounted) {
            if (result.type == ResultType.success) {
              context.showNotifier('注销成功');
            } else {
              context.showNotifier('注销失败: ${result.message}');
            }
          }
        },
        tooltip: '注销 (删除 Access Token)',
      ),
    ];
  }

  Widget _buildAnnouncementCard(
    BuildContext context,
    WidgetRef ref,
  ) {
    final announcementAsync = ref.watch(_announcementProvider);

    return announcementAsync.when(
      data: (result) {
        if (result.type != ResultType.success || result.data == null) {
          return const SizedBox.shrink();
        }

        final announcement = result.data!;
        return CommonCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAnnouncementHeader(context),
                const SizedBox(height: 16),
                if (announcement.date.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      announcement.date,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                SelectableText.rich(
                  _buildAnnouncementText(context, announcement.content),
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      },
      loading: () => CommonCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.announcement,
                size: 24,
                color: context.colorScheme.primary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '公告',
                  style: context.textTheme.titleMedium,
                ),
              ),
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ],
          ),
        ),
      ),
      error: (error, stackTrace) => const SizedBox.shrink(),
    );
  }

  Widget _buildAnnouncementHeader(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.announcement,
          size: 24,
          color: context.colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            '公告',
            style: context.textTheme.titleMedium,
          ),
        ),
      ],
    );
  }

  TextSpan _buildAnnouncementText(BuildContext context, String content) {
    final textStyle = context.textTheme.bodyMedium;
    final hrLine = '─' * 40;
    String processedContent = content
        .replaceAll(RegExp(r'<p[^>]*>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'</p>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'<hr\s*/?>', caseSensitive: false), '\n$hrLine\n')
        .replaceAll(RegExp(r'<[^>]+>', caseSensitive: false), '')
        .trim()
        .replaceAll(RegExp(r'\n{3,}'), '\n\n');
    
    return TextSpan(
      text: processedContent,
      style: textStyle,
    );
  }
}

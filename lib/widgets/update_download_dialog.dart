import 'dart:async';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/update_download_task.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/providers/update_download.dart';
import 'package:fl_clash/widgets/dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

// Closing a progress view leaves its application-owned download running.
enum UpdateDownloadAction { install, browser }

class UpdateDownloadDialog extends StatefulWidget {
  const UpdateDownloadDialog({super.key, required this.task});
  final AppUpdateDownloadTask task;

  @override
  State<UpdateDownloadDialog> createState() => _UpdateDownloadDialogState();
}

class _UpdateDownloadDialogState extends State<UpdateDownloadDialog> {
  @override
  void initState() {
    super.initState();
    widget.task.attachView();
  }

  @override
  void dispose() {
    widget.task.detachView();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.appLocalizations;
    return ValueListenableBuilder(
      valueListenable: widget.task,
      builder: (context, state, _) {
        final downloading = state.phase == AppUpdateDownloadPhase.downloading;
        final ready = state.phase == AppUpdateDownloadPhase.ready;
        return CommonDialog(
          title: ready ? l.updateReady : l.download,
          actions: [
            if (downloading) ...[
              TextButton(
                onPressed: () {
                  widget.task.cancel();
                  Navigator.of(context).pop();
                },
                child: Text(l.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l.updateDownloadBackground),
              ),
            ] else ...[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l.close),
              ),
              if (ready)
                FilledButton(
                  onPressed: () =>
                      Navigator.of(context).pop(UpdateDownloadAction.install),
                  child: Text(l.updateInstall),
                ),
              if (state.phase == AppUpdateDownloadPhase.failed) ...[
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(UpdateDownloadAction.browser),
                  child: Text(l.updateDownloadBrowser),
                ),
                FilledButton(
                  onPressed: () => unawaited(widget.task.retry()),
                  child: Text(l.configRecoveryRetry),
                ),
              ],
            ],
          ],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (downloading) ...[
                LinearProgressIndicator(value: state.progress),
                const SizedBox(height: 12),
                Text(
                  state.progress == null
                      ? l.loading
                      : '${(state.progress! * 100).floor()}%',
                ),
              ] else
                Text(ready ? l.updateReadyHint : l.updateDownloadFailed),
            ],
          ),
        );
      },
    );
  }
}

/// Persistent in-app notice: silent startup is never brought to the foreground.
/// A dismissed notice leaves the installer available from About / Check update.
class AppUpdateReadyNotice extends ConsumerWidget {
  const AppUpdateReadyNotice({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(appUpdateDownloadProvider);
    final l = context.appLocalizations;
    return ValueListenableBuilder(
      valueListenable: task,
      builder: (context, state, _) {
        if (state.phase != AppUpdateDownloadPhase.ready ||
            !state.showReadyNotice ||
            task.hasForegroundView) {
          return const SizedBox.shrink();
        }
        return _UpdateNoticeCard(
          title: l.updateReady,
          message: l.updateReadyHint,
          actions: [
            FilledButton(
              onPressed: () => appController.installAppUpdate(),
              child: Text(l.updateInstall),
            ),
            TextButton(onPressed: task.dismissNotice, child: Text(l.close)),
          ],
        );
      },
    );
  }
}

/// Reports what an automatic check found. The installer is already on its way,
/// so this only names the release; the ready notice takes over once it lands.
/// A release downloaded by an earlier launch is offered here instead.
class AppUpdateAvailableNotice extends ConsumerWidget {
  const AppUpdateAvailableNotice({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notice = ref.watch(appUpdateNoticeProvider);
    final task = ref.watch(appUpdateDownloadProvider);
    final l = context.appLocalizations;
    return ValueListenableBuilder(
      valueListenable: notice,
      builder: (context, info, _) {
        if (info == null) return const SizedBox.shrink();
        return ValueListenableBuilder(
          valueListenable: task,
          builder: (context, state, _) {
            final downloading =
                state.phase == AppUpdateDownloadPhase.downloading;
            // A finished or failed transfer is reported by its own notice and
            // by the About entry; two cards would say the same thing twice.
            if (!downloading && task.hasDownload) {
              return const SizedBox.shrink();
            }
            return _UpdateNoticeCard(
              title: l.discovery,
              message: info.version.isEmpty ? l.noInfo : info.version,
              detail: downloading ? l.updateDownloading : null,
              actions: [
                if (!downloading)
                  FilledButton(
                    onPressed: () => appController.acceptUpdateNotice(),
                    child: Text(l.download),
                  ),
                TextButton(
                  onPressed: () => notice.value = null,
                  child: Text(l.close),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _UpdateNoticeCard extends StatelessWidget {
  const _UpdateNoticeCard({
    required this.title,
    required this.message,
    required this.actions,
    this.detail,
  });

  final String title;
  final String message;
  final String? detail;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final detail = this.detail;
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(message),
                if (detail != null)
                  Text(
                    detail,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                Wrap(spacing: 8, children: actions),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

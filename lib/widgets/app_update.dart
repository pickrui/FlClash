import 'dart:async';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/update_download_task.dart';
import 'package:fl_clash/providers/action.dart';
import 'package:fl_clash/providers/update_download.dart';
import 'package:fl_clash/widgets/dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class AppUpdateAvailableNotice extends ConsumerWidget {
  const AppUpdateAvailableNotice({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notice = ref.watch(appUpdateNoticeProvider);
    return ValueListenableBuilder(
      valueListenable: notice,
      builder: (context, info, _) {
        if (info == null) return const SizedBox.shrink();
        final l = context.appLocalizations;
        void open() => unawaited(
          ref.read(updateActionProvider.notifier).showDetails(info),
        );
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 420),
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: open,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 8, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              l.discovery,
                              style: context.textTheme.titleSmall,
                            ),
                          ),
                          IconButton(
                            tooltip: l.close,
                            icon: const Icon(Icons.close),
                            onPressed: () => ref
                                .read(updateActionProvider.notifier)
                                .dismissNotice(info),
                          ),
                        ],
                      ),
                      if (info.version.isNotEmpty) Text(info.version),
                      const SizedBox(height: 4),
                      TextButton(
                        onPressed: open,
                        child: Text(l.updateViewDetails),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AppUpdatePage extends StatelessWidget {
  const AppUpdatePage({super.key, required this.info});

  final AppUpdateInfo info;

  @override
  Widget build(BuildContext context) {
    final l = context.appLocalizations;
    final notes = info.releaseNotes?.trim();
    return Scaffold(
      appBar: AppBar(title: Text(l.discovery)),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (info.version.isNotEmpty) ...[
                        Text(
                          info.version,
                          style: context.textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 24),
                      ],
                      Text(
                        l.updateReleaseNotes,
                        style: context.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      SelectableText(
                        notes == null || notes.isEmpty ? l.noInfo : notes,
                        style: context.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 1),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: OverflowBar(
                    alignment: MainAxisAlignment.end,
                    spacing: 8,
                    overflowSpacing: 8,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(l.updateLater),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text(l.updateDownloadConfirm),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Closing a progress view leaves its application-owned download running.
enum UpdateDownloadAction { install, browser }

class UpdateDownloadDialog extends StatelessWidget {
  const UpdateDownloadDialog({super.key, required this.task});
  final AppUpdateDownloadTask task;

  @override
  Widget build(BuildContext context) {
    final l = context.appLocalizations;
    return ValueListenableBuilder(
      valueListenable: task,
      builder: (context, state, _) {
        final downloading = state.phase == AppUpdateDownloadPhase.downloading;
        final ready = state.phase == AppUpdateDownloadPhase.ready;
        return CommonDialog(
          title: ready ? l.updateReady : l.download,
          maxWidth: 360,
          actions: [
            if (downloading) ...[
              TextButton(
                onPressed: () {
                  task.cancel();
                  Navigator.of(context).pop();
                },
                child: Text(l.updateCancelDownload),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l.updateDownloadBackground),
              ),
            ] else ...[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(ready ? l.updateLater : l.close),
              ),
              if (ready)
                FilledButton(
                  onPressed: () =>
                      Navigator.of(context).pop(UpdateDownloadAction.install),
                  child: Text(l.updateInstall),
                ),
              if (state.phase == AppUpdateDownloadPhase.failed) ...[
                FilledButton(
                  onPressed: () => unawaited(task.retry()),
                  child: Text(l.configRecoveryRetry),
                ),
              ],
            ],
          ],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              if (state.phase == AppUpdateDownloadPhase.failed) ...[
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: () =>
                      Navigator.of(context).pop(UpdateDownloadAction.browser),
                  icon: const Icon(Icons.open_in_new, size: 18),
                  label: Text(l.updateDownloadBrowser),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

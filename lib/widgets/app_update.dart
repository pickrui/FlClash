import 'dart:async';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/update_download_task.dart';
import 'package:fl_clash/providers/action.dart';
import 'package:fl_clash/providers/update_download.dart';
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
        final colors = context.colorScheme;
        final onContainer = colors.onPrimaryContainer;
        void open() => unawaited(
          ref.read(updateActionProvider.notifier).showDetails(info),
        );
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 420),
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 3,
              color: colors.primaryContainer,
              child: InkWell(
                onTap: open,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
                  child: Row(
                    children: [
                      Icon(Icons.system_update, color: onContainer),
                      const SizedBox(width: 12),
                      // The version and notes stay on the details page; this only
                      // has to be noticed and offer a way in.
                      Expanded(
                        child: Text(
                          l.updateNotice,
                          style: context.textTheme.titleSmall?.copyWith(
                            color: onContainer,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(onPressed: open, child: Text(l.view)),
                      IconButton(
                        tooltip: l.close,
                        color: onContainer,
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(Icons.close),
                        onPressed: () => ref
                            .read(updateActionProvider.notifier)
                            .dismissNotice(info),
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

// Closing the page leaves its application-owned download running.
enum UpdateDownloadAction { install, browser }

class AppUpdatePage extends StatefulWidget {
  const AppUpdatePage({
    super.key,
    required this.info,
    required this.task,
    required this.loadReleaseNotes,
    required this.onDownload,
  });

  final AppUpdateInfo info;
  final AppUpdateDownloadTask task;
  final Future<String?> Function() loadReleaseNotes;
  final Future<void> Function() onDownload;

  @override
  State<AppUpdatePage> createState() => _AppUpdatePageState();
}

class _AppUpdatePageState extends State<AppUpdatePage> {
  late Future<String?> _notes;
  bool _starting = false;

  @override
  void initState() {
    super.initState();
    _notes = _initialNotes();
  }

  @override
  void didUpdateWidget(covariant AppUpdatePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.info != widget.info) _notes = _initialNotes();
  }

  Future<String?> _initialNotes() {
    final notes = widget.info.releaseNotes?.trim();
    return notes == null || notes.isEmpty
        ? Future.sync(widget.loadReleaseNotes)
        : Future.value(notes);
  }

  /// Choosing a package or reaching the temporary directory happens before the
  /// task reports anything, so the button holds the wait itself.
  Future<void> _startDownload() async {
    if (_starting) return;
    setState(() => _starting = true);
    try {
      await widget.onDownload();
    } finally {
      if (mounted) setState(() => _starting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.appLocalizations;
    final info = widget.info;
    final version = releaseTagNameFromVersionData(info.version);
    final buildNumber = info.remoteBuildNumber > 0
        ? info.remoteBuildNumber
        : int.tryParse(info.version.split('+').last) ?? 0;
    final fullVersion = version == null
        ? null
        : buildNumber > 0
        ? '${version.substring(1)}+$buildNumber'
        : version.substring(1);
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
                      if (fullVersion != null)
                        Text(l.updateVersionNumber(fullVersion))
                      else if (buildNumber > 0)
                        Text(l.updateBuildNumber('$buildNumber')),
                      if (version != null || buildNumber > 0)
                        const SizedBox(height: 24),
                      Text(
                        l.updateReleaseNotes,
                        style: context.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      FutureBuilder<String?>(
                        future: _notes,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const LinearProgressIndicator(),
                                const SizedBox(height: 12),
                                Text(l.loading),
                              ],
                            );
                          }
                          final notes = snapshot.data?.trim();
                          if (!snapshot.hasError &&
                              notes != null &&
                              notes.isNotEmpty) {
                            return SelectableText(
                              notes,
                              style: context.textTheme.bodyLarge,
                            );
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(l.updateReleaseNotesFailed),
                              const SizedBox(height: 8),
                              OutlinedButton.icon(
                                onPressed: () => setState(() {
                                  _notes = Future.sync(widget.loadReleaseNotes);
                                }),
                                icon: const Icon(Icons.refresh),
                                label: Text(l.configRecoveryRetry),
                              ),
                            ],
                          );
                        },
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
                  child: _UpdateDownloadBar(
                    task: widget.task,
                    starting: _starting,
                    onDownload: _startDownload,
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

enum _DownloadStage { idle, preparing, downloading, ready, failed }

class _UpdateDownloadBar extends StatelessWidget {
  const _UpdateDownloadBar({
    required this.task,
    required this.starting,
    required this.onDownload,
  });

  final AppUpdateDownloadTask task;
  final bool starting;
  final VoidCallback onDownload;

  _DownloadStage _stage(AppUpdateDownloadPhase phase) => switch (phase) {
    AppUpdateDownloadPhase.downloading => _DownloadStage.downloading,
    AppUpdateDownloadPhase.ready => _DownloadStage.ready,
    AppUpdateDownloadPhase.failed => _DownloadStage.failed,
    _ => starting ? _DownloadStage.preparing : _DownloadStage.idle,
  };

  static void _close(BuildContext context, [UpdateDownloadAction? action]) =>
      Navigator.of(context).pop(action);

  List<Widget> _status(
    BuildContext context,
    _DownloadStage stage,
    double? progress,
  ) {
    final l = context.appLocalizations;
    return switch (stage) {
      _DownloadStage.idle => const [],
      _DownloadStage.preparing || _DownloadStage.downloading => [
        LinearProgressIndicator(value: progress),
        const SizedBox(height: 12),
        Text(
          progress == null
              ? l.updateDownloading
              : '${(progress * 100).floor()}%',
        ),
        const SizedBox(height: 16),
      ],
      _DownloadStage.ready => [
        Text(l.updateReadyHint),
        const SizedBox(height: 16),
      ],
      _DownloadStage.failed => [
        Text(l.updateDownloadFailed),
        const SizedBox(height: 4),
        TextButton.icon(
          onPressed: () => _close(context, UpdateDownloadAction.browser),
          icon: const Icon(Icons.open_in_new, size: 18),
          label: Text(l.updateDownloadBrowser),
        ),
        const SizedBox(height: 8),
      ],
    };
  }

  List<Widget> _actions(BuildContext context, _DownloadStage stage) {
    final l = context.appLocalizations;
    void close() => _close(context);
    return switch (stage) {
      _DownloadStage.downloading => [
        TextButton(onPressed: task.cancel, child: Text(l.updateCancelDownload)),
        FilledButton(onPressed: close, child: Text(l.updateDownloadBackground)),
      ],
      _DownloadStage.ready => [
        TextButton(onPressed: close, child: Text(l.updateLater)),
        FilledButton(
          onPressed: () => _close(context, UpdateDownloadAction.install),
          child: Text(l.updateInstall),
        ),
      ],
      _DownloadStage.failed => [
        TextButton(onPressed: close, child: Text(l.close)),
        FilledButton(
          onPressed: () => unawaited(task.retry()),
          child: Text(l.configRecoveryRetry),
        ),
      ],
      _DownloadStage.idle || _DownloadStage.preparing => [
        TextButton(onPressed: close, child: Text(l.updateLater)),
        FilledButton(
          onPressed: stage == _DownloadStage.preparing ? null : onDownload,
          child: Text(l.updateDownloadConfirm),
        ),
      ],
    };
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: task,
    builder: (context, state, _) {
      final stage = _stage(state.phase);
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._status(context, stage, state.progress),
          Align(
            alignment: Alignment.centerRight,
            child: OverflowBar(
              alignment: MainAxisAlignment.end,
              spacing: 8,
              overflowSpacing: 8,
              children: _actions(context, stage),
            ),
          ),
        ],
      );
    },
  );
}

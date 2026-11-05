import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/widgets/dialog.dart';
import 'package:flutter/material.dart';

class UpdateDownloadResult {
  const UpdateDownloadResult.success(File this.file) : error = null;

  const UpdateDownloadResult.failure(Object this.error) : file = null;

  final File? file;
  final Object? error;
}

class UpdateDownloadDialog extends StatefulWidget {
  const UpdateDownloadDialog({super.key, required this.download});

  final Future<File> Function(CancelToken token, ProgressCallback onProgress)
  download;

  @override
  State<UpdateDownloadDialog> createState() => _UpdateDownloadDialogState();
}

class _UpdateDownloadDialogState extends State<UpdateDownloadDialog> {
  final _token = CancelToken();
  double? _progress;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _download());
  }

  Future<void> _download() async {
    if (!mounted) return;
    UpdateDownloadResult result;
    try {
      final file = await widget.download(_token, (received, total) {
        if (!mounted || _token.isCancelled) return;
        setState(
          () => _progress = total > 0 ? (received / total).clamp(0, 1) : null,
        );
      });
      result = UpdateDownloadResult.success(file);
    } catch (error) {
      result = UpdateDownloadResult.failure(error);
    }
    final route = mounted ? ModalRoute.of<UpdateDownloadResult>(context) : null;
    if (_token.isCancelled || route == null || !route.isActive) {
      // A download may finish just as the route is dismissed. Its installer is
      // no longer needed, even if cancellation arrived after the file was saved.
      try {
        await result.file?.delete();
      } on FileSystemException {
        // Temporary storage may already have been removed during cancellation.
      }
      return;
    }
    if (route.isCurrent) {
      route.navigator?.pop(result);
    } else {
      route.navigator?.removeRoute(route, result);
    }
  }

  @override
  void dispose() {
    _token.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return PopScope<UpdateDownloadResult>(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) _token.cancel();
      },
      child: CommonDialog(
        title: l.download,
        actions: [
          TextButton(
            onPressed: () {
              _token.cancel();
              Navigator.of(context).pop();
            },
            child: Text(l.cancel),
          ),
        ],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LinearProgressIndicator(value: _progress),
            const SizedBox(height: 12),
            Text(
              _progress == null ? l.loading : '${(_progress! * 100).floor()}%',
            ),
          ],
        ),
      ),
    );
  }
}

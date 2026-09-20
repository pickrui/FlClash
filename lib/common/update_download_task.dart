import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

import 'update_download.dart';

enum AppUpdateDownloadPhase { idle, downloading, ready, failed, canceled }

typedef AppUpdateDownloader =
    Future<File> Function(CancelToken token, ProgressCallback onProgress);

Future<void> waitForAppUpdateStartup({
  required bool Function() isReady,
  required CancelToken cancelToken,
}) async {
  for (var i = 0; i < 120; i++) {
    if (cancelToken.isCancelled) throw cancelToken.cancelError!;
    if (isReady()) return;
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
  if (cancelToken.isCancelled) throw cancelToken.cancelError!;
}

@immutable
class AppUpdateDownloadState {
  final AppUpdateDownloadPhase phase;
  final double? progress;
  final File? file;
  final Object? error;
  final bool showReadyNotice;
  const AppUpdateDownloadState(
    this.phase, {
    this.progress,
    this.file,
    this.error,
    this.showReadyNotice = false,
  });
}

/// The application owns the transfer; progress dialogs only observe it.
class AppUpdateDownloadTask extends ValueNotifier<AppUpdateDownloadState> {
  AppUpdateDownloadTask()
    : super(const AppUpdateDownloadState(AppUpdateDownloadPhase.idle));

  CancelToken? _token;
  AppUpdateDownloader? _download;
  Future<void>? _operation;
  Future<void> _stagingTail = Future.value();
  bool _disposed = false;
  int _views = 0;
  String? downloadUrl;

  bool get hasDownload =>
      value.phase != AppUpdateDownloadPhase.idle &&
      value.phase != AppUpdateDownloadPhase.canceled;
  bool get hasForegroundView => _views > 0;

  Future<void> start(AppUpdateDownloader download, {required String url}) {
    if (_disposed) return Future.value();
    if (value.phase == AppUpdateDownloadPhase.downloading ||
        value.phase == AppUpdateDownloadPhase.ready) {
      return _operation ?? Future.value();
    }
    _download = download;
    downloadUrl = url;
    final token = _token = CancelToken();
    value = const AppUpdateDownloadState(AppUpdateDownloadPhase.downloading);
    return _operation = _run(download, token);
  }

  /// Cleanup and transfer belong to the same new task. Reopening an active
  /// download reuses start() and never touches its staging directory.
  Future<void> startDownload(
    AppUpdateDownloader download, {
    required String url,
    required Directory directory,
  }) => start((token, onProgress) async {
    await _serializeStaging(() => sweepStaleUpdateDownloads(directory));
    if (token.isCancelled) throw token.cancelError!;
    return download(token, onProgress);
  }, url: url);

  /// Startup cleanup is serialized with the preparation of new downloads.
  Future<void> cleanStaleDownloads(Directory directory) =>
      _serializeStaging(() async {
        if (_disposed || hasDownload) return;
        await sweepStaleUpdateDownloads(directory);
      });

  Future<void> _serializeStaging(Future<void> Function() action) {
    final operation = _stagingTail.then((_) => action());
    _stagingTail = operation.then<void>(
      (_) {},
      onError: (Object _, StackTrace _) {},
    );
    return operation;
  }

  Future<void> retry() {
    final download = _download;
    final url = downloadUrl;
    if (download == null || url == null) return Future.value();
    return start(download, url: url);
  }

  Future<void> _run(AppUpdateDownloader download, CancelToken token) async {
    bool current() =>
        !_disposed && identical(token, _token) && !token.isCancelled;
    try {
      final file = await download(token, (received, total) {
        if (!current()) return;
        final progress = total > 0 ? (received / total).clamp(0.0, 1.0) : null;
        // Publish at most once per displayed percent, including indeterminate
        // transitions. Large downloads need no notification for every chunk.
        if (progress == value.progress ||
            (progress != null &&
                value.progress != null &&
                (progress * 100).floor() == (value.progress! * 100).floor())) {
          return;
        }
        value = AppUpdateDownloadState(
          AppUpdateDownloadPhase.downloading,
          progress: progress,
        );
      });
      if (!current()) {
        await _discard(file);
        return;
      }
      value = AppUpdateDownloadState(
        AppUpdateDownloadPhase.ready,
        file: file,
        showReadyNotice: true,
      );
    } catch (error) {
      if (current()) {
        value = AppUpdateDownloadState(
          AppUpdateDownloadPhase.failed,
          error: error,
        );
      }
    }
  }

  void cancel() {
    if (_disposed) return;
    _token?.cancel();
    final file = value.file;
    value = const AppUpdateDownloadState(AppUpdateDownloadPhase.canceled);
    if (file != null) unawaited(_discard(file));
  }

  void attachView() {
    if (_disposed) return;
    _views++;
    // Route construction can happen during a frame. Consumers will observe the
    // attachment on the next task state change; avoid notifying during build.
  }

  void detachView() {
    if (_disposed) return;
    if (_views > 0) _views--;
    scheduleMicrotask(() {
      if (!_disposed) notifyListeners();
    });
  }

  void dismissNotice() {
    if (_disposed || value.phase != AppUpdateDownloadPhase.ready) return;
    value = AppUpdateDownloadState(
      AppUpdateDownloadPhase.ready,
      file: value.file,
    );
  }

  static Future<void> _discard(File file) async {
    try {
      await file.delete();
      if (p.basename(file.parent.path).startsWith('flclash-update-')) {
        // Only remove an empty directory created by the updater.
        await file.parent.delete();
      }
    } on FileSystemException {
      /* Already removed, open, or still in use. */
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _token?.cancel();
    // A ready installer may have just been handed to the OS. Leave it intact.
    super.dispose();
  }
}

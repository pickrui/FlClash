import 'package:fl_clash/common/request.dart';
import 'package:fl_clash/common/update_download_task.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appUpdateDownloadProvider = Provider<AppUpdateDownloadTask>((ref) {
  final task = AppUpdateDownloadTask();
  ref.onDispose(task.dispose);
  return task;
});

final appUpdateNoticeProvider = Provider<ValueNotifier<AppUpdateInfo?>>((ref) {
  final notice = ValueNotifier<AppUpdateInfo?>(null);
  ref.onDispose(notice.dispose);
  return notice;
});

class AppUpdateCheck {
  AppUpdateCheck({required this.checkForUpdates});

  final Future<void> Function(bool isUser) checkForUpdates;
  Future<void>? _inFlight;
  bool _forUser = false;
  int? _declinedBuildNumber;
  int? get declinedBuildNumber => _declinedBuildNumber;

  void decline(int buildNumber) {
    if (_declinedBuildNumber == null || buildNumber > _declinedBuildNumber!) {
      _declinedBuildNumber = buildNumber;
    }
  }

  Future<void> run({bool isUser = false}) async {
    while (_inFlight != null) {
      final inFlight = _inFlight!;
      if (!isUser || _forUser) return inFlight;
      try {
        await inFlight;
      } catch (_) {
        // The automatic caller receives its error; the queued user still checks.
      }
    }
    _forUser = isUser;
    final run = _inFlight = Future<void>.sync(() => checkForUpdates(isUser));
    try {
      await run;
    } finally {
      if (identical(_inFlight, run)) _inFlight = null;
    }
  }
}

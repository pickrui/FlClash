import 'package:fl_clash/common/request.dart';
import 'package:fl_clash/common/update_download_task.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appUpdateDownloadProvider = Provider<AppUpdateDownloadTask>((ref) {
  final task = AppUpdateDownloadTask();
  ref.onDispose(task.dispose);
  return task;
});

final appUpdateNoticeProvider = Provider<AppUpdateNotice>((ref) {
  final notice = AppUpdateNotice();
  ref.onDispose(notice.dispose);
  return notice;
});

class AppUpdateCheck {
  AppUpdateCheck({required this.checkForUpdates});

  final Future<void> Function(bool isUser) checkForUpdates;
  Future<void>? _inFlight;
  bool _forUser = false;

  Future<void> run({bool isUser = false}) async {
    while (_inFlight != null) {
      final inFlight = _inFlight!;
      if (!isUser || _forUser) return inFlight;
      await inFlight;
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

class AppUpdateNotice extends ValueNotifier<AppUpdateInfo?> {
  AppUpdateNotice() : super(null);

  int? _declinedBuildNumber;
  int? get declinedBuildNumber => _declinedBuildNumber;

  void decline(int buildNumber) {
    if (_declinedBuildNumber == null || buildNumber > _declinedBuildNumber!) {
      _declinedBuildNumber = buildNumber;
    }
    if (value != null && value!.remoteBuildNumber <= _declinedBuildNumber!) {
      value = null;
    }
  }

  void dismiss() {
    final info = value;
    if (info != null) decline(info.remoteBuildNumber);
  }
}

import 'package:fl_clash/common/request.dart';
import 'package:fl_clash/common/update_download_task.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appUpdateDownloadProvider = Provider<AppUpdateDownloadTask>((ref) {
  final task = AppUpdateDownloadTask();
  ref.onDispose(task.dispose);
  return task;
});

/// A release an automatic check found, reported while its download runs. It
/// also holds a release an earlier launch already fetched, which this one
/// downloads again only if the user asks.
final appUpdateNoticeProvider = Provider<ValueNotifier<AppUpdateInfo?>>((ref) {
  final notice = ValueNotifier<AppUpdateInfo?>(null);
  ref.onDispose(notice.dispose);
  return notice;
});

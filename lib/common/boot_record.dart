// Adapted from FlClash v0.8.97; recovery never changes the selected profile.
enum BootStage { starting, running, failed, closed }

class AppExitInfo {
  final int reason;
  final int timestamp;
  final int processId;

  const AppExitInfo({
    required this.reason,
    required this.timestamp,
    required this.processId,
  });

  static AppExitInfo? fromJson(Object? value) {
    if (value is! Map ||
        value['reason'] is! int ||
        value['timestamp'] is! int ||
        value['pid'] is! int) {
      return null;
    }
    return AppExitInfo(
      reason: value['reason'] as int,
      timestamp: value['timestamp'] as int,
      processId: value['pid'] as int,
    );
  }

  // ApplicationExitInfo: Java/native crash, ANR, or initialization failure.
  // Unknown, low-memory, user-requested and package-update exits are excluded.
  bool get isCrash => const {4, 5, 6, 7}.contains(reason);
}

class BootRecord {
  final BootStage stage;
  final int? profileId;
  final String version;
  final int processId;
  final int startedAt;
  final int failureCount;

  const BootRecord({
    required this.stage,
    required this.profileId,
    required this.version,
    required this.processId,
    required this.startedAt,
    this.failureCount = 0,
  });

  static BootRecord? fromJson(Object? value) {
    if (value is! Map || value['schema'] != 1) return null;
    final stage = BootStage.values
        .where((e) => e.name == value['stage'])
        .firstOrNull;
    final profileId = value['profileId'];
    final version = value['version'];
    final processId = value['pid'];
    final startedAt = value['startedAt'];
    final failureCount = value['failureCount'];
    if (stage == null ||
        (profileId != null && profileId is! int) ||
        version is! String ||
        processId is! int ||
        processId <= 0 ||
        startedAt is! int ||
        startedAt <= 0 ||
        failureCount is! int ||
        failureCount < 0 ||
        failureCount > 2) {
      return null;
    }
    return BootRecord(
      stage: stage,
      profileId: profileId as int?,
      version: version,
      processId: processId,
      startedAt: startedAt,
      failureCount: failureCount,
    );
  }

  BootRecord withStage(BootStage next) => BootRecord(
    stage: next,
    profileId: profileId,
    version: version,
    processId: processId,
    startedAt: startedAt,
    failureCount: next == BootStage.running || next == BootStage.closed
        ? 0
        : failureCount,
  );

  Map<String, Object?> toJson() => {
    'schema': 1,
    'stage': stage.name,
    'profileId': profileId,
    'version': version,
    'pid': processId,
    'startedAt': startedAt,
    'failureCount': failureCount,
  };
}

class BootDecision {
  final int failureCount;
  // Identifies the in-process attempt; never persisted in the journal.
  final int revision;
  const BootDecision({this.failureCount = 0, this.revision = 0});
  bool get skipAutoSetup => failureCount >= 2;
}

BootDecision resolveBootDecision({
  required BootRecord? record,
  required AppExitInfo? exitInfo,
  required int? profileId,
  required String version,
  required int now,
}) {
  if (record == null ||
      record.profileId != profileId ||
      record.version != version ||
      record.startedAt > now) {
    return const BootDecision();
  }
  final confirmedCrash =
      record.stage == BootStage.starting &&
      exitInfo != null &&
      exitInfo.isCrash &&
      exitInfo.processId == record.processId &&
      exitInfo.timestamp >= record.startedAt &&
      exitInfo.timestamp <= now;
  if (record.stage != BootStage.failed && !confirmedCrash) {
    return const BootDecision();
  }
  return BootDecision(failureCount: (record.failureCount + 1).clamp(0, 2));
}

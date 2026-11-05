import 'dart:async';

import 'boot_record.dart';

/// The journal records only initialization attempts, never configuration data.
/// Missing/unreadable records and unavailable OS exit history fail open.
class BootGuard {
  final Future<BootRecord?> Function() readRecord;
  final Future<void> Function(BootRecord) writeRecord;
  final Future<AppExitInfo?> Function() readExitInfo;
  final void Function(Object) onError;
  final int Function() now;
  BootRecord? _record;
  Future<void> _writes = Future.value();
  bool _closed = false;
  int _generation = 0;
  bool _automaticSetupPaused = false;

  BootGuard({
    required this.readRecord,
    required this.writeRecord,
    required this.readExitInfo,
    required this.onError,
    int Function()? now,
  }) : now = now ?? (() => DateTime.now().millisecondsSinceEpoch);

  bool get automaticSetupPaused => _automaticSetupPaused;
  bool isCurrent(BootDecision attempt) =>
      !_closed && attempt.revision > 0 && attempt.revision == _generation;
  void resumeAutomaticSetup() {
    _automaticSetupPaused = false;
  }

  Future<BootDecision> begin({
    required int? profileId,
    required String version,
    required int processId,
  }) async {
    final generation = ++_generation;
    BootRecord? previous;
    AppExitInfo? exitInfo;
    try {
      previous = await readRecord();
    } catch (error) {
      onError(error);
    }
    try {
      exitInfo = await readExitInfo().timeout(const Duration(seconds: 2));
    } catch (error) {
      onError(error);
    }
    final startedAt = now();
    final resolution = resolveBootDecision(
      record: previous,
      exitInfo: exitInfo,
      profileId: profileId,
      version: version,
      now: startedAt,
    );
    final decision = BootDecision(
      failureCount: resolution.failureCount,
      revision: generation,
    );
    // A user exit or a newer begin while the reads were pending must win.
    if (_closed || generation != _generation) return const BootDecision();
    _automaticSetupPaused = decision.skipAutoSetup;
    _record = BootRecord(
      stage: BootStage.starting,
      profileId: profileId,
      version: version,
      processId: processId,
      startedAt: startedAt,
      failureCount: decision.failureCount,
    );
    final saved = await _write(_record!);
    if (!saved && generation == _generation) {
      _automaticSetupPaused = false;
      return BootDecision(revision: generation);
    }
    return decision;
  }

  Future<void> markRunning([BootDecision? attempt]) =>
      _transition(BootStage.running, attempt);
  Future<void> markFailed([BootDecision? attempt]) =>
      _transition(BootStage.failed, attempt);
  Future<void> markClosed() {
    _closed = true;
    _generation++;
    return _transition(BootStage.closed);
  }

  Future<void> _transition(BootStage stage, [BootDecision? attempt]) async {
    if (attempt != null && !isCurrent(attempt)) return;
    final record = _record;
    if (record == null || (_closed && stage != BootStage.closed)) return;
    if (record.stage == stage) return;
    // Closing an already failed startup does not erase its explicit evidence.
    if (stage == BootStage.closed && record.stage == BootStage.failed) return;
    if (stage != BootStage.closed && record.stage != BootStage.starting) return;
    _record = record.withStage(stage);
    await _write(_record!);
  }

  Future<bool> _write(BootRecord record) {
    final result = _writes.then((_) async {
      try {
        await writeRecord(record);
        return true;
      } catch (error) {
        onError(error);
        return false;
      }
    });
    _writes = result.then<void>((_) {});
    return result;
  }
}

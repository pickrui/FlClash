import 'dart:async';
import 'dart:convert';

import 'package:fl_clash/common/boot_guard.dart';
import 'package:fl_clash/common/boot_record.dart';
import 'package:flutter_test/flutter_test.dart';

const version = '0.8.96+123';
BootRecord record({
  BootStage stage = BootStage.starting,
  int failures = 0,
  int? profileId = 42,
}) => BootRecord(
  stage: stage,
  profileId: profileId,
  version: version,
  processId: 100,
  startedAt: 1000,
  failureCount: failures,
);
BootDecision decide(
  BootRecord? previous, {
  int? reason,
  int exitAt = 1500,
  int exitPid = 100,
  int? profileId = 42,
  String appVersion = version,
}) => resolveBootDecision(
  record: previous,
  exitInfo: reason == null
      ? null
      : AppExitInfo(reason: reason, timestamp: exitAt, processId: exitPid),
  profileId: profileId,
  version: appVersion,
  now: 2000,
);

void main() {
  test('unknown or externally stopped starts do not count as crashes', () {
    for (final reason in [null, 0, 1, 2, 3, 8, 9, 10, 11, 12, 13, 14, 15, 16]) {
      final decision = decide(record(failures: 1), reason: reason);
      expect(decision.failureCount, 0, reason: '$reason');
      expect(decision.skipAutoSetup, isFalse);
    }
  });

  test('two confirmed failed starts pause automatic setup', () {
    for (final reason in [4, 5, 6, 7]) {
      expect(decide(record(), reason: reason).skipAutoSetup, isFalse);
      expect(decide(record(failures: 1), reason: reason).skipAutoSetup, isTrue);
    }
    expect(
      decide(record(stage: BootStage.failed, failures: 1)).skipAutoSetup,
      isTrue,
    );
  });

  test('exit evidence must identify the recorded attempt', () {
    final previous = record(failures: 1);
    expect(decide(previous, reason: 4, exitAt: 999).skipAutoSetup, isFalse);
    expect(decide(previous, reason: 4, exitAt: 2001).skipAutoSetup, isFalse);
    expect(decide(previous, reason: 4, exitPid: 999).skipAutoSetup, isFalse);
    expect(decide(previous, reason: 4, profileId: 7).skipAutoSetup, isFalse);
    expect(
      decide(previous, reason: 4, appVersion: 'new-build').skipAutoSetup,
      isFalse,
    );
    for (final stage in [BootStage.running, BootStage.closed]) {
      expect(
        decide(record(stage: stage, failures: 1), reason: 4).skipAutoSetup,
        isFalse,
      );
    }
  });

  test('journal round trip is strict and excludes malformed records', () {
    final original = record(stage: BootStage.failed, failures: 1);
    expect(
      BootRecord.fromJson(jsonDecode(jsonEncode(original.toJson())))?.toJson(),
      original.toJson(),
    );
    for (final change in [
      {'schema': 2},
      {'stage': 'bad'},
      {'pid': -1},
      {'startedAt': 'x'},
      {'failureCount': 100},
      {'profileId': '42'},
    ]) {
      expect(BootRecord.fromJson({...original.toJson(), ...change}), isNull);
    }
    expect(BootRecord.fromJson(null), isNull);
    expect(AppExitInfo.fromJson({'reason': 4, 'timestamp': 1000}), isNull);
    expect(
      AppExitInfo.fromJson({
        'reason': 4,
        'timestamp': 1000,
        'pid': 100,
      })?.isCrash,
      isTrue,
    );
  });

  test(
    'recovery preserves the selected profile and resumes on explicit retry',
    () async {
      BootRecord? stored = record(stage: BootStage.failed, failures: 1);
      final guard = BootGuard(
        readRecord: () async => stored,
        writeRecord: (value) async {
          stored = value;
        },
        readExitInfo: () async => null,
        onError: (e) => fail('$e'),
        now: () => 2000,
      );
      expect(
        (await guard.begin(
          profileId: 42,
          version: version,
          processId: 101,
        )).skipAutoSetup,
        isTrue,
      );
      expect(guard.automaticSetupPaused, isTrue);
      expect(stored?.profileId, 42);
      await guard.markRunning();
      expect(stored?.stage, BootStage.running);
      expect(stored?.failureCount, 0);
      expect(guard.automaticSetupPaused, isTrue);
      guard.resumeAutomaticSetup();
      expect(guard.automaticSetupPaused, isFalse);
      expect(stored?.profileId, 42);
      // Successful recovery is not a permanent persisted auto-run disable.
      expect(decide(stored).skipAutoSetup, isFalse);
    },
  );

  test(
    'closed wins over concurrent writes and late startup completion',
    () async {
      final firstWrite = Completer<void>();
      final writes = <BootRecord>[];
      final guard = BootGuard(
        readRecord: () async => null,
        writeRecord: (value) async {
          if (value.stage == BootStage.starting) await firstWrite.future;
          writes.add(value);
        },
        readExitInfo: () async => null,
        onError: (e) => fail('$e'),
        now: () => 2000,
      );
      final starting = guard.begin(
        profileId: 42,
        version: version,
        processId: 101,
      );
      await Future<void>.delayed(Duration.zero);
      final running = guard.markRunning();
      final closing = guard.markClosed();
      final lateFailure = guard.markFailed();
      firstWrite.complete();
      await Future.wait([starting, running, closing, lateFailure]);
      expect(writes.map((e) => e.stage), [
        BootStage.starting,
        BootStage.running,
        BootStage.closed,
      ]);
    },
  );

  test(
    'exit during journal loading does not write a new starting marker',
    () async {
      final read = Completer<BootRecord?>();
      final writes = <BootRecord>[];
      final guard = BootGuard(
        readRecord: () => read.future,
        writeRecord: (value) async {
          writes.add(value);
        },
        readExitInfo: () async => null,
        onError: (e) => fail('$e'),
        now: () => 2000,
      );
      final starting = guard.begin(
        profileId: 42,
        version: version,
        processId: 101,
      );
      await guard.markClosed();
      read.complete(record(stage: BootStage.failed, failures: 1));
      expect((await starting).skipAutoSetup, isFalse);
      expect(guard.automaticSetupPaused, isFalse);
      expect(writes, isEmpty);
    },
  );

  test(
    'failed journal or exit-history access cannot prevent startup',
    () async {
      final errors = <Object>[];
      final guard = BootGuard(
        readRecord: () async => throw const FormatException('corrupt journal'),
        writeRecord: (_) async => throw StateError('storage unavailable'),
        readExitInfo: () async => throw StateError('unsupported OS'),
        onError: errors.add,
        now: () => 2000,
      );
      expect(
        (await guard.begin(
          profileId: 42,
          version: version,
          processId: 101,
        )).skipAutoSetup,
        isFalse,
      );
      await guard.markRunning();
      expect(guard.automaticSetupPaused, isFalse);
      expect(errors, hasLength(4));
    },
  );

  test(
    'a stale recovery record does not trap a read-only journal in recovery',
    () async {
      final guard = BootGuard(
        readRecord: () async => record(stage: BootStage.failed, failures: 1),
        writeRecord: (_) async => throw StateError('read-only'),
        readExitInfo: () async => null,
        onError: (_) {},
        now: () => 2000,
      );
      expect(
        (await guard.begin(
          profileId: 42,
          version: version,
          processId: 101,
        )).skipAutoSetup,
        isFalse,
      );
      expect(guard.automaticSetupPaused, isFalse);
    },
  );
  test(
    'a delayed older begin cannot replace a newer startup journal',
    () async {
      final oldRead = Completer<BootRecord?>();
      var reads = 0;
      final writes = <BootRecord>[];
      final guard = BootGuard(
        readRecord: () async => ++reads == 1 ? await oldRead.future : null,
        writeRecord: (value) async {
          writes.add(value);
        },
        readExitInfo: () async => null,
        onError: (e) => fail('$e'),
        now: () => 2000,
      );
      final oldStart = guard.begin(
        profileId: 1,
        version: version,
        processId: 101,
      );
      await guard.begin(profileId: 2, version: version, processId: 101);
      oldRead.complete(
        record(stage: BootStage.failed, failures: 1, profileId: 1),
      );
      await oldStart;
      expect(writes.map((e) => e.profileId), [2]);
      expect(guard.automaticSetupPaused, isFalse);
      await guard.markClosed();
      await guard.markClosed();
      expect(writes.map((e) => e.stage), [
        BootStage.starting,
        BootStage.closed,
      ]);
    },
  );

  test('explicit startup failure survives a later normal exit', () async {
    BootRecord? stored;
    final guard = BootGuard(
      readRecord: () async => null,
      writeRecord: (value) async {
        stored = value;
      },
      readExitInfo: () async => null,
      onError: (e) => fail('$e'),
      now: () => 2000,
    );
    await guard.begin(profileId: 42, version: version, processId: 101);
    await guard.markFailed();
    await guard.markClosed();
    expect(stored?.stage, BootStage.failed);
    final next = resolveBootDecision(
      record: stored,
      exitInfo: null,
      profileId: 42,
      version: version,
      now: 3000,
    );
    expect(next.failureCount, 1);
  });
  test('late completion cannot settle a newer attempt', () async {
    BootRecord? stored;
    final guard = BootGuard(
      readRecord: () async => stored,
      writeRecord: (value) async {
        stored = value;
      },
      readExitInfo: () async => null,
      onError: (e) => fail('$e'),
      now: () => 2000,
    );
    final first = await guard.begin(
      profileId: 1,
      version: version,
      processId: 101,
    );
    final second = await guard.begin(
      profileId: 2,
      version: version,
      processId: 101,
    );
    expect(guard.isCurrent(first), isFalse);
    expect(guard.isCurrent(second), isTrue);
    await guard.markRunning(first);
    await guard.markFailed(first);
    expect(stored?.stage, BootStage.starting);
    expect(stored?.profileId, 2);
    await guard.markRunning(second);
    expect(stored?.stage, BootStage.running);
    await guard.markClosed();
    expect(guard.isCurrent(second), isFalse);
    await guard.markFailed(second);
    expect(stored?.stage, BootStage.closed);
  });
}

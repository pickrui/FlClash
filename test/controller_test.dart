import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fl_clash/controller.dart';
import 'package:fl_clash/core/controller.dart';
import 'package:fl_clash/common/preferences.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('port conflict recovery', () {
    test('waits for the new port to be applied before retrying', () async {
      var activePort = 7890;
      final applyPort = Completer<void>();
      final editingPort = Completer<void>();
      final attempts = <int>[];
      final result = startCoreWithPortRecovery(
        shouldContinue: () => true,
        start: () async {
          attempts.add(activePort);
          if (activePort == 7890) {
            throw const PortConflictException('occupied');
          }
        },
        resolveConflict: () async {
          editingPort.complete();
          await applyPort.future;
          activePort = 7891;
          return true;
        },
      );

      await editingPort.future;
      expect(attempts, [7890]);
      applyPort.complete();
      expect(await result, isTrue);
      expect(attempts, [7890, 7891]);
    });

    test(
      'reopens editing when the replacement port is also occupied',
      () async {
        var attempts = 0;
        var edits = 0;
        final started = await startCoreWithPortRecovery(
          shouldContinue: () => true,
          start: () async {
            if (++attempts < 3) {
              throw const PortConflictException('occupied');
            }
          },
          resolveConflict: () async {
            edits++;
            return true;
          },
        );

        expect(started, isTrue);
        expect(attempts, 3);
        expect(edits, 2);
      },
    );

    test('cancelling returns normally without retrying', () async {
      var attempts = 0;
      final started = await startCoreWithPortRecovery(
        shouldContinue: () => true,
        start: () async {
          attempts++;
          throw const PortConflictException('occupied');
        },
        resolveConflict: () async => false,
      );

      expect(started, isFalse);
      expect(attempts, 1);
    });

    test(
      'successful starts and unrelated errors never open port editing',
      () async {
        Future<bool> unexpectedEdit() async {
          fail('port editor should not open');
        }

        expect(
          await startCoreWithPortRecovery(
            shouldContinue: () => true,
            start: () async {},
            resolveConflict: unexpectedEdit,
          ),
          isTrue,
        );
        final error = StateError('core disconnected');
        await expectLater(
          startCoreWithPortRecovery(
            shouldContinue: () => true,
            start: () async => throw error,
            resolveConflict: unexpectedEdit,
          ),
          throwsA(same(error)),
        );
      },
    );
    test('a stop request during editing prevents another start', () async {
      var shouldStart = true;
      var attempts = 0;
      expect(
        await startCoreWithPortRecovery(
          shouldContinue: () => shouldStart,
          start: () async {
            attempts++;
            throw const PortConflictException('occupied');
          },
          resolveConflict: () async {
            shouldStart = false;
            return true;
          },
        ),
        isFalse,
      );
      expect(attempts, 1);
    });

    test('an obsolete start never opens listeners or the editor', () async {
      expect(
        await startCoreWithPortRecovery(
          shouldContinue: () => false,
          start: () async => fail('start is obsolete'),
          resolveConflict: () async => fail('start is obsolete'),
        ),
        isFalse,
      );
    });

    test(
      'failure to apply the edited port does not retry the listener',
      () async {
        var attempts = 0;
        final error = StateError('port update failed');
        await expectLater(
          startCoreWithPortRecovery(
            shouldContinue: () => true,
            start: () async {
              attempts++;
              throw const PortConflictException('occupied');
            },
            resolveConflict: () async => throw error,
          ),
          throwsA(same(error)),
        );
        expect(attempts, 1);
      },
    );
  });

  test('interactive core readiness recovers only when needed', () async {
    var recoveryCalls = 0;

    final ready = await ensureInteractiveCoreReady(
      probe: () async => true,
      recover: () async {
        recoveryCalls++;
        return false;
      },
    );

    expect(ready, true);
    expect(recoveryCalls, 0);

    expect(
      await ensureInteractiveCoreReady(
        probe: () async => false,
        recover: () async {
          recoveryCalls++;
          return true;
        },
      ),
      true,
    );
    expect(recoveryCalls, 1);
  });

  test('persistent log rotation keeps only complete UTF-8 lines', () {
    final bytes = Uint8List.fromList(utf8.encode('超长中文行\n保留内容\n'));

    expect(
      utf8.decode(retainCompleteLogLines(bytes, bytes.length - 1)),
      '保留内容\n',
    );
    expect(retainCompleteLogLines(bytes, 2), isEmpty);
  });

  test('persistent log line limit preserves valid UTF-8 and byte limit', () {
    final limited = limitLogLine(
      Uint8List.fromList(utf8.encode('abc中文def\n')),
      10,
    );

    expect(limited.length, 10);
    expect(utf8.decode(limited), 'abc中...\n');
  });

  test('formats YAML type mismatch for the profile error dialog', () async {
    final localizations = await AppLocalizations.load(const Locale('zh', 'CN'));

    final message = formatConfigValidationMessage(
      'Parse Error: yaml: unmarshal errors:\n'
      '  line 16: cannot unmarshal !!map into []map[string]interface {}',
      localizations,
    );

    expect(
      message,
      '第 16 行的配置格式不正确\n'
      '此处应为列表，但实际为对象\n\n'
      '请检查该行附近的缩进和 "-" 列表标记',
    );

    expect(
      formatConfigValidationMessage(
        'Parse Error: yaml: unmarshal errors:\n'
        '  line 8: cannot unmarshal !!str \'abc\' into int',
        localizations,
      ),
      '第 8 行的配置格式不正确\n'
      '此处应为整数，但实际为文本\n\n'
      '请检查该行附近的缩进和 "-" 列表标记',
    );
  });

  test('backup config excludes WebDAV passwords', () {
    const secret = 'do-not-back-up-this-password';
    const config = Config(
      themeProps: defaultThemeProps,
      davProps: DAVProps(
        uri: 'https://dav.example.com',
        user: 'user',
        password: secret,
      ),
    );

    final backup = createBackupConfigMap(config, 3);

    expect(backup.toString(), isNot(contains(secret)));
    expect((backup['davProps'] as Map)['password'], '');
    expect(backup['version'], 3);
  });

  test('persistent config excludes controller credentials', () {
    const config = Config(
      themeProps: defaultThemeProps,
      patchClashConfig: ClashConfig(secret: 'controller-secret'),
    );

    final backup = createBackupConfigMap(config, 3);
    final cached = sanitizeConfigForPreferences(config).toJson();

    expect(backup.toString(), isNot(contains('controller-secret')));
    expect(cached.toString(), isNot(contains('controller-secret')));
    expect(((backup['patchClashConfig'] as Map)['secret'] as String), isEmpty);
  });

  test(
    'restore only reuses a WebDAV password for the same endpoint and user',
    () {
      const previous = DAVProps(
        uri: 'https://DAV.example.com:443/root/',
        user: 'user',
        password: 'secret',
      );

      expect(
        mergeRestoredDavProps(
          const DAVProps(
            uri: 'https://dav.example.com/root',
            user: 'user',
            password: '',
          ),
          previous,
        )?.password,
        'secret',
      );
      expect(
        mergeRestoredDavProps(
          const DAVProps(
            uri: 'https://attacker.example/root',
            user: 'user',
            password: '',
          ),
          previous,
        )?.password,
        isEmpty,
      );
      expect(
        mergeRestoredDavProps(
          const DAVProps(
            uri: 'https://dav.example.com/root',
            user: 'other',
            password: '',
          ),
          previous,
        )?.password,
        isEmpty,
      );
    },
  );

  test('proxy group filters are checked by the core validator', () async {
    String? payload;
    final message = await validateProxyGroupFilters(
      const ProxyGroup(name: 'Filtered', type: GroupType.Selector, filter: '['),
      (data) async {
        payload = data;
        return 'invalid regexp';
      },
    );

    expect(message, 'invalid regexp');
    expect(payload, isNotNull);
    expect(
      await validateProxyGroupFilters(
        const ProxyGroup(name: 'Plain', type: GroupType.Selector),
        (_) async => throw StateError('must not run'),
      ),
      isEmpty,
    );
  });

  group('shouldStopCoreAfterApplyFailure', () {
    test('keeps a running core for candidate validation failures', () {
      expect(
        shouldStopCoreAfterApplyFailure(
          isRunning: true,
          candidateValidationFailed: true,
        ),
        false,
      );
    });

    test('stops a running core after an actual setup failure', () {
      expect(
        shouldStopCoreAfterApplyFailure(
          isRunning: true,
          candidateValidationFailed: false,
        ),
        true,
      );
    });

    test('does not stop an already stopped core', () {
      expect(
        shouldStopCoreAfterApplyFailure(
          isRunning: false,
          candidateValidationFailed: false,
        ),
        false,
      );
    });
  });

  group('canPublishGroupsForProfile', () {
    const appliedState = SetupState(
      profileId: 7,
      profileLastUpdateDate: null,
      overwriteType: OverwriteType.standard,
      addedRules: [],
      proxyChains: [],
      profileProxies: [],
      customProxyGroups: [],
      customRules: [],
      script: null,
      overrideDns: false,
      dns: Dns(),
    );

    test('accepts only the profile loaded by the core', () {
      expect(canPublishGroupsForProfile(7, appliedState), true);
      expect(canPublishGroupsForProfile(8, appliedState), false);
      expect(canPublishGroupsForProfile(7, null), false);
      expect(canPublishGroupsForProfile(null, null), false);
    });

    test('rejects a proxy change after the active profile changes', () {
      expect(
        canChangeProxyForProfile(
          requestedProfileId: 7,
          currentProfileId: 7,
          appliedState: appliedState,
        ),
        true,
      );
      expect(
        canChangeProxyForProfile(
          requestedProfileId: 7,
          currentProfileId: 8,
          appliedState: appliedState,
        ),
        false,
      );
      expect(
        canChangeProxyForProfile(
          requestedProfileId: 7,
          currentProfileId: 7,
          appliedState: null,
        ),
        false,
      );
    });
  });

  test('mergeRefreshedProfile preserves concurrent profile state', () {
    final current = Profile.normal(label: 'Current', url: 'current-url')
        .copyWith(
          selectedMap: {'Group': 'Current Proxy'},
          unfoldSet: {'Group'},
          autoUpdate: false,
        );
    final refreshed = current.copyWith(
      label: 'Remote',
      url: 'old-url',
      lastUpdateDate: DateTime(2026, 7, 16),
      subscriptionInfo: const SubscriptionInfo(total: 100),
      selectedMap: {'Group': 'Old Proxy'},
      unfoldSet: const {},
      autoUpdate: true,
    );

    final merged = mergeRefreshedProfile(current, refreshed);

    expect(merged.label, 'Current');
    expect(merged.url, 'current-url');
    expect(merged.selectedMap, {'Group': 'Current Proxy'});
    expect(merged.unfoldSet, {'Group'});
    expect(merged.autoUpdate, false);
    expect(merged.lastUpdateDate, refreshed.lastUpdateDate);
    expect(merged.subscriptionInfo, refreshed.subscriptionInfo);
  });

  group('applyProfileAfterRefresh', () {
    test('awaits an immediate forced apply for the current profile', () async {
      final applyCompleter = Completer<void>();
      var immediateCalls = 0;
      var debounceCalls = 0;

      final applying = applyProfileAfterRefresh(
        isCurrent: true,
        force: true,
        applyImmediately: () async {
          immediateCalls++;
          await applyCompleter.future;
        },
        applyDebounced: () => debounceCalls++,
      );
      await Future<void>.delayed(Duration.zero);

      expect(immediateCalls, 1);
      expect(debounceCalls, 0);

      applyCompleter.complete();
      await applying;
    });

    test('keeps ordinary current profile refreshes debounced', () async {
      var immediateCalls = 0;
      var debounceCalls = 0;

      await applyProfileAfterRefresh(
        isCurrent: true,
        force: false,
        applyImmediately: () => immediateCalls++,
        applyDebounced: () => debounceCalls++,
      );

      expect(immediateCalls, 0);
      expect(debounceCalls, 1);
    });

    test('does not apply a refreshed inactive profile', () async {
      var immediateCalls = 0;
      var debounceCalls = 0;

      await applyProfileAfterRefresh(
        isCurrent: false,
        force: true,
        applyImmediately: () => immediateCalls++,
        applyDebounced: () => debounceCalls++,
      );

      expect(immediateCalls, 0);
      expect(debounceCalls, 0);
    });
  });

  test(
    'ProfileApplyIntent carries force and preload into a newer apply',
    () async {
      var preloadCalls = 0;
      Future<void> preload() async => preloadCalls++;
      final intent = ProfileApplyIntent()
        ..merge(force: true, preloadInvoke: preload)
        ..merge(force: false);

      expect(intent.requiresForce, true);
      expect(intent.preloadInvoke, isNotNull);

      await Future.wait([
        Future.sync(intent.preloadInvoke!),
        Future.sync(intent.preloadInvoke!),
      ]);
      intent.merge(force: true);
      await intent.preloadInvoke!();
      expect(preloadCalls, 1);

      intent.clear();
      expect(intent.requiresForce, false);
      expect(intent.preloadInvoke, isNull);
    },
  );

  test('a new start replaces a pending cancelled preload', () async {
    final cancelledStart = Completer<void>();
    final intent = ProfileApplyIntent()
      ..merge(force: true, preloadInvoke: () => cancelledStart.future);
    final previous = Future.sync(intent.preloadInvoke!);
    final previousResult = expectLater(previous, throwsStateError);

    var newStarts = 0;
    intent.merge(force: true, preloadInvoke: () => newStarts++);
    await intent.preloadInvoke!();
    expect(newStarts, 1);

    cancelledStart.completeError(StateError('start cancelled'));
    await previousResult;
    await intent.preloadInvoke!();
    expect(newStarts, 1);
  });

  group('commitRestoredFiles', () {
    test('commits staged files before database commit', () async {
      final tempDir = await Directory.systemTemp.createTemp('restore_commit_');
      addTearDown(() => tempDir.delete(recursive: true));
      final source = File('${tempDir.path}/staging/profile.yaml')
        ..createSync(recursive: true)
        ..writeAsStringSync('new');
      final target = File('${tempDir.path}/live/profile.yaml')
        ..createSync(recursive: true)
        ..writeAsStringSync('old');
      var committed = false;

      await commitRestoredFiles([
        VM2(source.path, target.path),
      ], () async => committed = true);

      expect(committed, true);
      expect(await target.readAsString(), 'new');
    });

    test('rolls files back when database commit fails', () async {
      final tempDir = await Directory.systemTemp.createTemp(
        'restore_rollback_',
      );
      addTearDown(() => tempDir.delete(recursive: true));
      final sourceA = File('${tempDir.path}/staging/a.yaml')
        ..createSync(recursive: true)
        ..writeAsStringSync('new-a');
      final sourceB = File('${tempDir.path}/staging/b.yaml')
        ..createSync(recursive: true)
        ..writeAsStringSync('new-b');
      final targetA = File('${tempDir.path}/live/a.yaml')
        ..createSync(recursive: true)
        ..writeAsStringSync('old-a');
      final targetB = File('${tempDir.path}/live/b.yaml');

      await expectLater(
        commitRestoredFiles([
          VM2(sourceA.path, targetA.path),
          VM2(sourceB.path, targetB.path),
        ], () => throw StateError('database failed')),
        throwsStateError,
      );

      expect(await targetA.readAsString(), 'old-a');
      expect(await targetB.exists(), false);
    });

    test('rejects duplicate targets before changing live files', () async {
      final tempDir = await Directory.systemTemp.createTemp(
        'restore_duplicate_',
      );
      addTearDown(() => tempDir.delete(recursive: true));
      final sourceA = File('${tempDir.path}/staging/a.yaml')
        ..createSync(recursive: true)
        ..writeAsStringSync('new-a');
      final sourceB = File('${tempDir.path}/staging/b.yaml')
        ..writeAsStringSync('new-b');
      final target = File('${tempDir.path}/live/profile.yaml')
        ..createSync(recursive: true)
        ..writeAsStringSync('old');

      await expectLater(
        commitRestoredFiles([
          VM2(sourceA.path, target.path),
          VM2(sourceB.path, target.path),
        ], () async {}),
        throwsFormatException,
      );

      expect(await target.readAsString(), 'old');
    });

    test('deletes obsolete files and directories after commit', () async {
      final tempDir = await Directory.systemTemp.createTemp('restore_delete_');
      addTearDown(() => tempDir.delete(recursive: true));
      final file = File('${tempDir.path}/profile.yaml')
        ..writeAsStringSync('secret');
      final directory = Directory('${tempDir.path}/providers')..createSync();
      File('${directory.path}/cache').writeAsStringSync('cache');

      await commitRestoredFiles(
        [],
        () async {},
        deletePaths: [file.path, directory.path],
      );

      expect(await file.exists(), false);
      expect(await directory.exists(), false);
    });

    test('restores deleted files and directories when commit fails', () async {
      final tempDir = await Directory.systemTemp.createTemp(
        'restore_delete_rollback_',
      );
      addTearDown(() => tempDir.delete(recursive: true));
      final file = File('${tempDir.path}/profile.yaml')
        ..writeAsStringSync('secret');
      final directory = Directory('${tempDir.path}/providers')..createSync();
      final cache = File('${directory.path}/cache')..writeAsStringSync('cache');

      await expectLater(
        commitRestoredFiles(
          [],
          () => throw StateError('database failed'),
          deletePaths: [file.path, directory.path],
        ),
        throwsStateError,
      );

      expect(await file.readAsString(), 'secret');
      expect(await cache.readAsString(), 'cache');
    });
  });

  test('validates restored profiles but ignores scripts', () async {
    final root = await Directory.systemTemp.createTemp('restore_validate_');
    addTearDown(() => root.delete(recursive: true));
    final profile = File('${root.path}/staging/profile.yaml')
      ..createSync(recursive: true)
      ..writeAsStringSync('profile');
    final script = File('${root.path}/staging/script.js')
      ..writeAsStringSync('script');
    final validated = <String>[];

    await validateRestoredProfileFiles(
      [
        VM2(profile.path, '${root.path}/live/profiles/1.yaml'),
        VM2(script.path, '${root.path}/live/scripts/1.js'),
      ],
      '${root.path}/live/profiles',
      (path) async {
        validated.add(path);
        return '';
      },
    );

    expect(validated, [profile.path]);
  });

  test('runCleanupActions attempts every action after failures', () async {
    final events = <String>[];

    await expectLater(
      runCleanupActions([
        () {
          events.add('first');
          throw StateError('failed');
        },
        () => events.add('second'),
        () async => events.add('third'),
      ]),
      throwsStateError,
    );

    expect(events, ['first', 'second', 'third']);
  });

  test('deleteApplicationSupportData keeps lock and tombstones', () async {
    final root = await Directory.systemTemp.createTemp('clear_data_');
    addTearDown(() => root.delete(recursive: true));
    final lock = File('${root.path}/FlClash.lock')..writeAsStringSync('lock');
    final preferences = File('${root.path}/shared_preferences.json')
      ..writeAsStringSync('tombstones');
    for (final path in [
      'database.sqlite',
      'database.sqlite-wal',
      'database.sqlite-shm',
      'config.yaml',
      'config.age',
      'profiles/provider/cache',
      'scripts/1.js',
      'logs/app.log',
      'restore/journal.json',
    ]) {
      File('${root.path}/$path')
        ..createSync(recursive: true)
        ..writeAsStringSync('data');
    }

    await deleteApplicationSupportData(
      root.path,
      preservePaths: {lock.path, preferences.path},
    );

    expect(await lock.readAsString(), 'lock');
    expect(await preferences.readAsString(), 'tombstones');
    final remaining = await root
        .list(followLinks: false)
        .map((entry) => p.basename(entry.path))
        .toList();
    expect(remaining, containsAll(['FlClash.lock', 'shared_preferences.json']));
    expect(remaining, hasLength(2));
  });
}

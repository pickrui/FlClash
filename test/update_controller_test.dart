import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/update_download_task.dart';

import 'package:fl_clash/common/constant.dart';
import 'package:fl_clash/common/linux_package_format.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/common/request.dart';
import 'package:fl_clash/providers/update_download.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'manual checks queued behind an automatic check share one follow-up',
    () async {
      final automatic = Completer<void>();
      final manual = Completer<void>();
      final calls = <bool>[];
      final check = AppUpdateCheck(
        checkForUpdates: (isUser) {
          calls.add(isUser);
          return isUser ? manual.future : automatic.future;
        },
      );
      final first = check.run();
      final waiters = List.generate(5, (_) => check.run(isUser: true));
      expect(calls, [false]);
      automatic.complete();
      await pumpEventQueue();
      expect(calls, [false, true]);
      final automaticFollower = check.run();
      manual.complete();
      await Future.wait([first, ...waiters, automaticFollower]);
      expect(calls, [false, true]);
      await check.run();
      expect(calls, [false, true, false]);
    },
  );

  test('a failed update check releases the next manual request', () async {
    final pending = Completer<void>();
    var calls = 0;
    final check = AppUpdateCheck(
      checkForUpdates: (_) {
        calls++;
        return calls == 1 ? pending.future : Future.value();
      },
    );
    final first = check.run();
    final second = check.run();
    final assertions = [
      expectLater(first, throwsStateError),
      expectLater(second, throwsStateError),
    ];
    pending.completeError(StateError('window unavailable'));
    await Future.wait(assertions);
    await check.run(isUser: true);
    expect(calls, 2);
  });

  testWidgets('canceling the startup wait releases the task before startup', (
    tester,
  ) async {
    final token = CancelToken();
    var reads = 0;
    final waiting = waitForAppUpdateStartup(
      isReady: () {
        reads++;
        return false;
      },
      cancelToken: token,
    );
    final result = expectLater(waiting, throwsA(isA<DioException>()));
    token.cancel();
    await tester.pump(const Duration(milliseconds: 500));
    await result;
    expect(reads, 1);
  });

  testWidgets('startup wait ends at readiness and remains bounded on failure', (
    tester,
  ) async {
    var ready = false;
    var finished = false;
    final waiting = waitForAppUpdateStartup(
      isReady: () => ready,
      cancelToken: CancelToken(),
    ).then((_) => finished = true);
    await tester.pump(const Duration(milliseconds: 500));
    expect(finished, isFalse);
    ready = true;
    await tester.pump(const Duration(milliseconds: 500));
    await waiting;
    expect(finished, isTrue);
    finished = false;
    final bounded = waitForAppUpdateStartup(
      isReady: () => false,
      cancelToken: CancelToken(),
    ).then((_) => finished = true);
    for (var i = 0; i < 119; i++) {
      await tester.pump(const Duration(milliseconds: 500));
    }
    expect(finished, isFalse);
    await tester.pump(const Duration(milliseconds: 500));
    await bounded;
    expect(finished, isTrue);
  });

  test(
    'a canceled startup wait never reads disposed application state',
    () async {
      await expectLater(
        waitForAppUpdateStartup(
          isReady: () => throw StateError('disposed'),
          cancelToken: CancelToken()..cancel(),
        ),
        throwsA(isA<DioException>()),
      );
    },
  );

  test(
    'dismissed notices suppress older automatic offers but allow manual checks',
    () {
      final notice = AppUpdateNotice()
        ..value = const AppUpdateInfo(remoteBuildNumber: 12);
      addTearDown(notice.dispose);
      notice.dismiss();
      notice.decline(10);
      expect(notice.value, isNull);
      expect(notice.declinedBuildNumber, 12);
      expect(
        resolveAppUpdateOffer(
          isUser: false,
          isUiVisible: true,
          remoteBuildNumber: 12,
          declinedBuildNumber: notice.declinedBuildNumber,
        ),
        AppUpdateOffer.ignore,
      );
      expect(
        resolveAppUpdateOffer(
          isUser: true,
          isUiVisible: true,
          remoteBuildNumber: 12,
          declinedBuildNumber: notice.declinedBuildNumber,
        ),
        AppUpdateOffer.prompt,
      );
      notice.value = const AppUpdateInfo(remoteBuildNumber: 13);
      notice.decline(12);
      expect(notice.value?.remoteBuildNumber, 13);
      final nextLaunch = AppUpdateNotice();
      addTearDown(nextLaunch.dispose);
      expect(nextLaunch.declinedBuildNumber, isNull);
    },
  );

  test('manual update waits for the window before prompting', () async {
    final shown = Completer<void>();
    final events = <String>[];
    final result = promptForAppUpdate(
      showWindow: () {
        events.add('show');
        return shown.future;
      },
      prompt: () async {
        events.add('prompt');
        return false;
      },
    );
    await Future<void>.delayed(Duration.zero);
    expect(events, ['show']);
    shown.complete();
    expect(await result, isFalse);
    expect(events, ['show', 'prompt']);
  });

  test('a manual check always asks, whatever a run already answered', () {
    for (final visible in [true, false]) {
      expect(
        resolveAppUpdateOffer(
          isUser: true,
          isUiVisible: visible,
          remoteBuildNumber: 2026092010,
          declinedBuildNumber: 2026092010,
        ),
        AppUpdateOffer.prompt,
        reason: 'visible=$visible',
      );
    }
  });

  test('an automatic check asks the user before anything is fetched', () {
    expect(
      resolveAppUpdateOffer(
        isUser: false,
        isUiVisible: true,
        remoteBuildNumber: 2026092010,
        declinedBuildNumber: null,
      ),
      AppUpdateOffer.prompt,
    );
  });

  test('a hidden window keeps the offer in the notice', () {
    expect(
      resolveAppUpdateOffer(
        isUser: false,
        isUiVisible: false,
        remoteBuildNumber: 2026092010,
        declinedBuildNumber: null,
      ),
      AppUpdateOffer.notice,
    );
  });

  test('a declined release is not offered again by this run', () {
    for (final build in [2026092009, 2026092010]) {
      expect(
        resolveAppUpdateOffer(
          isUser: false,
          isUiVisible: true,
          remoteBuildNumber: build,
          declinedBuildNumber: 2026092010,
        ),
        AppUpdateOffer.ignore,
        reason: 'build=$build',
      );
    }
    expect(
      resolveAppUpdateOffer(
        isUser: false,
        isUiVisible: true,
        remoteBuildNumber: 2026092011,
        declinedBuildNumber: 2026092010,
      ),
      AppUpdateOffer.prompt,
    );
  });

  test('a hidden window is never asked to show an automatic prompt', () async {
    for (final visible in [false, true]) {
      expect(
        await canPromptForAppUpdate(
          isUiVisible: visible,
          isWindowVisible: () async => false,
        ),
        isFalse,
        reason: 'bookkeeping=$visible',
      );
    }
  });

  test('a window reporting itself visible may be prompted', () async {
    expect(
      await canPromptForAppUpdate(
        isUiVisible: true,
        isWindowVisible: () async => true,
      ),
      isTrue,
    );
  });

  test('a window that cannot answer counts as hidden', () async {
    var queried = false;
    expect(
      await canPromptForAppUpdate(
        isUiVisible: true,
        isWindowVisible: () async {
          queried = true;
          throw StateError('window unavailable');
        },
      ),
      isFalse,
    );
    expect(queried, isTrue);
  });

  test(
    'a background app is not prompted without querying its window',
    () async {
      expect(
        await canPromptForAppUpdate(
          isUiVisible: false,
          isWindowVisible: () async => fail('must not query a background app'),
        ),
        isFalse,
      );
    },
  );

  test('a platform without windows follows the app state alone', () async {
    for (final visible in [false, true]) {
      expect(
        await canPromptForAppUpdate(
          isUiVisible: visible,
          isWindowVisible: null,
        ),
        visible,
        reason: 'visible=$visible',
      );
    }
  });

  test('mobile update prompts without a desktop window', () async {
    expect(
      await promptForAppUpdate(showWindow: null, prompt: () async => null),
      isNull,
    );
  });

  test('update installers match every supported platform and ABI', () {
    const installers = {
      Abi.windowsX64: 'windows-amd64-setup.exe',
      Abi.windowsArm64: 'windows-arm64-setup.exe',
      Abi.macosX64: 'macos-amd64.dmg',
      Abi.macosArm64: 'macos-arm64.dmg',
      Abi.androidArm: 'android-armeabi-v7a.apk',
      Abi.androidArm64: 'android-arm64-v8a.apk',
      Abi.androidX64: 'android-x86_64.apk',
      Abi.linuxX64: 'linux-amd64.deb',
      Abi.linuxArm64: 'linux-arm64.deb',
    };
    for (final entry in installers.entries) {
      final downloadUrl = getAppUpdateDownloadUrl(entry.key);
      expect(
        downloadUrl,
        'https://dl.dler.io/flclash-${entry.value}',
        reason: entry.key.toString(),
      );
      expect(
        getAppUpdateFallbackDownloadUrl(downloadUrl!),
        'https://github.com/$releaseRepository/releases/latest/download/'
        'flclash-${entry.value}',
        reason: entry.key.toString(),
      );
    }
    for (final abi in Abi.values.where((abi) => !installers.containsKey(abi))) {
      expect(getAppUpdateDownloadUrl(abi), isNull, reason: abi.toString());
    }
  });

  test('every published Linux package format has a download', () {
    const names = {
      LinuxPackageFormat.deb: 'linux-amd64.deb',
      LinuxPackageFormat.rpm: 'linux-amd64.rpm',
      LinuxPackageFormat.appImage: 'linux-amd64.AppImage',
    };
    for (final format in linuxPackageFormatsFor(Abi.linuxX64)) {
      expect(
        getAppUpdateDownloadUrl(Abi.linuxX64, linuxFormat: format),
        'https://dl.dler.io/flclash-${names[format]}',
        reason: format.name,
      );
    }
    // arm64 publishes a Debian package only, whatever is asked for.
    for (final format in LinuxPackageFormat.values) {
      expect(
        getAppUpdateDownloadUrl(Abi.linuxArm64, linuxFormat: format),
        'https://dl.dler.io/flclash-linux-arm64.deb',
        reason: format.name,
      );
    }
  });

  test('only an AppImage download is left to the user to install', () {
    expect(
      isAppImageInstaller(File('/tmp/flclash-linux-amd64.AppImage')),
      isTrue,
    );
    for (final name in const [
      'flclash-linux-amd64.deb',
      'flclash-linux-amd64.rpm',
      'flclash-windows-amd64-setup.exe',
      'AppImage',
    ]) {
      expect(isAppImageInstaller(File('/tmp/$name')), isFalse, reason: name);
    }
  });

  test('successful installer open does not fall back to browser', () async {
    final file = File('/tmp/update.apk');
    await openAppUpdateDownload(
      file: file,
      openFile: (value) async {
        expect(value, same(file));
        return true;
      },
      openBrowser: () async => fail('must not open the browser'),
      onError: (_) => fail('must not report an error'),
    );
  });

  for (final throws in [false, true]) {
    test(
      'installer open ${throws ? 'throwing' : 'returning false'} falls back',
      () async {
        final error = StateError('installer unavailable');
        var browserOpens = 0;
        var errors = 0;
        await openAppUpdateDownload(
          file: File('/tmp/update.apk'),
          openFile: (_) async {
            if (throws) throw error;
            return false;
          },
          openBrowser: () async => browserOpens++,
          onError: (value) {
            errors++;
            if (throws) expect(value, same(error));
          },
        );
        expect(browserOpens, 1);
        expect(errors, 1);
      },
    );
  }

  test(
    'browser failure propagates without retrying the download or browser',
    () async {
      final error = StateError('browser unavailable');
      var browserOpens = 0;
      await expectLater(
        openAppUpdateDownload(
          file: File('/tmp/update.apk'),
          openFile: (_) async => false,
          openBrowser: () async {
            browserOpens++;
            throw error;
          },
          onError: (_) {},
        ),
        throwsA(same(error)),
      );
      expect(browserOpens, 1);
    },
  );
}

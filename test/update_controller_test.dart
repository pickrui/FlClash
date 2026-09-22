import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/update_download_task.dart';

import 'package:fl_clash/common/constant.dart';
import 'package:fl_clash/common/linux_package_format.dart';
import 'package:fl_clash/controller.dart';
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

  test(
    'a queued manual check retries after an automatic check fails',
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
      final failure = expectLater(first, throwsStateError);
      final waiters = List.generate(3, (_) => check.run(isUser: true));
      final completed = Future.wait(waiters);
      automatic.completeError(StateError('automatic check failed'));
      await failure;
      await pumpEventQueue();
      expect(calls, [false, true]);
      manual.complete();
      await completed;
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
    'declined prompts suppress older automatic offers but allow manual checks',
    () {
      final check = AppUpdateCheck(checkForUpdates: (_) async {});
      check.decline(12);
      check.decline(10);
      expect(check.declinedBuildNumber, 12);
      expect(
        resolveAppUpdateOffer(
          isUser: false,
          remoteBuildNumber: 12,
          declinedBuildNumber: check.declinedBuildNumber,
        ),
        AppUpdateOffer.ignore,
      );
      expect(
        resolveAppUpdateOffer(
          isUser: true,
          remoteBuildNumber: 12,
          declinedBuildNumber: check.declinedBuildNumber,
        ),
        AppUpdateOffer.prompt,
      );
      check.decline(13);
      check.decline(12);
      expect(check.declinedBuildNumber, 13);
      final nextLaunch = AppUpdateCheck(checkForUpdates: (_) async {});
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

  test('a manual check opens details even after declining that release', () {
    expect(
      resolveAppUpdateOffer(
        isUser: true,
        remoteBuildNumber: 2026092010,
        declinedBuildNumber: 2026092010,
      ),
      AppUpdateOffer.prompt,
    );
  });

  test('an automatic check only offers an in-app notice', () {
    expect(
      resolveAppUpdateOffer(
        isUser: false,
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
        remoteBuildNumber: 2026092011,
        declinedBuildNumber: 2026092010,
      ),
      AppUpdateOffer.notice,
    );
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
    for (final format in linuxPackageFormatsFor(Abi.linuxX64)) {
      expect(
        getAppUpdateDownloadUrl(Abi.linuxArm64, linuxFormat: format),
        'https://dl.dler.io/flclash-linux-arm64.deb',
        reason: format.name,
      );
    }
    // A managed format has no installer to point at on any ABI.
    for (final abi in Abi.values) {
      expect(
        getAppUpdateDownloadUrl(abi, linuxFormat: LinuxPackageFormat.pacman),
        isNull,
        reason: abi.toString(),
      );
    }
  });

  test('a package manager install is never downloaded', () {
    for (final abi in const [Abi.linuxX64, Abi.linuxArm64]) {
      expect(
        resolveLinuxUpdateFormat(
          published: linuxPackageFormatsFor(abi),
          detected: LinuxPackageFormat.pacman,
          stored: LinuxPackageFormat.deb,
        ),
        LinuxPackageFormat.pacman,
        reason: abi.toString(),
      );
    }
  });

  test('a stored answer outranks detection, and detection the user', () {
    final published = linuxPackageFormatsFor(Abi.linuxX64);
    expect(
      resolveLinuxUpdateFormat(
        published: published,
        detected: LinuxPackageFormat.rpm,
        stored: LinuxPackageFormat.appImage,
      ),
      LinuxPackageFormat.appImage,
    );
    expect(
      resolveLinuxUpdateFormat(
        published: published,
        detected: LinuxPackageFormat.rpm,
        stored: null,
      ),
      LinuxPackageFormat.rpm,
    );
    // Nothing answered: an unpacked build on Arch still reaches the dialog.
    expect(
      resolveLinuxUpdateFormat(
        published: published,
        detected: null,
        stored: null,
      ),
      isNull,
    );
    // An ABI with a single package never asks.
    expect(
      resolveLinuxUpdateFormat(
        published: linuxPackageFormatsFor(Abi.linuxArm64),
        detected: null,
        stored: LinuxPackageFormat.rpm,
      ),
      LinuxPackageFormat.deb,
    );
    expect(
      resolveLinuxUpdateFormat(
        published: linuxPackageFormatsFor(Abi.macosArm64),
        detected: null,
        stored: null,
      ),
      LinuxPackageFormat.deb,
    );
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

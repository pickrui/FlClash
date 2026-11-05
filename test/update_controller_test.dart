import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:fl_clash/common/constant.dart';
import 'package:fl_clash/common/linux_package_format.dart';
import 'package:fl_clash/controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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

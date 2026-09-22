import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:fl_clash/common/linux_package_format.dart';
import 'package:flutter_test/flutter_test.dart';

ProcessRunner _runner(
  Map<String, int> exitCodes, {
  Set<String> missing = const {},
  Set<String> hangs = const {},
  List<String>? log,
}) {
  return (executable, arguments) {
    log?.add([executable, ...arguments].join(' '));
    if (missing.contains(executable)) {
      throw ProcessException(executable, arguments, 'not found', 2);
    }
    if (hangs.contains(executable)) return Completer<ProcessResult>().future;
    return Future.value(ProcessResult(1, exitCodes[executable] ?? 1, '', ''));
  };
}

Future<LinuxPackageFormat?> _detect({
  Map<String, String> environment = const {},
  ProcessRunner? runProcess,
  String? osRelease,
  List<String>? log,
}) => detectLinuxPackageFormat(
  environment: environment,
  executablePath: '/usr/lib/flclash/FlClash',
  runProcess:
      runProcess ?? _runner(const {}, missing: {'dpkg', 'rpm'}, log: log),
  readOsRelease: () async => osRelease,
  timeout: const Duration(milliseconds: 50),
);

void main() {
  test('the AppImage runtime answers before any package manager', () async {
    final log = <String>[];
    expect(
      await _detect(
        environment: const {'APPIMAGE': '/home/me/FlClash.AppImage'},
        runProcess: _runner(const {'dpkg': 0}, log: log),
        osRelease: 'ID=ubuntu',
        log: log,
      ),
      LinuxPackageFormat.appImage,
    );
    expect(log, isEmpty);
  });

  test('an empty APPIMAGE value is not an AppImage', () async {
    expect(
      await _detect(
        environment: const {'APPIMAGE': ''},
        runProcess: _runner(const {'rpm': 0}),
      ),
      LinuxPackageFormat.rpm,
    );
  });

  test('the package manager owning the executable decides', () async {
    final log = <String>[];
    expect(
      await _detect(
        runProcess: _runner(const {'dpkg': 0}, log: log),
        log: log,
      ),
      LinuxPackageFormat.deb,
    );
    expect(log, ['dpkg -S /usr/lib/flclash/FlClash']);
    log.clear();
    expect(
      await _detect(
        runProcess: _runner(const {'rpm': 0}, log: log),
        log: log,
      ),
      LinuxPackageFormat.rpm,
    );
    expect(log, [
      'dpkg -S /usr/lib/flclash/FlClash',
      'rpm -qf /usr/lib/flclash/FlClash',
    ]);
  });

  test('pacman owning the executable reports a managed install', () async {
    final log = <String>[];
    expect(
      await _detect(
        runProcess: _runner(
          const {'pacman': 0},
          missing: {'dpkg', 'rpm'},
          log: log,
        ),
        osRelease: 'ID=arch',
        log: log,
      ),
      LinuxPackageFormat.pacman,
    );
    expect(log, [
      'dpkg -S /usr/lib/flclash/FlClash',
      'rpm -qf /usr/lib/flclash/FlClash',
      'pacman -Qo /usr/lib/flclash/FlClash',
    ]);
  });

  test('only a package manager install is managed', () {
    expect(LinuxPackageFormat.pacman.managed, isTrue);
    for (final format in linuxPackageFormatsFor(Abi.linuxX64)) {
      expect(format.managed, isFalse, reason: format.name);
    }
  });

  test('a missing or hanging package manager falls through', () async {
    expect(
      await _detect(
        runProcess: _runner(
          const {'rpm': 0},
          missing: {'dpkg'},
          hangs: {'rpm'},
        ),
        osRelease: 'ID=debian',
      ),
      LinuxPackageFormat.deb,
    );
  });

  test('the distribution family answers when nothing owns the build', () async {
    expect(await _detect(osRelease: 'ID=fedora'), LinuxPackageFormat.rpm);
    expect(
      await _detect(osRelease: 'ID=linuxmint\nID_LIKE="ubuntu debian"'),
      LinuxPackageFormat.deb,
    );
    expect(
      await _detect(osRelease: "ID=rocky\nID_LIKE='rhel centos fedora'"),
      LinuxPackageFormat.rpm,
    );
    expect(
      await _detect(osRelease: '# comment\nNAME="Arch Linux"\nID=arch'),
      isNull,
    );
    expect(await _detect(), isNull);
  });

  test('os-release parsing ignores comments and blank values', () {
    expect(
      linuxPackageFormatFromOsRelease('#ID=fedora\nID=\nID_LIKE=debian'),
      LinuxPackageFormat.deb,
    );
    expect(linuxPackageFormatFromOsRelease(null), isNull);
    expect(linuxPackageFormatFromOsRelease(''), isNull);
  });

  test('published formats follow what each Linux ABI ships', () {
    expect(linuxPackageFormatsFor(Abi.linuxX64), [
      LinuxPackageFormat.deb,
      LinuxPackageFormat.rpm,
      LinuxPackageFormat.appImage,
    ]);
    expect(linuxPackageFormatsFor(Abi.linuxArm64), [LinuxPackageFormat.deb]);
    for (final abi in Abi.values.where(
      (abi) => abi != Abi.linuxX64 && abi != Abi.linuxArm64,
    )) {
      expect(linuxPackageFormatsFor(abi), isEmpty, reason: abi.toString());
    }
  });

  test('a stored answer round-trips through its name', () {
    for (final format in LinuxPackageFormat.values) {
      expect(LinuxPackageFormat.fromName(format.name), format);
    }
    expect(LinuxPackageFormat.fromName('snap'), isNull);
    expect(LinuxPackageFormat.fromName(null), isNull);
  });
}

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

/// Linux ships the same build in several package formats, and only some of
/// them leave a trace the running app can read. What detection cannot answer
/// the user is asked once.
enum LinuxPackageFormat {
  deb('deb'),
  rpm('rpm'),
  appImage('AppImage'),
  pacman('pkg.tar.zst', managed: true);

  const LinuxPackageFormat(this.extension, {this.managed = false});

  /// Extension of the published installer, e.g. `flclash-linux-amd64.deb`.
  final String extension;

  /// A package manager owns the upgrade; nothing is published to download.
  final bool managed;

  static LinuxPackageFormat? fromName(String? name) {
    for (final format in values) {
      if (format.name == name) return format;
    }
    return null;
  }
}

/// Formats published for [abi]; arm64 only ships a Debian package.
List<LinuxPackageFormat> linuxPackageFormatsFor(Abi abi) => switch (abi) {
  Abi.linuxX64 => const [
    LinuxPackageFormat.deb,
    LinuxPackageFormat.rpm,
    LinuxPackageFormat.appImage,
  ],
  Abi.linuxArm64 => const [LinuxPackageFormat.deb],
  _ => const [],
};

typedef ProcessRunner =
    Future<ProcessResult> Function(String executable, List<String> arguments);

const _debianIds = {
  'debian',
  'ubuntu',
  'linuxmint',
  'pop',
  'elementary',
  'zorin',
  'raspbian',
  'devuan',
  'kali',
};

const _rpmIds = {
  'fedora',
  'rhel',
  'centos',
  'rocky',
  'almalinux',
  'ol',
  'opensuse',
  'opensuse-leap',
  'opensuse-tumbleweed',
  'suse',
  'sles',
  'mageia',
};

const _packageOwners = [
  ('dpkg', ['-S'], LinuxPackageFormat.deb),
  ('rpm', ['-qf'], LinuxPackageFormat.rpm),
  ('pacman', ['-Qo'], LinuxPackageFormat.pacman),
];

/// Reports how this build was installed, or null when nothing answers — an
/// unpacked tarball and a self-built binary belong to no package at all.
Future<LinuxPackageFormat?> detectLinuxPackageFormat({
  Map<String, String>? environment,
  String? executablePath,
  ProcessRunner? runProcess,
  Future<String?> Function()? readOsRelease,
  Duration timeout = const Duration(seconds: 3),
}) async {
  // Only the AppImage runtime exports the image it launched.
  final env = environment ?? Platform.environment;
  if ((env['APPIMAGE'] ?? '').isNotEmpty) return LinuxPackageFormat.appImage;

  final path = executablePath ?? Platform.resolvedExecutable;
  final run = runProcess ?? Process.run;
  for (final (executable, arguments, format) in _packageOwners) {
    try {
      final result = await run(executable, [
        ...arguments,
        path,
      ]).timeout(timeout);
      if (result.exitCode == 0) return format;
    } on ProcessException {
      // This package manager is not installed; ask the next one.
    } on TimeoutException {
      // A query that hangs says nothing about the format.
    }
  }

  return linuxPackageFormatFromOsRelease(
    await (readOsRelease ?? _readOsRelease)(),
  );
}

/// The distribution's own family, used only after the package managers were
/// silent: an unpacked build on a Debian host still reports `deb`.
LinuxPackageFormat? linuxPackageFormatFromOsRelease(String? osRelease) {
  if (osRelease == null) return null;
  final values = <String, String>{};
  for (final line in const LineSplitter().convert(osRelease)) {
    final separator = line.indexOf('=');
    if (separator <= 0 || line.startsWith('#')) continue;
    final key = line.substring(0, separator).trim();
    var value = line.substring(separator + 1).trim();
    if (value.length > 1 &&
        (value.startsWith('"') && value.endsWith('"') ||
            value.startsWith("'") && value.endsWith("'"))) {
      value = value.substring(1, value.length - 1);
    }
    values[key] = value.toLowerCase();
  }
  final ids = [
    ?values['ID'],
    ...?values['ID_LIKE']?.split(RegExp(r'\s+')),
  ].where((id) => id.isNotEmpty);
  for (final id in ids) {
    if (_debianIds.contains(id)) return LinuxPackageFormat.deb;
    if (_rpmIds.contains(id)) return LinuxPackageFormat.rpm;
  }
  return null;
}

Future<String?> _readOsRelease() async {
  for (final path in const ['/etc/os-release', '/usr/lib/os-release']) {
    try {
      final file = File(path);
      if (await file.exists()) return await file.readAsString();
    } on FileSystemException {
      // Unreadable; try the next location.
    }
  }
  return null;
}

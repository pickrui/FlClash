// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';
import 'package:setup_hooks/setup_hooks.dart' as hooks;

enum Target { windows, linux, android, macos }

extension TargetExt on Target {
  bool get same {
    if (this == Target.android) {
      return true;
    }
    if (Platform.isWindows && this == Target.windows) {
      return true;
    }
    if (Platform.isLinux && this == Target.linux) {
      return true;
    }
    if (Platform.isMacOS && this == Target.macos) {
      return true;
    }
    return false;
  }

  String get executableExtensionName {
    final String extensionName;
    switch (this) {
      case Target.windows:
        extensionName = '.exe';
        break;
      default:
        extensionName = '';
        break;
    }
    return extensionName;
  }
}

enum Mode { core, lib }

enum Arch { amd64, arm64, arm }

Arch? resolveHostArch(String? name) => switch (name?.toLowerCase()) {
  'amd64' || 'x86_64' => Arch.amd64,
  'arm64' || 'aarch64' => Arch.arm64,
  'arm' || 'armv7l' => Arch.arm,
  _ => null,
};

class BuildItem {
  Target target;
  Arch? arch;
  String? archName;

  BuildItem({required this.target, this.arch, this.archName});

  @override
  String toString() {
    return 'BuildLibItem{target: $target, arch: $arch, archName: $archName}';
  }
}

/// The release date uses Beijing time regardless of the build host timezone.
String buildNumberForTime(DateTime instant) {
  final time = instant.toUtc().add(const Duration(hours: 8));
  String twoDigits(int value) => value.toString().padLeft(2, '0');
  return '${time.year.toString().padLeft(4, '0')}'
      '${twoDigits(time.month)}${twoDigits(time.day)}${twoDigits(time.hour)}';
}

class Build {
  /// Stamp once per app build so every architecture and package shares a date.
  static void prepareAppVersion({
    File? pubspecFile,
    DateTime? now,
    Map<String, String>? environment,
  }) {
    final file = pubspecFile ?? File('pubspec.yaml');
    final content = file.readAsStringSync();
    final versionLine = RegExp(r'^version:[^\r\n]*', multiLine: true);
    if (versionLine.allMatches(content).length != 1) {
      throw const FormatException('pubspec.yaml must contain one version');
    }
    final config = loadYaml(content) as YamlMap;
    final sourceVersion = config['version'] as String?;
    final env = environment ?? Platform.environment;
    final version =
        env['FLUTTER_VERSION_NUMBER'] ?? sourceVersion?.split('+').first;
    if (version == null ||
        !RegExp(r'^\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?$').hasMatch(version)) {
      throw const FormatException('Invalid app version');
    }
    // CI supplies the shared batch timestamp. Local builds always read the
    // clock; an old or future pubspec suffix must never become a lower bound.
    final buildNumber =
        env['FLUTTER_BUILD_NUMBER'] ??
        buildNumberForTime(now ?? DateTime.now());
    if (!RegExp(r'^\d{10}$').hasMatch(buildNumber)) {
      throw const FormatException('Build number must use yyyyMMddHH');
    }
    final fullVersion = '$version+$buildNumber';
    file.writeAsStringSync(
      content.replaceFirst(versionLine, 'version: $fullVersion'),
    );
    print('Updated version to: $fullVersion');
  }

  static List<BuildItem> get buildItems => [
    BuildItem(target: Target.macos, arch: Arch.arm64),
    BuildItem(target: Target.macos, arch: Arch.amd64),
    BuildItem(target: Target.linux, arch: Arch.arm64),
    BuildItem(target: Target.linux, arch: Arch.amd64),
    BuildItem(target: Target.windows, arch: Arch.amd64),
    BuildItem(target: Target.windows, arch: Arch.arm64),
    BuildItem(target: Target.android, arch: Arch.arm, archName: 'armeabi-v7a'),
    BuildItem(target: Target.android, arch: Arch.arm64, archName: 'arm64-v8a'),
    BuildItem(target: Target.android, arch: Arch.amd64, archName: 'x86_64'),
  ];

  static String get coreName => 'FlClashCore';

  static String get libName => 'libclash';

  static String get distPath => join(current, 'dist');

  static int get _androidApiLevel {
    final source = File('android/gradle/libs.versions.toml').readAsStringSync();
    final match = RegExp(
      r'^minSdk\s*=\s*"(\d+)"',
      multiLine: true,
    ).firstMatch(source);
    if (match == null) throw StateError('Android minSdk is missing');
    return int.parse(match[1]!);
  }

  static String _getCc(BuildItem buildItem) {
    final environment = Platform.environment;
    if (buildItem.target == Target.android) {
      final ndk = environment['ANDROID_NDK'];
      assert(ndk != null);
      final prebuiltDir = Directory(
        join(ndk!, 'toolchains', 'llvm', 'prebuilt'),
      );
      final prebuiltDirList = prebuiltDir
          .listSync()
          .where((file) => !basename(file.path).startsWith('.'))
          .toList();
      final map = {
        'armeabi-v7a': 'armv7a-linux-androideabi$_androidApiLevel-clang',
        'arm64-v8a': 'aarch64-linux-android$_androidApiLevel-clang',
        'x86': 'i686-linux-android$_androidApiLevel-clang',
        'x86_64': 'x86_64-linux-android$_androidApiLevel-clang',
      };
      return join(prebuiltDirList.first.path, 'bin', map[buildItem.archName]);
    }
    return 'gcc';
  }

  static const _sensitiveBuildKeys = {
    'PROFILE_KEY',
    'BASE_DOMAIN',
    'SPARE_DOMAIN',
    'API_DOMAIN',
    'SPARE_API_DOMAIN',
    'FLCLASH_APP_SECRET',
    'FLCLASH_KEY',
    'DNS_AUTH_PRIVATE_KEY',
    'DNS_AUTH_DOMAINS',
  };

  static final RegExp _sensitiveValuePattern = RegExp(
    '(${_sensitiveBuildKeys.map(RegExp.escape).join('|')})=([^\\s]+)',
  );

  static final RegExp _dartDefinesPattern = RegExp(
    r'((?:--)?DartDefines=|DART_DEFINES\s*=\s*)[^\r\n\s]+',
  );

  static final RegExp _goLinkerSecretPattern = RegExp(
    r'(-X\s+main\.GlobalDNSAuth(?:PrivateKey|Domains)=)\S+',
  );

  static void requireEnvironment(Iterable<String> keys) {
    final missing = keys
        .where((key) => Platform.environment[key]?.trim().isNotEmpty != true)
        .toList();
    if (missing.isNotEmpty) {
      throw 'Missing required build environment: ${missing.join(', ')}';
    }
  }

  static String _redactSensitive(String value) {
    return value
        .replaceAllMapped(
          _sensitiveValuePattern,
          (match) => '${match[1]}=<redacted>',
        )
        .replaceAllMapped(
          _goLinkerSecretPattern,
          (match) => '${match[1]}<redacted>',
        );
  }

  static String _redactOutput(String value) {
    return _redactSensitive(
      value,
    ).replaceAllMapped(_dartDefinesPattern, (match) => '${match[1]}<redacted>');
  }

  static String _redactCommand(List<String> executable) {
    return executable.map(_redactSensitive).join(' ');
  }

  static Map<String, String>? _redactEnvironment(
    Map<String, String>? environment,
  ) {
    return environment?.map((key, value) {
      return MapEntry(
        key,
        _sensitiveBuildKeys.contains(key)
            ? '<redacted>'
            : _redactSensitive(value),
      );
    });
  }

  static Future<void> exec(
    List<String> executable, {
    String? name,
    Map<String, String>? environment,
    String? workingDirectory,
    bool runInShell = true,
  }) async {
    if (name != null) print('run $name');
    print('exec: ${_redactCommand(executable)}');
    print('env: ${_redactEnvironment(environment).toString()}');
    final process = await Process.start(
      executable[0],
      executable.sublist(1),
      environment: environment,
      workingDirectory: workingDirectory,
      runInShell: runInShell,
    );
    Future<void> forward(Stream<List<int>> stream) => stream
        .transform(const Utf8Decoder(allowMalformed: true))
        .transform(const LineSplitter())
        .forEach((line) => print(_redactOutput(line)));
    await Future.wait([forward(process.stdout), forward(process.stderr)]);
    final exitCode = await process.exitCode;
    if (exitCode != 0) {
      throw ProcessException(
        executable.first,
        executable.skip(1).map(_redactSensitive).toList(),
        '${name ?? executable.first} failed',
        exitCode,
      );
    }
  }

  static Future<List<String>> buildCore({
    required Mode mode,
    required Target target,
    Arch? arch,
    bool includeHelper = false,
  }) async {
    final items = buildItems.where(
      (item) => item.target == target && (arch == null || item.arch == arch),
    );
    final outputs = <String>[];
    hooks.initLogging();
    try {
      for (final item in items) {
        final nativeTarget = hooks.Target.resolve(
          platform: target.name,
          goarch: item.arch!.name,
        );
        final report = await hooks.buildPlatform(
          hooks.BuildRequest(
            rootDir: current,
            target: nativeTarget,
            harnessDir: join(current, 'plugins', 'setup', 'setup_hooks'),
            includeHelper: includeHelper,
            requireSecrets: true,
            androidToolchain: mode == Mode.lib
                ? hooks.AndroidToolchain(
                    clangDirectory: dirname(_getCc(item)),
                    apiLevel: _androidApiLevel,
                  )
                : null,
          ),
        );
        outputs.add(
          report.outputs.firstWhere(
            (path) =>
                basename(path) ==
                (mode == Mode.lib
                    ? '$libName.so'
                    : '$coreName${target.executableExtensionName}'),
          ),
        );
      }
      return outputs;
    } finally {
      hooks.closeLogging();
    }
  }

  static Future<void> getDistributor() async {
    final distributorDir = join(
      current,
      'plugins',
      'flutter_distributor',
      'packages',
      'flutter_distributor',
    );
    await exec([
      'dart',
      'pub',
      'global',
      'activate',
      '-s',
      'path',
      distributorDir,
    ], name: 'get distributor');
  }
}

class BuildCommand extends Command {
  Target target;

  BuildCommand({required this.target}) {
    argParser.addOption(
      'arch',
      allowed: arches.map((e) => e.name).toList(),
      help:
          'Target architecture (defaults to the desktop host; all on Android)',
    );
    argParser.addOption(
      'out',
      allowed: [if (target.same) 'app', 'core'],
      help: 'The $name build arch',
    );
    argParser.addOption(
      'env',
      allowed: ['pre', 'stable'],
      help: 'The $name build env',
    );
  }

  @override
  String get description => 'build $name application';

  @override
  String get name => target.name;

  List<Arch> get arches => Build.buildItems
      .where((element) => element.target == target && element.arch != null)
      .map((e) => e.arch!)
      .toList();

  List<String> _buildDartDefines({
    required String prefix,
    required String env,
  }) {
    final values = {
      'APP_ENV': env,
      'PROFILE_KEY': Platform.environment['PROFILE_KEY']?.trim(),
      'BASE_DOMAIN': Platform.environment['BASE_DOMAIN']?.trim(),
      'SPARE_DOMAIN': Platform.environment['SPARE_DOMAIN']?.trim(),
      'API_DOMAIN': Platform.environment['API_DOMAIN']?.trim(),
      'SPARE_API_DOMAIN': Platform.environment['SPARE_API_DOMAIN']?.trim(),
      'FLCLASH_APP_SECRET': Platform.environment['FLCLASH_APP_SECRET']?.trim(),
    };

    return values.entries
        .where((entry) => entry.value != null && entry.value!.isNotEmpty)
        .map((entry) {
          // APP_ENV is not a secret; everything else is obfuscated (v2) and
          // restored at runtime by lib/common/secrets.dart.
          final value = entry.key == 'APP_ENV'
              ? entry.value!
              : hooks.obfuscateBuildSecret(entry.value!);
          return '$prefix=${entry.key}=$value';
        })
        .toList();
  }

  Future<void> _getLinuxDependencies(Arch arch) async {
    await Build.exec(['sudo', 'apt-get', 'update', '-y']);
    await Build.exec([
      'sudo',
      'apt-get',
      'install',
      '-y',
      'ninja-build',
      'libgtk-3-dev',
      'libayatana-appindicator3-dev',
      'libkeybinder-3.0-dev',
      'libsecret-1-dev',
      'libjsoncpp-dev',
      'libglib2.0-dev',
      'locate',
    ]);
    if (arch == Arch.amd64) {
      await Build.exec([
        'sudo',
        'apt-get',
        'install',
        '-y',
        'rpm',
        'patchelf',
        'libfuse2',
      ]);
      await _installAppImageTool();
    }
  }

  /// Pins the static runtime through a wrapper, because flutter_distributor
  /// runs `appimagetool` with no options. See docs/aur-packaging.md.
  Future<void> _installAppImageTool() async {
    const toolDir = '/usr/local/lib/flclash';
    const realTool = '$toolDir/appimagetool';
    const runtime = '$toolDir/appimage-runtime';
    const wrapper = '/usr/local/bin/appimagetool';

    await Build.exec(['sudo', 'mkdir', '-p', toolDir]);
    if (!File(realTool).existsSync()) {
      await Build.exec([
        'wget',
        '-O',
        'appimagetool',
        'https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage',
      ]);
      await Build.exec(['chmod', '+x', 'appimagetool']);
      await Build.exec(['sudo', 'mv', 'appimagetool', realTool]);
    }
    if (!File(runtime).existsSync()) {
      await Build.exec([
        'wget',
        '-O',
        'appimage-runtime',
        'https://github.com/AppImage/type2-runtime/releases/download/continuous/runtime-x86_64',
      ]);
      await Build.exec(['sudo', 'mv', 'appimage-runtime', runtime]);
    }

    final wrapperFile = File(
      join(Directory.systemTemp.path, 'appimagetool-wrapper.sh'),
    );
    await wrapperFile.writeAsString(
      '#!/bin/sh\n'
      'exec $realTool --runtime-file $runtime "\$@"\n',
    );
    await Build.exec(['chmod', '+x', wrapperFile.path]);
    await Build.exec(['sudo', 'mv', wrapperFile.path, wrapper]);
  }

  /// Fails the build when the image still resolves libfuse.so.2 at startup.
  Future<void> _verifyAppImageRuntime() async {
    final distDir = Directory(join(current, 'dist'));
    if (!distDir.existsSync()) return;
    final images = distDir.listSync().whereType<File>().where(
      (file) => extension(file.path) == '.AppImage',
    );
    for (final image in images) {
      final handle = await image.open();
      try {
        final head = await handle.read(2 * 1024 * 1024);
        if (const AsciiDecoder(
          allowInvalid: true,
        ).convert(head).contains('libfuse.so.2')) {
          throw Exception(
            '${basename(image.path)} embeds the fuse2 AppImage runtime',
          );
        }
      } finally {
        await handle.close();
      }
    }
  }

  Future<void> _setLinuxCoreSetuid() async {
    final coreFile = File('libclash/linux/FlClashCore');
    if (!coreFile.existsSync()) return;
    final result = await Process.run('chmod', ['u+s', coreFile.path]);
    if (result.exitCode != 0) {
      throw ProcessException(
        'chmod',
        ['u+s', coreFile.path],
        result.stderr.toString(),
        result.exitCode,
      );
    }
  }

  Future<void> _getMacosDependencies() async {
    final appDmg = await Process.run('bash', [
      '-lc',
      'command -v appdmg >/dev/null 2>&1',
    ]);
    if (appDmg.exitCode == 0) {
      return;
    }
    await Build.exec(['npm', 'install', '-g', 'appdmg']);
  }

  Future<void> _buildDistributor({
    required Target target,
    required String targets,
    List<String> args = const [],
    Map<String, String>? environment,
    required String env,
  }) async {
    await Build.getDistributor();

    // Use custom artifact name template to exclude version number and -setup suffix
    const artifactNameTemplate =
        'flclash-{{platform}}{{#description}}-{{description}}{{/description}}.{{ext}}';
    final dartDefines = _buildDartDefines(
      prefix: '--build-dart-define',
      env: env,
    );
    final flutterBuildArgs = [
      if (Platform.environment['FLUTTER_BUILD_VERBOSE'] == 'true') 'verbose',
      'no-pub',
      // Obfuscate Dart symbol names in the AOT snapshot; split-debug-info keeps
      // the mapping so release crashes can still be de-obfuscated (retain the
      // build/debug-symbols/<platform> dir per release).
      'obfuscate',
      'split-debug-info=build/debug-symbols/${target.name}',
    ].join(',');

    await Build.exec(name: name, [
      'flutter_distributor',
      'package',
      '--skip-clean',
      '--platform',
      target.name,
      '--targets',
      targets,
      '--artifact-name',
      artifactNameTemplate,
      '--flutter-build-args=$flutterBuildArgs',
      ...args,
      ...dartDefines,
    ], environment: environment);
  }

  Future<void> _buildAndroidApkDirect({
    required String targetPlatform,
    required String archName,
    required String env,
  }) async {
    final dartDefines = _buildDartDefines(prefix: '--dart-define', env: env);

    await Build.exec(name: name, [
      'flutter',
      'build',
      'apk',
      '--no-pub',
      '--obfuscate',
      '--split-debug-info=build/debug-symbols/android',
      '--target-platform',
      targetPlatform,
      ...dartDefines,
    ]);

    final distDir = Directory(join(current, 'dist'));
    if (!await distDir.exists()) {
      await distDir.create(recursive: true);
    }

    final sourceApk = File(
      join(
        current,
        'build',
        'app',
        'outputs',
        'flutter-apk',
        'app-release.apk',
      ),
    );
    if (await sourceApk.exists()) {
      final targetApk = File(
        join(distDir.path, 'flclash-android-$archName.apk'),
      );
      await sourceApk.copy(targetApk.path);
      print('✓ Built APK: ${targetApk.path}');
    } else {
      throw 'APK file not found: ${sourceApk.path}';
    }
  }

  Future<String?> get systemArch async {
    if (Platform.isWindows) {
      return Platform.environment['PROCESSOR_ARCHITECTURE'];
    } else if (Platform.isLinux || Platform.isMacOS) {
      final result = await Process.run('uname', ['-m']);
      return result.stdout.toString().trim();
    }
    return null;
  }

  @override
  Future<void> run() async {
    final mode = target == Target.android ? Mode.lib : Mode.core;
    final String out = argResults?['out'] ?? (target.same ? 'app' : 'core');
    final archName =
        argResults?['arch'] as String? ??
        (target == Target.android
            ? null
            : resolveHostArch(await systemArch)?.name);
    final env = argResults?['env'] ?? 'pre';
    final currentArches = arches
        .where((element) => element.name == archName)
        .toList();
    final arch = currentArches.isEmpty ? null : currentArches.first;

    if (arch == null && target != Target.android) {
      throw 'Invalid arch parameter';
    }

    Build.requireEnvironment(const [
      'DNS_AUTH_PRIVATE_KEY',
      'DNS_AUTH_DOMAINS',
    ]);
    if (out == 'app') {
      final config =
          loadYaml(File('pubspec.yaml').readAsStringSync()) as YamlMap;
      final defines =
          (config['hooks'] as YamlMap?)?['user_defines'] as YamlMap?;
      for (final package in ['setup', 'rust_api']) {
        if ((defines?[package] as YamlMap?)?['build_assets'] == false) {
          throw 'Enable native build assets for $package before packaging';
        }
      }
      Build.requireEnvironment(const [
        'PROFILE_KEY',
        'BASE_DOMAIN',
        'SPARE_DOMAIN',
        'API_DOMAIN',
        'SPARE_API_DOMAIN',
        'FLCLASH_APP_SECRET',
      ]);
      Build.prepareAppVersion();
    }

    await Build.buildCore(
      target: target,
      arch: arch,
      mode: mode,
      includeHelper: out == 'app',
    );

    if (out != 'app') {
      return;
    }

    switch (target) {
      case Target.windows:
        await _buildDistributor(
          target: target,
          targets: 'exe,zip',
          args: ['--description', archName!],
          env: env,
        );
        return;
      case Target.linux:
        final targetMap = {Arch.arm64: 'linux-arm64', Arch.amd64: 'linux-x64'};
        final targets = [
          'deb',
          if (arch == Arch.amd64) 'appimage',
          if (arch == Arch.amd64) 'rpm',
        ].join(',');
        final defaultTarget = targetMap[arch];
        await _getLinuxDependencies(arch!);
        await _setLinuxCoreSetuid();
        await _buildDistributor(
          target: target,
          targets: targets,
          args: [
            '--description',
            archName!,
            '--build-target-platform',
            defaultTarget!,
          ],
          env: env,
        );
        await _verifyAppImageRuntime();
        return;
      case Target.android:
        final targetMap = {
          Arch.arm: 'android-arm',
          Arch.arm64: 'android-arm64',
          Arch.amd64: 'android-x64',
        };
        final archNameMap = {
          Arch.arm: 'armeabi-v7a',
          Arch.arm64: 'arm64-v8a',
          Arch.amd64: 'x86_64',
        };

        if (arch != null) {
          await _buildAndroidApkDirect(
            targetPlatform: targetMap[arch]!,
            archName: archNameMap[arch]!,
            env: env,
          );
        } else {
          final defaultArches = [Arch.arm, Arch.arm64, Arch.amd64];
          final defaultTargets = defaultArches
              .map((e) => targetMap[e])
              .toList();
          await _buildDistributor(
            target: target,
            targets: 'apk',
            args: ['--build-target-platform', defaultTargets.join(',')],
            env: env,
          );
        }
        return;
      case Target.macos:
        await _getMacosDependencies();
        await _buildDistributor(
          target: target,
          targets: 'dmg',
          args: ['--description', archName!],
          // Flutter release builds otherwise default to a universal app, while
          // this package contains the Core for the explicitly selected arch.
          environment: {
            'FLUTTER_XCODE_ARCHS': arch == Arch.arm64 ? 'arm64' : 'x86_64',
          },
          env: env,
        );
        return;
    }
  }
}

Future<void> main(Iterable<String> args) async {
  final runner = CommandRunner('setup', 'build Application');
  runner.addCommand(BuildCommand(target: Target.android));
  runner.addCommand(BuildCommand(target: Target.linux));
  runner.addCommand(BuildCommand(target: Target.windows));
  runner.addCommand(BuildCommand(target: Target.macos));
  await runner.run(args);
}

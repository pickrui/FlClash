// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:args/command_runner.dart';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart';

// Obfuscate compile-time secrets (v2) so plaintext keys/domains are not left in
// the Go core binary or the Flutter dart-defines. Restored at runtime by
// core/secrets.go and lib/common/secrets.dart, which share this exact scheme:
// keystream = SHA256-CTR(master, nonce), master = SHA256(a||b||"oix-obf-v2-flclash").
final Random _obfRandom = Random.secure();

String _obfV2(String plain) {
  final data = utf8.encode(plain);
  final nonce = List<int>.generate(8, (_) => _obfRandom.nextInt(256));
  final ks = _obfKeystream(nonce, data.length);
  final out = List<int>.generate(data.length, (i) => data[i] ^ ks[i]);
  return 'v2:${base64.encode(<int>[...nonce, ...out])}';
}

List<int> _obfMaster() {
  const a = [0x5a, 0x1c, 0xe7, 0x93, 0x2f, 0xb8, 0x04, 0xd6, 0x69, 0xa1, 0x3e, 0xcf, 0x72, 0x8d, 0x15, 0xba];
  const b = [0xc4, 0x37, 0x9e, 0x08, 0x51, 0xed, 0x2a, 0x7f, 0xd3, 0x60, 0x1b, 0x86, 0xf9, 0x42, 0xad, 0x0e];
  return sha256.convert(<int>[...a, ...b, ...utf8.encode('oix-obf-v2-flclash')]).bytes;
}

List<int> _obfKeystream(List<int> nonce, int count) {
  final master = _obfMaster();
  final out = <int>[];
  var counter = 0;
  while (out.length < count) {
    out.addAll(sha256.convert(<int>[
      ...master,
      ...nonce,
      (counter >> 24) & 0xff,
      (counter >> 16) & 0xff,
      (counter >> 8) & 0xff,
      counter & 0xff,
    ]).bytes);
    counter++;
  }
  return out.sublist(0, count);
}

enum Target { windows, linux, android, macos }

extension TargetExt on Target {
  String get os {
    if (this == Target.macos) {
      return 'darwin';
    }
    return name;
  }

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

  String get dynamicLibExtensionName {
    final String extensionName;
    switch (this) {
      case Target.android || Target.linux:
        extensionName = '.so';
        break;
      case Target.windows:
        extensionName = '.dll';
        break;
      case Target.macos:
        extensionName = '.dylib';
        break;
    }
    return extensionName;
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

class Build {
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

  static String get appName => 'FlClash';

  static String get coreName => 'FlClashCore';

  static String get libName => 'libclash';

  static const coreManifestName = 'manifest.json';

  static String get outDir => join(current, libName);

  static String get _coreDir => join(current, 'core');

  static String get _servicesDir => join(current, 'services', 'helper');

  static String get distPath => join(current, 'dist');

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
        'armeabi-v7a': 'armv7a-linux-androideabi21-clang',
        'arm64-v8a': 'aarch64-linux-android21-clang',
        'x86': 'i686-linux-android21-clang',
        'x86_64': 'x86_64-linux-android21-clang',
      };
      return join(prebuiltDirList.first.path, 'bin', map[buildItem.archName]);
    }
    return 'gcc';
  }

  static String get tags => 'with_gvisor';

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
    return _redactSensitive(value).replaceAllMapped(
      _dartDefinesPattern,
      (match) => '${match[1]}<redacted>',
    );
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
    process.stdout.listen((data) {
      print(_redactOutput(utf8.decode(data, allowMalformed: true)));
    });
    process.stderr.listen((data) {
      print(_redactOutput(utf8.decode(data, allowMalformed: true)));
    });
    final exitCode = await process.exitCode;
    if (exitCode != 0 && name != null) throw '$name error';
  }

  static Future<String> calcSha256(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw 'File not exists';
    }
    final stream = file.openRead();
    return sha256.convert(await stream.reduce((a, b) => a + b)).toString();
  }

  static Future<List<String>> buildCore({
    required Mode mode,
    required Target target,
    Arch? arch,
  }) async {
    final isLib = mode == Mode.lib;

    final items = buildItems.where((element) {
      return element.target == target &&
          (arch == null ? true : element.arch == arch);
    }).toList();

    final List<String> corePaths = [];

    final targetOutFilePath = join(outDir, target.name);
    final targetOutDirectory = Directory(targetOutFilePath);
    if (await targetOutDirectory.exists()) {
      await targetOutDirectory.delete(recursive: true);
    }
    await targetOutDirectory.create(recursive: true);
    for (final item in items) {
      final outFilePath = join(targetOutFilePath, item.archName);

      final fileName = isLib
          ? '$libName${item.target.dynamicLibExtensionName}'
          : '$coreName${item.target.executableExtensionName}';
      final realOutPath = join(outFilePath, fileName);
      corePaths.add(realOutPath);

      final Map<String, String> env = {};
      env['GOOS'] = item.target.os;
      if (item.arch != null) {
        env['GOARCH'] = item.arch!.name;
      }
      if (isLib) {
        env['CGO_ENABLED'] = '1';
        env['CC'] = _getCc(item);
        env['CFLAGS'] = '-O3 -Werror';
      } else {
        env['CGO_ENABLED'] = '0';
      }
      // -w -s strips the symbol table and DWARF; -buildid= removes the build
      // fingerprint. Combined with -trimpath below (which drops source paths),
      // this matches the mihomo/Clash.Meta hardening baseline.
      final ldflags = StringBuffer('-w -s -buildid=');
      final dnsAuthPrivateKey =
          Platform.environment['DNS_AUTH_PRIVATE_KEY']?.trim();
      if (dnsAuthPrivateKey != null && dnsAuthPrivateKey.isNotEmpty) {
        ldflags.write(
          ' -X main.GlobalDNSAuthPrivateKey=${_obfV2(dnsAuthPrivateKey)}',
        );
      }
      final dnsAuthDomains = Platform.environment['DNS_AUTH_DOMAINS']?.trim();
      if (dnsAuthDomains != null && dnsAuthDomains.isNotEmpty) {
        ldflags.write(' -X main.GlobalDNSAuthDomains=${_obfV2(dnsAuthDomains)}');
      }
      final execLines = [
        'go',
        'build',
        '-trimpath',
        '-ldflags=$ldflags',
        '-tags=$tags',
        if (isLib) '-buildmode=c-shared',
        '-o',
        realOutPath,
      ];
      await exec(
        execLines,
        name: 'build core',
        environment: env,
        workingDirectory: _coreDir,
      );
      if (isLib && item.archName != null) {
        await adjustLibOut(
          targetOutFilePath: targetOutFilePath,
          outFilePath: outFilePath,
          archName: item.archName!,
        );
      }
    }

    if (target == Target.windows && !isLib && corePaths.isNotEmpty) {
      final coreSha256 = await calcSha256(corePaths.first);
      await File(
        join(targetOutFilePath, coreManifestName),
      ).writeAsString(
        '${jsonEncode({'coreSha256': coreSha256})}\n',
        flush: true,
      );
    }

    return corePaths;
  }

  static Future<void> adjustLibOut({
    required String targetOutFilePath,
    required String outFilePath,
    required String archName,
  }) async {
    final includesPath = join(targetOutFilePath, 'includes');
    final realOutPath = join(includesPath, archName);
    await Directory(realOutPath).create(recursive: true);
    final targetOutFiles = Directory(outFilePath).listSync();
    final coreFiles = Directory(_coreDir).listSync();
    for (final file in [...targetOutFiles, ...coreFiles]) {
      if (!file.path.endsWith('.h')) {
        continue;
      }
      final targetFilePath = join(realOutPath, basename(file.path));
      final realFile = File(file.path);
      await realFile.copy(targetFilePath);
      if (coreFiles.contains(file)) {
        continue;
      }
      await realFile.delete();
    }
  }

  static Future<void> buildHelper(Target target, String coreSha256) async {
    await exec(
      ['cargo', 'build', '--release', '--features', 'windows-service'],
      environment: {'CORE_SHA256': coreSha256, 'CORE_NAME': '$coreName.exe'},
      name: 'build helper',
      workingDirectory: _servicesDir,
    );
    final outPath = join(
      _servicesDir,
      'target',
      'release',
      'helper${target.executableExtensionName}',
    );
    final targetPath = join(
      outDir,
      target.name,
      'FlClashHelperService${target.executableExtensionName}',
    );
    await File(outPath).copy(targetPath);
  }

  static List<String> getExecutable(String command) {
    return command.split(' ');
  }

  static Future<void> getDistributor() async {
    final distributorDir = join(
      current,
      'plugins',
      'flutter_distributor',
      'packages',
      'flutter_distributor',
    );

    await exec(
      name: 'get distributor',
      Build.getExecutable('dart pub global activate -s path $distributorDir'),
    );
  }

  static void copyFile(String sourceFilePath, String destinationFilePath) {
    final sourceFile = File(sourceFilePath);
    if (!sourceFile.existsSync()) {
      throw 'SourceFilePath not exists';
    }
    final destinationFile = File(destinationFilePath);
    final destinationDirectory = destinationFile.parent;
    if (!destinationDirectory.existsSync()) {
      destinationDirectory.createSync(recursive: true);
    }
    try {
      sourceFile.copySync(destinationFilePath);
      print('File copied successfully!');
    } catch (e) {
      print('Failed to copy file: $e');
    }
  }
}

class BuildCommand extends Command {
  Target target;

  BuildCommand({required this.target}) {
    if (target == Target.android || target == Target.linux) {
      argParser.addOption(
        'arch',
        valueHelp: arches.map((e) => e.name).join(','),
        help: 'The $name build desc',
      );
    } else {
      argParser.addOption('arch', help: 'The $name build archName');
    }
    argParser.addOption(
      'out',
      valueHelp: [if (target.same) 'app', 'core'].join(','),
      help: 'The $name build arch',
    );
    argParser.addOption(
      'env',
      valueHelp: ['pre', 'stable'].join(','),
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

  String _buildDartDefines({required String prefix, required String env}) {
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
              : _obfV2(entry.value!);
          return '$prefix=${entry.key}=$value';
        })
        .join(' ');
  }

  Future<void> _getLinuxDependencies(Arch arch) async {
    await Build.exec(Build.getExecutable('sudo apt-get update -y'));
    await Build.exec(
      Build.getExecutable(
        'sudo apt-get install -y ninja-build libgtk-3-dev libayatana-appindicator3-dev libkeybinder-3.0-dev libsecret-1-dev libjsoncpp-dev libglib2.0-dev locate',
      ),
    );
    if (arch == Arch.amd64) {
      await Build.exec(
        Build.getExecutable('sudo apt-get install -y rpm patchelf libfuse2'),
      );

      final appImageTool = File('/usr/local/bin/appimagetool');
      if (!appImageTool.existsSync()) {
        final downloadName = arch == Arch.amd64 ? 'x86_64' : 'aarch64';
        await Build.exec(
          Build.getExecutable(
            'wget -O appimagetool https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-$downloadName.AppImage',
          ),
        );
        await Build.exec(Build.getExecutable('chmod +x appimagetool'));
        await Build.exec(
          Build.getExecutable('sudo mv appimagetool /usr/local/bin/'),
        );
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
    await Build.exec(Build.getExecutable('npm install -g appdmg'));
  }

  Future<void> _buildDistributor({
    required Target target,
    required String targets,
    String args = '',
    required String env,
  }) async {
    await Build.getDistributor();

    // Get version from environment variables if available
    final versionNumber = Platform.environment['FLUTTER_VERSION_NUMBER'];
    final buildNumber = Platform.environment['FLUTTER_BUILD_NUMBER'];

    // Update pubspec.yaml with version from environment if available
    if (versionNumber != null && buildNumber != null) {
      await _updatePubspecVersion(versionNumber, buildNumber);
    }

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

    await Build.exec(
      name: name,
      Build.getExecutable(
        'flutter_distributor package --skip-clean --platform ${target.name} --targets $targets --artifact-name $artifactNameTemplate --flutter-build-args=$flutterBuildArgs$args $dartDefines',
      ),
    );
  }

  Future<void> _buildAndroidApkDirect({
    required String targetPlatform,
    required String archName,
    required String env,
  }) async {
    final versionNumber = Platform.environment['FLUTTER_VERSION_NUMBER'];
    final buildNumber = Platform.environment['FLUTTER_BUILD_NUMBER'];

    if (versionNumber != null && buildNumber != null) {
      await _updatePubspecVersion(versionNumber, buildNumber);
    }

    final dartDefines = _buildDartDefines(prefix: '--dart-define', env: env);

    await Build.exec(
      name: name,
      Build.getExecutable(
        'flutter build apk --no-pub --obfuscate --split-debug-info=build/debug-symbols/android --target-platform $targetPlatform $dartDefines',
      ),
    );

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

  Future<void> _updatePubspecVersion(String version, String buildNumber) async {
    final pubspecPath = join(current, 'pubspec.yaml');
    final pubspecFile = File(pubspecPath);

    if (!await pubspecFile.exists()) {
      print('Warning: pubspec.yaml not found');
      return;
    }

    final content = await pubspecFile.readAsString();
    final lines = content.split('\n');
    final updatedLines = <String>[];

    for (final line in lines) {
      if (line.startsWith('version:')) {
        updatedLines.add('version: $version+$buildNumber');
        print('Updated version to: $version+$buildNumber');
      } else {
        updatedLines.add(line);
      }
    }

    await pubspecFile.writeAsString(updatedLines.join('\n'));
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
    final archName = argResults?['arch'];
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
      Build.requireEnvironment(const [
        'PROFILE_KEY',
        'BASE_DOMAIN',
        'SPARE_DOMAIN',
        'API_DOMAIN',
        'SPARE_API_DOMAIN',
        'FLCLASH_APP_SECRET',
      ]);
    }

    final corePaths = await Build.buildCore(
      target: target,
      arch: arch,
      mode: mode,
    );

    if (out != 'app') {
      return;
    }

    switch (target) {
      case Target.windows:
        final coreSha256 = await Build.calcSha256(corePaths.first);
        await Build.buildHelper(target, coreSha256);
        await _buildDistributor(
          target: target,
          targets: 'exe,zip',
          args: ' --description $archName',
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
          args:
              ' --description $archName --build-target-platform $defaultTarget',
          env: env,
        );
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
            args:
                " --build-target-platform ${defaultTargets.join(",")}",
            env: env,
          );
        }
        return;
      case Target.macos:
        await _getMacosDependencies();
        await _buildDistributor(
          target: target,
          targets: 'dmg',
          args: ' --description $archName',
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

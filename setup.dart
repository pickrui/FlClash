// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart';

enum Target { windows, linux, android, macos }

// 构建产物文件名模板常量
const String _defaultArtifactNameTemplate = 'flclash-{{platform}}{{#description}}-{{description}}{{/description}}.{{ext}}';
const String _windowsArtifactNameTemplate = 'flclash-windows-x86_64{{#ext}}.{{ext}}{{/ext}}';
const String _androidArtifactNameTemplate = 'flclash-{{platform}}.{{ext}}';

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

  /// 自动更新 pubspec.yaml 中的构建号
  static Future<void> updateVersion() async {
    final pubspecFile = File(join(current, 'pubspec.yaml'));
    if (!await pubspecFile.exists()) {
      return;
    }

    final content = await pubspecFile.readAsString();
    final lines = content.split('\n');
    
    // 查找 version 行
    final versionIndex = lines.indexWhere((line) => line.trim().startsWith('version:'));
    if (versionIndex == -1) {
      return;
    }

    final versionLine = lines[versionIndex];
    final versionMatch = RegExp(r'version:\s*([\d.]+)\+(\d+)').firstMatch(versionLine);
    if (versionMatch == null) {
      return;
    }

    final versionNumber = versionMatch.group(1)!; // 例如: 0.8.90
    final oldBuildNumber = versionMatch.group(2)!; // 例如: 2025100801

    // 获取当前 UTC 时间并转换为 UTC+8
    final nowUtc = DateTime.now().toUtc();
    final now = nowUtc.add(const Duration(hours: 8));
    
    // 提取日期组件
    final year = now.year;
    final month = now.month;
    final day = now.day;
    final hour = now.hour;
    
    // 调试信息：输出原始时间值
    print('Build number generation: UTC=${nowUtc.toString()}, UTC+8=${now.toString()}, year=$year, month=$month, day=$day, hour=$hour');
    
    // 验证日期有效性
    if (month < 1 || month > 12) {
      throw 'Invalid month value: $month (from DateTime: ${now.toString()})';
    }
    if (day < 1 || day > 31) {
      throw 'Invalid day value: $day (from DateTime: ${now.toString()})';
    }
    if (hour < 0 || hour > 23) {
      throw 'Invalid hour value: $hour (from DateTime: ${now.toString()})';
    }
    
    // 使用 DateTime.utc 验证日期是否有效（这会自动处理无效日期）
    DateTime testDate;
    try {
      testDate = DateTime.utc(year, month, day, hour);
      // 检查日期是否被自动调整（例如 11月31日会被调整为12月1日）
      if (testDate.year != year || testDate.month != month || testDate.day != day || testDate.hour != hour) {
        throw 'Date validation failed: constructed date ($testDate) does not match input ($year-$month-$day $hour:00). This indicates an invalid date (e.g., day 31 in a month with only 30 days).';
      }
    } catch (e) {
      throw 'Invalid date: $year-$month-$day $hour:00 (from ${now.toString()}). Error: $e';
    }
    
    // 分别生成字符串，确保类型安全
    final yearStr = year.toString();
    final monthStr = month.toString();
    final dayStr = day.toString();
    final hourStr = hour.toString();
    
    // 确保每个组件都是正确的格式（补零）
    final yearStrPadded = yearStr.padLeft(4, '0');
    final monthStrPadded = monthStr.padLeft(2, '0');
    final dayStrPadded = dayStr.padLeft(2, '0');
    final hourStrPadded = hourStr.padLeft(2, '0');
    
    // 验证每个组件的长度和格式
    if (yearStrPadded.length != 4 || !RegExp(r'^\d{4}$').hasMatch(yearStrPadded)) {
      throw 'Invalid year format: "$yearStrPadded" (expected 4 digits)';
    }
    if (monthStrPadded.length != 2 || !RegExp(r'^\d{2}$').hasMatch(monthStrPadded)) {
      throw 'Invalid month format: "$monthStrPadded" (expected 2 digits)';
    }
    if (dayStrPadded.length != 2 || !RegExp(r'^\d{2}$').hasMatch(dayStrPadded)) {
      throw 'Invalid day format: "$dayStrPadded" (expected 2 digits)';
    }
    if (hourStrPadded.length != 2 || !RegExp(r'^\d{2}$').hasMatch(hourStrPadded)) {
      throw 'Invalid hour format: "$hourStrPadded" (expected 2 digits)';
    }
    
    // 拼接构建号
    final finalBuildNumber = '$yearStrPadded$monthStrPadded$dayStrPadded$hourStrPadded';
    
    // 调试信息：输出构建号组件
    print('Build number components: year="$yearStrPadded", month="$monthStrPadded", day="$dayStrPadded", hour="$hourStrPadded", final="$finalBuildNumber"');
    
    // 最终验证构建号格式
    if (finalBuildNumber.length != 10 || !RegExp(r'^\d{10}$').hasMatch(finalBuildNumber)) {
      throw 'Invalid build number format: "$finalBuildNumber" (length: ${finalBuildNumber.length}, expected YYYYMMDDHH). Components: year=$yearStrPadded, month=$monthStrPadded, day=$dayStrPadded, hour=$hourStrPadded';
    }
    
    // 再次验证日期有效性（双重检查）- 这是最关键的验证
    try {
      final parsedYear = int.parse(finalBuildNumber.substring(0, 4));
      final parsedMonth = int.parse(finalBuildNumber.substring(4, 6));
      final parsedDay = int.parse(finalBuildNumber.substring(6, 8));
      final parsedHour = int.parse(finalBuildNumber.substring(8, 10));
      
      // 验证解析后的值是否与原始值匹配
      if (parsedYear != year || parsedMonth != month || parsedDay != day || parsedHour != hour) {
        throw 'Parsed components do not match: year=$parsedYear vs $year, month=$parsedMonth vs $month, day=$parsedDay vs $day, hour=$parsedHour vs $hour. Build number: "$finalBuildNumber"';
      }
      
      // 验证月份范围
      if (parsedMonth < 1 || parsedMonth > 12) {
        throw 'Invalid month in build number: $parsedMonth (from "$finalBuildNumber")';
      }
      
      // 验证日期范围（根据月份）
      final daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
      final maxDay = parsedMonth == 2 && _isLeapYear(parsedYear) ? 29 : daysInMonth[parsedMonth - 1];
      if (parsedDay < 1 || parsedDay > maxDay) {
        throw 'Invalid day in build number: $parsedDay (month $parsedMonth has max $maxDay days, from "$finalBuildNumber")';
      }
      
      // 验证小时范围
      if (parsedHour < 0 || parsedHour > 23) {
        throw 'Invalid hour in build number: $parsedHour (from "$finalBuildNumber")';
      }
      
      // 使用 DateTime.utc 验证日期是否有效（这会自动处理无效日期）
      final testDate = DateTime.utc(parsedYear, parsedMonth, parsedDay, parsedHour);
      if (testDate.year != parsedYear || testDate.month != parsedMonth || testDate.day != parsedDay || testDate.hour != parsedHour) {
        throw 'Date validation failed: constructed date ($testDate) does not match parsed components (year=$parsedYear, month=$parsedMonth, day=$parsedDay, hour=$parsedHour) from "$finalBuildNumber"';
      }
    } catch (e) {
      throw 'Invalid date in build number: "$finalBuildNumber". Error: $e';
    }

    lines[versionIndex] = 'version: $versionNumber+$finalBuildNumber';
    
    await pubspecFile.writeAsString(lines.join('\n'));
    print('Updated version: $versionNumber+$oldBuildNumber -> $versionNumber+$finalBuildNumber');

    final androidDir = Directory(join(current, 'android'));
    if (!await androidDir.exists()) {
      return;
    }
    
    final localPropertiesFile = File(join(current, 'android', 'local.properties'));
    List<String> localPropertiesLines = [];
    
    if (await localPropertiesFile.exists()) {
      final localPropertiesContent = await localPropertiesFile.readAsString();
      localPropertiesLines = localPropertiesContent.split('\n');
    }
    
    bool versionNameFound = false;
    bool versionCodeFound = false;
    
    for (int i = 0; i < localPropertiesLines.length; i++) {
      if (localPropertiesLines[i].startsWith('flutter.versionName=')) {
        localPropertiesLines[i] = 'flutter.versionName=$versionNumber';
        versionNameFound = true;
      } else if (localPropertiesLines[i].startsWith('flutter.versionCode=')) {
        localPropertiesLines[i] = 'flutter.versionCode=$finalBuildNumber';
        versionCodeFound = true;
      }
    }
    
    if (!versionNameFound) {
      localPropertiesLines.add('flutter.versionName=$versionNumber');
    }
    if (!versionCodeFound) {
      localPropertiesLines.add('flutter.versionCode=$finalBuildNumber');
    }
    
    await localPropertiesFile.writeAsString(localPropertiesLines.join('\n'));
    print('Updated android/local.properties: versionName=$versionNumber, versionCode=$finalBuildNumber');
  }

  static Future<void> exec(
    List<String> executable, {
    String? name,
    Map<String, String>? environment,
    String? workingDirectory,
    bool runInShell = true,
  }) async {
    if (name != null) print('run $name');
    print('exec: ${executable.join(' ')}');
    print('env: ${environment.toString()}');
    final process = await Process.start(
      executable[0],
      executable.sublist(1),
      environment: environment,
      workingDirectory: workingDirectory,
      runInShell: runInShell,
    );
    process.stdout.listen((data) {
      print(utf8.decode(data));
    });
    process.stderr.listen((data) {
      print(utf8.decode(data));
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
    final targetOutFile = File(targetOutFilePath);
    if (await targetOutFile.exists()) {
      await targetOutFile.delete(recursive: true);
      await Directory(targetOutFilePath).create(recursive: true);
    }
    for (final item in items) {
      final outFilePath = join(targetOutFilePath, item.archName);
      final file = File(outFilePath);
      if (file.existsSync()) {
        file.deleteSync(recursive: true);
      }

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
      final execLines = [
        'go',
        'build',
        '-ldflags=-w -s',
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

  static Future<void> buildHelper(Target target, String token) async {
    await exec(
      ['cargo', 'build', '--release', '--features', 'windows-service'],
      environment: {'TOKEN': token},
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
      name: 'clean distributor',
      Build.getExecutable('flutter clean'),
      workingDirectory: distributorDir,
    );
    await exec(
      name: 'upgrade distributor',
      Build.getExecutable('flutter pub upgrade'),
      workingDirectory: distributorDir,
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

  Future<void> _getLinuxDependencies(Arch arch) async {
    await Build.exec(Build.getExecutable('sudo apt update -y'));
    await Build.exec(
      Build.getExecutable('sudo apt install -y ninja-build libgtk-3-dev'),
    );
    await Build.exec(
      Build.getExecutable('sudo apt install -y libayatana-appindicator3-dev'),
    );
    await Build.exec(
      Build.getExecutable('sudo apt-get install -y libkeybinder-3.0-dev'),
    );
    await Build.exec(Build.getExecutable('sudo apt install -y locate'));
    if (arch == Arch.amd64) {
      await Build.exec(Build.getExecutable('sudo apt install -y rpm patchelf'));
      await Build.exec(Build.getExecutable('sudo apt install -y libfuse2'));

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

  Future<void> _getMacosDependencies() async {
    await Build.exec(Build.getExecutable('npm install -g appdmg'));
  }

  Future<void> _buildDistributor({
    required Target target,
    required String targets,
    String args = '',
    required String env,
    String? artifactName,
  }) async {
    await Build.getDistributor();
    final artifactNameArg = artifactName != null ? ' --artifact-name $artifactName' : '';
    await Build.exec(
      name: name,
      Build.getExecutable(
        'flutter_distributor package --skip-clean --platform ${target.name} --targets $targets --flutter-build-args=verbose$args --build-dart-define=APP_ENV=$env$artifactNameArg',
      ),
    );
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
    // 自动更新版本号
    await Build.updateVersion();
    
    final mode = target == Target.android ? Mode.lib : Mode.core;
    final String out = argResults?['out'] ?? (target.same ? 'app' : 'core');
    final archName = argResults?['arch'];
    final env = argResults?['env'] ?? 'stable';
    final currentArches = arches
        .where((element) => element.name == archName)
        .toList();
    final arch = currentArches.isEmpty ? null : currentArches.first;

    if (arch == null && target != Target.android) {
      throw 'Invalid arch parameter';
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
        final token = target != Target.android
            ? await Build.calcSha256(corePaths.first)
            : null;
        Build.buildHelper(target, token!);
        await _buildDistributor(
          target: target,
          targets: 'exe',
          args:
              ' --description $archName --build-dart-define=CORE_SHA256=$token',
          env: env,
          artifactName: _windowsArtifactNameTemplate,
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
        await _buildDistributor(
          target: target,
          targets: targets,
          args:
              ' --description $archName --build-target-platform $defaultTarget',
          env: env,
          artifactName: _defaultArtifactNameTemplate,
        );
        return;
      case Target.android:
        final targetMap = {
          Arch.arm: 'android-arm',
          Arch.arm64: 'android-arm64',
          Arch.amd64: 'android-x64',
        };
        final defaultArches = [Arch.arm, Arch.arm64, Arch.amd64];
        final defaultTargets = defaultArches
            .where((element) => arch == null ? true : element == arch)
            .map((e) => targetMap[e])
            .toList();
        await _buildDistributor(
          target: target,
          targets: 'apk',
          args: ",split-per-abi --build-target-platform ${defaultTargets.join(",")}",
          env: env,
          artifactName: _androidArtifactNameTemplate,
        );
        return;
      case Target.macos:
        await _getMacosDependencies();
        await _buildDistributor(
          target: target,
          targets: 'dmg',
          args: archName != null ? ' --description $archName' : '',
          env: env,
          artifactName: _defaultArtifactNameTemplate,
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
  runner.run(args);
}
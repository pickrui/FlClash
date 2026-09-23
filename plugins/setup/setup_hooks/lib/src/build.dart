import 'dart:io';
import 'artifact_transaction.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

import 'build_cache.dart';
import 'secrets.dart';
import 'error.dart';
import 'fingerprint.dart';
import 'go_builder.dart';
import 'options.dart';
import 'rust_builder.dart';
import 'target.dart';
import 'util.dart';

final _log = Logger('setup_hooks');

class AndroidToolchain {
  const AndroidToolchain({
    required this.clangDirectory,
    required this.apiLevel,
  });

  final String clangDirectory;
  final int apiLevel;

  String clangFor(Target target) =>
      p.join(clangDirectory, '${target.ndkTriple}$apiLevel-clang');
}

class BuildRequest {
  const BuildRequest({
    required this.rootDir,
    required this.target,
    this.harnessDir,
    this.androidToolchain,
    this.includeHelper = true,
    this.requireSecrets = false,
  });

  final bool includeHelper;
  final bool requireSecrets;
  final String rootDir;
  final Target target;

  final String? harnessDir;
  final AndroidToolchain? androidToolchain;
}

class BuildReport {
  const BuildReport({
    required this.inputs,
    required this.outputs,
    required this.rebuilt,
  });

  final List<String> inputs;
  final List<String> outputs;
  final bool rebuilt;

  /// A directory dependency hashes child names, not content, so a deleted
  /// artifact still reruns the hook without rereading the Core.
  List<String> get outputDirectories =>
      {for (final output in outputs) p.dirname(output)}.toList()..sort();
}

/// The Helper embeds the Core's SHA256, so the Core is built first.
Future<BuildReport> buildPlatform(BuildRequest request) {
  final target = request.target;
  const config = BuildConfig.release;
  final outDir = p.join(request.rootDir, config.outputDir, target.platformDir);
  return withArtifactTransaction(
    rootDir: request.rootDir,
    key: target.isLib
        ? '${target.platformDir}-${target.abi}'
        : target.platformDir,
    outputs: target.isLib
        ? _androidOutputs(request.rootDir, config, target, outDir)
        : [
            p.join(outDir, '${config.coreName}${target.executableExtension}'),
            if (target.hasHelper) ...[
              p.join(
                outDir,
                '${config.helperName}${target.executableExtension}',
              ),
              p.join(outDir, coreManifestName),
            ],
          ],
    build: () => _buildPlatform(request),
  );
}

List<String> _androidOutputs(
  String rootDir,
  BuildConfig config,
  Target target,
  String outDir,
) {
  final abi = target.abi!;
  final coreDir = Directory(p.join(rootDir, config.coreDir));
  final headerNames = <String>{'${config.libName}.h'};
  final includes = [
    p.join(outDir, 'includes', abi),
    p.join(rootDir, 'android', 'core', 'src', 'main', 'cpp', 'includes', abi),
  ];
  for (final dir in [coreDir, ...includes.map(Directory.new)]) {
    if (!dir.existsSync()) continue;
    for (final file in dir.listSync().whereType<File>()) {
      if (file.path.endsWith('.h')) headerNames.add(p.basename(file.path));
    }
  }
  return [
    p.join(outDir, abi, '${config.libName}.so'),
    p.join(
      rootDir,
      'android',
      'core',
      'src',
      'main',
      'jniLibs',
      abi,
      '${config.libName}.so',
    ),
    for (final include in includes)
      for (final name in headerNames) p.join(include, name),
  ];
}

Future<BuildReport> _buildPlatform(BuildRequest request) async {
  final stopwatch = Stopwatch()..start();
  final target = request.target;
  if (target.isLib && request.androidToolchain == null) {
    throw BuildException('Android target $target needs an NDK toolchain');
  }
  final rootDir = request.rootDir;
  final secrets = CoreBuildSecrets.load(
    rootDir: rootDir,
    requireSecrets: request.requireSecrets,
  );
  final config = BuildConfig.release.withCoreSecrets(secrets.ldflags);
  final cache = BuildCache(rootDir: rootDir);
  final notice = BuildNotice();
  final harnessInputs = <String>[
    secrets.path,
    p.join(rootDir, 'pubspec.yaml'),
    ...switch (request.harnessDir) {
      null => const <String>[],
      final dir => collectPackageInputs(dir),
    },
  ];

  final core = await GoBuilder(
    rootDir: rootDir,
    config: config,
    cache: cache,
    notice: notice,
    harnessInputs: harnessInputs,
    androidToolchain: request.androidToolchain,
  ).build(target);
  if (!target.hasHelper) {
    _log.info('Done in ${stopwatch.elapsed}: ${core.primaryOutput}');
    return _report([core], sourceRoot: p.join(rootDir, config.coreDir));
  }

  final coreSha256 = await calcSha256(core.primaryOutput);
  final helper = !request.includeHelper
      ? null
      : await RustBuilder(
          rootDir: rootDir,
          config: config,
          cache: cache,
          notice: notice,
          harnessInputs: harnessInputs,
        ).build(target, coreSha256);
  final manifestPath = p.join(
    rootDir,
    config.outputDir,
    target.platformDir,
    coreManifestName,
  );
  writeCoreManifest(path: manifestPath, coreSha256: coreSha256);

  _log.info(
    'Done in ${stopwatch.elapsed}: ${core.primaryOutput}, '
    '${helper?.primaryOutput ?? "Core only"}',
  );
  return _report(
    [core, ?helper],
    extraOutputs: [manifestPath],
    sourceRoot: p.join(rootDir, config.coreDir),
  );
}

BuildReport _report(
  List<BuildExecution> results, {
  List<String> extraOutputs = const [],
  required String sourceRoot,
}) {
  final inputs = <String>{};
  final outputs = <String>{};
  for (final result in results) {
    inputs.addAll(result.inputs);
    outputs.addAll(result.outputs);
  }
  outputs.addAll(extraOutputs);
  // New source files must invalidate the Flutter hook cache too, before the
  // toolchain fingerprint has a chance to discover them.
  // Flutter 3.44 recursively stats directory dependencies. Keep the repository
  // and .dart_tool roots out: build folders contain framework symlinks.
  inputs.addAll(
    inputs
        .map(p.dirname)
        .where(
          (dir) => p.equals(dir, sourceRoot) || p.isWithin(sourceRoot, dir),
        )
        .toList(),
  );
  return BuildReport(
    inputs: inputs.toList()..sort(),
    outputs: outputs.toList()..sort(),
    rebuilt: results.any((result) => result.rebuilt),
  );
}

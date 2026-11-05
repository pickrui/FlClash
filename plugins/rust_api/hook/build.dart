import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:flutter_rust_bridge_hooks/flutter_rust_bridge_hooks.dart';

void main(List<String> args) async {
  await build(args, (input, output) async {
    if (input.userDefines['build_assets'] == false) {
      stdout.writeln('Skipping the Rust build: user-define build_assets=false');
      return;
    }
    if (!input.config.buildCodeAssets) return;
    final rustDirectory = Directory.fromUri(input.packageRoot.resolve('rust/'));
    // A Homebrew rustc may precede rustup shims in PATH even under `rustup run`.
    // Select the compiler belonging to the pinned toolchain, including its std targets.
    await _rustup(['show', 'active-toolchain'], rustDirectory.path);
    final rustc = await _rustup(['which', 'rustc'], rustDirectory.path);
    await FlutterRustBridgeNativeAssetsBuilder(
      cratePath: 'rust',
      extraCargoBuildArgs: const ['--locked'],
      extraCargoEnvironmentVariables: {
        'RUSTC': rustc,
        ...bindgenEnvironment(
          isAndroid: input.config.code.targetOS == OS.android,
          compiler: input.config.code.cCompiler?.compiler,
          libclangPath: Platform.environment['LIBCLANG_PATH'],
        ),
        if (input.config.code.targetOS == OS.macOS)
          'MACOSX_DEPLOYMENT_TARGET': '12.0',
      },
    ).run(input: input, output: output);
  });
}

// Bindgen is a host tool. Prefer an explicitly configured host libclang, then
// the NDK copy when present. Some Linux NDK distributions omit it entirely;
// leave discovery to clang-sys so the installed host libclang can be used.
Map<String, String> bindgenEnvironment({
  required bool isAndroid,
  Uri? compiler,
  String? libclangPath,
}) {
  if (!isAndroid) return const {};
  if (libclangPath != null && libclangPath.isNotEmpty) {
    return {'LIBCLANG_PATH': libclangPath};
  }
  if (compiler == null) return const {};
  final llvmRoot = File.fromUri(compiler).parent.parent;
  for (final name in const ['lib', 'lib64']) {
    final directory = Directory(
      '${llvmRoot.path}${Platform.pathSeparator}$name',
    );
    if (directory.existsSync() && directory.listSync().any(_isLibclang)) {
      return {'LIBCLANG_PATH': directory.path};
    }
  }
  return const {};
}

bool _isLibclang(FileSystemEntity entity) {
  return entity.path.split(Platform.pathSeparator).last.startsWith('libclang.');
}

Future<String> _rustup(List<String> arguments, String directory) async {
  final result = await Process.run(
    'rustup',
    arguments,
    workingDirectory: directory,
  );
  if (result.exitCode != 0) {
    throw ProcessException(
      'rustup',
      arguments,
      result.stderr.toString(),
      result.exitCode,
    );
  }
  return result.stdout.toString().trim();
}

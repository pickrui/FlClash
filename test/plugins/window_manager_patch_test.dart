import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

void main() {
  late Directory temporaryDirectory;
  late String executable;

  Future<ProcessResult> run(String command, List<String> arguments) async {
    final result = await Process.run(command, arguments);
    expect(
      result.exitCode,
      0,
      reason:
          '$command ${arguments.join(' ')}\n'
          '${result.stdout}\n${result.stderr}',
    );
    return result;
  }

  setUpAll(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'flclash_window_manager_',
    );
    addTearDown(() => temporaryDirectory.delete(recursive: true));

    final packageConfig = File('.dart_tool/package_config.json').absolute;
    final config =
        jsonDecode(await packageConfig.readAsString()) as Map<String, dynamic>;
    final packages = (config['packages'] as List).cast<Map<String, dynamic>>();
    final package = packages.singleWhere(
      (entry) => entry['name'] == 'window_manager',
    );
    final pluginDirectory = Directory.fromUri(
      packageConfig.uri.resolve(package['rootUri'] as String),
    ).uri.resolve('windows/').toFilePath();
    final patchedDirectory = '${temporaryDirectory.path}/patched';
    await run('cmake', [
      '-DWINDOW_MANAGER_SOURCE_DIR=$pluginDirectory',
      '-DWINDOW_MANAGER_PATCH_DIR=$patchedDirectory',
      '-P',
      File('windows/window_manager_patch.cmake').absolute.path,
    ]);

    final source = await File(
      '$patchedDirectory/window_manager.cpp',
    ).readAsString();
    final methods = <String>[];
    for (final name in [
      'WaitUntilReadyToShow',
      'SetSkipTaskbar',
      'SetProgressBar',
    ]) {
      final method = RegExp(
        '^void WindowManager::$name\\([^;{]*\\) \\{.*?\n\\}',
        dotAll: true,
        multiLine: true,
      ).allMatches(source).toList();
      expect(method, hasLength(1), reason: 'Expected one $name definition');
      methods.add(method.single.group(0)!);
    }
    await File(
      '${temporaryDirectory.path}/window_manager_methods.inc',
    ).writeAsString(methods.join('\n\n'));

    final fixture = File(
      'test/support/window_manager_taskbar_test.cpp',
    ).absolute.path.replaceAll('\\', '/');
    await File('${temporaryDirectory.path}/CMakeLists.txt').writeAsString('''
cmake_minimum_required(VERSION 3.15)
project(window_manager_taskbar_test LANGUAGES CXX)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "\${CMAKE_BINARY_DIR}/bin")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG "\${CMAKE_BINARY_DIR}/bin")
add_executable(taskbar_test "$fixture")
target_compile_features(taskbar_test PRIVATE cxx_std_17)
target_include_directories(taskbar_test PRIVATE "\${CMAKE_CURRENT_SOURCE_DIR}")
''');
    final buildDirectory = '${temporaryDirectory.path}/build';
    await run('cmake', [
      '-S',
      temporaryDirectory.path,
      '-B',
      buildDirectory,
      '-DCMAKE_BUILD_TYPE=Debug',
    ]);
    await run('cmake', ['--build', buildDirectory, '--config', 'Debug']);
    executable =
        '$buildDirectory/bin/taskbar_test'
        '${Platform.isWindows ? '.exe' : ''}';
  });

  for (final scenario in [
    'creation_failure',
    'null_interface',
    'initialization_failure',
    'retry_after_failure',
    'early_visibility',
    'early_progress',
    'repeated_initialization',
  ]) {
    test('Windows taskbar: $scenario', () async {
      await run(executable, [scenario]);
    });
  }
}

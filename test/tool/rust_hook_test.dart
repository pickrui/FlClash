import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

import '../../plugins/rust_api/hook/build.dart' as hook;

void main() {
  late Directory ndk;
  late Uri compiler;

  setUp(() {
    ndk = Directory.systemTemp.createTempSync('flclash-ndk-fixture-');
    compiler = File(p.join(ndk.path, 'bin', 'clang')).uri;
  });
  tearDown(() => ndk.deleteSync(recursive: true));

  for (final entry in [
    ('lib', 'libclang.dylib'),
    ('lib64', 'libclang.so.18'),
  ]) {
    test('uses bundled libclang from ${entry.$1}', () {
      final library = File(p.join(ndk.path, entry.$1, entry.$2));
      library.parent.createSync(recursive: true);
      library.writeAsStringSync('host library fixture');
      expect(hook.bindgenEnvironment(isAndroid: true, compiler: compiler), {
        'LIBCLANG_PATH': library.parent.path,
      });
    });
  }

  test('a Linux NDK without libclang allows system library discovery', () {
    final runtime = File(p.join(ndk.path, 'lib', 'libclang_rt.builtins.a'));
    runtime.parent.createSync(recursive: true);
    runtime.writeAsStringSync('not the bindgen host library');
    expect(
      hook.bindgenEnvironment(isAndroid: true, compiler: compiler),
      isEmpty,
    );
  });

  test('an explicit host library takes precedence over the NDK copy', () {
    final library = File(p.join(ndk.path, 'lib', 'libclang.so'));
    library.parent.createSync(recursive: true);
    library.writeAsStringSync('NDK fixture');
    expect(
      hook.bindgenEnvironment(
        isAndroid: true,
        compiler: compiler,
        libclangPath: p.join(ndk.path, 'custom-llvm'),
      ),
      {'LIBCLANG_PATH': p.join(ndk.path, 'custom-llvm')},
    );
  });

  test('desktop builds retain their existing bindgen environment', () {
    expect(
      hook.bindgenEnvironment(
        isAndroid: false,
        compiler: compiler,
        libclangPath: 'unused',
      ),
      isEmpty,
    );
  });
}

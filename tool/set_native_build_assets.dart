import 'dart:io';

/// Unit-test jobs build their native fixtures explicitly. Release packaging
/// rejects disabled hooks, so the switch cannot produce a partial package.
void main(List<String> args) {
  if (args.isEmpty ||
      args.length > 2 ||
      !['true', 'false'].contains(args.first) ||
      (args.length == 2 && !['setup', 'rust_api'].contains(args[1]))) {
    stderr.writeln(
      'Usage: dart tool/set_native_build_assets.dart true|false [setup|rust_api]',
    );
    exitCode = 64;
    return;
  }
  final file = File('pubspec.yaml');
  final source = file.readAsStringSync();
  file.writeAsStringSync(
    configureBuildAssets(
      source,
      args.first == 'true',
      package: args.length == 2 ? args[1] : null,
    ),
  );
}

String configureBuildAssets(String source, bool enabled, {String? package}) {
  final pattern = RegExp(
    r'^(    (?:setup|rust_api):\r?\n      build_assets: )(true|false)(\r?)$',
    multiLine: true,
  );
  if (pattern.allMatches(source).length != 2) {
    throw StateError(
      'Expected exactly two native build switches in pubspec.yaml',
    );
  }
  return source.replaceAllMapped(
    pattern,
    (match) => package == null || match[1]!.trimLeft().startsWith('$package:')
        ? '${match[1]}$enabled${match[3]}'
        : match[0]!,
  );
}

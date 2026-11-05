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
  final pattern = RegExp(
    r'^(    (?:setup|rust_api):\r?\n      build_assets: )(true|false)$',
    multiLine: true,
  );
  if (pattern.allMatches(source).length != 2) {
    throw StateError(
      'Expected exactly two native build switches in pubspec.yaml',
    );
  }
  file.writeAsStringSync(
    source.replaceAllMapped(
      pattern,
      (match) =>
          args.length == 1 || match[1]!.trimLeft().startsWith('${args[1]}:')
          ? '${match[1]}${args.first}'
          : match[0]!,
    ),
  );
}

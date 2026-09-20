import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'lint_sources.dart';

const _entryPoints = ['lib/main.dart'];

/// Top level names a file publishes: types, `final appPath = AppPath()`
/// singletons and `CoreLib? get coreLib` accessors, anchored at column zero.
final _declarations = [
  RegExp(
    r'^(?:abstract |sealed |final |base |mixin )*(?:class|enum|mixin)\s+'
    r'([A-Za-z]\w*)',
    multiLine: true,
  ),
  RegExp(
    r'^(?:final|const)[ \t]+(?:[\w<>,\[\]? \t]+[ \t]+)?([a-z]\w*)[ \t]*=',
    multiLine: true,
  ),
  RegExp(
    r'^[A-Za-z_][\w<>?,\[\] \t]*[ \t]+get[ \t]+([a-z]\w*)',
    multiLine: true,
  ),
];

bool _isBarrel(String source) {
  final lines = source
      .split('\n')
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty && !line.startsWith('//'));
  return lines.isNotEmpty &&
      lines.every(
        (line) => line.startsWith('export ') || line.startsWith('import '),
      );
}

String _relative(File file) => p.relative(file.path).replaceAll(r'\', '/');

void main() {
  test('every file under lib declares something used outside itself', () {
    // Generated code consumes but never declares.
    final consumers = {
      for (final file in dartFiles(includeGenerated: true))
        _relative(file): file.readAsStringSync(),
    };
    final sources = {
      for (final file in dartFiles(includeGenerated: false))
        _relative(file): consumers[_relative(file)]!,
    };
    final barrels = {
      for (final MapEntry(key: path, value: source) in sources.entries)
        if (_isBarrel(source)) path,
    };

    final orphans = <String>[];

    for (final MapEntry(key: path, value: source) in sources.entries) {
      if (!path.startsWith('lib/')) continue;
      if (barrels.contains(path) || _entryPoints.contains(path)) continue;
      if (path.startsWith('lib/l10n/')) continue;

      // Extensions, typedefs and functions are reached by unmeasurable names.
      final names = {
        for (final declaration in _declarations)
          ...declaration.allMatches(source).map((match) => match.group(1)!),
      };
      if (names.isEmpty) continue;

      final fileName = p.basename(path);
      final directive = RegExp('''['"][^'"]*${RegExp.escape(fileName)}['"]''');

      final used = consumers.entries.any((entry) {
        if (entry.key == path || barrels.contains(entry.key)) return false;
        if (directive.hasMatch(entry.value)) return true;
        return names.any((name) => RegExp('\\b$name\\b').hasMatch(entry.value));
      });

      if (!used) {
        orphans.add(
          '$path — publishes ${names.join(', ')}, none of which is referenced '
          'anywhere else. A barrel export keeps it compiling; it is still dead.',
        );
      }
    }

    expect(orphans, isEmpty, reason: orphans.join('\n'));
  });
}

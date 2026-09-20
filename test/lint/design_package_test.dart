import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'lint_sources.dart';

const _forbiddenImports = <String, String>{
  'package:cupertino_ui/':
      'the app is Material only; take widgets-layer types from '
      'package:flutter/widgets.dart instead',
  'package:flutter/material.dart':
      'Material comes from package:material_ui/material_ui.dart',
  'package:flutter/cupertino.dart':
      'the app is Material only; take widgets-layer types from '
      'package:flutter/widgets.dart instead',
};

void main() {
  test('material_ui is the only design library the project imports', () {
    final offenders = <String>[];

    for (final file in dartFiles(includeGenerated: false)) {
      final relative = p.relative(file.path);
      final lines = file.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        final line = lines[i].trimLeft();
        if (!line.startsWith('import ') && !line.startsWith('export ')) {
          continue;
        }
        for (final entry in _forbiddenImports.entries) {
          if (line.contains("'${entry.key}") || line.contains('"${entry.key}')) {
            offenders.add('$relative:${i + 1} — ${entry.value}');
          }
        }
      }
    }

    expect(offenders, isEmpty, reason: offenders.join('\n'));
  });
}

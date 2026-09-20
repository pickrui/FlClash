import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

const _tagFile = 'tool/go_build_tags.env';
const _harnessDefaults = 'plugins/setup/setup_hooks/lib/src/options.dart';

String _sharedTags() {
  final line = File(_tagFile).readAsLinesSync().firstWhere(
    (line) => line.startsWith('GO_TAGS='),
    orElse: () => '',
  );
  expect(line, isNotEmpty, reason: '$_tagFile must define GO_TAGS');
  return line.substring('GO_TAGS='.length).trim();
}

Iterable<File> _tagConsumers() sync* {
  yield File('Makefile');
  for (final directory in ['.github/workflows', 'tool']) {
    for (final entity in Directory(directory).listSync()) {
      if (entity is File &&
          (entity.path.endsWith('.yaml') || entity.path.endsWith('.sh'))) {
        yield entity;
      }
    }
  }
}

void main() {
  test('the packaging harness ships the shared release build tags', () {
    final tags = _sharedTags();
    final defaults = RegExp(
      r"tags: '([^']*)'",
    ).firstMatch(File(_harnessDefaults).readAsStringSync());
    expect(defaults, isNotNull, reason: '$_harnessDefaults lost its tag list');
    expect(
      defaults!.group(1),
      tags,
      reason:
          'BuildConfig defaults and $_tagFile must name the same build tags; '
          'CI would otherwise validate a binary the release never ships',
    );
  });

  test('build tooling takes the release build tags from one file', () {
    final tags = _sharedTags();
    final offenders = <String>[];
    for (final file in _tagConsumers()) {
      final relative = p.relative(file.path).replaceAll(r'\', '/');
      final lines = file.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        if (!lines[i].contains(tags)) continue;
        offenders.add(
          '$relative:${i + 1} — spell the release tags "\$GO_TAGS" and load '
          'them from $_tagFile',
        );
      }
    }

    expect(offenders, isEmpty, reason: offenders.join('\n'));
  });
}

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

const _disposableTypes = {
  'AnimationController',
  'FocusNode',
  'PageController',
  'ScrollController',
  'StreamController',
  'TabController',
  'TextEditingController',
  'ValueNotifier',
};

/// Fields deliberately never released, keyed by `<path>#<field>`.
const _allowed = {
  // Fans core events out for the whole run; closing it ends event delivery.
  'lib/core/event.dart#_controller',
  // The platform-channel singleton broadcasts these until the app exits.
  'lib/plugins/app.dart#_packageChanges',
  'lib/plugins/app.dart#_iconChanges',
};

final _declaration = RegExp(
  r'^\s+(?:late\s+)?final\s+(?:[A-Za-z][\w<>,\s?]*\s+)?(_?[A-Za-z]\w*)\s*=\s*'
  r'(?:[A-Za-z]\w*)?'
  '(${_disposableTypes.join('|')})'
  r'\b',
);

/// A `late` field built in `initState`, owned just the same.
final _lateDeclaration = RegExp(
  '^\\s+late\\s+(?:final\\s+)?(${_disposableTypes.join('|')})'
  r'(?:<[\w<>,\s?]*>)?\??\s+(_?[A-Za-z]\w*)\s*;',
);

bool _isGenerated(String path) {
  return path.contains('/generated/') ||
      path.endsWith('.g.dart') ||
      path.endsWith('.freezed.dart');
}

/// A tear-off counts: `ref.onDispose(notice.dispose)` releases it too.
bool _isReleased(String source, String field) {
  return RegExp('\\b${RegExp.escape(field)}\\.(?:dispose|close)\\b')
      .hasMatch(source);
}

void main() {
  test('every self-created disposable field is released in the same file', () {
    final root = Directory('lib');
    final offenders = <String>[];

    for (final entity in root.listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) {
        continue;
      }
      final relative = p.relative(entity.path).replaceAll(r'\', '/');
      if (_isGenerated(relative)) {
        continue;
      }
      final source = entity.readAsStringSync();
      final lines = source.split('\n');
      for (var i = 0; i < lines.length; i++) {
        final match = _declaration.firstMatch(lines[i]);
        final lateMatch = match == null
            ? _lateDeclaration.firstMatch(lines[i])
            : null;
        if (match == null && lateMatch == null) {
          continue;
        }
        final field = match?.group(1) ?? lateMatch!.group(2)!;
        final type = match?.group(2) ?? lateMatch!.group(1)!;
        if (_allowed.contains('$relative#$field')) {
          continue;
        }
        if (_isReleased(source, field)) {
          continue;
        }
        offenders.add('$relative:${i + 1} $field ($type)');
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'These fields are constructed by their owner but never disposed or '
          'closed. Release them in `dispose()`, or add the declaration to '
          '`_allowed` with the reason it outlives its owner.\n'
          '${offenders.join('\n')}',
    );
  });

  test('the allow list has no stale entries', () {
    for (final entry in _allowed) {
      final parts = entry.split('#');
      final file = File(parts.first);
      expect(
        file.existsSync(),
        isTrue,
        reason: '$entry names a file that no longer exists',
      );
      expect(
        file.readAsStringSync(),
        contains(parts.last),
        reason: '$entry names a field that no longer exists',
      );
    }
  });
}

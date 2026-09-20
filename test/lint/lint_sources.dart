import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

/// Every first-party root a lint test walks. `plugins/flutter_distributor` is
/// a vendored submodule with its own conventions and stays out of all of them.
const lintRoots = ['lib', 'test', 'tool', 'plugins'];

const _vendoredRoots = ['plugins/flutter_distributor'];

const _generatedL10n = ['lib/l10n/l10n.dart', 'lib/l10n/intl/'];

bool isGenerated(String relativePath) {
  return relativePath.contains('/generated/') ||
      relativePath.endsWith('.g.dart') ||
      relativePath.endsWith('.freezed.dart') ||
      _generatedL10n.any(relativePath.startsWith);
}

bool isVendored(String relativePath) {
  return _vendoredRoots.any(
    (root) => relativePath == root || relativePath.startsWith('$root/'),
  );
}

Iterable<File> dartFiles({required bool includeGenerated}) sync* {
  for (final root in lintRoots) {
    final directory = Directory(root);
    if (!directory.existsSync()) {
      fail('$root no longer exists; update lintRoots.');
    }
    for (final entity in directory.listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      final relative = p.relative(entity.path).replaceAll(r'\', '/');
      if (isVendored(relative)) continue;
      if (!includeGenerated && isGenerated(relative)) continue;
      yield entity;
    }
  }
}

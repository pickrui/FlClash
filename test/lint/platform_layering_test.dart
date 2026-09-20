import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

/// What `lib/common/common.dart` pulls in today, as a ratchet rather than an
/// endorsement: `common/navigation.dart` and `enum/enum.dart` name widgets, so
/// the barrel carries the view tree. Upstream binds those through ports
/// instead (`common/app_ports.dart`).
const _closureBudget = 292;
const _viewsInClosureBudget = 50;

final _directive = RegExp(
  r'''^\s*(?:import|export|part)\s+['"]([^'"]+)['"]''',
  multiLine: true,
);

String _resolve(String uri, String from) {
  if (uri.startsWith('package:fl_clash/')) {
    return 'lib/${uri.substring('package:fl_clash/'.length)}';
  }
  if (uri.startsWith('dart:') || uri.startsWith('package:')) return uri;
  return p.normalize(p.join(p.dirname(from), uri)).replaceAll(r'\', '/');
}

Set<String> _closureOfCommonBarrel() {
  final reached = <String>{'lib/common/common.dart'};
  final queue = <String>[...reached];

  while (queue.isNotEmpty) {
    final current = queue.removeLast();
    final file = File(current);
    if (!file.existsSync()) continue;
    for (final match in _directive.allMatches(file.readAsStringSync())) {
      final next = _resolve(match.group(1)!, current);
      if (!reached.add(next)) continue;
      queue.add(next);
    }
  }

  return reached;
}

void main() {
  test('common never depends on the manager barrel', () {
    final offenders = <String>[];

    for (final entity in Directory('lib/common').listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      if (entity.readAsStringSync().contains(
        "import 'package:fl_clash/manager/manager.dart';",
      )) {
        offenders.add(
          '${p.relative(entity.path)} — import the one manager it needs, not '
          'the barrel that reaches every platform manager',
        );
      }
    }

    expect(offenders, isEmpty, reason: offenders.join('\n'));
  });

  test('the common barrel does not reach further than it does today', () {
    final reached = _closureOfCommonBarrel();
    final libFiles = reached.where((uri) => uri.startsWith('lib/')).toList();
    final views = reached.where((uri) => uri.startsWith('lib/views/')).toList()
      ..sort();

    expect(
      libFiles.length,
      lessThanOrEqualTo(_closureBudget),
      reason:
          'Importing the common barrel for a string helper now compiles '
          '${libFiles.length} files. Pass what the lower layer needs through a '
          'port the UI binds, the way upstream does in common/app_ports.dart, '
          'or lower _closureBudget once it shrinks.',
    );
    expect(
      views.length,
      lessThanOrEqualTo(_viewsInClosureBudget),
      reason:
          'The common barrel now reaches ${views.length} view files:\n'
          '${views.join('\n')}',
    );
  });
}

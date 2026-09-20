import 'dart:convert';
import 'dart:io';

import 'package:fl_clash/common/navigation.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

const _arbDir = 'arb';
const _referenceArb = 'intl_en.arb';

/// `Intl.message(<runtime string>)` looks the text up as the key and returns it
/// unchanged when the lookup fails, so a key that exists in no .arb ships to
/// the UI verbatim. Every family of keys the app builds at runtime is listed
/// here, and the prefix guard below fails when a new one appears.
Set<String> _runtimeKeys() => {
  for (final mode in Mode.values) mode.name,
  for (final type in ProxiesType.values) type.name,
  for (final type in ProxyCardType.values) type.name,
  for (final label in PageLabel.values) label.name,
  for (final action in HotAction.values) 'action_${action.name}',
  for (final strategy in RestoreStrategy.values)
    'restoreStrategy_${strategy.name}',
  for (final mode in RouteMode.values) 'routeMode_${mode.name}',
  for (final locale in AppLocalizations.delegate.supportedLocales)
    locale.toString(),
  for (final item in Navigation().getItems(openLogs: true, hasProxies: true))
    if (item.description != null) item.description!,
};

const _coveredPrefixes = {'action_', 'restoreStrategy_', 'routeMode_'};

Map<String, Set<String>> _arbKeys() {
  final result = <String, Set<String>>{};
  for (final entity in Directory(_arbDir).listSync()) {
    if (entity is! File || !entity.path.endsWith('.arb')) continue;
    final decoded =
        jsonDecode(entity.readAsStringSync()) as Map<String, Object?>;
    result[entity.uri.pathSegments.last] = decoded.keys
        .where((key) => !key.startsWith('@'))
        .toSet();
  }
  return result;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('every locale carries the same keys', () {
    final byFile = _arbKeys();
    expect(byFile, isNotEmpty, reason: 'no .arb files were read from $_arbDir');

    final reference = byFile[_referenceArb];
    expect(reference, isNotNull, reason: '$_arbDir/$_referenceArb is the reference');

    for (final entry in byFile.entries) {
      expect(
        entry.value,
        reference,
        reason:
            '${entry.key} does not carry the same keys as $_referenceArb. A '
            'key present in only one locale renders as the raw key elsewhere.',
      );
    }
  });

  test('every key the app builds at runtime exists in every locale', () {
    final byFile = _arbKeys();
    final missing = <String>[];

    for (final entry in byFile.entries) {
      for (final key in _runtimeKeys()) {
        if (!entry.value.contains(key)) {
          missing.add('${entry.key} has no "$key"');
        }
      }
    }

    expect(
      missing,
      isEmpty,
      reason:
          'Intl.message() falls back to its argument, so each of these renders '
          'as the raw key:\n${missing.join('\n')}',
    );
  });

  test('no Intl.message call builds a key this test does not cover', () {
    final interpolated = RegExp(r"""Intl\.message\(\s*'([A-Za-z_]+)\$\{""");
    final uncovered = <String>[];

    for (final entity in Directory('lib').listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      final path = entity.path.replaceAll(r'\', '/');
      if (path.contains('/generated/') || path.contains('/l10n/')) continue;
      for (final match in interpolated.allMatches(entity.readAsStringSync())) {
        final prefix = match.group(1)!;
        if (_coveredPrefixes.contains(prefix)) continue;
        uncovered.add('$path builds "$prefix…" keys');
      }
    }

    expect(
      uncovered,
      isEmpty,
      reason:
          'Add the family to _runtimeKeys and _coveredPrefixes so a missing '
          'translation fails here instead of in the UI:\n'
          '${uncovered.join('\n')}',
    );
  });
}

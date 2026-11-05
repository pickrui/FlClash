import 'dart:convert';

import 'package:fl_clash/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('DNS fallback query policy', () {
    test('defaults to parallel queries', () {
      expect(const Dns().toJson()['fallback-lazy-query'], false);
    });

    for (final lazy in [false, true]) {
      test('preserves explicit fallback-lazy-query=$lazy', () {
        final config = ClashConfig.fromJson({
          'dns': {'fallback-lazy-query': lazy},
        });
        final saved = jsonDecode(jsonEncode(config)) as Map<String, dynamic>;
        expect(saved['dns']['fallback-lazy-query'], lazy);
        final restored = ClashConfig.fromJson(saved);
        expect(restored.dns.toJson()['fallback-lazy-query'], lazy);
      });
    }
  });

  group('ParsedRule round-trip', () {
    for (final value in [
      'MATCH,Proxy',
      'DOMAIN,example.com,DIRECT',
      'RULE-SET,provider,Proxy,no-resolve',
    ]) {
      test(value, () {
        expect(ParsedRule.parseString(value).value, value);
      });
    }

    test('handles empty and incomplete rules', () {
      expect(ParsedRule.parseString('').value, 'DOMAIN');
      expect(ParsedRule.parseString('src').value, 'DOMAIN');
      expect(ParsedRule.parseString('DOMAIN').value, 'DOMAIN');
      expect(
        ParsedRule.parseString('RULE-SET,provider').value,
        'RULE-SET,provider',
      );
    });
  });
}

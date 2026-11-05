import 'dart:convert';

import 'package:fl_clash/database/database.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('StringMapConverter', () {
    const converter = StringMapConverter();

    test('roundtrip encodes and decodes correctly', () {
      final original = {'key1': 'value1', 'key2': 'value2'};
      final encoded = converter.toSql(original);
      final decoded = converter.fromSql(encoded);
      expect(decoded, original);
    });

    test('handles empty map', () {
      final encoded = converter.toSql({});
      final decoded = converter.fromSql(encoded);
      expect(decoded, isEmpty);
    });

    test('handles special characters in values', () {
      final original = {'key': 'value with "quotes" and \\backslash'};
      final encoded = converter.toSql(original);
      final decoded = converter.fromSql(encoded);
      expect(decoded, original);
    });

    test('produces valid JSON string', () {
      final encoded = converter.toSql({'a': 'b'});
      expect(() => json.decode(encoded), returnsNormally);
    });
  });

  group('StringListConverter', () {
    const converter = StringListConverter();

    test('roundtrip encodes and decodes correctly', () {
      final original = ['a', 'b', 'c'];
      final encoded = converter.toSql(original);
      final decoded = converter.fromSql(encoded);
      expect(decoded, original);
    });

    test('handles empty list', () {
      final encoded = converter.toSql([]);
      final decoded = converter.fromSql(encoded);
      expect(decoded, isEmpty);
    });

    test('handles list with duplicates', () {
      final original = ['a', 'a', 'b'];
      final encoded = converter.toSql(original);
      final decoded = converter.fromSql(encoded);
      expect(decoded, original);
    });
  });

  group('StringSetConverter', () {
    const converter = StringSetConverter();

    test('roundtrip encodes and decodes correctly', () {
      final original = {'x', 'y', 'z'};
      final encoded = converter.toSql(original);
      final decoded = converter.fromSql(encoded);
      expect(decoded, original);
    });

    test('handles empty set', () {
      final encoded = converter.toSql(<String>{});
      final decoded = converter.fromSql(encoded);
      expect(decoded, isEmpty);
    });

    test('deduplicates on decode', () {
      final encoded = json.encode(['a', 'a', 'b']);
      final decoded = converter.fromSql(encoded);
      expect(decoded.length, 2);
      expect(decoded, containsAll(['a', 'b']));
    });
  });

  group('custom overwrite converters', () {
    test('ProxyGroupListConverter preserves canonical group data', () {
      const converter = ProxyGroupListConverter();
      const groups = [
        ProxyGroup(
          name: 'Auto',
          type: GroupType.URLTest,
          proxies: ['Proxy A'],
          interval: 300,
          tolerance: 50,
          lazy: true,
          disableUdp: true,
          url: 'https://example.com/generate_204',
          excludeFilter: 'Blocked',
          includeAllProviders: true,
          strategy: 'round-robin',
        ),
      ];

      final encoded = converter.toSql(groups);
      final decoded = converter.fromSql(encoded);

      expect(json.decode(encoded)[0]['type'], 'url-test');
      expect(json.decode(encoded)[0]['tolerance'], 50);
      expect(json.decode(encoded)[0]['disable-udp'], true);
      expect(json.decode(encoded)[0]['exclude-filter'], 'Blocked');
      expect(json.decode(encoded)[0]['include-all-providers'], true);
      expect(json.decode(encoded)[0]['strategy'], 'round-robin');
      expect(decoded, groups);
    });

    test('ProxyGroup accepts mihomo weakly typed values', () {
      final group = ProxyGroup.fromJson({
        'name': 'Weak',
        'type': 'select',
        'proxies': ['Proxy', 123],
        'lazy': 1,
        'disable-udp': 0,
      });

      expect(group.proxies, ['Proxy', '123']);
      expect(group.lazy, true);
      expect(group.disableUdp, false);
    });

    test('RuleListConverter preserves rule values and order', () {
      const converter = RuleListConverter();
      const rules = [
        Rule(id: 1, value: 'DOMAIN,example.com,DIRECT', order: 'a0'),
      ];

      expect(converter.fromSql(converter.toSql(rules)), rules);
    });
  });
}

import 'dart:convert';

import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('TUN stack configuration', () {
    test('keeps mixed as the default for existing configurations', () {
      expect(const Tun().stack, TunStack.mixed);
      expect(ClashConfig.fromJson({}).tun.stack, TunStack.mixed);
      expect(
        ClashConfig.fromJson(jsonDecode('{"tun":{}}')).tun.stack,
        TunStack.mixed,
      );
    });

    for (final stack in TunStack.values) {
      test(
        'preserves ${stack.name} and its TUN settings across persistence',
        () {
          final source = {
            'enable': true,
            'device': 'test-tun',
            'auto-route': true,
            'stack': stack.name,
            'dns-hijack': ['any:53'],
            'route-address': ['0.0.0.0/0'],
            'mtu': 1480,
          };
          final config = ClashConfig.fromJson({'tun': source});
          final saved = jsonDecode(jsonEncode(config)) as Map<String, dynamic>;
          expect(saved['tun'], source);
          expect(config.tun.stack, stack);
          expect(ClashConfig.fromJson(saved).tun, config.tun);
        },
      );
    }
  });

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

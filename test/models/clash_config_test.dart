import 'package:fl_clash/models/models.dart';
import 'package:test/test.dart';

void main() {
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

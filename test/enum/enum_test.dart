import 'package:fl_clash/enum/enum.dart';
import 'package:test/test.dart';

void main() {
  group('GroupType.parseProfileType', () {
    test('parses canonical profile values', () {
      expect(GroupType.parseProfileType('select'), GroupType.Selector);
      expect(GroupType.parseProfileType('url-test'), GroupType.URLTest);
      expect(GroupType.parseProfileType('fallback'), GroupType.Fallback);
      expect(GroupType.parseProfileType('load-balance'), GroupType.LoadBalance);
      expect(GroupType.parseProfileType('relay'), GroupType.Relay);
    });

    test('parses aliases and case variants', () {
      expect(GroupType.parseProfileType('Selector'), GroupType.Selector);
      expect(GroupType.parseProfileType('URLTEST'), GroupType.URLTest);
      expect(
        GroupType.parseProfileType(' loadBalance '),
        GroupType.LoadBalance,
      );
    });

    test('rejects unsupported values', () {
      expect(
        () => GroupType.parseProfileType('unknown'),
        throwsA(isA<UnimplementedError>()),
      );
    });
  });
}

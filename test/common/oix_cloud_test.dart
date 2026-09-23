import 'package:fl_clash/common/oix_cloud.dart';
import 'package:fl_clash/common/secrets.dart';
import 'package:test/test.dart';

void main() {
  group('isoixCloudProfileUrl', () {
    test('accepts the managed URL and any oixcloud scheme', () {
      expect(isoixCloudProfileUrl(oixCloudManagedProfileUrl), isTrue);
      expect(isoixCloudProfileUrl('  OIXCLOUD://Managed '), isTrue);
      expect(isoixCloudProfileUrl('oixcloud://profile/42'), isTrue);
    });

    test('accepts every configured cloud domain', () {
      for (final domain in Secrets.cloudDomains) {
        expect(isoixCloudProfileUrl('https://$domain/sub?token=1'), isTrue);
      }
    });

    test('rejects other hosts and unparseable input', () {
      expect(isoixCloudProfileUrl('https://example.invalid/sub'), isFalse);
      expect(isoixCloudProfileUrl('http://[::1'), isFalse);
      expect(isoixCloudProfileUrl(''), isFalse);
    });
  });
}

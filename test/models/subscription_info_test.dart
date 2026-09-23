import 'package:fl_clash/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('SubscriptionInfo.formHString', () {
    test('parses the standard header', () {
      expect(
        SubscriptionInfo.formHString(
          'upload=1; download=2; total=3; expire=1735660800',
        ),
        const SubscriptionInfo(
          upload: 1,
          download: 2,
          total: 3,
          expire: 1735660800,
        ),
      );
    });

    test('accepts mixed-case keys, spaced separators and float values', () {
      expect(
        SubscriptionInfo.formHString(
          'Upload = 10; DOWNLOAD=2.5e3; Total=1.073741824E10; expire=',
        ),
        const SubscriptionInfo(upload: 10, download: 2500, total: 10737418240),
      );
    });

    test('ignores malformed and non-finite values', () {
      expect(
        SubscriptionInfo.formHString('upload=NaN; download=Infinity; total'),
        const SubscriptionInfo(),
      );
      expect(
        SubscriptionInfo.formHString('upload=5; total=1e400; expire=-1e400'),
        const SubscriptionInfo(upload: 5),
      );
      expect(SubscriptionInfo.formHString(null), const SubscriptionInfo());
    });
  });
}

import 'package:fl_clash/common/utils.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:test/test.dart';

void main() {
  final utils = Utils();

  group('getDateStringLast2', () {
    test('pads single digit', () {
      expect(utils.getDateStringLast2(5), '05');
    });

    test('returns last 2 chars of double digit', () {
      expect(utils.getDateStringLast2(12), '12');
    });

    test('handles zero', () {
      expect(utils.getDateStringLast2(0), '00');
    });
  });

  group('uuidV4', () {
    test('produces valid UUID v4 format', () {
      final uuid = utils.uuidV4;
      expect(
        RegExp(
          r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
        ).hasMatch(uuid),
        isTrue,
      );
    });

    test('produces unique values', () {
      final uuid1 = utils.uuidV4;
      final uuid2 = utils.uuidV4;
      expect(uuid1, isNot(equals(uuid2)));
    });
  });

  group('getTimeText', () {
    test('returns 00:00:00 for null', () {
      expect(utils.getTimeText(null), '00:00:00');
    });

    test('formats zero milliseconds', () {
      expect(utils.getTimeText(0), '00:00:00');
    });

    test('formats seconds only', () {
      expect(utils.getTimeText(5000), '00:00:05');
    });

    test('formats minutes and seconds', () {
      expect(utils.getTimeText(125000), '00:02:05');
    });

    test('formats hours', () {
      expect(utils.getTimeText(3661000), '01:01:01');
    });

    test('omits seconds when hours exceed two digits', () {
      expect(
        utils.getTimeText(
          const Duration(hours: 99, minutes: 59, seconds: 59).inMilliseconds,
        ),
        '99:59:59',
      );
      expect(
        utils.getTimeText(
          const Duration(hours: 100, minutes: 2, seconds: 5).inMilliseconds,
        ),
        '100:02',
      );
    });
  });

  group('getOverwriteLabel', () {
    test('appends (1) to label without number', () {
      expect(utils.getOverwriteLabel('foo'), 'foo(1)');
    });

    test('increments existing number', () {
      expect(utils.getOverwriteLabel('foo(1)'), 'foo(2)');
    });

    test('increments higher numbers', () {
      expect(utils.getOverwriteLabel('foo(9)'), 'foo(10)');
    });

    test('increments numbers with three or more digits', () {
      expect(utils.getOverwriteLabel('foo(100)'), 'foo(101)');
      expect(utils.getOverwriteLabel('Plan(2025)'), 'Plan(2026)');
    });

    test('increments a label that is only a counter', () {
      expect(utils.getOverwriteLabel('(1)'), '(2)');
    });

    test('appends a counter when the number overflows', () {
      expect(
        utils.getOverwriteLabel('foo(99999999999999999999)'),
        'foo(99999999999999999999)(1)',
      );
    });
  });

  group('getFileNameForDisposition', () {
    test('prefers the encoded file name', () {
      expect(
        utils.getFileNameForDisposition(
          "attachment; filename=plain.yaml; filename*=UTF-8''%E6%B5%8B.yaml",
        ),
        '测.yaml',
      );
    });

    test('falls back to the plain name when the encoded one is malformed', () {
      expect(
        utils.getFileNameForDisposition(
          "attachment; filename=plain.yaml; filename*=UTF-8''%E4%B8",
        ),
        'plain.yaml',
      );
    });

    test('ignores a header that cannot be parsed', () {
      expect(
        utils.getFileNameForDisposition('attachment; filename="plain'),
        isNull,
      );
    });
  });

  group('getViewMode', () {
    test('mobile for small width', () {
      expect(utils.getViewMode(400).name, 'mobile');
    });

    test('laptop for medium width', () {
      expect(utils.getViewMode(700).name, 'laptop');
    });

    test('desktop for large width', () {
      expect(utils.getViewMode(1000).name, 'desktop');
    });
  });

  group('getProxiesColumns', () {
    test('minimum 2 columns', () {
      expect(utils.getProxiesColumns(100, ProxiesLayout.standard), 2);
    });

    test('scales with width', () {
      expect(utils.getProxiesColumns(500, ProxiesLayout.standard), 2);
      expect(utils.getProxiesColumns(800, ProxiesLayout.standard), 4);
    });

    test('tight layout adds column', () {
      final standard = utils.getProxiesColumns(500, ProxiesLayout.standard);
      final tight = utils.getProxiesColumns(500, ProxiesLayout.tight);
      expect(tight, standard + 1);
    });

    test('loose layout removes column', () {
      final standard = utils.getProxiesColumns(800, ProxiesLayout.standard);
      final loose = utils.getProxiesColumns(800, ProxiesLayout.loose);
      expect(loose, standard - 1);
    });
  });

  group('getProfilesColumns', () {
    test('minimum 1 column', () {
      expect(utils.getProfilesColumns(100), 1);
    });

    test('scales with width', () {
      expect(utils.getProfilesColumns(300), 1);
      expect(utils.getProfilesColumns(600), 2);
    });
  });

  group('fastHash', () {
    test('produces consistent hash', () {
      final hash1 = utils.fastHash('hello');
      final hash2 = utils.fastHash('hello');
      expect(hash1, hash2);
    });

    test('different input produces different hash', () {
      expect(utils.fastHash('hello'), isNot(equals(utils.fastHash('world'))));
    });

    test('returns an integer', () {
      final hash = utils.fastHash('test');
      expect(hash, isA<int>());
    });
  });
}

import 'package:fl_clash/common/snowflake.dart';
import 'package:test/test.dart';

void main() {
  group('Snowflake', () {
    test('generates positive IDs', () {
      final id = snowflake.id;
      expect(id, greaterThan(0));
    });

    test('generates unique sequential IDs', () {
      final ids = <int>{};
      for (int i = 0; i < 1000; i++) {
        ids.add(snowflake.id);
      }
      expect(ids.length, 1000);
    });

    test('IDs are monotonically increasing', () {
      final ids = List.generate(100, (_) => snowflake.id);
      for (int i = 1; i < ids.length; i++) {
        expect(ids[i], greaterThan(ids[i - 1]));
      }
    });

    test('keeps issuing increasing IDs when the clock steps back', () {
      var now = 1800000000000;
      final generator = Snowflake.withClock(() => now);
      final before = generator.id;
      now -= 60 * 60 * 1000;

      final after = [generator.id, generator.id];

      expect(after.first, greaterThan(before));
      expect(after.last, greaterThan(after.first));
    });

    test('borrows the next millisecond once a sequence is exhausted', () {
      const now = 1800000000000;
      final generator = Snowflake.withClock(() => now);

      final ids = List.generate(4096 * 2 + 1, (_) => generator.id);

      expect(ids.toSet().length, ids.length);
      for (var i = 1; i < ids.length; i++) {
        expect(ids[i], greaterThan(ids[i - 1]));
      }
    });
  });
}

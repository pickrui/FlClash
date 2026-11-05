import 'package:fl_clash/common/function.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:test/test.dart';

void main() {
  test('debounces calls with the same key', () async {
    final debouncer = Debouncer();
    final values = <int>[];

    debouncer.call(
      (FunctionTag.changeProxy, 'Group A'),
      values.add,
      args: [1],
      duration: Duration.zero,
    );
    debouncer.call(
      (FunctionTag.changeProxy, 'Group A'),
      values.add,
      args: [2],
      duration: Duration.zero,
    );
    await Future<void>.delayed(const Duration(milliseconds: 10));

    expect(values, [2]);
  });

  test('keeps calls for different proxy groups', () async {
    final debouncer = Debouncer();
    final values = <String>[];

    debouncer.call(
      (FunctionTag.changeProxy, 'Group A'),
      values.add,
      args: ['A'],
      duration: Duration.zero,
    );
    debouncer.call(
      (FunctionTag.changeProxy, 'Group B'),
      values.add,
      args: ['B'],
      duration: Duration.zero,
    );
    await Future<void>.delayed(const Duration(milliseconds: 10));

    expect(values, containsAll(['A', 'B']));
  });

  group('retry', () {
    test('returns immediately when first result does not need retry', () async {
      var attempts = 0;

      final result = await retry(
        task: () async {
          attempts++;
          return 'done';
        },
        retryIf: (res) => res != 'done',
        delay: Duration.zero,
      );

      expect(result, 'done');
      expect(attempts, 1);
    });

    test('retries until result no longer matches retry condition', () async {
      var attempts = 0;

      final result = await retry(
        task: () async {
          attempts++;
          return attempts < 3 ? 'pending' : 'done';
        },
        retryIf: (res) => res == 'pending',
        delay: Duration.zero,
        maxAttempts: 5,
      );

      expect(result, 'done');
      expect(attempts, 3);
    });

    test('returns last result when max attempts are exhausted', () async {
      var attempts = 0;

      final result = await retry(
        task: () async {
          attempts++;
          return false;
        },
        retryIf: (res) => res == false,
        delay: Duration.zero,
        maxAttempts: 3,
      );

      expect(result, false);
      expect(attempts, 3);
    });

    test('waits between retry attempts', () async {
      var attempts = 0;

      final future = retry(
        task: () async {
          attempts++;
          return attempts < 2 ? 'pending' : 'done';
        },
        retryIf: (res) => res == 'pending',
        delay: const Duration(milliseconds: 50),
        maxAttempts: 2,
      );

      await Future.delayed(const Duration(milliseconds: 10));
      expect(attempts, 1);

      final result = await future;

      expect(result, 'done');
      expect(attempts, 2);
    });
  });
}

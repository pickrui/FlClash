import 'package:fl_clash/common/input_limits.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TextInputLimits', () {
    test('limit truncates text to the configured length', () {
      final result = TextInputLimits.limit(5).single.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: '123456789'),
      );

      expect(result.text, '12345');
    });

    test('digitsOnly filters non-digits and limits length', () {
      var value = const TextEditingValue(text: '12ab345678');
      for (final formatter in TextInputLimits.digitsOnly(5)) {
        value = formatter.formatEditUpdate(TextEditingValue.empty, value);
      }

      expect(value.text, '12345');
    });
  });
}

import 'package:fl_clash/views/dashboard/widgets/network_detection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('country codes become flags, Taiwan as the panel shows it', () {
    expect(countryCodeToEmoji('hk'), '🇭🇰');
    expect(countryCodeToEmoji('JP'), '🇯🇵');
    expect(countryCodeToEmoji('tw'), '🇨🇳');
    expect(countryCodeToEmoji('TW'), '🇨🇳');
    expect(countryCodeToEmoji('unknown'), 'unknown');
  });
}

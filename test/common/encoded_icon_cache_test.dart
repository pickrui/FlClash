import 'dart:convert';

import 'package:fl_clash/common/encoded_icon_cache.dart';
import 'package:flutter_test/flutter_test.dart';

String icon(int value, [int bytes = 18]) =>
    'data:image/png;base64,${base64Encode(List.filled(bytes, value))}';

void main() {
  test('byte budget accounts for data URI keys and evicts old icons', () {
    final cache = EncodedIconCache(maxBytes: 150);
    final first = cache.decode(icon(1));
    expect(identical(cache.decode(icon(1)), first), true);
    cache.decode(icon(2));
    expect(identical(cache.decode(icon(1)), first), false);
  });

  test('cache hits keep recently used icons within the entry limit', () {
    final cache = EncodedIconCache(maxEntries: 2);
    final first = cache.decode(icon(1));
    final second = cache.decode(icon(2));
    expect(identical(cache.decode(icon(1)), first), true);
    cache.decode(icon(3));
    expect(identical(cache.decode(icon(1)), first), true);
    expect(identical(cache.decode(icon(2)), second), false);
  });

  test('oversized icons render without displacing cached small icons', () {
    final cache = EncodedIconCache(maxBytes: 150);
    final small = cache.decode(icon(1));
    final large = cache.decode(icon(2, 1024));
    expect(large, hasLength(1024));
    expect(identical(cache.decode(icon(2, 1024)), large), false);
    expect(identical(cache.decode(icon(1)), small), true);
  });

  test('memory pressure can release cache ownership', () {
    final cache = EncodedIconCache();
    final first = cache.decode(icon(1));
    cache.clear();
    expect(identical(cache.decode(icon(1)), first), false);
  });

  test('invalid and empty data URIs remain optional icons', () {
    final cache = EncodedIconCache();
    for (final value in [
      '',
      'https://example.invalid/a.png',
      'base64,!',
      'base64,',
    ]) {
      expect(cache.decode(value), null);
    }
  });
}

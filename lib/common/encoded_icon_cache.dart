import 'dart:convert';
import 'dart:typed_data';

/// Bounds both decoded bytes and the data URI retained as the cache key.
class EncodedIconCache {
  EncodedIconCache({this.maxEntries = 64, this.maxBytes = 2 * 1024 * 1024});

  final int maxEntries;
  final int maxBytes;
  final _entries = <String, Uint8List>{};
  int _retainedBytes = 0;

  Uint8List? decode(String source) {
    final existing = _entries.remove(source);
    if (existing != null) {
      _entries[source] = existing;
      return existing;
    }
    final marker = source.indexOf('base64,');
    if (marker < 0) return null;
    final Uint8List bytes;
    try {
      bytes = base64.decode(source.substring(marker + 7));
    } on FormatException {
      return null;
    }
    if (bytes.isEmpty) return null;
    final cost = _cost(source, bytes);
    // Oversized images may still render, but must not evict every small icon
    // or remain resident in this auxiliary cache.
    if (maxEntries <= 0 || cost > maxBytes) return bytes;
    while (_entries.length >= maxEntries || _retainedBytes + cost > maxBytes) {
      final oldest = _entries.keys.first;
      _retainedBytes -= _cost(oldest, _entries.remove(oldest)!);
    }
    _entries[source] = bytes;
    _retainedBytes += cost;
    return bytes;
  }

  void clear() {
    _entries.clear();
    _retainedBytes = 0;
  }

  int _cost(String source, Uint8List bytes) => source.length * 2 + bytes.length;
}

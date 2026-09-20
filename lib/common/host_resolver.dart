import 'dart:async';
import 'dart:convert';
import 'dart:io';

typedef HostLookup =
    Future<List<InternetAddress>> Function(
      String host, {
      InternetAddressType type,
    });

typedef HostAddressStore = ({
  Future<String?> Function() read,
  Future<void> Function(String value) write,
});

/// Addresses that a connection actually used, kept so a resolver answering
/// with nothing cannot cut the app off from a host it reached minutes ago.
///
/// The system resolver is still asked first and its answer always wins; the
/// cache only stands in when resolution itself fails. A stale entry therefore
/// costs one failed connection instead of hiding a real outage.
class HostResolver {
  HostResolver({
    HostLookup? lookup,
    this._store,
    this.ttl = const Duration(days: 7),
    DateTime Function()? now,
  }) : _lookup = lookup ?? _systemLookup,
       _now = now ?? DateTime.now;

  final HostLookup _lookup;
  final HostAddressStore? _store;
  final DateTime Function() _now;
  final Duration ttl;

  final _cache = <String, ({List<InternetAddress> addresses, DateTime at})>{};
  Future<void>? _loaded;
  Future<void> _writes = Future.value();

  static Future<List<InternetAddress>> _systemLookup(
    String host, {
    InternetAddressType type = InternetAddressType.any,
  }) => InternetAddress.lookup(host, type: type);

  /// Addresses to try, most trustworthy first.
  Future<List<InternetAddress>> resolve(String host) async {
    final literal = InternetAddress.tryParse(host);
    if (literal != null) return [literal];
    await _restore();
    Object? firstError;
    StackTrace? firstStackTrace;
    // A resolver bound to a tunnel often serves A records only, so an answer
    // for one family says nothing about the other; ask for IPv4 on its own
    // before giving up on the system.
    for (final type in const [
      InternetAddressType.any,
      InternetAddressType.IPv4,
    ]) {
      try {
        final addresses = await _lookup(host, type: type);
        if (addresses.isNotEmpty) return addresses;
      } catch (error, stackTrace) {
        firstError ??= error;
        firstStackTrace ??= stackTrace;
      }
    }
    final cached = _cache[_key(host)];
    if (cached != null && _now().difference(cached.at) <= ttl) {
      return cached.addresses;
    }
    if (firstError != null) {
      Error.throwWithStackTrace(firstError, firstStackTrace!);
    }
    throw SocketException('Failed host lookup: \'$host\'', osError: _noData);
  }

  /// Records an address a connection was established over.
  void confirm(String host, InternetAddress address) {
    if (address.type == InternetAddressType.unix) return;
    final key = _key(host);
    final now = _now();
    final existing = _cache[key];
    if (existing != null &&
        existing.addresses.length == 1 &&
        existing.addresses.first.address == address.address &&
        existing.at == now) {
      return;
    }
    // A stable address is still fresh when a new connection succeeds.
    _cache[key] = (addresses: [address], at: now);
    _persist();
  }

  Future<void> _restore() {
    final store = _store;
    if (store == null) return Future.value();
    return _loaded ??= () async {
      try {
        final raw = await store.read();
        if (raw == null || raw.isEmpty) return;
        final decoded = jsonDecode(raw);
        if (decoded is! Map) return;
        for (final entry in decoded.entries) {
          final value = entry.value;
          if (value is! Map) continue;
          final at = DateTime.tryParse('${value['at']}');
          final addresses = [
            for (final address in value['addresses'] as List? ?? const [])
              ?InternetAddress.tryParse('$address'),
          ];
          if (at == null || addresses.isEmpty) continue;
          // What this launch confirmed is newer than anything on disk.
          _cache.putIfAbsent(
            '${entry.key}',
            () => (addresses: addresses, at: at),
          );
        }
      } catch (_) {
        // A cache that cannot be read is simply empty.
      }
    }();
  }

  void _persist() {
    final store = _store;
    if (store == null) return;
    // A confirmation can land before anything was read back, so merge what is
    // already stored first; a write must not drop another host's address.
    _writes = _writes
        .then((_) => _restore())
        .then(
          (_) => store.write(
            jsonEncode({
              for (final entry in _cache.entries)
                entry.key: {
                  'at': entry.value.at.toIso8601String(),
                  'addresses': [
                    for (final address in entry.value.addresses)
                      address.address,
                  ],
                },
            }),
          ),
        )
        .onError((_, _) {});
  }

  static String _key(String host) => host.toLowerCase();

  static const _noData = OSError('No address associated with hostname', 7);
}

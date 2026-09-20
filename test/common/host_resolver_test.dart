import 'dart:io';

import 'package:fl_clash/common/host_resolver.dart';
import 'package:flutter_test/flutter_test.dart';

/// What a resolver bound to a dead tunnel answers: the query is served, the
/// answer carries no address.
const _noData = SocketException(
  "Failed host lookup: 'api.test'",
  osError: OSError('No address associated with hostname', 7),
);

final _address = InternetAddress('192.0.2.10');
final _ipv6 = InternetAddress('2001:db8::1');

typedef _Query = ({String host, InternetAddressType type});

class _FakeLookup {
  _FakeLookup(this._answers);

  final List<Object> _answers;
  final queries = <_Query>[];

  Future<List<InternetAddress>> call(
    String host, {
    InternetAddressType type = InternetAddressType.any,
  }) async {
    queries.add((host: host, type: type));
    if (_answers.isEmpty) throw _noData;
    final answer = _answers.removeAt(0);
    if (answer is Exception) throw answer;
    return (answer as List).cast<InternetAddress>();
  }
}

({HostAddressStore store, String? Function() value}) _store() {
  String? saved;
  return (
    store: (
      read: () async => saved,
      write: (String value) async => saved = value,
    ),
    value: () => saved,
  );
}

void main() {
  test('a system answer is used as it comes', () async {
    final lookup = _FakeLookup([
      [_ipv6, _address],
    ]);
    final resolver = HostResolver(lookup: lookup.call);
    expect(await resolver.resolve('api.test'), [_ipv6, _address]);
    expect(lookup.queries, [(host: 'api.test', type: InternetAddressType.any)]);
  });

  test('an IP literal is never looked up', () async {
    final lookup = _FakeLookup([]);
    final resolver = HostResolver(lookup: lookup.call);
    expect(await resolver.resolve('192.0.2.10'), [_address]);
    expect(lookup.queries, isEmpty);
  });

  for (final entry in {
    'an empty answer': <Object>[<InternetAddress>[]],
    'a lookup failure': <Object>[_noData],
  }.entries) {
    test('${entry.key} is retried for IPv4 alone', () async {
      final lookup = _FakeLookup([
        ...entry.value,
        [_address],
      ]);
      final resolver = HostResolver(lookup: lookup.call);
      expect(await resolver.resolve('api.test'), [_address]);
      expect(lookup.queries, [
        (host: 'api.test', type: InternetAddressType.any),
        (host: 'api.test', type: InternetAddressType.IPv4),
      ]);
    });
  }

  test(
    'an address that carried a connection stands in for a dead resolver',
    () async {
      final store = _store();
      final working = HostResolver(
        lookup: _FakeLookup([
          [_address],
        ]).call,
        store: store.store,
      );
      await working.resolve('api.test');
      working.confirm('api.test', _address);
      await pumpEventQueue();
      expect(store.value(), contains('192.0.2.10'));

      // A later launch reads the same store and the resolver has gone silent.
      final broken = HostResolver(
        lookup: _FakeLookup([]).call,
        store: store.store,
      );
      expect(await broken.resolve('api.test'), [_address]);
    },
  );

  test('an expired address is not used and the real error survives', () async {
    final store = _store();
    var now = DateTime(2026, 9, 19);
    final resolver = HostResolver(
      lookup: _FakeLookup([
        [_address],
      ]).call,
      store: store.store,
      ttl: const Duration(days: 7),
      now: () => now,
    );
    await resolver.resolve('api.test');
    resolver.confirm('api.test', _address);
    await pumpEventQueue();

    now = now.add(const Duration(days: 8));
    final expired = HostResolver(
      lookup: _FakeLookup([]).call,
      store: store.store,
      ttl: const Duration(days: 7),
      now: () => now,
    );
    await expectLater(
      expired.resolve('api.test'),
      throwsA(
        isA<SocketException>().having(
          (error) => error.osError?.errorCode,
          'errorCode',
          7,
        ),
      ),
    );
  });

  test('nothing to answer with keeps the empty-answer diagnosis', () async {
    final resolver = HostResolver(
      lookup: (host, {type = InternetAddressType.any}) async => const [],
    );
    await expectLater(
      resolver.resolve('api.test'),
      throwsA(
        isA<SocketException>().having(
          (error) => error.osError?.errorCode,
          'errorCode',
          7,
        ),
      ),
    );
  });

  test('a confirmation keeps what another host already stored', () async {
    final store = _store();
    final first = HostResolver(
      lookup: _FakeLookup([
        [_address],
      ]).call,
      store: store.store,
    );
    await first.resolve('other.test');
    first.confirm('other.test', _address);
    await pumpEventQueue();

    // A fresh resolver confirms before anything made it read the store back.
    final second = HostResolver(
      lookup: _FakeLookup([]).call,
      store: store.store,
    );
    second.confirm('api.test', InternetAddress.loopbackIPv4);
    await pumpEventQueue();
    expect(store.value(), contains('other.test'));
    expect(store.value(), contains('api.test'));
  });

  test(
    'a repeated confirmation at the same instant does not rewrite the store',
    () async {
      final store = _store();
      final resolver = HostResolver(
        lookup: _FakeLookup([]).call,
        now: () => DateTime.utc(2026, 9, 19),
        store: store.store,
      );
      resolver.confirm('api.test', _address);
      await pumpEventQueue();
      final first = store.value();
      resolver.confirm('API.test', _address);
      await pumpEventQueue();
      expect(store.value(), first);
    },
  );

  test('same-IP success refreshes TTL in memory and across launches', () async {
    final store = _store();
    var now = DateTime.utc(2026, 9, 1);
    final resolver = HostResolver(
      lookup: _FakeLookup([]).call,
      store: store.store,
      now: () => now,
    );
    resolver.confirm('api.test', _address);
    await pumpEventQueue();
    now = now.add(const Duration(days: 6));
    resolver.confirm('API.test', _address);
    await pumpEventQueue();
    now = now.add(const Duration(days: 2));
    expect(await resolver.resolve('api.test'), [_address]);
    final restarted = HostResolver(
      lookup: _FakeLookup([]).call,
      store: store.store,
      now: () => now,
    );
    expect(await restarted.resolve('api.test'), [_address]);
    now = now.add(const Duration(days: 6));
    await expectLater(restarted.resolve('api.test'), throwsA(same(_noData)));
  });
}

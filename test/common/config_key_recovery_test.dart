import 'dart:async';
import 'dart:convert';

import 'package:fl_clash/services/config_key_store.dart';
import 'package:fl_clash/services/config_recovery.dart';
import 'package:test/test.dart';

void main() {
  final seed = base64Encode(List<int>.generate(32, (index) => index));

  test('recovers the original seed on one automatic storage retry', () async {
    final reads = <bool>[];
    final writes = <String>[];

    final result = await loadConfigSeed(
      durableConfigExists: true,
      readSeed: (retry) async {
        reads.add(retry);
        return retry ? seed : null;
      },
      writeSeed: (value) async => writes.add(value),
    );

    expect(result, seed);
    expect(reads, [false, true]);
    expect(writes, isEmpty);
  });

  for (final stored in [null, 'invalid']) {
    test(
      'unavailable seed $stored never replaces an existing config key',
      () async {
        var writes = 0;
        await expectLater(
          loadConfigSeed(
            durableConfigExists: true,
            readSeed: (_) async => stored,
            writeSeed: (_) async => writes++,
          ),
          throwsA(isA<ConfigKeyUnavailableException>()),
        );
        expect(writes, 0);
      },
    );
  }

  test('fresh installation persists a new seed before returning it', () async {
    String? persisted;
    final result = await loadConfigSeed(
      durableConfigExists: false,
      readSeed: (_) async => null,
      writeSeed: (value) async => persisted = value,
    );

    expect(ConfigKeyStore.decodeSeed(result), hasLength(32));
    expect(result, persisted);
  });

  test('storage failure cannot be treated as a fresh installation', () async {
    var reads = 0;
    var writes = 0;
    await expectLater(
      loadConfigSeed(
        durableConfigExists: false,
        readSeed: (_) async {
          reads++;
          throw StateError('storage unavailable');
        },
        writeSeed: (_) async => writes++,
      ),
      throwsA(isA<ConfigKeyUnavailableException>()),
    );
    expect(reads, 2);
    expect(writes, 0);
  });

  test(
    'failed seed persistence remains recoverable and hides storage details',
    () async {
      await expectLater(
        loadConfigSeed(
          durableConfigExists: false,
          readSeed: (_) async => null,
          writeSeed: (_) async => throw StateError('private storage detail'),
        ),
        throwsA(
          isA<ConfigKeyUnavailableException>().having(
            (error) => error.toString(),
            'safe message',
            isNot(contains('private storage detail')),
          ),
        ),
      );
    },
  );

  test('readable startup does not show the recovery screen', () async {
    expect(
      await loadWithConfigRecovery(
        load: (_) async => 'config',
        showRecovery: (_) => fail('unexpected recovery screen'),
      ),
      'config',
    );
  });

  test('startup waits through failures and resumes exactly once', () async {
    final shown = Completer<Future<void> Function()>();
    final loading = Completer<String>();
    var calls = 0;
    var resumed = 0;
    final startup =
        loadWithConfigRecovery(
          load: (retry) async {
            calls++;
            if (calls <= 2) throw const ConfigKeyUnavailableException();
            expect(retry, isTrue);
            return loading.future;
          },
          showRecovery: shown.complete,
        ).then((value) {
          resumed++;
          return value;
        });

    final retry = await shown.future;
    await expectLater(retry(), throwsA(isA<ConfigKeyUnavailableException>()));
    expect(resumed, 0);
    final first = retry();
    final duplicate = retry();
    expect(identical(first, duplicate), isTrue);
    expect(calls, 3);
    loading.complete('original config');
    await first;
    expect(await startup, 'original config');
    await retry();
    expect(calls, 3);
    expect(resumed, 1);
  });

  test('unrelated startup errors do not enter key recovery', () async {
    await expectLater(
      loadWithConfigRecovery<String>(
        load: (_) async => throw const FormatException('unrelated'),
        showRecovery: (_) => fail('unexpected key recovery'),
      ),
      throwsFormatException,
    );
  });

  test(
    'unrelated failure after key recovery returns to startup handling',
    () async {
      final shown = Completer<Future<void> Function()>();
      final startup = loadWithConfigRecovery<String>(
        load: (retry) async {
          if (!retry) throw const ConfigKeyUnavailableException();
          throw const FormatException('invalid preference config');
        },
        showRecovery: shown.complete,
      );
      final failedStartup = expectLater(startup, throwsFormatException);
      final retry = await shown.future;
      await expectLater(retry(), throwsFormatException);
      await failedStartup;
    },
  );
}

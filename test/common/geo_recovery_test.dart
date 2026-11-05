import 'dart:async';

import 'package:fl_clash/common/geo_recovery.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:flutter_test/flutter_test.dart';

const _geoFailure = "can't download GeoIP.dat: timeout";
const _validationFailure =
    '''Parse Error: rules[0] [GEOIP,CN,DIRECT] error: can't download GeoIP.dat: Get "validator://disabled": unsupported protocol scheme "validator"''';

void main() {
  test('recognizes resource-specific errors and exact failed URL file names', () {
    final cases = {
      'Get "https://fastly.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@release/geoip.dat": net/http: TLS handshake timeout':
          GeoResource.GEOIP,
      "can't download GeoSite.dat: timeout": GeoResource.GEOSITE,
      "can't download MMDB: timeout": GeoResource.MMDB,
      "can't download ASN: timeout": GeoResource.ASN,
      'Get "https://example.org/GeoLite2-ASN.mmdb": EOF': GeoResource.ASN,
      'Get "https://example.org/Country.mmdb?token=private": EOF':
          GeoResource.MMDB,
      'Get "https://example.org/geoip.db": EOF': GeoResource.MMDB,
      _validationFailure: GeoResource.GEOIP,
    };
    for (final entry in cases.entries) {
      expect(failedGeoResource(entry.key), entry.value, reason: entry.key);
    }
    for (final error in [
      'invalid GEOIP.dat rule',
      'cannot download profile containing GEOIP.dat',
      'Get "https://example.org/geoip.dat/profile.yaml": timeout',
      'Get "https://example.org/profile.yaml?name=geoip.dat": timeout',
      'GEOIP.dat: Get "https://example.org/profile.yaml": timeout',
    ]) {
      expect(failedGeoResource(error), isNull, reason: error);
    }
  });

  test('extracts custom source from wrapped download failure', () {
    const url = 'https://example.org/custom?token=secret';
    expect(
      failedGeoDownloadUrl('can\'t download GeoIP.dat: Get "$url": EOF'),
      url,
    );
    expect(failedGeoDownloadUrl(_validationFailure), isNull);
    expect(needsInitialGeoDownload(_validationFailure), isTrue);
    expect(needsInitialGeoDownload(_geoFailure), isFalse);
  });

  for (final initialError in [null, _validationFailure]) {
    test(
      'normal and validation requests download before offering recovery: $initialError',
      () async {
        final events = <String>[];
        expect(
          await downloadGeoWithRecovery(
            initialError: initialError,
            download: () async {
              events.add('download');
              return '';
            },
            recover: (_) async {
              events.add('recover');
              return true;
            },
            shouldContinue: () => true,
          ),
          isTrue,
        );
        expect(events, ['download']);
      },
    );
  }

  test(
    'failed default download offers recovery with actual network error',
    () async {
      final events = <String>[];
      expect(
        await downloadGeoWithRecovery(
          initialError: _validationFailure,
          download: () async {
            events.add('download');
            return _geoFailure;
          },
          recover: (error) async {
            expect(error, _geoFailure);
            events.add('recover');
            return true;
          },
          shouldContinue: () => true,
        ),
        isTrue,
      );
      expect(events, ['download', 'recover']);
    },
  );

  test(
    'existing network failure does not silently repeat the failed request',
    () async {
      expect(
        await downloadGeoWithRecovery(
          initialError: _geoFailure,
          download: () async => throw StateError('already downloaded'),
          recover: (error) async {
            expect(error, _geoFailure);
            return false;
          },
          shouldContinue: () => true,
        ),
        isFalse,
      );
    },
  );

  test('network and invalid content errors offer a different source', () async {
    for (final failure in [
      'GEO download failed: unexpected EOF',
      'GEO download exceeds size limit',
      'invalid ASN database file: unsupported type',
      'invalid GEOIP database file: empty CN group',
    ]) {
      expect(
        await downloadGeoWithRecovery(
          download: () async => failure,
          recover: (error) async {
            expect(error, failure);
            return true;
          },
          shouldContinue: () => true,
        ),
        isTrue,
      );
    }
  });

  for (final failure in [
    'GEO update is already in progress',
    'context canceled',
    'GEO download failed: context canceled',
    'invalid GEO resource name',
    'open /data/.flclash-geo-temp: permission denied',
    'write /data/.flclash-geo-temp: no space left on device',
  ]) {
    test(
      'operational failure is not presented as a source problem: $failure',
      () async {
        await expectLater(
          downloadGeoWithRecovery(
            download: () async => failure,
            recover: (_) async => throw StateError('unexpected recovery'),
            shouldContinue: () => true,
          ),
          throwsA(failure),
        );
      },
    );
  }

  test('stale default download completion does not show recovery', () async {
    var current = true;
    final download = Completer<String>();
    final result = downloadGeoWithRecovery(
      download: () => download.future,
      recover: (_) async => throw StateError('unexpected recovery'),
      shouldContinue: () => current,
    );
    current = false;
    download.complete(_geoFailure);
    expect(await result, isFalse);
  });

  test('ordinary success never offers recovery', () async {
    expect(
      await withGeoRecovery(
        action: () async => true,
        recover: (_, _) async => throw StateError('unexpected recovery'),
        shouldContinue: () => true,
      ),
      isTrue,
    );
  });

  test(
    'waits for successful recovery before retrying the original operation',
    () async {
      var calls = 0;
      var recovered = false;
      expect(
        await withGeoRecovery(
          action: () async {
            calls++;
            if (!recovered) throw _geoFailure;
            return true;
          },
          recover: (resource, error) async {
            expect(resource, GeoResource.GEOIP);
            recovered = true;
            return true;
          },
          shouldContinue: () => true,
        ),
        isTrue,
      );
      expect(calls, 2);
    },
  );

  test(
    'cancellation returns false without repeating the error or action',
    () async {
      var calls = 0;
      expect(
        await withGeoRecovery(
          action: () async {
            calls++;
            throw _geoFailure;
          },
          recover: (_, _) async => false,
          shouldContinue: () => true,
        ),
        isFalse,
      );
      expect(calls, 1);
    },
  );

  test('stale profile does not retry after recovery', () async {
    var current = true;
    var calls = 0;
    expect(
      await withGeoRecovery(
        action: () async {
          calls++;
          throw _geoFailure;
        },
        shouldContinue: () => current,
        recover: (_, _) async {
          current = false;
          return true;
        },
      ),
      isFalse,
    );
    expect(calls, 1);
  });

  test('stale intent never starts the initial action', () async {
    expect(
      await withGeoRecovery(
        action: () async => throw StateError('unexpected action'),
        recover: (_, _) async => throw StateError('unexpected recovery'),
        shouldContinue: () => false,
      ),
      isFalse,
    );
  });

  test(
    'successful repair cannot cause endless downloads for the same resource',
    () async {
      var recoveries = 0;
      await expectLater(
        withGeoRecovery(
          action: () async => throw _geoFailure,
          recover: (_, _) async {
            recoveries++;
            return true;
          },
          shouldContinue: () => true,
        ),
        throwsA(_geoFailure),
      );
      expect(recoveries, 1);
    },
  );

  test('different missing dependencies are repaired sequentially', () async {
    var calls = 0;
    final resources = <GeoResource>[];
    expect(
      await withGeoRecovery(
        action: () async {
          if (calls++ == 0) throw _geoFailure;
          if (calls == 2) throw "can't download GeoSite.dat: timeout";
          return true;
        },
        recover: (resource, _) async {
          resources.add(resource);
          return true;
        },
        shouldContinue: () => true,
      ),
      isTrue,
    );
    expect(resources, [GeoResource.GEOIP, GeoResource.GEOSITE]);
  });

  test('non-GEO error is propagated without offering recovery', () async {
    await expectLater(
      withGeoRecovery(
        action: () async => throw 'invalid proxy group',
        recover: (_, _) async => throw StateError('unexpected recovery'),
        shouldContinue: () => true,
      ),
      throwsA('invalid proxy group'),
    );
  });
}

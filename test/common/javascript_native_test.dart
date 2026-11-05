import 'dart:io';

import 'package:fl_clash/common/constant.dart';
import 'package:fl_clash/common/javascript.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart'
    show ExternalLibrary;
import 'package:flutter_test/flutter_test.dart';
import 'package:rust_api/rust_api.dart';

void main() {
  final library = Platform.environment['FLCLASH_TEST_SCRIPT_LIB'];
  group(
    'native script bridge',
    () {
      setUpAll(
        () async =>
            RustLib.init(externalLibrary: ExternalLibrary.open(library!)),
      );
      tearDownAll(RustLib.dispose);

      test('default script can be evaluated repeatedly', () async {
        for (var index = 0; index < 10; index++) {
          final result = await evaluateProfileScript('$scriptTemplate ', {
            'proxies': <dynamic>[],
          });
          expect(result['proxies'], isEmpty);
          expect(result['proxy-providers'], isEmpty);
        }
      });

      test('async transform and console survive the FFI round trip', () async {
        final logs = <String>[];
        final result = await evaluateProfileScript(
          "const main = async c => { await Promise.resolve(); console.warn('中文', {x: 1}); c.mode = 'global'; return c; }",
          {'mode': 'rule'},
          onConsole: (level, line) => logs.add('$level:$line'),
        );
        expect(result['mode'], 'global');
        expect(logs, ['warn:中文 {"x":1}']);
      });

      test(
        'recovers after syntax, rejected promise and allocation failures',
        () async {
          for (final script in [
            'const main = (',
            "async function main() { throw Error('failed'); }",
            'function main() { return new Promise(() => {}); }',
            'function main() { return {toJSON: () => []}; }',
            'function main() { const a = []; while(true) a.push(new ArrayBuffer(16 * 1024 * 1024)); }',
          ]) {
            await expectLater(
              evaluateProfileScript(script, {}),
              throwsA(isA<String>()),
            );
            expect(
              await evaluateProfileScript('function main(c) { return c }', {
                'ok': true,
              }),
              containsPair('ok', true),
            );
          }
        },
      );
    },
    skip: library == null ? 'FLCLASH_TEST_SCRIPT_LIB is not set' : false,
  );
}

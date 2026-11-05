import 'dart:convert';

import 'package:fl_clash/common/javascript.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rust_api/rust_api.dart';

void main() {
  final nativeEvaluator = scriptEvaluator;
  tearDown(() => scriptEvaluator = nativeEvaluator);

  test('adds proxy providers without modifying the caller config', () async {
    final original = <String, dynamic>{'proxies': <dynamic>[]};
    scriptEvaluator = ({required script, required config}) async {
      expect(script, 'script');
      expect(jsonDecode(config)['proxy-providers'], isEmpty);
      return ScriptEvaluation(config: config, logs: []);
    };
    final result = await evaluateProfileScript('script', original);
    expect(result['proxy-providers'], isEmpty);
    expect(original.containsKey('proxy-providers'), isFalse);
  });

  test(
    'delivers console output on failure and never retries failed scripts',
    () async {
      var calls = 0;
      scriptEvaluator = ({required script, required config}) async {
        calls++;
        return const ScriptEvaluation(
          error: 'timeout',
          logs: [ScriptLog(level: 'warn', output: 'before failure')],
        );
      };
      final lines = <String>[];
      await expectLater(
        evaluateProfileScript(
          '',
          {},
          onConsole: (level, text) {
            lines.add('$level:$text');
          },
        ),
        throwsA('timeout'),
      );
      expect(calls, 1);
      expect(lines, ['warn:before failure']);
    },
  );

  test(
    'logging callback errors do not discard a valid configuration',
    () async {
      scriptEvaluator = ({required script, required config}) async =>
          const ScriptEvaluation(
            config: '{"ok":true}',
            logs: [ScriptLog(level: 'log', output: 'line')],
          );
      expect(
        await evaluateProfileScript(
          '',
          {},
          onConsole: (_, _) => throw StateError('closed'),
        ),
        {'ok': true},
      );
    },
  );

  test('validates decoded output including custom toJSON results', () async {
    for (final output in [null, 'null', '[]', '42', '"text"']) {
      scriptEvaluator = ({required script, required config}) async =>
          ScriptEvaluation(config: output, logs: []);
      await expectLater(evaluateProfileScript('', {}), throwsA(isA<String>()));
    }
  });
}

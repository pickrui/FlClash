import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rust_api/rust_api.dart';

typedef ScriptEvaluator =
    Future<ScriptEvaluation> Function({
      required String script,
      required String config,
    });

@visibleForTesting
ScriptEvaluator scriptEvaluator = evaluateScript;

Future<Map<String, dynamic>> evaluateProfileScript(
  String script,
  Map<String, dynamic> config, {
  void Function(String level, String output)? onConsole,
}) async {
  final input = <String, dynamic>{...config};
  input['proxy-providers'] ??= <String, dynamic>{};
  final result = await scriptEvaluator(
    script: script,
    config: jsonEncode(input),
  );
  for (final log in result.logs) {
    // A UI log callback must not change the script's outcome.
    try {
      onConsole?.call(log.level, log.output);
    } catch (_) {}
  }
  if (result.error != null) {
    throw result.error!;
  }
  if (result.config == null) {
    throw 'script did not return a configuration object';
  }
  final decoded = jsonDecode(result.config!);
  if (decoded is! Map<String, dynamic>) {
    throw 'script did not return a configuration object';
  }
  return decoded;
}

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
  Map<String, bool> options = const {},
}) async {
  final input = <String, dynamic>{...config};
  input['proxy-providers'] ??= <String, dynamic>{};
  final result = await scriptEvaluator(
    script: applyScriptOptions(script, options),
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

/// Profile scripts publish their switches as a top-level `ruleOptionsEnable`
/// object. A switch a frozen or read-only script refuses to take is never
/// offered, so applying the profile cannot fail on an override it rejects.
const _optionEntries = """
const entries = (() => {
  if (typeof ruleOptionsEnable === 'undefined' || !ruleOptionsEnable ||
      typeof ruleOptionsEnable !== 'object' || Array.isArray(ruleOptionsEnable)) {
    return [];
  }
  return Object.keys(ruleOptionsEnable).slice(0, 128).filter((key) => {
    if (key === '__proto__' || key === 'constructor' || key === 'prototype') {
      return false;
    }
    const descriptor = Object.getOwnPropertyDescriptor(ruleOptionsEnable, key);
    return descriptor !== undefined && descriptor.writable === true &&
        typeof descriptor.value === 'boolean';
  });
})();
""";

String applyScriptOptions(String script, Map<String, bool> options) {
  if (options.isEmpty) return script;
  final encoded = jsonEncode(jsonEncode(options));
  return '''
$script
;(() => {
  "use strict";
$_optionEntries
  const overrides = JSON.parse($encoded);
  for (const key of entries) {
    if (Object.prototype.hasOwnProperty.call(overrides, key)) {
      ruleOptionsEnable[key] = overrides[key];
    }
  }
})();
''';
}

Future<Map<String, bool>> extractScriptOptions(String script) async {
  final result = await evaluateProfileScript('''
function main() {
  return (() => {
    $script
    ;return (() => {
$_optionEntries
    const options = {};
    for (const key of entries) options[key] = ruleOptionsEnable[key];
    return options;
    })();
  })();
}
''', {});
  return {
    for (final entry in result.entries)
      if (entry.value is bool) entry.key: entry.value as bool,
  };
}

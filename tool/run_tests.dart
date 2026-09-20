import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'set_native_build_assets.dart';

Future<void> main(List<String> args) async {
  final pubspec = File('pubspec.yaml');
  final original = pubspec.readAsBytesSync();
  final source = utf8.decode(original);
  final disabled = configureBuildAssets(source, false);
  final signals = <StreamSubscription<ProcessSignal>>[];
  var status = 1;
  int? interrupted;
  ProcessSignal? interruption;
  Process? process;
  try {
    for (final signal in [
      ProcessSignal.sigint,
      if (!Platform.isWindows) ProcessSignal.sigterm,
    ]) {
      signals.add(
        signal.watch().listen((_) {
          interrupted = signal == ProcessSignal.sigint ? 130 : 143;
          interruption = signal;
          process?.kill(signal);
        }),
      );
    }
    pubspec.writeAsStringSync(disabled);
    process = await Process.start(
      Platform.isWindows ? 'flutter.bat' : 'flutter',
      ['test', ...args],
      mode: ProcessStartMode.inheritStdio,
      runInShell: Platform.isWindows,
    );
    if (interruption != null) process.kill(interruption!);
    status = await process.exitCode;
  } finally {
    for (final subscription in signals) {
      await subscription.cancel();
    }
    final current = pubspec.readAsStringSync();
    if (current == disabled) {
      pubspec.writeAsBytesSync(original);
    } else {
      var restored = current;
      for (final package in ['setup', 'rust_api']) {
        final setting = RegExp(
          '$package:\r?\n      build_assets: (true|false)',
        ).firstMatch(source)!.group(1);
        restored = configureBuildAssets(
          restored,
          setting == 'true',
          package: package,
        );
      }
      pubspec.writeAsStringSync(restored);
      stderr.writeln(
        'pubspec.yaml changed during tests; kept those edits and restored its native build switches',
      );
      status = 1;
    }
    exitCode = interrupted ?? status;
  }
}

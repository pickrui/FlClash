import 'package:fl_clash/models/models.dart';

typedef DelayProbe = Future<Delay> Function(({String name, String url}) target);

/// Test every target once with bounded concurrency, as upstream does. Each
/// probe starts its own network deadline after acquiring a slot. Publish only
/// completed results; a generation change discards late and queued work.
/// A missing Core response aborts queued work without marking nodes as failed.
Future<void> runDelayTestBatch({
  required List<({String name, String url})> targets,
  required int concurrency,
  required DelayProbe probe,
  required bool Function() isCurrent,
  required void Function(Delay delay) onResult,
}) async {
  if (concurrency <= 0) {
    throw ArgumentError.value(concurrency, 'concurrency', 'Must be positive');
  }
  var next = 0;
  Future<void> worker() async {
    while (isCurrent() && next < targets.length) {
      final target = targets[next++];
      Delay delay;
      try {
        delay = await probe(target);
      } catch (_) {
        delay = Delay(name: target.name, url: target.url, value: null);
      }
      if (!isCurrent()) return;
      onResult(delay);
      if (delay.value == null) {
        // A broken Core channel cannot test the rest of this batch. Release
        // their pending UI state, while already running probes may finish.
        while (isCurrent() && next < targets.length) {
          final skipped = targets[next++];
          onResult(Delay(name: skipped.name, url: skipped.url, value: null));
        }
      }
    }
  }

  await Future.wait(
    List.generate(
      targets.length < concurrency ? targets.length : concurrency,
      (_) => worker(),
    ),
  );
}

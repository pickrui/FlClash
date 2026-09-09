import 'package:fl_clash/models/models.dart';

/// Retry failed batch probes only after the first pass, one at a time.
/// A new generation stops both queued probes and stale result delivery.
Future<void> runDelayTestBatch({
  required List<({String name, String url})> targets,
  required int concurrency,
  required Future<Delay> Function(({String name, String url}) target) probe,
  required bool Function() isCurrent,
  required void Function(Delay delay) onResult,
}) async {
  assert(concurrency > 0);
  final failed = <({String name, String url})>[];
  var next = 0;
  Future<void> worker() async {
    while (isCurrent() && next < targets.length) {
      final target = targets[next++];
      final delay = await probe(target);
      if (!isCurrent()) return;
      if ((delay.value ?? -1) <= 0) {
        failed.add(target);
      } else {
        onResult(delay);
      }
    }
  }

  await Future.wait(
    List.generate(
      targets.length < concurrency ? targets.length : concurrency,
      (_) => worker(),
    ),
  );
  for (final target in failed) {
    if (!isCurrent()) return;
    final delay = await probe(target);
    if (!isCurrent()) return;
    onResult(delay);
  }
}

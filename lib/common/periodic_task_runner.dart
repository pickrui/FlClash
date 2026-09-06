import 'dart:async';

typedef PeriodicTask = FutureOr<void> Function();

class PeriodicTaskRunner {
  final Duration interval;
  final void Function(Object error, StackTrace stackTrace) onError;
  List<PeriodicTask> _tasks = [];
  Timer? _timer;
  Future<void>? _inFlight;
  bool _enabled = false;
  int _generation = 0;

  PeriodicTaskRunner({
    this.interval = const Duration(seconds: 1),
    required this.onError,
  });

  Future<void> start([List<PeriodicTask>? tasks]) {
    if (tasks != null) _tasks = List.of(tasks);
    if (_tasks.isEmpty) {
      stop();
      return Future.value();
    }
    if (_enabled) return _inFlight ?? Future.value();
    _enabled = true;
    return _run(++_generation);
  }

  void stop() {
    _enabled = false;
    _generation++;
    _timer?.cancel();
    _timer = null;
  }

  bool _isCurrent(int generation) => _enabled && generation == _generation;

  Future<void> _run(int generation) async {
    final previous = _inFlight;
    final completion = Completer<void>();
    _inFlight = completion.future;
    _timer = null;
    try {
      // A resumed run waits for the old RPC to finish instead of overlapping it.
      if (previous != null) await previous;
      if (!_isCurrent(generation)) return;
      for (final task in List<PeriodicTask>.of(_tasks)) {
        if (!_isCurrent(generation)) return;
        try {
          await task();
        } catch (error, stackTrace) {
          onError(error, stackTrace);
        }
      }
    } finally {
      if (identical(_inFlight, completion.future)) _inFlight = null;
      completion.complete();
      if (_isCurrent(generation)) {
        _timer = Timer(interval, () => unawaited(_run(generation)));
      }
    }
  }
}

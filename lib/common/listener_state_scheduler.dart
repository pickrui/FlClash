/// Serializes listener transitions. A queued network change cannot overtake a
/// newer user stop, and a failed transition does not poison the queue.
class ListenerStateScheduler {
  ListenerStateScheduler(this.setRunning);

  final Future<void> Function(bool running) setRunning;
  Future<void> _pending = Future.value();
  int _revision = 0;

  Future<void> apply({required bool running, required bool suspended}) {
    final revision = ++_revision;
    final operation = _pending.then((_) async {
      if (revision != _revision) return;
      await setRunning(running && !suspended);
    });
    _pending = operation.then<void>(
      (_) {},
      onError: (Object _, StackTrace _) {},
    );
    return operation;
  }
}

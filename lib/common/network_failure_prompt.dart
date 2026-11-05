/// An invitation after a complete user-triggered group test, never a claim
/// that every node in every group is broken. A successful batch rearms it.
class NetworkFailurePromptGate {
  Object? _session;
  bool _notified = false;

  bool observe({
    required Object session,
    required int expected,
    required Iterable<int?> results,
    required bool current,
    required bool running,
  }) {
    if (!current || !running) return false;
    if (_session != session) {
      _session = session;
      _notified = false;
    }
    final values = results.toList();
    if (values.any((value) => value != null && value > 0)) {
      _notified = false;
      return false;
    }
    if (_notified ||
        expected < 2 ||
        values.length != expected ||
        values.any((value) => value != -1)) {
      return false;
    }
    _notified = true;
    return true;
  }
}

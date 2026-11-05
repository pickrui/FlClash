import 'package:fl_clash/common/network_failure_prompt.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late NetworkFailurePromptGate gate;
  setUp(() => gate = NetworkFailurePromptGate());
  bool observe(
    List<int?> results, {
    Object session = 'profile/run',
    int? expected,
    bool current = true,
    bool running = true,
  }) => gate.observe(
    session: session,
    expected: expected ?? results.length,
    results: results,
    current: current,
    running: running,
  );
  test('complete failure prompts once and a successful batch rearms', () {
    expect(observe([-1, -1]), isTrue);
    expect(observe([-1, -1]), isFalse);
    expect(observe([-1, 50]), isFalse);
    expect(observe([-1, -1]), isTrue);
  });
  test('a new profile or core session can prompt again', () {
    expect(observe([-1, -1], session: (1, 100)), isTrue);
    expect(observe([-1, -1], session: (1, 100)), isFalse);
    expect(observe([-1, -1], session: (2, 100)), isTrue);
    expect(observe([-1, -1], session: (2, 101)), isTrue);
  });
  test('canceled pending single empty or incomplete tests never prompt', () {
    for (final values in <List<int?>>[
      [],
      [-1],
      [-1, null],
      [-1, 0],
      [-1, 10],
    ]) {
      expect(observe(values), isFalse, reason: '$values');
    }
    expect(observe([-1, -1], expected: 3), isFalse);
    expect(observe([-1, -1]), isTrue);
  });
  test('stale and stopped runs cannot prompt or rearm an existing prompt', () {
    expect(observe([-1, -1], current: false), isFalse);
    expect(observe([-1, -1], running: false), isFalse);
    expect(observe([-1, -1]), isTrue);
    expect(observe([40, 50], current: false), isFalse);
    expect(observe([40, 50], running: false), isFalse);
    expect(observe([-1, -1]), isFalse);
  });
}

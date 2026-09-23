import 'dart:async';

import 'package:fl_clash/common/indexing.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _GlobalRules extends GlobalRules {
  @override
  Stream<List<Rule>> build() => Stream.value([
    for (var id = 5; id > 0; id--)
      Rule(id: id, value: 'DOMAIN,$id.example,DIRECT', order: 'a${id - 1}'),
  ]);
}

Profile _profile(int id) => Profile(
  id: id,
  autoUpdateDuration: const Duration(hours: 1),
  order: id - 1,
);

Future<GlobalRules> _globalRules() async {
  final container = ProviderContainer(
    overrides: [globalRulesProvider.overrideWith(_GlobalRules.new)],
  );
  addTearDown(container.dispose);
  container.listen(globalRulesProvider, (_, _) {});
  await container.read(globalRulesProvider.future);
  return container.read(globalRulesProvider.notifier);
}

void _expectDescendingKeys(List<Rule> rules) {
  final orders = rules.map((rule) => rule.order!).toList();
  for (var i = 1; i < orders.length; i++) {
    expect(orders[i - 1].compareTo(orders[i]), greaterThan(0));
  }
}

void main() {
  // Writes stay queued behind this, so the notifiers keep their optimistic
  // state, as they do while a real write is still pending.
  setUpAll(() {
    unawaited(databaseWriteQueue.add(() => Completer<void>().future));
  });

  test('a rule moved twice before its write lands keeps valid keys', () async {
    final notifier = await _globalRules();

    notifier.order(4, 0);
    notifier.order(4, 1);

    final rules = notifier.value;
    expect(rules.map((rule) => rule.id), [1, 2, 5, 4, 3]);
    _expectDescendingKeys(rules);
  });

  test('a rule added before its write lands is keyed above the top', () async {
    final notifier = await _globalRules();

    notifier.put(const Rule(id: 6, value: 'DOMAIN,6.example,DIRECT'));
    notifier.order(5, 1);

    final rules = notifier.value;
    expect(rules.map((rule) => rule.id), [6, 1, 5, 4, 3, 2]);
    expect(rules.first.order, indexing.generateKeyBetween('a4', null));
    _expectDescendingKeys(rules);
  });

  test('an edited rule keeps its key', () async {
    final notifier = await _globalRules();

    const edited = Rule(id: 3, value: 'DOMAIN,edited.example,DIRECT');
    notifier.put(edited);

    expect(notifier.value[2], edited.copyWith(order: 'a2'));
  });

  test('reordered profiles carry their new order', () async {
    final container = ProviderContainer(
      overrides: [
        profilesStreamProvider.overrideWith(
          (ref) => Stream.value([_profile(1), _profile(2), _profile(3)]),
        ),
      ],
    );
    addTearDown(container.dispose);
    container.listen(profilesProvider, (_, _) {});
    await container.read(profilesStreamProvider.future);

    container
        .read(profilesProvider.notifier)
        .reorder(container.read(profilesProvider).reversed.toList());

    expect(container.read(profilesProvider).map((p) => (p.id, p.order)), [
      (3, 0),
      (2, 1),
      (1, 2),
    ]);
  });

  test('reorder applies ids to the current profiles', () async {
    final container = ProviderContainer(
      overrides: [
        profilesStreamProvider.overrideWith(
          (ref) => Stream.value([_profile(1), _profile(2), _profile(3)]),
        ),
      ],
    );
    addTearDown(container.dispose);
    container.listen(profilesProvider, (_, _) {});
    await container.read(profilesStreamProvider.future);
    final notifier = container.read(profilesProvider.notifier);
    final stale = container.read(profilesProvider);

    notifier.updateProfile(2, (profile) => profile.copyWith(label: 'renamed'));
    notifier.reorder([stale[2], stale[1], _profile(9)]);

    expect(
      container.read(profilesProvider).map((p) => (p.id, p.label, p.order)),
      [(3, '', 0), (2, 'renamed', 1), (1, '', 2)],
    );
  });
}

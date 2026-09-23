import 'dart:async';

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

void main() {
  // Writes stay queued behind this, so the notifiers keep their optimistic
  // state, as they do while a real write is still pending.
  setUpAll(() {
    unawaited(databaseWriteQueue.add(() => Completer<void>().future));
  });

  test('a rule moved twice before its write lands keeps valid keys', () async {
    final container = ProviderContainer(
      overrides: [globalRulesProvider.overrideWith(_GlobalRules.new)],
    );
    addTearDown(container.dispose);
    container.listen(globalRulesProvider, (_, _) {});
    await container.read(globalRulesProvider.future);
    final notifier = container.read(globalRulesProvider.notifier);

    notifier.order(4, 0);
    notifier.order(4, 1);

    final rules = notifier.value;
    expect(rules.map((rule) => rule.id), [1, 2, 5, 4, 3]);
    final orders = rules.map((rule) => rule.order!).toList();
    for (var i = 1; i < orders.length; i++) {
      expect(orders[i - 1].compareTo(orders[i]), greaterThan(0));
    }
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
}

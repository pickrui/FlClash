import 'package:drift/native.dart';
import 'package:fl_clash/database/database.dart';
import 'package:fl_clash/models/models.dart';
import 'package:test/test.dart';

void main() {
  test('setting orders leaves other columns and missing rows alone', () async {
    final database = Database(NativeDatabase.memory());
    addTearDown(database.close);
    for (final (id, label) in [(1, 'first'), (2, 'second')]) {
      await database.putProfile(
        Profile(
          id: id,
          label: label,
          autoUpdateDuration: Duration.zero,
          order: id - 1,
        ),
      );
    }

    await database.profilesDao.setOrders({1: 1, 2: 0, 3: 2});

    final profiles = await database.profilesDao.all().get();
    expect(
      profiles.map((profile) => (profile.id, profile.label, profile.order)),
      [(2, 'second', 0), (1, 'first', 1)],
    );
  });
}

import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';

part 'generated/database.g.dart';
part 'links.dart';
part 'profiles.dart';
part 'rules.dart';
part 'scripts.dart';

const currentDatabaseSchemaVersion = 3;

@DriftDatabase(
  tables: [Profiles, Scripts, Rules, ProfileRuleLinks],
  daos: [ProfilesDao, ScriptsDao, RulesDao],
)
class Database extends _$Database {
  Database([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => currentDatabaseSchemaVersion;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        await customStatement('''
          DELETE FROM profile_rule_mapping
          WHERE rule_id NOT IN (SELECT id FROM rules)
             OR (profile_id IS NOT NULL AND profile_id NOT IN (SELECT id FROM profiles))
        ''');
        await customStatement('PRAGMA foreign_keys = ON');
      },
      onUpgrade: (m, from, to) async {
        final profileColumns = await _profileColumnNames();
        if (from < 2) {
          if (profileColumns.add('proxy_chains')) {
            await m.addColumn(profiles, profiles.proxyChains);
          }
          if (profileColumns.add('profile_proxies')) {
            await m.addColumn(profiles, profiles.profileProxies);
          }
        }
        if (from < 3) {
          if (profileColumns.add('custom_proxy_groups')) {
            await m.addColumn(profiles, profiles.customProxyGroups);
          }
          if (profileColumns.add('custom_rules')) {
            await m.addColumn(profiles, profiles.customRules);
          }
        }
      },
    );
  }

  Future<Set<String>> _profileColumnNames() async {
    final rows = await customSelect('PRAGMA table_info("profiles")').get();
    return rows.map((row) => row.read<String>('name')).toSet();
  }

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final databaseFile = File(await appPath.databasePath);
      return NativeDatabase.createInBackground(databaseFile);
    });
  }

  Future<void> createSnapshot(String path) async {
    final file = File(path);
    await file.safeDelete();
    final escapedPath = path.replaceAll("'", "''");
    await customStatement("VACUUM INTO '$escapedPath'");
  }

  Future<void> restore(
    List<Profile> profiles,
    List<Script> scripts,
    List<Rule> rules,
    List<ProfileRuleLink> links, {
    bool isOverride = false,
  }) async {
    await batch((b) {
      if (isOverride) {
        profilesDao.setAllWithBatch(b, profiles);
        scriptsDao.setAllWithBatch(b, scripts);
        rulesDao.restoreWithBatch(b, rules, links);
      } else {
        profilesDao.putAllWithBatch(
          b,
          profiles.map((item) => item.toCompanion()),
        );
        b.insertAllOnConflictUpdate(
          this.scripts,
          scripts.map((item) => item.toCompanion()),
        );
        b.insertAllOnConflictUpdate(
          this.rules,
          rules.map((item) => item.toCompanion()),
        );
        b.insertAllOnConflictUpdate(
          profileRuleLinks,
          links.map((item) => item.toCompanion()),
        );
      }
    });
  }

  Future<List<int>> deleteScriptAndClearReferences(int scriptId) {
    return transaction(() async {
      final affectedProfileIds =
          await (select(profiles)
                ..where((table) => table.scriptId.equals(scriptId)))
              .map((row) => row.id)
              .get();
      await (update(profiles)
            ..where((table) => table.scriptId.equals(scriptId)))
          .write(const ProfilesCompanion(scriptId: Value(null)));
      await scripts.remove((table) => table.id.equals(scriptId));
      return affectedProfileIds;
    });
  }
}

extension TableInfoExt<Tbl extends Table, Row> on TableInfo<Tbl, Row> {
  void setAll(
    Batch batch,
    Iterable<Insertable<Row>> items, {
    required Expression<bool> Function(Tbl tbl) deleteFilter,
  }) async {
    batch.insertAllOnConflictUpdate(this, items);
    batch.deleteWhere(this, deleteFilter);
  }

  Future<int> remove(Expression<bool> Function(Tbl tbl) filter) async {
    return (delete()..where(filter)).go();
  }

  Future<int> put(Insertable<Row> item) async {
    return insertOnConflictUpdate(item);
  }
}

final database = Database();

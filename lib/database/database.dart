import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';

part 'generated/database.g.dart';
part 'converter.dart';
part 'groups.dart';
part 'icons.dart';
part 'links.dart';
part 'profiles.dart';
part 'rules.dart';
part 'scripts.dart';

const currentDatabaseSchemaVersion = 4;

@DriftDatabase(
  tables: [
    Profiles,
    Scripts,
    Rules,
    ProfileRuleLinks,
    ProxyGroups,
    IconRecords,
  ],
  daos: [ProfilesDao, ScriptsDao, RulesDao, ProxyGroupsDao, IconRecordsDao],
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
        await customStatement(
          'DELETE FROM rules WHERE id NOT IN (SELECT rule_id FROM profile_rule_mapping)',
        );
        await rulesDao.repairOrders();
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
        if (from < 4) {
          if (profileColumns.add('match_target')) {
            await m.addColumn(profiles, profiles.matchTarget);
          }
          final tables = (await customSelect(
            "SELECT name FROM sqlite_master WHERE type = 'table'",
          ).get()).map((row) => row.read<String>('name')).toSet();
          if (!tables.contains('proxy_groups')) {
            await m.createTable(proxyGroups);
          }
          if (!tables.contains('icon_records')) {
            await m.createTable(iconRecords);
          }
          final ruleColumns = (await customSelect(
            'PRAGMA table_info(rules)',
          ).get()).map((row) => row.read<String>('name')).toSet();
          for (final column in [
            rules.ruleAction,
            rules.content,
            rules.ruleTarget,
            rules.ruleProvider,
            rules.subRule,
            rules.noResolve,
            rules.src,
          ]) {
            if (!ruleColumns.contains(column.name)) {
              await m.addColumn(rules, column);
            }
          }
          final linkColumns = (await customSelect(
            'PRAGMA table_info(profile_rule_mapping)',
          ).get()).map((row) => row.read<String>('name')).toSet();
          if (!linkColumns.contains('source_id')) {
            await m.addColumn(profileRuleLinks, profileRuleLinks.sourceId);
          }
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_rule_target ON rules(rule_target)',
          );
          for (final rule in await select(rules).get()) {
            await into(
              rules,
            ).insertOnConflictUpdate(rule.toRule().toCompanion());
          }
          final existing = await profilesDao.all().get();
          await batch((batch) async {
            for (final profile in existing) {
              await proxyGroupsDao.replaceWithBatch(batch, profile);
              await rulesDao.replaceCustomWithBatch(batch, profile);
            }
          });
        }
      },
    );
  }

  /// The profile snapshot keeps older JSON backups compatible. Normalized groups
  /// are replaced in the same transaction, so UI queries never see a half-write.
  Future<void> putProfile(Profile profile) => transaction(() async {
    final previous = await (select(
      profiles,
    )..where((row) => row.id.equals(profile.id))).getSingleOrNull();
    await into(profiles).insertOnConflictUpdate(profile.toCompanion());
    await batch((batch) async {
      if (previous == null ||
          !proxyGroupsEquality.equals(
            previous.customProxyGroups,
            profile.customProxyGroups,
          )) {
        await proxyGroupsDao.replaceWithBatch(batch, profile);
      }
      if (previous == null ||
          !ruleListEquality.equals(previous.customRules, profile.customRules)) {
        await rulesDao.replaceCustomWithBatch(batch, profile);
      }
    });
  });

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
    await transaction(() async {
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
      await batch((b) async {
        for (final profile in profiles) {
          await proxyGroupsDao.replaceWithBatch(b, profile);
          await rulesDao.replaceCustomWithBatch(b, profile);
        }
      });
      await rulesDao.repairOrders();
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
    bool preDelete = false,
  }) {
    if (preDelete) batch.deleteWhere(this, deleteFilter);
    batch.insertAllOnConflictUpdate(this, items);
    if (!preDelete) batch.deleteWhere(this, deleteFilter);
  }

  Selectable<int?> get count {
    final expression = countAll();
    final query = select().addColumns([expression]);
    return query.map((row) => row.read(expression));
  }

  Future<int> remove(Expression<bool> Function(Tbl tbl) filter) async {
    return (delete()..where(filter)).go();
  }

  Future<int> put(Insertable<Row> item) async {
    return insertOnConflictUpdate(item);
  }
}

final database = Database();

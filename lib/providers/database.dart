import 'dart:async';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/database/database.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/database.g.dart';

class RollbackScope<T> {
  final T _originData;
  final Future Function() _handler;

  RollbackScope(this._originData, this._handler);

  void onRollback(void Function(T data) callback) {
    try {
      _handler().catchError((e) {
        callback(_originData);
      });
    } catch (e) {
      callback(_originData);
      rethrow;
    }
  }
}

RollbackScope<T> withRollback<T>(T originData, Future Function() handler) {
  return RollbackScope(originData, handler);
}

@riverpod
Stream<List<Profile>> profilesStream(Ref ref) {
  return database.profilesDao.query().watch();
}

@riverpod
Stream<List<Rule>> addedRulesStream(Ref ref, int profileId) {
  return database.rulesDao.queryAddedRules(profileId).watch();
}

@riverpod
Stream<int> customRulesCount(Ref ref, int profileId) {
  return database.rulesDao.profileCustomRulesCount(profileId).watchSingle();
}

@riverpod
Stream<int> proxyGroupsCount(Ref ref, int profileId) {
  return database.proxyGroupsDao.count(profileId).watchSingle();
}

@Riverpod(keepAlive: true)
class Profiles extends _$Profiles {
  @override
  List<Profile> build() {
    return ref.watch(profilesStreamProvider).value ?? [];
  }

  void put(Profile profile) {
    withRollback(state, () {
      final newProfile = state.optimizeLabel(profile);
      state.copyAndPut(newProfile, (item) => item.id == newProfile.id);
      return database.profiles.put(newProfile.toCompanion());
    }).onRollback((v) => state = v);
  }

  void del(int id) {
    withRollback(state, () {
      state = state.where((e) => e.id != id).toList();
      return database.profiles.remove((t) => t.id.equals(id));
    }).onRollback((v) => state = v);
  }

  void updateProfile(int profileId, Profile Function(Profile profile) builder) {
    final index = state.indexWhere((element) => element.id == profileId);
    if (index == -1) return;
    final newProfile = builder(state[index]);
    withRollback(state, () {
      final temp = List<Profile>.from(state);
      temp[index] = newProfile;
      state = temp;
      return database.profiles.put(newProfile.toCompanion());
    }).onRollback((v) => state = v);
  }

  void setAndReorder(List<Profile> profiles) {
    withRollback(state, () {
      state = List<Profile>.from(profiles);
      return database.profilesDao.setAll(profiles);
    }).onRollback((v) => state = v);
  }

  void reorder(List<Profile> profiles) {
    withRollback(state, () {
      state = List<Profile>.from(profiles);
      final needUpdate = <ProfilesCompanion>[];
      state.forEachIndexed((index, item) {
        if (item.order != index) {
          needUpdate.add(item.toCompanion(index));
        }
      });
      return database.profilesDao.putAll(needUpdate);
    }).onRollback((v) => state = v);
  }

  @override
  bool updateShouldNotify(List<Profile> previous, List<Profile> next) {
    return !profileListEquality.equals(previous, next);
  }
}

@riverpod
class Scripts extends _$Scripts with AsyncNotifierMixin {
  @override
  Stream<List<Script>> build() {
    return database.scriptsDao.query().watch();
  }

  @override
  List<Script> get value => state.value ?? [];

  void put(Script script) {
    final index = value.indexWhere((item) => item.id == script.id);
    withRollback(value, () {
      final list = List<Script>.from(value);
      if (index != -1) {
        list[index] = script;
      } else {
        list.add(script);
      }
      value = list;
      return database.scripts.put(script.toCompanion());
    }).onRollback((v) => value = v);
  }

  void del(int id) {
    final index = value.indexWhere((item) => item.id == id);
    if (index == -1) return;
    withRollback(value, () {
      final list = List<Script>.from(value);
      list.removeAt(index);
      value = list;
      return database.scripts.remove((t) => t.id.equals(id));
    }).onRollback((v) => value = v);
  }

  bool isExits(String label) {
    return value.indexWhere((item) => item.label == label) != -1;
  }

  @override
  bool updateShouldNotify(
    AsyncValue<List<Script>> previous,
    AsyncValue<List<Script>> next,
  ) {
    return !scriptListEquality.equals(previous.value, next.value);
  }
}

@riverpod
Future<Script?> script(Ref ref, int? scriptId) async {
  final script = ref.watch(
    scriptsProvider.future.select((state) async {
      final scripts = await state;
      return scripts.get(scriptId);
    }),
  );
  return script;
}

@riverpod
class GlobalRules extends _$GlobalRules with AsyncNotifierMixin {
  @override
  Stream<List<Rule>> build() {
    return database.rulesDao.queryGlobalAddedRules().watch();
  }

  @override
  List<Rule> get value => state.value ?? [];

  @override
  bool updateShouldNotify(
    AsyncValue<List<Rule>> previous,
    AsyncValue<List<Rule>> next,
  ) {
    return !ruleListEquality.equals(previous.value, next.value);
  }

  void delAll(Iterable<int> ruleIds) {
    withRollback(value, () {
      value = List.from(value.where((item) => !ruleIds.contains(item.id)));
      return database.rulesDao.delRules(ruleIds);
    }).onRollback((v) => value = v);
  }

  void put(Rule rule) {
    withRollback(value, () {
      final newRule = rule.autoOrder(rule, null, value.firstOrNull?.order);
      value = value.copyAndPut(newRule, (rule) => rule.id == newRule.id);
      return database.rulesDao.putGlobalRule(newRule);
    }).onRollback((v) => value = v);
  }

  void order(int oldIndex, int newIndex) {
    withRollback(value, () {
      int insertIndex = newIndex;
      if (oldIndex < newIndex) insertIndex -= 1;
      final nextItems = List<Rule>.from(value);
      final item = nextItems.removeAt(oldIndex);
      nextItems.insert(insertIndex, item);
      value = nextItems;
      final preOrder = nextItems.safeGet(insertIndex - 1)?.order;
      final nextOrder = nextItems.safeGet(insertIndex + 1)?.order;
      final newOrder = indexing.generateKeyBetween(preOrder, nextOrder)!;
      return database.rulesDao.orderGlobalRule(
        ruleId: item.id,
        order: newOrder,
      );
    }).onRollback((v) => value = v);
  }
}

@riverpod
class ProfileAddedRules extends _$ProfileAddedRules with AsyncNotifierMixin {
  @override
  Stream<List<Rule>> build(int profileId) {
    return database.rulesDao.queryProfileAddedRules(profileId).watch();
  }

  @override
  List<Rule> get value => state.value ?? [];

  @override
  bool updateShouldNotify(
    AsyncValue<List<Rule>> previous,
    AsyncValue<List<Rule>> next,
  ) {
    return !ruleListEquality.equals(previous.value, next.value);
  }

  void put(Rule rule) {
    withRollback(value, () {
      final newRule = rule.autoOrder(rule, null, value.firstOrNull?.order);
      value = value.copyAndPut(newRule, (rule) => rule.id == newRule.id);
      return database.rulesDao.putProfileAddedRule(profileId, newRule);
    }).onRollback((v) => value = v);
  }

  void delAll(Iterable<int> ruleIds) {
    withRollback(value, () {
      value = List.from(value.where((item) => !ruleIds.contains(item.id)));
      return database.rulesDao.delRules(ruleIds);
    }).onRollback((v) => value = v);
  }

  void order(int oldIndex, int newIndex) {
    withRollback(value, () {
      int insertIndex = newIndex;
      if (oldIndex < newIndex) insertIndex -= 1;
      final nextItems = List<Rule>.from(value);
      final item = nextItems.removeAt(oldIndex);
      nextItems.insert(insertIndex, item);
      value = nextItems;
      final preOrder = nextItems.safeGet(insertIndex - 1)?.order;
      final nextOrder = nextItems.safeGet(insertIndex + 1)?.order;
      final newOrder = indexing.generateKeyBetween(preOrder, nextOrder)!;
      return database.rulesDao.orderProfileAddedRule(
        profileId,
        ruleId: item.id,
        order: newOrder,
      );
    }).onRollback((v) => value = v);
  }
}

@riverpod
class ProfileCustomRules extends _$ProfileCustomRules with AsyncNotifierMixin {
  @override
  Stream<List<Rule>> build(int profileId) {
    return database.rulesDao.queryProfileCustomRules(profileId).watch();
  }

  @override
  List<Rule> get value => state.value ?? [];

  @override
  bool updateShouldNotify(
    AsyncValue<List<Rule>> previous,
    AsyncValue<List<Rule>> next,
  ) {
    return !ruleListEquality.equals(previous.value, next.value);
  }

  void put(Rule rule) {
    withRollback(value, () {
      final newRule = rule.autoOrder(rule, null, value.firstOrNull?.order);
      value = value.copyAndPut(newRule, (rule) => rule.id == newRule.id);
      return database.rulesDao.putProfileCustomRule(profileId, newRule);
    }).onRollback((v) => value = v);
  }

  void delAll(Iterable<int> ruleIds) {
    withRollback(value, () {
      value = List.from(value.where((item) => !ruleIds.contains(item.id)));
      return database.rulesDao.delRules(ruleIds);
    }).onRollback((v) => value = v);
  }

  void order(int oldIndex, int newIndex) {
    withRollback(value, () {
      int insertIndex = newIndex;
      if (oldIndex < newIndex) insertIndex -= 1;
      final nextItems = List<Rule>.from(value);
      final item = nextItems.removeAt(oldIndex);
      nextItems.insert(insertIndex, item);
      value = nextItems;
      final preOrder = nextItems.safeGet(insertIndex - 1)?.order;
      final nextOrder = nextItems.safeGet(insertIndex + 1)?.order;
      final newOrder = indexing.generateKeyBetween(preOrder, nextOrder)!;
      return database.rulesDao.orderProfileCustomRule(
        profileId,
        ruleId: item.id,
        order: newOrder,
      );
    }).onRollback((v) => value = v);
  }
}

@riverpod
class ProxyGroups extends _$ProxyGroups with AsyncNotifierMixin {
  @override
  Stream<List<ProxyGroup>> build(int profileId) {
    return database.proxyGroupsDao.query(profileId).watch();
  }

  @override
  bool updateShouldNotify(
    AsyncValue<List<ProxyGroup>> previous,
    AsyncValue<List<ProxyGroup>> next,
  ) {
    return !proxyGroupsEquality.equals(previous.value, next.value);
  }

  void del(String name) {
    withRollback(value, () {
      value = List.from(value.where((item) => item.name != name));
      return database.proxyGroups.remove(
        (t) => t.profileId.equals(profileId) & t.name.equals(name),
      );
    }).onRollback((v) => value = v);
  }

  bool put(ProxyGroup proxyGroup) {
    final index = value.indexWhere((item) => item.id == proxyGroup.id);
    if (index == -1 &&
        value.indexWhere((item) => item.name == proxyGroup.name) != -1) {
      return false;
    }
    if (index != -1) {
      final oldName = value[index].name;
      final newName = proxyGroup.name;
      if (oldName != newName) {
        database.rulesDao.renameCustomRuleTarget(
          profileId,
          oldName: oldName,
          newName: newName,
        );
        database.proxyGroupsDao.renameProxies(
          profileId,
          oldName: oldName,
          newName: newName,
        );
      }
    }
    final icon = proxyGroup.icon?.value;
    if (icon != null) {
      database.iconRecordsDao.put(icon);
    }
    withRollback(value, () {
      final newList = [...value];
      if (index != -1) {
        newList[index] = proxyGroup;
      } else {
        newList.add(
          proxyGroup.copyWith(
            order: indexing.generateKeyBetween(null, proxyGroup.order),
          ),
        );
      }
      value = newList;
      return database.proxyGroups.put(proxyGroup.toCompanion(profileId));
    }).onRollback((v) => value = v);
    return true;
  }

  void order(int oldIndex, int newIndex) {
    withRollback(value, () {
      int insertIndex = newIndex;
      if (oldIndex < newIndex) insertIndex -= 1;
      final nextItems = List<ProxyGroup>.from(value);
      final item = nextItems.removeAt(oldIndex);
      nextItems.insert(insertIndex, item);
      value = nextItems;
      final preOrder = nextItems.safeGet(insertIndex - 1)?.order;
      final nextOrder = nextItems.safeGet(insertIndex + 1)?.order;
      final newOrder = indexing.generateKeyBetween(preOrder, nextOrder)!;
      return database.proxyGroupsDao.order(
        profileId,
        proxyGroup: item,
        order: newOrder,
      );
    }).onRollback((v) => value = v);
  }

  @override
  List<ProxyGroup> get value => state.value ?? [];
}

@riverpod
class ProfileDisabledRuleIds extends _$ProfileDisabledRuleIds
    with AsyncNotifierMixin {
  @override
  List<int> get value => state.value ?? [];

  @override
  Stream<List<int>> build(int profileId) {
    return database.rulesDao
        .queryProfileDisabledRules(profileId)
        .map((item) => item.id)
        .watch();
  }

  @override
  bool updateShouldNotify(
    AsyncValue<List<int>> previous,
    AsyncValue<List<int>> next,
  ) {
    return !intListEquality.equals(previous.value, next.value);
  }

  void _put(int ruleId) {
    final newList = List<int>.from(value);
    final index = newList.indexWhere((item) => item == ruleId);
    if (index != -1) {
      newList[index] = ruleId;
    } else {
      newList.insert(0, ruleId);
    }
    value = newList;
  }

  void del(int ruleId) {
    withRollback(value, () {
      value = List.from(value.where((item) => item != ruleId));
      return database.rulesDao.delDisabledLink(profileId, ruleId);
    }).onRollback((v) => value = v);
  }

  void put(int ruleId) {
    withRollback(value, () {
      _put(ruleId);
      return database.rulesDao.putDisabledLink(profileId, ruleId);
    }).onRollback((v) => value = v);
  }
}

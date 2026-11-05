import 'dart:async';

import 'package:collection/collection.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/database/database.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/database.g.dart';

Future<void> withRollback<T>({
  required T snapshot,
  required FutureOr<void> Function() action,
  required void Function(T snapshot) rollback,
}) async {
  try {
    await action();
  } catch (e, s) {
    rollback(snapshot);
    Error.throwWithStackTrace(e, s);
  }
}

class DatabaseWriteQueue {
  Future<void> _tail = Future.value();
  Object? _error;
  StackTrace? _stackTrace;

  Future<void> add(
    FutureOr<void> Function() action, {
    bool reportOnWait = true,
  }) {
    final operation = _tail.then((_) => action());
    _tail = operation.catchError((Object error, StackTrace stackTrace) {
      if (reportOnWait) {
        _error ??= error;
        _stackTrace ??= stackTrace;
      }
    });
    return operation;
  }

  Future<void> wait() async {
    while (true) {
      final tail = _tail;
      await tail;
      if (identical(tail, _tail)) {
        break;
      }
    }
    final error = _error;
    final stackTrace = _stackTrace;
    _error = null;
    _stackTrace = null;
    if (error != null) {
      Error.throwWithStackTrace(error, stackTrace ?? StackTrace.current);
    }
  }
}

final databaseWriteQueue = DatabaseWriteQueue();
var _databaseWritesSuspended = false;

Future<void> suspendDatabaseWrites() async {
  _databaseWritesSuspended = true;
  await databaseWriteQueue.wait();
}

void resumeDatabaseWrites() {
  _databaseWritesSuspended = false;
}

Future<void> waitForPendingDatabaseWrites() {
  return databaseWriteQueue.wait();
}

Future<void> queueDatabaseWrite(
  FutureOr<void> Function() action, {
  void Function()? onError,
  bool reportOnWait = true,
  void Function()? onFinished,
}) {
  if (_databaseWritesSuspended) {
    final error = StateError('database writes are suspended');
    onError?.call();
    onFinished?.call();
    FlutterError.reportError(
      FlutterErrorDetails(exception: error, library: 'database'),
    );
    final operation = Future<void>.error(error);
    unawaited(operation.catchError((_) {}));
    return operation;
  }
  final operation = databaseWriteQueue.add(() async {
    try {
      await action();
    } catch (error, stackTrace) {
      onError?.call();
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
          library: 'database',
        ),
      );
      rethrow;
    } finally {
      onFinished?.call();
    }
  }, reportOnWait: reportOnWait);
  unawaited(operation.catchError((_) {}));
  return operation;
}

Future<T> runExclusiveDatabaseOperation<T>(Future<T> Function() action) async {
  final completer = Completer<T>();
  databaseWriteQueue.add(() async {
    try {
      completer.complete(await action());
    } catch (error, stackTrace) {
      completer.completeError(error, stackTrace);
      rethrow;
    }
  }, reportOnWait: false);
  return completer.future;
}

void reloadProviderAfterDatabaseError(Ref ref) {
  if (ref.mounted) {
    ref.invalidateSelf(asReload: true);
  }
}

@riverpod
Stream<List<Profile>> profilesStream(Ref ref) {
  return database.profilesDao.all().watch();
}

@riverpod
Stream<List<Rule>> addedRuleStream(Ref ref, int profileId) {
  return database.rulesDao.allAddedRules(profileId).watch();
}

@Riverpod(keepAlive: true)
class Profiles extends _$Profiles {
  int _pendingWrites = 0;

  @override
  List<Profile> build() {
    final databaseProfiles = ref.watch(profilesStreamProvider).value;
    if (_pendingWrites > 0) {
      return stateOrNull ?? const [];
    }
    return databaseProfiles ?? stateOrNull ?? const [];
  }

  Future<void> _queueWrite(
    FutureOr<void> Function() action, {
    bool reportOnWait = true,
  }) {
    _pendingWrites++;
    return queueDatabaseWrite(
      action,
      onError: () => reloadProviderAfterDatabaseError(ref),
      reportOnWait: reportOnWait,
      onFinished: () => _pendingWrites--,
    );
  }

  Future<void> put(Profile profile, {bool reportOnWait = true}) {
    final vm2 = state.copyAndAddProfile(profile);
    final nextProfiles = vm2.a;
    final newProfile = vm2.b;
    state = nextProfiles;
    return _queueWrite(
      () => database.profiles.put(newProfile.toCompanion()),
      reportOnWait: reportOnWait,
    );
  }

  void replaceFromDatabase(List<Profile> profiles) {
    state = List<Profile>.from(profiles);
  }

  Future<void> del(int id, {bool reportOnWait = true}) {
    final newProfiles = state.where((element) => element.id != id).toList();
    state = newProfiles;
    return _queueWrite(
      () => database.profiles.remove((t) => t.id.equals(id)),
      reportOnWait: reportOnWait,
    );
  }

  void updateProfile(int profileId, Profile Function(Profile profile) builder) {
    final index = state.indexWhere((element) => element.id == profileId);
    if (index == -1) {
      return;
    }
    final List<Profile> profilesTemp = List.from(state);
    final newProfile = builder(profilesTemp[index]);
    profilesTemp[index] = newProfile;
    state = profilesTemp;
    _queueWrite(() => database.profiles.put(newProfile.toCompanion()));
  }

  Future<void> setAndReorder(List<Profile> profiles) {
    final newProfiles = List<Profile>.from(profiles);
    state = newProfiles;
    return _queueWrite(() => database.profilesDao.setAll(profiles));
  }

  void reorder(List<Profile> profiles) {
    final newProfiles = List<Profile>.from(profiles);
    state = newProfiles;
    final List<ProfilesCompanion> needUpdateProfiles = [];
    newProfiles.forEachIndexed((index, item) {
      if (item.order != index) {
        needUpdateProfiles.add(item.toCompanion(index));
      }
    });
    _queueWrite(() => database.profilesDao.putAll(needUpdateProfiles));
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
    return database.scriptsDao.all().watch();
  }

  @override
  List<Script> get value => state.value ?? [];

  Future<void> put(Script script, {bool reportOnWait = true}) {
    final list = List<Script>.from(value);
    final index = value.indexWhere((item) => item.id == script.id);
    if (index != -1) {
      list[index] = script;
    } else {
      list.add(script);
    }
    value = list;
    return queueDatabaseWrite(
      () => database.scripts.put(script.toCompanion()),
      onError: () => reloadProviderAfterDatabaseError(ref),
      reportOnWait: reportOnWait,
    );
  }

  void replaceFromDatabase(List<Script> scripts) {
    value = List<Script>.from(scripts);
  }

  Future<void> del(int id, {bool reportOnWait = true}) {
    final index = value.indexWhere((item) => item.id == id);
    if (index == -1) {
      return Future.value();
    }
    final list = List<Script>.from(value);
    list.removeAt(index);
    value = list;
    return queueDatabaseWrite(
      () => database.scripts.remove((t) => t.id.equals(id)),
      onError: () => reloadProviderAfterDatabaseError(ref),
      reportOnWait: reportOnWait,
    );
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
class GlobalRules extends _$GlobalRules with AsyncNotifierMixin {
  @override
  Stream<List<Rule>> build() {
    return database.rulesDao.allGlobalAddedRules().watch();
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
    value = List<Rule>.from(value.where((item) => !ruleIds.contains(item.id)));
    queueDatabaseWrite(
      () => database.rulesDao.delRules(ruleIds),
      onError: () => reloadProviderAfterDatabaseError(ref),
    );
  }

  void put(Rule rule) {
    value = value.copyAndPut(rule);
    queueDatabaseWrite(
      () => database.rulesDao.putGlobalRule(rule),
      onError: () => reloadProviderAfterDatabaseError(ref),
    );
  }

  void order(int oldIndex, int newIndex) {
    final nextItems = List<Rule>.from(value);
    final item = nextItems.removeAt(oldIndex);
    nextItems.insert(newIndex, item);
    value = nextItems;
    final preOrder = nextItems.safeGet(newIndex - 1)?.order;
    final nextOrder = nextItems.safeGet(newIndex + 1)?.order;
    final newOrder = indexing.generateKeyBetween(nextOrder, preOrder)!;
    queueDatabaseWrite(
      () => database.rulesDao.orderGlobalRule(ruleId: item.id, order: newOrder),
      onError: () => reloadProviderAfterDatabaseError(ref),
    );
  }
}

@riverpod
class ProfileAddedRules extends _$ProfileAddedRules with AsyncNotifierMixin {
  @override
  Stream<List<Rule>> build(int profileId) {
    return database.rulesDao.allProfileAddedRules(profileId).watch();
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
    value = value.copyAndPut(rule);
    queueDatabaseWrite(
      () => database.rulesDao.putProfileAddedRule(profileId, rule),
      onError: () => reloadProviderAfterDatabaseError(ref),
    );
  }

  void delAll(Iterable<int> ruleIds) {
    value = List<Rule>.from(value.where((item) => !ruleIds.contains(item.id)));
    queueDatabaseWrite(
      () => database.rulesDao.delRules(ruleIds),
      onError: () => reloadProviderAfterDatabaseError(ref),
    );
  }

  void order(int oldIndex, int newIndex) {
    final nextItems = List<Rule>.from(value);
    final item = nextItems.removeAt(oldIndex);
    nextItems.insert(newIndex, item);
    value = nextItems;
    final preOrder = nextItems.safeGet(newIndex - 1)?.order;
    final nextOrder = nextItems.safeGet(newIndex + 1)?.order;
    final newOrder = indexing.generateKeyBetween(nextOrder, preOrder)!;
    queueDatabaseWrite(
      () => database.rulesDao.orderProfileAddedRule(
        profileId,
        ruleId: item.id,
        order: newOrder,
      ),
      onError: () => reloadProviderAfterDatabaseError(ref),
    );
  }
}

@riverpod
class ProfileDisabledRuleIds extends _$ProfileDisabledRuleIds
    with AsyncNotifierMixin {
  @override
  List<int> get value => state.value ?? [];

  @override
  Stream<List<int>> build(int profileId) {
    return database.rulesDao
        .allProfileDisabledRules(profileId)
        .map((item) => item.id)
        .watch();
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
    List<int> newList = List.from(value);
    newList = newList.where((item) => item != ruleId).toList();
    value = newList;
    queueDatabaseWrite(
      () => database.rulesDao.delDisabledLink(profileId, ruleId),
      onError: () => reloadProviderAfterDatabaseError(ref),
    );
  }

  void put(int ruleId) {
    _put(ruleId);
    queueDatabaseWrite(
      () => database.rulesDao.putDisabledLink(profileId, ruleId),
      onError: () => reloadProviderAfterDatabaseError(ref),
    );
  }
}

part of '../action.dart';

@Riverpod(keepAlive: true)
class BackupAction extends _$BackupAction {
  @override
  void build() {
    _controller = ref.watch(actionControllerProvider);
  }

  late AppController _controller;

  Future<void> shakingStore() => _controller.shakingStore();

  Future<String> backup() => _controller.backup();

  Future<void> restore(RestoreOption option, {String? backupPath}) =>
      _controller.restore(option, backupPath: backupPath);
}

extension BackupControllerExt on AppController {
  Future<void> shakingStore() {
    return storageLock.synchronized(
      () => runExclusiveDatabaseOperation(() async {
        final profileIds = (await database.profilesDao.all().get())
            .map((item) => item.id)
            .toList();
        final scriptIds = (await database.scriptsDao.all().get())
            .map((item) => item.id)
            .toList();
        final pathsToDelete = await shakingProfileTask(
          VM2(profileIds, scriptIds),
        );
        await Future.wait(
          pathsToDelete.map((path) async {
            final message = await coreController.deleteFile(path);
            if (message.isNotEmpty) throw message;
          }),
        );
      }),
    );
  }

  Future<String> backup() async {
    final backupData = await storageLock.synchronized(() async {
      final currentConfig = _ref.read(configProvider);
      final configMap = createBackupConfigMap(
        currentConfig,
        await preferences.getVersion(),
      );
      final storageSnapshotPath = await runExclusiveDatabaseOperation(() async {
        final snapshotPath = await appPath.tempFilePath;
        final snapshotDir = Directory(snapshotPath);
        try {
          await snapshotDir.create(recursive: true);
          final profiles = await database.profilesDao.all().get();
          final scripts = await database.scriptsDao.all().get();
          await database.createSnapshot(
            p.join(snapshotPath, backupDatabaseName),
          );
          for (final profile in profiles.where(
            (item) => item.includeInPortableBackup,
          )) {
            final source = File(
              await appPath.getProfilePath(profile.id.toString()),
            );
            final target = File(
              p.join(snapshotPath, profilesDirectoryName, profile.fileName),
            );
            await target.parent.create(recursive: true);
            await source.safeCopy(target.path);
          }
          for (final script in scripts) {
            final source = File(
              await appPath.getScriptPath(script.id.toString()),
            );
            final target = File(
              p.join(snapshotPath, 'scripts', script.fileName),
            );
            await target.parent.create(recursive: true);
            await source.safeCopy(target.path);
          }
          return snapshotPath;
        } catch (_) {
          await snapshotDir.safeDelete(recursive: true);
          rethrow;
        }
      });
      return VM2(configMap, storageSnapshotPath);
    });
    return backupTask(backupData.a, backupData.b);
  }

  Future<void> restore(RestoreOption option, {String? backupPath}) {
    return _serializeCoreLifecycle(
      () => _restoreUnlocked(option, backupPath: backupPath),
    );
  }

  Future<void> _restoreUnlocked(
    RestoreOption option, {
    String? backupPath,
  }) async {
    final restoreStrategy = _ref.read(
      appSettingProvider.select((state) => state.restoreStrategy),
    );
    final isOverride = restoreStrategy == RestoreStrategy.override;
    final wasRunning = _ref.read(isStartProvider);
    final wasCoreConnected = coreController.isCompleted;
    int? restoredProfileId;
    int? previousProfileId;
    var coreQuiesced = false;
    var restoreCommitted = false;
    var stateSynchronized = false;
    Config? committedConfig;
    var restoredAllSettings = false;
    Object? stateSynchronizationError;
    Object? restoreError;
    StackTrace? restoreStackTrace;
    RestoreJournal? restoreJournal;
    var recoveryRequired = false;
    try {
      await withProfileStorageMutation(() async {
        final restoreDirPath = await appPath.tempFilePath;
        final restoreDir = Directory(restoreDirPath);
        try {
          _preferencesWritesSuspended = true;
          debouncer.cancel(FunctionTag.savePreferences);
          await _preferencesWriteTail;
          await suspendDatabaseWrites();
          final migrationData = await restoreTask(
            backupPath ?? await appPath.backupFilePath,
            restoreDirPath,
            await appPath.homeDirPath,
          );
          if (!await restoreDir.exists()) {
            throw appLocalizations.restoreException;
          }
          final configMap = migrationData.configMap;
          final restoredConfig =
              option == RestoreOption.all && configMap != null
              ? Config.fromJson(configMap)
              : null;
          await ensureCoreReadyOrThrow();
          await validateRestoredProfileFiles(
            migrationData.fileMigrations,
            await appPath.profilesPath,
            coreController.validateConfig,
          );
          final previousConfig = config;
          previousProfileId = previousConfig.currentProfileId;
          final previousProfiles = await database.profilesDao.all().get();
          final previousScripts = await database.scriptsDao.all().get();
          final previousRules = await database.select(database.rules).map((
            row,
          ) {
            return row.toRule();
          }).get();
          final previousLinks = await database
              .select(database.profileRuleLinks)
              .map((row) => row.toLink())
              .get();
          await preferences.saveDurableConfig(previousConfig);
          restoreJournal = await RestoreJournal.begin(
            homePath: await appPath.homeDirPath,
            durableConfigPath: await appPath.durableConfigPath,
            createDatabaseSnapshot: database.createSnapshot,
          );
          final deletePaths = <String>[];
          if (isOverride) {
            final restoredProfileFiles = migrationData.fileMigrations
                .map((migration) => p.absolute(p.normalize(migration.b)))
                .toSet();
            for (final profile in previousProfiles) {
              final profilePath = await appPath.getProfilePath(
                profile.id.toString(),
              );
              deletePaths.addAll([
                await appPath.getProfilePath('.${profile.id}'),
                await appPath.getProvidersDirPath(profile.id.toString()),
              ]);
              if (!restoredProfileFiles.contains(
                p.absolute(p.normalize(profilePath)),
              )) {
                deletePaths.add(profilePath);
              }
            }
            final restoredScriptIds = migrationData.scripts
                .map((script) => script.id)
                .toSet();
            for (final script in previousScripts) {
              if (!restoredScriptIds.contains(script.id)) {
                deletePaths.add(
                  await appPath.getScriptPath(script.id.toString()),
                );
              }
            }
          }
          coreQuiesced = true;
          if (wasRunning) {
            await updateStatus(false);
          }
          if (!await stopSystemProxyIfNeeded()) {
            throw StateError('failed to restore system proxy');
          }
          if (coreController.isCompleted) {
            if (!await coreController.shutdown(true)) {
              throw StateError('failed to stop core before restore');
            }
          }
          late Config configToApply;
          int? currentProfileId;
          var durableMutationStarted = false;
          var durableRollbackConfirmed = false;
          await runExclusiveDatabaseOperation(
            () => commitRestoredFiles(
              migrationData.fileMigrations,
              () async {
                durableMutationStarted = true;
                var databaseChanged = false;
                try {
                  await database.transaction(() async {
                    await database.restore(
                      migrationData.profiles,
                      migrationData.scripts,
                      migrationData.rules,
                      migrationData.links,
                      isOverride: isOverride,
                    );
                  });
                  databaseChanged = true;
                  final profileIds = (await database.profilesDao.all().get())
                      .map((profile) => profile.id)
                      .toSet();
                  if (wasRunning && profileIds.isEmpty) {
                    throw StateError(
                      'cannot restore an empty profile set while the core is running',
                    );
                  }
                  final requestedProfileId =
                      restoredConfig?.currentProfileId ??
                      previousConfig.currentProfileId;
                  currentProfileId = profileIds.contains(requestedProfileId)
                      ? requestedProfileId
                      : profileIds.firstOrNull;
                  if (restoredConfig == null) {
                    configToApply = previousConfig.copyWith(
                      currentProfileId: currentProfileId,
                    );
                  } else {
                    configToApply = restoredConfig.copyWith(
                      currentProfileId: currentProfileId,
                      patchClashConfig:
                          restoredConfig.patchClashConfig.secret.isEmpty
                          ? restoredConfig.patchClashConfig.copyWith(
                              secret: previousConfig.patchClashConfig.secret,
                            )
                          : restoredConfig.patchClashConfig,
                      davProps: mergeRestoredDavProps(
                        restoredConfig.davProps,
                        previousConfig.davProps,
                      ),
                    );
                  }
                  if (!await _saveConfigSerialized(configToApply)) {
                    throw appLocalizations.restoreException;
                  }
                  await restoreJournal!.markCommitted();
                } catch (error, stackTrace) {
                  Object? rollbackError;
                  if (databaseChanged) {
                    try {
                      await database.transaction(() async {
                        await database.restore(
                          previousProfiles,
                          previousScripts,
                          previousRules,
                          previousLinks,
                          isOverride: true,
                        );
                      });
                    } catch (failure) {
                      rollbackError = failure;
                    }
                  }
                  try {
                    if (!await _saveConfigSerialized(previousConfig)) {
                      rollbackError ??= StateError(
                        'failed to restore preferences',
                      );
                    }
                  } catch (failure) {
                    rollbackError ??= failure;
                  }
                  if (rollbackError != null) {
                    Error.throwWithStackTrace(
                      StateError(
                        '$error; restore rollback failed: $rollbackError',
                      ),
                      stackTrace,
                    );
                  }
                  durableRollbackConfirmed = true;
                  Error.throwWithStackTrace(error, stackTrace);
                }
              },
              deletePaths: deletePaths,
              prepare: (plan) => restoreJournal!.prepare(plan),
              rollbackCompleted: () async {
                if (!durableMutationStarted || durableRollbackConfirmed) {
                  await restoreJournal!.clearAfterRollback();
                  restoreJournal = null;
                }
              },
            ),
          );
          restoreCommitted = true;
          try {
            await restoreJournal!.clearAfterCommit();
            restoreJournal = null;
          } catch (error) {
            commonPrint.log(
              'restore journal cleanup failed: $error',
              logLevel: LogLevel.warning,
            );
          }
          restoredProfileId = currentProfileId;
          committedConfig = configToApply;
          restoredAllSettings = restoredConfig != null;
          final restoredProfiles = await database.profilesDao.all().get();
          final restoredScripts = await database.scriptsDao.all().get();
          try {
            _synchronizeRestoredState(
              profiles: restoredProfiles,
              scripts: restoredScripts,
              config: configToApply,
              restoreConfig: restoredAllSettings,
            );
            stateSynchronized = true;
          } catch (error) {
            stateSynchronizationError = error;
          }
        } finally {
          try {
            if (restoreCommitted &&
                !stateSynchronized &&
                committedConfig != null) {
              final profiles = await database.profilesDao.all().get();
              final scripts = await database.scriptsDao.all().get();
              try {
                _synchronizeRestoredState(
                  profiles: profiles,
                  scripts: scripts,
                  config: committedConfig!,
                  restoreConfig: restoredAllSettings,
                );
                stateSynchronized = true;
                stateSynchronizationError = null;
              } catch (error) {
                stateSynchronizationError = error;
              }
            } else if (!stateSynchronized) {
              _ref
                  .read(profilesProvider.notifier)
                  .replaceFromDatabase(await database.profilesDao.all().get());
              _ref
                  .read(scriptsProvider.notifier)
                  .replaceFromDatabase(await database.scriptsDao.all().get());
              _ref.invalidate(addedRuleStreamProvider);
              _ref.invalidate(setupStateProvider);
            }
            await restoreDir.safeDelete(recursive: true);
          } finally {
            recoveryRequired = restoreJournal?.hasPendingRollback == true;
            if (!recoveryRequired) {
              resumeDatabaseWrites();
              _preferencesWritesSuspended = false;
              if (_preferencesWriteRequestedWhileSuspended) {
                _preferencesWriteRequestedWhileSuspended = false;
                savePreferencesDebounce();
              }
            }
          }
        }
      });
    } catch (error, stackTrace) {
      restoreError = error;
      restoreStackTrace = stackTrace;
      try {
        await restoreJournal?.clearIfUnprepared();
      } catch (_) {}
      recoveryRequired = restoreJournal?.hasPendingRollback == true;
    }
    Object? coreRecoveryError;
    if (!recoveryRequired && coreQuiesced && (wasCoreConnected || wasRunning)) {
      try {
        if (!restoreCommitted) {
          _ref.read(currentProfileIdProvider.notifier).value =
              previousProfileId;
        }
        if (!coreController.isCompleted) {
          await _connectCore();
        }
        if (!coreController.isCompleted) {
          throw _coreDisconnectedMessage;
        }
        await _initCore();
        if (!restoreCommitted || stateSynchronized) {
          final profileId = restoreCommitted
              ? restoredProfileId
              : previousProfileId;
          if (profileId == null && wasRunning) {
            throw StateError('no profile is available after restore');
          }
          if (profileId != null) {
            bool activated;
            if (wasRunning) {
              await updateStatus(true, isInit: true);
              activated = _ref.read(isStartProvider);
            } else {
              activated = await applyProfile(force: true);
            }
            if (!activated) {
              throw appLocalizations.restoreException;
            }
          } else {
            _ref.read(groupsProvider.notifier).value = [];
            _ref.read(providersProvider.notifier).value = [];
            clearDelay();
          }
        }
      } catch (error) {
        coreRecoveryError = error;
      }
    } else if (recoveryRequired && coreController.isCompleted) {
      try {
        await coreController.shutdown(false);
      } catch (_) {}
    } else if (!wasCoreConnected && coreController.isCompleted) {
      try {
        if (!await coreController.shutdown(false)) {
          throw StateError('failed to restore disconnected core state');
        }
      } catch (error) {
        coreRecoveryError = error;
      }
    }
    if (stateSynchronizationError != null) {
      restoreError = StateError(
        'restore committed but state synchronization failed: '
        '$stateSynchronizationError',
      );
      restoreStackTrace ??= StackTrace.current;
    }
    if (recoveryRequired) {
      throw StateError(
        'restore recovery is required before the application can continue',
      );
    }
    if (restoreError != null) {
      final error = coreRecoveryError == null
          ? restoreError
          : StateError(
              '$restoreError; core recovery failed: $coreRecoveryError',
            );
      Error.throwWithStackTrace(error, restoreStackTrace ?? StackTrace.current);
    }
    if (coreRecoveryError != null) {
      throw StateError(
        'restore committed but core activation failed: $coreRecoveryError',
      );
    }
  }
}

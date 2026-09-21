part of '../action.dart';

@Riverpod(keepAlive: true)
class StoreAction extends _$StoreAction {
  @override
  void build() {
    _controller = ref.watch(actionControllerProvider);
  }

  late AppController _controller;

  void savePreferencesDebounce() => _controller.savePreferencesDebounce();

  Future<void> savePreferences() => _controller.savePreferences();

  Future handleClear() => _controller.handleClear();
}

extension StoreControllerExt on AppController {
  void savePreferencesDebounce() {
    if (_preferencesWritesSuspended) {
      _preferencesWriteRequestedWhileSuspended = true;
      return;
    }
    debouncer.call(FunctionTag.savePreferences, () async {
      if (!_preferencesWritesSuspended) {
        await _saveConfigSerialized(config);
      }
    });
  }

  Future<void> savePreferences() async {
    if (_preferencesWritesSuspended) {
      _preferencesWriteRequestedWhileSuspended = true;
      return;
    }
    await _saveConfigSerialized(config);
  }

  Future handleClear() async {
    var irreversibleClearStarted = false;
    try {
      await _serializeCoreLifecycle(
        () => withProfileStorageMutation(() async {
          _preferencesWritesSuspended = true;
          _persistentLogWritesSuspended = true;
          debouncer.cancel(FunctionTag.savePreferences);
          try {
            await _preferencesWriteTail;
            await suspendDatabaseWrites();
            await _logFileWrite;
            await globalState.handleStop();
            if (!await stopSystemProxyIfNeeded()) {
              throw StateError('failed to restore system proxy before clear');
            }
            if (coreController.isCompleted &&
                !await coreController.shutdown(true)) {
              throw StateError('failed to stop core before clear');
            }
            _ref.read(coreStatusProvider.notifier).value =
                CoreStatus.disconnected;

            irreversibleClearStarted = true;
            _persistentLogFile = null;
            _persistentLogLength = 0;
            await runCleanupActions([
              startupRecovery.markClosed,
              () => SafeStorage.delete('cloud_token'),
              ConfigKeyStore.clear,
              () => preferences.clearPreferences(
                preserveKeys: {
                  SafeStorage.deletionMarkerKey('cloud_token'),
                  SafeStorage.deletionMarkerKey('config_age_seed'),
                },
              ),
              database.close,
              () async => deleteApplicationSupportData(
                await appPath.homeDirPath,
                preservePaths: {
                  await appPath.lockFilePath,
                  await appPath.sharedPreferencesPath,
                },
              ),
            ]);
          } finally {
            if (!irreversibleClearStarted) {
              resumeDatabaseWrites();
              _preferencesWritesSuspended = false;
              _persistentLogWritesSuspended = false;
              if (_preferencesWriteRequestedWhileSuspended) {
                _preferencesWriteRequestedWhileSuspended = false;
                savePreferencesDebounce();
              }
            }
          }
        }),
      );
    } finally {
      if (irreversibleClearStarted) {
        await handleExit(false);
      }
    }
  }
}

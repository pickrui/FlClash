import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/core/core.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/action.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/providers/state.dart';
import 'package:fl_clash/state.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoreManager extends ConsumerStatefulWidget {
  final Widget child;

  const CoreManager({super.key, required this.child});

  @override
  ConsumerState<CoreManager> createState() => _CoreContainerState();
}

class _CoreContainerState extends ConsumerState<CoreManager>
    with CoreEventListener {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    coreEventManager.addListener(this);
    // The async setup state passes through null while a newly selected
    // profile loads. Compare against the last loaded state instead, or every
    // profile switch would run a full setup twice.
    SetupState? lastSetupState = ref.read(currentSetupStateProvider);
    ref.listenManual(currentSetupStateProvider, (_, next) {
      if (next == null) return;
      final previous = lastSetupState;
      lastSetupState = next;
      if (!ref.read(initProvider) || previous == next) {
        return;
      }
      if (previous?.profileId != next.profileId) {
        appController.fullSetup();
        return;
      }
      appController.applyProfileDebounce(silence: true);
    });
    ref.listenManual(updateParamsProvider, (prev, next) {
      if (prev != next) {
        appController.updateConfigDebounce();
      }
    });
    ref.listenManual(appSettingProvider.select((state) => state.openLogs), (
      prev,
      next,
    ) {
      if (next) {
        coreController.startLog();
      } else {
        coreController.stopLog();
      }
    }, fireImmediately: true);
  }

  @override
  void dispose() {
    coreEventManager.removeListener(this);
    super.dispose();
  }

  @override
  Future<void> onDelay(Delay delay) async {
    super.onDelay(delay);
    appController.setDelay(delay);
    debouncer.call(FunctionTag.updateDelay, () async {
      appController.updateGroupsDebounce();
    }, duration: const Duration(milliseconds: 5000));
  }

  @override
  void onLog(Log log) {
    if (Secrets.shouldSuppressOutput(log.payload)) return;
    appController.addLog(log);
    if (log.logLevel == LogLevel.error) {
      globalState.showNotifier(log.payload);
    }
    super.onLog(log);
  }

  @override
  void onRequest(TrackerInfo trackerInfo) async {
    ref.read(requestsProvider.notifier).addRequest(trackerInfo);
    super.onRequest(trackerInfo);
  }

  @override
  void onModeChanged(String mode) {
    final index = Mode.values.indexWhere((item) => item.name == mode);
    if (index == -1) {
      return;
    }
    final next = Mode.values[index];
    final current = ref.read(
      patchClashConfigProvider.select((state) => state.mode),
    );
    if (current != next) {
      appController.changeMode(next);
    }
    super.onModeChanged(mode);
  }

  @override
  void onLoaded(String providerName) {
    debouncer.call(FunctionTag.loadedProvider, () async {
      if (!mounted) return;
      final action = ref.read(proxiesActionProvider.notifier);
      try {
        await action.updateProviders();
        if (mounted) action.updateGroupsDebounce();
      } catch (error) {
        commonPrint.log(
          'Provider snapshot refresh failed: $error',
          logLevel: LogLevel.warning,
        );
      }
    }, duration: const Duration(milliseconds: 5000));
    super.onLoaded(providerName);
  }

  @override
  Future<void> onCrash(String message) async {
    if (ref.read(coreStatusProvider) != CoreStatus.connected) {
      return;
    }
    ref.read(coreStatusProvider.notifier).value = CoreStatus.disconnected;
    appController.clearDelay();
    if (WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed) {
      context.showNotifier(message);
    }
    globalState.clearRunState();
    await runCleanupActions([
      stopSystemProxyIfNeeded,
      () => coreController.shutdown(false),
    ]);
    super.onCrash(message);
  }

  @override
  void onGeoUpdate(
    String geoType,
    bool updating,
    bool skipped,
    bool reload,
    String? error, {
    bool silent = false,
  }) {
    if (reload) {
      if (ref.read(isStartProvider)) {
        debouncer.call(
          FunctionTag.geoReload,
          () => appController.restartCore(),
        );
      }
      return;
    }
    final geoResource = GeoResource.fromJson(geoType.toLowerCase());
    ref.read(isUpdatingProvider(geoResource.updatingKey).notifier).value =
        updating;
    if (silent) {
      return;
    }
    if (updating) {
      globalState.showNotifier(appLocalizations.geoUpdating(geoResource.name));
    } else if (error != null && error.isNotEmpty) {
      globalState.showNotifier(error);
    } else if (skipped) {
      globalState.showNotifier(appLocalizations.geoSkipped(geoResource.name));
    } else {
      globalState.showNotifier(appLocalizations.geoUpdated(geoResource.name));
    }
    super.onGeoUpdate(geoType, updating, skipped, reload, error);
  }
}

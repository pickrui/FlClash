import 'dart:async';
import 'package:fl_clash/common/listener_state_scheduler.dart';
import 'package:fl_clash/providers/state.dart';

import 'package:animations/animations.dart';
import 'package:fl_clash/services/config_reset.dart';
import 'package:dynamic_color/dynamic_color.dart' show DynamicColorPlugin;
import 'package:fl_clash/common/dynamic_color_scheme.dart';
import 'package:fl_clash/common/periodic_task_runner.dart';
import 'package:fl_clash/common/theme.dart';
import 'package:fl_clash/core/core.dart';
import 'package:fl_clash/plugins/service.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/providers/database.dart';
import 'package:fl_clash/widgets/dialog.dart';
import 'package:fl_clash/widgets/list.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'common/common.dart';
import 'database/database.dart';
import 'l10n/l10n.dart';
import 'models/models.dart';

typedef UpdateTasks = List<PeriodicTask>;

class GlobalState {
  static GlobalState? _instance;
  final navigatorKey = GlobalKey<NavigatorState>();
  final _updateTasks = PeriodicTaskRunner(
    onError: (error, stackTrace) {
      commonPrint.log('update task failed: $error\n$stackTrace');
    },
  );
  int _runRequest = 0;
  bool _appVisible = true;
  bool _windowVisible = !system.isDesktop;
  bool _trayTrafficEnabled = false;

  bool get isUiVisible => _appVisible && _windowVisible;
  bool get needsTrayTraffic => _trayTrafficEnabled;

  void setUpdateVisibility({
    bool? appVisible,
    bool? windowVisible,
    bool? trayTraffic,
  }) {
    if (appVisible != null) _appVisible = appVisible;
    if (windowVisible != null) _windowVisible = windowVisible;
    if (trayTraffic != null) _trayTrafficEnabled = trayTraffic;
    unawaited(_updateTasks.setPaused(!isUiVisible && !needsTrayTraffic));
  }

  late final _listeners = ListenerStateScheduler((running) async {
    if (coreController.isCompleted) {
      if (running) {
        if (!await coreController.startListener()) {
          throw PortConflictException(appLocalizations.portConflictTip);
        }
      } else {
        await coreController.stopListener();
      }
    } else if (running && system.isDesktop) {
      throw StateError('Core is not connected');
    }
  });

  Future<void> syncNetworkSuspension() => system.isAndroid
      ? Future.value()
      : _listeners.apply(
          running: isStart,
          suspended: container.read(suspendProvider),
        );

  bool isPre = true;
  late final PackageInfo packageInfo;
  late Measure measure;
  late CommonTheme theme;
  late Color accentColor;
  late ProviderContainer container;
  ColorScheme? lightDynamicColorScheme;
  ColorScheme? darkDynamicColorScheme;
  bool needInitStatus = true;
  DateTime? startTime;
  SetupState? lastSetupState;
  VpnState? lastVpnState;
  List<String> launchArguments = const [];

  bool get isStart => startTime != null && startTime!.isBeforeNow;

  GlobalState._internal();

  factory GlobalState() {
    _instance ??= GlobalState._internal();
    return _instance!;
  }

  Future<ProviderContainer> init(
    int version, {
    List<String> arguments = const [],
    Future<Map<String, Object?>?> Function()? loadConfig,
  }) async {
    launchArguments = await resolveLaunchArguments(
      arguments: arguments,
      isMacOS: system.isMacOS,
    );
    isPre = const String.fromEnvironment('APP_ENV') != 'stable';
    await _initDynamicColor();
    return _initData(version, loadConfig: loadConfig);
  }

  Future<void> _initDynamicColor() async {
    try {
      final corePalette = await DynamicColorPlugin.getCorePalette();
      lightDynamicColorScheme = corePalette?.toMaterialColorScheme();
      darkDynamicColorScheme = corePalette?.toMaterialColorScheme(
        brightness: Brightness.dark,
      );
    } catch (_) {}
    try {
      accentColor =
          await DynamicColorPlugin.getAccentColor() ??
          const Color(defaultPrimaryColor);
    } catch (_) {
      accentColor = const Color(defaultPrimaryColor);
    }
  }

  Future<ProviderContainer> _initData(
    int version, {
    Future<Map<String, Object?>?> Function()? loadConfig,
  }) async {
    final appState = AppState(
      brightness: WidgetsBinding.instance.platformDispatcher.platformBrightness,
      version: version,
      viewSize: Size.zero,
      requests: FixedList(maxLength),
      logs: FixedList(maxLength),
      traffics: FixedList(30),
      totalTraffic: const Traffic(),
    );
    final appStateOverrides = buildAppStateOverrides(appState);
    packageInfo = await PackageInfo.fromPlatform();
    await window?.ensureSingleInstance();
    if (system.isWindows) {
      await ConfigReset(await appPath.homeDirPath).resumePending();
    }
    await appPath.migrateLegacyApplicationSupportData();
    await recoverPendingRestore(
      homePath: await appPath.homeDirPath,
      databasePath: await appPath.databasePath,
      durableConfigPath: await appPath.durableConfigPath,
    );
    final configMap = await (loadConfig ?? preferences.getConfigMap)();
    await recoverPendingScriptDeletions(
      scriptsPath: await appPath.scriptsDirPath,
      scriptExists: (scriptId) async =>
          await database.scriptsDao.get(scriptId).getSingleOrNull() != null,
    );
    final config = await migration.migrationIfNeeded(
      configMap,
      sync: (data) async {
        final newConfigMap = data.configMap;
        final config = Config.realFromJson(newConfigMap);
        await database.transaction(() async {
          await database.restore(
            data.profiles,
            data.scripts,
            data.rules,
            data.links,
          );
        });
        await preferences.saveConfig(config);
        return config;
      },
    );
    await preferences.saveConfig(config);
    final configOverrides = buildConfigOverrides(config);
    container = ProviderContainer(
      overrides: [...appStateOverrides, ...configOverrides],
    );
    final profiles = await database.profilesDao.all().get();
    await container.read(profilesProvider.notifier).setAndReorder(profiles);
    await AppLocalizations.load(
      utils.getLocaleForString(config.appSettingProps.locale) ??
          WidgetsBinding.instance.platformDispatcher.locale,
    );
    final silentLaunch = shouldLaunchSilently(
      enabled: config.appSettingProps.silentLaunch,
      arguments: launchArguments,
    );
    await window?.init(version, config.windowProps, silentLaunch: silentLaunch);
    if (system.isAndroid) {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
    return container;
  }

  Future<void> startUpdateTasks([UpdateTasks? tasks]) {
    // Running state must reach the tray even when statistics have no consumer.
    final started = startTime;
    if (started != null) {
      container.read(runTimeProvider.notifier).value = DateTime.now()
          .difference(started)
          .inMilliseconds;
    }
    return _updateTasks.start(tasks);
  }

  void stopUpdateTasks() {
    _updateTasks.stop();
  }

  Future<void> handleStart([UpdateTasks? tasks]) async {
    final request = ++_runRequest;
    startTime ??= DateTime.now();
    try {
      await _listeners.apply(
        running: true,
        suspended: !system.isAndroid && container.read(suspendProvider),
      );
      if (request != _runRequest) return;
      await service?.start();
      if (request != _runRequest) return;
      startUpdateTasks(tasks);
    } catch (_) {
      if (request == _runRequest) startTime = null;
      rethrow;
    }
  }

  Future updateStartTime() async {
    startTime = await service?.getRunTime();
  }

  Future handleStop() async {
    ++_runRequest;
    startTime = null;
    stopUpdateTasks();
    try {
      await _listeners.apply(running: false, suspended: false);
    } finally {
      await service?.stop();
    }
  }

  Future<bool?> showMessage({
    required InlineSpan message,
    BuildContext? context,
    String? title,
    String? confirmText,
    String? cancelText,
    bool cancelable = true,
    bool? dismissible,
  }) async {
    return showCommonDialog<bool>(
      context: context,
      dismissible: dismissible,
      child: Builder(
        builder: (context) {
          return CommonDialog(
            title: title ?? appLocalizations.tip,
            actions: [
              if (cancelable)
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(cancelText ?? appLocalizations.cancel),
                ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text(confirmText ?? appLocalizations.confirm),
              ),
            ],
            child: Container(
              width: 300,
              constraints: const BoxConstraints(maxHeight: 200),
              child: SingleChildScrollView(
                child: SelectableText.rich(
                  TextSpan(
                    style: Theme.of(context).textTheme.labelLarge,
                    children: [message],
                  ),
                  style: const TextStyle(overflow: TextOverflow.visible),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<bool?> showAllUpdatingMessagesDialog(
    List<UpdatingMessage> messages,
  ) async {
    return showCommonDialog<bool>(
      child: Builder(
        builder: (context) {
          return CommonDialog(
            padding: EdgeInsets.zero,
            title: appLocalizations.tip,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text(appLocalizations.confirm),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.separated(
                itemBuilder: (_, index) {
                  final message = messages[index];
                  return ListItem(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    title: Text(message.label),
                    subtitle: Text(message.message),
                  );
                },
                itemCount: messages.length,
                separatorBuilder: (_, _) => const Divider(height: 0),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<T?> showCommonDialog<T>({
    required Widget child,
    BuildContext? context,
    bool? dismissible,
    bool filter = true,
  }) async {
    return showModal<T>(
      useRootNavigator: false,
      context: context ?? globalState.navigatorKey.currentContext!,
      configuration: FadeScaleTransitionConfiguration(
        barrierColor: Colors.black38,
        barrierDismissible: dismissible ?? true,
      ),
      builder: (_) => child,
      filter: filter ? commonFilter : null,
    );
  }

  void showNotifier(String text, {MessageActionState? actionState}) {
    final safeText = Secrets.redactApiDomains(text);
    if (safeText.isEmpty) {
      return;
    }
    navigatorKey.currentContext?.showNotifier(
      safeText,
      actionState: actionState,
    );
  }

  Future<void> openUrl(String url) async {
    final res = await showMessage(
      message: TextSpan(text: url),
      title: appLocalizations.externalLink,
      confirmText: appLocalizations.go,
    );
    if (res != true) {
      return;
    }
    launchUrl(Uri.parse(url));
  }
}

final globalState = GlobalState();

import 'dart:async';
import 'dart:convert';
import 'dart:ffi' as ffi;

import 'package:animations/animations.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:fl_clash/common/theme.dart';
import 'package:fl_clash/core/core.dart';
import 'package:fl_clash/plugins/service.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/providers/database.dart';
import 'package:fl_clash/widgets/dialog.dart';
import 'package:fl_clash/widgets/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'common/common.dart';
import 'database/database.dart';
import 'l10n/l10n.dart';
import 'models/models.dart';

typedef UpdateTasks = List<FutureOr Function()>;

class GlobalState {
  static GlobalState? _instance;
  final navigatorKey = GlobalKey<NavigatorState>();
  Timer? timer;
  bool isPre = true;
  late final PackageInfo packageInfo;
  Function? updateCurrentDelayDebounce;
  late Measure measure;
  late CommonTheme theme;
  late Color accentColor;
  late ProviderContainer container;
  ColorScheme? lightDynamicColorScheme;
  ColorScheme? darkDynamicColorScheme;
  bool needInitStatus = true;
  DateTime? startTime;
  UpdateTasks tasks = [];
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
  }) async {
    launchArguments = List.unmodifiable(arguments);
    isPre = const String.fromEnvironment('APP_ENV') != 'stable';
    await _initDynamicColor();
    return _initData(version);
  }

  Future<void> _initDynamicColor() async {
    try {
      final corePalette = await DynamicColorPlugin.getCorePalette();
      lightDynamicColorScheme = corePalette?.toColorScheme();
      darkDynamicColorScheme = corePalette?.toColorScheme(
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

  Future<ProviderContainer> _initData(int version) async {
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
    await appPath.migrateLegacyApplicationSupportData();
    await recoverPendingRestore(
      homePath: await appPath.homeDirPath,
      databasePath: await appPath.databasePath,
      durableConfigPath: await appPath.durableConfigPath,
    );
    await recoverPendingScriptDeletions(
      scriptsPath: await appPath.scriptsDirPath,
      scriptExists: (scriptId) async =>
          await database.scriptsDao.get(scriptId).getSingleOrNull() != null,
    );
    final configMap = await preferences.getConfigMap();
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
        if (!await preferences.saveConfig(config)) {
          throw StateError('failed to persist migrated config');
        }
        return config;
      },
    );
    if (!await preferences.saveConfig(config)) {
      throw StateError('failed to persist application config');
    }
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

  Future<void> startUpdateTasks([UpdateTasks? tasks]) async {
    if (timer != null && timer!.isActive == true) return;
    if (tasks != null) {
      this.tasks = tasks;
    }
    if (this.tasks.isEmpty) {
      return;
    }
    await executorUpdateTask();
    timer = Timer(const Duration(seconds: 1), () async {
      startUpdateTasks();
    });
  }

  Future<void> executorUpdateTask() async {
    for (final task in tasks) {
      await task();
    }
    timer = null;
  }

  void stopUpdateTasks() {
    if (timer == null || timer?.isActive == false) return;
    timer?.cancel();
    timer = null;
  }

  Future<void> handleStart([UpdateTasks? tasks]) async {
    startTime ??= DateTime.now();
    try {
      if (coreController.isCompleted) {
        if (!await coreController.startListener()) {
          throw PortConflictException(appLocalizations.portConflictTip);
        }
      } else if (system.isDesktop) {
        throw StateError('Core is not connected');
      }
      await service?.start();
      startUpdateTasks(tasks);
    } catch (_) {
      startTime = null;
      rethrow;
    }
  }

  Future updateStartTime() async {
    startTime = await service?.getRunTime();
  }

  Future handleStop() async {
    startTime = null;
    if (coreController.isCompleted) {
      await coreController.stopListener();
    }
    await service?.stop();
    stopUpdateTasks();
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

  Future<Map<String, dynamic>> handleEvaluate(
    String scriptContent,
    Map<String, dynamic> config, {
    void Function(String level, String output)? onConsole,
  }) async {
    if (config['proxy-providers'] == null) {
      config['proxy-providers'] = {};
    }
    final configJs = json.encode(config);
    String? lastError;
    Future<Map<String, dynamic>?> run() async {
      final runtime = getJavascriptRuntime();
      final engineId = runtime.getEngineInstanceId();
      try {
        if (onConsole != null) {
          JavascriptRuntime
                  .channelFunctionsRegistered[engineId]?['ConsoleLog'] =
              (dynamic args) {
                try {
                  final list = List<dynamic>.from(args as List);
                  final level = list.isNotEmpty
                      ? list.removeAt(0).toString()
                      : 'log';
                  onConsole(level, list.join(' '));
                } catch (_) {}
              };
        }
        final res = await runtime.evaluateAsync('''
      $scriptContent
      main($configJs)
    ''');
        if (res.isError) {
          lastError = res.stringResult;
          return null;
        }
        return switch (res.rawResult is ffi.Pointer) {
          true => runtime.convertValue<Map<String, dynamic>>(res),
          false => Map<String, dynamic>.from(res.rawResult),
        };
      } finally {
        JavascriptRuntime.channelFunctionsRegistered.remove(engineId);
        if (!system.isMacOS) {
          try {
            runtime.dispose();
          } catch (_) {}
        }
      }
    }

    var value = await run();
    if (value == null && lastError != null) {
      lastError = null;
      value = await run();
      if (value == null && lastError != null) {
        throw lastError!;
      }
    }
    return value ?? config;
  }
}

final globalState = GlobalState();

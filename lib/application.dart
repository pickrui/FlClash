import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/core/core.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/manager/hotkey_manager.dart';
import 'package:fl_clash/manager/manager.dart';
import 'package:fl_clash/plugins/app.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller.dart';
import 'pages/pages.dart';

class Application extends ConsumerStatefulWidget {
  const Application({super.key});

  @override
  ConsumerState<Application> createState() => ApplicationState();
}

class ApplicationState extends ConsumerState<Application>
    with WidgetsBindingObserver {
  Timer? _autoUpdateProfilesTaskTimer;
  bool _preHasVpn = false;

  final _pageTransitionsTheme = const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: commonSharedXPageTransitions,
      TargetPlatform.windows: commonSharedXPageTransitions,
      TargetPlatform.linux: commonSharedXPageTransitions,
      TargetPlatform.macOS: commonSharedXPageTransitions,
    },
  );

  ColorScheme _getAppColorScheme({
    required Brightness brightness,
    int? primaryColor,
  }) {
    return ref.read(genColorSchemeProvider(brightness));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      final currentContext = globalState.navigatorKey.currentContext;
      if (currentContext != null) {
        await appController.attach(currentContext, ref);
      } else {
        exit(0);
      }
      if (!mounted) return;
      _syncAutoUpdateProfilesTask();
      appController.initLink();
      app?.initShortcuts();
    });
  }

  bool get _shouldRunAutoUpdateProfilesTask {
    final lifecycleState = WidgetsBinding.instance.lifecycleState;
    return lifecycleState == null ||
        lifecycleState == AppLifecycleState.resumed ||
        (system.isDesktop && lifecycleState == AppLifecycleState.inactive);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _syncAutoUpdateProfilesTask();
  }

  void _syncAutoUpdateProfilesTask() {
    if (!_shouldRunAutoUpdateProfilesTask) {
      _autoUpdateProfilesTaskTimer?.cancel();
      _autoUpdateProfilesTaskTimer = null;
      return;
    }
    _autoUpdateProfilesTaskTimer ??= Timer.periodic(
      const Duration(minutes: 20),
      (timer) async {
        await appController.autoUpdateProfiles();
      },
    );
  }

  Widget _buildPlatformState({required Widget child}) {
    if (system.isDesktop) {
      return WindowManager(
        child: TrayManager(
          child: HotKeyManager(child: ProxyManager(child: child)),
        ),
      );
    }
    return AndroidManager(child: TileManager(child: child));
  }

  Widget _buildState({required Widget child}) {
    return AppStateManager(
      child: CoreManager(
        child: ConnectivityManager(
          onConnectivityChanged: (results) async {
            commonPrint.log('connectivityChanged ${results.toString()}');
            appController.updateLocalIp();
            final hasVpn = results.contains(ConnectivityResult.vpn);
            if (_preHasVpn == hasVpn) {
              appController.addCheckIp();
            }
            _preHasVpn = hasVpn;
          },
          child: child,
        ),
      ),
    );
  }

  Widget _buildPlatformApp({required Widget child}) {
    if (system.isDesktop) {
      return WindowHeaderContainer(child: child);
    }
    return VpnManager(child: child);
  }

  Widget _buildApp({required Widget child}) {
    return StatusManager(child: ThemeManager(child: child));
  }

  ThemeData _getAppTheme(ThemeData theme) {
    return theme.copyWith(
      listTileTheme: const ListTileThemeData(
        mouseCursor: WidgetStatePropertyAll(SystemMouseCursors.click),
      ),
      checkboxTheme: const CheckboxThemeData(
        mouseCursor: WidgetStatePropertyAll(SystemMouseCursors.click),
      ),
      radioTheme: const RadioThemeData(
        mouseCursor: WidgetStatePropertyAll(SystemMouseCursors.click),
      ),
      switchTheme: const SwitchThemeData(
        mouseCursor: WidgetStatePropertyAll(SystemMouseCursors.click),
      ),
      sliderTheme: const SliderThemeData(
        mouseCursor: WidgetStatePropertyAll(SystemMouseCursors.click),
      ),
      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
          mouseCursor: WidgetStatePropertyAll(SystemMouseCursors.click),
        ),
      ),
      filledButtonTheme: const FilledButtonThemeData(
        style: ButtonStyle(
          mouseCursor: WidgetStatePropertyAll(SystemMouseCursors.click),
        ),
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          mouseCursor: WidgetStatePropertyAll(SystemMouseCursors.click),
        ),
      ),
      outlinedButtonTheme: const OutlinedButtonThemeData(
        style: ButtonStyle(
          mouseCursor: WidgetStatePropertyAll(SystemMouseCursors.click),
        ),
      ),
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          mouseCursor: WidgetStatePropertyAll(SystemMouseCursors.click),
        ),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
    );
  }

  @override
  Widget build(context) {
    return Consumer(
      builder: (_, ref, child) {
        final locale = ref.watch(
          appSettingProvider.select((state) => state.locale),
        );
        final themeProps = ref.watch(themeSettingProvider);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: globalState.navigatorKey,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          builder: (_, child) {
            return AppEnvManager(
              child: _buildApp(
                child: _buildPlatformState(
                  child: _buildState(child: _buildPlatformApp(child: child!)),
                ),
              ),
            );
          },
          scrollBehavior: BaseScrollBehavior(),
          title: appName,
          locale: utils.getLocaleForString(locale),
          supportedLocales: AppLocalizations.delegate.supportedLocales,
          themeMode: themeProps.themeMode,
          theme: _getAppTheme(
            ThemeData(
              useMaterial3: true,
              pageTransitionsTheme: _pageTransitionsTheme,
              colorScheme: _getAppColorScheme(
                brightness: Brightness.light,
                primaryColor: themeProps.primaryColor,
              ),
            ),
          ),
          darkTheme: _getAppTheme(
            ThemeData(
              useMaterial3: true,
              pageTransitionsTheme: _pageTransitionsTheme,
              colorScheme: _getAppColorScheme(
                brightness: Brightness.dark,
                primaryColor: themeProps.primaryColor,
              ).toPureBlack(themeProps.pureBlack),
            ),
          ),
          home: child!,
        );
      },
      child: const HomePage(),
    );
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    linkManager.destroy();
    _autoUpdateProfilesTaskTimer?.cancel();
    await coreController.destroy();
    await appController.handleExit();
    super.dispose();
  }
}

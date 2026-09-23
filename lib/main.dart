import 'dart:async';
import 'dart:io';

import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/common/render_binding.dart';
import 'package:fl_clash/pages/error.dart';
import 'package:fl_clash/pages/config_recovery.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/providers/cloud_account_provider.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:fl_clash/services/config_key_store.dart';
import 'package:fl_clash/services/config_recovery.dart';
import 'package:fl_clash/services/config_reset.dart';
import 'package:fl_clash/models/profile.dart';
import 'package:fl_clash/state.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rust_api/rust_api.dart';
import 'package:window_manager/window_manager.dart';

import 'application.dart';
import 'common/common.dart';

Future<void> main(List<String> arguments) async {
  try {
    FlClashWidgetsBinding.ensureInitialized();
    await RustLib.init();
    registerFetchManagedConfig(CloudApiService().fetchManagedConfig);
    final version = await system.version;
    final container = await globalState.init(
      version,
      arguments: arguments,
      loadConfig: _loadStartupConfig,
    );
    // Eagerly build the cloud-account notifier so it registers its
    // ensureCloudReady hook before any oixCloud profile setup runs.
    container.read(cloudAccountProvider);
    HttpOverrides.global = FlClashHttpOverrides();
    runApp(
      UncontrolledProviderScope(
        container: container,
        child: const Application(),
      ),
    );
  } catch (e, s) {
    commonPrint.log('init failed: $e stack: $s', logLevel: LogLevel.error);
    render?.resume();
    runApp(
      MaterialApp(
        home: InitErrorScreen(error: e, stack: s),
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await window?.showInitFailure();
      } catch (showError, showStack) {
        commonPrint.log(
          'show init error window failed: $showError stack: $showStack',
          logLevel: LogLevel.error,
        );
      }
    });
  }
}

Future<Map<String, Object?>?> _loadStartupConfig() async {
  final exitListener = _RecoveryExitListener();
  try {
    return await loadWithConfigRecovery(
      load: (retry) async {
        if (retry) {
          await ConfigKeyStore.reload();
        } else {
          await ConfigKeyStore.seedBase64();
        }
        return preferences.getConfigMap();
      },
      showRecovery: (retry, failure) {
        commonPrint.log('Waiting for local configuration recovery');
        render?.resume();
        if (system.isDesktop) {
          windowManager.addListener(exitListener);
        }
        runApp(
          MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              ...GlobalMaterialLocalizations.delegates,
            ],
            supportedLocales: AppLocalizations.delegate.supportedLocales,
            home: ConfigRecoveryScreen(
              onRetry: retry,
              initialReason: failure.reason,
              onReset: Platform.isWindows
                  ? () async =>
                        ConfigReset(await appPath.homeDirPath).backupAndReset()
                  : null,
              onExit: () => exit(0),
            ),
          ),
        );
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          try {
            await window?.showInitFailure();
          } catch (error) {
            commonPrint.log(
              'Could not show configuration recovery window: ${error.runtimeType}',
            );
          }
        });
      },
    );
  } finally {
    if (system.isDesktop) {
      windowManager.removeListener(exitListener);
    }
  }
}

class _RecoveryExitListener with WindowListener {
  @override
  void onWindowShouldTerminate() => exit(0);
}

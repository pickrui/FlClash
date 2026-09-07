import 'dart:async';
import 'dart:io';

import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/pages/error.dart';
import 'package:fl_clash/pages/config_recovery.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/providers/cloud_account_provider.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:fl_clash/services/config_key_store.dart';
import 'package:fl_clash/services/config_recovery.dart';
import 'package:fl_clash/models/profile.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rust_api/rust_api.dart';
import 'package:window_ext/window_ext.dart';

import 'application.dart';
import 'common/common.dart';

Future<void> main(List<String> arguments) async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    if (system.isDesktop) {
      await RustLib.init();
    }
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
    runApp(
      MaterialApp(
        home: InitErrorScreen(error: e, stack: s),
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await window?.show();
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
      showRecovery: (retry) {
        commonPrint.log('Waiting for local configuration recovery');
        if (system.isDesktop) {
          windowExtManager.addListener(exitListener);
        }
        runApp(
          MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.delegate.supportedLocales,
            home: ConfigRecoveryScreen(onRetry: retry, onExit: () => exit(0)),
          ),
        );
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          try {
            await window?.show();
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
      windowExtManager.removeListener(exitListener);
    }
  }
}

class _RecoveryExitListener with WindowExtListener {
  @override
  void onShouldTerminate() => exit(0);
}

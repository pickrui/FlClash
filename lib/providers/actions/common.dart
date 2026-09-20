part of '../action.dart';

@Riverpod(keepAlive: true)
class CommonAction extends _$CommonAction {
  @override
  void build() {
    _controller = ref.watch(actionControllerProvider);
  }

  late AppController _controller;

  void toPage(PageLabel pageLabel) => _controller.toPage(pageLabel);

  void toProfiles() => _controller.toProfiles();

  Future<void> openCloudLogin({bool navigateToCloud = true}) =>
      _controller.openCloudLogin(navigateToCloud: navigateToCloud);

  void updateStart() => _controller.updateStart();

  void updateSpeedStatistics() => _controller.updateSpeedStatistics();

  void updateMode() => _controller.updateMode();

  void updateRunTime() => _controller.updateRunTime();

  Future<void> updateTraffic() => _controller.updateTraffic();

  Future<T?> loadingRun<T>(
    FutureOr<T> Function() futureFunction, {
    String? title,
    required LoadingTag? tag,
    bool silence = false,
  }) => _controller.loadingRun<T>(
    futureFunction,
    title: title,
    tag: tag,
    silence: silence,
  );

  Future<T?> safeRun<T>(
    FutureOr<T> Function() futureFunction, {
    String? title,
    VoidCallback? onStart,
    VoidCallback? onEnd,
    bool silence = true,
  }) => _controller.safeRun<T>(
    futureFunction,
    title: title,
    onStart: onStart,
    onEnd: onEnd,
    silence: silence,
  );
}

extension CommonControllerExt on AppController {
  void toPage(PageLabel pageLabel) {
    _ref.read(currentPageLabelProvider.notifier).value = pageLabel;
  }

  void toProfiles() {
    toPage(PageLabel.profiles);
  }

  Future<void> openCloudLogin({bool navigateToCloud = true}) async {
    if (_isCloudLoginDialogShowing) {
      return;
    }
    _isCloudLoginDialogShowing = true;
    try {
      if (navigateToCloud) {
        toPage(PageLabel.oixCloud);
      }
      await Future<void>.delayed(Duration.zero);
      final context = globalState.navigatorKey.currentContext;
      if (context == null || !context.mounted) {
        return;
      }
      await showCloudLoginPage(context);
    } finally {
      _isCloudLoginDialogShowing = false;
    }
  }

  void updateStart() {
    updateStatus(!_ref.read(isStartProvider));
  }

  void updateSpeedStatistics() {
    _ref
        .read(appSettingProvider.notifier)
        .update((state) => state.copyWith(showTrayTitle: !state.showTrayTitle));
  }

  void updateMode() {
    _ref.read(patchClashConfigProvider.notifier).update((state) {
      final index = Mode.values.indexWhere((item) => item == state.mode);
      if (index == -1) {
        return null;
      }
      final nextIndex = index + 1 > Mode.values.length - 1 ? 0 : index + 1;
      return state.copyWith(mode: Mode.values[nextIndex]);
    });
  }

  void updateRunTime() {
    final startTime = globalState.startTime;
    if (!globalState.isUiVisible &&
        (startTime != null) == (_ref.read(runTimeProvider) != null)) {
      return;
    }
    if (startTime != null) {
      final startTimeStamp = startTime.millisecondsSinceEpoch;
      final nowTimeStamp = DateTime.now().millisecondsSinceEpoch;
      _ref.read(runTimeProvider.notifier).value = nowTimeStamp - startTimeStamp;
    } else {
      _ref.read(runTimeProvider.notifier).value = null;
    }
  }

  Future<void> updateTraffic() async {
    final startTime = globalState.startTime;
    if (startTime == null ||
        (!globalState.isUiVisible && !globalState.needsTrayTraffic)) {
      return;
    }
    bool isCurrentRun() => globalState.startTime == startTime;
    final ready = coreController.isCompleted;
    final onlyStatisticsProxy = _ref.read(
      appSettingProvider.select((state) => state.onlyStatisticsProxy),
    );
    final traffic = ready
        ? await coreController.getTraffic(onlyStatisticsProxy)
        : const Traffic();
    if (!isCurrentRun()) return;
    if (globalState.needsTrayTraffic) {
      await tray?.updateTraffic(traffic);
    }
    if (!isCurrentRun() || !globalState.isUiVisible) return;
    final totalTraffic = ready
        ? await coreController.getTotalTraffic(onlyStatisticsProxy)
        : const Traffic();
    if (!isCurrentRun() || !globalState.isUiVisible) return;
    _ref.read(trafficsProvider.notifier).addTraffic(traffic);
    _ref.read(totalTrafficProvider.notifier).value = totalTraffic;
  }

  Future<T?> loadingRun<T>(
    FutureOr<T> Function() futureFunction, {
    String? title,
    required LoadingTag? tag,
    bool silence = false,
  }) async {
    return safeRun(
      futureFunction,
      silence: silence,
      title: title,
      onStart: () {
        if (tag == null) {
          return;
        }
        _ref.read(loadingProvider(tag).notifier).start();
      },
      onEnd: () {
        if (tag == null) {
          return;
        }
        _ref.read(loadingProvider(tag).notifier).stop();
      },
    );
  }

  Future<T?> safeRun<T>(
    FutureOr<T> Function() futureFunction, {
    String? title,
    VoidCallback? onStart,
    VoidCallback? onEnd,
    bool silence = true,
  }) async {
    try {
      if (onStart != null) {
        onStart();
      }
      final res = await futureFunction();
      return res;
    } catch (e, s) {
      if (CloudApiException.isHandledUnauthorized(e)) {
        return null;
      }
      commonPrint.log('$title ===> $e, $s', logLevel: LogLevel.warning);
      final isConfigValidationError = e is ConfigValidationException;
      final message = isConfigValidationError
          ? formatConfigValidationMessage(e.message, appLocalizations)
          : coreLaunchBlockedMessage(e, appLocalizations) ??
                Secrets.redactApiDomains(e.toString());
      if (silence) {
        globalState.showNotifier(message);
      } else {
        globalState.showMessage(
          title: isConfigValidationError
              ? appLocalizations.profileParseErrorDesc
              : title ?? appLocalizations.tip,
          message: TextSpan(text: message),
          cancelable: !isConfigValidationError,
        );
      }
      return null;
    } finally {
      if (onEnd != null) {
        onEnd();
      }
    }
  }
}

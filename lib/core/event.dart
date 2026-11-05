import 'dart:async';

import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter/foundation.dart';

abstract mixin class CoreEventListener {
  void onLog(Log log) {}

  void onDelay(Delay delay) {}

  void onRequest(TrackerInfo connection) {}

  void onLoaded(String providerName) {}

  FutureOr<void> onCrash(String message) {}

  void onGeoUpdate(
    String geoType,
    bool updating,
    bool skipped,
    bool reload,
    String? error,
  ) {}

  void onModeChanged(String mode) {}
}

class CoreEventManager {
  final _controller = StreamController<CoreEvent>();

  CoreEventManager._() {
    _controller.stream
        .asyncMap((event) async {
          for (final CoreEventListener listener in _listeners) {
            try {
              switch (event.type) {
                case CoreEventType.log:
                  listener.onLog(Log.fromJson(event.data));
                  break;
                case CoreEventType.delay:
                  listener.onDelay(Delay.fromJson(event.data));
                  break;
                case CoreEventType.request:
                  listener.onRequest(TrackerInfo.fromJson(event.data));
                  break;
                case CoreEventType.loaded:
                  listener.onLoaded(event.data);
                  break;
                case CoreEventType.crash:
                  await listener.onCrash(event.data);
                  break;
                case CoreEventType.geoUpdate:
                  final data = event.data as Map<String, dynamic>;
                  listener.onGeoUpdate(
                    data['type'] as String,
                    data['updating'] as bool,
                    data['skipped'] as bool? ?? false,
                    data['reload'] as bool? ?? false,
                    data['error'] as String?,
                  );
                  break;
                case CoreEventType.mode:
                  listener.onModeChanged(event.data as String);
                  break;
              }
            } catch (error, stackTrace) {
              FlutterError.reportError(
                FlutterErrorDetails(
                  exception: error,
                  stack: stackTrace,
                  library: 'core event',
                ),
              );
            }
          }
          return event;
        })
        .listen((_) {});
  }

  static final CoreEventManager instance = CoreEventManager._();

  final ObserverList<CoreEventListener> _listeners =
      ObserverList<CoreEventListener>();

  bool get hasListeners {
    return _listeners.isNotEmpty;
  }

  void sendEvent(CoreEvent event) {
    _controller.add(event);
  }

  void addListener(CoreEventListener listener) {
    _listeners.add(listener);
  }

  void removeListener(CoreEventListener listener) {
    _listeners.remove(listener);
  }
}

final coreEventManager = CoreEventManager.instance;

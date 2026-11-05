import 'dart:async';

import 'package:fl_clash/common/constant.dart';
import 'package:fl_clash/common/system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

abstract mixin class TileListener {
  FutureOr<bool> onStart() => false;

  FutureOr<bool> onStop() => false;
}

class Tile {
  final MethodChannel _channel = const MethodChannel('$packageName/tile');

  Tile._() {
    _channel.setMethodCallHandler(_methodCallHandler);
  }

  static final Tile instance = Tile._();

  final ObserverList<TileListener> _listeners = ObserverList<TileListener>();
  bool _ready = false;

  Future<bool> _methodCallHandler(MethodCall call) async {
    if (call.method == 'start' || call.method == 'stop') {
      if (!_ready) return false;
      for (final listener in _listeners.toList()) {
        final handled = await (call.method == 'start'
            ? listener.onStart()
            : listener.onStop());
        if (handled) return true;
      }
      return false;
    }
    throw MissingPluginException();
  }

  Future<void> setReady(bool ready) async {
    _ready = ready && _listeners.isNotEmpty;
    await _channel.invokeMethod<void>('setReady', _ready);
  }

  void addListener(TileListener listener) {
    _listeners.add(listener);
  }

  void removeListener(TileListener listener) {
    _listeners.remove(listener);
    if (_listeners.isEmpty) {
      setReady(false).ignore();
    }
  }
}

final tile = system.isAndroid ? Tile.instance : null;

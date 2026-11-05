import 'dart:async';

import 'package:fl_clash/common/system.dart';
import 'package:proxy/proxy.dart';

final proxy = system.isDesktop ? Proxy() : null;

typedef SystemProxyStarter =
    Future<bool?> Function(int port, List<String> bypassDomain);
typedef SystemProxyStopper = Future<bool?> Function();

class SystemProxyController {
  final SystemProxyStarter? _startProxy;
  final SystemProxyStopper? _stopProxy;

  bool _startedByFlClash = false;
  Future<void> _task = Future.value();

  SystemProxyController({
    required SystemProxyStarter? startProxy,
    required SystemProxyStopper? stopProxy,
  }) : _startProxy = startProxy,
       _stopProxy = stopProxy;

  bool get startedByFlClash => _startedByFlClash;

  Future<void> start(int port, List<String> bypassDomain) {
    final startProxy = _startProxy;
    if (startProxy == null) return Future.value();

    return _queue(() async {
      final success = await startProxy(port, bypassDomain);
      if (success == true) {
        _startedByFlClash = true;
      }
    });
  }

  Future<void> stopIfNeeded() {
    final stopProxy = _stopProxy;
    if (stopProxy == null) return Future.value();

    return _queue(() async {
      if (!_startedByFlClash) return;

      final success = await stopProxy();
      if (success == true) {
        _startedByFlClash = false;
      }
    });
  }

  Future<void> _queue(Future<void> Function() task) {
    _task = _task.then((_) => task()).catchError((_) {});
    return _task;
  }
}

Future<void> startSystemProxy(int port, List<String> bypassDomain) {
  return systemProxyController.start(port, bypassDomain);
}

Future<void> stopSystemProxyIfNeeded() {
  return systemProxyController.stopIfNeeded();
}

final systemProxyController = SystemProxyController(
  startProxy: proxy?.startProxy,
  stopProxy: proxy?.stopProxy,
);

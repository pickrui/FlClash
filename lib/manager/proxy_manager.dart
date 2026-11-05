import 'dart:async';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/proxy.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProxyManager extends ConsumerStatefulWidget {
  final Widget child;

  const ProxyManager({super.key, required this.child});

  @override
  ConsumerState createState() => _ProxyManagerState();
}

class _ProxyManagerState extends ConsumerState<ProxyManager> {
  Future<void> _updateProxy(ProxyState proxyState) async {
    final isStart = proxyState.isStart;
    final systemProxy = proxyState.systemProxy;
    final port = proxyState.port;
    if (isStart && systemProxy && port > 0) {
      final started = await startSystemProxy(port, proxyState.bassDomain);
      if (!started) {
        commonPrint.log(
          'system proxy skipped: mixed proxy is unavailable on port $port',
          logLevel: LogLevel.warning,
        );
      }
    } else {
      await stopSystemProxyIfNeeded();
    }
  }

  @override
  void initState() {
    super.initState();
    ref.listenManual(proxyStateProvider, (prev, next) {
      if (prev != next) {
        unawaited(
          _updateProxy(next).catchError((Object error, StackTrace stackTrace) {
            commonPrint.log(
              'system proxy update failed: $error\n$stackTrace',
              logLevel: LogLevel.warning,
            );
          }),
        );
      }
    }, fireImmediately: true);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

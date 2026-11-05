import 'package:fl_clash/common/app_localizations.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/plugins/app.dart';
import 'package:fl_clash/plugins/tile.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TileManager extends ConsumerStatefulWidget {
  final Widget child;

  const TileManager({super.key, required this.child});

  @override
  ConsumerState<TileManager> createState() => _TileContainerState();
}

class _TileContainerState extends ConsumerState<TileManager> with TileListener {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  Future<bool> onStart() async {
    if (!ref.read(initProvider)) return false;
    app?.tip(appLocalizations.startVpn);
    await appController.updateStatus(true);
    return true;
  }

  @override
  Future<bool> onStop() async {
    if (!ref.read(initProvider)) return false;
    app?.tip(appLocalizations.stopVpn);
    await appController.updateStatus(false);
    return true;
  }

  @override
  void initState() {
    super.initState();
    tile?.addListener(this);
    ref.listenManual(initProvider, (_, ready) {
      tile?.setReady(ready).ignore();
    }, fireImmediately: true);
  }

  @override
  void dispose() {
    tile?.removeListener(this);
    super.dispose();
  }
}

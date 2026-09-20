import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/providers/state.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:tray/tray.dart' as native;

class TrayManager extends ConsumerStatefulWidget {
  final Widget child;

  const TrayManager({super.key, required this.child});

  @override
  ConsumerState<TrayManager> createState() => _TrayContainerState();
}

class _TrayContainerState extends ConsumerState<TrayManager> {
  StreamSubscription<native.TrayEvent>? _subscription;
  @override
  void initState() {
    super.initState();
    _subscription = native.Tray.instance.events.listen((event) {
      switch (event) {
        case native.TrayIconActivated():
          window?.show();
        case native.TrayMenuRequested():
          unawaited(
            native.Tray.instance.openMenu().catchError((Object error) {
              commonPrint.log('Tray menu failed: $error');
            }),
          );
        case native.TrayMenuItemSelected():
          render?.active();
      }
    });
    ref.listenManual(trayStateProvider, (prev, next) {
      if (prev != next) {
        appController.updateTray();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

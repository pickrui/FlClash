import 'dart:async';

import 'package:fl_clash/controller.dart';
import 'package:flutter/widgets.dart';

class CommonPopScope extends StatelessWidget {
  final Widget child;
  final FutureOr<bool> Function(BuildContext context)? onPop;

  const CommonPopScope({super.key, required this.child, this.onPop});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: onPop == null ? true : false,
      onPopInvokedWithResult: onPop == null
          ? null
          : (didPop, _) async {
              if (didPop) {
                return;
              }
              final res = await onPop!(context);
              if (!context.mounted) {
                return;
              }
              if (!res) {
                return;
              }
              Navigator.of(context).pop();
            },
      child: child,
    );
  }
}

class SystemBackBlock extends StatefulWidget {
  final Widget child;

  const SystemBackBlock({super.key, required this.child});

  @override
  State<SystemBackBlock> createState() => _SystemBackBlockState();
}

class _SystemBackBlockState extends State<SystemBackBlock> {
  late final BackBlockAction _action;
  bool _blocked = false;

  @override
  void initState() {
    super.initState();
    _action = context.backBlockAction;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _blocked = true;
      _action.backBlock();
    });
  }

  @override
  void dispose() {
    if (_blocked) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _action.unBackBlock();
      });
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

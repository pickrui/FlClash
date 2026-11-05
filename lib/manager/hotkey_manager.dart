import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/common.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:rust_api/rust_api.dart';

class HotKeyManager extends ConsumerStatefulWidget {
  final Widget child;

  const HotKeyManager({super.key, required this.child});

  @override
  ConsumerState<HotKeyManager> createState() => _HotKeyManagerState();
}

class _HotKeyManagerState extends ConsumerState<HotKeyManager> {
  StreamSubscription<int>? _eventSubscription;
  static Future<void> _pendingUpdate = Future.value();
  static int _ownerGeneration = 0;
  late final int _owner;

  @override
  void initState() {
    super.initState();
    _owner = ++_ownerGeneration;
    try {
      _eventSubscription = hotKeyEvents().listen(
        (id) {
          if (mounted && id >= 0 && id < HotAction.values.length) {
            _handleHotKeyAction(HotAction.values[id]);
          }
        },
        onError: (Object error) =>
            commonPrint.log('Hotkey events unavailable: $error'),
      );
    } catch (error) {
      commonPrint.log('Hotkey events unavailable: $error');
    }
    ref.listenManual(hotKeyActionsProvider, (prev, next) {
      if (!hotKeyActionListEquality.equals(prev, next)) {
        _pendingUpdate = _pendingUpdate.then<void>((_) async {
          if (!mounted) return;
          await _updateHotKeys(hotKeyActions: next);
        });
      }
    }, fireImmediately: true);
  }

  Future<void> _handleHotKeyAction(HotAction action) async {
    switch (action) {
      case HotAction.mode:
        appController.updateMode();
      case HotAction.start:
        appController.updateStart();
      case HotAction.view:
        appController.updateVisible();
      case HotAction.proxy:
        appController.updateSystemProxy();
      case HotAction.tun:
        appController.updateTun();
    }
  }

  Future<void> _updateHotKeys({
    required List<HotKeyAction> hotKeyActions,
  }) async {
    if (_owner != _ownerGeneration) return;
    try {
      final failures = await setHotKeys(
        specs: [
          for (final action in hotKeyActions)
            if (action.key != null && action.modifiers.isNotEmpty)
              HotKeySpec(
                id: action.action.index,
                key: action.key!,
                modifiers: action.modifiers
                    .map((m) => m.toHotKeyModifier())
                    .toList(),
              ),
        ],
      );
      for (final failure in failures) {
        commonPrint.log(
          'Hotkey ${failure.id} not registered: ${failure.reason}',
        );
      }
    } catch (error) {
      commonPrint.log('Hotkey update failed: $error');
    }
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    _pendingUpdate = _pendingUpdate.then(
      (_) => _updateHotKeys(hotKeyActions: []),
    );
    super.dispose();
  }

  Shortcuts _buildCloseShortcuts(Widget child) {
    return Shortcuts(
      shortcuts: {
        utils.controlSingleActivator(LogicalKeyboardKey.keyW):
            const CloseWindowIntent(),
      },
      child: Actions(
        actions: {
          CloseWindowIntent: CallbackAction<CloseWindowIntent>(
            onInvoke: (_) =>
                appController.handleBackOrExit(forceBack: system.isMacOS),
          ),
          DoNothingIntent: CallbackAction<DoNothingIntent>(
            onInvoke: (_) => null,
          ),
        },
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildCloseShortcuts(widget.child);
  }
}

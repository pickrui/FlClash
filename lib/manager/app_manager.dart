import 'dart:async';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/manager/window_manager.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AppStateManager extends ConsumerStatefulWidget {
  final Widget child;

  const AppStateManager({super.key, required this.child});

  @override
  ConsumerState<AppStateManager> createState() => _AppStateManagerState();
}

class _AppStateManagerState extends ConsumerState<AppStateManager>
    with WidgetsBindingObserver {
  bool _isBackground = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ref.listenManual(checkIpProvider, (prev, next) {
      if (prev != next && next.a && next.c) {
        ref.read(networkDetectionProvider.notifier).startCheck();
      }
    });
    ref.listenManual(configProvider, (prev, next) {
      if (prev != next) {
        appController.savePreferencesDebounce();
      }
    });
    ref.listenManual(needUpdateGroupsProvider, (prev, next) {
      if (prev != next) {
        appController.updateGroupsDebounce();
      }
    });
    if (window == null) {
      return;
    }
    ref.listenManual(autoSetSystemDnsStateProvider, (prev, next) async {
      if (prev == next) {
        return;
      }
      if (next.a == true && next.b == true) {
        macOS?.updateDns(false);
      } else {
        macOS?.updateDns(true);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    commonPrint.log('$state');
    final isBackgroundState =
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden ||
        (state == AppLifecycleState.inactive && !system.isDesktop);
    if (isBackgroundState) {
      if (!_isBackground) {
        await appController.savePreferences();
        if (system.isAndroid) {
          globalState.stopUpdateTasks();
        }
      }
      _isBackground = true;
    }
    if (state == AppLifecycleState.resumed) {
      final wasBackground = _isBackground;
      _isBackground = false;
      render?.resume();
      if (system.isAndroid && wasBackground && globalState.isStart) {
        globalState.startUpdateTasks();
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (wasBackground) {
          appController.clearDelay();
        }
        appController.tryCheckIp();
        if (system.isAndroid) {
          appController.tryStartCore();
        }
      });
    }
  }

  @override
  void didChangePlatformBrightness() {
    appController.updateBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerHover: (_) {
        render?.resume();
      },
      child: widget.child,
    );
  }
}

class AppEnvManager extends StatelessWidget {
  final Widget child;

  const AppEnvManager({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      if (globalState.isPre) {
        return Banner(
          message: 'DEBUG',
          location: BannerLocation.topEnd,
          child: child,
        );
      }
    }
    if (globalState.isPre) {
      return Banner(
        message: 'PRE',
        location: BannerLocation.topEnd,
        child: child,
      );
    }
    return child;
  }
}

class NavigationRailFocus extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final int itemCount;
  final ValueChanged<int> onSelected;
  final bool autofocus;

  const NavigationRailFocus({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.itemCount,
    required this.onSelected,
    this.autofocus = false,
  }) : assert(itemCount > 0),
       assert(currentIndex >= 0 && currentIndex < itemCount);

  KeyEventResult _handleKeyEvent(FocusNode _, KeyEvent event) {
    final logicalKey = event.logicalKey;
    final navigationOffset = switch (logicalKey) {
      LogicalKeyboardKey.arrowUp => -1,
      LogicalKeyboardKey.arrowDown => 1,
      _ => null,
    };
    final isActivationKey =
        logicalKey == LogicalKeyboardKey.enter ||
        logicalKey == LogicalKeyboardKey.numpadEnter ||
        logicalKey == LogicalKeyboardKey.gameButtonA ||
        logicalKey == LogicalKeyboardKey.select;
    if (event is KeyRepeatEvent &&
        (navigationOffset != null || isActivationKey)) {
      return KeyEventResult.handled;
    }
    if (event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }
    if (navigationOffset != null) {
      final nextIndex = currentIndex + navigationOffset;
      if (nextIndex >= 0 && nextIndex < itemCount) {
        onSelected(nextIndex);
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    }
    if (isActivationKey) {
      onSelected(currentIndex);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: autofocus,
      descendantsAreFocusable: false,
      onKeyEvent: _handleKeyEvent,
      child: child,
    );
  }
}

class AppSidebarContainer extends ConsumerWidget {
  final Widget child;

  const AppSidebarContainer({super.key, required this.child});

  void _updateSideBarWidth(WidgetRef ref, double contentWidth) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(sideWidthProvider.notifier).value =
          ref.read(viewSizeProvider.select((state) => state.width)) -
          contentWidth;
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(navigationStateProvider);
    final navigationItems = navigationState.navigationItems;
    final isMobileView = navigationState.viewMode == ViewMode.mobile;
    if (isMobileView) {
      return child;
    }
    final currentIndex = navigationState.currentIndex;
    final showLabel = ref.watch(appSettingProvider).showLabel;
    final labelTextStyle = context.textTheme.labelLarge!.copyWith(
      color: context.colorScheme.onSurface,
    );
    void selectDestination(int index) {
      appController.toPage(navigationItems[index].label);
    }

    return Row(
      children: [
        Material(
          color: context.colorScheme.surfaceContainer,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (system.isMacOS) const SizedBox(height: 22),
                const SizedBox(height: 10),
                if (!system.isMacOS) ...[
                  const ClipRect(child: AppIcon()),
                  const SizedBox(height: 12),
                ],
                Expanded(
                  child: ScrollConfiguration(
                    behavior: HiddenBarScrollBehavior(),
                    child: NavigationRailFocus(
                      autofocus: system.isAndroid,
                      currentIndex: currentIndex,
                      itemCount: navigationItems.length,
                      onSelected: selectDestination,
                      child: NavigationRail(
                        scrollable: true,
                        minExtendedWidth: 200,
                        backgroundColor: Colors.transparent,
                        selectedLabelTextStyle: labelTextStyle,
                        unselectedLabelTextStyle: labelTextStyle,
                        destinations: navigationItems
                            .map(
                              (e) => NavigationRailDestination(
                                icon: e.icon,
                                label: Text(Intl.message(e.label.name)),
                              ),
                            )
                            .toList(),
                        onDestinationSelected: selectDestination,
                        extended: false,
                        selectedIndex: currentIndex,
                        labelType: showLabel
                            ? NavigationRailLabelType.all
                            : NavigationRailLabelType.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                IconButton(
                  onPressed: () {
                    ref
                        .read(appSettingProvider.notifier)
                        .update(
                          (state) =>
                              state.copyWith(showLabel: !state.showLabel),
                        );
                  },
                  icon: Icon(
                    Icons.menu,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        Expanded(
          child: ClipRect(
            child: LayoutBuilder(
              builder: (_, constraints) {
                _updateSideBarWidth(ref, constraints.maxWidth);
                return child;
              },
            ),
          ),
        ),
      ],
    );
  }
}

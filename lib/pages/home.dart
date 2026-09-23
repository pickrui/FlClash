import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/manager/app_manager.dart';
import 'package:fl_clash/models/common.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final commonAction = context.commonAction;

    return HomeBackScopeContainer(
      child: AppSidebarContainer(
        child: Material(
          color: context.colorScheme.surface,
          child: Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(navigationStateProvider);
              final isMobile = state.viewMode == ViewMode.mobile;
              final navigationItems = state.navigationItems;
              final currentIndex = state.currentIndex;
              final bottomNavigationBar = NavigationBarTheme(
                data: _NavigationBarDefaultsM3(context),
                child: NavigationBar(
                  destinations: navigationItems
                      .map(
                        (e) => NavigationDestination(
                          icon: e.icon,
                          label: Intl.message(e.label.name),
                        ),
                      )
                      .toList(),
                  onDestinationSelected: (index) {
                    commonAction.toPage(navigationItems[index].label);
                  },
                  selectedIndex: currentIndex,
                ),
              );
              if (isMobile) {
                return Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: MediaQuery.removePadding(
                        removeTop: false,
                        removeBottom: true,
                        removeLeft: true,
                        removeRight: true,
                        context: context,
                        child: child!,
                      ),
                    ),
                    MediaQuery.removePadding(
                      removeTop: true,
                      removeBottom: false,
                      removeLeft: true,
                      removeRight: true,
                      context: context,
                      child: bottomNavigationBar,
                    ),
                  ],
                );
              } else {
                return child!;
              }
            },
            child: Consumer(
              builder: (_, ref, _) {
                final navigationItems = ref
                    .watch(currentNavigationItemsStateProvider)
                    .value;
                final isMobile = ref.watch(isMobileViewProvider);
                return _HomePageView(
                  navigationItems: navigationItems,
                  pageBuilder: (_, index) {
                    final navigationItem = navigationItems[index];
                    final navigationView = navigationItem.builder(context);
                    final view = KeepScope(
                      keep: navigationItem.keep,
                      child: isMobile
                          ? navigationView
                          : Navigator(
                              pages: [MaterialPage(child: navigationView)],
                              onDidRemovePage: (_) {},
                            ),
                    );
                    return Consumer(
                      key: ValueKey(navigationItem.label),
                      builder: (_, ref, child) {
                        final isActive = ref.watch(
                          navigationStateProvider.select(
                            (state) =>
                                state
                                    .navigationItems[state.currentIndex]
                                    .label ==
                                navigationItem.label,
                          ),
                        );
                        return PageActivityScope(
                          isActive: isActive,
                          child: child!,
                        );
                      },
                      child: view,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _HomePageView extends ConsumerStatefulWidget {
  final IndexedWidgetBuilder pageBuilder;
  final List<NavigationItem> navigationItems;

  const _HomePageView({
    required this.pageBuilder,
    required this.navigationItems,
  });

  @override
  ConsumerState createState() => _HomePageViewState();
}

class _HomePageViewState extends ConsumerState<_HomePageView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _indexOf(ref.read(currentPageLabelProvider)),
    );
    ref.listenManual(currentPageLabelProvider, (prev, next) {
      if (prev != next) {
        _toPage(next);
      }
    });
  }

  @override
  void didUpdateWidget(covariant _HomePageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.navigationItems.length != widget.navigationItems.length) {
      _updatePageController();
    }
  }

  // A page that left the navigation falls back to the first item, the same
  // index navigationStateProvider highlights.
  int _indexOf(PageLabel pageLabel) {
    final index = widget.navigationItems.indexWhere(
      (item) => item.label == pageLabel,
    );
    return index == -1 ? 0 : index;
  }

  Future<void> _toPage(
    PageLabel pageLabel, [
    bool ignoreAnimateTo = false,
  ]) async {
    if (!mounted) {
      return;
    }
    final index = _indexOf(pageLabel);
    final isAnimateToPage = ref.read(appSettingProvider).isAnimateToPage;
    final isMobile = ref.read(isMobileViewProvider);
    if (isAnimateToPage && isMobile && !ignoreAnimateTo) {
      await _pageController.animateToPage(
        index,
        duration: kTabScrollDuration,
        curve: Curves.easeOut,
      );
    } else {
      _pageController.jumpToPage(index);
    }
  }

  void _updatePageController() {
    final pageLabel = ref.read(currentPageLabelProvider);
    _toPage(pageLabel, true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.navigationItems.length,
      findChildIndexCallback: (key) {
        if (key is! ValueKey<PageLabel>) {
          return null;
        }
        final index = widget.navigationItems.indexWhere(
          (item) => item.label == key.value,
        );
        return index == -1 ? null : index;
      },
      itemBuilder: (context, index) {
        return widget.pageBuilder(context, index);
      },
    );
  }
}

class _NavigationBarDefaultsM3 extends NavigationBarThemeData {
  _NavigationBarDefaultsM3(this.context)
    : super(
        height: 80.0,
        elevation: 3.0,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      );

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;
  late final TextTheme _textTheme = Theme.of(context).textTheme;

  @override
  Color? get backgroundColor => _colors.surfaceContainer;

  @override
  Color? get shadowColor => Colors.transparent;

  @override
  Color? get surfaceTintColor => Colors.transparent;

  @override
  WidgetStateProperty<IconThemeData?>? get iconTheme {
    return WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      return IconThemeData(
        size: 24.0,
        color: states.contains(WidgetState.disabled)
            ? _colors.onSurfaceVariant.opacity38
            : states.contains(WidgetState.selected)
            ? _colors.onSecondaryContainer
            : _colors.onSurfaceVariant,
      );
    });
  }

  @override
  Color? get indicatorColor => _colors.secondaryContainer;

  @override
  ShapeBorder? get indicatorShape => const StadiumBorder();

  @override
  WidgetStateProperty<TextStyle?>? get labelTextStyle {
    return WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      final TextStyle style = _textTheme.labelMedium!;
      return style.apply(
        overflow: TextOverflow.ellipsis,
        color: states.contains(WidgetState.disabled)
            ? _colors.onSurfaceVariant.opacity38
            : states.contains(WidgetState.selected)
            ? _colors.onSurface
            : _colors.onSurfaceVariant,
      );
    });
  }
}

class HomeBackScopeContainer extends ConsumerWidget {
  final Widget child;

  const HomeBackScopeContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context, ref) {
    final systemAction = context.systemAction;

    return CommonPopScope(
      onPop: (context) async {
        final pageLabel = ref.read(currentPageLabelProvider);
        final realContext =
            GlobalObjectKey(pageLabel).currentContext ?? context;
        final canPop = Navigator.canPop(realContext);
        if (canPop) {
          Navigator.of(realContext).pop();
        } else {
          await systemAction.handleBackOrExit();
        }
        return false;
      },
      child: child,
    );
  }
}

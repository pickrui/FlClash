import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/inherited.dart';
import 'package:material_ui/material_ui.dart';

import 'scaffold.dart';
import 'side_sheet.dart';

@immutable
class SheetProps {
  final double? maxWidth;
  final bool isScrollControlled;
  final bool useSafeArea;
  final Color? backgroundColor;
  final bool blur;

  const SheetProps({
    this.maxWidth,
    this.backgroundColor,
    this.useSafeArea = true,
    this.isScrollControlled = false,
    this.blur = true,
  });
}

@immutable
class ExtendProps {
  final double? maxWidth;
  final bool blur;
  final bool forceFull;

  const ExtendProps({this.maxWidth, this.blur = true, this.forceFull = false});
}

enum SheetType { page, bottomSheet, sideSheet }

typedef SheetBuilder = Widget Function(BuildContext context, SheetType type);

Future<T?> showSheet<T>({
  required BuildContext context,
  required SheetBuilder builder,
  SheetProps props = const SheetProps(),
}) {
  final isMobile = globalState.container.read(isMobileViewProvider);
  return switch (isMobile) {
    true => showModalBottomSheet<T>(
      context: context,
      isScrollControlled: props.isScrollControlled,
      builder: (_) {
        return SheetProvider(
          type: SheetType.bottomSheet,
          child: builder(context, SheetType.bottomSheet),
        );
      },
      backgroundColor: props.backgroundColor,
      showDragHandle: false,
      useSafeArea: props.useSafeArea,
    ),
    false => showModalSideSheet<T>(
      context: context,
      backgroundColor: props.backgroundColor,
      constraints: BoxConstraints(maxWidth: props.maxWidth ?? 360),
      filter: props.blur ? commonFilter : null,
      builder: (_) {
        return SheetProvider(
          type: SheetType.sideSheet,
          child: builder(context, SheetType.sideSheet),
        );
      },
    ),
  };
}

Future<T?> showExtend<T>(
  BuildContext context, {
  required SheetBuilder builder,
  ExtendProps props = const ExtendProps(),
}) {
  final isMobile = globalState.container.read(isMobileViewProvider);
  return switch (isMobile || props.forceFull) {
    true => BaseNavigator.push(
      context,
      SheetProvider(
        type: SheetType.page,
        child: builder(context, SheetType.page),
      ),
    ),
    false => showModalSideSheet<T>(
      context: context,
      constraints: BoxConstraints(maxWidth: props.maxWidth ?? 360),
      filter: props.blur ? commonFilter : null,
      builder: (context) {
        return SheetProvider(
          type: SheetType.sideSheet,
          child: builder(context, SheetType.sideSheet),
        );
      },
    ),
  };
}

class AdaptiveSheetScaffold extends StatelessWidget {
  final SheetType? type;
  final Widget body;
  final String title;
  final List<Widget> actions;

  const AdaptiveSheetScaffold({
    super.key,
    this.type,
    required this.body,
    required this.title,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    final type = this.type ?? SheetProvider.of(context)?.type ?? SheetType.page;
    final backgroundColor = type == SheetType.bottomSheet
        ? context.colorScheme.surfaceContainerLow
        : context.colorScheme.surface;
    final closeButtonStyle = IconButton.styleFrom(
      visualDensity: VisualDensity.standard,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
    final closeButton = switch (type) {
      SheetType.page => null,
      SheetType.bottomSheet => IconButton.filledTonal(
        onPressed: context.safeNestedPop,
        style: closeButtonStyle,
        icon: const Icon(Icons.close),
      ),
      SheetType.sideSheet => IconButton(
        onPressed: context.safeNestedPop,
        style: closeButtonStyle,
        icon: const Icon(Icons.close),
      ),
    };
    final suffixPop = closeButton != null && actions.isEmpty;
    final appBar = AppBar(
      backgroundColor: backgroundColor,
      forceMaterialTransparency: type == SheetType.bottomSheet,
      leading: suffixPop ? null : closeButton,
      automaticallyImplyLeading: type == SheetType.page,
      centerTitle: true,
      toolbarHeight: type == SheetType.bottomSheet ? 48 : null,
      title: Text(title),
      titleTextStyle: type == SheetType.bottomSheet
          ? context.textTheme.titleLarge?.adjustSize(-4)
          : null,
      actions: genActions(suffixPop ? [closeButton] : actions),
    );
    if (type == SheetType.bottomSheet) {
      const handleSize = Size(28, 4);
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Container(
                alignment: Alignment.center,
                height: handleSize.height,
                width: handleSize.width,
                decoration: ShapeDecoration(
                  color: context.colorScheme.onSurfaceVariant,
                  shape: RoundedSuperellipseBorder(
                    borderRadius: BorderRadius.circular(handleSize.height / 2),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: appBar,
            ),
            const SizedBox(height: 6),
            Flexible(child: body),
            SizedBox(height: MediaQuery.viewInsetsOf(context).bottom),
            SizedBox(height: MediaQuery.viewPaddingOf(context).bottom),
          ],
        ),
      );
    }
    return CommonScaffold(appBar: appBar, body: body);
  }
}

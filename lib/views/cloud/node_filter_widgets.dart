import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:material_ui/material_ui.dart';

class NodeFilterPanel extends StatelessWidget {
  final Widget child;

  const NodeFilterPanel({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: colorScheme.surfaceContainerLow,
        shape: AppShape.all(AppCorner.md).copyWith(
          side: BorderSide(color: colorScheme.surfaceContainerHighest),
        ),
      ),
      child: child,
    );
  }
}

class NodeFilterSectionTitle extends StatelessWidget {
  final String text;

  const NodeFilterSectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: context.colorScheme.onSurface,
      ),
    );
  }
}

class NodeFilterChoiceChip extends StatelessWidget {
  final String label;
  final int? count;
  final NodeFilterChoice choice;
  final VoidCallback? onTap;
  final bool dense;

  const NodeFilterChoiceChip({
    super.key,
    required this.label,
    required this.choice,
    this.count,
    this.onTap,
    this.dense = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final l10n = context.appLocalizations;
    final (background, foreground, border, icon, state) = switch (choice) {
      NodeFilterChoice.any => (
        Colors.transparent,
        colorScheme.onSurface,
        colorScheme.outlineVariant,
        null,
        l10n.nodeFilterAny,
      ),
      NodeFilterChoice.only => (
        colorScheme.primaryContainer,
        colorScheme.onPrimaryContainer,
        colorScheme.primary,
        Icons.check,
        l10n.nodeFilterOnly,
      ),
      NodeFilterChoice.exclude => (
        colorScheme.errorContainer,
        colorScheme.onErrorContainer,
        colorScheme.error,
        Icons.block,
        l10n.nodeFilterExclude,
      ),
    };
    final shape = RoundedRectangleBorder(
      borderRadius: AppRadius.sm,
      side: BorderSide(color: border),
    );
    final textStyle =
        (dense ? context.textTheme.labelMedium : context.textTheme.labelLarge)
            ?.copyWith(
              color: foreground,
              decoration: choice == NodeFilterChoice.exclude
                  ? TextDecoration.lineThrough
                  : null,
              decorationColor: foreground,
            );
    final content = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: dense ? 8 : (icon == null ? 12 : 10),
        vertical: dense ? 3 : 7,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: dense ? 14 : 16, color: foreground),
            const SizedBox(width: 4),
          ],
          Text(label, style: textStyle),
          if (count case final count?) ...[
            const SizedBox(width: 6),
            Text(
              '$count',
              style: context.textTheme.labelMedium?.copyWith(
                color: foreground.withValues(alpha: 0.7),
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ],
      ),
    );
    if (onTap == null && dense) {
      return DecoratedBox(
        decoration: ShapeDecoration(color: background, shape: shape),
        child: content,
      );
    }
    return Semantics(
      button: true,
      enabled: onTap != null,
      label: '$label, $state',
      excludeSemantics: true,
      child: Material(
        color: background,
        shape: shape,
        clipBehavior: Clip.antiAlias,
        child: InkWell(onTap: onTap, child: content),
      ),
    );
  }
}

class NodeFilterNodeRow extends StatelessWidget {
  final NodeFilterNode node;

  const NodeFilterNodeRow({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            node.kept ? Icons.check_circle : Icons.remove_circle_outline,
            size: 18,
            color: node.kept ? colorScheme.primary : colorScheme.outline,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              node.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodyMedium?.copyWith(
                color: node.kept
                    ? colorScheme.onSurface
                    : colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

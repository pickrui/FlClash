import 'package:fl_clash/common/common.dart';
import 'package:material_ui/material_ui.dart';

class CommonTheme {
  final BuildContext context;
  final Map<String, Color> _colorMap;
  final double textScaleFactor;

  CommonTheme.of(this.context, this.textScaleFactor) : _colorMap = {};

  Color get darken2SecondaryContainer {
    return _colorMap.updateCacheValue(
      'darken2SecondaryContainer',
      () => context.colorScheme.secondaryContainer.blendDarken(
        context,
        factor: 0.2,
      ),
    );
  }

  Color get darken3PrimaryContainer {
    return _colorMap.updateCacheValue(
      'darken3PrimaryContainer',
      () => context.colorScheme.primaryContainer.blendDarken(
        context,
        factor: 0.3,
      ),
    );
  }
}

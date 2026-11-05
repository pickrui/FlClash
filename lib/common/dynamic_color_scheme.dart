// SPDX-License-Identifier: Apache-2.0
// Adapted from dynamic_color 1.8.1 corepalette_to_colorscheme.dart
// TODO(guidezpl): remove ignore after migration to new color roles
// ignore_for_file: deprecated_member_use

import 'package:material_ui/material_ui.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

extension CorePaletteToMaterialColorScheme on CorePalette {
  /// Create a [ColorScheme] from the given `palette` obtained from the Android OS.
  ColorScheme toMaterialColorScheme({
    Brightness brightness = Brightness.light,
  }) {
    final Scheme scheme;

    switch (brightness) {
      case Brightness.light:
        scheme = Scheme.lightFromCorePalette(this);
        break;
      case Brightness.dark:
        scheme = Scheme.darkFromCorePalette(this);
        break;
    }
    return ColorScheme(
      primary: Color(scheme.primary),
      onPrimary: Color(scheme.onPrimary),
      primaryContainer: Color(scheme.primaryContainer),
      onPrimaryContainer: Color(scheme.onPrimaryContainer),
      secondary: Color(scheme.secondary),
      onSecondary: Color(scheme.onSecondary),
      secondaryContainer: Color(scheme.secondaryContainer),
      onSecondaryContainer: Color(scheme.onSecondaryContainer),
      tertiary: Color(scheme.tertiary),
      onTertiary: Color(scheme.onTertiary),
      tertiaryContainer: Color(scheme.tertiaryContainer),
      onTertiaryContainer: Color(scheme.onTertiaryContainer),
      error: Color(scheme.error),
      onError: Color(scheme.onError),
      errorContainer: Color(scheme.errorContainer),
      onErrorContainer: Color(scheme.onErrorContainer),
      outline: Color(scheme.outline),
      outlineVariant: Color(scheme.outlineVariant),
      background: Color(scheme.background),
      onBackground: Color(scheme.onBackground),
      surface: Color(scheme.surface),
      onSurface: Color(scheme.onSurface),
      surfaceVariant: Color(scheme.surfaceVariant),
      onSurfaceVariant: Color(scheme.onSurfaceVariant),
      inverseSurface: Color(scheme.inverseSurface),
      onInverseSurface: Color(scheme.inverseOnSurface),
      inversePrimary: Color(scheme.inversePrimary),
      shadow: Color(scheme.shadow),
      scrim: Color(scheme.scrim),
      brightness: brightness,
    );
  }
}

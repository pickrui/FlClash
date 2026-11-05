import 'dart:ui' show Size;

double getWindowHeaderHeight({required bool isDesktop, required bool isMacOS}) {
  if (!isDesktop) return 0;
  return isMacOS ? 28 : 32;
}

/// Windows 11 draws its caption buttons 46 wide over a 32 tall title bar
/// and renders every glyph as a 10x10 Segoe Fluent icon.
const captionButtonWidth = 46.0;
const captionGlyphSize = 10.0;

/// The pin is not a caption button: it keeps the round Material button in a
/// square slot the height of the bar, with a regular icon size.
const pinIconSize = 16.0;

Size getCaptionButtonSize(double headerHeight) =>
    Size(captionButtonWidth, headerHeight);

bool showsWindowHeader({
  required bool isDesktop,
  required bool isMacOS,
  required int version,
  required bool isMobileView,
}) {
  if (!isDesktop) return false;
  return !(isMacOS && (version <= 10 || !isMobileView));
}

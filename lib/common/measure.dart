import 'package:fl_clash/common/common.dart';
import 'package:material_ui/material_ui.dart';

class Measure {
  final TextScaler _textScaler;
  final BuildContext context;
  final Map<String, double> _measureMap;

  Measure.of(this.context, double textScaleFactor)
    : _measureMap = {},
      _textScaler = TextScaler.linear(textScaleFactor);

  T _layoutText<T>(
    Text text,
    TextStyle? style,
    double? maxWidth,
    T Function(TextPainter painter) read,
  ) {
    final painter = TextPainter(
      text: TextSpan(text: text.data, style: text.style ?? style),
      maxLines: text.maxLines,
      textScaler: _textScaler,
      ellipsis: '...',
      locale: Localizations.localeOf(context),
      textDirection: text.textDirection ?? TextDirection.ltr,
    );
    try {
      return read(painter..layout(maxWidth: maxWidth ?? double.infinity));
    } finally {
      painter.dispose();
    }
  }

  Size computeTextSize(Text text, {TextStyle? style, double? maxWidth}) =>
      _layoutText(text, style, maxWidth, (painter) => painter.size);

  bool computeTextIsOverflow(Text text, {TextStyle? style, double? maxWidth}) =>
      _layoutText(
        text,
        style,
        maxWidth,
        (painter) => painter.didExceedMaxLines,
      );

  double _lineHeight(String key, TextStyle? style) =>
      _measureMap.updateCacheValue(
        key,
        () => computeTextSize(Text('X', style: style)).height,
      );

  double get bodyMediumHeight =>
      _lineHeight('bodyMediumHeight', context.textTheme.bodyMedium);

  double get bodySmallHeight =>
      _lineHeight('bodySmallHeight', context.textTheme.bodySmall);

  double get labelSmallHeight =>
      _lineHeight('labelSmallHeight', context.textTheme.labelSmall);

  double get titleSmallHeight =>
      _lineHeight('titleSmallHeight', context.textTheme.titleSmall);

  double get titleMediumHeight =>
      _lineHeight('titleMediumHeight', context.textTheme.titleMedium);
}

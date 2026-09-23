import 'package:fl_clash/widgets/text.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

var _builds = 0;

void main() {
  setUp(() {
    _builds = 0;
  });

  testWidgets('EmojiText rebuilds for the text scale but not for insets', (
    tester,
  ) async {
    const text = _CountingEmojiText('Tokyo 🇯🇵');

    Widget app({required double inset, double scale = 1}) {
      return MediaQuery(
        data: MediaQueryData(
          viewInsets: EdgeInsets.only(bottom: inset),
          textScaler: TextScaler.linear(scale),
        ),
        child: const Directionality(
          textDirection: TextDirection.ltr,
          child: text,
        ),
      );
    }

    await tester.pumpWidget(app(inset: 0));
    expect(_builds, 1);

    for (var inset = 10.0; inset <= 50; inset += 10) {
      await tester.pumpWidget(app(inset: inset));
    }
    expect(_builds, 1);

    await tester.pumpWidget(app(inset: 50, scale: 2));
    expect(_builds, 2);
    expect(
      tester.widget<RichText>(find.byType(RichText)).textScaler,
      const TextScaler.linear(2),
    );
  });
}

class _CountingEmojiText extends EmojiText {
  const _CountingEmojiText(super.text);

  @override
  Widget build(BuildContext context) {
    _builds++;
    return super.build(context);
  }
}

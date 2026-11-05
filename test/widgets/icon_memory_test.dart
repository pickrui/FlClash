import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:fl_clash/widgets/icon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('large node icons decode at display resolution', (tester) async {
    final source = await tester.runAsync(() async {
      final recorder = ui.PictureRecorder();
      final canvas = ui.Canvas(recorder);
      canvas.drawPaint(ui.Paint()..color = const ui.Color(0xff123456));
      final picture = recorder.endRecording();
      final image = await picture.toImage(4096, 2048);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      image.dispose();
      picture.dispose();
      return 'data:image/png;base64,${base64Encode(bytes!.buffer.asUint8List())}';
    });
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(devicePixelRatio: 3),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(child: CommonTargetIcon(src: source!, size: 24)),
        ),
      ),
    );
    final image = tester.widget<Image>(find.byType(Image));
    final info = await tester.runAsync(() async {
      final stream = image.image.resolve(ImageConfiguration.empty);
      final completer = Completer<ImageInfo>();
      late final ImageStreamListener listener;
      listener = ImageStreamListener((value, _) {
        stream.removeListener(listener);
        completer.complete(value);
      }, onError: completer.completeError);
      stream.addListener(listener);
      return completer.future;
    });
    expect(info!.image.width, 72);
    expect(info.image.height, 36);
    info.dispose();
    await tester.pumpWidget(const SizedBox.shrink());
    tester.binding.imageCache.clear();
    tester.binding.imageCache.clearLiveImages();
  });
}

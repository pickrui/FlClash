import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:fl_clash/common/picker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlatformFileExt.readBytes', () {
    test('returns embedded bytes when available', () async {
      final bytes = Uint8List.fromList([1, 2, 3]);
      final platformFile = PlatformFile(
        name: 'profile.yaml',
        size: bytes.length,
        bytes: bytes,
      );

      expect(await platformFile.readBytes(), bytes);
    });

    test('loads bytes from the selected file path', () async {
      final directory = await Directory.systemTemp.createTemp('picker_test_');
      addTearDown(() => directory.delete(recursive: true));
      final file = File('${directory.path}/profile.yaml');
      await file.writeAsString('mixed-port: 7890');
      final platformFile = PlatformFile(
        name: 'profile.yaml',
        size: await file.length(),
        path: file.path,
      );

      final bytes = await platformFile.readBytes();

      expect(String.fromCharCodes(bytes), 'mixed-port: 7890');
    });

    test('throws when neither bytes nor path are available', () {
      final platformFile = PlatformFile(name: 'profile.yaml', size: 0);

      expect(platformFile.readBytes, throwsStateError);
    });
  });
}

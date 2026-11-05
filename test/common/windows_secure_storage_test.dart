import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fl_clash/utils/windows_secure_storage.dart';
import 'package:fl_clash/utils/windows_storage_crypto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Directory directory;
  late String path;
  late WindowsSecureStorage storage;
  Uint8List encrypt(Uint8List bytes) => Uint8List.fromList([42, ...bytes]);
  Uint8List decrypt(Uint8List bytes) {
    if (bytes.isEmpty || bytes.first != 42) {
      throw const FormatException('unreadable ciphertext');
    }
    return Uint8List.fromList(bytes.sublist(1));
  }

  WindowsSecureStorage open() =>
      WindowsSecureStorage(path: path, encrypt: encrypt, decrypt: decrypt);

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('windows_storage_');
    path = '${directory.path}/flutter_secure_storage.dat';
    storage = open();
  });
  tearDown(() => directory.delete(recursive: true));

  test(
    'concurrent writes across keys and instances retain every value',
    () async {
      await Future.wait(
        List.generate(30, (index) => open().write('key$index', '$index')),
      );
      for (var index = 0; index < 30; index++) {
        expect(await storage.read('key$index'), '$index');
      }
    },
  );

  test('reads the existing DPAPI JSON layout without changing it', () async {
    final bytes = encrypt(
      Uint8List.fromList(
        utf8.encode('{"config_age_seed":"original","cloud_token":"token"}'),
      ),
    );
    await File(path).writeAsBytes(bytes);
    expect(await storage.read('config_age_seed'), 'original');
    expect(await File(path).readAsBytes(), bytes);
  });

  test(
    'unreadable storage is retained and cannot be overwritten or deleted',
    () async {
      for (final suffix in ['', '.old', '.tmp']) {
        await File('$path$suffix').writeAsString('broken$suffix');
      }
      await expectLater(storage.read('seed'), throwsFormatException);
      await expectLater(
        storage.write('seed', 'replacement'),
        throwsFormatException,
      );
      await expectLater(storage.delete('seed'), throwsFormatException);
      for (final suffix in ['', '.old', '.tmp']) {
        expect(await File('$path$suffix').readAsString(), 'broken$suffix');
      }
    },
  );

  test('recovers a valid backup and retains the damaged primary', () async {
    await storage.write('seed', 'original');
    await File(path).writeAsString('damaged primary');
    expect(await storage.read('seed'), 'original');
    final saved = await directory
        .list()
        .where((file) => file.path.contains('.unreadable-'))
        .single;
    expect(
      utf8.decode(decrypt(await File(saved.path).readAsBytes())),
      'damaged primary',
    );
    expect(await open().read('seed'), 'original');
  });

  test('recovers a fully written first-use temporary file', () async {
    await File('$path.tmp').writeAsBytes(
      encrypt(Uint8List.fromList(utf8.encode('{"seed":"pending"}'))),
    );
    expect(await storage.read('seed'), 'pending');
    expect(await File(path).exists(), isTrue);
  });

  test('encryption failure leaves the committed files unchanged', () async {
    await storage.write('seed', 'original');
    final before = await File(path).readAsBytes();
    final failing = WindowsSecureStorage(
      path: path,
      decrypt: decrypt,
      encrypt: (_) => throw StateError('protection unavailable'),
    );
    await expectLater(failing.write('seed', 'replacement'), throwsStateError);
    expect(await File(path).readAsBytes(), before);
    expect(await storage.read('seed'), 'original');
    await storage.write('token', 'next');
    expect(await storage.read('token'), 'next');
  });

  test('successful deletion updates the recovery copy too', () async {
    await storage.write('seed', 'original');
    await storage.write('token', 'logged-in');
    await storage.delete('token');
    await File(path).writeAsString('corrupt');
    expect(await storage.read('token'), isNull);
    expect(await storage.read('seed'), 'original');
  });

  test('invalid JSON does not silently discard individual keys', () async {
    final bytes = encrypt(Uint8List.fromList(utf8.encode('{"seed":123}')));
    await File(path).writeAsBytes(bytes);
    await expectLater(storage.read('seed'), throwsFormatException);
    expect(await File(path).readAsBytes(), bytes);
  });

  test(
    'a directory at the file path is an error, not a new installation',
    () async {
      await Directory(path).create();
      await expectLater(
        storage.write('seed', 'replacement'),
        throwsA(isA<FileSystemException>()),
      );
      expect(await Directory(path).exists(), isTrue);
    },
  );

  test(
    'Windows DPAPI preserves keys across storage instances',
    () async {
      final native = WindowsSecureStorage(path: path);
      await native.write('config_age_seed', 'original');
      await native.write('cloud_token', 'token');
      expect(
        await WindowsSecureStorage(path: path).read('config_age_seed'),
        'original',
      );
      final raw = await File(path).readAsBytes();
      expect(
        utf8.decode(raw, allowMalformed: true),
        isNot(contains('original')),
      );
      final decoded = jsonDecode(utf8.decode(unprotectWindowsStorage(raw)));
      expect(decoded, {'config_age_seed': 'original', 'cloud_token': 'token'});
      await File(path).writeAsBytes([1, 2, 3]);
      expect(await native.read('config_age_seed'), 'original');
    },
    skip: !Platform.isWindows,
  );
}

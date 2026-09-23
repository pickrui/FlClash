import 'dart:io';

import 'package:fl_clash/common/string.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;

  setUpAll(() {
    tempDir = Directory.systemTemp.createTempSync('flclash_string_test_paths_');
    PathProviderPlatform.instance = _FakePathProvider(tempDir.path);
  });

  tearDownAll(() {
    tempDir.deleteSync(recursive: true);
  });

  group('StringExtension.isUrl', () {
    test('valid http URL', () {
      expect('http://example.com'.isUrl, isTrue);
    });

    test('valid https URL', () {
      expect('https://example.com/path?q=1'.isUrl, isTrue);
    });

    test('valid ftp URL', () {
      expect('ftp://files.example.com'.isUrl, isTrue);
    });

    test('invalid scheme', () {
      expect('file:///path'.isUrl, isFalse);
    });

    test('no host', () {
      expect('http://'.isUrl, isFalse);
    });

    test('plain text', () {
      expect('not a url'.isUrl, isFalse);
    });
  });

  group('StringExtension.splitByMultipleSeparators', () {
    test('splits on comma', () {
      final result = 'a,b,c'.splitByMultipleSeparators;
      expect(result, ['a', 'b', 'c']);
    });

    test('splits on semicolon', () {
      final result = 'a;b;c'.splitByMultipleSeparators;
      expect(result, ['a', 'b', 'c']);
    });

    test('splits on space', () {
      final result = 'a b c'.splitByMultipleSeparators;
      expect(result, ['a', 'b', 'c']);
    });

    test('splits on mixed separators', () {
      final result = 'a, b; c'.splitByMultipleSeparators;
      expect(result, ['a', 'b', 'c']);
    });

    test('returns original string when single part', () {
      final result = 'hello'.splitByMultipleSeparators;
      expect(result, 'hello');
    });

    test('filters empty parts', () {
      final result = 'a,,b'.splitByMultipleSeparators;
      expect(result, ['a', 'b']);
    });
  });

  group('StringExtension.isSvg', () {
    test('detects SVG files', () {
      expect('icon.svg'.isSvg, isTrue);
      expect('icon.PNG'.isSvg, isFalse);
      expect('icon.svg.bak'.isSvg, isFalse);
    });
  });

  group('StringExtension.toMd5', () {
    test('produces consistent hash', () {
      final hash1 = 'hello'.toMd5();
      final hash2 = 'hello'.toMd5();
      expect(hash1, hash2);
    });

    test('different input produces different hash', () {
      expect('hello'.toMd5(), isNot(equals('world'.toMd5())));
    });

    test('produces 32 char hex string', () {
      final hash = 'test'.toMd5();
      expect(hash.length, 32);
      expect(RegExp(r'^[0-9a-f]{32}$').hasMatch(hash), isTrue);
    });
  });

  group('StringExtension.value', () {
    test('returns null for empty string', () {
      expect(''.value, isNull);
    });

    test('returns self for non-empty string', () {
      expect('hello'.value, 'hello');
    });
  });

  group('StringNullExt.takeFirstValid', () {
    test('returns self when non-null and non-empty', () {
      expect('hello'.takeFirstValid(['world']), 'hello');
    });

    test('returns first valid from others when self is null', () {
      expect(null.takeFirstValid(['world', 'foo']), 'world');
    });

    test('skips null and empty in others', () {
      expect(null.takeFirstValid([null, '', 'valid']), 'valid');
    });

    test('returns default when all are null or empty', () {
      expect(
        null.takeFirstValid([null, ''], defaultValue: 'default'),
        'default',
      );
    });

    test('trims whitespace', () {
      expect('  hello  '.takeFirstValid([]), 'hello');
    });
  });
}

class _FakePathProvider extends PathProviderPlatform {
  final String path;

  _FakePathProvider(this.path);

  @override
  Future<String?> getTemporaryPath() async => path;

  @override
  Future<String?> getApplicationSupportPath() async => path;

  @override
  Future<String?> getApplicationCachePath() async => path;

  @override
  Future<String?> getDownloadsPath() async => path;
}

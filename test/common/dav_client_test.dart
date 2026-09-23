import 'package:fl_clash/common/dav_client.dart';
import 'package:fl_clash/models/models.dart';
import 'package:test/test.dart';

void main() {
  test('WebDAV backup file name rejects path and URI syntax', () {
    for (final value in [
      '',
      '.',
      '..',
      '../backup.zip',
      r'..\backup.zip',
      'folder/backup.zip',
      'backup.zip?overwrite=true',
      'backup.zip#fragment',
      'backup\u0000.zip',
    ]) {
      expect(isSafeDavFileName(value), false, reason: value);
    }
    expect(isSafeDavFileName('flclash-backup.zip'), true);
  });

  test('WebDAV URL accepts only http(s) with a host', () {
    for (final value in [
      '',
      'dav.example.com/dav',
      'ftp://dav.example.com/dav',
      'file:///tmp/dav',
      'https:///dav',
      'http://[::1',
    ]) {
      expect(isValidDavUri(value), false, reason: value);
    }
    expect(isValidDavUri('https://dav.example.com/dav'), true);
    expect(isValidDavUri('http://127.0.0.1:5005'), true);
  });

  test('DAVClient rejects a URL isValidDavUri rejects', () {
    expect(
      () => DAVClient(
        const DAVProps(
          uri: 'ftp://dav.example.com/dav',
          user: '',
          password: '',
        ),
      ),
      throwsFormatException,
    );
  });
}

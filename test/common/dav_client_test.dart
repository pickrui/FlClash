import 'package:fl_clash/common/dav_client.dart';
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
}

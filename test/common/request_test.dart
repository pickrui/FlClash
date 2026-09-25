import 'package:fl_clash/common/request.dart';
import 'package:test/test.dart';

void main() {
  test('releaseTagNameFromVersionData ignores build-only versions', () {
    expect(releaseTagNameFromVersionData({'version': '2026072318'}), isNull);
    expect(
      releaseTagNameFromVersionData({'version': '0.8.95+2026072318'}),
      'v0.8.95',
    );
    expect(releaseTagNameFromVersionData({'tag_name': 'v0.8.96'}), 'v0.8.96');
  });

  test('version API preserves the full version beside the legacy build', () {
    final info = AppUpdateInfo.fromVersionData({
      'version': '2026092110',
      'full_version': '0.8.98+2026092110',
      'release_notes': '## v0.8.98\n- Offered change\n## v0.8.97\n- Old change',
    });
    expect(info.version, '0.8.98+2026092110');
    expect(info.remoteBuildNumber, 2026092110);
    expect(info.releaseNotes, '- Offered change');
    expect(releaseTagNameFromVersionData(info.version), 'v0.8.98');
  });

  for (final key in ['tag_name', 'tagName', 'version_name', 'versionName']) {
    test('separate $key survives version response parsing', () {
      final info = AppUpdateInfo.fromVersionData({
        'version': '2026092110',
        key: 'v0.8.98',
      });
      expect(info.version, '0.8.98+2026092110');
      expect(info.remoteBuildNumber, 2026092110);
    });
  }

  test('legacy full and build-only versions remain supported', () {
    for (final version in ['0.8.98+2026092110', '2026092110']) {
      for (final data in [
        version,
        {'version': '  $version  '},
      ]) {
        final info = AppUpdateInfo.fromVersionData(data);
        expect(info.version, version);
        expect(info.remoteBuildNumber, 2026092110);
      }
    }
  });

  test('missing or invalid version fields are rejected', () {
    for (final data in [
      null,
      '',
      '  ',
      2026092110,
      {},
      {'version': null},
    ]) {
      expect(() => AppUpdateInfo.fromVersionData(data), throwsFormatException);
    }
  });

  test('extractEmbeddedReleaseNotes accepts supported API fields', () {
    expect(
      extractEmbeddedReleaseNotes({
        'version': '2026072318',
        'release_notes': '  - Fix startup\n\n\n- Improve updates  ',
      }, 'v0.8.95'),
      '- Fix startup\n- Improve updates',
    );
  });

  test('extractEmbeddedReleaseNotes selects only the requested version', () {
    expect(
      extractEmbeddedReleaseNotes({
        'releaseNotes': '''
## v0.8.95

- Current change

## v0.8.94

- Previous change
''',
      }, 'v0.8.94'),
      '- Previous change',
    );
  });

  test(
    'extractReleaseNotesFromReleaseBody selects only the current version',
    () {
      expect(
        extractReleaseNotesFromReleaseBody('''
## v0.8.95

- Fix silent launch
- Show release notes

## v0.8.94

- Previous change

<div align=center>
download table
''', 'v0.8.95'),
        '- Fix silent launch\n- Show release notes',
      );
    },
  );

  test('extractReleaseNotesFromReleaseBody accepts an unversioned body', () {
    expect(
      extractReleaseNotesFromReleaseBody(
        '- Fix silent launch\n- Show release notes',
        'v0.8.95',
      ),
      '- Fix silent launch\n- Show release notes',
    );
  });

  test('extractReleaseNotesFromChangelog selects the requested version', () {
    expect(
      extractReleaseNotesFromChangelog('''
## v0.8.95

- feat: release v0.8.95

- chore(release): follow upstream v0.8.95

- Latest change

## v0.8.94

- Previous change
''', 'v0.8.95'),
      '- Latest change',
    );
  });

  test('normalizeReleaseNotes keeps meaningful dependency versions', () {
    expect(
      normalizeReleaseNotes('- Upgrade Flutter to 3.44'),
      '- Upgrade Flutter to 3.44',
    );
  });

  test('normalizeReleaseNotes preserves paragraph breaks', () {
    expect(
      normalizeReleaseNotes('Summary\n\nDetails\n\n- First\n\n- Second'),
      'Summary\n\nDetails\n\n- First\n- Second',
    );
  });

  test('latestReleaseTagNameFromChangelog selects the first release', () {
    expect(
      latestReleaseTagNameFromChangelog('''
## v0.8.96

- Current change

## v0.8.95
'''),
      'v0.8.96',
    );
  });
}

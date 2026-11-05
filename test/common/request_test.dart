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

  test('extractEmbeddedReleaseNotes accepts supported API fields', () {
    expect(
      extractEmbeddedReleaseNotes({
        'version': '2026072318',
        'release_notes': '  - Fix startup\n\n\n- Improve updates  ',
      }, 'v0.8.95'),
      '- Fix startup\n- Improve updates',
    );
  });

  test('extractEmbeddedReleaseNotes selects only the current version', () {
    expect(
      extractEmbeddedReleaseNotes({
        'releaseNotes': '''
## v0.8.95

- Current change

## v0.8.94

- Previous change
''',
      }, 'v0.8.94'),
      '- Current change',
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

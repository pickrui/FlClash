# Markdown release notes

`CHANGELOG.md` is the only maintained release-note source. Keep the existing
Chinese paragraph style and place compatibility changes first in the current
version. The app prefers update API notes, then the matching GitHub Release body,
then the matching tagged Markdown file. Published Release bodies must agree with
Markdown; changing main does not rewrite an existing tag.

The CLI defaults to pickrui/FlClash and preserves v0.8.99 and older notes verbatim.
`release --version X.Y.Z` prepares Markdown for a new version; `build` fills missing
release sections from Conventional Commits while preserving edited paragraphs.
`build --unreleased` also prepares the untagged pubspec version. `render release`
and `render telegram` derive their output from Markdown; captions escape HTML and
respect the size limit. `verify` checks duplicate/empty sections and coverage of
reachable Git release tags. No command sends messages or publishes releases.

`bash tool/release.sh X.Y.Z` previews. `--apply` prepares notes and the version;
`--tag` also commits and tags locally. Neither pushes, and published tags are
immutable. The checked-in build-number suffix stays a snapshot.

The commit parser and render helpers originated from chen08209/FlClash at
4b59eca853778d4e7be3de26589252889c899bc5 under the root GPL-3.0 LICENSE.

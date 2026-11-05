# Structured release notes

Ported from chen08209/FlClash at 4b59eca853778d4e7be3de26589252889c899bc5 under the root GPL-3.0 LICENSE. The app and site understand schema 2.

The CLI defaults to pickrui/FlClash and freezes v0.8.99 and older notes. Pass global `--boundary` or `--repository` before the command for fixture repositories. `build` writes JSON only, `release --version X.Y.Z` prepares JSON and Markdown, `render release --tag vX.Y.Z` renders a release body, and `verify` checks the recorded commit ranges. Published tags are immutable through `release`.

Release comments escape `>` because an entry containing `-->` would prematurely close embedded JSON. Caption rendering escapes HTML and truncates to Telegram limits; it does not send anything. Frozen Markdown is retained verbatim.

`bash tool/release.sh X.Y.Z` only previews. `--apply` prepares files; `--tag` with `--apply` also commits and tags locally. Neither pushes. The build-number suffix stays a snapshot; setup.dart and CI continue generating the Beijing-time build number.

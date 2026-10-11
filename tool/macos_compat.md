# macOS 12 native assets

The Runner advertises macOS 12.0, but Flutter 3.47.4 passes a hardcoded macOS 13
target to native build hooks. The sqlite3 3.5.2 release binaries also require
macOS 13 on both x86_64 and arm64. Setting Xcode's deployment target or
MACOSX_DEPLOYMENT_TARGET alone does not correct these libraries.

Before Flutter embeds native frameworks, `build_macos_compat.py` invokes the
locked objective_c and sqlite3 package build hooks with a macOS 12 target.
SQLite is compiled from the official 3.53.4 amalgamation, matching the existing
package's SQLite version and default build options. The archive is verified
against the SHA256 recorded in the script. Flutter then embeds and signs the
resulting frameworks normally. No installed SDK or pub-cache source is edited.

The private cache under `.dart_tool/macos_compat` includes the architecture,
toolchain, dependency lockfile, package sources and build script in its key.
A file lock serializes cache updates. The same path runs for local Flutter
builds, setup.dart packaging and both macOS CI architectures.

The final Xcode phase checks every bundled Mach-O slice for its deployment
target and required architecture. A framework requiring macOS 13 fails the
build before packaging. This is a build check, not proof of execution on
macOS 12; that still requires a Monterey device or VM.

When updating objective_c or sqlite3, review the hooks and upstream minimum
versions, update the explicit package pins and `PACKAGES`, and update SQLite's
source URL and checksum if its embedded SQLite version changes. Keep the
upstream build options. Remove the rebuild workaround only when both Flutter's
hook configuration and all downloaded native libraries respect macOS 12.

Focused checks:

```sh
python3 -m unittest discover -s test/ci -p 'test_macos_compat.py' -v
python3 tool/check_macos_compat.py "/path/to/FlClash for oixCloud.app" --archs x86_64
```

The regression tests use the macOS linker to build fixtures for macOS 12 and
13, including a universal binary with one incompatible slice. They never run
the app. Any app smoke test must use SAFE_MODE and `run_macos_isolated.py` as
described in AGENTS.md.

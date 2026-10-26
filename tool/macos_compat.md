# macOS 13 minimum requirement

The rebuilt v0.9.2 uses Go 1.27 and requires macOS 13. A one-time final
macOS 12 edition uses Go 1.26 and includes the same production fixes, with app
update checks and the update entry disabled. It is packaged separately as
`flclash-v0.9.2-macos12-final-{arm64,amd64}.dmg`; it will receive no further
updates. Do not add ongoing macOS 12 CI jobs or compatibility build switches.
The user requested removal of tags at the original commit
`431f54bb35ab7d5f3eb409882ab0db39921aade7`; do not recreate those tags.

The app and Go 1.27 Core require macOS 13 Ventura or later. Runner, local Swift
packages, the Rust Native Assets hook, and release CI all target 13.0.

Native Assets builds SQLite and Objective-C through their package hooks. The
previous macOS 12 source rebuild is retired; no libraries are rewritten after
the package hooks complete.

Before signing, `check_macos_compat.py` checks the app Info.plist and every Mach-O
binary, including all slices of universal libraries. The app must declare 13.0;
no bundled binary may require a newer macOS version or omit a requested architecture.

```sh
python3 tool/check_macos_compat.py /absolute/path/FlClash.app --archs "arm64"
python3 -m unittest test.ci.test_macos_compat
```

These checks inspect metadata. Runtime verification still requires macOS 13
hardware or a VM. Local smoke tests must use SAFE_MODE and run_macos_isolated.py.

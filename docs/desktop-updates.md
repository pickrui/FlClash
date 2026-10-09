# Desktop updates

Desktop updates download a complete release package, verify an Ed25519 signed
manifest and its SHA-256 digest, and apply only after the user confirms. This is
an in-place full update, not a delta patch. Application support data, profiles,
subscriptions and preferences are outside the application directory.

| Installation | Update behavior |
| --- | --- |
| Windows Inno installation | Wait for graceful shutdown, request UAC, run the signed payload silently in the current directory, then restart as the original user |
| macOS Developer ID app | Check the same bundle identifier and signing team, stage the new app next to the installed app, wait for exit, replace and reopen |
| Linux AppImage | Stage next to `$APPIMAGE`, wait for exit, replace and reopen |
| Linux deb / rpm | Verify the download and open it with the system package manager |
| Linux AUR / pacman | Continue to use the package manager; do not download another package format |
| Android | Existing system APK installation is unchanged |

Windows uses the existing AppId and Inno setup engine without displaying its
wizard or uninstalling the application. The old Helper service is stopped and
removed before copying files, and a previously registered service is restored
with the new Core, Helper and manifest. OTA mode does not use the manual
installer's global process-name termination. A canceled UAC prompt or failed
installer restarts the installed application and records a failure for the next
launch. A reboot-required result is recorded as a failure and does not start a
possibly mixed installation.

macOS and AppImage require a writable installation parent. A read-only DMG,
protected app directory, ad-hoc macOS build or portable Windows ZIP requires a
manual update. Unix replacements keep the previous app in the private staging
directory until replacement and launch succeed. A failed replacement attempts
to restore it. This is not a health check of the restarted app and does not
guarantee recovery from power loss between renames. Failed staging directories
retain the worker log and any recovery copy.

## Signing and release

The pinned public key is in `lib/services/update_signature.dart`. The matching
private seed is stored locally in the ignored `.ota-signing-key` file with mode
0600. Keep a secure backup; do not commit it or include it in build artifacts.

For a locally built release, use the same build number stamped into every app:

```sh
dart tool/sign_updates.dart dist 2026100911 --key-file .ota-signing-key
```

The signer emits `<package>.update.json` beside each desktop package. Publish
both files together. Each signature binds the schema, exact artifact name
(including platform and architecture), build number, size and SHA-256. The
client requires the offered build to match; it rejects unsigned, mismatched or
modified packages. A stale or invalid mirror causes a fresh package and sidecar
download from GitHub, using the offered release tag when available. A failed
verification leaves the explicit browser-download option
available but never automatically opens the unverified package.

Actions can sign using the `FLCLASH_OTA_SIGNING_KEY` repository secret. Without
that secret, builds still publish normal packages, print a warning and do not
provide automatic updates. The private key has not been uploaded to GitHub.
The first client containing this updater must be installed through the previous
update flow; older clients cannot gain the new behavior before that upgrade.

## Validation

`test/services/desktop_update_test.dart` covers signatures, tampering, version
and architecture binding, bounded metadata, cancellation and verification before
handoff. `test/ci/test_desktop_update_worker.py` executes the Unix worker against
temporary executable fixtures, including failed replacement and cancellation.
`tool/check_desktop_update.ps1` exercises the real PowerShell worker with mocked
process/UAC operations; the existing Windows checks run it under Windows
PowerShell. These tests do not replace signed release-to-release tests on
Windows, macOS and a Linux AppImage host. Never test by replacing the normal
host application or changing its proxy, DNS or TUN configuration.

# Desktop updates

Desktop updates download a complete release package, verify an Ed25519 signed
manifest and its SHA-256 digest, and apply only after the user confirms. This is
an in-place full update, not a delta patch. Application support data, profiles,
subscriptions and preferences are outside the application directory.

| Installation | Update behavior |
| --- | --- |
| Windows Inno installation | Wait for graceful shutdown, request UAC, run the signed payload in the current directory showing only Setup's uncancelable progress window, then restart as the original user |
| macOS Developer ID app | Check the same bundle identifier and signing team, stage the new app next to the installed app, wait for exit, replace and reopen |
| Linux AppImage | Stage next to `$APPIMAGE`, wait for exit, replace and reopen |
| Linux deb / rpm | Verify the download and open it with the system package manager |
| Linux AUR / pacman | Continue to use the package manager; do not download another package format |
| Android | Existing system APK installation is unchanged |

Windows uses the existing AppId and Inno setup engine without displaying its
wizard or uninstalling the application (`/SILENT /NOCANCEL`). Until the app exits,
the update page shows the package check and staging as a progress bar. The old Helper service is stopped and
removed before copying files; failure stops installation. A previously registered
service is restored with the new Core, Helper and manifest, or with the
previous files when the copy fails or is canceled. A Helper that cannot be
registered again makes the installer report failure and preserves the recovery
record for a retry. Manual installation stops only the app and Core processes
whose executable paths match the installation directory. OTA mode waits for
the app to exit instead. The worker keeps the verified installer open without
write or delete sharing from its hash check until setup exits, and rejects a staging path
that passes through a junction or symbolic link. A canceled UAC prompt or failed
installer restarts the installed application and records a failure for the next
launch. A reboot-required result is recorded as a failure and does not start a
possibly mixed installation.

Canceling the initial Windows uninstall confirmation leaves the app and Helper
running. Service removal and process shutdown start only after confirmation;
service removal failure stops the uninstall before application files are removed.
User data cleanup resolves the account of the current desktop shell, uses that
account's data directories and registry hive, and requests confirmation before
deleting profiles or settings. It preserves data and reports a failure when the
account cannot be resolved or accessed. Silent uninstalls preserve user data.
Startup and protocol registrations are removed only when their command launches
this installation's `FlClash.exe`; a reference in another program's arguments
does not qualify for removal.
Registry deletion failures are reported after the remaining user cleanup has
been attempted. If deleting the Run entry fails, its StartupApproved state is
preserved so an existing disabled startup entry is not inadvertently enabled.
Cross-account access retries with `SeDebugPrivilege` only after access is denied,
restores the previous privilege state before impersonating the desktop user,
and preserves user data when privilege assignment or restoration fails.
Missing data directories count as already cleared; access errors and unexpected
file types are reported as failures rather than being treated as missing paths.

The in-app clear-data action saves credential deletion markers before removing
credentials, preferences or application data. A marker write failure stops that
destructive phase. Keyring deletion failures keep the relevant markers, including
across repeated clear-data attempts after the network list has already been cleared.
The destructive phase invalidates the cloud account session, so an in-flight
account refresh or token exchange cannot save credentials back after deletion.
The Windows and Linux preferences store updates its committed cache only after
a successful disk write. A failed write is not exposed by a reload or included
in a later, unrelated save.

Android's Dart secure-storage operations disable `resetOnError`, matching the
native config-key reader. Storage exceptions must not trigger the plugin's
automatic deletion of all credentials. System cloud backup and device transfer
exclude app data through the manifest and `data_extraction_rules.xml`.
macOS clear-data waits for system DNS restoration before deleting credentials,
preferences or the DNS recovery journal. A restoration failure aborts that
destructive phase and keeps the journal available for retry. It removes app-local
credentials without accessing shared Keychain entries.
Linux package removal preserves per-user settings; the app's explicit
clear-data action owns that cleanup. AUR removal retains the service unit and
staged binaries if stopping the service fails, matching the deb/rpm cleanup barrier.
An individual preference or application-data entry that cannot be removed does
not stop cleanup of the remaining entries or the durable config copies. Failed
items are retained for retry, and cleanup still returns the original failure.
The in-app destructive phase displays that failure and waits for acknowledgement
before exiting; preflight errors leave the app open and use its usual error UI.

Only an attempt that closed the app is reported on the next launch. A worker
that fails before the app exits reports the error immediately, and the app
keeps running. When the in-place update is unavailable or fails before exit for
any reason other than a package that no longer matches its signature, the app
falls back to the previous manual flow: it opens the verified installer or DMG,
or shows the folder of a downloaded AppImage. This flow rechecks the package
and its signed metadata before opening anything, including when staging failed.

macOS and AppImage require a writable installation parent. A read-only DMG,
protected app directory, ad-hoc macOS build or portable Windows ZIP requires a
manual update. Unix replacements keep the previous app in the private staging
directory until replacement and launch succeed. A failed replacement attempts
to restore it. This is not a health check of the restarted app and does not
guarantee recovery from power loss between renames. The next launch removes
leftover staging directories unless one still holds a recovery copy, a disk
image that could not be detached, or a ready worker without a terminal result.
That last case may still be waiting for UAC or completing the replacement.
A Unix status-file write failure does not undo a completed replacement or
prevent restarting a restored application.

## Signing and release

The pinned public key is in `lib/services/update_signature.dart`. The matching
private seed is stored locally in the ignored `.ota-signing-key` file with mode
0600. Keep a secure backup; do not commit it or include it in build artifacts.

For a locally built release, use the same build number stamped into every app:

```sh
dart tool/sign_updates.dart dist 2026100911 --key-file .ota-signing-key
```

The signer first gives packages their published names, as CI does
(`flclash-windows-<arch>-setup.exe`, `.AppImage`), then emits
`<package>.update.json` beside each desktop package. Publish both files
together. Each signature binds the schema, exact artifact name (including
platform and architecture), build number, size and SHA-256. The client fetches
the signed manifest before the package, from the mirror or else GitHub, and
requires the offered build to match; it rejects unsigned, mismatched or
modified packages. A release without a signed manifest fails before the package
is downloaded. A stale mirror package causes a fresh package download from
GitHub, using the offered release tag when available. A failed verification
leaves the explicit browser-download option available but never automatically
opens the unverified package.

Actions signs using the `FLCLASH_OTA_SIGNING_KEY` repository secret, configured
with the same private seed as the local backup. Without that secret, builds still
publish normal packages, print a warning and do not provide automatic updates.
The first client containing this updater must be installed through the previous
update flow; older clients cannot gain the new behavior before that upgrade.

## Validation

`test/services/desktop_update_test.dart` covers signatures, tampering, version
and architecture binding, bounded metadata, cancellation and verification before
handoff. `test/ci/test_desktop_update_worker.py` executes the Unix worker against
temporary executable fixtures, including failed replacement and cancellation.
On macOS it also uses real `codesign` checks on temporary ad-hoc bundles to
cover inline requirement parsing, identity mismatch and post-readiness tampering;
application launches remain mocked. Both macOS verification calls prefix the
requirement with `=` so `codesign` reads it as an expression instead of a path.
`tool/check_desktop_update.ps1` exercises the real PowerShell worker with mocked
process/UAC operations; the existing Windows checks run it under Windows
PowerShell. These tests do not replace signed release-to-release tests on
Windows, macOS and a Linux AppImage host. Never test by replacing the normal
host application or changing its proxy, DNS or TUN configuration.

#!/bin/sh
# Run only in an isolated offline Linux container, never on the desktop host.
set -eu
[ "${FLCLASH_HELPER_TEST_CONTAINER:-}" = 1 ] && [ -f /.dockerenv ] && [ "$(id -u)" = 0 ] || exit 77
fixture=$(mktemp -d)
trap 'rm -rf "$fixture"' EXIT
mkdir -p "$fixture/bin" "$fixture/App Image 100%" /etc/systemd/system
printf '#!/bin/sh\nexit 0\n' > "$fixture/App Image 100%/FlClashCore"
export CORE_SHA256=$(sha256sum "$fixture/App Image 100%/FlClashCore" | cut -d ' ' -f 1)
export CORE_NAME=FlClashCore
cargo build --locked --offline
cp target/debug/helper "$fixture/App Image 100%/FlClashHelperService"
cat > "$fixture/bin/id" <<'EOF'
#!/bin/sh
[ "$1" = -g ] && [ "$2" = 1000 ] && { echo 1000; exit 0; }
exec /usr/bin/id "$@"
EOF
cat > "$fixture/bin/systemctl" <<'EOF'
#!/bin/sh
echo "$*" >> "$FIXTURE/systemctl.log"
if [ "$1" = restart ] && [ -f "$FIXTURE/fail-once" ]; then
  rm "$FIXTURE/fail-once"
  exit 1
fi
EOF
chmod 755 "$fixture/bin/id" "$fixture/bin/systemctl"
export FIXTURE="$fixture" PATH="$fixture/bin:$PATH" PKEXEC_UID=1000
helper="$fixture/App Image 100%/FlClashHelperService"
unit=/etc/systemd/system/flclash-helper.service
installed="/usr/local/libexec/flclash/$CORE_SHA256/FlClashHelperService"
"$helper" install
[ -x "$installed" ]
[ "$(sha256sum "$(dirname "$installed")/FlClashCore" | cut -d ' ' -f 1)" = "$CORE_SHA256" ]
grep -F "ExecStart=\"$installed\"" "$unit"
cp "$unit" "$fixture/previous.unit"
# A helper-only upgrade must roll back both binaries as well as the unit.
printf '\nprevious helper marker\n' >> "$installed"
cp "$installed" "$fixture/previous.helper"
touch "$fixture/fail-once"
if "$helper" install; then echo 'failed activation was accepted' >&2; exit 1; fi
cmp "$unit" "$fixture/previous.unit"
cmp "$installed" "$fixture/previous.helper"
# Refuse another user's unit and retain it unchanged.
sed -i 's/OWNER_UID=1000/OWNER_UID=1001/' "$unit"
if "$helper" install; then echo 'foreign owner was accepted' >&2; exit 1; fi
grep 'OWNER_UID=1001' "$unit"
cp "$fixture/previous.unit" "$unit"
# Reinstall succeeds, and removing the transient AppImage does not break it.
"$helper" install
# A Core upgrade stages under the new hash and drops the previous copy.
previous="$(dirname "$installed")"
printf '#!/bin/sh\nexit 1\n' > "$fixture/App Image 100%/FlClashCore"
export CORE_SHA256=$(sha256sum "$fixture/App Image 100%/FlClashCore" | cut -d ' ' -f 1)
cargo build --locked --offline
cp target/debug/helper "$fixture/App Image 100%/FlClashHelperService"
installed="/usr/local/libexec/flclash/$CORE_SHA256/FlClashHelperService"
"$helper" install
[ -x "$installed" ] && [ ! -e "$previous" ]
grep -F "ExecStart=\"$installed\"" "$unit"
rm -rf "$fixture/App Image 100%"
"$installed" uninstall
[ ! -e "$unit" ] && [ ! -e /usr/local/libexec/flclash ]
echo 'Linux installation, same-Core rollback, owner isolation, upgrade cleanup and AppImage removal passed'

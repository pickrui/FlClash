#!/usr/bin/env bash
# Render the AUR package for a published release: downloads that release's two
# Debian packages, hashes them and writes PKGBUILD, the install scriptlet and
# .SRCINFO into an output directory ready to commit to the AUR.
#
# Usage: tool/build_aur_package.sh <tag> [output-dir]
set -euo pipefail
repo_dir="$(cd "$(dirname "$0")/.." && pwd)"
tag="${1:?Usage: tool/build_aur_package.sh <tag> [output-dir]}"
out_dir="${2:-$repo_dir/dist/aur}"
pkgname="${AUR_PKGNAME:-flclash-oixcloud-bin}"
pkgrel="${AUR_PKGREL:-1}"
source_repo="${AUR_SOURCE_REPO:-pickrui/FlClash}"
maintainer="${AUR_MAINTAINER:-pickrui <pickrui@users.noreply.github.com>}"
pkgver="${tag#v}"

case "$pkgver" in
  '' | *[!A-Za-z0-9.+_]*)
    echo "Tag $tag does not yield a valid pkgver" >&2
    exit 1
    ;;
esac

if command -v sha256sum >/dev/null 2>&1; then
  hash_file() { sha256sum "$1" | cut -d' ' -f1; }
elif command -v shasum >/dev/null 2>&1; then
  hash_file() { shasum -a 256 "$1" | cut -d' ' -f1; }
else
  echo "Neither sha256sum nor shasum is available" >&2
  exit 1
fi

work_dir="$(mktemp -d)"
trap 'rm -rf "$work_dir"' EXIT

fetch() {
  local url="$1" destination="$2"
  if ! curl -fsSL --retry 3 -o "$destination" "$url"; then
    echo "Cannot download $url" >&2
    exit 1
  fi
}

release_url="https://github.com/$source_repo/releases/download/$tag"
fetch "$release_url/flclash-linux-amd64.deb" "$work_dir/amd64.deb"
fetch "$release_url/flclash-linux-arm64.deb" "$work_dir/arm64.deb"
fetch "https://raw.githubusercontent.com/$source_repo/$tag/LICENSE" "$work_dir/LICENSE"

mkdir -p "$out_dir"
sed \
  -e "s|@MAINTAINER@|$maintainer|g" \
  -e "s|@PKGNAME@|$pkgname|g" \
  -e "s|@PKGVER@|$pkgver|g" \
  -e "s|@PKGREL@|$pkgrel|g" \
  -e "s|@TAG@|$tag|g" \
  -e "s|@REPO@|$source_repo|g" \
  -e "s|@SHA256_X86_64@|$(hash_file "$work_dir/amd64.deb")|g" \
  -e "s|@SHA256_AARCH64@|$(hash_file "$work_dir/arm64.deb")|g" \
  -e "s|@SHA256_LICENSE@|$(hash_file "$work_dir/LICENSE")|g" \
  "$repo_dir/linux/packaging/aur/PKGBUILD.in" > "$out_dir/PKGBUILD"
cp "$repo_dir/linux/packaging/aur/package.install" "$out_dir/$pkgname.install"

if grep -q '@[A-Z0-9_]*@' "$out_dir/PKGBUILD"; then
  echo "PKGBUILD still holds unrendered placeholders" >&2
  exit 1
fi

rm -f "$out_dir/.SRCINFO"
if [ "${AUR_SKIP_SRCINFO:-0}" = "1" ]; then
  echo "Skipping .SRCINFO"
elif command -v makepkg >/dev/null 2>&1; then
  (cd "$out_dir" && makepkg --printsrcinfo > .SRCINFO)
else
  echo "makepkg is not available; rerun on Arch or set AUR_SKIP_SRCINFO=1" >&2
  exit 1
fi

# Arch users install from this tarball while AUR registration is closed, so it
# carries the same files under the directory `makepkg -si` expects to run in.
stage="$work_dir/$pkgname"
mkdir "$stage"
cp "$out_dir/PKGBUILD" "$out_dir/$pkgname.install" "$stage/"
if [ -f "$out_dir/.SRCINFO" ]; then
  cp "$out_dir/.SRCINFO" "$stage/"
fi
tar -czf "$out_dir/$pkgname-aur.tar.gz" -C "$work_dir" "$pkgname"

echo "Rendered $pkgname $pkgver-$pkgrel into $out_dir"

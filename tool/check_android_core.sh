#!/usr/bin/env bash
# Compile the Android-only Go code and the real JNI bridge against its headers.
# Output stays in a temporary directory; no signing keys or packaged binaries.
set -euo pipefail
repo_dir="$(cd "$(dirname "$0")/.." && pwd)"
. "$repo_dir/tool/go_build_tags.env"
: "${ANDROID_NDK_HOME:?Set ANDROID_NDK_HOME to the Android NDK directory}"
case "$(uname -s)" in
  Darwin) host_tag=darwin-x86_64 ;;
  Linux) host_tag=linux-x86_64 ;;
  *) echo "Unsupported NDK host" >&2; exit 1 ;;
esac
arch="${1:-arm64}"
case "$arch" in
  arm64) target=aarch64-linux-android; go_arch=arm64 ;;
  arm) target=armv7a-linux-androideabi; go_arch=arm; export GOARM=7 ;;
  amd64) target=x86_64-linux-android; go_arch=amd64 ;;
  *) echo "Unsupported Android architecture: $arch" >&2; exit 1 ;;
esac
compiler_dir="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$host_tag/bin"
export CC="$compiler_dir/${target}23-clang"
export CXX="$compiler_dir/${target}23-clang++"
test -x "$CC"
export CGO_ENABLED=1 GOOS=android GOARCH="$go_arch"
output_dir="$(mktemp -d "${TMPDIR:-/tmp}/flclash-android-core.XXXXXX")"
trap 'rm -rf "$output_dir"' EXIT
# Use the NDK's VM-neutral JNI header with the host compiler for fault injection.
cp "$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$host_tag/sysroot/usr/include/jni.h" "$output_dir/jni.h"
"${HOST_CXX:-clang++}" -std=c++17 -I"$output_dir" \
  -I"$repo_dir/android/core/src/main/cpp" \
  "$repo_dir/android/core/src/test/cpp/jni_helper_test.cpp" \
  "$repo_dir/android/core/src/main/cpp/jni_helper.cpp" -o "$output_dir/jni_helper_test"
"$output_dir/jni_helper_test"
cd "$repo_dir/core"
go vet -tags "$GO_TAGS" . ./tun ./platform
go build -tags "$GO_TAGS" -buildmode=c-shared -trimpath -o "$output_dir/libclash.so" .
cp bride.h "$output_dir/bride.h"
"$CXX" -std=c++17 -DLIBCLASH -fPIC -shared -Wl,--no-undefined \
  -I"$output_dir" "$repo_dir/android/core/src/main/cpp/core.cpp" \
  "$repo_dir/android/core/src/main/cpp/jni_helper.cpp" \
  -L"$output_dir" -lclash -o "$output_dir/libcore.so"
echo "Android $arch: Go vet, shared core, and JNI link passed"

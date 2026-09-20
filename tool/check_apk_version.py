"""Read the packaged APK manifest; reject ABI offsets or stale build metadata."""
import argparse
import os
import re
import shutil
import subprocess
from pathlib import Path


def find_aapt():
    for sdk in (os.environ.get("ANDROID_HOME"), os.environ.get("ANDROID_SDK_ROOT")):
        if not sdk:
            continue
        candidates = list(Path(sdk).glob("build-tools/*/aapt"))
        if candidates:
            return str(max(candidates, key=lambda p: tuple(
                int(n) for n in re.findall(r"\d+", p.parent.name))))
    executable = shutil.which("aapt")
    if executable:
        return executable
    raise ValueError("Android SDK aapt is required to verify the final APK")


def verify_metadata(output, version, build):
    package = re.search(r"^package: name='([^']+)' versionCode='([^']+)' versionName='([^']+)'", output, re.M)
    if not package:
        raise ValueError("aapt did not return APK manifest version fields")
    application_id, actual_build, actual_version = package.groups()
    if actual_build != build or actual_version != version:
        raise ValueError(f"APK version is {actual_version}+{actual_build}; expected {version}+{build}")
    if application_id != "com.oixcloud.clash":
        raise ValueError(f"Unexpected release application ID: {application_id}")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--version", required=True)
    parser.add_argument("--build", required=True)
    parser.add_argument("apks", nargs="+", type=Path)
    args = parser.parse_args()
    if not re.fullmatch(r"\d{10}", args.build):
        parser.error("build number must be the shared yyyyMMddHH timestamp")
    aapt = find_aapt()
    for apk in args.apks:
        if not apk.is_file():
            raise ValueError(f"APK not found: {apk}")
        output = subprocess.run([aapt, "dump", "badging", str(apk)],
                                check=True, capture_output=True, text=True).stdout
        verify_metadata(output, args.version, args.build)
        print(f"Verified {apk.name}: {args.version}+{args.build}")


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Run pinned Mieru tests with deterministic DNS fixtures.

Two upstream address-resolution tests use the host resolver and assume that
invalid_host never resolves. DNS interception can invalidate that assumption.
Only those two test resolvers are replaced in a temporary module copy; all
assertions and production sources are preserved. The module cache is untouched.
"""

import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile


CORE = Path(__file__).resolve().parents[1] / "core" / "Clash.Meta"
MODULE = "github.com/enfein/mieru/v3"
VERSION = "v3.37.0"


def main():
    module = json.loads(subprocess.check_output(
        ["go", "list", "-mod=readonly", "-m", "-json", MODULE], cwd=CORE, text=True,
    ))
    if module["Version"] != VERSION:
        raise SystemExit("Review Mieru DNS fixtures when changing the pinned version")
    with tempfile.TemporaryDirectory(prefix="flclash-mieru-tests-") as temporary:
        temporary = Path(temporary)
        isolated = temporary / "mieru"
        shutil.copytree(module["Dir"], isolated, copy_function=shutil.copyfile)
        source = isolated / "apis" / "common" / "dns_test.go"
        original = source.read_text()
        old = "resolver := &net.Resolver{PreferGo: true}"
        if original.count(old) != 2:
            raise SystemExit("Unexpected Mieru DNS test fixtures")
        replacement = '''resolver := testDNSResolver{
            lookupIP: func(_ context.Context, _ string, host string) ([]net.IP, error) {
                if host == "localhost" {
                    return []net.IP{net.ParseIP("127.0.0.1")}, nil
                }
                return nil, &net.DNSError{Err: "no such host", Name: host, IsNotFound: true}
            },
        }'''
        source.write_text(original.replace(old, replacement))
        modfile = temporary / "go.mod"
        modfile.write_text((CORE / "go.mod").read_text())
        (temporary / "go.sum").write_text((CORE / "go.sum").read_text())
        subprocess.run([
            "go", "mod", "edit", "-modfile=" + str(modfile),
            "-replace=" + MODULE + "=" + str(isolated),
        ], cwd=CORE, check=True)
        return subprocess.call([
            "go", "test", "-mod=readonly", "-modfile=" + str(modfile),
            "-race", "-count=1", "-timeout=180s", *sys.argv[1:],
            MODULE + "/apis/...", MODULE + "/pkg/protocol", MODULE + "/pkg/socks5",
            MODULE + "/pkg/mathext", MODULE + "/pkg/rng",
        ], cwd=CORE)


if __name__ == "__main__":
    raise SystemExit(main())

#!/usr/bin/env python3
"""Run pinned QUIC dependency tests with valid TLS names in dial fixtures.

The metacubex TLS fork rejects an empty client ServerName unless verification
is disabled. Two upstream quic-go tests pass an empty config while testing
cancellation/socket ownership, so they fail before sending an Initial packet.
A temporary module copy supplies a name in those test fixtures; production sources,
TLS verification, assertions, and the module cache remain unchanged.
"""

import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile


CORE = Path(__file__).resolve().parents[1] / "core" / "Clash.Meta"
QUIC_VERSION = "v0.61.1-0.20260727080200-2548683b76f4"


def main():
    module = json.loads(subprocess.check_output(
        ["go", "list", "-mod=readonly", "-m", "-json", "github.com/metacubex/quic-go"],
        cwd=CORE, text=True,
    ))
    if module["Version"] != QUIC_VERSION:
        raise SystemExit("Review QUIC TLS test fixtures when changing the pinned version")
    source_dir = Path(module["Dir"])
    with tempfile.TemporaryDirectory(prefix="flclash-quic-tests-") as temporary:
        temporary = Path(temporary)
        isolated = temporary / "quic-go"
        shutil.copytree(source_dir, isolated, copy_function=shutil.copyfile)
        modfile = temporary / "go.mod"
        modfile.write_text((CORE / "go.mod").read_text())
        (temporary / "go.sum").write_text((CORE / "go.sum").read_text())
        subprocess.run([
            "go", "mod", "edit", "-modfile=" + str(modfile),
            "-replace=github.com/metacubex/quic-go=" + str(isolated),
        ], cwd=CORE, check=True)
        for filename, function, count in [
            ("client_test.go", "TestDial", 4),
            ("transport_test.go", "TestTransportAndDialConcurrentClose", 1),
        ]:
            source = isolated / filename
            original = source.read_text()
            start = original.index("func " + function + "(")
            end = original.index("\nfunc ", start + 1)
            fixture = original[start:end]
            if fixture.count("&tls.Config{}") != count:
                raise SystemExit("Unexpected TLS fixture in " + filename)
            fixture = fixture.replace("&tls.Config{}", '&tls.Config{ServerName: "localhost"}')
            source.write_text(original[:start] + fixture + original[end:])
        return subprocess.call([
            "go", "test", "-mod=readonly", "-modfile=" + str(modfile),
            "-race", "-count=1", "-timeout=180s", *sys.argv[1:],
            "github.com/metacubex/quic-go", "github.com/metacubex/quic-go/http3",
            "github.com/metacubex/connect-ip-go",
        ], cwd=CORE)


if __name__ == "__main__":
    raise SystemExit(main())

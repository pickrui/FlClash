#!/usr/bin/env python3
"""Run form decoder regressions without bypassing Go's URL parameter limit.

The upstream proportional-allocation test uses 50,000 URL query parameters,
which net/url now rejects before the form decoder runs. In a temporary module
copy, supply those same entries through DecodeValues and keep the size assertion.
Additional tests cover the default URL limit through both string and reader APIs.
Production sources, the module cache and runtime security settings stay intact.
"""

import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile


CORE = Path(__file__).resolve().parents[1] / "core" / "Clash.Meta"
MODULE = "github.com/ajg/form"
VERSION = "v1.9.0"

QUERY_LIMIT_TEST = '''package form

import (
    "net/url"
    "strconv"
    "strings"
    "testing"
)

func TestFlClashDefaultURLQueryParameterLimit(t *testing.T) {
    for _, count := range []int{10000, 10001} {
        values := make(url.Values, count)
        for i := 0; i < count; i++ {
            values["foo."+strconv.Itoa(i)] = []string{"1"}
        }
        query := values.Encode()
        for _, reader := range []bool{false, true} {
            name := strconv.Itoa(count) + "/reader=" + strconv.FormatBool(reader)
            t.Run(name, func(t *testing.T) {
                var dst sliceTarget
                var err error
                if reader {
                    err = NewDecoder(strings.NewReader(query)).Decode(&dst)
                } else {
                    err = DecodeString(&dst, query)
                }
                if count > 10000 {
                    if err == nil || !strings.Contains(err.Error(), "URL query parameters exceeded limit") {
                        t.Fatalf("expected the URL parameter limit, got %v", err)
                    }
                    if len(dst.Foo) != 0 {
                        t.Fatalf("oversized query allocated %d slice entries", len(dst.Foo))
                    }
                    return
                }
                if err != nil || len(dst.Foo) != count {
                    t.Fatalf("valid query decoded %d entries: %v", len(dst.Foo), err)
                }
                for i, value := range dst.Foo {
                    if value != 1 {
                        t.Fatalf("entry %d = %d, want 1", i, value)
                    }
                }
            })
        }
    }
}
'''


def main():
    module = json.loads(subprocess.check_output(
        ["go", "list", "-mod=readonly", "-m", "-json", MODULE], cwd=CORE, text=True,
    ))
    if module["Version"] != VERSION:
        raise SystemExit("Review form decoder fixtures when changing the pinned version")
    with tempfile.TemporaryDirectory(prefix="flclash-form-tests-") as temporary:
        temporary = Path(temporary)
        isolated = temporary / "form"
        shutil.copytree(module["Dir"], isolated, copy_function=shutil.copyfile)
        # copytree preserves the module cache's read-only directory mode.
        isolated.chmod(isolated.stat().st_mode | 0o200)
        source = isolated / "decode_dos_test.go"
        original = source.read_text()
        start = original.index("func TestDecodeSliceLargeLegitimateSliceWorks(")
        end = original.index("\nfunc ", start + 1)
        fixture = original[start:end]
        old = '''var b strings.Builder
\tfor i := 0; i < count; i++ {
\t\tif i > 0 {
\t\t\tb.WriteByte('&')
\t\t}
\t\tb.WriteString("foo.")
\t\tb.WriteString(strconv.Itoa(i))
\t\tb.WriteString("=1")
\t}'''
        new = '''// Exercise the decoder's proportional bound independently of URL parsing.
\tvalues := make(url.Values, count)
\tfor i := 0; i < count; i++ {
\t\tvalues["foo."+strconv.Itoa(i)] = []string{"1"}
\t}'''
        call = "DecodeString(&dst, b.String())"
        if fixture.count(old) != 1 or fixture.count(call) != 1:
            raise SystemExit("Unexpected form large-slice fixture")
        fixture = fixture.replace(old, new).replace(call, "DecodeValues(&dst, values)")
        updated = original[:start] + fixture + original[end:]
        if updated.count("import (\n") != 1 or '"net/url"' in updated:
            raise SystemExit("Unexpected form test imports")
        source.write_text(updated.replace("import (\n", 'import (\n\t"net/url"\n', 1))
        boundary_test = isolated / "flclash_query_limit_test.go"
        boundary_test.write_text(QUERY_LIMIT_TEST)
        subprocess.run(["gofmt", "-w", str(source), str(boundary_test)], check=True)
        modfile = temporary / "go.mod"
        modfile.write_text((CORE / "go.mod").read_text())
        (temporary / "go.sum").write_text((CORE / "go.sum").read_text())
        subprocess.run([
            "go", "mod", "edit", "-modfile=" + str(modfile),
            "-replace=" + MODULE + "=" + str(isolated),
        ], cwd=CORE, check=True)
        return subprocess.call([
            "go", "test", "-mod=readonly", "-modfile=" + str(modfile),
            "-race", "-count=1", "-timeout=180s", *sys.argv[1:], MODULE,
        ], cwd=CORE)


if __name__ == "__main__":
    raise SystemExit(main())

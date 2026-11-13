# mips low-memory integration

FlClash selects the optimized mips implementation when users choose `mips`; the application default remains `mixed`.

## Implementation

- Retain mipstack `802d64336f8c` and sing-tun `v0.4.24` as local replacements in both Go modules
- Backport [mipstack PR #3](https://github.com/MetaCubeX/mipstack/pull/3), commit `456a89053ab2a5b08cc9e90be294871f2505027a`, onto the newer mipstack baseline
- Select the upstream cache policy using `with_mips_low_memory`, without enabling mihomo's unrelated global `with_low_memory` behavior
- Configure the TUN adapter with the reference workload's 32 KiB initial and 128 KiB maximum send and receive buffers
- Enable the dedicated tag in the shared release/Native Assets harness, local Go tests, Android compilation checks and CI
- Keep that tag list in `tool/go_build_tags.env`: CI jobs load it into `$GITHUB_ENV`, the Makefile includes it and
  `tool/check_android_core.sh` sources it, while `BuildConfig` in `plugins/setup/setup_hooks` mirrors it for packaging.
  `test/lint/go_build_tags_test.dart` fails if the two drift apart or if a caller spells the tags out again

| TCP storage policy | Ordinary mips | Optimized mips |
| --- | ---: | ---: |
| Minimum first send allocation | 2 KiB | 1 KiB |
| Retained acknowledged send chunk | up to 32 KiB | up to 16 KiB |
| Drained receive metadata | up to 64 slots | up to 32 slots |
| Initial TUN receive/send capacity | 1 MiB / 256 KiB | 32 KiB / 32 KiB |
| Maximum TUN receive/send capacity | 16 MiB / 16 MiB | 128 KiB / 128 KiB |

Allocation is demand-driven. Buffer maxima do not represent an upfront allocation. The patch releases unused backing, preserves unread/unacknowledged data, and avoids reusing an undersized spare that would force an extra 16 KiB allocation. No periodic GC or memory-pressure polling is added. Smaller window maxima can reduce throughput on high-latency paths.

The local changes and their source provenance are documented in each dependency's `README.oix.md`; original sources, tests and licenses are retained. Both Go module replacements are necessary because transitive `replace` directives are not inherited. The shared harness includes these source files and selected tags in its build fingerprint.

## Validation

The four upstream low-memory regressions fail on the original implementation and pass after the backport. A TUN integration test checks the actual accepted socket's buffer profile, transfers 1-byte, 1,200-byte, 32 KiB and 1 MiB messages over IPv4 and IPv6, checks every echoed byte, then reuses and half-closes the connection. CI runs the dependency race suites with and without the dedicated tag and checks the upstream tag independently.

The deterministic upstream fixture for 1,000 drained connections after short messages retains 3,448,000 bytes in the ordinary build and 2,600,000 bytes in the optimized build. This accounts only for retained queue backing and excludes connection objects, running actors, the Go runtime and Android RSS.

On Apple M4 / Go 1.26.8, three 1-second in-process echo benchmark repetitions produced median combined-direction throughput of 967.54 MB/s for the original default profile, 845.69 MB/s for ordinary storage with 32/128 KiB buffers, and 793.92 MB/s for optimized storage with 32/128 KiB buffers. The complete memory-oriented profile was about 18% slower in this host fixture (about 6% attributable to the storage-policy comparison at equal buffer limits). These short host measurements are not Android or Internet throughput guarantees; this change prioritizes retained memory and does not claim a speed improvement.

Reproduce from `core/`:

```sh
go test -race -count=1 -timeout=300s -tags with_gvisor,with_mips_low_memory github.com/metacubex/mipstack github.com/metacubex/sing-tun
go test -race -count=1 -timeout=300s -tags with_gvisor github.com/metacubex/mipstack github.com/metacubex/sing-tun
go test -tags with_low_memory -run '^TestLowMemory' github.com/metacubex/mipstack
go test -v -run TestTCPMemoryProfileBaseline github.com/metacubex/mipstack
go test -v -tags with_mips_low_memory -run TestTCPMemoryProfileBaseline github.com/metacubex/mipstack
```

## Local validation on 2026-09-21

- Flutter and proxy plugin suites: 1,697 passed, 6 conditional skips; Dart analysis passed
- Setup build defaults and cache checks: 11 passed; release gate checks: 12 passed
- FlClash Go tests and vet passed; mipstack and sing-tun root race suites passed with both ordinary and optimized builds
- Android arm64, arm and amd64: core vet, shared-library build and JNI link passed
- macOS arm64, Windows amd64 and Linux amd64: optimized core compilation passed from a clean committed checkout
- The generated desktop core's Go build information confirms `with_gvisor,with_mips_low_memory`
- Full upstream gVisor interoperability suite from mipstack `802d64336f8c`, using the application's gVisor `79317d808312`: non-race run passed in 61.326 seconds
- The same complete suite with race instrumentation and GOMAXPROCS=2 failed IPv4 MTU-68 TCP forwarding/stream cases and an IPv6 receive-window-reopen case on I/O deadlines, then hit its 300-second suite timeout; no data-race warning was reported, but this is a failed check, not a pass
- An unmodified mipstack `802d64336f8c` control run reproduced the MTU-68 forwarding and mipstack-listener timeouts; this establishes pre-existing failures for those cases, not a passing complete interoperability race suite
- The optimized IPv6 receive-window-reopen case passed three isolated race repetitions in 24.594 seconds; the full-suite failure remains recorded and is not erased by that targeted pass

## Android measurement boundary

No Android device was connected during local validation. Compilation and host tests do not establish application RSS savings. FlClash's dashboard adds the UI and core process RSS; shared pages can be counted in both processes, while kernel socket buffers are outside this metric.

Device comparisons should restart the application for each variant, reuse the same configuration and traffic, and record peak and idle dashboard RSS, per-process PSS, Go heap, connection count, throughput and CPU. Keep ordinary mips, optimized mips and mixed as separate samples. The upstream iPad measurements in `third_party/mipstack/LOW_MEMORY.md` are not FlClash Android measurements.

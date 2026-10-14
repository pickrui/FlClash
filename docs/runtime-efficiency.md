# Runtime efficiency

Most Core changes below adapt ideas from [ProjectClash/Clash at `3891cc46`](https://github.com/ProjectClash/Clash/tree/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb)
to FlClash's lifecycle and IPC. None of them adds a periodic timer, background sweeper, production GC call or on-disk
format change unless stated.

## Measurements

Unless a table says otherwise: Apple M4, macOS arm64, Go 1.26.9, `CGO_ENABLED=0`, release tags
`with_gvisor,with_mips_low_memory`, three one-second samples (ranges are min–max). "Before" is the preceding Core commit,
or the prior implementation supplied through a temporary Go overlay. Figures are operation-level allocations, timings or
retained-heap deltas from isolated fixtures; they are not whole-app RSS, latency or battery measurements. Deferred work
moves its cost to first use.

Reproduce a benchmark from `core/Clash.Meta/` (or `core/` for the app-side Core) with:

```bash
GOTOOLCHAIN=go1.26.9 CGO_ENABLED=0 go test -tags with_gvisor,with_mips_low_memory \
  -run '^$' -bench '^<Benchmark>$' -benchmem -benchtime=1s -count=3 <package>
```

Where a row notes `GOMAXPROCS=1`, set it for the run.

## App and IPC

### Traffic rates

`Now` and `NowTraffic` derive rates from cumulative counters when read; there is no statistics ticker. Readers within
half a second share a sample, so jittery 1 Hz polls each get a fresh rate. A reader returning after five idle seconds
starts from zero with a fresh baseline.

### Logs

- Go and Dart log payloads are capped at 16 KiB of UTF-8 with a truncation marker; sensitive-output filtering runs first
- Core event batches carry at most 256 KiB of encoded log messages within the 32-message / 16 ms limits
- The UI keeps at most 1000 logs and a 2 MiB UTF-16 text budget
- Persistent writes admit at most 256 pending entries / 2 MiB; overflow drops incoming writes. File rotation stays at 1 MiB

### Connection deltas

The connection page subscribes over the typed Core IPC. The first reply is a snapshot; later one-second events carry new
connections, changed counters and removed IDs only. Each subscription has an ID and sequence; a gap, an expired lease or
three seconds without events triggers a fresh snapshot. A failed snapshot cancels its subscription and retries with
backoff up to eight seconds. Leaving the page or backgrounding the app unsubscribes, and leases expire after 15 seconds
(at most four subscribers). Cloud connections are filtered in the Core before they reach the stream.

### Paged nodes

Group refreshes carry summaries (counts, selection, presentation metadata); full member lists come from `getProxyPage`,
128 entries per reply for views and up to 2048 for on-demand enumeration. Each mounted group/query keeps at most six
pages including previous rows during a reload, four pending and two concurrent requests. Search and sorting run in the
Core over the whole group and return the selected index.

Each group has its own revision covering its members and configuration, so a selection or another group's change keeps
cached pages. Requests sorted by latency or hiding timeouts also cover the selections their order depends on, and only
they carry the delay map. A page request hashes only its group: 0.64 ms instead of 15.4 ms for a 10,000-node group in a
100,000-membership fixture. Changed inputs reload a page source in place, keeping shown rows until replacements arrive
or fail, when a retry replaces the old row. Late replies are ignored; conflicting initial revisions trigger a fresh
read instead of mixing versions. Manual group tests and the macOS tray enumerate pages on demand, and a group that
cannot be read falls back to its summary so the tray menu still opens.

Unfiltered, unsorted reads reuse the group's immutable membership; operations that change order or membership own
their slice, and result arrays are allocated to the exact page size. In a prepared 10,000-node group, a 128-node read
uses 6704 B / 3 allocations instead of 179716 B / 11, taking 140–141 µs instead of 181–183 µs
(`BenchmarkNodePageRead/10000`, `core/`, `GOMAXPROCS=1`).

### Memory sampling

The memory RPC reads six `runtime/metrics` values on demand instead of `ReadMemStats`, keeping the previous heap, idle,
stack and runtime-other definitions: 379–459 ns/op versus 70–72 µs/op, zero allocations
(`BenchmarkRuntimeMemoryStats`, `core/`).

## Health checks and groups

### Scheduling

- Scheduled, provider-refresh and failure-recovery checks share ten global slots; waiting does not consume the probe timeout
- Explicit provider checks and manual delay tests keep their own concurrency
- Device idle stops automatic tickers and cancels queued/running automatic probes; waking starts a fresh interval
- Automatic and recovery rounds probe selected group members first, then failed nodes, then the rest
- Concurrent probes of the same proxy, URL, expected status and class share one result (policy groups excluded). A
  cancelled waiter does not cancel the owner, and only the network probe publishes history
- Each Core group URL-test request admits at most 64 probe workers

### Bounded rounds

A scheduled round tests at most 1000 matching nodes per provider and URL: up to 500 slots for selected nodes, then up to
64 known-fast nodes, then failed nodes, and the rest from a rotating per-URL cursor. Providers within the window are still
checked completely; manual checks and failure recovery always cover the full list. A cancelled round does not advance
the cursor.

| 10,000-node fixture (`BenchmarkHealthCheckScheduling`, `./adapter/provider`) | Before | After |
| --- | --- | --- |
| Automatic round: probes / allocated bytes | 10000 / 9.27 MB | 1000 / 0.94 MB |
| Automatic round: time | 13.6–14.0 ms | 1.43–1.50 ms |
| Request reusing a completed round | 164113 B, 22–23 µs | 272 B, 228 ns |

### Failure recovery and selection

- Connection failures update their counter under a mutex; a group runs at most one recovery round and waits one second
  after it before admitting another. Handshake success resets the counter; `max-failed-times: 1` triggers on the first failure
- An all-down URL-test group keeps its current member while it still exists; tolerance also applies to the first member
- Selector, fallback and URL-test groups read atomic selected-name snapshots
- Provider, name-replacement, group and health-check filters use regexp2's ~100 ms match budget. A provider filter error
  rejects the update; a group filter error keeps the last valid list and retries after 30 seconds; a health-check
  filter error stops that URL's scheduling without marking nodes failed

### Health storage

History rings (ten records) and per-URL state are allocated on first result; the first URL is published through an
atomic entry and further URLs use a small map. JSON still renders empty history as `[]` and extra state as `{}`.

| `BenchmarkProxyHealthStorage` (`./adapter`) | Before | After |
| --- | --- | --- |
| Construct and inspect an unmeasured wrapper | 3472 B / 6 allocs | 112 B / 1 alloc |
| Construct and record the first result | 4555 B / 15 allocs | 1529 B / 10 allocs |
| Read first-URL health and last delay | 16.1–17.0 ns | 8.69 ns |
| Global, per-URL and all-URL history snapshots | 4336 B / 18 allocs | 1424 B / 5 allocs |

## Outbounds

### TLS sessions and buffers

Ordinary TLS through `StreamTLSConn` shares at most 128 security identities with one session each. The key covers the
dialed address, server name, verification mode, verification name, certificate pin and ordered ALPN, so servers sharing
an SNI never see each other's tickets; a different root pool replaces the shared cache. Custom CA, client certificates and ECH are excluded. HTTP and SOCKS5 TLS outbounds own one session each. uTLS,
REALITY and the other custom TLS stacks are unchanged.

The `bytes.Buffer` pool drops backing arrays larger than 64 KiB when they are returned.

### Lazy construction

These nodes keep parsed settings and build their expensive state on first TCP/UDP use, health check or remote DNS.
Parsing, validation and error messages stay at load time; close is terminal and never builds deferred state.

| Construct and close one unused node (`./adapter/outbound`) | Before | After |
| --- | --- | --- |
| MASQUE gVisor (`BenchmarkMasqueUnused`) | 87.4 KB / 769 allocs, 118–120 µs | 16.5 KB / 227 allocs, 66–67 µs |
| MASQUE mips | 96.5 KB / 259 allocs | 16.5 KB / 227 allocs |
| ZeroTier, 2048-frame queue (`BenchmarkZeroTierUnused`) | 134 KB, 21–24 µs | 2.9 KB, 1.25 µs |
| Sudoku entropy (`BenchmarkSudokuUnused`) | 1.04 MB, 78–79 ms | 2.2 KB, 0.79 µs |
| Sudoku directional | 2.08 MB, 161–173 ms | 3.4 KB, 1.23 µs |
| Hysteria2 `1-65535` hopping (`BenchmarkHysteria2Unused`) | 595 KB, 170–190 µs | 2.9 KB, 0.89 µs |
| Hysteria2 single port | 2288 B / 15 allocs | 2440 B / 16 allocs |
| TUIC v5 (`BenchmarkTuicConstruction`) | 2000 B / 16 allocs | 1376 B / 13 allocs |
| WireGuard with private DNS (`BenchmarkUnusedNodeDNS`) | 3376 B / 47 allocs | 2296 B / 33 allocs |
| ZeroTier DNS config, `GOMAXPROCS=1` (`BenchmarkZeroTierPrivateDNSConfig`) | 1648 B / 26 allocs | 568 B / 12 allocs |

- **MASQUE:** IP stacks are created under the handshake lock; unusual addresses or MTUs a backend may reject still
  construct eagerly. L4-proxy mode keeps its client
- **ZeroTier:** the inbound frame queue is allocated on first start and reused across retries and identity recovery
- **Sudoku:** nodes share an immutable table set when key seed, table type and rotation patterns match; the global cache
  holds weak references
- **Hysteria2:** hopping nodes keep port ranges and expand them on first use, preserving order, overlap weights and
  boundaries. Single-port and Realm nodes stay eager. Close cancels the node lifetime before waiting on the dependency
  lock and releases Realm's idle HTTP connections
- **TUIC:** ordinary nodes capture the CA pool at parse time and build TLS/QUIC configurations on first dial. Pinning,
  `name-cert-verify` and client certificates still build TLS at parse time
- **Private DNS:** WireGuard, MASQUE and ZeroTier build their node resolver on first acquisition; OpenVPN builds one per
  session after the handshake. Session loss, close and a ZeroTier configuration with different DNS inputs cancel that
  resolver's queries and drop it; periodic ZeroTier refreshes with unchanged DNS keep it and its cache. A closed node
  reports `net.ErrClosed`. Nodes without private DNS keep using the default resolver

### TUIC lifecycle

Close cancels pending pool handshakes, closes every TCP/UDP QUIC client and rejects later reuse; a handshake finishing
after close discards its connection. Each QUIC connection owns its stream count and UDP inputs, so late callbacks from a
retired connection cannot decrement or close a replacement's state. Grace timers hold weak references, letting a retired
client be collected before its five-second grace period ends.

## Rules and data

### Classical rule indexes

Runs of at least 16 consecutive `DOMAIN`/`DOMAIN-SUFFIX` rules, or `no-resolve`/source `IP-CIDR` rules, become immutable
indexes at their original position, so first-match order, DNS callbacks and logical/process rules behave as before.
Resolving IP rules stay linear. Every rule still passes through the configured parser.

| 10,000 rules (`./rules/provider`) | Before | After |
| --- | --- | --- |
| Domain: construct (`BenchmarkClassicalDomainRules`) | 1.02–1.05 ms, 1.79 MB | 1.73–1.81 ms, 2.02 MB |
| Domain: last exact / miss | 61 µs / 66 µs | 21–33 ns / 80–86 ns |
| IP `/25`, `GOMAXPROCS=1`: construct (`BenchmarkClassicalIPRules`) | 1.91–1.95 ms, 2.91 MB | 2.39–2.42 ms, 3.39 MB |
| IP: first / last / miss | 5.3 ns / 45 µs / 45 µs | 36 ns / 35 ns / 36 ns |

Domain indexes copy names into one arena per table, so the raw rule lines can be collected.
`TestClassicalIndexRetainedStorage` builds 20,000 rules and requires the index to retain at most half the linear
strategy's bytes for domains and three quarters for disjoint IP ranges, with a handful of objects instead of one per rule.

### GeoSite and MRS

The default `memconservative` GeoSite loader shares raw lists only while a read is in flight and keeps completed
matchers, so the source domains and attributes can be collected once a matcher is built. Failed loads are never cached.
MRS parsing uses one streaming low-memory zstd decoder and discards reserved extension bytes without allocating them,
cutting allocated bytes by 13–28% (48% with an 8 MiB extension; `BenchmarkMrsDecode`, `./rules/provider`). The 100,000-IP
input is about 5% slower.

### Fake-IP

Each new persistent mapping replaces conflicting forward/reverse records in one database transaction, rolled back as a
whole on failure; the bucket format is unchanged. The memory backend keeps two indexes over one LRU list. Building 1000
mappings allocates 334 KB / 1046 objects instead of 430 KB / 4050, and eviction drops from 4 allocations to none
(`BenchmarkPoolMemory`, `./component/fakeip`).

## DNS

### Query lifetime

Each resolver owns a query context. Closing it cancels upstream work, rejects new exchanges and closes its bootstrap
resolver. A configuration reload retires the replaced resolvers one DNS timeout later, so lookups already in flight for
rule matching or proxy dials still finish. Disabling DNS and Core shutdown retire them at once; shutdown keeps the
fake-IP mapper so an in-process restart (Android) restores its mappings. Stale cache hits still answer immediately with TTL 1, but only one refresh per resolver and question waits
upstream: 512 stale hits used to leave 512 goroutines waiting and now leave none
(`TestResolverRefreshBurstResources`, `./dns`).

### Connection resets

Network resets reach domain-trie and matcher policies, all resolver roles and the bootstrap resolver, and visit each
shared raw transport once after unwrapping decorators. Policy clients are streamed from the trie without rebuilding
names: 16,384 policy entries reset in 427–441 µs with 272 B, versus 2.3–3.6 ms and 2.6 MB for a snapshot walk
(`BenchmarkResetPolicyConnections`, `GOMAXPROCS=1`, `./dns`).

## Controller JSON

Proxy serialization merges the adapter's canonical JSON with current health and metadata instead of decoding and
re-encoding it. Non-canonical input (floats, large integers, duplicate keys, deep nesting) falls back to the map-based
encoder, so output bytes and errors match the previous marshaler. `/proxies`, `/providers/proxies` and
`/providers/proxies/{name}` stream their lists through a 4 KiB writer; a failure after output has started aborts the
transfer instead of sending truncated JSON.

| `GOMAXPROCS=1` | Before | After |
| --- | --- | --- |
| `json.Marshal` 1000 unmeasured nodes (`BenchmarkProxyJSON`, `./adapter`) | 4.89 MB / 65010 allocs | 1.23 MB / 20004 allocs |
| `json.Marshal` one group of 10,000 names | 1.36 MB / 20122 allocs | 0.37 MB / 37 allocs |
| `/proxies` with 1000 nodes, buffered vs streamed (`BenchmarkControllerProxyJSON`, `./hub/route`) | 2.57 MB | 0.73 MB |
| One provider with 1000 nodes, buffered vs streamed | 2.76 MB | 0.71 MB |

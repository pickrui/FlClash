# Runtime efficiency

The first batch adapts ideas from [ProjectClash/Clash](https://github.com/ProjectClash/Clash/tree/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb) to FlClash's existing lifecycle and IPC

## Traffic rates

`Now` and `NowTraffic` share a sample calculated from cumulative counters when read, at most once per second. There is no statistics ticker or sampling goroutine. A reader returning after five seconds without reads starts with zero and a fresh baseline; background traffic still contributes to cumulative totals. Rates account for the actual elapsed time between samples

## Health checks

- Scheduled, provider-refresh and connection-failure recovery checks share ten global slots; waiting for a slot does not consume the network timeout
- An explicit provider check and the app's manual delay tests retain their existing concurrency controls
- Device idle stops automatic health-check tickers and cancels queued/running automatic probes, independently of the optional setting that suspends traffic forwarding
- Waking starts a fresh configured interval; it does not replay missed ticks
- Each scheduled URL checks failed nodes and selected group members before other candidates, keeping ordering within each category
- Concurrent probes of the same proxy, URL, expected status and foreground/background class share a result; policy groups are excluded because their selected member can change
- Canceling a waiting caller does not cancel the owner; a remaining caller retries if the owner's deadline/cancellation interrupted the probe
- Only the actual network probe publishes health history. Canceled work does not publish a failure. A scheduled round can reuse a successful measurement completed since the round began only when its expected status and timeout are compatible

Focused tests cover shared rate consumers, dormant traffic, reset, aggregate concurrency, queue cancellation, idle/wake, independent manual probes, duplicate-result publication, deadlines, frontend generations and 150 distinct concurrent nodes. The core dependency packages also run under Go's race detector

These checks establish behavior and resource bounds. They do not measure battery life or whole-app resident memory on devices

## Log budgets

- Go and Dart log payloads are capped at 16 KiB of UTF-8, with a truncation marker and complete Unicode characters; sensitive-output filtering happens before truncation
- Core batches allow up to 256 KiB of JSON-encoded log messages, including escaping, within the existing 32-message and 16 ms limits. Non-log events retain their existing handling
- The UI retains at most 1000 logs and a conservative 2 MiB UTF-16 text budget, including timestamps; resetting the buffer retains the same policy
- Persistent writes reserve at most 256 pending entries and a 2 MiB text budget. Overflow skips incoming writes, and completion or failure releases capacity. The existing 1 MiB file rotation limit remains in effect

The text budgets exclude object and queue bookkeeping; they are not whole-process memory limits. Regression tests cover Unicode, JSON escaping, weighted eviction, reset and write-admission failure

## Node regular expressions

Provider filters, name replacements, group filters and health-check filters use regexp2's 100 ms match budget. The library checks an approximate clock, so this is not a strict 100 ms wall-clock deadline. Ordinary Go regex and routing-rule matching are unaffected

A provider parse or replacement error rejects the candidate instead of publishing a partial node list. A group runtime filter error logs the failure and retains its last valid filtered list (or its configured empty fallback when none exists), retrying only when a provider version changes. A health-check filter error stops that URL's scheduling without marking unmatched nodes as failed

## Connection deltas

The visible connection page subscribes over the existing typed Core IPC. Its initial response contains a snapshot; subsequent one-second events carry only new connection metadata, changed upload/download counters and removed IDs. Unchanged connections do not resend metadata. The Core still scans live trackers once per second while subscribed; this does not add hooks or locks to traffic reads and writes

Each subscription has its own ID and sequence. Empty events are sequence watermarks, so dropping a final close event is detectable. A sequence gap, expired lease or three seconds without events requests a fresh snapshot with a new subscription ID. Events arriving before the initial response are buffered up to eight entries, and late replies cannot republish a hidden page

Leaving the page or backgrounding the app unsubscribes. The Core stops its ticker when no subscribers remain. Leases expire after 15 seconds without renewal, with at most four subscribers, so a lost cancellation cannot keep a worker alive indefinitely. Existing sensitive-connection filtering also applies to the stream

## Paged nodes

Group refreshes transfer summaries containing counts, selection and presentation metadata; `Group.all` in a summary contains only the selected member needed for nested selection resolution. Full member lists are fetched through `getProxyPage`, with a maximum of 128 entries per reply. Names are resolved within their live group so same-named provider nodes cannot replace top-level policy groups

Tab, list and dashboard views fetch pages as needed. Each mounted group/query retains at most six pages (768 nodes), admits four pending requests and runs at most two concurrently. The list computes row geometry from compact sections instead of constructing every row widget. Core-side search and sorting cover the complete group, preserve selected and unprobeable nodes under the hide-timeout setting, and return the selected index for direct navigation. A lightweight cross-group count query hides groups with no search matches

Membership, config replacement and nested selection changes invalidate page revisions. Query/style changes dispose the old page source; late responses are ignored. Failed pages require an explicit retry. Manual group tests and the macOS tray enumerate all pages only on demand; the native menu's temporary complete member list is replaced by summaries after it closes

The Core keeps the routing configuration and computes filtering/sorting from live members for page requests; this is a transport/UI retention bound, not a limit on Core routing memory. Focused tests cover deltas and privacy, dropped events, lifecycle/lease expiry, multi-page search and ordering, reloads, cache/request limits, and reaching and selecting the last node without fetching intermediate pages. These fixture checks do not establish device battery savings or whole-app RSS reductions

## TLS session reuse

This batch adapts ProjectClash's [TLS session cache](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/transport/vmess/tls_session_cache.go) and HTTP/SOCKS5 resumption support. Ordinary TLS through `StreamTLSConn` shares at most 128 security identities, retaining one session per identity. The key includes server name, certificate verification mode, explicit verification name, certificate pin and ordered ALPN. A cache lookup with a different root certificate pool replaces the previous shared cache; the cache owner retains only its latest trust pool

HTTP and SOCKS5 TLS outbounds own one session each; replacing an outbound starts a new cache. These limits trade a bounded amount of ticket retention for fewer repeated certificate transfers and signature checks. TLS 1.2 and TLS 1.3 both resume when the server supports tickets and fall back to a complete handshake otherwise

Automatic shared caching excludes custom CA data/files, client certificates and ECH. HTTP/SOCKS5 client certificates also keep their existing handshake behavior so file reloads cannot be hidden by session resumption. Caller-supplied caches are preserved. uTLS, REALITY, Restls, ShadowTLS, JLS, TLSMirror and QUIC configuration conversion retain their existing behavior; AnyTLS is unchanged

Tests perform actual TLS and HTTP CONNECT/SOCKS5 handshakes, check `DidResume`, and exercise changed pins, replaced trust pools/outbounds, concurrent cache access, eviction and servers without tickets. These local fixtures verify correctness and cache limits; they do not measure device battery savings or whole-app memory

## Buffer retention and memory sampling

The general `bytes.Buffer` pool releases backing arrays larger than 64 KiB when returned. Smaller buffers retain their capacity for reuse; payloads may still grow beyond that size while borrowed. This extends the existing allocation-budget approach to occasional large protocol and provider buffers, independently of packet sizes or forwarding behavior

The memory RPC now reads six `runtime/metrics` counters on demand, reusing a synchronized sample array. It preserves the previous heap, idle heap, stack and runtime-other definitions and still queries OS RSS separately. It does not perform `ReadMemStats`' stop-the-world sampling or add timers, cached snapshots or automatic GC. Existing visibility polling and manual memory release remain intact

On the local Apple M4 with Go 1.26.9, three one-second runs measured runtime sampling at 379–459 ns/op versus 70–72 microseconds/op for `ReadMemStats`, with zero allocations on both paths. This comparison excludes OS RSS collection, IPC and UI work. Reproduce from `core/` with `GOTOOLCHAIN=go1.26.9 CGO_ENABLED=0 go test -run '^$' -bench '^BenchmarkRuntimeMemoryStats$' -benchtime=1s -count=3 -tags with_gvisor,with_mips_low_memory`

Validation includes the root Core suite, race checks for pool/TLS/outbound/CA packages, concurrent memory sampling, buffer retention boundaries and the existing memory-widget/model tests. Device power and whole-app RSS have not been measured

## Fake-IP storage

This batch adapts ProjectClash's [atomic Fake-IP transaction](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/component/profile/cachefile/clash_fakeip_batch.go) idea. Each new persistent mapping now replaces any conflicting forward/reverse pair in one synchronous database update. A fresh slot previously needed two sequential batch transactions; a recycled slot needed three. The new path commits once before returning and avoids their batch-delay timers. The existing bucket format, IPv4/IPv6 separation and allocation-state checkpoints through `StoreState` remain compatible

The transaction rolls back both directions and any removed records if a write fails. Cleanup only removes a previous counterpart that still refers to the replaced mapping, preserving unrelated records left by an older partial write. Pending operations do not accumulate in a background queue

The memory-only backend uses two lookup indexes pointing to one entry and one LRU list. Forward and reverse lookups share the same recency; full caches reuse the oldest entry on replacement. The pool mutex protects both indexes, including flush and state checkpoints. Cloning creates independent entries in recency order and honors the destination capacity. Clearing releases the old indexes and list; nonpositive capacities retain their existing unlimited behavior

Local Apple M4 measurements with Go 1.26.9, three one-second runs, compared against Core `b230a693` with the same benchmark:

| Memory pool operation | Before | After |
| --- | --- | --- |
| Build 1000 mappings, allocated bytes | 429745–429746 B/op | 333601–333602 B/op |
| Build 1000 mappings, allocations | 4050/op | 1046/op |
| Build 4096 mappings, allocated bytes | 1744764–1744773 B/op | 1351393–1351395 B/op |
| Build 4096 mappings, allocations | 16486/op | 4194/op |
| Hit one of 1000 retained mappings | 33.9–35.1 ns/op | 16.0–16.8 ns/op |
| Repeated eviction at capacity 1000 | 191–194 ns/op, 160 B/op, 4 allocs/op | 96–101 ns/op, 0 B/op, 0 allocs/op |

Pool construction allocates about 22% fewer bytes and 74% fewer objects in these fixtures. Host strings are prepared outside the timed region; the eviction benchmark cycles through one more host than the capacity. These are operation-level allocation and CPU measurements, not retained-heap, whole-app RSS or battery measurements. Reproduce from `core/Clash.Meta/` with `GOTOOLCHAIN=go1.26.9 CGO_ENABLED=0 go test -run '^$' -bench '^BenchmarkPoolMemory$' -benchmem -benchtime=1s -count=3 -tags with_gvisor,with_mips_low_memory ./component/fakeip`

Validation covers legacy database replacement and reopen, rollback, one commit per new mapping and none for hits, IPv4/IPv6 wraparound and state restore, reverse-lookup recency, clone capacity/independence, missing database handles, and concurrent lookup/flush/state saves. Fake-IP, cachefile and DNS packages pass race detection, and the root Core suite passes. Database fixtures use temporary directories and close their handles during cleanup

## Lazy MASQUE stacks

This batch adapts ProjectClash's [lazy MASQUE construction](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/adapter/outbound/clash_masque_lazy.go) and [configuration compatibility guard](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/adapter/outbound/clash_lazy_ipstack.go). Ordinary MASQUE IP-tunnel nodes retain their parsed settings until the first TCP/UDP request, health check or remote DNS use. Loading unused nodes avoids their gVisor/mips stack allocations and the workers started by the gVisor constructor. This adds no background timer; once created, the stack remains available until the outbound closes

The existing handshake lock shares the first initialization and reuses the stack after a failed tunnel handshake. Device creation/start and close also share a lock, preventing shutdown from missing a newly created stack or overlapping its start. Closing an unused node does not create a stack; later requests remain canceled. Constructor errors release resources already owned by the outbound, and close also clears idle HTTP/2 connections

Address parsing, backend selection and congestion-controller validation still run at configuration load. Unusual addresses, duplicate addresses and MTUs that a backend may reject continue through its constructor immediately, preserving existing acceptance and error messages. Such accepted exceptional configurations can still allocate eagerly. The guard includes the current mips IPv6 minimum MTU of 1280. L4-proxy mode retains its separate existing client

Local Apple M4 measurements with Go 1.26.9, three one-second runs, compared against Core `0b3cba0e` with the same benchmark:

| Construct and close one unused node | Before | After |
| --- | --- | --- |
| auto (gVisor), allocated bytes | 87428–87451 B/op | 16450–16451 B/op |
| auto (gVisor), allocations | 769/op | 227/op |
| auto (gVisor), elapsed time | 118–120 microseconds/op | 65.9–66.9 microseconds/op |
| mips, allocated bytes | 96547–96548 B/op | 16450 B/op |
| mips, allocations | 259/op | 227/op |
| mips, elapsed time | 78.5–80.1 microseconds/op | 68.0–73.4 microseconds/op |

Allocated bytes fall by about 81–83% in this fixture. Key generation is outside the timed region; construction still parses the keys and builds TLS settings. These are construction/close measurements, not retained heap, whole-app RSS, first-connection latency or device battery measurements. First use now pays the deferred stack setup cost. Reproduce from `core/Clash.Meta/` with `GOTOOLCHAIN=go1.26.9 CGO_ENABLED=0 go test -run '^$' -bench '^BenchmarkMasqueUnused$' -benchmem -benchtime=1s -count=3 -tags with_gvisor,with_mips_low_memory ./adapter/outbound`

Validation covers unused IPv4/IPv6/dual-stack nodes, cancellation and close races, concurrent first requests, handshake failure/retry, backend configuration outcomes, and actual TCP/UDP echo over a local HTTP/2 TLS tunnel with certificate pin verification and both handshake-timeout modes. The outbound package passes race detection with the release tags, MASQUE tests also pass without gVisor, and the root Core suite passes. Invalid-configuration parity runs in a child process because the current gVisor dependency retains workers on constructor errors; exiting that process prevents those workers from affecting later tests

## Lazy ZeroTier frame queues

This batch adapts ProjectClash's [deferred frame queue](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/adapter/outbound/clash_zerotier_lazy.go). Loading a ZeroTier node no longer reserves its 2048-frame inbound queue. The first startup allocates it under the existing operation lock before installing frame callbacks. Its capacity and ordered consumer remain unchanged, and retries or identity recovery reuse the same queue because that consumer outlives individual runtimes

An unused node can close without allocating the queue or creating its state directory. Startup failures retain an already allocated queue for retry; this change does not release queues from previously started nodes. Existing network configuration, identity persistence and transport maintenance behavior still apply once a node starts

Local Apple M4 measurements with Go 1.26.9, three one-second runs, compared against Core `3c428579` with the same benchmark:

| Construct and close one unused ZeroTier node | Before | After |
| --- | --- | --- |
| Allocated bytes | 134167–134169 B/op | 2889 B/op |
| Allocations | 20/op | 18/op |
| Elapsed time | 21.3–24.4 microseconds/op | 1.24–1.26 microseconds/op |

The fixture allocates about 98% fewer bytes per unused node. It constructs and closes nodes with temporary home paths and never starts a network. These are operation-level allocations and elapsed time, not retained-heap, whole-app RSS or battery measurements. Reproduce from `core/Clash.Meta/` with `GOTOOLCHAIN=go1.26.9 CGO_ENABLED=0 go test -run '^$' -bench '^BenchmarkZeroTierUnused$' -benchmem -benchtime=1s -count=3 -tags with_gvisor,with_mips_low_memory ./adapter/outbound`

## TUIC pool shutdown

This batch adapts ProjectClash's [pool release](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/transport/tuic/clash_pool_reset.go) and [forced client close](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/transport/tuic/v5/clash_force_close.go) into a terminal outbound lifecycle. TUIC previously inherited the base outbound's no-op close. It now explicitly cancels pending pool handshakes, closes all TCP/UDP QUIC clients and clears both lists. Closing transport connections stops their keepalives and receive workers without waiting for the inner clients' finalizers

Cancellation happens before taking the locks held by connection setup. A handshake returning a connection after cancellation closes that connection instead of publishing it. Pool admission and stream-limit retries reject new clients after close; previously selected clients also reject reuse. Concurrent initial acquisition of an empty pool creates one client under its pool lock. Repeated close calls share one completion

Open outbounds retain their existing connection reuse and heartbeat settings. Existing five-second stream-accounting callbacks may finish after shutdown; closed clients cannot establish another connection. The pool adds a cancellation context, with no polling loop or periodic cleanup timer

Validation covers actual TCP/UDP echo over TLS-verified loopback TUIC v4/v5 in both QUIC and native UDP modes, closing active transports, refusing requests after close, canceling blocked handshakes and discarding late successful connections. ZeroTier fixtures cover unused-node shutdown, malformed stored identity, concurrent startup retry and identity-collision recovery with all physical dialing disabled. The complete outbound and TUIC transport packages pass race detection with release tags, and the root Core suite passes

## Lazy shared Sudoku tables

This batch adapts ProjectClash's [lazy shared tables](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/adapter/outbound/clash_sudoku_tables.go) and [table specification validation](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/transport/sudoku/clash_table_spec.go). Loading an outbound validates its options and byte layouts without generating the Sudoku encoding/decoding tables. TCP, UDP-over-TCP and session-multiplex connections fill a private connection configuration on first use

Nodes share an immutable table set only when their canonical key seed, normalized table type and ordered rotation patterns match. Construction snapshots the pattern slice so later caller edits cannot change either the cache identity or the delayed build. Concurrent first requests share initialization; waiting callers can cancel without canceling another caller's build. A request already canceled on entry performs no table construction or dialing

Each used outbound retains its table set. The global cache holds weak references and removes obsolete entries after collection, with an identity check preventing old cleanup work from deleting a replacement entry. Active connections retain their own table references. There is no periodic cache cleanup timer. Closing a node alone does not drop its tables while that node remains reachable

Local Apple M4 measurements with Go 1.26.9, three one-second runs, compared against Core `611d4835` with equivalent benchmark operations:

| Operation | Before | After |
| --- | --- | --- |
| Construct and close an unused entropy node, allocated bytes | 1038796–1039960 B/op | 2200 B/op |
| Same operation, allocations / elapsed time | 3636–3637/op / 78.2–79.3 ms | 13/op / 0.783–0.792 microseconds |
| Construct and close an unused directional node, allocated bytes | 2076640–2076651 B/op | 3376 B/op |
| Same operation, allocations / elapsed time | 7265/op / 160.9–173.1 ms | 19/op / 1.224–1.233 microseconds |
| Construct a matching entropy node, prepare its connection configuration and close it while another node holds the tables, allocated bytes | 1041768–1041771 B/op | 2448 B/op |
| Same operation, allocations / elapsed time | 3648/op / 78.0–80.1 ms | 16/op / 0.927–0.934 microseconds |

Unused-node allocation bytes fall by about 99.8% in these fixtures. The first used node of each distinct configuration still pays the table-generation cost; that CPU-only build runs synchronously and completes before observing a cancellation that arrives during construction. Subsequent nodes reuse the tables while an owner remains alive. These are operation-level allocations and timings, not whole-app RSS, network latency or device battery measurements. Reproduce from `core/Clash.Meta/` with `GOTOOLCHAIN=go1.26.9 CGO_ENABLED=0 go test -run '^$' -bench '^BenchmarkSudoku(Unused|SharedTables)$' -benchmem -benchtime=1s -count=3 -tags with_gvisor,with_mips_low_memory ./adapter/outbound`

Validation covers 32 concurrent TCP/UDP requests across two keys, input-slice mutation, ordered and directional table identity, garbage collection and cache replacement, cancellation while waiting, and parse-time errors matched against the original table builder. Two independent outbounds exchange all byte values over directional, rotating Sudoku UDP frames through an in-memory pipe. The complete outbound and Sudoku transport packages pass race detection. Existing inbound TCP fixtures pass over loopback for PSK/private keys, custom tables, pure/packed downlink, HTTP masking and multiplexing; their high-volume concurrent stress branch is disabled for this compatibility check. The root Core suite and repository checks pass

## Bounded group probes and failure recovery

This batch adapts ProjectClash's [group probe concurrency limit](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/adapter/outboundgroup/groupbase.go) and [paused failure recovery](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/adapter/outboundgroup/clash_failed_check_pause_test.go). Each Core group URL-test request now admits at most 64 probe workers. Admission observes cancellation, and a worker checks the context before invoking its node. Successful results and the existing all-failed error remain compatible. Large groups may take more elapsed time; queued probes stop when the caller's deadline expires. The limit applies per group request; the existing global limit of ten background probes remains separate

Connection failures now update their short counter window under a mutex before creating any recovery worker. One group runs at most one failure-triggered recovery round at a time and waits at least one second after that round completes before admitting another. The cooldown is checked by the next failure and has no timer or periodic wakeup. Reported handshake success resets the failure counter, an expired counter window starts with the next failure, and `max-failed-times: 1` works on the first failure. Refused connections still request immediate recovery when admission is available. Explicit cancellation, unsupported operations and background-paused states do not start recovery; built-in provider checks retain their existing idle cancellation and probe sharing

Compared against Core `c98b9437`, the same fixture with 1000 blocked nodes canceled after the first 64 started previously invoked all 1000 nodes; it now invokes exactly 64 and leaves the remaining 936 unstarted. A separate fixture sends 1000 concurrent failures while a recovery round is blocked and verifies that only that one round runs, then checks the cooldown and later retry using virtual time. These are scheduling and concurrency bounds from isolated fixtures, not RSS or device battery measurements

## Stable concurrent group selection

This batch also adapts ProjectClash's [all-down choice retention](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/adapter/outboundgroup/clash_urltest_steady.go) and [atomic selection snapshots](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/adapter/outboundgroup/clash_group_selection.go). When reevaluating an all-down URL-test group, the current member is retained if it still exists. A same-named replacement uses the current provider's object; a recovered member can be selected normally. Tolerance applies even when the current node is first in the list, and the delay-plus-tolerance comparison uses a wider integer to avoid overflow

Selector, fallback and URL-test groups read atomic selected-name snapshots. URL-test calculations serialize writes to the cached node even when a cache reset overlaps another calculation. Fallback uses an available member when its pin fails, and clearing an old dead pin cannot erase a different selection set concurrently. Full JSON and paged summaries keep their existing fields and string values

The new regressions reproduce the previous all-down switch, first-member tolerance failure and canceled-probe burst. Further tests cover 150 mixed successful/failed probes, timeout counter resets, idle/suspension, recovery after cooldown, high-delay tolerance, member replacement/removal, concurrent selection and JSON reads, and old-pin/new-selection ordering. Outbound-group, provider, adapter and single-flight packages pass race detection with release tags; the root Core integration suite and repository checks pass

## Rotating background health checks

This batch adapts ProjectClash's [bounded health-check windows](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/adapter/provider/clash_healthcheck_window.go). Scheduled and provider-refresh checks select at most 1000 matching nodes per provider and test URL in each round. Up to 500 slots prioritize selected nodes, then up to 64 known fast nodes for that URL, then failed nodes. The remaining slots walk a rotating cursor, so a large set of selected or failed nodes cannot permanently exclude the rest. Priority selection also starts from the cursor; filters apply before admission, and each URL has an independent cursor

Providers with at most 1000 nodes still receive a complete scheduled check. A large provider's matching subset is also checked completely when it fits the window. The global limit remains ten automatic probes, including failure recovery. Manual checks and connection-failure recovery continue to cover the complete matching list; recovery has its own merged execution so it cannot reuse a partial scheduled round. Overlapping probes retain the existing sharing and successful-result reuse

A canceled round does not advance its cursors. Replacement lists and newly registered URLs appear in the next admitted round, while a running round keeps its original snapshot. Published node slices are owned by the health checker and reused without copying on each check. Extra URL/filter snapshots are created only by the admitted execution; duplicate requests no longer copy the full node list before being merged. An empty startup list does not cache a result that could suppress the first populated check. Cursor state stores only one integer per URL and adds no timers

Local Apple M4 measurements with Go 1.26.9, three one-second runs, compared against Core `b02ab53f` with the same 10000-node scheduling fixture:

| Operation | Before | After |
| --- | --- | --- |
| Automatic round, probe calls | 10000 | 1000 |
| Automatic round, allocated bytes | 9273344–9281516 B/op | 937380–938521 B/op |
| Automatic round, elapsed time | 13.62–14.04 ms/op | 1.43–1.50 ms/op |
| Request reusing a completed round, allocated bytes | 164113 B/op | 272 B/op |
| Request reusing a completed round, elapsed time | 22.23–23.23 microseconds/op | 228–229 ns/op |

The fixture uses immediate in-memory probes; it measures scheduling, logging arguments and temporary allocations, without network handshakes. Automatic-round allocation bytes fall by about 90%; the tradeoff is that ordinary nodes in a large provider are refreshed over multiple intervals instead of every interval. Selection still scans the current list to find priority candidates, and the Core still retains the full routing configuration. These figures are not whole-app RSS or device battery measurements. Reproduce from `core/Clash.Meta/` with `GOTOOLCHAIN=go1.26.9 CGO_ENABLED=0 go test -tags with_gvisor,with_mips_low_memory ./adapter/provider -run '^$' -bench '^BenchmarkHealthCheckScheduling$' -benchtime=1s -count=3`

Focused regressions cover complete rotation with many failures, selected and fast candidates, separate filtered URLs and expected statuses, whitespace-normalized URLs, cancellation before queued probes start, replacement during an active round, input-slice ownership, empty startup, regex timeout and complete manual/recovery checks. Provider, outbound-group and adapter packages pass race detection with release tags; the root Core suite and repository checks pass

## Compact lazy node health storage

This batch adapts ProjectClash's [lazy history allocation](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/adapter/clash_history.go) and [lazy per-URL state registry](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/adapter/clash_proxy_states.go). Constructing a node or inspecting its unmeasured health no longer allocates history queues or initializes a concurrent map's backing table. The first recorded test URL is published through an immutable atomic entry; additional URLs use a small map allocated only when needed. This keeps the usual single-URL health reads free of map lookups and registry locks

Each global or per-URL history allocates a fixed ten-record ring on its first result. Later writes reuse that storage; one lock covers replacement and size accounting, so concurrent snapshots cannot temporarily exceed the ten-record limit. History snapshots copy records once in chronological order and remain independent of the stored records. Exporting all URLs takes a registry snapshot before visiting additional entries, with callbacks outside the registry lock

Unknown nodes remain alive with no reusable result and an unknown delay. JSON still exposes empty history as `[]` and extra state as `{}`. Global transport health and URL-specific expected-status failures retain their existing distinction. Result ordering, cancellation, hook publication and successful-result reuse retain their existing guards. Used URL states remain until their node is released; this change adds no cleanup timers, workers or URL eviction

Local Apple M4 measurements with Go 1.26.9, three one-second runs, compared against Core `fc345d92` with the same benchmark:

| Operation | Before | After |
| --- | --- | --- |
| Construct an unused node wrapper, allocated bytes / allocations | 592 B/op / 3 | 112 B/op / 1 |
| Construct and inspect an unmeasured wrapper, allocated bytes / allocations | 3472 B/op / 6 | 112 B/op / 1 |
| Construct and record the first result, allocated bytes / allocations | 4555 B/op / 15 | 1529 B/op / 10 |
| Record another result on a measured node, allocated bytes | 768 B/op | 640 B/op |
| Read the first URL's health and last delay, elapsed time | 16.1–17.0 ns/op | 8.69 ns/op |
| Read global, per-URL and all-URL history snapshots, allocated bytes / allocations | 4336 B/op / 18 | 1424 B/op / 5 |
| Same three snapshots, elapsed time | 885–909 ns/op | 242–245 ns/op |

Construction plus inspection allocates about 97% fewer bytes, and the three snapshots allocate about 67% fewer bytes in these fixtures. Wrappers share one preconstructed outbound, so these figures exclude protocol-specific node allocations. Recording uses an invalid-scheme URL to exercise result publication without network access; URL parsing and error handling still allocate after the history ring is initialized. Snapshot fixtures retain ten results for one URL. These are operation-level allocation and CPU measurements, not retained-heap, whole-app RSS or device battery measurements. Reproduce from `core/Clash.Meta/` with `GOTOOLCHAIN=go1.26.9 CGO_ENABLED=0 go test -tags with_gvisor,with_mips_low_memory ./adapter -run '^$' -bench '^BenchmarkProxyHealthStorage$' -benchmem -benchtime=1s -count=3`

The new allocation regression reproduces three allocations when first reading each untouched node before this change and zero afterward. Further tests cover chronological ring wraparound, independent global and per-URL snapshots, empty JSON, unexpected HTTP statuses, concurrent results across eight URLs and reads from result hooks. Adapter, provider and outbound-group packages pass race detection with release tags; the root Core suite, including cancellation and stale-result ordering coverage, passes

## TUIC grace-period ownership and reconnect isolation

This batch adapts ProjectClash's [weak grace callbacks](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/transport/tuic/common/clash_grace.go). TUIC v4/v5 stream-close timers now hold weak references to both the client and its connection session. Once a retired session and client lose their ordinary owners and workers, the timer no longer keeps their state reachable for the rest of the five-second grace period. A live session still receives its delayed release; a collected owner or session needs no further work

Each QUIC connection owns its stream count and UDP input map. Authentication, receive workers, stream failures and delayed closes keep the session they started with. Retiring an old connection clears the current-session pointer only when it still matches, and cleans only that connection's UDP inputs. Late callbacks can therefore neither decrement a replacement connection's stream count nor remove its UDP associations. Stream admission and graceful shutdown share the connection lock; UDP registration also checks that its reserved session remains current before publishing an input

Compared against Core `e8b1ec67`, loopback regressions reproduce the following outcomes in both protocol versions:

| Scenario | Before | After |
| --- | --- | --- |
| A retired TCP stream's grace callback runs after reconnecting | Replacement's active-stream count falls from 1 to 0 | Replacement's count stays at 1 |
| An old UDP stream closes after reconnecting | Replacement's input pipe is closed | Replacement's input remains available |
| An unused retired client is collected while its grace timer is pending | Still retained after the 2.5-second collection window | Client and session are collected within that window |

The collection fixture opens and closes a real TLS-verified loopback QUIC transport and explicitly requests garbage collection. It establishes that the application state can be released before the grace timer expires; open streams and QUIC's own internal owners can still retain transport resources. The five-second grace duration and one timer per closed stream remain in place. Whole-app RSS and device power have not been measured

Validation covers the reproduced reconnect failures, client/session collection, live-stream graceful shutdown, repeated close, rejected stream slots and the exact grace deadline. Existing TUIC TCP/UDP echo, QUIC/native UDP modes, handshake cancellation, late handshake completion and terminal pool-close checks also pass. The complete TUIC transport and outbound packages pass race detection with release tags, and the root Core integration suite passes

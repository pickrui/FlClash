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

Group refreshes transfer summaries containing counts, selection and presentation metadata; `Group.all` in a summary contains only the selected member needed for nested selection resolution. Full member lists are fetched through `getProxyPage`: views request 128 entries per reply, and on-demand enumeration requests up to 2048. Names are resolved within their live group so same-named provider nodes cannot replace top-level policy groups

Tab, list and dashboard views fetch pages as needed. Each mounted group/query retains at most six pages (768 nodes), admits four pending requests and runs at most two concurrently. The list computes row geometry from compact sections instead of constructing every row widget. Core-side search and sorting cover the complete group, preserve selected and unprobeable nodes under the hide-timeout setting, and return the selected index for direct navigation. A lightweight cross-group count query hides groups with no search matches

Each group has its own revision covering its members and config identity, so a selection or another group's change keeps cached pages. Requests sorted by latency or hiding timeouts also cover the group's selection and the nested selections their order resolves through; only these requests carry the delay map. A page request hashes only the requested group, about 0.6 ms for a 10,000-node group in a 100,000-membership fixture on an M4, previously 15 ms for every group. Order, timeout-filter, latency and membership changes reload a page source in place and keep the rows already shown until their replacements arrive; a new query starts a separate source, and late responses are ignored. Locating the selection rereads the first page, because a selection made elsewhere does not invalidate cached pages. Failed pages require an explicit retry. Manual group tests and the macOS tray enumerate all pages only on demand; the native menu's temporary complete member list is replaced by summaries after it closes

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

## Hysteria2 hopping allocation and terminal cleanup

This batch adapts ProjectClash's [lazy Hysteria2 client](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/adapter/outbound/hysteria2.go) for nodes with port hopping. An unused hopping node keeps parsed ranges instead of an expanded port slice. Its first live request creates one shared client and expands the ports into an exactly sized allocation; initialization and close both discard the pending factory. Range order, overlapping entries and their sampling weights, reversed ranges, and the `0`/`65535` boundaries are preserved

TLS, ECH, client certificates, obfuscation, hop intervals and Realm settings are still checked when loading the node. The dependency's constructor validates a single representative hopping port, preserving its Realm/hopping exclusion without allocating the entire list. The temporary validation client is closed before retaining the prepared configuration. TLS settings and certificate loaders are prepared only once, and ALPN/STUN slices are copied. Ordinary single-port and Realm nodes retain their lightweight eager client; making those clients lazy provided no comparable allocation benefit

Closing either kind of node is terminal for TCP and UDP. It cancels the node lifetime before waiting on the dependency's connection lock, so a default handshake cannot hold close until its caller times out. Configured independent handshake timeouts still survive an individual caller's cancellation. Closing also releases Realm's idle HTTP control connections instead of leaving them until the 90-second idle timeout

Compared against Core `908bc923`, Go 1.26.9, release tags, macOS arm64 on Apple M4, three one-second samples of constructing and closing an unused node:

| Node configuration | Before, allocated bytes / allocations | After, allocated bytes / allocations | Before, elapsed time | After, elapsed time |
| --- | --- | --- | --- | --- |
| Single port | 2288 B/op / 15 | 2440 B/op / 16 | 665–680 ns/op | 730–736 ns/op |
| `40000-50000` (10,001 ports) | 95520 B/op / 35 | 2872 B/op / 22 | 26.6–27.5 µs/op | 889–894 ns/op |
| `1-65535` (65,535 ports) | 595234 B/op / 41 | 2872 B/op / 22 | 170–190 µs/op | 888–889 ns/op |

The two hopping fixtures allocate approximately 97.0% and 99.5% fewer bytes during construction. Ordinary nodes pay 152 additional bytes and one allocation for terminal lifecycle ownership and cancellation. These are operation-level construction/close measurements, not retained-heap, whole-app RSS, active-request throughput or device-power measurements. TLS certificate state still exists on unused nodes, and a used hopping node still needs the complete port slice required by the dependency. Reproduce from `core/Clash.Meta/` with `GOTOOLCHAIN=go1.26.9 CGO_ENABLED=0 go test -tags with_gvisor,with_mips_low_memory ./adapter/outbound -run '^$' -bench '^BenchmarkHysteria2Unused$' -benchmem -benchtime=1s -count=3`

The new regressions reproduce post-close TCP/UDP handshakes and close blocking on the default handshake before the change. They cover unused/initialized closure, canceled first use, concurrent initialization, port-range boundaries, load-time errors and Realm idle-connection cleanup. A TLS-verified loopback fixture starts through the hopping path, checks that later ALPN input mutation cannot change the prepared TLS settings, echoes fragmented UDP followed by TCP, and verifies that outbound close releases the UDP reader. Existing TLS, ECH, mTLS, Salamander, Gecko and Brutal round trips pass. The outbound and TUIC common packages pass their full race suites, the Hysteria2 inbound cases pass with race detection, and the root Core integration suite passes. The inbound fixtures run with `SKIP_CONCURRENT_TEST=true`; their high-fanout stress branch was not run

## Compact classical domain indexes

This batch adapts ProjectClash's [compact classical name tables](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/rules/provider/classical_strategy.go). Consecutive runs of at least 16 standard `DOMAIN`/`DOMAIN-SUFFIX` rules become immutable exact-name and suffix indexes. Sorted unique names share compact 32-bit hash slots; small unique sets use binary search. Retired rule references are cleared, and substantially oversized matcher arrays are copied down to their remaining entries. Duplicate rules still contribute to the provider's reported count. Smaller runs retain their original representation

Each run stays at its original position between other rules. DNS resolution, process lookup, logical rules, custom wrappers and metadata changes therefore keep the same ordering and short-circuit behavior. Every input still passes through the configured parser before eligibility is checked, preserving parse errors and custom normalization. Matching retains the existing case behavior, `SniffHost` preference and literal treatment of domain punctuation. Suffix candidate lengths are bounded by the longest indexed name, so an unusually long host only scans its final candidate span. Reset, repeated finishing, late insertion and atomic provider replacement remain supported. This change adds no workers, timers or on-disk format

Compared against Core `d6cb97e8`, Go 1.26.9, release tags, macOS arm64 on Apple M4, three serial one-second samples using 10,000 alternating exact/suffix rules:

| Operation | Before | After |
| --- | --- | --- |
| Construct the rule strategy | 1.02–1.05 ms/op | 1.73–1.81 ms/op |
| Construction, allocated bytes / allocations | 1786023–1786045 B/op / 40019 | 2015539–2015573 B/op / 40025 |
| Match the first rule | 10.9–11.2 ns/op | 12.5–12.7 ns/op |
| Match the last exact rule | 60.6–62.2 µs/op | 20.6–32.9 ns/op |
| Match a subdomain of the final suffix rule | 55.0–58.9 µs/op | 50.9–53.3 ns/op |
| Miss every rule | 65.8–67.2 µs/op | 80.0–85.7 ns/op |

All matching fixtures allocate zero bytes. Building the index costs approximately 13% more temporary allocation bytes and additional one-time CPU work; the first-rule hit is slightly slower. The gain applies to retained structures and repeated matching through longer domain runs, and does not accelerate interleaved non-domain rules

A separate 20,000-rule fixture retains the source strings before measuring and requests GC before/after each strategy construction. Across three runs, the linear strategy retains 1,013,536–1,022,904 additional heap bytes and approximately 20,000 objects; the indexed strategy retains 458,944–459,056 bytes and 7–8 objects. This is approximately 55% less retained structure memory. The fixture excludes the already-retained source strings, unrelated app state and transient construction allocations; it does not measure whole-app RSS or device power

Reproduce from `core/Clash.Meta/` with `GOTOOLCHAIN=go1.26.9 CGO_ENABLED=0 go test -tags with_gvisor,with_mips_low_memory ./rules/provider -run '^$' -bench '^BenchmarkClassicalDomainRules$' -benchmem -benchtime=1s -count=3`. The retained-heap check is `go test` with the same environment/tags and `-run '^TestClassicalIndexRetainedStorage$' -count=3 -v`. The before timing uses the same fixtures with the pre-change strategy implementation, compiled through a temporary Go overlay

Validation compares indexed matching against an unbuilt linear strategy across mixed rule corpora, including DNS/process call traces, metadata results, Unicode, unusual dots, duplicates, long hosts and sniffed hosts. Focused cases cover custom parser rejection/rewrites, a custom rule changing later match metadata, small-run boundaries, reset and late insertion. The provider update regression now covers both domain and classical strategies while reads and JSON exports run concurrently. All rule packages pass race detection with release tags; the root Core integration suite and repository checks pass

## GeoSite source retention and MRS decoding

This batch adapts ProjectClash's [GeoSite source-list release](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/component/geodata/utils.go) and the [single-worker, low-memory decoder and streamed extension skipping](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/component/geodata/compiled/ipcidr.go) used by its compiled GeoIP reader

The default `memconservative` GeoSite loader now shares raw protobuf lists only while a read is in flight. Once matching structures have been built, the cache no longer keeps the source domains, attributes and strings alive. Completed matchers remain cached, including attribute variants, so repeated access to the same matcher does not read the file again. Standard/custom loaders retain their existing source-list cache. Cache invalidation resets both list groups and the matcher group

The transient group uses ordinary singleflight completion instead of deleting a cache entry after matcher construction. An older build therefore cannot evict a newer read for the same category. Different attribute variants still share overlapping reads, but a variant starting after a read has completed can read the category again, including while another variant is building. This trades some first-use file I/O and decoding work for lower retained memory; it introduces no timer or forced GC. Race detection during review also exposed an existing unlocked read of singleflight's duplicate counter when completed calls remain cached. The return path now reads that counter under the group mutex, covered by concurrent GeoSite matcher access

MRS rule providers and the MRS preview/export path now use one streaming zstd decoder per parse, with low-memory mode explicitly selected. This removes asynchronous decoder workers and reduces block buffers; it does not serialize separate provider updates or retain a shared decoder. The low-memory flag was already the zstd version's default; the measured decoder reduction comes from the concurrency setting. Reserved extension bytes are copied to `io.Discard` instead of allocating a slice equal to their declared length. The decoder's own window and resulting rule structures still need memory, and the MRS wire format and existing size limits are unchanged

Compared against Core `6e8c03b0`, Go 1.26.9, release tags, macOS arm64 on Apple M4, three serial one-second samples:

| MRS input | Before, ms/op | After, ms/op | Before, allocated MB/op | After, allocated MB/op |
| --- | --- | --- | --- | --- |
| 10,000 domain rules | 0.647–0.779 | 0.498–0.533 | 1.452–1.453 | 1.040 |
| 100,000 domain rules | 4.451–4.524 | 4.201–4.250 | 9.366–9.367 | 7.297 |
| 10,000 IP rules | 2.299–2.370 | 2.097–2.134 | 2.175–2.176 | 1.634 |
| 100,000 IP rules | 19.218–20.055 | 20.520–23.161 | 14.268–14.270 | 12.436 |
| 20 domain rules plus an 8 MiB reserved extension | 0.870–0.884 | 0.841–0.872 | 18.410–18.411 | 9.609 |

MB in the allocation columns means 1,000,000 bytes. These fixtures reduce allocated bytes by approximately 13–28% for normal inputs and 48% for the large reserved extension. The 100,000-IP fixture is slower: its median changes from 19.62 to 20.71 ms, approximately 5.5%. The table preserves the observed range rather than claiming a universal loading-speed gain

A separate fixture generates 50,000 GeoSite suffix domains with attributes inside a test loader, then requests GC before and after building the matcher. Across three runs, `memconservative` retains 11,405,216–11,405,248 additional heap bytes and about 200,000 objects before the change, versus 603,728–604,272 bytes and 7–11 objects afterwards, approximately 95% fewer retained heap bytes. The standard-loader control continues retaining approximately 11.4 MB. This measures source-object and matcher retention with synthetic data; it excludes file parsing and does not represent whole-app RSS, peak heap or device power

Reproduce from `core/Clash.Meta/` using `GOTOOLCHAIN=go1.26.9 CGO_ENABLED=0 go test -tags with_gvisor,with_mips_low_memory ./rules/provider -run '^$' -bench '^BenchmarkMrsDecode$' -benchmem -benchtime=1s -count=3`. The retained-heap fixture uses the same environment/tags with `./component/geodata -run '^TestGeoSiteRetainedHeap$' -count=3 -v`. Before measurements use the same fixtures with the two pre-change implementation files supplied through a temporary Go overlay

Validation covers reclaiming source objects with live matchers, both succinct and MPH matching, attributes and negation, standard-loader reuse, cache invalidation, retry after read/build failures and concurrent matcher access. MRS tests cover both behaviors, byte-identical decoded structures, parallel parsing, reserved extensions, malformed/truncated input and a huge declared extension backed by a short input. Geodata and rule packages pass race detection with release tags; the root Core integration suite and repository checks pass

## Lazy TUIC dial configurations

This batch adapts ProjectClash's [deferred TUIC TLS/QUIC configurations](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/adapter/outbound/clash_tuic_lazy.go). Ordinary TUIC nodes capture the current CA pool when parsed and build their TLS/QUIC configurations on the first connection attempt. Concurrent first attempts share the completed configurations. Canceled attempts do not initialize them, and terminal close drops the cached configurations and pending CA reference under the same mutex. A configuration already acquired by an in-flight dial remains valid; pool shutdown retains responsibility for canceling and retiring connections

Nodes with certificate pinning, `name-cert-verify` or client certificates still validate and retain their TLS state at parse time. This keeps malformed settings as configuration errors and preserves the original client-certificate loader, including its file watcher and last successfully loaded certificate. Only their QUIC configuration is deferred. Ordinary nodes build the simple TLS settings directly instead of constructing and discarding a TLS configuration during parsing. Keeping the parse-time CA reference also avoids silently switching an unused node to a later replacement trust pool

The deferred builders preserve SNI and IP override behavior, disabled SNI, certificate verification, the NTP clock, nil versus explicitly empty ALPN, TLS 1.3, stream/connection windows, stream-count margins, heartbeat intervals, datagram limits and MTU discovery settings. The first connection pays the deferred construction cost. Used nodes keep a small additional mutex/closed-state/snapshot field overhead, while the mutex is acquired when establishing a QUIC connection rather than for each payload packet

Compared against Core `3a04a4b0`, Go 1.26.9, release tags, macOS arm64 on Apple M4, three serial one-second samples after warming the shared CA pool:

| Operation | Before | After |
| --- | --- | --- |
| Construct and close a TUIC v4 node | 740.8–748.5 ns/op | 639.3–645.1 ns/op |
| v4 allocated bytes / allocations | 2032 B/op / 17 | 1408 B/op / 14 |
| Construct and close a TUIC v5 node | 663.4–674.7 ns/op | 556.2–574.4 ns/op |
| v5 allocated bytes / allocations | 2000 B/op / 16 | 1376 B/op / 13 |
| Retained heap, 4096 unused v4 nodes | 7,860,976–7,875,520 bytes | 5,305,072–5,314,296 bytes |
| Retained heap, 4096 unused v5 nodes | 7,795,536–7,795,552 bytes | 5,239,648–5,244,968 bytes |

These ordinary-node fixtures reduce construction allocation bytes by approximately 31%, construction-time medians by 14–15%, and retained heap by approximately 33%. The heap fixture requests GC before and after creating the nodes; the shared CA pool and preallocated holder slice are outside the measured delta. Nodes with special TLS settings retain their validated TLS state and receive a smaller memory saving. This does not measure whole-app RSS, live traffic throughput, first-handshake latency or device power

Reproduce from `core/Clash.Meta/` with `GOTOOLCHAIN=go1.26.9 CGO_ENABLED=0 go test -tags with_gvisor,with_mips_low_memory ./adapter/outbound -run '^TestTuicRetainedHeap$' -bench '^BenchmarkTuicConstruction$' -benchmem -benchtime=1s -count=3 -v`. Before measurements use the same benchmark/heap fixtures with the prior `tuic.go` and the new configuration helper/tests omitted through a temporary Go overlay

Validation covers concurrent first initialization, cancellation before initialization, close racing with initialization, terminal TCP/UDP rejection, option compatibility, and a parsed client-certificate loader surviving source-file removal. Real loopback QUIC handshakes cover CA replacement between parse and dial, pinning, separate certificate names, disabled SNI and explicit verification skipping; incorrect names and pins still fail. TUIC outbound tests, TUIC transport packages and CA tests pass race detection with release tags. The root Core integration suite, formatting, notice, comment-density and diff checks pass

## Compact classical IP indexes

This batch adapts ProjectClash's [merged classical IP rule steps](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/rules/provider/classical_strategy.go). Consecutive runs of at least 16 standard IP-CIDR rules become immutable sorted address ranges. Only destination rules with `no-resolve` and source-address rules qualify; source and destination runs remain separate. The configured parser still handles every input, including `IP-CIDR6` and the `src` parameter, before eligibility is checked

Each run allocates one range array, sorts and merges overlapping/adjacent ranges in place, then shrinks substantially oversized storage. Matching uses binary search without allocation. The strategy releases the original rule objects and excess matcher capacity, while reported counts still include duplicate input rules. IPv4, IPv6, IPv4-mapped IPv6, noncanonical prefixes and address zones preserve the existing `netip.Prefix.Contains` behavior

Resolving rules stay linear, including consecutive rules that could otherwise share a set: each DNS callback may change the metadata seen by the next rule. Domain indexes, process/logical rules, custom wrappers and source/destination changes remain ordering boundaries. Reset, repeated finishing, late insertion and atomic provider replacement continue to work. The change introduces no background workers, timers, forced GC or file-format changes

Compared against Core `5ccb3345`, Go 1.26.9, release tags, macOS arm64 on Apple M4, three serial one-second samples with `GOMAXPROCS=1` and 10,000 disjoint IPv4 `/25` rules:

| Operation | Before | After |
| --- | --- | --- |
| Construct the rule strategy | 1.91–1.95 ms/op | 2.39–2.42 ms/op |
| Construction, allocated bytes / allocations | 2906016 B/op / 50019 | 3389392 B/op / 50022 |
| Match the first rule | 5.30–5.39 ns/op | 35.96–36.21 ns/op |
| Match the last rule | 44.67–45.23 µs/op | 35.34–35.72 ns/op |
| Miss every rule | 44.94–45.36 µs/op | 35.61–35.88 ns/op |

All matching fixtures allocate zero bytes. Construction costs approximately 24% more time at the median and 17% more allocated bytes; first-rule hits also cost more. The benefit applies to retained structures and repeated matching through longer eligible runs, especially late hits and misses. Small runs, interleaved rules and resolving destination rules keep their existing lookup behavior. Timings are operation-level measurements on a shared host, not device-power or whole-app throughput measurements

A separate 20,000-rule fixture retains the source strings outside the measured delta and requests GC before/after strategy construction. Across three runs, disjoint prefixes retain 1,652,232–1,653,648 additional heap bytes and about 20,000 objects with the linear strategy, versus 966,752 bytes and 4 objects with the index, approximately 41% less retained structure memory. A fixture whose final `/8` covers the preceding prefixes retains 144–5,464 additional bytes after indexing, verifying that the large temporary range array is released; the small result includes normal GC measurement noise. These figures exclude source strings, unrelated app state and temporary construction storage, and do not measure whole-app RSS or peak memory

Reproduce from `core/Clash.Meta/` with `GOTOOLCHAIN=go1.26.9 CGO_ENABLED=0 GOMAXPROCS=1 go test -tags with_gvisor,with_mips_low_memory ./rules/provider -run '^$' -bench '^BenchmarkClassicalIPRules$' -benchmem -benchtime=1s -count=3`. The retained-heap check uses the same Go version/tags without the `GOMAXPROCS` override and `-run '^TestClassicalIPIndexRetainedStorage$' -count=3 -v`. Before timings use the same fixtures with the prior strategy and per-rule matching implementation supplied through a temporary Go overlay

Validation compares indexed results, metadata and callback traces against linear matching across mixed/randomized corpora. Focused cases cover overlapping/adjacent prefixes, zero/full-width masks, both address families and their extremes, mapped addresses, zones, nil resolvers, DNS callbacks changing an address partway through a resolving run, parser rewrites/rejection, a custom rule mutating the source address, duplicates, small-run boundaries, reset and late insertion. The provider update regression also publishes IP indexes while matching and exporting JSON concurrently. All rule packages pass race detection with release tags, the root Core integration suite passes, and formatting, notice, comment-density and diff checks pass

## DNS query lifetime and coalesced cache refresh

This batch adapts ProjectClash's [resolver-owned query cancellation](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/dns/resolver.go) and its [live-query lifecycle checks](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/dns/live_query_lifecycle_test.go). Each resolver lazily creates one query context. Closing it cancels active upstream work, rejects subsequent exchanges, suppresses background retries and closes its bootstrap resolver. Close is idempotent, including before first use and while queries begin. A canceled caller leaves the shared upstream query available to other callers, and ordinary network resets preserve the query lifetime

Configuration replacement retires the previous main, proxy-host and direct-host resolver group after publishing the replacement. Disabling DNS and shutting down the Core clear configured resolver, mapper and service references. Query cancellation happens before the DNS listener is shut down, so listener shutdown does not wait for the old upstream timeout. Fake-IP state is stored before the mapper is released. The process-wide system resolver remains reusable across Core reinitialization. Node-private resolver ownership and idle upstream transport cleanup are outside this batch

Stale cache hits still return their cached answer immediately with TTL 1, but only one refresh worker per resolver/question may wait for an upstream result. The pending-question map releases its storage when empty. An individual caller's cancellation no longer schedules a second cache refresh: the existing shared exchange already completes and populates the cache. Background work snapshots the DNS request before the caller regains ownership, preventing later request mutation from changing the query. The snapshots add a request copy on cache misses and on each admitted refresh; fresh cache hits need no additional copy beyond the existing cache path

Compared against Core `a74ba3c4`, Go 1.26.9, release tags, macOS arm64 on Apple M4, three serial samples hold one upstream refresh open and then serve 512 additional stale hits for the same question:

| Retained work after 512 stale hits | Before | After |
| --- | --- | --- |
| Additional goroutines | 512 | 0 |
| Additional heap bytes after GC | 415,592–704,512 | approximately zero; measured delta -6,120 to -2,144 |
| Concurrent upstream queries | 1 | 1 |

The old singleflight path already shares the upstream query but retains one waiting goroutine and associated state for every cache hit. The new admission check removes those duplicate waiters. Negative small heap deltas reflect GC noise, not negative memory use. Separate fixtures close 32 active live queries or 32 stale refreshes in approximately 1.1–2.6 ms, including a 1 ms test polling interval. Both old-implementation fixtures fail the one-second completion assertion. These synthetic tests use cancellation-aware blocked clients; they do not measure whole-app RSS, real network latency or device power

Reproduce from `core/Clash.Meta/` with `GOTOOLCHAIN=go1.26.9 CGO_ENABLED=0 go test -tags with_gvisor,with_mips_low_memory ./dns -run '^TestResolver(RefreshBurstResources|CloseQueriesStopsActiveWork)$' -count=3 -v`. Before measurements use the same tests with the prior resolver implementation and no-op close methods supplied through a temporary Go overlay

Validation covers shared-query cancellation, network resets, request ownership after return, repeated cache refresh, close before first use, fresh-cache rejection after close, concurrent close/first use, all configured resolver roles, replacement, DNS disable/re-enable and system-resolver reuse. The DNS, resolver component and executor packages pass race detection with release tags; the root Core integration suite passes and verifies configured DNS retirement through the actual shutdown entry point. The desktop integration package cannot run directly with `-race` on macOS because its existing CGO build selects Android-only platform code; no build constraints were changed for testing

The requested UI cleanup removes the mips-only option subtitle and its four localized messages. All protocol-stack options now use the same name-only presentation. The affected Dart files pass analysis, localization/build-tag checks pass, and source-notice, comment-density and diff checks pass

## Lazy private DNS for WireGuard and MASQUE

This batch extends the ownership and deferred-construction approach in ProjectClash's [WireGuard device lifecycle](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/adapter/outbound/clash_wireguard_lazy.go) and [MASQUE stack lifecycle](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/adapter/outbound/clash_masque_lazy.go) to node-private DNS. The new DNS holder is a local adaptation of that approach, combined with the resolver query-lifetime support from the preceding batch

WireGuard and both MASQUE modes now retain parsed private nameservers until the resolver is first acquired. Unused nodes avoid creating the main/bootstrap resolvers, their caches and upstream client objects. Nameserver parsing, malformed-address rejection, proxy-adapter binding and IPv6 selection still happen during node construction. TCP dialing acquires the private resolver, including for literal destinations; UDP acquires it when resolving a hostname. Concurrent first users share one resolver, subsequent requests reuse its cache, and a canceled first acquisition does not initialize it

Terminal node close cancels private queries before device teardown, releases the holder's resolver and parsed-server references, and permanently rejects later acquisitions. The same mutex serializes construction and cancellation, so concurrent close calls cannot return while another closer is still canceling that resolver. A borrower already holding the resolver receives its terminal cancellation. Nodes without private DNS continue consulting the current default resolver; closing a private owner never switches it to that fallback or closes the shared default resolver

Compared against Core `7e864f1c`, Go 1.26.9, release tags, macOS arm64 on Apple M4, three samples constructing and closing a node with `remote-dns-resolve` and one ordinary UDP nameserver:

| Node | Before, allocated bytes/op | After, allocated bytes/op | Allocations before → after |
| --- | --- | --- | --- |
| WireGuard | 3,376 | 2,296 | 47 → 33 |
| MASQUE L3 | 18,023–18,024 | 16,944 | 252 → 238 |
| MASQUE L4 | 18,103–18,104 | 17,023–17,024 | 254 → 240 |

Construction allocates approximately 1,080 fewer bytes and 14 fewer objects per node. The larger MASQUE TLS setup remains part of these measurements. Timing varied with concurrent host activity, so these samples support allocation comparisons, not a construction-speed claim

A separate fixture retains 2,048 unused nodes and requests GC before and after construction. Each of the three samples below runs in its own test process, avoiding the previous node kind's cleanup and finalizers affecting the next heap delta:

| Node | Before, retained heap bytes | After, retained heap bytes | Approximate reduction |
| --- | --- | --- | --- |
| WireGuard | 5,046,536–5,046,768 | 3,419,384–3,435,232 | 32% |
| MASQUE L3 | 8,412,000–8,414,104 | 6,791,208–6,797,216 | 19% |
| MASQUE L4 | 8,569,816–8,580,088 | 6,954,720–6,959,720 | 19% |

The holder slice, input nameserver strings and shared warmed state are outside the measured delta. These figures cover unused nodes with private DNS enabled, not whole-app RSS or device power. First use pays the deferred construction cost; used nodes retain a small holder object and take its mutex when acquiring the resolver. No timer, background sweeper or production GC call is added. This batch cancels private queries and releases ownership; it does not add a general DNS transport-disposal API or change OpenVPN/ZeroTier ownership

Reproduce construction allocations from `core/Clash.Meta/` with `GOTOOLCHAIN=go1.26.9 CGO_ENABLED=0 go test -tags with_gvisor,with_mips_low_memory ./adapter/outbound -run '^$' -bench '^BenchmarkUnusedNodeDNS$' -benchmem -benchtime=1s -count=3`. For retained heap, use the same environment/tags with `-run '^TestUnusedNodeDNSRetainedHeap$/^wireguard$' -count=1 -v`, replacing `wireguard` with `masque` or `masque-l4` and running each command three times in separate processes. Before samples use a temporary Go overlay with the prior WireGuard/MASQUE files and the new holder-specific test file omitted

Validation uses the production nameserver parser and covers malformed inputs, no private DNS, canceled first use, concurrent initialization/close, rejection after close, cancellation of a blocked upstream, IPv4/IPv6 answers through the selected proxy, cache reuse/clear, connection reset and default-resolver isolation. The existing local MASQUE tunnel fixture now also serves DNS over the tunnel and verifies TCP/UDP echo by hostname on auto, mips and gVisor stacks. WireGuard, MASQUE and private-DNS tests pass race detection with release tags; the root Core integration suite, formatting, notice, comment-density and diff checks pass. Fixtures use in-memory connections or loopback tunnels and do not launch the application or change host networking

## Complete and deduplicated DNS connection resets

This batch adapts ProjectClash's [policy-aware connection reset and shared-transport deduplication](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/dns/resolver.go) and [policy client enumeration](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/dns/policy.go). Network resets now reach both domain-trie and matcher-based nameserver policies, including the main, proxy-host and direct-host resolver roles and the bootstrap resolver. The preceding implementation only walked main/fallback/bootstrap clients, leaving policy-only encrypted DNS connections on their previous network

A reset unwraps ECS and disabled-query-type decorators and visits each shared raw transport once across the resolver group. Its temporary identity set belongs to that reset, so later network changes still perform cleanup. Pointer transports use type comparability directly; structured values also check their actual fields before being used as map keys, avoiding panics for custom clients containing a slice or map behind an interface. Non-comparable clients remain supported without identity deduplication. DNS caches and the resolver's query lifetime remain reusable

The local adaptation streams policy clients through a value-only trie traversal. It neither reconstructs domain names nor collects a temporary client list, and it handles optimized single-child nodes directly without synthesizing child maps. The only retained traversal state is on the call stack; the temporary identity set scales with distinct transports, not policy aliases. No additional permanent resolver field, timer or background worker is introduced

Against Core `ec607ee5`, the regression fixture changes six resets of one shared transport to one per network change, while both kinds of policy-only transport change from zero resets to one. Those checks establish the missing cleanup and duplicate work; the old implementation's skipped policy traversal is not a valid timing baseline for a complete reset

The following comparison instead isolates ProjectClash-style snapshot enumeration versus the streaming adaptation. Both variants run the same new deduplicated reset code; a temporary Go overlay replaces only trie-policy enumeration with the reference approach of reconstructing names and appending clients to a slice. Each fixture has one shared wrapped transport. Go 1.26.9, release tags, `GOMAXPROCS=1`, macOS arm64 on Apple M4, three serial samples:

| Policy entries | Snapshot allocated bytes / allocations | Streaming allocated bytes / allocations | Snapshot time | Streaming time |
| --- | --- | --- | --- | --- |
| 1 | 424 B / 9 | 272 B / 3 | 437–506 ns | 111–114 ns |
| 1,024 | 150,192 B / 3,089 | 272 B / 3 | 119–130 µs | 22.7–22.8 µs |
| 16,384 | 2,632,368 B / 49,177 | 272 B / 3 | 2.33–3.57 ms | 427–441 µs |

Every measured reset visits the raw transport once. These figures measure temporary allocation and traversal work during a network reset, not steady-state app memory or device power. Configurations with many distinct transports require a larger identity set, and the new complete reset necessarily performs cleanup that the previous implementation omitted

Reproduce the streaming measurements from `core/Clash.Meta/` with `GOTOOLCHAIN=go1.26.9 CGO_ENABLED=0 GOMAXPROCS=1 go test -tags with_gvisor,with_mips_low_memory ./dns -run '^$' -bench '^BenchmarkResetPolicyConnections$' -benchmem -benchtime=1s -count=3`. For the snapshot comparison, replace `domainTriePolicy.forEachClient` through an overlay with `DomainTrie.Foreach`, append each entry's clients to a slice, then visit that slice; leave the rest of the reset path unchanged

Validation covers exact/wildcard policies, both policy representations, nested decorators, shared and independent role clients, bootstrap clients, repeated resets, empty groups, non-comparable custom clients, cached answers and subsequent queries. Production-configured DoT, DoH and DoQ policy clients complete queries through local loopback fixtures and perform a fresh handshake after resetting. Trie traversal tests cover stored zero values, optimized/unoptimized nodes, empty tries and early termination. DNS, trie, resolver-component and executor packages pass race detection with release tags; the root Core integration suite and formatting, notice, comment-density and diff checks pass

## Private DNS ownership across OpenVPN and ZeroTier sessions

This batch applies the deferred construction and session-owned resource approach in ProjectClash's [WireGuard lifecycle](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/adapter/outbound/clash_wireguard_lazy.go) and [MASQUE lifecycle](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/adapter/outbound/clash_masque_lazy.go) to the remaining node-private DNS owners. These are local adaptations using FlClash's existing resolver cancellation and lazy DNS holder, rather than copied OpenVPN or ZeroTier DNS implementations from the reference

OpenVPN captures its private resolver with the packet-loop session. Session loss and terminal close cancel outstanding queries and clear the resolver reference, releasing its cache ownership. The next successful handshake constructs a fresh resolver with the new session's IPv6 setting. A delayed old-session cleanup cancels only its captured resolver and cannot clear a replacement session. OpenVPN continues constructing its resolver after a successful handshake

ZeroTier retains parsed nameservers until TCP dialing or a UDP hostname lookup first acquires its private resolver. Configuration replacement, network removal/failure, stack failure, identity recovery and terminal close cancel the retired owner's queries and release its resolver and nameserver references. Cancellation runs outside the state mutex, and terminal close cancels DNS before waiting for the control-operation lock. Configuration parsing, explicit DNS precedence, controller port defaults, proxy-adapter binding and IPv6 selection remain unchanged. Failed or superseded configuration updates preserve the published resolver; stale runtime/device callbacks cannot retire it

Compared against Core `eb25bba1`, Go 1.26.9, release tags, `GOMAXPROCS=1`, macOS arm64 on Apple M4, three serial samples preparing a ZeroTier network configuration with one controller-provided UDP nameserver:

| DNS configuration preparation | Before | After |
| --- | --- | --- |
| Allocated bytes/op | 1,648 | 568 |
| Allocations/op | 26 | 12 |

The deferred construction removes 1,080 allocated bytes and 14 allocations from this path, approximately 65.5% fewer allocated bytes. First acquisition pays the deferred resolver construction cost. The fixture measures configuration preparation, including parsing and adapter binding; it does not measure a full network join, retained whole-app memory, RSS or device power. No periodic cleanup worker, additional timer or production GC call is introduced, and query cancellation is not a general DNS transport-disposal API

Reproduce from `core/Clash.Meta/` with `GOTOOLCHAIN=go1.26.9 CGO_ENABLED=0 GOMAXPROCS=1 go test -tags with_gvisor,with_mips_low_memory ./adapter/outbound -run '^$' -bench '^BenchmarkZeroTierPrivateDNSConfig$' -benchmem -benchtime=1s -count=3`. Before samples use the same benchmark with the prior `zerotier.go` and identity test supplied through a temporary Go overlay, with the new ZeroTier DNS-specific tests omitted

Focused fixtures suspend 32 private DNS queries for each retirement event and verify upstream cancellation, completion, rejection of later queries and no retry dials. Replaying the prior OpenVPN implementation through an overlay fails both the session-loss and terminal-close retirement assertions within the fixtures' one-second limit. Other checks exercise a blocked ZeroTier control operation, TCP/UDP error propagation, a late OpenVPN session cleanup, rejected configuration updates before and after IP-link mutation, stale callbacks and configured-identity recovery. OpenVPN, ZeroTier, WireGuard, MASQUE and private-DNS tests pass race detection with release tags, and the root Core integration suite passes. Fixtures use in-memory transports and the existing isolated loopback tests; they do not launch the application or change host networking

## Lower-allocation proxy JSON responses

This batch adapts ProjectClash's [canonical JSON member merge](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/adapter/clash_proxy_json_merge.go) and [direct metadata/history encoding](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/adapter/clash_proxy_json.go). Proxy serialization obtains the underlying adapter JSON once, validates its canonical representation, retains existing member byte ranges and merges the current health and proxy metadata. Large group member arrays no longer need an intermediate decoded slice and string objects before being encoded again. The shared proxy marshaler serves node, group and provider JSON responses

The fast path preserves sorted field order, metadata overrides, HTML/string escaping, UTF-8 replacement, time encoding and the existing empty-history distinctions (`[]` for the node, `null` for an unmeasured extra URL). Floats, exponent notation, large integers, duplicate or unordered keys, noncanonical strings and nesting beyond 64 value levels use the existing map-based implementation. This preserves the legacy numeric conversion and error behavior for custom adapters. Adapter errors return directly, and fallback does not invoke its marshaler a second time

The local adaptation snapshots health entries through the existing concurrent state container, uses Go's validated time appender and bounds the recursive fast-path scan. Generic member sorting avoids quadratic behavior for large custom objects. History buffers reserve capacity for their bounded records, and the merged response reserves space from the actual fields being written; this also lowers allocations for nodes with full histories. All serialization buffers are temporary, with no new retained cache, timer or background task

Compared against Core `02e723e2`, Go 1.26.9, release tags, `GOMAXPROCS=1`, macOS arm64 on Apple M4, three serial samples of `json.Marshal` on a proxy slice:

| Fixture | Before, allocated bytes/op | After, allocated bytes/op | Allocations before → after |
| --- | --- | --- | --- |
| One unmeasured node | 4,936 | 2,528 | 67 → 33 |
| One node with ten main records and ten records for each of two URLs | 11,450 | 10,089 | 106 → 42 |
| One group containing 10,000 names | 1,359,686–1,359,689 | 371,124 | 20,122 → 48 |
| 1,000 unmeasured nodes | 4,894,962–4,894,966 | 2,486,714–2,486,717 | 65,010 → 31,006 |

The 1,000-node fixture allocates approximately 49.2% fewer bytes and takes 3.12–3.30 ms/op versus 5.78–5.84 ms/op. The large-group fixture allocates approximately 72.7% fewer bytes and takes 0.815–0.857 ms/op versus 1.698–1.749 ms/op. The group fixture regenerates its adapter JSON each time from a fixed member snapshot; its membership-selection work is outside the measurement. These are temporary operation-level allocations and elapsed times on a shared host, not retained heap, whole-app RSS or battery measurements

Reproduce from `core/Clash.Meta/` with `GOTOOLCHAIN=go1.26.9 CGO_ENABLED=0 GOMAXPROCS=1 go test -tags with_gvisor,with_mips_low_memory ./adapter -run '^$' -bench '^BenchmarkProxyJSON$' -benchmem -benchtime=1s -count=3`. Before samples use the same benchmark with only the prior `adapter/adapter.go` supplied through a temporary Go overlay

Validation compares output bytes and errors against the previous marshaler across canonical/custom objects, metadata collisions, duplicate keys, numeric edge cases, escaped and invalid UTF-8 strings, empty/full histories, deep nesting and invalid timestamps. Production selector, URL-test, fallback and load-balance groups retain their fields in both node lists and provider payloads. A 20-second fuzz run executes 354,354 inputs and checks that every accepted canonical object is byte-identical after the standard decode/encode round trip. Concurrent health writers and JSON readers, the full adapter/group/provider packages and the root Core integration suite pass their relevant tests, including race detection for those three Core packages. Formatting, notice, comment-density and diff checks pass

## Streaming controller node and provider responses

This batch adapts ProjectClash's [streamed proxy map](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/adapter/clash_proxy_json.go), [provider header and node-list writer](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/adapter/provider/clash_provider_json.go) and [controller integration](https://github.com/ProjectClash/Clash/blob/3891cc46092029c23f7fd0bfa1fe29e0e6e1dffb/hub/route/clash_proxies_json.go). The external controller's `/proxies`, `/providers/proxies` and `/providers/proxies/{name}` endpoints write their lists incrementally. Ordinary node encoding reuses the output buffer's available space, removing the per-node merged-result copy as well as the complete-list response buffers

The local implementation uses a 4 KiB writer buffer to keep the fixed cost small for ordinary responses. Map keys still require a sorted name slice, and individual nodes, group member arrays and health snapshots can allocate beyond the buffer size. Custom proxy/provider marshalers retain standard JSON validation and escaping; unknown provider implementations use their complete custom marshaler. The 4 KiB buffer is therefore not a whole-request or process memory bound. This adds no response cache, timer or background worker

Successful response bytes, sorted map keys, field order, HTML/UTF-8 escaping, `null` versus empty lists, content type, configured HTTP status and trailing newline match the prior renderer. Provider streaming and ordinary marshaling share the same metadata snapshot definition. A slow reader holds neither the provider mutex nor a live mutable member list; concurrent replacement affects later responses. Inline-provider timestamp updates now share the snapshot lock

Cancellation and write errors stop subsequent node encoding. Before the first transport write, encoding errors retain the HTTP 500 response and marshaler error chain. Once output has started, an encoding/write failure aborts the HTTP transfer instead of completing a truncated JSON response or appending an error object. This is an intentional late-error behavior change required by streaming; an HTTP/1 client observes an incomplete body. Oversized individual nodes are still supported

Go 1.26.9, release tags, `GOMAXPROCS=1`, macOS arm64 on Apple M4, three serial one-second samples compare the existing buffered `render.JSON` path and the new stream in the same build:

| Response fixture | Buffered, allocated bytes/op | Streamed, allocated bytes/op | Conservative reduction |
| --- | --- | --- | --- |
| 10 nodes | 26,117 | 24,161 | 7.5% |
| 1,000 nodes | 2,567,987–2,571,890 | 2,019,477–2,019,479 | 21.4% |
| One provider with 1,000 nodes | 2,757,269–2,763,343 | 1,971,108–1,971,110 | 28.5% |
| Three provider entries, each with 1,000 nodes | 8,255,043–8,412,388 | 5,904,948–5,904,950 | 28.5% |

Fixtures and request writers are prepared outside the timed loop; response bytes are discarded so client-side storage is excluded. The three-provider fixture reuses the same immutable provider in all three entries, encoding it three times. Allocation counts remain similar and can rise slightly at buffer boundaries: the 1,000-node response uses 33,071 allocations versus 33,011, while the provider response uses 31,073 versus 31,010–31,011. The improvement is fewer allocated bytes and no complete-list encoding buffer, not a reduction in every allocation count. Elapsed times varied on the shared host; these measurements do not establish retained heap, whole-app RSS or device battery savings

Reproduce from `core/Clash.Meta/` with `GOTOOLCHAIN=go1.26.9 CGO_ENABLED=0 GOMAXPROCS=1 go test -tags with_gvisor,with_mips_low_memory ./hub/route -run '^$' -bench '^BenchmarkControllerProxyJSON$' -benchmem -benchtime=1s -count=3`

Validation covers byte-for-byte compatibility for all three endpoints, large lists, custom marshalers, early error bodies, tiny/normal buffer boundaries, cancellation, short writes, failed writes, provider replacement during a blocked response, concurrent timestamp/subscription updates and an actual loopback HTTP response aborted after a late encoding failure. The full adapter, provider and controller-route packages pass race detection, and the root Core integration suite passes. Manual review, formatting, notice, comment-density and diff checks complete the batch

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

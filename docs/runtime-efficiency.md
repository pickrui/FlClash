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

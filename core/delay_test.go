package main

import (
	"context"
	"crypto/tls"
	"crypto/x509"
	"encoding/json"
	"errors"
	"fmt"
	"net"
	"net/http"
	"net/http/httptest"
	"strings"
	"sync"
	"sync/atomic"
	"syscall"
	"testing"
	"time"

	"github.com/metacubex/mihomo/adapter"
	"github.com/metacubex/mihomo/adapter/outbound"
	"github.com/metacubex/mihomo/common/utils"
	"github.com/metacubex/mihomo/constant"
	"github.com/metacubex/mihomo/tunnel"
)

func TestDelayEventFilterKeepsConcurrentManualTargetsScoped(t *testing.T) {
	var filter delayEventFilter
	first := filter.begin("node", "https://example.com")
	second := filter.begin("node", "https://example.com")

	if got := filter.message("https://example.com", "node", 0, false); got != nil {
		t.Fatalf("manual failure leaked as event: %+v", got)
	}
	if got := filter.message("https://other.example.com", "node", 25, true); got == nil || got.Value != 25 {
		t.Fatalf("independent URL event = %+v", got)
	}
	if got := filter.message("https://example.com", "other", 25, true); got == nil || got.Value != 25 {
		t.Fatalf("independent proxy event = %+v", got)
	}

	first()
	if got := filter.message("https://example.com", "node", 0, false); got != nil {
		t.Fatalf("second manual probe still active, event = %+v", got)
	}
	second()
	if got := filter.message("https://example.com", "node", 0, false); got == nil || got.Value != -1 {
		t.Fatalf("background failure after manual completion = %+v", got)
	}
	if len(filter.active) != 0 {
		t.Fatalf("completed manual probes retained %d targets", len(filter.active))
	}
}

func TestDelayEventFilterConcurrentAccess(t *testing.T) {
	var filter delayEventFilter
	var workers sync.WaitGroup
	for range 50 {
		workers.Go(func() {
			for range 100 {
				finish := filter.begin("node", "https://example.com")
				if got := filter.message("https://example.com", "node", 25, true); got != nil {
					t.Error("manual probe event escaped while its slot was active")
				}
				finish()
			}
		})
	}
	workers.Wait()
	if len(filter.active) != 0 {
		t.Fatalf("completed manual probes retained %d targets", len(filter.active))
	}
}

type delayProbeProxy struct {
	constant.Proxy
	onTest func(context.Context, string) (uint16, error)
}

func (p *delayProbeProxy) Name() string { return "node" }

func (p *delayProbeProxy) URLTest(ctx context.Context, url string, _ utils.IntRanges[uint16]) (uint16, error) {
	return p.onTest(ctx, url)
}

func TestHandleAsyncTestDelayReturnsScopedResultWithoutDuplicateEvent(t *testing.T) {
	previousProxies, previousProviders := tunnel.Proxies(), tunnel.Providers()
	t.Cleanup(func() { tunnel.UpdateProxies(previousProxies, previousProviders) })

	for _, probe := range []struct {
		value   uint16
		failure bool
		want    int32
	}{
		{value: 25, want: 25},
		{value: 0, want: 1},
		{value: 0, failure: true, want: -1},
	} {
		proxy := &delayProbeProxy{onTest: func(ctx context.Context, url string) (uint16, error) {
			if _, ok := ctx.Deadline(); !ok {
				t.Error("manual probe has no network deadline")
			}
			if got := manualDelayEvents.message(url, "node", 0, false); got != nil {
				t.Errorf("manual URLTest event was not suppressed: %+v", got)
			}
			if probe.failure {
				return probe.value, errors.New("unreachable")
			}
			return probe.value, nil
		}}
		tunnel.UpdateProxies(map[string]constant.Proxy{"node": proxy}, nil)
		result := make(chan *Delay, 1)
		handleAsyncTestDelay(&TestDelayParams{
			ProxyName: "node", TestUrl: "https://example.com", Timeout: 5000,
		}, func(delay *Delay) { result <- delay })

		select {
		case got := <-result:
			if got.Name != "node" || got.Url != "https://example.com" || got.Value != probe.want {
				t.Fatalf("manual response = %+v, want node, supplied URL, %d", got, probe.want)
			}
			if got := manualDelayEvents.message("https://example.com", "node", 25, true); got == nil {
				t.Fatal("background event still suppressed after the manual result")
			}
		case <-time.After(time.Second):
			t.Fatal("manual probe did not respond")
		}
	}
}

func TestHandleAsyncTestDelayPreservesURLForMissingProxy(t *testing.T) {
	previousProxies, previousProviders := tunnel.Proxies(), tunnel.Providers()
	t.Cleanup(func() { tunnel.UpdateProxies(previousProxies, previousProviders) })
	tunnel.UpdateProxies(map[string]constant.Proxy{}, nil)

	for _, url := range []string{"https://example.com", ""} {
		result := make(chan *Delay, 1)
		handleAsyncTestDelay(&TestDelayParams{
			ProxyName: "missing", TestUrl: url, Timeout: 5000,
		}, func(delay *Delay) { result <- delay })
		wantURL := url
		if wantURL == "" {
			wantURL = constant.DefaultTestURL
		}
		select {
		case got := <-result:
			if got.Name != "missing" || got.Url != wantURL || got.Value != -1 || got.Failure != "missingProxy" {
				t.Fatalf("missing proxy response = %+v, want missing, %q, -1", got, wantURL)
			}
		case <-time.After(time.Second):
			t.Fatal("missing proxy did not respond")
		}
	}
}

// Exercise the real outbound HTTP probe, not a synthetic returned delay. A slow
// link must fail a short deadline and succeed with its own adequate budget.
func TestDelayProbeHonorsItsNetworkBudget(t *testing.T) {
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		select {
		case <-r.Context().Done():
			return
		case <-time.After(150 * time.Millisecond):
			w.WriteHeader(http.StatusNoContent)
		}
	}))
	defer server.Close()
	previousProxies, previousProviders := tunnel.Proxies(), tunnel.Providers()
	t.Cleanup(func() { tunnel.UpdateProxies(previousProxies, previousProviders) })
	tunnel.UpdateProxies(map[string]constant.Proxy{"slow": adapter.NewProxy(outbound.NewDirect())}, nil)
	for _, timeout := range []int64{30, 2000} {
		result := make(chan *Delay, 1)
		handleAsyncTestDelay(&TestDelayParams{
			ProxyName: "slow", TestUrl: server.URL, Timeout: timeout,
		}, func(delay *Delay) { result <- delay })
		select {
		case delay := <-result:
			if timeout == 30 && (delay.Value != -1 || delay.Failure != "timeout") {
				t.Fatalf("short deadline reported success: %+v", delay)
			}
			if timeout == 2000 && delay.Value <= 0 {
				t.Fatalf("adequate budget did not complete the slow HTTP probe: %+v", delay)
			}
		case <-time.After(3 * time.Second):
			t.Fatal("probe did not finish within its RPC grace")
		}
	}
}

// Verify the actual mihomo probe used by the app: HEAD accepts a response
// without following redirects, and unified delay measures a second request
// over the same connection instead of the initial setup/first response.
func TestDelayProbeUsesHTTPHeadAndUnifiedRoundTrip(t *testing.T) {
	previousProxies, previousProviders := tunnel.Proxies(), tunnel.Providers()
	previousUnified := adapter.UnifiedDelay.Load()
	t.Cleanup(func() {
		tunnel.UpdateProxies(previousProxies, previousProviders)
		adapter.UnifiedDelay.Store(previousUnified)
	})

	for _, unified := range []bool{false, true} {
		name := "first response"
		if unified {
			name = "unified round trip"
		}
		t.Run(name, func(t *testing.T) {
			adapter.UnifiedDelay.Store(unified)
			var mu sync.Mutex
			var peers []string
			server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				if r.Method != http.MethodHead || r.URL.Path != "/probe" {
					t.Errorf("probe request = %s %s", r.Method, r.URL.Path)
				}
				mu.Lock()
				peers = append(peers, r.RemoteAddr)
				first := len(peers) == 1
				mu.Unlock()
				if first {
					time.Sleep(250 * time.Millisecond)
				}
				w.Header().Set("Location", "/must-not-follow")
				w.WriteHeader(http.StatusFound)
			}))
			defer server.Close()
			tunnel.UpdateProxies(map[string]constant.Proxy{"node": adapter.NewProxy(outbound.NewDirect())}, nil)
			result := make(chan *Delay, 1)
			handleAsyncTestDelay(&TestDelayParams{
				ProxyName: "node", TestUrl: server.URL + "/probe", Timeout: 2000,
			}, func(delay *Delay) { result <- delay })

			select {
			case delay := <-result:
				if delay.Value <= 0 {
					t.Fatalf("HTTP response reported as failed: %+v", delay)
				}
				if unified && delay.Value >= 250 {
					t.Fatalf("unified delay included the slow first response: %+v", delay)
				}
				if !unified && delay.Value < 250 {
					t.Fatalf("non-unified delay excluded the first response: %+v", delay)
				}
			case <-time.After(3 * time.Second):
				t.Fatal("HEAD probe did not complete")
			}
			mu.Lock()
			defer mu.Unlock()
			if !unified && len(peers) != 1 {
				t.Fatalf("non-unified probe made %d requests", len(peers))
			}
			if unified && (len(peers) != 2 || peers[0] != peers[1]) {
				t.Fatalf("unified probe did not reuse its connection: %v", peers)
			}
		})
	}
}

// A new test run supersedes the previous one: probes the app has already
// discarded stop at once instead of holding the network, the probe semaphore
// and the app's request budget until their own deadline.
func TestManualProbeSupersededByNewerGeneration(t *testing.T) {
	started := make(chan struct{}, 4)
	release := make(chan struct{})
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		select {
		case started <- struct{}{}:
		default:
		}
		select {
		case <-r.Context().Done():
		case <-release:
			w.WriteHeader(http.StatusNoContent)
		}
	}))
	defer server.Close()
	var once sync.Once
	unblock := func() { once.Do(func() { close(release) }) }
	defer unblock()
	previousProxies, previousProviders := tunnel.Proxies(), tunnel.Providers()
	t.Cleanup(func() { tunnel.UpdateProxies(previousProxies, previousProviders) })
	node := adapter.NewProxy(outbound.NewDirect())
	tunnel.UpdateProxies(map[string]constant.Proxy{"node": node}, nil)
	if !node.AliveForTestUrl(server.URL) {
		t.Fatal("new node should be available before a health failure")
	}

	superseded := make(chan *Delay, 1)
	handleAsyncTestDelay(&TestDelayParams{
		ProxyName: "node", TestUrl: server.URL, Timeout: 30000, Generation: 1,
	}, func(delay *Delay) { superseded <- delay })
	select {
	case <-started:
	case <-time.After(5 * time.Second):
		t.Fatal("the first probe never reached the test server")
	}

	current := make(chan *Delay, 1)
	handleAsyncTestDelay(&TestDelayParams{
		ProxyName: "node", TestUrl: server.URL, Timeout: 30000, Generation: 2,
	}, func(delay *Delay) { current <- delay })

	select {
	case delay := <-superseded:
		if delay.Value != -1 {
			t.Fatalf("superseded probe reported %+v", delay)
		}
	case <-time.After(5 * time.Second):
		t.Fatal("a superseded probe kept running until its own deadline")
	}
	if !node.AliveForTestUrl(server.URL) || len(node.DelayHistory()) != 0 {
		t.Fatal("superseded probe overwrote health/history with a false failure")
	}
	select {
	case delay := <-current:
		t.Fatalf("the current run was cancelled with its predecessor: %+v", delay)
	case <-time.After(300 * time.Millisecond):
	}
	unblock()
	select {
	case delay := <-current:
		if delay.Value <= 0 {
			t.Fatalf("replacement probe failed: %+v", delay)
		}
	case <-time.After(5 * time.Second):
		t.Fatal("replacement probe did not complete")
	}
}

// Queue time must not eat the probe budget: a node that waited behind a full
// semaphore still gets its whole timeout, or a bulk test reports Timeout for
// whatever sat at the back of the queue.
func TestQueuedProbeKeepsItsFullBudget(t *testing.T) {
	const serverDelay = 300 * time.Millisecond
	const queueDelay = 400 * time.Millisecond
	const budget = 500 * time.Millisecond

	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		select {
		case <-r.Context().Done():
		case <-time.After(serverDelay):
			w.WriteHeader(http.StatusNoContent)
		}
	}))
	defer server.Close()
	previousProxies, previousProviders := tunnel.Proxies(), tunnel.Providers()
	t.Cleanup(func() { tunnel.UpdateProxies(previousProxies, previousProviders) })
	tunnel.UpdateProxies(
		map[string]constant.Proxy{"node": adapter.NewProxy(outbound.NewDirect())},
		nil,
	)

	if err := delaySem.Acquire(context.Background(), delayTestConcurrency); err != nil {
		t.Fatalf("could not reserve the probe semaphore: %v", err)
	}
	released := false
	defer func() {
		if !released {
			delaySem.Release(delayTestConcurrency)
		}
	}()

	result := make(chan *Delay, 1)
	handleAsyncTestDelay(&TestDelayParams{
		ProxyName: "node",
		TestUrl:   server.URL,
		Timeout:   budget.Milliseconds(),
	}, func(delay *Delay) { result <- delay })

	select {
	case delay := <-result:
		t.Fatalf("probe ran without a slot: %+v", delay)
	case <-time.After(queueDelay):
	}
	delaySem.Release(delayTestConcurrency)
	released = true

	select {
	case delay := <-result:
		if delay.Value <= 0 {
			t.Fatalf("a queued probe lost its network budget: %+v", delay)
		}
	case <-time.After(budget + serverDelay + time.Second):
		t.Fatal("queued probe never finished")
	}
}

func TestDelayProbeBatchAfterFrontendRestart(t *testing.T) {
	var hold atomic.Bool
	started := make(chan struct{}, 2)
	release := make(chan struct{})
	var releaseOnce sync.Once
	unblock := func() { releaseOnce.Do(func() { close(release) }) }
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if hold.Load() {
			started <- struct{}{}
			select {
			case <-r.Context().Done():
				return
			case <-release:
			}
		}
		w.WriteHeader(http.StatusNoContent)
	}))
	defer server.Close()
	defer unblock()
	previousProxies, previousProviders := tunnel.Proxies(), tunnel.Providers()
	previousUnified := adapter.UnifiedDelay.Load()
	adapter.UnifiedDelay.Store(false)
	t.Cleanup(func() {
		tunnel.UpdateProxies(previousProxies, previousProviders)
		adapter.UnifiedDelay.Store(previousUnified)
	})
	tunnel.UpdateProxies(map[string]constant.Proxy{"node": adapter.NewProxy(outbound.NewDirect())}, nil)

	probe := func(generation int64) <-chan *Delay {
		result := make(chan *Delay, 1)
		handleAsyncTestDelay(&TestDelayParams{
			ProxyName: "node", TestUrl: server.URL, Timeout: 2000, Generation: generation,
		}, func(delay *Delay) { result <- delay })
		return result
	}
	awaitSuccess := func(result <-chan *Delay) {
		t.Helper()
		select {
		case delay := <-result:
			if delay.Value <= 0 {
				t.Fatalf("reachable node reported a false failure: %+v", delay)
			}
		case <-time.After(3 * time.Second):
			t.Fatal("local probe did not finish")
		}
	}
	awaitSuccess(probe(100))
	hold.Store(true)
	first := probe(1)
	select {
	case <-started:
	case <-time.After(3 * time.Second):
		t.Fatal("first restarted probe never reached the server")
	}
	second := probe(1)
	select {
	case <-started:
	case <-time.After(3 * time.Second):
		t.Fatal("second restarted probe never reached the server")
	}
	unblock()
	awaitSuccess(first)
	awaitSuccess(second)
}

func TestDelayProbeRegistryScopesOverlappingFrontends(t *testing.T) {
	var registry delayProbeRegistry
	old, cancelOld := context.WithCancel(context.Background())
	defer cancelOld()
	oldID := registry.begin("old", 100, cancelOld)
	defer registry.end(oldID)
	first, cancelFirst := context.WithCancel(context.Background())
	defer cancelFirst()
	firstID := registry.begin("new", 1, cancelFirst)
	second, cancelSecond := context.WithCancel(context.Background())
	defer cancelSecond()
	secondID := registry.begin("new", 1, cancelSecond)
	if old.Err() != nil || first.Err() != nil || second.Err() != nil {
		t.Fatal("independent frontends or members of one batch cancelled each other")
	}
	current, cancelCurrent := context.WithCancel(context.Background())
	defer cancelCurrent()
	currentID := registry.begin("new", 2, cancelCurrent)
	if first.Err() != context.Canceled || second.Err() != context.Canceled || old.Err() != nil || current.Err() != nil {
		t.Fatal("a newer batch must cancel only its own frontend's older probes")
	}
	registry.end(firstID)
	registry.end(secondID)
	registry.end(currentID)
	registry.end(oldID)
	if len(registry.active) != 0 {
		t.Fatal("completed probes remain registered")
	}
}

func TestDelayProbeRegistryRejectsLateOlderBatch(t *testing.T) {
	var registry delayProbeRegistry
	current, cancelCurrent := context.WithCancel(context.Background())
	defer cancelCurrent()
	currentID := registry.begin("session", 2, cancelCurrent)
	defer registry.end(currentID)
	late, cancelLate := context.WithCancel(context.Background())
	defer cancelLate()
	lateID := registry.begin("session", 1, cancelLate)
	if lateID != 0 || late.Err() != context.Canceled || current.Err() != nil || len(registry.active) != 1 {
		t.Fatal("late stale probe was admitted or cancelled the current batch")
	}
	unscoped, cancelUnscoped := context.WithCancel(context.Background())
	defer cancelUnscoped()
	unscopedID := registry.begin("session", 0, cancelUnscoped)
	defer registry.end(unscopedID)
	if unscoped.Err() != nil || current.Err() != nil {
		t.Fatal("legacy unscoped probes must remain independent of batch cancellation")
	}
}

func TestDelayProbeSupports150ConcurrentReachableNodes(t *testing.T) {
	const count = 150
	started := make(chan struct{}, count)
	release := make(chan struct{})
	var once sync.Once
	unblock := func() { once.Do(func() { close(release) }) }
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		started <- struct{}{}
		select {
		case <-release:
			w.WriteHeader(http.StatusNoContent)
		case <-r.Context().Done():
		}
	}))
	defer server.Close()
	defer unblock()
	previousProxies, previousProviders := tunnel.Proxies(), tunnel.Providers()
	previousUnified := adapter.UnifiedDelay.Load()
	adapter.UnifiedDelay.Store(false)
	t.Cleanup(func() {
		tunnel.UpdateProxies(previousProxies, previousProviders)
		adapter.UnifiedDelay.Store(previousUnified)
	})
	tunnel.UpdateProxies(map[string]constant.Proxy{"node": adapter.NewProxy(outbound.NewDirect())}, nil)
	results := make(chan *Delay, count)
	for range count {
		handleAsyncTestDelay(&TestDelayParams{
			Session: "parallel-150", Generation: 1, ProxyName: "node", TestUrl: server.URL, Timeout: 5000,
		}, func(delay *Delay) { results <- delay })
	}
	deadline := time.NewTimer(4 * time.Second)
	defer deadline.Stop()
	for index := range count {
		select {
		case <-started:
		case <-deadline.C:
			t.Fatalf("only %d of 150 probes could reach the server concurrently", index)
		}
	}
	unblock()
	for range count {
		select {
		case delay := <-results:
			if delay.Value <= 0 {
				t.Fatalf("reachable probe failed at 150 concurrency: %+v", delay)
			}
		case <-time.After(5 * time.Second):
			t.Fatal("concurrent probe did not complete")
		}
	}
}

func TestDelayFailureReasonsKeepSensitiveErrorsInsideCore(t *testing.T) {
	for _, test := range []struct {
		err  error
		want string
	}{
		{context.DeadlineExceeded, "timeout"},
		{context.Canceled, "canceled"},
		{errTunNotReady, "vpnNotReady"},
		{errProtectRefused, "vpnProtect"},
		{&net.DNSError{Name: "private-host", Err: "private-error", IsTimeout: true}, "dns"},
		{&tls.CertificateVerificationError{Err: errors.New("private-error")}, "tls"},
		{x509.UnknownAuthorityError{}, "tls"},
		{x509.HostnameError{Host: "private-host"}, "tls"},
		{&net.OpError{Op: "dial", Err: syscall.ECONNREFUSED}, "connect"},
		{&net.OpError{Op: "read", Err: errors.New("private-error")}, "transport"},
		{errors.New("private-error"), "other"},
	} {
		reason := delayFailureReason(fmt.Errorf("private-wrapper: %w", test.err))
		if reason != test.want {
			t.Fatalf("reason = %q, want %q", reason, test.want)
		}
		encoded, err := json.Marshal(Delay{Value: -1, Failure: reason})
		if err != nil {
			t.Fatal(err)
		}
		if strings.Contains(string(encoded), "private") {
			t.Fatalf("sensitive error escaped: %s", encoded)
		}
	}
	if delayFailureReason(nil) != "" {
		t.Fatal("successful probe has a failure reason")
	}
}

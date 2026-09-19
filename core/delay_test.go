package main

import (
	"context"
	"errors"
	"net/http"
	"net/http/httptest"
	"sync"
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
			if got.Name != "missing" || got.Url != wantURL || got.Value != -1 {
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
			if timeout == 30 && delay.Value != -1 {
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
	defer close(release)
	previousProxies, previousProviders := tunnel.Proxies(), tunnel.Providers()
	t.Cleanup(func() { tunnel.UpdateProxies(previousProxies, previousProviders) })
	tunnel.UpdateProxies(
		map[string]constant.Proxy{"node": adapter.NewProxy(outbound.NewDirect())},
		nil,
	)

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
	select {
	case delay := <-current:
		t.Fatalf("the current run was cancelled with its predecessor: %+v", delay)
	case <-time.After(300 * time.Millisecond):
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

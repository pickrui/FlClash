package main

import (
	"context"
	"errors"
	"net/http"
	"net/http/httptest"
	"sync/atomic"
	"testing"
	"time"

	"github.com/metacubex/mihomo/adapter"
	"github.com/metacubex/mihomo/adapter/outbound"
)

func TestDelayProbeCompletionOrdering(t *testing.T) {
	previousUnified, previousHook := adapter.UnifiedDelay.Load(), adapter.UrlTestHook
	adapter.UnifiedDelay.Store(false)
	t.Cleanup(func() {
		adapter.UnifiedDelay.Store(previousUnified)
		adapter.UrlTestHook = previousHook
	})
	for _, test := range []struct {
		name                                              string
		olderFails, newerFails, differentURL, cancelNewer bool
	}{
		{name: "late health failure cannot overwrite manual success", olderFails: true},
		{name: "late success cannot overwrite a newer failure", newerFails: true},
		{name: "different test URLs retain independent results", olderFails: true, differentURL: true},
		{name: "canceled probe does not invalidate an older result", cancelNewer: true},
	} {
		t.Run(test.name, func(t *testing.T) {
			started, release := make(chan struct{}), make(chan struct{})
			var requests atomic.Int32
			var failNext atomic.Bool
			server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				fail := test.newerFails || failNext.Load()
				if requests.Add(1) == 1 {
					close(started)
					select {
					case <-release:
					case <-r.Context().Done():
						return
					}
					fail = test.olderFails
				}
				if fail {
					connection, _, err := w.(http.Hijacker).Hijack()
					if err == nil {
						_ = connection.Close()
					}
					return
				}
				time.Sleep(2 * time.Millisecond)
				w.WriteHeader(http.StatusNoContent)
			}))
			defer server.Close()
			proxy := adapter.NewProxy(outbound.NewDirect())
			events := make(chan bool, 4)
			adapter.UrlTestHook = func(_, _ string, _ uint16, alive bool) { events <- alive }
			ctx, cancel := context.WithTimeout(context.Background(), 3*time.Second)
			defer cancel()
			olderURL, newerURL := server.URL+"/old", server.URL+"/old"
			if test.differentURL {
				newerURL = server.URL + "/new"
			}
			older := make(chan error, 1)
			go func() { _, err := proxy.URLTest(ctx, olderURL, nil); older <- err }()
			select {
			case <-started:
			case <-ctx.Done():
				t.Fatal("older probe did not start")
			}
			newerContext, cancelNewer := context.WithCancel(ctx)
			defer cancelNewer()
			if test.cancelNewer {
				cancelNewer()
			}
			_, newerError := proxy.URLTest(newerContext, newerURL, nil)
			if test.cancelNewer {
				if !errors.Is(newerError, context.Canceled) {
					t.Fatalf("canceled probe: %v", newerError)
				}
			} else {
				if (newerError != nil) != test.newerFails {
					t.Fatalf("newer probe: %v", newerError)
				}
				if len(events) != 1 || <-events != !test.newerFails {
					t.Fatal("newer result was not published")
				}
			}
			close(release)
			if err := <-older; (err != nil) != test.olderFails {
				t.Fatalf("older probe: %v", err)
			}
			olderAccepted := test.differentURL || test.cancelNewer
			wantAlive := !test.newerFails
			if olderAccepted {
				wantAlive = !test.olderFails
			}
			if got := proxy.AliveForTestUrl(olderURL); got != wantAlive {
				t.Errorf("per-URL health = %v, want %v", got, wantAlive)
			}
			history := proxy.DelayHistoryForTestUrl(olderURL)
			if len(history) != 1 || (history[0].Delay > 0) != wantAlive {
				t.Errorf("per-URL history = %+v, want one alive=%v result", history, wantAlive)
			}
			if test.differentURL && !proxy.AliveForTestUrl(newerURL) {
				t.Error("independent URL lost its success")
			}
			globalAlive := !test.newerFails
			if test.cancelNewer {
				globalAlive = !test.olderFails
			}
			if got := proxy.AliveForTestUrl("untested"); got != globalAlive {
				t.Errorf("global fallback health = %v, want %v", got, globalAlive)
			}
			if history := proxy.DelayHistory(); len(history) != 1 {
				t.Errorf("global history includes stale completion: %+v", history)
			}
			if olderAccepted {
				if len(events) != 1 || <-events != !test.olderFails {
					t.Error("independent older result was not published")
				}
			} else if len(events) != 0 {
				t.Error("stale probe published a UI event")
			}
			failNext.Store(true)
			if _, err := proxy.URLTest(ctx, newerURL, nil); err == nil {
				t.Fatal("newer failed probe succeeded")
			}
			if proxy.AliveForTestUrl(newerURL) || len(events) != 1 || <-events {
				t.Error("a genuinely newer failure must still update health and the UI")
			}
		})
	}
}

package main

import (
	"context"
	"errors"
	"fmt"
	"net/http"
	"net/http/httptest"
	"sync"
	"sync/atomic"
	"time"

	"github.com/metacubex/mihomo/adapter"
	"github.com/metacubex/mihomo/adapter/outbound"
)

func main() {
	for _, concurrency := range []int{50, 16, 8} {
		slots := make(chan struct{}, 8)
		server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			select {
			case slots <- struct{}{}:
				defer func() { <-slots }()
			case <-r.Context().Done():
				return
			}
			select {
			case <-time.After(150 * time.Millisecond):
				w.WriteHeader(http.StatusNoContent)
			case <-r.Context().Done():
				return
			}
		}))
		adapter.UnifiedDelay.Store(false)
		var next, successes, failures, deadlines atomic.Int32
		var workers sync.WaitGroup
		started := time.Now()
		for range concurrency {
			workers.Go(func() {
				for next.Add(1) <= 50 {
					proxy := adapter.NewProxy(outbound.NewDirect())
					ctx, cancel := context.WithTimeout(context.Background(), 400*time.Millisecond)
					_, err := proxy.URLTest(ctx, server.URL, nil)
					if err == nil {
						successes.Add(1)
					} else {
						failures.Add(1)
						if errors.Is(err, context.DeadlineExceeded) {
							deadlines.Add(1)
						}
					}
					cancel()
				}
			})
		}
		workers.Wait()
		server.Close()
		fmt.Printf("concurrency=%d targets=50 success=%d failure=%d deadline=%d duration=%s\n", concurrency, successes.Load(), failures.Load(), deadlines.Load(), time.Since(started).Round(time.Millisecond))
	}
}

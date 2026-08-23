package main

import (
	"testing"
	"time"

	"github.com/metacubex/mihomo/adapter"
	"github.com/metacubex/mihomo/adapter/outbound"
	"github.com/metacubex/mihomo/constant"
	"github.com/metacubex/mihomo/tunnel"
)

func TestPatchSelectGroupPublishesAppliedProxySnapshot(t *testing.T) {
	previousProxies := tunnel.Proxies()
	previousProviders := tunnel.Providers()
	selectionLock.Lock()
	previousSnapshot := proxySnapshot
	selectionLock.Unlock()
	t.Cleanup(func() {
		tunnel.UpdateProxies(previousProxies, previousProviders)
		publishProxySnapshot(previousSnapshot)
	})

	oldProxy := adapter.NewProxy(outbound.NewDirect())
	newProxy := adapter.NewProxy(outbound.NewDirect())
	publishProxySnapshot(map[string]constant.Proxy{"DIRECT": oldProxy})
	tunnel.UpdateProxies(
		map[string]constant.Proxy{"DIRECT": newProxy},
		nil,
	)

	patchSelectGroup(nil)

	selectionLock.Lock()
	got := proxySnapshot["DIRECT"]
	selectionLock.Unlock()
	if got != newProxy {
		t.Fatalf("proxy snapshot = %p, want applied proxy %p", got, newProxy)
	}
}

func TestHandleChangeProxyDoesNotWaitForConfigApply(t *testing.T) {
	runLock.Lock()
	defer runLock.Unlock()

	groupName := "missing"
	proxyName := "node"
	answered := make(chan string, 1)
	go func() {
		answered <- handleChangeProxy(
			&ChangeProxyParams{GroupName: &groupName, ProxyName: &proxyName},
		)
	}()

	select {
	case message := <-answered:
		if message != "Not found group" {
			t.Fatalf("message = %q, want missing group error", message)
		}
	case <-time.After(time.Second):
		t.Fatal("proxy selection waited for the whole config apply")
	}
}

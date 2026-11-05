package main

import (
	"context"
	"errors"
	"net"
	"net/netip"
	"strings"
	"sync"
	"sync/atomic"
	"time"

	"github.com/metacubex/mihomo/component/resolver"
	"github.com/metacubex/mihomo/listener"
	"github.com/metacubex/mihomo/tunnel"
)

var networkDiagnosticBusy atomic.Bool

// DNS names, returned addresses, signed queries and upstream errors stay inside
// the Core. Only fixed result codes and counts cross the diagnostic RPC.
type diagnosticDNS struct {
	Status    string `json:"status"`
	Checked   int    `json:"checked"`
	Succeeded int    `json:"succeeded"`
}

type diagnosticLookup func(context.Context, string) ([]netip.Addr, error)

func probeDiagnosticDNS(ctx context.Context, names []string, lookup diagnosticLookup) diagnosticDNS {
	if lookup == nil {
		return diagnosticDNS{Status: "unavailable"}
	}
	if len(names) == 0 {
		return diagnosticDNS{Status: "not_applicable"}
	}
	result := diagnosticDNS{Status: "ok", Checked: len(names)}
	statuses := make([]string, len(names))
	var wg sync.WaitGroup
	for i, name := range names {
		wg.Add(1)
		go func(i int, name string) {
			defer wg.Done()
			ips, err := lookup(ctx, name)
			statuses[i] = diagnosticDNSError(ips, err)
		}(i, name)
	}
	wg.Wait()
	for _, status := range statuses {
		if status == "ok" {
			result.Succeeded++
		} else {
			result.Status = status
		}
	}
	if result.Succeeded == len(names) {
		result.Status = "ok"
	} else if result.Succeeded > 0 {
		result.Status = "partial"
	}
	return result
}

func diagnosticDNSError(ips []netip.Addr, err error) string {
	if err == nil {
		if len(ips) > 0 {
			return "ok"
		}
		return "no_answer"
	}
	var networkError net.Error
	if errors.Is(err, context.DeadlineExceeded) || (errors.As(err, &networkError) && networkError.Timeout()) {
		return "timeout"
	}
	message := strings.ToLower(err.Error())
	switch {
	case strings.Contains(message, "certificate"), strings.Contains(message, "x509"):
		return "certificate"
	case strings.Contains(message, "no such host"), strings.Contains(message, "nxdomain"):
		return "no_answer"
	case strings.Contains(message, "refused"):
		return "refused"
	default:
		return "failed"
	}
}

func diagnosticManagedHost(address string, suffixes []string) string {
	host, _, err := net.SplitHostPort(address)
	if err != nil {
		return ""
	}
	host = strings.ToLower(strings.TrimSuffix(host, "."))
	if _, err := netip.ParseAddr(host); err == nil {
		return ""
	}
	for _, suffix := range suffixes {
		if host == suffix || strings.HasSuffix(host, "."+suffix) {
			return host
		}
	}
	return ""
}

func handleNetworkDiagnostics() map[string]any {
	if !networkDiagnosticBusy.CompareAndSwap(false, true) {
		return map[string]any{"busy": true}
	}
	defer networkDiagnosticBusy.Store(false)
	runLock.Lock()
	configSnapshot := currentConfig
	running := isRunning && !networkExcluded
	tunConfig := listener.GetTunConf()
	result := map[string]any{
		"configured": configSnapshot != nil, "running": running,
		"mixedPort": listener.GetPorts().MixedPort,
		"tunDevice": tunConfig.Device, "tunInterfaceUp": false,
	}
	if device, err := net.InterfaceByName(tunConfig.Device); err == nil {
		result["tunInterfaceUp"] = running && tunConfig.Enable && device.Flags&net.FlagUp != 0
	}
	defaultResolver := resolver.DefaultResolver
	proxyResolver := resolver.ProxyServerHostResolver
	auth := currentDNSAuth()
	_, wrapped := proxyResolver.(*tokenInjectResolver)
	result["dnsAuthReady"] = auth != nil && wrapped
	suffixes := dnsAuthSuffixes()
	if auth != nil {
		suffixes = auth.suffixes
	}
	// Bound both the sample and the scan. Provider nodes may not be in the static
	// proxy map, so include the currently loaded provider snapshots as well.
	names := make([]string, 0, 3)
	seen := map[string]bool{}
	scanned := 0
	add := func(address string) {
		if len(names) >= 3 || scanned >= 4096 {
			return
		}
		scanned++
		if host := diagnosticManagedHost(address, suffixes); host != "" && !seen[host] {
			names = append(names, host)
			seen[host] = true
		}
	}
	selectionLock.Lock()
	for _, proxy := range proxySnapshot {
		if len(names) >= 3 || scanned >= 4096 {
			break
		}
		add(proxy.Addr())
	}
	selectionLock.Unlock()
	for _, provider := range tunnel.ProvidersSnapshot() {
		if len(names) >= 3 || scanned >= 4096 {
			break
		}
		for _, proxy := range provider.Proxies() {
			if len(names) >= 3 || scanned >= 4096 {
				break
			}
			add(proxy.Addr())
		}
	}
	runLock.Unlock()
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	var general, managed diagnosticDNS
	var wg sync.WaitGroup
	wg.Add(1)
	go func() {
		defer wg.Done()
		var lookup diagnosticLookup
		if defaultResolver != nil {
			lookup = defaultResolver.LookupIP
		}
		general = probeDiagnosticDNS(ctx, []string{"www.cloudflare.com", "www.gstatic.com"}, lookup)
	}()
	if len(names) == 0 {
		managed = diagnosticDNS{Status: "not_applicable"}
	} else if auth == nil || !wrapped {
		managed = diagnosticDNS{Status: "auth_unavailable"}
	} else {
		managed = probeDiagnosticDNS(ctx, names, proxyResolver.LookupIP)
	}
	wg.Wait()
	result["dns"] = general
	result["oixDns"] = managed
	runLock.Lock()
	result["stale"] = currentConfig != configSnapshot || running != (isRunning && !networkExcluded) || currentDNSAuth() != auth
	runLock.Unlock()
	return result
}

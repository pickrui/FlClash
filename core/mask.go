package main

import (
	"net"
	"net/netip"
	"strings"
	"sync"
	"sync/atomic"

	"github.com/metacubex/mihomo/hub/route"
	"github.com/metacubex/mihomo/log"
	"github.com/metacubex/mihomo/tunnel/statistic"
)

var (
	cloudIPs           sync.Map
	cloudOutputDomains atomic.Pointer[[]string]
)

func init() {
	statistic.TrackerInfoFilter = func(info *statistic.TrackerInfo) bool {
		return !shouldSuppressCloudTracker(info)
	}
	route.DNSQueryObfuscated = matchManagedSuffix
	log.EventFilter = func(event log.Event) bool {
		return !shouldSuppressCloudOutput(event.Payload)
	}
}

func setCloudOutputDomains(domains []string) {
	normalized := make([]string, 0, len(domains))
	for _, domain := range domains {
		domain = strings.TrimSuffix(strings.ToLower(strings.TrimSpace(domain)), ".")
		if domain != "" {
			normalized = append(normalized, domain)
		}
	}
	cloudOutputDomains.Store(&normalized)
}

func isCloudHost(host string) bool {
	if parsed, _, err := net.SplitHostPort(host); err == nil {
		host = parsed
	}
	host = strings.TrimSuffix(strings.Trim(host, "[]"), ".")
	if matchManagedSuffix(host) || isCloudIP(host) {
		return true
	}
	if domains := cloudOutputDomains.Load(); domains != nil {
		for _, domain := range *domains {
			if host == domain || strings.HasSuffix(host, "."+domain) {
				return true
			}
		}
	}
	for _, domain := range dnsAuthSuffixes() {
		if host == domain || strings.HasSuffix(host, "."+domain) {
			return true
		}
	}
	return false
}

func shouldSuppressCloudOutput(value string) bool {
	value = strings.ToLower(value)
	if strings.Contains(value, "oixcloud") || strings.Contains(value, "[dns-auth]") || strings.Contains(value, "cloudapi") {
		return true
	}
	for _, host := range strings.FieldsFunc(value, func(char rune) bool {
		return !(char >= 'a' && char <= 'z' || char >= '0' && char <= '9' || strings.ContainsRune(".-:[]", char))
	}) {
		host = strings.Trim(host, ".")
		if isCloudHost(host) {
			return true
		}
		if trimmed, ok := strings.CutSuffix(host, ":"); ok && isCloudHost(trimmed) {
			return true
		}
	}
	return false
}

func shouldSuppressCloudTracker(info *statistic.TrackerInfo) bool {
	if info == nil {
		return false
	}
	if metadata := info.Metadata; metadata != nil {
		if shouldSuppressCloudOutput(metadata.Host) || shouldSuppressCloudOutput(metadata.SniffHost) {
			if metadata.DstIP.IsValid() {
				markCloudIP(metadata.DstIP.String())
			}
			return true
		}
		if shouldSuppressCloudOutput(metadata.RemoteDst) || isCloudIP(metadata.DstIP.String()) {
			return true
		}
		for _, value := range []string{metadata.SpecialRules, metadata.SpecialProxy, metadata.Process, metadata.ProcessPath} {
			if shouldSuppressCloudOutput(value) {
				return true
			}
		}
	}
	for _, value := range append(append([]string{info.Rule, info.RulePayload}, info.Chain...), info.ProviderChain...) {
		if shouldSuppressCloudOutput(value) {
			return true
		}
	}
	return false
}

func resetCloudIPs() {
	cloudIPs.Clear()
}

func markCloudIP(ip string) {
	if parsed, err := netip.ParseAddr(ip); err == nil {
		cloudIPs.Store(parsed.Unmap().String(), true)
	}
}

func markCloudIPs(ips []netip.Addr) {
	for _, ip := range ips {
		markCloudIP(ip.String())
	}
}

func isCloudIP(host string) bool {
	if h, _, err := net.SplitHostPort(host); err == nil {
		host = h
	}
	ip, err := netip.ParseAddr(host)
	if err != nil {
		return false
	}
	_, ok := cloudIPs.Load(ip.Unmap().String())
	return ok
}

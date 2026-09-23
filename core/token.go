package main

import (
	"context"
	"crypto/ed25519"
	"encoding/base32"
	"encoding/base64"
	"net"
	"net/netip"
	"strconv"
	"strings"
	"sync"
	"sync/atomic"
	"time"

	"github.com/metacubex/mihomo/component/resolver"
	"github.com/metacubex/mihomo/log"
)

type dnsAuthSettings struct {
	privKey  ed25519.PrivateKey
	window   int64
	suffixes []string
}

const dnsAuthWindowSeconds = 300

var (
	dnsAuthLock    sync.RWMutex
	dnsAuthCurrent *dnsAuthSettings
)

func setDNSAuth(s *dnsAuthSettings) {
	dnsAuthLock.Lock()
	dnsAuthCurrent = s
	dnsAuthLock.Unlock()
}

func currentDNSAuth() *dnsAuthSettings {
	dnsAuthLock.RLock()
	defer dnsAuthLock.RUnlock()
	return dnsAuthCurrent
}

type dnsAuthSuffixList struct {
	source   string
	suffixes []string
}

var dnsAuthSuffixCache atomic.Pointer[dnsAuthSuffixList]

// The log filters call this per token, so the parsed slice is cached and shared; callers must not modify it.
func dnsAuthSuffixes() []string {
	source := GlobalDNSAuthDomains
	if cached := dnsAuthSuffixCache.Load(); cached != nil && cached.source == source {
		return cached.suffixes
	}
	suffixes := parseDNSAuthSuffixes(source)
	dnsAuthSuffixCache.Store(&dnsAuthSuffixList{source: source, suffixes: suffixes})
	return suffixes
}

func parseDNSAuthSuffixes(domains string) []string {
	if domains == "" {
		return nil
	}
	seen := make(map[string]struct{})
	suffixes := make([]string, 0)
	for _, d := range strings.Split(domains, ",") {
		s := strings.ToLower(strings.TrimSpace(d))
		s = strings.TrimPrefix(s, "*.")
		s = strings.TrimSuffix(s, ".")
		if s == "" || strings.Contains(s, "*") {
			continue
		}
		if _, ok := seen[s]; ok {
			continue
		}
		seen[s] = struct{}{}
		suffixes = append(suffixes, s)
	}
	return suffixes
}

func applyDNSAuth() {
	suffixes := dnsAuthSuffixes()
	if len(suffixes) == 0 {
		setDNSAuth(nil)
		return
	}
	if GlobalDNSAuthPrivateKey != "" {
		seed, err := base64.StdEncoding.DecodeString(strings.TrimSpace(GlobalDNSAuthPrivateKey))
		if err == nil && len(seed) == ed25519.SeedSize {
			setDNSAuth(&dnsAuthSettings{privKey: ed25519.NewKeyFromSeed(seed), window: dnsAuthWindowSeconds, suffixes: suffixes})
			log.Infoln("[DNS-Auth] enabled (ed25519) for %d managed suffix(es)", len(suffixes))
			return
		}
		log.Warnln("[DNS-Auth] invalid private key")
	}
	setDNSAuth(nil)
}

var dnsAuthEncoding = base32.StdEncoding.WithPadding(base32.NoPadding)

func dnsAuthMessage(basename string, window int64) []byte {
	b := make([]byte, 0, len(basename)+1+20)
	b = append(b, basename...)
	b = append(b, '|')
	b = strconv.AppendInt(b, window, 10)
	return b
}

func (s *dnsAuthSettings) matchSuffix(name string) (string, bool) {
	for _, suf := range s.suffixes {
		if name == suf || strings.HasSuffix(name, "."+suf) {
			return suf, true
		}
	}
	return "", false
}

func tokenizeHost(host string) string {
	s := currentDNSAuth()
	if s == nil || host == "" {
		return host
	}
	name := strings.ToLower(strings.TrimSuffix(host, "."))
	if _, ok := s.matchSuffix(name); !ok {
		return host
	}
	if s.privKey == nil {
		return host
	}
	window := time.Now().Unix() / s.window
	sig := ed25519.Sign(s.privKey, dnsAuthMessage(name, window))
	half := ed25519.SignatureSize / 2
	p1 := strings.ToLower(dnsAuthEncoding.EncodeToString(sig[:half]))
	p2 := strings.ToLower(dnsAuthEncoding.EncodeToString(sig[half:]))
	return p1 + "." + p2 + "." + name
}

func matchManagedSuffix(host string) bool {
	_, ok := maskManagedDomain(host)
	return ok
}

func maskManagedDomain(host string) (string, bool) {
	s := currentDNSAuth()
	if s == nil || host == "" {
		return host, false
	}
	name := strings.ToLower(strings.TrimSuffix(host, "."))
	port := ""
	if h, p, err := net.SplitHostPort(name); err == nil {
		name, port = h, p
	}
	suf, ok := s.matchSuffix(name)
	if !ok {
		return host, false
	}
	masked := "***." + suf
	if port != "" {
		masked += ":" + port
	}
	return masked, true
}

type tokenInjectResolver struct {
	resolver.Resolver
}

// managedLookup rewrites managed-suffix hosts with the DNS-Auth token and marks
// the resolved IPs as cloud nodes. Result caching is delegated to the wrapped
// resolver, which caches by the signed name and honors each record's real DNS
// TTL (so rotating node IPs stay fresh); other hosts pass straight through.
func (t *tokenInjectResolver) managedLookup(ctx context.Context, host string, lookup func(context.Context, string) ([]netip.Addr, error)) ([]netip.Addr, error) {
	ips, err := lookup(ctx, tokenizeHost(host))
	if err == nil && matchManagedSuffix(host) {
		markCloudIPs(ips)
	}
	return ips, err
}

func (t *tokenInjectResolver) LookupIP(ctx context.Context, host string) ([]netip.Addr, error) {
	return t.managedLookup(ctx, host, t.Resolver.LookupIP)
}

func (t *tokenInjectResolver) LookupIPv4(ctx context.Context, host string) ([]netip.Addr, error) {
	return t.managedLookup(ctx, host, t.Resolver.LookupIPv4)
}

func (t *tokenInjectResolver) LookupIPv6(ctx context.Context, host string) ([]netip.Addr, error) {
	return t.managedLookup(ctx, host, t.Resolver.LookupIPv6)
}

func (t *tokenInjectResolver) ResolveECH(ctx context.Context, host string) ([]byte, error) {
	return t.Resolver.ResolveECH(ctx, tokenizeHost(host))
}

func installDNSAuthResolver() {
	if currentDNSAuth() == nil {
		return
	}
	inner := resolver.ProxyServerHostResolver
	if inner == nil {
		return
	}
	if _, ok := inner.(*tokenInjectResolver); ok {
		return
	}
	resolver.ProxyServerHostResolver = &tokenInjectResolver{Resolver: inner}
}

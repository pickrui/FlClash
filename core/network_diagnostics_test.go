package main

import (
	"context"
	"crypto/ed25519"
	"encoding/json"
	"errors"
	"net"
	"net/netip"
	"strings"
	"testing"
	"time"

	"github.com/metacubex/mihomo/component/resolver"
)

func TestNetworkDiagnosticManagedHost(t *testing.T) {
	cases := map[string]string{
		"Node.Managed.Example.:443": "node.managed.example",
		"managed.example:80":        "managed.example",
		"notmanaged.example:443":    "", "node.managed.example.evil:443": "",
		"192.0.2.1:443": "", "[2001:db8::1]:443": "", "invalid": "",
	}
	for address, want := range cases {
		if got := diagnosticManagedHost(address, []string{"managed.example"}); got != want {
			t.Errorf("host = %q, want %q", got, want)
		}
	}
}

func TestNetworkDiagnosticDNSPartialAndRedaction(t *testing.T) {
	result := probeDiagnosticDNS(context.Background(), []string{"one.secret.example", "two.secret.example"},
		func(_ context.Context, name string) ([]netip.Addr, error) {
			if strings.HasPrefix(name, "one") {
				return []netip.Addr{netip.MustParseAddr("192.0.2.1")}, nil
			}
			return nil, errors.New("secret-token upstream https://private.example?key=secret-key")
		})
	if result.Status != "partial" || result.Checked != 2 || result.Succeeded != 1 {
		t.Fatalf("unexpected summary: %+v", result)
	}
	data, _ := json.Marshal(result)
	for _, secret := range []string{"secret", "192.0.2.1", "private.example"} {
		if strings.Contains(string(data), secret) {
			t.Fatal("diagnostic response leaked a transport detail")
		}
	}
}

func TestNetworkDiagnosticDNSDeadline(t *testing.T) {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Millisecond)
	defer cancel()
	result := probeDiagnosticDNS(ctx, []string{"sample"}, func(ctx context.Context, _ string) ([]netip.Addr, error) {
		<-ctx.Done()
		return nil, ctx.Err()
	})
	if result.Status != "timeout" {
		t.Fatalf("status = %s", result.Status)
	}
}

func TestNetworkDiagnosticDNSCodes(t *testing.T) {
	for _, tc := range []struct {
		err  error
		want string
	}{
		{nil, "no_answer"}, {errors.New("x509: private hostname"), "certificate"},
		{&net.DNSError{Err: "no such host", Name: "secret"}, "no_answer"},
		{errors.New("upstream REFUSED secret"), "refused"},
		{errors.New("opaque secret"), "failed"},
	} {
		if got := diagnosticDNSError(nil, tc.err); got != tc.want {
			t.Errorf("got %s want %s", got, tc.want)
		}
	}
}

type diagnosticResolverStub struct {
	resolver.Resolver
	queried string
}

func (s *diagnosticResolverStub) LookupIP(_ context.Context, name string) ([]netip.Addr, error) {
	s.queried = name
	return nil, &net.DNSError{Err: "no such host", Name: name}
}
func TestNetworkDiagnosticUsesSignedResolver(t *testing.T) {
	previous := currentDNSAuth()
	defer setDNSAuth(previous)
	setDNSAuth(&dnsAuthSettings{privKey: ed25519.NewKeyFromSeed(make([]byte, ed25519.SeedSize)), window: dnsAuthWindowSeconds, suffixes: []string{"managed.example"}})
	inner := &diagnosticResolverStub{}
	wrapped := &tokenInjectResolver{Resolver: inner}
	result := probeDiagnosticDNS(context.Background(), []string{"node.managed.example"}, wrapped.LookupIP)
	if inner.queried == "node.managed.example" || !strings.HasSuffix(inner.queried, ".node.managed.example") {
		t.Fatal("managed diagnosis bypassed DNS signing")
	}
	if result.Status != "no_answer" {
		t.Fatalf("status = %s", result.Status)
	}
	encoded, _ := json.Marshal(result)
	if strings.Contains(string(encoded), inner.queried) {
		t.Fatal("signed query escaped the Core")
	}
}

func TestNetworkDiagnosticUnavailableAndEmptyAreNotSuccess(t *testing.T) {
	if got := probeDiagnosticDNS(context.Background(), []string{"sample"}, nil); got.Status != "unavailable" {
		t.Fatalf("%+v", got)
	}
	if got := probeDiagnosticDNS(context.Background(), nil, func(context.Context, string) ([]netip.Addr, error) { t.Fatal("unexpected query"); return nil, nil }); got.Status != "not_applicable" {
		t.Fatalf("%+v", got)
	}
}

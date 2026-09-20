package tun

import (
	"net/netip"
	"reflect"
	"testing"

	"github.com/metacubex/mihomo/constant"
)

func TestParseOptionsPreservesDualStackConfiguration(t *testing.T) {
	options, err := parseOptions(42, "Mixed", "172.19.0.1/30, fdfe:dcba:9876::1/126", "172.19.0.2, fdfe:dcba:9876::2", 9000)
	if err != nil {
		t.Fatal(err)
	}
	if options.FileDescriptor != 42 || options.Stack != constant.TunMixed || options.AutoRoute || options.AutoDetectInterface {
		t.Fatalf("invalid descriptor, stack or routing policy: %+v", options)
	}
	if !reflect.DeepEqual(options.Inet4Address, []netip.Prefix{netip.MustParsePrefix("172.19.0.1/30")}) ||
		!reflect.DeepEqual(options.Inet6Address, []netip.Prefix{netip.MustParsePrefix("fdfe:dcba:9876::1/126")}) {
		t.Fatalf("incorrect interface addresses: %v / %v", options.Inet4Address, options.Inet6Address)
	}
	if !reflect.DeepEqual(options.DNSHijack, []string{"172.19.0.2:53", "[fdfe:dcba:9876::2]:53"}) {
		t.Fatalf("incorrect DNS interception addresses: %v", options.DNSHijack)
	}
}

func TestParseOptionsRejectsInvalidInputBeforeAdoptingDescriptor(t *testing.T) {
	for _, test := range []struct {
		name, address, dns string
	}{
		{name: "address", address: "172.19.0.1/99", dns: "172.19.0.2"},
		{name: "DNS hostname", address: "172.19.0.1/30", dns: "invalid.example"},
		{name: "DNS port", address: "172.19.0.1/30", dns: "172.19.0.2:53"},
	} {
		t.Run(test.name, func(t *testing.T) {
			if _, err := parseOptions(42, "system", test.address, test.dns, 9000); err == nil {
				t.Fatal("invalid TUN configuration was accepted")
			}
		})
	}
}

func TestParseOptionsKeepsConfiguredMtuAlignedWithVpn(t *testing.T) {
	for _, mtu := range []int{1280, 1480, 4064, 9000, 65535, 0, -1, 1279, 65536} {
		options, err := parseOptions(42, "mixed", "172.19.0.1/30", "172.19.0.2", mtu)
		if err != nil {
			t.Fatal(err)
		}
		want := mtu
		if mtu < 1280 || mtu > 65535 {
			want = 9000
		}
		if options.MTU != uint32(want) {
			t.Fatalf("MTU %d became %d, want %d", mtu, options.MTU, want)
		}
	}
}

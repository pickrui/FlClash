package tun

import (
	"fmt"
	"net/netip"
	"strings"

	"github.com/metacubex/mihomo/constant"
	LC "github.com/metacubex/mihomo/listener/config"
)

func parseOptions(fd int, stack, address, dns string) (LC.Tun, error) {
	var prefix4 []netip.Prefix
	var prefix6 []netip.Prefix
	tunStack, ok := constant.StackTypeMapping[strings.ToLower(stack)]
	if !ok {
		tunStack = constant.TunSystem
	}
	for _, a := range strings.Split(address, ",") {
		a = strings.TrimSpace(a)
		if len(a) == 0 {
			continue
		}
		prefix, err := netip.ParsePrefix(a)
		if err != nil {
			return LC.Tun{}, fmt.Errorf("invalid TUN address: %w", err)
		}
		if prefix.Addr().Is4() {
			prefix4 = append(prefix4, prefix)
		} else {
			prefix6 = append(prefix6, prefix)
		}
	}

	var dnsHijack []string
	for _, d := range strings.Split(dns, ",") {
		d = strings.TrimSpace(d)
		if len(d) == 0 {
			continue
		}
		addr, err := netip.ParseAddr(d)
		if err != nil {
			return LC.Tun{}, fmt.Errorf("invalid TUN DNS address: %w", err)
		}
		dnsHijack = append(dnsHijack, netip.AddrPortFrom(addr, 53).String())
	}

	return LC.Tun{
		Enable:              true,
		Device:              "FlClash",
		Stack:               tunStack,
		DNSHijack:           dnsHijack,
		AutoRoute:           false,
		AutoDetectInterface: false,
		Inet4Address:        prefix4,
		Inet6Address:        prefix6,
		MTU:                 9000,
		FileDescriptor:      fd,
	}, nil
}

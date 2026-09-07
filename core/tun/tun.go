//go:build android && cgo

package tun

import (
	"syscall"

	"github.com/metacubex/mihomo/listener/sing_tun"
	"github.com/metacubex/mihomo/log"
	"github.com/metacubex/mihomo/tunnel"
)

// Start takes ownership of fd, including when the supplied options are invalid.
func Start(fd int, stack, address, dns string) *sing_tun.Listener {
	options, err := parseOptions(fd, stack, address, dns)
	if err != nil {
		_ = syscall.Close(fd)
		log.Errorln("TUN: %v", err)
		return nil
	}
	// All options that can fail before adopting the descriptor were validated
	// above. With automatic routing disabled, sing_tun owns fd from this point
	// and closes it both on initialization failure and when the listener stops.
	listener, err := sing_tun.New(options, tunnel.Tunnel)
	if err != nil {
		log.Errorln("TUN: %v", err)
		return nil
	}
	return listener
}

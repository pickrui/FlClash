package main

import (
	"errors"
	"sync"
	"syscall"
)

var (
	errTunNotReady    = errors.New("blocked: TUN callbacks are not ready")
	errProtectRefused = errors.New("blocked: VpnService.protect refused the socket")
)

// A JNI callback can be released only after its in-flight calls have finished.
// Readiness stays false while the TUN listener is being created, so a socket
// opened during setup fails immediately instead of reentering the setup lock.
type tunCallbackLease struct {
	mu      sync.RWMutex
	ready   bool
	closed  bool
	release func()
}

func (lease *tunCallbackLease) activate() {
	lease.mu.Lock()
	defer lease.mu.Unlock()
	if !lease.closed {
		lease.ready = true
	}
}

func (lease *tunCallbackLease) use(call func()) bool {
	lease.mu.RLock()
	defer lease.mu.RUnlock()
	if !lease.ready {
		return false
	}
	call()
	return true
}

func (lease *tunCallbackLease) protect(fd int, call func(int) bool) error {
	accepted := false
	if !lease.use(func() { accepted = call(fd) }) {
		return errTunNotReady
	}
	if !accepted {
		return errProtectRefused
	}
	return nil
}

func (lease *tunCallbackLease) close() {
	lease.mu.Lock()
	defer lease.mu.Unlock()
	if lease.closed {
		return
	}
	lease.ready = false
	lease.closed = true
	if lease.release != nil {
		lease.release()
	}
}

func protectSocket(conn syscall.RawConn, protect func(int) error) error {
	var protectErr error
	if err := conn.Control(func(fd uintptr) { protectErr = protect(int(fd)) }); err != nil {
		return err
	}
	return protectErr
}

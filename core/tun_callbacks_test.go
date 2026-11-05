package main

import (
	"errors"
	"net"
	"sync"
	"sync/atomic"
	"syscall"
	"testing"
)

type protectionRawConn struct {
	fd  uintptr
	err error
}

func (c protectionRawConn) Control(fn func(uintptr)) error {
	if c.err != nil {
		return c.err
	}
	fn(c.fd)
	return nil
}
func (protectionRawConn) Read(func(uintptr) bool) error  { panic("unexpected read") }
func (protectionRawConn) Write(func(uintptr) bool) error { panic("unexpected write") }

func TestSocketProtectionRejectsRefusedAndUnreadyCallbacks(t *testing.T) {
	lease := &tunCallbackLease{}
	calls := 0
	accepted := false
	protect := func(fd int) bool {
		if fd != 42 {
			t.Fatalf("fd = %d", fd)
		}
		calls++
		return accepted
	}
	run := func() error {
		return protectSocket(protectionRawConn{fd: 42}, func(fd int) error { return lease.protect(fd, protect) })
	}
	if err := run(); !errors.Is(err, errTunNotReady) || calls != 0 {
		t.Fatalf("unready: %v, calls %d", err, calls)
	}
	lease.activate()
	if err := run(); !errors.Is(err, errProtectRefused) {
		t.Fatalf("refusal lost: %v", err)
	}
	accepted = true
	if err := run(); err != nil {
		t.Fatal(err)
	}
	lease.close()
	lease.activate()
	if err := run(); !errors.Is(err, errTunNotReady) || calls != 2 {
		t.Fatalf("closed: %v, calls %d", err, calls)
	}
}

func TestSocketProtectionPreservesControlError(t *testing.T) {
	failure := errors.New("descriptor closed")
	err := protectSocket(protectionRawConn{err: failure}, func(int) error { t.Fatal("callback on invalid fd"); return nil })
	if !errors.Is(err, failure) {
		t.Fatalf("control error lost: %v", err)
	}
}

func TestTunCallbackReleaseWaitsForInflightCallAndRunsOnce(t *testing.T) {
	entered, finishCall := make(chan struct{}), make(chan struct{})
	var released atomic.Int32
	lease := &tunCallbackLease{release: func() { released.Add(1) }}
	lease.activate()
	callDone := make(chan error, 1)
	go func() {
		callDone <- lease.protect(42, func(int) bool { close(entered); <-finishCall; return released.Load() == 0 })
	}()
	<-entered
	var closers sync.WaitGroup
	for i := 0; i < 10; i++ {
		closers.Add(1)
		go func() { defer closers.Done(); lease.close() }()
	}
	if released.Load() != 0 {
		t.Fatal("released an in-flight callback")
	}
	close(finishCall)
	if err := <-callDone; err != nil {
		t.Fatal(err)
	}
	closers.Wait()
	if released.Load() != 1 {
		t.Fatalf("release count %d", released.Load())
	}
	if lease.use(func() { t.Fatal("used released JNI reference") }) {
		t.Fatal("closed lease accepted a call")
	}
}

// Exercise RawConn.Control through the real TCP/UDP dial path. Refusal must
// abort before connect/send, for both address families.
func TestDialRejectsUnprotectedSockets(t *testing.T) {
	for _, network := range []string{"tcp4", "tcp6", "udp4", "udp6"} {
		t.Run(network, func(t *testing.T) {
			calls := 0
			dialer := net.Dialer{Control: func(_, _ string, conn syscall.RawConn) error {
				return protectSocket(conn, func(fd int) error {
					if fd < 0 {
						t.Fatalf("invalid fd %d", fd)
					}
					calls++
					return errProtectRefused
				})
			}}
			address := "127.0.0.1:9"
			if network[len(network)-1] == '6' {
				address = "[::1]:9"
			}
			conn, err := dialer.Dial(network, address)
			if conn != nil {
				conn.Close()
				t.Fatal("unprotected socket escaped")
			}
			if !errors.Is(err, errProtectRefused) || calls != 1 {
				t.Fatalf("error %v, protection calls %d", err, calls)
			}
		})
	}
}

//go:build !cgo

package main

import (
	"bytes"
	"encoding/binary"
	"io"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
	"sync/atomic"
	"syscall"
	"testing"
	"time"
)

const (
	exitHelperEnv = "FLCLASH_EXIT_HELPER"
	exitMarkerEnv = "FLCLASH_EXIT_MARKER"
	exitReadyEnv  = "FLCLASH_EXIT_READY"
)

func stubExitCleanup(t *testing.T, cleanup func()) *bool {
	t.Helper()
	called := false
	previousGuard := exitGuard
	exitGuard = &exitCleanupGuard{done: make(chan struct{})}
	previous := exitCleanup
	exitCleanup = func() {
		called = true
		cleanup()
	}
	t.Cleanup(func() { exitCleanup = previous; exitGuard = previousGuard })
	return &called
}

func TestReleaseOnExitSkipsCleanupBeforeInit(t *testing.T) {
	previousIsInit := isInit.Load()
	isInit.Store(false)
	t.Cleanup(func() { isInit.Store(previousIsInit) })

	called := stubExitCleanup(t, func() {})

	releaseOnExit()

	if *called {
		t.Fatal("cleanup ran although the core was never initialized")
	}
}

func TestReleaseOnExitRunsCleanupOnce(t *testing.T) {
	previousIsInit := isInit.Load()
	isInit.Store(true)
	t.Cleanup(func() { isInit.Store(previousIsInit) })

	calls := make(chan struct{}, 2)
	stubExitCleanup(t, func() { calls <- struct{}{} })

	releaseOnExit()
	releaseOnExit()

	select {
	case <-calls:
	default:
		t.Fatal("cleanup did not run")
	}
	select {
	case <-calls:
		t.Fatal("cleanup ran more than once")
	default:
	}
}

func TestReleaseOnExitStopsWaitingForAStalledCleanup(t *testing.T) {
	previousIsInit := isInit.Load()
	isInit.Store(true)
	previousTimeout := exitCleanupTimeout
	exitCleanupTimeout = 20 * time.Millisecond
	t.Cleanup(func() {
		isInit.Store(previousIsInit)
		exitCleanupTimeout = previousTimeout
	})

	release := make(chan struct{})
	stubExitCleanup(t, func() { <-release })
	done := exitGuard.done
	t.Cleanup(func() { close(release); <-done })

	returned := make(chan struct{})
	go func() {
		defer close(returned)
		releaseOnExit()
	}()

	select {
	case <-returned:
	case <-time.After(5 * time.Second):
		t.Fatal("releaseOnExit() waited for a cleanup that never finished")
	}
}

func TestHandleTerminationCleansUpAndExits(t *testing.T) {
	previousIsInit := isInit.Load()
	isInit.Store(true)
	previousExit := exitProcess
	t.Cleanup(func() {
		isInit.Store(previousIsInit)
		exitProcess = previousExit
	})

	codes := make(chan int, 1)
	exitProcess = func(code int) { codes <- code }
	called := stubExitCleanup(t, func() {})

	signals := make(chan os.Signal, 1)
	signals <- syscall.SIGTERM

	handleTermination(signals)

	if !*called {
		t.Fatal("cleanup did not run before exit")
	}
	select {
	case code := <-codes:
		if code != 0 {
			t.Fatalf("exit code = %d, want 0", code)
		}
	default:
		t.Fatal("the process was never asked to exit")
	}
}

// The point of the fix is that SIGTERM no longer takes the default
// disposition, which only a real signal to a real process can show.
func TestExitOnTerminationRunsCleanupOnSigterm(t *testing.T) {
	if runtime.GOOS == "windows" {
		t.Skip("SIGTERM is not delivered on Windows")
	}

	directory := t.TempDir()
	marker := filepath.Join(directory, "cleanup")
	ready := filepath.Join(directory, "ready")

	command := exec.Command(
		os.Args[0],
		"-test.run=TestExitOnTerminationHelperProcess",
	)
	command.Env = append(
		os.Environ(),
		exitHelperEnv+"=1",
		exitMarkerEnv+"="+marker,
		exitReadyEnv+"="+ready,
	)
	if err := command.Start(); err != nil {
		t.Fatalf("start helper: %v", err)
	}
	defer func() {
		_ = command.Process.Kill()
		_ = command.Wait()
	}()

	deadline := time.Now().Add(30 * time.Second)
	for {
		if _, err := os.Stat(ready); err == nil {
			break
		}
		if time.Now().After(deadline) {
			t.Fatal("helper never registered its signal handler")
		}
		time.Sleep(10 * time.Millisecond)
	}

	if err := command.Process.Signal(syscall.SIGTERM); err != nil {
		t.Fatalf("signal helper: %v", err)
	}
	if err := command.Wait(); err != nil {
		t.Fatalf("helper exited with an error: %v", err)
	}

	content, err := os.ReadFile(marker)
	if err != nil {
		t.Fatalf("cleanup marker: %v", err)
	}
	if string(content) != "cleaned" {
		t.Fatalf("cleanup marker = %q, want %q", content, "cleaned")
	}
}

func TestExitOnTerminationHelperProcess(t *testing.T) {
	if os.Getenv(exitHelperEnv) != "1" {
		t.Skip("helper for TestExitOnTerminationRunsCleanupOnSigterm")
	}

	marker := os.Getenv(exitMarkerEnv)
	isInit.Store(true)
	exitCleanup = func() {
		_ = os.WriteFile(marker, []byte("cleaned"), 0o600)
	}

	watchTermination()

	if err := os.WriteFile(os.Getenv(exitReadyEnv), nil, 0o600); err != nil {
		t.Fatal(err)
	}

	time.Sleep(30 * time.Second)
	t.Fatal("the process was never terminated")
}

func TestConcurrentExitWaitsForTheSameCleanup(t *testing.T) {
	previous := isInit.Load()
	isInit.Store(true)
	t.Cleanup(func() { isInit.Store(previous) })
	started := make(chan struct{})
	release := make(chan struct{})
	var calls atomic.Int32
	stubExitCleanup(t, func() {
		calls.Add(1)
		isInit.Store(false)
		close(started)
		<-release
	})
	done := exitGuard.done
	t.Cleanup(func() { close(release); <-done })
	returned := make(chan struct{}, 2)
	go func() { releaseOnExit(); returned <- struct{}{} }()
	<-started
	go func() { releaseOnExit(); returned <- struct{}{} }()
	select {
	case <-returned:
		t.Fatal("an exit path returned while cleanup was still running")
	case <-time.After(30 * time.Millisecond):
	}
	if calls.Load() != 1 {
		t.Fatalf("cleanup calls = %d, want 1", calls.Load())
	}
}

type exitTestConn struct {
	io.Reader
	closed bool
}

func (c *exitTestConn) Write(p []byte) (int, error) { return len(p), nil }
func (c *exitTestConn) Close() error                { c.closed = true; return nil }

func TestServeCleansUpOnDisconnect(t *testing.T) {
	oversized := make([]byte, 4)
	binary.LittleEndian.PutUint32(oversized, maxIPCFrameSize+1)
	for name, data := range map[string][]byte{
		"eof":              nil,
		"truncated header": {1, 0},
		"oversized frame":  oversized,
	} {
		t.Run(name, func(t *testing.T) {
			previousInit, previousConn := isInit.Load(), conn
			isInit.Store(true)
			t.Cleanup(func() { isInit.Store(previousInit); conn = previousConn })
			connection := &exitTestConn{Reader: bytes.NewReader(data)}
			called := stubExitCleanup(t, func() {
				if !connection.closed {
					t.Error("cleanup started before closing IPC")
				}
			})
			serve(connection)
			if !*called {
				t.Fatal("IPC disconnect skipped cleanup")
			}
		})
	}
}

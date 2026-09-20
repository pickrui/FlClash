//go:build !cgo

package main

import (
	"fmt"
	"os"
	"os/signal"
	"sync"
	"syscall"
	"time"
)

// sing-tun's routes outlive the process and only handleShutdown removes them;
// the Helper kills the Core three seconds after SIGTERM, so cleanup stays under.
var (
	exitCleanupTimeout = 2 * time.Second
	exitCleanup        = func() { handleShutdown() }
	exitProcess        = os.Exit
	exitGuard          = &exitCleanupGuard{done: make(chan struct{})}
)

type exitCleanupGuard struct {
	once sync.Once
	done chan struct{}
}

func releaseOnExit() {
	guard := exitGuard
	guard.once.Do(func() {
		if !isInit.Load() {
			close(guard.done)
			return
		}
		cleanup := exitCleanup
		go func() {
			defer close(guard.done)
			cleanup()
		}()
	})
	timer := time.NewTimer(exitCleanupTimeout)
	defer timer.Stop()
	select {
	case <-guard.done:
	case <-timer.C:
		fmt.Fprintln(os.Stderr, "[ERROR] core cleanup did not finish before exit")
	}
}

func watchTermination() {
	signals := make(chan os.Signal, 1)
	signal.Notify(signals, os.Interrupt, syscall.SIGTERM)
	go func() {
		defer signal.Stop(signals)
		handleTermination(signals)
	}()
}

func handleTermination(signals <-chan os.Signal) {
	<-signals
	releaseOnExit()
	exitProcess(0)
}

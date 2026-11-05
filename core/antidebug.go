package main

import (
	"os"
	"time"

	"github.com/metacubex/mihomo/log"
)

// GuardStartup refuses to start when a debugger is attached or a foreign
// library has been injected, protecting decrypted node material from being
// dumped.
func GuardStartup() {
	if debuggerPresent() {
		log.Warnln("FlClash: debugger detected, refusing to start")
		os.Exit(1)
	}
	if injectionDetected() {
		log.Warnln("FlClash: library injection detected, refusing to start")
		os.Exit(1)
	}
}

func injectionDetected() bool {
	for _, key := range []string{"LD_PRELOAD", "DYLD_INSERT_LIBRARIES", "LD_AUDIT"} {
		if os.Getenv(key) != "" {
			return true
		}
	}
	return false
}

// init runs the startup guard as soon as the core is loaded, covering both the
// cgo shared-library build consumed by the app and the standalone CLI build.
func init() {
	GuardStartup()
	go func() {
		for {
			time.Sleep(7 * time.Second)
			if debuggerPresent() || injectionDetected() {
				os.Exit(1)
			}
		}
	}()
}

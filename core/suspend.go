package main

import "github.com/metacubex/mihomo/tunnel"

// All idle state is protected by runLock, including calls from Android's idle
// receiver and configuration changes. Keeping traffic active is the default.
var (
	deviceIdle            bool
	suspendOnIdle         bool
	idleOwnsTunnelSuspend bool
)

// reconcileIdleSuspendLocked changes only the suspend state owned by the idle
// policy. The caller must hold runLock so config loading cannot be resumed early.
func reconcileIdleSuspendLocked() {
	if !isRunning {
		// Retain ownership until the next explicit start. A wake event or setting
		// change while stopped must not restart the tunnel.
		return
	}
	status := tunnel.Status()
	if status != tunnel.Suspend {
		idleOwnsTunnelSuspend = false
	}
	if deviceIdle && suspendOnIdle {
		if status == tunnel.Running {
			tunnel.OnSuspend()
			idleOwnsTunnelSuspend = true
		}
		return
	}
	if idleOwnsTunnelSuspend {
		tunnel.OnRunning()
		idleOwnsTunnelSuspend = false
	}
}

package com.oixcloud.clash

import com.oixcloud.clash.common.QuickAction
import kotlinx.coroutines.sync.Mutex
import kotlinx.coroutines.sync.withLock

/** Resolve each shortcut against the service, including after the UI process died. */
internal class QuickActionHandler(
    private val isRunning: suspend () -> Boolean,
    private val start: suspend () -> Unit,
    private val stop: suspend () -> Unit,
) {
    private val mutex = Mutex()

    suspend fun handle(action: QuickAction) = mutex.withLock {
        val running = isRunning()
        when (action) {
            QuickAction.TOGGLE -> if (running) stop() else start()
            QuickAction.START -> if (!running) start()
            QuickAction.STOP -> if (running) stop()
        }
    }
}

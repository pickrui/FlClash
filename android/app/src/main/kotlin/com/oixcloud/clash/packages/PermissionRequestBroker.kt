package com.oixcloud.clash.packages

import java.util.concurrent.atomic.AtomicInteger

/** Coalesces one permission dialog, rejecting results from an older attachment. */
internal class PermissionRequestBroker {
    private val lock = Any()
    private var code: Int? = null
    private val callbacks = mutableListOf<(Boolean) -> Unit>()

    fun begin(callback: (Boolean) -> Unit): Int? = synchronized(lock) {
        callbacks.add(callback)
        if (code != null) return null
        val next = 0x2000 + (nextCode.getAndIncrement() and Int.MAX_VALUE) % 0x6000
        code = next
        next
    }

    fun complete(requestCode: Int, granted: Boolean): Boolean {
        val waiting = synchronized(lock) {
            if (requestCode != code) return false
            code = null
            callbacks.toList().also { callbacks.clear() }
        }
        waiting.forEach { runCatching { it(granted) } }
        return true
    }

    fun cancel() {
        val waiting = synchronized(lock) {
            code = null
            callbacks.toList().also { callbacks.clear() }
        }
        waiting.forEach { runCatching { it(false) } }
    }

    companion object {
        private val nextCode = AtomicInteger(0)
    }
}

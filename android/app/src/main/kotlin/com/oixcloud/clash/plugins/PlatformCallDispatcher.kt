package com.oixcloud.clash.plugins

import io.flutter.plugin.common.MethodChannel.Result
import java.util.concurrent.atomic.AtomicBoolean
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch

/** Owns replies for a single engine attachment, including work that cannot be interrupted. */
internal class PlatformCallDispatcher(private val scope: CoroutineScope) {
    private class Reply(private val result: Result) {
        private val completed = AtomicBoolean(false)
        fun success(value: Any?) {
            if (completed.compareAndSet(false, true)) result.success(value)
        }
        fun error(code: String, message: String) {
            if (completed.compareAndSet(false, true)) result.error(code, message, null)
        }
    }

    private val lock = Any()
    private val pending = mutableSetOf<Reply>()
    private var closed = false

    fun submit(result: Result, block: suspend () -> Any?) {
        val reply = Reply(result)
        synchronized(lock) {
            if (closed) {
                reply.error("UNAVAILABLE", "Android app plugin detached")
                return
            }
            pending.add(reply)
            val job = scope.launch {
                try {
                    reply.success(block())
                } catch (_: CancellationException) {
                    reply.error("CANCELLED", "Android platform call cancelled")
                } catch (_: Exception) {
                    reply.error("PLATFORM_ERROR", "Could not read Android application information")
                } finally {
                    synchronized(lock) { pending.remove(reply) }
                }
            }
            // A cancelled scope may prevent the coroutine body from starting at all.
            job.invokeOnCompletion { cause ->
                if (cause is CancellationException) {
                    reply.error("CANCELLED", "Android platform call cancelled")
                }
                synchronized(lock) { pending.remove(reply) }
            }
        }
    }

    fun close() {
        val replies = synchronized(lock) {
            closed = true
            pending.toList().also { pending.clear() }
        }
        try {
            replies.forEach { reply ->
                // One unavailable messenger must not strand the remaining callers.
                runCatching { reply.error("UNAVAILABLE", "Android app plugin detached") }
            }
        } finally {
            scope.cancel()
        }
    }
}

package com.oixcloud.clash

import com.oixcloud.clash.common.RunIntentArbiter
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException

/** Cancels permission waits without holding the service transition lock. */
internal class StartPreparation {
    private val lock = Any()
    private val requests = RunIntentArbiter()
    private var pending: (() -> Unit)? = null

    val isWaiting: Boolean
        get() = synchronized(lock) { pending != null }

    fun begin(): RunIntentArbiter.Token = request(true)

    fun stop() { request(false) }

    private fun request(running: Boolean): RunIntentArbiter.Token {
        val (token, cancel) = synchronized(lock) {
            val token = requests.request(running)
            val cancel = pending
            pending = null
            token to cancel
        }
        cancel?.invoke()
        return token
    }

    fun ensureCurrent(token: RunIntentArbiter.Token) {
        if (!requests.isCurrent(token)) throw CancellationException("VPN start was cancelled")
    }

    suspend fun <T> await(
        token: RunIntentArbiter.Token,
        register: ((T) -> Unit) -> Unit,
        unregister: ((T) -> Unit) -> Unit,
    ): T = suspendCancellableCoroutine { continuation ->
        val abort = { continuation.cancel(CancellationException("VPN start was cancelled")); Unit }
        fun clear() {
            synchronized(lock) { if (pending === abort) pending = null }
        }
        val callback: (T) -> Unit = { value ->
            clear()
            if (continuation.isActive) continuation.resume(value)
        }
        continuation.invokeOnCancellation {
            clear()
            unregister(callback)
        }
        synchronized(lock) {
            try {
                ensureCurrent(token)
                if (continuation.isActive) {
                    pending = abort
                    // Stop cannot cancel a callback before registration finishes.
                    register(callback)
                }
            } catch (error: Exception) {
                clear()
                unregister(callback)
                if (continuation.isActive) continuation.resumeWithException(error)
            }
        }
    }
}

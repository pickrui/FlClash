package com.oixcloud.clash.common

import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.CoroutineStart
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.filterNotNull
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import kotlinx.coroutines.withTimeout

internal class ServiceBinding<T>(
    private val scope: CoroutineScope,
    private val connect: () -> Flow<Pair<T?, String>>,
    private val onServiceDisconnected: ((String) -> Unit)? = null,
) {
    private class Binding<T> {
        val state = MutableStateFlow<Pair<T?, String>?>(null)
        lateinit var job: Job
    }

    private val lock = Any()
    private var active: Binding<T>? = null
    private val state = MutableStateFlow<Pair<T?, String>?>(null)
    val serviceState: StateFlow<Pair<T?, String>?> = state

    fun bind() {
        val binding = synchronized(lock) {
            if (active != null) return
            Binding<T>().also { next ->
                active = next
                state.value = null
                // Store the job before collection can synchronously fail or
                // invoke a disconnect callback that starts another binding.
                next.job = scope.launch(start = CoroutineStart.LAZY) {
                    try {
                        connect().collect { publish(next, it) }
                    } catch (error: CancellationException) {
                        throw error
                    } catch (error: Exception) {
                        publish(next, Pair(null, error.message ?: "Service binding failed"))
                    }
                }
            }
        }
        binding.job.start()
    }

    private fun publish(binding: Binding<T>, result: Pair<T?, String>) {
        synchronized(lock) {
            if (active !== binding) return
            binding.state.value = result
            state.value = result
            if (result.first == null) {
                active = null
                binding.job.cancel()
                // Keep the failure visible to pending calls. Clearing it to
                // null here makes StateFlow callers miss the disconnection
                // and report only the generic five-second binding timeout.
                onServiceDisconnected?.invoke(result.second)
            }
        }
    }

    suspend fun <R> useService(
        timeoutMillis: Long = 5000,
        block: suspend (T) -> R,
    ): Result<R> {
        val currentState = synchronized(lock) {
            // A disconnected binding has no active owner. Freeze its error
            // before a concurrent bind clears the public state for a new one.
            active?.state ?: state.value?.let { MutableStateFlow(it) } ?: state
        }
        return runCatching {
            withTimeout(timeoutMillis) {
                val result = currentState.filterNotNull().first()
                val service = result.first ?: throw IllegalStateException(result.second)
                withContext(Dispatchers.Default) { block(service) }
            }
        }
    }

    fun unbind() {
        val binding = synchronized(lock) {
            val previous = active
            active = null
            // Calls already waiting for the old binding must not migrate to
            // its replacement when a core restart immediately binds again.
            previous?.state?.value = Pair(null, "Service unbound")
            state.value = null
            previous
        }
        binding?.job?.cancel()
    }
}

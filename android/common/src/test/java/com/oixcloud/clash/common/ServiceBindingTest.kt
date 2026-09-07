package com.oixcloud.clash.common

import kotlinx.coroutines.CancellableContinuation
import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.CoroutineStart
import kotlinx.coroutines.Delay
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.DisposableHandle
import kotlinx.coroutines.InternalCoroutinesApi
import kotlinx.coroutines.TimeoutCancellationException
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitCancellation
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.FlowCollector
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.withContext
import kotlinx.coroutines.yield
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test
import kotlin.coroutines.CoroutineContext

class ServiceBindingTest {
    // A retained callback can arrive after the platform binding is cancelled.
    // Deliver directly to the collector to exercise that ordering explicitly.
    @OptIn(InternalCoroutinesApi::class)
    private class Connection : Flow<Pair<String?, String>> {
        private val collector = CompletableDeferred<FlowCollector<Pair<String?, String>>>()

        override suspend fun collect(collector: FlowCollector<Pair<String?, String>>) {
            this.collector.complete(collector)
            awaitCancellation()
        }

        suspend fun ready() {
            collector.await()
        }

        suspend fun emit(service: String?, error: String = "") {
            collector.await().emit(Pair(service, error))
        }
    }

    @Test
    fun pendingCallReceivesDisconnectInsteadOfBindingTimeout() = runBlocking {
        val connection = Connection()
        val errors = mutableListOf<String>()
        val binding = ServiceBinding(this, { connection }, errors::add)
        binding.bind()
        connection.ready()
        val pending = async(start = CoroutineStart.UNDISPATCHED) {
            binding.useService(timeoutMillis = 250) { it }
        }

        connection.emit(null, "Service disconnected")

        assertEquals("Service disconnected", pending.await().exceptionOrNull()?.message)
        assertEquals(Pair(null, "Service disconnected"), binding.serviceState.value)
        assertEquals(listOf("Service disconnected"), errors)
        assertEquals(
            "Service disconnected",
            binding.useService { it }.exceptionOrNull()?.message,
        )
        binding.unbind()
    }

    @Test
    fun rebindIsUnaffectedByOldCallbacksAndPendingCallsStayWithOldBinding() = runBlocking {
        val previous = Connection()
        val next = Connection()
        var attempts = 0
        val errors = mutableListOf<String>()
        val binding = ServiceBinding(this, { if (attempts++ == 0) previous else next }, errors::add)
        try {
            binding.bind()
            previous.ready()
            val pending = async(start = CoroutineStart.UNDISPATCHED) {
                binding.useService { it }
            }
            binding.unbind()
            binding.bind()
            next.ready()
            next.emit("new service")
            previous.emit("old service")
            previous.emit(null, "Service disconnected")

            assertEquals("Service unbound", pending.await().exceptionOrNull()?.message)
            assertEquals("new service", binding.useService { it }.getOrThrow())
            assertEquals(Pair("new service", ""), binding.serviceState.value)
            assertTrue(errors.isEmpty())
            binding.bind()
            yield()
            assertEquals(2, attempts)
        } finally {
            binding.unbind()
        }
    }

    @Test
    fun bindingFailureIsReportedAndTheNextBindCanRetry() = runBlocking {
        val connection = Connection()
        var attempts = 0
        val binding = ServiceBinding(this, {
            if (attempts++ == 0) flow { error("bindService() failed") } else connection
        })
        try {
            binding.bind()
            assertEquals(
                "bindService() failed",
                binding.useService(timeoutMillis = 250) { it }.exceptionOrNull()?.message,
            )
            binding.bind()
            connection.ready()
            connection.emit("service")
            assertEquals("service", binding.useService { it }.getOrThrow())
        } finally {
            binding.unbind()
        }
    }

    @Test
    fun disconnectCallbackCanRebindWithoutOldCleanupCancellingTheNewBinding() = runBlocking {
        val previous = Connection()
        val next = Connection()
        var attempts = 0
        lateinit var binding: ServiceBinding<String>
        binding = ServiceBinding(
            this,
            { if (attempts++ == 0) previous else next },
            { binding.bind() },
        )
        try {
            binding.bind()
            previous.ready()
            previous.emit(null, "Service disconnected")
            next.ready()
            next.emit("replacement")
            binding.bind()
            yield()

            assertEquals(2, attempts)
            assertEquals("replacement", binding.useService { it }.getOrThrow())
        } finally {
            binding.unbind()
        }
    }

    @Test
    @OptIn(InternalCoroutinesApi::class)
    fun disconnectedCallKeepsItsErrorIfRebindingStartsBeforeItSubscribes() = runBlocking {
        val previous = Connection()
        var attempts = 0
        val binding = ServiceBinding(
            CoroutineScope(coroutineContext + Dispatchers.Unconfined),
            {
                if (attempts++ == 0) previous else flow {
                    emit(Pair("replacement", ""))
                    awaitCancellation()
                }
            },
        )
        try {
            binding.bind()
            previous.emit(null, "Service disconnected")
            // withTimeout registers its timer after useService captures the
            // state but before first() subscribes. Rebind at exactly that point.
            val dispatcher = object : CoroutineDispatcher(), Delay {
                override fun isDispatchNeeded(context: CoroutineContext) = false

                override fun dispatch(context: CoroutineContext, block: Runnable) = block.run()

                override fun scheduleResumeAfterDelay(
                    timeMillis: Long,
                    continuation: CancellableContinuation<Unit>,
                ) = error("Unexpected delay")

                override fun invokeOnTimeout(
                    timeMillis: Long,
                    block: Runnable,
                    context: CoroutineContext,
                ): DisposableHandle {
                    binding.bind()
                    return DisposableHandle { }
                }
            }
            val result = withContext(dispatcher) { binding.useService { it } }

            assertEquals("Service disconnected", result.exceptionOrNull()?.message)
            assertEquals("replacement", binding.useService { it }.getOrThrow())
        } finally {
            binding.unbind()
        }
    }

    @Test
    fun waitingForAServiceStillTimesOutWithoutCancellingItsBinding() = runBlocking {
        val connection = Connection()
        val binding = ServiceBinding(this, { connection })
        try {
            binding.bind()
            connection.ready()
            assertTrue(
                binding.useService(timeoutMillis = 1) { it }.exceptionOrNull()
                    is TimeoutCancellationException,
            )
            connection.emit("late service")
            assertEquals("late service", binding.useService { it }.getOrThrow())
        } finally {
            binding.unbind()
        }
    }
}

package com.oixcloud.clash

import com.oixcloud.clash.common.QuickAction
import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.CoroutineStart
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class QuickActionHandlerTest {
    @Test
    fun coldUiWithRunningRemoteStopsWithoutLoadingConfig() = runBlocking {
        var starts = 0
        var stops = 0
        val handler = QuickActionHandler(
            isRunning = { true },
            start = { starts++ },
            stop = { stops++ },
        )

        handler.handle(QuickAction.TOGGLE)

        assertEquals(0, starts)
        assertEquals(1, stops)
    }

    @Test
    fun secondToggleWaitsForSetupAndThenStops() = runBlocking {
        var running = false
        val setup = CompletableDeferred<Unit>()
        val events = mutableListOf<String>()
        val handler = QuickActionHandler(
            isRunning = { events.add("query"); running },
            start = {
                events.add("setup")
                setup.await()
                running = true
                events.add("started")
            },
            stop = { running = false; events.add("stopped") },
        )
        val first = launch(start = CoroutineStart.UNDISPATCHED) {
            handler.handle(QuickAction.TOGGLE)
        }
        val second = launch(start = CoroutineStart.UNDISPATCHED) {
            handler.handle(QuickAction.TOGGLE)
        }
        assertEquals(listOf("query", "setup"), events)
        setup.complete(Unit)
        first.join()
        second.join()

        assertEquals(listOf("query", "setup", "started", "query", "stopped"), events)
    }

    @Test
    fun queryFailureDoesNotTurnToggleIntoStartAndCanRetry() = runBlocking {
        var failed = true
        var starts = 0
        val handler = QuickActionHandler(
            isRunning = { check(!failed) { "service disconnected" }; false },
            start = { starts++ },
            stop = { error("unexpected stop") },
        )

        assertTrue(runCatching { handler.handle(QuickAction.TOGGLE) }.isFailure)
        assertEquals(0, starts)
        failed = false
        handler.handle(QuickAction.TOGGLE)
        assertEquals(1, starts)
    }

    @Test
    fun setupFailureReleasesOperationForRetry() = runBlocking {
        var attempts = 0
        val handler = QuickActionHandler(
            isRunning = { false },
            start = { attempts++; check(attempts > 1) { "key unavailable" } },
            stop = { error("unexpected stop") },
        )

        assertTrue(runCatching { handler.handle(QuickAction.START) }.isFailure)
        handler.handle(QuickAction.START)
        assertEquals(2, attempts)
    }

    @Test
    fun explicitActionsAreIdempotent() = runBlocking {
        var running = false
        var starts = 0
        var stops = 0
        val handler = QuickActionHandler(
            isRunning = { running },
            start = { running = true; starts++ },
            stop = { running = false; stops++ },
        )

        handler.handle(QuickAction.STOP)
        handler.handle(QuickAction.START)
        handler.handle(QuickAction.START)
        handler.handle(QuickAction.STOP)
        handler.handle(QuickAction.STOP)
        assertEquals(1, starts)
        assertEquals(1, stops)
    }
}

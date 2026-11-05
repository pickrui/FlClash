package com.oixcloud.clash

import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.CoroutineStart
import kotlinx.coroutines.awaitCancellation
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.yield
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertSame
import org.junit.Assert.assertTrue
import org.junit.Test

class StartWithRollbackTest {
    @Test
    fun successfulStartReturnsItsResultWithoutRollback() = runBlocking {
        var rolledBack = false

        val result = startWithRollback(
            block = { 42L },
            rollback = { rolledBack = true },
        )

        assertEquals(42L, result)
        assertFalse(rolledBack)
    }

    @Test
    fun configurationFailureRollsBackBeforeReportingFailure() = runBlocking {
        val failure = IllegalStateException("config decryption failed")
        val events = mutableListOf<String>()

        val result = runCatching {
            startWithRollback(
                block = {
                    events.add("configure")
                    throw failure
                },
                rollback = { events.add("rollback") },
            )
        }
        events.add("reported")

        assertSame(failure, result.exceptionOrNull())
        assertEquals(listOf("configure", "rollback", "reported"), events)
    }

    @Test
    fun vpnStartFailureRollsBackTheConfiguredCore() = runBlocking {
        val failure = IllegalStateException("VPN startup failed")
        var coreConfigured = false
        val events = mutableListOf<String>()

        val result = runCatching {
            startWithRollback(
                block = {
                    coreConfigured = true
                    events.add("configured")
                    events.add("start-vpn")
                    throw failure
                },
                rollback = {
                    assertTrue(coreConfigured)
                    coreConfigured = false
                    events.add("rollback")
                },
            )
        }

        assertSame(failure, result.exceptionOrNull())
        assertFalse(coreConfigured)
        assertEquals(listOf("configured", "start-vpn", "rollback"), events)
    }

    @Test
    fun cancellationStillWaitsForSuspendingRollbackToComplete() = runBlocking {
        val rollbackEntered = CompletableDeferred<Unit>()
        val finishRollback = CompletableDeferred<Unit>()
        var rolledBack = false
        val operation = launch(start = CoroutineStart.UNDISPATCHED) {
            startWithRollback(
                block = { awaitCancellation() },
                rollback = {
                    rollbackEntered.complete(Unit)
                    yield()
                    finishRollback.await()
                    rolledBack = true
                },
            )
        }

        operation.cancel(CancellationException("shortcut cancelled"))
        rollbackEntered.await()
        assertFalse(operation.isCompleted)
        assertFalse(rolledBack)
        finishRollback.complete(Unit)
        operation.join()

        assertTrue(operation.isCancelled)
        assertTrue(rolledBack)
    }

    @Test
    fun rollbackFailureIsSuppressedOnTheOriginalFailure() = runBlocking {
        val failure = IllegalStateException("start failed")
        val rollbackFailure = IllegalStateException("shutdown failed")

        val result = runCatching {
            startWithRollback(
                block = { throw failure },
                rollback = { throw rollbackFailure },
            )
        }

        assertSame(failure, result.exceptionOrNull())
        assertEquals(1, failure.suppressed.size)
        assertSame(rollbackFailure, failure.suppressed.single())
    }

    @Test
    fun theSameFailureIsNeverSuppressedOnItself() = runBlocking {
        val failure = IllegalStateException("shared failure")

        val result = runCatching {
            startWithRollback(
                block = { throw failure },
                rollback = { throw failure },
            )
        }

        assertSame(failure, result.exceptionOrNull())
        assertTrue(failure.suppressed.isEmpty())
    }
}

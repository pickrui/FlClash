package com.oixcloud.clash

import com.oixcloud.clash.common.PendingCallback
import kotlinx.coroutines.CoroutineStart
import kotlinx.coroutines.async
import kotlinx.coroutines.runBlocking
import org.junit.Assert.*
import org.junit.Test

class StartPreparationTest {
    @Test
    fun stopCancelsConsentAndRemovesItsCallback() = runBlocking {
        val preparation = StartPreparation()
        val callbacks = PendingCallback<Boolean>()
        val request = preparation.begin()
        val waiting = async(start = CoroutineStart.UNDISPATCHED) {
            preparation.await(request, { callbacks.replace(it, false) }, callbacks::cancel)
        }
        assertTrue(preparation.isWaiting)
        preparation.stop()
        waiting.join()
        assertTrue(waiting.isCancelled)
        assertFalse(callbacks.isPending)
        assertFalse(preparation.isWaiting)
        assertTrue(runCatching { preparation.ensureCurrent(request) }.isFailure)
    }

    @Test
    fun replacementCancelsOldWaitWithoutRemovingNewCallback() = runBlocking {
        val preparation = StartPreparation()
        val callbacks = PendingCallback<Boolean>()
        val old = async(start = CoroutineStart.UNDISPATCHED) {
            preparation.await(preparation.begin(), { callbacks.replace(it, false) }, callbacks::cancel)
        }
        val latest = preparation.begin()
        val next = async(start = CoroutineStart.UNDISPATCHED) {
            preparation.await(latest, { callbacks.replace(it, false) }, callbacks::cancel)
        }
        old.join()
        assertTrue(old.isCancelled)
        assertTrue(callbacks.isPending)
        callbacks.resolve(true)
        assertTrue(next.await())
        preparation.ensureCurrent(latest)
    }

    @Test
    fun stoppedRequestCannotRegisterAnotherPermission() = runBlocking {
        val preparation = StartPreparation()
        val request = preparation.begin()
        preparation.stop()
        var registered = false
        val result = runCatching {
            preparation.await<Boolean>(request, { registered = true }, {})
        }
        assertTrue(result.isFailure)
        assertFalse(registered)
        assertFalse(preparation.isWaiting)
    }

    @Test
    fun synchronousPermissionResultLeavesNothingPending() = runBlocking {
        val preparation = StartPreparation()
        assertTrue(preparation.await<Boolean>(preparation.begin(), { it(true) }, {}))
        assertFalse(preparation.isWaiting)
    }

    @Test
    fun callerCancellationRemovesTheRegisteredCallback() = runBlocking {
        val preparation = StartPreparation()
        val callbacks = PendingCallback<Boolean>()
        val waiting = async(start = CoroutineStart.UNDISPATCHED) {
            preparation.await(preparation.begin(), { callbacks.replace(it, false) }, callbacks::cancel)
        }
        waiting.cancel()
        waiting.join()
        assertFalse(callbacks.isPending)
        assertFalse(preparation.isWaiting)
    }

    @Test
    fun registrationFailureReleasesThePendingWait() = runBlocking {
        val preparation = StartPreparation()
        val callbacks = PendingCallback<Boolean>()
        val result = runCatching {
            preparation.await<Boolean>(preparation.begin(), {
                callbacks.replace(it, false)
                error("activity unavailable")
            }, callbacks::cancel)
        }
        assertEquals("activity unavailable", result.exceptionOrNull()?.message)
        assertFalse(callbacks.isPending)
        assertFalse(preparation.isWaiting)
    }
}

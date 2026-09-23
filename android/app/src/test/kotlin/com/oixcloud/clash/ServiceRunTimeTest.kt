package com.oixcloud.clash

import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.CoroutineStart
import kotlinx.coroutines.async
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.sync.Mutex
import kotlinx.coroutines.sync.withLock
import org.junit.Assert.*
import org.junit.Test

class ServiceRunTimeTest {
    @Test
    fun delayedStopNotificationReadsTheReplacementSession() = runBlocking {
        val lock = Mutex(locked = true)
        var runtime = 0L
        var published = -1L
        val sync = async(start = CoroutineStart.UNDISPATCHED) {
            syncServiceRunTime(lock, { runtime }, { published = it })
        }
        runtime = 456L
        lock.unlock()

        assertEquals(456L, sync.await())
        assertEquals(456L, published)
    }

    @Test
    fun statePublicationCannotOvertakeTheFollowingNativeStart() = runBlocking {
        val lock = Mutex()
        val querying = CompletableDeferred<Unit>()
        val finish = CompletableDeferred<Unit>()
        var published = 0L
        val sync = async(start = CoroutineStart.UNDISPATCHED) {
            syncServiceRunTime(lock, {
                querying.complete(Unit)
                finish.await()
                0L
            }, { published = it })
        }
        querying.await()
        val start = launch(start = CoroutineStart.UNDISPATCHED) {
            lock.withLock { published = 789L }
        }
        assertFalse(start.isCompleted)
        finish.complete(Unit)
        assertEquals(0L, sync.await())
        start.join()
        assertEquals(789L, published)
    }

    @Test
    fun unavailableQueryDoesNotPublishAFalseStopOrBlockTheNextQuery() = runBlocking {
        val lock = Mutex()
        var published = 123L
        val failure = IllegalStateException("unavailable")
        val result = runCatching {
            syncServiceRunTime(lock, { throw failure }, { published = it })
        }
        assertSame(failure, result.exceptionOrNull())
        assertEquals(123L, published)
        assertEquals(456L, syncServiceRunTime(lock, { 456L }, { published = it }))
        assertEquals(456L, published)
    }
}

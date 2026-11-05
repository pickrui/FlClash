package com.oixcloud.clash

import com.oixcloud.clash.plugins.PlatformCallDispatcher
import io.flutter.plugin.common.MethodChannel.Result
import java.util.concurrent.CountDownLatch
import java.util.concurrent.TimeUnit
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.runBlocking
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class PlatformCallDispatcherTest {
    private class Response : Result {
        val events = java.util.Collections.synchronizedList(mutableListOf<Any?>())
        override fun success(result: Any?) { events.add(result) }
        override fun error(code: String, message: String?, details: Any?) { events.add(code) }
        override fun notImplemented() { events.add("notImplemented") }
    }

    @Test
    fun successAndFailureBothSettleAndOneFailureDoesNotCancelOtherCalls() {
        val calls = PlatformCallDispatcher(CoroutineScope(SupervisorJob() + Dispatchers.Unconfined))
        val failed = Response()
        val successful = Response()
        calls.submit(failed) { throw SecurityException("package query unavailable") }
        calls.submit(successful) { "packages" }
        assertEquals(listOf("PLATFORM_ERROR"), failed.events)
        assertEquals(listOf("packages"), successful.events)
        calls.close()
        assertEquals(1, successful.events.size)
        assertEquals(1, failed.events.size)
    }

    @Test
    fun detachSettlesBlockingWorkImmediatelyAndIgnoresItsLateResult() = runBlocking {
        val scope = CoroutineScope(SupervisorJob() + Dispatchers.Default)
        val calls = PlatformCallDispatcher(scope)
        val response = Response()
        val started = CountDownLatch(1)
        val finish = CountDownLatch(1)
        try {
            calls.submit(response) {
                started.countDown()
                check(finish.await(5, TimeUnit.SECONDS))
                "late result"
            }
            assertTrue(started.await(5, TimeUnit.SECONDS))
            calls.close()
            assertEquals(listOf("UNAVAILABLE"), response.events)
        } finally {
            finish.countDown()
            calls.close()
        }
        scope.coroutineContext[kotlinx.coroutines.Job]!!.join()
        assertEquals(listOf("UNAVAILABLE"), response.events)
    }

    @Test
    fun alreadyCancelledScopeStillSettlesUnstartedWork() {
        val scope = CoroutineScope(SupervisorJob() + Dispatchers.Unconfined)
        scope.cancel()
        val calls = PlatformCallDispatcher(scope)
        val response = Response()
        calls.submit(response) { error("must not start") }
        assertEquals(listOf("CANCELLED"), response.events)
        calls.close()
        assertEquals(1, response.events.size)
    }

    @Test
    fun closedAttachmentRejectsNewCallsAndANewAttachmentWorks() {
        val old = PlatformCallDispatcher(CoroutineScope(SupervisorJob() + Dispatchers.Unconfined))
        old.close()
        val rejected = Response()
        old.submit(rejected) { error("must not start") }
        val fresh = PlatformCallDispatcher(CoroutineScope(SupervisorJob() + Dispatchers.Unconfined))
        val success = Response()
        fresh.submit(success) { "new attachment" }
        assertEquals(listOf("UNAVAILABLE"), rejected.events)
        assertEquals(listOf("new attachment"), success.events)
        fresh.close()
    }
}

package com.oixcloud.clash.service

import java.util.concurrent.CountDownLatch
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class UidPackageCacheTest {
    @Test
    fun unknownAndEmptyResultsDoNotPoisonLaterLookups() {
        var result: Array<String>? = null
        var calls = 0
        val cache = UidPackageCache { calls++; result }
        assertEquals("", cache.resolve(-1))
        assertEquals(0, calls)
        assertEquals("", cache.resolve(1000))
        result = emptyArray()
        assertEquals("", cache.resolve(1000))
        result = arrayOf("")
        assertEquals("", cache.resolve(1000))
        result = arrayOf("installed", "shared.uid")
        assertEquals("installed", cache.resolve(1000))
        result = arrayOf("replacement")
        assertEquals("installed", cache.resolve(1000))
        assertEquals(4, calls)
        cache.clear()
        assertEquals("replacement", cache.resolve(1000))
    }

    @Test
    fun clearingWhileLookupIsInFlightDoesNotReviveTheOldCache() {
        val started = CountDownLatch(1)
        val finish = CountDownLatch(1)
        val pool = Executors.newSingleThreadExecutor()
        var first = true
        val cache = UidPackageCache {
            if (first) {
                first = false
                started.countDown()
                check(finish.await(5, TimeUnit.SECONDS))
                arrayOf("old")
            } else arrayOf("new")
        }
        try {
            val old = pool.submit<String> { cache.resolve(1000) }
            assertTrue(started.await(5, TimeUnit.SECONDS))
            cache.clear()
            finish.countDown()
            assertEquals("old", old.get(5, TimeUnit.SECONDS))
            assertEquals("new", cache.resolve(1000))
        } finally {
            finish.countDown()
            pool.shutdownNow()
        }
    }

    @Test
    fun concurrentCallbacksPublishOneConsistentPackage() {
        val callers = 8
        val ready = CountDownLatch(callers)
        val resolve = CountDownLatch(1)
        val pool = Executors.newFixedThreadPool(callers)
        val cache = UidPackageCache {
            ready.countDown()
            check(resolve.await(5, TimeUnit.SECONDS))
            arrayOf(Thread.currentThread().name)
        }
        try {
            val results = (1..callers).map { pool.submit<String> { cache.resolve(1000) } }
            assertTrue(ready.await(5, TimeUnit.SECONDS))
            resolve.countDown()
            val names = results.map { it.get(5, TimeUnit.SECONDS) }.toSet()
            assertEquals(1, names.size)
            assertEquals(names.single(), cache.resolve(1000))
        } finally {
            resolve.countDown()
            pool.shutdownNow()
        }
    }
}

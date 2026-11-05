package com.oixcloud.clash

import com.oixcloud.clash.packages.PackageSnapshotCache
import java.util.concurrent.CountDownLatch
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit
import java.util.concurrent.atomic.AtomicInteger
import org.junit.Assert.assertEquals
import org.junit.Assert.assertThrows
import org.junit.Assert.assertTrue
import org.junit.Test

class PackageSnapshotCacheTest {
    @Test
    fun cachesEmptyListsAndReloadsAfterInstallation() {
        var calls = 0
        var installed = emptyList<String>()
        val cache = PackageSnapshotCache { calls++; installed }
        assertTrue(cache.get().isEmpty())
        assertTrue(cache.get().isEmpty())
        assertEquals(1, calls)
        installed = listOf("new.app")
        cache.invalidate()
        assertEquals(installed, cache.get())
        assertEquals(2, calls)
    }

    @Test
    fun oldLoadCannotRefillCacheAfterAnUninstall() {
        val started = CountDownLatch(1)
        val finish = CountDownLatch(1)
        val count = AtomicInteger()
        val pool = Executors.newSingleThreadExecutor()
        val cache = PackageSnapshotCache {
            if (count.getAndIncrement() == 0) {
                started.countDown()
                check(finish.await(5, TimeUnit.SECONDS))
                listOf("removed.app")
            } else emptyList()
        }
        try {
            val old = pool.submit<List<String>> { cache.get() }
            assertTrue(started.await(5, TimeUnit.SECONDS))
            cache.invalidate()
            assertTrue(cache.get().isEmpty())
            finish.countDown()
            assertTrue(old.get(5, TimeUnit.SECONDS).isEmpty())
            assertEquals(2, count.get())
        } finally {
            finish.countDown()
            pool.shutdownNow()
        }
    }

    @Test
    fun failedQueryDoesNotCacheFailureAndPublishedListsAreSnapshots() {
        val installed = mutableListOf("existing")
        var fail = true
        val cache = PackageSnapshotCache {
            if (fail) throw SecurityException("permission")
            installed
        }
        assertThrows(SecurityException::class.java) { cache.get() }
        fail = false
        assertEquals(listOf("existing"), cache.get())
        installed.clear()
        assertEquals(listOf("existing"), cache.get())
        cache.invalidate()
        assertTrue(cache.get().isEmpty())
    }
}

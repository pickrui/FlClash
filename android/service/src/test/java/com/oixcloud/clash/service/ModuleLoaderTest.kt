package com.oixcloud.clash.service

import com.oixcloud.clash.service.modules.Module
import com.oixcloud.clash.service.modules.moduleLoader
import java.util.concurrent.CountDownLatch
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertSame
import org.junit.Assert.assertThrows
import org.junit.Assert.assertTrue
import org.junit.Test

class ModuleLoaderTest {
    private fun module(
        install: () -> Unit = {},
        uninstall: () -> Unit = {},
    ) = object : Module() {
        override fun onInstall() = install()
        override fun onUninstall() = uninstall()
    }

    @Test
    fun startupCompletesBeforeSuccessAndRepeatedLoadIsIdempotent() {
        val events = mutableListOf<String>()
        val loader = moduleLoader {
            install(module(install = { events.add("installed") }))
        }

        loader.load()
        events.add("started")
        loader.load()

        assertEquals(listOf("installed", "started"), events)
    }

    @Test
    fun failedStartupRollsBackCompletedAndPartiallyInstalledModules() {
        val events = mutableListOf<String>()
        val failure = IllegalStateException("foreground service rejected")
        val loader = moduleLoader {
            install(module(uninstall = { events.add("network stopped") }))
            install(module(
                install = { throw failure },
                uninstall = { events.add("notification stopped") },
            ))
        }

        val thrown = assertThrows(IllegalStateException::class.java) {
            startWithCleanup(start = loader::load, cleanup = loader::cancel)
        }

        assertSame(failure, thrown)
        assertEquals(listOf("notification stopped", "network stopped"), events)
        loader.cancel()
        assertEquals(2, events.size)
    }

    @Test
    fun cleanupFailureDoesNotSkipOtherModulesOrPreventTheNextStart() {
        val events = mutableListOf<String>()
        val failure = IllegalStateException("receiver already removed")
        val otherFailure = IllegalStateException("callback already removed")
        val loader = moduleLoader {
            install(module(
                install = { events.add("started") },
                uninstall = { events.add("network stopped"); throw otherFailure },
            ))
            install(module(uninstall = { throw failure }))
        }
        loader.load()

        val thrown = assertThrows(IllegalStateException::class.java) { loader.cancel() }
        assertSame(failure, thrown)
        assertEquals(listOf(otherFailure), thrown.suppressed.toList())
        assertEquals(listOf("started", "network stopped"), events)

        loader.cancel()
        loader.load()
        assertEquals(listOf("started", "network stopped", "started"), events)
    }

    @Test
    fun stopWaitsForAnInFlightInstallationAndFinishesCleanupBeforeReturning() {
        val installing = CountDownLatch(1)
        val finishInstall = CountDownLatch(1)
        val stopping = CountDownLatch(1)
        val stopped = CountDownLatch(1)
        val executor = Executors.newFixedThreadPool(2)
        val loader = moduleLoader {
            install(module(
                install = {
                    installing.countDown()
                    check(finishInstall.await(5, TimeUnit.SECONDS))
                },
                uninstall = { stopped.countDown() },
            ))
        }
        try {
            val start = executor.submit { loader.load() }
            assertTrue(installing.await(5, TimeUnit.SECONDS))
            val stop = executor.submit {
                stopping.countDown()
                loader.cancel()
                check(stopped.count == 0L)
            }
            assertTrue(stopping.await(5, TimeUnit.SECONDS))
            assertFalse(stopped.await(100, TimeUnit.MILLISECONDS))
            finishInstall.countDown()
            start.get(5, TimeUnit.SECONDS)
            stop.get(5, TimeUnit.SECONDS)
        } finally {
            finishInstall.countDown()
            executor.shutdownNow()
        }
    }
}

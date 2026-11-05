package com.oixcloud.clash.service

import org.junit.Assert.assertEquals
import org.junit.Assert.assertSame
import org.junit.Assert.assertThrows
import org.junit.Test

class ServiceStartTest {
    @Test
    fun successfulStartKeepsTheServiceRunning() {
        val events = mutableListOf<String>()
        startWithCleanup(
            start = { events.add("start") },
            cleanup = { events.add("stop") },
        )
        assertEquals(listOf("start"), events)
    }

    @Test
    fun rejectedVpnIsCleanedUpAndReportedAsFailure() {
        val events = mutableListOf<String>()
        val failure = IllegalStateException("Establish VPN rejected by system")
        val thrown = assertThrows(IllegalStateException::class.java) {
            startWithCleanup(
                start = {
                    events.add("start")
                    throw failure
                },
                cleanup = { events.add("stop") },
            )
        }
        assertSame(failure, thrown)
        assertEquals(listOf("start", "stop"), events)
    }

    @Test
    fun cleanupFailureDoesNotHideTheStartFailure() {
        val failure = IllegalStateException("VPN permission revoked")
        val cleanupFailure = IllegalArgumentException("Network callback not registered")
        val thrown = assertThrows(IllegalStateException::class.java) {
            startWithCleanup(
                start = { throw failure },
                cleanup = { throw cleanupFailure },
            )
        }
        assertSame(failure, thrown)
        assertEquals(listOf(cleanupFailure), thrown.suppressed.toList())
    }
}

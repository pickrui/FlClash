package com.oixcloud.clash.service

import com.oixcloud.clash.service.modules.NetworkDnsTracker
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class NetworkDnsTrackerTest {
    private class Pending(val at: Long, val action: () -> Unit) {
        var cancelled = false
        var fired = false
    }

    private class Fixture {
        var time = 100L
        val pending = mutableListOf<Pending>()
        val updates = mutableListOf<List<String>>()
        val tracker = NetworkDnsTracker<String>(
            now = { time },
            schedule = { delay, action ->
                val task = Pending(time + delay, action)
                pending.add(task)
                val cancel: () -> Unit = { task.cancelled = true }
                cancel
            },
            publish = { updates.add(it) },
        )

        fun add(name: String, priority: Int, dns: List<String> = listOf(name)) {
            tracker.available(name, priority)
            tracker.linkPropertiesChanged(name, dns)
        }

        fun advance(delay: Long) {
            time += delay
            pending.filter { !it.cancelled && !it.fired && it.at <= time }.forEach {
                it.fired = true
                it.action()
            }
        }
    }

    @Test
    fun losingWifiRecoversItsDnsWithoutAnotherNetworkCallback() {
        val f = Fixture()
        f.add("wifi", 0)
        f.add("cellular", 4)
        f.tracker.losing("wifi", 1000)
        assertEquals(listOf("cellular"), f.updates.last())
        f.advance(999)
        assertEquals(2, f.updates.size)
        f.advance(1)
        assertEquals(listOf(listOf("wifi"), listOf("cellular"), listOf("wifi")), f.updates)
    }

    @Test
    fun lostNetworkAndLateTimerCannotRestoreStaleDns() {
        val f = Fixture()
        f.add("wifi", 0)
        f.add("cellular", 4)
        f.tracker.losing("wifi", 1000)
        val old = f.pending.single()
        f.tracker.lost("wifi")
        assertTrue(old.cancelled)
        f.advance(2000)
        old.action()
        assertEquals(listOf("cellular"), f.updates.last())
        assertEquals(2, f.updates.size)
    }

    @Test
    fun repeatedLosingNotificationExtendsTheDeadline() {
        val f = Fixture()
        f.add("wifi", 0)
        f.add("cellular", 4)
        f.tracker.losing("wifi", 1000)
        val old = f.pending.single()
        f.advance(500)
        f.tracker.losing("wifi", 2000)
        assertTrue(old.cancelled)
        f.advance(500)
        old.action()
        assertEquals(listOf("cellular"), f.updates.last())
        f.advance(1500)
        assertEquals(listOf("wifi"), f.updates.last())
    }

    @Test
    fun stoppedSessionIgnoresEveryLateCallback() {
        val f = Fixture()
        f.add("wifi", 0)
        f.tracker.losing("wifi", 1000)
        val old = f.pending.single()
        f.tracker.stop()
        val stopped = f.updates.toList()
        assertEquals(emptyList<String>(), stopped.last())
        assertTrue(old.cancelled)
        f.tracker.available("wifi", 0)
        f.tracker.capabilitiesChanged("wifi", 0)
        f.tracker.linkPropertiesChanged("wifi", listOf("stale"))
        f.tracker.losing("wifi", 1000)
        f.tracker.lost("wifi")
        old.action()
        f.tracker.stop()
        assertEquals(stopped, f.updates)
    }

    @Test
    fun availableNetworkWithoutDnsDoesNotEraseKnownResolvers() {
        val f = Fixture()
        f.add("cellular", 4)
        f.tracker.available("wifi", 0)
        assertEquals(listOf(listOf("cellular")), f.updates)
        val dns = mutableListOf("[fe80::1%2]:53", "192.0.2.1:53", "192.0.2.1:53")
        f.tracker.linkPropertiesChanged("wifi", dns)
        dns.clear()
        assertEquals(listOf("[fe80::1%2]:53", "192.0.2.1:53"), f.updates.last())
        f.tracker.available("wifi", 0)
        assertEquals(2, f.updates.size)
        f.tracker.lost("wifi")
        f.tracker.lost("cellular")
        assertEquals(emptyList<String>(), f.updates.last())
    }

    @Test
    fun capabilityChangesReorderDnsAndZeroLifetimeDoesNotLeaveATimer() {
        val f = Fixture()
        f.add("unknown", 100)
        f.add("cellular", 4)
        f.tracker.capabilitiesChanged("unknown", 0)
        assertEquals(listOf("unknown"), f.updates.last())
        f.tracker.losing("unknown", 0)
        f.tracker.losing("unknown", -1)
        assertTrue(f.pending.isEmpty())
        assertEquals(3, f.updates.size)
    }
}

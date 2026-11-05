package com.oixcloud.clash

import com.oixcloud.clash.packages.PermissionRequestBroker
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotEquals
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Test

class PermissionRequestBrokerTest {
    @Test
    fun concurrentRequestsShareOneDialogAndResolveOnce() {
        val broker = PermissionRequestBroker()
        val values = mutableListOf<Boolean>()
        val code = broker.begin { values.add(it) }!!
        assertNull(broker.begin { values.add(it) })
        assertTrue(code in 0x2000..0x7fff)
        assertTrue(broker.complete(code, true))
        assertFalse(broker.complete(code, true))
        assertEquals(listOf(true, true), values)
    }

    @Test
    fun detachedRequestCannotResolveANewAttachment() {
        val old = PermissionRequestBroker()
        val first = mutableListOf<Boolean>()
        val oldCode = old.begin { first.add(it) }!!
        old.cancel()
        val fresh = PermissionRequestBroker()
        val second = mutableListOf<Boolean>()
        val newCode = fresh.begin { second.add(it) }!!
        assertNotEquals(oldCode, newCode)
        assertFalse(fresh.complete(oldCode, true))
        assertTrue(second.isEmpty())
        assertTrue(fresh.complete(newCode, false))
        assertEquals(listOf(false), first)
        assertEquals(listOf(false), second)
    }

    @Test
    fun callbackCanStartAnotherRequestWithoutBeingResolvedByOldResult() {
        val broker = PermissionRequestBroker()
        val values = mutableListOf<Boolean>()
        var next = 0
        val old = broker.begin {
            next = broker.begin { value -> values.add(value) }!!
        }!!
        broker.complete(old, false)
        assertNotEquals(old, next)
        assertFalse(broker.complete(old, true))
        broker.complete(next, true)
        assertEquals(listOf(true), values)
    }

    @Test
    fun failedMessengerDoesNotStrandOtherWaiters() {
        val broker = PermissionRequestBroker()
        broker.begin { throw IllegalStateException("detached") }
        val values = mutableListOf<Boolean>()
        broker.begin { values.add(it) }
        broker.cancel()
        broker.cancel()
        assertEquals(listOf(false), values)
    }
}

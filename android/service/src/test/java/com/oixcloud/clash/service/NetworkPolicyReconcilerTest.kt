package com.oixcloud.clash.service

import kotlinx.coroutines.runBlocking
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

class NetworkPolicyReconcilerTest {
    @Test
    fun partialSuspendFailureStillRestoresVpnWhenTheNetworkReturns() = runBlocking {
        var vpnExcluded = false
        var coreExcluded = false
        var rejectCore = false
        val applied = mutableListOf<Boolean>()
        val policy = NetworkPolicyReconciler(
            { vpnExcluded = it },
            { if (rejectCore) error("Core disconnected") else coreExcluded = it },
            applied::add,
        )
        policy.apply(false)
        rejectCore = true
        assertTrue(runCatching { policy.apply(true) }.isFailure)
        assertTrue(vpnExcluded)
        assertFalse(coreExcluded)
        rejectCore = false
        policy.apply(false)
        assertFalse(vpnExcluded)
        assertFalse(coreExcluded)
        assertEquals(listOf(false, false), applied)
    }

    @Test
    fun partialResumeFailureClosesListenersWhenTheExcludedNetworkReturns() = runBlocking {
        var coreExcluded = false
        var rejectVpn = false
        val events = mutableListOf<String>()
        val policy = NetworkPolicyReconciler(
            { events.add("vpn:$it"); if (rejectVpn && !it) error("VPN rejected") },
            { events.add("core:$it"); coreExcluded = it },
            {},
        )
        policy.apply(true)
        rejectVpn = true
        assertTrue(runCatching { policy.apply(false) }.isFailure)
        assertFalse(coreExcluded)
        policy.apply(true)
        assertTrue(coreExcluded)
        assertEquals(listOf("vpn:true", "core:true", "core:false", "vpn:false", "vpn:true", "core:true"), events)
    }

    @Test
    fun completedPoliciesDeduplicateButFreshStartsAlwaysReapply() = runBlocking {
        val events = mutableListOf<String>()
        val policy = NetworkPolicyReconciler(
            { events.add("vpn:$it") }, { events.add("core:$it") }, {},
        )
        policy.apply(false)
        policy.apply(false)
        assertEquals(listOf("core:false", "vpn:false"), events)
        policy.apply(false, force = true)
        assertEquals(listOf("core:false", "vpn:false", "core:false", "vpn:false"), events)
    }
}

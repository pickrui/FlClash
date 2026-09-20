package com.oixcloud.clash.service

import com.oixcloud.clash.service.modules.NetworkRuleMatcher
import com.oixcloud.clash.service.models.normalizeTunMtu
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Assert.assertEquals
import org.junit.Test

class NetworkRuleMatcherTest {
    @Test fun matchesOnlyTheRequestedAddressSource() {
        val ips = listOf("192.168.1.23", "fe80::1")
        val gateways = listOf("192.168.1.1")
        assertTrue(NetworkRuleMatcher.matches(ips, gateways, listOf("192.168.1.0/24")))
        assertTrue(NetworkRuleMatcher.matches(ips, gateways, listOf(" gateway:192.168.1.1 ")))
        assertTrue(NetworkRuleMatcher.matches(ips, gateways, listOf("GATEWAY:192.168.0.0/16")))
        assertTrue(NetworkRuleMatcher.matches(ips, gateways, listOf("0.0.0.0/0")))
        assertFalse(NetworkRuleMatcher.matches(ips, gateways, listOf("192.168.1.1")))
        assertFalse(NetworkRuleMatcher.matches(ips, gateways, listOf("gateway:192.168.1.23")))
        assertFalse(NetworkRuleMatcher.matches(emptyList(), emptyList(), listOf("0.0.0.0/0")))
    }
    @Test fun malformedRulesNeverResolveDnsOrMatch() {
        val invalid = listOf("example.com", "::1", "10.0.0.256", "+1.2.3.4", "1.2.3.4/-1", "1.2.3.4/33", "1.2.3.4/1/2", "gateway:gateway:1.2.3.4")
        invalid.forEach { assertFalse(NetworkRuleMatcher.matches(listOf("1.2.3.4"), listOf("1.2.3.4"), listOf(it))) }
        assertFalse(NetworkRuleMatcher.matches(listOf("1.2.3.4"), emptyList(), List(17) { "0.0.0.0/0" }))
    }
    @Test fun vpnMtuUsesTheSameLimitsAndFallbackAsCore() {
        listOf(1280, 1480, 4064, 9000, 65535).forEach { assertEquals(it, normalizeTunMtu(it)) }
        listOf(0, -1, 1279, 65536).forEach { assertEquals(9000, normalizeTunMtu(it)) }
    }
}

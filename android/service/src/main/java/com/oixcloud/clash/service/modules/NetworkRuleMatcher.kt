package com.oixcloud.clash.service.modules

internal object NetworkRuleMatcher {
    /** Mirrors maxNetworkRules in lib/common/network.dart. */
    private const val MAX_RULES = 16
    private val octetPattern = Regex("[0-9]{1,3}")
    private val prefixPattern = Regex("[0-9]{1,2}")
    private fun ipv4(value: String): Long? {
        val parts = value.split('.')
        if (parts.size != 4) return null
        var result = 0L
        for (part in parts) {
            if (!part.matches(octetPattern)) return null
            val number = part.toIntOrNull() ?: return null
            if (number !in 0..255) return null
            result = (result shl 8) or number.toLong()
        }
        return result
    }

    private fun matches(address: String, value: String): Boolean {
        val parts = value.split('/')
        if (parts.size !in 1..2) return false
        val ip = ipv4(address) ?: return false
        val network = ipv4(parts[0]) ?: return false
        val prefix = if (parts.size == 1) 32 else {
            if (!parts[1].matches(prefixPattern)) return false
            parts[1].toIntOrNull() ?: return false
        }
        if (prefix !in 0..32) return false
        val mask = if (prefix == 0) 0L else (0xffffffffL shl (32 - prefix)) and 0xffffffffL
        return (ip and mask) == (network and mask)
    }

    fun matches(addresses: List<String>, gateways: List<String>, rules: List<String>): Boolean {
        if (rules.size > MAX_RULES) return false
        return rules.any { raw ->
            val rule = raw.trim()
            val gateway = rule.startsWith("gateway:", ignoreCase = true)
            val value = if (gateway) rule.substring(8).trim() else rule
            (if (gateway) gateways else addresses).any { matches(it, value) }
        }
    }
}

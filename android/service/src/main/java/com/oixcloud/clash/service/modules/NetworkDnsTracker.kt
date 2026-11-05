package com.oixcloud.clash.service.modules

/** One registration owns one tracker, so late callbacks cannot revive a stopped session. */
internal class NetworkDnsTracker<N>(
    private val now: () -> Long,
    private val schedule: (Long, () -> Unit) -> (() -> Unit),
    private val publish: (List<String>) -> Unit,
) {
    private class Info(var priority: Int) {
        var dns = emptyList<String>()
        var losingUntil = 0L
        var revision: Any? = null
        var cancel: (() -> Unit)? = null
    }

    private val networks = linkedMapOf<N, Info>()
    private var active = true
    private var previousDns = emptyList<String>()

    @Synchronized
    fun available(network: N, priority: Int) {
        if (!active) return
        networks.getOrPut(network) { Info(priority) }.priority = priority
        update()
    }

    @Synchronized
    fun capabilitiesChanged(network: N, priority: Int) {
        if (!active) return
        networks[network]?.priority = priority
        update()
    }

    @Synchronized
    fun linkPropertiesChanged(network: N, dns: List<String>) {
        if (!active) return
        networks[network]?.dns = dns.distinct()
        update()
    }

    @Synchronized
    fun losing(network: N, lifetimeMs: Int) {
        if (!active) return
        val info = networks[network] ?: return
        info.cancel?.invoke()
        val delay = lifetimeMs.coerceAtLeast(0).toLong()
        val revision = Any()
        info.revision = revision
        info.losingUntil = now() + delay
        update()
        info.cancel = if (delay > 0) schedule(delay) {
            synchronized(this) {
                if (active && networks[network] === info && info.revision === revision) {
                    info.cancel = null
                    update()
                }
            }
        } else null
    }

    @Synchronized
    fun lost(network: N) {
        if (!active) return
        networks.remove(network)?.cancel?.invoke()
        update()
    }

    @Synchronized
    fun stop() {
        active = false
        networks.values.forEach { it.cancel?.invoke() }
        networks.clear()
        update()
    }

    private fun update() {
        val time = now()
        val dns = networks.values.asSequence()
            .filter { it.dns.isNotEmpty() }
            .minByOrNull { it.priority + if (time < it.losingUntil) 10 else 0 }
            ?.dns ?: emptyList()
        if (dns == previousDns) return
        previousDns = dns
        publish(dns.toList())
    }
}

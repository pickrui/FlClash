package com.oixcloud.clash.service.modules

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.net.ConnectivityManager
import android.net.Network
import android.net.LinkProperties
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import android.net.wifi.WifiInfo
import android.net.wifi.WifiManager
import android.os.Build
import android.os.Handler
import android.os.Looper
import androidx.core.content.ContextCompat

/** Lives in the VPN process, so shortcuts do not need to open Flutter. */
class WifiSsidMonitor(private val context: Context, private val onChange: () -> Unit) {
    private val connectivity = context.getSystemService(ConnectivityManager::class.java)
    private val wifi = context.applicationContext.getSystemService(WifiManager::class.java)
    private val handler = Handler(Looper.getMainLooper())
    private val lock = Any()
    private val names = mutableMapOf<Network, String?>()
    private var callback: ConnectivityManager.NetworkCallback? = null
    private var active = false
    private val poll = object : Runnable {
        override fun run(): Unit = synchronized(lock) {
            if (!active) return
            onChange()
            handler.postDelayed(this, 10_000)
        }
    }

    private fun permitted(): Boolean =
        ContextCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION) ==
            PackageManager.PERMISSION_GRANTED &&
        (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q ||
            ContextCompat.checkSelfPermission(context, Manifest.permission.ACCESS_BACKGROUND_LOCATION) ==
                PackageManager.PERMISSION_GRANTED)

    fun current(): String? = synchronized(lock) {
        if (!permitted()) return null
        names.values.firstOrNull { it != null } ?: runCatching {
            @Suppress("DEPRECATION")
            normalizeSsid(wifi?.connectionInfo?.ssid)
        }.getOrNull()
    }

    fun start(): Unit = synchronized(lock) {
        if (active) return
        active = true
        val listener = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            object : ConnectivityManager.NetworkCallback(ConnectivityManager.NetworkCallback.FLAG_INCLUDE_LOCATION_INFO) {
                override fun onCapabilitiesChanged(network: Network, caps: NetworkCapabilities) = changed(network, caps)
                override fun onLost(network: Network) = lost(network)
                override fun onLinkPropertiesChanged(network: Network, properties: LinkProperties) = linksChanged()
            }
        } else {
            object : ConnectivityManager.NetworkCallback() {
                override fun onCapabilitiesChanged(network: Network, caps: NetworkCapabilities) = changed(network, caps)
                override fun onLost(network: Network) = lost(network)
                override fun onLinkPropertiesChanged(network: Network, properties: LinkProperties) = linksChanged()
            }
        }
        callback = listener
        runCatching {
            connectivity?.registerNetworkCallback(NetworkRequest.Builder()
                .addTransportType(NetworkCapabilities.TRANSPORT_WIFI)
                .addTransportType(NetworkCapabilities.TRANSPORT_ETHERNET)
                .addCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
                .addCapability(NetworkCapabilities.NET_CAPABILITY_NOT_VPN).build(), listener)
        }
        handler.post(poll)
    }

    fun matchesNetworks(rules: List<String>): Boolean {
        if (rules.isEmpty()) return false
        val manager = connectivity ?: return false
        return runCatching {
            val active = manager.activeNetwork
            val activeCaps = active?.let { manager.getNetworkCapabilities(it) }
            val networks = if (active != null && activeCaps?.hasCapability(NetworkCapabilities.NET_CAPABILITY_NOT_VPN) == true) {
                listOf(active)
            } else manager.allNetworks.toList()
            val network = networks.mapNotNull { net ->
                val caps = manager.getNetworkCapabilities(net) ?: return@mapNotNull null
                if (!caps.hasCapability(NetworkCapabilities.NET_CAPABILITY_NOT_VPN) ||
                    !caps.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)) return@mapNotNull null
                val priority = when {
                    caps.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> 0
                    caps.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) -> 1
                    else -> return@mapNotNull null
                }
                net to priority
            }.minByOrNull { it.second }?.first ?: return@runCatching false
            val links = manager.getLinkProperties(network) ?: return@runCatching false
            NetworkRuleMatcher.matches(
                links.linkAddresses.mapNotNull { it.address.hostAddress },
                links.routes.filter { it.isDefaultRoute }.mapNotNull { it.gateway?.hostAddress },
                rules,
            )
        }.getOrDefault(false)
    }

    private fun linksChanged() = synchronized(lock) {
        if (active) onChange()
    }

    private fun changed(network: Network, caps: NetworkCapabilities) = synchronized(lock) {
        if (!active) return
        names[network] = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            normalizeSsid((caps.transportInfo as? WifiInfo)?.ssid)
        } else null
        onChange()
    }

    private fun lost(network: Network) = synchronized(lock) {
        if (!active) return
        names.remove(network)
        onChange()
    }

    fun stop() = synchronized(lock) {
        active = false
        handler.removeCallbacks(poll)
        callback?.let { runCatching { connectivity?.unregisterNetworkCallback(it) } }
        callback = null
        names.clear()
    }
}

fun normalizeSsid(value: String?): String? {
    if (value.isNullOrEmpty() || value == WifiManager.UNKNOWN_SSID) return null
    return if (value.length >= 2 && value.first() == '"' && value.last() == '"') {
        value.substring(1, value.length - 1).takeIf { it.isNotEmpty() }
    } else value
}

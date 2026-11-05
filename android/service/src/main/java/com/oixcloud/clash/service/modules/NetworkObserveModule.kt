package com.oixcloud.clash.service.modules

import android.app.Service
import android.net.ConnectivityManager
import android.net.LinkProperties
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkCapabilities.TRANSPORT_SATELLITE
import android.net.NetworkCapabilities.TRANSPORT_USB
import android.net.NetworkRequest
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.os.SystemClock
import androidx.core.content.getSystemService
import com.oixcloud.clash.core.Core
import java.net.Inet4Address
import java.net.Inet6Address
import java.net.InetAddress

class NetworkObserveModule(private val service: Service) : Module() {
    private val lock = Any()
    private val handler = Handler(Looper.getMainLooper())
    private val connectivity by lazy { service.getSystemService<ConnectivityManager>() }
    private var callback: ConnectivityManager.NetworkCallback? = null
    private var tracker: NetworkDnsTracker<Network>? = null

    private val request = NetworkRequest.Builder().apply {
        addCapability(NetworkCapabilities.NET_CAPABILITY_NOT_VPN)
        addCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            addCapability(NetworkCapabilities.NET_CAPABILITY_FOREGROUND)
        }
        addCapability(NetworkCapabilities.NET_CAPABILITY_NOT_RESTRICTED)
    }.build()

    override fun onInstall(): Unit = synchronized(lock) {
        if (callback != null) return
        val session = NetworkDnsTracker<Network>(
            now = SystemClock::elapsedRealtime,
            schedule = { delay, action ->
                val runnable = Runnable { action() }
                handler.postDelayed(runnable, delay)
                val cancel: () -> Unit = { handler.removeCallbacks(runnable) }
                cancel
            },
            publish = { Core.updateDNS(it.joinToString(",")) },
        )
        val listener = object : ConnectivityManager.NetworkCallback() {
            override fun onAvailable(network: Network) {
                // O+ delivers capabilities immediately after availability. Earlier
                // releases need an initial query to preserve transport priority.
                val priority = if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) {
                    connectivity?.getNetworkCapabilities(network)?.let(::networkPriority) ?: 100
                } else 100
                session.available(network, priority)
            }

            override fun onCapabilitiesChanged(network: Network, caps: NetworkCapabilities) =
                session.capabilitiesChanged(network, networkPriority(caps))

            override fun onLosing(network: Network, maxMsToLive: Int) =
                session.losing(network, maxMsToLive)

            override fun onLost(network: Network) = session.lost(network)

            override fun onLinkPropertiesChanged(network: Network, properties: LinkProperties) =
                session.linkPropertiesChanged(
                    network, properties.dnsServers.map { it.asSocketAddressText(53) },
                )
        }
        tracker = session
        callback = listener
        connectivity?.registerNetworkCallback(request, listener)
    }

    private fun networkPriority(capabilities: NetworkCapabilities): Int = when {
        capabilities.hasTransport(NetworkCapabilities.TRANSPORT_VPN) -> 90
        capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> 0
        capabilities.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) -> 1
        Build.VERSION.SDK_INT >= Build.VERSION_CODES.S &&
            capabilities.hasTransport(TRANSPORT_USB) -> 2
        capabilities.hasTransport(NetworkCapabilities.TRANSPORT_BLUETOOTH) -> 3
        capabilities.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) -> 4
        Build.VERSION.SDK_INT >= Build.VERSION_CODES.VANILLA_ICE_CREAM &&
            capabilities.hasTransport(TRANSPORT_SATELLITE) -> 5
        else -> 20
    }

    override fun onUninstall(): Unit = synchronized(lock) {
        val listener = callback
        callback = null
        try {
            listener?.let { connectivity?.unregisterNetworkCallback(it) }
        } finally {
            tracker?.stop()
            tracker = null
        }
    }
}

fun InetAddress.asSocketAddressText(port: Int): String {
    return when (this) {
        is Inet6Address -> "[${numericToTextFormat(this)}]:$port"

        is Inet4Address -> "${this.hostAddress}:$port"

        else -> throw IllegalArgumentException("Unsupported Inet type ${this.javaClass}")
    }
}

private fun numericToTextFormat(address: Inet6Address): String {
    val src = address.address
    val sb = StringBuilder(39)
    for (i in 0 until 8) {
        sb.append(
            Integer.toHexString(
                src[i shl 1].toInt() shl 8 and 0xff00 or (src[(i shl 1) + 1].toInt() and 0xff)
            )
        )
        if (i < 7) {
            sb.append(":")
        }
    }
    if (address.scopeId > 0) {
        sb.append("%")
        sb.append(address.scopeId)
    }
    return sb.toString()
}

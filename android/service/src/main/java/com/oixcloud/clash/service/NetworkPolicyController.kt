package com.oixcloud.clash.service

import com.google.gson.JsonParser
import com.oixcloud.clash.common.GlobalState
import com.oixcloud.clash.core.Core
import com.oixcloud.clash.service.modules.WifiSsidMonitor
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlinx.coroutines.sync.withLock
import kotlinx.coroutines.withTimeout

/** Owned by the process, not a RemoteService binding: the VPN outlives the UI's binding. */
internal object NetworkPolicyController {
    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.Default)

    private val networkPolicy = NetworkPolicyReconciler(
        setVpnExcluded = { excluded ->
            State.delegate?.useService { it.setNetworkExcluded(excluded) }?.getOrThrow()
        },
        setCoreExcluded = ::setCoreNetworkExcluded,
        onApplied = { State.networkExcluded = it },
    )

    private val monitor = lazy {
        WifiSsidMonitor(GlobalState.application) {
            scope.launch {
                State.runLock.withLock {
                    if (State.runTime == 0L) return@withLock
                    runCatching { applyPolicy() }.onFailure {
                        GlobalState.log("Wi-Fi policy transition failed: ${it.javaClass.simpleName}")
                    }
                }
            }
        }
    }
    private val ssidMonitor by monitor

    private suspend fun setCoreNetworkExcluded(excluded: Boolean) = withTimeout(5_000) {
        suspendCancellableCoroutine<Unit> { continuation ->
            Core.invokeMethod("{\"method\":\"setNetworkExcluded\",\"arguments\":$excluded}") { result ->
                val response = runCatching { JsonParser.parseString(result).asJsonObject }.getOrNull()
                val ok = response?.get("result")?.toString() == "true" && response.get("error") == null
                val failure = if (ok) null else IllegalStateException("Core rejected Wi-Fi policy")
                if (continuation.isActive) {
                    continuation.resumeWith(if (failure == null) Result.success(Unit) else Result.failure(failure))
                }
            }
        }
    }

    fun configure() {
        val options = State.options
        if (options?.excludeSSIDs.isNullOrEmpty() && options?.excludeNetworks.isNullOrEmpty()) {
            ssidMonitor.stop()
        } else {
            ssidMonitor.start()
        }
    }

    suspend fun applyPolicy(initial: Boolean = false) {
        val ssid = if (State.options?.excludeSSIDs.isNullOrEmpty()) null else ssidMonitor.current()
        val excluded = (ssid != null && State.options?.excludeSSIDs.orEmpty().contains(ssid)) ||
            ssidMonitor.matchesNetworks(State.options?.excludeNetworks.orEmpty())
        networkPolicy.apply(excluded, force = initial)
        // When the list is cleared, keep the existing polling retry alive until
        // both VPN and Core have resumed successfully.
        configure()
    }

    fun stop() {
        if (monitor.isInitialized()) ssidMonitor.stop()
    }
}

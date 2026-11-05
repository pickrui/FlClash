package com.oixcloud.clash.service

/** Called under State.runLock, which also serializes manual start and stop. */
internal class NetworkPolicyReconciler(
    private val setVpnExcluded: suspend (Boolean) -> Unit,
    private val setCoreExcluded: suspend (Boolean) -> Unit,
    private val onApplied: (Boolean) -> Unit,
) {
    private var applied: Boolean? = null

    suspend fun apply(excluded: Boolean, force: Boolean = false) {
        if (!force && applied == excluded) return
        // Neither side is authoritative after a partial failure. Even a return
        // to the last completed policy must reconcile both sides on the retry.
        applied = null
        if (excluded) setVpnExcluded(true)
        setCoreExcluded(excluded)
        if (!excluded) setVpnExcluded(false)
        onApplied(excluded)
        applied = excluded
    }
}

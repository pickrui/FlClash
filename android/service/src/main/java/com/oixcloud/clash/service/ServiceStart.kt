package com.oixcloud.clash.service

/** Clean up a partial start while preserving the failure for the remote caller. */
internal inline fun startWithCleanup(start: () -> Unit, cleanup: () -> Unit) {
    try {
        start()
    } catch (failure: Exception) {
        try {
            cleanup()
        } catch (cleanupFailure: Exception) {
            if (cleanupFailure !== failure) failure.addSuppressed(cleanupFailure)
        }
        throw failure
    }
}

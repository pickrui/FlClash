package com.oixcloud.clash

import kotlinx.coroutines.NonCancellable
import kotlinx.coroutines.withContext

/** Clean up a partially started core before reporting failure or cancellation. */
internal suspend fun <T> startWithRollback(
    block: suspend () -> T,
    rollback: suspend () -> Unit,
): T {
    try {
        return block()
    } catch (error: Throwable) {
        withContext(NonCancellable) {
            try {
                rollback()
            } catch (rollbackError: Throwable) {
                if (rollbackError !== error) {
                    error.addSuppressed(rollbackError)
                }
            }
        }
        throw error
    }
}

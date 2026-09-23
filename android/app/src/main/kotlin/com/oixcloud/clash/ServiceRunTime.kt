package com.oixcloud.clash

import kotlinx.coroutines.sync.Mutex
import kotlinx.coroutines.sync.withLock

suspend fun syncServiceRunTime(
    lock: Mutex,
    query: suspend () -> Long,
    publish: (Long) -> Unit,
): Long = lock.withLock {
    query().also(publish)
}

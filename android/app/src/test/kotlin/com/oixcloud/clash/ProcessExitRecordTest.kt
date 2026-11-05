package com.oixcloud.clash

import org.junit.Assert.*
import org.junit.Test

class ProcessExitRecordTest {
    private val app = "com.oixcloud.clash"

    @Test
    fun excludesServiceAndWebViewCrashes() {
        val records = listOf(
            ProcessExitRecord("$app:service", 2, 3000L, 5),
            ProcessExitRecord("$app:renderer", 3, 4000L, 4),
            ProcessExitRecord(app, 1, 2000L, 10),
        )
        assertEquals(mapOf<String, Any>("reason" to 10, "timestamp" to 2000L, "pid" to 1), latestMainProcessExit(records, app))
    }

    @Test
    fun selectsNewestMainExitEvenWhenHistoryIsUnordered() {
        val records = listOf(
            ProcessExitRecord(app, 1, 1000L, 4),
            ProcessExitRecord(app, 3, 3000L, 10),
            ProcessExitRecord(app, 2, 2000L, 5),
        )
        assertEquals(10, latestMainProcessExit(records, app)?.get("reason"))
    }

    @Test
    fun absentOrInvalidMainHistoryIsUnknown() {
        assertNull(latestMainProcessExit(emptyList(), app))
        assertNull(latestMainProcessExit(listOf(
            ProcessExitRecord("$app:service", 1, 1000L, 4),
            ProcessExitRecord(app, 0, 1000L, 4),
            ProcessExitRecord(app, 1, 0L, 4),
        ), app))
    }
}

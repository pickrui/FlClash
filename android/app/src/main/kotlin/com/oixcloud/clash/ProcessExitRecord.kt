package com.oixcloud.clash

internal data class ProcessExitRecord(
    val processName: String,
    val pid: Int,
    val timestamp: Long,
    val reason: Int,
)

// A VPN service or WebView exit must not be attributed to the Flutter process.
internal fun latestMainProcessExit(
    records: Iterable<ProcessExitRecord>,
    packageName: String,
): Map<String, Any>? = records
    .filter { it.processName == packageName && it.pid > 0 && it.timestamp > 0 }
    .maxByOrNull { it.timestamp }
    ?.let { mapOf("reason" to it.reason, "timestamp" to it.timestamp, "pid" to it.pid) }

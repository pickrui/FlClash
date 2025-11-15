package com.dler.clash.models


data class AppState(
    val currentProfileName: String = "FlClash for Dler Cloud",
    val stopText: String = "Stop",
    val onlyStatisticsProxy: Boolean = false,
)

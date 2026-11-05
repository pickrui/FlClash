package com.follow.clash.models


data class AppState(
    val currentProfileName: String = "FlClash",
    val stopText: String = "Stop",
    val onlyStatisticsProxy: Boolean = false,
)

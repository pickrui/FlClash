package com.dler.clash.service.models

import android.os.Parcelable
import kotlinx.parcelize.Parcelize

@Parcelize
data class NotificationParams(
    val title: String = "FlClash for Dler Cloud",
    val stopText: String = "STOP",
    val onlyStatisticsProxy: Boolean = false,
) : Parcelable
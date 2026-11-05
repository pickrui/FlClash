package com.oixcloud.clash.common

import android.content.ComponentName

object Components {
    const val PACKAGE_NAME = "com.oixcloud.clash"

    val MAIN_ACTIVITY =
        ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.MainActivity")

    val TEMP_ACTIVITY =
        ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.TempActivity")

    val BROADCAST_RECEIVER =
        ComponentName(GlobalState.packageName, "${PACKAGE_NAME}.BroadcastReceiver")
}
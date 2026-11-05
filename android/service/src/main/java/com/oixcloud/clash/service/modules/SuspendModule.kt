package com.oixcloud.clash.service.modules

import android.app.Service
import android.content.Intent
import android.os.PowerManager
import androidx.core.content.getSystemService
import com.oixcloud.clash.common.receiveBroadcastFlow
import com.oixcloud.clash.core.Core
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.cancel
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.onStart
import kotlinx.coroutines.launch


class SuspendModule(private val service: Service) : Module() {
    private val scope = CoroutineScope(Dispatchers.Default)

    private fun isScreenOn(): Boolean {
        val pm = service.getSystemService<PowerManager>()
        return when (pm != null) {
            true -> pm.isInteractive
            false -> true
        }
    }

    val isDeviceIdleMode: Boolean
        get() {
            return service.getSystemService<PowerManager>()?.isDeviceIdleMode ?: true
        }

    private fun onUpdate(isScreenOn: Boolean) {
        if (isScreenOn) {
            Core.suspended(false)
            return
        }
        Core.suspended(isDeviceIdleMode)
    }

    override fun onInstall() {
        scope.launch {
            service.receiveBroadcastFlow {
                addAction(Intent.ACTION_SCREEN_ON)
                addAction(Intent.ACTION_SCREEN_OFF)
                addAction(PowerManager.ACTION_DEVICE_IDLE_MODE_CHANGED)
            }.onStart {
                emit(Intent())
            }.collect { intent ->
                if (intent.action == Intent.ACTION_SCREEN_ON) {
                    Core.suspended(false)
                } else {
                    onUpdate(isScreenOn())
                }
            }
        }
    }

    override fun onUninstall() {
        scope.cancel()
        Core.suspended(false)
    }
}

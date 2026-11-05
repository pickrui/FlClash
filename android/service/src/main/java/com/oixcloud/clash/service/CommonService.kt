package com.oixcloud.clash.service

import android.app.Service
import android.content.ComponentCallbacks2
import android.content.Intent
import android.os.Binder
import android.os.IBinder
import com.oixcloud.clash.core.Core
import com.oixcloud.clash.common.GlobalState
import com.oixcloud.clash.service.modules.NetworkObserveModule
import com.oixcloud.clash.service.modules.NotificationModule
import com.oixcloud.clash.service.modules.SuspendModule
import com.oixcloud.clash.service.modules.moduleLoader
class CommonService : Service(), IBaseService {

    private val self: CommonService
        get() = this

    private val loader = moduleLoader {
        install(NetworkObserveModule(self))
        install(NotificationModule(self))
        install(SuspendModule(self))
    }

    override fun onCreate() {
        super.onCreate()
        handleCreate()
    }

    override fun onDestroy() {
        runCatching { loader.cancel() }.onFailure {
            GlobalState.log("Background service cleanup failed: $it")
        }
        handleDestroy()
        super.onDestroy()
    }

    override fun onLowMemory() {
        Core.forceGC()
        super.onLowMemory()
    }

    override fun onTrimMemory(level: Int) {
        if (level >= ComponentCallbacks2.TRIM_MEMORY_BACKGROUND ||
            level == ComponentCallbacks2.TRIM_MEMORY_RUNNING_CRITICAL
        ) {
            Core.forceGC()
        }
        super.onTrimMemory(level)
    }

    private val binder = LocalBinder()

    inner class LocalBinder : Binder() {
        fun getService(): CommonService = this@CommonService
    }

    override fun onBind(intent: Intent): IBinder {
        return binder
    }

    override fun start() {
        startWithCleanup(start = loader::load, cleanup = ::stop)
    }

    override fun stop() {
        try {
            loader.cancel()
        } finally {
            stopSelf()
        }
    }
}

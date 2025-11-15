package com.dler.clash.service

import android.app.Service
import android.content.Intent
import android.os.Binder
import android.os.IBinder
import com.dler.clash.core.Core
import com.dler.clash.service.modules.NetworkObserveModule
import com.dler.clash.service.modules.NotificationModule
import com.dler.clash.service.modules.SuspendModule
import com.dler.clash.service.modules.moduleLoader
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers

class CommonService : Service(), IBaseService,
    CoroutineScope by CoroutineScope(Dispatchers.Default) {

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
        handleDestroy()
        super.onDestroy()
    }

    override fun onLowMemory() {
        Core.forceGC()
        super.onLowMemory()
    }

    private val binder = LocalBinder()

    inner class LocalBinder : Binder() {
        fun getService(): CommonService = this@CommonService
    }

    override fun onBind(intent: Intent): IBinder {
        return binder
    }

    override fun start() {
        loader.load()
    }

    override fun stop() {
        loader.cancel()
        stopSelf()
    }
}
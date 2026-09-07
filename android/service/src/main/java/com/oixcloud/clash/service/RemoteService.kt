package com.oixcloud.clash.service

import android.app.Service
import android.content.Intent
import android.os.IBinder
import com.oixcloud.clash.common.GlobalState
import com.oixcloud.clash.common.BroadcastAction
import com.oixcloud.clash.common.ServiceDelegate
import com.oixcloud.clash.common.chunkedForAidl
import com.oixcloud.clash.common.intent
import com.oixcloud.clash.common.sendBroadcast
import com.oixcloud.clash.core.Core
import com.oixcloud.clash.service.State.delegate
import com.oixcloud.clash.service.State.intent
import com.oixcloud.clash.service.State.runLock
import com.oixcloud.clash.service.models.NotificationParams
import com.oixcloud.clash.service.models.VpnOptions
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlinx.coroutines.sync.withLock
import java.util.UUID
import kotlin.coroutines.resume

class RemoteService : Service(),
    CoroutineScope by CoroutineScope(SupervisorJob() + Dispatchers.Default) {
    private fun handleStopService(result: IResultInterface) {
        launch {
            runLock.withLock {
                val currentDelegate = delegate
                val stopped = when {
                    currentDelegate != null -> currentDelegate.useService { it.stop() }
                    State.runTime == 0L -> Result.success(Unit)
                    else -> Result.failure(IllegalStateException("Background service is unavailable"))
                }
                stopped.onSuccess {
                    clearBinding(currentDelegate)
                    State.runTime = 0
                }.onFailure {
                    GlobalState.log("Background service stop failed: $it")
                }
                result.onResult(State.runTime)
            }
        }
    }

    private fun clearBinding(currentDelegate: ServiceDelegate<IBaseService>?) {
        if (delegate !== currentDelegate) return
        delegate = null
        intent = null
        currentDelegate?.unbind()
    }

    private fun handleServiceDisconnected(
        currentDelegate: ServiceDelegate<IBaseService>,
        message: String,
    ) {
        GlobalState.log("Background service disconnected: $message")
        launch {
            runLock.withLock {
                if (delegate !== currentDelegate) return@withLock
                clearBinding(currentDelegate)
                State.runTime = 0L
                BroadcastAction.SERVICE_DESTROYED.sendBroadcast()
            }
        }
    }

    private fun handleStartService(options: VpnOptions, runTime: Long, result: IResultInterface) {
        launch {
            runLock.withLock {
                var startingService: IBaseService? = null
                val started = runCatching {
                    State.options = options
                    val nextIntent = when (options.enable) {
                        true -> VpnService::class.intent
                        false -> CommonService::class.intent
                    }
                    if (delegate == null || intent?.filterEquals(nextIntent) != true) {
                        // Finish the previous service before its replacement can
                        // install modules or take ownership of the TUN interface.
                        delegate?.useService {
                            startingService = it
                            it.stop()
                        }?.getOrThrow()
                        startingService = null
                        clearBinding(delegate)
                        lateinit var nextDelegate: ServiceDelegate<IBaseService>
                        nextDelegate = ServiceDelegate(
                            nextIntent,
                            { message -> handleServiceDisconnected(nextDelegate, message) },
                        ) { binder ->
                            when (binder) {
                                is VpnService.LocalBinder -> binder.getService()
                                is CommonService.LocalBinder -> binder.getService()
                                else -> throw IllegalArgumentException("Invalid binder type")
                            }
                        }
                        delegate = nextDelegate
                        intent = nextIntent
                        nextDelegate.bind()
                    }
                    checkNotNull(delegate).useService { service ->
                        startingService = service
                        service.start()
                    }.getOrThrow()
                    when (runTime != 0L) {
                        true -> runTime
                        false -> System.currentTimeMillis()
                    }
                }
                State.runTime = started.getOrElse { error ->
                    // A synchronous JNI start can finish after useService's
                    // timeout. Roll it back before unbinding or returning zero.
                    runCatching { startingService?.stop() }.onFailure {
                        if (it !== error) error.addSuppressed(it)
                    }
                    GlobalState.log("Background service start failed: $error")
                    clearBinding(delegate)
                    0L
                }
                result.onResult(State.runTime)
            }
        }
    }

    private val binder = object : IRemoteInterface.Stub() {
        override fun invokeMethod(data: String, callback: ICallbackInterface) {
            Core.invokeMethod(data) {
                launch {
                    runCatching {
                        val chunks = it?.chunkedForAidl() ?: listOf()
                        for ((index, chunk) in chunks.withIndex()) {
                            suspendCancellableCoroutine { cont ->
                                callback.onResult(
                                    chunk,
                                    index == chunks.lastIndex,
                                    object : IAckInterface.Stub() {
                                        override fun onAck() {
                                            cont.resume(Unit)
                                        }
                                    },
                                )
                            }
                        }
                    }
                }
            }
        }

        override fun quickSetup(
            initParamsString: String,
            setupParamsString: String,
            callback: ICallbackInterface,
            onStarted: IVoidInterface
        ) {
            Core.quickSetup(initParamsString, setupParamsString) {
                launch {
                    runCatching {
                        val chunks = it?.chunkedForAidl() ?: listOf()
                        for ((index, chunk) in chunks.withIndex()) {
                            suspendCancellableCoroutine { cont ->
                                callback.onResult(
                                    chunk,
                                    index == chunks.lastIndex,
                                    object : IAckInterface.Stub() {
                                        override fun onAck() {
                                            cont.resume(Unit)
                                        }
                                    },
                                )
                            }
                        }
                    }
                }
            }
            onStarted()
        }

        override fun updateNotificationParams(params: NotificationParams?) {
            State.notificationParamsFlow.tryEmit(params)
        }


        override fun startService(
            options: VpnOptions,
            runtime: Long,
            result: IResultInterface,
        ) {
            GlobalState.log("remote startService")
            handleStartService(options, runtime, result)
        }

        override fun stopService(result: IResultInterface) {
            handleStopService(result)
        }

        override fun setEventListener(eventListener: IEventInterface?) {
            GlobalState.log("RemoveEventListener ${eventListener == null}")
            when (eventListener != null) {
                true -> Core.callSetEventListener {
                    launch {
                        runCatching {
                            val id = UUID.randomUUID().toString()
                            val chunks = it?.chunkedForAidl() ?: listOf()
                            for ((index, chunk) in chunks.withIndex()) {
                                suspendCancellableCoroutine { cont ->
                                    eventListener.onEvent(
                                        id,
                                        chunk,
                                        index == chunks.lastIndex,
                                        object : IAckInterface.Stub() {
                                            override fun onAck() {
                                                cont.resume(Unit)
                                            }
                                        },
                                    )
                                }
                            }
                        }
                    }
                }

                false -> Core.callSetEventListener(null)
            }
        }


        override fun getRunTime(): Long {
            return State.runTime
        }
    }

    override fun onBind(intent: Intent?): IBinder {
        return binder
    }

    override fun onDestroy() {
        GlobalState.log("Remote service destroy")
        super.onDestroy()
    }
}

package com.oixcloud.clash

import android.net.VpnService
import com.oixcloud.clash.common.GlobalState
import com.oixcloud.clash.common.QuickAction
import com.oixcloud.clash.models.SharedState
import com.oixcloud.clash.plugins.AppPlugin
import com.oixcloud.clash.plugins.TilePlugin
import com.oixcloud.clash.service.models.NotificationParams
import com.google.gson.Gson
import io.flutter.embedding.engine.FlutterEngine
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlinx.coroutines.sync.Mutex
import kotlinx.coroutines.sync.withLock
import kotlinx.coroutines.withContext
import kotlinx.coroutines.withTimeout
import kotlin.coroutines.resume

enum class RunState {
    START, PENDING, STOP
}


object State {

    val runLock = Mutex()

    var runTime: Long = 0
    private var startRevision = 0

    var sharedState: SharedState = SharedState()

    val runStateFlow: MutableStateFlow<RunState> = MutableStateFlow(RunState.STOP)

    var flutterEngine: FlutterEngine? = null

    val appPlugin: AppPlugin?
        get() = flutterEngine?.plugin<AppPlugin>()

    val tilePlugin: TilePlugin?
        get() = flutterEngine?.plugin<TilePlugin>()

    private val quickActions = QuickActionHandler(
        isRunning = {
            runLock.withLock {
                Service.bind()
                // Do not interpret a failed query as STOP and accidentally start.
                runTime = Service.getRunTime()
                runStateFlow.value = if (runTime == 0L) RunState.STOP else RunState.START
                runTime != 0L
            }
        },
        start = ::handleStartServiceAction,
        stop = ::handleStopServiceAction,
    )

    suspend fun handleQuickAction(action: QuickAction) {
        quickActions.handle(action)
    }

    suspend fun handleSyncState() {
        runLock.withLock {
            try {
                Service.bind()
                runTime = Service.getRunTime()
                val runState = when (runTime == 0L) {
                    true -> RunState.STOP
                    false -> RunState.START
                }
                runStateFlow.tryEmit(runState)
            } catch (error: CancellationException) {
                throw error
            } catch (error: Exception) {
                // A transport failure is not evidence that the VPN stopped.
                GlobalState.log("VPN state query failed: $error")
            }
        }
    }

    suspend fun handleStartServiceAction() {
        // Dart calls back into the service while handling this request.
        // Never hold runLock across the Flutter channel round trip.
        val plugin = runLock.withLock {
            if (runStateFlow.value != RunState.STOP) return
            tilePlugin
        }
        plugin?.let {
            it.handleStart()
            return
        }
        runLock.withLock {
            if (runStateFlow.value != RunState.STOP) {
                return
            }
            sharedState = GlobalState.application.sharedState
            setupAndStart()
        }

    }

    suspend fun handleStopServiceAction() {
        val plugin = runLock.withLock {
            if (runStateFlow.value != RunState.START) return
            // Stopping must remain available even if Dart cannot load its key.
            tilePlugin?.takeIf { it.isReady }
        }
        plugin?.let {
            it.handleStop()
            return
        }
        runLock.withLock {
            if (runStateFlow.value != RunState.START) {
                return
            }
            sharedState = GlobalState.application.sharedState
            GlobalState.application.showToast(sharedState.stopTip)
            stopServiceLocked()
            check(runTime == 0L) { "VPN service did not stop" }
        }
    }

    suspend fun handleStartService() = withTimeout(60_000) {
        val revision = runLock.withLock { ++startRevision }
        val options = sharedState.vpnOptions
            ?: throw IllegalStateException("Open the app to configure the VPN first")
        val plugin = appPlugin
        if (plugin != null) {
            withContext(Dispatchers.Main) {
                suspendCancellableCoroutine<Unit> { continuation ->
                    plugin.requestNotificationsPermission {
                        if (continuation.isActive) continuation.resume(Unit)
                    }
                }
            }
            val allowed = withContext(Dispatchers.Main) {
                suspendCancellableCoroutine<Boolean> { continuation ->
                    plugin.prepare(options.enable) {
                        if (continuation.isActive) continuation.resume(it)
                    }
                }
            }
            check(allowed) { "VPN permission was not granted" }
        } else {
            check(!options.enable || VpnService.prepare(GlobalState.application) == null) {
                "Open the app and allow the VPN connection first"
            }
        }
        runLock.withLock {
            check(revision == startRevision) { "VPN start was cancelled" }
            if (runStateFlow.value == RunState.START) return@withLock
            runStateFlow.value = RunState.PENDING
            startWithRollback(
                block = {
                    runTime = Service.startService(options, runTime)
                    check(runTime != 0L) { "VPN service did not start" }
                    runStateFlow.value = RunState.START
                },
                rollback = ::rollbackStart,
            )
        }
    }

    suspend fun syncState() {
        Service.updateNotificationParams(
            NotificationParams(
                title = sharedState.currentProfileName,
                stopText = sharedState.stopText,
                onlyStatisticsProxy = sharedState.onlyStatisticsProxy
            )
        )
    }

    private suspend fun setupAndStart() {
        val options = sharedState.vpnOptions
            ?: throw IllegalStateException("Open the app to configure the VPN first")
        if (options.enable && VpnService.prepare(GlobalState.application) != null) {
            throw IllegalStateException("Open the app and allow the VPN connection first")
        }
        val configAgeSecretKey = try {
            ConfigKeyReader.read(GlobalState.application)
        } catch (error: CancellationException) {
            throw error
        } catch (_: Exception) {
            throw IllegalStateException("Open the app to restore access to the configuration key")
        }
            ?: throw IllegalStateException("Open the app to restore access to the configuration key")
        Service.bind()
        syncState()
        GlobalState.application.showToast(sharedState.startTip)
        val initParams = mutableMapOf<String, Any>()
        initParams["home-dir"] = GlobalState.application.filesDir.path
        initParams["version"] = android.os.Build.VERSION.SDK_INT
        initParams["profile-key"] = BuildConfig.PROFILE_KEY
        initParams["config-age-secret-key"] = configAgeSecretKey
        val initParamsString = Gson().toJson(initParams)
        val setupParamsString = Gson().toJson(sharedState.setupParams)
        runStateFlow.value = RunState.PENDING
        startWithRollback(
            block = {
                val result = withTimeout(60_000) {
                    val completion = CompletableDeferred<String>()
                    Service.quickSetup(
                        initParamsString,
                        setupParamsString,
                        onStarted = null,
                        onResult = { completion.complete(it) },
                    ).getOrThrow()
                    completion.await()
                }
                check(result.isEmpty()) { result }
                runTime = Service.startService(options, runTime)
                check(runTime != 0L) { "VPN service did not start" }
                runStateFlow.value = RunState.START
            },
            rollback = ::rollbackStart,
        )
    }

    private suspend fun rollbackStart() {
        var failure: Throwable? = null
        try {
            // A timed-out start RPC may still complete in RemoteService. Its
            // serialized stop must finish before core listener cleanup.
            runTime = withTimeout(5_000) { Service.stopService() }
            runStateFlow.value = if (runTime == 0L) RunState.STOP else RunState.START
            check(runTime == 0L) { "VPN startup rollback did not stop the service" }
        } catch (error: Throwable) {
            failure = error
            try {
                runTime = withTimeout(5_000) { Service.getRunTime() }
                runStateFlow.value = if (runTime == 0L) RunState.STOP else RunState.START
            } catch (queryError: Throwable) {
                if (queryError !== error) error.addSuppressed(queryError)
                // Keep the state unknown when both stop and query failed.
                runStateFlow.value = RunState.PENDING
            }
        }
        try {
            withTimeout(5_000) { Service.stopListener() }
        } catch (error: Throwable) {
            if (failure == null) failure = error
            else if (failure !== error) failure.addSuppressed(error)
        }
        failure?.let { throw it }
    }

    suspend fun handleStopService() {
        runLock.withLock {
            ++startRevision
            if (runStateFlow.value != RunState.START) {
                return
            }
            stopServiceLocked()
            check(runTime == 0L) { "VPN service did not stop" }
        }
    }

    private suspend fun stopServiceLocked() {
        try {
            runStateFlow.value = RunState.PENDING
            runTime = Service.stopService()
            runStateFlow.value = if (runTime == 0L) RunState.STOP else RunState.START
        } finally {
            if (runStateFlow.value == RunState.PENDING) {
                runStateFlow.value = RunState.START
            }
        }
    }
}

package com.oixcloud.clash.plugins

import com.oixcloud.clash.common.Components
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import kotlinx.coroutines.withTimeout

class TilePlugin : FlutterPlugin, MethodChannel.MethodCallHandler {

    private lateinit var channel: MethodChannel
    private val stateLock = Any()
    private var attached = false
    private var readiness = CompletableDeferred<Unit>()
    private val pendingCalls = mutableSetOf<CompletableDeferred<Boolean>>()

    val isReady: Boolean
        get() = synchronized(stateLock) { attached && readiness.isCompleted }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel =
            MethodChannel(flutterPluginBinding.binaryMessenger, "${Components.PACKAGE_NAME}/tile")
        channel.setMethodCallHandler(this)
        synchronized(stateLock) {
            attached = true
            readiness = CompletableDeferred()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        synchronized(stateLock) {
            attached = false
            val error = IllegalStateException("Flutter shortcut handler was detached")
            readiness.completeExceptionally(error)
            pendingCalls.forEach { it.completeExceptionally(error) }
        }
    }

    suspend fun handleStart() {
        handleAction("start")
    }

    suspend fun handleStop() {
        handleAction("stop")
    }

    private suspend fun handleAction(method: String) {
        val ready = synchronized(stateLock) {
            check(attached) { "Flutter shortcut handler is not attached" }
            readiness
        }
        // Only initialization is timed out: an accepted Dart operation may wait
        // for a permission dialog and must retain ownership until it finishes.
        withTimeout(60_000) { ready.await() }
        val response = CompletableDeferred<Boolean>()
        try {
            withContext(Dispatchers.Main) {
                synchronized(stateLock) {
                    // A detached engine or a new initialization cycle cannot
                    // inherit an action accepted by the previous handler.
                    check(attached && readiness === ready) {
                        "Flutter shortcut handler changed before dispatch"
                    }
                    pendingCalls.add(response)
                }
                channel.invokeMethod(method, null, object : MethodChannel.Result {
                    override fun success(result: Any?) {
                        response.complete(result == true)
                    }

                    override fun error(code: String, message: String?, details: Any?) {
                        response.completeExceptionally(
                            IllegalStateException(message ?: code),
                        )
                    }

                    override fun notImplemented() {
                        response.completeExceptionally(
                            IllegalStateException("Flutter shortcut handler is unavailable"),
                        )
                    }
                })
            }
            check(response.await()) { "Flutter shortcut handler is not ready" }
        } finally {
            synchronized(stateLock) { pendingCalls.remove(response) }
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method != "setReady") {
            result.notImplemented()
            return
        }
        synchronized(stateLock) {
            if (call.arguments == true) {
                readiness.complete(Unit)
            } else if (readiness.isCompleted) {
                readiness = CompletableDeferred()
            }
        }
        result.success(null)
    }
}

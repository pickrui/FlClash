package com.oixcloud.clash.service

import android.app.Service
import android.content.Intent
import android.os.IBinder
import com.oixcloud.clash.common.chunkedForAidl
import com.oixcloud.clash.common.maxValidationMessageBytes
import com.oixcloud.clash.core.Core
import com.google.gson.JsonParser
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlinx.coroutines.withTimeoutOrNull
import java.io.File
import java.io.ByteArrayOutputStream
import kotlin.coroutines.resume

class ValidatorService : Service(),
    CoroutineScope by CoroutineScope(SupervisorJob() + Dispatchers.Default) {
    private var validatorHome: File? = null
    private var initAction: String? = null
    private var resultCallback: ICallbackInterface? = null
    private var requestBuffer: ByteArrayOutputStream? = null

    private val binder = object : IValidatorInterface.Stub() {
        override fun begin(
            initAction: String,
            callback: ICallbackInterface,
            ack: IAckInterface,
        ) {
            this@ValidatorService.initAction = initAction
            resultCallback = callback
            requestBuffer = ByteArrayOutputStream()
            ack.onAck()
        }

        override fun sendChunk(data: ByteArray, isLast: Boolean, ack: IAckInterface) {
            val buffer = requestBuffer
            if (buffer == null ||
                buffer.size() > maxValidationMessageBytes - data.size
            ) {
                throw IllegalStateException("invalid validator request")
            }
            buffer.write(data)
            ack.onAck()
            if (!isLast) return
            requestBuffer = null
            val action = buffer.toString(Charsets.UTF_8.name())
            val callback = resultCallback ?: throw IllegalStateException("missing callback")
            val currentInitAction = this@ValidatorService.initAction
                ?: throw IllegalStateException("missing init action")
            launch {
                val isolatedInitAction = runCatching {
                    prepareValidatorHome(currentInitAction)
                }.getOrElse {
                    deliverAndFinish(
                        validationError(action, "validator setup failed: ${it.message}"),
                        callback,
                    )
                    return@launch
                }
                Core.invokeAction(isolatedInitAction) { initResult ->
                    if (!isSuccessfulInit(initResult)) {
                        deliverAndFinish(
                            validationError(action, "validator initialization failed"),
                            callback,
                        )
                        return@invokeAction
                    }
                    Core.invokeAction(action) { result ->
                        deliverAndFinish(
                            result ?: validationError(action, "validator returned no result"),
                            callback,
                        )
                    }
                }
            }
        }

        override fun shutdown() {
            requestBuffer = null
            resultCallback = null
            initAction = null
            cleanupValidatorHome()
            stopSelf()
            android.os.Process.killProcess(android.os.Process.myPid())
        }
    }

    override fun onBind(intent: Intent): IBinder = binder

    override fun onCreate() {
        super.onCreate()
        cacheDir.listFiles()
            ?.filter { it.name.startsWith("validator-") }
            ?.forEach { it.deleteRecursively() }
    }

    override fun onUnbind(intent: Intent?): Boolean {
        cleanupValidatorHome()
        stopSelf()
        android.os.Process.killProcess(android.os.Process.myPid())
        return false
    }

    private fun isSuccessfulInit(result: String?): Boolean {
        return runCatching {
            JsonParser.parseString(result).asJsonObject
                .getAsJsonPrimitive("data")
                .asBoolean
        }.getOrDefault(false)
    }

    private fun prepareValidatorHome(initAction: String): String {
        val action = JsonParser.parseString(initAction).asJsonObject
        val params = JsonParser.parseString(action.getAsJsonPrimitive("data").asString)
            .asJsonObject
        val sourceHome = File(params.getAsJsonPrimitive("home-dir").asString)
        val targetHome = File(cacheDir, "validator-${android.os.Process.myPid()}")
        targetHome.deleteRecursively()
        check(targetHome.mkdirs())
        validatorHome = targetHome
        return try {
            params.addProperty("validation-source-home", sourceHome.path)
            params.addProperty("home-dir", targetHome.path)
            action.addProperty("data", params.toString())
            action.toString()
        } catch (error: Throwable) {
            cleanupValidatorHome()
            throw error
        }
    }

    private fun cleanupValidatorHome() {
        validatorHome?.deleteRecursively()
        validatorHome = null
    }

    private fun validationError(action: String, message: String): String {
        return runCatching {
            JsonParser.parseString(action).asJsonObject.apply {
                addProperty("data", message)
                addProperty("code", 0)
            }.toString()
        }.getOrElse {
            "{\"id\":\"\",\"method\":\"validateConfig\",\"data\":\"$message\",\"code\":0}"
        }
    }

    private fun deliverAndFinish(result: String, callback: ICallbackInterface) {
        launch {
            runCatching {
                val chunks = result.chunkedForAidl(
                    maxTotalBytes = maxValidationMessageBytes,
                )
                for ((index, chunk) in chunks.withIndex()) {
                    val acknowledged = withTimeoutOrNull(5_000) {
                        suspendCancellableCoroutine { continuation ->
                            callback.onResult(
                                chunk,
                                index == chunks.lastIndex,
                                object : IAckInterface.Stub() {
                                    override fun onAck() {
                                        if (continuation.isActive) {
                                            continuation.resume(Unit)
                                        }
                                    }
                                },
                            )
                        }
                        true
                    }
                    if (acknowledged != true) {
                        throw IllegalStateException("validator callback was not acknowledged")
                    }
                }
            }.onFailure {
                cleanupValidatorHome()
                stopSelf()
                android.os.Process.killProcess(android.os.Process.myPid())
            }
        }
    }
}
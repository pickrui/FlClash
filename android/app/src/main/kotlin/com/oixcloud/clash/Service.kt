package com.oixcloud.clash

import android.os.IBinder
import android.os.RemoteException
import com.oixcloud.clash.common.GlobalState
import com.oixcloud.clash.common.ServiceDelegate
import com.oixcloud.clash.common.chunkedForAidl
import com.oixcloud.clash.common.formatString
import com.oixcloud.clash.common.intent
import com.oixcloud.clash.common.maxValidationMessageBytes
import com.oixcloud.clash.service.IAckInterface
import com.oixcloud.clash.service.ICallbackInterface
import com.oixcloud.clash.service.IEventInterface
import com.oixcloud.clash.service.IRemoteInterface
import com.oixcloud.clash.service.IResultInterface
import com.oixcloud.clash.service.IValidatorInterface
import com.oixcloud.clash.service.IVoidInterface
import com.oixcloud.clash.service.RemoteService
import com.oixcloud.clash.service.ValidatorService
import com.oixcloud.clash.service.models.NotificationParams
import com.oixcloud.clash.service.models.VpnOptions
import com.google.gson.JsonObject
import com.google.gson.JsonParser
import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlinx.coroutines.sync.Mutex
import kotlinx.coroutines.sync.withLock
import kotlinx.coroutines.withTimeoutOrNull
import java.util.concurrent.atomic.AtomicBoolean
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException

object Service {
    private const val INIT_METHOD = "initClash"
    private val validationMethods = setOf("validateConfig", "validateConfigWithBytes")
    private val validationMutex = Mutex()
    @Volatile
    private var validatorInitAction: String? = null

    private val delegate by lazy {
        ServiceDelegate<IRemoteInterface>(
            RemoteService::class.intent, ::handleServiceDisconnected
        ) {
            IRemoteInterface.Stub.asInterface(it)
        }
    }

    var onServiceDisconnected: ((String) -> Unit)? = null

    private fun handleServiceDisconnected(message: String) {
        onServiceDisconnected?.let {
            it(message)
        }
    }

    fun bind() {
        delegate.bind()
    }

    fun unbind() {
        delegate.unbind()
    }

    suspend fun invokeAction(data: String, cb: ((result: String) -> Unit)?): Result<Unit> {
        val method = runCatching {
            JsonParser.parseString(data).asJsonObject.getAsJsonPrimitive("method").asString
        }.getOrNull()
        if (method in validationMethods) {
            return validationMutex.withLock {
                invokeValidatorAction(data, cb)
            }
        }
        val res = mutableListOf<ByteArray>()
        return delegate.useService {
            it.invokeAction(
                data, object : ICallbackInterface.Stub() {
                    override fun onResult(
                        result: ByteArray?, isSuccess: Boolean, ack: IAckInterface?
                    ) {
                        res.add(result ?: byteArrayOf())
                        ack?.onAck()
                        if (isSuccess) {
                            val output = res.formatString()
                            if (method == INIT_METHOD && isSuccessfulInit(output)) {
                                validatorInitAction = data
                            }
                            cb?.let { cb ->
                                cb(output)
                            }
                        }
                    }
                })
        }
    }

    private suspend fun invokeValidatorAction(
        data: String,
        cb: ((result: String) -> Unit)?,
    ): Result<Unit> {
        val initAction = validatorInitAction
            ?: return Result.failure(IllegalStateException("validator is not initialized"))
        val validator = ServiceDelegate<IValidatorInterface>(
            ValidatorService::class.intent,
            interfaceCreator = { IValidatorInterface.Stub.asInterface(it) },
        )
        validator.bind()
        var validatorService: IValidatorInterface? = null
        return try {
            validator.useService(timeoutMillis = 30_000) { service ->
                validatorService = service
                val binder = service.asBinder()
                val response = CompletableDeferred<Unit>()
                val responseChunks = mutableListOf<ByteArray>()
                var responseBytes = 0
                val deathRecipient = IBinder.DeathRecipient {
                    response.completeExceptionally(
                        IllegalStateException("validator process died"),
                    )
                }
                binder.linkToDeath(deathRecipient, 0)
                val callback = object : ICallbackInterface.Stub() {
                    override fun onResult(
                        result: ByteArray?,
                        isSuccess: Boolean,
                        ack: IAckInterface?,
                    ) {
                        val chunk = result ?: byteArrayOf()
                        if (responseBytes > maxValidationMessageBytes - chunk.size) {
                            ack?.onAck()
                            response.completeExceptionally(
                                IllegalStateException("validator response is too large"),
                            )
                            return
                        }
                        responseBytes += chunk.size
                        responseChunks.add(chunk)
                        ack?.onAck()
                        if (isSuccess) {
                            runCatching { cb?.invoke(responseChunks.formatString()) }
                                .onSuccess { response.complete(Unit) }
                                .onFailure(response::completeExceptionally)
                        }
                    }
                }
                try {
                    awaitValidatorAck { ack -> service.begin(initAction, callback, ack) }
                    val requestChunks = data.chunkedForAidl(
                        maxTotalBytes = maxValidationMessageBytes,
                    )
                    for ((index, chunk) in requestChunks.withIndex()) {
                        awaitValidatorAck { ack ->
                            service.sendChunk(chunk, index == requestChunks.lastIndex, ack)
                        }
                    }
                    response.await()
                } finally {
                    runCatching { binder.unlinkToDeath(deathRecipient, 0) }
                }
            }
        } finally {
            validatorService?.let { service ->
                withTimeoutOrNull(5_000) {
                    shutdownValidator(service)
                }
            }
            validator.unbind()
        }
    }

    private suspend fun awaitValidatorAck(send: (IAckInterface) -> Unit) {
        val acknowledged = withTimeoutOrNull(5_000) {
            suspendCancellableCoroutine { continuation ->
                try {
                    send(object : IAckInterface.Stub() {
                        override fun onAck() {
                            if (continuation.isActive) continuation.resume(Unit)
                        }
                    })
                } catch (error: Throwable) {
                    if (continuation.isActive) continuation.resumeWithException(error)
                }
            }
            true
        }
        if (acknowledged != true) {
            throw IllegalStateException("validator request was not acknowledged")
        }
    }

    private suspend fun shutdownValidator(service: IValidatorInterface) {
        suspendCancellableCoroutine { continuation ->
            val binder = service.asBinder()
            val completed = AtomicBoolean(false)
            lateinit var recipient: IBinder.DeathRecipient
            fun finish() {
                if (!completed.compareAndSet(false, true)) {
                    return
                }
                runCatching { binder.unlinkToDeath(recipient, 0) }
                if (continuation.isActive) {
                    continuation.resume(Unit)
                }
            }
            recipient = IBinder.DeathRecipient { finish() }
            try {
                binder.linkToDeath(recipient, 0)
                service.shutdown()
                if (!binder.isBinderAlive) {
                    finish()
                }
            } catch (_: RemoteException) {
                finish()
            }
            continuation.invokeOnCancellation {
                if (completed.compareAndSet(false, true)) {
                    runCatching { binder.unlinkToDeath(recipient, 0) }
                }
            }
        }
    }

    private fun isSuccessfulInit(result: String): Boolean {
        return runCatching {
            JsonParser.parseString(result).asJsonObject
                .getAsJsonPrimitive("data")
                .asBoolean
        }.getOrDefault(false)
    }

    suspend fun quickSetup(
        initParamsString: String,
        setupParamsString: String,
        onStarted: (() -> Unit)?,
        onResult: ((result: String) -> Unit)?,
    ): Result<Unit> {
        validatorInitAction = JsonObject().apply {
            addProperty("id", "validator-init")
            addProperty("method", INIT_METHOD)
            addProperty("data", initParamsString)
        }.toString()
        val res = mutableListOf<ByteArray>()
        return delegate.useService {
            it.quickSetup(
                initParamsString,
                setupParamsString,
                object : ICallbackInterface.Stub() {
                    override fun onResult(
                        result: ByteArray?, isSuccess: Boolean, ack: IAckInterface?
                    ) {
                        res.add(result ?: byteArrayOf())
                        ack?.onAck()
                        if (isSuccess) {
                            onResult?.let { cb ->
                                cb(res.formatString())
                            }
                        }
                    }
                },
                object : IVoidInterface.Stub() {
                    override fun invoke() {
                        onStarted?.let { onStarted ->
                            onStarted()
                        }
                    }
                }
            )
        }
    }

    suspend fun setEventListener(
        cb: ((result: String?) -> Unit)?
    ): Result<Unit> {
        val results = HashMap<String, MutableList<ByteArray>>()
        return delegate.useService {
            it.setEventListener(
                when (cb != null) {
                    true -> object : IEventInterface.Stub() {
                        override fun onEvent(
                            id: String, data: ByteArray?, isSuccess: Boolean, ack: IAckInterface?
                        ) {
                            if (results[id] == null) {
                                results[id] = mutableListOf()
                            }
                            results[id]?.add(data ?: byteArrayOf())
                            ack?.onAck()
                            if (isSuccess) {
                                cb(results[id]?.formatString())
                                results.remove(id)
                            }
                        }
                    }

                    false -> null
                })
        }
    }

    suspend fun updateNotificationParams(
        params: NotificationParams
    ): Result<Unit> {
        return delegate.useService {
            it.updateNotificationParams(params)
        }
    }

    private suspend fun awaitIResultInterface(
        block: (IResultInterface) -> Unit
    ): Long = suspendCancellableCoroutine { continuation ->
        val callback = object : IResultInterface.Stub() {
            override fun onResult(time: Long) {
                if (continuation.isActive) {
                    continuation.resume(time)
                }
            }
        }

        try {
            block(callback)
        } catch (e: Exception) {
            GlobalState.log("awaitIResultInterface $e")
            if (continuation.isActive) {
                continuation.resumeWithException(e)
            }
        }
    }


    suspend fun startService(options: VpnOptions, runTime: Long): Long {
        return delegate.useService {
            awaitIResultInterface { callback ->
                it.startService(options, runTime, callback)
            }
        }.getOrNull() ?: 0L
    }

    suspend fun stopService(): Long {
        return delegate.useService {
            awaitIResultInterface { callback ->
                it.stopService(callback)
            }
        }.getOrNull() ?: 0L
    }

    suspend fun getRunTime(): Long {
        return delegate.useService {
            it.runTime
        }.getOrNull() ?: 0L
    }
}
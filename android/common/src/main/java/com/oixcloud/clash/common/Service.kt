package com.oixcloud.clash.common

import android.content.Intent
import android.os.IBinder
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.map

class ServiceDelegate<T>(
    intent: Intent,
    onServiceDisconnected: ((String) -> Unit)? = null,
    interfaceCreator: (IBinder) -> T,
) {
    private val binding = ServiceBinding(
        scope = CoroutineScope(SupervisorJob() + Dispatchers.Default),
        connect = {
            GlobalState.application.bindServiceFlow<IBinder>(intent).map { (binder, message) ->
                Pair(binder?.let(interfaceCreator), message)
            }
        },
        onServiceDisconnected = onServiceDisconnected,
    )

    val serviceState: StateFlow<Pair<T?, String>?> = binding.serviceState

    fun bind() = binding.bind()

    suspend fun <R> useService(
        timeoutMillis: Long = 5000,
        block: suspend (T) -> R,
    ): Result<R> = binding.useService(timeoutMillis, block)

    fun unbind() = binding.unbind()
}

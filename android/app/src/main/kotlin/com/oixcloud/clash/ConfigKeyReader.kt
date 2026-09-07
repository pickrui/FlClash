package com.oixcloud.clash

import android.content.Context
import com.it_nomads.fluttersecurestorage.FlutterSecureStorage
import com.it_nomads.fluttersecurestorage.FlutterSecureStorageConfig
import com.it_nomads.fluttersecurestorage.SecurePreferencesCallback
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlinx.coroutines.withContext
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException

/** Reads the identity used by Dart without requiring a running Flutter engine. */
internal object ConfigKeyReader {
    private const val seedKey = "config_age_seed"
    private const val preferencesPrefix = "flutter."

    suspend fun read(context: Context): String? = withContext(Dispatchers.IO) {
        val appContext = context.applicationContext
        val preferences = appContext.getSharedPreferences(
            "FlutterSharedPreferences",
            Context.MODE_PRIVATE,
        )
        readConfigSeed(
            isDeleted = {
                preferences.getBoolean(
                    "${preferencesPrefix}__safe_storage_deleted_$seedKey",
                    false,
                )
            },
            isMigrated = {
                preferences.getBoolean(
                    "${preferencesPrefix}__safe_storage_migrated_$seedKey",
                    false,
                )
            },
            readLegacy = { preferences.all["$preferencesPrefix$seedKey"] as? String },
            readSecure = {
                val storage = FlutterSecureStorage(appContext)
                // Match SafeStorage's default namespace and cipher options.
                // Never let transient KeyStore errors erase the existing key.
                val config = FlutterSecureStorageConfig(
                    mapOf<String, Any>("resetOnError" to "false"),
                )
                suspendCancellableCoroutine<Unit> { continuation ->
                    storage.initialize(config, object : SecurePreferencesCallback<Void> {
                        override fun onSuccess(result: Void?) {
                            if (continuation.isActive) continuation.resume(Unit)
                        }

                        override fun onError(error: Exception) {
                            if (continuation.isActive) continuation.resumeWithException(error)
                        }
                    })
                }
                storage.read(storage.addPrefixToKey(seedKey))
            },
        )
    }
}

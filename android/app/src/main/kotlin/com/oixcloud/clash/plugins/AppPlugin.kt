package com.oixcloud.clash.plugins

import android.Manifest
import android.app.Activity
import android.app.ActivityManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.ApplicationInfo
import android.content.pm.ComponentInfo
import android.content.pm.PackageManager
import android.net.Uri
import android.net.VpnService
import android.os.Build
import android.provider.Settings
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.core.content.ContextCompat.getSystemService
import androidx.core.content.FileProvider
import androidx.core.content.pm.ShortcutInfoCompat
import androidx.core.content.pm.ShortcutManagerCompat
import androidx.core.graphics.drawable.IconCompat
import com.android.tools.smali.dexlib2.dexbacked.DexBackedDexFile
import com.google.gson.Gson
import com.oixcloud.clash.ChinaPackageMatcher
import com.oixcloud.clash.ProcessExitRecord
import com.oixcloud.clash.R
import com.oixcloud.clash.common.Components
import com.oixcloud.clash.common.GlobalState
import com.oixcloud.clash.common.PendingCallback
import com.oixcloud.clash.common.QuickAction
import com.oixcloud.clash.common.quickIntent
import com.oixcloud.clash.common.registerReceiverCompat
import com.oixcloud.clash.getPackageIconPath
import com.oixcloud.clash.latestMainProcessExit
import com.oixcloud.clash.models.Package
import com.oixcloud.clash.packages.PackageSnapshotCache
import com.oixcloud.clash.packages.PermissionRequestBroker
import com.oixcloud.clash.showToast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener
import io.flutter.plugin.common.PluginRegistry.RequestPermissionsResultListener
import java.io.File
import java.lang.ref.WeakReference
import java.util.zip.ZipFile
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.withContext

class AppPlugin : FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {

    companion object {
        const val VPN_PERMISSION_REQUEST_CODE = 1001
        const val NOTIFICATION_PERMISSION_REQUEST_CODE = 1002
        private const val GET_INSTALLED_APPS = "com.android.permission.GET_INSTALLED_APPS"
    }

    private var activityRef: WeakReference<Activity>? = null

    private lateinit var channel: MethodChannel

    private lateinit var platformCalls: PlatformCallDispatcher

    private val vpnPrepareCallback = PendingCallback<Boolean>()

    private val requestNotificationCallback = PendingCallback<Unit>()

    private val packages = PackageSnapshotCache { loadPackages() }
    private val installedAppsRequest = PermissionRequestBroker()
    private var packageChangeContext: Context? = null
    private var packageChangeReceiver: BroadcastReceiver? = null
    private var activityBinding: ActivityPluginBinding? = null
    private val activityResultListener = ActivityResultListener(::onActivityResult)
    private val permissionResultListener = RequestPermissionsResultListener(::onRequestPermissionsResultListener)

    private var isBlockNotification = false

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getLastExitInfo" -> platformCalls.submit(result) { lastExitInfo() }

            "moveTaskToBack" -> {
                activityRef?.get()?.moveTaskToBack(true)
                result.success(true)
            }

            "updateExcludeFromRecents" -> {
                val value = call.argument<Boolean>("value")
                updateExcludeFromRecents(value)
                result.success(true)
            }

            "initShortcuts" -> {
                initShortcuts(call.arguments as String)
                result.success(true)
            }

            "getPackages" -> platformCalls.submit(result) {
                if (call.argument<Boolean>("refresh") == true) packages.invalidate()
                getPackagesToJson()
            }

            "isInstalledAppsPermissionGranted" -> platformCalls.submit(result) {
                hasInstalledAppsPermission()
            }

            "requestInstalledAppsPermission" -> requestInstalledAppsPermission(result)

            "openAppSettings" -> {
                val context = activityRef?.get() ?: GlobalState.application
                val opened = runCatching {
                    context.startActivity(Intent(
                        Settings.ACTION_APPLICATION_DETAILS_SETTINGS,
                        Uri.fromParts("package", context.packageName, null),
                    ).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK))
                    true
                }.getOrDefault(false)
                result.success(opened)
            }

            "getChinaPackageNames" -> platformCalls.submit(result) { getChinaPackageNames() }

            "getPackageIcon" -> {
                handleGetPackageIcon(call, result)
            }

            "tip" -> {
                val message = call.argument<String>("message")
                tip(message)
                result.success(true)
            }

            "openFile" -> {
                handleOpenFile(call, result)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    private fun lastExitInfo(): Map<String, Any>? {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.R) return null
        val application = GlobalState.application
        val manager = application.getSystemService(ActivityManager::class.java) ?: return null
        return runCatching {
            latestMainProcessExit(
                manager.getHistoricalProcessExitReasons(application.packageName, 0, 0).map {
                    ProcessExitRecord(it.processName, it.pid, it.timestamp, it.reason)
                },
                application.packageName,
            )
        }.getOrNull()
    }

    private fun handleOpenFile(call: MethodCall, result: Result) {
        val path = call.argument<String>("path")
        if (path.isNullOrBlank()) {
            result.success(false)
            return
        }

        val file = File(path)
        if (!file.exists()) {
            result.success(false)
            return
        }

        val activity = activityRef?.get()
        val context = activity ?: GlobalState.application
        try {
            val uri = FileProvider.getUriForFile(
                context,
                "${context.packageName}.file_provider",
                file
            )
            val mimeType = if (file.extension.equals("apk", ignoreCase = true)) {
                "application/vnd.android.package-archive"
            } else {
                "application/octet-stream"
            }
            val intent = Intent(Intent.ACTION_VIEW).apply {
                setDataAndType(uri, mimeType)
                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                if (activity == null) {
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                }
            }
            (activity ?: context).startActivity(intent)
            result.success(true)
        } catch (_: Exception) {
            result.success(false)
        }
    }

    private fun handleGetPackageIcon(call: MethodCall, result: Result) {
        platformCalls.submit(result) {
            val packageName = call.argument<String>("packageName") ?: return@submit ""
            GlobalState.application.packageManager.getPackageIconPath(packageName)
        }
    }

    private fun initShortcuts(label: String) {
        val shortcut = with(ShortcutInfoCompat.Builder(GlobalState.application, "toggle")) {
            setShortLabel(label)
            setIcon(
                IconCompat.createWithResource(
                    GlobalState.application,
                    R.mipmap.ic_launcher_round,
                )
            )
            setIntent(QuickAction.TOGGLE.quickIntent)
            build()
        }
        ShortcutManagerCompat.setDynamicShortcuts(
            GlobalState.application, listOf(shortcut)
        )
    }

    private fun tip(message: String?) {
        GlobalState.application.showToast(message)
    }

    @Suppress("DEPRECATION")
    private fun updateExcludeFromRecents(value: Boolean?) {
        val am = getSystemService(GlobalState.application, ActivityManager::class.java)
        val task = am?.appTasks?.firstOrNull {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                it.taskInfo.taskId == activityRef?.get()?.taskId
            } else {
                it.taskInfo.id == activityRef?.get()?.taskId
            }
        }

        task?.setExcludeFromRecents(value == true)
    }

    private fun hasInstalledAppsPermission(): Boolean {
        val manager = GlobalState.application.packageManager
        try {
            @Suppress("DEPRECATION")
            manager.getPermissionInfo(GET_INSTALLED_APPS, 0)
        } catch (_: PackageManager.NameNotFoundException) {
            return true // Stock Android has no vendor runtime permission.
        }
        return manager.checkPermission(GET_INSTALLED_APPS, GlobalState.application.packageName) ==
            PackageManager.PERMISSION_GRANTED
    }

    private fun requestInstalledAppsPermission(result: Result) {
        try {
            if (hasInstalledAppsPermission()) {
                result.success(true)
                return
            }
            val activity = activityRef?.get()
            if (activity == null) {
                result.success(false)
                return
            }
            val requestCode = installedAppsRequest.begin { result.success(it) } ?: return
            try {
                ActivityCompat.requestPermissions(activity, arrayOf(GET_INSTALLED_APPS), requestCode)
            } catch (_: Exception) {
                installedAppsRequest.complete(requestCode, false)
            }
        } catch (_: Exception) {
            result.error("PLATFORM_ERROR", "Could not request installed apps permission", null)
        }
    }

    private fun getPackages(): List<Package> {
        if (!hasInstalledAppsPermission()) {
            packages.invalidate()
            return emptyList()
        }
        val loaded = packages.get()
        if (hasInstalledAppsPermission()) return loaded
        packages.invalidate()
        return emptyList()
    }

    private fun loadPackages(): List<Package> {
        val manager = GlobalState.application.packageManager
        val flags = PackageManager.GET_PERMISSIONS
        val installed = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            manager.getInstalledPackages(PackageManager.PackageInfoFlags.of(flags.toLong()))
        } else {
            @Suppress("DEPRECATION")
            manager.getInstalledPackages(flags)
        }
        return installed.filter {
            it.packageName != GlobalState.application.packageName && it.packageName != "android"
        }.map {
            Package(
                packageName = it.packageName,
                label = it.applicationInfo?.loadLabel(manager)?.toString() ?: it.packageName,
                system = it.applicationInfo?.let { info ->
                    info.flags and ApplicationInfo.FLAG_SYSTEM != 0
                } == true,
                lastUpdateTime = it.lastUpdateTime,
                internet = it.requestedPermissions?.contains(Manifest.permission.INTERNET) == true,
            )
        }
    }

    private suspend fun getPackagesToJson(): String {
        return withContext(Dispatchers.Default) {
            Gson().toJson(getPackages())
        }
    }

    private suspend fun getChinaPackageNames(): String {
        return withContext(Dispatchers.Default) {
            check(hasInstalledAppsPermission()) { "Installed apps permission is required" }
            val names = getPackages().map { it.packageName }.filter { isChinaPackage(it) }
            check(hasInstalledAppsPermission()) { "Installed apps permission was revoked" }
            Gson().toJson(names)
        }
    }

    fun requestNotificationsPermission(callBack: (Unit) -> Unit) {
        requestNotificationCallback.replace(callBack, Unit)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            val permission = ContextCompat.checkSelfPermission(
                GlobalState.application, Manifest.permission.POST_NOTIFICATIONS
            )
            if (permission == PackageManager.PERMISSION_GRANTED || isBlockNotification) {
                invokeRequestNotificationCallback()
                return
            }
            activityRef?.get()?.let {
                ActivityCompat.requestPermissions(
                    it,
                    arrayOf(Manifest.permission.POST_NOTIFICATIONS),
                    NOTIFICATION_PERMISSION_REQUEST_CODE
                )
            } ?: invokeRequestNotificationCallback()
            return
        } else {
            invokeRequestNotificationCallback()
        }

    }

    fun invokeRequestNotificationCallback() {
        requestNotificationCallback.resolve(Unit)
    }

    fun cancelNotificationPreparation(callback: (Unit) -> Unit) {
        requestNotificationCallback.cancel(callback)
    }

    fun cancelVpnPreparation(callback: (Boolean) -> Unit) {
        vpnPrepareCallback.cancel(callback)
    }

    fun prepare(needPrepare: Boolean, callBack: (Boolean) -> Unit) {
        vpnPrepareCallback.replace(callBack, false)
        if (!needPrepare) {
            invokeVpnPrepareCallback()
            return
        }
        val intent = VpnService.prepare(GlobalState.application)
        if (intent != null) {
            activityRef?.get()?.let {
                it.startActivityForResult(intent, VPN_PERMISSION_REQUEST_CODE)
            } ?: invokeVpnPrepareCallback(false)
            return
        }
        invokeVpnPrepareCallback()
    }

    fun invokeVpnPrepareCallback(allowed: Boolean = true) {
        vpnPrepareCallback.resolve(allowed)
    }


    @Suppress("DEPRECATION")
    private fun isChinaPackage(packageName: String): Boolean {
        val packageManager = GlobalState.application.packageManager ?: return false
        if (ChinaPackageMatcher.isSkipped(packageName)) return false
        val packageManagerFlags = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            PackageManager.MATCH_UNINSTALLED_PACKAGES or PackageManager.GET_ACTIVITIES or PackageManager.GET_SERVICES or PackageManager.GET_RECEIVERS or PackageManager.GET_PROVIDERS
        } else {
            PackageManager.GET_UNINSTALLED_PACKAGES or PackageManager.GET_ACTIVITIES or PackageManager.GET_SERVICES or PackageManager.GET_RECEIVERS or PackageManager.GET_PROVIDERS
        }
        if (ChinaPackageMatcher.matchesKnownPrefix(packageName)) {
            return true
        }
        try {
            val packageInfo = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                packageManager.getPackageInfo(
                    packageName, PackageManager.PackageInfoFlags.of(packageManagerFlags.toLong())
                )
            } else {
                packageManager.getPackageInfo(
                    packageName, packageManagerFlags
                )
            }
            mutableListOf<ComponentInfo>().apply {
                packageInfo.services?.let { addAll(it) }
                packageInfo.activities?.let { addAll(it) }
                packageInfo.receivers?.let { addAll(it) }
                packageInfo.providers?.let { addAll(it) }
            }.forEach {
                if (ChinaPackageMatcher.matchesKnownPrefix(it.name)) return true
            }
            packageInfo.applicationInfo?.publicSourceDir?.let {
                ZipFile(File(it)).use {
                    for (packageEntry in it.entries()) {
                        if (packageEntry.name.startsWith("firebase-")) return false
                    }
                    for (packageEntry in it.entries()) {
                        if (!(packageEntry.name.startsWith("classes") && packageEntry.name.endsWith(
                                ".dex"
                            ))
                        ) {
                            continue
                        }
                        if (packageEntry.size > 15000000) {
                            return true
                        }
                        val input = it.getInputStream(packageEntry).buffered()
                        val dexFile = try {
                            DexBackedDexFile.fromInputStream(null, input)
                        } catch (e: Exception) {
                            return false
                        }
                        for (clazz in dexFile.classes) {
                            if (ChinaPackageMatcher.matchesKnownPrefix(
                                    ChinaPackageMatcher.classNameOf(clazz.type)
                                )) return true
                        }
                    }
                }
            }
        } catch (_: Exception) {
            return false
        }
        return false
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        platformCalls = PlatformCallDispatcher(CoroutineScope(SupervisorJob() + Dispatchers.IO))
        channel =
            MethodChannel(flutterPluginBinding.binaryMessenger, "${Components.PACKAGE_NAME}/app")
        channel.setMethodCallHandler(this)
        packages.invalidate()
        val context = flutterPluginBinding.applicationContext
        val attachedChannel = channel
        val receiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                if (packageChangeReceiver !== this || intent?.data?.scheme != "package") return
                // Replacements send REMOVED + ADDED before REPLACED; refresh once at the end.
                if (intent.action != Intent.ACTION_PACKAGE_REPLACED &&
                    intent.getBooleanExtra(Intent.EXTRA_REPLACING, false)) return
                packages.invalidate()
                attachedChannel.invokeMethod("packagesChanged", null)
            }
        }
        val filter = IntentFilter().apply {
            addAction(Intent.ACTION_PACKAGE_ADDED)
            addAction(Intent.ACTION_PACKAGE_REPLACED)
            addAction(Intent.ACTION_PACKAGE_REMOVED)
            addDataScheme("package")
        }
        context.registerReceiverCompat(receiver, filter)
        packageChangeContext = context
        packageChangeReceiver = receiver
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        val receiver = packageChangeReceiver
        packageChangeReceiver = null
        receiver?.let { runCatching { packageChangeContext?.unregisterReceiver(it) } }
        packageChangeContext = null
        detachActivityListeners()
        installedAppsRequest.cancel()
        packages.invalidate()
        invokeRequestNotificationCallback()
        invokeVpnPrepareCallback(false)
        platformCalls.close()
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        detachActivityListeners()
        activityBinding = binding
        activityRef = WeakReference(binding.activity)
        binding.addActivityResultListener(activityResultListener)
        binding.addRequestPermissionsResultListener(permissionResultListener)
    }

    private fun detachActivityListeners() {
        activityRef = null
        activityBinding?.removeActivityResultListener(activityResultListener)
        activityBinding?.removeRequestPermissionsResultListener(permissionResultListener)
        activityBinding = null
    }

    override fun onDetachedFromActivityForConfigChanges() {
        detachActivityListeners()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        detachActivityListeners()
        installedAppsRequest.cancel()
        invokeRequestNotificationCallback()
        invokeVpnPrepareCallback(false)
    }

    private fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode != VPN_PERMISSION_REQUEST_CODE) return false
        invokeVpnPrepareCallback(resultCode == FlutterActivity.RESULT_OK)
        return true
    }

    private fun onRequestPermissionsResultListener(
        requestCode: Int, permissions: Array<String>, grantResults: IntArray
    ): Boolean {
        if (requestCode >= 0x2000) {
            if (permissions.isNotEmpty() && !permissions.contains(GET_INSTALLED_APPS)) return false
            val granted = permissions.contains(GET_INSTALLED_APPS) &&
                grantResults.isNotEmpty() &&
                runCatching { hasInstalledAppsPermission() }.getOrDefault(false)
            if (installedAppsRequest.complete(requestCode, granted)) {
                packages.invalidate()
                channel.invokeMethod("packagesChanged", null)
                return true
            }
            return false
        }
        if (requestCode != NOTIFICATION_PERMISSION_REQUEST_CODE) return false
        isBlockNotification = true
        invokeRequestNotificationCallback()
        return true
    }
}

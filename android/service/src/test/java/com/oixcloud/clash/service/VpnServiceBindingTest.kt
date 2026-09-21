package com.oixcloud.clash.service

import android.app.Application
import android.content.Intent
import android.os.IBinder
import android.os.Parcel
import com.oixcloud.clash.common.GlobalState
import com.oixcloud.clash.common.ServiceDelegate
import com.oixcloud.clash.service.modules.Module
import com.oixcloud.clash.service.modules.moduleLoader
import java.util.concurrent.CountDownLatch
import java.util.concurrent.TimeUnit
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.sync.withLock
import kotlinx.coroutines.withTimeout
import org.junit.After
import org.junit.Assert.*
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.robolectric.Robolectric
import org.robolectric.RobolectricTestRunner
import org.robolectric.RuntimeEnvironment
import org.robolectric.Shadows.shadowOf
import org.robolectric.annotation.Config
import org.robolectric.util.ReflectionHelpers
import android.net.VpnService as SystemVpnService

@RunWith(RobolectricTestRunner::class)
@Config(sdk = [28], manifest = Config.NONE, application = Application::class)
class VpnServiceBindingTest {
    @Before
    fun prepareState() {
        GlobalState.init(RuntimeEnvironment.getApplication())
        State.delegate = null
        State.intent = null
        State.runTime = 0L
    }

    @After
    fun clearState() = runBlocking {
        State.runLock.withLock {
            State.delegate?.unbind()
            State.delegate = null
            State.intent = null
            State.runTime = 0L
        }
    }

    private fun service(): VpnService = Robolectric.buildService(VpnService::class.java).get()

    private fun bind(service: VpnService): ServiceDelegate<IBaseService> {
        val intent = Intent(RuntimeEnvironment.getApplication(), VpnService::class.java)
        val binder = service.onBind(intent) as VpnService.LocalBinder
        val delegate = ServiceDelegate<IBaseService>(intent) {
            (it as VpnService.LocalBinder).getService()
        }
        val binding = ReflectionHelpers.getField<Any>(delegate, "binding")
        val state = ReflectionHelpers.getField<MutableStateFlow<Pair<IBaseService?, String>?>>(
            binding, "state",
        )
        state.value = Pair(binder.getService(), "")
        State.delegate = delegate
        State.intent = intent
        State.runTime = 123L
        return delegate
    }

    private fun observeStop(service: VpnService, fail: Boolean = false): CountDownLatch {
        val stopped = CountDownLatch(1)
        val loader = moduleLoader {
            install(object : Module() {
                override fun onInstall() {}
                override fun onUninstall() {
                    stopped.countDown()
                    if (fail) error("module cleanup failed")
                }
            })
        }
        loader.load()
        ReflectionHelpers.setField(service, "loader", loader)
        return stopped
    }

    private fun revoke(service: VpnService, stopped: CountDownLatch) {
        val binder = service.onBind(Intent(SystemVpnService.SERVICE_INTERFACE))
        assertFalse(binder is VpnService.LocalBinder)
        val parcel = Parcel.obtain()
        try {
            assertTrue(binder!!.transact(IBinder.LAST_CALL_TRANSACTION, parcel, null, 0))
        } finally {
            parcel.recycle()
        }
        assertTrue("System revoke must run service cleanup", stopped.await(5, TimeUnit.SECONDS))
        runBlocking { withTimeout(5_000) { State.runLock.withLock {} } }
    }

    @Test
    fun localBindingKeepsTheServiceInterface() {
        val service = service()
        val binder = service.onBind(Intent())
        assertTrue(binder is VpnService.LocalBinder)
        assertSame(service, (binder as VpnService.LocalBinder).getService())
        assertSame(binder, service.onBind(Intent()))
    }

    @Test
    fun unknownLocalTransactionDoesNotAnnounceServiceDestruction() {
        val application = RuntimeEnvironment.getApplication()
        val before = shadowOf(application).broadcastIntents.size
        val binder = service().onBind(Intent())
        val parcel = Parcel.obtain()
        try {
            assertFalse(binder.transact(IBinder.FIRST_CALL_TRANSACTION, parcel, null, 0))
        } finally {
            parcel.recycle()
        }
        assertEquals(before, shadowOf(application).broadcastIntents.size)
    }

    @Test
    fun systemRevocationStopsModulesAndReleasesCurrentBinding() {
        val service = service()
        val delegate = bind(service)
        revoke(service, observeStop(service))
        assertNull(State.delegate)
        assertNull(State.intent)
        assertEquals(0L, State.runTime)
        assertNull(delegate.serviceState.value)
    }

    @Test
    fun cleanupFailureStillReleasesRevokedBinding() {
        val service = service()
        val delegate = bind(service)
        revoke(service, observeStop(service, fail = true))
        assertNull(State.delegate)
        assertNull(State.intent)
        assertEquals(0L, State.runTime)
        assertNull(delegate.serviceState.value)
    }

    @Test
    fun oldSystemRevocationKeepsReplacementBinding() {
        val oldService = service()
        val replacement = service()
        val delegate = bind(replacement)
        revoke(oldService, observeStop(oldService))
        assertSame(delegate, State.delegate)
        assertSame(replacement, delegate.serviceState.value?.first)
        assertEquals(123L, State.runTime)
    }
}

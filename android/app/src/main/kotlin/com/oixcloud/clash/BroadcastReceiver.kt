package com.oixcloud.clash

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Handler
import android.os.Looper
import com.oixcloud.clash.common.BroadcastAction
import com.oixcloud.clash.common.BroadcastLease
import com.oixcloud.clash.common.GlobalState
import com.oixcloud.clash.common.action
import kotlinx.coroutines.launch

class BroadcastReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent?.action != BroadcastAction.SERVICE_CREATED.action &&
            intent?.action != BroadcastAction.SERVICE_DESTROYED.action
        ) return

        // Creation is announced before VPN establishment succeeds. Treat these
        // as state notifications; replaying START here can loop after a failure.
        val pending = goAsync()
        val lease = BroadcastLease { pending.finish() }
        val timeout = Runnable {
            lease.release { GlobalState.log("Service state broadcast timed out") }
        }
        mainHandler.postDelayed(timeout, BROADCAST_TIMEOUT_MILLIS)
        GlobalState.launch {
            try {
                State.handleSyncState()
                State.servicePlugin?.handleStateChanged()
            } finally {
                mainHandler.removeCallbacks(timeout)
                lease.release()
            }
        }
    }

    private companion object {
        const val BROADCAST_TIMEOUT_MILLIS = 9_000L
        val mainHandler = Handler(Looper.getMainLooper())
    }
}

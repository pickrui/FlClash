package com.oixcloud.clash

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import com.oixcloud.clash.common.BroadcastAction
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
        GlobalState.launch {
            try {
                State.handleSyncState()
            } finally {
                pending.finish()
            }
        }
    }
}

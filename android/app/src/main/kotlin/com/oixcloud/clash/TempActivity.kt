package com.oixcloud.clash

import android.app.Activity
import android.os.Bundle
import com.oixcloud.clash.common.GlobalState
import com.oixcloud.clash.common.QuickAction
import com.oixcloud.clash.common.action
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.launch

class TempActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // The original application-scoped operation survives activity recreation.
        if (savedInstanceState != null) {
            finish()
            return
        }
        val action = QuickAction.entries.firstOrNull { it.action == intent.action }
        if (action == null) {
            finish()
            return
        }
        GlobalState.launch {
            try {
                State.handleQuickAction(action)
            } catch (error: CancellationException) {
                throw error
            } catch (error: Exception) {
                GlobalState.application.showToast(error.message ?: "VPN operation failed")
            }
        }
        // The application scope owns the operation. Finish before onResume so
        // the launcher never presents a window while VPN setup/stop is pending.
        finish()
    }
}

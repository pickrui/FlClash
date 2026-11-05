package com.dler.clash

import android.app.Application
import android.content.Context
import com.dler.clash.common.GlobalState

class Application : Application() {

    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
        GlobalState.init(this)
    }
}

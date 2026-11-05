package com.oixcloud.clash.service

import com.oixcloud.clash.common.BroadcastAction
import com.oixcloud.clash.common.GlobalState
import com.oixcloud.clash.common.sendBroadcast

interface IBaseService {
    fun handleCreate() {
        GlobalState.log("Service create")
        BroadcastAction.SERVICE_CREATED.sendBroadcast()
    }

    fun handleDestroy() {
        GlobalState.log("Service destroy")
        BroadcastAction.SERVICE_DESTROYED.sendBroadcast()
    }

    fun start()

    fun stop()
}
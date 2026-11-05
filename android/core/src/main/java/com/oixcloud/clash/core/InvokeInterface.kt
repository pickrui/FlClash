package com.oixcloud.clash.core

import androidx.annotation.Keep

@Keep
interface InvokeInterface {
    fun onResult(result: String?)
}
// ICallbackInterface.aidl
package com.oixcloud.clash.service;

import com.oixcloud.clash.service.IAckInterface;

interface ICallbackInterface {
    oneway void onResult(in byte[] data,in boolean isSuccess, in IAckInterface ack);
}
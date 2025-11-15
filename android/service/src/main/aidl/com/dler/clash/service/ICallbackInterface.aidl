// ICallbackInterface.aidl
package com.dler.clash.service;

import com.dler.clash.service.IAckInterface;

interface ICallbackInterface {
    oneway void onResult(in byte[] data,in boolean isSuccess, in IAckInterface ack);
}
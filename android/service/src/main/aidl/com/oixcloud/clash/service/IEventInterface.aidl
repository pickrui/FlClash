// IEventInterface.aidl
package com.oixcloud.clash.service;

import com.oixcloud.clash.service.IAckInterface;

interface IEventInterface {
    oneway void onEvent(in String id, in byte[] data,in boolean isSuccess, in IAckInterface ack);
}
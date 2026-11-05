// IEventInterface.aidl
package com.dler.clash.service;

import com.dler.clash.service.IAckInterface;

interface IEventInterface {
    oneway void onEvent(in String id, in byte[] data,in boolean isSuccess, in IAckInterface ack);
}
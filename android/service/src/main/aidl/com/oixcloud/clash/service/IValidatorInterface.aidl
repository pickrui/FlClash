package com.oixcloud.clash.service;

import com.oixcloud.clash.service.ICallbackInterface;
import com.oixcloud.clash.service.IAckInterface;

interface IValidatorInterface {
	void begin(in String initAction, in ICallbackInterface callback, in IAckInterface ack);
	void sendChunk(in byte[] data, boolean isLast, in IAckInterface ack);
    void shutdown();
}
// IRemoteInterface.aidl
package com.dler.clash.service;

import com.dler.clash.service.ICallbackInterface;
import com.dler.clash.service.IEventInterface;
import com.dler.clash.service.IResultInterface;
import com.dler.clash.service.models.VpnOptions;
import com.dler.clash.service.models.NotificationParams;

interface IRemoteInterface {
    void invokeAction(in String data, in ICallbackInterface callback);
    void updateNotificationParams(in NotificationParams params);
    void startService(in VpnOptions options, in long runTime, in IResultInterface result);
    void stopService(in IResultInterface result);
    void setEventListener(in IEventInterface event);
    long getRunTime();
}
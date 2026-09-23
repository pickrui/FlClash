// IRemoteInterface.aidl
package com.oixcloud.clash.service;

import com.oixcloud.clash.service.ICallbackInterface;
import com.oixcloud.clash.service.IEventInterface;
import com.oixcloud.clash.service.IResultInterface;
import com.oixcloud.clash.service.models.VpnOptions;
import com.oixcloud.clash.service.models.NotificationParams;

interface IRemoteInterface {
    void invokeMethod(in String data, in ICallbackInterface callback);
    void quickSetup(in String initParamsString, in String setupParamsString, in ICallbackInterface callback);
    void updateNotificationParams(in NotificationParams params);
    void startService(in VpnOptions options, in long runTime, in IResultInterface result);
    void stopService(in IResultInterface result);
    void setEventListener(in IEventInterface event);
    long getRunTime();
    void updateExcludeSSIDs(in String[] ssids, in String[] networks);
}

#include <jni.h>
#include <unistd.h>

#ifdef LIBCLASH

#include "jni_helper.h"
#include "libclash.h"
#include "bride.h"

extern "C"
JNIEXPORT jboolean JNICALL
Java_com_oixcloud_clash_core_Core_startTun(JNIEnv *env, jobject thiz, jint fd, jobject cb,
                                         jstring stack, jstring address, jstring dns, jint mtu) {
    const auto interface = new_global(cb);
    return startTUN(interface, fd, mtu, get_string(stack), get_string(address), get_string(dns))
        ? JNI_TRUE : JNI_FALSE;
}

extern "C"
JNIEXPORT void JNICALL
Java_com_oixcloud_clash_core_Core_stopTun(JNIEnv *env, jobject thiz) {
    stopTun();
}

extern "C"
JNIEXPORT void JNICALL
Java_com_oixcloud_clash_core_Core_forceGC(JNIEnv *env, jobject thiz) {
    forceGC();
}

extern "C"
JNIEXPORT void JNICALL
Java_com_oixcloud_clash_core_Core_updateDNS(JNIEnv *env, jobject thiz, jstring dns) {
    updateDns(get_string(dns));
}

extern "C"
JNIEXPORT void JNICALL
Java_com_oixcloud_clash_core_Core_invokeMethod(JNIEnv *env, jobject thiz, jstring data, jobject cb) {
    const auto interface = new_global(cb);
    invokeMethod(interface, get_string(data));
}

extern "C"
JNIEXPORT void JNICALL
Java_com_oixcloud_clash_core_Core_setEventListener(JNIEnv *env, jobject thiz, jobject cb) {
    if (cb != nullptr) {
        const auto interface = new_global(cb);
        setEventListener(interface);
    } else {
        setEventListener(nullptr);
    }
}

extern "C"
JNIEXPORT jstring JNICALL
Java_com_oixcloud_clash_core_Core_getTraffic(JNIEnv *env, jobject thiz,
                                           const jboolean only_statistics_proxy) {
    auto traffic = getTraffic(only_statistics_proxy);
    const auto result = new_string(traffic);
    release_string(&traffic);
    return result;
}

extern "C"
JNIEXPORT void JNICALL
Java_com_oixcloud_clash_core_Core_suspended(JNIEnv *env, jobject thiz, jboolean suspended) {
    suspend(suspended);
}

extern "C"
JNIEXPORT void JNICALL
Java_com_oixcloud_clash_core_Core_quickSetup(JNIEnv *env, jobject thiz, jstring init_params_string,
                                           jstring setup_params_string, jobject cb) {
    const auto interface = new_global(cb);
    quickSetup(interface, get_string(init_params_string), get_string(setup_params_string));
}


static jmethodID m_tun_interface_protect;
static jmethodID m_tun_interface_resolve_process;
static jmethodID m_invoke_interface_result;


static void release_jni_object_impl(void *obj) {
    ATTACH_JNI();
    del_global(static_cast<jobject>(obj));
}

static void free_string_impl(char *str) {
    free(str);
}

static int call_tun_interface_protect_impl(void *tun_interface, const int fd) {
    if (tun_interface == nullptr) return 0;
    ATTACH_JNI();
    const auto accepted = env->CallBooleanMethod(static_cast<jobject>(tun_interface),
                                                m_tun_interface_protect, fd);
    if (jni_clear_exception(env)) return 0;
    return accepted == JNI_TRUE ? 1 : 0;
}

static char *
call_tun_interface_resolve_process_impl(void *tun_interface, const int protocol,
                                        const char *source,
                                        const char *target,
                                        const int uid) {
    if (tun_interface == nullptr) return nullptr;
    ATTACH_JNI();
    const auto sourceString = new_string(source);
    if (sourceString == nullptr) return nullptr;
    const auto targetString = new_string(target);
    if (targetString == nullptr) {
        env->DeleteLocalRef(sourceString);
        return nullptr;
    }
    const auto packageName = reinterpret_cast<jstring>(env->CallObjectMethod(
            static_cast<jobject>(tun_interface),
            m_tun_interface_resolve_process,
            protocol,
            sourceString,
            targetString,
            uid));
    const auto failed = jni_clear_exception(env);
    const auto result = failed ? nullptr : get_string(packageName);
    if (sourceString != nullptr) env->DeleteLocalRef(sourceString);
    if (targetString != nullptr) env->DeleteLocalRef(targetString);
    if (packageName != nullptr) env->DeleteLocalRef(packageName);
    return result;
}

static void call_invoke_interface_result_impl(void *invoke_interface, const char *data) {
    if (invoke_interface == nullptr) return;
    ATTACH_JNI();
    const auto value = new_string(data);
    if (value == nullptr) return;
    env->CallVoidMethod(static_cast<jobject>(invoke_interface),
                        m_invoke_interface_result, value);
    jni_clear_exception(env);
    if (value != nullptr) env->DeleteLocalRef(value);
}

extern "C"
JNIEXPORT jint JNICALL
JNI_OnLoad(JavaVM *vm, void *) {
    JNIEnv *env = nullptr;
    if (vm->GetEnv(reinterpret_cast<void **>(&env), JNI_VERSION_1_6) != JNI_OK) {
        return JNI_ERR;
    }

    initialize_jni(vm, env);

    const auto c_tun_interface = find_class("com/oixcloud/clash/core/TunInterface");

    const auto c_invoke_interface = find_class("com/oixcloud/clash/core/InvokeInterface");

    m_tun_interface_protect = find_method(c_tun_interface, "protect", "(I)Z");
    m_tun_interface_resolve_process = find_method(c_tun_interface, "resolverProcess",
                                                  "(ILjava/lang/String;Ljava/lang/String;I)Ljava/lang/String;");
    m_invoke_interface_result = find_method(c_invoke_interface, "onResult",
                                            "(Ljava/lang/String;)V");


    protect_func = &call_tun_interface_protect_impl;
    resolve_process_func = &call_tun_interface_resolve_process_impl;
    result_func = &call_invoke_interface_result_impl;
    release_object_func = &release_jni_object_impl;
    free_string_func = &free_string_impl;

    return JNI_VERSION_1_6;
}
#else
extern "C"
JNIEXPORT jboolean JNICALL
Java_com_oixcloud_clash_core_Core_startTun(JNIEnv *env, jobject thiz, jint fd, jobject cb,
                                         jstring stack, jstring address, jstring dns, jint mtu) {
    close(fd);
    return JNI_FALSE;
}

extern "C"
JNIEXPORT void JNICALL
Java_com_oixcloud_clash_core_Core_stopTun(JNIEnv *env, jobject thiz) {
}

extern "C"
JNIEXPORT void JNICALL
Java_com_oixcloud_clash_core_Core_invokeMethod(JNIEnv *env, jobject thiz, jstring data, jobject cb) {
}

extern "C"
JNIEXPORT void JNICALL
Java_com_oixcloud_clash_core_Core_forceGC(JNIEnv *env, jobject thiz) {
}

extern "C"
JNIEXPORT void JNICALL
Java_com_oixcloud_clash_core_Core_updateDNS(JNIEnv *env, jobject thiz, jstring dns) {
}

extern "C"
JNIEXPORT void JNICALL
Java_com_oixcloud_clash_core_Core_setEventListener(JNIEnv *env, jobject thiz, jobject cb) {
}

extern "C"
JNIEXPORT jstring JNICALL
Java_com_oixcloud_clash_core_Core_getTraffic(JNIEnv *env, jobject thiz,
                                           const jboolean only_statistics_proxy) {
    return nullptr;
}

extern "C"
JNIEXPORT void JNICALL
Java_com_oixcloud_clash_core_Core_suspended(JNIEnv *env, jobject thiz, jboolean suspended) {
}

extern "C"
JNIEXPORT void JNICALL
Java_com_oixcloud_clash_core_Core_quickSetup(JNIEnv *env, jobject thiz, jstring init_params_string,
                                           jstring setup_params_string, jobject cb) {
}
#endif

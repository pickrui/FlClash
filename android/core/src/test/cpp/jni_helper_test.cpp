#include "jni_helper.h"
#include <cassert>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <initializer_list>

// Fault injection through JNI's actual function table exercises the production
// helpers without needing an Android device or a running JVM.
static bool pending;
static int deleted;
static int constructed;
enum Failure { none, get_bytes, read_array, allocate_array, write_array, construct_string };
static Failure failure;
static _jclass string_class;
static _jstring string_value;
static _jbyteArray bytes;
static char payload[64] = "hello";
static int length = 5;

static jboolean exception_check(JNIEnv *) { return pending ? JNI_TRUE : JNI_FALSE; }
static void exception_clear(JNIEnv *) { pending = false; }
static void exception_describe(JNIEnv *) {}
static void delete_local(JNIEnv *, jobject) { deleted++; }
static jclass find_class_stub(JNIEnv *, const char *) { return &string_class; }
static jobject global_ref(JNIEnv *, jobject value) { return value; }
static jmethodID method(JNIEnv *, jclass, const char *, const char *) {
    return reinterpret_cast<jmethodID>(1);
}
static jobject get_bytes_stub(JNIEnv *, jobject, jmethodID, va_list) {
    assert(!pending);
    if (failure == get_bytes) { pending = true; return nullptr; }
    return &bytes;
}
static jsize array_length(JNIEnv *, jarray) { assert(!pending); return length; }
static void read_bytes(JNIEnv *, jbyteArray, jsize, jsize size, jbyte *out) {
    assert(!pending);
    if (failure == read_array) { pending = true; return; }
    memcpy(out, payload, size);
}
static jbyteArray new_array(JNIEnv *, jsize size) {
    assert(!pending);
    if (failure == allocate_array) { pending = true; return nullptr; }
    length = size;
    return &bytes;
}
static void write_bytes(JNIEnv *, jbyteArray, jsize, jsize size, const jbyte *data) {
    assert(!pending);
    if (failure == write_array) { pending = true; return; }
    memcpy(payload, data, size);
    payload[size] = 0;
}
static jobject new_object(JNIEnv *, jclass, jmethodID, va_list) {
    assert(!pending);
    constructed++;
    if (failure == construct_string) { pending = true; return nullptr; }
    return &string_value;
}
static void reset(Failure next = none) {
    assert(!pending);
    failure = next;
    deleted = constructed = 0;
    strcpy(payload, "hello");
    length = 5;
}
int main() {
    JNINativeInterface table{};
    table.ExceptionCheck = exception_check;
    table.ExceptionClear = exception_clear;
    table.ExceptionDescribe = exception_describe;
    table.DeleteLocalRef = delete_local;
    table.FindClass = find_class_stub;
    table.NewGlobalRef = global_ref;
    table.GetMethodID = method;
    table.CallObjectMethodV = get_bytes_stub;
    table.GetArrayLength = array_length;
    table.GetByteArrayRegion = read_bytes;
    table.NewByteArray = new_array;
    table.SetByteArrayRegion = write_bytes;
    table.NewObjectV = new_object;
    JNIEnv env{&table};
    initialize_jni(nullptr, &env);

    reset();
    char *value = jni_get_string(&env, &string_value);
    assert(strcmp(value, "hello") == 0 && deleted == 1);
    free(value);
    value = jni_get_string(&env, nullptr);
    assert(value != nullptr && value[0] == 0);
    free(value);

    for (auto fault : {get_bytes, read_array}) {
        reset(fault);
        value = jni_get_string(&env, &string_value);
        assert(value != nullptr && value[0] == 0 && !pending);
        assert(deleted == (fault == read_array ? 1 : 0));
        free(value);
    }
    for (auto fault : {allocate_array, write_array, construct_string}) {
        reset(fault);
        assert(jni_new_string(&env, "test") == nullptr && !pending);
        assert(deleted == (fault == allocate_array ? 0 : 1));
        assert(constructed == (fault == construct_string ? 1 : 0));
    }
    reset();
    assert(jni_new_string(&env, "UTF-8: \xe4\xb8\xad") == &string_value);
    assert(strcmp(payload, "UTF-8: \xe4\xb8\xad") == 0 && deleted == 1);
    reset();
    assert(jni_new_string(&env, nullptr) == &string_value && length == 0);
    assert(!pending && deleted == 1);
    puts("JNI string copy, exception cleanup, and local reference tests passed");
}

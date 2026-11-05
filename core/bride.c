#include "bride.h"

void (*release_object_func)(void *obj);

void (*free_string_func)(char *data);

int (*protect_func)(void *tun_interface, int fd);

char* (*resolve_process_func)(void *tun_interface,int protocol, const char *source, const char *target, int uid);

void (*result_func)(void *invoke_Interface, const char *data);

int protect(void *tun_interface, int fd) {
    if (tun_interface == NULL || protect_func == NULL) return 0;
    return protect_func(tun_interface, fd);
}

char* resolve_process(void *tun_interface, int protocol, const char *source, const char *target, int uid) {
    if (tun_interface == NULL || resolve_process_func == NULL) return NULL;
    return resolve_process_func(tun_interface, protocol, source, target, uid);
}

void release_object(void *obj) {
    if (obj != NULL && release_object_func != NULL) release_object_func(obj);
}

void free_string(char *data) {
    if (free_string_func != NULL) free_string_func(data);
    else free(data);
}

void result(void *invoke_Interface, const char *data) {
    if (invoke_Interface != NULL && result_func != NULL) result_func(invoke_Interface, data);
}

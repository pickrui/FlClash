#include "include/wifi_ssid/wifi_ssid_plugin.h"

#include <flutter_linux/flutter_linux.h>

#include <cstdio>
#include <cstring>

#define WIFI_SSID_PLUGIN(obj)                                     \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), wifi_ssid_plugin_get_type(), \
                              WifiSsidPlugin))

struct _WifiSsidPlugin {
  GObject parent_instance;
  FlPluginRegistrar* registrar;
  FlMethodChannel* channel;
};

G_DEFINE_TYPE(WifiSsidPlugin, wifi_ssid_plugin, g_object_get_type())

static FlMethodResponse* get_ssid() {
  // Run nmcli to get active WiFi SSID
  FILE* fp = popen("nmcli -t -f active,ssid dev wifi 2>/dev/null", "r");
  if (fp == nullptr) {
    return FL_METHOD_RESPONSE(
        fl_method_success_response_new(fl_value_new_null()));
  }

  char line[256];
  gchar* ssid = nullptr;

  while (fgets(line, sizeof(line), fp) != nullptr) {
    // Remove trailing newline
    size_t len = strlen(line);
    if (len > 0 && line[len - 1] == '\n') {
      line[len - 1] = '\0';
    }

    // Parse "yes:SSID" or "no:SSID"
    char* colon = strchr(line, ':');
    if (colon != nullptr && strncmp(line, "yes", colon - line) == 0) {
      ssid = g_strdup(colon + 1);
      break;
    }
  }

  pclose(fp);

  if (ssid == nullptr || strlen(ssid) == 0) {
    g_free(ssid);
    return FL_METHOD_RESPONSE(
        fl_method_success_response_new(fl_value_new_null()));
  }

  FlValue* result = fl_value_new_string(ssid);
  g_free(ssid);
  return FL_METHOD_RESPONSE(fl_method_success_response_new(result));
}

static void wifi_ssid_plugin_handle_method_call(WifiSsidPlugin* self,
                                                 FlMethodCall* method_call) {
  g_autoptr(FlMethodResponse) response = nullptr;
  const gchar* method = fl_method_call_get_name(method_call);

  if (strcmp(method, "getSsid") == 0) {
    response = get_ssid();
  } else if (strcmp(method, "checkPermission") == 0 || strcmp(method, "requestPermission") == 0) {
    // Linux does not require location permission for WiFi SSID
    response = FL_METHOD_RESPONSE(
        fl_method_success_response_new(fl_value_new_int(0)));
  } else {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }

  fl_method_call_respond(method_call, response, nullptr);
}

static void wifi_ssid_plugin_dispose(GObject* object) {
  G_OBJECT_CLASS(wifi_ssid_plugin_parent_class)->dispose(object);
}

static void wifi_ssid_plugin_class_init(WifiSsidPluginClass* klass) {
  G_OBJECT_CLASS(klass)->dispose = wifi_ssid_plugin_dispose;
}

static void wifi_ssid_plugin_init(WifiSsidPlugin* self) {}

static void method_call_cb(FlMethodChannel* channel,
                            FlMethodCall* method_call, gpointer user_data) {
  WifiSsidPlugin* plugin = WIFI_SSID_PLUGIN(user_data);
  wifi_ssid_plugin_handle_method_call(plugin, method_call);
}

void wifi_ssid_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
  WifiSsidPlugin* plugin = WIFI_SSID_PLUGIN(
      g_object_new(wifi_ssid_plugin_get_type(), nullptr));

  plugin->registrar = FL_PLUGIN_REGISTRAR(g_object_ref(registrar));

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  plugin->channel =
      fl_method_channel_new(fl_plugin_registrar_get_messenger(registrar),
                            "wifi_ssid", FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(
      plugin->channel, method_call_cb, g_object_ref(plugin), g_object_unref);

  g_object_unref(plugin);
}

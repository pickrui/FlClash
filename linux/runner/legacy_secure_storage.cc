#include "legacy_secure_storage.h"

#include <cstring>
#include <libsecret/secret.h>

namespace {

SecretSchema LegacySchema() {
  SecretSchema schema{};
  schema.name = "com.oixcloud.clash.LegacySecureStorage";
  schema.flags = SECRET_SCHEMA_DONT_MATCH_NAME;
  schema.attributes[0].name = "account";
  schema.attributes[0].type = SECRET_SCHEMA_ATTRIBUTE_STRING;
  return schema;
}

void HandleMethodCall(FlMethodChannel*, FlMethodCall* method_call, gpointer) {
  g_autoptr(FlMethodResponse) response = nullptr;
  if (std::strcmp(fl_method_call_get_name(method_call), "readAll") != 0) {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
    fl_method_call_respond(method_call, response, nullptr);
    return;
  }

  const SecretSchema schema = LegacySchema();
  g_autoptr(GError) error = nullptr;
  gchar* value = secret_password_lookup_sync(
      &schema, nullptr, &error, "account", "com.follow.clash.secureStorage",
      nullptr);
  if (error != nullptr) {
    response = FL_METHOD_RESPONSE(fl_method_error_response_new(
        "Libsecret error", error->message, nullptr));
  } else {
    g_autoptr(FlValue) result =
        value == nullptr ? nullptr : fl_value_new_string(value);
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
  }
  if (value != nullptr) {
    secret_password_free(value);
  }
  fl_method_call_respond(method_call, response, nullptr);
}

}

void legacy_secure_storage_register_with_registrar(
    FlPluginRegistrar* registrar) {
  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  g_autoptr(FlMethodChannel) channel = fl_method_channel_new(
      fl_plugin_registrar_get_messenger(registrar),
      "com.oixcloud.clash/legacy_secure_storage", FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(channel, HandleMethodCall, nullptr,
                                            nullptr);
}
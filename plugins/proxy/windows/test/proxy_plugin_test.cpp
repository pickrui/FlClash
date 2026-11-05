#include <flutter/method_call.h>
#include <flutter/method_result_functions.h>
#include <flutter/standard_method_codec.h>
#include <gtest/gtest.h>

#include <memory>
#include <string>
#include <variant>

#include "proxy_plugin.h"
#include "proxy_restore_decision.h"

namespace proxy {
namespace test {

namespace {

using flutter::EncodableMap;
using flutter::EncodableValue;
using flutter::MethodCall;
using flutter::MethodResultFunctions;

}  // namespace

TEST(ProxyPlugin, UnknownMethodIsNotImplemented) {
  ProxyPlugin plugin;
  bool not_implemented = false;
  plugin.HandleMethodCall(
      MethodCall("unknown", std::make_unique<EncodableValue>()),
      std::make_unique<MethodResultFunctions<>>(
          nullptr, nullptr,
          [&not_implemented]() { not_implemented = true; }));

  EXPECT_TRUE(not_implemented);
}

TEST(ProxyPlugin, StartProxyRejectsMissingArguments) {
  ProxyPlugin plugin;
  std::string error_code;
  plugin.HandleMethodCall(
      MethodCall("StartProxy", std::make_unique<EncodableValue>(EncodableMap())),
      std::make_unique<MethodResultFunctions<>>(
          nullptr,
          [&error_code](
              const std::string& code,
              const std::string& message,
              const EncodableValue* details) { error_code = code; },
          nullptr));

  EXPECT_EQ(error_code, "bad_args");
}

TEST(ProxyRestoreDecision, RestoresOnlyOwnedState) {
  EXPECT_TRUE(internal::ShouldCommitPending(false, true));
  EXPECT_FALSE(internal::ShouldCommitPending(true, true));
  EXPECT_FALSE(internal::ShouldCommitPending(false, false));

  EXPECT_TRUE(internal::ShouldRestoreOwnedField(false, true, false));
  EXPECT_TRUE(internal::ShouldRestoreOwnedField(false, false, true));
  EXPECT_FALSE(internal::ShouldRestoreOwnedField(true, true, true));
  EXPECT_FALSE(internal::ShouldRestoreOwnedField(false, false, false));

  EXPECT_TRUE(internal::HasOwnedField(true, false, false));
  EXPECT_TRUE(internal::HasOwnedField(false, true, false));
  EXPECT_TRUE(internal::HasOwnedField(false, false, true));
  EXPECT_FALSE(internal::HasOwnedField(false, false, false));
}

TEST(ProxyPlugin, StartProxyRejectsInvalidArguments) {
  ProxyPlugin plugin;
  std::string error_code;
  EncodableMap arguments = {
      {EncodableValue("port"), EncodableValue(0)},
      {EncodableValue("bypassDomain"),
       EncodableValue(flutter::EncodableList{EncodableValue(1)})},
  };
  plugin.HandleMethodCall(
      MethodCall(
          "StartProxy", std::make_unique<EncodableValue>(arguments)),
      std::make_unique<MethodResultFunctions<>>(
          nullptr,
          [&error_code](
              const std::string& code,
              const std::string& message,
              const EncodableValue* details) { error_code = code; },
          nullptr));

  EXPECT_EQ(error_code, "bad_args");
}

class DiagnosticProxyPlugin : public ProxyPlugin {
 public:
  bool available = true;
  int restore_attempts = 0;
 protected:
  std::optional<flutter::EncodableMap> ReadProxySettings() override {
    if (!available) return std::nullopt;
    return EncodableMap{
      {EncodableValue("flags"), EncodableValue(10)},
      {EncodableValue("proxyServer"), EncodableValue("127.0.0.1:7890")},
    };
  }
  bool RestoreProxy() override { ++restore_attempts; return true; }
};

TEST(ProxyPlugin, DiagnosticsReturnFlagsWithoutRestoringProxy) {
  DiagnosticProxyPlugin plugin;
  bool received = false;
  plugin.HandleMethodCall(
      MethodCall("GetProxySettings", std::make_unique<EncodableValue>()),
      std::make_unique<MethodResultFunctions<>>(
          [&received](const EncodableValue* value) {
            ASSERT_NE(value, nullptr);
            const auto& data = std::get<EncodableMap>(*value);
            EXPECT_EQ(std::get<int>(data.at(EncodableValue("flags"))), 10);
            EXPECT_EQ(data.size(), 2u);
            received = true;
          }, nullptr, nullptr));
  EXPECT_TRUE(received);
  EXPECT_EQ(plugin.restore_attempts, 0);
}

TEST(ProxyPlugin, UnavailableDiagnosticsReturnNull) {
  DiagnosticProxyPlugin plugin;
  plugin.available = false;
  bool received = false;
  plugin.HandleMethodCall(
      MethodCall("GetProxySettings", std::make_unique<EncodableValue>()),
      std::make_unique<MethodResultFunctions<>>(
          [&received](const EncodableValue* value) {
            EXPECT_TRUE(value == nullptr || std::holds_alternative<std::monostate>(*value));
            received = true;
          }, nullptr, nullptr));
  EXPECT_TRUE(received);
  EXPECT_EQ(plugin.restore_attempts, 0);
}

class SessionProxyPlugin : public ProxyPlugin {
 public:
  int restore_attempts = 0;
  bool restore_result = true;

 protected:
  bool RestoreProxy() override {
    ++restore_attempts;
    return restore_result;
  }
};

TEST(ProxyPlugin, ConfirmedSessionEndRestoresWithoutConsumingTheMessage) {
  SessionProxyPlugin plugin;
  EXPECT_FALSE(plugin.HandleWindowProc(nullptr, WM_ENDSESSION, TRUE, 0).has_value());
  EXPECT_EQ(plugin.restore_attempts, 1);
  EXPECT_FALSE(plugin.HandleWindowProc(
      nullptr, WM_ENDSESSION, TRUE, ENDSESSION_LOGOFF).has_value());
  EXPECT_EQ(plugin.restore_attempts, 2);
}

TEST(ProxyPlugin, CancelledShutdownAndWindowCloseKeepTheProxy) {
  SessionProxyPlugin plugin;
  plugin.HandleWindowProc(nullptr, WM_QUERYENDSESSION, TRUE, 0);
  plugin.HandleWindowProc(nullptr, WM_ENDSESSION, FALSE, 0);
  plugin.HandleWindowProc(nullptr, WM_CLOSE, TRUE, 0);
  EXPECT_EQ(plugin.restore_attempts, 0);
}

TEST(ProxyPlugin, FailedRestorationCanBeRetriedByTheNormalStopPath) {
  SessionProxyPlugin plugin;
  plugin.restore_result = false;
  EXPECT_FALSE(plugin.HandleWindowProc(nullptr, WM_ENDSESSION, TRUE, 0).has_value());
  plugin.restore_result = true;
  bool restored = false;
  plugin.HandleMethodCall(
      MethodCall("StopProxy", std::make_unique<EncodableValue>()),
      std::make_unique<MethodResultFunctions<>>(
          [&restored](const EncodableValue* value) {
            restored = value != nullptr && std::get<bool>(*value);
          }, nullptr, nullptr));
  EXPECT_TRUE(restored);
  EXPECT_EQ(plugin.restore_attempts, 2);
}

}  // namespace test
}  // namespace proxy

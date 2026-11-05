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

}  // namespace test
}  // namespace proxy

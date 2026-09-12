#include <cstdint>
#include <cstdlib>
#include <iostream>
#include <map>
#include <string>
#include <variant>

using HRESULT = int32_t;
using HWND = void*;
constexpr HRESULT kSuccess = 0;
constexpr HRESULT kFailure = -1;
constexpr int CLSID_TaskbarList = 1;
constexpr int CLSCTX_INPROC_SERVER = 1;
constexpr int TBPF_INDETERMINATE = 1;
constexpr int TBPF_NOPROGRESS = 0;

bool FAILED(HRESULT result) { return result < 0; }
#define IID_PPV_ARGS(pointer) pointer

namespace flutter {
using EncodableValue = std::variant<bool, double, std::string>;
using EncodableMap = std::map<EncodableValue, EncodableValue>;
}

void Require(bool condition, const char* message) {
  if (!condition) {
    std::cerr << message << std::endl;
    std::exit(EXIT_FAILURE);
  }
}

struct ITaskbarList3 {
  HRESULT initialization_result = kSuccess;
  int initialization_calls = 0;
  int release_calls = 0;
  int add_calls = 0;
  int delete_calls = 0;
  int progress_calls = 0;

  HRESULT HrInit() {
    ++initialization_calls;
    return initialization_result;
  }
  void Release() { ++release_calls; }
  void AddTab(HWND) { ++add_calls; }
  void DeleteTab(HWND) { ++delete_calls; }
  void SetProgressState(HWND, int) { ++progress_calls; }
  void SetProgressValue(HWND, int32_t, int32_t) { ++progress_calls; }
};

ITaskbarList3 taskbar;
HRESULT creation_result = kSuccess;
bool return_null_interface = false;
int creation_calls = 0;

HRESULT CoCreateInstance(int, void*, int, ITaskbarList3** result) {
  ++creation_calls;
  *result = FAILED(creation_result) || return_null_interface ? nullptr : &taskbar;
  return creation_result;
}

class WindowManager {
 public:
  ITaskbarList3* taskbar_ = nullptr;
  bool is_skip_taskbar_ = true;

  HWND GetMainWindow() { return reinterpret_cast<HWND>(1); }
  void WaitUntilReadyToShow();
  void SetSkipTaskbar(const flutter::EncodableMap& args);
  void SetProgressBar(const flutter::EncodableMap& args);
};

#include "window_manager_methods.inc"

flutter::EncodableMap Visibility(bool skip) {
  return {{flutter::EncodableValue("isSkipTaskbar"), skip}};
}

flutter::EncodableMap Progress(double value) {
  return {{flutter::EncodableValue("progress"), value}};
}

int main(int argument_count, char** arguments) {
  Require(argument_count == 2, "Expected a test scenario");
  const std::string scenario = arguments[1];
  WindowManager manager;

  if (scenario == "creation_failure" || scenario == "null_interface" ||
      scenario == "initialization_failure") {
    if (scenario == "creation_failure") creation_result = kFailure;
    if (scenario == "null_interface") return_null_interface = true;
    if (scenario == "initialization_failure")
      taskbar.initialization_result = kFailure;

    manager.WaitUntilReadyToShow();
    manager.SetSkipTaskbar(Visibility(false));
    Require(!manager.is_skip_taskbar_, "Show state was not recorded");
    manager.SetSkipTaskbar(Visibility(true));
    manager.SetProgressBar(Progress(0.5));
    Require(manager.is_skip_taskbar_, "Hide state was not recorded");
    Require(manager.taskbar_ == nullptr, "Unavailable interface was retained");
    Require(creation_calls == 4, "Unavailable interface was not retried");
    Require(taskbar.add_calls + taskbar.delete_calls + taskbar.progress_calls == 0,
            "Unavailable taskbar was used");
    Require(taskbar.release_calls ==
                (scenario == "initialization_failure" ? 4 : 0),
            "Failed initialization did not release the interface");
  } else if (scenario == "retry_after_failure") {
    creation_result = kFailure;
    manager.WaitUntilReadyToShow();
    creation_result = kSuccess;
    taskbar.initialization_result = kFailure;
    manager.SetSkipTaskbar(Visibility(false));
    taskbar.initialization_result = kSuccess;
    manager.SetSkipTaskbar(Visibility(false));
    manager.SetSkipTaskbar(Visibility(true));
    manager.SetProgressBar(Progress(0.5));
    Require(creation_calls == 3, "Interface was not retried or reused");
    Require(taskbar.initialization_calls == 2, "Unexpected initialization count");
    Require(taskbar.release_calls == 1, "Failed interface was not released");
    Require(taskbar.add_calls == 1 && taskbar.delete_calls == 1,
            "Taskbar visibility did not recover");
    Require(taskbar.progress_calls > 0, "Taskbar progress did not recover");
  } else if (scenario == "early_visibility") {
    manager.SetSkipTaskbar(Visibility(false));
    manager.SetSkipTaskbar(Visibility(true));
    Require(creation_calls == 1 && taskbar.initialization_calls == 1,
            "Early visibility did not initialize the interface exactly once");
    Require(taskbar.add_calls == 1 && taskbar.delete_calls == 1,
            "Early visibility did not update the taskbar");
  } else if (scenario == "early_progress") {
    manager.SetProgressBar(Progress(0.5));
    manager.SetProgressBar(Progress(-1));
    manager.SetProgressBar(Progress(2));
    Require(creation_calls == 1 && taskbar.initialization_calls == 1,
            "Early progress did not initialize the interface exactly once");
    Require(taskbar.progress_calls == 12, "Progress updates changed");
  } else if (scenario == "repeated_initialization") {
    manager.WaitUntilReadyToShow();
    manager.WaitUntilReadyToShow();
    manager.SetSkipTaskbar(Visibility(false));
    manager.WaitUntilReadyToShow();
    Require(creation_calls == 1 && taskbar.initialization_calls == 1,
            "Ready interface was initialized more than once");
  } else {
    Require(false, "Unknown test scenario");
  }
  return EXIT_SUCCESS;
}
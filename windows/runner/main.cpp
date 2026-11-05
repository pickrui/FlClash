#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>

#include <algorithm>
#include <string>

#include "flutter_window.h"
#include "utils.h"

namespace {

constexpr wchar_t kWindowTitle[] = L"FlClash for oixCloud";
constexpr wchar_t kSingleInstanceMutex[] =
    L"Local\\FlClashForoixCloudSingleInstance";

std::wstring LegacySingleInstanceMutexName() {
  std::wstring name = kSingleInstanceMutex;
  const auto brand_offset = name.find(L"oixCloud");
  if (brand_offset != std::wstring::npos) {
    name[brand_offset] = L'O';
  }
  return name;
}

bool ActivateExistingInstance() {
  HWND existing_window = ::FindWindowW(nullptr, kWindowTitle);
  if (existing_window == nullptr) {
    return false;
  }
  ::ShowWindow(existing_window,
               ::IsIconic(existing_window) ? SW_RESTORE : SW_SHOW);
  ::SetForegroundWindow(existing_window);
  return true;
}

} // namespace

int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t *command_line, _In_ int show_command) {
  std::vector<std::string> command_line_arguments = GetCommandLineArguments();
  const bool is_silent_launch =
      std::find(command_line_arguments.begin(), command_line_arguments.end(),
                "--silent-launch") != command_line_arguments.end();
  const std::wstring legacy_mutex_name = LegacySingleInstanceMutexName();
  HANDLE legacy_instance_mutex =
      ::CreateMutexW(nullptr, TRUE, legacy_mutex_name.c_str());
  const bool legacy_instance_exists =
      legacy_instance_mutex != nullptr &&
      ::GetLastError() == ERROR_ALREADY_EXISTS;
  HANDLE single_instance_mutex =
      ::CreateMutexW(nullptr, TRUE, kSingleInstanceMutex);
  const bool single_instance_exists =
      single_instance_mutex != nullptr &&
      ::GetLastError() == ERROR_ALREADY_EXISTS;
  if (legacy_instance_exists || single_instance_exists) {
    if (!is_silent_launch) {
      ActivateExistingInstance();
    }
    if (single_instance_mutex != nullptr) {
      ::CloseHandle(single_instance_mutex);
    }
    if (legacy_instance_mutex != nullptr) {
      ::CloseHandle(legacy_instance_mutex);
    }
    return EXIT_SUCCESS;
  }

  // Attach to console when present (e.g., 'flutter run') or create a
  // new console when running with a debugger.
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    CreateAndAttachConsole();
  }

  // Initialize COM, so that it is available for use in the library and/or
  // plugins.
  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  flutter::DartProject project(L"data");
  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

  FlutterWindow window(project);
  Win32Window::Point origin(10, 10);
  Win32Window::Size size(1280, 720);
  if (!window.Create(kWindowTitle, origin, size)) {
    if (single_instance_mutex != nullptr) {
      ::CloseHandle(single_instance_mutex);
    }
    if (legacy_instance_mutex != nullptr) {
      ::CloseHandle(legacy_instance_mutex);
    }
    ::CoUninitialize();
    return EXIT_FAILURE;
  }
  window.SetQuitOnClose(true);

  ::MSG msg;
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    ::TranslateMessage(&msg);
    ::DispatchMessage(&msg);
  }

  ::CoUninitialize();
  if (single_instance_mutex != nullptr) {
    ::CloseHandle(single_instance_mutex);
  }
  if (legacy_instance_mutex != nullptr) {
    ::CloseHandle(legacy_instance_mutex);
  }
  return EXIT_SUCCESS;
}

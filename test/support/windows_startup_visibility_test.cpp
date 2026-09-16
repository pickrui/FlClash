#include <windows.h>

#include <cstdlib>
#include <iostream>
#include <string>
#include <vector>

void Require(bool condition, const char* message) {
  if (!condition) {
    std::cerr << message << " (Win32 error " << GetLastError() << ")\n";
    std::exit(EXIT_FAILURE);
  }
}

class WindowManager {
 public:
  explicit WindowManager(HWND window) : window_(window) {}
  HWND GetMainWindow() { return window_; }
  void Hide();
  void Show();
  void Focus();
  bool IsMinimized();
  void Restore();

 private:
  HWND window_;
};

#include "window_manager_visibility.inc"

void DrainMessages() {
  MSG message{};
  while (PeekMessageW(&message, nullptr, 0, 0, PM_REMOVE)) {
    TranslateMessage(&message);
    DispatchMessageW(&message);
  }
}

void CheckChild(int show_command) {
  STARTUPINFOW startup{};
  startup.cb = sizeof(startup);
  GetStartupInfoW(&startup);
  Require((startup.dwFlags & STARTF_USESHOWWINDOW) != 0 &&
              startup.wShowWindow == show_command,
          "Missing launcher show command");

  WNDCLASSW window_class{};
  window_class.lpfnWndProc = DefWindowProcW;
  window_class.hInstance = GetModuleHandleW(nullptr);
  window_class.lpszClassName = L"FlClashStartupVisibilityFixture";
  Require(RegisterClassW(&window_class) != 0, "RegisterClass failed");
  HWND window = CreateWindowExW(
      0, window_class.lpszClassName, L"FlClash startup fixture",
      WS_OVERLAPPEDWINDOW, 0, 0, 100, 100, nullptr, nullptr,
      window_class.hInstance, nullptr);
  Require(window != nullptr, "CreateWindow failed");
  Require(!IsWindowVisible(window), "Window must start hidden");

  WindowManager manager(window);
  manager.Hide();
  Require(!IsWindowVisible(window), "First silent hide became visible");
  manager.Hide();
  Require(!IsWindowVisible(window), "Silent launch became visible");
  // Match Window._showWindow and window_manager's Dart show wrapper.
  if (manager.IsMinimized()) manager.Restore();
  manager.Show();
  manager.Focus();
  DrainMessages();
  Require(IsWindowVisible(window), "Manual opening must show the window");
  Require(!IsIconic(window), "Manual opening must not inherit startup minimization");
  manager.Hide();
  Require(!IsWindowVisible(window), "Closing must hide a visible window");
  DestroyWindow(window);
  UnregisterClassW(window_class.lpszClassName, window_class.hInstance);
}

void RunChild(const std::wstring& executable, int show_command) {
  std::wstring command = L"\"" + executable + L"\" " + std::to_wstring(show_command);
  STARTUPINFOW startup{};
  startup.cb = sizeof(startup);
  startup.dwFlags = STARTF_USESHOWWINDOW | STARTF_USESTDHANDLES;
  startup.wShowWindow = static_cast<WORD>(show_command);
  startup.hStdInput = GetStdHandle(STD_INPUT_HANDLE);
  startup.hStdOutput = GetStdHandle(STD_OUTPUT_HANDLE);
  startup.hStdError = GetStdHandle(STD_ERROR_HANDLE);
  PROCESS_INFORMATION process{};
  Require(CreateProcessW(executable.c_str(), command.data(), nullptr, nullptr,
                         TRUE, 0, nullptr, nullptr, &startup, &process),
          "CreateProcess failed");
  CloseHandle(process.hThread);
  const DWORD wait = WaitForSingleObject(process.hProcess, 10000);
  if (wait != WAIT_OBJECT_0) {
    TerminateProcess(process.hProcess, EXIT_FAILURE);
    WaitForSingleObject(process.hProcess, 5000);
    CloseHandle(process.hProcess);
    Require(false, "Startup fixture timed out");
  }
  DWORD exit_code = EXIT_FAILURE;
  const bool read_exit_code = GetExitCodeProcess(process.hProcess, &exit_code);
  CloseHandle(process.hProcess);
  Require(read_exit_code && exit_code == EXIT_SUCCESS, "Startup fixture failed");
}

int WINAPI wWinMain(HINSTANCE, HINSTANCE, PWSTR command_line, int) {
  const std::wstring mode = command_line;
  if (!mode.empty()) {
    const int show_command = std::stoi(mode);
    Require(show_command >= SW_HIDE && show_command <= SW_SHOWMAXIMIZED,
            "Unknown launcher show command");
    CheckChild(show_command);
    return EXIT_SUCCESS;
  }
  std::vector<wchar_t> path(32768);
  const DWORD length = GetModuleFileNameW(nullptr, path.data(), path.size());
  Require(length > 0 && length < path.size(), "GetModuleFileName failed");
  const std::wstring executable(path.data(), length);
  for (const int show_command : {SW_HIDE, SW_SHOWNORMAL, SW_SHOWMINIMIZED,
                                 SW_SHOWMAXIMIZED}) {
    RunChild(executable, show_command);
  }
  return EXIT_SUCCESS;
}

function(flclash_patch_window_manager source_dir output_dir)
  file(READ "${source_dir}/window_manager.cpp" source)

  set(initialization_before [=[
void WindowManager::WaitUntilReadyToShow() {
  ::CoCreateInstance(CLSID_TaskbarList, NULL, CLSCTX_INPROC_SERVER,
                     IID_PPV_ARGS(&taskbar_));
}
]=])
  set(initialization_after [=[
void WindowManager::WaitUntilReadyToShow() {
  if (taskbar_ != nullptr)
    return;

  ITaskbarList3* taskbar = nullptr;
  if (FAILED(::CoCreateInstance(CLSID_TaskbarList, nullptr,
                                CLSCTX_INPROC_SERVER,
                                IID_PPV_ARGS(&taskbar))))
    return;
  if (taskbar == nullptr)
    return;
  if (FAILED(taskbar->HrInit())) {
    taskbar->Release();
    return;
  }
  taskbar_ = taskbar;
}
]=])

  set(visibility_before [=[
  LPVOID lp = NULL;
  CoInitialize(lp);

  taskbar_->HrInit();
]=])
  set(visibility_after [=[
  WaitUntilReadyToShow();
  if (taskbar_ == nullptr)
    return;
]=])

  set(progress_before [=[
  HWND hWnd = GetMainWindow();
  taskbar_->SetProgressState(hWnd, TBPF_INDETERMINATE);
]=])
  set(progress_after [=[
  HWND hWnd = GetMainWindow();
  WaitUntilReadyToShow();
  if (taskbar_ == nullptr)
    return;
  taskbar_->SetProgressState(hWnd, TBPF_INDETERMINATE);
]=])

  set(show_window_before [=[
void WindowManager::Show() {
  HWND hWnd = GetMainWindow();
  DWORD gwlStyle = GetWindowLong(hWnd, GWL_STYLE);
  gwlStyle = gwlStyle | WS_VISIBLE;
  if ((gwlStyle & WS_VISIBLE) == 0) {
    SetWindowLong(hWnd, GWL_STYLE, gwlStyle);
    ::SetWindowPos(hWnd, HWND_TOP, 0, 0, 0, 0, SWP_NOSIZE | SWP_NOMOVE);
  }

  ShowWindowAsync(GetMainWindow(), SW_SHOW);
  SetForegroundWindow(GetMainWindow());
}
]=])
  set(show_window_after [=[
void WindowManager::Show() {
  HWND hWnd = GetMainWindow();
  ::SetWindowPos(hWnd, HWND_TOP, 0, 0, 0, 0,
                 SWP_NOSIZE | SWP_NOMOVE | SWP_SHOWWINDOW);
  ::SetForegroundWindow(hWnd);
}
]=])

  set(hide_window_before [=[
void WindowManager::Hide() {
  ShowWindow(GetMainWindow(), SW_HIDE);
}
]=])
  set(hide_window_after [=[
void WindowManager::Hide() {
  ::SetWindowPos(GetMainWindow(), nullptr, 0, 0, 0, 0,
                 SWP_NOSIZE | SWP_NOMOVE | SWP_NOZORDER | SWP_NOACTIVATE |
                     SWP_HIDEWINDOW);
}
]=])

  foreach(patch initialization visibility progress show_window hide_window)
    string(FIND "${source}" "${${patch}_before}" match_position)
    if(match_position EQUAL -1)
      message(FATAL_ERROR
        "window_manager ${patch} patch no longer matches; review the upstream Windows implementation.")
    endif()
    string(REPLACE "${${patch}_before}" "${${patch}_after}" source "${source}")
  endforeach()

  file(MAKE_DIRECTORY "${output_dir}")
  file(WRITE "${output_dir}/window_manager.cpp.in" "${source}")
  configure_file("${output_dir}/window_manager.cpp.in"
    "${output_dir}/window_manager.cpp" COPYONLY)
  configure_file("${source_dir}/window_manager_plugin.cpp"
    "${output_dir}/window_manager_plugin.cpp" COPYONLY)
endfunction()

if(DEFINED WINDOW_MANAGER_SOURCE_DIR AND DEFINED WINDOW_MANAGER_PATCH_DIR)
  flclash_patch_window_manager(
    "${WINDOW_MANAGER_SOURCE_DIR}" "${WINDOW_MANAGER_PATCH_DIR}")
endif()
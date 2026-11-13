# Linux SSID 原生回归

使用 GLib 测试框架和真实 Flutter Linux MethodChannel，不启动 Flutter 引擎或窗口
依赖 CMake、C++17 编译器、pkg-config、GTK 3 / GIO 开发包、dbus-daemon，以及与项目 SDK 对应的 Flutter Linux 引擎头文件和动态库

```sh
flutter precache --linux
cmake -S plugins/wifi_ssid/linux/test -B build/wifi_ssid_tests \
  -DFLUTTER_LINUX_DIR="$FLUTTER_ROOT/bin/cache/artifacts/engine/linux-x64"
cmake --build build/wifi_ssid_tests
ctest --test-dir build/wifi_ssid_tests --output-on-failure
```

arm64 使用对应的 `linux-arm64` 目录；`FLUTTER_ROOT` 指向项目固定版本的 SDK
这些 C++ 测试不由 `flutter test` 自动发现

测试启动私有 D-Bus，重定向 system bus 地址，并将 PATH 限制到临时的假 nmcli
不连接宿主 NetworkManager、iwd、ConnMan 或真实无线接口，不修改代理、DNS、TUN 或网络设置
覆盖 nmcli 参数和转义、其他热点的非 UTF-8 输出、失败与预取消、并发查询合并、5 秒超时与后续恢复、引擎通道关闭，以及 D-Bus 初始化挂起
超时和关闭测试断言子进程已退出并回收，通道关闭测试还验证插件对象释放且没有迟到回应

可额外通过 `CMAKE_CXX_FLAGS` / `CMAKE_EXE_LINKER_FLAGS` 传入 `-fsanitize=address,undefined`
容器跨架构仿真下运行 ASan 时可能需要 `ASAN_OPTIONS=detect_leaks=0`；这不等于验证了 LeakSanitizer

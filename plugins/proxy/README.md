# proxy

FlClash's bundled system proxy plugin for macOS, Linux and Windows.

`Proxy.startProxy` configures the desktop proxy and bypass list;
`Proxy.stopProxy` restores the saved settings. Windows uses the native
method-channel implementation, while macOS and Linux use platform commands.

Run `flutter test plugins/proxy/test/proxy_test.dart` from the repository root.
The Dart tests inject command runners and temporary state files to avoid changing
host networking. Windows native tests live under `windows/test` and require a
Windows build environment.

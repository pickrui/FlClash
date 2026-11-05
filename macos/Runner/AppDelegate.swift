import Cocoa
import Darwin
import FlutterMacOS
import window_ext

@main
class AppDelegate: FlutterAppDelegate {
    private func activateExistingInstanceIfNeeded() -> Bool {
        guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
            return false
        }
        let currentPID = ProcessInfo.processInfo.processIdentifier
        guard let existingApplication = NSRunningApplication
            .runningApplications(withBundleIdentifier: bundleIdentifier)
            .first(where: { $0.processIdentifier != currentPID && !$0.isTerminated }) else {
            return false
        }
        existingApplication.activate(options: [.activateAllWindows, .activateIgnoringOtherApps])
        return true
    }

    override func applicationWillFinishLaunching(_ notification: Notification) {
        if activateExistingInstanceIfNeeded() {
            Darwin.exit(0)
        }
        super.applicationWillFinishLaunching(notification)
    }

    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }

    override func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        WindowExtPlugin.instance?.handleShouldTerminate()
        return .terminateCancel
    }

    override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    override func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            for window in NSApp.windows {
                if !window.isVisible {
                    window.setIsVisible(true)
                }
                window.makeKeyAndOrderFront(self)
                window.orderFrontRegardless()
            }
            NSApp.activate(ignoringOtherApps: true)
        }
        return true
    }
}

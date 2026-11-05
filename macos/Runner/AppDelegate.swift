import Cocoa
import Darwin
import FlutterMacOS
import window_manager

@main
class AppDelegate: FlutterAppDelegate {
    private var wasLaunchedAtLogin: Bool?
    private var launchResultCallbacks: [FlutterResult] = []
    private let currentIdentifierPrefix = "com.oixcloud.clash"
    private let legacyIdentifierPrefix = "com.follow.clash"
    private let identityMigrationKey = "com.oixcloud.clash.identityMigrationCompleted"

    private func legacyIdentifier(for identifier: String) -> String? {
        guard identifier == currentIdentifierPrefix ||
                identifier.hasPrefix("\(currentIdentifierPrefix).") else {
            return nil
        }
        return identifier.replacingOccurrences(
            of: currentIdentifierPrefix,
            with: legacyIdentifierPrefix,
            options: [.anchored]
        )
    }

    private func migrateLegacyDefaultsIfNeeded() {
        guard let currentIdentifier = Bundle.main.bundleIdentifier,
              let legacyIdentifier = legacyIdentifier(for: currentIdentifier) else {
            return
        }
        let defaults = UserDefaults.standard
        var currentDomain = defaults.persistentDomain(forName: currentIdentifier) ?? [:]
        if currentDomain[identityMigrationKey] as? Bool == true {
            return
        }
        if let legacyDomain = defaults.persistentDomain(forName: legacyIdentifier) {
            for (key, value) in legacyDomain where currentDomain[key] == nil {
                currentDomain[key] = value
            }
        }
        currentDomain[identityMigrationKey] = true
        defaults.setPersistentDomain(currentDomain, forName: currentIdentifier)
    }

    private func activateExistingInstanceIfNeeded() -> Bool {
        guard let currentIdentifier = Bundle.main.bundleIdentifier else {
            return false
        }
        let currentPID = ProcessInfo.processInfo.processIdentifier
        let identifiers = [currentIdentifier, legacyIdentifier(for: currentIdentifier)].compactMap { $0 }
        for identifier in identifiers {
            if let existingApplication = NSRunningApplication
                .runningApplications(withBundleIdentifier: identifier)
                .first(where: { $0.processIdentifier != currentPID && !$0.isTerminated }) {
                existingApplication.activate(options: [.activateAllWindows, .activateIgnoringOtherApps])
                return true
            }
        }
        return false
    }

    override func applicationWillFinishLaunching(_ notification: Notification) {
        if activateExistingInstanceIfNeeded() {
            Darwin.exit(0)
        }
        migrateLegacyDefaultsIfNeeded()
        super.applicationWillFinishLaunching(notification)
    }

    override func applicationDidFinishLaunching(_ notification: Notification) {
        let event = NSAppleEventManager.shared().currentAppleEvent
        wasLaunchedAtLogin = event?.eventID == kAEOpenApplication &&
            event?.paramDescriptor(forKeyword: keyAEPropData)?.enumCodeValue == keyAELaunchedAsLogInItem
        super.applicationDidFinishLaunching(notification)
        let callbacks = launchResultCallbacks
        launchResultCallbacks.removeAll()
        for callback in callbacks {
            callback(wasLaunchedAtLogin)
        }
    }

    func resolveLaunchAtLogin(_ result: @escaping FlutterResult) {
        if let wasLaunchedAtLogin = wasLaunchedAtLogin {
            result(wasLaunchedAtLogin)
        } else {
            launchResultCallbacks.append(result)
        }
    }

    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }

    override func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        WindowManagerPlugin.instance?.handleShouldTerminate()
        return .terminateCancel
    }

    override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    override func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        WindowManagerPlugin.instance?.handleReopen()
        return false
    }
}

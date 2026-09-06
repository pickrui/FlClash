// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(value) => "Commission ¥ ${value}";

  static String m1(line) =>
      "The configuration format is invalid at line ${line}.";

  static String m2(expected, actual) =>
      "Expected ${expected}, but found ${actual}.";

  static String m3(name) =>
      "${name} is still referenced by a group, rule, or proxy chain";

  static String m4(count) =>
      "${Intl.plural(count, one: '1 day ago', other: '${count} days ago')}";

  static String m5(label) =>
      "Are you sure you want to delete the selected ${label}?";

  static String m6(label) =>
      "Are you sure you want to delete the current ${label}?";

  static String m7(label) => "${label} details";

  static String m8(label) => "${label} cannot be empty";

  static String m9(count) => "${count} entries";

  static String m10(label) => "Current ${label} already exists";

  static String m11(date) => "Expires: ${date}";

  static String m12(name) => "${name} skipped";

  static String m13(name) => "${name} updated";

  static String m14(name) => "Updating ${name}...";

  static String m15(count) =>
      "${Intl.plural(count, one: '1 hour ago', other: '${count} hours ago')}";

  static String m16(count) => "${count} hours";

  static String m17(count) =>
      "${Intl.plural(count, one: '1 minute ago', other: '${count} minutes ago')}";

  static String m18(count) =>
      "${Intl.plural(count, one: '1 month ago', other: '${count} months ago')}";

  static String m19(label) => "No ${label} yet";

  static String m20(label) => "${label} must be a number";

  static String m21(id) => "Plan #${id}";

  static String m22(label) => "${label} must be between 1024 and 49151";

  static String m23(port) =>
      "The mixed port ${port} could not start listening and may be in use by another application. Change the port to retry immediately.";

  static String m24(name) =>
      "Node ${name} is already used by another enabled chain or has a proxy chain relation conflict";

  static String m25(name) => "Node ${name} is not available in this position";

  static String m26(time) => "Purchased ${time}";

  static String m27(name, path) =>
      "${name} is referenced by the original configuration at ${path}";

  static String m28(value) => "Remaining: ${value}";

  static String m29(count) => "Only ${count} left";

  static String m30(seconds) => "Resend in ${seconds}s";

  static String m31(count) => "${count} seconds";

  static String m32(count) => "${count} items have been selected";

  static String m33(label) => "${label} must be a url";

  static String m34(count) =>
      "${Intl.plural(count, one: '1 year ago', other: '${count} years ago')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "accessControl": MessageLookupByLibrary.simpleMessage("AccessControl"),
    "accessControlAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Only allow selected app to enter VPN",
    ),
    "accessControlDesc": MessageLookupByLibrary.simpleMessage(
      "Configure application access proxy",
    ),
    "accessControlNotAllowDesc": MessageLookupByLibrary.simpleMessage(
      "The selected application will be excluded from VPN",
    ),
    "accessControlSettings": MessageLookupByLibrary.simpleMessage(
      "Access Control Settings",
    ),
    "accessToken": MessageLookupByLibrary.simpleMessage("Access Token"),
    "account": MessageLookupByLibrary.simpleMessage("Account"),
    "accountBalance": MessageLookupByLibrary.simpleMessage("Balance"),
    "action": MessageLookupByLibrary.simpleMessage("Action"),
    "action_mode": MessageLookupByLibrary.simpleMessage("Switch mode"),
    "action_proxy": MessageLookupByLibrary.simpleMessage("System proxy"),
    "action_start": MessageLookupByLibrary.simpleMessage("Start/Stop"),
    "action_tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "action_view": MessageLookupByLibrary.simpleMessage("Show/Hide"),
    "activate": MessageLookupByLibrary.simpleMessage("Activate"),
    "activatePlanConfirm": MessageLookupByLibrary.simpleMessage(
      "Activate this plan? It will become your active plan.",
    ),
    "activatePlanTitle": MessageLookupByLibrary.simpleMessage("Activate plan"),
    "add": MessageLookupByLibrary.simpleMessage("Add"),
    "addProfile": MessageLookupByLibrary.simpleMessage("Add Profile"),
    "addProxyChainNode": MessageLookupByLibrary.simpleMessage("Add"),
    "addProxyGroup": MessageLookupByLibrary.simpleMessage("Add proxy group"),
    "addRule": MessageLookupByLibrary.simpleMessage("Add rule"),
    "addedRules": MessageLookupByLibrary.simpleMessage("Added rules"),
    "address": MessageLookupByLibrary.simpleMessage("Address"),
    "addressCopied": MessageLookupByLibrary.simpleMessage("Address copied"),
    "addressHelp": MessageLookupByLibrary.simpleMessage(
      "WebDAV server address",
    ),
    "addressTip": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid WebDAV address",
    ),
    "advancedConfig": MessageLookupByLibrary.simpleMessage(
      "Advanced configuration",
    ),
    "advancedConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Provide diverse configuration options",
    ),
    "allowBypass": MessageLookupByLibrary.simpleMessage(
      "Allow applications to bypass VPN",
    ),
    "allowBypassDesc": MessageLookupByLibrary.simpleMessage(
      "Some apps can bypass VPN when turned on",
    ),
    "allowLan": MessageLookupByLibrary.simpleMessage("AllowLan"),
    "allowLanDesc": MessageLookupByLibrary.simpleMessage(
      "Allow access proxy through the LAN",
    ),
    "allowTemporarily": MessageLookupByLibrary.simpleMessage(
      "Allow Temporarily",
    ),
    "announcement": MessageLookupByLibrary.simpleMessage("Announcement"),
    "apiAvailable": MessageLookupByLibrary.simpleMessage(
      "API service is operational",
    ),
    "app": MessageLookupByLibrary.simpleMessage("App"),
    "appAccessControl": MessageLookupByLibrary.simpleMessage(
      "App access control",
    ),
    "appendSystemDns": MessageLookupByLibrary.simpleMessage(
      "Append System DNS",
    ),
    "appendSystemDnsTip": MessageLookupByLibrary.simpleMessage(
      "Forcefully append system DNS to the configuration",
    ),
    "application": MessageLookupByLibrary.simpleMessage("Application"),
    "applicationDesc": MessageLookupByLibrary.simpleMessage(
      "Modify application related settings",
    ),
    "auto": MessageLookupByLibrary.simpleMessage("Auto"),
    "autoCloseConnections": MessageLookupByLibrary.simpleMessage(
      "Auto close connections",
    ),
    "autoCloseConnectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Auto close connections after change node",
    ),
    "autoIpv6": MessageLookupByLibrary.simpleMessage("Auto IPv6"),
    "autoIpv6Desc": MessageLookupByLibrary.simpleMessage(
      "Toggle IPv6 automatically based on local network support",
    ),
    "autoLaunch": MessageLookupByLibrary.simpleMessage("Auto launch"),
    "autoLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Follow the system self startup",
    ),
    "autoRenewOff": MessageLookupByLibrary.simpleMessage("Auto-renew off"),
    "autoRenewOn": MessageLookupByLibrary.simpleMessage("Auto-renew on"),
    "autoRun": MessageLookupByLibrary.simpleMessage("AutoRun"),
    "autoRunDesc": MessageLookupByLibrary.simpleMessage(
      "Auto run when the application is opened",
    ),
    "autoSetSystemDns": MessageLookupByLibrary.simpleMessage(
      "Auto set system DNS",
    ),
    "autoUpdate": MessageLookupByLibrary.simpleMessage("Auto update"),
    "autoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Auto update interval (minutes)",
    ),
    "availablePlans": MessageLookupByLibrary.simpleMessage("Choose a Plan"),
    "backup": MessageLookupByLibrary.simpleMessage("Backup"),
    "backupAndRestore": MessageLookupByLibrary.simpleMessage(
      "Backup and Restore",
    ),
    "backupAndRestoreDesc": MessageLookupByLibrary.simpleMessage(
      "Sync data via WebDAV or files",
    ),
    "backupSuccess": MessageLookupByLibrary.simpleMessage("Backup success"),
    "balance": MessageLookupByLibrary.simpleMessage("Balance"),
    "basicConfig": MessageLookupByLibrary.simpleMessage("Basic configuration"),
    "basicConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Modify the basic configuration globally",
    ),
    "bind": MessageLookupByLibrary.simpleMessage("Bind"),
    "blacklistMode": MessageLookupByLibrary.simpleMessage("Blacklist mode"),
    "blockQuic": MessageLookupByLibrary.simpleMessage("Block QUIC"),
    "blockQuicDesc": MessageLookupByLibrary.simpleMessage(
      "Reject UDP 443 traffic to force connections back to TCP",
    ),
    "blockWebRtc": MessageLookupByLibrary.simpleMessage("Block WebRTC"),
    "blockWebRtcDesc": MessageLookupByLibrary.simpleMessage(
      "Reject STUN traffic to reduce WebRTC IP leaks. Calls and live audio may stop working.",
    ),
    "buyWithBalance": MessageLookupByLibrary.simpleMessage("Use balance"),
    "bypassDomain": MessageLookupByLibrary.simpleMessage("Bypass domain"),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Only takes effect when the system proxy is enabled",
    ),
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "The cache is corrupt. Do you want to clear it?",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelSelectAll": MessageLookupByLibrary.simpleMessage(
      "Cancel select all",
    ),
    "checkApi": MessageLookupByLibrary.simpleMessage("Check API"),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("Check for updates"),
    "checkUpdateError": MessageLookupByLibrary.simpleMessage(
      "The current application is already the latest version",
    ),
    "checkUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to check for updates. Please check your network and try again",
    ),
    "checkingPayment": MessageLookupByLibrary.simpleMessage("Checking..."),
    "clearData": MessageLookupByLibrary.simpleMessage("Clear Data"),
    "clearProxyChain": MessageLookupByLibrary.simpleMessage(
      "Clear chain config",
    ),
    "clipboardExport": MessageLookupByLibrary.simpleMessage("Export clipboard"),
    "clipboardImport": MessageLookupByLibrary.simpleMessage("Clipboard import"),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "codeSent": MessageLookupByLibrary.simpleMessage("Verification code sent"),
    "color": MessageLookupByLibrary.simpleMessage("Color"),
    "colorSchemes": MessageLookupByLibrary.simpleMessage("Color schemes"),
    "columns": MessageLookupByLibrary.simpleMessage("Columns"),
    "commission": MessageLookupByLibrary.simpleMessage("Commission"),
    "commissionBalance": m0,
    "compatible": MessageLookupByLibrary.simpleMessage("Compatibility mode"),
    "configDataDetected": MessageLookupByLibrary.simpleMessage(
      "Data detected in configuration",
    ),
    "configParseErrorAtLine": m1,
    "configTypeMismatch": m2,
    "configValueTypeBoolean": MessageLookupByLibrary.simpleMessage("a boolean"),
    "configValueTypeInteger": MessageLookupByLibrary.simpleMessage(
      "an integer",
    ),
    "configValueTypeList": MessageLookupByLibrary.simpleMessage("a list"),
    "configValueTypeNull": MessageLookupByLibrary.simpleMessage(
      "an empty value",
    ),
    "configValueTypeNumber": MessageLookupByLibrary.simpleMessage("a number"),
    "configValueTypeObject": MessageLookupByLibrary.simpleMessage("an object"),
    "configValueTypeText": MessageLookupByLibrary.simpleMessage("text"),
    "configYamlFormatHint": MessageLookupByLibrary.simpleMessage(
      "Check the indentation and \"-\" list markers near this line.",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmClearAllData": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to clear all data?",
    ),
    "confirmForceCrashCore": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to force crash the core?",
    ),
    "confirmOverwriteTip": MessageLookupByLibrary.simpleMessage(
      "Existing data will be overwritten after confirmation",
    ),
    "confirmPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Re-enter your password",
    ),
    "confirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Confirm Password",
    ),
    "confirmPasswordValidation": MessageLookupByLibrary.simpleMessage(
      "Please confirm your password",
    ),
    "confirmPurchase": MessageLookupByLibrary.simpleMessage("Confirm purchase"),
    "connected": MessageLookupByLibrary.simpleMessage("Connected"),
    "connecting": MessageLookupByLibrary.simpleMessage("Connecting..."),
    "connection": MessageLookupByLibrary.simpleMessage("Connection"),
    "connections": MessageLookupByLibrary.simpleMessage("Connections"),
    "connectionsDesc": MessageLookupByLibrary.simpleMessage(
      "View current connections data",
    ),
    "connectivity": MessageLookupByLibrary.simpleMessage("Connectivity："),
    "content": MessageLookupByLibrary.simpleMessage("Content"),
    "contentScheme": MessageLookupByLibrary.simpleMessage("Content"),
    "controlGlobalAddedRules": MessageLookupByLibrary.simpleMessage(
      "Control global added rules",
    ),
    "copy": MessageLookupByLibrary.simpleMessage("Copy"),
    "copyEnvVar": MessageLookupByLibrary.simpleMessage(
      "Copying environment variables",
    ),
    "copyLink": MessageLookupByLibrary.simpleMessage("Copy link"),
    "copySuccess": MessageLookupByLibrary.simpleMessage("Copy success"),
    "core": MessageLookupByLibrary.simpleMessage("Core"),
    "coreStatus": MessageLookupByLibrary.simpleMessage("Core status"),
    "crashTest": MessageLookupByLibrary.simpleMessage("Crash test"),
    "create": MessageLookupByLibrary.simpleMessage("Create"),
    "creationTime": MessageLookupByLibrary.simpleMessage("Creation time"),
    "custom": MessageLookupByLibrary.simpleMessage("Custom"),
    "customOutboundInUse": m3,
    "cut": MessageLookupByLibrary.simpleMessage("Cut"),
    "dark": MessageLookupByLibrary.simpleMessage("Dark"),
    "dashboard": MessageLookupByLibrary.simpleMessage("Dashboard"),
    "daysAgo": m4,
    "defaultNameserver": MessageLookupByLibrary.simpleMessage(
      "Default nameserver",
    ),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "For resolving DNS server",
    ),
    "defaultText": MessageLookupByLibrary.simpleMessage("Default"),
    "delay": MessageLookupByLibrary.simpleMessage("Delay"),
    "delayTest": MessageLookupByLibrary.simpleMessage("Delay Test"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteAccount": MessageLookupByLibrary.simpleMessage("Delete account"),
    "deleteAccountAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "I understand that this permanently deletes my account",
    ),
    "deleteAccountFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to delete account",
    ),
    "deleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
      "Account deleted",
    ),
    "deleteAccountWarning": MessageLookupByLibrary.simpleMessage(
      "Permanently deleting your account removes the account, active plans, balance, purchase history, and associated cloud data. This action cannot be undone.",
    ),
    "deleteMultipTip": m5,
    "deleteTip": m6,
    "desc": MessageLookupByLibrary.simpleMessage(
      "A multi-platform proxy client based on ClashMeta, simple and easy to use, open-source and ad-free.",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("Destination"),
    "destinationGeoIP": MessageLookupByLibrary.simpleMessage(
      "Destination GeoIP",
    ),
    "destinationIPASN": MessageLookupByLibrary.simpleMessage(
      "Destination IPASN",
    ),
    "details": m7,
    "detectionTip": MessageLookupByLibrary.simpleMessage(
      "Relying on third-party api is for reference only",
    ),
    "developerMode": MessageLookupByLibrary.simpleMessage("Developer mode"),
    "developerModeEnableTip": MessageLookupByLibrary.simpleMessage(
      "Developer mode is enabled.",
    ),
    "direct": MessageLookupByLibrary.simpleMessage("Direct"),
    "disableUDP": MessageLookupByLibrary.simpleMessage("Disable UDP"),
    "disconnected": MessageLookupByLibrary.simpleMessage("Disconnected"),
    "discountCodeOptional": MessageLookupByLibrary.simpleMessage(
      "Discount code (optional)",
    ),
    "discovery": MessageLookupByLibrary.simpleMessage(
      "Discovery a new version",
    ),
    "dnsDesc": MessageLookupByLibrary.simpleMessage(
      "Update DNS related settings",
    ),
    "dnsHijacking": MessageLookupByLibrary.simpleMessage("DNS hijacking"),
    "dnsMode": MessageLookupByLibrary.simpleMessage("DNS mode"),
    "doYouWantToPass": MessageLookupByLibrary.simpleMessage(
      "Do you want to pass",
    ),
    "documentCenter": MessageLookupByLibrary.simpleMessage("Document Center"),
    "domain": MessageLookupByLibrary.simpleMessage("Domain"),
    "download": MessageLookupByLibrary.simpleMessage("Download"),
    "earlyRenew": MessageLookupByLibrary.simpleMessage("Early renewal"),
    "edit": MessageLookupByLibrary.simpleMessage("Edit"),
    "editGlobalRules": MessageLookupByLibrary.simpleMessage(
      "Edit global rules",
    ),
    "editProxyGroup": MessageLookupByLibrary.simpleMessage("Edit proxy group"),
    "editRule": MessageLookupByLibrary.simpleMessage("Edit rule"),
    "emailCodeHint": MessageLookupByLibrary.simpleMessage(
      "Enter the 6-digit code",
    ),
    "emailCodeLabel": MessageLookupByLibrary.simpleMessage("Email Code"),
    "emailCodeValidation": MessageLookupByLibrary.simpleMessage(
      "Please enter the email code",
    ),
    "emailFormatValidation": MessageLookupByLibrary.simpleMessage(
      "Invalid email format",
    ),
    "emailHint": MessageLookupByLibrary.simpleMessage("Enter email address"),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "emailPassword": MessageLookupByLibrary.simpleMessage("Email & Password"),
    "emailValidation": MessageLookupByLibrary.simpleMessage(
      "Please enter email",
    ),
    "emergencyMode": MessageLookupByLibrary.simpleMessage("Emergency Mode"),
    "emergencyModeDesc": MessageLookupByLibrary.simpleMessage(
      "Enable this option to switch to backup nodes when regular lines are unavailable",
    ),
    "emptyTip": m8,
    "en": MessageLookupByLibrary.simpleMessage("English"),
    "enableAutoRenew": MessageLookupByLibrary.simpleMessage(
      "Enable auto-renew",
    ),
    "entries": MessageLookupByLibrary.simpleMessage(" entries"),
    "entriesCount": m9,
    "exclude": MessageLookupByLibrary.simpleMessage("Hidden from recent tasks"),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "When the app is in the background, the app is hidden from the recent task",
    ),
    "excludeProxyFilter": MessageLookupByLibrary.simpleMessage(
      "Exclude proxy filter",
    ),
    "excludeType": MessageLookupByLibrary.simpleMessage("Exclude type"),
    "existsTip": m10,
    "exit": MessageLookupByLibrary.simpleMessage("Exit"),
    "expand": MessageLookupByLibrary.simpleMessage("Standard"),
    "expectedStatus": MessageLookupByLibrary.simpleMessage("Expected status"),
    "expireDate": m11,
    "exportFile": MessageLookupByLibrary.simpleMessage("Export file"),
    "exportLogs": MessageLookupByLibrary.simpleMessage("Export logs"),
    "exportSuccess": MessageLookupByLibrary.simpleMessage("Export Success"),
    "expressiveScheme": MessageLookupByLibrary.simpleMessage("Expressive"),
    "externalController": MessageLookupByLibrary.simpleMessage(
      "ExternalController",
    ),
    "externalControllerDesc": MessageLookupByLibrary.simpleMessage(
      "Once enabled, the Clash kernel can be controlled on the configured port",
    ),
    "externalFetch": MessageLookupByLibrary.simpleMessage("External fetch"),
    "externalLink": MessageLookupByLibrary.simpleMessage("External link"),
    "fakeipFilter": MessageLookupByLibrary.simpleMessage("Fakeip filter"),
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Fakeip range"),
    "fallback": MessageLookupByLibrary.simpleMessage("Fallback"),
    "fallbackDesc": MessageLookupByLibrary.simpleMessage(
      "Generally use offshore DNS",
    ),
    "fallbackFilter": MessageLookupByLibrary.simpleMessage("Fallback filter"),
    "fetchOrdersFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to load purchase records",
    ),
    "fetchPlansFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to load plans",
    ),
    "fidelityScheme": MessageLookupByLibrary.simpleMessage("Fidelity"),
    "file": MessageLookupByLibrary.simpleMessage("File"),
    "fileDesc": MessageLookupByLibrary.simpleMessage("Directly upload profile"),
    "fileIsUpdate": MessageLookupByLibrary.simpleMessage(
      "The file has been modified. Do you want to save the changes?",
    ),
    "findProcessMode": MessageLookupByLibrary.simpleMessage("Find process"),
    "findProcessModeDesc": MessageLookupByLibrary.simpleMessage(
      "There is a certain performance loss after opening",
    ),
    "fontFamily": MessageLookupByLibrary.simpleMessage("FontFamily"),
    "forceRestartCoreTip": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to force restart the core?",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "fruitSaladScheme": MessageLookupByLibrary.simpleMessage("FruitSalad"),
    "geoAutoUpdate": MessageLookupByLibrary.simpleMessage("Auto Update"),
    "geoAutoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Auto Update Interval",
    ),
    "geoAutoUpdateIntervalTip": MessageLookupByLibrary.simpleMessage(
      "Auto update interval must be between 1 and 8760 hours",
    ),
    "geoOptions": MessageLookupByLibrary.simpleMessage("Geo Options"),
    "geoResources": MessageLookupByLibrary.simpleMessage("Geo Resources"),
    "geoSkipped": m12,
    "geoUpdated": m13,
    "geoUpdating": m14,
    "geodataLoader": MessageLookupByLibrary.simpleMessage(
      "Geo Low Memory Mode",
    ),
    "geodataLoaderDesc": MessageLookupByLibrary.simpleMessage(
      "Enabling will use the Geo low memory loader",
    ),
    "geoipCode": MessageLookupByLibrary.simpleMessage("Geoip code"),
    "getProfileSuccess": MessageLookupByLibrary.simpleMessage(
      "Profile imported successfully",
    ),
    "global": MessageLookupByLibrary.simpleMessage("Global"),
    "go": MessageLookupByLibrary.simpleMessage("Go"),
    "goLogin": MessageLookupByLibrary.simpleMessage("Log in"),
    "goPay": MessageLookupByLibrary.simpleMessage("Pay"),
    "goToConfigureScript": MessageLookupByLibrary.simpleMessage(
      "Go to configure script",
    ),
    "hasCacheChange": MessageLookupByLibrary.simpleMessage(
      "Do you want to cache the changes?",
    ),
    "haveAccountAlready": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
    ),
    "hide": MessageLookupByLibrary.simpleMessage("Hide"),
    "hideFromList": MessageLookupByLibrary.simpleMessage("Hide from list"),
    "host": MessageLookupByLibrary.simpleMessage("Host"),
    "hostsDesc": MessageLookupByLibrary.simpleMessage("Add Hosts"),
    "hotkeyConflict": MessageLookupByLibrary.simpleMessage("Hotkey conflict"),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage(
      "Hotkey Management",
    ),
    "hotkeyManagementDesc": MessageLookupByLibrary.simpleMessage(
      "Use keyboard to control applications",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("Hours"),
    "hoursAgo": m15,
    "hoursCount": m16,
    "iHavePaid": MessageLookupByLibrary.simpleMessage("I have paid"),
    "icon": MessageLookupByLibrary.simpleMessage("Icon"),
    "iconStyle": MessageLookupByLibrary.simpleMessage("Icon style"),
    "iconUrl": MessageLookupByLibrary.simpleMessage("Icon URL"),
    "import": MessageLookupByLibrary.simpleMessage("Import"),
    "importFile": MessageLookupByLibrary.simpleMessage("Import from file"),
    "importFromURL": MessageLookupByLibrary.simpleMessage("Import from URL"),
    "importUrl": MessageLookupByLibrary.simpleMessage("Import from URL"),
    "includeAll": MessageLookupByLibrary.simpleMessage(
      "Include all proxies and providers",
    ),
    "includeAllProxies": MessageLookupByLibrary.simpleMessage(
      "Include all proxies",
    ),
    "includeAllProxyProviders": MessageLookupByLibrary.simpleMessage(
      "Include all proxy providers",
    ),
    "infiniteTime": MessageLookupByLibrary.simpleMessage("Long term effective"),
    "init": MessageLookupByLibrary.simpleMessage("Init"),
    "inputCorrectHotkey": MessageLookupByLibrary.simpleMessage(
      "Please enter the correct hotkey",
    ),
    "intelligentSelected": MessageLookupByLibrary.simpleMessage(
      "Intelligent selection",
    ),
    "internet": MessageLookupByLibrary.simpleMessage("Internet"),
    "interval": MessageLookupByLibrary.simpleMessage("Interval"),
    "intranetIP": MessageLookupByLibrary.simpleMessage("Intranet IP"),
    "invalidAmount": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid amount",
    ),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Invalid backup file",
    ),
    "invalidCertificateContent": MessageLookupByLibrary.simpleMessage(
      "The server certificate could not be verified. If you trust this network and server, you can skip verification for this retry only.",
    ),
    "invalidCertificateTitle": MessageLookupByLibrary.simpleMessage(
      "Certificate Verification Failed",
    ),
    "inviteCodeHint": MessageLookupByLibrary.simpleMessage("Enter invite code"),
    "inviteCodeLabel": MessageLookupByLibrary.simpleMessage("Invite Code"),
    "inviteCodeValidation": MessageLookupByLibrary.simpleMessage(
      "Please enter the invite code",
    ),
    "ipcidr": MessageLookupByLibrary.simpleMessage("Ipcidr"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage(
      "When turned on it will be able to receive IPv6 traffic",
    ),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage(
      "Allow IPv6 inbound",
    ),
    "ja": MessageLookupByLibrary.simpleMessage("Japanese"),
    "justNow": MessageLookupByLibrary.simpleMessage("Just now"),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "Tcp keep alive interval",
    ),
    "key": MessageLookupByLibrary.simpleMessage("Key"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "layout": MessageLookupByLibrary.simpleMessage("Layout"),
    "lazy": MessageLookupByLibrary.simpleMessage("Lazy loading"),
    "light": MessageLookupByLibrary.simpleMessage("Light"),
    "list": MessageLookupByLibrary.simpleMessage("List"),
    "listen": MessageLookupByLibrary.simpleMessage("Listen"),
    "loadTest": MessageLookupByLibrary.simpleMessage("Load test"),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "local": MessageLookupByLibrary.simpleMessage("Local"),
    "localBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Backup local data to local",
    ),
    "log": MessageLookupByLibrary.simpleMessage("Log"),
    "logLevel": MessageLookupByLibrary.simpleMessage("LogLevel"),
    "logcat": MessageLookupByLibrary.simpleMessage("Logcat"),
    "logcatDesc": MessageLookupByLibrary.simpleMessage(
      "Disabling will hide the log entry",
    ),
    "loggedOutViewDesc": MessageLookupByLibrary.simpleMessage(
      "Login to view account info and manage subscriptions",
    ),
    "loggedOutViewTitle": MessageLookupByLibrary.simpleMessage("oixCloud"),
    "loginFailed": MessageLookupByLibrary.simpleMessage("Login Failed"),
    "loginSuccess": MessageLookupByLibrary.simpleMessage("Login Successful"),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Login"),
    "logoutAndDeleteToken": MessageLookupByLibrary.simpleMessage(
      "Sign Out and Delete Token",
    ),
    "logoutContent": MessageLookupByLibrary.simpleMessage(
      "The token is removed from this device either way. Deleting it from oixCloud may sign out other devices using the same token.",
    ),
    "logoutLocalOnly": MessageLookupByLibrary.simpleMessage("Sign Out Only"),
    "logoutTitle": MessageLookupByLibrary.simpleMessage("Logout"),
    "logs": MessageLookupByLibrary.simpleMessage("Logs"),
    "logsDesc": MessageLookupByLibrary.simpleMessage("Log capture records"),
    "logsTest": MessageLookupByLibrary.simpleMessage("Logs test"),
    "loopback": MessageLookupByLibrary.simpleMessage("Loopback unlock tool"),
    "loopbackDesc": MessageLookupByLibrary.simpleMessage(
      "Used for UWP loopback unlocking",
    ),
    "loose": MessageLookupByLibrary.simpleMessage("Loose"),
    "mainlandNetworkWarning": MessageLookupByLibrary.simpleMessage(
      "May not be suitable for networks in mainland China",
    ),
    "maxFailedTimes": MessageLookupByLibrary.simpleMessage("Max failed times"),
    "memoryInfo": MessageLookupByLibrary.simpleMessage("Memory info"),
    "messageTest": MessageLookupByLibrary.simpleMessage("Message test"),
    "messageTestTip": MessageLookupByLibrary.simpleMessage(
      "This is a message.",
    ),
    "min": MessageLookupByLibrary.simpleMessage("Min"),
    "minimalConfiguration": MessageLookupByLibrary.simpleMessage(
      "Minimal Configuration",
    ),
    "minimalConfigurationDesc": MessageLookupByLibrary.simpleMessage(
      "Use a simplified rule set to generate a smaller profile",
    ),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage("Minimize on exit"),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "Modify the default system exit event",
    ),
    "minutesAgo": m17,
    "mixedPort": MessageLookupByLibrary.simpleMessage("Mixed Port"),
    "mode": MessageLookupByLibrary.simpleMessage("Mode"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("Monochrome"),
    "monthsAgo": m18,
    "more": MessageLookupByLibrary.simpleMessage("More"),
    "myOrders": MessageLookupByLibrary.simpleMessage("Purchased Plans"),
    "name": MessageLookupByLibrary.simpleMessage("Name"),
    "nameserver": MessageLookupByLibrary.simpleMessage("Nameserver"),
    "nameserverDesc": MessageLookupByLibrary.simpleMessage(
      "For resolving domain",
    ),
    "nameserverPolicy": MessageLookupByLibrary.simpleMessage(
      "Nameserver policy",
    ),
    "nameserverPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "Specify the corresponding nameserver policy",
    ),
    "network": MessageLookupByLibrary.simpleMessage("Network"),
    "networkDesc": MessageLookupByLibrary.simpleMessage(
      "Modify network-related settings",
    ),
    "networkDetection": MessageLookupByLibrary.simpleMessage(
      "Network detection",
    ),
    "networkException": MessageLookupByLibrary.simpleMessage(
      "Network exception, please check your connection and try again",
    ),
    "networkSpeed": MessageLookupByLibrary.simpleMessage("Network speed"),
    "networkType": MessageLookupByLibrary.simpleMessage("Network type"),
    "neutralScheme": MessageLookupByLibrary.simpleMessage("Neutral"),
    "newPasswordLabel": MessageLookupByLibrary.simpleMessage("New password"),
    "nicknameHint": MessageLookupByLibrary.simpleMessage(
      "Letters and numbers, up to 12 characters",
    ),
    "nicknameLabel": MessageLookupByLibrary.simpleMessage("Nickname"),
    "nicknameValidation": MessageLookupByLibrary.simpleMessage(
      "Please enter a nickname",
    ),
    "noAvailablePlans": MessageLookupByLibrary.simpleMessage(
      "No plans available",
    ),
    "noData": MessageLookupByLibrary.simpleMessage("No data"),
    "noHotKey": MessageLookupByLibrary.simpleMessage("No HotKey"),
    "noInfo": MessageLookupByLibrary.simpleMessage("No info"),
    "noNetwork": MessageLookupByLibrary.simpleMessage("No network"),
    "noNetworkApp": MessageLookupByLibrary.simpleMessage("No network APP"),
    "noPaymentMethods": MessageLookupByLibrary.simpleMessage(
      "No payment methods available",
    ),
    "noProxy": MessageLookupByLibrary.simpleMessage("No proxy"),
    "noPurchaseRecords": MessageLookupByLibrary.simpleMessage(
      "No purchased plans yet",
    ),
    "noResolve": MessageLookupByLibrary.simpleMessage("No resolve IP"),
    "noUpgradablePlans": MessageLookupByLibrary.simpleMessage(
      "No upgradable plans",
    ),
    "none": MessageLookupByLibrary.simpleMessage("none"),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "The current proxy group cannot be selected.",
    ),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "No profile, Please add a profile",
    ),
    "nullTip": m19,
    "numberTip": m20,
    "oixCloud": MessageLookupByLibrary.simpleMessage("oixCloud"),
    "onlyIcon": MessageLookupByLibrary.simpleMessage("Icon"),
    "onlyStatisticsProxy": MessageLookupByLibrary.simpleMessage(
      "Only statistics proxy",
    ),
    "onlyStatisticsProxyDesc": MessageLookupByLibrary.simpleMessage(
      "When turned on, only statistics proxy traffic",
    ),
    "openDashboard": MessageLookupByLibrary.simpleMessage("Open dashboard"),
    "openInBrowser": MessageLookupByLibrary.simpleMessage("Open in browser"),
    "operationFailed": MessageLookupByLibrary.simpleMessage("Operation failed"),
    "operationSuccess": MessageLookupByLibrary.simpleMessage(
      "Operation successful",
    ),
    "optionalParameters": MessageLookupByLibrary.simpleMessage(
      "Optional Parameters",
    ),
    "options": MessageLookupByLibrary.simpleMessage("Options"),
    "orderAndPay": MessageLookupByLibrary.simpleMessage("Pay online"),
    "other": MessageLookupByLibrary.simpleMessage("Other"),
    "outboundMode": MessageLookupByLibrary.simpleMessage("Outbound mode"),
    "override": MessageLookupByLibrary.simpleMessage("Override"),
    "overrideDns": MessageLookupByLibrary.simpleMessage("Override Dns"),
    "overrideDnsDesc": MessageLookupByLibrary.simpleMessage(
      "Turning it on will override the DNS options in the profile",
    ),
    "overrideMode": MessageLookupByLibrary.simpleMessage("Override mode"),
    "overrideScript": MessageLookupByLibrary.simpleMessage("Override script"),
    "overseasNetworkEnvironment": MessageLookupByLibrary.simpleMessage(
      "Overseas Network Environment",
    ),
    "overseasNetworkEnvironmentDesc": MessageLookupByLibrary.simpleMessage(
      "Turn on this option if you are currently outside mainland China",
    ),
    "overwriteTypeCustom": MessageLookupByLibrary.simpleMessage("Custom"),
    "overwriteTypeCustomDesc": MessageLookupByLibrary.simpleMessage(
      "Custom mode, fully customize proxy groups and rules",
    ),
    "palette": MessageLookupByLibrary.simpleMessage("Palette"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "passwordRuleHint": MessageLookupByLibrary.simpleMessage(
      "10-36 chars incl. upper/lowercase, number and symbol",
    ),
    "passwordValidation": MessageLookupByLibrary.simpleMessage(
      "Please enter password",
    ),
    "paste": MessageLookupByLibrary.simpleMessage("Paste"),
    "paymentAmount": MessageLookupByLibrary.simpleMessage("Payment amount"),
    "paymentMethod": MessageLookupByLibrary.simpleMessage("Payment method"),
    "paymentRequestFailed": MessageLookupByLibrary.simpleMessage(
      "Payment request failed",
    ),
    "paymentSuccess": MessageLookupByLibrary.simpleMessage(
      "Payment successful",
    ),
    "paymentUnknownResponse": MessageLookupByLibrary.simpleMessage(
      "Payment endpoint returned an unknown format",
    ),
    "planEnded": MessageLookupByLibrary.simpleMessage("Ended"),
    "planInUse": MessageLookupByLibrary.simpleMessage("In use"),
    "planNotActivated": MessageLookupByLibrary.simpleMessage(
      "Pending activation",
    ),
    "planNumber": m21,
    "pleaseBindWebDAV": MessageLookupByLibrary.simpleMessage(
      "Please bind WebDAV",
    ),
    "pleaseEnterScriptName": MessageLookupByLibrary.simpleMessage(
      "Please enter a script name",
    ),
    "pleaseInputAdminPassword": MessageLookupByLibrary.simpleMessage(
      "Please enter the admin password",
    ),
    "pleaseUploadValidQrcode": MessageLookupByLibrary.simpleMessage(
      "Please upload a valid QR code",
    ),
    "points": MessageLookupByLibrary.simpleMessage("Points"),
    "port": MessageLookupByLibrary.simpleMessage("Port"),
    "portConflictTip": MessageLookupByLibrary.simpleMessage(
      "Please enter a different port",
    ),
    "portTip": m22,
    "portUnavailableMessage": m23,
    "portUnavailableTitle": MessageLookupByLibrary.simpleMessage(
      "Port unavailable",
    ),
    "preferH3Desc": MessageLookupByLibrary.simpleMessage(
      "Prioritize the use of DOH\'s http/3",
    ),
    "pressKeyboard": MessageLookupByLibrary.simpleMessage(
      "Please press the keyboard.",
    ),
    "preview": MessageLookupByLibrary.simpleMessage("Preview"),
    "process": MessageLookupByLibrary.simpleMessage("Process"),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "profileAutoUpdateIntervalInvalidValidationDesc":
        MessageLookupByLibrary.simpleMessage(
          "Please input a valid interval time format",
        ),
    "profileAutoUpdateIntervalNullValidationDesc":
        MessageLookupByLibrary.simpleMessage(
          "Please enter the auto update interval time",
        ),
    "profileHasUpdate": MessageLookupByLibrary.simpleMessage(
      "The profile has been modified. Do you want to disable auto update?",
    ),
    "profileNameNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Please input the profile name",
    ),
    "profileParseErrorDesc": MessageLookupByLibrary.simpleMessage(
      "Profile parse error",
    ),
    "profileUrlInvalidValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Please input a valid profile URL",
    ),
    "profileUrlNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Please input the profile URL",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Profiles"),
    "profilesSort": MessageLookupByLibrary.simpleMessage("Profiles sort"),
    "project": MessageLookupByLibrary.simpleMessage("Project"),
    "providers": MessageLookupByLibrary.simpleMessage("Providers"),
    "proxies": MessageLookupByLibrary.simpleMessage("Proxies"),
    "proxyChainAvailableNodes": MessageLookupByLibrary.simpleMessage(
      "Available nodes",
    ),
    "proxyChainConflictTip": m24,
    "proxyChainCustomNode": MessageLookupByLibrary.simpleMessage("Custom node"),
    "proxyChainCustomNodes": MessageLookupByLibrary.simpleMessage(
      "Custom nodes",
    ),
    "proxyChainEmpty": MessageLookupByLibrary.simpleMessage(
      "No nodes in the proxy chain",
    ),
    "proxyChainEntry": MessageLookupByLibrary.simpleMessage("Entry"),
    "proxyChainExit": MessageLookupByLibrary.simpleMessage("Exit"),
    "proxyChainInstruction": MessageLookupByLibrary.simpleMessage(
      "Click nodes in order: the first node is the entry and the last node is the exit. Select the exit node to use the chain.",
    ),
    "proxyChainMinimumNodes": MessageLookupByLibrary.simpleMessage(
      "Proxy chains require at least 2 nodes",
    ),
    "proxyChainMinimumNodesHint": MessageLookupByLibrary.simpleMessage(
      "Proxy chains require at least 2 nodes. Add an exit node.",
    ),
    "proxyChainNodeAdded": MessageLookupByLibrary.simpleMessage(
      "Node added to proxy chain",
    ),
    "proxyChainOtherNodes": MessageLookupByLibrary.simpleMessage("Other nodes"),
    "proxyChainRelatedChainsUpdated": MessageLookupByLibrary.simpleMessage(
      "Related proxy chains updated",
    ),
    "proxyChainSavedAndApplied": MessageLookupByLibrary.simpleMessage(
      "Proxy chain saved and applied. Select the exit node to use it",
    ),
    "proxyChainSelectedNodes": MessageLookupByLibrary.simpleMessage(
      "Proxy chain",
    ),
    "proxyChainUnavailableNodeTip": m25,
    "proxyChainUriNodeSupportedFormats": MessageLookupByLibrary.simpleMessage(
      "Supported formats: ss://, ssr://, vmess://, vless://, trojan://, anytls://, hysteria:// / hy://, hysteria2:// / hy2://, tuic://, wireguard:// / wg://, http(s)://, socks(5)://",
    ),
    "proxyChainWarning": MessageLookupByLibrary.simpleMessage(
      "Proxy chaining can significantly reduce network speed. Keep it disabled unless you clearly need it.",
    ),
    "proxyChains": MessageLookupByLibrary.simpleMessage("Proxy chains"),
    "proxyFilter": MessageLookupByLibrary.simpleMessage("Proxy filter"),
    "proxyGroup": MessageLookupByLibrary.simpleMessage("Proxy group"),
    "proxyGroupEmpty": MessageLookupByLibrary.simpleMessage(
      "Proxy group is empty",
    ),
    "proxyGroupMembersEmpty": MessageLookupByLibrary.simpleMessage(
      "Add a proxy, provider, or include-all option",
    ),
    "proxyGroupNameEmpty": MessageLookupByLibrary.simpleMessage(
      "Proxy group name cannot be empty",
    ),
    "proxyNameserver": MessageLookupByLibrary.simpleMessage("Proxy nameserver"),
    "proxyNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Domain for resolving proxy nodes",
    ),
    "proxyPort": MessageLookupByLibrary.simpleMessage("ProxyPort"),
    "proxyProviders": MessageLookupByLibrary.simpleMessage("Proxy providers"),
    "pruneCache": MessageLookupByLibrary.simpleMessage("Prune cache"),
    "purchaseTime": m26,
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("Pure black mode"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QR code"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage(
      "Scan QR code to obtain profile",
    ),
    "quickFill": MessageLookupByLibrary.simpleMessage("Quick fill"),
    "rainbowScheme": MessageLookupByLibrary.simpleMessage("Rainbow"),
    "rawOutboundInUse": m27,
    "receivingAddress": MessageLookupByLibrary.simpleMessage(
      "Receiving address",
    ),
    "recharge": MessageLookupByLibrary.simpleMessage("Recharge"),
    "rechargeAmount": MessageLookupByLibrary.simpleMessage(
      "Recharge amount (¥)",
    ),
    "redirPort": MessageLookupByLibrary.simpleMessage("Redir Port"),
    "redo": MessageLookupByLibrary.simpleMessage("redo"),
    "refresh": MessageLookupByLibrary.simpleMessage("Refresh"),
    "refreshAfterPayment": MessageLookupByLibrary.simpleMessage(
      "After payment, pull down to refresh and check the result",
    ),
    "register": MessageLookupByLibrary.simpleMessage("Register"),
    "registerClosed": MessageLookupByLibrary.simpleMessage(
      "Registration is currently closed",
    ),
    "registerFailed": MessageLookupByLibrary.simpleMessage(
      "Registration failed",
    ),
    "registerTitle": MessageLookupByLibrary.simpleMessage("Create Account"),
    "relayGroupUnsupported": MessageLookupByLibrary.simpleMessage(
      "Relay groups were removed by the core. Choose another type.",
    ),
    "remaining": m28,
    "remainingStock": m29,
    "remote": MessageLookupByLibrary.simpleMessage("Remote"),
    "remoteBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Backup local data to WebDAV",
    ),
    "remoteDestination": MessageLookupByLibrary.simpleMessage(
      "Remote destination",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("Remove"),
    "rename": MessageLookupByLibrary.simpleMessage("Rename"),
    "request": MessageLookupByLibrary.simpleMessage("Request"),
    "requests": MessageLookupByLibrary.simpleMessage("Requests"),
    "requestsDesc": MessageLookupByLibrary.simpleMessage(
      "View recently request records",
    ),
    "resendCodeIn": m30,
    "reset": MessageLookupByLibrary.simpleMessage("Reset"),
    "resetEmailSent": MessageLookupByLibrary.simpleMessage(
      "Reset email sent. Paste the reset link or code from the email below.",
    ),
    "resetPageChangesTip": MessageLookupByLibrary.simpleMessage(
      "The current page has changes. Are you sure you want to reset?",
    ),
    "resetPasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Password has been reset, please sign in with your new password",
    ),
    "resetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Reset password",
    ),
    "resetTip": MessageLookupByLibrary.simpleMessage("Make sure to reset"),
    "resetTokenLabel": MessageLookupByLibrary.simpleMessage(
      "Reset link or code",
    ),
    "resetTokenValidation": MessageLookupByLibrary.simpleMessage(
      "Please enter the reset link or code",
    ),
    "resources": MessageLookupByLibrary.simpleMessage("Resources"),
    "resourcesDesc": MessageLookupByLibrary.simpleMessage(
      "External resource related info",
    ),
    "respectRules": MessageLookupByLibrary.simpleMessage("Respect rules"),
    "respectRulesDesc": MessageLookupByLibrary.simpleMessage(
      "DNS connection following rules, need to configure proxy-server-nameserver",
    ),
    "restart": MessageLookupByLibrary.simpleMessage("Restart"),
    "restartCoreTip": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to restart the core?",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Restore"),
    "restoreAllData": MessageLookupByLibrary.simpleMessage("Restore all data"),
    "restoreDefault": MessageLookupByLibrary.simpleMessage("Restore Default"),
    "restoreException": MessageLookupByLibrary.simpleMessage(
      "Recovery exception",
    ),
    "restoreFromFileDesc": MessageLookupByLibrary.simpleMessage(
      "Restore data via file",
    ),
    "restoreFromWebDAVDesc": MessageLookupByLibrary.simpleMessage(
      "Restore data via WebDAV",
    ),
    "restoreOnlyConfig": MessageLookupByLibrary.simpleMessage(
      "Restore configuration files only",
    ),
    "restoreStrategy": MessageLookupByLibrary.simpleMessage("Restore strategy"),
    "restoreStrategy_compatible": MessageLookupByLibrary.simpleMessage(
      "Compatible",
    ),
    "restoreStrategy_override": MessageLookupByLibrary.simpleMessage(
      "Override",
    ),
    "restoreSuccess": MessageLookupByLibrary.simpleMessage("Restore success"),
    "reverseEngineeringNotice": MessageLookupByLibrary.simpleMessage(
      "Reverse engineering, decompilation, disassembly, or AI-assisted analysis of this application is strictly prohibited.",
    ),
    "routeAddress": MessageLookupByLibrary.simpleMessage("Route address"),
    "routeAddressDesc": MessageLookupByLibrary.simpleMessage(
      "Config listen route address",
    ),
    "routeMode": MessageLookupByLibrary.simpleMessage("Route mode"),
    "routeMode_bypassPrivate": MessageLookupByLibrary.simpleMessage(
      "Bypass private route address",
    ),
    "routeMode_config": MessageLookupByLibrary.simpleMessage("Use config"),
    "ru": MessageLookupByLibrary.simpleMessage("Russian"),
    "rule": MessageLookupByLibrary.simpleMessage("Rule"),
    "ruleEmpty": MessageLookupByLibrary.simpleMessage("Rule is empty"),
    "ruleName": MessageLookupByLibrary.simpleMessage("Rule name"),
    "ruleProviders": MessageLookupByLibrary.simpleMessage("Rule providers"),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("Rule target"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "saveAndRetry": MessageLookupByLibrary.simpleMessage("Save and retry"),
    "saveChanges": MessageLookupByLibrary.simpleMessage(
      "Do you want to save the changes?",
    ),
    "scanOrTransferPay": MessageLookupByLibrary.simpleMessage(
      "Scan / Transfer payment",
    ),
    "scanToPayNotice": MessageLookupByLibrary.simpleMessage(
      "Scan with Alipay / WeChat to pay",
    ),
    "script": MessageLookupByLibrary.simpleMessage("Script"),
    "scriptModeDesc": MessageLookupByLibrary.simpleMessage(
      "Script mode, use external extension scripts, provide one-click override configuration capability",
    ),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "seconds": MessageLookupByLibrary.simpleMessage("Seconds"),
    "secondsCount": m31,
    "selectAll": MessageLookupByLibrary.simpleMessage("Select all"),
    "selectUpgradeTarget": MessageLookupByLibrary.simpleMessage(
      "Select upgrade target",
    ),
    "selected": MessageLookupByLibrary.simpleMessage("Selected"),
    "selectedCountTitle": m32,
    "sendCode": MessageLookupByLibrary.simpleMessage("Send Code"),
    "sendResetEmail": MessageLookupByLibrary.simpleMessage("Send reset email"),
    "serviceCheckFailed": MessageLookupByLibrary.simpleMessage(
      "Service Check Failed",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "show": MessageLookupByLibrary.simpleMessage("Show"),
    "shrink": MessageLookupByLibrary.simpleMessage("Shrink"),
    "silentLaunch": MessageLookupByLibrary.simpleMessage("SilentLaunch"),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Start in the background",
    ),
    "size": MessageLookupByLibrary.simpleMessage("Size"),
    "socksPort": MessageLookupByLibrary.simpleMessage("Socks Port"),
    "softwareCenter": MessageLookupByLibrary.simpleMessage("Software Center"),
    "soldOut": MessageLookupByLibrary.simpleMessage("Sold out"),
    "sort": MessageLookupByLibrary.simpleMessage("Sort"),
    "source": MessageLookupByLibrary.simpleMessage("Source"),
    "sourceIp": MessageLookupByLibrary.simpleMessage("Source IP"),
    "specialProxy": MessageLookupByLibrary.simpleMessage("Special proxy"),
    "specialRules": MessageLookupByLibrary.simpleMessage("special rules"),
    "speedStatistics": MessageLookupByLibrary.simpleMessage("Speed statistics"),
    "stackMode": MessageLookupByLibrary.simpleMessage("Stack mode"),
    "standard": MessageLookupByLibrary.simpleMessage("Standard"),
    "standardModeDesc": MessageLookupByLibrary.simpleMessage(
      "Standard mode, override basic configuration, provide simple rule addition capability",
    ),
    "start": MessageLookupByLibrary.simpleMessage("Start"),
    "startCorePromptContent": MessageLookupByLibrary.simpleMessage(
      "Profile has been successfully imported. Do you want to start the core now?",
    ),
    "startCorePromptTitle": MessageLookupByLibrary.simpleMessage("Prompt"),
    "startSuccess": MessageLookupByLibrary.simpleMessage(
      "Started successfully",
    ),
    "startVpn": MessageLookupByLibrary.simpleMessage("Starting VPN..."),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "statusDesc": MessageLookupByLibrary.simpleMessage(
      "System DNS will be used when turned off",
    ),
    "stop": MessageLookupByLibrary.simpleMessage("Stop"),
    "stopVpn": MessageLookupByLibrary.simpleMessage("Stopping VPN..."),
    "store": MessageLookupByLibrary.simpleMessage("Store"),
    "storeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Buy plans · Recharge · Renew & upgrade",
    ),
    "strategy": MessageLookupByLibrary.simpleMessage("Strategy"),
    "style": MessageLookupByLibrary.simpleMessage("Style"),
    "subRule": MessageLookupByLibrary.simpleMessage("Sub rule"),
    "submit": MessageLookupByLibrary.simpleMessage("Submit"),
    "sync": MessageLookupByLibrary.simpleMessage("Sync"),
    "system": MessageLookupByLibrary.simpleMessage("System"),
    "systemApp": MessageLookupByLibrary.simpleMessage("System APP"),
    "systemProxy": MessageLookupByLibrary.simpleMessage("System proxy"),
    "systemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Attach HTTP proxy to VpnService",
    ),
    "tab": MessageLookupByLibrary.simpleMessage("Tab"),
    "tabAnimation": MessageLookupByLibrary.simpleMessage("Tab animation"),
    "tabAnimationDesc": MessageLookupByLibrary.simpleMessage(
      "Effective only in mobile view",
    ),
    "tcpConcurrent": MessageLookupByLibrary.simpleMessage("TCP concurrent"),
    "tcpConcurrentDesc": MessageLookupByLibrary.simpleMessage(
      "Enabling it will allow TCP concurrency",
    ),
    "tcpFastOpen": MessageLookupByLibrary.simpleMessage("TCP Fast Open"),
    "tcpFastOpenDesc": MessageLookupByLibrary.simpleMessage(
      "Enable this option to accelerate TCP connection establishment",
    ),
    "testUrl": MessageLookupByLibrary.simpleMessage("Test url"),
    "textScale": MessageLookupByLibrary.simpleMessage("Text Scaling"),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "themeColor": MessageLookupByLibrary.simpleMessage("Theme color"),
    "themeDesc": MessageLookupByLibrary.simpleMessage(
      "Set dark mode,adjust the color",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Theme mode"),
    "tight": MessageLookupByLibrary.simpleMessage("Tight"),
    "time": MessageLookupByLibrary.simpleMessage("Time"),
    "timeSyncTip": MessageLookupByLibrary.simpleMessage(
      "The proxy protocol requires the device time and UTC time to be synchronized within a 30-second error margin. Please ensure your device time is accurate.",
    ),
    "timeout": MessageLookupByLibrary.simpleMessage("Timeout"),
    "tip": MessageLookupByLibrary.simpleMessage("tip"),
    "todayUsed": MessageLookupByLibrary.simpleMessage("Today\'s Usage"),
    "toggle": MessageLookupByLibrary.simpleMessage("Toggle"),
    "tokenLabel": MessageLookupByLibrary.simpleMessage("Access Token"),
    "tokenValidation": MessageLookupByLibrary.simpleMessage(
      "Please enter Access Token",
    ),
    "tolerance": MessageLookupByLibrary.simpleMessage("Tolerance"),
    "tonalSpotScheme": MessageLookupByLibrary.simpleMessage("TonalSpot"),
    "tools": MessageLookupByLibrary.simpleMessage("Tools"),
    "tproxyPort": MessageLookupByLibrary.simpleMessage("Tproxy Port"),
    "trafficUsage": MessageLookupByLibrary.simpleMessage("Traffic usage"),
    "transferConfirmNotice": MessageLookupByLibrary.simpleMessage(
      "The system will confirm automatically after the transfer is completed, and the selected plan will be activated.",
    ),
    "tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "tunAuthorizationFailed": MessageLookupByLibrary.simpleMessage(
      "TUN could not be enabled because administrator authorization was denied. Allow the system permission prompt and try again.",
    ),
    "tunDesc": MessageLookupByLibrary.simpleMessage(
      "only effective in administrator mode",
    ),
    "turnOff": MessageLookupByLibrary.simpleMessage("Turn Off"),
    "turnOn": MessageLookupByLibrary.simpleMessage("Turn On"),
    "twoFactorCodeOptional": MessageLookupByLibrary.simpleMessage(
      "Two-factor code (if enabled)",
    ),
    "undo": MessageLookupByLibrary.simpleMessage("undo"),
    "unifiedDelay": MessageLookupByLibrary.simpleMessage("Unified delay"),
    "unifiedDelayDesc": MessageLookupByLibrary.simpleMessage(
      "Remove extra delays such as handshaking",
    ),
    "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
    "unknownNetworkError": MessageLookupByLibrary.simpleMessage(
      "Unknown network error",
    ),
    "unnamed": MessageLookupByLibrary.simpleMessage("Unnamed"),
    "update": MessageLookupByLibrary.simpleMessage("Update"),
    "upgradePlan": MessageLookupByLibrary.simpleMessage("Upgrade plan"),
    "upload": MessageLookupByLibrary.simpleMessage("Upload"),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage(
      "Obtain profile through URL",
    ),
    "urlTip": m33,
    "useHosts": MessageLookupByLibrary.simpleMessage("Use hosts"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage("Use system hosts"),
    "userAgent": MessageLookupByLibrary.simpleMessage("User-Agent"),
    "userCenter": MessageLookupByLibrary.simpleMessage("User Center"),
    "userCenterFallback": MessageLookupByLibrary.simpleMessage(
      "User Center (Backup)",
    ),
    "value": MessageLookupByLibrary.simpleMessage("Value"),
    "vibrantScheme": MessageLookupByLibrary.simpleMessage("Vibrant"),
    "view": MessageLookupByLibrary.simpleMessage("View"),
    "vpnConfigChangeDetected": MessageLookupByLibrary.simpleMessage(
      "VPN configuration change detected",
    ),
    "vpnEnableDesc": MessageLookupByLibrary.simpleMessage(
      "Auto routes all system traffic through VpnService",
    ),
    "vpnTip": MessageLookupByLibrary.simpleMessage(
      "Changes take effect after restarting the VPN",
    ),
    "webDAVConfiguration": MessageLookupByLibrary.simpleMessage(
      "WebDAV configuration",
    ),
    "whitelistMode": MessageLookupByLibrary.simpleMessage("Whitelist mode"),
    "yearsAgo": m34,
    "zh_CN": MessageLookupByLibrary.simpleMessage("Simplified Chinese"),
  };
}

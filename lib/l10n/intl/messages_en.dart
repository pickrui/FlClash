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

  static String m0(value) => "Available ${value}";

  static String m1(count, skipped) =>
      "${count} to add, ${skipped} skipped as existing";

  static String m2(status) => "Server returned HTTP ${status}";

  static String m3(error) => "Direct: ${error}";

  static String m4(error) => "Local proxy: ${error}";

  static String m5(code) => "System error ${code}";

  static String m6(value) => "Commission ${value}";

  static String m7(line) =>
      "The configuration format is invalid at line ${line}.";

  static String m8(expected, actual) =>
      "Expected ${expected}, but found ${actual}.";

  static String m9(code) =>
      "Windows blocked the proxy core from starting (system error ${code}). Check Protection history in Windows Security and your app control policy, and verify the installer source and signature.";

  static String m10(url) => "Do you want to create a profile from ${url}?";

  static String m11(count) =>
      "${Intl.plural(count, one: '1 SUB-RULE rule was dropped, since custom profiles do not support sub-rules', other: '${count} SUB-RULE rules were dropped, since custom profiles do not support sub-rules')}";

  static String m12(count) =>
      "${Intl.plural(count, one: '1 proxy had no name or type', other: '${count} proxies had no name or type')}";

  static String m13(count) =>
      "${count} items have problems, and applying this profile may fail";

  static String m14(name) =>
      "${name} is still referenced by a group, rule, or proxy chain";

  static String m15(example) =>
      "Check the content for this rule type. Example: ${example}";

  static String m16(name) =>
      "${name} is unavailable. Choose an existing rule provider.";

  static String m17(name) =>
      "${name} is unavailable. Choose a target from this configuration.";

  static String m18(count) =>
      "${Intl.plural(count, one: '1 day ago', other: '${count} days ago')}";

  static String m19(count) => "${Intl.plural(count, other: '${count}d ago')}";

  static String m20(label) =>
      "Are you sure you want to delete the selected ${label}?";

  static String m21(label) =>
      "Are you sure you want to delete the current ${label}?";

  static String m22(label) => "${label} details";

  static String m23(port) =>
      "Local address: 127.0.0.1\nMixed port (current configuration): ${port}\nUse this mixed port for HTTP, HTTPS website proxying, or SOCKS5 on this device only.";

  static String m24(count) => "${count} of 2 independent HTTPS checks passed";

  static String m25(name) =>
      "Dialing through ${name} leads back to the proxy that uses it, so the connection was stopped";

  static String m26(label) => "${label} cannot be empty";

  static String m27(label) => "Current ${label} already exists";

  static String m28(date) => "Expires: ${date}";

  static String m29(label, message) => "${label}: ${message}";

  static String m30(name) => "${name} skipped";

  static String m31(name) => "${name} updated";

  static String m32(name) => "Updating ${name}...";

  static String m33(count) =>
      "${Intl.plural(count, one: '1 group', other: '${count} groups')}";

  static String m34(name) =>
      "Circular group reference: ${name}. Choose a different member.";

  static String m35(count) => "${count} timed out";

  static String m36(action) =>
      "Already used by “${action}”. Saving moves it here.";

  static String m37(modifiers) => "Include at least one of ${modifiers}";

  static String m38(count) =>
      "${Intl.plural(count, one: '1 hour ago', other: '${count} hours ago')}";

  static String m39(count) => "${Intl.plural(count, other: '${count}h ago')}";

  static String m40(count) => "${count} hours";

  static String m41(target) => "${target} is an invalid policy";

  static String m42(providerName) =>
      "${providerName} is an invalid proxy provider";

  static String m43(ruleSet) => "${ruleSet} is an invalid rule set";

  static String m44(subRule) => "${subRule} is an invalid SUB_RULE";

  static String m45(count) =>
      "${Intl.plural(count, one: '1 item', other: '${count} items')}";

  static String m46(line, message) => "Line ${line}: ${message}";

  static String m47(appName) =>
      "1. Open System Settings > Privacy & Security\n2. Choose Location Services\n3. Find and check ${appName} in the list\n\nWhen you are done, return to the app to continue. Thank you for your cooperation.";

  static String m48(label, max) => "${label} must be at most ${max} characters";

  static String m49(size) => "Released ${size}";

  static String m50(count) =>
      "${Intl.plural(count, one: '1 minute ago', other: '${count} minutes ago')}";

  static String m51(count) => "${Intl.plural(count, other: '${count}m ago')}";

  static String m52(count) =>
      "${Intl.plural(count, one: '1 month ago', other: '${count} months ago')}";

  static String m53(count) => "${Intl.plural(count, other: '${count}mo ago')}";

  static String m54(code) =>
      "The server denied access (HTTP ${code}). The link may have expired, or the credentials are wrong";

  static String m55(code) => "The server rejected the request (HTTP ${code})";

  static String m56(code) =>
      "Nothing was found at this address (HTTP ${code}). Check that the URL is correct";

  static String m57(code) =>
      "The server ran into a problem (HTTP ${code}). Try again later";

  static String m58(kept, total) => "${kept} of ${total} nodes kept";

  static String m59(name) => "${name}, excluded";

  static String m60(name) => "${name}, kept";

  static String m61(label) => "No ${label} yet";

  static String m62(label, min, max) =>
      "${label} must be between ${min} and ${max}";

  static String m63(label) => "${label} must be a number";

  static String m64(name) =>
      "The name \"${name}\" is already used. Rename the personal group to keep both.";

  static String m65(name) =>
      "The name ${name} is already used by another proxy or proxy group";

  static String m66(name) =>
      "The empty-group fallback must be an existing node or built-in outbound, not a proxy group: ${name}";

  static String m67(path) =>
      "Proxy groups reference each other in a loop: ${path}";

  static String m68(names) => "These proxy providers do not exist: ${names}";

  static String m69(names) =>
      "These proxies or policies do not exist: ${names}";

  static String m70(name) =>
      "${name} is a built-in policy name and cannot be used here";

  static String m71(count) =>
      "${count} items have problems, and applying this override may fail";

  static String m72(id) => "Plan #${id}";

  static String m73(port) => "Suggested port ${port} has been filled in.";

  static String m74(label) => "${label} must be between 1024 and 49151";

  static String m75(port) =>
      "The mixed port ${port} could not start listening and may be in use by another application. Change the port to retry immediately.";

  static String m76(port) => "Port ${port}";

  static String m77(days) =>
      "${Intl.plural(days, one: '1 day left', other: '${days} days left')}";

  static String m78(date, days) =>
      "Expires ${date}, ${Intl.plural(days, one: '1 day', other: '${days} days')} left";

  static String m79(profiles) =>
      "This profile is a proxy provider of ${profiles}. Remove it there first.";

  static String m80(time) => "Updated ${time}";

  static String m81(profiles) => "This resource is still used by ${profiles}";

  static String m82(profiles) =>
      "Renaming would change subscription resource references in ${profiles}";

  static String m83(profiles) =>
      "Edit references in the source profile before renaming: ${profiles}";

  static String m84(profiles) =>
      "Cannot read these profiles to check references: ${profiles}";

  static String m85(count) =>
      "${Intl.plural(count, one: '1 proxy', other: '${count} proxies')}";

  static String m86(name) =>
      "Node ${name} is already used by another enabled chain or has a proxy chain relation conflict";

  static String m87(name) => "Node ${name} is not available in this position";

  static String m88(address) =>
      "Before starting, the system proxy pointed to ${address}.";

  static String m89(name) =>
      "Before starting, traffic was routed through another VPN or virtual adapter: ${name}.";

  static String m90(count) =>
      "${Intl.plural(count, one: '1 proxy group', other: '${count} proxy groups')}";

  static String m91(count) => "${count}d";

  static String m92(count) => "${count}h";

  static String m93(count) => "${count}m";

  static String m94(name, path) =>
      "${name} is referenced by the original configuration at ${path}";

  static String m95(min, max) => "Allowed range ${min} – ${max}";

  static String m96(value) => "Remaining: ${value}";

  static String m97(count) => "Only ${count} left";

  static String m98(seconds) => "Resend in ${seconds}s";

  static String m99(limit) => "The resource exceeds ${limit}";

  static String m100(count) =>
      "${Intl.plural(count, one: '1 rule', other: '${count} rules')}";

  static String m101(appName) => "${appName} (Safe mode)";

  static String m102(count) => "Added (${count})";

  static String m103(count) => "Modified (${count})";

  static String m104(count) => "Removed (${count})";

  static String m105(count) => "${count} seconds";

  static String m106(count) => "${count} in effect";

  static String m107(count) =>
      "${Intl.plural(count, one: '1 setting', other: '${count} settings')}";

  static String m108(count) =>
      "${Intl.plural(count, one: '1 node was added from the share links', other: '${count} nodes were added from the share links')}";

  static String m109(count) =>
      "${count} nodes cannot be represented by links and will be kept unchanged";

  static String m110(count) =>
      "${Intl.plural(count, one: '1 link could not be read', other: '${count} links could not be read')}";

  static String m111(label) => "${label} must be a single item";

  static String m112(fields) => "Check these settings: ${fields}";

  static String m113(count) => "Devices (${count})";

  static String m114(name, profile) =>
      "${name} is still used by a rule or group in profile ${profile}";

  static String m115(region) => "Relay ${region}";

  static String m116(name) =>
      "This device will leave ${name} and its sign-in will be deleted from this device. If the network is unreachable now, remove the device in the Tailscale admin console.";

  static String m117(value) => "Peak ${value}";

  static String m118(value) => "Total ${value}";

  static String m119(transport) => "${transport} Headers";

  static String m120(build) => "Build: ${build}";

  static String m121(version) => "Version: ${version}";

  static String m122(label) => "${label} must be a url";

  static String m123(count) =>
      "${Intl.plural(count, one: '1 year ago', other: '${count} years ago')}";

  static String m124(count) => "${Intl.plural(count, other: '${count}y ago')}";

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
    "accessControlDisabledDesc": MessageLookupByLibrary.simpleMessage(
      "App access control is disabled",
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
    "action_copyEnv": MessageLookupByLibrary.simpleMessage(
      "Copy proxy environment variables",
    ),
    "action_delayTest": MessageLookupByLibrary.simpleMessage(
      "Test node latency",
    ),
    "action_directMode": MessageLookupByLibrary.simpleMessage("Direct mode"),
    "action_exit": MessageLookupByLibrary.simpleMessage("Exit"),
    "action_globalMode": MessageLookupByLibrary.simpleMessage("Global mode"),
    "action_mode": MessageLookupByLibrary.simpleMessage("Switch mode"),
    "action_proxy": MessageLookupByLibrary.simpleMessage("System proxy"),
    "action_ruleMode": MessageLookupByLibrary.simpleMessage("Rule mode"),
    "action_start": MessageLookupByLibrary.simpleMessage("Start/Stop"),
    "action_tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "action_updateProfiles": MessageLookupByLibrary.simpleMessage(
      "Update profiles",
    ),
    "action_view": MessageLookupByLibrary.simpleMessage("Show/Hide"),
    "activate": MessageLookupByLibrary.simpleMessage("Activate"),
    "activatePlanConfirm": MessageLookupByLibrary.simpleMessage(
      "Activate this plan? It will become your active plan.",
    ),
    "activatePlanTitle": MessageLookupByLibrary.simpleMessage("Activate plan"),
    "add": MessageLookupByLibrary.simpleMessage("Add"),
    "addNodes": MessageLookupByLibrary.simpleMessage("Add nodes"),
    "addOverrideEntry": MessageLookupByLibrary.simpleMessage(
      "Add override entry",
    ),
    "addProfile": MessageLookupByLibrary.simpleMessage("Add Profile"),
    "addProxyChainNode": MessageLookupByLibrary.simpleMessage("Add"),
    "addProxyGroup": MessageLookupByLibrary.simpleMessage("Add proxy group"),
    "addRule": MessageLookupByLibrary.simpleMessage("Add rule"),
    "addSettingEntry": MessageLookupByLibrary.simpleMessage("Add setting"),
    "addSsid": MessageLookupByLibrary.simpleMessage("Add SSID"),
    "addedRules": MessageLookupByLibrary.simpleMessage("Added rules"),
    "additionalParameters": MessageLookupByLibrary.simpleMessage(
      "Additional parameters",
    ),
    "additionalPrefix": MessageLookupByLibrary.simpleMessage("Name prefix"),
    "additionalSuffix": MessageLookupByLibrary.simpleMessage("Name suffix"),
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
    "ageDecryptFailedTip": MessageLookupByLibrary.simpleMessage(
      "Could not decrypt the profile. Check the age secret key and try again.",
    ),
    "ageSecretKey": MessageLookupByLibrary.simpleMessage("Age secret key"),
    "ageSecretKeyRequiredTip": MessageLookupByLibrary.simpleMessage(
      "This profile is encrypted with age and needs an age secret key to decrypt",
    ),
    "allowBackgroundLocation": MessageLookupByLibrary.simpleMessage(
      "Allow all the time",
    ),
    "allowBypass": MessageLookupByLibrary.simpleMessage(
      "Allow apps to bypass VPN",
    ),
    "allowBypassDesc": MessageLookupByLibrary.simpleMessage(
      "Some apps can bypass VPN when turned on",
    ),
    "allowLan": MessageLookupByLibrary.simpleMessage("Allow LAN"),
    "allowLanDesc": MessageLookupByLibrary.simpleMessage(
      "Allow access proxy through the LAN",
    ),
    "allowTemporarily": MessageLookupByLibrary.simpleMessage(
      "Allow Temporarily",
    ),
    "allowedIps": MessageLookupByLibrary.simpleMessage("Allowed IPs"),
    "amountDueLabel": MessageLookupByLibrary.simpleMessage("Amount due"),
    "amountPayable": MessageLookupByLibrary.simpleMessage("Amount payable"),
    "announcement": MessageLookupByLibrary.simpleMessage("Announcement"),
    "apiAvailable": MessageLookupByLibrary.simpleMessage(
      "API service is operational",
    ),
    "apiAvailableWithCertificateException":
        MessageLookupByLibrary.simpleMessage(
          "The API was reachable with a temporary certificate exception. No account or node configuration was synced. Fix the certificate issue, then check again.",
        ),
    "app": MessageLookupByLibrary.simpleMessage("App"),
    "appAccessControl": MessageLookupByLibrary.simpleMessage(
      "App access control",
    ),
    "appProviderLibrary": MessageLookupByLibrary.simpleMessage(
      "Provider library",
    ),
    "appendSystemDns": MessageLookupByLibrary.simpleMessage(
      "Append system DNS",
    ),
    "appendSystemDnsTip": MessageLookupByLibrary.simpleMessage(
      "Forcefully append system DNS to the configuration",
    ),
    "application": MessageLookupByLibrary.simpleMessage("Application"),
    "authentication": MessageLookupByLibrary.simpleMessage(
      "Local proxy authentication",
    ),
    "authenticationApplyFailed": MessageLookupByLibrary.simpleMessage(
      "Could not apply authentication settings",
    ),
    "authenticationDesc": MessageLookupByLibrary.simpleMessage(
      "Local proxy authentication asks for a username and password on the HTTP and SOCKS ports. While it is on, the system HTTP proxy is not set; TUN and VPN keep working",
    ),
    "authenticationPasswordInvalid": MessageLookupByLibrary.simpleMessage(
      "Use 1–255 UTF-8 bytes, without control characters",
    ),
    "authenticationSystemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "The system proxy is not applied while local proxy authentication is on",
    ),
    "authenticationUsernameInvalid": MessageLookupByLibrary.simpleMessage(
      "Use 1–255 UTF-8 bytes, without colons or control characters",
    ),
    "authorized": MessageLookupByLibrary.simpleMessage("Authorized"),
    "auto": MessageLookupByLibrary.simpleMessage("Auto"),
    "autoCloseConnections": MessageLookupByLibrary.simpleMessage(
      "Auto close connections",
    ),
    "autoCloseConnectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Auto close connections after change node",
    ),
    "autoInclude": MessageLookupByLibrary.simpleMessage("Auto-include"),
    "autoIpv6": MessageLookupByLibrary.simpleMessage("Auto IPv6"),
    "autoIpv6Desc": MessageLookupByLibrary.simpleMessage(
      "Auto IPv6 turns IPv6 on or off by whether the local network supports it",
    ),
    "autoLaunch": MessageLookupByLibrary.simpleMessage("Auto launch"),
    "autoLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Follow the system self startup",
    ),
    "autoRun": MessageLookupByLibrary.simpleMessage("Auto run"),
    "autoRunDesc": MessageLookupByLibrary.simpleMessage(
      "Auto run when the application is opened",
    ),
    "autoSetSystemDns": MessageLookupByLibrary.simpleMessage(
      "Auto-set system DNS",
    ),
    "autoUpdate": MessageLookupByLibrary.simpleMessage("Auto update"),
    "autoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Auto update interval",
    ),
    "availableBalance": m0,
    "availablePlans": MessageLookupByLibrary.simpleMessage("Choose a Plan"),
    "back": MessageLookupByLibrary.simpleMessage("Back"),
    "backup": MessageLookupByLibrary.simpleMessage("Backup"),
    "backupAndRestore": MessageLookupByLibrary.simpleMessage(
      "Backup and Restore",
    ),
    "backupAndRestoreDesc": MessageLookupByLibrary.simpleMessage(
      "Sync data via WebDAV or files",
    ),
    "backupFromNewerVersion": MessageLookupByLibrary.simpleMessage(
      "This backup comes from a newer version of the app. Update the app before restoring it",
    ),
    "backupRetention": MessageLookupByLibrary.simpleMessage("Backups to keep"),
    "backupRetentionDesc": MessageLookupByLibrary.simpleMessage(
      "Each backup removes this device\'s older WebDAV backups",
    ),
    "backupSuccess": MessageLookupByLibrary.simpleMessage("Backup success"),
    "balance": MessageLookupByLibrary.simpleMessage("Balance"),
    "balanceDeductionHint": MessageLookupByLibrary.simpleMessage(
      "Purchases use your balance first, then commission for any shortfall.",
    ),
    "basicInfo": MessageLookupByLibrary.simpleMessage("Basic info"),
    "basicStrategy": MessageLookupByLibrary.simpleMessage("Basic strategies"),
    "batchAdd": MessageLookupByLibrary.simpleMessage("Batch add"),
    "batchLinkInputTip": MessageLookupByLibrary.simpleMessage(
      "One link per line",
    ),
    "batchListInputTip": MessageLookupByLibrary.simpleMessage(
      "One item per line, or separated by commas",
    ),
    "batchMapInputTip": MessageLookupByLibrary.simpleMessage(
      "One entry per line: key, a space, then value",
    ),
    "batchPreviewTip": m1,
    "batteryOptimizationDesc": MessageLookupByLibrary.simpleMessage(
      "Ignore battery optimization keeps the app running in the background",
    ),
    "batteryOptimizationStatusTip": MessageLookupByLibrary.simpleMessage(
      "Due to system limitations, the battery optimization status cannot be read correctly while running",
    ),
    "behavior": MessageLookupByLibrary.simpleMessage("Behavior"),
    "billingPeriodLabel": MessageLookupByLibrary.simpleMessage(
      "Billing period",
    ),
    "bind": MessageLookupByLibrary.simpleMessage("Bind"),
    "bindCoupon": MessageLookupByLibrary.simpleMessage("Apply coupon"),
    "bindCouponIntro": MessageLookupByLibrary.simpleMessage(
      "Enter an official coupon code. The difference is settled for the remaining plan duration, and a recurring coupon also updates the renewal price.",
    ),
    "blacklistMode": MessageLookupByLibrary.simpleMessage("Blacklist mode"),
    "blockQuic": MessageLookupByLibrary.simpleMessage("Block QUIC"),
    "blockQuicDesc": MessageLookupByLibrary.simpleMessage(
      "Reject UDP 443 traffic to force connections back to TCP",
    ),
    "blockWebRtc": MessageLookupByLibrary.simpleMessage("Block WebRTC"),
    "blockWebRtcDesc": MessageLookupByLibrary.simpleMessage(
      "Reject STUN traffic to reduce WebRTC IP leaks.",
    ),
    "brightness": MessageLookupByLibrary.simpleMessage("Brightness"),
    "buy": MessageLookupByLibrary.simpleMessage("Buy"),
    "bypassDomain": MessageLookupByLibrary.simpleMessage("Bypass domains"),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Bypass domains apply only while the system proxy is on",
    ),
    "bypassPrivateRoute": MessageLookupByLibrary.simpleMessage(
      "Bypass private addresses",
    ),
    "bypassPrivateRouteDesc": MessageLookupByLibrary.simpleMessage(
      "With Bypass private addresses on, LAN, loopback and multicast addresses skip TUN",
    ),
    "cacheAlgorithm": MessageLookupByLibrary.simpleMessage("Cache algorithm"),
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "The cache is corrupt. Do you want to clear it?",
    ),
    "cacheMaxSize": MessageLookupByLibrary.simpleMessage("Cache size"),
    "calculatingQuote": MessageLookupByLibrary.simpleMessage("Calculating…"),
    "cameraPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "Allow camera access in system settings to scan QR codes, or choose a QR code image from the album.",
    ),
    "cameraPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Camera permission required",
    ),
    "cameraUnavailable": MessageLookupByLibrary.simpleMessage(
      "Camera unavailable",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelSelectAll": MessageLookupByLibrary.simpleMessage(
      "Cancel select all",
    ),
    "certificateCheckOnlyHint": MessageLookupByLibrary.simpleMessage(
      "This action only checks API connectivity. It does not sign in or download node configurations.",
    ),
    "certificateExpired": MessageLookupByLibrary.simpleMessage(
      "Certificate has expired",
    ),
    "certificateHostnameHint": MessageLookupByLibrary.simpleMessage(
      "Try a different network and complete any Wi-Fi sign-in first. If the problem persists, contact the service provider to check that the certificate matches the server domain.",
    ),
    "certificateHostnameMismatch": MessageLookupByLibrary.simpleMessage(
      "Certificate does not match the requested domain",
    ),
    "certificateNotYetValid": MessageLookupByLibrary.simpleMessage(
      "Certificate is not yet valid",
    ),
    "certificateRevoked": MessageLookupByLibrary.simpleMessage(
      "Certificate has been revoked",
    ),
    "certificateRevokedHint": MessageLookupByLibrary.simpleMessage(
      "Contact the service provider to replace the revoked certificate. Retrying or changing the system time will not fix a revoked certificate.",
    ),
    "certificateSyncRetryDescription": MessageLookupByLibrary.simpleMessage(
      "After confirmation, this attempt checks the connection, refreshes your account, and downloads the node configuration. The certificate exception ends when this sync finishes.",
    ),
    "certificateUnknownHint": MessageLookupByLibrary.simpleMessage(
      "Check the system date and time, then try a different network. If verification still fails, send this error to the service provider for help.",
    ),
    "certificateUntrusted": MessageLookupByLibrary.simpleMessage(
      "Certificate chain is not trusted",
    ),
    "certificateUntrustedHint": MessageLookupByLibrary.simpleMessage(
      "Try a different network, such as a phone hotspot, and check for system updates. If antivirus software or a company network inspects HTTPS, ask its administrator to check it. If the problem persists, contact the service provider to check the certificate chain.",
    ),
    "certificateValidityHint": MessageLookupByLibrary.simpleMessage(
      "First synchronize the system date and time. If the time is correct, the server certificate needs to be fixed.",
    ),
    "changeProxyFailedTip": MessageLookupByLibrary.simpleMessage(
      "Failed to switch proxy; the previous selection has been restored",
    ),
    "changelogBreaking": MessageLookupByLibrary.simpleMessage(
      "Breaking changes",
    ),
    "changelogFeatures": MessageLookupByLibrary.simpleMessage("New features"),
    "changelogFixes": MessageLookupByLibrary.simpleMessage("Bug fixes"),
    "changelogPerformance": MessageLookupByLibrary.simpleMessage("Performance"),
    "changelogReverts": MessageLookupByLibrary.simpleMessage("Reverts"),
    "checkApi": MessageLookupByLibrary.simpleMessage("Check API"),
    "checkRouting": MessageLookupByLibrary.simpleMessage("Check configuration"),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("Check for updates"),
    "checkUpdateError": MessageLookupByLibrary.simpleMessage(
      "The current application is already the latest version",
    ),
    "checkUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to check for updates. Please check your network and try again",
    ),
    "checkingPayment": MessageLookupByLibrary.simpleMessage("Checking..."),
    "chooseMembers": MessageLookupByLibrary.simpleMessage("Choose members"),
    "cipher": MessageLookupByLibrary.simpleMessage("Cipher"),
    "clearCustomRouting": MessageLookupByLibrary.simpleMessage("Clear all"),
    "clearData": MessageLookupByLibrary.simpleMessage("Clear Data"),
    "clearProxyChain": MessageLookupByLibrary.simpleMessage(
      "Clear chain config",
    ),
    "clearSearch": MessageLookupByLibrary.simpleMessage("Clear search"),
    "clientFingerprint": MessageLookupByLibrary.simpleMessage(
      "Client fingerprint",
    ),
    "clipboardExport": MessageLookupByLibrary.simpleMessage(
      "Export to clipboard",
    ),
    "clipboardImport": MessageLookupByLibrary.simpleMessage(
      "Import from clipboard",
    ),
    "clipboardWriteFailed": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t copy to the clipboard. The selection may be too large",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "closeAllConnections": MessageLookupByLibrary.simpleMessage(
      "Close all connections",
    ),
    "cloudApiAccessDenied": MessageLookupByLibrary.simpleMessage(
      "Network access denied",
    ),
    "cloudApiAddressInUse": MessageLookupByLibrary.simpleMessage(
      "Network address or port is already in use",
    ),
    "cloudApiAddressUnavailable": MessageLookupByLibrary.simpleMessage(
      "Network address is unavailable",
    ),
    "cloudApiBadGateway": MessageLookupByLibrary.simpleMessage(
      "Gateway received an invalid upstream response",
    ),
    "cloudApiBadRequest": MessageLookupByLibrary.simpleMessage(
      "Server rejected the request as invalid",
    ),
    "cloudApiClockSkew": MessageLookupByLibrary.simpleMessage(
      "The device clock is too far from the server. Turn on automatic date and time, then retry.",
    ),
    "cloudApiConnectTimeout": MessageLookupByLibrary.simpleMessage(
      "Connection timed out",
    ),
    "cloudApiConnectionAborted": MessageLookupByLibrary.simpleMessage(
      "Connection aborted",
    ),
    "cloudApiConnectionFailed": MessageLookupByLibrary.simpleMessage(
      "Connection failed",
    ),
    "cloudApiConnectionRefused": MessageLookupByLibrary.simpleMessage(
      "Connection refused",
    ),
    "cloudApiConnectionReset": MessageLookupByLibrary.simpleMessage(
      "Connection reset",
    ),
    "cloudApiDnsEmpty": MessageLookupByLibrary.simpleMessage(
      "DNS returned no address, possibly blocked or a broken system resolver",
    ),
    "cloudApiDnsFailed": MessageLookupByLibrary.simpleMessage(
      "DNS lookup failed",
    ),
    "cloudApiDnsUnknownHost": MessageLookupByLibrary.simpleMessage(
      "DNS could not find this domain",
    ),
    "cloudApiForbidden": MessageLookupByLibrary.simpleMessage(
      "Access forbidden",
    ),
    "cloudApiGatewayTimeout": MessageLookupByLibrary.simpleMessage(
      "Gateway timed out waiting for the upstream server",
    ),
    "cloudApiHttpError": m2,
    "cloudApiInvalidResponse": MessageLookupByLibrary.simpleMessage(
      "Invalid server response",
    ),
    "cloudApiMethodNotAllowed": MessageLookupByLibrary.simpleMessage(
      "Request method is not allowed",
    ),
    "cloudApiNetworkAuthRequired": MessageLookupByLibrary.simpleMessage(
      "This network requires sign-in before access",
    ),
    "cloudApiNetworkResourcesExhausted": MessageLookupByLibrary.simpleMessage(
      "Insufficient system network resources",
    ),
    "cloudApiNetworkUnreachable": MessageLookupByLibrary.simpleMessage(
      "Network unreachable",
    ),
    "cloudApiNotFound": MessageLookupByLibrary.simpleMessage(
      "Requested API or resource was not found",
    ),
    "cloudApiProxyAuthFailed": MessageLookupByLibrary.simpleMessage(
      "Proxy authentication failed (HTTP 407)",
    ),
    "cloudApiProxyFailed": MessageLookupByLibrary.simpleMessage(
      "Proxy connection failed",
    ),
    "cloudApiRateLimited": MessageLookupByLibrary.simpleMessage(
      "Too many requests; try again later",
    ),
    "cloudApiReceiveTimeout": MessageLookupByLibrary.simpleMessage(
      "Waiting for the response timed out",
    ),
    "cloudApiRedirectInvalid": MessageLookupByLibrary.simpleMessage(
      "Server redirect is invalid",
    ),
    "cloudApiRedirectLimit": MessageLookupByLibrary.simpleMessage(
      "Too many server redirects",
    ),
    "cloudApiRedirectLoop": MessageLookupByLibrary.simpleMessage(
      "Server redirects form a loop",
    ),
    "cloudApiRequestCanceled": MessageLookupByLibrary.simpleMessage(
      "Request canceled",
    ),
    "cloudApiRequestTooLarge": MessageLookupByLibrary.simpleMessage(
      "Request exceeds the server size limit",
    ),
    "cloudApiResponseInterrupted": MessageLookupByLibrary.simpleMessage(
      "Connection closed before the full response was received",
    ),
    "cloudApiResponseTooLarge": MessageLookupByLibrary.simpleMessage(
      "Server response exceeds the allowed size",
    ),
    "cloudApiRouteDirect": m3,
    "cloudApiRouteProxy": m4,
    "cloudApiSendTimeout": MessageLookupByLibrary.simpleMessage(
      "Sending the request timed out",
    ),
    "cloudApiServerError": MessageLookupByLibrary.simpleMessage(
      "Internal server error",
    ),
    "cloudApiServerRequestTimeout": MessageLookupByLibrary.simpleMessage(
      "Server timed out receiving the request",
    ),
    "cloudApiServerUnconfigured": MessageLookupByLibrary.simpleMessage(
      "The server has no key configured for this app. Contact support.",
    ),
    "cloudApiServiceUnavailable": MessageLookupByLibrary.simpleMessage(
      "Service is temporarily unavailable",
    ),
    "cloudApiSignatureRejected": MessageLookupByLibrary.simpleMessage(
      "The server rejected this app’s signature. Reinstall the latest official build.",
    ),
    "cloudApiSystemError": m5,
    "cloudApiTimeout": MessageLookupByLibrary.simpleMessage(
      "Request timed out",
    ),
    "cloudApiTlsAlgorithmFailed": MessageLookupByLibrary.simpleMessage(
      "TLS cryptographic algorithm negotiation failed",
    ),
    "cloudApiTlsFailed": MessageLookupByLibrary.simpleMessage(
      "TLS handshake failed",
    ),
    "cloudApiTlsInterrupted": MessageLookupByLibrary.simpleMessage(
      "Connection closed before the TLS handshake completed",
    ),
    "cloudApiTlsProtocolFailed": MessageLookupByLibrary.simpleMessage(
      "Incompatible TLS protocol or invalid TLS response",
    ),
    "cloudCertificateSyncFailed": MessageLookupByLibrary.simpleMessage(
      "The API check passed, but account or node configuration sync failed: ",
    ),
    "cloudConfigSyncIncomplete": MessageLookupByLibrary.simpleMessage(
      "The node configuration was not downloaded. Resolve the download error and sync again.",
    ),
    "cloudSyncedWithCertificateException": MessageLookupByLibrary.simpleMessage(
      "Account and configuration sync completed with a temporary certificate exception. Verification is now restored; resolve the certificate issue before the next sync.",
    ),
    "codeSent": MessageLookupByLibrary.simpleMessage("Verification code sent"),
    "collapseList": MessageLookupByLibrary.simpleMessage("Collapse"),
    "color": MessageLookupByLibrary.simpleMessage("Color"),
    "colorStyle": MessageLookupByLibrary.simpleMessage("Color style"),
    "columns": MessageLookupByLibrary.simpleMessage("Columns"),
    "commission": MessageLookupByLibrary.simpleMessage("Commission"),
    "commissionBalance": m6,
    "compact": MessageLookupByLibrary.simpleMessage("Compact"),
    "compatible": MessageLookupByLibrary.simpleMessage("Compatibility mode"),
    "configDataDetected": MessageLookupByLibrary.simpleMessage(
      "Data detected in configuration",
    ),
    "configParseErrorAtLine": m7,
    "configRecoveryKeyring": MessageLookupByLibrary.simpleMessage(
      "The system keyring (Secret Service) could not be accessed. Enable and unlock KDE Wallet or GNOME Keyring in your system settings, then retry.",
    ),
    "configRecoveryMessage": MessageLookupByLibrary.simpleMessage(
      "Local configuration is temporarily unavailable. Your existing data has been kept. Unlock your device and retry, or reopen the app later.",
    ),
    "configRecoveryMissingKey": MessageLookupByLibrary.simpleMessage(
      "The encryption key for your existing configuration is missing or invalid. Try the original system account on the original device or restore a backup. Retrying cannot recreate a lost key.",
    ),
    "configRecoveryReset": MessageLookupByLibrary.simpleMessage(
      "Back up and reset",
    ),
    "configRecoveryResetConfirm": MessageLookupByLibrary.simpleMessage(
      "Create an encrypted backup of all local settings, subscriptions, rules and account data, then reset the application? You will need to sign in again and restore or import your subscriptions and settings. The backup is protected by this Windows account; it cannot recover a lost encryption key.",
    ),
    "configRecoveryResetDone": MessageLookupByLibrary.simpleMessage(
      "An encrypted backup of your original data has been saved in the folder below. Exit and reopen the application to set it up again.",
    ),
    "configRecoveryResetFailed": MessageLookupByLibrary.simpleMessage(
      "The encrypted backup and reset could not be completed. Surviving original data will not be removed without a verified backup. Retry this operation, or exit and reopen the application to finish it.",
    ),
    "configRecoveryRetry": MessageLookupByLibrary.simpleMessage("Retry"),
    "configRecoveryStorage": MessageLookupByLibrary.simpleMessage(
      "The local configuration or its encryption key could not be read or saved. Check access to the application data folder and the system secure storage, then retry.",
    ),
    "configRecoveryTitle": MessageLookupByLibrary.simpleMessage(
      "Recover local configuration",
    ),
    "configRecoveryUnreadable": MessageLookupByLibrary.simpleMessage(
      "The local configuration cannot be decrypted or is damaged. Existing files have been kept. Restore the matching key and configuration backup, or back up and reset.",
    ),
    "configRecoveryUseLocalStorage": MessageLookupByLibrary.simpleMessage(
      "Use local file storage",
    ),
    "configRecoveryUseLocalStorageConfirm":
        MessageLookupByLibrary.simpleMessage(
          "Store encryption keys and account credentials in a file in the application data folder that only your user account can open, instead of the system keyring? Any program running as your user can read them and decrypt the local configuration. This choice stays in effect from now on.",
        ),
    "configTypeMismatch": m8,
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
    "confirmClearCustomRouting": MessageLookupByLibrary.simpleMessage(
      "Clear this profile’s custom proxy groups and rules? Subscription content, added rules, proxy chains, and custom nodes will be kept.",
    ),
    "confirmDeleteProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this proxy group?",
    ),
    "confirmExitWindow": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to exit the current window?",
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
    "congestionControl": MessageLookupByLibrary.simpleMessage(
      "Congestion control",
    ),
    "congestionController": MessageLookupByLibrary.simpleMessage(
      "TCP congestion control",
    ),
    "congestionControllerDesc": MessageLookupByLibrary.simpleMessage(
      "TCP congestion control works only with the mips stack",
    ),
    "connected": MessageLookupByLibrary.simpleMessage("Connected"),
    "connecting": MessageLookupByLibrary.simpleMessage("Connecting..."),
    "connection": MessageLookupByLibrary.simpleMessage("Connection"),
    "connectionStats": MessageLookupByLibrary.simpleMessage("Connection stats"),
    "connectionStatsDesc": MessageLookupByLibrary.simpleMessage(
      "Live connections, recent requests and DNS queries",
    ),
    "connections": MessageLookupByLibrary.simpleMessage("Connections"),
    "connectionsDesc": MessageLookupByLibrary.simpleMessage(
      "View current connections data",
    ),
    "connectivity": MessageLookupByLibrary.simpleMessage("Connectivity："),
    "content": MessageLookupByLibrary.simpleMessage("Content"),
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
    "coreBlockedByPolicyTip": m9,
    "coreBlockedBySmartAppControlTip": MessageLookupByLibrary.simpleMessage(
      "Windows blocked FlClashCore.exe, and Smart App Control is enabled. Check the block details in Windows Security → App & browser control, and use a trusted, verified release.",
    ),
    "coreNotConnected": MessageLookupByLibrary.simpleMessage(
      "Core is not connected",
    ),
    "coreStatus": MessageLookupByLibrary.simpleMessage("Core status"),
    "crashTest": MessageLookupByLibrary.simpleMessage("Crash test"),
    "create": MessageLookupByLibrary.simpleMessage("Create"),
    "createProfileFromUrlTip": m10,
    "creationTime": MessageLookupByLibrary.simpleMessage("Creation time"),
    "currentOutboundDesc": MessageLookupByLibrary.simpleMessage(
      "Holds the start button and can\'t be removed",
    ),
    "custom": MessageLookupByLibrary.simpleMessage("Custom"),
    "customColor": MessageLookupByLibrary.simpleMessage("Custom color"),
    "customImportCloudRefused": MessageLookupByLibrary.simpleMessage(
      "oixCloud addresses cannot be imported into a custom profile",
    ),
    "customImportDroppedSubRules": m11,
    "customImportNotImported": MessageLookupByLibrary.simpleMessage(
      "Not imported",
    ),
    "customImportUnnamedProxies": m12,
    "customIssuesSummary": m13,
    "customOutboundInUse": m14,
    "customProfile": MessageLookupByLibrary.simpleMessage("Custom profile"),
    "customProfileDesc": MessageLookupByLibrary.simpleMessage(
      "Assemble proxy groups and rules from your own nodes, the provider library and other profiles",
    ),
    "customProfileResources": MessageLookupByLibrary.simpleMessage(
      "Custom profile resources",
    ),
    "customRoutingDraftHint": MessageLookupByLibrary.simpleMessage(
      "Fill in your custom routing, then switch to Custom mode. Editing this draft does not change the current mode.",
    ),
    "customRuleChooseProvider": MessageLookupByLibrary.simpleMessage(
      "Choose a rule provider",
    ),
    "customRuleChooseTarget": MessageLookupByLibrary.simpleMessage(
      "Choose a target",
    ),
    "customRuleForm": MessageLookupByLibrary.simpleMessage("Form"),
    "customRuleFormUnavailable": MessageLookupByLibrary.simpleMessage(
      "This rule uses advanced syntax. Edit the rule text to preserve all options.",
    ),
    "customRuleInvalidContent": m15,
    "customRuleInvalidSyntax": MessageLookupByLibrary.simpleMessage(
      "Enter one complete rule with a valid type, content and target.",
    ),
    "customRuleMatchHint": MessageLookupByLibrary.simpleMessage(
      "Matches all remaining traffic. Rules below it will not be reached.",
    ),
    "customRuleNoResolveHint": MessageLookupByLibrary.simpleMessage(
      "Match known IP addresses without resolving domain names.",
    ),
    "customRuleRaw": MessageLookupByLibrary.simpleMessage("Rule text"),
    "customRuleRawHint": MessageLookupByLibrary.simpleMessage(
      "Enter one complete rule. Advanced expressions are preserved.",
    ),
    "customRuleTargetHint": MessageLookupByLibrary.simpleMessage(
      "Choose a policy group, proxy or built-in action.",
    ),
    "customRuleType": MessageLookupByLibrary.simpleMessage("Rule type"),
    "customRuleUnavailableProvider": m16,
    "customRuleUnavailableTarget": m17,
    "cut": MessageLookupByLibrary.simpleMessage("Cut"),
    "dark": MessageLookupByLibrary.simpleMessage("Dark"),
    "dashboard": MessageLookupByLibrary.simpleMessage("Dashboard"),
    "dashboardAddableSection": MessageLookupByLibrary.simpleMessage(
      "Available to add",
    ),
    "dataChangedSave": MessageLookupByLibrary.simpleMessage(
      "Data changes detected. Save them?",
    ),
    "databaseWriteFailedTip": MessageLookupByLibrary.simpleMessage(
      "Failed to save the change. Please check the current value and try again.",
    ),
    "daysAgo": m18,
    "daysAgoShort": m19,
    "defaultNameserver": MessageLookupByLibrary.simpleMessage(
      "Default nameserver",
    ),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "The default nameserver resolves the domains of DNS servers",
    ),
    "defaultSelected": MessageLookupByLibrary.simpleMessage(
      "Default selection",
    ),
    "defaultText": MessageLookupByLibrary.simpleMessage("Default"),
    "definitionNotMap": MessageLookupByLibrary.simpleMessage(
      "The configuration must be a YAML mapping with a name and a type",
    ),
    "delay": MessageLookupByLibrary.simpleMessage("Delay"),
    "delayConcurrency": MessageLookupByLibrary.simpleMessage(
      "Concurrent batch latency tests",
    ),
    "delayConcurrencyAndroidDesc": MessageLookupByLibrary.simpleMessage(
      "Default: 16 on Android. Reduce on congested networks; applies to the next batch",
    ),
    "delayConcurrencyDesc": MessageLookupByLibrary.simpleMessage(
      "Default: 50. Reduce on congested networks; applies to the next batch",
    ),
    "delayTest": MessageLookupByLibrary.simpleMessage("Delay Test"),
    "delayTestFailed": MessageLookupByLibrary.simpleMessage("Failed"),
    "delayTestQueued": MessageLookupByLibrary.simpleMessage("Queued"),
    "delayTestRunning": MessageLookupByLibrary.simpleMessage("Testing"),
    "delayTestTimeout": MessageLookupByLibrary.simpleMessage(
      "Delay test timeout",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteBackupTip": MessageLookupByLibrary.simpleMessage(
      "Delete this backup from WebDAV?",
    ),
    "deleteMultipTip": m20,
    "deleteTip": m21,
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
    "details": m22,
    "detectionTip": MessageLookupByLibrary.simpleMessage(
      "Relying on third-party api is for reference only",
    ),
    "developerMode": MessageLookupByLibrary.simpleMessage("Developer mode"),
    "developerModeEnableTip": MessageLookupByLibrary.simpleMessage(
      "Developer mode is enabled.",
    ),
    "diagAllFailed": MessageLookupByLibrary.simpleMessage(
      "Every node tested in this group failed. The test URL may also be unreachable. Run a network self-check?",
    ),
    "diagCanceled": MessageLookupByLibrary.simpleMessage(
      "Check canceled; results are incomplete",
    ),
    "diagCaptureHint": MessageLookupByLibrary.simpleMessage(
      "Enable system proxy or TUN, or configure the affected app to use the local proxy.",
    ),
    "diagClock": MessageLookupByLibrary.simpleMessage("System time comparison"),
    "diagClockHint": MessageLookupByLibrary.simpleMessage(
      "Enable automatic system date and time, then retry. A clock error can affect certificates and oixCloud DNS signatures.",
    ),
    "diagClockReady": MessageLookupByLibrary.simpleMessage(
      "No consistent large time difference was found in this sample",
    ),
    "diagClockSkew": MessageLookupByLibrary.simpleMessage(
      "Two independent responses indicate a possible time difference of at least five minutes",
    ),
    "diagClockUnknown": MessageLookupByLibrary.simpleMessage(
      "Not enough uncached HTTPS responses to compare time",
    ),
    "diagCopy": MessageLookupByLibrary.simpleMessage("Copy diagnostic report"),
    "diagCopyProxyAddress": MessageLookupByLibrary.simpleMessage(
      "Copy proxy address",
    ),
    "diagCore": MessageLookupByLibrary.simpleMessage("Core response"),
    "diagCoreDns": MessageLookupByLibrary.simpleMessage("Core DNS"),
    "diagCoreHint": MessageLookupByLibrary.simpleMessage(
      "Check the connection switch and Wi-Fi exclusions. If the core cannot respond, restart it and use a matching current client/core version.",
    ),
    "diagCoreReady": MessageLookupByLibrary.simpleMessage(
      "The core responded and reports active listeners",
    ),
    "diagCoreStopped": MessageLookupByLibrary.simpleMessage(
      "The core reports that traffic forwarding is stopped",
    ),
    "diagCoreUnknown": MessageLookupByLibrary.simpleMessage(
      "The core diagnostic response is unavailable or the configuration changed",
    ),
    "diagDisabled": MessageLookupByLibrary.simpleMessage(
      "This option is not enabled",
    ),
    "diagDnsHint": MessageLookupByLibrary.simpleMessage(
      "Check DNS overrides and try another network. If system DNS works but core DNS fails, inspect the configuration DNS settings.",
    ),
    "diagDnsNoAnswer": MessageLookupByLibrary.simpleMessage(
      "DNS returned no usable address; this alone does not prove an authentication failure",
    ),
    "diagDnsPartial": MessageLookupByLibrary.simpleMessage(
      "Only some sampled names resolved",
    ),
    "diagDnsReady": MessageLookupByLibrary.simpleMessage(
      "Sampled names resolved successfully",
    ),
    "diagDnsRefused": MessageLookupByLibrary.simpleMessage(
      "The DNS request was refused",
    ),
    "diagEntryHint": MessageLookupByLibrary.simpleMessage(
      "Check the core, system proxy, TUN and DNS",
    ),
    "diagFailed": MessageLookupByLibrary.simpleMessage("Failed"),
    "diagFixApplyProfile": MessageLookupByLibrary.simpleMessage(
      "Apply configuration",
    ),
    "diagFixEnableSystemProxy": MessageLookupByLibrary.simpleMessage(
      "Enable system proxy",
    ),
    "diagFixFailed": MessageLookupByLibrary.simpleMessage(
      "The fix could not be applied. Follow the suggestion above.",
    ),
    "diagFixRestartConnection": MessageLookupByLibrary.simpleMessage(
      "Reconnect",
    ),
    "diagFixRestartCore": MessageLookupByLibrary.simpleMessage("Restart core"),
    "diagFixRetest": MessageLookupByLibrary.simpleMessage("Retest nodes"),
    "diagFixStart": MessageLookupByLibrary.simpleMessage("Start connection"),
    "diagFixSystemProxy": MessageLookupByLibrary.simpleMessage(
      "Reapply system proxy",
    ),
    "diagFixTun": MessageLookupByLibrary.simpleMessage("Re-enable TUN"),
    "diagFixing": MessageLookupByLibrary.simpleMessage(
      "Applying the fix, then checking again",
    ),
    "diagListener": MessageLookupByLibrary.simpleMessage("Local proxy entry"),
    "diagListenerFailed": MessageLookupByLibrary.simpleMessage(
      "The expected proxy port did not respond or differs from the core port",
    ),
    "diagListenerHint": MessageLookupByLibrary.simpleMessage(
      "Check for port conflicts or a stopped listener. Reconnect first; if it still fails, open Ports and authentication to check or change the mixed port.",
    ),
    "diagListenerReady": MessageLookupByLibrary.simpleMessage(
      "The expected port responded to the proxy protocol",
    ),
    "diagNoCapture": MessageLookupByLibrary.simpleMessage(
      "Neither system proxy nor TUN is enabled",
    ),
    "diagOixDns": MessageLookupByLibrary.simpleMessage("oixCloud signed DNS"),
    "diagOixDnsAuthMissing": MessageLookupByLibrary.simpleMessage(
      "The managed DNS signing function is not ready",
    ),
    "diagOixDnsHint": MessageLookupByLibrary.simpleMessage(
      "Check the client version and system time, then refresh the subscription. If resolution still fails, share this diagnostic report with support.",
    ),
    "diagOixDnsNoSample": MessageLookupByLibrary.simpleMessage(
      "No managed node hostname was available for this sample",
    ),
    "diagOpenDnsSettings": MessageLookupByLibrary.simpleMessage(
      "DNS override settings",
    ),
    "diagOpenNetworkSettings": MessageLookupByLibrary.simpleMessage(
      "Network and TUN settings",
    ),
    "diagOpenPortSettings": MessageLookupByLibrary.simpleMessage(
      "Ports and authentication",
    ),
    "diagOpenSettingsFailed": MessageLookupByLibrary.simpleMessage(
      "Could not open system settings. Follow the path above to open them manually.",
    ),
    "diagOpenSystemSettings": MessageLookupByLibrary.simpleMessage(
      "Open system settings",
    ),
    "diagPassed": MessageLookupByLibrary.simpleMessage("Passed"),
    "diagProfile": MessageLookupByLibrary.simpleMessage(
      "Applied configuration",
    ),
    "diagProfileHint": MessageLookupByLibrary.simpleMessage(
      "Select a valid configuration and start the connection before checking again.",
    ),
    "diagProfileMissing": MessageLookupByLibrary.simpleMessage(
      "The selected configuration has not been applied",
    ),
    "diagProfileReady": MessageLookupByLibrary.simpleMessage(
      "The selected configuration has been applied",
    ),
    "diagProxyAutomatic": MessageLookupByLibrary.simpleMessage(
      "Automatic proxy configuration is present; its effective route was not verified",
    ),
    "diagProxyAutomaticHint": MessageLookupByLibrary.simpleMessage(
      "A PAC script or auto-discovery may choose a different proxy for each website. This does not necessarily mean the connection is broken. Check who provided the configuration before changing it.",
    ),
    "diagProxyDifferent": MessageLookupByLibrary.simpleMessage(
      "The OS proxy does not match the app port",
    ),
    "diagProxyDisabled": MessageLookupByLibrary.simpleMessage(
      "The app requested a system proxy, but the OS reports it disabled",
    ),
    "diagProxyGuide": MessageLookupByLibrary.simpleMessage(
      "Troubleshoot and manual setup",
    ),
    "diagProxyGuideApp": MessageLookupByLibrary.simpleMessage(
      "On this device, open the target app’s proxy settings, choose HTTP or SOCKS5, and enter the address and port below.\nAndroid provides the system proxy through the VPN service. For VPN access, check the VPN switch and app access control in FlClash network settings.",
    ),
    "diagProxyGuideAuthenticated": MessageLookupByLibrary.simpleMessage(
      "Local proxy authentication is enabled, so FlClash does not apply a system proxy automatically.\nIn an app that supports proxy authentication, choose HTTP or SOCKS5 and enter the address and port below. Use the username and password from FlClash → Override → General → Inbound → Authentication.\nDo not include credentials in diagnostic reports.",
    ),
    "diagProxyGuideInvalidPort": MessageLookupByLibrary.simpleMessage(
      "The mixed port is unavailable. Set a valid port in Ports and authentication, then start the connection.",
    ),
    "diagProxyGuideLinux": MessageLookupByLibrary.simpleMessage(
      "Open your desktop settings → Network → Network Proxy and select Manual (names vary by desktop).\nEnter the address and port below for both HTTP and HTTPS, then apply. If there is no system proxy panel, configure the target app instead.\nBefore replacing an automatic configuration, check its source and whether your network still needs it.",
    ),
    "diagProxyGuideMacos": MessageLookupByLibrary.simpleMessage(
      "System Settings → Network → active Wi-Fi or Ethernet service → Details → Proxies\nmacOS 12: System Preferences → Network → active service → Advanced → Proxies\nIf automatic settings are left over from another app and your network no longer needs them, turn off Auto proxy discovery and Automatic proxy configuration.\nEnable Web proxy (HTTP) and Secure web proxy (HTTPS). Enter the address and port below for both, then save. Keep any bypass entries your network needs.",
    ),
    "diagProxyGuideManualTitle": MessageLookupByLibrary.simpleMessage(
      "2. Check or enter the proxy settings",
    ),
    "diagProxyGuidePrepare": MessageLookupByLibrary.simpleMessage(
      "Select a valid profile, start the connection in FlClash, and make sure Local proxy listener passes before entering the proxy address.\nQuit other proxy apps that may keep changing system settings. If your company or school manages the settings, or they are locked or keep reverting, check with the administrator.",
    ),
    "diagProxyGuidePrepareTitle": MessageLookupByLibrary.simpleMessage(
      "1. Check the local proxy first",
    ),
    "diagProxyGuideValues": m23,
    "diagProxyGuideVerify": MessageLookupByLibrary.simpleMessage(
      "Return and select Check again, then retry in the browser or app you use.\nIf the local proxy check passes but an app still fails, check its system proxy, custom proxy, or proxy extension settings. System proxy settings do not capture every app.\nYou may need to turn off a manually configured proxy or restore its previous settings when stopping FlClash to keep internet access.",
    ),
    "diagProxyGuideVerifyTitle": MessageLookupByLibrary.simpleMessage(
      "3. Save and verify the actual app",
    ),
    "diagProxyGuideWindows": MessageLookupByLibrary.simpleMessage(
      "Settings → Network & internet → Proxy\nIf automatic settings are left over from another app and your network no longer needs them, turn off Use setup script and Automatically detect settings.\nUnder Manual proxy setup, enable Use a proxy server, enter the address and port below in their separate fields, and save. Do not prefix the address with http://. Keep any exceptions your network needs.",
    ),
    "diagProxyHint": MessageLookupByLibrary.simpleMessage(
      "Open Troubleshoot and manual setup to compare the system proxy address and port. If settings keep reverting, check other proxy apps or device management policies.",
    ),
    "diagProxyPath": MessageLookupByLibrary.simpleMessage(
      "Through the local proxy",
    ),
    "diagProxyPathHint": MessageLookupByLibrary.simpleMessage(
      "If the system path works, check the selected node, routing rules and core DNS. Failure at one test site does not mean every node is unusable.",
    ),
    "diagProxyReady": MessageLookupByLibrary.simpleMessage(
      "HTTP and HTTPS proxy settings point to the expected local port",
    ),
    "diagRecheck": MessageLookupByLibrary.simpleMessage("Check again"),
    "diagRun": MessageLookupByLibrary.simpleMessage("Run self-check"),
    "diagScope": MessageLookupByLibrary.simpleMessage(
      "Checks the current connection using a small sample. The system network path may also pass through TUN. Results do not cover every app or node.",
    ),
    "diagSkipped": MessageLookupByLibrary.simpleMessage("Skipped"),
    "diagSuspended": MessageLookupByLibrary.simpleMessage(
      "Traffic forwarding is paused by the current Wi-Fi exclusion setting",
    ),
    "diagSystemDns": MessageLookupByLibrary.simpleMessage("System DNS"),
    "diagSystemDnsHint": MessageLookupByLibrary.simpleMessage(
      "Try another network and check the DNS servers for the active connection in your operating system. Changing only the client DNS overrides may not fix system lookups.",
    ),
    "diagSystemPath": MessageLookupByLibrary.simpleMessage(
      "System network path",
    ),
    "diagSystemPathHint": MessageLookupByLibrary.simpleMessage(
      "This path does not explicitly use the app HTTP proxy, but may use TUN. A failed sample may be caused by DNS, filtering or the test site; compare the local proxy result.",
    ),
    "diagSystemProxy": MessageLookupByLibrary.simpleMessage(
      "System proxy settings",
    ),
    "diagTitle": MessageLookupByLibrary.simpleMessage("Network self-check"),
    "diagTrafficCapture": MessageLookupByLibrary.simpleMessage(
      "Traffic capture",
    ),
    "diagTun": MessageLookupByLibrary.simpleMessage("TUN interface and route"),
    "diagTunHint": MessageLookupByLibrary.simpleMessage(
      "Turn TUN off and on and complete system authorization. If the route differs, check other VPNs. IPv6, UDP and app-specific exclusions need separate checks.",
    ),
    "diagTunMissing": MessageLookupByLibrary.simpleMessage(
      "The core TUN interface was not found in an active state",
    ),
    "diagTunReady": MessageLookupByLibrary.simpleMessage(
      "The core TUN interface is active and the sampled IPv4 route uses it",
    ),
    "diagTunRouteMismatch": MessageLookupByLibrary.simpleMessage(
      "TUN is active, but the sampled IPv4 route uses another interface",
    ),
    "diagTunRouteUnknown": MessageLookupByLibrary.simpleMessage(
      "TUN is active; its IPv4 route could not be verified",
    ),
    "diagUnknown": MessageLookupByLibrary.simpleMessage("Could not confirm"),
    "diagWarning": MessageLookupByLibrary.simpleMessage("Needs attention"),
    "diagWebResult": m24,
    "dialerProxy": MessageLookupByLibrary.simpleMessage("Dialer proxy"),
    "dialerProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Dialer proxy is the outbound used to reach the NTP server",
    ),
    "dialerProxyLoopStopped": m25,
    "direct": MessageLookupByLibrary.simpleMessage("Direct"),
    "directNameserver": MessageLookupByLibrary.simpleMessage(
      "Direct nameserver",
    ),
    "directNameserverFollowPolicy": MessageLookupByLibrary.simpleMessage(
      "Direct nameserver follows policy",
    ),
    "disableIcmpForwarding": MessageLookupByLibrary.simpleMessage(
      "Disable ICMP forwarding",
    ),
    "disableIcmpForwardingDesc": MessageLookupByLibrary.simpleMessage(
      "With ICMP forwarding disabled, TUN answers ping itself, so ping no longer shows the real latency",
    ),
    "disableKeepAlive": MessageLookupByLibrary.simpleMessage(
      "Disable TCP keep-alive",
    ),
    "disableUDP": MessageLookupByLibrary.simpleMessage("Disable UDP"),
    "disabled": MessageLookupByLibrary.simpleMessage("Disabled"),
    "discard": MessageLookupByLibrary.simpleMessage("Discard"),
    "discardChanges": MessageLookupByLibrary.simpleMessage(
      "Discard the changes?",
    ),
    "disconnected": MessageLookupByLibrary.simpleMessage("Disconnected"),
    "discountCode": MessageLookupByLibrary.simpleMessage("Discount code"),
    "discountCodeOptional": MessageLookupByLibrary.simpleMessage(
      "Discount code (optional)",
    ),
    "discountCodeRequired": MessageLookupByLibrary.simpleMessage(
      "Enter a discount code",
    ),
    "discountedPriceLabel": MessageLookupByLibrary.simpleMessage(
      "Discounted price",
    ),
    "discovery": MessageLookupByLibrary.simpleMessage(
      "Discovery a new version",
    ),
    "dnsDesc": MessageLookupByLibrary.simpleMessage(
      "Update DNS related settings",
    ),
    "dnsHijackDesc": MessageLookupByLibrary.simpleMessage(
      "Without this entry, TUN hijacks every DNS query to port 53 (any:53)",
    ),
    "dnsHijacking": MessageLookupByLibrary.simpleMessage("DNS hijacking"),
    "dnsMode": MessageLookupByLibrary.simpleMessage("DNS mode"),
    "dnsOverrideDesc": MessageLookupByLibrary.simpleMessage(
      "Entries added here replace the DNS settings of every profile; anything not added keeps the profile\'s own setting. Entries a custom profile adds itself take precedence",
    ),
    "dnsQueries": MessageLookupByLibrary.simpleMessage("DNS queries"),
    "dnsQueriesDesc": MessageLookupByLibrary.simpleMessage(
      "View the latest 500 resolver queries",
    ),
    "dnsQueryAll": MessageLookupByLibrary.simpleMessage("All queries"),
    "dnsQueryAnswers": MessageLookupByLibrary.simpleMessage("Answers"),
    "dnsQueryCached": MessageLookupByLibrary.simpleMessage("Cached"),
    "dnsQueryFailures": MessageLookupByLibrary.simpleMessage("Failed queries"),
    "dnsQueryInitiatorApp": MessageLookupByLibrary.simpleMessage("Application"),
    "dnsQueryInitiatorDirect": MessageLookupByLibrary.simpleMessage(
      "Direct connection",
    ),
    "dnsQueryInitiatorOther": MessageLookupByLibrary.simpleMessage("Other"),
    "dnsQueryInitiatorProxy": MessageLookupByLibrary.simpleMessage(
      "Proxy connection",
    ),
    "dnsQueryInitiatorRule": MessageLookupByLibrary.simpleMessage(
      "Rule matching",
    ),
    "dnsQueryRcode": MessageLookupByLibrary.simpleMessage("Response code"),
    "dnsQueryType": MessageLookupByLibrary.simpleMessage("Query type"),
    "dnsQueryUpstream": MessageLookupByLibrary.simpleMessage("Upstream"),
    "doYouWantToPass": MessageLookupByLibrary.simpleMessage(
      "Do you want to pass",
    ),
    "docked": MessageLookupByLibrary.simpleMessage("Docked"),
    "domain": MessageLookupByLibrary.simpleMessage("Domain"),
    "done": MessageLookupByLibrary.simpleMessage("Done"),
    "download": MessageLookupByLibrary.simpleMessage("Download"),
    "downloadBandwidth": MessageLookupByLibrary.simpleMessage(
      "Download bandwidth",
    ),
    "duration": MessageLookupByLibrary.simpleMessage("Duration"),
    "dynamicMembersHint": MessageLookupByLibrary.simpleMessage(
      "Automatically include nodes from this configuration as the subscription updates. Use a name filter, such as Japan|JP.",
    ),
    "edit": MessageLookupByLibrary.simpleMessage("Edit"),
    "editCustomRouting": MessageLookupByLibrary.simpleMessage(
      "Edit custom routing",
    ),
    "editDashboard": MessageLookupByLibrary.simpleMessage("Edit dashboard"),
    "editGlobalRules": MessageLookupByLibrary.simpleMessage(
      "Edit global rules",
    ),
    "editProfile": MessageLookupByLibrary.simpleMessage("Edit Profile"),
    "editProxyGroup": MessageLookupByLibrary.simpleMessage("Edit proxy group"),
    "editRule": MessageLookupByLibrary.simpleMessage("Edit rule"),
    "editSsid": MessageLookupByLibrary.simpleMessage("Edit SSID"),
    "editorUnavailable": MessageLookupByLibrary.simpleMessage(
      "Editor unavailable",
    ),
    "elapsed": MessageLookupByLibrary.simpleMessage("Took"),
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
    "emptyCustomOverwrite": MessageLookupByLibrary.simpleMessage(
      "Custom override is empty. Use Quick fill or add rules and proxy groups first. To keep subscription content, use Overlay mode.",
    ),
    "emptyCustomProfile": MessageLookupByLibrary.simpleMessage(
      "Add a proxy group or a rule to this custom profile first",
    ),
    "emptyFallback": MessageLookupByLibrary.simpleMessage("Empty fallback"),
    "emptyTip": m26,
    "en": MessageLookupByLibrary.simpleMessage("English"),
    "enableAutoRenew": MessageLookupByLibrary.simpleMessage(
      "Enable auto-renew",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Enabled"),
    "enabledOnStart": MessageLookupByLibrary.simpleMessage("Enable on start"),
    "entries": MessageLookupByLibrary.simpleMessage(" entries"),
    "error": MessageLookupByLibrary.simpleMessage("Error"),
    "errorDetails": MessageLookupByLibrary.simpleMessage("Error details"),
    "es": MessageLookupByLibrary.simpleMessage("Spanish"),
    "exclude": MessageLookupByLibrary.simpleMessage("Hide from recent tasks"),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "When the app is in the background, the app is hidden from the recent task",
    ),
    "excludeDstPort": MessageLookupByLibrary.simpleMessage(
      "Excluded destination ports",
    ),
    "excludeDstPortDesc": MessageLookupByLibrary.simpleMessage(
      "Traffic to excluded destination ports skips TUN",
    ),
    "excludeInterface": MessageLookupByLibrary.simpleMessage(
      "Excluded interfaces",
    ),
    "excludeInterfaceDesc": MessageLookupByLibrary.simpleMessage(
      "Traffic arriving on excluded interfaces, such as docker0, skips TUN",
    ),
    "excludeNetworks": MessageLookupByLibrary.simpleMessage(
      "Pause proxy by IP or gateway",
    ),
    "excludeNetworksDesc": MessageLookupByLibrary.simpleMessage(
      "Pause on matching Wi-Fi/Ethernet IPv4 addresses, subnets or gateways; resume after leaving. Comma-separated, e.g. 192.168.1.0/24,gateway:192.168.1.1",
    ),
    "excludeNetworksInvalid": MessageLookupByLibrary.simpleMessage(
      "Up to 16 rules; enter valid IPv4, CIDR or gateway:address",
    ),
    "excludeProxyFilter": MessageLookupByLibrary.simpleMessage(
      "Exclude proxy filter",
    ),
    "excludeSrcPort": MessageLookupByLibrary.simpleMessage(
      "Excluded source ports",
    ),
    "excludeSrcPortDesc": MessageLookupByLibrary.simpleMessage(
      "Traffic from excluded source ports skips TUN",
    ),
    "excludeSsids": MessageLookupByLibrary.simpleMessage(
      "Wi-Fi networks that pause the proxy",
    ),
    "excludeSsidsDesc": MessageLookupByLibrary.simpleMessage(
      "Pause proxying on the listed Wi-Fi networks; resume after leaving only while the app remains started.",
    ),
    "excludeType": MessageLookupByLibrary.simpleMessage("Exclude type"),
    "excludeUid": MessageLookupByLibrary.simpleMessage("Excluded user IDs"),
    "excludeUidDesc": MessageLookupByLibrary.simpleMessage(
      "Traffic from processes of excluded user IDs skips TUN",
    ),
    "existsTip": m27,
    "exit": MessageLookupByLibrary.simpleMessage("Exit"),
    "exitFullScreen": MessageLookupByLibrary.simpleMessage("Exit full screen"),
    "exitNodes": MessageLookupByLibrary.simpleMessage("Exit nodes"),
    "expandList": MessageLookupByLibrary.simpleMessage("Expand"),
    "expectedStatus": MessageLookupByLibrary.simpleMessage("Expected status"),
    "expireDate": m28,
    "expireTime": MessageLookupByLibrary.simpleMessage("Expiration time"),
    "expiresAtLabel": MessageLookupByLibrary.simpleMessage("Expires at"),
    "exportFile": MessageLookupByLibrary.simpleMessage("Export file"),
    "exportLogs": MessageLookupByLibrary.simpleMessage("Export logs"),
    "exportSuccess": MessageLookupByLibrary.simpleMessage("Export Success"),
    "externalController": MessageLookupByLibrary.simpleMessage(
      "External controller",
    ),
    "externalControllerDesc": MessageLookupByLibrary.simpleMessage(
      "The external controller lets you control the core on the configured address",
    ),
    "externalLink": MessageLookupByLibrary.simpleMessage("External link"),
    "extraLarge": MessageLookupByLibrary.simpleMessage("Extra large"),
    "fade": MessageLookupByLibrary.simpleMessage("Fade"),
    "failedItem": m29,
    "fakeipFilter": MessageLookupByLibrary.simpleMessage("Fake-IP filter"),
    "fakeipFilterMode": MessageLookupByLibrary.simpleMessage(
      "Fake-IP filter mode",
    ),
    "fakeipFilterModeDesc": MessageLookupByLibrary.simpleMessage(
      "In Fake-IP filter mode, blacklist excludes matches, whitelist fakes only matches, and rule matches as rules",
    ),
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Fake-IP range"),
    "fakeipRange6": MessageLookupByLibrary.simpleMessage(
      "Fake-IP range (IPv6)",
    ),
    "fakeipTtl": MessageLookupByLibrary.simpleMessage("Fake-IP TTL"),
    "fallback": MessageLookupByLibrary.simpleMessage("Fallback"),
    "fallbackDesc": MessageLookupByLibrary.simpleMessage(
      "Fallback usually lists DNS servers abroad",
    ),
    "fallbackFilter": MessageLookupByLibrary.simpleMessage("Fallback filter"),
    "fallbackLazyQuery": MessageLookupByLibrary.simpleMessage(
      "Lazy fallback query",
    ),
    "fetchOrdersFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to load purchase records",
    ),
    "fetchPlansFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to load plans",
    ),
    "file": MessageLookupByLibrary.simpleMessage("File"),
    "fileDesc": MessageLookupByLibrary.simpleMessage("Directly upload profile"),
    "fileIsUpdate": MessageLookupByLibrary.simpleMessage(
      "The file has been modified. Do you want to save the changes?",
    ),
    "filter": MessageLookupByLibrary.simpleMessage("Filter"),
    "filters": MessageLookupByLibrary.simpleMessage("Filters"),
    "findProcessMode": MessageLookupByLibrary.simpleMessage("Find process"),
    "findProcessModeAutomaticDesc": MessageLookupByLibrary.simpleMessage(
      "Process rules look up the process only when they are checked",
    ),
    "findProcessModeDesc": MessageLookupByLibrary.simpleMessage(
      "There is a certain performance loss after opening",
    ),
    "floating": MessageLookupByLibrary.simpleMessage("Floating"),
    "floatingNavigationBar": MessageLookupByLibrary.simpleMessage(
      "Floating navigation",
    ),
    "followProfile": MessageLookupByLibrary.simpleMessage("Follow profile"),
    "followSystem": MessageLookupByLibrary.simpleMessage("Follow system"),
    "fontFamily": MessageLookupByLibrary.simpleMessage("Font family"),
    "fontSize": MessageLookupByLibrary.simpleMessage("Size"),
    "forceDnsMapping": MessageLookupByLibrary.simpleMessage(
      "Force DNS mapping",
    ),
    "forceDnsMappingDesc": MessageLookupByLibrary.simpleMessage(
      "Force DNS mapping also sniffs connections whose domain came from a DNS mapping",
    ),
    "forceDomain": MessageLookupByLibrary.simpleMessage("Force domains"),
    "forceDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Force domains are sniffed too; other connections that already have a domain are left alone",
    ),
    "forceRestartCoreTip": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to force restart the core?",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "format": MessageLookupByLibrary.simpleMessage("Format"),
    "fr": MessageLookupByLibrary.simpleMessage("French"),
    "general": MessageLookupByLibrary.simpleMessage("General"),
    "geoAutoUpdate": MessageLookupByLibrary.simpleMessage("Auto Update"),
    "geoAutoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Auto Update Interval",
    ),
    "geoAutoUpdateIntervalTip": MessageLookupByLibrary.simpleMessage(
      "Auto update interval must be between 1 and 8760 hours",
    ),
    "geoBackupSource": MessageLookupByLibrary.simpleMessage("Backup CDN"),
    "geoDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "GEO download failed",
    ),
    "geoDownloadRecoveryHint": MessageLookupByLibrary.simpleMessage(
      "Download uses the current network rules, or a direct connection when the proxy is unavailable. Retry the current address, choose another source, or enter a custom URL. After validation, the operation will continue automatically.",
    ),
    "geoDownloadUrl": MessageLookupByLibrary.simpleMessage("Download URL"),
    "geoFileMissing": MessageLookupByLibrary.simpleMessage("Not downloaded"),
    "geoFileReadFailed": MessageLookupByLibrary.simpleMessage(
      "Could not read resource file",
    ),
    "geoInvalidDownloadUrl": MessageLookupByLibrary.simpleMessage(
      "Enter a valid HTTP or HTTPS URL",
    ),
    "geoOptions": MessageLookupByLibrary.simpleMessage("Geo Options"),
    "geoOriginalSource": MessageLookupByLibrary.simpleMessage(
      "Current address",
    ),
    "geoResources": MessageLookupByLibrary.simpleMessage("Geo Resources"),
    "geoSkipped": m30,
    "geoUpdated": m31,
    "geoUpdating": m32,
    "geodataLoader": MessageLookupByLibrary.simpleMessage(
      "Geo low-memory mode",
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
    "goToConfigureAddedRules": MessageLookupByLibrary.simpleMessage(
      "Go to added rules configuration",
    ),
    "goToConfigureScript": MessageLookupByLibrary.simpleMessage(
      "Go to configure script",
    ),
    "googleLoginInvalidCallback": MessageLookupByLibrary.simpleMessage(
      "Could not verify Google sign-in. Please try again.",
    ),
    "googleLoginTimedOut": MessageLookupByLibrary.simpleMessage(
      "Google sign-in timed out. Please try again.",
    ),
    "googleLoginUnavailable": MessageLookupByLibrary.simpleMessage(
      "Could not open Google sign-in. Please try again.",
    ),
    "googleLoginWaiting": MessageLookupByLibrary.simpleMessage(
      "Complete Google sign-in in your browser",
    ),
    "grid": MessageLookupByLibrary.simpleMessage("Grid"),
    "groupCount": m33,
    "groupCountUnit": MessageLookupByLibrary.simpleMessage("groups"),
    "groupCycleError": m34,
    "groupFilterHint": MessageLookupByLibrary.simpleMessage(
      "Filters automatically included and provider nodes. Manually selected members are always kept.",
    ),
    "groupTimeoutCount": m35,
    "groupTypeFallback": MessageLookupByLibrary.simpleMessage("Failover"),
    "groupTypeFallbackHint": MessageLookupByLibrary.simpleMessage(
      "Try members in order and switch when the current member fails.",
    ),
    "groupTypeLoadBalance": MessageLookupByLibrary.simpleMessage(
      "Load balancing",
    ),
    "groupTypeLoadBalanceHint": MessageLookupByLibrary.simpleMessage(
      "Distribute connections across available members.",
    ),
    "groupTypeSelect": MessageLookupByLibrary.simpleMessage("Manual selection"),
    "groupTypeSelectHint": MessageLookupByLibrary.simpleMessage(
      "Choose the active member on the Proxies page.",
    ),
    "groupTypeUrlTest": MessageLookupByLibrary.simpleMessage(
      "Automatic selection",
    ),
    "groupTypeUrlTestHint": MessageLookupByLibrary.simpleMessage(
      "Periodically test members and select a low-latency node.",
    ),
    "hasCacheChange": MessageLookupByLibrary.simpleMessage(
      "Do you want to cache the changes?",
    ),
    "hashByInUser": MessageLookupByLibrary.simpleMessage(
      "Hash by inbound user",
    ),
    "haveAccountAlready": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
    ),
    "healthCheck": MessageLookupByLibrary.simpleMessage("Health check"),
    "helperCorruptTip": MessageLookupByLibrary.simpleMessage(
      "Helper service unavailable; TUN mode cannot be enabled. Reinstall FlClash to restore it.",
    ),
    "hex": MessageLookupByLibrary.simpleMessage("Hex"),
    "hide": MessageLookupByLibrary.simpleMessage("Hide"),
    "hideFromList": MessageLookupByLibrary.simpleMessage("Hide from list"),
    "hideIp": MessageLookupByLibrary.simpleMessage("Hide IP"),
    "hidePassword": MessageLookupByLibrary.simpleMessage("Hide password"),
    "hideTimeoutProxies": MessageLookupByLibrary.simpleMessage(
      "Hide failed nodes",
    ),
    "hideTimeoutProxiesDesc": MessageLookupByLibrary.simpleMessage(
      "Keep the selected node and nodes that have not finished testing",
    ),
    "hopInterval": MessageLookupByLibrary.simpleMessage("Hop interval"),
    "host": MessageLookupByLibrary.simpleMessage("Host"),
    "hostname": MessageLookupByLibrary.simpleMessage("Hostname"),
    "hostsDesc": MessageLookupByLibrary.simpleMessage("Add Hosts"),
    "hotkeyConflictWith": m36,
    "hotkeyDesc": MessageLookupByLibrary.simpleMessage(
      "Global hotkeys work even while the window is hidden. Tap an action to record its key combination.",
    ),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage(
      "Hotkey Management",
    ),
    "hotkeyManagementDesc": MessageLookupByLibrary.simpleMessage(
      "Use keyboard to control applications",
    ),
    "hotkeyNeedsModifier": m37,
    "hotkeyNotSet": MessageLookupByLibrary.simpleMessage("Not set"),
    "hotkeyUnavailable": MessageLookupByLibrary.simpleMessage(
      "Shortcut unavailable",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("Hours"),
    "hoursAgo": m38,
    "hoursAgoShort": m39,
    "hoursCount": m40,
    "hue": MessageLookupByLibrary.simpleMessage("Hue"),
    "iHavePaid": MessageLookupByLibrary.simpleMessage("I have paid"),
    "icon": MessageLookupByLibrary.simpleMessage("Icon"),
    "iconHistory": MessageLookupByLibrary.simpleMessage("Recent icons"),
    "iconSets": MessageLookupByLibrary.simpleMessage("Icon sets"),
    "iconSetsEmptyTip": MessageLookupByLibrary.simpleMessage(
      "No icon sets yet. Add them in Custom profile resources → Icon sets",
    ),
    "iconStyle": MessageLookupByLibrary.simpleMessage("Icon style"),
    "iconStyleFilled": MessageLookupByLibrary.simpleMessage("Filled"),
    "iconStyleHidden": MessageLookupByLibrary.simpleMessage("Hidden"),
    "iconStylePlain": MessageLookupByLibrary.simpleMessage("Plain"),
    "iconUrl": MessageLookupByLibrary.simpleMessage("Icon URL"),
    "ignoreBatteryOptimization": MessageLookupByLibrary.simpleMessage(
      "Ignore battery optimization",
    ),
    "import": MessageLookupByLibrary.simpleMessage("Import"),
    "importConfig": MessageLookupByLibrary.simpleMessage("Import config"),
    "importConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Build a custom profile from a config\'s proxies, groups, rules and settings",
    ),
    "importConfigInvalid": MessageLookupByLibrary.simpleMessage(
      "This is not a config that can be imported",
    ),
    "importConfigReplaceTip": MessageLookupByLibrary.simpleMessage(
      "Importing replaces the nodes, proxy groups, rules and settings this profile has now",
    ),
    "importFile": MessageLookupByLibrary.simpleMessage("Import from file"),
    "importFromLink": MessageLookupByLibrary.simpleMessage("Import from link"),
    "importFromURL": MessageLookupByLibrary.simpleMessage("Import from URL"),
    "importText": MessageLookupByLibrary.simpleMessage("Import from text"),
    "importUrl": MessageLookupByLibrary.simpleMessage("Import from URL"),
    "inbound": MessageLookupByLibrary.simpleMessage("Inbound"),
    "includeAll": MessageLookupByLibrary.simpleMessage(
      "Include all proxies and providers",
    ),
    "includeAllProxies": MessageLookupByLibrary.simpleMessage(
      "Include all proxies",
    ),
    "includeAllProxyProviders": MessageLookupByLibrary.simpleMessage(
      "Include all proxy providers",
    ),
    "includeInterface": MessageLookupByLibrary.simpleMessage(
      "Included interfaces",
    ),
    "includeInterfaceDesc": MessageLookupByLibrary.simpleMessage(
      "Only traffic arriving on included interfaces goes through TUN, and excluded interfaces no longer apply",
    ),
    "includeUid": MessageLookupByLibrary.simpleMessage("Included user IDs"),
    "includeUidDesc": MessageLookupByLibrary.simpleMessage(
      "Only traffic from processes of included user IDs goes through TUN",
    ),
    "infiniteTime": MessageLookupByLibrary.simpleMessage("Long term effective"),
    "init": MessageLookupByLibrary.simpleMessage("Init"),
    "initFailed": MessageLookupByLibrary.simpleMessage("Startup failed"),
    "initFailedTip": MessageLookupByLibrary.simpleMessage(
      "The application encountered a critical error during startup and cannot continue.",
    ),
    "initiatorShort": MessageLookupByLibrary.simpleMessage("From"),
    "inputProxyGroupName": MessageLookupByLibrary.simpleMessage(
      "Enter the proxy group name",
    ),
    "installedAppsLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Could not load installed apps. Please try again.",
    ),
    "installedAppsPermissionDeniedMessage":
        MessageLookupByLibrary.simpleMessage(
          "Permission was not granted. You can enable it in system settings.",
        ),
    "installedAppsPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "Allow access to the installed app list to choose which apps use the VPN.",
    ),
    "installedAppsPermissionGrant": MessageLookupByLibrary.simpleMessage(
      "Allow access",
    ),
    "installedAppsPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Installed apps permission required",
    ),
    "installedFonts": MessageLookupByLibrary.simpleMessage("Installed fonts"),
    "insufficientBalanceHint": MessageLookupByLibrary.simpleMessage(
      "Insufficient balance. Top up before continuing.",
    ),
    "insufficientBalanceRecharge": MessageLookupByLibrary.simpleMessage(
      "Recharge and try again.",
    ),
    "intelligentSelected": MessageLookupByLibrary.simpleMessage(
      "Intelligent selection",
    ),
    "interfaceAutomatic": MessageLookupByLibrary.simpleMessage(
      "Clear override (automatic interface)",
    ),
    "interfaceFollowProfile": MessageLookupByLibrary.simpleMessage(
      "Follow profile",
    ),
    "interfaceName": MessageLookupByLibrary.simpleMessage("Interface name"),
    "interfaceNameDesc": MessageLookupByLibrary.simpleMessage(
      "Interface name is the network interface outbound connections use",
    ),
    "interfaceNameMode": MessageLookupByLibrary.simpleMessage(
      "Outbound interface",
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
      "The server certificate could not be verified. Skipping verification means the server may be impersonated, and any account credentials or subscription data you send or receive could be stolen or altered.\n\nProceed only if you trust this network and server. This exception applies only to this retry with the same server and certificate, and is removed when the operation ends.",
    ),
    "invalidCertificateTitle": MessageLookupByLibrary.simpleMessage(
      "Certificate Verification Failed",
    ),
    "invalidCidrContent": MessageLookupByLibrary.simpleMessage(
      "Enter an IP range in CIDR form such as 192.168.0.0/16",
    ),
    "invalidDscpContent": MessageLookupByLibrary.simpleMessage(
      "A DSCP mark cannot exceed 63",
    ),
    "invalidHostContent": MessageLookupByLibrary.simpleMessage(
      "Enter a domain or an IP address",
    ),
    "invalidIpv6CidrContent": MessageLookupByLibrary.simpleMessage(
      "Enter an IPv6 range in CIDR form such as fd00::/8",
    ),
    "invalidLinkTip": MessageLookupByLibrary.simpleMessage(
      "Not a subscription link or a proxy share link",
    ),
    "invalidListenContent": MessageLookupByLibrary.simpleMessage(
      "Enter an address and port such as 0.0.0.0:1053",
    ),
    "invalidNetworkContent": MessageLookupByLibrary.simpleMessage(
      "Only tcp or udp is supported",
    ),
    "invalidPolicy": m41,
    "invalidPortRangeContent": MessageLookupByLibrary.simpleMessage(
      "Enter a port or a range such as 443 or 8000-9000",
    ),
    "invalidProfileQrcode": MessageLookupByLibrary.simpleMessage(
      "This QR code doesn\'t contain a profile link",
    ),
    "invalidProxyProvider": m42,
    "invalidRangeContent": MessageLookupByLibrary.simpleMessage(
      "Enter numbers or ranges such as 80 or 8000-9000, separated by /",
    ),
    "invalidRuleSet": m43,
    "invalidSubRule": m44,
    "inviteCodeHint": MessageLookupByLibrary.simpleMessage("Enter invite code"),
    "inviteCodeLabel": MessageLookupByLibrary.simpleMessage("Invite Code"),
    "inviteCodeValidation": MessageLookupByLibrary.simpleMessage(
      "Please enter the invite code",
    ),
    "ipType": MessageLookupByLibrary.simpleMessage("Type"),
    "ipVersion": MessageLookupByLibrary.simpleMessage("IP version"),
    "ipcidr": MessageLookupByLibrary.simpleMessage("Ipcidr"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage(
      "IPv6 traffic is received only while IPv6 is on",
    ),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage(
      "With IPv6 on, the VPN allows IPv6 inbound",
    ),
    "ipv6Timeout": MessageLookupByLibrary.simpleMessage("IPv6 timeout (ms)"),
    "itemsCount": m45,
    "ja": MessageLookupByLibrary.simpleMessage("Japanese"),
    "justNow": MessageLookupByLibrary.simpleMessage("Just now"),
    "keepAliveIdle": MessageLookupByLibrary.simpleMessage(
      "TCP keep-alive idle",
    ),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "TCP keep-alive interval",
    ),
    "key": MessageLookupByLibrary.simpleMessage("Key"),
    "ko": MessageLookupByLibrary.simpleMessage("Korean"),
    "label": MessageLookupByLibrary.simpleMessage("Label"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "large": MessageLookupByLibrary.simpleMessage("Large"),
    "lastUpdated": MessageLookupByLibrary.simpleMessage("Last updated"),
    "layout": MessageLookupByLibrary.simpleMessage("Layout"),
    "lazy": MessageLookupByLibrary.simpleMessage("Lazy loading"),
    "light": MessageLookupByLibrary.simpleMessage("Light"),
    "lineIssueTip": m46,
    "lineWrap": MessageLookupByLibrary.simpleMessage("Word wrap"),
    "link": MessageLookupByLibrary.simpleMessage("Link"),
    "linkDesc": MessageLookupByLibrary.simpleMessage(
      "Obtain a profile from a subscription link or a proxy share link",
    ),
    "liquidGlass": MessageLookupByLibrary.simpleMessage("Liquid Glass"),
    "list": MessageLookupByLibrary.simpleMessage("List"),
    "listen": MessageLookupByLibrary.simpleMessage("Listen"),
    "listenRoutingMark": MessageLookupByLibrary.simpleMessage(
      "Listen routing mark",
    ),
    "listenRoutingMarkDesc": MessageLookupByLibrary.simpleMessage(
      "Listen routing mark works only on Linux",
    ),
    "liveConnections": MessageLookupByLibrary.simpleMessage("Live connections"),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "local": MessageLookupByLibrary.simpleMessage("Local"),
    "localBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Backup local data to local",
    ),
    "localImage": MessageLookupByLibrary.simpleMessage("Local image"),
    "localNetworkTip": MessageLookupByLibrary.simpleMessage(
      "Local network access denied; using gVisor for this connection. LAN proxies and services may remain unavailable",
    ),
    "locateSelected": MessageLookupByLibrary.simpleMessage(
      "Locate selected node",
    ),
    "locationPermission": MessageLookupByLibrary.simpleMessage(
      "Location permission",
    ),
    "locationPermissionGuide": m47,
    "locationPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Location permission required",
    ),
    "log": MessageLookupByLibrary.simpleMessage("Log"),
    "logLevel": MessageLookupByLibrary.simpleMessage("Log level"),
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
    "logoutContent": MessageLookupByLibrary.simpleMessage("Sign out?"),
    "logoutTitle": MessageLookupByLibrary.simpleMessage("Logout"),
    "logs": MessageLookupByLibrary.simpleMessage("Logs"),
    "logsAndDiagnostics": MessageLookupByLibrary.simpleMessage(
      "Logs and diagnostics",
    ),
    "logsDesc": MessageLookupByLibrary.simpleMessage("Log capture records"),
    "logsTest": MessageLookupByLibrary.simpleMessage("Logs test"),
    "lookupProxyConfig": MessageLookupByLibrary.simpleMessage(
      "Find node configuration",
    ),
    "loopback": MessageLookupByLibrary.simpleMessage("UWP loopback exemption"),
    "loopbackDesc": MessageLookupByLibrary.simpleMessage(
      "Used for UWP loopback unlocking",
    ),
    "loose": MessageLookupByLibrary.simpleMessage("Loose"),
    "mainlandNetworkWarning": MessageLookupByLibrary.simpleMessage(
      "May not be suitable for networks in mainland China",
    ),
    "matchCase": MessageLookupByLibrary.simpleMessage("Match case"),
    "matchTarget": MessageLookupByLibrary.simpleMessage("MATCH-TARGET"),
    "matchTargetTitle": MessageLookupByLibrary.simpleMessage("Match target"),
    "maxFailedTimes": MessageLookupByLibrary.simpleMessage("Max failed times"),
    "maxLengthTip": m48,
    "maximize": MessageLookupByLibrary.simpleMessage("Maximize"),
    "memberOrderHint": MessageLookupByLibrary.simpleMessage(
      "Selection order is the fallback order. Remove and reselect a member to move it to the end.",
    ),
    "memoryAppResident": MessageLookupByLibrary.simpleMessage(
      "Resident memory",
    ),
    "memoryAppShared": MessageLookupByLibrary.simpleMessage("App & shared"),
    "memoryCoreHeapIdle": MessageLookupByLibrary.simpleMessage("Heap idle"),
    "memoryCoreHeapInuse": MessageLookupByLibrary.simpleMessage("Heap in use"),
    "memoryCoreNotRunning": MessageLookupByLibrary.simpleMessage(
      "Core is not running",
    ),
    "memoryCoreRuntime": MessageLookupByLibrary.simpleMessage(
      "Runtime overhead",
    ),
    "memoryCoreStack": MessageLookupByLibrary.simpleMessage("Goroutine stacks"),
    "memoryEstimateDesc": MessageLookupByLibrary.simpleMessage(
      "Estimated from process resident memory; it may differ from what the system reports.",
    ),
    "memoryEstimateSharedDesc": MessageLookupByLibrary.simpleMessage(
      "The Core runs inside the app process. Its share is estimated from runtime stats, and the rest counts as app and shared memory.",
    ),
    "memoryInfo": MessageLookupByLibrary.simpleMessage("Memory info"),
    "memoryInfoDesc": MessageLookupByLibrary.simpleMessage(
      "Memory the app and the core use",
    ),
    "memoryReleased": MessageLookupByLibrary.simpleMessage("Memory released"),
    "memoryReleasedSize": m49,
    "messageTest": MessageLookupByLibrary.simpleMessage("Message test"),
    "messageTestTip": MessageLookupByLibrary.simpleMessage(
      "This is a message.",
    ),
    "minimalConfiguration": MessageLookupByLibrary.simpleMessage(
      "Minimal Configuration",
    ),
    "minimalConfigurationDesc": MessageLookupByLibrary.simpleMessage(
      "Use a simplified rule set to generate a smaller profile",
    ),
    "minimize": MessageLookupByLibrary.simpleMessage("Minimize"),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage("Minimize on exit"),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "Modify the default system exit event",
    ),
    "minutes": MessageLookupByLibrary.simpleMessage("minutes"),
    "minutesAgo": m50,
    "minutesAgoShort": m51,
    "mixedPort": MessageLookupByLibrary.simpleMessage("Mixed port"),
    "mode": MessageLookupByLibrary.simpleMessage("Mode"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("Monochrome"),
    "monthsAgo": m52,
    "monthsAgoShort": m53,
    "more": MessageLookupByLibrary.simpleMessage("More"),
    "myOrders": MessageLookupByLibrary.simpleMessage("Purchased Plans"),
    "name": MessageLookupByLibrary.simpleMessage("Name"),
    "nameCustomProfileTip": MessageLookupByLibrary.simpleMessage(
      "Name this custom profile",
    ),
    "nameserver": MessageLookupByLibrary.simpleMessage("Nameserver"),
    "nameserverDesc": MessageLookupByLibrary.simpleMessage(
      "The nameserver resolves domains",
    ),
    "nameserverPolicy": MessageLookupByLibrary.simpleMessage(
      "Nameserver policy",
    ),
    "nameserverPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "Nameserver policy picks the nameserver for matching domains",
    ),
    "navigationBarStyle": MessageLookupByLibrary.simpleMessage("Bottom bar"),
    "network": MessageLookupByLibrary.simpleMessage("Network"),
    "networkAccessDeniedError": m54,
    "networkBadResponseError": m55,
    "networkCancelledError": MessageLookupByLibrary.simpleMessage(
      "The request was cancelled",
    ),
    "networkConnectionError": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t connect to the server. Check your network connection or proxy settings",
    ),
    "networkDesc": MessageLookupByLibrary.simpleMessage(
      "Modify network-related settings",
    ),
    "networkDetection": MessageLookupByLibrary.simpleMessage(
      "Network detection",
    ),
    "networkException": MessageLookupByLibrary.simpleMessage(
      "Network exception, please check your connection and try again",
    ),
    "networkHostLookupError": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t resolve the server address. Check that the URL is correct and DNS is working",
    ),
    "networkName": MessageLookupByLibrary.simpleMessage("Network name"),
    "networkNotFoundError": m56,
    "networkRateLimitedError": MessageLookupByLibrary.simpleMessage(
      "Too many requests (HTTP 429). Wait a moment and try again",
    ),
    "networkSecret": MessageLookupByLibrary.simpleMessage("Network secret"),
    "networkServerError": m57,
    "networkSpeed": MessageLookupByLibrary.simpleMessage("Network speed"),
    "networkTakeover": MessageLookupByLibrary.simpleMessage("Traffic takeover"),
    "networkTimeoutError": MessageLookupByLibrary.simpleMessage(
      "The request timed out. Check your network or proxy, then try again",
    ),
    "networkTlsError": MessageLookupByLibrary.simpleMessage(
      "Secure connection failed. The server\'s certificate may be invalid, or the connection is being intercepted",
    ),
    "networkType": MessageLookupByLibrary.simpleMessage("Network type"),
    "newPasswordLabel": MessageLookupByLibrary.simpleMessage("New password"),
    "nextMatch": MessageLookupByLibrary.simpleMessage("Next match"),
    "nicknameHint": MessageLookupByLibrary.simpleMessage(
      "Letters and numbers, up to 12 characters",
    ),
    "nicknameLabel": MessageLookupByLibrary.simpleMessage("Nickname"),
    "nicknameValidation": MessageLookupByLibrary.simpleMessage(
      "Please enter a nickname",
    ),
    "no": MessageLookupByLibrary.simpleMessage("No"),
    "noAvailablePlans": MessageLookupByLibrary.simpleMessage(
      "No plans available",
    ),
    "noData": MessageLookupByLibrary.simpleMessage("No data"),
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
    "noRemoteBackup": MessageLookupByLibrary.simpleMessage(
      "No backups on WebDAV",
    ),
    "noResolve": MessageLookupByLibrary.simpleMessage("No resolve IP"),
    "noSearchResult": MessageLookupByLibrary.simpleMessage(
      "No matching results",
    ),
    "noSearchResults": MessageLookupByLibrary.simpleMessage(
      "No matching results",
    ),
    "noUpgradablePlans": MessageLookupByLibrary.simpleMessage(
      "No upgradable plans",
    ),
    "nodeCoreValidationUnavailable": MessageLookupByLibrary.simpleMessage(
      "Start the Core before validating this node",
    ),
    "nodeDefinition": MessageLookupByLibrary.simpleMessage("Node definition"),
    "nodeFilter": MessageLookupByLibrary.simpleMessage("Node Filter"),
    "nodeFilterAccountNote": MessageLookupByLibrary.simpleMessage(
      "Saved to your account and applies to every device signed in to this app.",
    ),
    "nodeFilterAny": MessageLookupByLibrary.simpleMessage("Any"),
    "nodeFilterCustomized": MessageLookupByLibrary.simpleMessage("Customized"),
    "nodeFilterExclude": MessageLookupByLibrary.simpleMessage("Exclude"),
    "nodeFilterKeepOne": MessageLookupByLibrary.simpleMessage(
      "Keep at least one node",
    ),
    "nodeFilterKept": m58,
    "nodeFilterLines": MessageLookupByLibrary.simpleMessage("Lines"),
    "nodeFilterNameContains": MessageLookupByLibrary.simpleMessage(
      "Name contains",
    ),
    "nodeFilterNameExcludes": MessageLookupByLibrary.simpleMessage(
      "Name excludes",
    ),
    "nodeFilterNodeExcluded": m59,
    "nodeFilterNodeKept": m60,
    "nodeFilterOnly": MessageLookupByLibrary.simpleMessage("Only"),
    "nodeFilterPreview": MessageLookupByLibrary.simpleMessage("Preview"),
    "nodeFilterRegions": MessageLookupByLibrary.simpleMessage("Regions"),
    "nodeFilterRetry": MessageLookupByLibrary.simpleMessage("Retry"),
    "nodeFilterSearch": MessageLookupByLibrary.simpleMessage("Search nodes"),
    "nodeFilterSmartSelection": MessageLookupByLibrary.simpleMessage(
      "Smart Selection",
    ),
    "nodeInvalidDefinition": MessageLookupByLibrary.simpleMessage(
      "Enter one complete proxy definition with a name and type",
    ),
    "nodeQuickFields": MessageLookupByLibrary.simpleMessage("Quick edit"),
    "nodeShareLinkUnavailable": MessageLookupByLibrary.simpleMessage(
      "This node cannot be represented by a share link; use fields or YAML",
    ),
    "nodes": MessageLookupByLibrary.simpleMessage("Nodes"),
    "nonTextProviderFile": MessageLookupByLibrary.simpleMessage(
      "This external resource is not a text file",
    ),
    "none": MessageLookupByLibrary.simpleMessage("None"),
    "notRunning": MessageLookupByLibrary.simpleMessage("Not running"),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "The current proxy group cannot be selected.",
    ),
    "ntpDesc": MessageLookupByLibrary.simpleMessage(
      "Update NTP related settings",
    ),
    "ntpInterval": MessageLookupByLibrary.simpleMessage(
      "Sync interval (minutes)",
    ),
    "ntpOverrideDesc": MessageLookupByLibrary.simpleMessage(
      "Entries added here replace the NTP settings of every profile; anything not added keeps the profile\'s own setting. Entries a custom profile adds itself take precedence",
    ),
    "ntpStatusDesc": MessageLookupByLibrary.simpleMessage(
      "NTP takes the time from an NTP server instead of the system clock",
    ),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "No profile, Please add a profile",
    ),
    "nullTip": m61,
    "numberRangeTip": m62,
    "numberTip": m63,
    "obfs": MessageLookupByLibrary.simpleMessage("Obfuscation"),
    "obfsHost": MessageLookupByLibrary.simpleMessage("Obfuscation host"),
    "obfsMode": MessageLookupByLibrary.simpleMessage("Obfuscation mode"),
    "obfsParam": MessageLookupByLibrary.simpleMessage("Obfuscation parameter"),
    "obfsPassword": MessageLookupByLibrary.simpleMessage(
      "Obfuscation password",
    ),
    "oixCloud": MessageLookupByLibrary.simpleMessage("oixCloud"),
    "onDemand": MessageLookupByLibrary.simpleMessage("On demand"),
    "onDemandDesc": MessageLookupByLibrary.simpleMessage(
      "On demand pauses and resumes the proxy by Wi-Fi or network conditions",
    ),
    "onlyStatisticsProxy": MessageLookupByLibrary.simpleMessage(
      "Only count proxy traffic",
    ),
    "onlyStatisticsProxyDesc": MessageLookupByLibrary.simpleMessage(
      "When turned on, only statistics proxy traffic",
    ),
    "openDashboard": MessageLookupByLibrary.simpleMessage("Open dashboard"),
    "openInBrowser": MessageLookupByLibrary.simpleMessage("Open in browser"),
    "openLinkFailed": MessageLookupByLibrary.simpleMessage(
      "Unable to open the link. Check that a browser is installed and try again.",
    ),
    "operationFailed": MessageLookupByLibrary.simpleMessage("Operation failed"),
    "operationSuccess": MessageLookupByLibrary.simpleMessage(
      "Operation successful",
    ),
    "optional": MessageLookupByLibrary.simpleMessage("Optional"),
    "options": MessageLookupByLibrary.simpleMessage("Options"),
    "other": MessageLookupByLibrary.simpleMessage("Other"),
    "outbound": MessageLookupByLibrary.simpleMessage("Outbound"),
    "outboundExit": MessageLookupByLibrary.simpleMessage("Exit"),
    "outboundMode": MessageLookupByLibrary.simpleMessage("Outbound mode"),
    "outboundUnavailable": MessageLookupByLibrary.simpleMessage(
      "Unavailable in this configuration. Remove or replace it.",
    ),
    "overlayHint": MessageLookupByLibrary.simpleMessage(
      "Saved separately from the subscription and reapplied after updates. New groups block connections when no members match.",
    ),
    "overlayNameConflict": m64,
    "override": MessageLookupByLibrary.simpleMessage("Override"),
    "overrideDestination": MessageLookupByLibrary.simpleMessage(
      "Override destination",
    ),
    "overrideDestinationDesc": MessageLookupByLibrary.simpleMessage(
      "Override destination connects to the sniffed domain instead of the original address",
    ),
    "overrideEntries": MessageLookupByLibrary.simpleMessage("Override entries"),
    "overrideMode": MessageLookupByLibrary.simpleMessage("Override mode"),
    "overrideScript": MessageLookupByLibrary.simpleMessage("Override script"),
    "overwriteIssueDuplicateName": m65,
    "overwriteIssueEmptyFallback": m66,
    "overwriteIssueEmptyName": MessageLookupByLibrary.simpleMessage(
      "The name is empty",
    ),
    "overwriteIssueGroupLoop": m67,
    "overwriteIssueMissingProviders": m68,
    "overwriteIssueMissingProxies": m69,
    "overwriteIssueNoProxySource": MessageLookupByLibrary.simpleMessage(
      "No proxies or proxy providers are selected, so the core rejects this group",
    ),
    "overwriteIssueReservedName": m70,
    "overwriteIssuesSummary": m71,
    "overwriteTypeCustom": MessageLookupByLibrary.simpleMessage("Custom"),
    "overwriteTypeCustomDesc": MessageLookupByLibrary.simpleMessage(
      "Custom mode, fully customize proxy groups and rules",
    ),
    "overwriteTypeMerge": MessageLookupByLibrary.simpleMessage("Overlay"),
    "overwriteTypeMergeDesc": MessageLookupByLibrary.simpleMessage(
      "Keep subscription rules and groups, then add your own. Personal rules take priority over subscription rules; existing added rules keep their priority.",
    ),
    "parsePureIp": MessageLookupByLibrary.simpleMessage("Parse pure IP"),
    "parsePureIpDesc": MessageLookupByLibrary.simpleMessage(
      "Parse pure IP sniffs connections that carry only an IP address",
    ),
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
    "pauseUpdates": MessageLookupByLibrary.simpleMessage("Pause updates"),
    "payWithBalance": MessageLookupByLibrary.simpleMessage("Pay with balance"),
    "paymentAmount": MessageLookupByLibrary.simpleMessage("Payment amount"),
    "paymentMethod": MessageLookupByLibrary.simpleMessage("Payment method"),
    "paymentPending": MessageLookupByLibrary.simpleMessage(
      "Payment has not been received yet. Please check again shortly.",
    ),
    "paymentRequestFailed": MessageLookupByLibrary.simpleMessage(
      "Payment request failed",
    ),
    "paymentSuccess": MessageLookupByLibrary.simpleMessage(
      "Payment successful",
    ),
    "paymentUnknownResponse": MessageLookupByLibrary.simpleMessage(
      "Payment endpoint returned an unknown format",
    ),
    "peers": MessageLookupByLibrary.simpleMessage("Peers"),
    "personalRouting": MessageLookupByLibrary.simpleMessage("Personal routing"),
    "pickFromAlbum": MessageLookupByLibrary.simpleMessage("Choose from album"),
    "pinWindow": MessageLookupByLibrary.simpleMessage("Pin window"),
    "planEnded": MessageLookupByLibrary.simpleMessage("Ended"),
    "planInUse": MessageLookupByLibrary.simpleMessage("In use"),
    "planNotActivated": MessageLookupByLibrary.simpleMessage(
      "Pending activation",
    ),
    "planNumber": m72,
    "planUnavailable": MessageLookupByLibrary.simpleMessage("Unavailable"),
    "pleaseBindWebDAV": MessageLookupByLibrary.simpleMessage(
      "Please bind WebDAV",
    ),
    "pleaseInputAdminPassword": MessageLookupByLibrary.simpleMessage(
      "Please enter the admin password",
    ),
    "pleaseUploadValidQrcode": MessageLookupByLibrary.simpleMessage(
      "Please upload a valid QR code",
    ),
    "plugin": MessageLookupByLibrary.simpleMessage("Plugin"),
    "pluginCipher": MessageLookupByLibrary.simpleMessage("Plugin cipher"),
    "pluginHost": MessageLookupByLibrary.simpleMessage("Plugin host"),
    "pluginMode": MessageLookupByLibrary.simpleMessage("Plugin mode"),
    "pluginPassword": MessageLookupByLibrary.simpleMessage("Plugin password"),
    "pluginPath": MessageLookupByLibrary.simpleMessage("Plugin path"),
    "pluginUsername": MessageLookupByLibrary.simpleMessage("Plugin username"),
    "points": MessageLookupByLibrary.simpleMessage("Points"),
    "port": MessageLookupByLibrary.simpleMessage("Port"),
    "portConflictTip": MessageLookupByLibrary.simpleMessage(
      "Please enter a different port",
    ),
    "portHopping": MessageLookupByLibrary.simpleMessage("Port hopping"),
    "portProxyAppTip": MessageLookupByLibrary.simpleMessage(
      "If another proxy app is running, close it first.",
    ),
    "portSuggestionTip": m73,
    "portTip": m74,
    "portUnavailableMessage": m75,
    "portUnavailableTitle": MessageLookupByLibrary.simpleMessage(
      "Port unavailable",
    ),
    "portValue": m76,
    "ports": MessageLookupByLibrary.simpleMessage("Ports"),
    "preSharedKey": MessageLookupByLibrary.simpleMessage("Pre-shared key"),
    "preferH3": MessageLookupByLibrary.simpleMessage("Prefer HTTP/3"),
    "preferH3Desc": MessageLookupByLibrary.simpleMessage(
      "Prefer HTTP/3 tries HTTP/3 first for DoH servers",
    ),
    "preferred": MessageLookupByLibrary.simpleMessage("Preferred"),
    "prerequisites": MessageLookupByLibrary.simpleMessage("Prerequisites"),
    "pressKeyboard": MessageLookupByLibrary.simpleMessage(
      "Please press the keyboard.",
    ),
    "preview": MessageLookupByLibrary.simpleMessage("Preview"),
    "previousMatch": MessageLookupByLibrary.simpleMessage("Previous match"),
    "privateKey": MessageLookupByLibrary.simpleMessage("Private key"),
    "privateKeyPassphrase": MessageLookupByLibrary.simpleMessage(
      "Private key passphrase",
    ),
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
    "profileDaysLeft": m77,
    "profileExpiresIn": m78,
    "profileHasUpdate": MessageLookupByLibrary.simpleMessage(
      "The profile has been modified. Do you want to disable auto update?",
    ),
    "profileNameNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Please input the profile name",
    ),
    "profileOverrideSettingsDesc": MessageLookupByLibrary.simpleMessage(
      "Applies to this profile only and takes precedence over the override entries in the app\'s DNS and NTP settings; anything not added follows those entries",
    ),
    "profileParseErrorDesc": MessageLookupByLibrary.simpleMessage(
      "Profile parse error",
    ),
    "profileProviderInUse": m79,
    "profileSettingsDesc": MessageLookupByLibrary.simpleMessage(
      "Applies to this profile only; anything not added uses its default",
    ),
    "profileTunSettingsDesc": MessageLookupByLibrary.simpleMessage(
      "Applies to this profile only and takes precedence over the TUN override entries in the network settings",
    ),
    "profileUpdatedAt": m80,
    "profileUrlInvalidValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Please input a valid profile URL",
    ),
    "profileUrlNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Please input the profile URL",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Profiles"),
    "profilesSort": MessageLookupByLibrary.simpleMessage("Profiles sort"),
    "project": MessageLookupByLibrary.simpleMessage("Project"),
    "protocol": MessageLookupByLibrary.simpleMessage("Protocol"),
    "protocolParam": MessageLookupByLibrary.simpleMessage("Protocol parameter"),
    "protocolVersion": MessageLookupByLibrary.simpleMessage("Protocol version"),
    "providerChanged": MessageLookupByLibrary.simpleMessage(
      "The resource changed while editing; reopen it and try again",
    ),
    "providerContent": MessageLookupByLibrary.simpleMessage("Resource content"),
    "providerContentInvalid": MessageLookupByLibrary.simpleMessage(
      "The resource content or format is invalid",
    ),
    "providerContentTooLarge": MessageLookupByLibrary.simpleMessage(
      "The resource exceeds 32 MiB",
    ),
    "providerInUse": m81,
    "providerLocal": MessageLookupByLibrary.simpleMessage("Local file"),
    "providerLookupFailed": MessageLookupByLibrary.simpleMessage(
      "Unable to read the active node configuration. Refresh the resource and try again.",
    ),
    "providerNameInvalid": MessageLookupByLibrary.simpleMessage(
      "Enter a name without commas or line breaks",
    ),
    "providerRemote": MessageLookupByLibrary.simpleMessage("Remote URL"),
    "providerRenameShadowed": m82,
    "providerSourceApp": MessageLookupByLibrary.simpleMessage("App library"),
    "providerSourceProfile": MessageLookupByLibrary.simpleMessage("Profile"),
    "providerSourceReference": m83,
    "providerSourceSubscription": MessageLookupByLibrary.simpleMessage(
      "Subscription",
    ),
    "providerSourceUnavailable": m84,
    "providerUrlTip": MessageLookupByLibrary.simpleMessage(
      "Enter an HTTP or HTTPS URL without embedded credentials",
    ),
    "providers": MessageLookupByLibrary.simpleMessage("Providers"),
    "proxies": MessageLookupByLibrary.simpleMessage("Proxies"),
    "proxiesCount": m85,
    "proxyChainAvailableNodes": MessageLookupByLibrary.simpleMessage(
      "Available nodes",
    ),
    "proxyChainConflictTip": m86,
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
    "proxyChainUnavailableNodeTip": m87,
    "proxyChainUriNodeSupportedFormats": MessageLookupByLibrary.simpleMessage(
      "Supported formats: ss://, ssr://, vmess://, vless://, trojan://, anytls://, hysteria:// / hy://, hysteria2:// / hy2://, tuic://, wireguard:// / wg://, http(s)://, socks(5)://",
    ),
    "proxyChainWarning": MessageLookupByLibrary.simpleMessage(
      "Proxy chaining can significantly reduce network speed. Keep it disabled unless you clearly need it.",
    ),
    "proxyChains": MessageLookupByLibrary.simpleMessage("Proxy chains"),
    "proxyConflictAutoConfig": MessageLookupByLibrary.simpleMessage(
      "Before starting, the system proxy used an automatic configuration script.",
    ),
    "proxyConflictHint": MessageLookupByLibrary.simpleMessage(
      "If this belongs to another proxy app or VPN, close it; running both can break the connection.",
    ),
    "proxyConflictSystemProxy": m88,
    "proxyConflictTitle": MessageLookupByLibrary.simpleMessage(
      "Possible proxy conflict",
    ),
    "proxyConflictVpn": m89,
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
    "proxyGroupsAfterStart": MessageLookupByLibrary.simpleMessage(
      "Groups show up here once the core starts",
    ),
    "proxyGroupsCount": m90,
    "proxyNameserver": MessageLookupByLibrary.simpleMessage("Proxy nameserver"),
    "proxyNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "The proxy nameserver resolves the domains of proxy nodes",
    ),
    "proxyNameserverPolicy": MessageLookupByLibrary.simpleMessage(
      "Proxy nameserver policy",
    ),
    "proxyNode": MessageLookupByLibrary.simpleMessage("Proxy node"),
    "proxyPort": MessageLookupByLibrary.simpleMessage("ProxyPort"),
    "proxyProviders": MessageLookupByLibrary.simpleMessage("Proxy providers"),
    "proxyType": MessageLookupByLibrary.simpleMessage("Proxy type"),
    "pruneCache": MessageLookupByLibrary.simpleMessage("Prune cache"),
    "publicKey": MessageLookupByLibrary.simpleMessage("Public key"),
    "purchaseAutoRenewLabel": MessageLookupByLibrary.simpleMessage(
      "Auto-renew",
    ),
    "purchaseDays": m91,
    "purchaseHours": m92,
    "purchaseMinutes": m93,
    "purchasePriceLabel": MessageLookupByLibrary.simpleMessage(
      "Purchase price",
    ),
    "purchaseRenewOff": MessageLookupByLibrary.simpleMessage("Off"),
    "purchaseRenewOn": MessageLookupByLibrary.simpleMessage("On"),
    "purchaseTotalTrafficLabel": MessageLookupByLibrary.simpleMessage(
      "Total traffic",
    ),
    "purchasedAtLabel": MessageLookupByLibrary.simpleMessage("Purchase time"),
    "pureBlack": MessageLookupByLibrary.simpleMessage("Pure black"),
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("Pure black mode"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QR code"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage(
      "Scan QR code to obtain profile",
    ),
    "qrcodeTooLongTip": MessageLookupByLibrary.simpleMessage(
      "This link is too long for a QR code. Use Copy link instead.",
    ),
    "quickActions": MessageLookupByLibrary.simpleMessage("Quick actions"),
    "quickAdd": MessageLookupByLibrary.simpleMessage("Quick add"),
    "quickEdit": MessageLookupByLibrary.simpleMessage("Quick edit"),
    "quickFill": MessageLookupByLibrary.simpleMessage("Quick fill"),
    "rawOutboundInUse": m94,
    "readFullAnnouncement": MessageLookupByLibrary.simpleMessage(
      "Read full announcement",
    ),
    "receivingAddress": MessageLookupByLibrary.simpleMessage(
      "Receiving address",
    ),
    "recharge": MessageLookupByLibrary.simpleMessage("Recharge"),
    "rechargeAllowedRange": m95,
    "rechargeAmount": MessageLookupByLibrary.simpleMessage(
      "Recharge amount (¥)",
    ),
    "rechargeAmountOutOfRange": MessageLookupByLibrary.simpleMessage(
      "The amount is outside the range allowed by this payment method",
    ),
    "recommendedIcons": MessageLookupByLibrary.simpleMessage("Suggested"),
    "recurringRenewalHint": MessageLookupByLibrary.simpleMessage(
      "Future automatic renewals keep this discount",
    ),
    "redirPort": MessageLookupByLibrary.simpleMessage("Redir port"),
    "redo": MessageLookupByLibrary.simpleMessage("redo"),
    "refresh": MessageLookupByLibrary.simpleMessage("Refresh"),
    "refreshAfterPayment": MessageLookupByLibrary.simpleMessage(
      "After payment, pull down to refresh and check the result",
    ),
    "refundAmountLabel": MessageLookupByLibrary.simpleMessage("Refund"),
    "regex": MessageLookupByLibrary.simpleMessage("Regex"),
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
    "releaseMemory": MessageLookupByLibrary.simpleMessage("Release memory"),
    "releaseMemoryFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to release memory",
    ),
    "remaining": m96,
    "remainingStock": m97,
    "remainingTimeLabel": MessageLookupByLibrary.simpleMessage(
      "Remaining time",
    ),
    "remainingTrafficLabel": MessageLookupByLibrary.simpleMessage(
      "Remaining traffic",
    ),
    "remote": MessageLookupByLibrary.simpleMessage("Remote"),
    "remoteBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Backup local data to WebDAV",
    ),
    "remoteDestination": MessageLookupByLibrary.simpleMessage(
      "Remote destination",
    ),
    "remoteDnsResolve": MessageLookupByLibrary.simpleMessage(
      "Remote DNS resolution",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("Remove"),
    "rename": MessageLookupByLibrary.simpleMessage("Rename"),
    "renewalPriceLabel": MessageLookupByLibrary.simpleMessage("Renewal price"),
    "replace": MessageLookupByLibrary.simpleMessage("Replace"),
    "replaceAll": MessageLookupByLibrary.simpleMessage("Replace all"),
    "request": MessageLookupByLibrary.simpleMessage("Request"),
    "requestHeaders": MessageLookupByLibrary.simpleMessage("Request headers"),
    "requests": MessageLookupByLibrary.simpleMessage("Requests"),
    "requestsDesc": MessageLookupByLibrary.simpleMessage(
      "View recently request records",
    ),
    "required": MessageLookupByLibrary.simpleMessage("Required"),
    "resendCodeIn": m98,
    "reset": MessageLookupByLibrary.simpleMessage("Reset"),
    "resetDns": MessageLookupByLibrary.simpleMessage("Reset DNS"),
    "resetDnsFailed": MessageLookupByLibrary.simpleMessage(
      "Could not reset DNS. Check that the core is connected and try again.",
    ),
    "resetDnsSuccess": MessageLookupByLibrary.simpleMessage(
      "DNS state cleared",
    ),
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
    "resourceSizeLimitTip": m99,
    "resources": MessageLookupByLibrary.simpleMessage("Resources"),
    "resourcesDesc": MessageLookupByLibrary.simpleMessage(
      "External resource related info",
    ),
    "respectRules": MessageLookupByLibrary.simpleMessage("Respect rules"),
    "respectRulesDesc": MessageLookupByLibrary.simpleMessage(
      "Respect rules routes DNS connections by the rules and needs a proxy nameserver",
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
    "result": MessageLookupByLibrary.simpleMessage("Result"),
    "resumeUpdates": MessageLookupByLibrary.simpleMessage("Resume updates"),
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "retryCloudSyncWithCertificateException":
        MessageLookupByLibrary.simpleMessage("Allow Temporarily and Sync"),
    "retryWithoutCertificateVerification": MessageLookupByLibrary.simpleMessage(
      "Temporarily Check API",
    ),
    "reverseEngineeringNotice": MessageLookupByLibrary.simpleMessage(
      "Reverse engineering, decompilation, disassembly, or AI-assisted analysis of this application is strictly prohibited.",
    ),
    "routeAddress": MessageLookupByLibrary.simpleMessage("Route addresses"),
    "routeAddressDesc": MessageLookupByLibrary.simpleMessage(
      "Config listen route address",
    ),
    "routeExcludeAddress": MessageLookupByLibrary.simpleMessage(
      "Route exclude addresses",
    ),
    "routingApplied": MessageLookupByLibrary.simpleMessage(
      "Personal settings applied.",
    ),
    "routingApplyFailed": MessageLookupByLibrary.simpleMessage(
      "Changes were saved but could not be applied. Check the configuration and retry.",
    ),
    "routingChanged": MessageLookupByLibrary.simpleMessage(
      "This configuration changed while it was being edited or checked. Reopen the editor or check it again.",
    ),
    "routingChecked": MessageLookupByLibrary.simpleMessage(
      "Configuration is valid. Personal settings are saved for this profile.",
    ),
    "routingDraftHint": MessageLookupByLibrary.simpleMessage(
      "Save a draft to fix other items. Settings are applied only after the full configuration passes validation.",
    ),
    "routingGroupType": MessageLookupByLibrary.simpleMessage("Group type"),
    "routingMark": MessageLookupByLibrary.simpleMessage("Routing mark"),
    "ru": MessageLookupByLibrary.simpleMessage("Russian"),
    "rule": MessageLookupByLibrary.simpleMessage("Rule"),
    "ruleActionAndDesc": MessageLookupByLibrary.simpleMessage(
      "Logical rule AND",
    ),
    "ruleActionDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Match the full domain",
    ),
    "ruleActionDomainKeywordDesc": MessageLookupByLibrary.simpleMessage(
      "Match a domain keyword",
    ),
    "ruleActionDomainRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Match a domain regex",
    ),
    "ruleActionDomainSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Match a domain suffix",
    ),
    "ruleActionDomainWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Wildcard match; only * and ? are supported",
    ),
    "ruleActionDscpDesc": MessageLookupByLibrary.simpleMessage(
      "Match the DSCP mark (tproxy UDP inbound only)",
    ),
    "ruleActionDstPortDesc": MessageLookupByLibrary.simpleMessage(
      "Match the destination port range",
    ),
    "ruleActionGeoipDesc": MessageLookupByLibrary.simpleMessage(
      "Match the IP\'s country code",
    ),
    "ruleActionGeositeDesc": MessageLookupByLibrary.simpleMessage(
      "Match domains in Geosite",
    ),
    "ruleActionInNameDesc": MessageLookupByLibrary.simpleMessage(
      "Match the inbound name",
    ),
    "ruleActionInPortDesc": MessageLookupByLibrary.simpleMessage(
      "Match the inbound port",
    ),
    "ruleActionInTypeDesc": MessageLookupByLibrary.simpleMessage(
      "Match the inbound type",
    ),
    "ruleActionInUserDesc": MessageLookupByLibrary.simpleMessage(
      "Match the inbound username; separate multiple usernames with /",
    ),
    "ruleActionIpAsnDesc": MessageLookupByLibrary.simpleMessage(
      "Match the IP\'s ASN",
    ),
    "ruleActionIpCidr6Desc": MessageLookupByLibrary.simpleMessage(
      "Match an IP address range; IP-CIDR6 is just an alias",
    ),
    "ruleActionIpCidrDesc": MessageLookupByLibrary.simpleMessage(
      "Match an IP address range",
    ),
    "ruleActionIpSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Match an IP suffix range",
    ),
    "ruleActionMatchDesc": MessageLookupByLibrary.simpleMessage(
      "Match all requests, no conditions needed",
    ),
    "ruleActionNetworkDesc": MessageLookupByLibrary.simpleMessage(
      "Match TCP or UDP",
    ),
    "ruleActionNotDesc": MessageLookupByLibrary.simpleMessage(
      "Logical rule NOT",
    ),
    "ruleActionOrDesc": MessageLookupByLibrary.simpleMessage("Logical rule OR"),
    "ruleActionProcessNameDesc": MessageLookupByLibrary.simpleMessage(
      "Match by process name; matches the package name on Android",
    ),
    "ruleActionProcessNameRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Match by process name regex; matches the package name on Android",
    ),
    "ruleActionProcessNameWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Match by process name wildcard; only * and ? are supported",
    ),
    "ruleActionProcessPathDesc": MessageLookupByLibrary.simpleMessage(
      "Match by the full process path",
    ),
    "ruleActionProcessPathRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Match by process path regex",
    ),
    "ruleActionProcessPathWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Match by process path wildcard; only * and ? are supported",
    ),
    "ruleActionRematchNameDesc": MessageLookupByLibrary.simpleMessage(
      "Match the rematch name; separate multiple names with /",
    ),
    "ruleActionRuleSetDesc": MessageLookupByLibrary.simpleMessage(
      "Reference a rule set; requires rule-providers",
    ),
    "ruleActionSrcGeoipDesc": MessageLookupByLibrary.simpleMessage(
      "Match the source IP\'s country code",
    ),
    "ruleActionSrcIpAsnDesc": MessageLookupByLibrary.simpleMessage(
      "Match the source IP\'s ASN",
    ),
    "ruleActionSrcIpCidrDesc": MessageLookupByLibrary.simpleMessage(
      "Match a source IP address range",
    ),
    "ruleActionSrcIpSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Match a source IP suffix range",
    ),
    "ruleActionSrcPortDesc": MessageLookupByLibrary.simpleMessage(
      "Match the source port range",
    ),
    "ruleActionSubRuleDesc": MessageLookupByLibrary.simpleMessage(
      "Match into a sub-rule; mind the parentheses",
    ),
    "ruleActionUidDesc": MessageLookupByLibrary.simpleMessage(
      "Match the Linux user ID",
    ),
    "ruleEmpty": MessageLookupByLibrary.simpleMessage("Rule is empty"),
    "ruleListInvalid": MessageLookupByLibrary.simpleMessage(
      "The rules must be a YAML list with one rule per item, such as - DOMAIN,example.com,DIRECT",
    ),
    "ruleName": MessageLookupByLibrary.simpleMessage("Rule name"),
    "rulePresetBittorrentDirect": MessageLookupByLibrary.simpleMessage(
      "BitTorrent direct",
    ),
    "rulePresetBlockDot": MessageLookupByLibrary.simpleMessage(
      "Block DNS over TLS",
    ),
    "rulePresetBlockLoopback": MessageLookupByLibrary.simpleMessage(
      "Block proxy loopback",
    ),
    "rulePresetBlockQuic": MessageLookupByLibrary.simpleMessage("Block QUIC"),
    "rulePresetBlockStun": MessageLookupByLibrary.simpleMessage("Block STUN"),
    "rulePresetInsertHint": MessageLookupByLibrary.simpleMessage(
      "Add selected presets before existing rules. Identical rules are not added again.",
    ),
    "rulePresetLanDirect": MessageLookupByLibrary.simpleMessage("LAN direct"),
    "rulePresetSystemServicesDirect": MessageLookupByLibrary.simpleMessage(
      "Apple and Microsoft direct",
    ),
    "ruleProviders": MessageLookupByLibrary.simpleMessage("Rule providers"),
    "ruleSetBusyTip": MessageLookupByLibrary.simpleMessage(
      "Another rule set operation is running. Try again shortly",
    ),
    "ruleSetConvert": MessageLookupByLibrary.simpleMessage("Convert to MRS"),
    "ruleSetConvertRemote": MessageLookupByLibrary.simpleMessage(
      "Download as local MRS",
    ),
    "ruleSetDetect": MessageLookupByLibrary.simpleMessage(
      "Detect format and behavior",
    ),
    "ruleSetEmptyTip": MessageLookupByLibrary.simpleMessage(
      "The rule set has no usable entries",
    ),
    "ruleSetInvalidTip": MessageLookupByLibrary.simpleMessage(
      "Unable to read this rule set. Check its format and entries",
    ),
    "ruleSetMixedTip": MessageLookupByLibrary.simpleMessage(
      "The rule set mixes bare domains and IP ranges; use classical rules to combine them",
    ),
    "ruleSetNeedsConversionTip": MessageLookupByLibrary.simpleMessage(
      "This remote rule set needs normalization. Download it as local MRS to use it",
    ),
    "ruleSetSizeTip": MessageLookupByLibrary.simpleMessage(
      "The rule set exceeds the processing limit. Split it into smaller sets",
    ),
    "ruleSetUnsupportedTip": MessageLookupByLibrary.simpleMessage(
      "These rules cannot be converted to MRS without changing their behavior",
    ),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("Rule target"),
    "rules": MessageLookupByLibrary.simpleMessage("Rules"),
    "rulesCount": m100,
    "rulesRequireRuleMode": MessageLookupByLibrary.simpleMessage(
      "Personal routing rules take effect in Rule mode.",
    ),
    "runTime": MessageLookupByLibrary.simpleMessage("Uptime"),
    "running": MessageLookupByLibrary.simpleMessage("Running"),
    "runtimeConfig": MessageLookupByLibrary.simpleMessage("Runtime config"),
    "safeMode": MessageLookupByLibrary.simpleMessage("Safe mode"),
    "safeModeAppTitle": m101,
    "saturation": MessageLookupByLibrary.simpleMessage("Saturation"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "saveAndRetry": MessageLookupByLibrary.simpleMessage("Save and retry"),
    "saveChanges": MessageLookupByLibrary.simpleMessage(
      "Do you want to save the changes?",
    ),
    "saveRoutingDraft": MessageLookupByLibrary.simpleMessage("Save draft"),
    "scanOrTransferPay": MessageLookupByLibrary.simpleMessage(
      "Scan / Transfer payment",
    ),
    "scanToPayNotice": MessageLookupByLibrary.simpleMessage(
      "Scan with Alipay / WeChat to pay",
    ),
    "script": MessageLookupByLibrary.simpleMessage("Script"),
    "scriptChanged": MessageLookupByLibrary.simpleMessage(
      "The script changed or was deleted. Reopen it and try again.",
    ),
    "scriptChanges": MessageLookupByLibrary.simpleMessage("Script changes"),
    "scriptChangesAdded": m102,
    "scriptChangesDescription": MessageLookupByLibrary.simpleMessage(
      "Top-level configuration fields added, modified or removed by the script. The full configuration also includes app settings.",
    ),
    "scriptChangesEmpty": MessageLookupByLibrary.simpleMessage(
      "The script did not change the configuration",
    ),
    "scriptChangesModified": m103,
    "scriptChangesRemoved": m104,
    "scriptFullConfig": MessageLookupByLibrary.simpleMessage("Full config"),
    "scriptModeDesc": MessageLookupByLibrary.simpleMessage(
      "Script mode, use external extension scripts, provide one-click override configuration capability",
    ),
    "scriptOptions": MessageLookupByLibrary.simpleMessage("Script options"),
    "scriptOptionsEmpty": MessageLookupByLibrary.simpleMessage(
      "This script does not expose configurable switches",
    ),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "seconds": MessageLookupByLibrary.simpleMessage("Seconds"),
    "secondsCount": m105,
    "secretKey": MessageLookupByLibrary.simpleMessage("Key"),
    "sectionsInEffect": m106,
    "select": MessageLookupByLibrary.simpleMessage("Select"),
    "selectAll": MessageLookupByLibrary.simpleMessage("Select all"),
    "selectBackup": MessageLookupByLibrary.simpleMessage("Select a backup"),
    "selectUpgradeTarget": MessageLookupByLibrary.simpleMessage(
      "Select upgrade target",
    ),
    "selected": MessageLookupByLibrary.simpleMessage("Selected"),
    "send": MessageLookupByLibrary.simpleMessage("Send"),
    "sendCode": MessageLookupByLibrary.simpleMessage("Send Code"),
    "sendFromPhone": MessageLookupByLibrary.simpleMessage("Send from phone"),
    "sendFromPhoneConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Import the link from your phone?",
    ),
    "sendFromPhoneDesc": MessageLookupByLibrary.simpleMessage(
      "Scan with your phone and send a link to this device",
    ),
    "sendFromPhoneNoNetwork": MessageLookupByLibrary.simpleMessage(
      "This device is not connected to a local network",
    ),
    "sendFromPhonePageHint": MessageLookupByLibrary.simpleMessage(
      "Subscription link or proxy share link",
    ),
    "sendFromPhonePageSent": MessageLookupByLibrary.simpleMessage(
      "Sent. Confirm the import on the other device.",
    ),
    "sendFromPhonePageTitle": MessageLookupByLibrary.simpleMessage(
      "Send a link to FlClash",
    ),
    "sendFromPhonePermissionDenied": MessageLookupByLibrary.simpleMessage(
      "Receiving a link from your phone needs the Nearby devices permission, which lets FlClash reach the local network. Turn it on in the app\'s settings.",
    ),
    "sendFromPhoneTip": MessageLookupByLibrary.simpleMessage(
      "Scan the code with your phone\'s camera and paste the link on the page that opens. Both devices need to be on the same network.",
    ),
    "sendResetEmail": MessageLookupByLibrary.simpleMessage("Send reset email"),
    "server": MessageLookupByLibrary.simpleMessage("Server"),
    "serviceCheckFailed": MessageLookupByLibrary.simpleMessage(
      "Service Check Failed",
    ),
    "serviceFailed": MessageLookupByLibrary.simpleMessage("Check failed"),
    "settingEntries": MessageLookupByLibrary.simpleMessage("settings"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "settingsCount": m107,
    "shareLinkNodesAdded": m108,
    "shareLinkNodesPreserved": m109,
    "shareLinksNotRead": m110,
    "shareQrcodeTip": MessageLookupByLibrary.simpleMessage(
      "Scan with FlClash on another device to import this profile.",
    ),
    "show": MessageLookupByLibrary.simpleMessage("Show"),
    "showLess": MessageLookupByLibrary.simpleMessage("Collapse"),
    "showMore": MessageLookupByLibrary.simpleMessage("Expand"),
    "showNotificationStopAction": MessageLookupByLibrary.simpleMessage(
      "Stop button in notification",
    ),
    "showPassword": MessageLookupByLibrary.simpleMessage("Show password"),
    "sidebarBlur": MessageLookupByLibrary.simpleMessage("Blur sidebar"),
    "sidebarBlurDesc": MessageLookupByLibrary.simpleMessage(
      "Show a translucent system backdrop behind the sidebar",
    ),
    "signInWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Sign in with Google",
    ),
    "silentLaunch": MessageLookupByLibrary.simpleMessage("Silent launch"),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Start in the background",
    ),
    "singleAdd": MessageLookupByLibrary.simpleMessage("Single add"),
    "singleValueTip": m111,
    "size": MessageLookupByLibrary.simpleMessage("Size"),
    "skipCertVerify": MessageLookupByLibrary.simpleMessage(
      "Skip certificate verification",
    ),
    "skipDomain": MessageLookupByLibrary.simpleMessage("Skip domains"),
    "skipDomainDesc": MessageLookupByLibrary.simpleMessage(
      "A sniffed domain on the Skip domains list is not used",
    ),
    "skipDstAddress": MessageLookupByLibrary.simpleMessage(
      "Skip destination addresses",
    ),
    "skipSrcAddress": MessageLookupByLibrary.simpleMessage(
      "Skip source addresses",
    ),
    "slide": MessageLookupByLibrary.simpleMessage("Slide"),
    "sliders": MessageLookupByLibrary.simpleMessage("Sliders"),
    "sniffProtocols": MessageLookupByLibrary.simpleMessage("Protocols"),
    "sniffer": MessageLookupByLibrary.simpleMessage("Sniffer"),
    "snifferStatusDesc": MessageLookupByLibrary.simpleMessage(
      "The sniffer reads the domain from TLS, HTTP and QUIC traffic so rules can match it",
    ),
    "socksPort": MessageLookupByLibrary.simpleMessage("SOCKS port"),
    "softStyle": MessageLookupByLibrary.simpleMessage("Soft"),
    "soldOut": MessageLookupByLibrary.simpleMessage("Sold out"),
    "sort": MessageLookupByLibrary.simpleMessage("Sort"),
    "source": MessageLookupByLibrary.simpleMessage("Source"),
    "sourceIp": MessageLookupByLibrary.simpleMessage("Source IP"),
    "specialProxy": MessageLookupByLibrary.simpleMessage("Special proxy"),
    "specialRules": MessageLookupByLibrary.simpleMessage("special rules"),
    "spectrum": MessageLookupByLibrary.simpleMessage("Spectrum"),
    "speedStatistics": MessageLookupByLibrary.simpleMessage("Speed statistics"),
    "ssidPermissionGuide": MessageLookupByLibrary.simpleMessage(
      "Allow location access to read Wi-Fi names. On Android, allow precise location all the time and enable system location services.",
    ),
    "ssidPermissionMacosGuide": MessageLookupByLibrary.simpleMessage(
      "Allow this app to use Location Services in System Settings to read Wi-Fi names.",
    ),
    "ssidsEmpty": MessageLookupByLibrary.simpleMessage("SSIDs are empty"),
    "stackMode": MessageLookupByLibrary.simpleMessage("Stack mode"),
    "stackTrace": MessageLookupByLibrary.simpleMessage("Stack trace"),
    "standard": MessageLookupByLibrary.simpleMessage("Standard"),
    "standardModeDesc": MessageLookupByLibrary.simpleMessage(
      "Standard mode, override basic configuration, provide simple rule addition capability",
    ),
    "start": MessageLookupByLibrary.simpleMessage("Start"),
    "startCorePromptContent": MessageLookupByLibrary.simpleMessage(
      "Profile has been successfully imported. Do you want to start the core now?",
    ),
    "startCorePromptTitle": MessageLookupByLibrary.simpleMessage("Prompt"),
    "startFromScratch": MessageLookupByLibrary.simpleMessage(
      "Start from scratch",
    ),
    "startSuccess": MessageLookupByLibrary.simpleMessage(
      "Started successfully",
    ),
    "startVpn": MessageLookupByLibrary.simpleMessage("Starting VPN..."),
    "startupAndBackground": MessageLookupByLibrary.simpleMessage(
      "Startup and background",
    ),
    "startupDiagnostics": MessageLookupByLibrary.simpleMessage(
      "Startup diagnostics",
    ),
    "startupRecoveryTip": MessageLookupByLibrary.simpleMessage(
      "The previous startup did not finish. Automatic configuration setup and VPN startup are paused for this launch. Your selected profile and settings are unchanged. Check the configuration and tap Start to retry; an already running VPN will stay connected.",
    ),
    "startupRecoveryTitle": MessageLookupByLibrary.simpleMessage(
      "Startup recovery",
    ),
    "startupTimeoutTip": MessageLookupByLibrary.simpleMessage(
      "Startup timed out. Quit and reopen the application. Copy the diagnostics below if the problem persists.",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "statusDesc": MessageLookupByLibrary.simpleMessage(
      "With DNS off, the system DNS is used",
    ),
    "stop": MessageLookupByLibrary.simpleMessage("Stop"),
    "stopVpn": MessageLookupByLibrary.simpleMessage("Stopping VPN..."),
    "store": MessageLookupByLibrary.simpleMessage("Store"),
    "storeOutcomeUnknown": MessageLookupByLibrary.simpleMessage(
      "The request may still have gone through. Check Purchased Plans before trying again.",
    ),
    "storeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Purchase, renew, and upgrade plans",
    ),
    "strategy": MessageLookupByLibrary.simpleMessage("Strategy"),
    "strictRoute": MessageLookupByLibrary.simpleMessage("Strict route"),
    "strictRouteDesc": MessageLookupByLibrary.simpleMessage(
      "Strict route keeps traffic such as DNS from bypassing TUN, and with IPv6 off it blocks this device\'s IPv6 connections",
    ),
    "style": MessageLookupByLibrary.simpleMessage("Style"),
    "subRule": MessageLookupByLibrary.simpleMessage("Sub rule"),
    "submit": MessageLookupByLibrary.simpleMessage("Submit"),
    "subscriptionInfo": MessageLookupByLibrary.simpleMessage(
      "Subscription info",
    ),
    "suspendOnIdle": MessageLookupByLibrary.simpleMessage(
      "Pause proxy when idle",
    ),
    "suspendOnIdleDesc": MessageLookupByLibrary.simpleMessage(
      "Pause proxy when idle stops traffic forwarding and health checks while the screen is off and the system is idle, which may disconnect calls and live audio and delay push notifications",
    ),
    "suspended": MessageLookupByLibrary.simpleMessage("Suspended…"),
    "switchProfile": MessageLookupByLibrary.simpleMessage("Switch profile"),
    "sync": MessageLookupByLibrary.simpleMessage("Sync"),
    "system": MessageLookupByLibrary.simpleMessage("System"),
    "systemApp": MessageLookupByLibrary.simpleMessage("System APP"),
    "systemProxy": MessageLookupByLibrary.simpleMessage("System proxy"),
    "systemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Attach HTTP proxy to VpnService",
    ),
    "tab": MessageLookupByLibrary.simpleMessage("Tab"),
    "tabAnimation": MessageLookupByLibrary.simpleMessage("Tab animation"),
    "tailscaleAccount": MessageLookupByLibrary.simpleMessage("Account"),
    "tailscaleAddNetwork": MessageLookupByLibrary.simpleMessage("Add network"),
    "tailscaleAdvanced": MessageLookupByLibrary.simpleMessage("Advanced"),
    "tailscaleAuthKey": MessageLookupByLibrary.simpleMessage("Auth key"),
    "tailscaleAuthKeyInvalid": MessageLookupByLibrary.simpleMessage(
      "This does not look like an auth key",
    ),
    "tailscaleAuthKeySaved": MessageLookupByLibrary.simpleMessage(
      "An auth key is saved on this device. Enter a new one to replace it.",
    ),
    "tailscaleAutoRoute": MessageLookupByLibrary.simpleMessage(
      "Automatic routing",
    ),
    "tailscaleAutoRouteDesc": MessageLookupByLibrary.simpleMessage(
      "Route peer addresses, MagicDNS names and approved subnets through this network",
    ),
    "tailscaleAvailableExitNodes": MessageLookupByLibrary.simpleMessage(
      "Available exit nodes",
    ),
    "tailscaleCheckSettings": m112,
    "tailscaleConnected": MessageLookupByLibrary.simpleMessage("Connected"),
    "tailscaleConnecting": MessageLookupByLibrary.simpleMessage("Connecting"),
    "tailscaleControlUrl": MessageLookupByLibrary.simpleMessage("Control URL"),
    "tailscaleCredentialsFooter": MessageLookupByLibrary.simpleMessage(
      "Authentication and device identity stay on this device.",
    ),
    "tailscaleDeviceName": MessageLookupByLibrary.simpleMessage("Device name"),
    "tailscaleDevices": m113,
    "tailscaleDirect": MessageLookupByLibrary.simpleMessage("Direct"),
    "tailscaleEmptyDesc": MessageLookupByLibrary.simpleMessage(
      "Add a network, sign in on this device, then start the proxy to reach your devices.",
    ),
    "tailscaleEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "Access your tailnet",
    ),
    "tailscaleEnterAuthKey": MessageLookupByLibrary.simpleMessage(
      "Enter the auth key to log in on this device.",
    ),
    "tailscaleEntryHint": MessageLookupByLibrary.simpleMessage(
      "Access the devices in your tailnet",
    ),
    "tailscaleExitNode": MessageLookupByLibrary.simpleMessage("Exit node"),
    "tailscaleExitNodeActive": MessageLookupByLibrary.simpleMessage(
      "Exit node in use",
    ),
    "tailscaleExitNodeAllowLan": MessageLookupByLibrary.simpleMessage(
      "Allow local network access",
    ),
    "tailscaleExitNodeDesc": MessageLookupByLibrary.simpleMessage(
      "Leave empty for none, or use auto, a peer name or a peer IP address.",
    ),
    "tailscaleGuide": MessageLookupByLibrary.simpleMessage("Guide"),
    "tailscaleGuideDevices": MessageLookupByLibrary.simpleMessage(
      "Devices and MagicDNS",
    ),
    "tailscaleGuideDevicesBody": MessageLookupByLibrary.simpleMessage(
      "Automatic routing sends the addresses and MagicDNS names of known peers, and the subnets approved in your tailnet, into this network. Other traffic follows your rules.\nIt applies after your added and custom rules and before the profile\'s own rules.\nWith a custom control server domain, only known device names are routed, so the domain\'s public sites stay reachable.\nSubnet addresses inside the local network this device is on stay local. To reach a remote subnet with the same addresses, add a rule that points to this network.\nA hostname that resolves into an approved subnet also goes through this network. If the profile hands such a name straight to a proxy, add a domain rule that points to this network.",
    ),
    "tailscaleGuideExitNodes": MessageLookupByLibrary.simpleMessage(
      "Exit nodes",
    ),
    "tailscaleGuideExitNodesBody": MessageLookupByLibrary.simpleMessage(
      "With an exit node, the network appears in the profile\'s selector groups. Traffic uses the exit node only after you select the network there or point a rule to it.\nLeave the field empty to use no exit node. auto picks an available exit node; a device name or address picks that device.",
    ),
    "tailscaleGuideGetStarted": MessageLookupByLibrary.simpleMessage(
      "Get started",
    ),
    "tailscaleGuideGetStartedBody": MessageLookupByLibrary.simpleMessage(
      "Add a network and choose \"Save and log in\". Open the login page and authorize this device; sign-in completes on its own.\nTo sign in with an auth key, choose \"Auth key\" and enter it. No browser is needed.\nThe network carries traffic only while the proxy runs. Signing in alone routes nothing.",
    ),
    "tailscaleGuideSignIn": MessageLookupByLibrary.simpleMessage(
      "Sign-in and backup",
    ),
    "tailscaleGuideSignInBody": MessageLookupByLibrary.simpleMessage(
      "Network settings are included in backups. Auth keys and the device identity stay on this device, so sign in again after restoring on another device.\nWhen the node key expires, choose \"Save and log in\" again. Device approval and access are managed in your tailnet.\nRemoving a network signs this device out and deletes its identity from this device.",
    ),
    "tailscaleGuideTroubleshooting": MessageLookupByLibrary.simpleMessage(
      "Troubleshooting",
    ),
    "tailscaleGuideTroubleshootingBody": MessageLookupByLibrary.simpleMessage(
      "Check that the proxy is running, this device is approved and the peer is online. For subnets or the Internet, also check route approval and the exit node.\n\"Not applied\" means the running configuration lacks the network: select a profile and make sure none of its nodes uses the same name.\nThis app only connects out to your tailnet. It accepts no inbound connections and never offers this device as a subnet router or exit node.",
    ),
    "tailscaleHostnameInvalid": MessageLookupByLibrary.simpleMessage(
      "Use lowercase letters, digits and hyphens, up to 63 characters",
    ),
    "tailscaleInteractiveLogin": MessageLookupByLibrary.simpleMessage(
      "Interactive",
    ),
    "tailscaleKeyExpired": MessageLookupByLibrary.simpleMessage(
      "Node key has expired",
    ),
    "tailscaleLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Tailscale login failed",
    ),
    "tailscaleLoginFooter": MessageLookupByLibrary.simpleMessage(
      "Sign in once per network on this device.",
    ),
    "tailscaleLoginHint": MessageLookupByLibrary.simpleMessage(
      "Signing in authorizes this device. Start the proxy to use the network.",
    ),
    "tailscaleLoginMethod": MessageLookupByLibrary.simpleMessage(
      "Login method",
    ),
    "tailscaleLoginTimeout": MessageLookupByLibrary.simpleMessage(
      "Sign-in was not completed within five minutes. Try again.",
    ),
    "tailscaleLoginWaiting": MessageLookupByLibrary.simpleMessage(
      "Open the login page or scan the code. Sign-in completes automatically after approval.",
    ),
    "tailscaleLogout": MessageLookupByLibrary.simpleMessage("Log out"),
    "tailscaleNameInUse": MessageLookupByLibrary.simpleMessage(
      "This name is already in use",
    ),
    "tailscaleNameInvalid": MessageLookupByLibrary.simpleMessage(
      "Use up to 64 characters without commas",
    ),
    "tailscaleNeedsApproval": MessageLookupByLibrary.simpleMessage(
      "Device approval is pending",
    ),
    "tailscaleNeedsLogin": MessageLookupByLibrary.simpleMessage(
      "Login required",
    ),
    "tailscaleNetworkInUse": m114,
    "tailscaleNetworkName": MessageLookupByLibrary.simpleMessage(
      "Network name",
    ),
    "tailscaleNetworks": MessageLookupByLibrary.simpleMessage("Networks"),
    "tailscaleNotApplied": MessageLookupByLibrary.simpleMessage("Not applied"),
    "tailscaleNotAppliedHint": MessageLookupByLibrary.simpleMessage(
      "The network is not part of the running configuration. Select a profile and make sure none of its nodes uses the same name.",
    ),
    "tailscaleNotSignedIn": MessageLookupByLibrary.simpleMessage(
      "Not signed in",
    ),
    "tailscaleOffline": MessageLookupByLibrary.simpleMessage("Offline"),
    "tailscaleOnline": MessageLookupByLibrary.simpleMessage("Online"),
    "tailscaleOpenLoginPage": MessageLookupByLibrary.simpleMessage(
      "Open login page",
    ),
    "tailscaleRelay": m115,
    "tailscaleRemoveConfirm": m116,
    "tailscaleRemoveNetwork": MessageLookupByLibrary.simpleMessage(
      "Remove network",
    ),
    "tailscaleSaveAndLogin": MessageLookupByLibrary.simpleMessage(
      "Save and log in",
    ),
    "tailscaleSignedIn": MessageLookupByLibrary.simpleMessage("Signed in"),
    "tailscaleSigningIn": MessageLookupByLibrary.simpleMessage("Signing in"),
    "tailscaleStatus": MessageLookupByLibrary.simpleMessage("Status"),
    "tailscaleStopped": MessageLookupByLibrary.simpleMessage("Stopped"),
    "tailscaleThisDevice": MessageLookupByLibrary.simpleMessage("This device"),
    "tailscaleUnavailable": MessageLookupByLibrary.simpleMessage(
      "Connection unavailable",
    ),
    "tapIconToRetry": MessageLookupByLibrary.simpleMessage(
      "Tap the icon to retry",
    ),
    "tapToAuthorize": MessageLookupByLibrary.simpleMessage("Tap to authorize"),
    "target": MessageLookupByLibrary.simpleMessage("Target"),
    "tcpConcurrent": MessageLookupByLibrary.simpleMessage("TCP concurrent"),
    "tcpConcurrentDesc": MessageLookupByLibrary.simpleMessage(
      "Enabling it will allow TCP concurrency",
    ),
    "tcpFastOpen": MessageLookupByLibrary.simpleMessage("TCP Fast Open"),
    "tcpFastOpenDesc": MessageLookupByLibrary.simpleMessage(
      "Enable this option to accelerate TCP connection establishment",
    ),
    "testInterval": MessageLookupByLibrary.simpleMessage("Test interval"),
    "testUrl": MessageLookupByLibrary.simpleMessage("Test URL"),
    "testWhenUsed": MessageLookupByLibrary.simpleMessage("Test when used"),
    "textScale": MessageLookupByLibrary.simpleMessage("Text Scaling"),
    "textScalePreview": MessageLookupByLibrary.simpleMessage(
      "Text in the app will look like this",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "themeColor": MessageLookupByLibrary.simpleMessage("Theme color"),
    "themeDesc": MessageLookupByLibrary.simpleMessage(
      "Set dark mode,adjust the color",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Theme mode"),
    "tight": MessageLookupByLibrary.simpleMessage("Tight"),
    "time": MessageLookupByLibrary.simpleMessage("Time"),
    "timeout": MessageLookupByLibrary.simpleMessage("Timeout"),
    "tintedStyle": MessageLookupByLibrary.simpleMessage("Tinted"),
    "tip": MessageLookupByLibrary.simpleMessage("tip"),
    "todayUsed": MessageLookupByLibrary.simpleMessage("Today\'s Usage"),
    "toggle": MessageLookupByLibrary.simpleMessage("Toggle"),
    "toggleFlashlight": MessageLookupByLibrary.simpleMessage(
      "Toggle flashlight",
    ),
    "tokenLabel": MessageLookupByLibrary.simpleMessage("Access Token"),
    "tokenValidation": MessageLookupByLibrary.simpleMessage(
      "Please enter Access Token",
    ),
    "tolerance": MessageLookupByLibrary.simpleMessage("Tolerance"),
    "tools": MessageLookupByLibrary.simpleMessage("Tools"),
    "total": MessageLookupByLibrary.simpleMessage("Total"),
    "totalDownload": MessageLookupByLibrary.simpleMessage("Downloaded"),
    "totalUpload": MessageLookupByLibrary.simpleMessage("Uploaded"),
    "tproxyPort": MessageLookupByLibrary.simpleMessage("TProxy port"),
    "traffic": MessageLookupByLibrary.simpleMessage("Traffic"),
    "trafficPeak": m117,
    "trafficTotal": m118,
    "trafficUsage": MessageLookupByLibrary.simpleMessage("Traffic usage"),
    "transferConfirmNotice": MessageLookupByLibrary.simpleMessage(
      "The system will confirm automatically after the transfer is completed, and the selected plan will be activated.",
    ),
    "transport": MessageLookupByLibrary.simpleMessage("Transport"),
    "transportHeaders": m119,
    "tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "tunAdminAccountRequired": MessageLookupByLibrary.simpleMessage(
      "TUN needs an administrator account on this Mac. Sign in with an administrator account to turn it on.",
    ),
    "tunAuthorizationFailed": MessageLookupByLibrary.simpleMessage(
      "TUN could not be enabled because administrator authorization was denied. Allow the system permission prompt and try again.",
    ),
    "tunDesc": MessageLookupByLibrary.simpleMessage(
      "TUN works only in administrator mode",
    ),
    "tunDnsMode": MessageLookupByLibrary.simpleMessage("System DNS mode"),
    "tunDnsModeDesc": MessageLookupByLibrary.simpleMessage(
      "Empty keeps the previous behavior. disabled leaves system DNS unchanged; native uses the TUN address; hijack also intercepts DNS on other interfaces (Windows requires strict-route; Linux requires auto-redirect). An explicit mode takes precedence over automatic system DNS on macOS.",
    ),
    "tunHelperInstallFailed": MessageLookupByLibrary.simpleMessage(
      "TUN could not be enabled: Helper installation or startup failed. Check that the app installation is complete and the system service is working, then try again.",
    ),
    "tunMtuDesc": MessageLookupByLibrary.simpleMessage(
      "Default: 9000; alternatives: 1480 or 4064. Restart the Android VPN to apply",
    ),
    "tunMtuInvalid": MessageLookupByLibrary.simpleMessage(
      "Enter an integer from 1280 to 65535",
    ),
    "tunOverrideDesc": MessageLookupByLibrary.simpleMessage(
      "Entries added here replace the TUN settings of every profile; anything not added keeps the profile\'s own setting. Entries a custom profile adds itself take precedence",
    ),
    "turnOff": MessageLookupByLibrary.simpleMessage("Turn Off"),
    "turnOn": MessageLookupByLibrary.simpleMessage("Turn On"),
    "udpRelayMode": MessageLookupByLibrary.simpleMessage("UDP relay mode"),
    "udpTimeout": MessageLookupByLibrary.simpleMessage("UDP timeout"),
    "udpTimeoutDesc": MessageLookupByLibrary.simpleMessage(
      "The UDP timeout is in seconds and works only with the gvisor, system and mixed stacks",
    ),
    "ultra": MessageLookupByLibrary.simpleMessage("Ultra"),
    "undo": MessageLookupByLibrary.simpleMessage("undo"),
    "unifiedDelay": MessageLookupByLibrary.simpleMessage("Unified delay"),
    "unifiedDelayDesc": MessageLookupByLibrary.simpleMessage(
      "Remove extra delays such as handshaking",
    ),
    "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
    "unknownNetworkError": MessageLookupByLibrary.simpleMessage(
      "Unknown network error",
    ),
    "unmaximize": MessageLookupByLibrary.simpleMessage("Restore down"),
    "unnamed": MessageLookupByLibrary.simpleMessage("Unnamed"),
    "unpinWindow": MessageLookupByLibrary.simpleMessage("Unpin window"),
    "update": MessageLookupByLibrary.simpleMessage("Update"),
    "updateAppImageTip": MessageLookupByLibrary.simpleMessage(
      "An AppImage cannot be installed automatically. Replace the running program with the downloaded file; its folder has been opened.",
    ),
    "updateApplyFailed": MessageLookupByLibrary.simpleMessage(
      "Automatic update did not complete. Retry or update from the download page.",
    ),
    "updateBuildNumber": m120,
    "updateCancelDownload": MessageLookupByLibrary.simpleMessage(
      "Cancel download",
    ),
    "updateDownloadBackground": MessageLookupByLibrary.simpleMessage(
      "Download in background",
    ),
    "updateDownloadBrowser": MessageLookupByLibrary.simpleMessage(
      "Download in browser",
    ),
    "updateDownloadConfirm": MessageLookupByLibrary.simpleMessage(
      "Download update",
    ),
    "updateDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Update download failed",
    ),
    "updateDownloading": MessageLookupByLibrary.simpleMessage(
      "Downloading update",
    ),
    "updateInstall": MessageLookupByLibrary.simpleMessage("Install update"),
    "updateLater": MessageLookupByLibrary.simpleMessage("Later"),
    "updateNotice": MessageLookupByLibrary.simpleMessage(
      "New version detected",
    ),
    "updatePackageFormat": MessageLookupByLibrary.simpleMessage(
      "Choose the package format",
    ),
    "updatePackageFormatTip": MessageLookupByLibrary.simpleMessage(
      "How this build was installed could not be determined. Pick the format that matches it.",
    ),
    "updatePackageManagerTip": MessageLookupByLibrary.simpleMessage(
      "This build was installed by a package manager; upgrade it the same way you installed it.",
    ),
    "updateReady": MessageLookupByLibrary.simpleMessage(
      "Update ready to install",
    ),
    "updateReadyHint": MessageLookupByLibrary.simpleMessage(
      "The update has been downloaded. Install when convenient.",
    ),
    "updateReleaseNotes": MessageLookupByLibrary.simpleMessage("Release notes"),
    "updateReleaseNotesFailed": MessageLookupByLibrary.simpleMessage(
      "Could not load release notes. Please try again.",
    ),
    "updateRestart": MessageLookupByLibrary.simpleMessage("Update and restart"),
    "updateRestartHint": MessageLookupByLibrary.simpleMessage(
      "The app will close, update in place, and reopen. Your settings will be preserved.",
    ),
    "updateVersionNumber": m121,
    "upgradePlan": MessageLookupByLibrary.simpleMessage("Upgrade plan"),
    "upload": MessageLookupByLibrary.simpleMessage("Upload"),
    "uploadBandwidth": MessageLookupByLibrary.simpleMessage("Upload bandwidth"),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage(
      "Obtain profile through URL",
    ),
    "urlTip": m122,
    "useHosts": MessageLookupByLibrary.simpleMessage("Use hosts"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage("Use system hosts"),
    "usedShort": MessageLookupByLibrary.simpleMessage("used"),
    "usedTrafficLabel": MessageLookupByLibrary.simpleMessage("Used traffic"),
    "userAgent": MessageLookupByLibrary.simpleMessage("User-Agent"),
    "userCenter": MessageLookupByLibrary.simpleMessage("User Center"),
    "userCenterFallback": MessageLookupByLibrary.simpleMessage(
      "User Center (Backup)",
    ),
    "userGuide": MessageLookupByLibrary.simpleMessage("User Guide"),
    "username": MessageLookupByLibrary.simpleMessage("Username"),
    "value": MessageLookupByLibrary.simpleMessage("Value"),
    "verifyCoupon": MessageLookupByLibrary.simpleMessage("Verify"),
    "view": MessageLookupByLibrary.simpleMessage("View"),
    "virtualIpv4": MessageLookupByLibrary.simpleMessage("Virtual IPv4"),
    "vividStyle": MessageLookupByLibrary.simpleMessage("Vivid"),
    "vpnConfigChangeDetected": MessageLookupByLibrary.simpleMessage(
      "VPN configuration change detected",
    ),
    "vpnEnableDesc": MessageLookupByLibrary.simpleMessage(
      "VPN routes all system traffic through VpnService automatically",
    ),
    "vpnTip": MessageLookupByLibrary.simpleMessage(
      "Changes take effect after restarting the VPN",
    ),
    "webDAVConfiguration": MessageLookupByLibrary.simpleMessage(
      "WebDAV configuration",
    ),
    "whitelistMode": MessageLookupByLibrary.simpleMessage("Whitelist mode"),
    "writeToSystem": MessageLookupByLibrary.simpleMessage("Write to system"),
    "writeToSystemDesc": MessageLookupByLibrary.simpleMessage(
      "Write to system also sets the system clock; Android ignores it",
    ),
    "yearsAgo": m123,
    "yearsAgoShort": m124,
    "yes": MessageLookupByLibrary.simpleMessage("Yes"),
    "zh_CN": MessageLookupByLibrary.simpleMessage("Simplified Chinese"),
  };
}

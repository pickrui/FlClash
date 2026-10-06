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

  static String m1(status) => "Server returned HTTP ${status}";

  static String m2(error) => "Direct: ${error}";

  static String m3(error) => "Local proxy: ${error}";

  static String m4(code) => "System error ${code}";

  static String m5(value) => "Commission ${value}";

  static String m6(line) =>
      "The configuration format is invalid at line ${line}.";

  static String m7(expected, actual) =>
      "Expected ${expected}, but found ${actual}.";

  static String m8(code) =>
      "Windows blocked the proxy core from starting (system error ${code}). Check Protection history in Windows Security and your app control policy, and verify the installer source and signature.";

  static String m9(name) =>
      "${name} is still referenced by a group, rule, or proxy chain";

  static String m10(example) =>
      "Check the content for this rule type. Example: ${example}";

  static String m11(name) =>
      "${name} is unavailable. Choose an existing rule provider.";

  static String m12(name) =>
      "${name} is unavailable. Choose a target from this configuration.";

  static String m13(count) =>
      "${Intl.plural(count, one: '1 day ago', other: '${count} days ago')}";

  static String m14(label) =>
      "Are you sure you want to delete the selected ${label}?";

  static String m15(label) =>
      "Are you sure you want to delete the current ${label}?";

  static String m16(label) => "${label} details";

  static String m17(count) => "${count} of 2 independent HTTPS checks passed";

  static String m18(label) => "${label} cannot be empty";

  static String m19(count) => "${count} entries";

  static String m20(label) => "Current ${label} already exists";

  static String m21(date) => "Expires: ${date}";

  static String m22(name) => "${name} skipped";

  static String m23(name) => "${name} updated";

  static String m24(name) => "Updating ${name}...";

  static String m25(name) =>
      "Circular group reference: ${name}. Choose a different member.";

  static String m26(count) =>
      "${Intl.plural(count, one: '1 hour ago', other: '${count} hours ago')}";

  static String m27(count) => "${count} hours";

  static String m28(target) => "${target} is an invalid policy";

  static String m29(ruleSet) => "${ruleSet} is an invalid rule set";

  static String m30(subRule) => "${subRule} is an invalid SUB_RULE";

  static String m31(appName) =>
      "1. Open System Settings > Privacy & Security\n2. Choose Location Services\n3. Find and check ${appName} in the list\n\nWhen you are done, return to the app to continue. Thank you for your cooperation.";

  static String m32(size) => "Released ${size}";

  static String m33(count) =>
      "${Intl.plural(count, one: '1 minute ago', other: '${count} minutes ago')}";

  static String m34(count) =>
      "${Intl.plural(count, one: '1 month ago', other: '${count} months ago')}";

  static String m35(code) =>
      "The server denied access (HTTP ${code}). The link may have expired, or the credentials are wrong";

  static String m36(code) => "The server rejected the request (HTTP ${code})";

  static String m37(code) =>
      "Nothing was found at this address (HTTP ${code}). Check that the URL is correct";

  static String m38(detail) => "Network request failed: ${detail}";

  static String m39(code) =>
      "The server ran into a problem (HTTP ${code}). Try again later";

  static String m40(kept, total) => "${kept} of ${total} nodes kept";

  static String m41(name) => "${name}, excluded";

  static String m42(name) => "${name}, kept";

  static String m43(label) => "No ${label} yet";

  static String m44(label) => "${label} must be a number";

  static String m45(name) =>
      "The name \"${name}\" is already used. Rename the personal group to keep both.";

  static String m46(name) =>
      "The name ${name} is already used by another proxy or proxy group";

  static String m47(path) =>
      "Proxy groups reference each other in a loop: ${path}";

  static String m48(names) => "These proxy providers do not exist: ${names}";

  static String m49(names) =>
      "These proxies or policies do not exist: ${names}";

  static String m50(name) =>
      "${name} is a built-in policy name and cannot be used here";

  static String m51(id) => "Plan #${id}";

  static String m52(port) => "Suggested port ${port} has been filled in.";

  static String m53(label) => "${label} must be between 1024 and 49151";

  static String m54(port) =>
      "The mixed port ${port} could not start listening and may be in use by another application. Change the port to retry immediately.";

  static String m55(profiles) => "This resource is still used by ${profiles}";

  static String m56(profiles) =>
      "Renaming would change subscription resource references in ${profiles}";

  static String m57(profiles) =>
      "Edit references in the source profile before renaming: ${profiles}";

  static String m58(profiles) =>
      "Cannot read these profiles to check references: ${profiles}";

  static String m59(name) =>
      "Node ${name} is already used by another enabled chain or has a proxy chain relation conflict";

  static String m60(name) => "Node ${name} is not available in this position";

  static String m61(address) =>
      "Before starting, the system proxy pointed to ${address}.";

  static String m62(name) =>
      "Before starting, traffic was routed through another VPN or virtual adapter: ${name}.";

  static String m63(count) => "${count}d";

  static String m64(count) => "${count}h";

  static String m65(count) => "${count}m";

  static String m66(time) => "Purchased ${time}";

  static String m67(name, path) =>
      "${name} is referenced by the original configuration at ${path}";

  static String m68(min, max) => "Allowed range ${min} – ${max}";

  static String m69(value) => "Remaining: ${value}";

  static String m70(count) => "Only ${count} left";

  static String m71(seconds) => "Resend in ${seconds}s";

  static String m72(appName) => "${appName} (Safe mode)";

  static String m73(count) => "${count} seconds";

  static String m74(fields) => "Check these settings: ${fields}";

  static String m75(count) => "Devices (${count})";

  static String m76(name, profile) =>
      "${name} is still used by a rule or group in profile ${profile}";

  static String m77(region) => "Relay ${region}";

  static String m78(name) =>
      "This device will leave ${name} and its sign-in will be deleted from this device. If the network is unreachable now, remove the device in the Tailscale admin console.";

  static String m79(build) => "Build: ${build}";

  static String m80(version) => "Version: ${version}";

  static String m81(label) => "${label} must be a url";

  static String m82(count) =>
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
    "allServices": MessageLookupByLibrary.simpleMessage("All services"),
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
      "Append System DNS",
    ),
    "appendSystemDnsTip": MessageLookupByLibrary.simpleMessage(
      "Forcefully append system DNS to the configuration",
    ),
    "application": MessageLookupByLibrary.simpleMessage("Application"),
    "applicationDesc": MessageLookupByLibrary.simpleMessage(
      "Modify application related settings",
    ),
    "authentication": MessageLookupByLibrary.simpleMessage(
      "Local proxy authentication",
    ),
    "authenticationApplyFailed": MessageLookupByLibrary.simpleMessage(
      "Could not apply authentication settings",
    ),
    "authenticationDesc": MessageLookupByLibrary.simpleMessage(
      "Require a username and password for HTTP/SOCKS proxies. Automatic system HTTP proxy is suspended; TUN/VPN remains available.",
    ),
    "authenticationPasswordInvalid": MessageLookupByLibrary.simpleMessage(
      "Use 1–255 UTF-8 bytes, without control characters",
    ),
    "authenticationSystemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Not applied while local proxy authentication is enabled",
    ),
    "authenticationUsernameInvalid": MessageLookupByLibrary.simpleMessage(
      "Use 1–255 UTF-8 bytes, without colons or control characters",
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
    "availableBalance": m0,
    "availablePlans": MessageLookupByLibrary.simpleMessage("Choose a Plan"),
    "backup": MessageLookupByLibrary.simpleMessage("Backup"),
    "backupAndRestore": MessageLookupByLibrary.simpleMessage(
      "Backup and Restore",
    ),
    "backupAndRestoreDesc": MessageLookupByLibrary.simpleMessage(
      "Sync data via WebDAV or files",
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
    "basicConfig": MessageLookupByLibrary.simpleMessage("Basic configuration"),
    "basicConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Modify the basic configuration globally",
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
      "Reject STUN traffic to reduce WebRTC IP leaks. Calls and live audio may stop working.",
    ),
    "buy": MessageLookupByLibrary.simpleMessage("Buy"),
    "bypassDomain": MessageLookupByLibrary.simpleMessage("Bypass domain"),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Only takes effect when the system proxy is enabled",
    ),
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "The cache is corrupt. Do you want to clear it?",
    ),
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
    "clearCustomRouting": MessageLookupByLibrary.simpleMessage("Clear all"),
    "clearData": MessageLookupByLibrary.simpleMessage("Clear Data"),
    "clearProxyChain": MessageLookupByLibrary.simpleMessage(
      "Clear chain config",
    ),
    "clipboardExport": MessageLookupByLibrary.simpleMessage("Export clipboard"),
    "clipboardImport": MessageLookupByLibrary.simpleMessage("Clipboard import"),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
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
    "cloudApiHttpError": m1,
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
    "cloudApiRouteDirect": m2,
    "cloudApiRouteProxy": m3,
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
    "cloudApiSystemError": m4,
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
    "color": MessageLookupByLibrary.simpleMessage("Color"),
    "colorSchemes": MessageLookupByLibrary.simpleMessage("Color schemes"),
    "columns": MessageLookupByLibrary.simpleMessage("Columns"),
    "commission": MessageLookupByLibrary.simpleMessage("Commission"),
    "commissionBalance": m5,
    "compatible": MessageLookupByLibrary.simpleMessage("Compatibility mode"),
    "configDataDetected": MessageLookupByLibrary.simpleMessage(
      "Data detected in configuration",
    ),
    "configParseErrorAtLine": m6,
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
    "configTypeMismatch": m7,
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
    "coreBlockedByPolicyTip": m8,
    "coreStatus": MessageLookupByLibrary.simpleMessage("Core status"),
    "crashTest": MessageLookupByLibrary.simpleMessage("Crash test"),
    "create": MessageLookupByLibrary.simpleMessage("Create"),
    "creationTime": MessageLookupByLibrary.simpleMessage("Creation time"),
    "currentRoute": MessageLookupByLibrary.simpleMessage(
      "Current routing rules",
    ),
    "custom": MessageLookupByLibrary.simpleMessage("Custom"),
    "customOutboundInUse": m9,
    "customRoutingDraftHint": MessageLookupByLibrary.simpleMessage(
      "Fill in your custom routing, then switch to Custom mode. Editing this draft does not change the current mode.",
    ),
    "customRuleChooseProvider": MessageLookupByLibrary.simpleMessage(
      "Choose a rule provider",
    ),
    "customRuleChooseTarget": MessageLookupByLibrary.simpleMessage(
      "Choose a target",
    ),
    "customRuleDomainSuffixHint": MessageLookupByLibrary.simpleMessage(
      "Matches this domain and its subdomains. Enter a domain without https:// or a path.",
    ),
    "customRuleForm": MessageLookupByLibrary.simpleMessage("Form"),
    "customRuleFormUnavailable": MessageLookupByLibrary.simpleMessage(
      "This rule uses advanced syntax. Edit the rule text to preserve all options.",
    ),
    "customRuleInvalidContent": m10,
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
    "customRuleUnavailableProvider": m11,
    "customRuleUnavailableTarget": m12,
    "customUserAgent": MessageLookupByLibrary.simpleMessage(
      "Custom (enter manually)",
    ),
    "customUserAgentHint": MessageLookupByLibrary.simpleMessage(
      "Enter the full User-Agent value",
    ),
    "customUserAgentInvalid": MessageLookupByLibrary.simpleMessage(
      "Use only English letters, numbers, spaces, and standard punctuation",
    ),
    "cut": MessageLookupByLibrary.simpleMessage("Cut"),
    "dark": MessageLookupByLibrary.simpleMessage("Dark"),
    "dashboard": MessageLookupByLibrary.simpleMessage("Dashboard"),
    "daysAgo": m13,
    "defaultNameserver": MessageLookupByLibrary.simpleMessage(
      "Default nameserver",
    ),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "For resolving DNS server",
    ),
    "defaultText": MessageLookupByLibrary.simpleMessage("Default"),
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
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteBackupTip": MessageLookupByLibrary.simpleMessage(
      "Delete this backup from WebDAV?",
    ),
    "deleteMultipTip": m14,
    "deleteTip": m15,
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
    "details": m16,
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
      "Check for a port conflict or a stopped listener. Restart the connection; if needed, change the mixed port in network settings.",
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
    "diagProxyDifferent": MessageLookupByLibrary.simpleMessage(
      "The OS proxy does not match the app port",
    ),
    "diagProxyDisabled": MessageLookupByLibrary.simpleMessage(
      "The app requested a system proxy, but the OS reports it disabled",
    ),
    "diagProxyHint": MessageLookupByLibrary.simpleMessage(
      "Toggle the system proxy again and check whether another proxy app or an organization policy controls these settings. Some apps use their own proxy settings.",
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
    "diagRun": MessageLookupByLibrary.simpleMessage("Run self-check"),
    "diagScope": MessageLookupByLibrary.simpleMessage(
      "Checks the current connection using a small sample. The system network path may also pass through TUN. Results do not cover every app or node.",
    ),
    "diagSkipped": MessageLookupByLibrary.simpleMessage("Skipped"),
    "diagSuspended": MessageLookupByLibrary.simpleMessage(
      "Traffic forwarding is paused by the current Wi-Fi exclusion setting",
    ),
    "diagSystemDns": MessageLookupByLibrary.simpleMessage("System DNS"),
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
    "diagWebResult": m17,
    "direct": MessageLookupByLibrary.simpleMessage("Direct"),
    "disableUDP": MessageLookupByLibrary.simpleMessage("Disable UDP"),
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
    "dnsHijacking": MessageLookupByLibrary.simpleMessage("DNS hijacking"),
    "dnsMode": MessageLookupByLibrary.simpleMessage("DNS mode"),
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
    "documentCenter": MessageLookupByLibrary.simpleMessage("Document Center"),
    "domain": MessageLookupByLibrary.simpleMessage("Domain"),
    "download": MessageLookupByLibrary.simpleMessage("Download"),
    "dynamicMembersHint": MessageLookupByLibrary.simpleMessage(
      "Automatically include nodes from this configuration as the subscription updates. Use a name filter, such as Japan|JP.",
    ),
    "edit": MessageLookupByLibrary.simpleMessage("Edit"),
    "editCustomRouting": MessageLookupByLibrary.simpleMessage(
      "Edit custom routing",
    ),
    "editGlobalRules": MessageLookupByLibrary.simpleMessage(
      "Edit global rules",
    ),
    "editProfile": MessageLookupByLibrary.simpleMessage("Edit Profile"),
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
    "emptyCustomOverwrite": MessageLookupByLibrary.simpleMessage(
      "Custom override is empty. Use Quick fill or add rules and proxy groups first. To keep subscription content, use Overlay mode.",
    ),
    "emptyTip": m18,
    "en": MessageLookupByLibrary.simpleMessage("English"),
    "enableAutoRenew": MessageLookupByLibrary.simpleMessage(
      "Enable auto-renew",
    ),
    "entries": MessageLookupByLibrary.simpleMessage(" entries"),
    "entriesCount": m19,
    "exclude": MessageLookupByLibrary.simpleMessage("Hidden from recent tasks"),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "When the app is in the background, the app is hidden from the recent task",
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
    "excludeSsids": MessageLookupByLibrary.simpleMessage("Exclude SSIDs"),
    "excludeSsidsDesc": MessageLookupByLibrary.simpleMessage(
      "Pause proxying on the listed Wi-Fi networks; resume after leaving only while the app remains started.",
    ),
    "excludeType": MessageLookupByLibrary.simpleMessage("Exclude type"),
    "existsTip": m20,
    "exit": MessageLookupByLibrary.simpleMessage("Exit"),
    "exitFullScreen": MessageLookupByLibrary.simpleMessage("Exit full screen"),
    "expand": MessageLookupByLibrary.simpleMessage("Standard"),
    "expectedStatus": MessageLookupByLibrary.simpleMessage("Expected status"),
    "expireDate": m21,
    "expiresAtLabel": MessageLookupByLibrary.simpleMessage("Expires at"),
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
    "floatingNavigationBar": MessageLookupByLibrary.simpleMessage(
      "Floating navigation",
    ),
    "floatingNavigationBarDesc": MessageLookupByLibrary.simpleMessage(
      "Use a floating dock for compact layouts",
    ),
    "followProfile": MessageLookupByLibrary.simpleMessage("Follow profile"),
    "fontFamily": MessageLookupByLibrary.simpleMessage("FontFamily"),
    "forceRestartCoreTip": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to force restart the core?",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "format": MessageLookupByLibrary.simpleMessage("Format"),
    "fruitSaladScheme": MessageLookupByLibrary.simpleMessage("FruitSalad"),
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
    "geoInvalidDownloadUrl": MessageLookupByLibrary.simpleMessage(
      "Enter a valid HTTP or HTTPS URL",
    ),
    "geoOptions": MessageLookupByLibrary.simpleMessage("Geo Options"),
    "geoOriginalSource": MessageLookupByLibrary.simpleMessage(
      "Current address",
    ),
    "geoResources": MessageLookupByLibrary.simpleMessage("Geo Resources"),
    "geoSkipped": m22,
    "geoUpdated": m23,
    "geoUpdating": m24,
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
    "groupCycleError": m25,
    "groupFilterHint": MessageLookupByLibrary.simpleMessage(
      "Filters automatically included and provider nodes. Manually selected members are always kept.",
    ),
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
    "haveAccountAlready": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
    ),
    "hide": MessageLookupByLibrary.simpleMessage("Hide"),
    "hideFromList": MessageLookupByLibrary.simpleMessage("Hide from list"),
    "hideIp": MessageLookupByLibrary.simpleMessage("Hide IP"),
    "hideTimeoutProxies": MessageLookupByLibrary.simpleMessage(
      "Hide failed nodes",
    ),
    "hideTimeoutProxiesDesc": MessageLookupByLibrary.simpleMessage(
      "Keep the selected node and nodes that have not finished testing",
    ),
    "host": MessageLookupByLibrary.simpleMessage("Host"),
    "hostsDesc": MessageLookupByLibrary.simpleMessage("Add Hosts"),
    "hotkeyConflict": MessageLookupByLibrary.simpleMessage("Hotkey conflict"),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage(
      "Hotkey Management",
    ),
    "hotkeyManagementDesc": MessageLookupByLibrary.simpleMessage(
      "Use keyboard to control applications",
    ),
    "hotkeyUnavailable": MessageLookupByLibrary.simpleMessage(
      "Shortcut unavailable",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("Hours"),
    "hoursAgo": m26,
    "hoursCount": m27,
    "iHavePaid": MessageLookupByLibrary.simpleMessage("I have paid"),
    "icon": MessageLookupByLibrary.simpleMessage("Icon"),
    "iconHistory": MessageLookupByLibrary.simpleMessage("Recent icons"),
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
    "invalidPolicy": m28,
    "invalidProfileQrcode": MessageLookupByLibrary.simpleMessage(
      "This QR code doesn\'t contain a profile link",
    ),
    "invalidRuleSet": m29,
    "invalidSubRule": m30,
    "inviteCodeHint": MessageLookupByLibrary.simpleMessage("Enter invite code"),
    "inviteCodeLabel": MessageLookupByLibrary.simpleMessage("Invite Code"),
    "inviteCodeValidation": MessageLookupByLibrary.simpleMessage(
      "Please enter the invite code",
    ),
    "ipAsn": MessageLookupByLibrary.simpleMessage("ASN"),
    "ipFlagAbuser": MessageLookupByLibrary.simpleMessage("Abuse history"),
    "ipFlagNo": MessageLookupByLibrary.simpleMessage("No"),
    "ipFlagProxy": MessageLookupByLibrary.simpleMessage("Proxy"),
    "ipFlagTor": MessageLookupByLibrary.simpleMessage("Tor"),
    "ipFlagVpn": MessageLookupByLibrary.simpleMessage("VPN"),
    "ipFlagYes": MessageLookupByLibrary.simpleMessage("Yes"),
    "ipFlags": MessageLookupByLibrary.simpleMessage("Flags"),
    "ipOrganization": MessageLookupByLibrary.simpleMessage("Organization"),
    "ipQualityDetails": MessageLookupByLibrary.simpleMessage("IP quality"),
    "ipQualityFailed": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t determine the IP type",
    ),
    "ipQualityGood": MessageLookupByLibrary.simpleMessage("Good"),
    "ipQualityLevel": MessageLookupByLibrary.simpleMessage("Level"),
    "ipQualityNormal": MessageLookupByLibrary.simpleMessage("Normal"),
    "ipQualityQueryHint": MessageLookupByLibrary.simpleMessage(
      "Queries IPQuery, IPLocate, ipapi.is and proxycheck.io when tapped",
    ),
    "ipQualityRetry": MessageLookupByLibrary.simpleMessage("Check again"),
    "ipQualityRisky": MessageLookupByLibrary.simpleMessage("Risky"),
    "ipQualitySource": MessageLookupByLibrary.simpleMessage("Answered by"),
    "ipQualitySources": MessageLookupByLibrary.simpleMessage("Sources"),
    "ipSourceIpMismatch": MessageLookupByLibrary.simpleMessage(
      "Different outbound IP",
    ),
    "ipSourceNoType": MessageLookupByLibrary.simpleMessage("No type"),
    "ipSourceRateLimited": MessageLookupByLibrary.simpleMessage("Rate limited"),
    "ipType": MessageLookupByLibrary.simpleMessage("Type"),
    "ipTypeBusiness": MessageLookupByLibrary.simpleMessage("Business"),
    "ipTypeHosting": MessageLookupByLibrary.simpleMessage("Data center"),
    "ipTypeInferred": MessageLookupByLibrary.simpleMessage("Inferred"),
    "ipTypeMobile": MessageLookupByLibrary.simpleMessage("Mobile network"),
    "ipTypeResidential": MessageLookupByLibrary.simpleMessage("Residential"),
    "ipTypeUnknown": MessageLookupByLibrary.simpleMessage("Unknown"),
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
    "localNetworkTip": MessageLookupByLibrary.simpleMessage(
      "Local network access denied; using gVisor for this connection. LAN proxies and services may remain unavailable",
    ),
    "locationPermission": MessageLookupByLibrary.simpleMessage(
      "Location permission",
    ),
    "locationPermissionDeniedMessage": MessageLookupByLibrary.simpleMessage(
      "Location permission was denied, so the current Wi-Fi name cannot be read. Please enable location permission manually in system settings.",
    ),
    "locationPermissionGuide": m31,
    "locationPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Location permission required",
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
    "logoutContent": MessageLookupByLibrary.simpleMessage("Sign out?"),
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
    "manageServices": MessageLookupByLibrary.simpleMessage("Manage services"),
    "manageUserAgents": MessageLookupByLibrary.simpleMessage("Manage list"),
    "matchTarget": MessageLookupByLibrary.simpleMessage("MATCH-TARGET"),
    "matchTargetDesc": MessageLookupByLibrary.simpleMessage(
      "Where rules targeting MATCH-TARGET go. Defaults to the target of the final MATCH rule in this profile.",
    ),
    "matchTargetTitle": MessageLookupByLibrary.simpleMessage("Match target"),
    "maxFailedTimes": MessageLookupByLibrary.simpleMessage("Max failed times"),
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
    "memoryReleased": MessageLookupByLibrary.simpleMessage("Memory released"),
    "memoryReleasedSize": m32,
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
    "minimize": MessageLookupByLibrary.simpleMessage("Minimize"),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage("Minimize on exit"),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "Modify the default system exit event",
    ),
    "minutesAgo": m33,
    "mipsStackDesc": MessageLookupByLibrary.simpleMessage(
      "Low-memory userspace stack; throughput may drop on high-latency links",
    ),
    "mixedPort": MessageLookupByLibrary.simpleMessage("Mixed Port"),
    "mode": MessageLookupByLibrary.simpleMessage("Mode"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("Monochrome"),
    "monthsAgo": m34,
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
    "networkAccessDeniedError": m35,
    "networkBadResponseError": m36,
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
    "networkNotFoundError": m37,
    "networkRateLimitedError": MessageLookupByLibrary.simpleMessage(
      "Too many requests (HTTP 429). Wait a moment and try again",
    ),
    "networkRequestFailed": m38,
    "networkServerError": m39,
    "networkSpeed": MessageLookupByLibrary.simpleMessage("Network speed"),
    "networkTimeoutError": MessageLookupByLibrary.simpleMessage(
      "The request timed out. Check your network or proxy, then try again",
    ),
    "networkTlsError": MessageLookupByLibrary.simpleMessage(
      "Secure connection failed. The server\'s certificate may be invalid, or the connection is being intercepted",
    ),
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
    "noRemoteBackup": MessageLookupByLibrary.simpleMessage(
      "No backups on WebDAV",
    ),
    "noResolve": MessageLookupByLibrary.simpleMessage("No resolve IP"),
    "noSearchResult": MessageLookupByLibrary.simpleMessage(
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
    "nodeFilterKept": m40,
    "nodeFilterLines": MessageLookupByLibrary.simpleMessage("Lines"),
    "nodeFilterNameContains": MessageLookupByLibrary.simpleMessage(
      "Name contains",
    ),
    "nodeFilterNameExcludes": MessageLookupByLibrary.simpleMessage(
      "Name excludes",
    ),
    "nodeFilterNodeExcluded": m41,
    "nodeFilterNodeKept": m42,
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
    "none": MessageLookupByLibrary.simpleMessage("none"),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "The current proxy group cannot be selected.",
    ),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "No profile, Please add a profile",
    ),
    "nullTip": m43,
    "numberTip": m44,
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
    "options": MessageLookupByLibrary.simpleMessage("Options"),
    "other": MessageLookupByLibrary.simpleMessage("Other"),
    "outboundIp": MessageLookupByLibrary.simpleMessage("Outbound IP"),
    "outboundMode": MessageLookupByLibrary.simpleMessage("Outbound mode"),
    "outboundUnavailable": MessageLookupByLibrary.simpleMessage(
      "Unavailable in this configuration. Remove or replace it.",
    ),
    "overlayHint": MessageLookupByLibrary.simpleMessage(
      "Saved separately from the subscription and reapplied after updates. New groups block connections when no members match.",
    ),
    "overlayNameConflict": m45,
    "override": MessageLookupByLibrary.simpleMessage("Override"),
    "overrideDns": MessageLookupByLibrary.simpleMessage("Override Dns"),
    "overrideDnsDesc": MessageLookupByLibrary.simpleMessage(
      "Only the selected fields override the profile; other values are inherited",
    ),
    "overrideFieldsDesc": MessageLookupByLibrary.simpleMessage(
      "Only the selected fields override the profile; other values are inherited",
    ),
    "overrideFieldsEmpty": MessageLookupByLibrary.simpleMessage(
      "Add fields to override, or edit the YAML fragment",
    ),
    "overrideMode": MessageLookupByLibrary.simpleMessage("Override mode"),
    "overrideNtp": MessageLookupByLibrary.simpleMessage("Override NTP"),
    "overrideScript": MessageLookupByLibrary.simpleMessage("Override script"),
    "overwriteIssueDuplicateName": m46,
    "overwriteIssueEmptyName": MessageLookupByLibrary.simpleMessage(
      "The name is empty",
    ),
    "overwriteIssueGroupLoop": m47,
    "overwriteIssueMissingProviders": m48,
    "overwriteIssueMissingProxies": m49,
    "overwriteIssueNoProxySource": MessageLookupByLibrary.simpleMessage(
      "No proxies or proxy providers are selected, so the core rejects this group",
    ),
    "overwriteIssueReservedName": m50,
    "overwriteTypeCustom": MessageLookupByLibrary.simpleMessage("Custom"),
    "overwriteTypeCustomDesc": MessageLookupByLibrary.simpleMessage(
      "Custom mode, fully customize proxy groups and rules",
    ),
    "overwriteTypeMerge": MessageLookupByLibrary.simpleMessage("Overlay"),
    "overwriteTypeMergeDesc": MessageLookupByLibrary.simpleMessage(
      "Keep subscription rules and groups, then add your own. Personal rules take priority over subscription rules; existing added rules keep their priority.",
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
    "pauseUpdates": MessageLookupByLibrary.simpleMessage("Pause updates"),
    "payWithBalance": MessageLookupByLibrary.simpleMessage("Pay with balance"),
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
    "personalRouting": MessageLookupByLibrary.simpleMessage("Personal routing"),
    "pickFromAlbum": MessageLookupByLibrary.simpleMessage("Choose from album"),
    "pinWindow": MessageLookupByLibrary.simpleMessage("Pin window"),
    "planEnded": MessageLookupByLibrary.simpleMessage("Ended"),
    "planInUse": MessageLookupByLibrary.simpleMessage("In use"),
    "planNotActivated": MessageLookupByLibrary.simpleMessage(
      "Pending activation",
    ),
    "planNumber": m51,
    "planUnavailable": MessageLookupByLibrary.simpleMessage("Unavailable"),
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
    "portProxyAppTip": MessageLookupByLibrary.simpleMessage(
      "If another proxy app is running, close it first.",
    ),
    "portSuggestionTip": m52,
    "portTip": m53,
    "portUnavailableMessage": m54,
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
    "providerInUse": m55,
    "providerLocal": MessageLookupByLibrary.simpleMessage("Local file"),
    "providerNameInvalid": MessageLookupByLibrary.simpleMessage(
      "Enter a name without commas or line breaks",
    ),
    "providerRemote": MessageLookupByLibrary.simpleMessage("Remote URL"),
    "providerRenameShadowed": m56,
    "providerSourceReference": m57,
    "providerSourceUnavailable": m58,
    "providerUrlTip": MessageLookupByLibrary.simpleMessage(
      "Enter an HTTP or HTTPS URL without embedded credentials",
    ),
    "providers": MessageLookupByLibrary.simpleMessage("Providers"),
    "proxies": MessageLookupByLibrary.simpleMessage("Proxies"),
    "proxyChainAvailableNodes": MessageLookupByLibrary.simpleMessage(
      "Available nodes",
    ),
    "proxyChainConflictTip": m59,
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
    "proxyChainUnavailableNodeTip": m60,
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
    "proxyConflictSystemProxy": m61,
    "proxyConflictTitle": MessageLookupByLibrary.simpleMessage(
      "Possible proxy conflict",
    ),
    "proxyConflictVpn": m62,
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
    "purchaseAutoRenewLabel": MessageLookupByLibrary.simpleMessage(
      "Auto-renew",
    ),
    "purchaseDays": m63,
    "purchaseHours": m64,
    "purchaseMinutes": m65,
    "purchasePriceLabel": MessageLookupByLibrary.simpleMessage(
      "Purchase price",
    ),
    "purchaseRenewOff": MessageLookupByLibrary.simpleMessage("Off"),
    "purchaseRenewOn": MessageLookupByLibrary.simpleMessage("On"),
    "purchaseRenewalPriceLabel": MessageLookupByLibrary.simpleMessage(
      "Renewal price",
    ),
    "purchaseTime": m66,
    "purchaseTotalTrafficLabel": MessageLookupByLibrary.simpleMessage(
      "Total traffic",
    ),
    "purchasedAtLabel": MessageLookupByLibrary.simpleMessage("Purchase time"),
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("Pure black mode"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QR code"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage(
      "Scan QR code to obtain profile",
    ),
    "quickAdd": MessageLookupByLibrary.simpleMessage("Quick add"),
    "quickFill": MessageLookupByLibrary.simpleMessage("Quick fill"),
    "rainbowScheme": MessageLookupByLibrary.simpleMessage("Rainbow"),
    "rawOutboundInUse": m67,
    "receivingAddress": MessageLookupByLibrary.simpleMessage(
      "Receiving address",
    ),
    "recharge": MessageLookupByLibrary.simpleMessage("Recharge"),
    "rechargeAllowedRange": m68,
    "rechargeAmount": MessageLookupByLibrary.simpleMessage(
      "Recharge amount (¥)",
    ),
    "rechargeAmountOutOfRange": MessageLookupByLibrary.simpleMessage(
      "The amount is outside the range allowed by this payment method",
    ),
    "recurringRenewalHint": MessageLookupByLibrary.simpleMessage(
      "Future automatic renewals keep this discount",
    ),
    "redirPort": MessageLookupByLibrary.simpleMessage("Redir Port"),
    "redo": MessageLookupByLibrary.simpleMessage("redo"),
    "refresh": MessageLookupByLibrary.simpleMessage("Refresh"),
    "refreshAfterPayment": MessageLookupByLibrary.simpleMessage(
      "After payment, pull down to refresh and check the result",
    ),
    "refundAmountLabel": MessageLookupByLibrary.simpleMessage("Refund"),
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
    "remaining": m69,
    "remainingStock": m70,
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
    "remove": MessageLookupByLibrary.simpleMessage("Remove"),
    "rename": MessageLookupByLibrary.simpleMessage("Rename"),
    "renewalPriceLabel": MessageLookupByLibrary.simpleMessage("Renewal price"),
    "request": MessageLookupByLibrary.simpleMessage("Request"),
    "requests": MessageLookupByLibrary.simpleMessage("Requests"),
    "requestsDesc": MessageLookupByLibrary.simpleMessage(
      "View recently request records",
    ),
    "resendCodeIn": m71,
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
    "routeAddress": MessageLookupByLibrary.simpleMessage("Route address"),
    "routeAddressDesc": MessageLookupByLibrary.simpleMessage(
      "Config listen route address",
    ),
    "routeMode": MessageLookupByLibrary.simpleMessage("Route mode"),
    "routeMode_bypassPrivate": MessageLookupByLibrary.simpleMessage(
      "Bypass private route address",
    ),
    "routeMode_config": MessageLookupByLibrary.simpleMessage("Use config"),
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
    "ru": MessageLookupByLibrary.simpleMessage("Russian"),
    "rule": MessageLookupByLibrary.simpleMessage("Rule"),
    "ruleEmpty": MessageLookupByLibrary.simpleMessage("Rule is empty"),
    "ruleName": MessageLookupByLibrary.simpleMessage("Rule name"),
    "rulePresetBittorrentDirect": MessageLookupByLibrary.simpleMessage(
      "BitTorrent direct",
    ),
    "rulePresetBlockDot": MessageLookupByLibrary.simpleMessage(
      "Block DNS over TLS",
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
    "ruleTarget": MessageLookupByLibrary.simpleMessage("Rule target"),
    "rulesRequireRuleMode": MessageLookupByLibrary.simpleMessage(
      "Personal routing rules take effect in Rule mode.",
    ),
    "runTime": MessageLookupByLibrary.simpleMessage("Uptime"),
    "safeMode": MessageLookupByLibrary.simpleMessage("Safe mode"),
    "safeModeAppTitle": m72,
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
    "scriptModeDesc": MessageLookupByLibrary.simpleMessage(
      "Script mode, use external extension scripts, provide one-click override configuration capability",
    ),
    "scriptOptions": MessageLookupByLibrary.simpleMessage("Script options"),
    "scriptOptionsEmpty": MessageLookupByLibrary.simpleMessage(
      "This script does not expose configurable switches",
    ),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "seconds": MessageLookupByLibrary.simpleMessage("Seconds"),
    "secondsCount": m73,
    "selectAll": MessageLookupByLibrary.simpleMessage("Select all"),
    "selectBackup": MessageLookupByLibrary.simpleMessage("Select a backup"),
    "selectUpgradeTarget": MessageLookupByLibrary.simpleMessage(
      "Select upgrade target",
    ),
    "selected": MessageLookupByLibrary.simpleMessage("Selected"),
    "sendCode": MessageLookupByLibrary.simpleMessage("Send Code"),
    "sendResetEmail": MessageLookupByLibrary.simpleMessage("Send reset email"),
    "serviceAvailability": MessageLookupByLibrary.simpleMessage(
      "Service availability",
    ),
    "serviceAvailable": MessageLookupByLibrary.simpleMessage("Available"),
    "serviceBlocked": MessageLookupByLibrary.simpleMessage("Blocked"),
    "serviceCheckFailed": MessageLookupByLibrary.simpleMessage(
      "Service Check Failed",
    ),
    "serviceComingSoon": MessageLookupByLibrary.simpleMessage("Coming soon"),
    "serviceDisallowedIsp": MessageLookupByLibrary.simpleMessage(
      "ISP not supported",
    ),
    "serviceOriginalsOnly": MessageLookupByLibrary.simpleMessage(
      "Originals only",
    ),
    "serviceProbeHint": MessageLookupByLibrary.simpleMessage(
      "Run a check to inspect the actual route and service responses",
    ),
    "serviceProbeStale": MessageLookupByLibrary.simpleMessage(
      "Route changed — refresh to check again",
    ),
    "serviceProbeStart": MessageLookupByLibrary.simpleMessage(
      "Start the core to run checks (disabled in safe mode)",
    ),
    "serviceRestricted": MessageLookupByLibrary.simpleMessage("Restricted"),
    "serviceTimeout": MessageLookupByLibrary.simpleMessage("Timed out"),
    "serviceUnavailable": MessageLookupByLibrary.simpleMessage("Unavailable"),
    "serviceUnsupportedRegion": MessageLookupByLibrary.simpleMessage(
      "Region not supported",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "show": MessageLookupByLibrary.simpleMessage("Show"),
    "showNotificationStopAction": MessageLookupByLibrary.simpleMessage(
      "Stop button in notification",
    ),
    "shrink": MessageLookupByLibrary.simpleMessage("Shrink"),
    "sidebarBlur": MessageLookupByLibrary.simpleMessage("Blur sidebar"),
    "sidebarBlurDesc": MessageLookupByLibrary.simpleMessage(
      "Show a translucent system backdrop behind the sidebar",
    ),
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
    "ssidPermissionGuide": MessageLookupByLibrary.simpleMessage(
      "Allow location access to read Wi-Fi names. On Android, allow precise location all the time and enable system location services.",
    ),
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
    "startupRecoveryTip": MessageLookupByLibrary.simpleMessage(
      "Two recent startup attempts failed. Automatic profile application and VPN start are paused for this launch. Your selected profile and settings are preserved. Check the configuration, then press Start to retry. An already running VPN is kept active.",
    ),
    "startupRecoveryTitle": MessageLookupByLibrary.simpleMessage(
      "Startup recovery",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "statusDesc": MessageLookupByLibrary.simpleMessage(
      "System DNS will be used when turned off",
    ),
    "stop": MessageLookupByLibrary.simpleMessage("Stop"),
    "stopVpn": MessageLookupByLibrary.simpleMessage("Stopping VPN..."),
    "store": MessageLookupByLibrary.simpleMessage("Store"),
    "storeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Purchase, renew, and upgrade plans",
    ),
    "strategy": MessageLookupByLibrary.simpleMessage("Strategy"),
    "style": MessageLookupByLibrary.simpleMessage("Style"),
    "subRule": MessageLookupByLibrary.simpleMessage("Sub rule"),
    "submit": MessageLookupByLibrary.simpleMessage("Submit"),
    "suspendOnIdle": MessageLookupByLibrary.simpleMessage(
      "Pause proxy when idle",
    ),
    "suspendOnIdleDesc": MessageLookupByLibrary.simpleMessage(
      "Pause traffic forwarding to save power when the screen is off and the system becomes idle. This may disconnect calls and live audio.",
    ),
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
    "tailscaleCheckSettings": m74,
    "tailscaleConnected": MessageLookupByLibrary.simpleMessage("Connected"),
    "tailscaleConnecting": MessageLookupByLibrary.simpleMessage("Connecting"),
    "tailscaleControlUrl": MessageLookupByLibrary.simpleMessage("Control URL"),
    "tailscaleCredentialsFooter": MessageLookupByLibrary.simpleMessage(
      "Authentication and device identity stay on this device.",
    ),
    "tailscaleDeviceName": MessageLookupByLibrary.simpleMessage("Device name"),
    "tailscaleDevices": m75,
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
    "tailscaleNetworkInUse": m76,
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
    "tailscaleRelay": m77,
    "tailscaleRemoveConfirm": m78,
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
    "timeout": MessageLookupByLibrary.simpleMessage("Timeout"),
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
    "tonalSpotScheme": MessageLookupByLibrary.simpleMessage("TonalSpot"),
    "tools": MessageLookupByLibrary.simpleMessage("Tools"),
    "total": MessageLookupByLibrary.simpleMessage("Total"),
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
    "tunMtuDesc": MessageLookupByLibrary.simpleMessage(
      "Default: 9000; alternatives: 1480 or 4064. Restart the Android VPN to apply",
    ),
    "tunMtuInvalid": MessageLookupByLibrary.simpleMessage(
      "Enter an integer from 1280 to 65535",
    ),
    "turnOff": MessageLookupByLibrary.simpleMessage("Turn Off"),
    "turnOn": MessageLookupByLibrary.simpleMessage("Turn On"),
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
    "updateBuildNumber": m79,
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
    "updateVersionNumber": m80,
    "upgradePlan": MessageLookupByLibrary.simpleMessage("Upgrade plan"),
    "upload": MessageLookupByLibrary.simpleMessage("Upload"),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage(
      "Obtain profile through URL",
    ),
    "urlTip": m81,
    "useHosts": MessageLookupByLibrary.simpleMessage("Use hosts"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage("Use system hosts"),
    "usedTrafficLabel": MessageLookupByLibrary.simpleMessage("Used traffic"),
    "userAgent": MessageLookupByLibrary.simpleMessage("User-Agent"),
    "userCenter": MessageLookupByLibrary.simpleMessage("User Center"),
    "userCenterFallback": MessageLookupByLibrary.simpleMessage(
      "User Center (Backup)",
    ),
    "value": MessageLookupByLibrary.simpleMessage("Value"),
    "verifyCoupon": MessageLookupByLibrary.simpleMessage("Verify"),
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
    "yearsAgo": m82,
    "zh_CN": MessageLookupByLibrary.simpleMessage("Simplified Chinese"),
  };
}

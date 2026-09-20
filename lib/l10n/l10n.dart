// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(
      _current != null,
      'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Rule`
  String get rule {
    return Intl.message('Rule', name: 'rule', desc: '', args: []);
  }

  /// `Global`
  String get global {
    return Intl.message('Global', name: 'global', desc: '', args: []);
  }

  /// `Direct`
  String get direct {
    return Intl.message('Direct', name: 'direct', desc: '', args: []);
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message('Dashboard', name: 'dashboard', desc: '', args: []);
  }

  /// `Proxies`
  String get proxies {
    return Intl.message('Proxies', name: 'proxies', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Profiles`
  String get profiles {
    return Intl.message('Profiles', name: 'profiles', desc: '', args: []);
  }

  /// `Tools`
  String get tools {
    return Intl.message('Tools', name: 'tools', desc: '', args: []);
  }

  /// `Logs`
  String get logs {
    return Intl.message('Logs', name: 'logs', desc: '', args: []);
  }

  /// `Log capture records`
  String get logsDesc {
    return Intl.message(
      'Log capture records',
      name: 'logsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Resources`
  String get resources {
    return Intl.message('Resources', name: 'resources', desc: '', args: []);
  }

  /// `External resource related info`
  String get resourcesDesc {
    return Intl.message(
      'External resource related info',
      name: 'resourcesDesc',
      desc: '',
      args: [],
    );
  }

  /// `Traffic usage`
  String get trafficUsage {
    return Intl.message(
      'Traffic usage',
      name: 'trafficUsage',
      desc: '',
      args: [],
    );
  }

  /// `Network speed`
  String get networkSpeed {
    return Intl.message(
      'Network speed',
      name: 'networkSpeed',
      desc: '',
      args: [],
    );
  }

  /// `Outbound mode`
  String get outboundMode {
    return Intl.message(
      'Outbound mode',
      name: 'outboundMode',
      desc: '',
      args: [],
    );
  }

  /// `Network detection`
  String get networkDetection {
    return Intl.message(
      'Network detection',
      name: 'networkDetection',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message('Upload', name: 'upload', desc: '', args: []);
  }

  /// `Download`
  String get download {
    return Intl.message('Download', name: 'download', desc: '', args: []);
  }

  /// `No proxy`
  String get noProxy {
    return Intl.message('No proxy', name: 'noProxy', desc: '', args: []);
  }

  /// `No profile, Please add a profile`
  String get nullProfileDesc {
    return Intl.message(
      'No profile, Please add a profile',
      name: 'nullProfileDesc',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Default`
  String get defaultText {
    return Intl.message('Default', name: 'defaultText', desc: '', args: []);
  }

  /// `More`
  String get more {
    return Intl.message('More', name: 'more', desc: '', args: []);
  }

  /// `Other`
  String get other {
    return Intl.message('Other', name: 'other', desc: '', args: []);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `English`
  String get en {
    return Intl.message('English', name: 'en', desc: '', args: []);
  }

  /// `Japanese`
  String get ja {
    return Intl.message('Japanese', name: 'ja', desc: '', args: []);
  }

  /// `Russian`
  String get ru {
    return Intl.message('Russian', name: 'ru', desc: '', args: []);
  }

  /// `Simplified Chinese`
  String get zh_CN {
    return Intl.message(
      'Simplified Chinese',
      name: 'zh_CN',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Set dark mode,adjust the color`
  String get themeDesc {
    return Intl.message(
      'Set dark mode,adjust the color',
      name: 'themeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Override`
  String get override {
    return Intl.message('Override', name: 'override', desc: '', args: []);
  }

  /// `AllowLan`
  String get allowLan {
    return Intl.message('AllowLan', name: 'allowLan', desc: '', args: []);
  }

  /// `Allow access proxy through the LAN`
  String get allowLanDesc {
    return Intl.message(
      'Allow access proxy through the LAN',
      name: 'allowLanDesc',
      desc: '',
      args: [],
    );
  }

  /// `TUN`
  String get tun {
    return Intl.message('TUN', name: 'tun', desc: '', args: []);
  }

  /// `only effective in administrator mode`
  String get tunDesc {
    return Intl.message(
      'only effective in administrator mode',
      name: 'tunDesc',
      desc: '',
      args: [],
    );
  }

  /// `Minimize on exit`
  String get minimizeOnExit {
    return Intl.message(
      'Minimize on exit',
      name: 'minimizeOnExit',
      desc: '',
      args: [],
    );
  }

  /// `Modify the default system exit event`
  String get minimizeOnExitDesc {
    return Intl.message(
      'Modify the default system exit event',
      name: 'minimizeOnExitDesc',
      desc: '',
      args: [],
    );
  }

  /// `Auto launch`
  String get autoLaunch {
    return Intl.message('Auto launch', name: 'autoLaunch', desc: '', args: []);
  }

  /// `Follow the system self startup`
  String get autoLaunchDesc {
    return Intl.message(
      'Follow the system self startup',
      name: 'autoLaunchDesc',
      desc: '',
      args: [],
    );
  }

  /// `SilentLaunch`
  String get silentLaunch {
    return Intl.message(
      'SilentLaunch',
      name: 'silentLaunch',
      desc: '',
      args: [],
    );
  }

  /// `Start in the background`
  String get silentLaunchDesc {
    return Intl.message(
      'Start in the background',
      name: 'silentLaunchDesc',
      desc: '',
      args: [],
    );
  }

  /// `AutoRun`
  String get autoRun {
    return Intl.message('AutoRun', name: 'autoRun', desc: '', args: []);
  }

  /// `Auto run when the application is opened`
  String get autoRunDesc {
    return Intl.message(
      'Auto run when the application is opened',
      name: 'autoRunDesc',
      desc: '',
      args: [],
    );
  }

  /// `Logcat`
  String get logcat {
    return Intl.message('Logcat', name: 'logcat', desc: '', args: []);
  }

  /// `Disabling will hide the log entry`
  String get logcatDesc {
    return Intl.message(
      'Disabling will hide the log entry',
      name: 'logcatDesc',
      desc: '',
      args: [],
    );
  }

  /// `AccessControl`
  String get accessControl {
    return Intl.message(
      'AccessControl',
      name: 'accessControl',
      desc: '',
      args: [],
    );
  }

  /// `Configure application access proxy`
  String get accessControlDesc {
    return Intl.message(
      'Configure application access proxy',
      name: 'accessControlDesc',
      desc: '',
      args: [],
    );
  }

  /// `Application`
  String get application {
    return Intl.message('Application', name: 'application', desc: '', args: []);
  }

  /// `Modify application related settings`
  String get applicationDesc {
    return Intl.message(
      'Modify application related settings',
      name: 'applicationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Hours`
  String get hours {
    return Intl.message('Hours', name: 'hours', desc: '', args: []);
  }

  /// `Seconds`
  String get seconds {
    return Intl.message('Seconds', name: 'seconds', desc: '', args: []);
  }

  /// `QR code`
  String get qrcode {
    return Intl.message('QR code', name: 'qrcode', desc: '', args: []);
  }

  /// `Scan QR code to obtain profile`
  String get qrcodeDesc {
    return Intl.message(
      'Scan QR code to obtain profile',
      name: 'qrcodeDesc',
      desc: '',
      args: [],
    );
  }

  /// `URL`
  String get url {
    return Intl.message('URL', name: 'url', desc: '', args: []);
  }

  /// `Obtain profile through URL`
  String get urlDesc {
    return Intl.message(
      'Obtain profile through URL',
      name: 'urlDesc',
      desc: '',
      args: [],
    );
  }

  /// `File`
  String get file {
    return Intl.message('File', name: 'file', desc: '', args: []);
  }

  /// `Directly upload profile`
  String get fileDesc {
    return Intl.message(
      'Directly upload profile',
      name: 'fileDesc',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Please input the profile name`
  String get profileNameNullValidationDesc {
    return Intl.message(
      'Please input the profile name',
      name: 'profileNameNullValidationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Please input the profile URL`
  String get profileUrlNullValidationDesc {
    return Intl.message(
      'Please input the profile URL',
      name: 'profileUrlNullValidationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Please input a valid profile URL`
  String get profileUrlInvalidValidationDesc {
    return Intl.message(
      'Please input a valid profile URL',
      name: 'profileUrlInvalidValidationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Auto update`
  String get autoUpdate {
    return Intl.message('Auto update', name: 'autoUpdate', desc: '', args: []);
  }

  /// `Auto update interval (minutes)`
  String get autoUpdateInterval {
    return Intl.message(
      'Auto update interval (minutes)',
      name: 'autoUpdateInterval',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the auto update interval time`
  String get profileAutoUpdateIntervalNullValidationDesc {
    return Intl.message(
      'Please enter the auto update interval time',
      name: 'profileAutoUpdateIntervalNullValidationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Please input a valid interval time format`
  String get profileAutoUpdateIntervalInvalidValidationDesc {
    return Intl.message(
      'Please input a valid interval time format',
      name: 'profileAutoUpdateIntervalInvalidValidationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Theme mode`
  String get themeMode {
    return Intl.message('Theme mode', name: 'themeMode', desc: '', args: []);
  }

  /// `Theme color`
  String get themeColor {
    return Intl.message('Theme color', name: 'themeColor', desc: '', args: []);
  }

  /// `Preview`
  String get preview {
    return Intl.message('Preview', name: 'preview', desc: '', args: []);
  }

  /// `Auto`
  String get auto {
    return Intl.message('Auto', name: 'auto', desc: '', args: []);
  }

  /// `Light`
  String get light {
    return Intl.message('Light', name: 'light', desc: '', args: []);
  }

  /// `Dark`
  String get dark {
    return Intl.message('Dark', name: 'dark', desc: '', args: []);
  }

  /// `Import from URL`
  String get importFromURL {
    return Intl.message(
      'Import from URL',
      name: 'importFromURL',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message('Submit', name: 'submit', desc: '', args: []);
  }

  /// `Do you want to pass`
  String get doYouWantToPass {
    return Intl.message(
      'Do you want to pass',
      name: 'doYouWantToPass',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message('Create', name: 'create', desc: '', args: []);
  }

  /// `Please upload a valid QR code`
  String get pleaseUploadValidQrcode {
    return Intl.message(
      'Please upload a valid QR code',
      name: 'pleaseUploadValidQrcode',
      desc: '',
      args: [],
    );
  }

  /// `Blacklist mode`
  String get blacklistMode {
    return Intl.message(
      'Blacklist mode',
      name: 'blacklistMode',
      desc: '',
      args: [],
    );
  }

  /// `Whitelist mode`
  String get whitelistMode {
    return Intl.message(
      'Whitelist mode',
      name: 'whitelistMode',
      desc: '',
      args: [],
    );
  }

  /// `Select all`
  String get selectAll {
    return Intl.message('Select all', name: 'selectAll', desc: '', args: []);
  }

  /// `Cancel select all`
  String get cancelSelectAll {
    return Intl.message(
      'Cancel select all',
      name: 'cancelSelectAll',
      desc: '',
      args: [],
    );
  }

  /// `App access control`
  String get appAccessControl {
    return Intl.message(
      'App access control',
      name: 'appAccessControl',
      desc: '',
      args: [],
    );
  }

  /// `Only allow selected app to enter VPN`
  String get accessControlAllowDesc {
    return Intl.message(
      'Only allow selected app to enter VPN',
      name: 'accessControlAllowDesc',
      desc: '',
      args: [],
    );
  }

  /// `The selected application will be excluded from VPN`
  String get accessControlNotAllowDesc {
    return Intl.message(
      'The selected application will be excluded from VPN',
      name: 'accessControlNotAllowDesc',
      desc: '',
      args: [],
    );
  }

  /// `Selected`
  String get selected {
    return Intl.message('Selected', name: 'selected', desc: '', args: []);
  }

  /// `Profile parse error`
  String get profileParseErrorDesc {
    return Intl.message(
      'Profile parse error',
      name: 'profileParseErrorDesc',
      desc: '',
      args: [],
    );
  }

  /// `ProxyPort`
  String get proxyPort {
    return Intl.message('ProxyPort', name: 'proxyPort', desc: '', args: []);
  }

  /// `Port`
  String get port {
    return Intl.message('Port', name: 'port', desc: '', args: []);
  }

  /// `LogLevel`
  String get logLevel {
    return Intl.message('LogLevel', name: 'logLevel', desc: '', args: []);
  }

  /// `Show`
  String get show {
    return Intl.message('Show', name: 'show', desc: '', args: []);
  }

  /// `Hide`
  String get hide {
    return Intl.message('Hide', name: 'hide', desc: '', args: []);
  }

  /// `Exit`
  String get exit {
    return Intl.message('Exit', name: 'exit', desc: '', args: []);
  }

  /// `System proxy`
  String get systemProxy {
    return Intl.message(
      'System proxy',
      name: 'systemProxy',
      desc: '',
      args: [],
    );
  }

  /// `User-Agent`
  String get userAgent {
    return Intl.message('User-Agent', name: 'userAgent', desc: '', args: []);
  }

  /// `Custom (enter manually)`
  String get customUserAgent {
    return Intl.message(
      'Custom (enter manually)',
      name: 'customUserAgent',
      desc: '',
      args: [],
    );
  }

  /// `Enter the full User-Agent value`
  String get customUserAgentHint {
    return Intl.message(
      'Enter the full User-Agent value',
      name: 'customUserAgentHint',
      desc: '',
      args: [],
    );
  }

  /// `Use only English letters, numbers, spaces, and standard punctuation`
  String get customUserAgentInvalid {
    return Intl.message(
      'Use only English letters, numbers, spaces, and standard punctuation',
      name: 'customUserAgentInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Custom`
  String get custom {
    return Intl.message('Custom', name: 'custom', desc: '', args: []);
  }

  /// `Project`
  String get project {
    return Intl.message('Project', name: 'project', desc: '', args: []);
  }

  /// `Core`
  String get core {
    return Intl.message('Core', name: 'core', desc: '', args: []);
  }

  /// `Reverse engineering, decompilation, disassembly, or AI-assisted analysis of this application is strictly prohibited.`
  String get reverseEngineeringNotice {
    return Intl.message(
      'Reverse engineering, decompilation, disassembly, or AI-assisted analysis of this application is strictly prohibited.',
      name: 'reverseEngineeringNotice',
      desc: '',
      args: [],
    );
  }

  /// `Tab animation`
  String get tabAnimation {
    return Intl.message(
      'Tab animation',
      name: 'tabAnimation',
      desc: '',
      args: [],
    );
  }

  /// `A multi-platform proxy client based on ClashMeta, simple and easy to use, open-source and ad-free.`
  String get desc {
    return Intl.message(
      'A multi-platform proxy client based on ClashMeta, simple and easy to use, open-source and ad-free.',
      name: 'desc',
      desc: '',
      args: [],
    );
  }

  /// `Starting VPN...`
  String get startVpn {
    return Intl.message(
      'Starting VPN...',
      name: 'startVpn',
      desc: '',
      args: [],
    );
  }

  /// `Stopping VPN...`
  String get stopVpn {
    return Intl.message('Stopping VPN...', name: 'stopVpn', desc: '', args: []);
  }

  /// `Discovery a new version`
  String get discovery {
    return Intl.message(
      'Discovery a new version',
      name: 'discovery',
      desc: '',
      args: [],
    );
  }

  /// `Compatibility mode`
  String get compatible {
    return Intl.message(
      'Compatibility mode',
      name: 'compatible',
      desc: '',
      args: [],
    );
  }

  /// `The current proxy group cannot be selected.`
  String get notSelectedTip {
    return Intl.message(
      'The current proxy group cannot be selected.',
      name: 'notSelectedTip',
      desc: '',
      args: [],
    );
  }

  /// `tip`
  String get tip {
    return Intl.message('tip', name: 'tip', desc: '', args: []);
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
  }

  /// `Backup`
  String get backup {
    return Intl.message('Backup', name: 'backup', desc: '', args: []);
  }

  /// `Backup success`
  String get backupSuccess {
    return Intl.message(
      'Backup success',
      name: 'backupSuccess',
      desc: '',
      args: [],
    );
  }

  /// `No info`
  String get noInfo {
    return Intl.message('No info', name: 'noInfo', desc: '', args: []);
  }

  /// `Please bind WebDAV`
  String get pleaseBindWebDAV {
    return Intl.message(
      'Please bind WebDAV',
      name: 'pleaseBindWebDAV',
      desc: '',
      args: [],
    );
  }

  /// `Bind`
  String get bind {
    return Intl.message('Bind', name: 'bind', desc: '', args: []);
  }

  /// `Connectivity：`
  String get connectivity {
    return Intl.message(
      'Connectivity：',
      name: 'connectivity',
      desc: '',
      args: [],
    );
  }

  /// `WebDAV configuration`
  String get webDAVConfiguration {
    return Intl.message(
      'WebDAV configuration',
      name: 'webDAVConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `WebDAV server address`
  String get addressHelp {
    return Intl.message(
      'WebDAV server address',
      name: 'addressHelp',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid WebDAV address`
  String get addressTip {
    return Intl.message(
      'Please enter a valid WebDAV address',
      name: 'addressTip',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Check for updates`
  String get checkUpdate {
    return Intl.message(
      'Check for updates',
      name: 'checkUpdate',
      desc: '',
      args: [],
    );
  }

  /// `The current application is already the latest version`
  String get checkUpdateError {
    return Intl.message(
      'The current application is already the latest version',
      name: 'checkUpdateError',
      desc: '',
      args: [],
    );
  }

  /// `Failed to check for updates. Please check your network and try again`
  String get checkUpdateFailed {
    return Intl.message(
      'Failed to check for updates. Please check your network and try again',
      name: 'checkUpdateFailed',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message('Unknown', name: 'unknown', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Allow applications to bypass VPN`
  String get allowBypass {
    return Intl.message(
      'Allow applications to bypass VPN',
      name: 'allowBypass',
      desc: '',
      args: [],
    );
  }

  /// `Some apps can bypass VPN when turned on`
  String get allowBypassDesc {
    return Intl.message(
      'Some apps can bypass VPN when turned on',
      name: 'allowBypassDesc',
      desc: '',
      args: [],
    );
  }

  /// `ExternalController`
  String get externalController {
    return Intl.message(
      'ExternalController',
      name: 'externalController',
      desc: '',
      args: [],
    );
  }

  /// `Once enabled, the Clash kernel can be controlled on the configured port`
  String get externalControllerDesc {
    return Intl.message(
      'Once enabled, the Clash kernel can be controlled on the configured port',
      name: 'externalControllerDesc',
      desc: '',
      args: [],
    );
  }

  /// `Open dashboard`
  String get openDashboard {
    return Intl.message(
      'Open dashboard',
      name: 'openDashboard',
      desc: '',
      args: [],
    );
  }

  /// `When turned on it will be able to receive IPv6 traffic`
  String get ipv6Desc {
    return Intl.message(
      'When turned on it will be able to receive IPv6 traffic',
      name: 'ipv6Desc',
      desc: '',
      args: [],
    );
  }

  /// `Auto IPv6`
  String get autoIpv6 {
    return Intl.message('Auto IPv6', name: 'autoIpv6', desc: '', args: []);
  }

  /// `Toggle IPv6 automatically based on local network support`
  String get autoIpv6Desc {
    return Intl.message(
      'Toggle IPv6 automatically based on local network support',
      name: 'autoIpv6Desc',
      desc: '',
      args: [],
    );
  }

  /// `App`
  String get app {
    return Intl.message('App', name: 'app', desc: '', args: []);
  }

  /// `Attach HTTP proxy to VpnService`
  String get systemProxyDesc {
    return Intl.message(
      'Attach HTTP proxy to VpnService',
      name: 'systemProxyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Unified delay`
  String get unifiedDelay {
    return Intl.message(
      'Unified delay',
      name: 'unifiedDelay',
      desc: '',
      args: [],
    );
  }

  /// `Remove extra delays such as handshaking`
  String get unifiedDelayDesc {
    return Intl.message(
      'Remove extra delays such as handshaking',
      name: 'unifiedDelayDesc',
      desc: '',
      args: [],
    );
  }

  /// `TCP concurrent`
  String get tcpConcurrent {
    return Intl.message(
      'TCP concurrent',
      name: 'tcpConcurrent',
      desc: '',
      args: [],
    );
  }

  /// `Enabling it will allow TCP concurrency`
  String get tcpConcurrentDesc {
    return Intl.message(
      'Enabling it will allow TCP concurrency',
      name: 'tcpConcurrentDesc',
      desc: '',
      args: [],
    );
  }

  /// `Geo Low Memory Mode`
  String get geodataLoader {
    return Intl.message(
      'Geo Low Memory Mode',
      name: 'geodataLoader',
      desc: '',
      args: [],
    );
  }

  /// `Enabling will use the Geo low memory loader`
  String get geodataLoaderDesc {
    return Intl.message(
      'Enabling will use the Geo low memory loader',
      name: 'geodataLoaderDesc',
      desc: '',
      args: [],
    );
  }

  /// `Requests`
  String get requests {
    return Intl.message('Requests', name: 'requests', desc: '', args: []);
  }

  /// `View recently request records`
  String get requestsDesc {
    return Intl.message(
      'View recently request records',
      name: 'requestsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Find process`
  String get findProcessMode {
    return Intl.message(
      'Find process',
      name: 'findProcessMode',
      desc: '',
      args: [],
    );
  }

  /// `Init`
  String get init {
    return Intl.message('Init', name: 'init', desc: '', args: []);
  }

  /// `Long term effective`
  String get infiniteTime {
    return Intl.message(
      'Long term effective',
      name: 'infiniteTime',
      desc: '',
      args: [],
    );
  }

  /// `Connections`
  String get connections {
    return Intl.message('Connections', name: 'connections', desc: '', args: []);
  }

  /// `View current connections data`
  String get connectionsDesc {
    return Intl.message(
      'View current connections data',
      name: 'connectionsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Intranet IP`
  String get intranetIP {
    return Intl.message('Intranet IP', name: 'intranetIP', desc: '', args: []);
  }

  /// `View`
  String get view {
    return Intl.message('View', name: 'view', desc: '', args: []);
  }

  /// `Cut`
  String get cut {
    return Intl.message('Cut', name: 'cut', desc: '', args: []);
  }

  /// `Copy`
  String get copy {
    return Intl.message('Copy', name: 'copy', desc: '', args: []);
  }

  /// `Paste`
  String get paste {
    return Intl.message('Paste', name: 'paste', desc: '', args: []);
  }

  /// `Test url`
  String get testUrl {
    return Intl.message('Test url', name: 'testUrl', desc: '', args: []);
  }

  /// `Sync`
  String get sync {
    return Intl.message('Sync', name: 'sync', desc: '', args: []);
  }

  /// `Hidden from recent tasks`
  String get exclude {
    return Intl.message(
      'Hidden from recent tasks',
      name: 'exclude',
      desc: '',
      args: [],
    );
  }

  /// `When the app is in the background, the app is hidden from the recent task`
  String get excludeDesc {
    return Intl.message(
      'When the app is in the background, the app is hidden from the recent task',
      name: 'excludeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Standard`
  String get expand {
    return Intl.message('Standard', name: 'expand', desc: '', args: []);
  }

  /// `Shrink`
  String get shrink {
    return Intl.message('Shrink', name: 'shrink', desc: '', args: []);
  }

  /// `Min`
  String get min {
    return Intl.message('Min', name: 'min', desc: '', args: []);
  }

  /// `Tab`
  String get tab {
    return Intl.message('Tab', name: 'tab', desc: '', args: []);
  }

  /// `List`
  String get list {
    return Intl.message('List', name: 'list', desc: '', args: []);
  }

  /// `Delay`
  String get delay {
    return Intl.message('Delay', name: 'delay', desc: '', args: []);
  }

  /// `Style`
  String get style {
    return Intl.message('Style', name: 'style', desc: '', args: []);
  }

  /// `Size`
  String get size {
    return Intl.message('Size', name: 'size', desc: '', args: []);
  }

  /// `Sort`
  String get sort {
    return Intl.message('Sort', name: 'sort', desc: '', args: []);
  }

  /// `Columns`
  String get columns {
    return Intl.message('Columns', name: 'columns', desc: '', args: []);
  }

  /// `Proxy group`
  String get proxyGroup {
    return Intl.message('Proxy group', name: 'proxyGroup', desc: '', args: []);
  }

  /// `Go`
  String get go {
    return Intl.message('Go', name: 'go', desc: '', args: []);
  }

  /// `External link`
  String get externalLink {
    return Intl.message(
      'External link',
      name: 'externalLink',
      desc: '',
      args: [],
    );
  }

  /// `Auto close connections`
  String get autoCloseConnections {
    return Intl.message(
      'Auto close connections',
      name: 'autoCloseConnections',
      desc: '',
      args: [],
    );
  }

  /// `Auto close connections after change node`
  String get autoCloseConnectionsDesc {
    return Intl.message(
      'Auto close connections after change node',
      name: 'autoCloseConnectionsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Only statistics proxy`
  String get onlyStatisticsProxy {
    return Intl.message(
      'Only statistics proxy',
      name: 'onlyStatisticsProxy',
      desc: '',
      args: [],
    );
  }

  /// `When turned on, only statistics proxy traffic`
  String get onlyStatisticsProxyDesc {
    return Intl.message(
      'When turned on, only statistics proxy traffic',
      name: 'onlyStatisticsProxyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Pure black mode`
  String get pureBlackMode {
    return Intl.message(
      'Pure black mode',
      name: 'pureBlackMode',
      desc: '',
      args: [],
    );
  }

  /// `Tcp keep alive interval`
  String get keepAliveIntervalDesc {
    return Intl.message(
      'Tcp keep alive interval',
      name: 'keepAliveIntervalDesc',
      desc: '',
      args: [],
    );
  }

  /// ` entries`
  String get entries {
    return Intl.message(' entries', name: 'entries', desc: '', args: []);
  }

  /// `{count} seconds`
  String secondsCount(Object count) {
    return Intl.message(
      '$count seconds',
      name: 'secondsCount',
      desc: '',
      args: [count],
    );
  }

  /// `{count} entries`
  String entriesCount(Object count) {
    return Intl.message(
      '$count entries',
      name: 'entriesCount',
      desc: '',
      args: [count],
    );
  }

  /// `Geo Options`
  String get geoOptions {
    return Intl.message('Geo Options', name: 'geoOptions', desc: '', args: []);
  }

  /// `Auto Update`
  String get geoAutoUpdate {
    return Intl.message(
      'Auto Update',
      name: 'geoAutoUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Auto Update Interval`
  String get geoAutoUpdateInterval {
    return Intl.message(
      'Auto Update Interval',
      name: 'geoAutoUpdateInterval',
      desc: '',
      args: [],
    );
  }

  /// `Auto update interval must be between 1 and 8760 hours`
  String get geoAutoUpdateIntervalTip {
    return Intl.message(
      'Auto update interval must be between 1 and 8760 hours',
      name: 'geoAutoUpdateIntervalTip',
      desc: '',
      args: [],
    );
  }

  /// `{count} hours`
  String hoursCount(Object count) {
    return Intl.message(
      '$count hours',
      name: 'hoursCount',
      desc: '',
      args: [count],
    );
  }

  /// `Geo Resources`
  String get geoResources {
    return Intl.message(
      'Geo Resources',
      name: 'geoResources',
      desc: '',
      args: [],
    );
  }

  /// `Updating {name}...`
  String geoUpdating(Object name) {
    return Intl.message(
      'Updating $name...',
      name: 'geoUpdating',
      desc: '',
      args: [name],
    );
  }

  /// `{name} skipped`
  String geoSkipped(Object name) {
    return Intl.message(
      '$name skipped',
      name: 'geoSkipped',
      desc: '',
      args: [name],
    );
  }

  /// `{name} updated`
  String geoUpdated(Object name) {
    return Intl.message(
      '$name updated',
      name: 'geoUpdated',
      desc: '',
      args: [name],
    );
  }

  /// `Local`
  String get local {
    return Intl.message('Local', name: 'local', desc: '', args: []);
  }

  /// `Remote`
  String get remote {
    return Intl.message('Remote', name: 'remote', desc: '', args: []);
  }

  /// `Backup local data to WebDAV`
  String get remoteBackupDesc {
    return Intl.message(
      'Backup local data to WebDAV',
      name: 'remoteBackupDesc',
      desc: '',
      args: [],
    );
  }

  /// `Backup local data to local`
  String get localBackupDesc {
    return Intl.message(
      'Backup local data to local',
      name: 'localBackupDesc',
      desc: '',
      args: [],
    );
  }

  /// `Mode`
  String get mode {
    return Intl.message('Mode', name: 'mode', desc: '', args: []);
  }

  /// `Time`
  String get time {
    return Intl.message('Time', name: 'time', desc: '', args: []);
  }

  /// `Source`
  String get source {
    return Intl.message('Source', name: 'source', desc: '', args: []);
  }

  /// `Action`
  String get action {
    return Intl.message('Action', name: 'action', desc: '', args: []);
  }

  /// `Intelligent selection`
  String get intelligentSelected {
    return Intl.message(
      'Intelligent selection',
      name: 'intelligentSelected',
      desc: '',
      args: [],
    );
  }

  /// `Clipboard import`
  String get clipboardImport {
    return Intl.message(
      'Clipboard import',
      name: 'clipboardImport',
      desc: '',
      args: [],
    );
  }

  /// `Export clipboard`
  String get clipboardExport {
    return Intl.message(
      'Export clipboard',
      name: 'clipboardExport',
      desc: '',
      args: [],
    );
  }

  /// `Layout`
  String get layout {
    return Intl.message('Layout', name: 'layout', desc: '', args: []);
  }

  /// `Tight`
  String get tight {
    return Intl.message('Tight', name: 'tight', desc: '', args: []);
  }

  /// `Standard`
  String get standard {
    return Intl.message('Standard', name: 'standard', desc: '', args: []);
  }

  /// `Loose`
  String get loose {
    return Intl.message('Loose', name: 'loose', desc: '', args: []);
  }

  /// `Profiles sort`
  String get profilesSort {
    return Intl.message(
      'Profiles sort',
      name: 'profilesSort',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message('Start', name: 'start', desc: '', args: []);
  }

  /// `Stop`
  String get stop {
    return Intl.message('Stop', name: 'stop', desc: '', args: []);
  }

  /// `Update DNS related settings`
  String get dnsDesc {
    return Intl.message(
      'Update DNS related settings',
      name: 'dnsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Key`
  String get key {
    return Intl.message('Key', name: 'key', desc: '', args: []);
  }

  /// `Value`
  String get value {
    return Intl.message('Value', name: 'value', desc: '', args: []);
  }

  /// `Add Hosts`
  String get hostsDesc {
    return Intl.message('Add Hosts', name: 'hostsDesc', desc: '', args: []);
  }

  /// `Changes take effect after restarting the VPN`
  String get vpnTip {
    return Intl.message(
      'Changes take effect after restarting the VPN',
      name: 'vpnTip',
      desc: '',
      args: [],
    );
  }

  /// `Auto routes all system traffic through VpnService`
  String get vpnEnableDesc {
    return Intl.message(
      'Auto routes all system traffic through VpnService',
      name: 'vpnEnableDesc',
      desc: '',
      args: [],
    );
  }

  /// `Options`
  String get options {
    return Intl.message('Options', name: 'options', desc: '', args: []);
  }

  /// `Loopback unlock tool`
  String get loopback {
    return Intl.message(
      'Loopback unlock tool',
      name: 'loopback',
      desc: '',
      args: [],
    );
  }

  /// `Used for UWP loopback unlocking`
  String get loopbackDesc {
    return Intl.message(
      'Used for UWP loopback unlocking',
      name: 'loopbackDesc',
      desc: '',
      args: [],
    );
  }

  /// `Providers`
  String get providers {
    return Intl.message('Providers', name: 'providers', desc: '', args: []);
  }

  /// `Proxy providers`
  String get proxyProviders {
    return Intl.message(
      'Proxy providers',
      name: 'proxyProviders',
      desc: '',
      args: [],
    );
  }

  /// `Rule providers`
  String get ruleProviders {
    return Intl.message(
      'Rule providers',
      name: 'ruleProviders',
      desc: '',
      args: [],
    );
  }

  /// `Override Dns`
  String get overrideDns {
    return Intl.message(
      'Override Dns',
      name: 'overrideDns',
      desc: '',
      args: [],
    );
  }

  /// `Turning it on will override the DNS options in the profile`
  String get overrideDnsDesc {
    return Intl.message(
      'Turning it on will override the DNS options in the profile',
      name: 'overrideDnsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message('Status', name: 'status', desc: '', args: []);
  }

  /// `System DNS will be used when turned off`
  String get statusDesc {
    return Intl.message(
      'System DNS will be used when turned off',
      name: 'statusDesc',
      desc: '',
      args: [],
    );
  }

  /// `Prioritize the use of DOH's http/3`
  String get preferH3Desc {
    return Intl.message(
      'Prioritize the use of DOH\'s http/3',
      name: 'preferH3Desc',
      desc: '',
      args: [],
    );
  }

  /// `Respect rules`
  String get respectRules {
    return Intl.message(
      'Respect rules',
      name: 'respectRules',
      desc: '',
      args: [],
    );
  }

  /// `DNS connection following rules, need to configure proxy-server-nameserver`
  String get respectRulesDesc {
    return Intl.message(
      'DNS connection following rules, need to configure proxy-server-nameserver',
      name: 'respectRulesDesc',
      desc: '',
      args: [],
    );
  }

  /// `DNS mode`
  String get dnsMode {
    return Intl.message('DNS mode', name: 'dnsMode', desc: '', args: []);
  }

  /// `Fakeip range`
  String get fakeipRange {
    return Intl.message(
      'Fakeip range',
      name: 'fakeipRange',
      desc: '',
      args: [],
    );
  }

  /// `Fakeip filter`
  String get fakeipFilter {
    return Intl.message(
      'Fakeip filter',
      name: 'fakeipFilter',
      desc: '',
      args: [],
    );
  }

  /// `Default nameserver`
  String get defaultNameserver {
    return Intl.message(
      'Default nameserver',
      name: 'defaultNameserver',
      desc: '',
      args: [],
    );
  }

  /// `For resolving DNS server`
  String get defaultNameserverDesc {
    return Intl.message(
      'For resolving DNS server',
      name: 'defaultNameserverDesc',
      desc: '',
      args: [],
    );
  }

  /// `Nameserver`
  String get nameserver {
    return Intl.message('Nameserver', name: 'nameserver', desc: '', args: []);
  }

  /// `For resolving domain`
  String get nameserverDesc {
    return Intl.message(
      'For resolving domain',
      name: 'nameserverDesc',
      desc: '',
      args: [],
    );
  }

  /// `Use hosts`
  String get useHosts {
    return Intl.message('Use hosts', name: 'useHosts', desc: '', args: []);
  }

  /// `Use system hosts`
  String get useSystemHosts {
    return Intl.message(
      'Use system hosts',
      name: 'useSystemHosts',
      desc: '',
      args: [],
    );
  }

  /// `Nameserver policy`
  String get nameserverPolicy {
    return Intl.message(
      'Nameserver policy',
      name: 'nameserverPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Specify the corresponding nameserver policy`
  String get nameserverPolicyDesc {
    return Intl.message(
      'Specify the corresponding nameserver policy',
      name: 'nameserverPolicyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Proxy nameserver`
  String get proxyNameserver {
    return Intl.message(
      'Proxy nameserver',
      name: 'proxyNameserver',
      desc: '',
      args: [],
    );
  }

  /// `Domain for resolving proxy nodes`
  String get proxyNameserverDesc {
    return Intl.message(
      'Domain for resolving proxy nodes',
      name: 'proxyNameserverDesc',
      desc: '',
      args: [],
    );
  }

  /// `Fallback`
  String get fallback {
    return Intl.message('Fallback', name: 'fallback', desc: '', args: []);
  }

  /// `Generally use offshore DNS`
  String get fallbackDesc {
    return Intl.message(
      'Generally use offshore DNS',
      name: 'fallbackDesc',
      desc: '',
      args: [],
    );
  }

  /// `Fallback filter`
  String get fallbackFilter {
    return Intl.message(
      'Fallback filter',
      name: 'fallbackFilter',
      desc: '',
      args: [],
    );
  }

  /// `Geoip code`
  String get geoipCode {
    return Intl.message('Geoip code', name: 'geoipCode', desc: '', args: []);
  }

  /// `Ipcidr`
  String get ipcidr {
    return Intl.message('Ipcidr', name: 'ipcidr', desc: '', args: []);
  }

  /// `Domain`
  String get domain {
    return Intl.message('Domain', name: 'domain', desc: '', args: []);
  }

  /// `Reset`
  String get reset {
    return Intl.message('Reset', name: 'reset', desc: '', args: []);
  }

  /// `Show/Hide`
  String get action_view {
    return Intl.message('Show/Hide', name: 'action_view', desc: '', args: []);
  }

  /// `Start/Stop`
  String get action_start {
    return Intl.message('Start/Stop', name: 'action_start', desc: '', args: []);
  }

  /// `Switch mode`
  String get action_mode {
    return Intl.message('Switch mode', name: 'action_mode', desc: '', args: []);
  }

  /// `System proxy`
  String get action_proxy {
    return Intl.message(
      'System proxy',
      name: 'action_proxy',
      desc: '',
      args: [],
    );
  }

  /// `TUN`
  String get action_tun {
    return Intl.message('TUN', name: 'action_tun', desc: '', args: []);
  }

  /// `Hotkey Management`
  String get hotkeyManagement {
    return Intl.message(
      'Hotkey Management',
      name: 'hotkeyManagement',
      desc: '',
      args: [],
    );
  }

  /// `Use keyboard to control applications`
  String get hotkeyManagementDesc {
    return Intl.message(
      'Use keyboard to control applications',
      name: 'hotkeyManagementDesc',
      desc: '',
      args: [],
    );
  }

  /// `Please press the keyboard.`
  String get pressKeyboard {
    return Intl.message(
      'Please press the keyboard.',
      name: 'pressKeyboard',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the correct hotkey`
  String get inputCorrectHotkey {
    return Intl.message(
      'Please enter the correct hotkey',
      name: 'inputCorrectHotkey',
      desc: '',
      args: [],
    );
  }

  /// `Hotkey conflict`
  String get hotkeyConflict {
    return Intl.message(
      'Hotkey conflict',
      name: 'hotkeyConflict',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message('Remove', name: 'remove', desc: '', args: []);
  }

  /// `No HotKey`
  String get noHotKey {
    return Intl.message('No HotKey', name: 'noHotKey', desc: '', args: []);
  }

  /// `No network`
  String get noNetwork {
    return Intl.message('No network', name: 'noNetwork', desc: '', args: []);
  }

  /// `Allow IPv6 inbound`
  String get ipv6InboundDesc {
    return Intl.message(
      'Allow IPv6 inbound',
      name: 'ipv6InboundDesc',
      desc: '',
      args: [],
    );
  }

  /// `Export logs`
  String get exportLogs {
    return Intl.message('Export logs', name: 'exportLogs', desc: '', args: []);
  }

  /// `Export Success`
  String get exportSuccess {
    return Intl.message(
      'Export Success',
      name: 'exportSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Icon style`
  String get iconStyle {
    return Intl.message('Icon style', name: 'iconStyle', desc: '', args: []);
  }

  /// `Icon`
  String get onlyIcon {
    return Intl.message('Icon', name: 'onlyIcon', desc: '', args: []);
  }

  /// `Stack mode`
  String get stackMode {
    return Intl.message('Stack mode', name: 'stackMode', desc: '', args: []);
  }

  /// `Network`
  String get network {
    return Intl.message('Network', name: 'network', desc: '', args: []);
  }

  /// `Modify network-related settings`
  String get networkDesc {
    return Intl.message(
      'Modify network-related settings',
      name: 'networkDesc',
      desc: '',
      args: [],
    );
  }

  /// `Bypass domain`
  String get bypassDomain {
    return Intl.message(
      'Bypass domain',
      name: 'bypassDomain',
      desc: '',
      args: [],
    );
  }

  /// `Only takes effect when the system proxy is enabled`
  String get bypassDomainDesc {
    return Intl.message(
      'Only takes effect when the system proxy is enabled',
      name: 'bypassDomainDesc',
      desc: '',
      args: [],
    );
  }

  /// `Make sure to reset`
  String get resetTip {
    return Intl.message(
      'Make sure to reset',
      name: 'resetTip',
      desc: '',
      args: [],
    );
  }

  /// `Icon`
  String get icon {
    return Intl.message('Icon', name: 'icon', desc: '', args: []);
  }

  /// `No data`
  String get noData {
    return Intl.message('No data', name: 'noData', desc: '', args: []);
  }

  /// `FontFamily`
  String get fontFamily {
    return Intl.message('FontFamily', name: 'fontFamily', desc: '', args: []);
  }

  /// `Toggle`
  String get toggle {
    return Intl.message('Toggle', name: 'toggle', desc: '', args: []);
  }

  /// `System`
  String get system {
    return Intl.message('System', name: 'system', desc: '', args: []);
  }

  /// `Route mode`
  String get routeMode {
    return Intl.message('Route mode', name: 'routeMode', desc: '', args: []);
  }

  /// `Bypass private route address`
  String get routeMode_bypassPrivate {
    return Intl.message(
      'Bypass private route address',
      name: 'routeMode_bypassPrivate',
      desc: '',
      args: [],
    );
  }

  /// `Use config`
  String get routeMode_config {
    return Intl.message(
      'Use config',
      name: 'routeMode_config',
      desc: '',
      args: [],
    );
  }

  /// `Route address`
  String get routeAddress {
    return Intl.message(
      'Route address',
      name: 'routeAddress',
      desc: '',
      args: [],
    );
  }

  /// `Config listen route address`
  String get routeAddressDesc {
    return Intl.message(
      'Config listen route address',
      name: 'routeAddressDesc',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the admin password`
  String get pleaseInputAdminPassword {
    return Intl.message(
      'Please enter the admin password',
      name: 'pleaseInputAdminPassword',
      desc: '',
      args: [],
    );
  }

  /// `TUN could not be enabled because administrator authorization was denied. Allow the system permission prompt and try again.`
  String get tunAuthorizationFailed {
    return Intl.message(
      'TUN could not be enabled because administrator authorization was denied. Allow the system permission prompt and try again.',
      name: 'tunAuthorizationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Copying environment variables`
  String get copyEnvVar {
    return Intl.message(
      'Copying environment variables',
      name: 'copyEnvVar',
      desc: '',
      args: [],
    );
  }

  /// `Memory info`
  String get memoryInfo {
    return Intl.message('Memory info', name: 'memoryInfo', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `The file has been modified. Do you want to save the changes?`
  String get fileIsUpdate {
    return Intl.message(
      'The file has been modified. Do you want to save the changes?',
      name: 'fileIsUpdate',
      desc: '',
      args: [],
    );
  }

  /// `The profile has been modified. Do you want to disable auto update?`
  String get profileHasUpdate {
    return Intl.message(
      'The profile has been modified. Do you want to disable auto update?',
      name: 'profileHasUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to cache the changes?`
  String get hasCacheChange {
    return Intl.message(
      'Do you want to cache the changes?',
      name: 'hasCacheChange',
      desc: '',
      args: [],
    );
  }

  /// `Copy success`
  String get copySuccess {
    return Intl.message(
      'Copy success',
      name: 'copySuccess',
      desc: '',
      args: [],
    );
  }

  /// `Copy link`
  String get copyLink {
    return Intl.message('Copy link', name: 'copyLink', desc: '', args: []);
  }

  /// `Export file`
  String get exportFile {
    return Intl.message('Export file', name: 'exportFile', desc: '', args: []);
  }

  /// `The cache is corrupt. Do you want to clear it?`
  String get cacheCorrupt {
    return Intl.message(
      'The cache is corrupt. Do you want to clear it?',
      name: 'cacheCorrupt',
      desc: '',
      args: [],
    );
  }

  /// `Relying on third-party api is for reference only`
  String get detectionTip {
    return Intl.message(
      'Relying on third-party api is for reference only',
      name: 'detectionTip',
      desc: '',
      args: [],
    );
  }

  /// `Listen`
  String get listen {
    return Intl.message('Listen', name: 'listen', desc: '', args: []);
  }

  /// `undo`
  String get undo {
    return Intl.message('undo', name: 'undo', desc: '', args: []);
  }

  /// `redo`
  String get redo {
    return Intl.message('redo', name: 'redo', desc: '', args: []);
  }

  /// `none`
  String get none {
    return Intl.message('none', name: 'none', desc: '', args: []);
  }

  /// `Basic configuration`
  String get basicConfig {
    return Intl.message(
      'Basic configuration',
      name: 'basicConfig',
      desc: '',
      args: [],
    );
  }

  /// `Modify the basic configuration globally`
  String get basicConfigDesc {
    return Intl.message(
      'Modify the basic configuration globally',
      name: 'basicConfigDesc',
      desc: '',
      args: [],
    );
  }

  /// `Advanced configuration`
  String get advancedConfig {
    return Intl.message(
      'Advanced configuration',
      name: 'advancedConfig',
      desc: '',
      args: [],
    );
  }

  /// `Provide diverse configuration options`
  String get advancedConfigDesc {
    return Intl.message(
      'Provide diverse configuration options',
      name: 'advancedConfigDesc',
      desc: '',
      args: [],
    );
  }

  /// `{count} items have been selected`
  String selectedCountTitle(Object count) {
    return Intl.message(
      '$count items have been selected',
      name: 'selectedCountTitle',
      desc: '',
      args: [count],
    );
  }

  /// `Add rule`
  String get addRule {
    return Intl.message('Add rule', name: 'addRule', desc: '', args: []);
  }

  /// `Rule name`
  String get ruleName {
    return Intl.message('Rule name', name: 'ruleName', desc: '', args: []);
  }

  /// `Content`
  String get content {
    return Intl.message('Content', name: 'content', desc: '', args: []);
  }

  /// `Sub rule`
  String get subRule {
    return Intl.message('Sub rule', name: 'subRule', desc: '', args: []);
  }

  /// `Rule target`
  String get ruleTarget {
    return Intl.message('Rule target', name: 'ruleTarget', desc: '', args: []);
  }

  /// `Source IP`
  String get sourceIp {
    return Intl.message('Source IP', name: 'sourceIp', desc: '', args: []);
  }

  /// `No resolve IP`
  String get noResolve {
    return Intl.message('No resolve IP', name: 'noResolve', desc: '', args: []);
  }

  /// `Do you want to save the changes?`
  String get saveChanges {
    return Intl.message(
      'Do you want to save the changes?',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `There is a certain performance loss after opening`
  String get findProcessModeDesc {
    return Intl.message(
      'There is a certain performance loss after opening',
      name: 'findProcessModeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Effective only in mobile view`
  String get tabAnimationDesc {
    return Intl.message(
      'Effective only in mobile view',
      name: 'tabAnimationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Color schemes`
  String get colorSchemes {
    return Intl.message(
      'Color schemes',
      name: 'colorSchemes',
      desc: '',
      args: [],
    );
  }

  /// `Palette`
  String get palette {
    return Intl.message('Palette', name: 'palette', desc: '', args: []);
  }

  /// `TonalSpot`
  String get tonalSpotScheme {
    return Intl.message(
      'TonalSpot',
      name: 'tonalSpotScheme',
      desc: '',
      args: [],
    );
  }

  /// `Fidelity`
  String get fidelityScheme {
    return Intl.message('Fidelity', name: 'fidelityScheme', desc: '', args: []);
  }

  /// `Monochrome`
  String get monochromeScheme {
    return Intl.message(
      'Monochrome',
      name: 'monochromeScheme',
      desc: '',
      args: [],
    );
  }

  /// `Neutral`
  String get neutralScheme {
    return Intl.message('Neutral', name: 'neutralScheme', desc: '', args: []);
  }

  /// `Vibrant`
  String get vibrantScheme {
    return Intl.message('Vibrant', name: 'vibrantScheme', desc: '', args: []);
  }

  /// `Expressive`
  String get expressiveScheme {
    return Intl.message(
      'Expressive',
      name: 'expressiveScheme',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get contentScheme {
    return Intl.message('Content', name: 'contentScheme', desc: '', args: []);
  }

  /// `Rainbow`
  String get rainbowScheme {
    return Intl.message('Rainbow', name: 'rainbowScheme', desc: '', args: []);
  }

  /// `FruitSalad`
  String get fruitSaladScheme {
    return Intl.message(
      'FruitSalad',
      name: 'fruitSaladScheme',
      desc: '',
      args: [],
    );
  }

  /// `Developer mode`
  String get developerMode {
    return Intl.message(
      'Developer mode',
      name: 'developerMode',
      desc: '',
      args: [],
    );
  }

  /// `Developer mode is enabled.`
  String get developerModeEnableTip {
    return Intl.message(
      'Developer mode is enabled.',
      name: 'developerModeEnableTip',
      desc: '',
      args: [],
    );
  }

  /// `Message test`
  String get messageTest {
    return Intl.message(
      'Message test',
      name: 'messageTest',
      desc: '',
      args: [],
    );
  }

  /// `This is a message.`
  String get messageTestTip {
    return Intl.message(
      'This is a message.',
      name: 'messageTestTip',
      desc: '',
      args: [],
    );
  }

  /// `Crash test`
  String get crashTest {
    return Intl.message('Crash test', name: 'crashTest', desc: '', args: []);
  }

  /// `Clear Data`
  String get clearData {
    return Intl.message('Clear Data', name: 'clearData', desc: '', args: []);
  }

  /// `Text Scaling`
  String get textScale {
    return Intl.message('Text Scaling', name: 'textScale', desc: '', args: []);
  }

  /// `Internet`
  String get internet {
    return Intl.message('Internet', name: 'internet', desc: '', args: []);
  }

  /// `System APP`
  String get systemApp {
    return Intl.message('System APP', name: 'systemApp', desc: '', args: []);
  }

  /// `No network APP`
  String get noNetworkApp {
    return Intl.message(
      'No network APP',
      name: 'noNetworkApp',
      desc: '',
      args: [],
    );
  }

  /// `Restore strategy`
  String get restoreStrategy {
    return Intl.message(
      'Restore strategy',
      name: 'restoreStrategy',
      desc: '',
      args: [],
    );
  }

  /// `Override`
  String get restoreStrategy_override {
    return Intl.message(
      'Override',
      name: 'restoreStrategy_override',
      desc: '',
      args: [],
    );
  }

  /// `Compatible`
  String get restoreStrategy_compatible {
    return Intl.message(
      'Compatible',
      name: 'restoreStrategy_compatible',
      desc: '',
      args: [],
    );
  }

  /// `Logs test`
  String get logsTest {
    return Intl.message('Logs test', name: 'logsTest', desc: '', args: []);
  }

  /// `{label} cannot be empty`
  String emptyTip(Object label) {
    return Intl.message(
      '$label cannot be empty',
      name: 'emptyTip',
      desc: '',
      args: [label],
    );
  }

  /// `{label} must be a url`
  String urlTip(Object label) {
    return Intl.message(
      '$label must be a url',
      name: 'urlTip',
      desc: '',
      args: [label],
    );
  }

  /// `{label} must be a number`
  String numberTip(Object label) {
    return Intl.message(
      '$label must be a number',
      name: 'numberTip',
      desc: '',
      args: [label],
    );
  }

  /// `Interval`
  String get interval {
    return Intl.message('Interval', name: 'interval', desc: '', args: []);
  }

  /// `Current {label} already exists`
  String existsTip(Object label) {
    return Intl.message(
      'Current $label already exists',
      name: 'existsTip',
      desc: '',
      args: [label],
    );
  }

  /// `Are you sure you want to delete the current {label}?`
  String deleteTip(Object label) {
    return Intl.message(
      'Are you sure you want to delete the current $label?',
      name: 'deleteTip',
      desc: '',
      args: [label],
    );
  }

  /// `Are you sure you want to delete the selected {label}?`
  String deleteMultipTip(Object label) {
    return Intl.message(
      'Are you sure you want to delete the selected $label?',
      name: 'deleteMultipTip',
      desc: '',
      args: [label],
    );
  }

  /// `No {label} yet`
  String nullTip(Object label) {
    return Intl.message(
      'No $label yet',
      name: 'nullTip',
      desc: '',
      args: [label],
    );
  }

  /// `Script`
  String get script {
    return Intl.message('Script', name: 'script', desc: '', args: []);
  }

  /// `Color`
  String get color {
    return Intl.message('Color', name: 'color', desc: '', args: []);
  }

  /// `Rename`
  String get rename {
    return Intl.message('Rename', name: 'rename', desc: '', args: []);
  }

  /// `Unnamed`
  String get unnamed {
    return Intl.message('Unnamed', name: 'unnamed', desc: '', args: []);
  }

  /// `Please enter a script name`
  String get pleaseEnterScriptName {
    return Intl.message(
      'Please enter a script name',
      name: 'pleaseEnterScriptName',
      desc: '',
      args: [],
    );
  }

  /// `Mixed Port`
  String get mixedPort {
    return Intl.message('Mixed Port', name: 'mixedPort', desc: '', args: []);
  }

  /// `Socks Port`
  String get socksPort {
    return Intl.message('Socks Port', name: 'socksPort', desc: '', args: []);
  }

  /// `Redir Port`
  String get redirPort {
    return Intl.message('Redir Port', name: 'redirPort', desc: '', args: []);
  }

  /// `Tproxy Port`
  String get tproxyPort {
    return Intl.message('Tproxy Port', name: 'tproxyPort', desc: '', args: []);
  }

  /// `{label} must be between 1024 and 49151`
  String portTip(Object label) {
    return Intl.message(
      '$label must be between 1024 and 49151',
      name: 'portTip',
      desc: '',
      args: [label],
    );
  }

  /// `Please enter a different port`
  String get portConflictTip {
    return Intl.message(
      'Please enter a different port',
      name: 'portConflictTip',
      desc: '',
      args: [],
    );
  }

  /// `Port unavailable`
  String get portUnavailableTitle {
    return Intl.message(
      'Port unavailable',
      name: 'portUnavailableTitle',
      desc: '',
      args: [],
    );
  }

  /// `The mixed port {port} could not start listening and may be in use by another application. Change the port to retry immediately.`
  String portUnavailableMessage(Object port) {
    return Intl.message(
      'The mixed port $port could not start listening and may be in use by another application. Change the port to retry immediately.',
      name: 'portUnavailableMessage',
      desc: '',
      args: [port],
    );
  }

  /// `Save and retry`
  String get saveAndRetry {
    return Intl.message(
      'Save and retry',
      name: 'saveAndRetry',
      desc: '',
      args: [],
    );
  }

  /// `Import`
  String get import {
    return Intl.message('Import', name: 'import', desc: '', args: []);
  }

  /// `Import from file`
  String get importFile {
    return Intl.message(
      'Import from file',
      name: 'importFile',
      desc: '',
      args: [],
    );
  }

  /// `Import from URL`
  String get importUrl {
    return Intl.message(
      'Import from URL',
      name: 'importUrl',
      desc: '',
      args: [],
    );
  }

  /// `Auto set system DNS`
  String get autoSetSystemDns {
    return Intl.message(
      'Auto set system DNS',
      name: 'autoSetSystemDns',
      desc: '',
      args: [],
    );
  }

  /// `Pause proxy when idle`
  String get suspendOnIdle {
    return Intl.message(
      'Pause proxy when idle',
      name: 'suspendOnIdle',
      desc: '',
      args: [],
    );
  }

  /// `Pause traffic forwarding to save power when the screen is off and the system becomes idle. This may disconnect calls and live audio.`
  String get suspendOnIdleDesc {
    return Intl.message(
      'Pause traffic forwarding to save power when the screen is off and the system becomes idle. This may disconnect calls and live audio.',
      name: 'suspendOnIdleDesc',
      desc: '',
      args: [],
    );
  }

  /// `{label} details`
  String details(Object label) {
    return Intl.message(
      '$label details',
      name: 'details',
      desc: '',
      args: [label],
    );
  }

  /// `Creation time`
  String get creationTime {
    return Intl.message(
      'Creation time',
      name: 'creationTime',
      desc: '',
      args: [],
    );
  }

  /// `Process`
  String get process {
    return Intl.message('Process', name: 'process', desc: '', args: []);
  }

  /// `Host`
  String get host {
    return Intl.message('Host', name: 'host', desc: '', args: []);
  }

  /// `Destination`
  String get destination {
    return Intl.message('Destination', name: 'destination', desc: '', args: []);
  }

  /// `Destination GeoIP`
  String get destinationGeoIP {
    return Intl.message(
      'Destination GeoIP',
      name: 'destinationGeoIP',
      desc: '',
      args: [],
    );
  }

  /// `Destination IPASN`
  String get destinationIPASN {
    return Intl.message(
      'Destination IPASN',
      name: 'destinationIPASN',
      desc: '',
      args: [],
    );
  }

  /// `Special proxy`
  String get specialProxy {
    return Intl.message(
      'Special proxy',
      name: 'specialProxy',
      desc: '',
      args: [],
    );
  }

  /// `special rules`
  String get specialRules {
    return Intl.message(
      'special rules',
      name: 'specialRules',
      desc: '',
      args: [],
    );
  }

  /// `Remote destination`
  String get remoteDestination {
    return Intl.message(
      'Remote destination',
      name: 'remoteDestination',
      desc: '',
      args: [],
    );
  }

  /// `Network type`
  String get networkType {
    return Intl.message(
      'Network type',
      name: 'networkType',
      desc: '',
      args: [],
    );
  }

  /// `Proxy chains`
  String get proxyChains {
    return Intl.message(
      'Proxy chains',
      name: 'proxyChains',
      desc: '',
      args: [],
    );
  }

  /// `Proxy chaining can significantly reduce network speed. Keep it disabled unless you clearly need it.`
  String get proxyChainWarning {
    return Intl.message(
      'Proxy chaining can significantly reduce network speed. Keep it disabled unless you clearly need it.',
      name: 'proxyChainWarning',
      desc: '',
      args: [],
    );
  }

  /// `Click nodes in order: the first node is the entry and the last node is the exit. Select the exit node to use the chain.`
  String get proxyChainInstruction {
    return Intl.message(
      'Click nodes in order: the first node is the entry and the last node is the exit. Select the exit node to use the chain.',
      name: 'proxyChainInstruction',
      desc: '',
      args: [],
    );
  }

  /// `Proxy chains require at least 2 nodes`
  String get proxyChainMinimumNodes {
    return Intl.message(
      'Proxy chains require at least 2 nodes',
      name: 'proxyChainMinimumNodes',
      desc: '',
      args: [],
    );
  }

  /// `Proxy chains require at least 2 nodes. Add an exit node.`
  String get proxyChainMinimumNodesHint {
    return Intl.message(
      'Proxy chains require at least 2 nodes. Add an exit node.',
      name: 'proxyChainMinimumNodesHint',
      desc: '',
      args: [],
    );
  }

  /// `Entry`
  String get proxyChainEntry {
    return Intl.message('Entry', name: 'proxyChainEntry', desc: '', args: []);
  }

  /// `Exit`
  String get proxyChainExit {
    return Intl.message('Exit', name: 'proxyChainExit', desc: '', args: []);
  }

  /// `Clear chain config`
  String get clearProxyChain {
    return Intl.message(
      'Clear chain config',
      name: 'clearProxyChain',
      desc: '',
      args: [],
    );
  }

  /// `Custom nodes`
  String get proxyChainCustomNodes {
    return Intl.message(
      'Custom nodes',
      name: 'proxyChainCustomNodes',
      desc: '',
      args: [],
    );
  }

  /// `Custom node`
  String get proxyChainCustomNode {
    return Intl.message(
      'Custom node',
      name: 'proxyChainCustomNode',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get addProxyChainNode {
    return Intl.message('Add', name: 'addProxyChainNode', desc: '', args: []);
  }

  /// `Other nodes`
  String get proxyChainOtherNodes {
    return Intl.message(
      'Other nodes',
      name: 'proxyChainOtherNodes',
      desc: '',
      args: [],
    );
  }

  /// `Proxy chain saved and applied. Select the exit node to use it`
  String get proxyChainSavedAndApplied {
    return Intl.message(
      'Proxy chain saved and applied. Select the exit node to use it',
      name: 'proxyChainSavedAndApplied',
      desc: '',
      args: [],
    );
  }

  /// `Node {name} is already used by another enabled chain or has a proxy chain relation conflict`
  String proxyChainConflictTip(Object name) {
    return Intl.message(
      'Node $name is already used by another enabled chain or has a proxy chain relation conflict',
      name: 'proxyChainConflictTip',
      desc: '',
      args: [name],
    );
  }

  /// `Node {name} is not available in this position`
  String proxyChainUnavailableNodeTip(Object name) {
    return Intl.message(
      'Node $name is not available in this position',
      name: 'proxyChainUnavailableNodeTip',
      desc: '',
      args: [name],
    );
  }

  /// `Related proxy chains updated`
  String get proxyChainRelatedChainsUpdated {
    return Intl.message(
      'Related proxy chains updated',
      name: 'proxyChainRelatedChainsUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Proxy chain`
  String get proxyChainSelectedNodes {
    return Intl.message(
      'Proxy chain',
      name: 'proxyChainSelectedNodes',
      desc: '',
      args: [],
    );
  }

  /// `Available nodes`
  String get proxyChainAvailableNodes {
    return Intl.message(
      'Available nodes',
      name: 'proxyChainAvailableNodes',
      desc: '',
      args: [],
    );
  }

  /// `No nodes in the proxy chain`
  String get proxyChainEmpty {
    return Intl.message(
      'No nodes in the proxy chain',
      name: 'proxyChainEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Node added to proxy chain`
  String get proxyChainNodeAdded {
    return Intl.message(
      'Node added to proxy chain',
      name: 'proxyChainNodeAdded',
      desc: '',
      args: [],
    );
  }

  /// `Supported formats: ss://, ssr://, vmess://, vless://, trojan://, anytls://, hysteria:// / hy://, hysteria2:// / hy2://, tuic://, wireguard:// / wg://, http(s)://, socks(5)://`
  String get proxyChainUriNodeSupportedFormats {
    return Intl.message(
      'Supported formats: ss://, ssr://, vmess://, vless://, trojan://, anytls://, hysteria:// / hy://, hysteria2:// / hy2://, tuic://, wireguard:// / wg://, http(s)://, socks(5)://',
      name: 'proxyChainUriNodeSupportedFormats',
      desc: '',
      args: [],
    );
  }

  /// `Log`
  String get log {
    return Intl.message('Log', name: 'log', desc: '', args: []);
  }

  /// `Connection`
  String get connection {
    return Intl.message('Connection', name: 'connection', desc: '', args: []);
  }

  /// `Request`
  String get request {
    return Intl.message('Request', name: 'request', desc: '', args: []);
  }

  /// `Connected`
  String get connected {
    return Intl.message('Connected', name: 'connected', desc: '', args: []);
  }

  /// `Disconnected`
  String get disconnected {
    return Intl.message(
      'Disconnected',
      name: 'disconnected',
      desc: '',
      args: [],
    );
  }

  /// `Connecting...`
  String get connecting {
    return Intl.message(
      'Connecting...',
      name: 'connecting',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to restart the core?`
  String get restartCoreTip {
    return Intl.message(
      'Are you sure you want to restart the core?',
      name: 'restartCoreTip',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to force restart the core?`
  String get forceRestartCoreTip {
    return Intl.message(
      'Are you sure you want to force restart the core?',
      name: 'forceRestartCoreTip',
      desc: '',
      args: [],
    );
  }

  /// `DNS hijacking`
  String get dnsHijacking {
    return Intl.message(
      'DNS hijacking',
      name: 'dnsHijacking',
      desc: '',
      args: [],
    );
  }

  /// `Core status`
  String get coreStatus {
    return Intl.message('Core status', name: 'coreStatus', desc: '', args: []);
  }

  /// `Append System DNS`
  String get appendSystemDns {
    return Intl.message(
      'Append System DNS',
      name: 'appendSystemDns',
      desc: '',
      args: [],
    );
  }

  /// `Forcefully append system DNS to the configuration`
  String get appendSystemDnsTip {
    return Intl.message(
      'Forcefully append system DNS to the configuration',
      name: 'appendSystemDnsTip',
      desc: '',
      args: [],
    );
  }

  /// `Block QUIC`
  String get blockQuic {
    return Intl.message('Block QUIC', name: 'blockQuic', desc: '', args: []);
  }

  /// `Reject UDP 443 traffic to force connections back to TCP`
  String get blockQuicDesc {
    return Intl.message(
      'Reject UDP 443 traffic to force connections back to TCP',
      name: 'blockQuicDesc',
      desc: '',
      args: [],
    );
  }

  /// `Block WebRTC`
  String get blockWebRtc {
    return Intl.message(
      'Block WebRTC',
      name: 'blockWebRtc',
      desc: '',
      args: [],
    );
  }

  /// `Reject STUN traffic to reduce WebRTC IP leaks. Calls and live audio may stop working.`
  String get blockWebRtcDesc {
    return Intl.message(
      'Reject STUN traffic to reduce WebRTC IP leaks. Calls and live audio may stop working.',
      name: 'blockWebRtcDesc',
      desc: '',
      args: [],
    );
  }

  /// `Edit rule`
  String get editRule {
    return Intl.message('Edit rule', name: 'editRule', desc: '', args: []);
  }

  /// `Override mode`
  String get overrideMode {
    return Intl.message(
      'Override mode',
      name: 'overrideMode',
      desc: '',
      args: [],
    );
  }

  /// `Standard mode, override basic configuration, provide simple rule addition capability`
  String get standardModeDesc {
    return Intl.message(
      'Standard mode, override basic configuration, provide simple rule addition capability',
      name: 'standardModeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Script mode, use external extension scripts, provide one-click override configuration capability`
  String get scriptModeDesc {
    return Intl.message(
      'Script mode, use external extension scripts, provide one-click override configuration capability',
      name: 'scriptModeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Added rules`
  String get addedRules {
    return Intl.message('Added rules', name: 'addedRules', desc: '', args: []);
  }

  /// `Control global added rules`
  String get controlGlobalAddedRules {
    return Intl.message(
      'Control global added rules',
      name: 'controlGlobalAddedRules',
      desc: '',
      args: [],
    );
  }

  /// `Override script`
  String get overrideScript {
    return Intl.message(
      'Override script',
      name: 'overrideScript',
      desc: '',
      args: [],
    );
  }

  /// `Go to configure script`
  String get goToConfigureScript {
    return Intl.message(
      'Go to configure script',
      name: 'goToConfigureScript',
      desc: '',
      args: [],
    );
  }

  /// `Edit global rules`
  String get editGlobalRules {
    return Intl.message(
      'Edit global rules',
      name: 'editGlobalRules',
      desc: '',
      args: [],
    );
  }

  /// `External fetch`
  String get externalFetch {
    return Intl.message(
      'External fetch',
      name: 'externalFetch',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to force crash the core?`
  String get confirmForceCrashCore {
    return Intl.message(
      'Are you sure you want to force crash the core?',
      name: 'confirmForceCrashCore',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to clear all data?`
  String get confirmClearAllData {
    return Intl.message(
      'Are you sure you want to clear all data?',
      name: 'confirmClearAllData',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Load test`
  String get loadTest {
    return Intl.message('Load test', name: 'loadTest', desc: '', args: []);
  }

  /// `{count, plural, =1{1 year ago} other{{count} years ago}}`
  String yearsAgo(num count) {
    return Intl.plural(
      count,
      one: '1 year ago',
      other: '$count years ago',
      name: 'yearsAgo',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =1{1 month ago} other{{count} months ago}}`
  String monthsAgo(num count) {
    return Intl.plural(
      count,
      one: '1 month ago',
      other: '$count months ago',
      name: 'monthsAgo',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =1{1 day ago} other{{count} days ago}}`
  String daysAgo(num count) {
    return Intl.plural(
      count,
      one: '1 day ago',
      other: '$count days ago',
      name: 'daysAgo',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =1{1 hour ago} other{{count} hours ago}}`
  String hoursAgo(num count) {
    return Intl.plural(
      count,
      one: '1 hour ago',
      other: '$count hours ago',
      name: 'hoursAgo',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =1{1 minute ago} other{{count} minutes ago}}`
  String minutesAgo(num count) {
    return Intl.plural(
      count,
      one: '1 minute ago',
      other: '$count minutes ago',
      name: 'minutesAgo',
      desc: '',
      args: [count],
    );
  }

  /// `Just now`
  String get justNow {
    return Intl.message('Just now', name: 'justNow', desc: '', args: []);
  }

  /// `Access Control Settings`
  String get accessControlSettings {
    return Intl.message(
      'Access Control Settings',
      name: 'accessControlSettings',
      desc: '',
      args: [],
    );
  }

  /// `Turn On`
  String get turnOn {
    return Intl.message('Turn On', name: 'turnOn', desc: '', args: []);
  }

  /// `Turn Off`
  String get turnOff {
    return Intl.message('Turn Off', name: 'turnOff', desc: '', args: []);
  }

  /// `VPN configuration change detected`
  String get vpnConfigChangeDetected {
    return Intl.message(
      'VPN configuration change detected',
      name: 'vpnConfigChangeDetected',
      desc: '',
      args: [],
    );
  }

  /// `Restart`
  String get restart {
    return Intl.message('Restart', name: 'restart', desc: '', args: []);
  }

  /// `Speed statistics`
  String get speedStatistics {
    return Intl.message(
      'Speed statistics',
      name: 'speedStatistics',
      desc: '',
      args: [],
    );
  }

  /// `The current page has changes. Are you sure you want to reset?`
  String get resetPageChangesTip {
    return Intl.message(
      'The current page has changes. Are you sure you want to reset?',
      name: 'resetPageChangesTip',
      desc: '',
      args: [],
    );
  }

  /// `Custom`
  String get overwriteTypeCustom {
    return Intl.message(
      'Custom',
      name: 'overwriteTypeCustom',
      desc: '',
      args: [],
    );
  }

  /// `Custom mode, fully customize proxy groups and rules`
  String get overwriteTypeCustomDesc {
    return Intl.message(
      'Custom mode, fully customize proxy groups and rules',
      name: 'overwriteTypeCustomDesc',
      desc: '',
      args: [],
    );
  }

  /// `Custom override is empty. Use Quick fill or add rules and proxy groups first. To keep subscription content, use Overlay mode.`
  String get emptyCustomOverwrite {
    return Intl.message(
      'Custom override is empty. Use Quick fill or add rules and proxy groups first. To keep subscription content, use Overlay mode.',
      name: 'emptyCustomOverwrite',
      desc: '',
      args: [],
    );
  }

  /// `Proxy group is empty`
  String get proxyGroupEmpty {
    return Intl.message(
      'Proxy group is empty',
      name: 'proxyGroupEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Proxy group name cannot be empty`
  String get proxyGroupNameEmpty {
    return Intl.message(
      'Proxy group name cannot be empty',
      name: 'proxyGroupNameEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Rule is empty`
  String get ruleEmpty {
    return Intl.message('Rule is empty', name: 'ruleEmpty', desc: '', args: []);
  }

  /// `Existing data will be overwritten after confirmation`
  String get confirmOverwriteTip {
    return Intl.message(
      'Existing data will be overwritten after confirmation',
      name: 'confirmOverwriteTip',
      desc: '',
      args: [],
    );
  }

  /// `Data detected in configuration`
  String get configDataDetected {
    return Intl.message(
      'Data detected in configuration',
      name: 'configDataDetected',
      desc: '',
      args: [],
    );
  }

  /// `Quick fill`
  String get quickFill {
    return Intl.message('Quick fill', name: 'quickFill', desc: '', args: []);
  }

  /// `Clear all`
  String get clearCustomRouting {
    return Intl.message(
      'Clear all',
      name: 'clearCustomRouting',
      desc: '',
      args: [],
    );
  }

  /// `Clear this profile’s custom proxy groups and rules? Subscription content, added rules, proxy chains, and custom nodes will be kept.`
  String get confirmClearCustomRouting {
    return Intl.message(
      'Clear this profile’s custom proxy groups and rules? Subscription content, added rules, proxy chains, and custom nodes will be kept.',
      name: 'confirmClearCustomRouting',
      desc: '',
      args: [],
    );
  }

  /// `Add proxy group`
  String get addProxyGroup {
    return Intl.message(
      'Add proxy group',
      name: 'addProxyGroup',
      desc: '',
      args: [],
    );
  }

  /// `Edit proxy group`
  String get editProxyGroup {
    return Intl.message(
      'Edit proxy group',
      name: 'editProxyGroup',
      desc: '',
      args: [],
    );
  }

  /// `Lazy loading`
  String get lazy {
    return Intl.message('Lazy loading', name: 'lazy', desc: '', args: []);
  }

  /// `Proxy filter`
  String get proxyFilter {
    return Intl.message(
      'Proxy filter',
      name: 'proxyFilter',
      desc: '',
      args: [],
    );
  }

  /// `Exclude proxy filter`
  String get excludeProxyFilter {
    return Intl.message(
      'Exclude proxy filter',
      name: 'excludeProxyFilter',
      desc: '',
      args: [],
    );
  }

  /// `Exclude type`
  String get excludeType {
    return Intl.message(
      'Exclude type',
      name: 'excludeType',
      desc: '',
      args: [],
    );
  }

  /// `Expected status`
  String get expectedStatus {
    return Intl.message(
      'Expected status',
      name: 'expectedStatus',
      desc: '',
      args: [],
    );
  }

  /// `Max failed times`
  String get maxFailedTimes {
    return Intl.message(
      'Max failed times',
      name: 'maxFailedTimes',
      desc: '',
      args: [],
    );
  }

  /// `Timeout`
  String get timeout {
    return Intl.message('Timeout', name: 'timeout', desc: '', args: []);
  }

  /// `Strategy`
  String get strategy {
    return Intl.message('Strategy', name: 'strategy', desc: '', args: []);
  }

  /// `Icon URL`
  String get iconUrl {
    return Intl.message('Icon URL', name: 'iconUrl', desc: '', args: []);
  }

  /// `Disable UDP`
  String get disableUDP {
    return Intl.message('Disable UDP', name: 'disableUDP', desc: '', args: []);
  }

  /// `Hide from list`
  String get hideFromList {
    return Intl.message(
      'Hide from list',
      name: 'hideFromList',
      desc: '',
      args: [],
    );
  }

  /// `Include all proxies and providers`
  String get includeAll {
    return Intl.message(
      'Include all proxies and providers',
      name: 'includeAll',
      desc: '',
      args: [],
    );
  }

  /// `Include all proxies`
  String get includeAllProxies {
    return Intl.message(
      'Include all proxies',
      name: 'includeAllProxies',
      desc: '',
      args: [],
    );
  }

  /// `Include all proxy providers`
  String get includeAllProxyProviders {
    return Intl.message(
      'Include all proxy providers',
      name: 'includeAllProxyProviders',
      desc: '',
      args: [],
    );
  }

  /// `Add a proxy, provider, or include-all option`
  String get proxyGroupMembersEmpty {
    return Intl.message(
      'Add a proxy, provider, or include-all option',
      name: 'proxyGroupMembersEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Tolerance`
  String get tolerance {
    return Intl.message('Tolerance', name: 'tolerance', desc: '', args: []);
  }

  /// `{name} is still referenced by a group, rule, or proxy chain`
  String customOutboundInUse(Object name) {
    return Intl.message(
      '$name is still referenced by a group, rule, or proxy chain',
      name: 'customOutboundInUse',
      desc: '',
      args: [name],
    );
  }

  /// `Relay groups were removed by the core. Choose another type.`
  String get relayGroupUnsupported {
    return Intl.message(
      'Relay groups were removed by the core. Choose another type.',
      name: 'relayGroupUnsupported',
      desc: '',
      args: [],
    );
  }

  /// `{name} is referenced by the original configuration at {path}`
  String rawOutboundInUse(Object name, Object path) {
    return Intl.message(
      '$name is referenced by the original configuration at $path',
      name: 'rawOutboundInUse',
      desc: '',
      args: [name, path],
    );
  }

  /// `Unknown network error`
  String get unknownNetworkError {
    return Intl.message(
      'Unknown network error',
      name: 'unknownNetworkError',
      desc: '',
      args: [],
    );
  }

  /// `Recovery exception`
  String get restoreException {
    return Intl.message(
      'Recovery exception',
      name: 'restoreException',
      desc: '',
      args: [],
    );
  }

  /// `Network exception, please check your connection and try again`
  String get networkException {
    return Intl.message(
      'Network exception, please check your connection and try again',
      name: 'networkException',
      desc: '',
      args: [],
    );
  }

  /// `Invalid backup file`
  String get invalidBackupFile {
    return Intl.message(
      'Invalid backup file',
      name: 'invalidBackupFile',
      desc: '',
      args: [],
    );
  }

  /// `Prune cache`
  String get pruneCache {
    return Intl.message('Prune cache', name: 'pruneCache', desc: '', args: []);
  }

  /// `Backup and Restore`
  String get backupAndRestore {
    return Intl.message(
      'Backup and Restore',
      name: 'backupAndRestore',
      desc: '',
      args: [],
    );
  }

  /// `Sync data via WebDAV or files`
  String get backupAndRestoreDesc {
    return Intl.message(
      'Sync data via WebDAV or files',
      name: 'backupAndRestoreDesc',
      desc: '',
      args: [],
    );
  }

  /// `Restore`
  String get restore {
    return Intl.message('Restore', name: 'restore', desc: '', args: []);
  }

  /// `Restore Default`
  String get restoreDefault {
    return Intl.message(
      'Restore Default',
      name: 'restoreDefault',
      desc: '',
      args: [],
    );
  }

  /// `Optional Parameters`
  String get optionalParameters {
    return Intl.message(
      'Optional Parameters',
      name: 'optionalParameters',
      desc: '',
      args: [],
    );
  }

  /// `Restore success`
  String get restoreSuccess {
    return Intl.message(
      'Restore success',
      name: 'restoreSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Restore data via WebDAV`
  String get restoreFromWebDAVDesc {
    return Intl.message(
      'Restore data via WebDAV',
      name: 'restoreFromWebDAVDesc',
      desc: '',
      args: [],
    );
  }

  /// `Restore data via file`
  String get restoreFromFileDesc {
    return Intl.message(
      'Restore data via file',
      name: 'restoreFromFileDesc',
      desc: '',
      args: [],
    );
  }

  /// `Restore configuration files only`
  String get restoreOnlyConfig {
    return Intl.message(
      'Restore configuration files only',
      name: 'restoreOnlyConfig',
      desc: '',
      args: [],
    );
  }

  /// `Restore all data`
  String get restoreAllData {
    return Intl.message(
      'Restore all data',
      name: 'restoreAllData',
      desc: '',
      args: [],
    );
  }

  /// `Add Profile`
  String get addProfile {
    return Intl.message('Add Profile', name: 'addProfile', desc: '', args: []);
  }

  /// `Delay Test`
  String get delayTest {
    return Intl.message('Delay Test', name: 'delayTest', desc: '', args: []);
  }

  /// `User Center`
  String get userCenter {
    return Intl.message('User Center', name: 'userCenter', desc: '', args: []);
  }

  /// `User Center (Backup)`
  String get userCenterFallback {
    return Intl.message(
      'User Center (Backup)',
      name: 'userCenterFallback',
      desc: '',
      args: [],
    );
  }

  /// `Software Center`
  String get softwareCenter {
    return Intl.message(
      'Software Center',
      name: 'softwareCenter',
      desc: '',
      args: [],
    );
  }

  /// `Document Center`
  String get documentCenter {
    return Intl.message(
      'Document Center',
      name: 'documentCenter',
      desc: '',
      args: [],
    );
  }

  /// `oixCloud`
  String get oixCloud {
    return Intl.message('oixCloud', name: 'oixCloud', desc: '', args: []);
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Create Account`
  String get registerTitle {
    return Intl.message(
      'Create Account',
      name: 'registerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Registration failed`
  String get registerFailed {
    return Intl.message(
      'Registration failed',
      name: 'registerFailed',
      desc: '',
      args: [],
    );
  }

  /// `Registration is currently closed`
  String get registerClosed {
    return Intl.message(
      'Registration is currently closed',
      name: 'registerClosed',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get haveAccountAlready {
    return Intl.message(
      'Already have an account?',
      name: 'haveAccountAlready',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get goLogin {
    return Intl.message('Log in', name: 'goLogin', desc: '', args: []);
  }

  /// `Nickname`
  String get nicknameLabel {
    return Intl.message('Nickname', name: 'nicknameLabel', desc: '', args: []);
  }

  /// `Letters and numbers, up to 12 characters`
  String get nicknameHint {
    return Intl.message(
      'Letters and numbers, up to 12 characters',
      name: 'nicknameHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a nickname`
  String get nicknameValidation {
    return Intl.message(
      'Please enter a nickname',
      name: 'nicknameValidation',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPasswordLabel {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Re-enter your password`
  String get confirmPasswordHint {
    return Intl.message(
      'Re-enter your password',
      name: 'confirmPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get confirmPasswordValidation {
    return Intl.message(
      'Please confirm your password',
      name: 'confirmPasswordValidation',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordMismatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `10-36 chars incl. upper/lowercase, number and symbol`
  String get passwordRuleHint {
    return Intl.message(
      '10-36 chars incl. upper/lowercase, number and symbol',
      name: 'passwordRuleHint',
      desc: '',
      args: [],
    );
  }

  /// `Invite Code`
  String get inviteCodeLabel {
    return Intl.message(
      'Invite Code',
      name: 'inviteCodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter invite code`
  String get inviteCodeHint {
    return Intl.message(
      'Enter invite code',
      name: 'inviteCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the invite code`
  String get inviteCodeValidation {
    return Intl.message(
      'Please enter the invite code',
      name: 'inviteCodeValidation',
      desc: '',
      args: [],
    );
  }

  /// `Email Code`
  String get emailCodeLabel {
    return Intl.message(
      'Email Code',
      name: 'emailCodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter the 6-digit code`
  String get emailCodeHint {
    return Intl.message(
      'Enter the 6-digit code',
      name: 'emailCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the email code`
  String get emailCodeValidation {
    return Intl.message(
      'Please enter the email code',
      name: 'emailCodeValidation',
      desc: '',
      args: [],
    );
  }

  /// `Send Code`
  String get sendCode {
    return Intl.message('Send Code', name: 'sendCode', desc: '', args: []);
  }

  /// `Resend in {seconds}s`
  String resendCodeIn(Object seconds) {
    return Intl.message(
      'Resend in ${seconds}s',
      name: 'resendCodeIn',
      desc: '',
      args: [seconds],
    );
  }

  /// `Verification code sent`
  String get codeSent {
    return Intl.message(
      'Verification code sent',
      name: 'codeSent',
      desc: '',
      args: [],
    );
  }

  /// `oixCloud`
  String get loggedOutViewTitle {
    return Intl.message(
      'oixCloud',
      name: 'loggedOutViewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Login to view account info and manage subscriptions`
  String get loggedOutViewDesc {
    return Intl.message(
      'Login to view account info and manage subscriptions',
      name: 'loggedOutViewDesc',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginTitle {
    return Intl.message('Login', name: 'loginTitle', desc: '', args: []);
  }

  /// `Prompt`
  String get startCorePromptTitle {
    return Intl.message(
      'Prompt',
      name: 'startCorePromptTitle',
      desc: '',
      args: [],
    );
  }

  /// `Profile has been successfully imported. Do you want to start the core now?`
  String get startCorePromptContent {
    return Intl.message(
      'Profile has been successfully imported. Do you want to start the core now?',
      name: 'startCorePromptContent',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logoutTitle {
    return Intl.message('Logout', name: 'logoutTitle', desc: '', args: []);
  }

  /// `Sign out?`
  String get logoutContent {
    return Intl.message('Sign out?', name: 'logoutContent', desc: '', args: []);
  }

  /// `Login Successful`
  String get loginSuccess {
    return Intl.message(
      'Login Successful',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Profile imported successfully`
  String get getProfileSuccess {
    return Intl.message(
      'Profile imported successfully',
      name: 'getProfileSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Started successfully`
  String get startSuccess {
    return Intl.message(
      'Started successfully',
      name: 'startSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Login Failed`
  String get loginFailed {
    return Intl.message(
      'Login Failed',
      name: 'loginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Certificate Verification Failed`
  String get invalidCertificateTitle {
    return Intl.message(
      'Certificate Verification Failed',
      name: 'invalidCertificateTitle',
      desc: '',
      args: [],
    );
  }

  /// `The server certificate could not be verified. If you trust this network and server, you can skip verification for this retry only.`
  String get invalidCertificateContent {
    return Intl.message(
      'The server certificate could not be verified. If you trust this network and server, you can skip verification for this retry only.',
      name: 'invalidCertificateContent',
      desc: '',
      args: [],
    );
  }

  /// `Allow Temporarily`
  String get allowTemporarily {
    return Intl.message(
      'Allow Temporarily',
      name: 'allowTemporarily',
      desc: '',
      args: [],
    );
  }

  /// `Email & Password`
  String get emailPassword {
    return Intl.message(
      'Email & Password',
      name: 'emailPassword',
      desc: '',
      args: [],
    );
  }

  /// `Access Token`
  String get accessToken {
    return Intl.message(
      'Access Token',
      name: 'accessToken',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailLabel {
    return Intl.message('Email', name: 'emailLabel', desc: '', args: []);
  }

  /// `Enter email address`
  String get emailHint {
    return Intl.message(
      'Enter email address',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email`
  String get emailValidation {
    return Intl.message(
      'Please enter email',
      name: 'emailValidation',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email format`
  String get emailFormatValidation {
    return Intl.message(
      'Invalid email format',
      name: 'emailFormatValidation',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message('Password', name: 'passwordLabel', desc: '', args: []);
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get resetPasswordTitle {
    return Intl.message(
      'Reset password',
      name: 'resetPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Send reset email`
  String get sendResetEmail {
    return Intl.message(
      'Send reset email',
      name: 'sendResetEmail',
      desc: '',
      args: [],
    );
  }

  /// `Reset email sent. Paste the reset link or code from the email below.`
  String get resetEmailSent {
    return Intl.message(
      'Reset email sent. Paste the reset link or code from the email below.',
      name: 'resetEmailSent',
      desc: '',
      args: [],
    );
  }

  /// `Reset link or code`
  String get resetTokenLabel {
    return Intl.message(
      'Reset link or code',
      name: 'resetTokenLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the reset link or code`
  String get resetTokenValidation {
    return Intl.message(
      'Please enter the reset link or code',
      name: 'resetTokenValidation',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newPasswordLabel {
    return Intl.message(
      'New password',
      name: 'newPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Password has been reset, please sign in with your new password`
  String get resetPasswordSuccess {
    return Intl.message(
      'Password has been reset, please sign in with your new password',
      name: 'resetPasswordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get passwordValidation {
    return Intl.message(
      'Please enter password',
      name: 'passwordValidation',
      desc: '',
      args: [],
    );
  }

  /// `Access Token`
  String get tokenLabel {
    return Intl.message('Access Token', name: 'tokenLabel', desc: '', args: []);
  }

  /// `Please enter Access Token`
  String get tokenValidation {
    return Intl.message(
      'Please enter Access Token',
      name: 'tokenValidation',
      desc: '',
      args: [],
    );
  }

  /// `Expires: {date}`
  String expireDate(Object date) {
    return Intl.message(
      'Expires: $date',
      name: 'expireDate',
      desc: '',
      args: [date],
    );
  }

  /// `Today's Usage`
  String get todayUsed {
    return Intl.message(
      'Today\'s Usage',
      name: 'todayUsed',
      desc: '',
      args: [],
    );
  }

  /// `Remaining: {value}`
  String remaining(Object value) {
    return Intl.message(
      'Remaining: $value',
      name: 'remaining',
      desc: '',
      args: [value],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message('Balance', name: 'balance', desc: '', args: []);
  }

  /// `Commission`
  String get commission {
    return Intl.message('Commission', name: 'commission', desc: '', args: []);
  }

  /// `Points`
  String get points {
    return Intl.message('Points', name: 'points', desc: '', args: []);
  }

  /// `Announcement`
  String get announcement {
    return Intl.message(
      'Announcement',
      name: 'announcement',
      desc: '',
      args: [],
    );
  }

  /// `Service Check Failed`
  String get serviceCheckFailed {
    return Intl.message(
      'Service Check Failed',
      name: 'serviceCheckFailed',
      desc: '',
      args: [],
    );
  }

  /// `API service is operational`
  String get apiAvailable {
    return Intl.message(
      'API service is operational',
      name: 'apiAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Check API`
  String get checkApi {
    return Intl.message('Check API', name: 'checkApi', desc: '', args: []);
  }

  /// `Refresh`
  String get refresh {
    return Intl.message('Refresh', name: 'refresh', desc: '', args: []);
  }

  /// `All Nodes`
  String get allNodes {
    return Intl.message('All Nodes', name: 'allNodes', desc: '', args: []);
  }

  /// `Get all nodes available for your plan`
  String get allNodesDesc {
    return Intl.message(
      'Get all nodes available for your plan',
      name: 'allNodesDesc',
      desc: '',
      args: [],
    );
  }

  /// `Overseas Network Environment`
  String get overseasNetworkEnvironment {
    return Intl.message(
      'Overseas Network Environment',
      name: 'overseasNetworkEnvironment',
      desc: '',
      args: [],
    );
  }

  /// `Turn on this option if you are currently outside mainland China`
  String get overseasNetworkEnvironmentDesc {
    return Intl.message(
      'Turn on this option if you are currently outside mainland China',
      name: 'overseasNetworkEnvironmentDesc',
      desc: '',
      args: [],
    );
  }

  /// `Emergency Mode`
  String get emergencyMode {
    return Intl.message(
      'Emergency Mode',
      name: 'emergencyMode',
      desc: '',
      args: [],
    );
  }

  /// `Enable this option to switch to backup nodes when regular lines are unavailable`
  String get emergencyModeDesc {
    return Intl.message(
      'Enable this option to switch to backup nodes when regular lines are unavailable',
      name: 'emergencyModeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Minimal Configuration`
  String get minimalConfiguration {
    return Intl.message(
      'Minimal Configuration',
      name: 'minimalConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Use a simplified rule set to generate a smaller profile`
  String get minimalConfigurationDesc {
    return Intl.message(
      'Use a simplified rule set to generate a smaller profile',
      name: 'minimalConfigurationDesc',
      desc: '',
      args: [],
    );
  }

  /// `TCP Fast Open`
  String get tcpFastOpen {
    return Intl.message(
      'TCP Fast Open',
      name: 'tcpFastOpen',
      desc: '',
      args: [],
    );
  }

  /// `Enable this option to accelerate TCP connection establishment`
  String get tcpFastOpenDesc {
    return Intl.message(
      'Enable this option to accelerate TCP connection establishment',
      name: 'tcpFastOpenDesc',
      desc: '',
      args: [],
    );
  }

  /// `Store`
  String get store {
    return Intl.message('Store', name: 'store', desc: '', args: []);
  }

  /// `Recharge`
  String get recharge {
    return Intl.message('Recharge', name: 'recharge', desc: '', args: []);
  }

  /// `Choose a Plan`
  String get availablePlans {
    return Intl.message(
      'Choose a Plan',
      name: 'availablePlans',
      desc: '',
      args: [],
    );
  }

  /// `No plans available`
  String get noAvailablePlans {
    return Intl.message(
      'No plans available',
      name: 'noAvailablePlans',
      desc: '',
      args: [],
    );
  }

  /// `Purchased Plans`
  String get myOrders {
    return Intl.message(
      'Purchased Plans',
      name: 'myOrders',
      desc: '',
      args: [],
    );
  }

  /// `No purchased plans yet`
  String get noPurchaseRecords {
    return Intl.message(
      'No purchased plans yet',
      name: 'noPurchaseRecords',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get accountBalance {
    return Intl.message('Balance', name: 'accountBalance', desc: '', args: []);
  }

  /// `Commission ¥ {value}`
  String commissionBalance(Object value) {
    return Intl.message(
      'Commission ¥ $value',
      name: 'commissionBalance',
      desc: '',
      args: [value],
    );
  }

  /// `Sold out`
  String get soldOut {
    return Intl.message('Sold out', name: 'soldOut', desc: '', args: []);
  }

  /// `Only {count} left`
  String remainingStock(Object count) {
    return Intl.message(
      'Only $count left',
      name: 'remainingStock',
      desc: '',
      args: [count],
    );
  }

  /// `Use balance`
  String get buyWithBalance {
    return Intl.message(
      'Use balance',
      name: 'buyWithBalance',
      desc: '',
      args: [],
    );
  }

  /// `Pay online`
  String get orderAndPay {
    return Intl.message('Pay online', name: 'orderAndPay', desc: '', args: []);
  }

  /// `May not be suitable for networks in mainland China`
  String get mainlandNetworkWarning {
    return Intl.message(
      'May not be suitable for networks in mainland China',
      name: 'mainlandNetworkWarning',
      desc: '',
      args: [],
    );
  }

  /// `In use`
  String get planInUse {
    return Intl.message('In use', name: 'planInUse', desc: '', args: []);
  }

  /// `Pending activation`
  String get planNotActivated {
    return Intl.message(
      'Pending activation',
      name: 'planNotActivated',
      desc: '',
      args: [],
    );
  }

  /// `Ended`
  String get planEnded {
    return Intl.message('Ended', name: 'planEnded', desc: '', args: []);
  }

  /// `Plan #{id}`
  String planNumber(Object id) {
    return Intl.message('Plan #$id', name: 'planNumber', desc: '', args: [id]);
  }

  /// `Purchased {time}`
  String purchaseTime(Object time) {
    return Intl.message(
      'Purchased $time',
      name: 'purchaseTime',
      desc: '',
      args: [time],
    );
  }

  /// `Activate`
  String get activate {
    return Intl.message('Activate', name: 'activate', desc: '', args: []);
  }

  /// `Early renewal`
  String get earlyRenew {
    return Intl.message(
      'Early renewal',
      name: 'earlyRenew',
      desc: '',
      args: [],
    );
  }

  /// `Auto-renew on`
  String get autoRenewOn {
    return Intl.message(
      'Auto-renew on',
      name: 'autoRenewOn',
      desc: '',
      args: [],
    );
  }

  /// `Auto-renew off`
  String get autoRenewOff {
    return Intl.message(
      'Auto-renew off',
      name: 'autoRenewOff',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade plan`
  String get upgradePlan {
    return Intl.message(
      'Upgrade plan',
      name: 'upgradePlan',
      desc: '',
      args: [],
    );
  }

  /// `No payment methods available`
  String get noPaymentMethods {
    return Intl.message(
      'No payment methods available',
      name: 'noPaymentMethods',
      desc: '',
      args: [],
    );
  }

  /// `Activate plan`
  String get activatePlanTitle {
    return Intl.message(
      'Activate plan',
      name: 'activatePlanTitle',
      desc: '',
      args: [],
    );
  }

  /// `Activate this plan? It will become your active plan.`
  String get activatePlanConfirm {
    return Intl.message(
      'Activate this plan? It will become your active plan.',
      name: 'activatePlanConfirm',
      desc: '',
      args: [],
    );
  }

  /// `No upgradable plans`
  String get noUpgradablePlans {
    return Intl.message(
      'No upgradable plans',
      name: 'noUpgradablePlans',
      desc: '',
      args: [],
    );
  }

  /// `Select upgrade target`
  String get selectUpgradeTarget {
    return Intl.message(
      'Select upgrade target',
      name: 'selectUpgradeTarget',
      desc: '',
      args: [],
    );
  }

  /// `After payment, pull down to refresh and check the result`
  String get refreshAfterPayment {
    return Intl.message(
      'After payment, pull down to refresh and check the result',
      name: 'refreshAfterPayment',
      desc: '',
      args: [],
    );
  }

  /// `Discount code (optional)`
  String get discountCodeOptional {
    return Intl.message(
      'Discount code (optional)',
      name: 'discountCodeOptional',
      desc: '',
      args: [],
    );
  }

  /// `Apply coupon`
  String get bindCoupon {
    return Intl.message('Apply coupon', name: 'bindCoupon', desc: '', args: []);
  }

  /// `Enter an official coupon code. The difference is settled for the remaining plan duration, and a recurring coupon also updates the renewal price.`
  String get bindCouponIntro {
    return Intl.message(
      'Enter an official coupon code. The difference is settled for the remaining plan duration, and a recurring coupon also updates the renewal price.',
      name: 'bindCouponIntro',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verifyCoupon {
    return Intl.message('Verify', name: 'verifyCoupon', desc: '', args: []);
  }

  /// `Discount code`
  String get discountCode {
    return Intl.message(
      'Discount code',
      name: 'discountCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter a discount code`
  String get discountCodeRequired {
    return Intl.message(
      'Enter a discount code',
      name: 'discountCodeRequired',
      desc: '',
      args: [],
    );
  }

  /// `Discounted price`
  String get discountedPriceLabel {
    return Intl.message(
      'Discounted price',
      name: 'discountedPriceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Amount due`
  String get amountDueLabel {
    return Intl.message(
      'Amount due',
      name: 'amountDueLabel',
      desc: '',
      args: [],
    );
  }

  /// `Refund`
  String get refundAmountLabel {
    return Intl.message(
      'Refund',
      name: 'refundAmountLabel',
      desc: '',
      args: [],
    );
  }

  /// `Future automatic renewals keep this discount`
  String get recurringRenewalHint {
    return Intl.message(
      'Future automatic renewals keep this discount',
      name: 'recurringRenewalHint',
      desc: '',
      args: [],
    );
  }

  /// `Insufficient balance. Top up before applying the coupon.`
  String get insufficientBalanceHint {
    return Intl.message(
      'Insufficient balance. Top up before applying the coupon.',
      name: 'insufficientBalanceHint',
      desc: '',
      args: [],
    );
  }

  /// `Amount payable`
  String get amountPayable {
    return Intl.message(
      'Amount payable',
      name: 'amountPayable',
      desc: '',
      args: [],
    );
  }

  /// `Renewal price`
  String get renewalPriceLabel {
    return Intl.message(
      'Renewal price',
      name: 'renewalPriceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Calculating…`
  String get calculatingQuote {
    return Intl.message(
      'Calculating…',
      name: 'calculatingQuote',
      desc: '',
      args: [],
    );
  }

  /// `Enable auto-renew`
  String get enableAutoRenew {
    return Intl.message(
      'Enable auto-renew',
      name: 'enableAutoRenew',
      desc: '',
      args: [],
    );
  }

  /// `Payment method`
  String get paymentMethod {
    return Intl.message(
      'Payment method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get goPay {
    return Intl.message('Pay', name: 'goPay', desc: '', args: []);
  }

  /// `Confirm purchase`
  String get confirmPurchase {
    return Intl.message(
      'Confirm purchase',
      name: 'confirmPurchase',
      desc: '',
      args: [],
    );
  }

  /// `Recharge amount (¥)`
  String get rechargeAmount {
    return Intl.message(
      'Recharge amount (¥)',
      name: 'rechargeAmount',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid amount`
  String get invalidAmount {
    return Intl.message(
      'Please enter a valid amount',
      name: 'invalidAmount',
      desc: '',
      args: [],
    );
  }

  /// `Scan / Transfer payment`
  String get scanOrTransferPay {
    return Intl.message(
      'Scan / Transfer payment',
      name: 'scanOrTransferPay',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Checking...`
  String get checkingPayment {
    return Intl.message(
      'Checking...',
      name: 'checkingPayment',
      desc: '',
      args: [],
    );
  }

  /// `I have paid`
  String get iHavePaid {
    return Intl.message('I have paid', name: 'iHavePaid', desc: '', args: []);
  }

  /// `Open in browser`
  String get openInBrowser {
    return Intl.message(
      'Open in browser',
      name: 'openInBrowser',
      desc: '',
      args: [],
    );
  }

  /// `Scan with Alipay / WeChat to pay`
  String get scanToPayNotice {
    return Intl.message(
      'Scan with Alipay / WeChat to pay',
      name: 'scanToPayNotice',
      desc: '',
      args: [],
    );
  }

  /// `Payment amount`
  String get paymentAmount {
    return Intl.message(
      'Payment amount',
      name: 'paymentAmount',
      desc: '',
      args: [],
    );
  }

  /// `Receiving address`
  String get receivingAddress {
    return Intl.message(
      'Receiving address',
      name: 'receivingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Address copied`
  String get addressCopied {
    return Intl.message(
      'Address copied',
      name: 'addressCopied',
      desc: '',
      args: [],
    );
  }

  /// `The system will confirm automatically after the transfer is completed, and the selected plan will be activated.`
  String get transferConfirmNotice {
    return Intl.message(
      'The system will confirm automatically after the transfer is completed, and the selected plan will be activated.',
      name: 'transferConfirmNotice',
      desc: '',
      args: [],
    );
  }

  /// `Operation successful`
  String get operationSuccess {
    return Intl.message(
      'Operation successful',
      name: 'operationSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Operation failed`
  String get operationFailed {
    return Intl.message(
      'Operation failed',
      name: 'operationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Payment successful`
  String get paymentSuccess {
    return Intl.message(
      'Payment successful',
      name: 'paymentSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Payment request failed`
  String get paymentRequestFailed {
    return Intl.message(
      'Payment request failed',
      name: 'paymentRequestFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load plans`
  String get fetchPlansFailed {
    return Intl.message(
      'Failed to load plans',
      name: 'fetchPlansFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load purchase records`
  String get fetchOrdersFailed {
    return Intl.message(
      'Failed to load purchase records',
      name: 'fetchOrdersFailed',
      desc: '',
      args: [],
    );
  }

  /// `Buy plans · Recharge · Renew & upgrade`
  String get storeSubtitle {
    return Intl.message(
      'Buy plans · Recharge · Renew & upgrade',
      name: 'storeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Payment endpoint returned an unknown format`
  String get paymentUnknownResponse {
    return Intl.message(
      'Payment endpoint returned an unknown format',
      name: 'paymentUnknownResponse',
      desc: '',
      args: [],
    );
  }

  /// `The configuration format is invalid at line {line}.`
  String configParseErrorAtLine(Object line) {
    return Intl.message(
      'The configuration format is invalid at line $line.',
      name: 'configParseErrorAtLine',
      desc: '',
      args: [line],
    );
  }

  /// `Expected {expected}, but found {actual}.`
  String configTypeMismatch(Object expected, Object actual) {
    return Intl.message(
      'Expected $expected, but found $actual.',
      name: 'configTypeMismatch',
      desc: '',
      args: [expected, actual],
    );
  }

  /// `Check the indentation and "-" list markers near this line.`
  String get configYamlFormatHint {
    return Intl.message(
      'Check the indentation and "-" list markers near this line.',
      name: 'configYamlFormatHint',
      desc: '',
      args: [],
    );
  }

  /// `a list`
  String get configValueTypeList {
    return Intl.message(
      'a list',
      name: 'configValueTypeList',
      desc: '',
      args: [],
    );
  }

  /// `an object`
  String get configValueTypeObject {
    return Intl.message(
      'an object',
      name: 'configValueTypeObject',
      desc: '',
      args: [],
    );
  }

  /// `text`
  String get configValueTypeText {
    return Intl.message(
      'text',
      name: 'configValueTypeText',
      desc: '',
      args: [],
    );
  }

  /// `a boolean`
  String get configValueTypeBoolean {
    return Intl.message(
      'a boolean',
      name: 'configValueTypeBoolean',
      desc: '',
      args: [],
    );
  }

  /// `an integer`
  String get configValueTypeInteger {
    return Intl.message(
      'an integer',
      name: 'configValueTypeInteger',
      desc: '',
      args: [],
    );
  }

  /// `a number`
  String get configValueTypeNumber {
    return Intl.message(
      'a number',
      name: 'configValueTypeNumber',
      desc: '',
      args: [],
    );
  }

  /// `an empty value`
  String get configValueTypeNull {
    return Intl.message(
      'an empty value',
      name: 'configValueTypeNull',
      desc: '',
      args: [],
    );
  }

  /// `Recover local configuration`
  String get configRecoveryTitle {
    return Intl.message(
      'Recover local configuration',
      name: 'configRecoveryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Local configuration is temporarily unavailable. Your existing data has been kept. Unlock your device and retry, or reopen the app later.`
  String get configRecoveryMessage {
    return Intl.message(
      'Local configuration is temporarily unavailable. Your existing data has been kept. Unlock your device and retry, or reopen the app later.',
      name: 'configRecoveryMessage',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get configRecoveryRetry {
    return Intl.message(
      'Retry',
      name: 'configRecoveryRetry',
      desc: '',
      args: [],
    );
  }

  /// `GEO download failed`
  String get geoDownloadFailed {
    return Intl.message(
      'GEO download failed',
      name: 'geoDownloadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Download uses the current network rules, or a direct connection when the proxy is unavailable. Retry the current address, choose another source, or enter a custom URL. After validation, the operation will continue automatically.`
  String get geoDownloadRecoveryHint {
    return Intl.message(
      'Download uses the current network rules, or a direct connection when the proxy is unavailable. Retry the current address, choose another source, or enter a custom URL. After validation, the operation will continue automatically.',
      name: 'geoDownloadRecoveryHint',
      desc: '',
      args: [],
    );
  }

  /// `Current address`
  String get geoOriginalSource {
    return Intl.message(
      'Current address',
      name: 'geoOriginalSource',
      desc: '',
      args: [],
    );
  }

  /// `Backup CDN`
  String get geoBackupSource {
    return Intl.message(
      'Backup CDN',
      name: 'geoBackupSource',
      desc: '',
      args: [],
    );
  }

  /// `Download URL`
  String get geoDownloadUrl {
    return Intl.message(
      'Download URL',
      name: 'geoDownloadUrl',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid HTTP or HTTPS URL`
  String get geoInvalidDownloadUrl {
    return Intl.message(
      'Enter a valid HTTP or HTTPS URL',
      name: 'geoInvalidDownloadUrl',
      desc: '',
      args: [],
    );
  }

  /// `Purchase time`
  String get purchasedAtLabel {
    return Intl.message(
      'Purchase time',
      name: 'purchasedAtLabel',
      desc: '',
      args: [],
    );
  }

  /// `Purchase price`
  String get purchasePriceLabel {
    return Intl.message(
      'Purchase price',
      name: 'purchasePriceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Billing period`
  String get billingPeriodLabel {
    return Intl.message(
      'Billing period',
      name: 'billingPeriodLabel',
      desc: '',
      args: [],
    );
  }

  /// `Remaining time`
  String get remainingTimeLabel {
    return Intl.message(
      'Remaining time',
      name: 'remainingTimeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Remaining traffic`
  String get remainingTrafficLabel {
    return Intl.message(
      'Remaining traffic',
      name: 'remainingTrafficLabel',
      desc: '',
      args: [],
    );
  }

  /// `Expires at`
  String get expiresAtLabel {
    return Intl.message(
      'Expires at',
      name: 'expiresAtLabel',
      desc: '',
      args: [],
    );
  }

  /// `Used traffic`
  String get usedTrafficLabel {
    return Intl.message(
      'Used traffic',
      name: 'usedTrafficLabel',
      desc: '',
      args: [],
    );
  }

  /// `Total traffic`
  String get purchaseTotalTrafficLabel {
    return Intl.message(
      'Total traffic',
      name: 'purchaseTotalTrafficLabel',
      desc: '',
      args: [],
    );
  }

  /// `Renewal price`
  String get purchaseRenewalPriceLabel {
    return Intl.message(
      'Renewal price',
      name: 'purchaseRenewalPriceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Auto-renew`
  String get purchaseAutoRenewLabel {
    return Intl.message(
      'Auto-renew',
      name: 'purchaseAutoRenewLabel',
      desc: '',
      args: [],
    );
  }

  /// `{count}d`
  String purchaseDays(Object count) {
    return Intl.message(
      '${count}d',
      name: 'purchaseDays',
      desc: '',
      args: [count],
    );
  }

  /// `{count}h`
  String purchaseHours(Object count) {
    return Intl.message(
      '${count}h',
      name: 'purchaseHours',
      desc: '',
      args: [count],
    );
  }

  /// `{count}m`
  String purchaseMinutes(Object count) {
    return Intl.message(
      '${count}m',
      name: 'purchaseMinutes',
      desc: '',
      args: [count],
    );
  }

  /// `On`
  String get purchaseRenewOn {
    return Intl.message('On', name: 'purchaseRenewOn', desc: '', args: []);
  }

  /// `Off`
  String get purchaseRenewOff {
    return Intl.message('Off', name: 'purchaseRenewOff', desc: '', args: []);
  }

  /// `Overlay`
  String get overwriteTypeMerge {
    return Intl.message(
      'Overlay',
      name: 'overwriteTypeMerge',
      desc: '',
      args: [],
    );
  }

  /// `Keep subscription rules and groups, then add your own. Personal rules take priority over subscription rules; existing added rules keep their priority.`
  String get overwriteTypeMergeDesc {
    return Intl.message(
      'Keep subscription rules and groups, then add your own. Personal rules take priority over subscription rules; existing added rules keep their priority.',
      name: 'overwriteTypeMergeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Personal routing`
  String get personalRouting {
    return Intl.message(
      'Personal routing',
      name: 'personalRouting',
      desc: '',
      args: [],
    );
  }

  /// `Saved separately from the subscription and reapplied after updates. New groups block connections when no members match.`
  String get overlayHint {
    return Intl.message(
      'Saved separately from the subscription and reapplied after updates. New groups block connections when no members match.',
      name: 'overlayHint',
      desc: '',
      args: [],
    );
  }

  /// `The name "{name}" is already used. Rename the personal group to keep both.`
  String overlayNameConflict(Object name) {
    return Intl.message(
      'The name "$name" is already used. Rename the personal group to keep both.',
      name: 'overlayNameConflict',
      desc: '',
      args: [name],
    );
  }

  /// `Unavailable in this configuration. Remove or replace it.`
  String get outboundUnavailable {
    return Intl.message(
      'Unavailable in this configuration. Remove or replace it.',
      name: 'outboundUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Choose members`
  String get chooseMembers {
    return Intl.message(
      'Choose members',
      name: 'chooseMembers',
      desc: '',
      args: [],
    );
  }

  /// `Selection order is the fallback order. Remove and reselect a member to move it to the end.`
  String get memberOrderHint {
    return Intl.message(
      'Selection order is the fallback order. Remove and reselect a member to move it to the end.',
      name: 'memberOrderHint',
      desc: '',
      args: [],
    );
  }

  /// `Automatically include nodes from this configuration as the subscription updates. Use a name filter, such as Japan|JP.`
  String get dynamicMembersHint {
    return Intl.message(
      'Automatically include nodes from this configuration as the subscription updates. Use a name filter, such as Japan|JP.',
      name: 'dynamicMembersHint',
      desc: '',
      args: [],
    );
  }

  /// `No matching results`
  String get noSearchResult {
    return Intl.message(
      'No matching results',
      name: 'noSearchResult',
      desc: '',
      args: [],
    );
  }

  /// `Circular group reference: {name}. Choose a different member.`
  String groupCycleError(Object name) {
    return Intl.message(
      'Circular group reference: $name. Choose a different member.',
      name: 'groupCycleError',
      desc: '',
      args: [name],
    );
  }

  /// `Personal routing rules take effect in Rule mode.`
  String get rulesRequireRuleMode {
    return Intl.message(
      'Personal routing rules take effect in Rule mode.',
      name: 'rulesRequireRuleMode',
      desc: '',
      args: [],
    );
  }

  /// `Check configuration`
  String get checkRouting {
    return Intl.message(
      'Check configuration',
      name: 'checkRouting',
      desc: '',
      args: [],
    );
  }

  /// `Configuration is valid. Personal settings are saved for this profile.`
  String get routingChecked {
    return Intl.message(
      'Configuration is valid. Personal settings are saved for this profile.',
      name: 'routingChecked',
      desc: '',
      args: [],
    );
  }

  /// `Personal settings applied.`
  String get routingApplied {
    return Intl.message(
      'Personal settings applied.',
      name: 'routingApplied',
      desc: '',
      args: [],
    );
  }

  /// `Changes were saved but could not be applied. Check the configuration and retry.`
  String get routingApplyFailed {
    return Intl.message(
      'Changes were saved but could not be applied. Check the configuration and retry.',
      name: 'routingApplyFailed',
      desc: '',
      args: [],
    );
  }

  /// `Form`
  String get customRuleForm {
    return Intl.message('Form', name: 'customRuleForm', desc: '', args: []);
  }

  /// `Rule text`
  String get customRuleRaw {
    return Intl.message('Rule text', name: 'customRuleRaw', desc: '', args: []);
  }

  /// `Enter one complete rule. Advanced expressions are preserved.`
  String get customRuleRawHint {
    return Intl.message(
      'Enter one complete rule. Advanced expressions are preserved.',
      name: 'customRuleRawHint',
      desc: '',
      args: [],
    );
  }

  /// `This rule uses advanced syntax. Edit the rule text to preserve all options.`
  String get customRuleFormUnavailable {
    return Intl.message(
      'This rule uses advanced syntax. Edit the rule text to preserve all options.',
      name: 'customRuleFormUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Enter one complete rule with a valid type, content and target.`
  String get customRuleInvalidSyntax {
    return Intl.message(
      'Enter one complete rule with a valid type, content and target.',
      name: 'customRuleInvalidSyntax',
      desc: '',
      args: [],
    );
  }

  /// `Check the content for this rule type. Example: {example}`
  String customRuleInvalidContent(Object example) {
    return Intl.message(
      'Check the content for this rule type. Example: $example',
      name: 'customRuleInvalidContent',
      desc: '',
      args: [example],
    );
  }

  /// `{name} is unavailable. Choose a target from this configuration.`
  String customRuleUnavailableTarget(Object name) {
    return Intl.message(
      '$name is unavailable. Choose a target from this configuration.',
      name: 'customRuleUnavailableTarget',
      desc: '',
      args: [name],
    );
  }

  /// `{name} is unavailable. Choose an existing rule provider.`
  String customRuleUnavailableProvider(Object name) {
    return Intl.message(
      '$name is unavailable. Choose an existing rule provider.',
      name: 'customRuleUnavailableProvider',
      desc: '',
      args: [name],
    );
  }

  /// `Choose a target`
  String get customRuleChooseTarget {
    return Intl.message(
      'Choose a target',
      name: 'customRuleChooseTarget',
      desc: '',
      args: [],
    );
  }

  /// `Choose a rule provider`
  String get customRuleChooseProvider {
    return Intl.message(
      'Choose a rule provider',
      name: 'customRuleChooseProvider',
      desc: '',
      args: [],
    );
  }

  /// `Matches all remaining traffic. Rules below it will not be reached.`
  String get customRuleMatchHint {
    return Intl.message(
      'Matches all remaining traffic. Rules below it will not be reached.',
      name: 'customRuleMatchHint',
      desc: '',
      args: [],
    );
  }

  /// `Matches this domain and its subdomains. Enter a domain without https:// or a path.`
  String get customRuleDomainSuffixHint {
    return Intl.message(
      'Matches this domain and its subdomains. Enter a domain without https:// or a path.',
      name: 'customRuleDomainSuffixHint',
      desc: '',
      args: [],
    );
  }

  /// `Choose a policy group, proxy or built-in action.`
  String get customRuleTargetHint {
    return Intl.message(
      'Choose a policy group, proxy or built-in action.',
      name: 'customRuleTargetHint',
      desc: '',
      args: [],
    );
  }

  /// `Match known IP addresses without resolving domain names.`
  String get customRuleNoResolveHint {
    return Intl.message(
      'Match known IP addresses without resolving domain names.',
      name: 'customRuleNoResolveHint',
      desc: '',
      args: [],
    );
  }

  /// `Save draft`
  String get saveRoutingDraft {
    return Intl.message(
      'Save draft',
      name: 'saveRoutingDraft',
      desc: '',
      args: [],
    );
  }

  /// `Save a draft to fix other items. Settings are applied only after the full configuration passes validation.`
  String get routingDraftHint {
    return Intl.message(
      'Save a draft to fix other items. Settings are applied only after the full configuration passes validation.',
      name: 'routingDraftHint',
      desc: '',
      args: [],
    );
  }

  /// `Filters automatically included and provider nodes. Manually selected members are always kept.`
  String get groupFilterHint {
    return Intl.message(
      'Filters automatically included and provider nodes. Manually selected members are always kept.',
      name: 'groupFilterHint',
      desc: '',
      args: [],
    );
  }

  /// `Manual selection`
  String get groupTypeSelect {
    return Intl.message(
      'Manual selection',
      name: 'groupTypeSelect',
      desc: '',
      args: [],
    );
  }

  /// `Automatic selection`
  String get groupTypeUrlTest {
    return Intl.message(
      'Automatic selection',
      name: 'groupTypeUrlTest',
      desc: '',
      args: [],
    );
  }

  /// `Failover`
  String get groupTypeFallback {
    return Intl.message(
      'Failover',
      name: 'groupTypeFallback',
      desc: '',
      args: [],
    );
  }

  /// `Load balancing`
  String get groupTypeLoadBalance {
    return Intl.message(
      'Load balancing',
      name: 'groupTypeLoadBalance',
      desc: '',
      args: [],
    );
  }

  /// `Choose the active member on the Proxies page.`
  String get groupTypeSelectHint {
    return Intl.message(
      'Choose the active member on the Proxies page.',
      name: 'groupTypeSelectHint',
      desc: '',
      args: [],
    );
  }

  /// `Periodically test members and select a low-latency node.`
  String get groupTypeUrlTestHint {
    return Intl.message(
      'Periodically test members and select a low-latency node.',
      name: 'groupTypeUrlTestHint',
      desc: '',
      args: [],
    );
  }

  /// `Try members in order and switch when the current member fails.`
  String get groupTypeFallbackHint {
    return Intl.message(
      'Try members in order and switch when the current member fails.',
      name: 'groupTypeFallbackHint',
      desc: '',
      args: [],
    );
  }

  /// `Distribute connections across available members.`
  String get groupTypeLoadBalanceHint {
    return Intl.message(
      'Distribute connections across available members.',
      name: 'groupTypeLoadBalanceHint',
      desc: '',
      args: [],
    );
  }

  /// `Group type`
  String get routingGroupType {
    return Intl.message(
      'Group type',
      name: 'routingGroupType',
      desc: '',
      args: [],
    );
  }

  /// `Rule type`
  String get customRuleType {
    return Intl.message(
      'Rule type',
      name: 'customRuleType',
      desc: '',
      args: [],
    );
  }

  /// `This configuration changed while it was being edited or checked. Reopen the editor or check it again.`
  String get routingChanged {
    return Intl.message(
      'This configuration changed while it was being edited or checked. Reopen the editor or check it again.',
      name: 'routingChanged',
      desc: '',
      args: [],
    );
  }

  /// `Edit custom routing`
  String get editCustomRouting {
    return Intl.message(
      'Edit custom routing',
      name: 'editCustomRouting',
      desc: '',
      args: [],
    );
  }

  /// `Fill in your custom routing, then switch to Custom mode. Editing this draft does not change the current mode.`
  String get customRoutingDraftHint {
    return Intl.message(
      'Fill in your custom routing, then switch to Custom mode. Editing this draft does not change the current mode.',
      name: 'customRoutingDraftHint',
      desc: '',
      args: [],
    );
  }

  /// `Windows blocked the proxy core from starting (system error {code}). Check Protection history in Windows Security and your app control policy, and verify the installer source and signature.`
  String coreBlockedByPolicyTip(int code) {
    return Intl.message(
      'Windows blocked the proxy core from starting (system error $code). Check Protection history in Windows Security and your app control policy, and verify the installer source and signature.',
      name: 'coreBlockedByPolicyTip',
      desc: '',
      args: [code],
    );
  }

  /// `Startup recovery`
  String get startupRecoveryTitle {
    return Intl.message(
      'Startup recovery',
      name: 'startupRecoveryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Two recent startup attempts failed. Automatic profile application and VPN start are paused for this launch. Your selected profile and settings are preserved. Check the configuration, then press Start to retry. An already running VPN is kept active.`
  String get startupRecoveryTip {
    return Intl.message(
      'Two recent startup attempts failed. Automatic profile application and VPN start are paused for this launch. Your selected profile and settings are preserved. Check the configuration, then press Start to retry. An already running VPN is kept active.',
      name: 'startupRecoveryTip',
      desc: '',
      args: [],
    );
  }

  /// `Local proxy authentication`
  String get authentication {
    return Intl.message(
      'Local proxy authentication',
      name: 'authentication',
      desc: '',
      args: [],
    );
  }

  /// `Require a username and password for HTTP/SOCKS proxies. Automatic system HTTP proxy is suspended; TUN/VPN remains available.`
  String get authenticationDesc {
    return Intl.message(
      'Require a username and password for HTTP/SOCKS proxies. Automatic system HTTP proxy is suspended; TUN/VPN remains available.',
      name: 'authenticationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Not applied while local proxy authentication is enabled`
  String get authenticationSystemProxyDesc {
    return Intl.message(
      'Not applied while local proxy authentication is enabled',
      name: 'authenticationSystemProxyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Use 1–255 UTF-8 bytes, without colons or control characters`
  String get authenticationUsernameInvalid {
    return Intl.message(
      'Use 1–255 UTF-8 bytes, without colons or control characters',
      name: 'authenticationUsernameInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Use 1–255 UTF-8 bytes, without control characters`
  String get authenticationPasswordInvalid {
    return Intl.message(
      'Use 1–255 UTF-8 bytes, without control characters',
      name: 'authenticationPasswordInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Could not apply authentication settings`
  String get authenticationApplyFailed {
    return Intl.message(
      'Could not apply authentication settings',
      name: 'authenticationApplyFailed',
      desc: '',
      args: [],
    );
  }

  /// `Installed apps permission required`
  String get installedAppsPermissionRequired {
    return Intl.message(
      'Installed apps permission required',
      name: 'installedAppsPermissionRequired',
      desc: '',
      args: [],
    );
  }

  /// `Allow access to the installed app list to choose which apps use the VPN.`
  String get installedAppsPermissionDesc {
    return Intl.message(
      'Allow access to the installed app list to choose which apps use the VPN.',
      name: 'installedAppsPermissionDesc',
      desc: '',
      args: [],
    );
  }

  /// `Permission was not granted. You can enable it in system settings.`
  String get installedAppsPermissionDeniedMessage {
    return Intl.message(
      'Permission was not granted. You can enable it in system settings.',
      name: 'installedAppsPermissionDeniedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Allow access`
  String get installedAppsPermissionGrant {
    return Intl.message(
      'Allow access',
      name: 'installedAppsPermissionGrant',
      desc: '',
      args: [],
    );
  }

  /// `Could not load installed apps. Please try again.`
  String get installedAppsLoadFailed {
    return Intl.message(
      'Could not load installed apps. Please try again.',
      name: 'installedAppsLoadFailed',
      desc: '',
      args: [],
    );
  }

  /// `The encryption key for your existing configuration is missing or invalid. Try the original system account on the original device or restore a backup. Retrying cannot recreate a lost key.`
  String get configRecoveryMissingKey {
    return Intl.message(
      'The encryption key for your existing configuration is missing or invalid. Try the original system account on the original device or restore a backup. Retrying cannot recreate a lost key.',
      name: 'configRecoveryMissingKey',
      desc: '',
      args: [],
    );
  }

  /// `The local configuration cannot be decrypted or is damaged. Existing files have been kept. Restore the matching key and configuration backup, or back up and reset.`
  String get configRecoveryUnreadable {
    return Intl.message(
      'The local configuration cannot be decrypted or is damaged. Existing files have been kept. Restore the matching key and configuration backup, or back up and reset.',
      name: 'configRecoveryUnreadable',
      desc: '',
      args: [],
    );
  }

  /// `The local configuration or its encryption key could not be read or saved. Check access to the application data folder and the system secure storage, then retry.`
  String get configRecoveryStorage {
    return Intl.message(
      'The local configuration or its encryption key could not be read or saved. Check access to the application data folder and the system secure storage, then retry.',
      name: 'configRecoveryStorage',
      desc: '',
      args: [],
    );
  }

  /// `Back up and reset`
  String get configRecoveryReset {
    return Intl.message(
      'Back up and reset',
      name: 'configRecoveryReset',
      desc: '',
      args: [],
    );
  }

  /// `Create an encrypted backup of all local settings, subscriptions, rules and account data, then reset the application? You will need to sign in again and restore or import your subscriptions and settings. The backup is protected by this Windows account; it cannot recover a lost encryption key.`
  String get configRecoveryResetConfirm {
    return Intl.message(
      'Create an encrypted backup of all local settings, subscriptions, rules and account data, then reset the application? You will need to sign in again and restore or import your subscriptions and settings. The backup is protected by this Windows account; it cannot recover a lost encryption key.',
      name: 'configRecoveryResetConfirm',
      desc: '',
      args: [],
    );
  }

  /// `An encrypted backup of your original data has been saved in the folder below. Exit and reopen the application to set it up again.`
  String get configRecoveryResetDone {
    return Intl.message(
      'An encrypted backup of your original data has been saved in the folder below. Exit and reopen the application to set it up again.',
      name: 'configRecoveryResetDone',
      desc: '',
      args: [],
    );
  }

  /// `The encrypted backup and reset could not be completed. Surviving original data will not be removed without a verified backup. Retry this operation, or exit and reopen the application to finish it.`
  String get configRecoveryResetFailed {
    return Intl.message(
      'The encrypted backup and reset could not be completed. Surviving original data will not be removed without a verified backup. Retry this operation, or exit and reopen the application to finish it.',
      name: 'configRecoveryResetFailed',
      desc: '',
      args: [],
    );
  }

  /// `Exclude SSIDs`
  String get excludeSsids {
    return Intl.message(
      'Exclude SSIDs',
      name: 'excludeSsids',
      desc: '',
      args: [],
    );
  }

  /// `Pause proxying on the listed Wi-Fi networks; resume after leaving only while the app remains started.`
  String get excludeSsidsDesc {
    return Intl.message(
      'Pause proxying on the listed Wi-Fi networks; resume after leaving only while the app remains started.',
      name: 'excludeSsidsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Location permission`
  String get locationPermission {
    return Intl.message(
      'Location permission',
      name: 'locationPermission',
      desc: '',
      args: [],
    );
  }

  /// `Location permission required`
  String get locationPermissionRequired {
    return Intl.message(
      'Location permission required',
      name: 'locationPermissionRequired',
      desc: '',
      args: [],
    );
  }

  /// `Location permission was denied, so the current Wi-Fi name cannot be read. Please enable location permission manually in system settings.`
  String get locationPermissionDeniedMessage {
    return Intl.message(
      'Location permission was denied, so the current Wi-Fi name cannot be read. Please enable location permission manually in system settings.',
      name: 'locationPermissionDeniedMessage',
      desc: '',
      args: [],
    );
  }

  /// `1. Open System Settings > Privacy & Security\n2. Choose Location Services\n3. Find and check {appName} in the list\n\nWhen you are done, return to the app to continue. Thank you for your cooperation.`
  String locationPermissionGuide(Object appName) {
    return Intl.message(
      '1. Open System Settings > Privacy & Security\n2. Choose Location Services\n3. Find and check $appName in the list\n\nWhen you are done, return to the app to continue. Thank you for your cooperation.',
      name: 'locationPermissionGuide',
      desc: '',
      args: [appName],
    );
  }

  /// `Allow location access to read Wi-Fi names. On Android, allow precise location all the time and enable system location services.`
  String get ssidPermissionGuide {
    return Intl.message(
      'Allow location access to read Wi-Fi names. On Android, allow precise location all the time and enable system location services.',
      name: 'ssidPermissionGuide',
      desc: '',
      args: [],
    );
  }

  /// `Match target`
  String get matchTargetTitle {
    return Intl.message(
      'Match target',
      name: 'matchTargetTitle',
      desc: '',
      args: [],
    );
  }

  /// `MATCH-TARGET`
  String get matchTarget {
    return Intl.message(
      'MATCH-TARGET',
      name: 'matchTarget',
      desc: '',
      args: [],
    );
  }

  /// `Where rules targeting MATCH-TARGET go. Defaults to the target of the final MATCH rule in this profile.`
  String get matchTargetDesc {
    return Intl.message(
      'Where rules targeting MATCH-TARGET go. Defaults to the target of the final MATCH rule in this profile.',
      name: 'matchTargetDesc',
      desc: '',
      args: [],
    );
  }

  /// `Follow profile`
  String get followProfile {
    return Intl.message(
      'Follow profile',
      name: 'followProfile',
      desc: '',
      args: [],
    );
  }

  /// `Recent icons`
  String get iconHistory {
    return Intl.message(
      'Recent icons',
      name: 'iconHistory',
      desc: '',
      args: [],
    );
  }

  /// `Exit full screen`
  String get exitFullScreen {
    return Intl.message(
      'Exit full screen',
      name: 'exitFullScreen',
      desc: '',
      args: [],
    );
  }

  /// `Restore down`
  String get unmaximize {
    return Intl.message('Restore down', name: 'unmaximize', desc: '', args: []);
  }

  /// `Maximize`
  String get maximize {
    return Intl.message('Maximize', name: 'maximize', desc: '', args: []);
  }

  /// `Unpin window`
  String get unpinWindow {
    return Intl.message(
      'Unpin window',
      name: 'unpinWindow',
      desc: '',
      args: [],
    );
  }

  /// `Pin window`
  String get pinWindow {
    return Intl.message('Pin window', name: 'pinWindow', desc: '', args: []);
  }

  /// `Minimize`
  String get minimize {
    return Intl.message('Minimize', name: 'minimize', desc: '', args: []);
  }

  /// `DNS lookup failed`
  String get cloudApiDnsFailed {
    return Intl.message(
      'DNS lookup failed',
      name: 'cloudApiDnsFailed',
      desc: '',
      args: [],
    );
  }

  /// `DNS returned no address, possibly blocked or a broken system resolver`
  String get cloudApiDnsEmpty {
    return Intl.message(
      'DNS returned no address, possibly blocked or a broken system resolver',
      name: 'cloudApiDnsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `DNS could not find this domain`
  String get cloudApiDnsUnknownHost {
    return Intl.message(
      'DNS could not find this domain',
      name: 'cloudApiDnsUnknownHost',
      desc: '',
      args: [],
    );
  }

  /// `Connection timed out`
  String get cloudApiConnectTimeout {
    return Intl.message(
      'Connection timed out',
      name: 'cloudApiConnectTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Sending the request timed out`
  String get cloudApiSendTimeout {
    return Intl.message(
      'Sending the request timed out',
      name: 'cloudApiSendTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for the response timed out`
  String get cloudApiReceiveTimeout {
    return Intl.message(
      'Waiting for the response timed out',
      name: 'cloudApiReceiveTimeout',
      desc: '',
      args: [],
    );
  }

  /// `TLS handshake failed`
  String get cloudApiTlsFailed {
    return Intl.message(
      'TLS handshake failed',
      name: 'cloudApiTlsFailed',
      desc: '',
      args: [],
    );
  }

  /// `Connection refused`
  String get cloudApiConnectionRefused {
    return Intl.message(
      'Connection refused',
      name: 'cloudApiConnectionRefused',
      desc: '',
      args: [],
    );
  }

  /// `Connection reset`
  String get cloudApiConnectionReset {
    return Intl.message(
      'Connection reset',
      name: 'cloudApiConnectionReset',
      desc: '',
      args: [],
    );
  }

  /// `Network unreachable`
  String get cloudApiNetworkUnreachable {
    return Intl.message(
      'Network unreachable',
      name: 'cloudApiNetworkUnreachable',
      desc: '',
      args: [],
    );
  }

  /// `Network access denied`
  String get cloudApiAccessDenied {
    return Intl.message(
      'Network access denied',
      name: 'cloudApiAccessDenied',
      desc: '',
      args: [],
    );
  }

  /// `Connection failed`
  String get cloudApiConnectionFailed {
    return Intl.message(
      'Connection failed',
      name: 'cloudApiConnectionFailed',
      desc: '',
      args: [],
    );
  }

  /// `Proxy connection failed`
  String get cloudApiProxyFailed {
    return Intl.message(
      'Proxy connection failed',
      name: 'cloudApiProxyFailed',
      desc: '',
      args: [],
    );
  }

  /// `Proxy authentication failed (HTTP 407)`
  String get cloudApiProxyAuthFailed {
    return Intl.message(
      'Proxy authentication failed (HTTP 407)',
      name: 'cloudApiProxyAuthFailed',
      desc: '',
      args: [],
    );
  }

  /// `Server returned HTTP {status}`
  String cloudApiHttpError(Object status) {
    return Intl.message(
      'Server returned HTTP $status',
      name: 'cloudApiHttpError',
      desc: '',
      args: [status],
    );
  }

  /// `The device clock is too far from the server. Turn on automatic date and time, then retry.`
  String get cloudApiClockSkew {
    return Intl.message(
      'The device clock is too far from the server. Turn on automatic date and time, then retry.',
      name: 'cloudApiClockSkew',
      desc: '',
      args: [],
    );
  }

  /// `The server rejected this app’s signature. Reinstall the latest official build.`
  String get cloudApiSignatureRejected {
    return Intl.message(
      'The server rejected this app’s signature. Reinstall the latest official build.',
      name: 'cloudApiSignatureRejected',
      desc: '',
      args: [],
    );
  }

  /// `The server has no key configured for this app. Contact support.`
  String get cloudApiServerUnconfigured {
    return Intl.message(
      'The server has no key configured for this app. Contact support.',
      name: 'cloudApiServerUnconfigured',
      desc: '',
      args: [],
    );
  }

  /// `Invalid server response`
  String get cloudApiInvalidResponse {
    return Intl.message(
      'Invalid server response',
      name: 'cloudApiInvalidResponse',
      desc: '',
      args: [],
    );
  }

  /// `Request canceled`
  String get cloudApiRequestCanceled {
    return Intl.message(
      'Request canceled',
      name: 'cloudApiRequestCanceled',
      desc: '',
      args: [],
    );
  }

  /// `System error {code}`
  String cloudApiSystemError(Object code) {
    return Intl.message(
      'System error $code',
      name: 'cloudApiSystemError',
      desc: '',
      args: [code],
    );
  }

  /// `Request timed out`
  String get cloudApiTimeout {
    return Intl.message(
      'Request timed out',
      name: 'cloudApiTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Direct: {error}`
  String cloudApiRouteDirect(Object error) {
    return Intl.message(
      'Direct: $error',
      name: 'cloudApiRouteDirect',
      desc: '',
      args: [error],
    );
  }

  /// `Local proxy: {error}`
  String cloudApiRouteProxy(Object error) {
    return Intl.message(
      'Local proxy: $error',
      name: 'cloudApiRouteProxy',
      desc: '',
      args: [error],
    );
  }

  /// `Network self-check`
  String get diagTitle {
    return Intl.message(
      'Network self-check',
      name: 'diagTitle',
      desc: '',
      args: [],
    );
  }

  /// `Check the core, system proxy, TUN and DNS`
  String get diagEntryHint {
    return Intl.message(
      'Check the core, system proxy, TUN and DNS',
      name: 'diagEntryHint',
      desc: '',
      args: [],
    );
  }

  /// `Checks the current connection using a small sample. The system network path may also pass through TUN. Results do not cover every app or node.`
  String get diagScope {
    return Intl.message(
      'Checks the current connection using a small sample. The system network path may also pass through TUN. Results do not cover every app or node.',
      name: 'diagScope',
      desc: '',
      args: [],
    );
  }

  /// `Run self-check`
  String get diagRun {
    return Intl.message('Run self-check', name: 'diagRun', desc: '', args: []);
  }

  /// `Copy diagnostic report`
  String get diagCopy {
    return Intl.message(
      'Copy diagnostic report',
      name: 'diagCopy',
      desc: '',
      args: [],
    );
  }

  /// `Check canceled; results are incomplete`
  String get diagCanceled {
    return Intl.message(
      'Check canceled; results are incomplete',
      name: 'diagCanceled',
      desc: '',
      args: [],
    );
  }

  /// `Applying the fix, then checking again`
  String get diagFixing {
    return Intl.message(
      'Applying the fix, then checking again',
      name: 'diagFixing',
      desc: '',
      args: [],
    );
  }

  /// `The fix could not be applied. Follow the suggestion above.`
  String get diagFixFailed {
    return Intl.message(
      'The fix could not be applied. Follow the suggestion above.',
      name: 'diagFixFailed',
      desc: '',
      args: [],
    );
  }

  /// `Apply configuration`
  String get diagFixApplyProfile {
    return Intl.message(
      'Apply configuration',
      name: 'diagFixApplyProfile',
      desc: '',
      args: [],
    );
  }

  /// `Start connection`
  String get diagFixStart {
    return Intl.message(
      'Start connection',
      name: 'diagFixStart',
      desc: '',
      args: [],
    );
  }

  /// `Restart core`
  String get diagFixRestartCore {
    return Intl.message(
      'Restart core',
      name: 'diagFixRestartCore',
      desc: '',
      args: [],
    );
  }

  /// `Reconnect`
  String get diagFixRestartConnection {
    return Intl.message(
      'Reconnect',
      name: 'diagFixRestartConnection',
      desc: '',
      args: [],
    );
  }

  /// `Reapply system proxy`
  String get diagFixSystemProxy {
    return Intl.message(
      'Reapply system proxy',
      name: 'diagFixSystemProxy',
      desc: '',
      args: [],
    );
  }

  /// `Enable system proxy`
  String get diagFixEnableSystemProxy {
    return Intl.message(
      'Enable system proxy',
      name: 'diagFixEnableSystemProxy',
      desc: '',
      args: [],
    );
  }

  /// `Re-enable TUN`
  String get diagFixTun {
    return Intl.message(
      'Re-enable TUN',
      name: 'diagFixTun',
      desc: '',
      args: [],
    );
  }

  /// `Retest nodes`
  String get diagFixRetest {
    return Intl.message(
      'Retest nodes',
      name: 'diagFixRetest',
      desc: '',
      args: [],
    );
  }

  /// `Passed`
  String get diagPassed {
    return Intl.message('Passed', name: 'diagPassed', desc: '', args: []);
  }

  /// `Needs attention`
  String get diagWarning {
    return Intl.message(
      'Needs attention',
      name: 'diagWarning',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get diagFailed {
    return Intl.message('Failed', name: 'diagFailed', desc: '', args: []);
  }

  /// `Could not confirm`
  String get diagUnknown {
    return Intl.message(
      'Could not confirm',
      name: 'diagUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Skipped`
  String get diagSkipped {
    return Intl.message('Skipped', name: 'diagSkipped', desc: '', args: []);
  }

  /// `This option is not enabled`
  String get diagDisabled {
    return Intl.message(
      'This option is not enabled',
      name: 'diagDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Applied configuration`
  String get diagProfile {
    return Intl.message(
      'Applied configuration',
      name: 'diagProfile',
      desc: '',
      args: [],
    );
  }

  /// `The selected configuration has been applied`
  String get diagProfileReady {
    return Intl.message(
      'The selected configuration has been applied',
      name: 'diagProfileReady',
      desc: '',
      args: [],
    );
  }

  /// `The selected configuration has not been applied`
  String get diagProfileMissing {
    return Intl.message(
      'The selected configuration has not been applied',
      name: 'diagProfileMissing',
      desc: '',
      args: [],
    );
  }

  /// `Select a valid configuration and start the connection before checking again.`
  String get diagProfileHint {
    return Intl.message(
      'Select a valid configuration and start the connection before checking again.',
      name: 'diagProfileHint',
      desc: '',
      args: [],
    );
  }

  /// `Core response`
  String get diagCore {
    return Intl.message('Core response', name: 'diagCore', desc: '', args: []);
  }

  /// `The core responded and reports active listeners`
  String get diagCoreReady {
    return Intl.message(
      'The core responded and reports active listeners',
      name: 'diagCoreReady',
      desc: '',
      args: [],
    );
  }

  /// `The core diagnostic response is unavailable or the configuration changed`
  String get diagCoreUnknown {
    return Intl.message(
      'The core diagnostic response is unavailable or the configuration changed',
      name: 'diagCoreUnknown',
      desc: '',
      args: [],
    );
  }

  /// `The core reports that traffic forwarding is stopped`
  String get diagCoreStopped {
    return Intl.message(
      'The core reports that traffic forwarding is stopped',
      name: 'diagCoreStopped',
      desc: '',
      args: [],
    );
  }

  /// `Traffic forwarding is paused by the current Wi-Fi exclusion setting`
  String get diagSuspended {
    return Intl.message(
      'Traffic forwarding is paused by the current Wi-Fi exclusion setting',
      name: 'diagSuspended',
      desc: '',
      args: [],
    );
  }

  /// `Check the connection switch and Wi-Fi exclusions. If the core cannot respond, restart it and use a matching current client/core version.`
  String get diagCoreHint {
    return Intl.message(
      'Check the connection switch and Wi-Fi exclusions. If the core cannot respond, restart it and use a matching current client/core version.',
      name: 'diagCoreHint',
      desc: '',
      args: [],
    );
  }

  /// `Local proxy entry`
  String get diagListener {
    return Intl.message(
      'Local proxy entry',
      name: 'diagListener',
      desc: '',
      args: [],
    );
  }

  /// `The expected port responded to the proxy protocol`
  String get diagListenerReady {
    return Intl.message(
      'The expected port responded to the proxy protocol',
      name: 'diagListenerReady',
      desc: '',
      args: [],
    );
  }

  /// `The expected proxy port did not respond or differs from the core port`
  String get diagListenerFailed {
    return Intl.message(
      'The expected proxy port did not respond or differs from the core port',
      name: 'diagListenerFailed',
      desc: '',
      args: [],
    );
  }

  /// `Check for a port conflict or a stopped listener. Restart the connection; if needed, change the mixed port in network settings.`
  String get diagListenerHint {
    return Intl.message(
      'Check for a port conflict or a stopped listener. Restart the connection; if needed, change the mixed port in network settings.',
      name: 'diagListenerHint',
      desc: '',
      args: [],
    );
  }

  /// `System proxy settings`
  String get diagSystemProxy {
    return Intl.message(
      'System proxy settings',
      name: 'diagSystemProxy',
      desc: '',
      args: [],
    );
  }

  /// `HTTP and HTTPS proxy settings point to the expected local port`
  String get diagProxyReady {
    return Intl.message(
      'HTTP and HTTPS proxy settings point to the expected local port',
      name: 'diagProxyReady',
      desc: '',
      args: [],
    );
  }

  /// `The app requested a system proxy, but the OS reports it disabled`
  String get diagProxyDisabled {
    return Intl.message(
      'The app requested a system proxy, but the OS reports it disabled',
      name: 'diagProxyDisabled',
      desc: '',
      args: [],
    );
  }

  /// `The OS proxy does not match the app port`
  String get diagProxyDifferent {
    return Intl.message(
      'The OS proxy does not match the app port',
      name: 'diagProxyDifferent',
      desc: '',
      args: [],
    );
  }

  /// `Automatic proxy configuration is present; its effective route was not verified`
  String get diagProxyAutomatic {
    return Intl.message(
      'Automatic proxy configuration is present; its effective route was not verified',
      name: 'diagProxyAutomatic',
      desc: '',
      args: [],
    );
  }

  /// `Toggle the system proxy again and check whether another proxy app or an organization policy controls these settings. Some apps use their own proxy settings.`
  String get diagProxyHint {
    return Intl.message(
      'Toggle the system proxy again and check whether another proxy app or an organization policy controls these settings. Some apps use their own proxy settings.',
      name: 'diagProxyHint',
      desc: '',
      args: [],
    );
  }

  /// `TUN interface and route`
  String get diagTun {
    return Intl.message(
      'TUN interface and route',
      name: 'diagTun',
      desc: '',
      args: [],
    );
  }

  /// `The core TUN interface was not found in an active state`
  String get diagTunMissing {
    return Intl.message(
      'The core TUN interface was not found in an active state',
      name: 'diagTunMissing',
      desc: '',
      args: [],
    );
  }

  /// `The core TUN interface is active and the sampled IPv4 route uses it`
  String get diagTunReady {
    return Intl.message(
      'The core TUN interface is active and the sampled IPv4 route uses it',
      name: 'diagTunReady',
      desc: '',
      args: [],
    );
  }

  /// `TUN is active, but the sampled IPv4 route uses another interface`
  String get diagTunRouteMismatch {
    return Intl.message(
      'TUN is active, but the sampled IPv4 route uses another interface',
      name: 'diagTunRouteMismatch',
      desc: '',
      args: [],
    );
  }

  /// `TUN is active; its IPv4 route could not be verified`
  String get diagTunRouteUnknown {
    return Intl.message(
      'TUN is active; its IPv4 route could not be verified',
      name: 'diagTunRouteUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Turn TUN off and on and complete system authorization. If the route differs, check other VPNs. IPv6, UDP and app-specific exclusions need separate checks.`
  String get diagTunHint {
    return Intl.message(
      'Turn TUN off and on and complete system authorization. If the route differs, check other VPNs. IPv6, UDP and app-specific exclusions need separate checks.',
      name: 'diagTunHint',
      desc: '',
      args: [],
    );
  }

  /// `Traffic capture`
  String get diagTrafficCapture {
    return Intl.message(
      'Traffic capture',
      name: 'diagTrafficCapture',
      desc: '',
      args: [],
    );
  }

  /// `Neither system proxy nor TUN is enabled`
  String get diagNoCapture {
    return Intl.message(
      'Neither system proxy nor TUN is enabled',
      name: 'diagNoCapture',
      desc: '',
      args: [],
    );
  }

  /// `Enable system proxy or TUN, or configure the affected app to use the local proxy.`
  String get diagCaptureHint {
    return Intl.message(
      'Enable system proxy or TUN, or configure the affected app to use the local proxy.',
      name: 'diagCaptureHint',
      desc: '',
      args: [],
    );
  }

  /// `System DNS`
  String get diagSystemDns {
    return Intl.message(
      'System DNS',
      name: 'diagSystemDns',
      desc: '',
      args: [],
    );
  }

  /// `Core DNS`
  String get diagCoreDns {
    return Intl.message('Core DNS', name: 'diagCoreDns', desc: '', args: []);
  }

  /// `oixCloud signed DNS`
  String get diagOixDns {
    return Intl.message(
      'oixCloud signed DNS',
      name: 'diagOixDns',
      desc: '',
      args: [],
    );
  }

  /// `Sampled names resolved successfully`
  String get diagDnsReady {
    return Intl.message(
      'Sampled names resolved successfully',
      name: 'diagDnsReady',
      desc: '',
      args: [],
    );
  }

  /// `Only some sampled names resolved`
  String get diagDnsPartial {
    return Intl.message(
      'Only some sampled names resolved',
      name: 'diagDnsPartial',
      desc: '',
      args: [],
    );
  }

  /// `No managed node hostname was available for this sample`
  String get diagOixDnsNoSample {
    return Intl.message(
      'No managed node hostname was available for this sample',
      name: 'diagOixDnsNoSample',
      desc: '',
      args: [],
    );
  }

  /// `The managed DNS signing function is not ready`
  String get diagOixDnsAuthMissing {
    return Intl.message(
      'The managed DNS signing function is not ready',
      name: 'diagOixDnsAuthMissing',
      desc: '',
      args: [],
    );
  }

  /// `DNS returned no usable address; this alone does not prove an authentication failure`
  String get diagDnsNoAnswer {
    return Intl.message(
      'DNS returned no usable address; this alone does not prove an authentication failure',
      name: 'diagDnsNoAnswer',
      desc: '',
      args: [],
    );
  }

  /// `The DNS request was refused`
  String get diagDnsRefused {
    return Intl.message(
      'The DNS request was refused',
      name: 'diagDnsRefused',
      desc: '',
      args: [],
    );
  }

  /// `Check DNS overrides and try another network. If system DNS works but core DNS fails, inspect the configuration DNS settings.`
  String get diagDnsHint {
    return Intl.message(
      'Check DNS overrides and try another network. If system DNS works but core DNS fails, inspect the configuration DNS settings.',
      name: 'diagDnsHint',
      desc: '',
      args: [],
    );
  }

  /// `Check the client version and system time, then refresh the subscription. If resolution still fails, share this diagnostic report with support.`
  String get diagOixDnsHint {
    return Intl.message(
      'Check the client version and system time, then refresh the subscription. If resolution still fails, share this diagnostic report with support.',
      name: 'diagOixDnsHint',
      desc: '',
      args: [],
    );
  }

  /// `System network path`
  String get diagSystemPath {
    return Intl.message(
      'System network path',
      name: 'diagSystemPath',
      desc: '',
      args: [],
    );
  }

  /// `Through the local proxy`
  String get diagProxyPath {
    return Intl.message(
      'Through the local proxy',
      name: 'diagProxyPath',
      desc: '',
      args: [],
    );
  }

  /// `{count} of 2 independent HTTPS checks passed`
  String diagWebResult(Object count) {
    return Intl.message(
      '$count of 2 independent HTTPS checks passed',
      name: 'diagWebResult',
      desc: '',
      args: [count],
    );
  }

  /// `This path does not explicitly use the app HTTP proxy, but may use TUN. A failed sample may be caused by DNS, filtering or the test site; compare the local proxy result.`
  String get diagSystemPathHint {
    return Intl.message(
      'This path does not explicitly use the app HTTP proxy, but may use TUN. A failed sample may be caused by DNS, filtering or the test site; compare the local proxy result.',
      name: 'diagSystemPathHint',
      desc: '',
      args: [],
    );
  }

  /// `If the system path works, check the selected node, routing rules and core DNS. Failure at one test site does not mean every node is unusable.`
  String get diagProxyPathHint {
    return Intl.message(
      'If the system path works, check the selected node, routing rules and core DNS. Failure at one test site does not mean every node is unusable.',
      name: 'diagProxyPathHint',
      desc: '',
      args: [],
    );
  }

  /// `System time comparison`
  String get diagClock {
    return Intl.message(
      'System time comparison',
      name: 'diagClock',
      desc: '',
      args: [],
    );
  }

  /// `Not enough uncached HTTPS responses to compare time`
  String get diagClockUnknown {
    return Intl.message(
      'Not enough uncached HTTPS responses to compare time',
      name: 'diagClockUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Two independent responses indicate a possible time difference of at least five minutes`
  String get diagClockSkew {
    return Intl.message(
      'Two independent responses indicate a possible time difference of at least five minutes',
      name: 'diagClockSkew',
      desc: '',
      args: [],
    );
  }

  /// `No consistent large time difference was found in this sample`
  String get diagClockReady {
    return Intl.message(
      'No consistent large time difference was found in this sample',
      name: 'diagClockReady',
      desc: '',
      args: [],
    );
  }

  /// `Enable automatic system date and time, then retry. A clock error can affect certificates and oixCloud DNS signatures.`
  String get diagClockHint {
    return Intl.message(
      'Enable automatic system date and time, then retry. A clock error can affect certificates and oixCloud DNS signatures.',
      name: 'diagClockHint',
      desc: '',
      args: [],
    );
  }

  /// `Every node tested in this group failed. The test URL may also be unreachable. Run a network self-check?`
  String get diagAllFailed {
    return Intl.message(
      'Every node tested in this group failed. The test URL may also be unreachable. Run a network self-check?',
      name: 'diagAllFailed',
      desc: '',
      args: [],
    );
  }

  /// `Download in background`
  String get updateDownloadBackground {
    return Intl.message(
      'Download in background',
      name: 'updateDownloadBackground',
      desc: '',
      args: [],
    );
  }

  /// `Update ready to install`
  String get updateReady {
    return Intl.message(
      'Update ready to install',
      name: 'updateReady',
      desc: '',
      args: [],
    );
  }

  /// `The update has been downloaded. Install when convenient.`
  String get updateReadyHint {
    return Intl.message(
      'The update has been downloaded. Install when convenient.',
      name: 'updateReadyHint',
      desc: '',
      args: [],
    );
  }

  /// `Install update`
  String get updateInstall {
    return Intl.message(
      'Install update',
      name: 'updateInstall',
      desc: '',
      args: [],
    );
  }

  /// `Downloading update`
  String get updateDownloading {
    return Intl.message(
      'Downloading update',
      name: 'updateDownloading',
      desc: '',
      args: [],
    );
  }

  /// `Update download failed`
  String get updateDownloadFailed {
    return Intl.message(
      'Update download failed',
      name: 'updateDownloadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Download in browser`
  String get updateDownloadBrowser {
    return Intl.message(
      'Download in browser',
      name: 'updateDownloadBrowser',
      desc: '',
      args: [],
    );
  }

  /// `Choose the package format`
  String get updatePackageFormat {
    return Intl.message(
      'Choose the package format',
      name: 'updatePackageFormat',
      desc: '',
      args: [],
    );
  }

  /// `How this build was installed could not be determined. Pick the format that matches it.`
  String get updatePackageFormatTip {
    return Intl.message(
      'How this build was installed could not be determined. Pick the format that matches it.',
      name: 'updatePackageFormatTip',
      desc: '',
      args: [],
    );
  }

  /// `An AppImage cannot be installed automatically. Replace the running program with the downloaded file; its folder has been opened.`
  String get updateAppImageTip {
    return Intl.message(
      'An AppImage cannot be installed automatically. Replace the running program with the downloaded file; its folder has been opened.',
      name: 'updateAppImageTip',
      desc: '',
      args: [],
    );
  }

  /// `Default: 9000; alternatives: 1480 or 4064. Restart the Android VPN to apply`
  String get tunMtuDesc {
    return Intl.message(
      'Default: 9000; alternatives: 1480 or 4064. Restart the Android VPN to apply',
      name: 'tunMtuDesc',
      desc: '',
      args: [],
    );
  }

  /// `Enter an integer from 1280 to 65535`
  String get tunMtuInvalid {
    return Intl.message(
      'Enter an integer from 1280 to 65535',
      name: 'tunMtuInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Script options`
  String get scriptOptions {
    return Intl.message(
      'Script options',
      name: 'scriptOptions',
      desc: '',
      args: [],
    );
  }

  /// `This script does not expose configurable switches`
  String get scriptOptionsEmpty {
    return Intl.message(
      'This script does not expose configurable switches',
      name: 'scriptOptionsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Pause proxy by IP or gateway`
  String get excludeNetworks {
    return Intl.message(
      'Pause proxy by IP or gateway',
      name: 'excludeNetworks',
      desc: '',
      args: [],
    );
  }

  /// `Pause on matching Wi-Fi/Ethernet IPv4 addresses, subnets or gateways; resume after leaving. Comma-separated, e.g. 192.168.1.0/24,gateway:192.168.1.1`
  String get excludeNetworksDesc {
    return Intl.message(
      'Pause on matching Wi-Fi/Ethernet IPv4 addresses, subnets or gateways; resume after leaving. Comma-separated, e.g. 192.168.1.0/24,gateway:192.168.1.1',
      name: 'excludeNetworksDesc',
      desc: '',
      args: [],
    );
  }

  /// `Up to 16 rules; enter valid IPv4, CIDR or gateway:address`
  String get excludeNetworksInvalid {
    return Intl.message(
      'Up to 16 rules; enter valid IPv4, CIDR or gateway:address',
      name: 'excludeNetworksInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Concurrent batch latency tests`
  String get delayConcurrency {
    return Intl.message(
      'Concurrent batch latency tests',
      name: 'delayConcurrency',
      desc: '',
      args: [],
    );
  }

  /// `Default: 50. Reduce on congested networks; applies to the next batch`
  String get delayConcurrencyDesc {
    return Intl.message(
      'Default: 50. Reduce on congested networks; applies to the next batch',
      name: 'delayConcurrencyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Default: 16 on Android. Reduce on congested networks; applies to the next batch`
  String get delayConcurrencyAndroidDesc {
    return Intl.message(
      'Default: 16 on Android. Reduce on congested networks; applies to the next batch',
      name: 'delayConcurrencyAndroidDesc',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get delayTestFailed {
    return Intl.message('Failed', name: 'delayTestFailed', desc: '', args: []);
  }

  /// `View update`
  String get updateViewDetails {
    return Intl.message(
      'View update',
      name: 'updateViewDetails',
      desc: '',
      args: [],
    );
  }

  /// `Release notes`
  String get updateReleaseNotes {
    return Intl.message(
      'Release notes',
      name: 'updateReleaseNotes',
      desc: '',
      args: [],
    );
  }

  /// `Download update`
  String get updateDownloadConfirm {
    return Intl.message(
      'Download update',
      name: 'updateDownloadConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get updateLater {
    return Intl.message('Later', name: 'updateLater', desc: '', args: []);
  }

  /// `Cancel download`
  String get updateCancelDownload {
    return Intl.message(
      'Cancel download',
      name: 'updateCancelDownload',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

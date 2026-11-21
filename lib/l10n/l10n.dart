import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';
import 'l10n_es.dart';
import 'l10n_fr.dart';
import 'l10n_ja.dart';
import 'l10n_ko.dart';
import 'l10n_ru.dart';
import 'l10n_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('ko'),
    Locale('ru'),
    Locale('zh'),
  ];

  /// No description provided for @applyNow.
  ///
  /// In en, this message translates to:
  /// **'Apply now'**
  String get applyNow;

  /// No description provided for @rule.
  ///
  /// In en, this message translates to:
  /// **'Rule'**
  String get rule;

  /// No description provided for @global.
  ///
  /// In en, this message translates to:
  /// **'Global'**
  String get global;

  /// No description provided for @direct.
  ///
  /// In en, this message translates to:
  /// **'Direct'**
  String get direct;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @proxies.
  ///
  /// In en, this message translates to:
  /// **'Proxies'**
  String get proxies;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @profiles.
  ///
  /// In en, this message translates to:
  /// **'Profiles'**
  String get profiles;

  /// No description provided for @tools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get tools;

  /// No description provided for @logs.
  ///
  /// In en, this message translates to:
  /// **'Logs'**
  String get logs;

  /// No description provided for @logsDesc.
  ///
  /// In en, this message translates to:
  /// **'Log capture records'**
  String get logsDesc;

  /// No description provided for @resources.
  ///
  /// In en, this message translates to:
  /// **'Resources'**
  String get resources;

  /// No description provided for @resourcesDesc.
  ///
  /// In en, this message translates to:
  /// **'External resource related info'**
  String get resourcesDesc;

  /// No description provided for @trafficUsage.
  ///
  /// In en, this message translates to:
  /// **'Traffic usage'**
  String get trafficUsage;

  /// No description provided for @networkSpeed.
  ///
  /// In en, this message translates to:
  /// **'Network speed'**
  String get networkSpeed;

  /// No description provided for @outboundMode.
  ///
  /// In en, this message translates to:
  /// **'Outbound mode'**
  String get outboundMode;

  /// No description provided for @networkDetection.
  ///
  /// In en, this message translates to:
  /// **'Network detection'**
  String get networkDetection;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @noProxy.
  ///
  /// In en, this message translates to:
  /// **'No proxy'**
  String get noProxy;

  /// No description provided for @nullProfileDesc.
  ///
  /// In en, this message translates to:
  /// **'No profile, Please add a profile'**
  String get nullProfileDesc;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @defaultText.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultText;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get en;

  /// No description provided for @ja.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get ja;

  /// No description provided for @ru.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get ru;

  /// No description provided for @fr.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get fr;

  /// No description provided for @es.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get es;

  /// No description provided for @ko.
  ///
  /// In en, this message translates to:
  /// **'Korean'**
  String get ko;

  /// No description provided for @zh_CN.
  ///
  /// In en, this message translates to:
  /// **'Simplified Chinese'**
  String get zh_CN;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeDesc.
  ///
  /// In en, this message translates to:
  /// **'Set dark mode,adjust the color'**
  String get themeDesc;

  /// No description provided for @overrideLabel.
  ///
  /// In en, this message translates to:
  /// **'Override'**
  String get overrideLabel;

  /// No description provided for @allowLan.
  ///
  /// In en, this message translates to:
  /// **'Allow LAN'**
  String get allowLan;

  /// No description provided for @tun.
  ///
  /// In en, this message translates to:
  /// **'TUN'**
  String get tun;

  /// No description provided for @tunDesc.
  ///
  /// In en, this message translates to:
  /// **'TUN works only in administrator mode'**
  String get tunDesc;

  /// No description provided for @minimizeOnExit.
  ///
  /// In en, this message translates to:
  /// **'Minimize on exit'**
  String get minimizeOnExit;

  /// No description provided for @autoLaunch.
  ///
  /// In en, this message translates to:
  /// **'Auto launch'**
  String get autoLaunch;

  /// No description provided for @silentLaunch.
  ///
  /// In en, this message translates to:
  /// **'Silent launch'**
  String get silentLaunch;

  /// No description provided for @silentLaunchDesc.
  ///
  /// In en, this message translates to:
  /// **'Start in the background'**
  String get silentLaunchDesc;

  /// No description provided for @autoRun.
  ///
  /// In en, this message translates to:
  /// **'Auto run'**
  String get autoRun;

  /// No description provided for @autoRunDesc.
  ///
  /// In en, this message translates to:
  /// **'Auto run when the application is opened'**
  String get autoRunDesc;

  /// No description provided for @logcat.
  ///
  /// In en, this message translates to:
  /// **'Logcat'**
  String get logcat;

  /// No description provided for @logcatDesc.
  ///
  /// In en, this message translates to:
  /// **'Disabling will hide the log entry'**
  String get logcatDesc;

  /// No description provided for @accessControl.
  ///
  /// In en, this message translates to:
  /// **'AccessControl'**
  String get accessControl;

  /// No description provided for @accessControlDesc.
  ///
  /// In en, this message translates to:
  /// **'Configure application access proxy'**
  String get accessControlDesc;

  /// No description provided for @application.
  ///
  /// In en, this message translates to:
  /// **'Application'**
  String get application;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get hours;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'Seconds'**
  String get seconds;

  /// No description provided for @qrcode.
  ///
  /// In en, this message translates to:
  /// **'QR code'**
  String get qrcode;

  /// No description provided for @qrcodeDesc.
  ///
  /// In en, this message translates to:
  /// **'Scan QR code to obtain profile'**
  String get qrcodeDesc;

  /// No description provided for @url.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get url;

  /// No description provided for @file.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get file;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @profileNameNullValidationDesc.
  ///
  /// In en, this message translates to:
  /// **'Please input the profile name'**
  String get profileNameNullValidationDesc;

  /// No description provided for @profileUrlNullValidationDesc.
  ///
  /// In en, this message translates to:
  /// **'Please input the profile URL'**
  String get profileUrlNullValidationDesc;

  /// No description provided for @profileUrlInvalidValidationDesc.
  ///
  /// In en, this message translates to:
  /// **'Please input a valid profile URL'**
  String get profileUrlInvalidValidationDesc;

  /// No description provided for @autoUpdate.
  ///
  /// In en, this message translates to:
  /// **'Auto update'**
  String get autoUpdate;

  /// No description provided for @autoUpdateInterval.
  ///
  /// In en, this message translates to:
  /// **'Auto update interval'**
  String get autoUpdateInterval;

  /// No description provided for @profileAutoUpdateIntervalNullValidationDesc.
  ///
  /// In en, this message translates to:
  /// **'Please enter the auto update interval time'**
  String get profileAutoUpdateIntervalNullValidationDesc;

  /// No description provided for @profileAutoUpdateIntervalInvalidValidationDesc.
  ///
  /// In en, this message translates to:
  /// **'Please input a valid interval time format'**
  String get profileAutoUpdateIntervalInvalidValidationDesc;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme mode'**
  String get themeMode;

  /// No description provided for @themeColor.
  ///
  /// In en, this message translates to:
  /// **'Theme color'**
  String get themeColor;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @auto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get auto;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @createProfileFromUrlTip.
  ///
  /// In en, this message translates to:
  /// **'Do you want to create a profile from {url}?'**
  String createProfileFromUrlTip(Object url);

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @pleaseUploadValidQrcode.
  ///
  /// In en, this message translates to:
  /// **'Please upload a valid QR code'**
  String get pleaseUploadValidQrcode;

  /// No description provided for @blacklistMode.
  ///
  /// In en, this message translates to:
  /// **'Blacklist mode'**
  String get blacklistMode;

  /// No description provided for @whitelistMode.
  ///
  /// In en, this message translates to:
  /// **'Whitelist mode'**
  String get whitelistMode;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select all'**
  String get selectAll;

  /// No description provided for @cancelSelectAll.
  ///
  /// In en, this message translates to:
  /// **'Cancel select all'**
  String get cancelSelectAll;

  /// No description provided for @appAccessControl.
  ///
  /// In en, this message translates to:
  /// **'App access control'**
  String get appAccessControl;

  /// No description provided for @accessControlAllowDesc.
  ///
  /// In en, this message translates to:
  /// **'Only selected apps go through the VPN'**
  String get accessControlAllowDesc;

  /// No description provided for @accessControlNotAllowDesc.
  ///
  /// In en, this message translates to:
  /// **'Selected apps are excluded from the VPN'**
  String get accessControlNotAllowDesc;

  /// No description provided for @accessControlDisabledDesc.
  ///
  /// In en, this message translates to:
  /// **'App access control is disabled'**
  String get accessControlDisabledDesc;

  /// No description provided for @accessControlSelectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{{count} selected}}'**
  String accessControlSelectedCount(num count);

  /// No description provided for @profileParseErrorDesc.
  ///
  /// In en, this message translates to:
  /// **'Profile parse error'**
  String get profileParseErrorDesc;

  /// No description provided for @proxyPort.
  ///
  /// In en, this message translates to:
  /// **'ProxyPort'**
  String get proxyPort;

  /// No description provided for @port.
  ///
  /// In en, this message translates to:
  /// **'Port'**
  String get port;

  /// No description provided for @logLevel.
  ///
  /// In en, this message translates to:
  /// **'Log level'**
  String get logLevel;

  /// No description provided for @show.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get show;

  /// No description provided for @hide.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get hide;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @systemProxy.
  ///
  /// In en, this message translates to:
  /// **'System proxy'**
  String get systemProxy;

  /// No description provided for @custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get custom;

  /// No description provided for @project.
  ///
  /// In en, this message translates to:
  /// **'Project'**
  String get project;

  /// No description provided for @core.
  ///
  /// In en, this message translates to:
  /// **'Core'**
  String get core;

  /// No description provided for @reverseEngineeringNotice.
  ///
  /// In en, this message translates to:
  /// **'Reverse engineering, decompilation, disassembly, or AI-assisted analysis of this application is strictly prohibited.'**
  String get reverseEngineeringNotice;

  /// No description provided for @tabAnimation.
  ///
  /// In en, this message translates to:
  /// **'Tab animation'**
  String get tabAnimation;

  /// No description provided for @desc.
  ///
  /// In en, this message translates to:
  /// **'A multi-platform proxy client based on ClashMeta, simple and easy to use, open-source and ad-free.'**
  String get desc;

  /// No description provided for @startVpn.
  ///
  /// In en, this message translates to:
  /// **'Starting VPN...'**
  String get startVpn;

  /// No description provided for @stopVpn.
  ///
  /// In en, this message translates to:
  /// **'Stopping VPN...'**
  String get stopVpn;

  /// No description provided for @discovery.
  ///
  /// In en, this message translates to:
  /// **'Discovery a new version'**
  String get discovery;

  /// No description provided for @compatible.
  ///
  /// In en, this message translates to:
  /// **'Compatibility mode'**
  String get compatible;

  /// No description provided for @notSelectedTip.
  ///
  /// In en, this message translates to:
  /// **'The current proxy group cannot be selected.'**
  String get notSelectedTip;

  /// No description provided for @tip.
  ///
  /// In en, this message translates to:
  /// **'tip'**
  String get tip;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @backup.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backup;

  /// No description provided for @backupSuccess.
  ///
  /// In en, this message translates to:
  /// **'Backup success'**
  String get backupSuccess;

  /// No description provided for @noInfo.
  ///
  /// In en, this message translates to:
  /// **'No info'**
  String get noInfo;

  /// No description provided for @pleaseBindWebDAV.
  ///
  /// In en, this message translates to:
  /// **'Please bind WebDAV'**
  String get pleaseBindWebDAV;

  /// No description provided for @bind.
  ///
  /// In en, this message translates to:
  /// **'Bind'**
  String get bind;

  /// No description provided for @connectivity.
  ///
  /// In en, this message translates to:
  /// **'Connectivity：'**
  String get connectivity;

  /// No description provided for @webDAVConfiguration.
  ///
  /// In en, this message translates to:
  /// **'WebDAV configuration'**
  String get webDAVConfiguration;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @addressHelp.
  ///
  /// In en, this message translates to:
  /// **'WebDAV server address'**
  String get addressHelp;

  /// No description provided for @addressTip.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid WebDAV address'**
  String get addressTip;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @checkUpdate.
  ///
  /// In en, this message translates to:
  /// **'Check for updates'**
  String get checkUpdate;

  /// No description provided for @checkUpdateError.
  ///
  /// In en, this message translates to:
  /// **'The current application is already the latest version'**
  String get checkUpdateError;

  /// No description provided for @checkUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to check for updates. Please check your network and try again'**
  String get checkUpdateFailed;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @allowBypass.
  ///
  /// In en, this message translates to:
  /// **'Allow apps to bypass VPN'**
  String get allowBypass;

  /// No description provided for @externalController.
  ///
  /// In en, this message translates to:
  /// **'External controller'**
  String get externalController;

  /// No description provided for @externalControllerDesc.
  ///
  /// In en, this message translates to:
  /// **'The external controller lets you control the core on the configured address'**
  String get externalControllerDesc;

  /// No description provided for @openDashboard.
  ///
  /// In en, this message translates to:
  /// **'Open dashboard'**
  String get openDashboard;

  /// No description provided for @ipv6Desc.
  ///
  /// In en, this message translates to:
  /// **'IPv6 traffic is received only while IPv6 is on'**
  String get ipv6Desc;

  /// No description provided for @autoIpv6.
  ///
  /// In en, this message translates to:
  /// **'Auto IPv6'**
  String get autoIpv6;

  /// No description provided for @autoIpv6Desc.
  ///
  /// In en, this message translates to:
  /// **'Auto IPv6 turns IPv6 on or off by whether the local network supports it'**
  String get autoIpv6Desc;

  /// No description provided for @app.
  ///
  /// In en, this message translates to:
  /// **'App'**
  String get app;

  /// No description provided for @unifiedDelay.
  ///
  /// In en, this message translates to:
  /// **'Unified delay'**
  String get unifiedDelay;

  /// No description provided for @tcpConcurrent.
  ///
  /// In en, this message translates to:
  /// **'TCP concurrent'**
  String get tcpConcurrent;

  /// No description provided for @geodataLoader.
  ///
  /// In en, this message translates to:
  /// **'Geo low-memory mode'**
  String get geodataLoader;

  /// No description provided for @requests.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get requests;

  /// No description provided for @requestsDesc.
  ///
  /// In en, this message translates to:
  /// **'View recent requests and live connections'**
  String get requestsDesc;

  /// No description provided for @findProcessMode.
  ///
  /// In en, this message translates to:
  /// **'Find process'**
  String get findProcessMode;

  /// No description provided for @init.
  ///
  /// In en, this message translates to:
  /// **'Init'**
  String get init;

  /// No description provided for @infiniteTime.
  ///
  /// In en, this message translates to:
  /// **'Long term effective'**
  String get infiniteTime;

  /// No description provided for @connections.
  ///
  /// In en, this message translates to:
  /// **'Connections'**
  String get connections;

  /// No description provided for @intranetIP.
  ///
  /// In en, this message translates to:
  /// **'Intranet IP'**
  String get intranetIP;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @cut.
  ///
  /// In en, this message translates to:
  /// **'Cut'**
  String get cut;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @paste.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get paste;

  /// No description provided for @userAgent.
  ///
  /// In en, this message translates to:
  /// **'User-Agent'**
  String get userAgent;

  /// No description provided for @testUrl.
  ///
  /// In en, this message translates to:
  /// **'Test URL'**
  String get testUrl;

  /// No description provided for @delayTestTimeout.
  ///
  /// In en, this message translates to:
  /// **'Delay test timeout'**
  String get delayTestTimeout;

  /// No description provided for @sync.
  ///
  /// In en, this message translates to:
  /// **'Sync'**
  String get sync;

  /// No description provided for @exclude.
  ///
  /// In en, this message translates to:
  /// **'Hide from recent tasks'**
  String get exclude;

  /// No description provided for @compact.
  ///
  /// In en, this message translates to:
  /// **'Compact'**
  String get compact;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @tab.
  ///
  /// In en, this message translates to:
  /// **'Tab'**
  String get tab;

  /// No description provided for @list.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get list;

  /// No description provided for @delay.
  ///
  /// In en, this message translates to:
  /// **'Delay'**
  String get delay;

  /// No description provided for @style.
  ///
  /// In en, this message translates to:
  /// **'Style'**
  String get style;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @columns.
  ///
  /// In en, this message translates to:
  /// **'Columns'**
  String get columns;

  /// No description provided for @proxyGroup.
  ///
  /// In en, this message translates to:
  /// **'Proxy group'**
  String get proxyGroup;

  /// No description provided for @go.
  ///
  /// In en, this message translates to:
  /// **'Go'**
  String get go;

  /// No description provided for @externalLink.
  ///
  /// In en, this message translates to:
  /// **'External link'**
  String get externalLink;

  /// No description provided for @autoCloseConnections.
  ///
  /// In en, this message translates to:
  /// **'Auto close connections'**
  String get autoCloseConnections;

  /// No description provided for @autoCloseConnectionsDesc.
  ///
  /// In en, this message translates to:
  /// **'After switching nodes, close all connections or only those passing through the changed proxy group, including nested groups'**
  String get autoCloseConnectionsDesc;

  /// No description provided for @connectionCloseScope.
  ///
  /// In en, this message translates to:
  /// **'Connection closing scope'**
  String get connectionCloseScope;

  /// No description provided for @closeCurrentGroupConnections.
  ///
  /// In en, this message translates to:
  /// **'Only the current proxy group'**
  String get closeCurrentGroupConnections;

  /// No description provided for @onlyStatisticsProxy.
  ///
  /// In en, this message translates to:
  /// **'Only count proxy traffic'**
  String get onlyStatisticsProxy;

  /// No description provided for @pureBlackMode.
  ///
  /// In en, this message translates to:
  /// **'Pure black mode'**
  String get pureBlackMode;

  /// No description provided for @keepAliveIntervalDesc.
  ///
  /// In en, this message translates to:
  /// **'TCP keep-alive interval'**
  String get keepAliveIntervalDesc;

  /// No description provided for @entries.
  ///
  /// In en, this message translates to:
  /// **' entries'**
  String get entries;

  /// No description provided for @secondsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} seconds'**
  String secondsCount(Object count);

  /// No description provided for @itemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item} other{{count} items}}'**
  String itemsCount(num count);

  /// No description provided for @geoAutoUpdate.
  ///
  /// In en, this message translates to:
  /// **'Auto Update'**
  String get geoAutoUpdate;

  /// No description provided for @geoAutoUpdateInterval.
  ///
  /// In en, this message translates to:
  /// **'Auto Update Interval'**
  String get geoAutoUpdateInterval;

  /// No description provided for @geoAutoUpdateIntervalTip.
  ///
  /// In en, this message translates to:
  /// **'Auto update interval must be between 1 and 8760 hours'**
  String get geoAutoUpdateIntervalTip;

  /// No description provided for @geoResources.
  ///
  /// In en, this message translates to:
  /// **'Geo Resources'**
  String get geoResources;

  /// No description provided for @geoUpdating.
  ///
  /// In en, this message translates to:
  /// **'Updating {name}...'**
  String geoUpdating(Object name);

  /// No description provided for @geoSkipped.
  ///
  /// In en, this message translates to:
  /// **'{name} skipped'**
  String geoSkipped(Object name);

  /// No description provided for @geoUpdated.
  ///
  /// In en, this message translates to:
  /// **'{name} updated'**
  String geoUpdated(Object name);

  /// No description provided for @local.
  ///
  /// In en, this message translates to:
  /// **'Local'**
  String get local;

  /// No description provided for @remote.
  ///
  /// In en, this message translates to:
  /// **'Remote'**
  String get remote;

  /// No description provided for @remoteBackupDesc.
  ///
  /// In en, this message translates to:
  /// **'Backup local data to WebDAV'**
  String get remoteBackupDesc;

  /// No description provided for @localBackupDesc.
  ///
  /// In en, this message translates to:
  /// **'Backup local data to local'**
  String get localBackupDesc;

  /// No description provided for @mode.
  ///
  /// In en, this message translates to:
  /// **'Mode'**
  String get mode;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @source.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get source;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @intelligentSelected.
  ///
  /// In en, this message translates to:
  /// **'Intelligent selection'**
  String get intelligentSelected;

  /// No description provided for @clipboardNoPackageNames.
  ///
  /// In en, this message translates to:
  /// **'No package names found in the clipboard'**
  String get clipboardNoPackageNames;

  /// No description provided for @clipboardImport.
  ///
  /// In en, this message translates to:
  /// **'Import from clipboard'**
  String get clipboardImport;

  /// No description provided for @clipboardExport.
  ///
  /// In en, this message translates to:
  /// **'Export to clipboard'**
  String get clipboardExport;

  /// No description provided for @layout.
  ///
  /// In en, this message translates to:
  /// **'Layout'**
  String get layout;

  /// No description provided for @tight.
  ///
  /// In en, this message translates to:
  /// **'Tight'**
  String get tight;

  /// No description provided for @standard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get standard;

  /// No description provided for @loose.
  ///
  /// In en, this message translates to:
  /// **'Loose'**
  String get loose;

  /// No description provided for @profilesSort.
  ///
  /// In en, this message translates to:
  /// **'Profiles sort'**
  String get profilesSort;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @key.
  ///
  /// In en, this message translates to:
  /// **'Key'**
  String get key;

  /// No description provided for @value.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get value;

  /// No description provided for @vpnTip.
  ///
  /// In en, this message translates to:
  /// **'Changes take effect after restarting the VPN'**
  String get vpnTip;

  /// No description provided for @vpnEnableDesc.
  ///
  /// In en, this message translates to:
  /// **'VPN routes all system traffic through VpnService automatically'**
  String get vpnEnableDesc;

  /// No description provided for @options.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get options;

  /// No description provided for @loopback.
  ///
  /// In en, this message translates to:
  /// **'UWP loopback exemption'**
  String get loopback;

  /// No description provided for @providers.
  ///
  /// In en, this message translates to:
  /// **'Providers'**
  String get providers;

  /// No description provided for @proxyProviders.
  ///
  /// In en, this message translates to:
  /// **'Proxy providers'**
  String get proxyProviders;

  /// No description provided for @ruleProviders.
  ///
  /// In en, this message translates to:
  /// **'Rule providers'**
  String get ruleProviders;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @statusDesc.
  ///
  /// In en, this message translates to:
  /// **'With DNS off, the system DNS is used'**
  String get statusDesc;

  /// No description provided for @preferH3Desc.
  ///
  /// In en, this message translates to:
  /// **'Prefer HTTP/3 tries HTTP/3 first for DoH servers'**
  String get preferH3Desc;

  /// No description provided for @respectRules.
  ///
  /// In en, this message translates to:
  /// **'Respect rules'**
  String get respectRules;

  /// No description provided for @respectRulesDesc.
  ///
  /// In en, this message translates to:
  /// **'Respect rules routes DNS connections by the rules and needs a proxy nameserver'**
  String get respectRulesDesc;

  /// No description provided for @dnsMode.
  ///
  /// In en, this message translates to:
  /// **'DNS mode'**
  String get dnsMode;

  /// No description provided for @fakeipRange.
  ///
  /// In en, this message translates to:
  /// **'Fake-IP range'**
  String get fakeipRange;

  /// No description provided for @fakeipFilter.
  ///
  /// In en, this message translates to:
  /// **'Fake-IP filter'**
  String get fakeipFilter;

  /// No description provided for @defaultNameserver.
  ///
  /// In en, this message translates to:
  /// **'Default nameserver'**
  String get defaultNameserver;

  /// No description provided for @defaultNameserverDesc.
  ///
  /// In en, this message translates to:
  /// **'Resolves the hostnames of the other DNS servers. Use IP addresses only.'**
  String get defaultNameserverDesc;

  /// No description provided for @nameserver.
  ///
  /// In en, this message translates to:
  /// **'Nameserver'**
  String get nameserver;

  /// No description provided for @nameserverDesc.
  ///
  /// In en, this message translates to:
  /// **'The default DNS servers, such as 223.5.5.5, tls://1.1.1.1 or https://dns.google/dns-query.'**
  String get nameserverDesc;

  /// No description provided for @useHosts.
  ///
  /// In en, this message translates to:
  /// **'Use hosts'**
  String get useHosts;

  /// No description provided for @useSystemHosts.
  ///
  /// In en, this message translates to:
  /// **'Use system hosts'**
  String get useSystemHosts;

  /// No description provided for @nameserverPolicy.
  ///
  /// In en, this message translates to:
  /// **'Nameserver policy'**
  String get nameserverPolicy;

  /// No description provided for @nameserverPolicyDesc.
  ///
  /// In en, this message translates to:
  /// **'Matching domains use the DNS server given here instead of Nameserver and Fallback.'**
  String get nameserverPolicyDesc;

  /// No description provided for @proxyNameserver.
  ///
  /// In en, this message translates to:
  /// **'Proxy nameserver'**
  String get proxyNameserver;

  /// No description provided for @fallback.
  ///
  /// In en, this message translates to:
  /// **'Fallback'**
  String get fallback;

  /// No description provided for @fallbackDesc.
  ///
  /// In en, this message translates to:
  /// **'Used instead of Nameserver when the fallback filter treats its answer as polluted.'**
  String get fallbackDesc;

  /// No description provided for @preferH3.
  ///
  /// In en, this message translates to:
  /// **'Prefer HTTP/3'**
  String get preferH3;

  /// No description provided for @fallbackLazyQuery.
  ///
  /// In en, this message translates to:
  /// **'Lazy fallback query'**
  String get fallbackLazyQuery;

  /// No description provided for @proxyNameserverPolicy.
  ///
  /// In en, this message translates to:
  /// **'Proxy nameserver policy'**
  String get proxyNameserverPolicy;

  /// No description provided for @directNameserver.
  ///
  /// In en, this message translates to:
  /// **'Direct nameserver'**
  String get directNameserver;

  /// No description provided for @directNameserverFollowPolicy.
  ///
  /// In en, this message translates to:
  /// **'Direct nameserver follows policy'**
  String get directNameserverFollowPolicy;

  /// No description provided for @fallbackFilter.
  ///
  /// In en, this message translates to:
  /// **'Fallback filter'**
  String get fallbackFilter;

  /// No description provided for @geoipCode.
  ///
  /// In en, this message translates to:
  /// **'Geoip code'**
  String get geoipCode;

  /// No description provided for @ipcidr.
  ///
  /// In en, this message translates to:
  /// **'Ipcidr'**
  String get ipcidr;

  /// No description provided for @domain.
  ///
  /// In en, this message translates to:
  /// **'Domain'**
  String get domain;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @action_view.
  ///
  /// In en, this message translates to:
  /// **'Show/Hide'**
  String get action_view;

  /// No description provided for @action_start.
  ///
  /// In en, this message translates to:
  /// **'Start/Stop'**
  String get action_start;

  /// No description provided for @action_mode.
  ///
  /// In en, this message translates to:
  /// **'Switch mode'**
  String get action_mode;

  /// No description provided for @action_proxy.
  ///
  /// In en, this message translates to:
  /// **'System proxy'**
  String get action_proxy;

  /// No description provided for @action_tun.
  ///
  /// In en, this message translates to:
  /// **'TUN'**
  String get action_tun;

  /// No description provided for @hotkeyManagement.
  ///
  /// In en, this message translates to:
  /// **'Hotkey Management'**
  String get hotkeyManagement;

  /// No description provided for @hotkeyManagementDesc.
  ///
  /// In en, this message translates to:
  /// **'Use keyboard to control applications'**
  String get hotkeyManagementDesc;

  /// No description provided for @pressKeyboard.
  ///
  /// In en, this message translates to:
  /// **'Please press the keyboard.'**
  String get pressKeyboard;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @noNetwork.
  ///
  /// In en, this message translates to:
  /// **'No network'**
  String get noNetwork;

  /// No description provided for @ipv6InboundDesc.
  ///
  /// In en, this message translates to:
  /// **'With IPv6 on, the VPN allows IPv6 inbound'**
  String get ipv6InboundDesc;

  /// No description provided for @exportLogs.
  ///
  /// In en, this message translates to:
  /// **'Export logs'**
  String get exportLogs;

  /// No description provided for @exportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Export Success'**
  String get exportSuccess;

  /// No description provided for @iconStyle.
  ///
  /// In en, this message translates to:
  /// **'Icon style'**
  String get iconStyle;

  /// No description provided for @iconStyleFilled.
  ///
  /// In en, this message translates to:
  /// **'Filled'**
  String get iconStyleFilled;

  /// No description provided for @iconStylePlain.
  ///
  /// In en, this message translates to:
  /// **'Plain'**
  String get iconStylePlain;

  /// No description provided for @iconStyleHidden.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get iconStyleHidden;

  /// No description provided for @stackMode.
  ///
  /// In en, this message translates to:
  /// **'Stack mode'**
  String get stackMode;

  /// No description provided for @network.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get network;

  /// No description provided for @bypassDomain.
  ///
  /// In en, this message translates to:
  /// **'Bypass domains'**
  String get bypassDomain;

  /// No description provided for @bypassDomainDesc.
  ///
  /// In en, this message translates to:
  /// **'Bypass domains apply only while the system proxy is on'**
  String get bypassDomainDesc;

  /// No description provided for @resetTip.
  ///
  /// In en, this message translates to:
  /// **'Make sure to reset'**
  String get resetTip;

  /// No description provided for @icon.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get icon;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noData;

  /// No description provided for @fontFamily.
  ///
  /// In en, this message translates to:
  /// **'Font family'**
  String get fontFamily;

  /// No description provided for @installedFonts.
  ///
  /// In en, this message translates to:
  /// **'Installed fonts'**
  String get installedFonts;

  /// No description provided for @toggle.
  ///
  /// In en, this message translates to:
  /// **'Toggle'**
  String get toggle;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @bypassPrivateRoute.
  ///
  /// In en, this message translates to:
  /// **'Bypass private addresses'**
  String get bypassPrivateRoute;

  /// No description provided for @bypassPrivateRouteDesc.
  ///
  /// In en, this message translates to:
  /// **'With Bypass private addresses on, LAN, loopback and multicast addresses skip TUN'**
  String get bypassPrivateRouteDesc;

  /// No description provided for @routeAddress.
  ///
  /// In en, this message translates to:
  /// **'Route addresses'**
  String get routeAddress;

  /// No description provided for @pleaseInputAdminPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter the admin password'**
  String get pleaseInputAdminPassword;

  /// No description provided for @tunAuthorizationFailed.
  ///
  /// In en, this message translates to:
  /// **'TUN could not be enabled because administrator authorization was denied. Allow the system permission prompt and try again.'**
  String get tunAuthorizationFailed;

  /// No description provided for @tunHelperInstallFailed.
  ///
  /// In en, this message translates to:
  /// **'TUN could not be enabled: Helper installation or startup failed. Check that the app installation is complete and the system service is working, then try again.'**
  String get tunHelperInstallFailed;

  /// No description provided for @tunAdminAccountRequired.
  ///
  /// In en, this message translates to:
  /// **'TUN needs an administrator account on this Mac. Sign in with an administrator account to turn it on.'**
  String get tunAdminAccountRequired;

  /// No description provided for @copyEnvVar.
  ///
  /// In en, this message translates to:
  /// **'Copying environment variables'**
  String get copyEnvVar;

  /// No description provided for @memoryInfo.
  ///
  /// In en, this message translates to:
  /// **'Memory info'**
  String get memoryInfo;

  /// No description provided for @dialog.
  ///
  /// In en, this message translates to:
  /// **'Dialog'**
  String get dialog;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @fileIsUpdate.
  ///
  /// In en, this message translates to:
  /// **'The file has been modified. Do you want to save the changes?'**
  String get fileIsUpdate;

  /// No description provided for @profileHasUpdate.
  ///
  /// In en, this message translates to:
  /// **'The profile has been modified. Do you want to disable auto update?'**
  String get profileHasUpdate;

  /// No description provided for @copySuccess.
  ///
  /// In en, this message translates to:
  /// **'Copy success'**
  String get copySuccess;

  /// No description provided for @copyLink.
  ///
  /// In en, this message translates to:
  /// **'Copy link'**
  String get copyLink;

  /// No description provided for @exportFile.
  ///
  /// In en, this message translates to:
  /// **'Export file'**
  String get exportFile;

  /// No description provided for @cacheCorrupt.
  ///
  /// In en, this message translates to:
  /// **'The cache is corrupt. Do you want to clear it?'**
  String get cacheCorrupt;

  /// No description provided for @listen.
  ///
  /// In en, this message translates to:
  /// **'Listen'**
  String get listen;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'undo'**
  String get undo;

  /// No description provided for @redo.
  ///
  /// In en, this message translates to:
  /// **'redo'**
  String get redo;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @advancedConfig.
  ///
  /// In en, this message translates to:
  /// **'Advanced configuration'**
  String get advancedConfig;

  /// No description provided for @advancedConfigDesc.
  ///
  /// In en, this message translates to:
  /// **'Provide diverse configuration options'**
  String get advancedConfigDesc;

  /// No description provided for @addRule.
  ///
  /// In en, this message translates to:
  /// **'Add rule'**
  String get addRule;

  /// No description provided for @ruleName.
  ///
  /// In en, this message translates to:
  /// **'Rule name'**
  String get ruleName;

  /// No description provided for @content.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get content;

  /// No description provided for @subRule.
  ///
  /// In en, this message translates to:
  /// **'Sub rule'**
  String get subRule;

  /// No description provided for @ruleTarget.
  ///
  /// In en, this message translates to:
  /// **'Rule target'**
  String get ruleTarget;

  /// No description provided for @sourceIp.
  ///
  /// In en, this message translates to:
  /// **'Source IP'**
  String get sourceIp;

  /// No description provided for @noResolve.
  ///
  /// In en, this message translates to:
  /// **'No resolve IP'**
  String get noResolve;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Do you want to save the changes?'**
  String get saveChanges;

  /// No description provided for @findProcessModeAutomaticDesc.
  ///
  /// In en, this message translates to:
  /// **'Process rules look up the process only when they are checked'**
  String get findProcessModeAutomaticDesc;

  /// No description provided for @monochromeScheme.
  ///
  /// In en, this message translates to:
  /// **'Monochrome'**
  String get monochromeScheme;

  /// No description provided for @colorStyle.
  ///
  /// In en, this message translates to:
  /// **'Color style'**
  String get colorStyle;

  /// No description provided for @vividStyle.
  ///
  /// In en, this message translates to:
  /// **'Vivid'**
  String get vividStyle;

  /// No description provided for @tintedStyle.
  ///
  /// In en, this message translates to:
  /// **'Tinted'**
  String get tintedStyle;

  /// No description provided for @softStyle.
  ///
  /// In en, this message translates to:
  /// **'Soft'**
  String get softStyle;

  /// No description provided for @customColor.
  ///
  /// In en, this message translates to:
  /// **'Custom color'**
  String get customColor;

  /// No description provided for @grid.
  ///
  /// In en, this message translates to:
  /// **'Grid'**
  String get grid;

  /// No description provided for @spectrum.
  ///
  /// In en, this message translates to:
  /// **'Spectrum'**
  String get spectrum;

  /// No description provided for @sliders.
  ///
  /// In en, this message translates to:
  /// **'Sliders'**
  String get sliders;

  /// No description provided for @hue.
  ///
  /// In en, this message translates to:
  /// **'Hue'**
  String get hue;

  /// No description provided for @saturation.
  ///
  /// In en, this message translates to:
  /// **'Saturation'**
  String get saturation;

  /// No description provided for @brightness.
  ///
  /// In en, this message translates to:
  /// **'Brightness'**
  String get brightness;

  /// No description provided for @hex.
  ///
  /// In en, this message translates to:
  /// **'Hex'**
  String get hex;

  /// No description provided for @liquidGlass.
  ///
  /// In en, this message translates to:
  /// **'Liquid Glass'**
  String get liquidGlass;

  /// No description provided for @ultra.
  ///
  /// In en, this message translates to:
  /// **'Ultra'**
  String get ultra;

  /// No description provided for @developerMode.
  ///
  /// In en, this message translates to:
  /// **'Developer mode'**
  String get developerMode;

  /// No description provided for @developerModeEnableTip.
  ///
  /// In en, this message translates to:
  /// **'Developer mode is enabled.'**
  String get developerModeEnableTip;

  /// No description provided for @messageTest.
  ///
  /// In en, this message translates to:
  /// **'Message test'**
  String get messageTest;

  /// No description provided for @messageTestTip.
  ///
  /// In en, this message translates to:
  /// **'This is a message.'**
  String get messageTestTip;

  /// No description provided for @crashTest.
  ///
  /// In en, this message translates to:
  /// **'Crash test'**
  String get crashTest;

  /// No description provided for @clearData.
  ///
  /// In en, this message translates to:
  /// **'Clear Data'**
  String get clearData;

  /// No description provided for @textScale.
  ///
  /// In en, this message translates to:
  /// **'Text Scaling'**
  String get textScale;

  /// No description provided for @internet.
  ///
  /// In en, this message translates to:
  /// **'Internet'**
  String get internet;

  /// No description provided for @systemApp.
  ///
  /// In en, this message translates to:
  /// **'System APP'**
  String get systemApp;

  /// No description provided for @noNetworkApp.
  ///
  /// In en, this message translates to:
  /// **'No network APP'**
  String get noNetworkApp;

  /// No description provided for @restoreStrategy.
  ///
  /// In en, this message translates to:
  /// **'Restore strategy'**
  String get restoreStrategy;

  /// No description provided for @restoreStrategy_override.
  ///
  /// In en, this message translates to:
  /// **'Override'**
  String get restoreStrategy_override;

  /// No description provided for @restoreStrategy_compatible.
  ///
  /// In en, this message translates to:
  /// **'Compatible'**
  String get restoreStrategy_compatible;

  /// No description provided for @logsTest.
  ///
  /// In en, this message translates to:
  /// **'Logs test'**
  String get logsTest;

  /// No description provided for @emptyTip.
  ///
  /// In en, this message translates to:
  /// **'{label} cannot be empty'**
  String emptyTip(Object label);

  /// No description provided for @urlTip.
  ///
  /// In en, this message translates to:
  /// **'{label} must be a url'**
  String urlTip(Object label);

  /// No description provided for @numberTip.
  ///
  /// In en, this message translates to:
  /// **'{label} must be a number'**
  String numberTip(Object label);

  /// No description provided for @interval.
  ///
  /// In en, this message translates to:
  /// **'Interval'**
  String get interval;

  /// No description provided for @existsTip.
  ///
  /// In en, this message translates to:
  /// **'Current {label} already exists'**
  String existsTip(Object label);

  /// No description provided for @deleteTip.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the current {label}?'**
  String deleteTip(Object label);

  /// No description provided for @deleteMultipTip.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the selected {label}?'**
  String deleteMultipTip(Object label);

  /// No description provided for @nullTip.
  ///
  /// In en, this message translates to:
  /// **'No {label} yet'**
  String nullTip(Object label);

  /// No description provided for @script.
  ///
  /// In en, this message translates to:
  /// **'Script'**
  String get script;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @rename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get rename;

  /// No description provided for @unnamed.
  ///
  /// In en, this message translates to:
  /// **'Unnamed'**
  String get unnamed;

  /// No description provided for @mixedPort.
  ///
  /// In en, this message translates to:
  /// **'Mixed port'**
  String get mixedPort;

  /// No description provided for @socksPort.
  ///
  /// In en, this message translates to:
  /// **'SOCKS port'**
  String get socksPort;

  /// No description provided for @redirPort.
  ///
  /// In en, this message translates to:
  /// **'Redir port'**
  String get redirPort;

  /// No description provided for @tproxyPort.
  ///
  /// In en, this message translates to:
  /// **'TProxy port'**
  String get tproxyPort;

  /// No description provided for @portTip.
  ///
  /// In en, this message translates to:
  /// **'{label} must be between 1024 and 49151'**
  String portTip(Object label);

  /// No description provided for @portConflictTip.
  ///
  /// In en, this message translates to:
  /// **'Please enter a different port'**
  String get portConflictTip;

  /// No description provided for @portUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Port unavailable'**
  String get portUnavailableTitle;

  /// No description provided for @portUnavailableMessage.
  ///
  /// In en, this message translates to:
  /// **'The mixed port {port} could not start listening and may be in use by another application. Change the port to retry immediately.'**
  String portUnavailableMessage(Object port);

  /// No description provided for @saveAndRetry.
  ///
  /// In en, this message translates to:
  /// **'Save and retry'**
  String get saveAndRetry;

  /// No description provided for @portSuggestionTip.
  ///
  /// In en, this message translates to:
  /// **'Suggested port {port} has been filled in.'**
  String portSuggestionTip(Object port);

  /// No description provided for @portProxyAppTip.
  ///
  /// In en, this message translates to:
  /// **'If another proxy app is running, close it first.'**
  String get portProxyAppTip;

  /// No description provided for @import.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get import;

  /// No description provided for @importFile.
  ///
  /// In en, this message translates to:
  /// **'Import from file'**
  String get importFile;

  /// No description provided for @importUrl.
  ///
  /// In en, this message translates to:
  /// **'Import from URL'**
  String get importUrl;

  /// No description provided for @autoSetSystemDns.
  ///
  /// In en, this message translates to:
  /// **'Auto-set system DNS'**
  String get autoSetSystemDns;

  /// No description provided for @suspendOnIdle.
  ///
  /// In en, this message translates to:
  /// **'Pause proxy when idle'**
  String get suspendOnIdle;

  /// No description provided for @suspendOnIdleDesc.
  ///
  /// In en, this message translates to:
  /// **'Pause proxy when idle stops traffic forwarding and health checks while the screen is off and the system is idle, which may disconnect calls and live audio and delay push notifications'**
  String get suspendOnIdleDesc;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'{label} details'**
  String details(Object label);

  /// No description provided for @creationTime.
  ///
  /// In en, this message translates to:
  /// **'Creation time'**
  String get creationTime;

  /// No description provided for @process.
  ///
  /// In en, this message translates to:
  /// **'Process'**
  String get process;

  /// No description provided for @host.
  ///
  /// In en, this message translates to:
  /// **'Host'**
  String get host;

  /// No description provided for @destination.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get destination;

  /// No description provided for @destinationGeoIP.
  ///
  /// In en, this message translates to:
  /// **'Destination GeoIP'**
  String get destinationGeoIP;

  /// No description provided for @destinationIPASN.
  ///
  /// In en, this message translates to:
  /// **'Destination IPASN'**
  String get destinationIPASN;

  /// No description provided for @specialProxy.
  ///
  /// In en, this message translates to:
  /// **'Special proxy'**
  String get specialProxy;

  /// No description provided for @specialRules.
  ///
  /// In en, this message translates to:
  /// **'special rules'**
  String get specialRules;

  /// No description provided for @remoteDestination.
  ///
  /// In en, this message translates to:
  /// **'Remote destination'**
  String get remoteDestination;

  /// No description provided for @networkType.
  ///
  /// In en, this message translates to:
  /// **'Network type'**
  String get networkType;

  /// No description provided for @proxyChains.
  ///
  /// In en, this message translates to:
  /// **'Proxy chains'**
  String get proxyChains;

  /// No description provided for @proxyChainWarning.
  ///
  /// In en, this message translates to:
  /// **'Proxy chaining can significantly reduce network speed. Keep it disabled unless you clearly need it.'**
  String get proxyChainWarning;

  /// No description provided for @proxyChainInstruction.
  ///
  /// In en, this message translates to:
  /// **'Choose hops from entry to exit. Nodes or policy groups can occupy any hop. Concrete group members use the preceding hop; nested groups and DIRECT/REJECT stay unchanged. After saving, the chain appears under its name as a policy group in the proxy list and rule targets. Delays in this editor are per-hop references; test the chain\'s group to measure the effective route.'**
  String get proxyChainInstruction;

  /// No description provided for @proxyChainMinimumNodes.
  ///
  /// In en, this message translates to:
  /// **'A proxy chain needs an entry and an exit'**
  String get proxyChainMinimumNodes;

  /// No description provided for @proxyChainMinimumNodesHint.
  ///
  /// In en, this message translates to:
  /// **'Choose an exit node or policy group.'**
  String get proxyChainMinimumNodesHint;

  /// No description provided for @proxyChainPolicyGroups.
  ///
  /// In en, this message translates to:
  /// **'Policy groups'**
  String get proxyChainPolicyGroups;

  /// No description provided for @proxyChainUnsupportedGroupTip.
  ///
  /// In en, this message translates to:
  /// **'Only select, url-test, fallback, and load-balance groups can be used in a chain.'**
  String get proxyChainUnsupportedGroupTip;

  /// No description provided for @proxyChainEntry.
  ///
  /// In en, this message translates to:
  /// **'Entry'**
  String get proxyChainEntry;

  /// No description provided for @proxyChainExit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get proxyChainExit;

  /// No description provided for @clearProxyChain.
  ///
  /// In en, this message translates to:
  /// **'Clear chain config'**
  String get clearProxyChain;

  /// No description provided for @proxyChainCustomNodes.
  ///
  /// In en, this message translates to:
  /// **'Custom nodes'**
  String get proxyChainCustomNodes;

  /// No description provided for @proxyChainCustomNode.
  ///
  /// In en, this message translates to:
  /// **'Custom node'**
  String get proxyChainCustomNode;

  /// No description provided for @addProxyChainNode.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addProxyChainNode;

  /// No description provided for @proxyChainOtherNodes.
  ///
  /// In en, this message translates to:
  /// **'Other nodes'**
  String get proxyChainOtherNodes;

  /// No description provided for @proxyChainSavedAndApplied.
  ///
  /// In en, this message translates to:
  /// **'Proxy chain saved and applied. Select it by its name in rules or in the proxy list.'**
  String get proxyChainSavedAndApplied;

  /// No description provided for @proxyChainConflictTip.
  ///
  /// In en, this message translates to:
  /// **'Proxy {name} conflicts with another enabled chain or creates a loop'**
  String proxyChainConflictTip(Object name);

  /// No description provided for @proxyChainUnavailableNodeTip.
  ///
  /// In en, this message translates to:
  /// **'Proxy {name} is not available in this position'**
  String proxyChainUnavailableNodeTip(Object name);

  /// No description provided for @proxyChainUnavailableReference.
  ///
  /// In en, this message translates to:
  /// **'Proxy chain “{chainName}” references an unavailable node or policy group “{nodeName}”. Select it again in “Proxy chains”, or disable this chain.'**
  String proxyChainUnavailableReference(Object chainName, Object nodeName);

  /// No description provided for @proxyChainRelatedChainsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Related proxy chains updated'**
  String get proxyChainRelatedChainsUpdated;

  /// No description provided for @proxyChainSelectedNodes.
  ///
  /// In en, this message translates to:
  /// **'Proxy chain'**
  String get proxyChainSelectedNodes;

  /// No description provided for @proxyChainAvailableNodes.
  ///
  /// In en, this message translates to:
  /// **'Available nodes and groups'**
  String get proxyChainAvailableNodes;

  /// No description provided for @proxyChainEmpty.
  ///
  /// In en, this message translates to:
  /// **'No nodes in the proxy chain'**
  String get proxyChainEmpty;

  /// No description provided for @proxyChainNodeAdded.
  ///
  /// In en, this message translates to:
  /// **'Node added to proxy chain'**
  String get proxyChainNodeAdded;

  /// No description provided for @proxyChainUriNodeSupportedFormats.
  ///
  /// In en, this message translates to:
  /// **'Supported formats: ss://, ssr://, vmess://, vless://, trojan://, anytls://, hysteria:// / hy://, hysteria2:// / hy2://, tuic://, wireguard:// / wg://, http(s)://, socks(5)://'**
  String get proxyChainUriNodeSupportedFormats;

  /// No description provided for @log.
  ///
  /// In en, this message translates to:
  /// **'Log'**
  String get log;

  /// No description provided for @connection.
  ///
  /// In en, this message translates to:
  /// **'Connection'**
  String get connection;

  /// No description provided for @request.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get request;

  /// No description provided for @connected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connected;

  /// No description provided for @disconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get disconnected;

  /// No description provided for @connecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get connecting;

  /// No description provided for @restartCoreTip.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to restart the core?'**
  String get restartCoreTip;

  /// No description provided for @forceRestartCoreTip.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to force restart the core?'**
  String get forceRestartCoreTip;

  /// No description provided for @dnsHijacking.
  ///
  /// In en, this message translates to:
  /// **'DNS hijacking'**
  String get dnsHijacking;

  /// No description provided for @coreStatus.
  ///
  /// In en, this message translates to:
  /// **'Core status'**
  String get coreStatus;

  /// No description provided for @coreNotConnected.
  ///
  /// In en, this message translates to:
  /// **'Core is not connected'**
  String get coreNotConnected;

  /// No description provided for @appendSystemDns.
  ///
  /// In en, this message translates to:
  /// **'Append system DNS'**
  String get appendSystemDns;

  /// No description provided for @blockQuic.
  ///
  /// In en, this message translates to:
  /// **'Block QUIC'**
  String get blockQuic;

  /// No description provided for @blockQuicDesc.
  ///
  /// In en, this message translates to:
  /// **'Reject UDP 443 traffic to force connections back to TCP'**
  String get blockQuicDesc;

  /// No description provided for @blockWebRtc.
  ///
  /// In en, this message translates to:
  /// **'Block WebRTC'**
  String get blockWebRtc;

  /// No description provided for @blockWebRtcDesc.
  ///
  /// In en, this message translates to:
  /// **'Reject STUN traffic to reduce WebRTC IP leaks.'**
  String get blockWebRtcDesc;

  /// No description provided for @editRule.
  ///
  /// In en, this message translates to:
  /// **'Edit rule'**
  String get editRule;

  /// No description provided for @overrideMode.
  ///
  /// In en, this message translates to:
  /// **'Override mode'**
  String get overrideMode;

  /// No description provided for @standardModeDesc.
  ///
  /// In en, this message translates to:
  /// **'Standard mode, optionally runs an override script, then adds rules on top of the configuration'**
  String get standardModeDesc;

  /// No description provided for @addedRulesAfterScript.
  ///
  /// In en, this message translates to:
  /// **'Inserted after the script runs, ahead of the profile\'s rules'**
  String get addedRulesAfterScript;

  /// No description provided for @addedRules.
  ///
  /// In en, this message translates to:
  /// **'Added rules'**
  String get addedRules;

  /// No description provided for @controlGlobalAddedRules.
  ///
  /// In en, this message translates to:
  /// **'Control global added rules'**
  String get controlGlobalAddedRules;

  /// No description provided for @overrideScript.
  ///
  /// In en, this message translates to:
  /// **'Override script'**
  String get overrideScript;

  /// No description provided for @goToConfigureScript.
  ///
  /// In en, this message translates to:
  /// **'Go to configure script'**
  String get goToConfigureScript;

  /// No description provided for @editGlobalRules.
  ///
  /// In en, this message translates to:
  /// **'Edit global rules'**
  String get editGlobalRules;

  /// No description provided for @confirmForceCrashCore.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to force crash the core?'**
  String get confirmForceCrashCore;

  /// No description provided for @confirmClearAllData.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear all data?'**
  String get confirmClearAllData;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @yearsAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 year ago} other{{count} years ago}}'**
  String yearsAgo(num count);

  /// No description provided for @monthsAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 month ago} other{{count} months ago}}'**
  String monthsAgo(num count);

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day ago} other{{count} days ago}}'**
  String daysAgo(num count);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 hour ago} other{{count} hours ago}}'**
  String hoursAgo(num count);

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 minute ago} other{{count} minutes ago}}'**
  String minutesAgo(num count);

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @turnOn.
  ///
  /// In en, this message translates to:
  /// **'Turn On'**
  String get turnOn;

  /// No description provided for @turnOff.
  ///
  /// In en, this message translates to:
  /// **'Turn Off'**
  String get turnOff;

  /// No description provided for @vpnConfigChangeDetected.
  ///
  /// In en, this message translates to:
  /// **'VPN settings changed. Tap to restart'**
  String get vpnConfigChangeDetected;

  /// No description provided for @restart.
  ///
  /// In en, this message translates to:
  /// **'Restart'**
  String get restart;

  /// No description provided for @speedStatistics.
  ///
  /// In en, this message translates to:
  /// **'Speed statistics'**
  String get speedStatistics;

  /// No description provided for @resetPageChangesTip.
  ///
  /// In en, this message translates to:
  /// **'The current page has changes. Are you sure you want to reset?'**
  String get resetPageChangesTip;

  /// No description provided for @overwriteTypeCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get overwriteTypeCustom;

  /// No description provided for @overwriteTypeCustomDesc.
  ///
  /// In en, this message translates to:
  /// **'Custom mode, fully customize proxy groups and rules'**
  String get overwriteTypeCustomDesc;

  /// No description provided for @emptyCustomOverwrite.
  ///
  /// In en, this message translates to:
  /// **'Custom override is empty. Use Quick fill or add rules and proxy groups first. To keep subscription content, use Overlay mode.'**
  String get emptyCustomOverwrite;

  /// No description provided for @proxyGroupEmpty.
  ///
  /// In en, this message translates to:
  /// **'Proxy group is empty'**
  String get proxyGroupEmpty;

  /// No description provided for @proxyGroupNameEmpty.
  ///
  /// In en, this message translates to:
  /// **'Proxy group name cannot be empty'**
  String get proxyGroupNameEmpty;

  /// No description provided for @ruleEmpty.
  ///
  /// In en, this message translates to:
  /// **'Rule is empty'**
  String get ruleEmpty;

  /// No description provided for @confirmOverwriteTip.
  ///
  /// In en, this message translates to:
  /// **'Existing data will be overwritten after confirmation'**
  String get confirmOverwriteTip;

  /// No description provided for @configDataDetected.
  ///
  /// In en, this message translates to:
  /// **'Data detected in configuration'**
  String get configDataDetected;

  /// No description provided for @quickFill.
  ///
  /// In en, this message translates to:
  /// **'Quick fill'**
  String get quickFill;

  /// No description provided for @clearCustomRouting.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get clearCustomRouting;

  /// No description provided for @confirmClearCustomRouting.
  ///
  /// In en, this message translates to:
  /// **'Clear this profile’s custom proxy groups and rules? Subscription content, added rules, proxy chains, and custom nodes will be kept.'**
  String get confirmClearCustomRouting;

  /// No description provided for @addProxyGroup.
  ///
  /// In en, this message translates to:
  /// **'Add proxy group'**
  String get addProxyGroup;

  /// No description provided for @editProxyGroup.
  ///
  /// In en, this message translates to:
  /// **'Edit proxy group'**
  String get editProxyGroup;

  /// No description provided for @lazy.
  ///
  /// In en, this message translates to:
  /// **'Lazy loading'**
  String get lazy;

  /// No description provided for @proxyFilter.
  ///
  /// In en, this message translates to:
  /// **'Proxy filter'**
  String get proxyFilter;

  /// No description provided for @excludeProxyFilter.
  ///
  /// In en, this message translates to:
  /// **'Exclude proxy filter'**
  String get excludeProxyFilter;

  /// No description provided for @excludeType.
  ///
  /// In en, this message translates to:
  /// **'Exclude type'**
  String get excludeType;

  /// No description provided for @expectedStatus.
  ///
  /// In en, this message translates to:
  /// **'Expected status'**
  String get expectedStatus;

  /// No description provided for @maxFailedTimes.
  ///
  /// In en, this message translates to:
  /// **'Max failed times'**
  String get maxFailedTimes;

  /// No description provided for @timeout.
  ///
  /// In en, this message translates to:
  /// **'Timeout'**
  String get timeout;

  /// No description provided for @strategy.
  ///
  /// In en, this message translates to:
  /// **'Strategy'**
  String get strategy;

  /// No description provided for @iconUrl.
  ///
  /// In en, this message translates to:
  /// **'Icon URL'**
  String get iconUrl;

  /// No description provided for @disableUDP.
  ///
  /// In en, this message translates to:
  /// **'Disable UDP'**
  String get disableUDP;

  /// No description provided for @hideFromList.
  ///
  /// In en, this message translates to:
  /// **'Hide from list'**
  String get hideFromList;

  /// No description provided for @includeAll.
  ///
  /// In en, this message translates to:
  /// **'Include all proxies and providers'**
  String get includeAll;

  /// No description provided for @includeAllProxies.
  ///
  /// In en, this message translates to:
  /// **'Include all proxies'**
  String get includeAllProxies;

  /// No description provided for @includeAllProxyProviders.
  ///
  /// In en, this message translates to:
  /// **'Include all proxy providers'**
  String get includeAllProxyProviders;

  /// No description provided for @proxyGroupMembersEmpty.
  ///
  /// In en, this message translates to:
  /// **'Add a proxy, provider, or include-all option'**
  String get proxyGroupMembersEmpty;

  /// No description provided for @tolerance.
  ///
  /// In en, this message translates to:
  /// **'Tolerance'**
  String get tolerance;

  /// No description provided for @customOutboundInUse.
  ///
  /// In en, this message translates to:
  /// **'{name} is still referenced by a group, rule, or proxy chain'**
  String customOutboundInUse(Object name);

  /// No description provided for @relayGroupUnsupported.
  ///
  /// In en, this message translates to:
  /// **'Relay groups were removed by the core. Choose another type.'**
  String get relayGroupUnsupported;

  /// No description provided for @rawOutboundInUse.
  ///
  /// In en, this message translates to:
  /// **'{name} is referenced by the original configuration at {path}'**
  String rawOutboundInUse(Object name, Object path);

  /// No description provided for @unknownNetworkError.
  ///
  /// In en, this message translates to:
  /// **'Unknown network error'**
  String get unknownNetworkError;

  /// No description provided for @restoreException.
  ///
  /// In en, this message translates to:
  /// **'Recovery exception'**
  String get restoreException;

  /// No description provided for @networkException.
  ///
  /// In en, this message translates to:
  /// **'Network exception, please check your connection and try again'**
  String get networkException;

  /// No description provided for @invalidBackupFile.
  ///
  /// In en, this message translates to:
  /// **'Invalid backup file'**
  String get invalidBackupFile;

  /// No description provided for @backupFromNewerVersion.
  ///
  /// In en, this message translates to:
  /// **'This backup comes from a newer version of the app. Update the app before restoring it'**
  String get backupFromNewerVersion;

  /// No description provided for @pruneCache.
  ///
  /// In en, this message translates to:
  /// **'Prune cache'**
  String get pruneCache;

  /// No description provided for @backupAndRestore.
  ///
  /// In en, this message translates to:
  /// **'Backup and Restore'**
  String get backupAndRestore;

  /// No description provided for @backupAndRestoreDesc.
  ///
  /// In en, this message translates to:
  /// **'Sync data via WebDAV or files'**
  String get backupAndRestoreDesc;

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restore;

  /// No description provided for @restoreDefault.
  ///
  /// In en, this message translates to:
  /// **'Restore Default'**
  String get restoreDefault;

  /// No description provided for @restoreSuccess.
  ///
  /// In en, this message translates to:
  /// **'Restore success'**
  String get restoreSuccess;

  /// No description provided for @restoreFromWebDAVDesc.
  ///
  /// In en, this message translates to:
  /// **'Restore data via WebDAV'**
  String get restoreFromWebDAVDesc;

  /// No description provided for @restoreFromFileDesc.
  ///
  /// In en, this message translates to:
  /// **'Restore data via file'**
  String get restoreFromFileDesc;

  /// No description provided for @restoreOnlyConfig.
  ///
  /// In en, this message translates to:
  /// **'Restore configuration files only'**
  String get restoreOnlyConfig;

  /// No description provided for @restoreAllData.
  ///
  /// In en, this message translates to:
  /// **'Restore all data'**
  String get restoreAllData;

  /// No description provided for @backupRetention.
  ///
  /// In en, this message translates to:
  /// **'Backups to keep'**
  String get backupRetention;

  /// No description provided for @backupRetentionDesc.
  ///
  /// In en, this message translates to:
  /// **'Each backup removes this device\'s older WebDAV backups'**
  String get backupRetentionDesc;

  /// No description provided for @selectBackup.
  ///
  /// In en, this message translates to:
  /// **'Select a backup'**
  String get selectBackup;

  /// No description provided for @noRemoteBackup.
  ///
  /// In en, this message translates to:
  /// **'No backups on WebDAV'**
  String get noRemoteBackup;

  /// No description provided for @deleteBackupTip.
  ///
  /// In en, this message translates to:
  /// **'Delete this backup from WebDAV?'**
  String get deleteBackupTip;

  /// No description provided for @addProfile.
  ///
  /// In en, this message translates to:
  /// **'Add Profile'**
  String get addProfile;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @delayTest.
  ///
  /// In en, this message translates to:
  /// **'Delay Test'**
  String get delayTest;

  /// No description provided for @userCenter.
  ///
  /// In en, this message translates to:
  /// **'User Center'**
  String get userCenter;

  /// No description provided for @userCenterFallback.
  ///
  /// In en, this message translates to:
  /// **'User Center (Backup)'**
  String get userCenterFallback;

  /// No description provided for @userGuide.
  ///
  /// In en, this message translates to:
  /// **'User Guide'**
  String get userGuide;

  /// No description provided for @oixCloud.
  ///
  /// In en, this message translates to:
  /// **'oixCloud'**
  String get oixCloud;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get registerTitle;

  /// No description provided for @registerFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get registerFailed;

  /// No description provided for @registerClosed.
  ///
  /// In en, this message translates to:
  /// **'Registration is currently closed'**
  String get registerClosed;

  /// No description provided for @haveAccountAlready.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get haveAccountAlready;

  /// No description provided for @goLogin.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get goLogin;

  /// No description provided for @nicknameLabel.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get nicknameLabel;

  /// No description provided for @nicknameHint.
  ///
  /// In en, this message translates to:
  /// **'Letters and numbers, up to 12 characters'**
  String get nicknameHint;

  /// No description provided for @nicknameValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter a nickname'**
  String get nicknameValidation;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your password'**
  String get confirmPasswordHint;

  /// No description provided for @confirmPasswordValidation.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirmPasswordValidation;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordMismatch;

  /// No description provided for @passwordRuleHint.
  ///
  /// In en, this message translates to:
  /// **'10-36 chars incl. upper/lowercase, number and symbol'**
  String get passwordRuleHint;

  /// No description provided for @inviteCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Invite Code'**
  String get inviteCodeLabel;

  /// No description provided for @inviteCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Enter invite code'**
  String get inviteCodeHint;

  /// No description provided for @inviteCodeValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter the invite code'**
  String get inviteCodeValidation;

  /// No description provided for @emailCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Code'**
  String get emailCodeLabel;

  /// No description provided for @emailCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code'**
  String get emailCodeHint;

  /// No description provided for @emailCodeValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter the email code'**
  String get emailCodeValidation;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendCode;

  /// No description provided for @resendCodeIn.
  ///
  /// In en, this message translates to:
  /// **'Resend in {seconds}s'**
  String resendCodeIn(Object seconds);

  /// No description provided for @codeSent.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent'**
  String get codeSent;

  /// No description provided for @loggedOutViewTitle.
  ///
  /// In en, this message translates to:
  /// **'oixCloud'**
  String get loggedOutViewTitle;

  /// No description provided for @loggedOutViewDesc.
  ///
  /// In en, this message translates to:
  /// **'Login to view account info and manage subscriptions'**
  String get loggedOutViewDesc;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// No description provided for @googleLoginWaiting.
  ///
  /// In en, this message translates to:
  /// **'Complete Google sign-in in your browser'**
  String get googleLoginWaiting;

  /// No description provided for @googleLoginUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Could not open Google sign-in. Please try again.'**
  String get googleLoginUnavailable;

  /// No description provided for @googleLoginTimedOut.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in timed out. Please try again.'**
  String get googleLoginTimedOut;

  /// No description provided for @googleLoginInvalidCallback.
  ///
  /// In en, this message translates to:
  /// **'Could not verify Google sign-in. Please try again.'**
  String get googleLoginInvalidCallback;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @startCorePromptTitle.
  ///
  /// In en, this message translates to:
  /// **'Prompt'**
  String get startCorePromptTitle;

  /// No description provided for @startCorePromptContent.
  ///
  /// In en, this message translates to:
  /// **'Profile has been successfully imported. Do you want to start the core now?'**
  String get startCorePromptContent;

  /// No description provided for @logoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutTitle;

  /// No description provided for @logoutContent.
  ///
  /// In en, this message translates to:
  /// **'Sign out?'**
  String get logoutContent;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login Successful'**
  String get loginSuccess;

  /// No description provided for @getProfileSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile imported successfully'**
  String get getProfileSuccess;

  /// No description provided for @startSuccess.
  ///
  /// In en, this message translates to:
  /// **'Started successfully'**
  String get startSuccess;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login Failed'**
  String get loginFailed;

  /// No description provided for @invalidCertificateTitle.
  ///
  /// In en, this message translates to:
  /// **'Certificate Verification Failed'**
  String get invalidCertificateTitle;

  /// No description provided for @certificateExpired.
  ///
  /// In en, this message translates to:
  /// **'Certificate has expired'**
  String get certificateExpired;

  /// No description provided for @certificateNotYetValid.
  ///
  /// In en, this message translates to:
  /// **'Certificate is not yet valid'**
  String get certificateNotYetValid;

  /// No description provided for @certificateHostnameMismatch.
  ///
  /// In en, this message translates to:
  /// **'Certificate does not match the requested domain'**
  String get certificateHostnameMismatch;

  /// No description provided for @certificateUntrusted.
  ///
  /// In en, this message translates to:
  /// **'Certificate chain is not trusted'**
  String get certificateUntrusted;

  /// No description provided for @certificateValidityHint.
  ///
  /// In en, this message translates to:
  /// **'First synchronize the system date and time. If the time is correct, the server certificate needs to be fixed.'**
  String get certificateValidityHint;

  /// No description provided for @invalidCertificateContent.
  ///
  /// In en, this message translates to:
  /// **'The server certificate could not be verified. Skipping verification means the server may be impersonated, and any account credentials or subscription data you send or receive could be stolen or altered.\n\nProceed only if you trust this network and server. This exception applies only to this retry with the same server and certificate, and is removed when the operation ends.'**
  String get invalidCertificateContent;

  /// No description provided for @allowTemporarily.
  ///
  /// In en, this message translates to:
  /// **'Allow Temporarily'**
  String get allowTemporarily;

  /// No description provided for @retryWithoutCertificateVerification.
  ///
  /// In en, this message translates to:
  /// **'Temporarily Check API'**
  String get retryWithoutCertificateVerification;

  /// No description provided for @apiAvailableWithCertificateException.
  ///
  /// In en, this message translates to:
  /// **'The API was reachable with a temporary certificate exception. No account or node configuration was synced. Fix the certificate issue, then check again.'**
  String get apiAvailableWithCertificateException;

  /// No description provided for @certificateUntrustedHint.
  ///
  /// In en, this message translates to:
  /// **'Try a different network, such as a phone hotspot, and check for system updates. If antivirus software or a company network inspects HTTPS, ask its administrator to check it. If the problem persists, contact the service provider to check the certificate chain.'**
  String get certificateUntrustedHint;

  /// No description provided for @certificateHostnameHint.
  ///
  /// In en, this message translates to:
  /// **'Try a different network and complete any Wi-Fi sign-in first. If the problem persists, contact the service provider to check that the certificate matches the server domain.'**
  String get certificateHostnameHint;

  /// No description provided for @certificateRevokedHint.
  ///
  /// In en, this message translates to:
  /// **'Contact the service provider to replace the revoked certificate. Retrying or changing the system time will not fix a revoked certificate.'**
  String get certificateRevokedHint;

  /// No description provided for @certificateUnknownHint.
  ///
  /// In en, this message translates to:
  /// **'Check the system date and time, then try a different network. If verification still fails, send this error to the service provider for help.'**
  String get certificateUnknownHint;

  /// No description provided for @certificateCheckOnlyHint.
  ///
  /// In en, this message translates to:
  /// **'This action only checks API connectivity. It does not sign in or download node configurations.'**
  String get certificateCheckOnlyHint;

  /// No description provided for @certificateSyncRetryDescription.
  ///
  /// In en, this message translates to:
  /// **'After confirmation, this attempt checks the connection, refreshes your account, and downloads the node configuration. The certificate exception ends when this sync finishes.'**
  String get certificateSyncRetryDescription;

  /// No description provided for @retryCloudSyncWithCertificateException.
  ///
  /// In en, this message translates to:
  /// **'Allow Temporarily and Sync'**
  String get retryCloudSyncWithCertificateException;

  /// No description provided for @cloudSyncedWithCertificateException.
  ///
  /// In en, this message translates to:
  /// **'Account and configuration sync completed with a temporary certificate exception. Verification is now restored; resolve the certificate issue before the next sync.'**
  String get cloudSyncedWithCertificateException;

  /// No description provided for @cloudCertificateSyncFailed.
  ///
  /// In en, this message translates to:
  /// **'The API check passed, but account or node configuration sync failed: '**
  String get cloudCertificateSyncFailed;

  /// No description provided for @cloudConfigSyncIncomplete.
  ///
  /// In en, this message translates to:
  /// **'The node configuration was not downloaded. Resolve the download error and sync again.'**
  String get cloudConfigSyncIncomplete;

  /// No description provided for @emailPassword.
  ///
  /// In en, this message translates to:
  /// **'Email & Password'**
  String get emailPassword;

  /// No description provided for @accessToken.
  ///
  /// In en, this message translates to:
  /// **'Access Token'**
  String get accessToken;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter email address'**
  String get emailHint;

  /// No description provided for @emailValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter email'**
  String get emailValidation;

  /// No description provided for @emailFormatValidation.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get emailFormatValidation;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPasswordTitle;

  /// No description provided for @sendResetEmail.
  ///
  /// In en, this message translates to:
  /// **'Send reset email'**
  String get sendResetEmail;

  /// No description provided for @resetEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Reset email sent. Paste the reset link or code from the email below.'**
  String get resetEmailSent;

  /// No description provided for @resetTokenLabel.
  ///
  /// In en, this message translates to:
  /// **'Reset link or code'**
  String get resetTokenLabel;

  /// No description provided for @resetTokenValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter the reset link or code'**
  String get resetTokenValidation;

  /// No description provided for @newPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPasswordLabel;

  /// No description provided for @resetPasswordSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password has been reset, please sign in with your new password'**
  String get resetPasswordSuccess;

  /// No description provided for @passwordValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter password'**
  String get passwordValidation;

  /// No description provided for @tokenLabel.
  ///
  /// In en, this message translates to:
  /// **'Access Token'**
  String get tokenLabel;

  /// No description provided for @tokenValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter Access Token'**
  String get tokenValidation;

  /// No description provided for @expireDate.
  ///
  /// In en, this message translates to:
  /// **'Expires: {date}'**
  String expireDate(Object date);

  /// No description provided for @todayUsed.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Usage'**
  String get todayUsed;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining: {value}'**
  String remaining(Object value);

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @commission.
  ///
  /// In en, this message translates to:
  /// **'Commission'**
  String get commission;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// No description provided for @announcement.
  ///
  /// In en, this message translates to:
  /// **'Announcement'**
  String get announcement;

  /// No description provided for @readFullAnnouncement.
  ///
  /// In en, this message translates to:
  /// **'Read full announcement'**
  String get readFullAnnouncement;

  /// No description provided for @serviceCheckFailed.
  ///
  /// In en, this message translates to:
  /// **'Service Check Failed'**
  String get serviceCheckFailed;

  /// No description provided for @apiAvailable.
  ///
  /// In en, this message translates to:
  /// **'API service is operational'**
  String get apiAvailable;

  /// No description provided for @checkApi.
  ///
  /// In en, this message translates to:
  /// **'Check API'**
  String get checkApi;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @nodeFilter.
  ///
  /// In en, this message translates to:
  /// **'Node Filter'**
  String get nodeFilter;

  /// No description provided for @nodeFilterSmartSelection.
  ///
  /// In en, this message translates to:
  /// **'Smart Selection'**
  String get nodeFilterSmartSelection;

  /// No description provided for @nodeFilterCustomized.
  ///
  /// In en, this message translates to:
  /// **'Customized'**
  String get nodeFilterCustomized;

  /// No description provided for @nodeFilterKept.
  ///
  /// In en, this message translates to:
  /// **'{kept} of {total} nodes kept'**
  String nodeFilterKept(Object kept, Object total);

  /// No description provided for @nodeFilterLines.
  ///
  /// In en, this message translates to:
  /// **'Lines'**
  String get nodeFilterLines;

  /// No description provided for @nodeFilterRegions.
  ///
  /// In en, this message translates to:
  /// **'Regions'**
  String get nodeFilterRegions;

  /// No description provided for @nodeFilterNameContains.
  ///
  /// In en, this message translates to:
  /// **'Name contains'**
  String get nodeFilterNameContains;

  /// No description provided for @nodeFilterNameExcludes.
  ///
  /// In en, this message translates to:
  /// **'Name excludes'**
  String get nodeFilterNameExcludes;

  /// No description provided for @nodeFilterPreview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get nodeFilterPreview;

  /// No description provided for @nodeFilterSearch.
  ///
  /// In en, this message translates to:
  /// **'Search nodes'**
  String get nodeFilterSearch;

  /// No description provided for @nodeFilterAny.
  ///
  /// In en, this message translates to:
  /// **'Any'**
  String get nodeFilterAny;

  /// No description provided for @nodeFilterOnly.
  ///
  /// In en, this message translates to:
  /// **'Only'**
  String get nodeFilterOnly;

  /// No description provided for @nodeFilterExclude.
  ///
  /// In en, this message translates to:
  /// **'Exclude'**
  String get nodeFilterExclude;

  /// No description provided for @nodeFilterKeepOne.
  ///
  /// In en, this message translates to:
  /// **'Keep at least one node'**
  String get nodeFilterKeepOne;

  /// No description provided for @nodeFilterNodeKept.
  ///
  /// In en, this message translates to:
  /// **'{name}, kept'**
  String nodeFilterNodeKept(Object name);

  /// No description provided for @nodeFilterNodeExcluded.
  ///
  /// In en, this message translates to:
  /// **'{name}, excluded'**
  String nodeFilterNodeExcluded(Object name);

  /// No description provided for @nodeFilterRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get nodeFilterRetry;

  /// No description provided for @nodeFilterAccountNote.
  ///
  /// In en, this message translates to:
  /// **'Saved to your account and applies to every device signed in to this app.'**
  String get nodeFilterAccountNote;

  /// No description provided for @nodeFilterUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Node filters are available once you have a plan'**
  String get nodeFilterUnavailable;

  /// No description provided for @minimalConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Minimal Configuration'**
  String get minimalConfiguration;

  /// No description provided for @minimalConfigurationDesc.
  ///
  /// In en, this message translates to:
  /// **'Use a simplified rule set to generate a smaller profile'**
  String get minimalConfigurationDesc;

  /// No description provided for @tcpFastOpen.
  ///
  /// In en, this message translates to:
  /// **'TCP Fast Open'**
  String get tcpFastOpen;

  /// No description provided for @tcpFastOpenDesc.
  ///
  /// In en, this message translates to:
  /// **'Enable this option to accelerate TCP connection establishment'**
  String get tcpFastOpenDesc;

  /// No description provided for @store.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get store;

  /// No description provided for @recharge.
  ///
  /// In en, this message translates to:
  /// **'Recharge'**
  String get recharge;

  /// No description provided for @availablePlans.
  ///
  /// In en, this message translates to:
  /// **'Choose a Plan'**
  String get availablePlans;

  /// No description provided for @noAvailablePlans.
  ///
  /// In en, this message translates to:
  /// **'No plans available'**
  String get noAvailablePlans;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'Purchased Plans'**
  String get myOrders;

  /// No description provided for @noPurchaseRecords.
  ///
  /// In en, this message translates to:
  /// **'No purchased plans yet'**
  String get noPurchaseRecords;

  /// No description provided for @accountBalance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get accountBalance;

  /// No description provided for @commissionBalance.
  ///
  /// In en, this message translates to:
  /// **'Commission {value}'**
  String commissionBalance(Object value);

  /// No description provided for @soldOut.
  ///
  /// In en, this message translates to:
  /// **'Sold out'**
  String get soldOut;

  /// No description provided for @remainingStock.
  ///
  /// In en, this message translates to:
  /// **'Only {count} left'**
  String remainingStock(Object count);

  /// No description provided for @mainlandNetworkWarning.
  ///
  /// In en, this message translates to:
  /// **'May not be suitable for networks in mainland China'**
  String get mainlandNetworkWarning;

  /// No description provided for @planInUse.
  ///
  /// In en, this message translates to:
  /// **'In use'**
  String get planInUse;

  /// No description provided for @planNotActivated.
  ///
  /// In en, this message translates to:
  /// **'Pending activation'**
  String get planNotActivated;

  /// No description provided for @planEnded.
  ///
  /// In en, this message translates to:
  /// **'Ended'**
  String get planEnded;

  /// No description provided for @planAwaitingAutoRenewal.
  ///
  /// In en, this message translates to:
  /// **'Awaiting auto-renewal'**
  String get planAwaitingAutoRenewal;

  /// No description provided for @planAwaitingAutoRenewalNote.
  ///
  /// In en, this message translates to:
  /// **'Queued after your other plans; renews automatically once they are used up'**
  String get planAwaitingAutoRenewalNote;

  /// No description provided for @planAutoRenewalOffNote.
  ///
  /// In en, this message translates to:
  /// **'Queued after your other plans; ends once they are used up'**
  String get planAutoRenewalOffNote;

  /// No description provided for @planNumber.
  ///
  /// In en, this message translates to:
  /// **'Plan #{id}'**
  String planNumber(Object id);

  /// No description provided for @activate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get activate;

  /// No description provided for @upgradePlan.
  ///
  /// In en, this message translates to:
  /// **'Upgrade plan'**
  String get upgradePlan;

  /// No description provided for @noPaymentMethods.
  ///
  /// In en, this message translates to:
  /// **'No payment methods available'**
  String get noPaymentMethods;

  /// No description provided for @activatePlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Activate plan'**
  String get activatePlanTitle;

  /// No description provided for @activatePlanConfirm.
  ///
  /// In en, this message translates to:
  /// **'Activate this plan? It will become your active plan.'**
  String get activatePlanConfirm;

  /// No description provided for @noUpgradablePlans.
  ///
  /// In en, this message translates to:
  /// **'No upgradable plans'**
  String get noUpgradablePlans;

  /// No description provided for @selectUpgradeTarget.
  ///
  /// In en, this message translates to:
  /// **'Select upgrade target'**
  String get selectUpgradeTarget;

  /// No description provided for @refreshAfterPayment.
  ///
  /// In en, this message translates to:
  /// **'After payment, pull down to refresh and check the result'**
  String get refreshAfterPayment;

  /// No description provided for @discountCodeOptional.
  ///
  /// In en, this message translates to:
  /// **'Discount code (optional)'**
  String get discountCodeOptional;

  /// No description provided for @bindCoupon.
  ///
  /// In en, this message translates to:
  /// **'Apply coupon'**
  String get bindCoupon;

  /// No description provided for @bindCouponIntro.
  ///
  /// In en, this message translates to:
  /// **'Enter an official coupon code. The difference is settled for the remaining plan duration, and a recurring coupon also updates the renewal price.'**
  String get bindCouponIntro;

  /// No description provided for @verifyCoupon.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verifyCoupon;

  /// No description provided for @discountCode.
  ///
  /// In en, this message translates to:
  /// **'Discount code'**
  String get discountCode;

  /// No description provided for @discountCodeRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter a discount code'**
  String get discountCodeRequired;

  /// No description provided for @discountedPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Discounted price'**
  String get discountedPriceLabel;

  /// No description provided for @amountDueLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount due'**
  String get amountDueLabel;

  /// No description provided for @refundAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Refund'**
  String get refundAmountLabel;

  /// No description provided for @recurringRenewalHint.
  ///
  /// In en, this message translates to:
  /// **'Future automatic renewals keep this discount'**
  String get recurringRenewalHint;

  /// No description provided for @insufficientBalanceHint.
  ///
  /// In en, this message translates to:
  /// **'Insufficient balance. Top up before continuing.'**
  String get insufficientBalanceHint;

  /// No description provided for @amountPayable.
  ///
  /// In en, this message translates to:
  /// **'Amount payable'**
  String get amountPayable;

  /// No description provided for @renewalPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Renewal price'**
  String get renewalPriceLabel;

  /// No description provided for @calculatingQuote.
  ///
  /// In en, this message translates to:
  /// **'Calculating…'**
  String get calculatingQuote;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get paymentMethod;

  /// No description provided for @goPay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get goPay;

  /// No description provided for @confirmPurchase.
  ///
  /// In en, this message translates to:
  /// **'Confirm purchase'**
  String get confirmPurchase;

  /// No description provided for @rechargeAmount.
  ///
  /// In en, this message translates to:
  /// **'Recharge amount (¥)'**
  String get rechargeAmount;

  /// No description provided for @invalidAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount'**
  String get invalidAmount;

  /// No description provided for @scanOrTransferPay.
  ///
  /// In en, this message translates to:
  /// **'Scan / Transfer payment'**
  String get scanOrTransferPay;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @checkingPayment.
  ///
  /// In en, this message translates to:
  /// **'Checking...'**
  String get checkingPayment;

  /// No description provided for @paymentPending.
  ///
  /// In en, this message translates to:
  /// **'Payment has not been received yet. Please check again shortly.'**
  String get paymentPending;

  /// No description provided for @iHavePaid.
  ///
  /// In en, this message translates to:
  /// **'I have paid'**
  String get iHavePaid;

  /// No description provided for @openInBrowser.
  ///
  /// In en, this message translates to:
  /// **'Open in browser'**
  String get openInBrowser;

  /// No description provided for @openLinkFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to open the link. Check that a browser is installed and try again.'**
  String get openLinkFailed;

  /// No description provided for @scanToPayNotice.
  ///
  /// In en, this message translates to:
  /// **'Scan with Alipay / WeChat to pay'**
  String get scanToPayNotice;

  /// No description provided for @paymentAmount.
  ///
  /// In en, this message translates to:
  /// **'Payment amount'**
  String get paymentAmount;

  /// No description provided for @receivingAddress.
  ///
  /// In en, this message translates to:
  /// **'Receiving address'**
  String get receivingAddress;

  /// No description provided for @addressCopied.
  ///
  /// In en, this message translates to:
  /// **'Address copied'**
  String get addressCopied;

  /// No description provided for @transferConfirmNotice.
  ///
  /// In en, this message translates to:
  /// **'The system will confirm automatically after the transfer is completed, and the selected plan will be activated.'**
  String get transferConfirmNotice;

  /// No description provided for @operationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Operation successful'**
  String get operationSuccess;

  /// No description provided for @operationFailed.
  ///
  /// In en, this message translates to:
  /// **'Operation failed'**
  String get operationFailed;

  /// No description provided for @paymentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Payment successful'**
  String get paymentSuccess;

  /// No description provided for @paymentRequestFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment request failed'**
  String get paymentRequestFailed;

  /// No description provided for @fetchPlansFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load plans'**
  String get fetchPlansFailed;

  /// No description provided for @storeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Purchase, renew, and upgrade plans'**
  String get storeSubtitle;

  /// No description provided for @paymentUnknownResponse.
  ///
  /// In en, this message translates to:
  /// **'Payment endpoint returned an unknown format'**
  String get paymentUnknownResponse;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buy;

  /// No description provided for @payWithBalance.
  ///
  /// In en, this message translates to:
  /// **'Pay with balance'**
  String get payWithBalance;

  /// No description provided for @availableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available {value}'**
  String availableBalance(Object value);

  /// No description provided for @planUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get planUnavailable;

  /// No description provided for @balanceDeductionHint.
  ///
  /// In en, this message translates to:
  /// **'Purchases use your balance first, then commission for any shortfall.'**
  String get balanceDeductionHint;

  /// No description provided for @rechargeAllowedRange.
  ///
  /// In en, this message translates to:
  /// **'Allowed range {min} – {max}'**
  String rechargeAllowedRange(Object min, Object max);

  /// No description provided for @rechargeAmountOutOfRange.
  ///
  /// In en, this message translates to:
  /// **'The amount is outside the range allowed by this payment method'**
  String get rechargeAmountOutOfRange;

  /// No description provided for @insufficientBalanceRecharge.
  ///
  /// In en, this message translates to:
  /// **'Recharge and try again.'**
  String get insufficientBalanceRecharge;

  /// No description provided for @storeOutcomeUnknown.
  ///
  /// In en, this message translates to:
  /// **'The request may still have gone through. Check Purchased Plans before trying again.'**
  String get storeOutcomeUnknown;

  /// No description provided for @configParseErrorAtLine.
  ///
  /// In en, this message translates to:
  /// **'The configuration format is invalid at line {line}.'**
  String configParseErrorAtLine(Object line);

  /// No description provided for @configTypeMismatch.
  ///
  /// In en, this message translates to:
  /// **'Expected {expected}, but found {actual}.'**
  String configTypeMismatch(Object expected, Object actual);

  /// No description provided for @configYamlFormatHint.
  ///
  /// In en, this message translates to:
  /// **'Check the indentation and \"-\" list markers near this line.'**
  String get configYamlFormatHint;

  /// No description provided for @configValueTypeList.
  ///
  /// In en, this message translates to:
  /// **'a list'**
  String get configValueTypeList;

  /// No description provided for @configValueTypeObject.
  ///
  /// In en, this message translates to:
  /// **'an object'**
  String get configValueTypeObject;

  /// No description provided for @configValueTypeText.
  ///
  /// In en, this message translates to:
  /// **'text'**
  String get configValueTypeText;

  /// No description provided for @configValueTypeBoolean.
  ///
  /// In en, this message translates to:
  /// **'a boolean'**
  String get configValueTypeBoolean;

  /// No description provided for @configValueTypeInteger.
  ///
  /// In en, this message translates to:
  /// **'an integer'**
  String get configValueTypeInteger;

  /// No description provided for @configValueTypeNumber.
  ///
  /// In en, this message translates to:
  /// **'a number'**
  String get configValueTypeNumber;

  /// No description provided for @configValueTypeNull.
  ///
  /// In en, this message translates to:
  /// **'an empty value'**
  String get configValueTypeNull;

  /// No description provided for @configRecoveryTitle.
  ///
  /// In en, this message translates to:
  /// **'Recover local configuration'**
  String get configRecoveryTitle;

  /// No description provided for @configRecoveryMessage.
  ///
  /// In en, this message translates to:
  /// **'Local configuration is temporarily unavailable. Your existing data has been kept. Unlock your device and retry, or reopen the app later.'**
  String get configRecoveryMessage;

  /// No description provided for @configRecoveryRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get configRecoveryRetry;

  /// No description provided for @geoDownloadFailed.
  ///
  /// In en, this message translates to:
  /// **'GEO download failed'**
  String get geoDownloadFailed;

  /// No description provided for @geoFileMissing.
  ///
  /// In en, this message translates to:
  /// **'Not downloaded'**
  String get geoFileMissing;

  /// No description provided for @geoFileReadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not read resource file'**
  String get geoFileReadFailed;

  /// No description provided for @geoDownloadRecoveryHint.
  ///
  /// In en, this message translates to:
  /// **'Download uses the current network rules, or a direct connection when the proxy is unavailable. Retry the current address, choose another source, or enter a custom URL. After validation, the operation will continue automatically.'**
  String get geoDownloadRecoveryHint;

  /// No description provided for @geoOriginalSource.
  ///
  /// In en, this message translates to:
  /// **'Current address'**
  String get geoOriginalSource;

  /// No description provided for @geoBackupSource.
  ///
  /// In en, this message translates to:
  /// **'Backup CDN'**
  String get geoBackupSource;

  /// No description provided for @geoDownloadUrl.
  ///
  /// In en, this message translates to:
  /// **'Download URL'**
  String get geoDownloadUrl;

  /// No description provided for @geoInvalidDownloadUrl.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid HTTP or HTTPS URL'**
  String get geoInvalidDownloadUrl;

  /// No description provided for @purchasedAtLabel.
  ///
  /// In en, this message translates to:
  /// **'Purchase time'**
  String get purchasedAtLabel;

  /// No description provided for @purchasePriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Purchase price'**
  String get purchasePriceLabel;

  /// No description provided for @billingPeriodLabel.
  ///
  /// In en, this message translates to:
  /// **'Billing period'**
  String get billingPeriodLabel;

  /// No description provided for @remainingTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Remaining time'**
  String get remainingTimeLabel;

  /// No description provided for @remainingTrafficLabel.
  ///
  /// In en, this message translates to:
  /// **'Remaining traffic'**
  String get remainingTrafficLabel;

  /// No description provided for @expiresAtLabel.
  ///
  /// In en, this message translates to:
  /// **'Expires at'**
  String get expiresAtLabel;

  /// No description provided for @usedTrafficLabel.
  ///
  /// In en, this message translates to:
  /// **'Used traffic'**
  String get usedTrafficLabel;

  /// No description provided for @purchaseTotalTrafficLabel.
  ///
  /// In en, this message translates to:
  /// **'Total traffic'**
  String get purchaseTotalTrafficLabel;

  /// No description provided for @purchaseAutoRenewLabel.
  ///
  /// In en, this message translates to:
  /// **'Auto-renew'**
  String get purchaseAutoRenewLabel;

  /// No description provided for @purchaseDays.
  ///
  /// In en, this message translates to:
  /// **'{count}d'**
  String purchaseDays(Object count);

  /// No description provided for @purchaseHours.
  ///
  /// In en, this message translates to:
  /// **'{count}h'**
  String purchaseHours(Object count);

  /// No description provided for @purchaseMinutes.
  ///
  /// In en, this message translates to:
  /// **'{count}m'**
  String purchaseMinutes(Object count);

  /// No description provided for @purchaseRenewOn.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get purchaseRenewOn;

  /// No description provided for @purchaseRenewOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get purchaseRenewOff;

  /// No description provided for @overwriteTypeMerge.
  ///
  /// In en, this message translates to:
  /// **'Overlay'**
  String get overwriteTypeMerge;

  /// No description provided for @overwriteTypeMergeDesc.
  ///
  /// In en, this message translates to:
  /// **'Keep subscription rules and groups, then add your own. Personal rules take priority over subscription rules; existing added rules keep their priority.'**
  String get overwriteTypeMergeDesc;

  /// No description provided for @personalRouting.
  ///
  /// In en, this message translates to:
  /// **'Personal routing'**
  String get personalRouting;

  /// No description provided for @overlayHint.
  ///
  /// In en, this message translates to:
  /// **'Saved separately from the subscription and reapplied after updates. New groups block connections when no members match.'**
  String get overlayHint;

  /// No description provided for @overlayNameConflict.
  ///
  /// In en, this message translates to:
  /// **'The name \"{name}\" is already used. Rename the personal group to keep both.'**
  String overlayNameConflict(Object name);

  /// No description provided for @outboundUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable in this configuration. Remove or replace it.'**
  String get outboundUnavailable;

  /// No description provided for @memberOrderHint.
  ///
  /// In en, this message translates to:
  /// **'Selection order is the fallback order. Remove and reselect a member to move it to the end.'**
  String get memberOrderHint;

  /// No description provided for @groupCycleError.
  ///
  /// In en, this message translates to:
  /// **'Circular group reference: {name}. Choose a different member.'**
  String groupCycleError(Object name);

  /// No description provided for @rulesRequireRuleMode.
  ///
  /// In en, this message translates to:
  /// **'Personal routing rules take effect in Rule mode.'**
  String get rulesRequireRuleMode;

  /// No description provided for @checkRouting.
  ///
  /// In en, this message translates to:
  /// **'Check configuration'**
  String get checkRouting;

  /// No description provided for @routingChecked.
  ///
  /// In en, this message translates to:
  /// **'Configuration is valid. Personal settings are saved for this profile.'**
  String get routingChecked;

  /// No description provided for @routingApplied.
  ///
  /// In en, this message translates to:
  /// **'Personal settings applied.'**
  String get routingApplied;

  /// No description provided for @routingApplyFailed.
  ///
  /// In en, this message translates to:
  /// **'Changes were saved but could not be applied. Check the configuration and retry.'**
  String get routingApplyFailed;

  /// No description provided for @customRuleForm.
  ///
  /// In en, this message translates to:
  /// **'Form'**
  String get customRuleForm;

  /// No description provided for @customRuleRaw.
  ///
  /// In en, this message translates to:
  /// **'Rule text'**
  String get customRuleRaw;

  /// No description provided for @customRuleRawHint.
  ///
  /// In en, this message translates to:
  /// **'Enter one complete rule. Advanced expressions are preserved.'**
  String get customRuleRawHint;

  /// No description provided for @customRuleFormUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This rule uses advanced syntax. Edit the rule text to preserve all options.'**
  String get customRuleFormUnavailable;

  /// No description provided for @customRuleInvalidSyntax.
  ///
  /// In en, this message translates to:
  /// **'Enter one complete rule with a valid type, content and target.'**
  String get customRuleInvalidSyntax;

  /// No description provided for @customRuleInvalidContent.
  ///
  /// In en, this message translates to:
  /// **'Check the content for this rule type. Example: {example}'**
  String customRuleInvalidContent(Object example);

  /// No description provided for @customRuleUnavailableTarget.
  ///
  /// In en, this message translates to:
  /// **'{name} is unavailable. Choose a target from this configuration.'**
  String customRuleUnavailableTarget(Object name);

  /// No description provided for @customRuleUnavailableProvider.
  ///
  /// In en, this message translates to:
  /// **'{name} is unavailable. Choose an existing rule provider.'**
  String customRuleUnavailableProvider(Object name);

  /// No description provided for @customRuleChooseTarget.
  ///
  /// In en, this message translates to:
  /// **'Choose a target'**
  String get customRuleChooseTarget;

  /// No description provided for @customRuleChooseProvider.
  ///
  /// In en, this message translates to:
  /// **'Choose a rule provider'**
  String get customRuleChooseProvider;

  /// No description provided for @customRuleMatchHint.
  ///
  /// In en, this message translates to:
  /// **'Matches all remaining traffic. Rules below it will not be reached.'**
  String get customRuleMatchHint;

  /// No description provided for @customRuleNoResolveHint.
  ///
  /// In en, this message translates to:
  /// **'Match known IP addresses without resolving domain names.'**
  String get customRuleNoResolveHint;

  /// No description provided for @saveRoutingDraft.
  ///
  /// In en, this message translates to:
  /// **'Save draft'**
  String get saveRoutingDraft;

  /// No description provided for @routingDraftHint.
  ///
  /// In en, this message translates to:
  /// **'Save a draft to fix other items. Settings are applied only after the full configuration passes validation.'**
  String get routingDraftHint;

  /// No description provided for @groupFilterHint.
  ///
  /// In en, this message translates to:
  /// **'Filters automatically included and provider nodes. Manually selected members are always kept.'**
  String get groupFilterHint;

  /// No description provided for @groupTypeSelect.
  ///
  /// In en, this message translates to:
  /// **'Manual selection'**
  String get groupTypeSelect;

  /// No description provided for @groupTypeUrlTest.
  ///
  /// In en, this message translates to:
  /// **'Automatic selection'**
  String get groupTypeUrlTest;

  /// No description provided for @groupTypeFallback.
  ///
  /// In en, this message translates to:
  /// **'Failover'**
  String get groupTypeFallback;

  /// No description provided for @groupTypeLoadBalance.
  ///
  /// In en, this message translates to:
  /// **'Load balancing'**
  String get groupTypeLoadBalance;

  /// No description provided for @groupTypeSelectHint.
  ///
  /// In en, this message translates to:
  /// **'Choose the active member on the Proxies page.'**
  String get groupTypeSelectHint;

  /// No description provided for @groupTypeUrlTestHint.
  ///
  /// In en, this message translates to:
  /// **'Periodically test members and select a low-latency node.'**
  String get groupTypeUrlTestHint;

  /// No description provided for @groupTypeFallbackHint.
  ///
  /// In en, this message translates to:
  /// **'Try members in order and switch when the current member fails.'**
  String get groupTypeFallbackHint;

  /// No description provided for @groupTypeLoadBalanceHint.
  ///
  /// In en, this message translates to:
  /// **'Distribute connections across available members.'**
  String get groupTypeLoadBalanceHint;

  /// No description provided for @routingGroupType.
  ///
  /// In en, this message translates to:
  /// **'Group type'**
  String get routingGroupType;

  /// No description provided for @customRuleType.
  ///
  /// In en, this message translates to:
  /// **'Rule type'**
  String get customRuleType;

  /// No description provided for @routingChanged.
  ///
  /// In en, this message translates to:
  /// **'This configuration changed while it was being edited or checked. Reopen the editor or check it again.'**
  String get routingChanged;

  /// No description provided for @editCustomRouting.
  ///
  /// In en, this message translates to:
  /// **'Edit custom routing'**
  String get editCustomRouting;

  /// No description provided for @customRoutingDraftHint.
  ///
  /// In en, this message translates to:
  /// **'Fill in your custom routing, then switch to Custom mode. Editing this draft does not change the current mode.'**
  String get customRoutingDraftHint;

  /// No description provided for @coreBlockedByPolicyTip.
  ///
  /// In en, this message translates to:
  /// **'Windows blocked the proxy core from starting (system error {code}). Check Protection history in Windows Security and your app control policy, and verify the installer source and signature.'**
  String coreBlockedByPolicyTip(int code);

  /// No description provided for @startupRecoveryTitle.
  ///
  /// In en, this message translates to:
  /// **'Startup recovery'**
  String get startupRecoveryTitle;

  /// No description provided for @startupRecoveryTip.
  ///
  /// In en, this message translates to:
  /// **'The previous startup did not finish. Automatic configuration setup and VPN startup are paused for this launch. Your selected profile and settings are unchanged. Check the configuration and tap Start to retry; an already running VPN will stay connected.'**
  String get startupRecoveryTip;

  /// No description provided for @initFailed.
  ///
  /// In en, this message translates to:
  /// **'Startup failed'**
  String get initFailed;

  /// No description provided for @initFailedTip.
  ///
  /// In en, this message translates to:
  /// **'The application encountered a critical error during startup and cannot continue.'**
  String get initFailedTip;

  /// No description provided for @startupTimeoutTip.
  ///
  /// In en, this message translates to:
  /// **'Startup timed out. Quit and reopen the application. Copy the diagnostics below if the problem persists.'**
  String get startupTimeoutTip;

  /// No description provided for @startupDiagnostics.
  ///
  /// In en, this message translates to:
  /// **'Startup diagnostics'**
  String get startupDiagnostics;

  /// No description provided for @errorDetails.
  ///
  /// In en, this message translates to:
  /// **'Error details'**
  String get errorDetails;

  /// No description provided for @stackTrace.
  ///
  /// In en, this message translates to:
  /// **'Stack trace'**
  String get stackTrace;

  /// No description provided for @authentication.
  ///
  /// In en, this message translates to:
  /// **'Local proxy authentication'**
  String get authentication;

  /// No description provided for @authenticationDesc.
  ///
  /// In en, this message translates to:
  /// **'Local proxy authentication asks for a username and password on the HTTP and SOCKS ports. While it is on, the system HTTP proxy is not set; TUN and VPN keep working'**
  String get authenticationDesc;

  /// No description provided for @authenticationSystemProxyDesc.
  ///
  /// In en, this message translates to:
  /// **'The system proxy is not applied while local proxy authentication is on'**
  String get authenticationSystemProxyDesc;

  /// No description provided for @authenticationUsernameInvalid.
  ///
  /// In en, this message translates to:
  /// **'Use 1–255 UTF-8 bytes, without colons or control characters'**
  String get authenticationUsernameInvalid;

  /// No description provided for @authenticationPasswordInvalid.
  ///
  /// In en, this message translates to:
  /// **'Use 1–255 UTF-8 bytes, without control characters'**
  String get authenticationPasswordInvalid;

  /// No description provided for @authenticationApplyFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not apply authentication settings'**
  String get authenticationApplyFailed;

  /// No description provided for @installedAppsPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Installed apps permission required'**
  String get installedAppsPermissionRequired;

  /// No description provided for @installedAppsPermissionDesc.
  ///
  /// In en, this message translates to:
  /// **'Allow access to the installed app list to choose which apps use the VPN.'**
  String get installedAppsPermissionDesc;

  /// No description provided for @installedAppsPermissionDeniedMessage.
  ///
  /// In en, this message translates to:
  /// **'Permission was not granted. You can enable it in system settings.'**
  String get installedAppsPermissionDeniedMessage;

  /// No description provided for @installedAppsPermissionGrant.
  ///
  /// In en, this message translates to:
  /// **'Allow access'**
  String get installedAppsPermissionGrant;

  /// No description provided for @installedAppsLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load installed apps. Please try again.'**
  String get installedAppsLoadFailed;

  /// No description provided for @configRecoveryMissingKey.
  ///
  /// In en, this message translates to:
  /// **'The encryption key for your existing configuration is missing or invalid. Try the original system account on the original device or restore a backup. Retrying cannot recreate a lost key.'**
  String get configRecoveryMissingKey;

  /// No description provided for @configRecoveryDatabaseUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The local database cannot be accessed right now. Your files have been kept. Check permissions for this app’s data folder and whether another process is using the database, then retry.'**
  String get configRecoveryDatabaseUnavailable;

  /// No description provided for @configRecoveryIncompatibleDatabase.
  ///
  /// In en, this message translates to:
  /// **'The database in this app’s data folder is incompatible or damaged. Your files have been kept. Restore a compatible backup, or back up and reset to set up this app again. Data belonging to other apps will not be accessed.'**
  String get configRecoveryIncompatibleDatabase;

  /// No description provided for @configRecoveryUnreadable.
  ///
  /// In en, this message translates to:
  /// **'The local configuration cannot be decrypted or is damaged. Existing files have been kept. Restore the matching key and configuration backup, or back up and reset.'**
  String get configRecoveryUnreadable;

  /// No description provided for @configRecoveryStorage.
  ///
  /// In en, this message translates to:
  /// **'The local configuration or its encryption key could not be read or saved. Check access to the application data folder and the system secure storage, then retry.'**
  String get configRecoveryStorage;

  /// No description provided for @configRecoveryReset.
  ///
  /// In en, this message translates to:
  /// **'Back up and reset'**
  String get configRecoveryReset;

  /// No description provided for @configRecoveryResetConfirm.
  ///
  /// In en, this message translates to:
  /// **'Create an encrypted backup of all local settings, subscriptions, rules and account data, then reset the application? You will need to sign in again and restore or import your subscriptions and settings. The backup is protected by this Windows account; it cannot recover a lost encryption key.'**
  String get configRecoveryResetConfirm;

  /// No description provided for @configRecoveryResetDone.
  ///
  /// In en, this message translates to:
  /// **'An encrypted backup of your original data has been saved in the folder below. Exit and reopen the application to set it up again.'**
  String get configRecoveryResetDone;

  /// No description provided for @configRecoveryResetFailed.
  ///
  /// In en, this message translates to:
  /// **'The encrypted backup and reset could not be completed. Surviving original data will not be removed without a verified backup. Retry this operation, or exit and reopen the application to finish it.'**
  String get configRecoveryResetFailed;

  /// No description provided for @configRecoveryKeyring.
  ///
  /// In en, this message translates to:
  /// **'The system keyring (Secret Service) could not be accessed. Enable and unlock KDE Wallet or GNOME Keyring in your system settings, then retry.'**
  String get configRecoveryKeyring;

  /// No description provided for @configRecoveryUseLocalStorage.
  ///
  /// In en, this message translates to:
  /// **'Use local file storage'**
  String get configRecoveryUseLocalStorage;

  /// No description provided for @configRecoveryUseLocalStorageConfirm.
  ///
  /// In en, this message translates to:
  /// **'Store encryption keys and account credentials in a file in the application data folder that only your user account can open, instead of the system keyring? Any program running as your user can read them and decrypt the local configuration. This choice stays in effect from now on.'**
  String get configRecoveryUseLocalStorageConfirm;

  /// No description provided for @excludeSsids.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi networks that pause the proxy'**
  String get excludeSsids;

  /// No description provided for @excludeSsidsDesc.
  ///
  /// In en, this message translates to:
  /// **'Pause proxying on the listed Wi-Fi networks; resume after leaving only while the app remains started.'**
  String get excludeSsidsDesc;

  /// No description provided for @allowBackgroundLocation.
  ///
  /// In en, this message translates to:
  /// **'Allow all the time'**
  String get allowBackgroundLocation;

  /// No description provided for @locationPermission.
  ///
  /// In en, this message translates to:
  /// **'Location permission'**
  String get locationPermission;

  /// No description provided for @locationPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Location permission required'**
  String get locationPermissionRequired;

  /// No description provided for @locationPermissionGuide.
  ///
  /// In en, this message translates to:
  /// **'1. Open System Settings > Privacy & Security\n2. Choose Location Services\n3. Find and check {appName} in the list\n\nWhen you are done, return to the app to continue. Thank you for your cooperation.'**
  String locationPermissionGuide(Object appName);

  /// No description provided for @ssidPermissionGuide.
  ///
  /// In en, this message translates to:
  /// **'Allow location access to read Wi-Fi names. On Android, allow precise location all the time and enable system location services.'**
  String get ssidPermissionGuide;

  /// No description provided for @ssidPermissionMacosGuide.
  ///
  /// In en, this message translates to:
  /// **'Allow this app to use Location Services in System Settings to read Wi-Fi names.'**
  String get ssidPermissionMacosGuide;

  /// No description provided for @matchTargetTitle.
  ///
  /// In en, this message translates to:
  /// **'Match target'**
  String get matchTargetTitle;

  /// No description provided for @matchTarget.
  ///
  /// In en, this message translates to:
  /// **'MATCH-TARGET'**
  String get matchTarget;

  /// No description provided for @followProfile.
  ///
  /// In en, this message translates to:
  /// **'Follow profile'**
  String get followProfile;

  /// No description provided for @iconHistory.
  ///
  /// In en, this message translates to:
  /// **'Recent icons'**
  String get iconHistory;

  /// No description provided for @exitFullScreen.
  ///
  /// In en, this message translates to:
  /// **'Exit full screen'**
  String get exitFullScreen;

  /// No description provided for @unmaximize.
  ///
  /// In en, this message translates to:
  /// **'Restore down'**
  String get unmaximize;

  /// No description provided for @maximize.
  ///
  /// In en, this message translates to:
  /// **'Maximize'**
  String get maximize;

  /// No description provided for @unpinWindow.
  ///
  /// In en, this message translates to:
  /// **'Unpin window'**
  String get unpinWindow;

  /// No description provided for @pinWindow.
  ///
  /// In en, this message translates to:
  /// **'Pin window'**
  String get pinWindow;

  /// No description provided for @minimize.
  ///
  /// In en, this message translates to:
  /// **'Minimize'**
  String get minimize;

  /// No description provided for @cloudApiDnsFailed.
  ///
  /// In en, this message translates to:
  /// **'DNS lookup failed'**
  String get cloudApiDnsFailed;

  /// No description provided for @cloudApiDnsEmpty.
  ///
  /// In en, this message translates to:
  /// **'DNS returned no address, possibly blocked or a broken system resolver'**
  String get cloudApiDnsEmpty;

  /// No description provided for @cloudApiDnsUnknownHost.
  ///
  /// In en, this message translates to:
  /// **'DNS could not find this domain'**
  String get cloudApiDnsUnknownHost;

  /// No description provided for @cloudApiConnectTimeout.
  ///
  /// In en, this message translates to:
  /// **'Connection timed out'**
  String get cloudApiConnectTimeout;

  /// No description provided for @cloudApiSendTimeout.
  ///
  /// In en, this message translates to:
  /// **'Sending the request timed out'**
  String get cloudApiSendTimeout;

  /// No description provided for @cloudApiReceiveTimeout.
  ///
  /// In en, this message translates to:
  /// **'Waiting for the response timed out'**
  String get cloudApiReceiveTimeout;

  /// No description provided for @cloudApiTlsFailed.
  ///
  /// In en, this message translates to:
  /// **'TLS handshake failed'**
  String get cloudApiTlsFailed;

  /// No description provided for @cloudApiConnectionRefused.
  ///
  /// In en, this message translates to:
  /// **'Connection refused'**
  String get cloudApiConnectionRefused;

  /// No description provided for @cloudApiConnectionReset.
  ///
  /// In en, this message translates to:
  /// **'Connection reset'**
  String get cloudApiConnectionReset;

  /// No description provided for @cloudApiNetworkUnreachable.
  ///
  /// In en, this message translates to:
  /// **'Network unreachable'**
  String get cloudApiNetworkUnreachable;

  /// No description provided for @cloudApiAccessDenied.
  ///
  /// In en, this message translates to:
  /// **'Network access denied'**
  String get cloudApiAccessDenied;

  /// No description provided for @cloudApiConnectionFailed.
  ///
  /// In en, this message translates to:
  /// **'Connection failed'**
  String get cloudApiConnectionFailed;

  /// No description provided for @cloudApiProxyFailed.
  ///
  /// In en, this message translates to:
  /// **'Proxy connection failed'**
  String get cloudApiProxyFailed;

  /// No description provided for @cloudApiProxyAuthFailed.
  ///
  /// In en, this message translates to:
  /// **'Proxy authentication failed (HTTP 407)'**
  String get cloudApiProxyAuthFailed;

  /// No description provided for @cloudApiHttpError.
  ///
  /// In en, this message translates to:
  /// **'Server returned HTTP {status}'**
  String cloudApiHttpError(Object status);

  /// No description provided for @certificateRevoked.
  ///
  /// In en, this message translates to:
  /// **'Certificate has been revoked'**
  String get certificateRevoked;

  /// No description provided for @cloudApiBadRequest.
  ///
  /// In en, this message translates to:
  /// **'Server rejected the request as invalid'**
  String get cloudApiBadRequest;

  /// No description provided for @cloudApiForbidden.
  ///
  /// In en, this message translates to:
  /// **'Access forbidden'**
  String get cloudApiForbidden;

  /// No description provided for @cloudApiNotFound.
  ///
  /// In en, this message translates to:
  /// **'Requested API or resource was not found'**
  String get cloudApiNotFound;

  /// No description provided for @cloudApiMethodNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Request method is not allowed'**
  String get cloudApiMethodNotAllowed;

  /// No description provided for @cloudApiServerRequestTimeout.
  ///
  /// In en, this message translates to:
  /// **'Server timed out receiving the request'**
  String get cloudApiServerRequestTimeout;

  /// No description provided for @cloudApiRequestTooLarge.
  ///
  /// In en, this message translates to:
  /// **'Request exceeds the server size limit'**
  String get cloudApiRequestTooLarge;

  /// No description provided for @cloudApiRateLimited.
  ///
  /// In en, this message translates to:
  /// **'Too many requests; try again later'**
  String get cloudApiRateLimited;

  /// No description provided for @cloudApiServerError.
  ///
  /// In en, this message translates to:
  /// **'Internal server error'**
  String get cloudApiServerError;

  /// No description provided for @cloudApiBadGateway.
  ///
  /// In en, this message translates to:
  /// **'Gateway received an invalid upstream response'**
  String get cloudApiBadGateway;

  /// No description provided for @cloudApiServiceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Service is temporarily unavailable'**
  String get cloudApiServiceUnavailable;

  /// No description provided for @cloudApiGatewayTimeout.
  ///
  /// In en, this message translates to:
  /// **'Gateway timed out waiting for the upstream server'**
  String get cloudApiGatewayTimeout;

  /// No description provided for @cloudApiNetworkAuthRequired.
  ///
  /// In en, this message translates to:
  /// **'This network requires sign-in before access'**
  String get cloudApiNetworkAuthRequired;

  /// No description provided for @cloudApiResponseTooLarge.
  ///
  /// In en, this message translates to:
  /// **'Server response exceeds the allowed size'**
  String get cloudApiResponseTooLarge;

  /// No description provided for @cloudApiTlsProtocolFailed.
  ///
  /// In en, this message translates to:
  /// **'Incompatible TLS protocol or invalid TLS response'**
  String get cloudApiTlsProtocolFailed;

  /// No description provided for @cloudApiTlsAlgorithmFailed.
  ///
  /// In en, this message translates to:
  /// **'TLS cryptographic algorithm negotiation failed'**
  String get cloudApiTlsAlgorithmFailed;

  /// No description provided for @cloudApiTlsInterrupted.
  ///
  /// In en, this message translates to:
  /// **'Connection closed before the TLS handshake completed'**
  String get cloudApiTlsInterrupted;

  /// No description provided for @cloudApiRedirectLoop.
  ///
  /// In en, this message translates to:
  /// **'Server redirects form a loop'**
  String get cloudApiRedirectLoop;

  /// No description provided for @cloudApiRedirectLimit.
  ///
  /// In en, this message translates to:
  /// **'Too many server redirects'**
  String get cloudApiRedirectLimit;

  /// No description provided for @cloudApiRedirectInvalid.
  ///
  /// In en, this message translates to:
  /// **'Server redirect is invalid'**
  String get cloudApiRedirectInvalid;

  /// No description provided for @cloudApiResponseInterrupted.
  ///
  /// In en, this message translates to:
  /// **'Connection closed before the full response was received'**
  String get cloudApiResponseInterrupted;

  /// No description provided for @cloudApiConnectionAborted.
  ///
  /// In en, this message translates to:
  /// **'Connection aborted'**
  String get cloudApiConnectionAborted;

  /// No description provided for @cloudApiAddressUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Network address is unavailable'**
  String get cloudApiAddressUnavailable;

  /// No description provided for @cloudApiAddressInUse.
  ///
  /// In en, this message translates to:
  /// **'Network address or port is already in use'**
  String get cloudApiAddressInUse;

  /// No description provided for @cloudApiNetworkResourcesExhausted.
  ///
  /// In en, this message translates to:
  /// **'Insufficient system network resources'**
  String get cloudApiNetworkResourcesExhausted;

  /// No description provided for @cloudApiClockSkew.
  ///
  /// In en, this message translates to:
  /// **'The device clock is too far from the server. Turn on automatic date and time, then retry.'**
  String get cloudApiClockSkew;

  /// No description provided for @cloudApiSignatureRejected.
  ///
  /// In en, this message translates to:
  /// **'The server rejected this app’s signature. Reinstall the latest official build.'**
  String get cloudApiSignatureRejected;

  /// No description provided for @cloudApiServerUnconfigured.
  ///
  /// In en, this message translates to:
  /// **'The server has no key configured for this app. Contact support.'**
  String get cloudApiServerUnconfigured;

  /// No description provided for @cloudApiConfigKeyRejected.
  ///
  /// In en, this message translates to:
  /// **'The server rejected this device’s configuration key. Reinstall the latest official build.'**
  String get cloudApiConfigKeyRejected;

  /// No description provided for @cloudApiAccountDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled. Contact support.'**
  String get cloudApiAccountDisabled;

  /// No description provided for @cloudApiAccountAnomaly.
  ///
  /// In en, this message translates to:
  /// **'This account needs verification. Complete it on the website, then retry.'**
  String get cloudApiAccountAnomaly;

  /// No description provided for @cloudApiAccountNotFound.
  ///
  /// In en, this message translates to:
  /// **'This account no longer exists. Sign in again.'**
  String get cloudApiAccountNotFound;

  /// No description provided for @cloudApiInvalidResponse.
  ///
  /// In en, this message translates to:
  /// **'Invalid server response'**
  String get cloudApiInvalidResponse;

  /// No description provided for @cloudApiRequestCanceled.
  ///
  /// In en, this message translates to:
  /// **'Request canceled'**
  String get cloudApiRequestCanceled;

  /// No description provided for @cloudApiSystemError.
  ///
  /// In en, this message translates to:
  /// **'System error {code}'**
  String cloudApiSystemError(Object code);

  /// No description provided for @cloudApiTimeout.
  ///
  /// In en, this message translates to:
  /// **'Request timed out'**
  String get cloudApiTimeout;

  /// No description provided for @cloudApiRouteDirect.
  ///
  /// In en, this message translates to:
  /// **'Direct: {error}'**
  String cloudApiRouteDirect(Object error);

  /// No description provided for @cloudApiRouteProxy.
  ///
  /// In en, this message translates to:
  /// **'Local proxy: {error}'**
  String cloudApiRouteProxy(Object error);

  /// No description provided for @diagTitle.
  ///
  /// In en, this message translates to:
  /// **'Network self-check'**
  String get diagTitle;

  /// No description provided for @diagEntryHint.
  ///
  /// In en, this message translates to:
  /// **'Check the core, system proxy, TUN and DNS'**
  String get diagEntryHint;

  /// No description provided for @diagScope.
  ///
  /// In en, this message translates to:
  /// **'Checks the current connection using a small sample. The system network path may also pass through TUN. Results do not cover every app or node.'**
  String get diagScope;

  /// No description provided for @diagRun.
  ///
  /// In en, this message translates to:
  /// **'Run self-check'**
  String get diagRun;

  /// No description provided for @diagCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy diagnostic report'**
  String get diagCopy;

  /// No description provided for @diagCanceled.
  ///
  /// In en, this message translates to:
  /// **'Check canceled; results are incomplete'**
  String get diagCanceled;

  /// No description provided for @diagFixing.
  ///
  /// In en, this message translates to:
  /// **'Applying the fix, then checking again'**
  String get diagFixing;

  /// No description provided for @diagFixFailed.
  ///
  /// In en, this message translates to:
  /// **'The fix could not be applied. Follow the suggestion above.'**
  String get diagFixFailed;

  /// No description provided for @diagFixApplyProfile.
  ///
  /// In en, this message translates to:
  /// **'Apply configuration'**
  String get diagFixApplyProfile;

  /// No description provided for @diagFixStart.
  ///
  /// In en, this message translates to:
  /// **'Start connection'**
  String get diagFixStart;

  /// No description provided for @diagFixRestartCore.
  ///
  /// In en, this message translates to:
  /// **'Restart core'**
  String get diagFixRestartCore;

  /// No description provided for @diagFixRestartConnection.
  ///
  /// In en, this message translates to:
  /// **'Reconnect'**
  String get diagFixRestartConnection;

  /// No description provided for @diagFixSystemProxy.
  ///
  /// In en, this message translates to:
  /// **'Reapply system proxy'**
  String get diagFixSystemProxy;

  /// No description provided for @diagFixEnableSystemProxy.
  ///
  /// In en, this message translates to:
  /// **'Enable system proxy'**
  String get diagFixEnableSystemProxy;

  /// No description provided for @diagFixTun.
  ///
  /// In en, this message translates to:
  /// **'Re-enable TUN'**
  String get diagFixTun;

  /// No description provided for @diagFixRetest.
  ///
  /// In en, this message translates to:
  /// **'Retest nodes'**
  String get diagFixRetest;

  /// No description provided for @diagPassed.
  ///
  /// In en, this message translates to:
  /// **'Passed'**
  String get diagPassed;

  /// No description provided for @diagWarning.
  ///
  /// In en, this message translates to:
  /// **'Needs attention'**
  String get diagWarning;

  /// No description provided for @diagFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get diagFailed;

  /// No description provided for @diagUnknown.
  ///
  /// In en, this message translates to:
  /// **'Could not confirm'**
  String get diagUnknown;

  /// No description provided for @diagSkipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get diagSkipped;

  /// No description provided for @diagDisabled.
  ///
  /// In en, this message translates to:
  /// **'This option is not enabled'**
  String get diagDisabled;

  /// No description provided for @diagProfile.
  ///
  /// In en, this message translates to:
  /// **'Applied configuration'**
  String get diagProfile;

  /// No description provided for @diagProfileReady.
  ///
  /// In en, this message translates to:
  /// **'The selected configuration has been applied'**
  String get diagProfileReady;

  /// No description provided for @diagProfileMissing.
  ///
  /// In en, this message translates to:
  /// **'The selected configuration has not been applied'**
  String get diagProfileMissing;

  /// No description provided for @diagProfileHint.
  ///
  /// In en, this message translates to:
  /// **'Select a valid configuration and start the connection before checking again.'**
  String get diagProfileHint;

  /// No description provided for @diagCore.
  ///
  /// In en, this message translates to:
  /// **'Core response'**
  String get diagCore;

  /// No description provided for @diagCoreReady.
  ///
  /// In en, this message translates to:
  /// **'The core responded and reports active listeners'**
  String get diagCoreReady;

  /// No description provided for @diagCoreUnknown.
  ///
  /// In en, this message translates to:
  /// **'The core diagnostic response is unavailable or the configuration changed'**
  String get diagCoreUnknown;

  /// No description provided for @diagCoreStopped.
  ///
  /// In en, this message translates to:
  /// **'The core reports that traffic forwarding is stopped'**
  String get diagCoreStopped;

  /// No description provided for @diagSuspended.
  ///
  /// In en, this message translates to:
  /// **'Traffic forwarding is paused by the current Wi-Fi exclusion setting'**
  String get diagSuspended;

  /// No description provided for @diagCoreHint.
  ///
  /// In en, this message translates to:
  /// **'Check the connection switch and Wi-Fi exclusions. If the core cannot respond, restart it and use a matching current client/core version.'**
  String get diagCoreHint;

  /// No description provided for @diagListener.
  ///
  /// In en, this message translates to:
  /// **'Local proxy entry'**
  String get diagListener;

  /// No description provided for @diagListenerReady.
  ///
  /// In en, this message translates to:
  /// **'The expected port responded to the proxy protocol'**
  String get diagListenerReady;

  /// No description provided for @diagListenerFailed.
  ///
  /// In en, this message translates to:
  /// **'The expected proxy port did not respond or differs from the core port'**
  String get diagListenerFailed;

  /// No description provided for @diagListenerHint.
  ///
  /// In en, this message translates to:
  /// **'Check for port conflicts or a stopped listener. Reconnect first; if it still fails, open Ports and authentication to check or change the mixed port.'**
  String get diagListenerHint;

  /// No description provided for @diagSystemProxy.
  ///
  /// In en, this message translates to:
  /// **'System proxy settings'**
  String get diagSystemProxy;

  /// No description provided for @diagProxyReady.
  ///
  /// In en, this message translates to:
  /// **'HTTP and HTTPS proxy settings point to the expected local port'**
  String get diagProxyReady;

  /// No description provided for @diagProxyDisabled.
  ///
  /// In en, this message translates to:
  /// **'The app requested a system proxy, but the OS reports it disabled'**
  String get diagProxyDisabled;

  /// No description provided for @diagProxyDifferent.
  ///
  /// In en, this message translates to:
  /// **'The OS proxy does not match the app port'**
  String get diagProxyDifferent;

  /// No description provided for @diagProxyAutomatic.
  ///
  /// In en, this message translates to:
  /// **'Automatic proxy configuration is present; its effective route was not verified'**
  String get diagProxyAutomatic;

  /// No description provided for @diagProxyHint.
  ///
  /// In en, this message translates to:
  /// **'Open Troubleshoot and manual setup to compare the system proxy address and port. If settings keep reverting, check other proxy apps or device management policies.'**
  String get diagProxyHint;

  /// No description provided for @diagProxyAutomaticHint.
  ///
  /// In en, this message translates to:
  /// **'A PAC script or auto-discovery may choose a different proxy for each website. This does not necessarily mean the connection is broken. Check who provided the configuration before changing it.'**
  String get diagProxyAutomaticHint;

  /// No description provided for @diagSystemDnsHint.
  ///
  /// In en, this message translates to:
  /// **'Try another network and check the DNS servers for the active connection in your operating system. Changing only the client DNS overrides may not fix system lookups.'**
  String get diagSystemDnsHint;

  /// No description provided for @diagProxyRecover.
  ///
  /// In en, this message translates to:
  /// **'Turn off inactive local proxy'**
  String get diagProxyRecover;

  /// No description provided for @diagProxyRecoverHint.
  ///
  /// In en, this message translates to:
  /// **'Stop the connection first. This turns off a manual proxy pointing to the current local port only when no service is listening. Other proxy addresses, ports and automatic settings are kept.'**
  String get diagProxyRecoverHint;

  /// No description provided for @diagProxyGuide.
  ///
  /// In en, this message translates to:
  /// **'Troubleshoot and manual setup'**
  String get diagProxyGuide;

  /// No description provided for @diagRecheck.
  ///
  /// In en, this message translates to:
  /// **'Check again'**
  String get diagRecheck;

  /// No description provided for @diagOpenPortSettings.
  ///
  /// In en, this message translates to:
  /// **'Ports and authentication'**
  String get diagOpenPortSettings;

  /// No description provided for @diagOpenNetworkSettings.
  ///
  /// In en, this message translates to:
  /// **'Network and TUN settings'**
  String get diagOpenNetworkSettings;

  /// No description provided for @diagOpenDnsSettings.
  ///
  /// In en, this message translates to:
  /// **'DNS override settings'**
  String get diagOpenDnsSettings;

  /// No description provided for @diagOpenSystemSettings.
  ///
  /// In en, this message translates to:
  /// **'Open system settings'**
  String get diagOpenSystemSettings;

  /// No description provided for @diagOpenSettingsFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open system settings. Follow the path above to open them manually.'**
  String get diagOpenSettingsFailed;

  /// No description provided for @diagCopyProxyAddress.
  ///
  /// In en, this message translates to:
  /// **'Copy proxy address'**
  String get diagCopyProxyAddress;

  /// No description provided for @diagProxyGuidePrepareTitle.
  ///
  /// In en, this message translates to:
  /// **'1. Check the local proxy first'**
  String get diagProxyGuidePrepareTitle;

  /// No description provided for @diagProxyGuidePrepare.
  ///
  /// In en, this message translates to:
  /// **'Select a valid profile, start the connection in FlClash, and make sure Local proxy listener passes before entering the proxy address.\nQuit other proxy apps that may keep changing system settings. If your company or school manages the settings, or they are locked or keep reverting, check with the administrator.'**
  String get diagProxyGuidePrepare;

  /// No description provided for @diagProxyGuideManualTitle.
  ///
  /// In en, this message translates to:
  /// **'2. Check or enter the proxy settings'**
  String get diagProxyGuideManualTitle;

  /// No description provided for @diagProxyGuideWindows.
  ///
  /// In en, this message translates to:
  /// **'Settings → Network & internet → Proxy\nIf automatic settings are left over from another app and your network no longer needs them, turn off Use setup script and Automatically detect settings.\nUnder Manual proxy setup, enable Use a proxy server, enter the address and port below in their separate fields, and save. Do not prefix the address with http://. Keep any exceptions your network needs.'**
  String get diagProxyGuideWindows;

  /// No description provided for @diagProxyGuideMacos.
  ///
  /// In en, this message translates to:
  /// **'System Settings → Network → active Wi-Fi or Ethernet service → Details → Proxies\nmacOS 12: System Preferences → Network → active service → Advanced → Proxies\nIf automatic settings are left over from another app and your network no longer needs them, turn off Auto proxy discovery and Automatic proxy configuration.\nEnable Web proxy (HTTP) and Secure web proxy (HTTPS). Enter the address and port below for both, then save. Keep any bypass entries your network needs.'**
  String get diagProxyGuideMacos;

  /// No description provided for @diagProxyGuideLinux.
  ///
  /// In en, this message translates to:
  /// **'Open your desktop settings → Network → Network Proxy and select Manual (names vary by desktop).\nEnter the address and port below for both HTTP and HTTPS, then apply. If there is no system proxy panel, configure the target app instead.\nBefore replacing an automatic configuration, check its source and whether your network still needs it.'**
  String get diagProxyGuideLinux;

  /// No description provided for @diagProxyGuideApp.
  ///
  /// In en, this message translates to:
  /// **'On this device, open the target app’s proxy settings, choose HTTP or SOCKS5, and enter the address and port below.\nAndroid provides the system proxy through the VPN service. For VPN access, check the VPN switch and app access control in FlClash network settings.'**
  String get diagProxyGuideApp;

  /// No description provided for @diagProxyGuideAuthenticated.
  ///
  /// In en, this message translates to:
  /// **'Local proxy authentication is enabled, so FlClash does not apply a system proxy automatically.\nIn an app that supports proxy authentication, choose HTTP or SOCKS5 and enter the address and port below. Use the username and password from FlClash → Override → General → Inbound → Authentication.\nDo not include credentials in diagnostic reports.'**
  String get diagProxyGuideAuthenticated;

  /// No description provided for @diagProxyGuideValues.
  ///
  /// In en, this message translates to:
  /// **'Local address: 127.0.0.1\nMixed port (current configuration): {port}\nUse this mixed port for HTTP, HTTPS website proxying, or SOCKS5 on this device only.'**
  String diagProxyGuideValues(Object port);

  /// No description provided for @diagProxyGuideInvalidPort.
  ///
  /// In en, this message translates to:
  /// **'The mixed port is unavailable. Set a valid port in Ports and authentication, then start the connection.'**
  String get diagProxyGuideInvalidPort;

  /// No description provided for @diagProxyGuideVerifyTitle.
  ///
  /// In en, this message translates to:
  /// **'3. Save and verify the actual app'**
  String get diagProxyGuideVerifyTitle;

  /// No description provided for @diagProxyGuideVerify.
  ///
  /// In en, this message translates to:
  /// **'Return and select Check again, then retry in the browser or app you use.\nIf the local proxy check passes but an app still fails, check its system proxy, custom proxy, or proxy extension settings. System proxy settings do not capture every app.\nYou may need to turn off a manually configured proxy or restore its previous settings when stopping FlClash to keep internet access.'**
  String get diagProxyGuideVerify;

  /// No description provided for @diagTun.
  ///
  /// In en, this message translates to:
  /// **'TUN interface and route'**
  String get diagTun;

  /// No description provided for @diagTunMissing.
  ///
  /// In en, this message translates to:
  /// **'The core TUN interface was not found in an active state'**
  String get diagTunMissing;

  /// No description provided for @diagTunReady.
  ///
  /// In en, this message translates to:
  /// **'The core TUN interface is active and the sampled IPv4 route uses it'**
  String get diagTunReady;

  /// No description provided for @diagTunRouteMismatch.
  ///
  /// In en, this message translates to:
  /// **'TUN is active, but the sampled IPv4 route uses another interface'**
  String get diagTunRouteMismatch;

  /// No description provided for @diagTunRouteUnknown.
  ///
  /// In en, this message translates to:
  /// **'TUN is active; its IPv4 route could not be verified'**
  String get diagTunRouteUnknown;

  /// No description provided for @diagTunHint.
  ///
  /// In en, this message translates to:
  /// **'Turn TUN off and on and complete system authorization. If the route differs, check other VPNs. IPv6, UDP and app-specific exclusions need separate checks.'**
  String get diagTunHint;

  /// No description provided for @proxyConflictTitle.
  ///
  /// In en, this message translates to:
  /// **'Possible proxy conflict'**
  String get proxyConflictTitle;

  /// No description provided for @proxyConflictSystemProxy.
  ///
  /// In en, this message translates to:
  /// **'Before starting, the system proxy pointed to {address}.'**
  String proxyConflictSystemProxy(Object address);

  /// No description provided for @proxyConflictAutoConfig.
  ///
  /// In en, this message translates to:
  /// **'Before starting, the system proxy used an automatic configuration script.'**
  String get proxyConflictAutoConfig;

  /// No description provided for @proxyConflictVpn.
  ///
  /// In en, this message translates to:
  /// **'Before starting, traffic was routed through another VPN or virtual adapter: {name}.'**
  String proxyConflictVpn(Object name);

  /// No description provided for @proxyConflictHint.
  ///
  /// In en, this message translates to:
  /// **'If this belongs to another proxy app or VPN, close it; running both can break the connection.'**
  String get proxyConflictHint;

  /// No description provided for @diagTrafficCapture.
  ///
  /// In en, this message translates to:
  /// **'Traffic capture'**
  String get diagTrafficCapture;

  /// No description provided for @diagNoCapture.
  ///
  /// In en, this message translates to:
  /// **'Neither system proxy nor TUN is enabled'**
  String get diagNoCapture;

  /// No description provided for @diagCaptureHint.
  ///
  /// In en, this message translates to:
  /// **'Enable system proxy or TUN, or configure the affected app to use the local proxy.'**
  String get diagCaptureHint;

  /// No description provided for @diagSystemDns.
  ///
  /// In en, this message translates to:
  /// **'System DNS'**
  String get diagSystemDns;

  /// No description provided for @diagCoreDns.
  ///
  /// In en, this message translates to:
  /// **'Core DNS'**
  String get diagCoreDns;

  /// No description provided for @diagProbeSummary.
  ///
  /// In en, this message translates to:
  /// **'{passed}/{total} samples passed'**
  String diagProbeSummary(int passed, int total);

  /// No description provided for @diagProbeResult.
  ///
  /// In en, this message translates to:
  /// **'Sample {index}: {result} · {milliseconds} ms'**
  String diagProbeResult(int index, String result, int milliseconds);

  /// No description provided for @diagDnsServerFailed.
  ///
  /// In en, this message translates to:
  /// **'DNS upstream returned a server failure'**
  String get diagDnsServerFailed;

  /// No description provided for @diagDnsReady.
  ///
  /// In en, this message translates to:
  /// **'Sampled names resolved successfully'**
  String get diagDnsReady;

  /// No description provided for @diagDnsPartial.
  ///
  /// In en, this message translates to:
  /// **'Only some sampled names resolved'**
  String get diagDnsPartial;

  /// No description provided for @diagOixDnsNoSample.
  ///
  /// In en, this message translates to:
  /// **'No managed node hostname was available for this sample'**
  String get diagOixDnsNoSample;

  /// No description provided for @diagOixDnsAuthMissing.
  ///
  /// In en, this message translates to:
  /// **'The managed DNS signing function is not ready'**
  String get diagOixDnsAuthMissing;

  /// No description provided for @diagDnsNoAnswer.
  ///
  /// In en, this message translates to:
  /// **'DNS returned no usable address; this alone does not prove an authentication failure'**
  String get diagDnsNoAnswer;

  /// No description provided for @diagDnsRefused.
  ///
  /// In en, this message translates to:
  /// **'The DNS request was refused'**
  String get diagDnsRefused;

  /// No description provided for @diagDnsHint.
  ///
  /// In en, this message translates to:
  /// **'Check DNS overrides and try another network. If system DNS works but core DNS fails, inspect the configuration DNS settings.'**
  String get diagDnsHint;

  /// No description provided for @diagOixDnsHint.
  ///
  /// In en, this message translates to:
  /// **'Check the client version and system time, then refresh the subscription. If resolution still fails, share this diagnostic report with support.'**
  String get diagOixDnsHint;

  /// No description provided for @diagSystemPath.
  ///
  /// In en, this message translates to:
  /// **'System network path'**
  String get diagSystemPath;

  /// No description provided for @diagProxyPath.
  ///
  /// In en, this message translates to:
  /// **'Through the local proxy'**
  String get diagProxyPath;

  /// No description provided for @diagWebResult.
  ///
  /// In en, this message translates to:
  /// **'{count} of 2 independent HTTPS checks passed'**
  String diagWebResult(Object count);

  /// No description provided for @diagSystemPathHint.
  ///
  /// In en, this message translates to:
  /// **'This path does not explicitly use the app HTTP proxy, but may use TUN. A failed sample may be caused by DNS, filtering or the test site; compare the local proxy result.'**
  String get diagSystemPathHint;

  /// No description provided for @diagProxyPathHint.
  ///
  /// In en, this message translates to:
  /// **'If the system path works, check the selected node, routing rules and core DNS. Failure at one test site does not mean every node is unusable.'**
  String get diagProxyPathHint;

  /// No description provided for @diagClock.
  ///
  /// In en, this message translates to:
  /// **'System time comparison'**
  String get diagClock;

  /// No description provided for @diagClockUnknown.
  ///
  /// In en, this message translates to:
  /// **'Not enough uncached HTTPS responses to compare time'**
  String get diagClockUnknown;

  /// No description provided for @diagClockSkew.
  ///
  /// In en, this message translates to:
  /// **'Two independent responses indicate a possible time difference of at least five minutes'**
  String get diagClockSkew;

  /// No description provided for @diagClockReady.
  ///
  /// In en, this message translates to:
  /// **'No consistent large time difference was found in this sample'**
  String get diagClockReady;

  /// No description provided for @diagClockHint.
  ///
  /// In en, this message translates to:
  /// **'Enable automatic system date and time, then retry. A clock error can affect certificates and oixCloud DNS signatures.'**
  String get diagClockHint;

  /// No description provided for @diagAllFailed.
  ///
  /// In en, this message translates to:
  /// **'Every node tested in this group failed. The test URL may also be unreachable. Run a network self-check?'**
  String get diagAllFailed;

  /// No description provided for @updateDownloadBackground.
  ///
  /// In en, this message translates to:
  /// **'Download in background'**
  String get updateDownloadBackground;

  /// No description provided for @updateReady.
  ///
  /// In en, this message translates to:
  /// **'Update ready to install'**
  String get updateReady;

  /// No description provided for @updateRestart.
  ///
  /// In en, this message translates to:
  /// **'Update and relaunch'**
  String get updateRestart;

  /// No description provided for @updateRestartHint.
  ///
  /// In en, this message translates to:
  /// **'The app will close, update in place, and reopen. Your settings will be preserved.'**
  String get updateRestartHint;

  /// No description provided for @updatePreparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing the update'**
  String get updatePreparing;

  /// No description provided for @updateVerifying.
  ///
  /// In en, this message translates to:
  /// **'Verifying update package'**
  String get updateVerifying;

  /// No description provided for @updateCheckingInstaller.
  ///
  /// In en, this message translates to:
  /// **'Checking the installer'**
  String get updateCheckingInstaller;

  /// No description provided for @updateRestarting.
  ///
  /// In en, this message translates to:
  /// **'Closing and restarting'**
  String get updateRestarting;

  /// No description provided for @updateApplyFailed.
  ///
  /// In en, this message translates to:
  /// **'Automatic update did not complete. Retry or update from the download page.'**
  String get updateApplyFailed;

  /// No description provided for @updateReadyHint.
  ///
  /// In en, this message translates to:
  /// **'The update has been downloaded. Install when convenient.'**
  String get updateReadyHint;

  /// No description provided for @updateInstall.
  ///
  /// In en, this message translates to:
  /// **'Install update'**
  String get updateInstall;

  /// No description provided for @updateDownloading.
  ///
  /// In en, this message translates to:
  /// **'Downloading update'**
  String get updateDownloading;

  /// No description provided for @updateDownloadFailed.
  ///
  /// In en, this message translates to:
  /// **'Update download failed'**
  String get updateDownloadFailed;

  /// No description provided for @updateDownloadBrowser.
  ///
  /// In en, this message translates to:
  /// **'Download in browser'**
  String get updateDownloadBrowser;

  /// No description provided for @updatePackageFormat.
  ///
  /// In en, this message translates to:
  /// **'Choose the package format'**
  String get updatePackageFormat;

  /// No description provided for @updatePackageFormatTip.
  ///
  /// In en, this message translates to:
  /// **'How this build was installed could not be determined. Pick the format that matches it.'**
  String get updatePackageFormatTip;

  /// No description provided for @updateAppImageTip.
  ///
  /// In en, this message translates to:
  /// **'An AppImage cannot be installed automatically. Replace the running program with the downloaded file; its folder has been opened.'**
  String get updateAppImageTip;

  /// No description provided for @updatePackageManagerTip.
  ///
  /// In en, this message translates to:
  /// **'This build was installed by a package manager; upgrade it the same way you installed it.'**
  String get updatePackageManagerTip;

  /// No description provided for @tunMtuDesc.
  ///
  /// In en, this message translates to:
  /// **'Default: 9000; alternatives: 1480 or 4064. Restart the Android VPN to apply'**
  String get tunMtuDesc;

  /// No description provided for @tunMtuInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter an integer from 1280 to 65535'**
  String get tunMtuInvalid;

  /// No description provided for @scriptOptions.
  ///
  /// In en, this message translates to:
  /// **'Script options'**
  String get scriptOptions;

  /// No description provided for @scriptOptionsEmpty.
  ///
  /// In en, this message translates to:
  /// **'This script does not expose configurable switches'**
  String get scriptOptionsEmpty;

  /// No description provided for @scriptChanges.
  ///
  /// In en, this message translates to:
  /// **'Script changes'**
  String get scriptChanges;

  /// No description provided for @scriptFullConfig.
  ///
  /// In en, this message translates to:
  /// **'Full config'**
  String get scriptFullConfig;

  /// No description provided for @scriptChangesDescription.
  ///
  /// In en, this message translates to:
  /// **'Top-level configuration fields added, modified or removed by the script. The full configuration also includes app settings.'**
  String get scriptChangesDescription;

  /// No description provided for @scriptChangesEmpty.
  ///
  /// In en, this message translates to:
  /// **'The script did not change the configuration'**
  String get scriptChangesEmpty;

  /// No description provided for @scriptChangesAdded.
  ///
  /// In en, this message translates to:
  /// **'Added ({count})'**
  String scriptChangesAdded(int count);

  /// No description provided for @scriptChangesModified.
  ///
  /// In en, this message translates to:
  /// **'Modified ({count})'**
  String scriptChangesModified(int count);

  /// No description provided for @scriptChangesRemoved.
  ///
  /// In en, this message translates to:
  /// **'Removed ({count})'**
  String scriptChangesRemoved(int count);

  /// No description provided for @excludeNetworks.
  ///
  /// In en, this message translates to:
  /// **'Pause proxy by IP or gateway'**
  String get excludeNetworks;

  /// No description provided for @excludeNetworksDesc.
  ///
  /// In en, this message translates to:
  /// **'Pause on matching Wi-Fi/Ethernet IPv4 addresses, subnets or gateways; resume after leaving. Comma-separated, e.g. 192.168.1.0/24,gateway:192.168.1.1'**
  String get excludeNetworksDesc;

  /// No description provided for @excludeNetworksInvalid.
  ///
  /// In en, this message translates to:
  /// **'Up to 16 rules; enter valid IPv4, CIDR or gateway:address'**
  String get excludeNetworksInvalid;

  /// No description provided for @delayConcurrency.
  ///
  /// In en, this message translates to:
  /// **'Concurrent batch latency tests'**
  String get delayConcurrency;

  /// No description provided for @delayTestFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get delayTestFailed;

  /// No description provided for @updateReleaseNotes.
  ///
  /// In en, this message translates to:
  /// **'Release notes'**
  String get updateReleaseNotes;

  /// No description provided for @updateDownloadConfirm.
  ///
  /// In en, this message translates to:
  /// **'Download update'**
  String get updateDownloadConfirm;

  /// No description provided for @updateLater.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get updateLater;

  /// No description provided for @updateCancelDownload.
  ///
  /// In en, this message translates to:
  /// **'Cancel download'**
  String get updateCancelDownload;

  /// No description provided for @updateNotice.
  ///
  /// In en, this message translates to:
  /// **'New version detected'**
  String get updateNotice;

  /// No description provided for @updateVersionNumber.
  ///
  /// In en, this message translates to:
  /// **'Version: {version}'**
  String updateVersionNumber(String version);

  /// No description provided for @updateBuildNumber.
  ///
  /// In en, this message translates to:
  /// **'Build: {build}'**
  String updateBuildNumber(String build);

  /// No description provided for @updateReleaseNotesFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load release notes. Please try again.'**
  String get updateReleaseNotesFailed;

  /// No description provided for @tailscaleEntryHint.
  ///
  /// In en, this message translates to:
  /// **'Access the devices in your tailnet'**
  String get tailscaleEntryHint;

  /// No description provided for @tailscaleEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Access your tailnet'**
  String get tailscaleEmptyTitle;

  /// No description provided for @tailscaleEmptyDesc.
  ///
  /// In en, this message translates to:
  /// **'Add a network, sign in on this device, then start the proxy to reach your devices.'**
  String get tailscaleEmptyDesc;

  /// No description provided for @tailscaleAddNetwork.
  ///
  /// In en, this message translates to:
  /// **'Add network'**
  String get tailscaleAddNetwork;

  /// No description provided for @tailscaleNetworks.
  ///
  /// In en, this message translates to:
  /// **'Networks'**
  String get tailscaleNetworks;

  /// No description provided for @tailscaleGuide.
  ///
  /// In en, this message translates to:
  /// **'Guide'**
  String get tailscaleGuide;

  /// No description provided for @tailscaleThisDevice.
  ///
  /// In en, this message translates to:
  /// **'This device'**
  String get tailscaleThisDevice;

  /// No description provided for @tailscaleStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get tailscaleStatus;

  /// No description provided for @tailscaleDeviceName.
  ///
  /// In en, this message translates to:
  /// **'Device name'**
  String get tailscaleDeviceName;

  /// No description provided for @tailscaleDevices.
  ///
  /// In en, this message translates to:
  /// **'Devices ({count})'**
  String tailscaleDevices(Object count);

  /// No description provided for @tailscaleNetworkName.
  ///
  /// In en, this message translates to:
  /// **'Network name'**
  String get tailscaleNetworkName;

  /// No description provided for @tailscaleNameInUse.
  ///
  /// In en, this message translates to:
  /// **'This name is already in use'**
  String get tailscaleNameInUse;

  /// No description provided for @tailscaleLoginMethod.
  ///
  /// In en, this message translates to:
  /// **'Login method'**
  String get tailscaleLoginMethod;

  /// No description provided for @tailscaleInteractiveLogin.
  ///
  /// In en, this message translates to:
  /// **'Interactive'**
  String get tailscaleInteractiveLogin;

  /// No description provided for @tailscaleAuthKey.
  ///
  /// In en, this message translates to:
  /// **'Auth key'**
  String get tailscaleAuthKey;

  /// No description provided for @tailscaleAuthKeySaved.
  ///
  /// In en, this message translates to:
  /// **'An auth key is saved on this device. Enter a new one to replace it.'**
  String get tailscaleAuthKeySaved;

  /// No description provided for @tailscaleLoginFooter.
  ///
  /// In en, this message translates to:
  /// **'Sign in once per network on this device.'**
  String get tailscaleLoginFooter;

  /// No description provided for @tailscaleAutoRoute.
  ///
  /// In en, this message translates to:
  /// **'Automatic routing'**
  String get tailscaleAutoRoute;

  /// No description provided for @tailscaleAutoRouteDesc.
  ///
  /// In en, this message translates to:
  /// **'Route peer addresses, MagicDNS names and approved subnets through this network'**
  String get tailscaleAutoRouteDesc;

  /// No description provided for @tailscaleExitNode.
  ///
  /// In en, this message translates to:
  /// **'Exit node'**
  String get tailscaleExitNode;

  /// No description provided for @tailscaleExitNodeDesc.
  ///
  /// In en, this message translates to:
  /// **'Leave empty for none, or use auto, a peer name or a peer IP address.'**
  String get tailscaleExitNodeDesc;

  /// No description provided for @tailscaleAvailableExitNodes.
  ///
  /// In en, this message translates to:
  /// **'Available exit nodes'**
  String get tailscaleAvailableExitNodes;

  /// No description provided for @tailscaleExitNodeAllowLan.
  ///
  /// In en, this message translates to:
  /// **'Allow local network access'**
  String get tailscaleExitNodeAllowLan;

  /// No description provided for @tailscaleAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get tailscaleAdvanced;

  /// No description provided for @tailscaleControlUrl.
  ///
  /// In en, this message translates to:
  /// **'Control URL'**
  String get tailscaleControlUrl;

  /// No description provided for @tailscaleCredentialsFooter.
  ///
  /// In en, this message translates to:
  /// **'Authentication and device identity stay on this device.'**
  String get tailscaleCredentialsFooter;

  /// No description provided for @tailscaleAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get tailscaleAccount;

  /// No description provided for @tailscaleSaveAndLogin.
  ///
  /// In en, this message translates to:
  /// **'Save and log in'**
  String get tailscaleSaveAndLogin;

  /// No description provided for @tailscaleOpenLoginPage.
  ///
  /// In en, this message translates to:
  /// **'Open login page'**
  String get tailscaleOpenLoginPage;

  /// No description provided for @tailscaleLoginWaiting.
  ///
  /// In en, this message translates to:
  /// **'Open the login page or scan the code. Sign-in completes automatically after approval.'**
  String get tailscaleLoginWaiting;

  /// No description provided for @tailscaleSigningIn.
  ///
  /// In en, this message translates to:
  /// **'Signing in'**
  String get tailscaleSigningIn;

  /// No description provided for @tailscaleSignedIn.
  ///
  /// In en, this message translates to:
  /// **'Signed in'**
  String get tailscaleSignedIn;

  /// No description provided for @tailscaleLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get tailscaleLogout;

  /// No description provided for @tailscaleLoginFailed.
  ///
  /// In en, this message translates to:
  /// **'Tailscale login failed'**
  String get tailscaleLoginFailed;

  /// No description provided for @tailscaleLoginTimeout.
  ///
  /// In en, this message translates to:
  /// **'Sign-in was not completed within five minutes. Try again.'**
  String get tailscaleLoginTimeout;

  /// No description provided for @tailscaleLoginHint.
  ///
  /// In en, this message translates to:
  /// **'Signing in authorizes this device. Start the proxy to use the network.'**
  String get tailscaleLoginHint;

  /// No description provided for @tailscaleEnterAuthKey.
  ///
  /// In en, this message translates to:
  /// **'Enter the auth key to log in on this device.'**
  String get tailscaleEnterAuthKey;

  /// No description provided for @tailscaleCheckSettings.
  ///
  /// In en, this message translates to:
  /// **'Check these settings: {fields}'**
  String tailscaleCheckSettings(Object fields);

  /// No description provided for @tailscaleNotApplied.
  ///
  /// In en, this message translates to:
  /// **'Not applied'**
  String get tailscaleNotApplied;

  /// No description provided for @tailscaleNotAppliedHint.
  ///
  /// In en, this message translates to:
  /// **'The network is not part of the running configuration. Select a profile and make sure none of its nodes uses the same name.'**
  String get tailscaleNotAppliedHint;

  /// No description provided for @tailscaleNotSignedIn.
  ///
  /// In en, this message translates to:
  /// **'Not signed in'**
  String get tailscaleNotSignedIn;

  /// No description provided for @tailscaleNeedsLogin.
  ///
  /// In en, this message translates to:
  /// **'Login required'**
  String get tailscaleNeedsLogin;

  /// No description provided for @tailscaleKeyExpired.
  ///
  /// In en, this message translates to:
  /// **'Node key has expired'**
  String get tailscaleKeyExpired;

  /// No description provided for @tailscaleNeedsApproval.
  ///
  /// In en, this message translates to:
  /// **'Device approval is pending'**
  String get tailscaleNeedsApproval;

  /// No description provided for @tailscaleConnecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting'**
  String get tailscaleConnecting;

  /// No description provided for @tailscaleConnected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get tailscaleConnected;

  /// No description provided for @tailscaleStopped.
  ///
  /// In en, this message translates to:
  /// **'Stopped'**
  String get tailscaleStopped;

  /// No description provided for @tailscaleUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Connection unavailable'**
  String get tailscaleUnavailable;

  /// No description provided for @tailscaleOnline.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get tailscaleOnline;

  /// No description provided for @tailscaleOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get tailscaleOffline;

  /// No description provided for @tailscaleRemoveNetwork.
  ///
  /// In en, this message translates to:
  /// **'Remove network'**
  String get tailscaleRemoveNetwork;

  /// No description provided for @tailscaleRemoveConfirm.
  ///
  /// In en, this message translates to:
  /// **'This device will leave {name} and its sign-in will be deleted from this device. If the network is unreachable now, remove the device in the Tailscale admin console.'**
  String tailscaleRemoveConfirm(Object name);

  /// No description provided for @tailscaleNetworkInUse.
  ///
  /// In en, this message translates to:
  /// **'{name} is still used by a rule or group in profile {profile}'**
  String tailscaleNetworkInUse(Object name, Object profile);

  /// No description provided for @tailscaleGuideGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get tailscaleGuideGetStarted;

  /// No description provided for @tailscaleGuideGetStartedBody.
  ///
  /// In en, this message translates to:
  /// **'Add a network and choose \"Save and log in\". Open the login page and authorize this device; sign-in completes on its own.\nTo sign in with an auth key, choose \"Auth key\" and enter it. No browser is needed.\nThe network carries traffic only while the proxy runs. Signing in alone routes nothing.'**
  String get tailscaleGuideGetStartedBody;

  /// No description provided for @tailscaleGuideDevices.
  ///
  /// In en, this message translates to:
  /// **'Devices and MagicDNS'**
  String get tailscaleGuideDevices;

  /// No description provided for @tailscaleGuideDevicesBody.
  ///
  /// In en, this message translates to:
  /// **'Automatic routing sends the addresses and MagicDNS names of known peers, and the subnets approved in your tailnet, into this network. Other traffic follows your rules.\nIt applies after your added and custom rules and before the profile\'s own rules.\nWith a custom control server domain, only known device names are routed, so the domain\'s public sites stay reachable.\nSubnet addresses inside the local network this device is on stay local. To reach a remote subnet with the same addresses, add a rule that points to this network.\nA hostname that resolves into an approved subnet also goes through this network. If the profile hands such a name straight to a proxy, add a domain rule that points to this network.'**
  String get tailscaleGuideDevicesBody;

  /// No description provided for @tailscaleGuideExitNodes.
  ///
  /// In en, this message translates to:
  /// **'Exit nodes'**
  String get tailscaleGuideExitNodes;

  /// No description provided for @tailscaleGuideExitNodesBody.
  ///
  /// In en, this message translates to:
  /// **'With an exit node, the network appears in the profile\'s selector groups. Traffic uses the exit node only after you select the network there or point a rule to it.\nLeave the field empty to use no exit node. auto picks an available exit node; a device name or address picks that device.'**
  String get tailscaleGuideExitNodesBody;

  /// No description provided for @tailscaleGuideSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign-in and backup'**
  String get tailscaleGuideSignIn;

  /// No description provided for @tailscaleGuideSignInBody.
  ///
  /// In en, this message translates to:
  /// **'Network settings are included in backups. Auth keys and the device identity stay on this device, so sign in again after restoring on another device.\nWhen the node key expires, choose \"Save and log in\" again. Device approval and access are managed in your tailnet.\nRemoving a network signs this device out and deletes its identity from this device.'**
  String get tailscaleGuideSignInBody;

  /// No description provided for @tailscaleGuideTroubleshooting.
  ///
  /// In en, this message translates to:
  /// **'Troubleshooting'**
  String get tailscaleGuideTroubleshooting;

  /// No description provided for @tailscaleGuideTroubleshootingBody.
  ///
  /// In en, this message translates to:
  /// **'Check that the proxy is running, this device is approved and the peer is online. For subnets or the Internet, also check route approval and the exit node.\n\"Not applied\" means the running configuration lacks the network: select a profile and make sure none of its nodes uses the same name.\nThis app only connects out to your tailnet. It accepts no inbound connections and never offers this device as a subnet router or exit node.'**
  String get tailscaleGuideTroubleshootingBody;

  /// No description provided for @tailscaleNameInvalid.
  ///
  /// In en, this message translates to:
  /// **'Use up to 64 characters without commas'**
  String get tailscaleNameInvalid;

  /// No description provided for @tailscaleHostnameInvalid.
  ///
  /// In en, this message translates to:
  /// **'Use lowercase letters, digits and hyphens, up to 63 characters'**
  String get tailscaleHostnameInvalid;

  /// No description provided for @tailscaleAuthKeyInvalid.
  ///
  /// In en, this message translates to:
  /// **'This does not look like an auth key'**
  String get tailscaleAuthKeyInvalid;

  /// No description provided for @tailscaleDirect.
  ///
  /// In en, this message translates to:
  /// **'Direct'**
  String get tailscaleDirect;

  /// No description provided for @tailscaleRelay.
  ///
  /// In en, this message translates to:
  /// **'Relay {region}'**
  String tailscaleRelay(Object region);

  /// No description provided for @tailscaleExitNodeActive.
  ///
  /// In en, this message translates to:
  /// **'Exit node in use'**
  String get tailscaleExitNodeActive;

  /// No description provided for @quickAdd.
  ///
  /// In en, this message translates to:
  /// **'Quick add'**
  String get quickAdd;

  /// No description provided for @rulePresetBlockQuic.
  ///
  /// In en, this message translates to:
  /// **'Block QUIC'**
  String get rulePresetBlockQuic;

  /// No description provided for @rulePresetBlockStun.
  ///
  /// In en, this message translates to:
  /// **'Block STUN'**
  String get rulePresetBlockStun;

  /// No description provided for @rulePresetBlockDot.
  ///
  /// In en, this message translates to:
  /// **'Block DNS over TLS'**
  String get rulePresetBlockDot;

  /// No description provided for @rulePresetBlockLoopback.
  ///
  /// In en, this message translates to:
  /// **'Block proxy loopback'**
  String get rulePresetBlockLoopback;

  /// No description provided for @rulePresetLanDirect.
  ///
  /// In en, this message translates to:
  /// **'LAN direct'**
  String get rulePresetLanDirect;

  /// No description provided for @rulePresetSystemServicesDirect.
  ///
  /// In en, this message translates to:
  /// **'Apple and Microsoft direct'**
  String get rulePresetSystemServicesDirect;

  /// No description provided for @rulePresetBittorrentDirect.
  ///
  /// In en, this message translates to:
  /// **'BitTorrent direct'**
  String get rulePresetBittorrentDirect;

  /// No description provided for @rulePresetInsertHint.
  ///
  /// In en, this message translates to:
  /// **'Add selected presets before existing rules. Identical rules are not added again.'**
  String get rulePresetInsertHint;

  /// No description provided for @overwriteIssueEmptyName.
  ///
  /// In en, this message translates to:
  /// **'The name is empty'**
  String get overwriteIssueEmptyName;

  /// No description provided for @overwriteIssueReservedName.
  ///
  /// In en, this message translates to:
  /// **'{name} is a built-in policy name and cannot be used here'**
  String overwriteIssueReservedName(Object name);

  /// No description provided for @overwriteIssueDuplicateName.
  ///
  /// In en, this message translates to:
  /// **'The name {name} is already used by another proxy or proxy group'**
  String overwriteIssueDuplicateName(Object name);

  /// No description provided for @overwriteIssueNoProxySource.
  ///
  /// In en, this message translates to:
  /// **'No proxies or proxy providers are selected, so the core rejects this group'**
  String get overwriteIssueNoProxySource;

  /// No description provided for @overwriteIssueMissingProxies.
  ///
  /// In en, this message translates to:
  /// **'These proxies or policies do not exist: {names}'**
  String overwriteIssueMissingProxies(Object names);

  /// No description provided for @overwriteIssueMissingProviders.
  ///
  /// In en, this message translates to:
  /// **'These proxy providers do not exist: {names}'**
  String overwriteIssueMissingProviders(Object names);

  /// No description provided for @overwriteIssueEmptyFallback.
  ///
  /// In en, this message translates to:
  /// **'The empty-group fallback must be an existing node or built-in outbound, not a proxy group: {name}'**
  String overwriteIssueEmptyFallback(Object name);

  /// No description provided for @overwriteIssueGroupLoop.
  ///
  /// In en, this message translates to:
  /// **'Proxy groups reference each other in a loop: {path}'**
  String overwriteIssueGroupLoop(Object path);

  /// No description provided for @invalidPolicy.
  ///
  /// In en, this message translates to:
  /// **'{target} is an invalid policy'**
  String invalidPolicy(Object target);

  /// No description provided for @invalidRuleSet.
  ///
  /// In en, this message translates to:
  /// **'{ruleSet} is an invalid rule set'**
  String invalidRuleSet(Object ruleSet);

  /// No description provided for @invalidSubRule.
  ///
  /// In en, this message translates to:
  /// **'{subRule} is an invalid SUB_RULE'**
  String invalidSubRule(Object subRule);

  /// No description provided for @safeMode.
  ///
  /// In en, this message translates to:
  /// **'Safe mode'**
  String get safeMode;

  /// No description provided for @safeModeAppTitle.
  ///
  /// In en, this message translates to:
  /// **'{appName} (Safe mode)'**
  String safeModeAppTitle(Object appName);

  /// No description provided for @hideTimeoutProxies.
  ///
  /// In en, this message translates to:
  /// **'Hide failed nodes'**
  String get hideTimeoutProxies;

  /// No description provided for @delayTestQueued.
  ///
  /// In en, this message translates to:
  /// **'Queued'**
  String get delayTestQueued;

  /// No description provided for @delayTestRunning.
  ///
  /// In en, this message translates to:
  /// **'Testing'**
  String get delayTestRunning;

  /// No description provided for @dnsQueries.
  ///
  /// In en, this message translates to:
  /// **'DNS queries'**
  String get dnsQueries;

  /// No description provided for @dnsQueriesDesc.
  ///
  /// In en, this message translates to:
  /// **'View the latest 500 resolver queries'**
  String get dnsQueriesDesc;

  /// No description provided for @dnsQueryCached.
  ///
  /// In en, this message translates to:
  /// **'Cached'**
  String get dnsQueryCached;

  /// No description provided for @dnsQueryUpstream.
  ///
  /// In en, this message translates to:
  /// **'Upstream'**
  String get dnsQueryUpstream;

  /// No description provided for @dnsQueryAnswers.
  ///
  /// In en, this message translates to:
  /// **'Answers'**
  String get dnsQueryAnswers;

  /// No description provided for @dnsQueryRcode.
  ///
  /// In en, this message translates to:
  /// **'Response code'**
  String get dnsQueryRcode;

  /// No description provided for @dnsQueryType.
  ///
  /// In en, this message translates to:
  /// **'Query type'**
  String get dnsQueryType;

  /// No description provided for @pauseUpdates.
  ///
  /// In en, this message translates to:
  /// **'Pause updates'**
  String get pauseUpdates;

  /// No description provided for @resumeUpdates.
  ///
  /// In en, this message translates to:
  /// **'Resume updates'**
  String get resumeUpdates;

  /// No description provided for @dnsQueryAll.
  ///
  /// In en, this message translates to:
  /// **'All queries'**
  String get dnsQueryAll;

  /// No description provided for @dnsQueryFailures.
  ///
  /// In en, this message translates to:
  /// **'Failed queries'**
  String get dnsQueryFailures;

  /// No description provided for @dnsQueryInitiatorApp.
  ///
  /// In en, this message translates to:
  /// **'Application'**
  String get dnsQueryInitiatorApp;

  /// No description provided for @dnsQueryInitiatorRule.
  ///
  /// In en, this message translates to:
  /// **'Rule matching'**
  String get dnsQueryInitiatorRule;

  /// No description provided for @dnsQueryInitiatorDirect.
  ///
  /// In en, this message translates to:
  /// **'Direct connection'**
  String get dnsQueryInitiatorDirect;

  /// No description provided for @dnsQueryInitiatorProxy.
  ///
  /// In en, this message translates to:
  /// **'Proxy connection'**
  String get dnsQueryInitiatorProxy;

  /// No description provided for @dnsQueryInitiatorOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get dnsQueryInitiatorOther;

  /// No description provided for @action_ruleMode.
  ///
  /// In en, this message translates to:
  /// **'Rule mode'**
  String get action_ruleMode;

  /// No description provided for @action_globalMode.
  ///
  /// In en, this message translates to:
  /// **'Global mode'**
  String get action_globalMode;

  /// No description provided for @action_directMode.
  ///
  /// In en, this message translates to:
  /// **'Direct mode'**
  String get action_directMode;

  /// No description provided for @action_delayTest.
  ///
  /// In en, this message translates to:
  /// **'Test node latency'**
  String get action_delayTest;

  /// No description provided for @action_updateProfiles.
  ///
  /// In en, this message translates to:
  /// **'Update profiles'**
  String get action_updateProfiles;

  /// No description provided for @action_copyEnv.
  ///
  /// In en, this message translates to:
  /// **'Copy proxy environment variables'**
  String get action_copyEnv;

  /// No description provided for @action_exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get action_exit;

  /// No description provided for @hotkeyUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Shortcut unavailable'**
  String get hotkeyUnavailable;

  /// No description provided for @runTime.
  ///
  /// In en, this message translates to:
  /// **'Uptime'**
  String get runTime;

  /// No description provided for @floatingNavigationBar.
  ///
  /// In en, this message translates to:
  /// **'Floating navigation'**
  String get floatingNavigationBar;

  /// No description provided for @localNetworkTip.
  ///
  /// In en, this message translates to:
  /// **'Local network access denied; using gVisor for this connection. LAN proxies and services may remain unavailable'**
  String get localNetworkTip;

  /// No description provided for @sidebar.
  ///
  /// In en, this message translates to:
  /// **'Sidebar'**
  String get sidebar;

  /// No description provided for @backgroundBlur.
  ///
  /// In en, this message translates to:
  /// **'Background blur'**
  String get backgroundBlur;

  /// No description provided for @sidebarBlurDesc.
  ///
  /// In en, this message translates to:
  /// **'Background blur lets the desktop behind the window show through the sidebar.'**
  String get sidebarBlurDesc;

  /// No description provided for @format.
  ///
  /// In en, this message translates to:
  /// **'Format'**
  String get format;

  /// No description provided for @behavior.
  ///
  /// In en, this message translates to:
  /// **'Behavior'**
  String get behavior;

  /// No description provided for @appProviderLibrary.
  ///
  /// In en, this message translates to:
  /// **'Provider library'**
  String get appProviderLibrary;

  /// No description provided for @providerLocal.
  ///
  /// In en, this message translates to:
  /// **'Local file'**
  String get providerLocal;

  /// No description provided for @providerRemote.
  ///
  /// In en, this message translates to:
  /// **'Remote URL'**
  String get providerRemote;

  /// No description provided for @providerContent.
  ///
  /// In en, this message translates to:
  /// **'Resource content'**
  String get providerContent;

  /// No description provided for @providerContentInvalid.
  ///
  /// In en, this message translates to:
  /// **'The resource content or format is invalid'**
  String get providerContentInvalid;

  /// No description provided for @providerContentTooLarge.
  ///
  /// In en, this message translates to:
  /// **'The resource exceeds 32 MiB'**
  String get providerContentTooLarge;

  /// No description provided for @providerChanged.
  ///
  /// In en, this message translates to:
  /// **'The resource changed while editing; reopen it and try again'**
  String get providerChanged;

  /// No description provided for @providerNameInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a name without commas or line breaks'**
  String get providerNameInvalid;

  /// No description provided for @providerInUse.
  ///
  /// In en, this message translates to:
  /// **'This resource is still used by {profiles}'**
  String providerInUse(String profiles);

  /// No description provided for @providerRenameShadowed.
  ///
  /// In en, this message translates to:
  /// **'Renaming would change subscription resource references in {profiles}'**
  String providerRenameShadowed(String profiles);

  /// No description provided for @providerUrlTip.
  ///
  /// In en, this message translates to:
  /// **'Enter an HTTP or HTTPS URL without embedded credentials'**
  String get providerUrlTip;

  /// No description provided for @providerSourceReference.
  ///
  /// In en, this message translates to:
  /// **'Edit references in the source profile before renaming: {profiles}'**
  String providerSourceReference(String profiles);

  /// No description provided for @providerSourceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Cannot read these profiles to check references: {profiles}'**
  String providerSourceUnavailable(String profiles);

  /// No description provided for @nodeDefinition.
  ///
  /// In en, this message translates to:
  /// **'Node definition'**
  String get nodeDefinition;

  /// No description provided for @nodeQuickFields.
  ///
  /// In en, this message translates to:
  /// **'Quick edit'**
  String get nodeQuickFields;

  /// No description provided for @nodeCoreValidationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Start the Core before validating this node'**
  String get nodeCoreValidationUnavailable;

  /// No description provided for @nodeInvalidDefinition.
  ///
  /// In en, this message translates to:
  /// **'Enter one complete proxy definition with a name and type'**
  String get nodeInvalidDefinition;

  /// No description provided for @releaseMemory.
  ///
  /// In en, this message translates to:
  /// **'Release memory'**
  String get releaseMemory;

  /// No description provided for @memoryCoreHeapInuse.
  ///
  /// In en, this message translates to:
  /// **'Heap in use'**
  String get memoryCoreHeapInuse;

  /// No description provided for @memoryCoreHeapIdle.
  ///
  /// In en, this message translates to:
  /// **'Heap idle'**
  String get memoryCoreHeapIdle;

  /// No description provided for @memoryCoreStack.
  ///
  /// In en, this message translates to:
  /// **'Goroutine stacks'**
  String get memoryCoreStack;

  /// No description provided for @memoryCoreRuntime.
  ///
  /// In en, this message translates to:
  /// **'Runtime overhead'**
  String get memoryCoreRuntime;

  /// No description provided for @memoryCoreNotRunning.
  ///
  /// In en, this message translates to:
  /// **'Core is not running'**
  String get memoryCoreNotRunning;

  /// No description provided for @memoryAppResident.
  ///
  /// In en, this message translates to:
  /// **'Resident memory'**
  String get memoryAppResident;

  /// No description provided for @memoryAppShared.
  ///
  /// In en, this message translates to:
  /// **'App & shared'**
  String get memoryAppShared;

  /// No description provided for @memoryEstimateDesc.
  ///
  /// In en, this message translates to:
  /// **'Estimated from process resident memory; it may differ from what the system reports.'**
  String get memoryEstimateDesc;

  /// No description provided for @memoryEstimateSharedDesc.
  ///
  /// In en, this message translates to:
  /// **'The Core runs inside the app process. Its share is estimated from runtime stats, and the rest counts as app and shared memory.'**
  String get memoryEstimateSharedDesc;

  /// No description provided for @memoryReleased.
  ///
  /// In en, this message translates to:
  /// **'Memory released'**
  String get memoryReleased;

  /// No description provided for @memoryReleasedSize.
  ///
  /// In en, this message translates to:
  /// **'Released {size}'**
  String memoryReleasedSize(Object size);

  /// No description provided for @releaseMemoryFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to release memory'**
  String get releaseMemoryFailed;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @showNotificationStopAction.
  ///
  /// In en, this message translates to:
  /// **'Stop button in notification'**
  String get showNotificationStopAction;

  /// No description provided for @interfaceName.
  ///
  /// In en, this message translates to:
  /// **'Interface name'**
  String get interfaceName;

  /// No description provided for @interfaceNameMode.
  ///
  /// In en, this message translates to:
  /// **'Outbound interface'**
  String get interfaceNameMode;

  /// No description provided for @interfaceNameDesc.
  ///
  /// In en, this message translates to:
  /// **'Interface name is the network interface outbound connections use'**
  String get interfaceNameDesc;

  /// No description provided for @interfaceFollowProfile.
  ///
  /// In en, this message translates to:
  /// **'Follow profile'**
  String get interfaceFollowProfile;

  /// No description provided for @interfaceAutomatic.
  ///
  /// In en, this message translates to:
  /// **'Clear override (automatic interface)'**
  String get interfaceAutomatic;

  /// No description provided for @hideIp.
  ///
  /// In en, this message translates to:
  /// **'Hide IP'**
  String get hideIp;

  /// No description provided for @cameraPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Camera permission required'**
  String get cameraPermissionRequired;

  /// No description provided for @cameraPermissionDesc.
  ///
  /// In en, this message translates to:
  /// **'Allow camera access in system settings to scan QR codes, or choose a QR code image from the album.'**
  String get cameraPermissionDesc;

  /// No description provided for @cameraUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Camera unavailable'**
  String get cameraUnavailable;

  /// No description provided for @invalidProfileQrcode.
  ///
  /// In en, this message translates to:
  /// **'This QR code doesn\'t contain a profile link'**
  String get invalidProfileQrcode;

  /// No description provided for @pickFromAlbum.
  ///
  /// In en, this message translates to:
  /// **'Choose from album'**
  String get pickFromAlbum;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @toggleFlashlight.
  ///
  /// In en, this message translates to:
  /// **'Toggle flashlight'**
  String get toggleFlashlight;

  /// No description provided for @networkTimeoutError.
  ///
  /// In en, this message translates to:
  /// **'The request timed out. Check your network or proxy, then try again'**
  String get networkTimeoutError;

  /// No description provided for @networkHostLookupError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t resolve the server address. Check that the URL is correct and DNS is working'**
  String get networkHostLookupError;

  /// No description provided for @monochromeIcon.
  ///
  /// In en, this message translates to:
  /// **'Monochrome icon'**
  String get monochromeIcon;

  /// No description provided for @networkConnectionError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t connect to the server. Check your network connection or proxy settings'**
  String get networkConnectionError;

  /// No description provided for @networkTlsError.
  ///
  /// In en, this message translates to:
  /// **'Secure connection failed. The server\'s certificate may be invalid, or the connection is being intercepted'**
  String get networkTlsError;

  /// No description provided for @networkCancelledError.
  ///
  /// In en, this message translates to:
  /// **'The request was cancelled'**
  String get networkCancelledError;

  /// No description provided for @networkAccessDeniedError.
  ///
  /// In en, this message translates to:
  /// **'The server denied access (HTTP {code}). The link may have expired, or the credentials are wrong'**
  String networkAccessDeniedError(Object code);

  /// No description provided for @networkNotFoundError.
  ///
  /// In en, this message translates to:
  /// **'Nothing was found at this address (HTTP {code}). Check that the URL is correct'**
  String networkNotFoundError(Object code);

  /// No description provided for @networkRateLimitedError.
  ///
  /// In en, this message translates to:
  /// **'Too many requests (HTTP 429). Wait a moment and try again'**
  String get networkRateLimitedError;

  /// No description provided for @networkServerError.
  ///
  /// In en, this message translates to:
  /// **'The server ran into a problem (HTTP {code}). Try again later'**
  String networkServerError(Object code);

  /// No description provided for @networkBadResponseError.
  ///
  /// In en, this message translates to:
  /// **'The server rejected the request (HTTP {code})'**
  String networkBadResponseError(Object code);

  /// No description provided for @clipboardWriteFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t copy to the clipboard. The selection may be too large'**
  String get clipboardWriteFailed;

  /// No description provided for @lineWrap.
  ///
  /// In en, this message translates to:
  /// **'Word wrap'**
  String get lineWrap;

  /// No description provided for @previousMatch.
  ///
  /// In en, this message translates to:
  /// **'Previous match'**
  String get previousMatch;

  /// No description provided for @nextMatch.
  ///
  /// In en, this message translates to:
  /// **'Next match'**
  String get nextMatch;

  /// No description provided for @editorUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Editor unavailable'**
  String get editorUnavailable;

  /// No description provided for @replaceAll.
  ///
  /// In en, this message translates to:
  /// **'Replace all'**
  String get replaceAll;

  /// No description provided for @fontSize.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get fontSize;

  /// No description provided for @replace.
  ///
  /// In en, this message translates to:
  /// **'Replace'**
  String get replace;

  /// No description provided for @locateSelected.
  ///
  /// In en, this message translates to:
  /// **'Locate selected node'**
  String get locateSelected;

  /// No description provided for @expandList.
  ///
  /// In en, this message translates to:
  /// **'Expand'**
  String get expandList;

  /// No description provided for @collapseList.
  ///
  /// In en, this message translates to:
  /// **'Collapse'**
  String get collapseList;

  /// No description provided for @clearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// No description provided for @closeAllConnections.
  ///
  /// In en, this message translates to:
  /// **'Close all connections'**
  String get closeAllConnections;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'Expand'**
  String get showMore;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **'Collapse'**
  String get showLess;

  /// No description provided for @showPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePassword;

  /// No description provided for @switchProfile.
  ///
  /// In en, this message translates to:
  /// **'Switch profile'**
  String get switchProfile;

  /// No description provided for @subscriptionInfo.
  ///
  /// In en, this message translates to:
  /// **'Subscription info'**
  String get subscriptionInfo;

  /// No description provided for @lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated'**
  String get lastUpdated;

  /// No description provided for @proxiesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 proxy} other{{count} proxies}}'**
  String proxiesCount(num count);

  /// No description provided for @rulesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 rule} other{{count} rules}}'**
  String rulesCount(num count);

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @noSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No matching results'**
  String get noSearchResults;

  /// No description provided for @proxyNode.
  ///
  /// In en, this message translates to:
  /// **'Proxy node'**
  String get proxyNode;

  /// No description provided for @rules.
  ///
  /// In en, this message translates to:
  /// **'Rules'**
  String get rules;

  /// No description provided for @addOverrideEntry.
  ///
  /// In en, this message translates to:
  /// **'Add override entry'**
  String get addOverrideEntry;

  /// No description provided for @batchAdd.
  ///
  /// In en, this message translates to:
  /// **'Batch add'**
  String get batchAdd;

  /// No description provided for @batchListInputTip.
  ///
  /// In en, this message translates to:
  /// **'One item per line, or separated by commas'**
  String get batchListInputTip;

  /// No description provided for @batchMapInputTip.
  ///
  /// In en, this message translates to:
  /// **'One entry per line: key, a space, then value'**
  String get batchMapInputTip;

  /// No description provided for @batchPreviewTip.
  ///
  /// In en, this message translates to:
  /// **'{count} to add, {skipped} skipped as existing'**
  String batchPreviewTip(Object count, Object skipped);

  /// No description provided for @cacheAlgorithm.
  ///
  /// In en, this message translates to:
  /// **'Cache algorithm'**
  String get cacheAlgorithm;

  /// No description provided for @cacheMaxSize.
  ///
  /// In en, this message translates to:
  /// **'Cache size'**
  String get cacheMaxSize;

  /// No description provided for @dialerProxy.
  ///
  /// In en, this message translates to:
  /// **'Dialer proxy'**
  String get dialerProxy;

  /// No description provided for @dialerProxyDesc.
  ///
  /// In en, this message translates to:
  /// **'Dialer proxy is the outbound used to reach the NTP server'**
  String get dialerProxyDesc;

  /// No description provided for @dialerProxyLoopStopped.
  ///
  /// In en, this message translates to:
  /// **'Dialing through {name} leads back to the proxy that uses it, so the connection was stopped'**
  String dialerProxyLoopStopped(Object name);

  /// No description provided for @discardChanges.
  ///
  /// In en, this message translates to:
  /// **'Discard the changes?'**
  String get discardChanges;

  /// No description provided for @fakeipFilterMode.
  ///
  /// In en, this message translates to:
  /// **'Fake-IP filter mode'**
  String get fakeipFilterMode;

  /// No description provided for @fakeipFilterModeDesc.
  ///
  /// In en, this message translates to:
  /// **'In Fake-IP filter mode, blacklist excludes matches, whitelist fakes only matches, and rule matches as rules'**
  String get fakeipFilterModeDesc;

  /// No description provided for @fakeipRange6.
  ///
  /// In en, this message translates to:
  /// **'Fake-IP range (IPv6)'**
  String get fakeipRange6;

  /// No description provided for @fakeipTtl.
  ///
  /// In en, this message translates to:
  /// **'Fake-IP TTL'**
  String get fakeipTtl;

  /// No description provided for @ipv6Timeout.
  ///
  /// In en, this message translates to:
  /// **'IPv6 timeout (ms)'**
  String get ipv6Timeout;

  /// No description provided for @lineIssueTip.
  ///
  /// In en, this message translates to:
  /// **'Line {line}: {message}'**
  String lineIssueTip(Object line, Object message);

  /// No description provided for @listenRoutingMark.
  ///
  /// In en, this message translates to:
  /// **'Listen routing mark'**
  String get listenRoutingMark;

  /// No description provided for @listenRoutingMarkDesc.
  ///
  /// In en, this message translates to:
  /// **'Listen routing mark works only on Linux'**
  String get listenRoutingMarkDesc;

  /// No description provided for @maxLengthTip.
  ///
  /// In en, this message translates to:
  /// **'{label} must be at most {max} characters'**
  String maxLengthTip(Object label, Object max);

  /// No description provided for @ntpInterval.
  ///
  /// In en, this message translates to:
  /// **'Sync interval (minutes)'**
  String get ntpInterval;

  /// No description provided for @ntpStatusDesc.
  ///
  /// In en, this message translates to:
  /// **'NTP takes the time from an NTP server instead of the system clock'**
  String get ntpStatusDesc;

  /// No description provided for @overrideEntries.
  ///
  /// In en, this message translates to:
  /// **'Override entries'**
  String get overrideEntries;

  /// No description provided for @quickEdit.
  ///
  /// In en, this message translates to:
  /// **'Quick edit'**
  String get quickEdit;

  /// No description provided for @server.
  ///
  /// In en, this message translates to:
  /// **'Server'**
  String get server;

  /// No description provided for @singleAdd.
  ///
  /// In en, this message translates to:
  /// **'Single add'**
  String get singleAdd;

  /// No description provided for @singleValueTip.
  ///
  /// In en, this message translates to:
  /// **'{label} must be a single item'**
  String singleValueTip(Object label);

  /// No description provided for @writeToSystem.
  ///
  /// In en, this message translates to:
  /// **'Write to system'**
  String get writeToSystem;

  /// No description provided for @writeToSystemDesc.
  ///
  /// In en, this message translates to:
  /// **'Write to system also sets the system clock; Android ignores it'**
  String get writeToSystemDesc;

  /// No description provided for @basicInfo.
  ///
  /// In en, this message translates to:
  /// **'Basic info'**
  String get basicInfo;

  /// No description provided for @ruleActionIpSuffixDesc.
  ///
  /// In en, this message translates to:
  /// **'Match an IP suffix range'**
  String get ruleActionIpSuffixDesc;

  /// No description provided for @ruleActionDomainSuffixDesc.
  ///
  /// In en, this message translates to:
  /// **'Match a domain suffix'**
  String get ruleActionDomainSuffixDesc;

  /// No description provided for @ruleActionMatchDesc.
  ///
  /// In en, this message translates to:
  /// **'Match all requests, no conditions needed'**
  String get ruleActionMatchDesc;

  /// No description provided for @ruleActionSrcGeoipDesc.
  ///
  /// In en, this message translates to:
  /// **'Match the source IP\'s country code'**
  String get ruleActionSrcGeoipDesc;

  /// No description provided for @ruleActionDomainWildcardDesc.
  ///
  /// In en, this message translates to:
  /// **'Wildcard match; only * and ? are supported'**
  String get ruleActionDomainWildcardDesc;

  /// No description provided for @ruleActionAndDesc.
  ///
  /// In en, this message translates to:
  /// **'Logical rule AND'**
  String get ruleActionAndDesc;

  /// No description provided for @ruleActionIpCidr6Desc.
  ///
  /// In en, this message translates to:
  /// **'Match an IP address range; IP-CIDR6 is just an alias'**
  String get ruleActionIpCidr6Desc;

  /// No description provided for @ruleActionDomainRegexDesc.
  ///
  /// In en, this message translates to:
  /// **'Match a domain regex'**
  String get ruleActionDomainRegexDesc;

  /// No description provided for @ruleActionProcessPathRegexDesc.
  ///
  /// In en, this message translates to:
  /// **'Match by process path regex'**
  String get ruleActionProcessPathRegexDesc;

  /// No description provided for @ruleActionDstPortDesc.
  ///
  /// In en, this message translates to:
  /// **'Match the destination port range'**
  String get ruleActionDstPortDesc;

  /// No description provided for @ruleActionDscpDesc.
  ///
  /// In en, this message translates to:
  /// **'Match the DSCP mark (tproxy UDP inbound only)'**
  String get ruleActionDscpDesc;

  /// No description provided for @ruleActionInPortDesc.
  ///
  /// In en, this message translates to:
  /// **'Match the inbound port'**
  String get ruleActionInPortDesc;

  /// No description provided for @ruleActionUidDesc.
  ///
  /// In en, this message translates to:
  /// **'Match the Linux user ID'**
  String get ruleActionUidDesc;

  /// No description provided for @ruleActionIpCidrDesc.
  ///
  /// In en, this message translates to:
  /// **'Match an IP address range'**
  String get ruleActionIpCidrDesc;

  /// No description provided for @ruleActionRuleSetDesc.
  ///
  /// In en, this message translates to:
  /// **'Reference a rule set; requires rule-providers'**
  String get ruleActionRuleSetDesc;

  /// No description provided for @ruleActionGeositeDesc.
  ///
  /// In en, this message translates to:
  /// **'Match domains in Geosite'**
  String get ruleActionGeositeDesc;

  /// No description provided for @ruleActionNetworkDesc.
  ///
  /// In en, this message translates to:
  /// **'Match TCP or UDP'**
  String get ruleActionNetworkDesc;

  /// No description provided for @ruleActionProcessPathDesc.
  ///
  /// In en, this message translates to:
  /// **'Match by the full process path'**
  String get ruleActionProcessPathDesc;

  /// No description provided for @ruleActionProcessPathWildcardDesc.
  ///
  /// In en, this message translates to:
  /// **'Match by process path wildcard; only * and ? are supported'**
  String get ruleActionProcessPathWildcardDesc;

  /// No description provided for @ruleActionRematchNameDesc.
  ///
  /// In en, this message translates to:
  /// **'Match the rematch name; separate multiple names with /'**
  String get ruleActionRematchNameDesc;

  /// No description provided for @ruleActionSrcIpSuffixDesc.
  ///
  /// In en, this message translates to:
  /// **'Match a source IP suffix range'**
  String get ruleActionSrcIpSuffixDesc;

  /// No description provided for @ruleActionGeoipDesc.
  ///
  /// In en, this message translates to:
  /// **'Match the IP\'s country code'**
  String get ruleActionGeoipDesc;

  /// No description provided for @ruleActionInUserDesc.
  ///
  /// In en, this message translates to:
  /// **'Match the inbound username; separate multiple usernames with /'**
  String get ruleActionInUserDesc;

  /// No description provided for @invalidNetworkContent.
  ///
  /// In en, this message translates to:
  /// **'Only tcp or udp is supported'**
  String get invalidNetworkContent;

  /// No description provided for @ruleActionDomainKeywordDesc.
  ///
  /// In en, this message translates to:
  /// **'Match a domain keyword'**
  String get ruleActionDomainKeywordDesc;

  /// No description provided for @ruleActionNotDesc.
  ///
  /// In en, this message translates to:
  /// **'Logical rule NOT'**
  String get ruleActionNotDesc;

  /// No description provided for @ruleActionSrcIpAsnDesc.
  ///
  /// In en, this message translates to:
  /// **'Match the source IP\'s ASN'**
  String get ruleActionSrcIpAsnDesc;

  /// No description provided for @invalidRangeContent.
  ///
  /// In en, this message translates to:
  /// **'Enter numbers or ranges such as 80 or 8000-9000, separated by /'**
  String get invalidRangeContent;

  /// No description provided for @ruleActionProcessNameRegexDesc.
  ///
  /// In en, this message translates to:
  /// **'Match by process name regex; matches the package name on Android'**
  String get ruleActionProcessNameRegexDesc;

  /// No description provided for @ruleActionSrcIpCidrDesc.
  ///
  /// In en, this message translates to:
  /// **'Match a source IP address range'**
  String get ruleActionSrcIpCidrDesc;

  /// No description provided for @ruleActionDomainDesc.
  ///
  /// In en, this message translates to:
  /// **'Match the full domain'**
  String get ruleActionDomainDesc;

  /// No description provided for @ruleActionInNameDesc.
  ///
  /// In en, this message translates to:
  /// **'Match the inbound name'**
  String get ruleActionInNameDesc;

  /// No description provided for @invalidDscpContent.
  ///
  /// In en, this message translates to:
  /// **'A DSCP mark cannot exceed 63'**
  String get invalidDscpContent;

  /// No description provided for @invalidCidrContent.
  ///
  /// In en, this message translates to:
  /// **'Enter an IP range in CIDR form such as 192.168.0.0/16'**
  String get invalidCidrContent;

  /// No description provided for @invalidIpv6CidrContent.
  ///
  /// In en, this message translates to:
  /// **'Enter an IPv6 range in CIDR form such as fd00::/8'**
  String get invalidIpv6CidrContent;

  /// No description provided for @invalidHostContent.
  ///
  /// In en, this message translates to:
  /// **'Enter a domain or an IP address'**
  String get invalidHostContent;

  /// No description provided for @invalidListenContent.
  ///
  /// In en, this message translates to:
  /// **'Enter an address and port such as 0.0.0.0:1053'**
  String get invalidListenContent;

  /// No description provided for @ruleActionIpAsnDesc.
  ///
  /// In en, this message translates to:
  /// **'Match the IP\'s ASN'**
  String get ruleActionIpAsnDesc;

  /// No description provided for @ruleActionSrcPortDesc.
  ///
  /// In en, this message translates to:
  /// **'Match the source port range'**
  String get ruleActionSrcPortDesc;

  /// No description provided for @ruleActionInTypeDesc.
  ///
  /// In en, this message translates to:
  /// **'Match the inbound type'**
  String get ruleActionInTypeDesc;

  /// No description provided for @ruleActionOrDesc.
  ///
  /// In en, this message translates to:
  /// **'Logical rule OR'**
  String get ruleActionOrDesc;

  /// No description provided for @ruleActionSubRuleDesc.
  ///
  /// In en, this message translates to:
  /// **'Match into a sub-rule; mind the parentheses'**
  String get ruleActionSubRuleDesc;

  /// No description provided for @ruleActionProcessNameWildcardDesc.
  ///
  /// In en, this message translates to:
  /// **'Match by process name wildcard; only * and ? are supported'**
  String get ruleActionProcessNameWildcardDesc;

  /// No description provided for @ruleActionProcessNameDesc.
  ///
  /// In en, this message translates to:
  /// **'Match by process name; matches the package name on Android'**
  String get ruleActionProcessNameDesc;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @startupAndBackground.
  ///
  /// In en, this message translates to:
  /// **'Startup and background'**
  String get startupAndBackground;

  /// No description provided for @inbound.
  ///
  /// In en, this message translates to:
  /// **'Inbound'**
  String get inbound;

  /// No description provided for @outbound.
  ///
  /// In en, this message translates to:
  /// **'Outbound'**
  String get outbound;

  /// No description provided for @logsAndDiagnostics.
  ///
  /// In en, this message translates to:
  /// **'Logs and diagnostics'**
  String get logsAndDiagnostics;

  /// No description provided for @onDemand.
  ///
  /// In en, this message translates to:
  /// **'On demand'**
  String get onDemand;

  /// No description provided for @onDemandDesc.
  ///
  /// In en, this message translates to:
  /// **'On demand pauses and resumes the proxy by Wi-Fi or network conditions'**
  String get onDemandDesc;

  /// No description provided for @prerequisites.
  ///
  /// In en, this message translates to:
  /// **'Prerequisites'**
  String get prerequisites;

  /// No description provided for @suspended.
  ///
  /// In en, this message translates to:
  /// **'Suspended…'**
  String get suspended;

  /// No description provided for @enabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// No description provided for @enabledOnStart.
  ///
  /// In en, this message translates to:
  /// **'Enable on start'**
  String get enabledOnStart;

  /// No description provided for @disabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabled;

  /// No description provided for @overwriteIssuesSummary.
  ///
  /// In en, this message translates to:
  /// **'{count} items have problems, and applying this override may fail'**
  String overwriteIssuesSummary(Object count);

  /// No description provided for @ignoreBatteryOptimization.
  ///
  /// In en, this message translates to:
  /// **'Ignore battery optimization'**
  String get ignoreBatteryOptimization;

  /// No description provided for @batteryOptimizationDesc.
  ///
  /// In en, this message translates to:
  /// **'Ignore battery optimization keeps the app running in the background'**
  String get batteryOptimizationDesc;

  /// No description provided for @batteryOptimizationStatusTip.
  ///
  /// In en, this message translates to:
  /// **'Due to system limitations, the battery optimization status cannot be read correctly while running'**
  String get batteryOptimizationStatusTip;

  /// No description provided for @authorized.
  ///
  /// In en, this message translates to:
  /// **'Authorized'**
  String get authorized;

  /// No description provided for @tapToAuthorize.
  ///
  /// In en, this message translates to:
  /// **'Tap to authorize'**
  String get tapToAuthorize;

  /// No description provided for @addSsid.
  ///
  /// In en, this message translates to:
  /// **'Add SSID'**
  String get addSsid;

  /// No description provided for @editSsid.
  ///
  /// In en, this message translates to:
  /// **'Edit SSID'**
  String get editSsid;

  /// No description provided for @ssidsEmpty.
  ///
  /// In en, this message translates to:
  /// **'SSIDs are empty'**
  String get ssidsEmpty;

  /// No description provided for @hotkeyDesc.
  ///
  /// In en, this message translates to:
  /// **'Global hotkeys work even while the window is hidden. Tap an action to record its key combination.'**
  String get hotkeyDesc;

  /// No description provided for @hotkeyNotSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get hotkeyNotSet;

  /// No description provided for @hotkeyNeedsModifier.
  ///
  /// In en, this message translates to:
  /// **'Include at least one of {modifiers}'**
  String hotkeyNeedsModifier(Object modifiers);

  /// No description provided for @hotkeyConflictWith.
  ///
  /// In en, this message translates to:
  /// **'Already used by “{action}”. Saving moves it here.'**
  String hotkeyConflictWith(Object action);

  /// No description provided for @confirmExitWindow.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit the current window?'**
  String get confirmExitWindow;

  /// No description provided for @dataChangedSave.
  ///
  /// In en, this message translates to:
  /// **'Data changes detected. Save them?'**
  String get dataChangedSave;

  /// No description provided for @discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// No description provided for @docked.
  ///
  /// In en, this message translates to:
  /// **'Docked'**
  String get docked;

  /// No description provided for @fade.
  ///
  /// In en, this message translates to:
  /// **'Fade'**
  String get fade;

  /// No description provided for @floating.
  ///
  /// In en, this message translates to:
  /// **'Floating'**
  String get floating;

  /// No description provided for @followSystem.
  ///
  /// In en, this message translates to:
  /// **'Follow system'**
  String get followSystem;

  /// No description provided for @navigationBarStyle.
  ///
  /// In en, this message translates to:
  /// **'Bottom bar'**
  String get navigationBarStyle;

  /// No description provided for @pureBlack.
  ///
  /// In en, this message translates to:
  /// **'Pure black'**
  String get pureBlack;

  /// No description provided for @slide.
  ///
  /// In en, this message translates to:
  /// **'Slide'**
  String get slide;

  /// No description provided for @textScalePreview.
  ///
  /// In en, this message translates to:
  /// **'Text in the app will look like this'**
  String get textScalePreview;

  /// No description provided for @basicStrategy.
  ///
  /// In en, this message translates to:
  /// **'Basic strategies'**
  String get basicStrategy;

  /// No description provided for @nonTextProviderFile.
  ///
  /// In en, this message translates to:
  /// **'This external resource is not a text file'**
  String get nonTextProviderFile;

  /// No description provided for @scriptChanged.
  ///
  /// In en, this message translates to:
  /// **'The script changed or was deleted. Reopen it and try again.'**
  String get scriptChanged;

  /// No description provided for @startFromScratch.
  ///
  /// In en, this message translates to:
  /// **'Start from scratch'**
  String get startFromScratch;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @coreBlockedBySmartAppControlTip.
  ///
  /// In en, this message translates to:
  /// **'Windows blocked FlClashCore.exe, and Smart App Control is enabled. Check the block details in Windows Security → App & browser control, and use a trusted, verified release.'**
  String get coreBlockedBySmartAppControlTip;

  /// No description provided for @helperCorruptTip.
  ///
  /// In en, this message translates to:
  /// **'Helper service unavailable; TUN mode cannot be enabled. Reinstall FlClash to restore it.'**
  String get helperCorruptTip;

  /// No description provided for @changeProxyFailedTip.
  ///
  /// In en, this message translates to:
  /// **'Failed to switch proxy; the previous selection has been restored'**
  String get changeProxyFailedTip;

  /// No description provided for @databaseWriteFailedTip.
  ///
  /// In en, this message translates to:
  /// **'Failed to save the change. Please check the current value and try again.'**
  String get databaseWriteFailedTip;

  /// No description provided for @proxyType.
  ///
  /// In en, this message translates to:
  /// **'Proxy type'**
  String get proxyType;

  /// No description provided for @providerSourceSubscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get providerSourceSubscription;

  /// No description provided for @providerSourceProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get providerSourceProfile;

  /// No description provided for @providerSourceApp.
  ///
  /// In en, this message translates to:
  /// **'App library'**
  String get providerSourceApp;

  /// No description provided for @target.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get target;

  /// No description provided for @outboundExit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get outboundExit;

  /// No description provided for @protocol.
  ///
  /// In en, this message translates to:
  /// **'Protocol'**
  String get protocol;

  /// No description provided for @traffic.
  ///
  /// In en, this message translates to:
  /// **'Traffic'**
  String get traffic;

  /// No description provided for @totalDownload.
  ///
  /// In en, this message translates to:
  /// **'Downloaded'**
  String get totalDownload;

  /// No description provided for @totalUpload.
  ///
  /// In en, this message translates to:
  /// **'Uploaded'**
  String get totalUpload;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @initiatorShort.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get initiatorShort;

  /// No description provided for @result.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get result;

  /// No description provided for @elapsed.
  ///
  /// In en, this message translates to:
  /// **'Took'**
  String get elapsed;

  /// No description provided for @tunOverrideDesc.
  ///
  /// In en, this message translates to:
  /// **'Entries added here replace the TUN settings of every profile; anything not added keeps the profile\'s own setting. Entries a custom profile adds itself take precedence'**
  String get tunOverrideDesc;

  /// No description provided for @dnsOverrideDesc.
  ///
  /// In en, this message translates to:
  /// **'Entries added here replace the DNS settings of every profile; anything not added keeps the profile\'s own setting. Entries a custom profile adds itself take precedence'**
  String get dnsOverrideDesc;

  /// No description provided for @ntpOverrideDesc.
  ///
  /// In en, this message translates to:
  /// **'Entries added here replace the NTP settings of every profile; anything not added keeps the profile\'s own setting. Entries a custom profile adds itself take precedence'**
  String get ntpOverrideDesc;

  /// No description provided for @congestionController.
  ///
  /// In en, this message translates to:
  /// **'TCP congestion control'**
  String get congestionController;

  /// No description provided for @congestionControllerDesc.
  ///
  /// In en, this message translates to:
  /// **'TCP congestion control works only with the mips stack'**
  String get congestionControllerDesc;

  /// No description provided for @strictRoute.
  ///
  /// In en, this message translates to:
  /// **'Strict route'**
  String get strictRoute;

  /// No description provided for @strictRouteDesc.
  ///
  /// In en, this message translates to:
  /// **'Strict route keeps traffic such as DNS from bypassing TUN, and with IPv6 off it blocks this device\'s IPv6 connections'**
  String get strictRouteDesc;

  /// No description provided for @routeExcludeAddress.
  ///
  /// In en, this message translates to:
  /// **'Route exclude addresses'**
  String get routeExcludeAddress;

  /// No description provided for @udpTimeout.
  ///
  /// In en, this message translates to:
  /// **'UDP timeout'**
  String get udpTimeout;

  /// No description provided for @udpTimeoutDesc.
  ///
  /// In en, this message translates to:
  /// **'The UDP timeout is in seconds and works only with the gvisor, system and mixed stacks'**
  String get udpTimeoutDesc;

  /// No description provided for @dnsHijackDesc.
  ///
  /// In en, this message translates to:
  /// **'Without this entry, TUN hijacks every DNS query to port 53 (any:53)'**
  String get dnsHijackDesc;

  /// No description provided for @disableIcmpForwarding.
  ///
  /// In en, this message translates to:
  /// **'Disable ICMP forwarding'**
  String get disableIcmpForwarding;

  /// No description provided for @disableIcmpForwardingDesc.
  ///
  /// In en, this message translates to:
  /// **'With ICMP forwarding disabled, TUN answers ping itself, so ping no longer shows the real latency'**
  String get disableIcmpForwardingDesc;

  /// No description provided for @includeInterface.
  ///
  /// In en, this message translates to:
  /// **'Included interfaces'**
  String get includeInterface;

  /// No description provided for @includeInterfaceDesc.
  ///
  /// In en, this message translates to:
  /// **'Only traffic arriving on included interfaces goes through TUN, and excluded interfaces no longer apply'**
  String get includeInterfaceDesc;

  /// No description provided for @excludeInterface.
  ///
  /// In en, this message translates to:
  /// **'Excluded interfaces'**
  String get excludeInterface;

  /// No description provided for @excludeInterfaceDesc.
  ///
  /// In en, this message translates to:
  /// **'Traffic arriving on excluded interfaces, such as docker0, skips TUN'**
  String get excludeInterfaceDesc;

  /// No description provided for @includeUid.
  ///
  /// In en, this message translates to:
  /// **'Included user IDs'**
  String get includeUid;

  /// No description provided for @includeUidDesc.
  ///
  /// In en, this message translates to:
  /// **'Only traffic from processes of included user IDs goes through TUN'**
  String get includeUidDesc;

  /// No description provided for @excludeUid.
  ///
  /// In en, this message translates to:
  /// **'Excluded user IDs'**
  String get excludeUid;

  /// No description provided for @excludeUidDesc.
  ///
  /// In en, this message translates to:
  /// **'Traffic from processes of excluded user IDs skips TUN'**
  String get excludeUidDesc;

  /// No description provided for @excludeSrcPort.
  ///
  /// In en, this message translates to:
  /// **'Excluded source ports'**
  String get excludeSrcPort;

  /// No description provided for @excludeSrcPortDesc.
  ///
  /// In en, this message translates to:
  /// **'Traffic from excluded source ports skips TUN'**
  String get excludeSrcPortDesc;

  /// No description provided for @excludeDstPort.
  ///
  /// In en, this message translates to:
  /// **'Excluded destination ports'**
  String get excludeDstPort;

  /// No description provided for @excludeDstPortDesc.
  ///
  /// In en, this message translates to:
  /// **'Traffic to excluded destination ports skips TUN'**
  String get excludeDstPortDesc;

  /// No description provided for @numberRangeTip.
  ///
  /// In en, this message translates to:
  /// **'{label} must be between {min} and {max}'**
  String numberRangeTip(Object label, Object min, Object max);

  /// No description provided for @customProfile.
  ///
  /// In en, this message translates to:
  /// **'Custom profile'**
  String get customProfile;

  /// No description provided for @customProfileDesc.
  ///
  /// In en, this message translates to:
  /// **'Assemble proxy groups and rules from your own nodes, the provider library and other profiles'**
  String get customProfileDesc;

  /// No description provided for @emptyCustomProfile.
  ///
  /// In en, this message translates to:
  /// **'Add a proxy group or a rule to this custom profile first'**
  String get emptyCustomProfile;

  /// No description provided for @nameCustomProfileTip.
  ///
  /// In en, this message translates to:
  /// **'Name this custom profile'**
  String get nameCustomProfileTip;

  /// No description provided for @profileProviderInUse.
  ///
  /// In en, this message translates to:
  /// **'This profile is a proxy provider of {profiles}. Remove it there first.'**
  String profileProviderInUse(Object profiles);

  /// No description provided for @healthCheck.
  ///
  /// In en, this message translates to:
  /// **'Health check'**
  String get healthCheck;

  /// No description provided for @additionalPrefix.
  ///
  /// In en, this message translates to:
  /// **'Name prefix'**
  String get additionalPrefix;

  /// No description provided for @additionalSuffix.
  ///
  /// In en, this message translates to:
  /// **'Name suffix'**
  String get additionalSuffix;

  /// No description provided for @ipVersion.
  ///
  /// In en, this message translates to:
  /// **'IP version'**
  String get ipVersion;

  /// No description provided for @profileSettingsDesc.
  ///
  /// In en, this message translates to:
  /// **'Applies to this profile only; anything not added uses its default'**
  String get profileSettingsDesc;

  /// No description provided for @profileOverrideSettingsDesc.
  ///
  /// In en, this message translates to:
  /// **'Applies to this profile only and takes precedence over the override entries in the app\'s DNS and NTP settings; anything not added follows those entries'**
  String get profileOverrideSettingsDesc;

  /// No description provided for @profileTunSettingsDesc.
  ///
  /// In en, this message translates to:
  /// **'Applies to this profile only and takes precedence over the TUN override entries in the network settings'**
  String get profileTunSettingsDesc;

  /// No description provided for @settingEntries.
  ///
  /// In en, this message translates to:
  /// **'settings'**
  String get settingEntries;

  /// No description provided for @addSettingEntry.
  ///
  /// In en, this message translates to:
  /// **'Add setting'**
  String get addSettingEntry;

  /// No description provided for @settingsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 setting} other{{count} settings}}'**
  String settingsCount(num count);

  /// No description provided for @sniffer.
  ///
  /// In en, this message translates to:
  /// **'Sniffer'**
  String get sniffer;

  /// No description provided for @snifferStatusDesc.
  ///
  /// In en, this message translates to:
  /// **'The sniffer reads the domain from TLS, HTTP and QUIC traffic so rules can match it'**
  String get snifferStatusDesc;

  /// No description provided for @overrideDestination.
  ///
  /// In en, this message translates to:
  /// **'Override destination'**
  String get overrideDestination;

  /// No description provided for @overrideDestinationDesc.
  ///
  /// In en, this message translates to:
  /// **'Override destination connects to the sniffed domain instead of the original address'**
  String get overrideDestinationDesc;

  /// No description provided for @forceDnsMapping.
  ///
  /// In en, this message translates to:
  /// **'Force DNS mapping'**
  String get forceDnsMapping;

  /// No description provided for @forceDnsMappingDesc.
  ///
  /// In en, this message translates to:
  /// **'Force DNS mapping also sniffs connections whose domain came from a DNS mapping'**
  String get forceDnsMappingDesc;

  /// No description provided for @parsePureIp.
  ///
  /// In en, this message translates to:
  /// **'Parse pure IP'**
  String get parsePureIp;

  /// No description provided for @parsePureIpDesc.
  ///
  /// In en, this message translates to:
  /// **'Parse pure IP sniffs connections that carry only an IP address'**
  String get parsePureIpDesc;

  /// No description provided for @forceDomain.
  ///
  /// In en, this message translates to:
  /// **'Force domains'**
  String get forceDomain;

  /// No description provided for @forceDomainDesc.
  ///
  /// In en, this message translates to:
  /// **'Force domains are sniffed too; other connections that already have a domain are left alone'**
  String get forceDomainDesc;

  /// No description provided for @skipDomain.
  ///
  /// In en, this message translates to:
  /// **'Skip domains'**
  String get skipDomain;

  /// No description provided for @skipDomainDesc.
  ///
  /// In en, this message translates to:
  /// **'A sniffed domain on the Skip domains list is not used'**
  String get skipDomainDesc;

  /// No description provided for @skipSrcAddress.
  ///
  /// In en, this message translates to:
  /// **'Skip source addresses'**
  String get skipSrcAddress;

  /// No description provided for @skipDstAddress.
  ///
  /// In en, this message translates to:
  /// **'Skip destination addresses'**
  String get skipDstAddress;

  /// No description provided for @sniffProtocols.
  ///
  /// In en, this message translates to:
  /// **'Protocols'**
  String get sniffProtocols;

  /// No description provided for @ports.
  ///
  /// In en, this message translates to:
  /// **'Ports'**
  String get ports;

  /// No description provided for @invalidPortRangeContent.
  ///
  /// In en, this message translates to:
  /// **'Enter a port or a range such as 443 or 8000-9000'**
  String get invalidPortRangeContent;

  /// No description provided for @importConfig.
  ///
  /// In en, this message translates to:
  /// **'Import config'**
  String get importConfig;

  /// No description provided for @importText.
  ///
  /// In en, this message translates to:
  /// **'Import from text'**
  String get importText;

  /// No description provided for @importConfigInvalid.
  ///
  /// In en, this message translates to:
  /// **'This is not a config that can be imported'**
  String get importConfigInvalid;

  /// No description provided for @importConfigReplaceTip.
  ///
  /// In en, this message translates to:
  /// **'Importing replaces the nodes, proxy groups, rules and settings this profile has now'**
  String get importConfigReplaceTip;

  /// No description provided for @customImportCloudRefused.
  ///
  /// In en, this message translates to:
  /// **'oixCloud addresses cannot be imported into a custom profile'**
  String get customImportCloudRefused;

  /// No description provided for @customImportNotImported.
  ///
  /// In en, this message translates to:
  /// **'Not imported'**
  String get customImportNotImported;

  /// No description provided for @customImportDroppedSubRules.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 SUB-RULE rule was dropped, since custom profiles do not support sub-rules} other{{count} SUB-RULE rules were dropped, since custom profiles do not support sub-rules}}'**
  String customImportDroppedSubRules(num count);

  /// No description provided for @customImportUnnamedProxies.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 proxy had no name or type} other{{count} proxies had no name or type}}'**
  String customImportUnnamedProxies(num count);

  /// No description provided for @failedItem.
  ///
  /// In en, this message translates to:
  /// **'{label}: {message}'**
  String failedItem(Object label, Object message);

  /// No description provided for @shareLinkNodesAdded.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 node was added from the share links} other{{count} nodes were added from the share links}}'**
  String shareLinkNodesAdded(num count);

  /// No description provided for @shareLinksNotRead.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 link could not be read} other{{count} links could not be read}}'**
  String shareLinksNotRead(num count);

  /// No description provided for @connectionStats.
  ///
  /// In en, this message translates to:
  /// **'Connection stats'**
  String get connectionStats;

  /// No description provided for @connectionStatsDesc.
  ///
  /// In en, this message translates to:
  /// **'Live connections, recent requests and DNS queries'**
  String get connectionStatsDesc;

  /// No description provided for @currentOutboundDesc.
  ///
  /// In en, this message translates to:
  /// **'Holds the start button and can\'t be removed'**
  String get currentOutboundDesc;

  /// No description provided for @dashboardAddableSection.
  ///
  /// In en, this message translates to:
  /// **'Available to add'**
  String get dashboardAddableSection;

  /// No description provided for @dashboardReorderHint.
  ///
  /// In en, this message translates to:
  /// **'Drag cards to reorder; touch and hold first on touchscreens'**
  String get dashboardReorderHint;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @editDashboard.
  ///
  /// In en, this message translates to:
  /// **'Edit dashboard'**
  String get editDashboard;

  /// No description provided for @groupCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 group} other{{count} groups}}'**
  String groupCount(num count);

  /// No description provided for @groupCountUnit.
  ///
  /// In en, this message translates to:
  /// **'groups'**
  String get groupCountUnit;

  /// No description provided for @groupTimeoutCount.
  ///
  /// In en, this message translates to:
  /// **'{count} timed out'**
  String groupTimeoutCount(Object count);

  /// No description provided for @ipType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get ipType;

  /// No description provided for @liveConnections.
  ///
  /// In en, this message translates to:
  /// **'Live connections'**
  String get liveConnections;

  /// No description provided for @memoryInfoDesc.
  ///
  /// In en, this message translates to:
  /// **'Memory the app and the core use'**
  String get memoryInfoDesc;

  /// No description provided for @networkTakeover.
  ///
  /// In en, this message translates to:
  /// **'Traffic takeover'**
  String get networkTakeover;

  /// No description provided for @notRunning.
  ///
  /// In en, this message translates to:
  /// **'Not running'**
  String get notRunning;

  /// No description provided for @portValue.
  ///
  /// In en, this message translates to:
  /// **'Port {port}'**
  String portValue(Object port);

  /// No description provided for @profileDaysLeft.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{1 day left} other{{days} days left}}'**
  String profileDaysLeft(num days);

  /// No description provided for @profileExpiresIn.
  ///
  /// In en, this message translates to:
  /// **'Expires {date}, {days, plural, =1{1 day} other{{days} days}} left'**
  String profileExpiresIn(Object date, num days);

  /// No description provided for @profileUpdatedAt.
  ///
  /// In en, this message translates to:
  /// **'Updated {time}'**
  String profileUpdatedAt(Object time);

  /// No description provided for @proxyGroupsAfterStart.
  ///
  /// In en, this message translates to:
  /// **'Groups show up here once the core starts'**
  String get proxyGroupsAfterStart;

  /// No description provided for @running.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get running;

  /// No description provided for @serviceFailed.
  ///
  /// In en, this message translates to:
  /// **'Check failed'**
  String get serviceFailed;

  /// No description provided for @tapIconToRetry.
  ///
  /// In en, this message translates to:
  /// **'Tap the icon to retry'**
  String get tapIconToRetry;

  /// No description provided for @trafficPeak.
  ///
  /// In en, this message translates to:
  /// **'Peak {value}'**
  String trafficPeak(Object value);

  /// No description provided for @trafficTotal.
  ///
  /// In en, this message translates to:
  /// **'Total {value}'**
  String trafficTotal(Object value);

  /// No description provided for @usedShort.
  ///
  /// In en, this message translates to:
  /// **'used'**
  String get usedShort;

  /// No description provided for @disableKeepAlive.
  ///
  /// In en, this message translates to:
  /// **'Disable TCP keep-alive'**
  String get disableKeepAlive;

  /// No description provided for @keepAliveIdle.
  ///
  /// In en, this message translates to:
  /// **'TCP keep-alive idle'**
  String get keepAliveIdle;

  /// No description provided for @routingMark.
  ///
  /// In en, this message translates to:
  /// **'Routing mark'**
  String get routingMark;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// No description provided for @yearsAgoShort.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{{count}y ago}}'**
  String yearsAgoShort(num count);

  /// No description provided for @monthsAgoShort.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{{count}mo ago}}'**
  String monthsAgoShort(num count);

  /// No description provided for @daysAgoShort.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{{count}d ago}}'**
  String daysAgoShort(num count);

  /// No description provided for @hoursAgoShort.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{{count}h ago}}'**
  String hoursAgoShort(num count);

  /// No description provided for @minutesAgoShort.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{{count}m ago}}'**
  String minutesAgoShort(num count);

  /// No description provided for @expireTime.
  ///
  /// In en, this message translates to:
  /// **'Expiration time'**
  String get expireTime;

  /// No description provided for @runtimeConfig.
  ///
  /// In en, this message translates to:
  /// **'Runtime config'**
  String get runtimeConfig;

  /// No description provided for @proxyGroupsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 proxy group} other{{count} proxy groups}}'**
  String proxyGroupsCount(num count);

  /// No description provided for @confirmDeleteProxyGroup.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this proxy group?'**
  String get confirmDeleteProxyGroup;

  /// No description provided for @invalidProxyProvider.
  ///
  /// In en, this message translates to:
  /// **'{providerName} is an invalid proxy provider'**
  String invalidProxyProvider(Object providerName);

  /// No description provided for @customIssuesSummary.
  ///
  /// In en, this message translates to:
  /// **'{count} items have problems, and applying this profile may fail'**
  String customIssuesSummary(Object count);

  /// No description provided for @sectionsInEffect.
  ///
  /// In en, this message translates to:
  /// **'{count} in effect'**
  String sectionsInEffect(Object count);

  /// No description provided for @emptyFallback.
  ///
  /// In en, this message translates to:
  /// **'Empty fallback'**
  String get emptyFallback;

  /// No description provided for @testInterval.
  ///
  /// In en, this message translates to:
  /// **'Test interval'**
  String get testInterval;

  /// No description provided for @testWhenUsed.
  ///
  /// In en, this message translates to:
  /// **'Test when used'**
  String get testWhenUsed;

  /// No description provided for @defaultSelected.
  ///
  /// In en, this message translates to:
  /// **'Default selection'**
  String get defaultSelected;

  /// No description provided for @hashByInUser.
  ///
  /// In en, this message translates to:
  /// **'Hash by inbound user'**
  String get hashByInUser;

  /// No description provided for @nodes.
  ///
  /// In en, this message translates to:
  /// **'Nodes'**
  String get nodes;

  /// No description provided for @addNodes.
  ///
  /// In en, this message translates to:
  /// **'Add nodes'**
  String get addNodes;

  /// No description provided for @autoInclude.
  ///
  /// In en, this message translates to:
  /// **'Auto-include'**
  String get autoInclude;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @inputProxyGroupName.
  ///
  /// In en, this message translates to:
  /// **'Enter the proxy group name'**
  String get inputProxyGroupName;

  /// No description provided for @definitionNotMap.
  ///
  /// In en, this message translates to:
  /// **'The configuration must be a YAML mapping with a name and a type'**
  String get definitionNotMap;

  /// No description provided for @additionalParameters.
  ///
  /// In en, this message translates to:
  /// **'Additional parameters'**
  String get additionalParameters;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get quickActions;

  /// No description provided for @ruleListInvalid.
  ///
  /// In en, this message translates to:
  /// **'The rules must be a YAML list with one rule per item, such as - DOMAIN,example.com,DIRECT'**
  String get ruleListInvalid;

  /// No description provided for @goToConfigureAddedRules.
  ///
  /// In en, this message translates to:
  /// **'Go to added rules configuration'**
  String get goToConfigureAddedRules;

  /// No description provided for @large.
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get large;

  /// No description provided for @extraLarge.
  ///
  /// In en, this message translates to:
  /// **'Extra large'**
  String get extraLarge;

  /// No description provided for @matchCase.
  ///
  /// In en, this message translates to:
  /// **'Match case'**
  String get matchCase;

  /// No description provided for @regex.
  ///
  /// In en, this message translates to:
  /// **'Regex'**
  String get regex;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @iconSets.
  ///
  /// In en, this message translates to:
  /// **'Icon sets'**
  String get iconSets;

  /// No description provided for @localImage.
  ///
  /// In en, this message translates to:
  /// **'Local image'**
  String get localImage;

  /// No description provided for @label.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get label;

  /// No description provided for @iconSetsEmptyTip.
  ///
  /// In en, this message translates to:
  /// **'No icon sets yet. Add them in Custom profile resources → Icon sets'**
  String get iconSetsEmptyTip;

  /// No description provided for @recommendedIcons.
  ///
  /// In en, this message translates to:
  /// **'Suggested'**
  String get recommendedIcons;

  /// No description provided for @customProfileResources.
  ///
  /// In en, this message translates to:
  /// **'Custom profile resources'**
  String get customProfileResources;

  /// No description provided for @importFromLink.
  ///
  /// In en, this message translates to:
  /// **'Import from link'**
  String get importFromLink;

  /// No description provided for @sendFromPhone.
  ///
  /// In en, this message translates to:
  /// **'Send from phone'**
  String get sendFromPhone;

  /// No description provided for @sendFromPhoneTip.
  ///
  /// In en, this message translates to:
  /// **'Scan the code with your phone\'s camera and paste the link on the page that opens. Both devices need to be on the same network.'**
  String get sendFromPhoneTip;

  /// No description provided for @sendFromPhoneNoNetwork.
  ///
  /// In en, this message translates to:
  /// **'This device is not connected to a local network'**
  String get sendFromPhoneNoNetwork;

  /// No description provided for @sendFromPhonePermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Receiving a link from your phone needs the Nearby devices permission, which lets FlClash reach the local network. Turn it on in the app\'s settings.'**
  String get sendFromPhonePermissionDenied;

  /// No description provided for @sendFromPhonePageTitle.
  ///
  /// In en, this message translates to:
  /// **'Send a link to FlClash'**
  String get sendFromPhonePageTitle;

  /// No description provided for @sendFromPhonePageHint.
  ///
  /// In en, this message translates to:
  /// **'Subscription link or proxy share link'**
  String get sendFromPhonePageHint;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @sendFromPhonePageSent.
  ///
  /// In en, this message translates to:
  /// **'Sent. Confirm the import on the other device.'**
  String get sendFromPhonePageSent;

  /// No description provided for @sendFromPhoneConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Import the link from your phone?'**
  String get sendFromPhoneConfirmTitle;

  /// No description provided for @shareQrcodeTip.
  ///
  /// In en, this message translates to:
  /// **'Scan with FlClash on another device to import this profile.'**
  String get shareQrcodeTip;

  /// No description provided for @qrcodeTooLongTip.
  ///
  /// In en, this message translates to:
  /// **'This link is too long for a QR code. Use Copy link instead.'**
  String get qrcodeTooLongTip;

  /// No description provided for @invalidLinkTip.
  ///
  /// In en, this message translates to:
  /// **'Not a subscription link or a proxy share link'**
  String get invalidLinkTip;

  /// No description provided for @batchLinkInputTip.
  ///
  /// In en, this message translates to:
  /// **'One link per line'**
  String get batchLinkInputTip;

  /// No description provided for @link.
  ///
  /// In en, this message translates to:
  /// **'Link'**
  String get link;

  /// No description provided for @allowedIps.
  ///
  /// In en, this message translates to:
  /// **'Allowed IPs'**
  String get allowedIps;

  /// No description provided for @cipher.
  ///
  /// In en, this message translates to:
  /// **'Cipher'**
  String get cipher;

  /// No description provided for @clientFingerprint.
  ///
  /// In en, this message translates to:
  /// **'Client fingerprint'**
  String get clientFingerprint;

  /// No description provided for @requestHeaders.
  ///
  /// In en, this message translates to:
  /// **'Request headers'**
  String get requestHeaders;

  /// No description provided for @transportHeaders.
  ///
  /// In en, this message translates to:
  /// **'{transport} Headers'**
  String transportHeaders(Object transport);

  /// No description provided for @congestionControl.
  ///
  /// In en, this message translates to:
  /// **'Congestion control'**
  String get congestionControl;

  /// No description provided for @downloadBandwidth.
  ///
  /// In en, this message translates to:
  /// **'Download bandwidth'**
  String get downloadBandwidth;

  /// No description provided for @hopInterval.
  ///
  /// In en, this message translates to:
  /// **'Hop interval'**
  String get hopInterval;

  /// No description provided for @obfs.
  ///
  /// In en, this message translates to:
  /// **'Obfuscation'**
  String get obfs;

  /// No description provided for @obfsHost.
  ///
  /// In en, this message translates to:
  /// **'Obfuscation host'**
  String get obfsHost;

  /// No description provided for @obfsMode.
  ///
  /// In en, this message translates to:
  /// **'Obfuscation mode'**
  String get obfsMode;

  /// No description provided for @obfsParam.
  ///
  /// In en, this message translates to:
  /// **'Obfuscation parameter'**
  String get obfsParam;

  /// No description provided for @obfsPassword.
  ///
  /// In en, this message translates to:
  /// **'Obfuscation password'**
  String get obfsPassword;

  /// No description provided for @plugin.
  ///
  /// In en, this message translates to:
  /// **'Plugin'**
  String get plugin;

  /// No description provided for @pluginHost.
  ///
  /// In en, this message translates to:
  /// **'Plugin host'**
  String get pluginHost;

  /// No description provided for @pluginPath.
  ///
  /// In en, this message translates to:
  /// **'Plugin path'**
  String get pluginPath;

  /// No description provided for @pluginUsername.
  ///
  /// In en, this message translates to:
  /// **'Plugin username'**
  String get pluginUsername;

  /// No description provided for @pluginPassword.
  ///
  /// In en, this message translates to:
  /// **'Plugin password'**
  String get pluginPassword;

  /// No description provided for @pluginCipher.
  ///
  /// In en, this message translates to:
  /// **'Plugin cipher'**
  String get pluginCipher;

  /// No description provided for @pluginMode.
  ///
  /// In en, this message translates to:
  /// **'Plugin mode'**
  String get pluginMode;

  /// No description provided for @portHopping.
  ///
  /// In en, this message translates to:
  /// **'Port hopping'**
  String get portHopping;

  /// No description provided for @preSharedKey.
  ///
  /// In en, this message translates to:
  /// **'Pre-shared key'**
  String get preSharedKey;

  /// No description provided for @privateKey.
  ///
  /// In en, this message translates to:
  /// **'Private key'**
  String get privateKey;

  /// No description provided for @privateKeyPassphrase.
  ///
  /// In en, this message translates to:
  /// **'Private key passphrase'**
  String get privateKeyPassphrase;

  /// No description provided for @protocolParam.
  ///
  /// In en, this message translates to:
  /// **'Protocol parameter'**
  String get protocolParam;

  /// No description provided for @protocolVersion.
  ///
  /// In en, this message translates to:
  /// **'Protocol version'**
  String get protocolVersion;

  /// No description provided for @publicKey.
  ///
  /// In en, this message translates to:
  /// **'Public key'**
  String get publicKey;

  /// No description provided for @remoteDnsResolve.
  ///
  /// In en, this message translates to:
  /// **'Remote DNS resolution'**
  String get remoteDnsResolve;

  /// No description provided for @secretKey.
  ///
  /// In en, this message translates to:
  /// **'Key'**
  String get secretKey;

  /// No description provided for @skipCertVerify.
  ///
  /// In en, this message translates to:
  /// **'Skip certificate verification'**
  String get skipCertVerify;

  /// No description provided for @transport.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get transport;

  /// No description provided for @udpRelayMode.
  ///
  /// In en, this message translates to:
  /// **'UDP relay mode'**
  String get udpRelayMode;

  /// No description provided for @uploadBandwidth.
  ///
  /// In en, this message translates to:
  /// **'Upload bandwidth'**
  String get uploadBandwidth;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @networkName.
  ///
  /// In en, this message translates to:
  /// **'Network name'**
  String get networkName;

  /// No description provided for @networkSecret.
  ///
  /// In en, this message translates to:
  /// **'Network secret'**
  String get networkSecret;

  /// No description provided for @peers.
  ///
  /// In en, this message translates to:
  /// **'Peers'**
  String get peers;

  /// No description provided for @virtualIpv4.
  ///
  /// In en, this message translates to:
  /// **'Virtual IPv4'**
  String get virtualIpv4;

  /// No description provided for @hostname.
  ///
  /// In en, this message translates to:
  /// **'Hostname'**
  String get hostname;

  /// No description provided for @exitNodes.
  ///
  /// In en, this message translates to:
  /// **'Exit nodes'**
  String get exitNodes;

  /// No description provided for @ageSecretKey.
  ///
  /// In en, this message translates to:
  /// **'Age secret key'**
  String get ageSecretKey;

  /// No description provided for @ageSecretKeyRequiredTip.
  ///
  /// In en, this message translates to:
  /// **'This profile is encrypted with age and needs an age secret key to decrypt'**
  String get ageSecretKeyRequiredTip;

  /// No description provided for @ageDecryptFailedTip.
  ///
  /// In en, this message translates to:
  /// **'Could not decrypt the profile. Check the age secret key and try again.'**
  String get ageDecryptFailedTip;

  /// No description provided for @resetDns.
  ///
  /// In en, this message translates to:
  /// **'Reset DNS'**
  String get resetDns;

  /// No description provided for @resetDnsSuccess.
  ///
  /// In en, this message translates to:
  /// **'DNS state cleared'**
  String get resetDnsSuccess;

  /// No description provided for @resetDnsFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not reset DNS. Check that the core is connected and try again.'**
  String get resetDnsFailed;

  /// No description provided for @resourceSizeLimitTip.
  ///
  /// In en, this message translates to:
  /// **'The resource exceeds {limit}'**
  String resourceSizeLimitTip(Object limit);

  /// No description provided for @ruleSetDetect.
  ///
  /// In en, this message translates to:
  /// **'Detect format and behavior'**
  String get ruleSetDetect;

  /// No description provided for @ruleSetConvert.
  ///
  /// In en, this message translates to:
  /// **'Convert to MRS'**
  String get ruleSetConvert;

  /// No description provided for @ruleSetConvertRemote.
  ///
  /// In en, this message translates to:
  /// **'Download as local MRS'**
  String get ruleSetConvertRemote;

  /// No description provided for @ruleSetEmptyTip.
  ///
  /// In en, this message translates to:
  /// **'The rule set has no usable entries'**
  String get ruleSetEmptyTip;

  /// No description provided for @ruleSetMixedTip.
  ///
  /// In en, this message translates to:
  /// **'The rule set mixes bare domains and IP ranges; use classical rules to combine them'**
  String get ruleSetMixedTip;

  /// No description provided for @ruleSetInvalidTip.
  ///
  /// In en, this message translates to:
  /// **'Unable to read this rule set. Check its format and entries'**
  String get ruleSetInvalidTip;

  /// No description provided for @ruleSetUnsupportedTip.
  ///
  /// In en, this message translates to:
  /// **'These rules cannot be converted to MRS without changing their behavior'**
  String get ruleSetUnsupportedTip;

  /// No description provided for @ruleSetBusyTip.
  ///
  /// In en, this message translates to:
  /// **'Another rule set operation is running. Try again shortly'**
  String get ruleSetBusyTip;

  /// No description provided for @ruleSetNeedsConversionTip.
  ///
  /// In en, this message translates to:
  /// **'This remote rule set needs normalization. Download it as local MRS to use it'**
  String get ruleSetNeedsConversionTip;

  /// No description provided for @ruleSetSizeTip.
  ///
  /// In en, this message translates to:
  /// **'The rule set exceeds the processing limit. Split it into smaller sets'**
  String get ruleSetSizeTip;

  /// No description provided for @providerLookupFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to read the active node configuration. Refresh the resource and try again.'**
  String get providerLookupFailed;

  /// No description provided for @lookupProxyConfig.
  ///
  /// In en, this message translates to:
  /// **'Find node configuration'**
  String get lookupProxyConfig;

  /// No description provided for @tunDnsMode.
  ///
  /// In en, this message translates to:
  /// **'System DNS mode'**
  String get tunDnsMode;

  /// No description provided for @tunDnsModeDesc.
  ///
  /// In en, this message translates to:
  /// **'Empty keeps the previous behavior. disabled leaves system DNS unchanged; native uses the TUN address; hijack also intercepts DNS on other interfaces (Windows requires strict-route; Linux requires auto-redirect). An explicit mode takes precedence over automatic system DNS on macOS.'**
  String get tunDnsModeDesc;

  /// No description provided for @nodeShareLinkUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This node cannot be represented by a share link; use fields or YAML'**
  String get nodeShareLinkUnavailable;

  /// No description provided for @shareLinkNodesPreserved.
  ///
  /// In en, this message translates to:
  /// **'{count} nodes cannot be represented by links and will be kept unchanged'**
  String shareLinkNodesPreserved(int count);

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @preferred.
  ///
  /// In en, this message translates to:
  /// **'Preferred'**
  String get preferred;

  /// No description provided for @addToLocalProxies.
  ///
  /// In en, this message translates to:
  /// **'Add to custom nodes'**
  String get addToLocalProxies;

  /// No description provided for @addedToLocalProxies.
  ///
  /// In en, this message translates to:
  /// **'Added {name} to custom nodes'**
  String addedToLocalProxies(Object name);

  /// No description provided for @alreadyInLocalProxies.
  ///
  /// In en, this message translates to:
  /// **'{name} is already in custom nodes'**
  String alreadyInLocalProxies(Object name);

  /// No description provided for @generalOverrideDesc.
  ///
  /// In en, this message translates to:
  /// **'Entries added here replace the setting of every profile; anything not added keeps the profile\'s own setting, or the core default when the profile has none.'**
  String get generalOverrideDesc;

  /// No description provided for @groupBy.
  ///
  /// In en, this message translates to:
  /// **'Group by'**
  String get groupBy;

  /// No description provided for @copyHost.
  ///
  /// In en, this message translates to:
  /// **'Copy host'**
  String get copyHost;

  /// No description provided for @copyDestination.
  ///
  /// In en, this message translates to:
  /// **'Copy destination'**
  String get copyDestination;

  /// No description provided for @closeConnection.
  ///
  /// In en, this message translates to:
  /// **'Close connection'**
  String get closeConnection;

  /// No description provided for @recentRequests.
  ///
  /// In en, this message translates to:
  /// **'Recent requests'**
  String get recentRequests;

  /// No description provided for @root.
  ///
  /// In en, this message translates to:
  /// **'Root'**
  String get root;

  /// No description provided for @mitm.
  ///
  /// In en, this message translates to:
  /// **'MITM'**
  String get mitm;

  /// No description provided for @httpsDecryption.
  ///
  /// In en, this message translates to:
  /// **'HTTPS decryption'**
  String get httpsDecryption;

  /// No description provided for @httpCapture.
  ///
  /// In en, this message translates to:
  /// **'HTTP capture'**
  String get httpCapture;

  /// No description provided for @httpCaptureDesc.
  ///
  /// In en, this message translates to:
  /// **'Records requests to the hosts listed under Hostname, to view in connection details. Records stay in memory only.'**
  String get httpCaptureDesc;

  /// No description provided for @httpCaptureNoHosts.
  ///
  /// In en, this message translates to:
  /// **'No host is listed, so nothing is recorded. Add hosts under Hostname on the MITM page, or from the details of a connection.'**
  String get httpCaptureNoHosts;

  /// No description provided for @httpCaptureLimit.
  ///
  /// In en, this message translates to:
  /// **'Maximum records'**
  String get httpCaptureLimit;

  /// No description provided for @httpCaptureLimitDesc.
  ///
  /// In en, this message translates to:
  /// **'The oldest records go first once this many are kept or they fill {memory} of memory. Each body keeps its first {body}.'**
  String httpCaptureLimitDesc(Object memory, Object body);

  /// No description provided for @httpRequests.
  ///
  /// In en, this message translates to:
  /// **'HTTP requests'**
  String get httpRequests;

  /// No description provided for @httpRequestsMissing.
  ///
  /// In en, this message translates to:
  /// **'Requests made before capture was on, or since cleared, are not listed.'**
  String get httpRequestsMissing;

  /// No description provided for @httpRequestCleared.
  ///
  /// In en, this message translates to:
  /// **'This request is no longer kept'**
  String get httpRequestCleared;

  /// No description provided for @httpCaptureOff.
  ///
  /// In en, this message translates to:
  /// **'Capture is off'**
  String get httpCaptureOff;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get inProgress;

  /// No description provided for @method.
  ///
  /// In en, this message translates to:
  /// **'Method'**
  String get method;

  /// No description provided for @originalUrl.
  ///
  /// In en, this message translates to:
  /// **'Original URL'**
  String get originalUrl;

  /// No description provided for @timeToFirstByte.
  ///
  /// In en, this message translates to:
  /// **'Time to first byte'**
  String get timeToFirstByte;

  /// No description provided for @requestBody.
  ///
  /// In en, this message translates to:
  /// **'Request body'**
  String get requestBody;

  /// No description provided for @response.
  ///
  /// In en, this message translates to:
  /// **'Response'**
  String get response;

  /// No description provided for @responseBody.
  ///
  /// In en, this message translates to:
  /// **'Response body'**
  String get responseBody;

  /// No description provided for @responseHeaders.
  ///
  /// In en, this message translates to:
  /// **'Response headers'**
  String get responseHeaders;

  /// No description provided for @matchedRules.
  ///
  /// In en, this message translates to:
  /// **'Matched rules'**
  String get matchedRules;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @copyAsBase64.
  ///
  /// In en, this message translates to:
  /// **'Copy as Base64'**
  String get copyAsBase64;

  /// No description provided for @copyAsCurl.
  ///
  /// In en, this message translates to:
  /// **'Copy as cURL'**
  String get copyAsCurl;

  /// No description provided for @copyRequest.
  ///
  /// In en, this message translates to:
  /// **'Copy request'**
  String get copyRequest;

  /// No description provided for @copyResponse.
  ///
  /// In en, this message translates to:
  /// **'Copy response'**
  String get copyResponse;

  /// No description provided for @copyResponseBody.
  ///
  /// In en, this message translates to:
  /// **'Copy response body'**
  String get copyResponseBody;

  /// No description provided for @httpBodyProtobufGuess.
  ///
  /// In en, this message translates to:
  /// **'Read as Protobuf without its schema: field numbers only, and the types are guesses.'**
  String get httpBodyProtobufGuess;

  /// No description provided for @exportHar.
  ///
  /// In en, this message translates to:
  /// **'Export HAR'**
  String get exportHar;

  /// No description provided for @mitmAddRejectRule.
  ///
  /// In en, this message translates to:
  /// **'Add a reject rule'**
  String get mitmAddRejectRule;

  /// No description provided for @mitmAddMapLocalRule.
  ///
  /// In en, this message translates to:
  /// **'Add a map local rule'**
  String get mitmAddMapLocalRule;

  /// No description provided for @httpExportPrivateTitle.
  ///
  /// In en, this message translates to:
  /// **'Contains private data'**
  String get httpExportPrivateTitle;

  /// No description provided for @httpExportPrivate.
  ///
  /// In en, this message translates to:
  /// **'A request can carry cookies, tokens, passwords and form contents. Check what you share, and with whom.'**
  String get httpExportPrivate;

  /// No description provided for @mitmRuleCopiedForStash.
  ///
  /// In en, this message translates to:
  /// **'This module is a Stash override, so the rule was copied for you to add by hand.'**
  String get mitmRuleCopiedForStash;

  /// No description provided for @binaryData.
  ///
  /// In en, this message translates to:
  /// **'Binary data'**
  String get binaryData;

  /// No description provided for @httpBodyNotKept.
  ///
  /// In en, this message translates to:
  /// **'Not recorded while memory was short.'**
  String get httpBodyNotKept;

  /// No description provided for @httpBodyTruncated.
  ///
  /// In en, this message translates to:
  /// **'Only the start of this body was recorded.'**
  String get httpBodyTruncated;

  /// No description provided for @httpBodyUndecoded.
  ///
  /// In en, this message translates to:
  /// **'Could not decode {encoding}, so this is the data as it was sent.'**
  String httpBodyUndecoded(Object encoding);

  /// No description provided for @mitmEnableTip.
  ///
  /// In en, this message translates to:
  /// **'FlClash will be able to read everything sent to the decrypted hosts, cookies and passwords included. Turn this on only for hosts you mean to rewrite.'**
  String get mitmEnableTip;

  /// No description provided for @certificate.
  ///
  /// In en, this message translates to:
  /// **'Certificate'**
  String get certificate;

  /// No description provided for @generateCertificate.
  ///
  /// In en, this message translates to:
  /// **'Generate certificate'**
  String get generateCertificate;

  /// No description provided for @regenerateCertificate.
  ///
  /// In en, this message translates to:
  /// **'Regenerate certificate'**
  String get regenerateCertificate;

  /// No description provided for @regenerateCertificateTip.
  ///
  /// In en, this message translates to:
  /// **'The new certificate replaces the current one, which FlClash takes out of this device\'s trusted roots where it can. Every other device that trusts the current one has to install the new one.'**
  String get regenerateCertificateTip;

  /// No description provided for @exportCertificate.
  ///
  /// In en, this message translates to:
  /// **'Export certificate'**
  String get exportCertificate;

  /// No description provided for @installCertificate.
  ///
  /// In en, this message translates to:
  /// **'Install to system'**
  String get installCertificate;

  /// No description provided for @installCertificateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Certificate installed'**
  String get installCertificateSuccess;

  /// No description provided for @validUntil.
  ///
  /// In en, this message translates to:
  /// **'Valid until {date}'**
  String validUntil(Object date);

  /// No description provided for @mitmCertificateExportTip.
  ///
  /// In en, this message translates to:
  /// **'Export it and trust it on the devices you want to decrypt.'**
  String get mitmCertificateExportTip;

  /// No description provided for @mitmTrustReady.
  ///
  /// In en, this message translates to:
  /// **'Trusted'**
  String get mitmTrustReady;

  /// No description provided for @mitmTrustUntrusted.
  ///
  /// In en, this message translates to:
  /// **'Not fully trusted'**
  String get mitmTrustUntrusted;

  /// No description provided for @mitmTrustNotInstalled.
  ///
  /// In en, this message translates to:
  /// **'Not installed'**
  String get mitmTrustNotInstalled;

  /// No description provided for @mitmTrustChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking…'**
  String get mitmTrustChecking;

  /// No description provided for @trustCertificate.
  ///
  /// In en, this message translates to:
  /// **'Trust certificate'**
  String get trustCertificate;

  /// No description provided for @mitmCertificateAndroidReadyTip.
  ///
  /// In en, this message translates to:
  /// **'Only apps that trust user certificates, mostly browsers, are decrypted.'**
  String get mitmCertificateAndroidReadyTip;

  /// No description provided for @mitmCertificateLinuxTip.
  ///
  /// In en, this message translates to:
  /// **'Flatpak browsers need the exported certificate imported by hand.'**
  String get mitmCertificateLinuxTip;

  /// No description provided for @mitmCertutilMissing.
  ///
  /// In en, this message translates to:
  /// **'Chrome and Firefox keep their own certificate stores, which need certutil: {command}'**
  String mitmCertutilMissing(Object command);

  /// No description provided for @mitmMissingStores.
  ///
  /// In en, this message translates to:
  /// **'Not yet in: {stores}'**
  String mitmMissingStores(Object stores);

  /// No description provided for @mitmSystemStoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Adding the certificate to the system\'s trusted roots failed'**
  String get mitmSystemStoreFailed;

  /// No description provided for @mitmRootUntilReboot.
  ///
  /// In en, this message translates to:
  /// **'No Magisk, KernelSU or APatch was found to keep the certificate. Install it again after the device restarts.'**
  String get mitmRootUntilReboot;

  /// No description provided for @mitmRootPendingReboot.
  ///
  /// In en, this message translates to:
  /// **'The certificate takes effect after the device restarts.'**
  String get mitmRootPendingReboot;

  /// No description provided for @mitmInstallSystemCaTip.
  ///
  /// In en, this message translates to:
  /// **'Root was found, so the certificate goes into the system\'s trusted certificates as a FlClash MITM CA module for Magisk, KernelSU or APatch. Every app on this device will then trust it, and anyone holding its private key could decrypt this device\'s HTTPS traffic. To undo it, regenerate the certificate or remove the module in the root manager and restart. If root is denied, it is installed as a user certificate instead.'**
  String get mitmInstallSystemCaTip;

  /// No description provided for @mitmInstallUserCaTip.
  ///
  /// In en, this message translates to:
  /// **'No root was found, so the certificate can only be installed as a user certificate. Only apps that trust user certificates, mostly browsers, are decrypted; other apps fail on the hosts you list, so leave those hosts out. On Android 11 and later you finish the install yourself in system settings.'**
  String get mitmInstallUserCaTip;

  /// No description provided for @mitmCertificateSavedTip.
  ///
  /// In en, this message translates to:
  /// **'Saved {fileName} to Downloads. Install it in Settings under Security › Encryption & credentials › Install a certificate › CA certificate.'**
  String mitmCertificateSavedTip(Object fileName);

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get openSettings;

  /// No description provided for @mitmRemoveOldCertificateTip.
  ///
  /// In en, this message translates to:
  /// **'Remove the old certificate, {name}, in Settings under Security › Encryption & credentials › Trusted credentials › User, then install the new one.'**
  String mitmRemoveOldCertificateTip(Object name);

  /// No description provided for @mitmOldCertificateLeftTip.
  ///
  /// In en, this message translates to:
  /// **'The old certificate, {name}, could not be removed. Remove it from the trusted roots yourself.'**
  String mitmOldCertificateLeftTip(Object name);

  /// No description provided for @mitmOldSystemCertificateLeftTip.
  ///
  /// In en, this message translates to:
  /// **'The old certificate, {name}, is still among the system\'s trusted CAs. Allow FlClash root access in your root manager and regenerate, or remove the FlClash MITM CA module there and restart.'**
  String mitmOldSystemCertificateLeftTip(Object name);

  /// No description provided for @mitmDecryptHost.
  ///
  /// In en, this message translates to:
  /// **'Decrypt this host'**
  String get mitmDecryptHost;

  /// No description provided for @mitmDecryptHostTip.
  ///
  /// In en, this message translates to:
  /// **'Add {host} to the hostname list? FlClash can then read what is sent to it, cookies and passwords included.'**
  String mitmDecryptHostTip(Object host);

  /// No description provided for @mitmClientRefusedCertificate.
  ///
  /// In en, this message translates to:
  /// **'The client refused the certificate. Install the CA, or exclude this host if the app pins its certificate.'**
  String get mitmClientRefusedCertificate;

  /// No description provided for @mitmExcludeHost.
  ///
  /// In en, this message translates to:
  /// **'Exclude from decryption'**
  String get mitmExcludeHost;

  /// No description provided for @mitmExcludeHostTip.
  ///
  /// In en, this message translates to:
  /// **'Add -{host} to the top of the hostname list? The host is then never decrypted.'**
  String mitmExcludeHostTip(Object host);

  /// No description provided for @urlRewrite.
  ///
  /// In en, this message translates to:
  /// **'URL rewrite'**
  String get urlRewrite;

  /// No description provided for @headerRewrite.
  ///
  /// In en, this message translates to:
  /// **'Header rewrite'**
  String get headerRewrite;

  /// No description provided for @bodyRewrite.
  ///
  /// In en, this message translates to:
  /// **'Body rewrite'**
  String get bodyRewrite;

  /// No description provided for @mapLocal.
  ///
  /// In en, this message translates to:
  /// **'Map local'**
  String get mapLocal;

  /// No description provided for @mitmHostnameDesc.
  ///
  /// In en, this message translates to:
  /// **'A leading - excludes a host, and the first match decides.'**
  String get mitmHostnameDesc;

  /// No description provided for @mitmModules.
  ///
  /// In en, this message translates to:
  /// **'Modules'**
  String get mitmModules;

  /// No description provided for @mitmModule.
  ///
  /// In en, this message translates to:
  /// **'Module'**
  String get mitmModule;

  /// No description provided for @mitmModuleInvalid.
  ///
  /// In en, this message translates to:
  /// **'This is not a Surge module, a Loon plugin, a Quantumult X snippet or a Stash override'**
  String get mitmModuleInvalid;

  /// No description provided for @arguments.
  ///
  /// In en, this message translates to:
  /// **'Arguments'**
  String get arguments;

  /// No description provided for @mitmRoutingRules.
  ///
  /// In en, this message translates to:
  /// **'Routing rules'**
  String get mitmRoutingRules;

  /// No description provided for @mitmIgnoredLines.
  ///
  /// In en, this message translates to:
  /// **'Ignored lines'**
  String get mitmIgnoredLines;

  /// No description provided for @mitmModuleRulesDesc.
  ///
  /// In en, this message translates to:
  /// **'Routing rules go in front of the profile’s own.'**
  String get mitmModuleRulesDesc;

  /// No description provided for @mitmModuleSystemTip.
  ///
  /// In en, this message translates to:
  /// **'Written for {system}; some lines may not match apps on this device.'**
  String mitmModuleSystemTip(Object system);

  /// No description provided for @mitmSkipSection.
  ///
  /// In en, this message translates to:
  /// **'The [{section}] section is not supported'**
  String mitmSkipSection(Object section);

  /// No description provided for @mitmSkipSetting.
  ///
  /// In en, this message translates to:
  /// **'This setting is not supported'**
  String get mitmSkipSetting;

  /// No description provided for @mitmSkipScriptType.
  ///
  /// In en, this message translates to:
  /// **'This script type is not supported'**
  String get mitmSkipScriptType;

  /// No description provided for @mitmSkipRule.
  ///
  /// In en, this message translates to:
  /// **'This rule type is not supported'**
  String get mitmSkipRule;

  /// No description provided for @mitmSkipPolicy.
  ///
  /// In en, this message translates to:
  /// **'Only the DIRECT and REJECT policies are supported'**
  String get mitmSkipPolicy;

  /// No description provided for @mitmSkipJq.
  ///
  /// In en, this message translates to:
  /// **'jq rewrites are not supported'**
  String get mitmSkipJq;

  /// No description provided for @mitmSkipJsonBody.
  ///
  /// In en, this message translates to:
  /// **'JSON body rewrites are not supported'**
  String get mitmSkipJsonBody;

  /// No description provided for @mitmSkipRawHeader.
  ///
  /// In en, this message translates to:
  /// **'Rewriting all headers as one text is not supported'**
  String get mitmSkipRawHeader;

  /// No description provided for @mitmSkipConditional.
  ///
  /// In en, this message translates to:
  /// **'Conditional rewrites are not supported'**
  String get mitmSkipConditional;

  /// No description provided for @mitmSkipRelativeData.
  ///
  /// In en, this message translates to:
  /// **'The file this line names is not attached; use a URL or attach it'**
  String get mitmSkipRelativeData;

  /// No description provided for @mitmSkipNotDownloaded.
  ///
  /// In en, this message translates to:
  /// **'Its file has not been downloaded'**
  String get mitmSkipNotDownloaded;

  /// No description provided for @mitmSkipUnreadable.
  ///
  /// In en, this message translates to:
  /// **'This line cannot be read'**
  String get mitmSkipUnreadable;

  /// No description provided for @mitmAddLocalFile.
  ///
  /// In en, this message translates to:
  /// **'Add a local file'**
  String get mitmAddLocalFile;

  /// No description provided for @mitmNewModule.
  ///
  /// In en, this message translates to:
  /// **'New module'**
  String get mitmNewModule;

  /// No description provided for @mitmAttachments.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get mitmAttachments;

  /// No description provided for @mitmAttachmentsDesc.
  ///
  /// In en, this message translates to:
  /// **'Lines refer to attachments by file name, as in script-path=a.js.'**
  String get mitmAttachmentsDesc;

  /// No description provided for @mitmFileTooLarge.
  ///
  /// In en, this message translates to:
  /// **'The file is larger than {size} MB'**
  String mitmFileTooLarge(Object size);

  /// No description provided for @mitmSkipDisabled.
  ///
  /// In en, this message translates to:
  /// **'Turned off by an argument'**
  String get mitmSkipDisabled;

  /// No description provided for @mitmSkipEvent.
  ///
  /// In en, this message translates to:
  /// **'This event is not supported'**
  String get mitmSkipEvent;

  /// No description provided for @mitmRunScript.
  ///
  /// In en, this message translates to:
  /// **'Run now'**
  String get mitmRunScript;

  /// No description provided for @mitmScriptNoOutput.
  ///
  /// In en, this message translates to:
  /// **'The script finished without output'**
  String get mitmScriptNoOutput;

  /// No description provided for @mitmScriptRiskTitle.
  ///
  /// In en, this message translates to:
  /// **'Run this module\'s scripts?'**
  String get mitmScriptRiskTitle;

  /// No description provided for @mitmScriptRisk.
  ///
  /// In en, this message translates to:
  /// **'Its scripts read and change the traffic of the hosts they match, cookies and tokens included, and can send requests of their own. Turn it on only if you trust where it comes from.'**
  String get mitmScriptRisk;

  /// No description provided for @skipServerCertVerify.
  ///
  /// In en, this message translates to:
  /// **'Skip server certificate verification'**
  String get skipServerCertVerify;

  /// No description provided for @http2.
  ///
  /// In en, this message translates to:
  /// **'HTTP/2'**
  String get http2;

  /// No description provided for @decryptUntrusted.
  ///
  /// In en, this message translates to:
  /// **'Decrypt without local trust'**
  String get decryptUntrusted;

  /// No description provided for @invalidOfCount.
  ///
  /// In en, this message translates to:
  /// **'{invalid} of {total} invalid'**
  String invalidOfCount(Object invalid, Object total);

  /// No description provided for @mitmModuleScriptsChanged.
  ///
  /// In en, this message translates to:
  /// **'{name} changed its scripts and was turned off'**
  String mitmModuleScriptsChanged(Object name);

  /// No description provided for @failedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} items failed. Tap to view'**
  String failedCount(Object count);

  /// No description provided for @proxyServerNameserverDesc.
  ///
  /// In en, this message translates to:
  /// **'Resolves proxy server hostnames only.'**
  String get proxyServerNameserverDesc;

  /// No description provided for @proxyServerNameserverPolicyDesc.
  ///
  /// In en, this message translates to:
  /// **'Matching proxy server hostnames use the DNS server given here instead of Proxy Server Nameserver.'**
  String get proxyServerNameserverPolicyDesc;

  /// No description provided for @directNameserverDesc.
  ///
  /// In en, this message translates to:
  /// **'Resolves domains for connections that go direct.'**
  String get directNameserverDesc;

  /// No description provided for @fakeipFilterDesc.
  ///
  /// In en, this message translates to:
  /// **'These domains get real IPs instead of Fake-IPs. In whitelist mode, only they get Fake-IPs.'**
  String get fakeipFilterDesc;

  /// No description provided for @fallbackFilterGeositeDesc.
  ///
  /// In en, this message translates to:
  /// **'Domains in these GeoSite categories are resolved by Fallback directly.'**
  String get fallbackFilterGeositeDesc;

  /// No description provided for @fallbackFilterIpcidrDesc.
  ///
  /// In en, this message translates to:
  /// **'When Nameserver returns an IP in these ranges, the Fallback answer is used.'**
  String get fallbackFilterIpcidrDesc;

  /// No description provided for @fallbackFilterDomainDesc.
  ///
  /// In en, this message translates to:
  /// **'These domains are resolved by Fallback directly.'**
  String get fallbackFilterDomainDesc;

  /// No description provided for @customResources.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get customResources;

  /// No description provided for @proxyYieldsToSubscription.
  ///
  /// In en, this message translates to:
  /// **'A subscription node has this name, so this profile uses that one'**
  String get proxyYieldsToSubscription;

  /// No description provided for @delayMeasurementUnknown.
  ///
  /// In en, this message translates to:
  /// **'Measurement time unavailable'**
  String get delayMeasurementUnknown;

  /// No description provided for @delayMeasuredAt.
  ///
  /// In en, this message translates to:
  /// **'Last tested: {time}'**
  String delayMeasuredAt(String time);

  /// No description provided for @delayMeasurementStale.
  ///
  /// In en, this message translates to:
  /// **'Old result; test again'**
  String get delayMeasurementStale;

  /// No description provided for @diagUdp.
  ///
  /// In en, this message translates to:
  /// **'UDP connectivity'**
  String get diagUdp;

  /// No description provided for @diagUdpReady.
  ///
  /// In en, this message translates to:
  /// **'A UDP round trip succeeded'**
  String get diagUdpReady;

  /// No description provided for @diagUdpUnknown.
  ///
  /// In en, this message translates to:
  /// **'UDP connectivity could not be confirmed'**
  String get diagUdpUnknown;

  /// No description provided for @diagUdpUnsupported.
  ///
  /// In en, this message translates to:
  /// **'This route does not support UDP'**
  String get diagUdpUnsupported;

  /// No description provided for @diagUdpHint.
  ///
  /// In en, this message translates to:
  /// **'Tests follow the current routing rules. A timeout may be caused by the test server or network; it does not prove all UDP traffic is blocked.'**
  String get diagUdpHint;

  /// No description provided for @diagTimeline.
  ///
  /// In en, this message translates to:
  /// **'Recent operation history'**
  String get diagTimeline;

  /// No description provided for @diagTimelineEvent.
  ///
  /// In en, this message translates to:
  /// **'{time} · {stage} · {result} {code}'**
  String diagTimelineEvent(
    String time,
    String stage,
    String result,
    String code,
  );

  /// No description provided for @diagStageFetch.
  ///
  /// In en, this message translates to:
  /// **'Fetch configuration'**
  String get diagStageFetch;

  /// No description provided for @diagStageValidate.
  ///
  /// In en, this message translates to:
  /// **'Validate configuration'**
  String get diagStageValidate;

  /// No description provided for @diagStageApply.
  ///
  /// In en, this message translates to:
  /// **'Apply configuration'**
  String get diagStageApply;

  /// No description provided for @diagStageStart.
  ///
  /// In en, this message translates to:
  /// **'Start VPN'**
  String get diagStageStart;

  /// No description provided for @diagStageStop.
  ///
  /// In en, this message translates to:
  /// **'Stop VPN'**
  String get diagStageStop;

  /// No description provided for @diagEventStarted.
  ///
  /// In en, this message translates to:
  /// **'Started'**
  String get diagEventStarted;

  /// No description provided for @diagEventSucceeded.
  ///
  /// In en, this message translates to:
  /// **'Succeeded'**
  String get diagEventSucceeded;

  /// No description provided for @diagEventFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get diagEventFailed;

  /// No description provided for @diagEventUnchanged.
  ///
  /// In en, this message translates to:
  /// **'Content unchanged'**
  String get diagEventUnchanged;

  /// No description provided for @diagEventCanceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get diagEventCanceled;

  /// No description provided for @diagRecorded.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get diagRecorded;

  /// No description provided for @mixedPortReset.
  ///
  /// In en, this message translates to:
  /// **'The mixed port cannot be {value}, so it was set back to {port}'**
  String mixedPortReset(Object value, Object port);

  /// No description provided for @coreStoppedDesc.
  ///
  /// In en, this message translates to:
  /// **'The app lost its connection to the core'**
  String get coreStoppedDesc;

  /// No description provided for @coreStoppedWithReason.
  ///
  /// In en, this message translates to:
  /// **'The app lost its connection to the core: {reason}'**
  String coreStoppedWithReason(Object reason);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'en',
    'es',
    'fr',
    'ja',
    'ko',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

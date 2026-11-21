// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get applyNow => 'Apply now';

  @override
  String get rule => 'Rule';

  @override
  String get global => 'Global';

  @override
  String get direct => 'Direct';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get proxies => 'Proxies';

  @override
  String get profile => 'Profile';

  @override
  String get profiles => 'Profiles';

  @override
  String get tools => 'Tools';

  @override
  String get logs => 'Logs';

  @override
  String get logsDesc => 'Log capture records';

  @override
  String get resources => 'Resources';

  @override
  String get resourcesDesc => 'External resource related info';

  @override
  String get trafficUsage => 'Traffic usage';

  @override
  String get networkSpeed => 'Network speed';

  @override
  String get outboundMode => 'Outbound mode';

  @override
  String get networkDetection => 'Network detection';

  @override
  String get upload => 'Upload';

  @override
  String get download => 'Download';

  @override
  String get noProxy => 'No proxy';

  @override
  String get nullProfileDesc => 'No profile, Please add a profile';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get defaultText => 'Default';

  @override
  String get more => 'More';

  @override
  String get other => 'Other';

  @override
  String get about => 'About';

  @override
  String get en => 'English';

  @override
  String get ja => 'Japanese';

  @override
  String get ru => 'Russian';

  @override
  String get fr => 'French';

  @override
  String get es => 'Spanish';

  @override
  String get ko => 'Korean';

  @override
  String get zh_CN => 'Simplified Chinese';

  @override
  String get theme => 'Theme';

  @override
  String get themeDesc => 'Set dark mode,adjust the color';

  @override
  String get overrideLabel => 'Override';

  @override
  String get allowLan => 'Allow LAN';

  @override
  String get tun => 'TUN';

  @override
  String get tunDesc => 'TUN works only in administrator mode';

  @override
  String get minimizeOnExit => 'Minimize on exit';

  @override
  String get autoLaunch => 'Auto launch';

  @override
  String get silentLaunch => 'Silent launch';

  @override
  String get silentLaunchDesc => 'Start in the background';

  @override
  String get autoRun => 'Auto run';

  @override
  String get autoRunDesc => 'Auto run when the application is opened';

  @override
  String get logcat => 'Logcat';

  @override
  String get logcatDesc => 'Disabling will hide the log entry';

  @override
  String get accessControl => 'AccessControl';

  @override
  String get accessControlDesc => 'Configure application access proxy';

  @override
  String get application => 'Application';

  @override
  String get edit => 'Edit';

  @override
  String get confirm => 'Confirm';

  @override
  String get update => 'Update';

  @override
  String get add => 'Add';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get hours => 'Hours';

  @override
  String get seconds => 'Seconds';

  @override
  String get qrcode => 'QR code';

  @override
  String get qrcodeDesc => 'Scan QR code to obtain profile';

  @override
  String get url => 'URL';

  @override
  String get file => 'File';

  @override
  String get name => 'Name';

  @override
  String get profileNameNullValidationDesc => 'Please input the profile name';

  @override
  String get profileUrlNullValidationDesc => 'Please input the profile URL';

  @override
  String get profileUrlInvalidValidationDesc =>
      'Please input a valid profile URL';

  @override
  String get autoUpdate => 'Auto update';

  @override
  String get autoUpdateInterval => 'Auto update interval';

  @override
  String get profileAutoUpdateIntervalNullValidationDesc =>
      'Please enter the auto update interval time';

  @override
  String get profileAutoUpdateIntervalInvalidValidationDesc =>
      'Please input a valid interval time format';

  @override
  String get themeMode => 'Theme mode';

  @override
  String get themeColor => 'Theme color';

  @override
  String get preview => 'Preview';

  @override
  String get auto => 'Auto';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get submit => 'Submit';

  @override
  String createProfileFromUrlTip(Object url) {
    return 'Do you want to create a profile from $url?';
  }

  @override
  String get create => 'Create';

  @override
  String get pleaseUploadValidQrcode => 'Please upload a valid QR code';

  @override
  String get blacklistMode => 'Blacklist mode';

  @override
  String get whitelistMode => 'Whitelist mode';

  @override
  String get selectAll => 'Select all';

  @override
  String get cancelSelectAll => 'Cancel select all';

  @override
  String get appAccessControl => 'App access control';

  @override
  String get accessControlAllowDesc => 'Only selected apps go through the VPN';

  @override
  String get accessControlNotAllowDesc =>
      'Selected apps are excluded from the VPN';

  @override
  String get accessControlDisabledDesc => 'App access control is disabled';

  @override
  String accessControlSelectedCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count selected',
    );
    return '$_temp0';
  }

  @override
  String get profileParseErrorDesc => 'Profile parse error';

  @override
  String get proxyPort => 'ProxyPort';

  @override
  String get port => 'Port';

  @override
  String get logLevel => 'Log level';

  @override
  String get show => 'Show';

  @override
  String get hide => 'Hide';

  @override
  String get exit => 'Exit';

  @override
  String get systemProxy => 'System proxy';

  @override
  String get custom => 'Custom';

  @override
  String get project => 'Project';

  @override
  String get core => 'Core';

  @override
  String get reverseEngineeringNotice =>
      'Reverse engineering, decompilation, disassembly, or AI-assisted analysis of this application is strictly prohibited.';

  @override
  String get tabAnimation => 'Tab animation';

  @override
  String get desc =>
      'A multi-platform proxy client based on ClashMeta, simple and easy to use, open-source and ad-free.';

  @override
  String get startVpn => 'Starting VPN...';

  @override
  String get stopVpn => 'Stopping VPN...';

  @override
  String get discovery => 'Discovery a new version';

  @override
  String get compatible => 'Compatibility mode';

  @override
  String get notSelectedTip => 'The current proxy group cannot be selected.';

  @override
  String get tip => 'tip';

  @override
  String get account => 'Account';

  @override
  String get backup => 'Backup';

  @override
  String get backupSuccess => 'Backup success';

  @override
  String get noInfo => 'No info';

  @override
  String get pleaseBindWebDAV => 'Please bind WebDAV';

  @override
  String get bind => 'Bind';

  @override
  String get connectivity => 'Connectivity：';

  @override
  String get webDAVConfiguration => 'WebDAV configuration';

  @override
  String get address => 'Address';

  @override
  String get addressHelp => 'WebDAV server address';

  @override
  String get addressTip => 'Please enter a valid WebDAV address';

  @override
  String get password => 'Password';

  @override
  String get checkUpdate => 'Check for updates';

  @override
  String get checkUpdateError =>
      'The current application is already the latest version';

  @override
  String get checkUpdateFailed =>
      'Failed to check for updates. Please check your network and try again';

  @override
  String get unknown => 'Unknown';

  @override
  String get search => 'Search';

  @override
  String get allowBypass => 'Allow apps to bypass VPN';

  @override
  String get externalController => 'External controller';

  @override
  String get externalControllerDesc =>
      'The external controller lets you control the core on the configured address';

  @override
  String get openDashboard => 'Open dashboard';

  @override
  String get ipv6Desc => 'IPv6 traffic is received only while IPv6 is on';

  @override
  String get autoIpv6 => 'Auto IPv6';

  @override
  String get autoIpv6Desc =>
      'Auto IPv6 turns IPv6 on or off by whether the local network supports it';

  @override
  String get app => 'App';

  @override
  String get unifiedDelay => 'Unified delay';

  @override
  String get tcpConcurrent => 'TCP concurrent';

  @override
  String get geodataLoader => 'Geo low-memory mode';

  @override
  String get requests => 'Requests';

  @override
  String get requestsDesc => 'View recent requests and live connections';

  @override
  String get findProcessMode => 'Find process';

  @override
  String get init => 'Init';

  @override
  String get infiniteTime => 'Long term effective';

  @override
  String get connections => 'Connections';

  @override
  String get intranetIP => 'Intranet IP';

  @override
  String get view => 'View';

  @override
  String get cut => 'Cut';

  @override
  String get copy => 'Copy';

  @override
  String get paste => 'Paste';

  @override
  String get userAgent => 'User-Agent';

  @override
  String get testUrl => 'Test URL';

  @override
  String get delayTestTimeout => 'Delay test timeout';

  @override
  String get sync => 'Sync';

  @override
  String get exclude => 'Hide from recent tasks';

  @override
  String get compact => 'Compact';

  @override
  String get filter => 'Filter';

  @override
  String get tab => 'Tab';

  @override
  String get list => 'List';

  @override
  String get delay => 'Delay';

  @override
  String get style => 'Style';

  @override
  String get size => 'Size';

  @override
  String get sort => 'Sort';

  @override
  String get columns => 'Columns';

  @override
  String get proxyGroup => 'Proxy group';

  @override
  String get go => 'Go';

  @override
  String get externalLink => 'External link';

  @override
  String get autoCloseConnections => 'Auto close connections';

  @override
  String get autoCloseConnectionsDesc =>
      'After switching nodes, close all connections or only those passing through the changed proxy group, including nested groups';

  @override
  String get connectionCloseScope => 'Connection closing scope';

  @override
  String get closeCurrentGroupConnections => 'Only the current proxy group';

  @override
  String get onlyStatisticsProxy => 'Only count proxy traffic';

  @override
  String get pureBlackMode => 'Pure black mode';

  @override
  String get keepAliveIntervalDesc => 'TCP keep-alive interval';

  @override
  String get entries => ' entries';

  @override
  String secondsCount(Object count) {
    return '$count seconds';
  }

  @override
  String itemsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String get geoAutoUpdate => 'Auto Update';

  @override
  String get geoAutoUpdateInterval => 'Auto Update Interval';

  @override
  String get geoAutoUpdateIntervalTip =>
      'Auto update interval must be between 1 and 8760 hours';

  @override
  String get geoResources => 'Geo Resources';

  @override
  String geoUpdating(Object name) {
    return 'Updating $name...';
  }

  @override
  String geoSkipped(Object name) {
    return '$name skipped';
  }

  @override
  String geoUpdated(Object name) {
    return '$name updated';
  }

  @override
  String get local => 'Local';

  @override
  String get remote => 'Remote';

  @override
  String get remoteBackupDesc => 'Backup local data to WebDAV';

  @override
  String get localBackupDesc => 'Backup local data to local';

  @override
  String get mode => 'Mode';

  @override
  String get time => 'Time';

  @override
  String get source => 'Source';

  @override
  String get action => 'Action';

  @override
  String get intelligentSelected => 'Intelligent selection';

  @override
  String get clipboardNoPackageNames =>
      'No package names found in the clipboard';

  @override
  String get clipboardImport => 'Import from clipboard';

  @override
  String get clipboardExport => 'Export to clipboard';

  @override
  String get layout => 'Layout';

  @override
  String get tight => 'Tight';

  @override
  String get standard => 'Standard';

  @override
  String get loose => 'Loose';

  @override
  String get profilesSort => 'Profiles sort';

  @override
  String get start => 'Start';

  @override
  String get stop => 'Stop';

  @override
  String get key => 'Key';

  @override
  String get value => 'Value';

  @override
  String get vpnTip => 'Changes take effect after restarting the VPN';

  @override
  String get vpnEnableDesc =>
      'VPN routes all system traffic through VpnService automatically';

  @override
  String get options => 'Options';

  @override
  String get loopback => 'UWP loopback exemption';

  @override
  String get providers => 'Providers';

  @override
  String get proxyProviders => 'Proxy providers';

  @override
  String get ruleProviders => 'Rule providers';

  @override
  String get status => 'Status';

  @override
  String get statusDesc => 'With DNS off, the system DNS is used';

  @override
  String get preferH3Desc => 'Prefer HTTP/3 tries HTTP/3 first for DoH servers';

  @override
  String get respectRules => 'Respect rules';

  @override
  String get respectRulesDesc =>
      'Respect rules routes DNS connections by the rules and needs a proxy nameserver';

  @override
  String get dnsMode => 'DNS mode';

  @override
  String get fakeipRange => 'Fake-IP range';

  @override
  String get fakeipFilter => 'Fake-IP filter';

  @override
  String get defaultNameserver => 'Default nameserver';

  @override
  String get defaultNameserverDesc =>
      'Resolves the hostnames of the other DNS servers. Use IP addresses only.';

  @override
  String get nameserver => 'Nameserver';

  @override
  String get nameserverDesc =>
      'The default DNS servers, such as 223.5.5.5, tls://1.1.1.1 or https://dns.google/dns-query.';

  @override
  String get useHosts => 'Use hosts';

  @override
  String get useSystemHosts => 'Use system hosts';

  @override
  String get nameserverPolicy => 'Nameserver policy';

  @override
  String get nameserverPolicyDesc =>
      'Matching domains use the DNS server given here instead of Nameserver and Fallback.';

  @override
  String get proxyNameserver => 'Proxy nameserver';

  @override
  String get fallback => 'Fallback';

  @override
  String get fallbackDesc =>
      'Used instead of Nameserver when the fallback filter treats its answer as polluted.';

  @override
  String get preferH3 => 'Prefer HTTP/3';

  @override
  String get fallbackLazyQuery => 'Lazy fallback query';

  @override
  String get proxyNameserverPolicy => 'Proxy nameserver policy';

  @override
  String get directNameserver => 'Direct nameserver';

  @override
  String get directNameserverFollowPolicy => 'Direct nameserver follows policy';

  @override
  String get fallbackFilter => 'Fallback filter';

  @override
  String get geoipCode => 'Geoip code';

  @override
  String get ipcidr => 'Ipcidr';

  @override
  String get domain => 'Domain';

  @override
  String get reset => 'Reset';

  @override
  String get action_view => 'Show/Hide';

  @override
  String get action_start => 'Start/Stop';

  @override
  String get action_mode => 'Switch mode';

  @override
  String get action_proxy => 'System proxy';

  @override
  String get action_tun => 'TUN';

  @override
  String get hotkeyManagement => 'Hotkey Management';

  @override
  String get hotkeyManagementDesc => 'Use keyboard to control applications';

  @override
  String get pressKeyboard => 'Please press the keyboard.';

  @override
  String get remove => 'Remove';

  @override
  String get noNetwork => 'No network';

  @override
  String get ipv6InboundDesc => 'With IPv6 on, the VPN allows IPv6 inbound';

  @override
  String get exportLogs => 'Export logs';

  @override
  String get exportSuccess => 'Export Success';

  @override
  String get iconStyle => 'Icon style';

  @override
  String get iconStyleFilled => 'Filled';

  @override
  String get iconStylePlain => 'Plain';

  @override
  String get iconStyleHidden => 'Hidden';

  @override
  String get stackMode => 'Stack mode';

  @override
  String get network => 'Network';

  @override
  String get bypassDomain => 'Bypass domains';

  @override
  String get bypassDomainDesc =>
      'Bypass domains apply only while the system proxy is on';

  @override
  String get resetTip => 'Make sure to reset';

  @override
  String get icon => 'Icon';

  @override
  String get noData => 'No data';

  @override
  String get fontFamily => 'Font family';

  @override
  String get installedFonts => 'Installed fonts';

  @override
  String get toggle => 'Toggle';

  @override
  String get system => 'System';

  @override
  String get bypassPrivateRoute => 'Bypass private addresses';

  @override
  String get bypassPrivateRouteDesc =>
      'With Bypass private addresses on, LAN, loopback and multicast addresses skip TUN';

  @override
  String get routeAddress => 'Route addresses';

  @override
  String get pleaseInputAdminPassword => 'Please enter the admin password';

  @override
  String get tunAuthorizationFailed =>
      'TUN could not be enabled because administrator authorization was denied. Allow the system permission prompt and try again.';

  @override
  String get tunHelperInstallFailed =>
      'TUN could not be enabled: Helper installation or startup failed. Check that the app installation is complete and the system service is working, then try again.';

  @override
  String get tunAdminAccountRequired =>
      'TUN needs an administrator account on this Mac. Sign in with an administrator account to turn it on.';

  @override
  String get copyEnvVar => 'Copying environment variables';

  @override
  String get memoryInfo => 'Memory info';

  @override
  String get dialog => 'Dialog';

  @override
  String get cancel => 'Cancel';

  @override
  String get fileIsUpdate =>
      'The file has been modified. Do you want to save the changes?';

  @override
  String get profileHasUpdate =>
      'The profile has been modified. Do you want to disable auto update?';

  @override
  String get copySuccess => 'Copy success';

  @override
  String get copyLink => 'Copy link';

  @override
  String get exportFile => 'Export file';

  @override
  String get cacheCorrupt => 'The cache is corrupt. Do you want to clear it?';

  @override
  String get listen => 'Listen';

  @override
  String get undo => 'undo';

  @override
  String get redo => 'redo';

  @override
  String get none => 'None';

  @override
  String get required => 'Required';

  @override
  String get advancedConfig => 'Advanced configuration';

  @override
  String get advancedConfigDesc => 'Provide diverse configuration options';

  @override
  String get addRule => 'Add rule';

  @override
  String get ruleName => 'Rule name';

  @override
  String get content => 'Content';

  @override
  String get subRule => 'Sub rule';

  @override
  String get ruleTarget => 'Rule target';

  @override
  String get sourceIp => 'Source IP';

  @override
  String get noResolve => 'No resolve IP';

  @override
  String get saveChanges => 'Do you want to save the changes?';

  @override
  String get findProcessModeAutomaticDesc =>
      'Process rules look up the process only when they are checked';

  @override
  String get monochromeScheme => 'Monochrome';

  @override
  String get colorStyle => 'Color style';

  @override
  String get vividStyle => 'Vivid';

  @override
  String get tintedStyle => 'Tinted';

  @override
  String get softStyle => 'Soft';

  @override
  String get customColor => 'Custom color';

  @override
  String get grid => 'Grid';

  @override
  String get spectrum => 'Spectrum';

  @override
  String get sliders => 'Sliders';

  @override
  String get hue => 'Hue';

  @override
  String get saturation => 'Saturation';

  @override
  String get brightness => 'Brightness';

  @override
  String get hex => 'Hex';

  @override
  String get liquidGlass => 'Liquid Glass';

  @override
  String get ultra => 'Ultra';

  @override
  String get developerMode => 'Developer mode';

  @override
  String get developerModeEnableTip => 'Developer mode is enabled.';

  @override
  String get messageTest => 'Message test';

  @override
  String get messageTestTip => 'This is a message.';

  @override
  String get crashTest => 'Crash test';

  @override
  String get clearData => 'Clear Data';

  @override
  String get textScale => 'Text Scaling';

  @override
  String get internet => 'Internet';

  @override
  String get systemApp => 'System APP';

  @override
  String get noNetworkApp => 'No network APP';

  @override
  String get restoreStrategy => 'Restore strategy';

  @override
  String get restoreStrategy_override => 'Override';

  @override
  String get restoreStrategy_compatible => 'Compatible';

  @override
  String get logsTest => 'Logs test';

  @override
  String emptyTip(Object label) {
    return '$label cannot be empty';
  }

  @override
  String urlTip(Object label) {
    return '$label must be a url';
  }

  @override
  String numberTip(Object label) {
    return '$label must be a number';
  }

  @override
  String get interval => 'Interval';

  @override
  String existsTip(Object label) {
    return 'Current $label already exists';
  }

  @override
  String deleteTip(Object label) {
    return 'Are you sure you want to delete the current $label?';
  }

  @override
  String deleteMultipTip(Object label) {
    return 'Are you sure you want to delete the selected $label?';
  }

  @override
  String nullTip(Object label) {
    return 'No $label yet';
  }

  @override
  String get script => 'Script';

  @override
  String get color => 'Color';

  @override
  String get rename => 'Rename';

  @override
  String get unnamed => 'Unnamed';

  @override
  String get mixedPort => 'Mixed port';

  @override
  String get socksPort => 'SOCKS port';

  @override
  String get redirPort => 'Redir port';

  @override
  String get tproxyPort => 'TProxy port';

  @override
  String portTip(Object label) {
    return '$label must be between 1024 and 49151';
  }

  @override
  String get portConflictTip => 'Please enter a different port';

  @override
  String get portUnavailableTitle => 'Port unavailable';

  @override
  String portUnavailableMessage(Object port) {
    return 'The mixed port $port could not start listening and may be in use by another application. Change the port to retry immediately.';
  }

  @override
  String get saveAndRetry => 'Save and retry';

  @override
  String portSuggestionTip(Object port) {
    return 'Suggested port $port has been filled in.';
  }

  @override
  String get portProxyAppTip =>
      'If another proxy app is running, close it first.';

  @override
  String get import => 'Import';

  @override
  String get importFile => 'Import from file';

  @override
  String get importUrl => 'Import from URL';

  @override
  String get autoSetSystemDns => 'Auto-set system DNS';

  @override
  String get suspendOnIdle => 'Pause proxy when idle';

  @override
  String get suspendOnIdleDesc =>
      'Pause proxy when idle stops traffic forwarding and health checks while the screen is off and the system is idle, which may disconnect calls and live audio and delay push notifications';

  @override
  String details(Object label) {
    return '$label details';
  }

  @override
  String get creationTime => 'Creation time';

  @override
  String get process => 'Process';

  @override
  String get host => 'Host';

  @override
  String get destination => 'Destination';

  @override
  String get destinationGeoIP => 'Destination GeoIP';

  @override
  String get destinationIPASN => 'Destination IPASN';

  @override
  String get specialProxy => 'Special proxy';

  @override
  String get specialRules => 'special rules';

  @override
  String get remoteDestination => 'Remote destination';

  @override
  String get networkType => 'Network type';

  @override
  String get proxyChains => 'Proxy chains';

  @override
  String get proxyChainWarning =>
      'Proxy chaining can significantly reduce network speed. Keep it disabled unless you clearly need it.';

  @override
  String get proxyChainInstruction =>
      'Choose hops from entry to exit. Nodes or policy groups can occupy any hop. Concrete group members use the preceding hop; nested groups and DIRECT/REJECT stay unchanged. After saving, the chain appears under its name as a policy group in the proxy list and rule targets. Delays in this editor are per-hop references; test the chain\'s group to measure the effective route.';

  @override
  String get proxyChainMinimumNodes =>
      'A proxy chain needs an entry and an exit';

  @override
  String get proxyChainMinimumNodesHint =>
      'Choose an exit node or policy group.';

  @override
  String get proxyChainPolicyGroups => 'Policy groups';

  @override
  String get proxyChainUnsupportedGroupTip =>
      'Only select, url-test, fallback, and load-balance groups can be used in a chain.';

  @override
  String get proxyChainEntry => 'Entry';

  @override
  String get proxyChainExit => 'Exit';

  @override
  String get clearProxyChain => 'Clear chain config';

  @override
  String get proxyChainCustomNodes => 'Custom nodes';

  @override
  String get proxyChainCustomNode => 'Custom node';

  @override
  String get addProxyChainNode => 'Add';

  @override
  String get proxyChainOtherNodes => 'Other nodes';

  @override
  String get proxyChainSavedAndApplied =>
      'Proxy chain saved and applied. Select it by its name in rules or in the proxy list.';

  @override
  String proxyChainConflictTip(Object name) {
    return 'Proxy $name conflicts with another enabled chain or creates a loop';
  }

  @override
  String proxyChainUnavailableNodeTip(Object name) {
    return 'Proxy $name is not available in this position';
  }

  @override
  String proxyChainUnavailableReference(Object chainName, Object nodeName) {
    return 'Proxy chain “$chainName” references an unavailable node or policy group “$nodeName”. Select it again in “Proxy chains”, or disable this chain.';
  }

  @override
  String get proxyChainRelatedChainsUpdated => 'Related proxy chains updated';

  @override
  String get proxyChainSelectedNodes => 'Proxy chain';

  @override
  String get proxyChainAvailableNodes => 'Available nodes and groups';

  @override
  String get proxyChainEmpty => 'No nodes in the proxy chain';

  @override
  String get proxyChainNodeAdded => 'Node added to proxy chain';

  @override
  String get proxyChainUriNodeSupportedFormats =>
      'Supported formats: ss://, ssr://, vmess://, vless://, trojan://, anytls://, hysteria:// / hy://, hysteria2:// / hy2://, tuic://, wireguard:// / wg://, http(s)://, socks(5)://';

  @override
  String get log => 'Log';

  @override
  String get connection => 'Connection';

  @override
  String get request => 'Request';

  @override
  String get connected => 'Connected';

  @override
  String get disconnected => 'Disconnected';

  @override
  String get connecting => 'Connecting...';

  @override
  String get restartCoreTip => 'Are you sure you want to restart the core?';

  @override
  String get forceRestartCoreTip =>
      'Are you sure you want to force restart the core?';

  @override
  String get dnsHijacking => 'DNS hijacking';

  @override
  String get coreStatus => 'Core status';

  @override
  String get coreNotConnected => 'Core is not connected';

  @override
  String get appendSystemDns => 'Append system DNS';

  @override
  String get blockQuic => 'Block QUIC';

  @override
  String get blockQuicDesc =>
      'Reject UDP 443 traffic to force connections back to TCP';

  @override
  String get blockWebRtc => 'Block WebRTC';

  @override
  String get blockWebRtcDesc =>
      'Reject STUN traffic to reduce WebRTC IP leaks.';

  @override
  String get editRule => 'Edit rule';

  @override
  String get overrideMode => 'Override mode';

  @override
  String get standardModeDesc =>
      'Standard mode, optionally runs an override script, then adds rules on top of the configuration';

  @override
  String get addedRulesAfterScript =>
      'Inserted after the script runs, ahead of the profile\'s rules';

  @override
  String get addedRules => 'Added rules';

  @override
  String get controlGlobalAddedRules => 'Control global added rules';

  @override
  String get overrideScript => 'Override script';

  @override
  String get goToConfigureScript => 'Go to configure script';

  @override
  String get editGlobalRules => 'Edit global rules';

  @override
  String get confirmForceCrashCore =>
      'Are you sure you want to force crash the core?';

  @override
  String get confirmClearAllData => 'Are you sure you want to clear all data?';

  @override
  String get loading => 'Loading...';

  @override
  String yearsAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count years ago',
      one: '1 year ago',
    );
    return '$_temp0';
  }

  @override
  String monthsAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count months ago',
      one: '1 month ago',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days ago',
      one: '1 day ago',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours ago',
      one: '1 hour ago',
    );
    return '$_temp0';
  }

  @override
  String minutesAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes ago',
      one: '1 minute ago',
    );
    return '$_temp0';
  }

  @override
  String get justNow => 'Just now';

  @override
  String get turnOn => 'Turn On';

  @override
  String get turnOff => 'Turn Off';

  @override
  String get vpnConfigChangeDetected => 'VPN settings changed. Tap to restart';

  @override
  String get restart => 'Restart';

  @override
  String get speedStatistics => 'Speed statistics';

  @override
  String get resetPageChangesTip =>
      'The current page has changes. Are you sure you want to reset?';

  @override
  String get overwriteTypeCustom => 'Custom';

  @override
  String get overwriteTypeCustomDesc =>
      'Custom mode, fully customize proxy groups and rules';

  @override
  String get emptyCustomOverwrite =>
      'Custom override is empty. Use Quick fill or add rules and proxy groups first. To keep subscription content, use Overlay mode.';

  @override
  String get proxyGroupEmpty => 'Proxy group is empty';

  @override
  String get proxyGroupNameEmpty => 'Proxy group name cannot be empty';

  @override
  String get ruleEmpty => 'Rule is empty';

  @override
  String get confirmOverwriteTip =>
      'Existing data will be overwritten after confirmation';

  @override
  String get configDataDetected => 'Data detected in configuration';

  @override
  String get quickFill => 'Quick fill';

  @override
  String get clearCustomRouting => 'Clear all';

  @override
  String get confirmClearCustomRouting =>
      'Clear this profile’s custom proxy groups and rules? Subscription content, added rules, proxy chains, and custom nodes will be kept.';

  @override
  String get addProxyGroup => 'Add proxy group';

  @override
  String get editProxyGroup => 'Edit proxy group';

  @override
  String get lazy => 'Lazy loading';

  @override
  String get proxyFilter => 'Proxy filter';

  @override
  String get excludeProxyFilter => 'Exclude proxy filter';

  @override
  String get excludeType => 'Exclude type';

  @override
  String get expectedStatus => 'Expected status';

  @override
  String get maxFailedTimes => 'Max failed times';

  @override
  String get timeout => 'Timeout';

  @override
  String get strategy => 'Strategy';

  @override
  String get iconUrl => 'Icon URL';

  @override
  String get disableUDP => 'Disable UDP';

  @override
  String get hideFromList => 'Hide from list';

  @override
  String get includeAll => 'Include all proxies and providers';

  @override
  String get includeAllProxies => 'Include all proxies';

  @override
  String get includeAllProxyProviders => 'Include all proxy providers';

  @override
  String get proxyGroupMembersEmpty =>
      'Add a proxy, provider, or include-all option';

  @override
  String get tolerance => 'Tolerance';

  @override
  String customOutboundInUse(Object name) {
    return '$name is still referenced by a group, rule, or proxy chain';
  }

  @override
  String get relayGroupUnsupported =>
      'Relay groups were removed by the core. Choose another type.';

  @override
  String rawOutboundInUse(Object name, Object path) {
    return '$name is referenced by the original configuration at $path';
  }

  @override
  String get unknownNetworkError => 'Unknown network error';

  @override
  String get restoreException => 'Recovery exception';

  @override
  String get networkException =>
      'Network exception, please check your connection and try again';

  @override
  String get invalidBackupFile => 'Invalid backup file';

  @override
  String get backupFromNewerVersion =>
      'This backup comes from a newer version of the app. Update the app before restoring it';

  @override
  String get pruneCache => 'Prune cache';

  @override
  String get backupAndRestore => 'Backup and Restore';

  @override
  String get backupAndRestoreDesc => 'Sync data via WebDAV or files';

  @override
  String get restore => 'Restore';

  @override
  String get restoreDefault => 'Restore Default';

  @override
  String get restoreSuccess => 'Restore success';

  @override
  String get restoreFromWebDAVDesc => 'Restore data via WebDAV';

  @override
  String get restoreFromFileDesc => 'Restore data via file';

  @override
  String get restoreOnlyConfig => 'Restore configuration files only';

  @override
  String get restoreAllData => 'Restore all data';

  @override
  String get backupRetention => 'Backups to keep';

  @override
  String get backupRetentionDesc =>
      'Each backup removes this device\'s older WebDAV backups';

  @override
  String get selectBackup => 'Select a backup';

  @override
  String get noRemoteBackup => 'No backups on WebDAV';

  @override
  String get deleteBackupTip => 'Delete this backup from WebDAV?';

  @override
  String get addProfile => 'Add Profile';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get delayTest => 'Delay Test';

  @override
  String get userCenter => 'User Center';

  @override
  String get userCenterFallback => 'User Center (Backup)';

  @override
  String get userGuide => 'User Guide';

  @override
  String get oixCloud => 'oixCloud';

  @override
  String get register => 'Register';

  @override
  String get registerTitle => 'Create Account';

  @override
  String get registerFailed => 'Registration failed';

  @override
  String get registerClosed => 'Registration is currently closed';

  @override
  String get haveAccountAlready => 'Already have an account?';

  @override
  String get goLogin => 'Log in';

  @override
  String get nicknameLabel => 'Nickname';

  @override
  String get nicknameHint => 'Letters and numbers, up to 12 characters';

  @override
  String get nicknameValidation => 'Please enter a nickname';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get confirmPasswordHint => 'Re-enter your password';

  @override
  String get confirmPasswordValidation => 'Please confirm your password';

  @override
  String get passwordMismatch => 'Passwords do not match';

  @override
  String get passwordRuleHint =>
      '10-36 chars incl. upper/lowercase, number and symbol';

  @override
  String get inviteCodeLabel => 'Invite Code';

  @override
  String get inviteCodeHint => 'Enter invite code';

  @override
  String get inviteCodeValidation => 'Please enter the invite code';

  @override
  String get emailCodeLabel => 'Email Code';

  @override
  String get emailCodeHint => 'Enter the 6-digit code';

  @override
  String get emailCodeValidation => 'Please enter the email code';

  @override
  String get sendCode => 'Send Code';

  @override
  String resendCodeIn(Object seconds) {
    return 'Resend in ${seconds}s';
  }

  @override
  String get codeSent => 'Verification code sent';

  @override
  String get loggedOutViewTitle => 'oixCloud';

  @override
  String get loggedOutViewDesc =>
      'Login to view account info and manage subscriptions';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get googleLoginWaiting => 'Complete Google sign-in in your browser';

  @override
  String get googleLoginUnavailable =>
      'Could not open Google sign-in. Please try again.';

  @override
  String get googleLoginTimedOut =>
      'Google sign-in timed out. Please try again.';

  @override
  String get googleLoginInvalidCallback =>
      'Could not verify Google sign-in. Please try again.';

  @override
  String get loginTitle => 'Login';

  @override
  String get startCorePromptTitle => 'Prompt';

  @override
  String get startCorePromptContent =>
      'Profile has been successfully imported. Do you want to start the core now?';

  @override
  String get logoutTitle => 'Logout';

  @override
  String get logoutContent => 'Sign out?';

  @override
  String get loginSuccess => 'Login Successful';

  @override
  String get getProfileSuccess => 'Profile imported successfully';

  @override
  String get startSuccess => 'Started successfully';

  @override
  String get loginFailed => 'Login Failed';

  @override
  String get invalidCertificateTitle => 'Certificate Verification Failed';

  @override
  String get certificateExpired => 'Certificate has expired';

  @override
  String get certificateNotYetValid => 'Certificate is not yet valid';

  @override
  String get certificateHostnameMismatch =>
      'Certificate does not match the requested domain';

  @override
  String get certificateUntrusted => 'Certificate chain is not trusted';

  @override
  String get certificateValidityHint =>
      'First synchronize the system date and time. If the time is correct, the server certificate needs to be fixed.';

  @override
  String get invalidCertificateContent =>
      'The server certificate could not be verified. Skipping verification means the server may be impersonated, and any account credentials or subscription data you send or receive could be stolen or altered.\n\nProceed only if you trust this network and server. This exception applies only to this retry with the same server and certificate, and is removed when the operation ends.';

  @override
  String get allowTemporarily => 'Allow Temporarily';

  @override
  String get retryWithoutCertificateVerification => 'Temporarily Check API';

  @override
  String get apiAvailableWithCertificateException =>
      'The API was reachable with a temporary certificate exception. No account or node configuration was synced. Fix the certificate issue, then check again.';

  @override
  String get certificateUntrustedHint =>
      'Try a different network, such as a phone hotspot, and check for system updates. If antivirus software or a company network inspects HTTPS, ask its administrator to check it. If the problem persists, contact the service provider to check the certificate chain.';

  @override
  String get certificateHostnameHint =>
      'Try a different network and complete any Wi-Fi sign-in first. If the problem persists, contact the service provider to check that the certificate matches the server domain.';

  @override
  String get certificateRevokedHint =>
      'Contact the service provider to replace the revoked certificate. Retrying or changing the system time will not fix a revoked certificate.';

  @override
  String get certificateUnknownHint =>
      'Check the system date and time, then try a different network. If verification still fails, send this error to the service provider for help.';

  @override
  String get certificateCheckOnlyHint =>
      'This action only checks API connectivity. It does not sign in or download node configurations.';

  @override
  String get certificateSyncRetryDescription =>
      'After confirmation, this attempt checks the connection, refreshes your account, and downloads the node configuration. The certificate exception ends when this sync finishes.';

  @override
  String get retryCloudSyncWithCertificateException =>
      'Allow Temporarily and Sync';

  @override
  String get cloudSyncedWithCertificateException =>
      'Account and configuration sync completed with a temporary certificate exception. Verification is now restored; resolve the certificate issue before the next sync.';

  @override
  String get cloudCertificateSyncFailed =>
      'The API check passed, but account or node configuration sync failed: ';

  @override
  String get cloudConfigSyncIncomplete =>
      'The node configuration was not downloaded. Resolve the download error and sync again.';

  @override
  String get emailPassword => 'Email & Password';

  @override
  String get accessToken => 'Access Token';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'Enter email address';

  @override
  String get emailValidation => 'Please enter email';

  @override
  String get emailFormatValidation => 'Invalid email format';

  @override
  String get passwordLabel => 'Password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get resetPasswordTitle => 'Reset password';

  @override
  String get sendResetEmail => 'Send reset email';

  @override
  String get resetEmailSent =>
      'Reset email sent. Paste the reset link or code from the email below.';

  @override
  String get resetTokenLabel => 'Reset link or code';

  @override
  String get resetTokenValidation => 'Please enter the reset link or code';

  @override
  String get newPasswordLabel => 'New password';

  @override
  String get resetPasswordSuccess =>
      'Password has been reset, please sign in with your new password';

  @override
  String get passwordValidation => 'Please enter password';

  @override
  String get tokenLabel => 'Access Token';

  @override
  String get tokenValidation => 'Please enter Access Token';

  @override
  String expireDate(Object date) {
    return 'Expires: $date';
  }

  @override
  String get todayUsed => 'Today\'s Usage';

  @override
  String remaining(Object value) {
    return 'Remaining: $value';
  }

  @override
  String get balance => 'Balance';

  @override
  String get commission => 'Commission';

  @override
  String get points => 'Points';

  @override
  String get announcement => 'Announcement';

  @override
  String get readFullAnnouncement => 'Read full announcement';

  @override
  String get serviceCheckFailed => 'Service Check Failed';

  @override
  String get apiAvailable => 'API service is operational';

  @override
  String get checkApi => 'Check API';

  @override
  String get refresh => 'Refresh';

  @override
  String get nodeFilter => 'Node Filter';

  @override
  String get nodeFilterSmartSelection => 'Smart Selection';

  @override
  String get nodeFilterCustomized => 'Customized';

  @override
  String nodeFilterKept(Object kept, Object total) {
    return '$kept of $total nodes kept';
  }

  @override
  String get nodeFilterLines => 'Lines';

  @override
  String get nodeFilterRegions => 'Regions';

  @override
  String get nodeFilterNameContains => 'Name contains';

  @override
  String get nodeFilterNameExcludes => 'Name excludes';

  @override
  String get nodeFilterPreview => 'Preview';

  @override
  String get nodeFilterSearch => 'Search nodes';

  @override
  String get nodeFilterAny => 'Any';

  @override
  String get nodeFilterOnly => 'Only';

  @override
  String get nodeFilterExclude => 'Exclude';

  @override
  String get nodeFilterKeepOne => 'Keep at least one node';

  @override
  String nodeFilterNodeKept(Object name) {
    return '$name, kept';
  }

  @override
  String nodeFilterNodeExcluded(Object name) {
    return '$name, excluded';
  }

  @override
  String get nodeFilterRetry => 'Retry';

  @override
  String get nodeFilterAccountNote =>
      'Saved to your account and applies to every device signed in to this app.';

  @override
  String get nodeFilterUnavailable =>
      'Node filters are available once you have a plan';

  @override
  String get minimalConfiguration => 'Minimal Configuration';

  @override
  String get minimalConfigurationDesc =>
      'Use a simplified rule set to generate a smaller profile';

  @override
  String get tcpFastOpen => 'TCP Fast Open';

  @override
  String get tcpFastOpenDesc =>
      'Enable this option to accelerate TCP connection establishment';

  @override
  String get store => 'Store';

  @override
  String get recharge => 'Recharge';

  @override
  String get availablePlans => 'Choose a Plan';

  @override
  String get noAvailablePlans => 'No plans available';

  @override
  String get myOrders => 'Purchased Plans';

  @override
  String get noPurchaseRecords => 'No purchased plans yet';

  @override
  String get accountBalance => 'Balance';

  @override
  String commissionBalance(Object value) {
    return 'Commission $value';
  }

  @override
  String get soldOut => 'Sold out';

  @override
  String remainingStock(Object count) {
    return 'Only $count left';
  }

  @override
  String get mainlandNetworkWarning =>
      'May not be suitable for networks in mainland China';

  @override
  String get planInUse => 'In use';

  @override
  String get planNotActivated => 'Pending activation';

  @override
  String get planEnded => 'Ended';

  @override
  String get planAwaitingAutoRenewal => 'Awaiting auto-renewal';

  @override
  String get planAwaitingAutoRenewalNote =>
      'Queued after your other plans; renews automatically once they are used up';

  @override
  String get planAutoRenewalOffNote =>
      'Queued after your other plans; ends once they are used up';

  @override
  String planNumber(Object id) {
    return 'Plan #$id';
  }

  @override
  String get activate => 'Activate';

  @override
  String get upgradePlan => 'Upgrade plan';

  @override
  String get noPaymentMethods => 'No payment methods available';

  @override
  String get activatePlanTitle => 'Activate plan';

  @override
  String get activatePlanConfirm =>
      'Activate this plan? It will become your active plan.';

  @override
  String get noUpgradablePlans => 'No upgradable plans';

  @override
  String get selectUpgradeTarget => 'Select upgrade target';

  @override
  String get refreshAfterPayment =>
      'After payment, pull down to refresh and check the result';

  @override
  String get discountCodeOptional => 'Discount code (optional)';

  @override
  String get bindCoupon => 'Apply coupon';

  @override
  String get bindCouponIntro =>
      'Enter an official coupon code. The difference is settled for the remaining plan duration, and a recurring coupon also updates the renewal price.';

  @override
  String get verifyCoupon => 'Verify';

  @override
  String get discountCode => 'Discount code';

  @override
  String get discountCodeRequired => 'Enter a discount code';

  @override
  String get discountedPriceLabel => 'Discounted price';

  @override
  String get amountDueLabel => 'Amount due';

  @override
  String get refundAmountLabel => 'Refund';

  @override
  String get recurringRenewalHint =>
      'Future automatic renewals keep this discount';

  @override
  String get insufficientBalanceHint =>
      'Insufficient balance. Top up before continuing.';

  @override
  String get amountPayable => 'Amount payable';

  @override
  String get renewalPriceLabel => 'Renewal price';

  @override
  String get calculatingQuote => 'Calculating…';

  @override
  String get paymentMethod => 'Payment method';

  @override
  String get goPay => 'Pay';

  @override
  String get confirmPurchase => 'Confirm purchase';

  @override
  String get rechargeAmount => 'Recharge amount (¥)';

  @override
  String get invalidAmount => 'Please enter a valid amount';

  @override
  String get scanOrTransferPay => 'Scan / Transfer payment';

  @override
  String get close => 'Close';

  @override
  String get checkingPayment => 'Checking...';

  @override
  String get paymentPending =>
      'Payment has not been received yet. Please check again shortly.';

  @override
  String get iHavePaid => 'I have paid';

  @override
  String get openInBrowser => 'Open in browser';

  @override
  String get openLinkFailed =>
      'Unable to open the link. Check that a browser is installed and try again.';

  @override
  String get scanToPayNotice => 'Scan with Alipay / WeChat to pay';

  @override
  String get paymentAmount => 'Payment amount';

  @override
  String get receivingAddress => 'Receiving address';

  @override
  String get addressCopied => 'Address copied';

  @override
  String get transferConfirmNotice =>
      'The system will confirm automatically after the transfer is completed, and the selected plan will be activated.';

  @override
  String get operationSuccess => 'Operation successful';

  @override
  String get operationFailed => 'Operation failed';

  @override
  String get paymentSuccess => 'Payment successful';

  @override
  String get paymentRequestFailed => 'Payment request failed';

  @override
  String get fetchPlansFailed => 'Failed to load plans';

  @override
  String get storeSubtitle => 'Purchase, renew, and upgrade plans';

  @override
  String get paymentUnknownResponse =>
      'Payment endpoint returned an unknown format';

  @override
  String get buy => 'Buy';

  @override
  String get payWithBalance => 'Pay with balance';

  @override
  String availableBalance(Object value) {
    return 'Available $value';
  }

  @override
  String get planUnavailable => 'Unavailable';

  @override
  String get balanceDeductionHint =>
      'Purchases use your balance first, then commission for any shortfall.';

  @override
  String rechargeAllowedRange(Object min, Object max) {
    return 'Allowed range $min – $max';
  }

  @override
  String get rechargeAmountOutOfRange =>
      'The amount is outside the range allowed by this payment method';

  @override
  String get insufficientBalanceRecharge => 'Recharge and try again.';

  @override
  String get storeOutcomeUnknown =>
      'The request may still have gone through. Check Purchased Plans before trying again.';

  @override
  String configParseErrorAtLine(Object line) {
    return 'The configuration format is invalid at line $line.';
  }

  @override
  String configTypeMismatch(Object expected, Object actual) {
    return 'Expected $expected, but found $actual.';
  }

  @override
  String get configYamlFormatHint =>
      'Check the indentation and \"-\" list markers near this line.';

  @override
  String get configValueTypeList => 'a list';

  @override
  String get configValueTypeObject => 'an object';

  @override
  String get configValueTypeText => 'text';

  @override
  String get configValueTypeBoolean => 'a boolean';

  @override
  String get configValueTypeInteger => 'an integer';

  @override
  String get configValueTypeNumber => 'a number';

  @override
  String get configValueTypeNull => 'an empty value';

  @override
  String get configRecoveryTitle => 'Recover local configuration';

  @override
  String get configRecoveryMessage =>
      'Local configuration is temporarily unavailable. Your existing data has been kept. Unlock your device and retry, or reopen the app later.';

  @override
  String get configRecoveryRetry => 'Retry';

  @override
  String get geoDownloadFailed => 'GEO download failed';

  @override
  String get geoFileMissing => 'Not downloaded';

  @override
  String get geoFileReadFailed => 'Could not read resource file';

  @override
  String get geoDownloadRecoveryHint =>
      'Download uses the current network rules, or a direct connection when the proxy is unavailable. Retry the current address, choose another source, or enter a custom URL. After validation, the operation will continue automatically.';

  @override
  String get geoOriginalSource => 'Current address';

  @override
  String get geoBackupSource => 'Backup CDN';

  @override
  String get geoDownloadUrl => 'Download URL';

  @override
  String get geoInvalidDownloadUrl => 'Enter a valid HTTP or HTTPS URL';

  @override
  String get purchasedAtLabel => 'Purchase time';

  @override
  String get purchasePriceLabel => 'Purchase price';

  @override
  String get billingPeriodLabel => 'Billing period';

  @override
  String get remainingTimeLabel => 'Remaining time';

  @override
  String get remainingTrafficLabel => 'Remaining traffic';

  @override
  String get expiresAtLabel => 'Expires at';

  @override
  String get usedTrafficLabel => 'Used traffic';

  @override
  String get purchaseTotalTrafficLabel => 'Total traffic';

  @override
  String get purchaseAutoRenewLabel => 'Auto-renew';

  @override
  String purchaseDays(Object count) {
    return '${count}d';
  }

  @override
  String purchaseHours(Object count) {
    return '${count}h';
  }

  @override
  String purchaseMinutes(Object count) {
    return '${count}m';
  }

  @override
  String get purchaseRenewOn => 'On';

  @override
  String get purchaseRenewOff => 'Off';

  @override
  String get overwriteTypeMerge => 'Overlay';

  @override
  String get overwriteTypeMergeDesc =>
      'Keep subscription rules and groups, then add your own. Personal rules take priority over subscription rules; existing added rules keep their priority.';

  @override
  String get personalRouting => 'Personal routing';

  @override
  String get overlayHint =>
      'Saved separately from the subscription and reapplied after updates. New groups block connections when no members match.';

  @override
  String overlayNameConflict(Object name) {
    return 'The name \"$name\" is already used. Rename the personal group to keep both.';
  }

  @override
  String get outboundUnavailable =>
      'Unavailable in this configuration. Remove or replace it.';

  @override
  String get memberOrderHint =>
      'Selection order is the fallback order. Remove and reselect a member to move it to the end.';

  @override
  String groupCycleError(Object name) {
    return 'Circular group reference: $name. Choose a different member.';
  }

  @override
  String get rulesRequireRuleMode =>
      'Personal routing rules take effect in Rule mode.';

  @override
  String get checkRouting => 'Check configuration';

  @override
  String get routingChecked =>
      'Configuration is valid. Personal settings are saved for this profile.';

  @override
  String get routingApplied => 'Personal settings applied.';

  @override
  String get routingApplyFailed =>
      'Changes were saved but could not be applied. Check the configuration and retry.';

  @override
  String get customRuleForm => 'Form';

  @override
  String get customRuleRaw => 'Rule text';

  @override
  String get customRuleRawHint =>
      'Enter one complete rule. Advanced expressions are preserved.';

  @override
  String get customRuleFormUnavailable =>
      'This rule uses advanced syntax. Edit the rule text to preserve all options.';

  @override
  String get customRuleInvalidSyntax =>
      'Enter one complete rule with a valid type, content and target.';

  @override
  String customRuleInvalidContent(Object example) {
    return 'Check the content for this rule type. Example: $example';
  }

  @override
  String customRuleUnavailableTarget(Object name) {
    return '$name is unavailable. Choose a target from this configuration.';
  }

  @override
  String customRuleUnavailableProvider(Object name) {
    return '$name is unavailable. Choose an existing rule provider.';
  }

  @override
  String get customRuleChooseTarget => 'Choose a target';

  @override
  String get customRuleChooseProvider => 'Choose a rule provider';

  @override
  String get customRuleMatchHint =>
      'Matches all remaining traffic. Rules below it will not be reached.';

  @override
  String get customRuleNoResolveHint =>
      'Match known IP addresses without resolving domain names.';

  @override
  String get saveRoutingDraft => 'Save draft';

  @override
  String get routingDraftHint =>
      'Save a draft to fix other items. Settings are applied only after the full configuration passes validation.';

  @override
  String get groupFilterHint =>
      'Filters automatically included and provider nodes. Manually selected members are always kept.';

  @override
  String get groupTypeSelect => 'Manual selection';

  @override
  String get groupTypeUrlTest => 'Automatic selection';

  @override
  String get groupTypeFallback => 'Failover';

  @override
  String get groupTypeLoadBalance => 'Load balancing';

  @override
  String get groupTypeSelectHint =>
      'Choose the active member on the Proxies page.';

  @override
  String get groupTypeUrlTestHint =>
      'Periodically test members and select a low-latency node.';

  @override
  String get groupTypeFallbackHint =>
      'Try members in order and switch when the current member fails.';

  @override
  String get groupTypeLoadBalanceHint =>
      'Distribute connections across available members.';

  @override
  String get routingGroupType => 'Group type';

  @override
  String get customRuleType => 'Rule type';

  @override
  String get routingChanged =>
      'This configuration changed while it was being edited or checked. Reopen the editor or check it again.';

  @override
  String get editCustomRouting => 'Edit custom routing';

  @override
  String get customRoutingDraftHint =>
      'Fill in your custom routing, then switch to Custom mode. Editing this draft does not change the current mode.';

  @override
  String coreBlockedByPolicyTip(int code) {
    return 'Windows blocked the proxy core from starting (system error $code). Check Protection history in Windows Security and your app control policy, and verify the installer source and signature.';
  }

  @override
  String get startupRecoveryTitle => 'Startup recovery';

  @override
  String get startupRecoveryTip =>
      'The previous startup did not finish. Automatic configuration setup and VPN startup are paused for this launch. Your selected profile and settings are unchanged. Check the configuration and tap Start to retry; an already running VPN will stay connected.';

  @override
  String get initFailed => 'Startup failed';

  @override
  String get initFailedTip =>
      'The application encountered a critical error during startup and cannot continue.';

  @override
  String get startupTimeoutTip =>
      'Startup timed out. Quit and reopen the application. Copy the diagnostics below if the problem persists.';

  @override
  String get startupDiagnostics => 'Startup diagnostics';

  @override
  String get errorDetails => 'Error details';

  @override
  String get stackTrace => 'Stack trace';

  @override
  String get authentication => 'Local proxy authentication';

  @override
  String get authenticationDesc =>
      'Local proxy authentication asks for a username and password on the HTTP and SOCKS ports. While it is on, the system HTTP proxy is not set; TUN and VPN keep working';

  @override
  String get authenticationSystemProxyDesc =>
      'The system proxy is not applied while local proxy authentication is on';

  @override
  String get authenticationUsernameInvalid =>
      'Use 1–255 UTF-8 bytes, without colons or control characters';

  @override
  String get authenticationPasswordInvalid =>
      'Use 1–255 UTF-8 bytes, without control characters';

  @override
  String get authenticationApplyFailed =>
      'Could not apply authentication settings';

  @override
  String get installedAppsPermissionRequired =>
      'Installed apps permission required';

  @override
  String get installedAppsPermissionDesc =>
      'Allow access to the installed app list to choose which apps use the VPN.';

  @override
  String get installedAppsPermissionDeniedMessage =>
      'Permission was not granted. You can enable it in system settings.';

  @override
  String get installedAppsPermissionGrant => 'Allow access';

  @override
  String get installedAppsLoadFailed =>
      'Could not load installed apps. Please try again.';

  @override
  String get configRecoveryMissingKey =>
      'The encryption key for your existing configuration is missing or invalid. Try the original system account on the original device or restore a backup. Retrying cannot recreate a lost key.';

  @override
  String get configRecoveryDatabaseUnavailable =>
      'The local database cannot be accessed right now. Your files have been kept. Check permissions for this app’s data folder and whether another process is using the database, then retry.';

  @override
  String get configRecoveryIncompatibleDatabase =>
      'The database in this app’s data folder is incompatible or damaged. Your files have been kept. Restore a compatible backup, or back up and reset to set up this app again. Data belonging to other apps will not be accessed.';

  @override
  String get configRecoveryUnreadable =>
      'The local configuration cannot be decrypted or is damaged. Existing files have been kept. Restore the matching key and configuration backup, or back up and reset.';

  @override
  String get configRecoveryStorage =>
      'The local configuration or its encryption key could not be read or saved. Check access to the application data folder and the system secure storage, then retry.';

  @override
  String get configRecoveryReset => 'Back up and reset';

  @override
  String get configRecoveryResetConfirm =>
      'Create an encrypted backup of all local settings, subscriptions, rules and account data, then reset the application? You will need to sign in again and restore or import your subscriptions and settings. The backup is protected by this Windows account; it cannot recover a lost encryption key.';

  @override
  String get configRecoveryResetDone =>
      'An encrypted backup of your original data has been saved in the folder below. Exit and reopen the application to set it up again.';

  @override
  String get configRecoveryResetFailed =>
      'The encrypted backup and reset could not be completed. Surviving original data will not be removed without a verified backup. Retry this operation, or exit and reopen the application to finish it.';

  @override
  String get configRecoveryKeyring =>
      'The system keyring (Secret Service) could not be accessed. Enable and unlock KDE Wallet or GNOME Keyring in your system settings, then retry.';

  @override
  String get configRecoveryUseLocalStorage => 'Use local file storage';

  @override
  String get configRecoveryUseLocalStorageConfirm =>
      'Store encryption keys and account credentials in a file in the application data folder that only your user account can open, instead of the system keyring? Any program running as your user can read them and decrypt the local configuration. This choice stays in effect from now on.';

  @override
  String get excludeSsids => 'Wi-Fi networks that pause the proxy';

  @override
  String get excludeSsidsDesc =>
      'Pause proxying on the listed Wi-Fi networks; resume after leaving only while the app remains started.';

  @override
  String get allowBackgroundLocation => 'Allow all the time';

  @override
  String get locationPermission => 'Location permission';

  @override
  String get locationPermissionRequired => 'Location permission required';

  @override
  String locationPermissionGuide(Object appName) {
    return '1. Open System Settings > Privacy & Security\n2. Choose Location Services\n3. Find and check $appName in the list\n\nWhen you are done, return to the app to continue. Thank you for your cooperation.';
  }

  @override
  String get ssidPermissionGuide =>
      'Allow location access to read Wi-Fi names. On Android, allow precise location all the time and enable system location services.';

  @override
  String get ssidPermissionMacosGuide =>
      'Allow this app to use Location Services in System Settings to read Wi-Fi names.';

  @override
  String get matchTargetTitle => 'Match target';

  @override
  String get matchTarget => 'MATCH-TARGET';

  @override
  String get followProfile => 'Follow profile';

  @override
  String get iconHistory => 'Recent icons';

  @override
  String get exitFullScreen => 'Exit full screen';

  @override
  String get unmaximize => 'Restore down';

  @override
  String get maximize => 'Maximize';

  @override
  String get unpinWindow => 'Unpin window';

  @override
  String get pinWindow => 'Pin window';

  @override
  String get minimize => 'Minimize';

  @override
  String get cloudApiDnsFailed => 'DNS lookup failed';

  @override
  String get cloudApiDnsEmpty =>
      'DNS returned no address, possibly blocked or a broken system resolver';

  @override
  String get cloudApiDnsUnknownHost => 'DNS could not find this domain';

  @override
  String get cloudApiConnectTimeout => 'Connection timed out';

  @override
  String get cloudApiSendTimeout => 'Sending the request timed out';

  @override
  String get cloudApiReceiveTimeout => 'Waiting for the response timed out';

  @override
  String get cloudApiTlsFailed => 'TLS handshake failed';

  @override
  String get cloudApiConnectionRefused => 'Connection refused';

  @override
  String get cloudApiConnectionReset => 'Connection reset';

  @override
  String get cloudApiNetworkUnreachable => 'Network unreachable';

  @override
  String get cloudApiAccessDenied => 'Network access denied';

  @override
  String get cloudApiConnectionFailed => 'Connection failed';

  @override
  String get cloudApiProxyFailed => 'Proxy connection failed';

  @override
  String get cloudApiProxyAuthFailed =>
      'Proxy authentication failed (HTTP 407)';

  @override
  String cloudApiHttpError(Object status) {
    return 'Server returned HTTP $status';
  }

  @override
  String get certificateRevoked => 'Certificate has been revoked';

  @override
  String get cloudApiBadRequest => 'Server rejected the request as invalid';

  @override
  String get cloudApiForbidden => 'Access forbidden';

  @override
  String get cloudApiNotFound => 'Requested API or resource was not found';

  @override
  String get cloudApiMethodNotAllowed => 'Request method is not allowed';

  @override
  String get cloudApiServerRequestTimeout =>
      'Server timed out receiving the request';

  @override
  String get cloudApiRequestTooLarge => 'Request exceeds the server size limit';

  @override
  String get cloudApiRateLimited => 'Too many requests; try again later';

  @override
  String get cloudApiServerError => 'Internal server error';

  @override
  String get cloudApiBadGateway =>
      'Gateway received an invalid upstream response';

  @override
  String get cloudApiServiceUnavailable => 'Service is temporarily unavailable';

  @override
  String get cloudApiGatewayTimeout =>
      'Gateway timed out waiting for the upstream server';

  @override
  String get cloudApiNetworkAuthRequired =>
      'This network requires sign-in before access';

  @override
  String get cloudApiResponseTooLarge =>
      'Server response exceeds the allowed size';

  @override
  String get cloudApiTlsProtocolFailed =>
      'Incompatible TLS protocol or invalid TLS response';

  @override
  String get cloudApiTlsAlgorithmFailed =>
      'TLS cryptographic algorithm negotiation failed';

  @override
  String get cloudApiTlsInterrupted =>
      'Connection closed before the TLS handshake completed';

  @override
  String get cloudApiRedirectLoop => 'Server redirects form a loop';

  @override
  String get cloudApiRedirectLimit => 'Too many server redirects';

  @override
  String get cloudApiRedirectInvalid => 'Server redirect is invalid';

  @override
  String get cloudApiResponseInterrupted =>
      'Connection closed before the full response was received';

  @override
  String get cloudApiConnectionAborted => 'Connection aborted';

  @override
  String get cloudApiAddressUnavailable => 'Network address is unavailable';

  @override
  String get cloudApiAddressInUse =>
      'Network address or port is already in use';

  @override
  String get cloudApiNetworkResourcesExhausted =>
      'Insufficient system network resources';

  @override
  String get cloudApiClockSkew =>
      'The device clock is too far from the server. Turn on automatic date and time, then retry.';

  @override
  String get cloudApiSignatureRejected =>
      'The server rejected this app’s signature. Reinstall the latest official build.';

  @override
  String get cloudApiServerUnconfigured =>
      'The server has no key configured for this app. Contact support.';

  @override
  String get cloudApiConfigKeyRejected =>
      'The server rejected this device’s configuration key. Reinstall the latest official build.';

  @override
  String get cloudApiAccountDisabled =>
      'This account has been disabled. Contact support.';

  @override
  String get cloudApiAccountAnomaly =>
      'This account needs verification. Complete it on the website, then retry.';

  @override
  String get cloudApiAccountNotFound =>
      'This account no longer exists. Sign in again.';

  @override
  String get cloudApiInvalidResponse => 'Invalid server response';

  @override
  String get cloudApiRequestCanceled => 'Request canceled';

  @override
  String cloudApiSystemError(Object code) {
    return 'System error $code';
  }

  @override
  String get cloudApiTimeout => 'Request timed out';

  @override
  String cloudApiRouteDirect(Object error) {
    return 'Direct: $error';
  }

  @override
  String cloudApiRouteProxy(Object error) {
    return 'Local proxy: $error';
  }

  @override
  String get diagTitle => 'Network self-check';

  @override
  String get diagEntryHint => 'Check the core, system proxy, TUN and DNS';

  @override
  String get diagScope =>
      'Checks the current connection using a small sample. The system network path may also pass through TUN. Results do not cover every app or node.';

  @override
  String get diagRun => 'Run self-check';

  @override
  String get diagCopy => 'Copy diagnostic report';

  @override
  String get diagCanceled => 'Check canceled; results are incomplete';

  @override
  String get diagFixing => 'Applying the fix, then checking again';

  @override
  String get diagFixFailed =>
      'The fix could not be applied. Follow the suggestion above.';

  @override
  String get diagFixApplyProfile => 'Apply configuration';

  @override
  String get diagFixStart => 'Start connection';

  @override
  String get diagFixRestartCore => 'Restart core';

  @override
  String get diagFixRestartConnection => 'Reconnect';

  @override
  String get diagFixSystemProxy => 'Reapply system proxy';

  @override
  String get diagFixEnableSystemProxy => 'Enable system proxy';

  @override
  String get diagFixTun => 'Re-enable TUN';

  @override
  String get diagFixRetest => 'Retest nodes';

  @override
  String get diagPassed => 'Passed';

  @override
  String get diagWarning => 'Needs attention';

  @override
  String get diagFailed => 'Failed';

  @override
  String get diagUnknown => 'Could not confirm';

  @override
  String get diagSkipped => 'Skipped';

  @override
  String get diagDisabled => 'This option is not enabled';

  @override
  String get diagProfile => 'Applied configuration';

  @override
  String get diagProfileReady => 'The selected configuration has been applied';

  @override
  String get diagProfileMissing =>
      'The selected configuration has not been applied';

  @override
  String get diagProfileHint =>
      'Select a valid configuration and start the connection before checking again.';

  @override
  String get diagCore => 'Core response';

  @override
  String get diagCoreReady => 'The core responded and reports active listeners';

  @override
  String get diagCoreUnknown =>
      'The core diagnostic response is unavailable or the configuration changed';

  @override
  String get diagCoreStopped =>
      'The core reports that traffic forwarding is stopped';

  @override
  String get diagSuspended =>
      'Traffic forwarding is paused by the current Wi-Fi exclusion setting';

  @override
  String get diagCoreHint =>
      'Check the connection switch and Wi-Fi exclusions. If the core cannot respond, restart it and use a matching current client/core version.';

  @override
  String get diagListener => 'Local proxy entry';

  @override
  String get diagListenerReady =>
      'The expected port responded to the proxy protocol';

  @override
  String get diagListenerFailed =>
      'The expected proxy port did not respond or differs from the core port';

  @override
  String get diagListenerHint =>
      'Check for port conflicts or a stopped listener. Reconnect first; if it still fails, open Ports and authentication to check or change the mixed port.';

  @override
  String get diagSystemProxy => 'System proxy settings';

  @override
  String get diagProxyReady =>
      'HTTP and HTTPS proxy settings point to the expected local port';

  @override
  String get diagProxyDisabled =>
      'The app requested a system proxy, but the OS reports it disabled';

  @override
  String get diagProxyDifferent => 'The OS proxy does not match the app port';

  @override
  String get diagProxyAutomatic =>
      'Automatic proxy configuration is present; its effective route was not verified';

  @override
  String get diagProxyHint =>
      'Open Troubleshoot and manual setup to compare the system proxy address and port. If settings keep reverting, check other proxy apps or device management policies.';

  @override
  String get diagProxyAutomaticHint =>
      'A PAC script or auto-discovery may choose a different proxy for each website. This does not necessarily mean the connection is broken. Check who provided the configuration before changing it.';

  @override
  String get diagSystemDnsHint =>
      'Try another network and check the DNS servers for the active connection in your operating system. Changing only the client DNS overrides may not fix system lookups.';

  @override
  String get diagProxyRecover => 'Turn off inactive local proxy';

  @override
  String get diagProxyRecoverHint =>
      'Stop the connection first. This turns off a manual proxy pointing to the current local port only when no service is listening. Other proxy addresses, ports and automatic settings are kept.';

  @override
  String get diagProxyGuide => 'Troubleshoot and manual setup';

  @override
  String get diagRecheck => 'Check again';

  @override
  String get diagOpenPortSettings => 'Ports and authentication';

  @override
  String get diagOpenNetworkSettings => 'Network and TUN settings';

  @override
  String get diagOpenDnsSettings => 'DNS override settings';

  @override
  String get diagOpenSystemSettings => 'Open system settings';

  @override
  String get diagOpenSettingsFailed =>
      'Could not open system settings. Follow the path above to open them manually.';

  @override
  String get diagCopyProxyAddress => 'Copy proxy address';

  @override
  String get diagProxyGuidePrepareTitle => '1. Check the local proxy first';

  @override
  String get diagProxyGuidePrepare =>
      'Select a valid profile, start the connection in FlClash, and make sure Local proxy listener passes before entering the proxy address.\nQuit other proxy apps that may keep changing system settings. If your company or school manages the settings, or they are locked or keep reverting, check with the administrator.';

  @override
  String get diagProxyGuideManualTitle =>
      '2. Check or enter the proxy settings';

  @override
  String get diagProxyGuideWindows =>
      'Settings → Network & internet → Proxy\nIf automatic settings are left over from another app and your network no longer needs them, turn off Use setup script and Automatically detect settings.\nUnder Manual proxy setup, enable Use a proxy server, enter the address and port below in their separate fields, and save. Do not prefix the address with http://. Keep any exceptions your network needs.';

  @override
  String get diagProxyGuideMacos =>
      'System Settings → Network → active Wi-Fi or Ethernet service → Details → Proxies\nmacOS 12: System Preferences → Network → active service → Advanced → Proxies\nIf automatic settings are left over from another app and your network no longer needs them, turn off Auto proxy discovery and Automatic proxy configuration.\nEnable Web proxy (HTTP) and Secure web proxy (HTTPS). Enter the address and port below for both, then save. Keep any bypass entries your network needs.';

  @override
  String get diagProxyGuideLinux =>
      'Open your desktop settings → Network → Network Proxy and select Manual (names vary by desktop).\nEnter the address and port below for both HTTP and HTTPS, then apply. If there is no system proxy panel, configure the target app instead.\nBefore replacing an automatic configuration, check its source and whether your network still needs it.';

  @override
  String get diagProxyGuideApp =>
      'On this device, open the target app’s proxy settings, choose HTTP or SOCKS5, and enter the address and port below.\nAndroid provides the system proxy through the VPN service. For VPN access, check the VPN switch and app access control in FlClash network settings.';

  @override
  String get diagProxyGuideAuthenticated =>
      'Local proxy authentication is enabled, so FlClash does not apply a system proxy automatically.\nIn an app that supports proxy authentication, choose HTTP or SOCKS5 and enter the address and port below. Use the username and password from FlClash → Override → General → Inbound → Authentication.\nDo not include credentials in diagnostic reports.';

  @override
  String diagProxyGuideValues(Object port) {
    return 'Local address: 127.0.0.1\nMixed port (current configuration): $port\nUse this mixed port for HTTP, HTTPS website proxying, or SOCKS5 on this device only.';
  }

  @override
  String get diagProxyGuideInvalidPort =>
      'The mixed port is unavailable. Set a valid port in Ports and authentication, then start the connection.';

  @override
  String get diagProxyGuideVerifyTitle => '3. Save and verify the actual app';

  @override
  String get diagProxyGuideVerify =>
      'Return and select Check again, then retry in the browser or app you use.\nIf the local proxy check passes but an app still fails, check its system proxy, custom proxy, or proxy extension settings. System proxy settings do not capture every app.\nYou may need to turn off a manually configured proxy or restore its previous settings when stopping FlClash to keep internet access.';

  @override
  String get diagTun => 'TUN interface and route';

  @override
  String get diagTunMissing =>
      'The core TUN interface was not found in an active state';

  @override
  String get diagTunReady =>
      'The core TUN interface is active and the sampled IPv4 route uses it';

  @override
  String get diagTunRouteMismatch =>
      'TUN is active, but the sampled IPv4 route uses another interface';

  @override
  String get diagTunRouteUnknown =>
      'TUN is active; its IPv4 route could not be verified';

  @override
  String get diagTunHint =>
      'Turn TUN off and on and complete system authorization. If the route differs, check other VPNs. IPv6, UDP and app-specific exclusions need separate checks.';

  @override
  String get proxyConflictTitle => 'Possible proxy conflict';

  @override
  String proxyConflictSystemProxy(Object address) {
    return 'Before starting, the system proxy pointed to $address.';
  }

  @override
  String get proxyConflictAutoConfig =>
      'Before starting, the system proxy used an automatic configuration script.';

  @override
  String proxyConflictVpn(Object name) {
    return 'Before starting, traffic was routed through another VPN or virtual adapter: $name.';
  }

  @override
  String get proxyConflictHint =>
      'If this belongs to another proxy app or VPN, close it; running both can break the connection.';

  @override
  String get diagTrafficCapture => 'Traffic capture';

  @override
  String get diagNoCapture => 'Neither system proxy nor TUN is enabled';

  @override
  String get diagCaptureHint =>
      'Enable system proxy or TUN, or configure the affected app to use the local proxy.';

  @override
  String get diagSystemDns => 'System DNS';

  @override
  String get diagCoreDns => 'Core DNS';

  @override
  String diagProbeSummary(int passed, int total) {
    return '$passed/$total samples passed';
  }

  @override
  String diagProbeResult(int index, String result, int milliseconds) {
    return 'Sample $index: $result · $milliseconds ms';
  }

  @override
  String get diagDnsServerFailed => 'DNS upstream returned a server failure';

  @override
  String get diagDnsReady => 'Sampled names resolved successfully';

  @override
  String get diagDnsPartial => 'Only some sampled names resolved';

  @override
  String get diagOixDnsNoSample =>
      'No managed node hostname was available for this sample';

  @override
  String get diagOixDnsAuthMissing =>
      'The managed DNS signing function is not ready';

  @override
  String get diagDnsNoAnswer =>
      'DNS returned no usable address; this alone does not prove an authentication failure';

  @override
  String get diagDnsRefused => 'The DNS request was refused';

  @override
  String get diagDnsHint =>
      'Check DNS overrides and try another network. If system DNS works but core DNS fails, inspect the configuration DNS settings.';

  @override
  String get diagOixDnsHint =>
      'Check the client version and system time, then refresh the subscription. If resolution still fails, share this diagnostic report with support.';

  @override
  String get diagSystemPath => 'System network path';

  @override
  String get diagProxyPath => 'Through the local proxy';

  @override
  String diagWebResult(Object count) {
    return '$count of 2 independent HTTPS checks passed';
  }

  @override
  String get diagSystemPathHint =>
      'This path does not explicitly use the app HTTP proxy, but may use TUN. A failed sample may be caused by DNS, filtering or the test site; compare the local proxy result.';

  @override
  String get diagProxyPathHint =>
      'If the system path works, check the selected node, routing rules and core DNS. Failure at one test site does not mean every node is unusable.';

  @override
  String get diagClock => 'System time comparison';

  @override
  String get diagClockUnknown =>
      'Not enough uncached HTTPS responses to compare time';

  @override
  String get diagClockSkew =>
      'Two independent responses indicate a possible time difference of at least five minutes';

  @override
  String get diagClockReady =>
      'No consistent large time difference was found in this sample';

  @override
  String get diagClockHint =>
      'Enable automatic system date and time, then retry. A clock error can affect certificates and oixCloud DNS signatures.';

  @override
  String get diagAllFailed =>
      'Every node tested in this group failed. The test URL may also be unreachable. Run a network self-check?';

  @override
  String get updateDownloadBackground => 'Download in background';

  @override
  String get updateReady => 'Update ready to install';

  @override
  String get updateRestart => 'Update and relaunch';

  @override
  String get updateRestartHint =>
      'The app will close, update in place, and reopen. Your settings will be preserved.';

  @override
  String get updatePreparing => 'Preparing the update';

  @override
  String get updateVerifying => 'Verifying update package';

  @override
  String get updateCheckingInstaller => 'Checking the installer';

  @override
  String get updateRestarting => 'Closing and restarting';

  @override
  String get updateApplyFailed =>
      'Automatic update did not complete. Retry or update from the download page.';

  @override
  String get updateReadyHint =>
      'The update has been downloaded. Install when convenient.';

  @override
  String get updateInstall => 'Install update';

  @override
  String get updateDownloading => 'Downloading update';

  @override
  String get updateDownloadFailed => 'Update download failed';

  @override
  String get updateDownloadBrowser => 'Download in browser';

  @override
  String get updatePackageFormat => 'Choose the package format';

  @override
  String get updatePackageFormatTip =>
      'How this build was installed could not be determined. Pick the format that matches it.';

  @override
  String get updateAppImageTip =>
      'An AppImage cannot be installed automatically. Replace the running program with the downloaded file; its folder has been opened.';

  @override
  String get updatePackageManagerTip =>
      'This build was installed by a package manager; upgrade it the same way you installed it.';

  @override
  String get tunMtuDesc =>
      'Default: 9000; alternatives: 1480 or 4064. Restart the Android VPN to apply';

  @override
  String get tunMtuInvalid => 'Enter an integer from 1280 to 65535';

  @override
  String get scriptOptions => 'Script options';

  @override
  String get scriptOptionsEmpty =>
      'This script does not expose configurable switches';

  @override
  String get scriptChanges => 'Script changes';

  @override
  String get scriptFullConfig => 'Full config';

  @override
  String get scriptChangesDescription =>
      'Top-level configuration fields added, modified or removed by the script. The full configuration also includes app settings.';

  @override
  String get scriptChangesEmpty =>
      'The script did not change the configuration';

  @override
  String scriptChangesAdded(int count) {
    return 'Added ($count)';
  }

  @override
  String scriptChangesModified(int count) {
    return 'Modified ($count)';
  }

  @override
  String scriptChangesRemoved(int count) {
    return 'Removed ($count)';
  }

  @override
  String get excludeNetworks => 'Pause proxy by IP or gateway';

  @override
  String get excludeNetworksDesc =>
      'Pause on matching Wi-Fi/Ethernet IPv4 addresses, subnets or gateways; resume after leaving. Comma-separated, e.g. 192.168.1.0/24,gateway:192.168.1.1';

  @override
  String get excludeNetworksInvalid =>
      'Up to 16 rules; enter valid IPv4, CIDR or gateway:address';

  @override
  String get delayConcurrency => 'Concurrent batch latency tests';

  @override
  String get delayTestFailed => 'Failed';

  @override
  String get updateReleaseNotes => 'Release notes';

  @override
  String get updateDownloadConfirm => 'Download update';

  @override
  String get updateLater => 'Later';

  @override
  String get updateCancelDownload => 'Cancel download';

  @override
  String get updateNotice => 'New version detected';

  @override
  String updateVersionNumber(String version) {
    return 'Version: $version';
  }

  @override
  String updateBuildNumber(String build) {
    return 'Build: $build';
  }

  @override
  String get updateReleaseNotesFailed =>
      'Could not load release notes. Please try again.';

  @override
  String get tailscaleEntryHint => 'Access the devices in your tailnet';

  @override
  String get tailscaleEmptyTitle => 'Access your tailnet';

  @override
  String get tailscaleEmptyDesc =>
      'Add a network, sign in on this device, then start the proxy to reach your devices.';

  @override
  String get tailscaleAddNetwork => 'Add network';

  @override
  String get tailscaleNetworks => 'Networks';

  @override
  String get tailscaleGuide => 'Guide';

  @override
  String get tailscaleThisDevice => 'This device';

  @override
  String get tailscaleStatus => 'Status';

  @override
  String get tailscaleDeviceName => 'Device name';

  @override
  String tailscaleDevices(Object count) {
    return 'Devices ($count)';
  }

  @override
  String get tailscaleNetworkName => 'Network name';

  @override
  String get tailscaleNameInUse => 'This name is already in use';

  @override
  String get tailscaleLoginMethod => 'Login method';

  @override
  String get tailscaleInteractiveLogin => 'Interactive';

  @override
  String get tailscaleAuthKey => 'Auth key';

  @override
  String get tailscaleAuthKeySaved =>
      'An auth key is saved on this device. Enter a new one to replace it.';

  @override
  String get tailscaleLoginFooter => 'Sign in once per network on this device.';

  @override
  String get tailscaleAutoRoute => 'Automatic routing';

  @override
  String get tailscaleAutoRouteDesc =>
      'Route peer addresses, MagicDNS names and approved subnets through this network';

  @override
  String get tailscaleExitNode => 'Exit node';

  @override
  String get tailscaleExitNodeDesc =>
      'Leave empty for none, or use auto, a peer name or a peer IP address.';

  @override
  String get tailscaleAvailableExitNodes => 'Available exit nodes';

  @override
  String get tailscaleExitNodeAllowLan => 'Allow local network access';

  @override
  String get tailscaleAdvanced => 'Advanced';

  @override
  String get tailscaleControlUrl => 'Control URL';

  @override
  String get tailscaleCredentialsFooter =>
      'Authentication and device identity stay on this device.';

  @override
  String get tailscaleAccount => 'Account';

  @override
  String get tailscaleSaveAndLogin => 'Save and log in';

  @override
  String get tailscaleOpenLoginPage => 'Open login page';

  @override
  String get tailscaleLoginWaiting =>
      'Open the login page or scan the code. Sign-in completes automatically after approval.';

  @override
  String get tailscaleSigningIn => 'Signing in';

  @override
  String get tailscaleSignedIn => 'Signed in';

  @override
  String get tailscaleLogout => 'Log out';

  @override
  String get tailscaleLoginFailed => 'Tailscale login failed';

  @override
  String get tailscaleLoginTimeout =>
      'Sign-in was not completed within five minutes. Try again.';

  @override
  String get tailscaleLoginHint =>
      'Signing in authorizes this device. Start the proxy to use the network.';

  @override
  String get tailscaleEnterAuthKey =>
      'Enter the auth key to log in on this device.';

  @override
  String tailscaleCheckSettings(Object fields) {
    return 'Check these settings: $fields';
  }

  @override
  String get tailscaleNotApplied => 'Not applied';

  @override
  String get tailscaleNotAppliedHint =>
      'The network is not part of the running configuration. Select a profile and make sure none of its nodes uses the same name.';

  @override
  String get tailscaleNotSignedIn => 'Not signed in';

  @override
  String get tailscaleNeedsLogin => 'Login required';

  @override
  String get tailscaleKeyExpired => 'Node key has expired';

  @override
  String get tailscaleNeedsApproval => 'Device approval is pending';

  @override
  String get tailscaleConnecting => 'Connecting';

  @override
  String get tailscaleConnected => 'Connected';

  @override
  String get tailscaleStopped => 'Stopped';

  @override
  String get tailscaleUnavailable => 'Connection unavailable';

  @override
  String get tailscaleOnline => 'Online';

  @override
  String get tailscaleOffline => 'Offline';

  @override
  String get tailscaleRemoveNetwork => 'Remove network';

  @override
  String tailscaleRemoveConfirm(Object name) {
    return 'This device will leave $name and its sign-in will be deleted from this device. If the network is unreachable now, remove the device in the Tailscale admin console.';
  }

  @override
  String tailscaleNetworkInUse(Object name, Object profile) {
    return '$name is still used by a rule or group in profile $profile';
  }

  @override
  String get tailscaleGuideGetStarted => 'Get started';

  @override
  String get tailscaleGuideGetStartedBody =>
      'Add a network and choose \"Save and log in\". Open the login page and authorize this device; sign-in completes on its own.\nTo sign in with an auth key, choose \"Auth key\" and enter it. No browser is needed.\nThe network carries traffic only while the proxy runs. Signing in alone routes nothing.';

  @override
  String get tailscaleGuideDevices => 'Devices and MagicDNS';

  @override
  String get tailscaleGuideDevicesBody =>
      'Automatic routing sends the addresses and MagicDNS names of known peers, and the subnets approved in your tailnet, into this network. Other traffic follows your rules.\nIt applies after your added and custom rules and before the profile\'s own rules.\nWith a custom control server domain, only known device names are routed, so the domain\'s public sites stay reachable.\nSubnet addresses inside the local network this device is on stay local. To reach a remote subnet with the same addresses, add a rule that points to this network.\nA hostname that resolves into an approved subnet also goes through this network. If the profile hands such a name straight to a proxy, add a domain rule that points to this network.';

  @override
  String get tailscaleGuideExitNodes => 'Exit nodes';

  @override
  String get tailscaleGuideExitNodesBody =>
      'With an exit node, the network appears in the profile\'s selector groups. Traffic uses the exit node only after you select the network there or point a rule to it.\nLeave the field empty to use no exit node. auto picks an available exit node; a device name or address picks that device.';

  @override
  String get tailscaleGuideSignIn => 'Sign-in and backup';

  @override
  String get tailscaleGuideSignInBody =>
      'Network settings are included in backups. Auth keys and the device identity stay on this device, so sign in again after restoring on another device.\nWhen the node key expires, choose \"Save and log in\" again. Device approval and access are managed in your tailnet.\nRemoving a network signs this device out and deletes its identity from this device.';

  @override
  String get tailscaleGuideTroubleshooting => 'Troubleshooting';

  @override
  String get tailscaleGuideTroubleshootingBody =>
      'Check that the proxy is running, this device is approved and the peer is online. For subnets or the Internet, also check route approval and the exit node.\n\"Not applied\" means the running configuration lacks the network: select a profile and make sure none of its nodes uses the same name.\nThis app only connects out to your tailnet. It accepts no inbound connections and never offers this device as a subnet router or exit node.';

  @override
  String get tailscaleNameInvalid => 'Use up to 64 characters without commas';

  @override
  String get tailscaleHostnameInvalid =>
      'Use lowercase letters, digits and hyphens, up to 63 characters';

  @override
  String get tailscaleAuthKeyInvalid => 'This does not look like an auth key';

  @override
  String get tailscaleDirect => 'Direct';

  @override
  String tailscaleRelay(Object region) {
    return 'Relay $region';
  }

  @override
  String get tailscaleExitNodeActive => 'Exit node in use';

  @override
  String get quickAdd => 'Quick add';

  @override
  String get rulePresetBlockQuic => 'Block QUIC';

  @override
  String get rulePresetBlockStun => 'Block STUN';

  @override
  String get rulePresetBlockDot => 'Block DNS over TLS';

  @override
  String get rulePresetBlockLoopback => 'Block proxy loopback';

  @override
  String get rulePresetLanDirect => 'LAN direct';

  @override
  String get rulePresetSystemServicesDirect => 'Apple and Microsoft direct';

  @override
  String get rulePresetBittorrentDirect => 'BitTorrent direct';

  @override
  String get rulePresetInsertHint =>
      'Add selected presets before existing rules. Identical rules are not added again.';

  @override
  String get overwriteIssueEmptyName => 'The name is empty';

  @override
  String overwriteIssueReservedName(Object name) {
    return '$name is a built-in policy name and cannot be used here';
  }

  @override
  String overwriteIssueDuplicateName(Object name) {
    return 'The name $name is already used by another proxy or proxy group';
  }

  @override
  String get overwriteIssueNoProxySource =>
      'No proxies or proxy providers are selected, so the core rejects this group';

  @override
  String overwriteIssueMissingProxies(Object names) {
    return 'These proxies or policies do not exist: $names';
  }

  @override
  String overwriteIssueMissingProviders(Object names) {
    return 'These proxy providers do not exist: $names';
  }

  @override
  String overwriteIssueEmptyFallback(Object name) {
    return 'The empty-group fallback must be an existing node or built-in outbound, not a proxy group: $name';
  }

  @override
  String overwriteIssueGroupLoop(Object path) {
    return 'Proxy groups reference each other in a loop: $path';
  }

  @override
  String invalidPolicy(Object target) {
    return '$target is an invalid policy';
  }

  @override
  String invalidRuleSet(Object ruleSet) {
    return '$ruleSet is an invalid rule set';
  }

  @override
  String invalidSubRule(Object subRule) {
    return '$subRule is an invalid SUB_RULE';
  }

  @override
  String get safeMode => 'Safe mode';

  @override
  String safeModeAppTitle(Object appName) {
    return '$appName (Safe mode)';
  }

  @override
  String get hideTimeoutProxies => 'Hide failed nodes';

  @override
  String get delayTestQueued => 'Queued';

  @override
  String get delayTestRunning => 'Testing';

  @override
  String get dnsQueries => 'DNS queries';

  @override
  String get dnsQueriesDesc => 'View the latest 500 resolver queries';

  @override
  String get dnsQueryCached => 'Cached';

  @override
  String get dnsQueryUpstream => 'Upstream';

  @override
  String get dnsQueryAnswers => 'Answers';

  @override
  String get dnsQueryRcode => 'Response code';

  @override
  String get dnsQueryType => 'Query type';

  @override
  String get pauseUpdates => 'Pause updates';

  @override
  String get resumeUpdates => 'Resume updates';

  @override
  String get dnsQueryAll => 'All queries';

  @override
  String get dnsQueryFailures => 'Failed queries';

  @override
  String get dnsQueryInitiatorApp => 'Application';

  @override
  String get dnsQueryInitiatorRule => 'Rule matching';

  @override
  String get dnsQueryInitiatorDirect => 'Direct connection';

  @override
  String get dnsQueryInitiatorProxy => 'Proxy connection';

  @override
  String get dnsQueryInitiatorOther => 'Other';

  @override
  String get action_ruleMode => 'Rule mode';

  @override
  String get action_globalMode => 'Global mode';

  @override
  String get action_directMode => 'Direct mode';

  @override
  String get action_delayTest => 'Test node latency';

  @override
  String get action_updateProfiles => 'Update profiles';

  @override
  String get action_copyEnv => 'Copy proxy environment variables';

  @override
  String get action_exit => 'Exit';

  @override
  String get hotkeyUnavailable => 'Shortcut unavailable';

  @override
  String get runTime => 'Uptime';

  @override
  String get floatingNavigationBar => 'Floating navigation';

  @override
  String get localNetworkTip =>
      'Local network access denied; using gVisor for this connection. LAN proxies and services may remain unavailable';

  @override
  String get sidebar => 'Sidebar';

  @override
  String get backgroundBlur => 'Background blur';

  @override
  String get sidebarBlurDesc =>
      'Background blur lets the desktop behind the window show through the sidebar.';

  @override
  String get format => 'Format';

  @override
  String get behavior => 'Behavior';

  @override
  String get appProviderLibrary => 'Provider library';

  @override
  String get providerLocal => 'Local file';

  @override
  String get providerRemote => 'Remote URL';

  @override
  String get providerContent => 'Resource content';

  @override
  String get providerContentInvalid =>
      'The resource content or format is invalid';

  @override
  String get providerContentTooLarge => 'The resource exceeds 32 MiB';

  @override
  String get providerChanged =>
      'The resource changed while editing; reopen it and try again';

  @override
  String get providerNameInvalid =>
      'Enter a name without commas or line breaks';

  @override
  String providerInUse(String profiles) {
    return 'This resource is still used by $profiles';
  }

  @override
  String providerRenameShadowed(String profiles) {
    return 'Renaming would change subscription resource references in $profiles';
  }

  @override
  String get providerUrlTip =>
      'Enter an HTTP or HTTPS URL without embedded credentials';

  @override
  String providerSourceReference(String profiles) {
    return 'Edit references in the source profile before renaming: $profiles';
  }

  @override
  String providerSourceUnavailable(String profiles) {
    return 'Cannot read these profiles to check references: $profiles';
  }

  @override
  String get nodeDefinition => 'Node definition';

  @override
  String get nodeQuickFields => 'Quick edit';

  @override
  String get nodeCoreValidationUnavailable =>
      'Start the Core before validating this node';

  @override
  String get nodeInvalidDefinition =>
      'Enter one complete proxy definition with a name and type';

  @override
  String get releaseMemory => 'Release memory';

  @override
  String get memoryCoreHeapInuse => 'Heap in use';

  @override
  String get memoryCoreHeapIdle => 'Heap idle';

  @override
  String get memoryCoreStack => 'Goroutine stacks';

  @override
  String get memoryCoreRuntime => 'Runtime overhead';

  @override
  String get memoryCoreNotRunning => 'Core is not running';

  @override
  String get memoryAppResident => 'Resident memory';

  @override
  String get memoryAppShared => 'App & shared';

  @override
  String get memoryEstimateDesc =>
      'Estimated from process resident memory; it may differ from what the system reports.';

  @override
  String get memoryEstimateSharedDesc =>
      'The Core runs inside the app process. Its share is estimated from runtime stats, and the rest counts as app and shared memory.';

  @override
  String get memoryReleased => 'Memory released';

  @override
  String memoryReleasedSize(Object size) {
    return 'Released $size';
  }

  @override
  String get releaseMemoryFailed => 'Failed to release memory';

  @override
  String get total => 'Total';

  @override
  String get showNotificationStopAction => 'Stop button in notification';

  @override
  String get interfaceName => 'Interface name';

  @override
  String get interfaceNameMode => 'Outbound interface';

  @override
  String get interfaceNameDesc =>
      'Interface name is the network interface outbound connections use';

  @override
  String get interfaceFollowProfile => 'Follow profile';

  @override
  String get interfaceAutomatic => 'Clear override (automatic interface)';

  @override
  String get hideIp => 'Hide IP';

  @override
  String get cameraPermissionRequired => 'Camera permission required';

  @override
  String get cameraPermissionDesc =>
      'Allow camera access in system settings to scan QR codes, or choose a QR code image from the album.';

  @override
  String get cameraUnavailable => 'Camera unavailable';

  @override
  String get invalidProfileQrcode =>
      'This QR code doesn\'t contain a profile link';

  @override
  String get pickFromAlbum => 'Choose from album';

  @override
  String get retry => 'Retry';

  @override
  String get toggleFlashlight => 'Toggle flashlight';

  @override
  String get networkTimeoutError =>
      'The request timed out. Check your network or proxy, then try again';

  @override
  String get networkHostLookupError =>
      'Couldn\'t resolve the server address. Check that the URL is correct and DNS is working';

  @override
  String get monochromeIcon => 'Monochrome icon';

  @override
  String get networkConnectionError =>
      'Couldn\'t connect to the server. Check your network connection or proxy settings';

  @override
  String get networkTlsError =>
      'Secure connection failed. The server\'s certificate may be invalid, or the connection is being intercepted';

  @override
  String get networkCancelledError => 'The request was cancelled';

  @override
  String networkAccessDeniedError(Object code) {
    return 'The server denied access (HTTP $code). The link may have expired, or the credentials are wrong';
  }

  @override
  String networkNotFoundError(Object code) {
    return 'Nothing was found at this address (HTTP $code). Check that the URL is correct';
  }

  @override
  String get networkRateLimitedError =>
      'Too many requests (HTTP 429). Wait a moment and try again';

  @override
  String networkServerError(Object code) {
    return 'The server ran into a problem (HTTP $code). Try again later';
  }

  @override
  String networkBadResponseError(Object code) {
    return 'The server rejected the request (HTTP $code)';
  }

  @override
  String get clipboardWriteFailed =>
      'Couldn\'t copy to the clipboard. The selection may be too large';

  @override
  String get lineWrap => 'Word wrap';

  @override
  String get previousMatch => 'Previous match';

  @override
  String get nextMatch => 'Next match';

  @override
  String get editorUnavailable => 'Editor unavailable';

  @override
  String get replaceAll => 'Replace all';

  @override
  String get fontSize => 'Size';

  @override
  String get replace => 'Replace';

  @override
  String get locateSelected => 'Locate selected node';

  @override
  String get expandList => 'Expand';

  @override
  String get collapseList => 'Collapse';

  @override
  String get clearSearch => 'Clear search';

  @override
  String get closeAllConnections => 'Close all connections';

  @override
  String get showMore => 'Expand';

  @override
  String get showLess => 'Collapse';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get switchProfile => 'Switch profile';

  @override
  String get subscriptionInfo => 'Subscription info';

  @override
  String get lastUpdated => 'Last updated';

  @override
  String proxiesCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count proxies',
      one: '1 proxy',
    );
    return '$_temp0';
  }

  @override
  String rulesCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rules',
      one: '1 rule',
    );
    return '$_temp0';
  }

  @override
  String get back => 'Back';

  @override
  String get noSearchResults => 'No matching results';

  @override
  String get proxyNode => 'Proxy node';

  @override
  String get rules => 'Rules';

  @override
  String get addOverrideEntry => 'Add override entry';

  @override
  String get batchAdd => 'Batch add';

  @override
  String get batchListInputTip => 'One item per line, or separated by commas';

  @override
  String get batchMapInputTip => 'One entry per line: key, a space, then value';

  @override
  String batchPreviewTip(Object count, Object skipped) {
    return '$count to add, $skipped skipped as existing';
  }

  @override
  String get cacheAlgorithm => 'Cache algorithm';

  @override
  String get cacheMaxSize => 'Cache size';

  @override
  String get dialerProxy => 'Dialer proxy';

  @override
  String get dialerProxyDesc =>
      'Dialer proxy is the outbound used to reach the NTP server';

  @override
  String dialerProxyLoopStopped(Object name) {
    return 'Dialing through $name leads back to the proxy that uses it, so the connection was stopped';
  }

  @override
  String get discardChanges => 'Discard the changes?';

  @override
  String get fakeipFilterMode => 'Fake-IP filter mode';

  @override
  String get fakeipFilterModeDesc =>
      'In Fake-IP filter mode, blacklist excludes matches, whitelist fakes only matches, and rule matches as rules';

  @override
  String get fakeipRange6 => 'Fake-IP range (IPv6)';

  @override
  String get fakeipTtl => 'Fake-IP TTL';

  @override
  String get ipv6Timeout => 'IPv6 timeout (ms)';

  @override
  String lineIssueTip(Object line, Object message) {
    return 'Line $line: $message';
  }

  @override
  String get listenRoutingMark => 'Listen routing mark';

  @override
  String get listenRoutingMarkDesc => 'Listen routing mark works only on Linux';

  @override
  String maxLengthTip(Object label, Object max) {
    return '$label must be at most $max characters';
  }

  @override
  String get ntpInterval => 'Sync interval (minutes)';

  @override
  String get ntpStatusDesc =>
      'NTP takes the time from an NTP server instead of the system clock';

  @override
  String get overrideEntries => 'Override entries';

  @override
  String get quickEdit => 'Quick edit';

  @override
  String get server => 'Server';

  @override
  String get singleAdd => 'Single add';

  @override
  String singleValueTip(Object label) {
    return '$label must be a single item';
  }

  @override
  String get writeToSystem => 'Write to system';

  @override
  String get writeToSystemDesc =>
      'Write to system also sets the system clock; Android ignores it';

  @override
  String get basicInfo => 'Basic info';

  @override
  String get ruleActionIpSuffixDesc => 'Match an IP suffix range';

  @override
  String get ruleActionDomainSuffixDesc => 'Match a domain suffix';

  @override
  String get ruleActionMatchDesc => 'Match all requests, no conditions needed';

  @override
  String get ruleActionSrcGeoipDesc => 'Match the source IP\'s country code';

  @override
  String get ruleActionDomainWildcardDesc =>
      'Wildcard match; only * and ? are supported';

  @override
  String get ruleActionAndDesc => 'Logical rule AND';

  @override
  String get ruleActionIpCidr6Desc =>
      'Match an IP address range; IP-CIDR6 is just an alias';

  @override
  String get ruleActionDomainRegexDesc => 'Match a domain regex';

  @override
  String get ruleActionProcessPathRegexDesc => 'Match by process path regex';

  @override
  String get ruleActionDstPortDesc => 'Match the destination port range';

  @override
  String get ruleActionDscpDesc =>
      'Match the DSCP mark (tproxy UDP inbound only)';

  @override
  String get ruleActionInPortDesc => 'Match the inbound port';

  @override
  String get ruleActionUidDesc => 'Match the Linux user ID';

  @override
  String get ruleActionIpCidrDesc => 'Match an IP address range';

  @override
  String get ruleActionRuleSetDesc =>
      'Reference a rule set; requires rule-providers';

  @override
  String get ruleActionGeositeDesc => 'Match domains in Geosite';

  @override
  String get ruleActionNetworkDesc => 'Match TCP or UDP';

  @override
  String get ruleActionProcessPathDesc => 'Match by the full process path';

  @override
  String get ruleActionProcessPathWildcardDesc =>
      'Match by process path wildcard; only * and ? are supported';

  @override
  String get ruleActionRematchNameDesc =>
      'Match the rematch name; separate multiple names with /';

  @override
  String get ruleActionSrcIpSuffixDesc => 'Match a source IP suffix range';

  @override
  String get ruleActionGeoipDesc => 'Match the IP\'s country code';

  @override
  String get ruleActionInUserDesc =>
      'Match the inbound username; separate multiple usernames with /';

  @override
  String get invalidNetworkContent => 'Only tcp or udp is supported';

  @override
  String get ruleActionDomainKeywordDesc => 'Match a domain keyword';

  @override
  String get ruleActionNotDesc => 'Logical rule NOT';

  @override
  String get ruleActionSrcIpAsnDesc => 'Match the source IP\'s ASN';

  @override
  String get invalidRangeContent =>
      'Enter numbers or ranges such as 80 or 8000-9000, separated by /';

  @override
  String get ruleActionProcessNameRegexDesc =>
      'Match by process name regex; matches the package name on Android';

  @override
  String get ruleActionSrcIpCidrDesc => 'Match a source IP address range';

  @override
  String get ruleActionDomainDesc => 'Match the full domain';

  @override
  String get ruleActionInNameDesc => 'Match the inbound name';

  @override
  String get invalidDscpContent => 'A DSCP mark cannot exceed 63';

  @override
  String get invalidCidrContent =>
      'Enter an IP range in CIDR form such as 192.168.0.0/16';

  @override
  String get invalidIpv6CidrContent =>
      'Enter an IPv6 range in CIDR form such as fd00::/8';

  @override
  String get invalidHostContent => 'Enter a domain or an IP address';

  @override
  String get invalidListenContent =>
      'Enter an address and port such as 0.0.0.0:1053';

  @override
  String get ruleActionIpAsnDesc => 'Match the IP\'s ASN';

  @override
  String get ruleActionSrcPortDesc => 'Match the source port range';

  @override
  String get ruleActionInTypeDesc => 'Match the inbound type';

  @override
  String get ruleActionOrDesc => 'Logical rule OR';

  @override
  String get ruleActionSubRuleDesc =>
      'Match into a sub-rule; mind the parentheses';

  @override
  String get ruleActionProcessNameWildcardDesc =>
      'Match by process name wildcard; only * and ? are supported';

  @override
  String get ruleActionProcessNameDesc =>
      'Match by process name; matches the package name on Android';

  @override
  String get general => 'General';

  @override
  String get startupAndBackground => 'Startup and background';

  @override
  String get inbound => 'Inbound';

  @override
  String get outbound => 'Outbound';

  @override
  String get logsAndDiagnostics => 'Logs and diagnostics';

  @override
  String get onDemand => 'On demand';

  @override
  String get onDemandDesc =>
      'On demand pauses and resumes the proxy by Wi-Fi or network conditions';

  @override
  String get prerequisites => 'Prerequisites';

  @override
  String get suspended => 'Suspended…';

  @override
  String get enabled => 'Enabled';

  @override
  String get enabledOnStart => 'Enable on start';

  @override
  String get disabled => 'Disabled';

  @override
  String overwriteIssuesSummary(Object count) {
    return '$count items have problems, and applying this override may fail';
  }

  @override
  String get ignoreBatteryOptimization => 'Ignore battery optimization';

  @override
  String get batteryOptimizationDesc =>
      'Ignore battery optimization keeps the app running in the background';

  @override
  String get batteryOptimizationStatusTip =>
      'Due to system limitations, the battery optimization status cannot be read correctly while running';

  @override
  String get authorized => 'Authorized';

  @override
  String get tapToAuthorize => 'Tap to authorize';

  @override
  String get addSsid => 'Add SSID';

  @override
  String get editSsid => 'Edit SSID';

  @override
  String get ssidsEmpty => 'SSIDs are empty';

  @override
  String get hotkeyDesc =>
      'Global hotkeys work even while the window is hidden. Tap an action to record its key combination.';

  @override
  String get hotkeyNotSet => 'Not set';

  @override
  String hotkeyNeedsModifier(Object modifiers) {
    return 'Include at least one of $modifiers';
  }

  @override
  String hotkeyConflictWith(Object action) {
    return 'Already used by “$action”. Saving moves it here.';
  }

  @override
  String get confirmExitWindow =>
      'Are you sure you want to exit the current window?';

  @override
  String get dataChangedSave => 'Data changes detected. Save them?';

  @override
  String get discard => 'Discard';

  @override
  String get docked => 'Docked';

  @override
  String get fade => 'Fade';

  @override
  String get floating => 'Floating';

  @override
  String get followSystem => 'Follow system';

  @override
  String get navigationBarStyle => 'Bottom bar';

  @override
  String get pureBlack => 'Pure black';

  @override
  String get slide => 'Slide';

  @override
  String get textScalePreview => 'Text in the app will look like this';

  @override
  String get basicStrategy => 'Basic strategies';

  @override
  String get nonTextProviderFile => 'This external resource is not a text file';

  @override
  String get scriptChanged =>
      'The script changed or was deleted. Reopen it and try again.';

  @override
  String get startFromScratch => 'Start from scratch';

  @override
  String get optional => 'Optional';

  @override
  String get coreBlockedBySmartAppControlTip =>
      'Windows blocked FlClashCore.exe, and Smart App Control is enabled. Check the block details in Windows Security → App & browser control, and use a trusted, verified release.';

  @override
  String get helperCorruptTip =>
      'Helper service unavailable; TUN mode cannot be enabled. Reinstall FlClash to restore it.';

  @override
  String get changeProxyFailedTip =>
      'Failed to switch proxy; the previous selection has been restored';

  @override
  String get databaseWriteFailedTip =>
      'Failed to save the change. Please check the current value and try again.';

  @override
  String get proxyType => 'Proxy type';

  @override
  String get providerSourceSubscription => 'Subscription';

  @override
  String get providerSourceProfile => 'Profile';

  @override
  String get providerSourceApp => 'App library';

  @override
  String get target => 'Target';

  @override
  String get outboundExit => 'Exit';

  @override
  String get protocol => 'Protocol';

  @override
  String get traffic => 'Traffic';

  @override
  String get totalDownload => 'Downloaded';

  @override
  String get totalUpload => 'Uploaded';

  @override
  String get duration => 'Duration';

  @override
  String get initiatorShort => 'From';

  @override
  String get result => 'Result';

  @override
  String get elapsed => 'Took';

  @override
  String get tunOverrideDesc =>
      'Entries added here replace the TUN settings of every profile; anything not added keeps the profile\'s own setting. Entries a custom profile adds itself take precedence';

  @override
  String get dnsOverrideDesc =>
      'Entries added here replace the DNS settings of every profile; anything not added keeps the profile\'s own setting. Entries a custom profile adds itself take precedence';

  @override
  String get ntpOverrideDesc =>
      'Entries added here replace the NTP settings of every profile; anything not added keeps the profile\'s own setting. Entries a custom profile adds itself take precedence';

  @override
  String get congestionController => 'TCP congestion control';

  @override
  String get congestionControllerDesc =>
      'TCP congestion control works only with the mips stack';

  @override
  String get strictRoute => 'Strict route';

  @override
  String get strictRouteDesc =>
      'Strict route keeps traffic such as DNS from bypassing TUN, and with IPv6 off it blocks this device\'s IPv6 connections';

  @override
  String get routeExcludeAddress => 'Route exclude addresses';

  @override
  String get udpTimeout => 'UDP timeout';

  @override
  String get udpTimeoutDesc =>
      'The UDP timeout is in seconds and works only with the gvisor, system and mixed stacks';

  @override
  String get dnsHijackDesc =>
      'Without this entry, TUN hijacks every DNS query to port 53 (any:53)';

  @override
  String get disableIcmpForwarding => 'Disable ICMP forwarding';

  @override
  String get disableIcmpForwardingDesc =>
      'With ICMP forwarding disabled, TUN answers ping itself, so ping no longer shows the real latency';

  @override
  String get includeInterface => 'Included interfaces';

  @override
  String get includeInterfaceDesc =>
      'Only traffic arriving on included interfaces goes through TUN, and excluded interfaces no longer apply';

  @override
  String get excludeInterface => 'Excluded interfaces';

  @override
  String get excludeInterfaceDesc =>
      'Traffic arriving on excluded interfaces, such as docker0, skips TUN';

  @override
  String get includeUid => 'Included user IDs';

  @override
  String get includeUidDesc =>
      'Only traffic from processes of included user IDs goes through TUN';

  @override
  String get excludeUid => 'Excluded user IDs';

  @override
  String get excludeUidDesc =>
      'Traffic from processes of excluded user IDs skips TUN';

  @override
  String get excludeSrcPort => 'Excluded source ports';

  @override
  String get excludeSrcPortDesc =>
      'Traffic from excluded source ports skips TUN';

  @override
  String get excludeDstPort => 'Excluded destination ports';

  @override
  String get excludeDstPortDesc =>
      'Traffic to excluded destination ports skips TUN';

  @override
  String numberRangeTip(Object label, Object min, Object max) {
    return '$label must be between $min and $max';
  }

  @override
  String get customProfile => 'Custom profile';

  @override
  String get customProfileDesc =>
      'Assemble proxy groups and rules from your own nodes, the provider library and other profiles';

  @override
  String get emptyCustomProfile =>
      'Add a proxy group or a rule to this custom profile first';

  @override
  String get nameCustomProfileTip => 'Name this custom profile';

  @override
  String profileProviderInUse(Object profiles) {
    return 'This profile is a proxy provider of $profiles. Remove it there first.';
  }

  @override
  String get healthCheck => 'Health check';

  @override
  String get additionalPrefix => 'Name prefix';

  @override
  String get additionalSuffix => 'Name suffix';

  @override
  String get ipVersion => 'IP version';

  @override
  String get profileSettingsDesc =>
      'Applies to this profile only; anything not added uses its default';

  @override
  String get profileOverrideSettingsDesc =>
      'Applies to this profile only and takes precedence over the override entries in the app\'s DNS and NTP settings; anything not added follows those entries';

  @override
  String get profileTunSettingsDesc =>
      'Applies to this profile only and takes precedence over the TUN override entries in the network settings';

  @override
  String get settingEntries => 'settings';

  @override
  String get addSettingEntry => 'Add setting';

  @override
  String settingsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count settings',
      one: '1 setting',
    );
    return '$_temp0';
  }

  @override
  String get sniffer => 'Sniffer';

  @override
  String get snifferStatusDesc =>
      'The sniffer reads the domain from TLS, HTTP and QUIC traffic so rules can match it';

  @override
  String get overrideDestination => 'Override destination';

  @override
  String get overrideDestinationDesc =>
      'Override destination connects to the sniffed domain instead of the original address';

  @override
  String get forceDnsMapping => 'Force DNS mapping';

  @override
  String get forceDnsMappingDesc =>
      'Force DNS mapping also sniffs connections whose domain came from a DNS mapping';

  @override
  String get parsePureIp => 'Parse pure IP';

  @override
  String get parsePureIpDesc =>
      'Parse pure IP sniffs connections that carry only an IP address';

  @override
  String get forceDomain => 'Force domains';

  @override
  String get forceDomainDesc =>
      'Force domains are sniffed too; other connections that already have a domain are left alone';

  @override
  String get skipDomain => 'Skip domains';

  @override
  String get skipDomainDesc =>
      'A sniffed domain on the Skip domains list is not used';

  @override
  String get skipSrcAddress => 'Skip source addresses';

  @override
  String get skipDstAddress => 'Skip destination addresses';

  @override
  String get sniffProtocols => 'Protocols';

  @override
  String get ports => 'Ports';

  @override
  String get invalidPortRangeContent =>
      'Enter a port or a range such as 443 or 8000-9000';

  @override
  String get importConfig => 'Import config';

  @override
  String get importText => 'Import from text';

  @override
  String get importConfigInvalid => 'This is not a config that can be imported';

  @override
  String get importConfigReplaceTip =>
      'Importing replaces the nodes, proxy groups, rules and settings this profile has now';

  @override
  String get customImportCloudRefused =>
      'oixCloud addresses cannot be imported into a custom profile';

  @override
  String get customImportNotImported => 'Not imported';

  @override
  String customImportDroppedSubRules(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count SUB-RULE rules were dropped, since custom profiles do not support sub-rules',
      one: '1 SUB-RULE rule was dropped, since custom profiles do not support sub-rules',
    );
    return '$_temp0';
  }

  @override
  String customImportUnnamedProxies(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count proxies had no name or type',
      one: '1 proxy had no name or type',
    );
    return '$_temp0';
  }

  @override
  String failedItem(Object label, Object message) {
    return '$label: $message';
  }

  @override
  String shareLinkNodesAdded(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nodes were added from the share links',
      one: '1 node was added from the share links',
    );
    return '$_temp0';
  }

  @override
  String shareLinksNotRead(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count links could not be read',
      one: '1 link could not be read',
    );
    return '$_temp0';
  }

  @override
  String get connectionStats => 'Connection stats';

  @override
  String get connectionStatsDesc =>
      'Live connections, recent requests and DNS queries';

  @override
  String get currentOutboundDesc =>
      'Holds the start button and can\'t be removed';

  @override
  String get dashboardAddableSection => 'Available to add';

  @override
  String get dashboardReorderHint =>
      'Drag cards to reorder; touch and hold first on touchscreens';

  @override
  String get done => 'Done';

  @override
  String get editDashboard => 'Edit dashboard';

  @override
  String groupCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count groups',
      one: '1 group',
    );
    return '$_temp0';
  }

  @override
  String get groupCountUnit => 'groups';

  @override
  String groupTimeoutCount(Object count) {
    return '$count timed out';
  }

  @override
  String get ipType => 'Type';

  @override
  String get liveConnections => 'Live connections';

  @override
  String get memoryInfoDesc => 'Memory the app and the core use';

  @override
  String get networkTakeover => 'Traffic takeover';

  @override
  String get notRunning => 'Not running';

  @override
  String portValue(Object port) {
    return 'Port $port';
  }

  @override
  String profileDaysLeft(num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days left',
      one: '1 day left',
    );
    return '$_temp0';
  }

  @override
  String profileExpiresIn(Object date, num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days',
      one: '1 day',
    );
    return 'Expires $date, $_temp0 left';
  }

  @override
  String profileUpdatedAt(Object time) {
    return 'Updated $time';
  }

  @override
  String get proxyGroupsAfterStart =>
      'Groups show up here once the core starts';

  @override
  String get running => 'Running';

  @override
  String get serviceFailed => 'Check failed';

  @override
  String get tapIconToRetry => 'Tap the icon to retry';

  @override
  String trafficPeak(Object value) {
    return 'Peak $value';
  }

  @override
  String trafficTotal(Object value) {
    return 'Total $value';
  }

  @override
  String get usedShort => 'used';

  @override
  String get disableKeepAlive => 'Disable TCP keep-alive';

  @override
  String get keepAliveIdle => 'TCP keep-alive idle';

  @override
  String get routingMark => 'Routing mark';

  @override
  String get minutes => 'minutes';

  @override
  String yearsAgoShort(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '${count}y ago',
    );
    return '$_temp0';
  }

  @override
  String monthsAgoShort(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '${count}mo ago',
    );
    return '$_temp0';
  }

  @override
  String daysAgoShort(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '${count}d ago',
    );
    return '$_temp0';
  }

  @override
  String hoursAgoShort(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '${count}h ago',
    );
    return '$_temp0';
  }

  @override
  String minutesAgoShort(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '${count}m ago',
    );
    return '$_temp0';
  }

  @override
  String get expireTime => 'Expiration time';

  @override
  String get runtimeConfig => 'Runtime config';

  @override
  String proxyGroupsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count proxy groups',
      one: '1 proxy group',
    );
    return '$_temp0';
  }

  @override
  String get confirmDeleteProxyGroup =>
      'Are you sure you want to delete this proxy group?';

  @override
  String invalidProxyProvider(Object providerName) {
    return '$providerName is an invalid proxy provider';
  }

  @override
  String customIssuesSummary(Object count) {
    return '$count items have problems, and applying this profile may fail';
  }

  @override
  String sectionsInEffect(Object count) {
    return '$count in effect';
  }

  @override
  String get emptyFallback => 'Empty fallback';

  @override
  String get testInterval => 'Test interval';

  @override
  String get testWhenUsed => 'Test when used';

  @override
  String get defaultSelected => 'Default selection';

  @override
  String get hashByInUser => 'Hash by inbound user';

  @override
  String get nodes => 'Nodes';

  @override
  String get addNodes => 'Add nodes';

  @override
  String get autoInclude => 'Auto-include';

  @override
  String get filters => 'Filters';

  @override
  String get inputProxyGroupName => 'Enter the proxy group name';

  @override
  String get definitionNotMap =>
      'The configuration must be a YAML mapping with a name and a type';

  @override
  String get additionalParameters => 'Additional parameters';

  @override
  String get quickActions => 'Quick actions';

  @override
  String get ruleListInvalid =>
      'The rules must be a YAML list with one rule per item, such as - DOMAIN,example.com,DIRECT';

  @override
  String get goToConfigureAddedRules => 'Go to added rules configuration';

  @override
  String get large => 'Large';

  @override
  String get extraLarge => 'Extra large';

  @override
  String get matchCase => 'Match case';

  @override
  String get regex => 'Regex';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get error => 'Error';

  @override
  String get iconSets => 'Icon sets';

  @override
  String get localImage => 'Local image';

  @override
  String get label => 'Label';

  @override
  String get iconSetsEmptyTip =>
      'No icon sets yet. Add them in Custom profile resources → Icon sets';

  @override
  String get recommendedIcons => 'Suggested';

  @override
  String get customProfileResources => 'Custom profile resources';

  @override
  String get importFromLink => 'Import from link';

  @override
  String get sendFromPhone => 'Send from phone';

  @override
  String get sendFromPhoneTip =>
      'Scan the code with your phone\'s camera and paste the link on the page that opens. Both devices need to be on the same network.';

  @override
  String get sendFromPhoneNoNetwork =>
      'This device is not connected to a local network';

  @override
  String get sendFromPhonePermissionDenied =>
      'Receiving a link from your phone needs the Nearby devices permission, which lets FlClash reach the local network. Turn it on in the app\'s settings.';

  @override
  String get sendFromPhonePageTitle => 'Send a link to FlClash';

  @override
  String get sendFromPhonePageHint => 'Subscription link or proxy share link';

  @override
  String get send => 'Send';

  @override
  String get sendFromPhonePageSent =>
      'Sent. Confirm the import on the other device.';

  @override
  String get sendFromPhoneConfirmTitle => 'Import the link from your phone?';

  @override
  String get shareQrcodeTip =>
      'Scan with FlClash on another device to import this profile.';

  @override
  String get qrcodeTooLongTip =>
      'This link is too long for a QR code. Use Copy link instead.';

  @override
  String get invalidLinkTip => 'Not a subscription link or a proxy share link';

  @override
  String get batchLinkInputTip => 'One link per line';

  @override
  String get link => 'Link';

  @override
  String get allowedIps => 'Allowed IPs';

  @override
  String get cipher => 'Cipher';

  @override
  String get clientFingerprint => 'Client fingerprint';

  @override
  String get requestHeaders => 'Request headers';

  @override
  String transportHeaders(Object transport) {
    return '$transport Headers';
  }

  @override
  String get congestionControl => 'Congestion control';

  @override
  String get downloadBandwidth => 'Download bandwidth';

  @override
  String get hopInterval => 'Hop interval';

  @override
  String get obfs => 'Obfuscation';

  @override
  String get obfsHost => 'Obfuscation host';

  @override
  String get obfsMode => 'Obfuscation mode';

  @override
  String get obfsParam => 'Obfuscation parameter';

  @override
  String get obfsPassword => 'Obfuscation password';

  @override
  String get plugin => 'Plugin';

  @override
  String get pluginHost => 'Plugin host';

  @override
  String get pluginPath => 'Plugin path';

  @override
  String get pluginUsername => 'Plugin username';

  @override
  String get pluginPassword => 'Plugin password';

  @override
  String get pluginCipher => 'Plugin cipher';

  @override
  String get pluginMode => 'Plugin mode';

  @override
  String get portHopping => 'Port hopping';

  @override
  String get preSharedKey => 'Pre-shared key';

  @override
  String get privateKey => 'Private key';

  @override
  String get privateKeyPassphrase => 'Private key passphrase';

  @override
  String get protocolParam => 'Protocol parameter';

  @override
  String get protocolVersion => 'Protocol version';

  @override
  String get publicKey => 'Public key';

  @override
  String get remoteDnsResolve => 'Remote DNS resolution';

  @override
  String get secretKey => 'Key';

  @override
  String get skipCertVerify => 'Skip certificate verification';

  @override
  String get transport => 'Transport';

  @override
  String get udpRelayMode => 'UDP relay mode';

  @override
  String get uploadBandwidth => 'Upload bandwidth';

  @override
  String get username => 'Username';

  @override
  String get networkName => 'Network name';

  @override
  String get networkSecret => 'Network secret';

  @override
  String get peers => 'Peers';

  @override
  String get virtualIpv4 => 'Virtual IPv4';

  @override
  String get hostname => 'Hostname';

  @override
  String get exitNodes => 'Exit nodes';

  @override
  String get ageSecretKey => 'Age secret key';

  @override
  String get ageSecretKeyRequiredTip =>
      'This profile is encrypted with age and needs an age secret key to decrypt';

  @override
  String get ageDecryptFailedTip =>
      'Could not decrypt the profile. Check the age secret key and try again.';

  @override
  String get resetDns => 'Reset DNS';

  @override
  String get resetDnsSuccess => 'DNS state cleared';

  @override
  String get resetDnsFailed =>
      'Could not reset DNS. Check that the core is connected and try again.';

  @override
  String resourceSizeLimitTip(Object limit) {
    return 'The resource exceeds $limit';
  }

  @override
  String get ruleSetDetect => 'Detect format and behavior';

  @override
  String get ruleSetConvert => 'Convert to MRS';

  @override
  String get ruleSetConvertRemote => 'Download as local MRS';

  @override
  String get ruleSetEmptyTip => 'The rule set has no usable entries';

  @override
  String get ruleSetMixedTip =>
      'The rule set mixes bare domains and IP ranges; use classical rules to combine them';

  @override
  String get ruleSetInvalidTip =>
      'Unable to read this rule set. Check its format and entries';

  @override
  String get ruleSetUnsupportedTip =>
      'These rules cannot be converted to MRS without changing their behavior';

  @override
  String get ruleSetBusyTip =>
      'Another rule set operation is running. Try again shortly';

  @override
  String get ruleSetNeedsConversionTip =>
      'This remote rule set needs normalization. Download it as local MRS to use it';

  @override
  String get ruleSetSizeTip =>
      'The rule set exceeds the processing limit. Split it into smaller sets';

  @override
  String get providerLookupFailed =>
      'Unable to read the active node configuration. Refresh the resource and try again.';

  @override
  String get lookupProxyConfig => 'Find node configuration';

  @override
  String get tunDnsMode => 'System DNS mode';

  @override
  String get tunDnsModeDesc =>
      'Empty keeps the previous behavior. disabled leaves system DNS unchanged; native uses the TUN address; hijack also intercepts DNS on other interfaces (Windows requires strict-route; Linux requires auto-redirect). An explicit mode takes precedence over automatic system DNS on macOS.';

  @override
  String get nodeShareLinkUnavailable =>
      'This node cannot be represented by a share link; use fields or YAML';

  @override
  String shareLinkNodesPreserved(int count) {
    return '$count nodes cannot be represented by links and will be kept unchanged';
  }

  @override
  String get select => 'Select';

  @override
  String get preferred => 'Preferred';

  @override
  String get addToLocalProxies => 'Add to custom nodes';

  @override
  String addedToLocalProxies(Object name) {
    return 'Added $name to custom nodes';
  }

  @override
  String alreadyInLocalProxies(Object name) {
    return '$name is already in custom nodes';
  }

  @override
  String get generalOverrideDesc =>
      'Entries added here replace the setting of every profile; anything not added keeps the profile\'s own setting, or the core default when the profile has none.';

  @override
  String get groupBy => 'Group by';

  @override
  String get copyHost => 'Copy host';

  @override
  String get copyDestination => 'Copy destination';

  @override
  String get closeConnection => 'Close connection';

  @override
  String get recentRequests => 'Recent requests';

  @override
  String get root => 'Root';

  @override
  String get mitm => 'MITM';

  @override
  String get httpsDecryption => 'HTTPS decryption';

  @override
  String get httpCapture => 'HTTP capture';

  @override
  String get httpCaptureDesc =>
      'Records requests to the hosts listed under Hostname, to view in connection details. Records stay in memory only.';

  @override
  String get httpCaptureNoHosts =>
      'No host is listed, so nothing is recorded. Add hosts under Hostname on the MITM page, or from the details of a connection.';

  @override
  String get httpCaptureLimit => 'Maximum records';

  @override
  String httpCaptureLimitDesc(Object memory, Object body) {
    return 'The oldest records go first once this many are kept or they fill $memory of memory. Each body keeps its first $body.';
  }

  @override
  String get httpRequests => 'HTTP requests';

  @override
  String get httpRequestsMissing =>
      'Requests made before capture was on, or since cleared, are not listed.';

  @override
  String get httpRequestCleared => 'This request is no longer kept';

  @override
  String get httpCaptureOff => 'Capture is off';

  @override
  String get inProgress => 'In progress';

  @override
  String get method => 'Method';

  @override
  String get originalUrl => 'Original URL';

  @override
  String get timeToFirstByte => 'Time to first byte';

  @override
  String get requestBody => 'Request body';

  @override
  String get response => 'Response';

  @override
  String get responseBody => 'Response body';

  @override
  String get responseHeaders => 'Response headers';

  @override
  String get matchedRules => 'Matched rules';

  @override
  String get overview => 'Overview';

  @override
  String get viewAll => 'View all';

  @override
  String get copyAsBase64 => 'Copy as Base64';

  @override
  String get copyAsCurl => 'Copy as cURL';

  @override
  String get copyRequest => 'Copy request';

  @override
  String get copyResponse => 'Copy response';

  @override
  String get copyResponseBody => 'Copy response body';

  @override
  String get httpBodyProtobufGuess =>
      'Read as Protobuf without its schema: field numbers only, and the types are guesses.';

  @override
  String get exportHar => 'Export HAR';

  @override
  String get mitmAddRejectRule => 'Add a reject rule';

  @override
  String get mitmAddMapLocalRule => 'Add a map local rule';

  @override
  String get httpExportPrivateTitle => 'Contains private data';

  @override
  String get httpExportPrivate =>
      'A request can carry cookies, tokens, passwords and form contents. Check what you share, and with whom.';

  @override
  String get mitmRuleCopiedForStash =>
      'This module is a Stash override, so the rule was copied for you to add by hand.';

  @override
  String get binaryData => 'Binary data';

  @override
  String get httpBodyNotKept => 'Not recorded while memory was short.';

  @override
  String get httpBodyTruncated => 'Only the start of this body was recorded.';

  @override
  String httpBodyUndecoded(Object encoding) {
    return 'Could not decode $encoding, so this is the data as it was sent.';
  }

  @override
  String get mitmEnableTip =>
      'FlClash will be able to read everything sent to the decrypted hosts, cookies and passwords included. Turn this on only for hosts you mean to rewrite.';

  @override
  String get certificate => 'Certificate';

  @override
  String get generateCertificate => 'Generate certificate';

  @override
  String get regenerateCertificate => 'Regenerate certificate';

  @override
  String get regenerateCertificateTip =>
      'The new certificate replaces the current one, which FlClash takes out of this device\'s trusted roots where it can. Every other device that trusts the current one has to install the new one.';

  @override
  String get exportCertificate => 'Export certificate';

  @override
  String get installCertificate => 'Install to system';

  @override
  String get installCertificateSuccess => 'Certificate installed';

  @override
  String validUntil(Object date) {
    return 'Valid until $date';
  }

  @override
  String get mitmCertificateExportTip =>
      'Export it and trust it on the devices you want to decrypt.';

  @override
  String get mitmTrustReady => 'Trusted';

  @override
  String get mitmTrustUntrusted => 'Not fully trusted';

  @override
  String get mitmTrustNotInstalled => 'Not installed';

  @override
  String get mitmTrustChecking => 'Checking…';

  @override
  String get trustCertificate => 'Trust certificate';

  @override
  String get mitmCertificateAndroidReadyTip =>
      'Only apps that trust user certificates, mostly browsers, are decrypted.';

  @override
  String get mitmCertificateLinuxTip =>
      'Flatpak browsers need the exported certificate imported by hand.';

  @override
  String mitmCertutilMissing(Object command) {
    return 'Chrome and Firefox keep their own certificate stores, which need certutil: $command';
  }

  @override
  String mitmMissingStores(Object stores) {
    return 'Not yet in: $stores';
  }

  @override
  String get mitmSystemStoreFailed =>
      'Adding the certificate to the system\'s trusted roots failed';

  @override
  String get mitmRootUntilReboot =>
      'No Magisk, KernelSU or APatch was found to keep the certificate. Install it again after the device restarts.';

  @override
  String get mitmRootPendingReboot =>
      'The certificate takes effect after the device restarts.';

  @override
  String get mitmInstallSystemCaTip =>
      'Root was found, so the certificate goes into the system\'s trusted certificates as a FlClash MITM CA module for Magisk, KernelSU or APatch. Every app on this device will then trust it, and anyone holding its private key could decrypt this device\'s HTTPS traffic. To undo it, regenerate the certificate or remove the module in the root manager and restart. If root is denied, it is installed as a user certificate instead.';

  @override
  String get mitmInstallUserCaTip =>
      'No root was found, so the certificate can only be installed as a user certificate. Only apps that trust user certificates, mostly browsers, are decrypted; other apps fail on the hosts you list, so leave those hosts out. On Android 11 and later you finish the install yourself in system settings.';

  @override
  String mitmCertificateSavedTip(Object fileName) {
    return 'Saved $fileName to Downloads. Install it in Settings under Security › Encryption & credentials › Install a certificate › CA certificate.';
  }

  @override
  String get openSettings => 'Open settings';

  @override
  String mitmRemoveOldCertificateTip(Object name) {
    return 'Remove the old certificate, $name, in Settings under Security › Encryption & credentials › Trusted credentials › User, then install the new one.';
  }

  @override
  String mitmOldCertificateLeftTip(Object name) {
    return 'The old certificate, $name, could not be removed. Remove it from the trusted roots yourself.';
  }

  @override
  String mitmOldSystemCertificateLeftTip(Object name) {
    return 'The old certificate, $name, is still among the system\'s trusted CAs. Allow FlClash root access in your root manager and regenerate, or remove the FlClash MITM CA module there and restart.';
  }

  @override
  String get mitmDecryptHost => 'Decrypt this host';

  @override
  String mitmDecryptHostTip(Object host) {
    return 'Add $host to the hostname list? FlClash can then read what is sent to it, cookies and passwords included.';
  }

  @override
  String get mitmClientRefusedCertificate =>
      'The client refused the certificate. Install the CA, or exclude this host if the app pins its certificate.';

  @override
  String get mitmExcludeHost => 'Exclude from decryption';

  @override
  String mitmExcludeHostTip(Object host) {
    return 'Add -$host to the top of the hostname list? The host is then never decrypted.';
  }

  @override
  String get urlRewrite => 'URL rewrite';

  @override
  String get headerRewrite => 'Header rewrite';

  @override
  String get bodyRewrite => 'Body rewrite';

  @override
  String get mapLocal => 'Map local';

  @override
  String get mitmHostnameDesc =>
      'A leading - excludes a host, and the first match decides.';

  @override
  String get mitmModules => 'Modules';

  @override
  String get mitmModule => 'Module';

  @override
  String get mitmModuleInvalid =>
      'This is not a Surge module, a Loon plugin, a Quantumult X snippet or a Stash override';

  @override
  String get arguments => 'Arguments';

  @override
  String get mitmRoutingRules => 'Routing rules';

  @override
  String get mitmIgnoredLines => 'Ignored lines';

  @override
  String get mitmModuleRulesDesc =>
      'Routing rules go in front of the profile’s own.';

  @override
  String mitmModuleSystemTip(Object system) {
    return 'Written for $system; some lines may not match apps on this device.';
  }

  @override
  String mitmSkipSection(Object section) {
    return 'The [$section] section is not supported';
  }

  @override
  String get mitmSkipSetting => 'This setting is not supported';

  @override
  String get mitmSkipScriptType => 'This script type is not supported';

  @override
  String get mitmSkipRule => 'This rule type is not supported';

  @override
  String get mitmSkipPolicy =>
      'Only the DIRECT and REJECT policies are supported';

  @override
  String get mitmSkipJq => 'jq rewrites are not supported';

  @override
  String get mitmSkipJsonBody => 'JSON body rewrites are not supported';

  @override
  String get mitmSkipRawHeader =>
      'Rewriting all headers as one text is not supported';

  @override
  String get mitmSkipConditional => 'Conditional rewrites are not supported';

  @override
  String get mitmSkipRelativeData =>
      'The file this line names is not attached; use a URL or attach it';

  @override
  String get mitmSkipNotDownloaded => 'Its file has not been downloaded';

  @override
  String get mitmSkipUnreadable => 'This line cannot be read';

  @override
  String get mitmAddLocalFile => 'Add a local file';

  @override
  String get mitmNewModule => 'New module';

  @override
  String get mitmAttachments => 'Attachments';

  @override
  String get mitmAttachmentsDesc =>
      'Lines refer to attachments by file name, as in script-path=a.js.';

  @override
  String mitmFileTooLarge(Object size) {
    return 'The file is larger than $size MB';
  }

  @override
  String get mitmSkipDisabled => 'Turned off by an argument';

  @override
  String get mitmSkipEvent => 'This event is not supported';

  @override
  String get mitmRunScript => 'Run now';

  @override
  String get mitmScriptNoOutput => 'The script finished without output';

  @override
  String get mitmScriptRiskTitle => 'Run this module\'s scripts?';

  @override
  String get mitmScriptRisk =>
      'Its scripts read and change the traffic of the hosts they match, cookies and tokens included, and can send requests of their own. Turn it on only if you trust where it comes from.';

  @override
  String get skipServerCertVerify => 'Skip server certificate verification';

  @override
  String get http2 => 'HTTP/2';

  @override
  String get decryptUntrusted => 'Decrypt without local trust';

  @override
  String invalidOfCount(Object invalid, Object total) {
    return '$invalid of $total invalid';
  }

  @override
  String mitmModuleScriptsChanged(Object name) {
    return '$name changed its scripts and was turned off';
  }

  @override
  String failedCount(Object count) {
    return '$count items failed. Tap to view';
  }

  @override
  String get proxyServerNameserverDesc =>
      'Resolves proxy server hostnames only.';

  @override
  String get proxyServerNameserverPolicyDesc =>
      'Matching proxy server hostnames use the DNS server given here instead of Proxy Server Nameserver.';

  @override
  String get directNameserverDesc =>
      'Resolves domains for connections that go direct.';

  @override
  String get fakeipFilterDesc =>
      'These domains get real IPs instead of Fake-IPs. In whitelist mode, only they get Fake-IPs.';

  @override
  String get fallbackFilterGeositeDesc =>
      'Domains in these GeoSite categories are resolved by Fallback directly.';

  @override
  String get fallbackFilterIpcidrDesc =>
      'When Nameserver returns an IP in these ranges, the Fallback answer is used.';

  @override
  String get fallbackFilterDomainDesc =>
      'These domains are resolved by Fallback directly.';

  @override
  String get customResources => 'Custom';

  @override
  String get proxyYieldsToSubscription =>
      'A subscription node has this name, so this profile uses that one';

  @override
  String get delayMeasurementUnknown => 'Measurement time unavailable';

  @override
  String delayMeasuredAt(String time) {
    return 'Last tested: $time';
  }

  @override
  String get delayMeasurementStale => 'Old result; test again';

  @override
  String get diagUdp => 'UDP connectivity';

  @override
  String get diagUdpReady => 'A UDP round trip succeeded';

  @override
  String get diagUdpUnknown => 'UDP connectivity could not be confirmed';

  @override
  String get diagUdpUnsupported => 'This route does not support UDP';

  @override
  String get diagUdpHint =>
      'Tests follow the current routing rules. A timeout may be caused by the test server or network; it does not prove all UDP traffic is blocked.';

  @override
  String get diagTimeline => 'Recent operation history';

  @override
  String diagTimelineEvent(
    String time,
    String stage,
    String result,
    String code,
  ) {
    return '$time · $stage · $result $code';
  }

  @override
  String get diagStageFetch => 'Fetch configuration';

  @override
  String get diagStageValidate => 'Validate configuration';

  @override
  String get diagStageApply => 'Apply configuration';

  @override
  String get diagStageStart => 'Start VPN';

  @override
  String get diagStageStop => 'Stop VPN';

  @override
  String get diagEventStarted => 'Started';

  @override
  String get diagEventSucceeded => 'Succeeded';

  @override
  String get diagEventFailed => 'Failed';

  @override
  String get diagEventUnchanged => 'Content unchanged';

  @override
  String get diagEventCanceled => 'Canceled';

  @override
  String get diagRecorded => 'History';
}

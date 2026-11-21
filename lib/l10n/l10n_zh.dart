// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get applyNow => '立即应用';

  @override
  String get rule => '规则';

  @override
  String get global => '全局';

  @override
  String get direct => '直连';

  @override
  String get dashboard => '仪表盘';

  @override
  String get proxies => '代理';

  @override
  String get profile => '配置';

  @override
  String get profiles => '配置';

  @override
  String get tools => '工具';

  @override
  String get logs => '日志';

  @override
  String get logsDesc => '日志捕获记录';

  @override
  String get resources => '资源';

  @override
  String get resourcesDesc => '外部资源相关信息';

  @override
  String get trafficUsage => '流量统计';

  @override
  String get networkSpeed => '网络速度';

  @override
  String get outboundMode => '出站模式';

  @override
  String get networkDetection => '网络检测';

  @override
  String get upload => '上传';

  @override
  String get download => '下载';

  @override
  String get noProxy => '暂无代理';

  @override
  String get nullProfileDesc => '没有配置文件,请先添加配置文件';

  @override
  String get settings => '设置';

  @override
  String get language => '语言';

  @override
  String get defaultText => '默认';

  @override
  String get more => '更多';

  @override
  String get other => '其他';

  @override
  String get about => '关于';

  @override
  String get en => '英语';

  @override
  String get ja => '日语';

  @override
  String get ru => '俄语';

  @override
  String get fr => '法语';

  @override
  String get es => '西班牙语';

  @override
  String get ko => '韩语';

  @override
  String get zh_CN => '中文简体';

  @override
  String get theme => '主题';

  @override
  String get themeDesc => '设置深色模式，调整色彩';

  @override
  String get overrideLabel => '覆写';

  @override
  String get allowLan => '局域网代理';

  @override
  String get tun => '虚拟网卡';

  @override
  String get tunDesc => '虚拟网卡仅在管理员模式生效';

  @override
  String get minimizeOnExit => '退出时最小化';

  @override
  String get autoLaunch => '自启动';

  @override
  String get silentLaunch => '静默启动';

  @override
  String get silentLaunchDesc => '后台启动';

  @override
  String get autoRun => '自动运行';

  @override
  String get autoRunDesc => '应用打开时自动运行';

  @override
  String get logcat => '日志捕获';

  @override
  String get logcatDesc => '禁用将会隐藏日志入口';

  @override
  String get accessControl => '访问控制';

  @override
  String get accessControlDesc => '配置应用访问代理';

  @override
  String get application => '应用程序';

  @override
  String get edit => '编辑';

  @override
  String get confirm => '确定';

  @override
  String get update => '更新';

  @override
  String get add => '添加';

  @override
  String get save => '保存';

  @override
  String get delete => '删除';

  @override
  String get hours => '小时';

  @override
  String get seconds => '秒';

  @override
  String get qrcode => '二维码';

  @override
  String get qrcodeDesc => '扫描二维码获取配置文件';

  @override
  String get url => 'URL';

  @override
  String get file => '文件';

  @override
  String get name => '名称';

  @override
  String get profileNameNullValidationDesc => '请输入配置名称';

  @override
  String get profileUrlNullValidationDesc => '请输入配置URL';

  @override
  String get profileUrlInvalidValidationDesc => '请输入有效配置URL';

  @override
  String get autoUpdate => '自动更新';

  @override
  String get autoUpdateInterval => '自动更新间隔';

  @override
  String get profileAutoUpdateIntervalNullValidationDesc => '请输入自动更新间隔时间';

  @override
  String get profileAutoUpdateIntervalInvalidValidationDesc => '请输入有效间隔时间格式';

  @override
  String get themeMode => '主题模式';

  @override
  String get themeColor => '主题色彩';

  @override
  String get preview => '预览';

  @override
  String get auto => '自动';

  @override
  String get light => '浅色';

  @override
  String get dark => '深色';

  @override
  String get submit => '提交';

  @override
  String createProfileFromUrlTip(Object url) {
    return '是否要通过 $url 创建配置？';
  }

  @override
  String get create => '创建';

  @override
  String get pleaseUploadValidQrcode => '请上传有效的二维码';

  @override
  String get blacklistMode => '黑名单模式';

  @override
  String get whitelistMode => '白名单模式';

  @override
  String get selectAll => '全选';

  @override
  String get cancelSelectAll => '取消全选';

  @override
  String get appAccessControl => '应用访问控制';

  @override
  String get accessControlAllowDesc => '只允许选中应用进入VPN';

  @override
  String get accessControlNotAllowDesc => '选中应用将会被排除在VPN之外';

  @override
  String get accessControlDisabledDesc => '应用访问控制已关闭';

  @override
  String accessControlSelectedCount(num count) {
    return '已选 $count';
  }

  @override
  String get profileParseErrorDesc => '配置文件解析错误';

  @override
  String get proxyPort => '代理端口';

  @override
  String get port => '端口';

  @override
  String get logLevel => '日志等级';

  @override
  String get show => '显示';

  @override
  String get hide => '隐藏';

  @override
  String get exit => '退出';

  @override
  String get systemProxy => '系统代理';

  @override
  String get custom => '自定义';

  @override
  String get project => '项目';

  @override
  String get core => '内核';

  @override
  String get reverseEngineeringNotice => '严禁对本应用进行逆向工程、反编译、反汇编或借助 AI 工具分析';

  @override
  String get tabAnimation => '选项卡动画';

  @override
  String get desc => '基于ClashMeta的多平台代理客户端，简单易用，开源无广告';

  @override
  String get startVpn => '正在启动VPN...';

  @override
  String get stopVpn => '正在停止VPN...';

  @override
  String get discovery => '发现新版本';

  @override
  String get compatible => '兼容模式';

  @override
  String get notSelectedTip => '当前代理组无法选中';

  @override
  String get tip => '提示';

  @override
  String get account => '账号';

  @override
  String get backup => '备份';

  @override
  String get backupSuccess => '备份成功';

  @override
  String get noInfo => '暂无信息';

  @override
  String get pleaseBindWebDAV => '请绑定WebDAV';

  @override
  String get bind => '绑定';

  @override
  String get connectivity => '连通性：';

  @override
  String get webDAVConfiguration => 'WebDAV配置';

  @override
  String get address => '地址';

  @override
  String get addressHelp => 'WebDAV服务器地址';

  @override
  String get addressTip => '请输入有效的WebDAV地址';

  @override
  String get password => '密码';

  @override
  String get checkUpdate => '检查更新';

  @override
  String get checkUpdateError => '当前应用已经是最新版了';

  @override
  String get checkUpdateFailed => '检查更新失败，请检查网络后重试';

  @override
  String get unknown => '未知';

  @override
  String get search => '搜索';

  @override
  String get allowBypass => '允许应用绕过VPN';

  @override
  String get externalController => '外部控制器';

  @override
  String get externalControllerDesc => '外部控制器开启后，可通过指定地址控制内核';

  @override
  String get openDashboard => '打开面板';

  @override
  String get ipv6Desc => '开启 IPv6 后才会接收 IPv6 流量';

  @override
  String get autoIpv6 => '自动 IPv6';

  @override
  String get autoIpv6Desc => '自动 IPv6 会根据本地网络是否支持 IPv6 自动开关';

  @override
  String get app => '应用';

  @override
  String get unifiedDelay => '统一延迟';

  @override
  String get tcpConcurrent => 'TCP并发';

  @override
  String get geodataLoader => 'Geo低内存模式';

  @override
  String get requests => '请求';

  @override
  String get requestsDesc => '查看最近请求与实时连接';

  @override
  String get findProcessMode => '查找进程';

  @override
  String get init => '初始化';

  @override
  String get infiniteTime => '长期有效';

  @override
  String get connections => '连接';

  @override
  String get intranetIP => '内网 IP';

  @override
  String get view => '查看';

  @override
  String get cut => '剪切';

  @override
  String get copy => '复制';

  @override
  String get paste => '粘贴';

  @override
  String get userAgent => '用户代理';

  @override
  String get testUrl => '测速链接';

  @override
  String get delayTestTimeout => '延迟测试超时';

  @override
  String get sync => '同步';

  @override
  String get exclude => '从最近任务中隐藏';

  @override
  String get compact => '紧凑';

  @override
  String get filter => '筛选';

  @override
  String get tab => '标签页';

  @override
  String get list => '列表';

  @override
  String get delay => '延迟';

  @override
  String get style => '风格';

  @override
  String get size => '尺寸';

  @override
  String get sort => '排序';

  @override
  String get columns => '列数';

  @override
  String get proxyGroup => '代理组';

  @override
  String get go => '前往';

  @override
  String get externalLink => '外部链接';

  @override
  String get autoCloseConnections => '自动关闭连接';

  @override
  String get autoCloseConnectionsDesc =>
      '切换节点后，可关闭全部连接，或仅关闭经过当前策略组的连接（包含嵌套策略组）';

  @override
  String get connectionCloseScope => '关闭连接范围';

  @override
  String get closeCurrentGroupConnections => '仅当前策略组';

  @override
  String get onlyStatisticsProxy => '仅统计代理流量';

  @override
  String get pureBlackMode => '纯黑模式';

  @override
  String get keepAliveIntervalDesc => 'TCP保持活动间隔';

  @override
  String get entries => '个条目';

  @override
  String secondsCount(Object count) {
    return '$count 秒';
  }

  @override
  String itemsCount(num count) {
    return '$count 项';
  }

  @override
  String get geoAutoUpdate => '自动更新';

  @override
  String get geoAutoUpdateInterval => '自动更新间隔';

  @override
  String get geoAutoUpdateIntervalTip => '自动更新间隔必须为 1 至 8760 小时';

  @override
  String get geoResources => 'Geo 资源';

  @override
  String geoUpdating(Object name) {
    return '正在更新 $name...';
  }

  @override
  String geoSkipped(Object name) {
    return '$name 已跳过';
  }

  @override
  String geoUpdated(Object name) {
    return '$name 已更新';
  }

  @override
  String get local => '本地';

  @override
  String get remote => '远程';

  @override
  String get remoteBackupDesc => '备份数据到WebDAV';

  @override
  String get localBackupDesc => '备份数据到本地';

  @override
  String get mode => '模式';

  @override
  String get time => '时间';

  @override
  String get source => '来源';

  @override
  String get action => '操作';

  @override
  String get intelligentSelected => '智能选择';

  @override
  String get clipboardNoPackageNames => '剪贴板中没有有效的包名';

  @override
  String get clipboardImport => '剪贴板导入';

  @override
  String get clipboardExport => '导出剪贴板';

  @override
  String get layout => '布局';

  @override
  String get tight => '紧凑';

  @override
  String get standard => '标准';

  @override
  String get loose => '宽松';

  @override
  String get profilesSort => '配置排序';

  @override
  String get start => '启动';

  @override
  String get stop => '暂停';

  @override
  String get key => '键';

  @override
  String get value => '值';

  @override
  String get vpnTip => '重启VPN后改变生效';

  @override
  String get vpnEnableDesc => 'VPN 通过 VpnService 自动路由系统所有流量';

  @override
  String get options => '选项';

  @override
  String get loopback => 'UWP 回环解锁';

  @override
  String get providers => '提供者';

  @override
  String get proxyProviders => '代理提供者';

  @override
  String get ruleProviders => '规则提供者';

  @override
  String get status => '状态';

  @override
  String get statusDesc => '关闭 DNS 后将使用系统 DNS';

  @override
  String get preferH3Desc => '优先使用 HTTP/3 时，DoH 服务器优先使用 HTTP/3';

  @override
  String get respectRules => '遵守规则';

  @override
  String get respectRulesDesc => '遵守规则使 DNS 连接遵守规则，需配置代理域名服务器';

  @override
  String get dnsMode => 'DNS模式';

  @override
  String get fakeipRange => 'Fake-IP范围';

  @override
  String get fakeipFilter => 'Fake-IP过滤';

  @override
  String get defaultNameserver => '默认域名服务器';

  @override
  String get defaultNameserverDesc => '用于解析其他 DNS 服务器的域名，只能填写 IP 地址';

  @override
  String get nameserver => '域名服务器';

  @override
  String get nameserverDesc =>
      '默认使用的 DNS 服务器，如 223.5.5.5、tls://1.1.1.1、https://dns.google/dns-query';

  @override
  String get useHosts => '使用Hosts';

  @override
  String get useSystemHosts => '使用系统Hosts';

  @override
  String get nameserverPolicy => '域名服务器策略';

  @override
  String get nameserverPolicyDesc =>
      '匹配的域名改用此处指定的 DNS 服务器，优先于 Nameserver 和 Fallback';

  @override
  String get proxyNameserver => '代理域名服务器';

  @override
  String get fallback => 'Fallback';

  @override
  String get fallbackDesc => 'Nameserver 的结果被 Fallback 过滤判定为污染时，改用这些服务器的结果';

  @override
  String get preferH3 => '优先使用HTTP/3';

  @override
  String get fallbackLazyQuery => 'Fallback按需查询';

  @override
  String get proxyNameserverPolicy => '代理域名服务器策略';

  @override
  String get directNameserver => '直连域名服务器';

  @override
  String get directNameserverFollowPolicy => '直连域名服务器遵循策略';

  @override
  String get fallbackFilter => 'Fallback过滤';

  @override
  String get geoipCode => 'Geoip代码';

  @override
  String get ipcidr => 'IP/掩码';

  @override
  String get domain => '域名';

  @override
  String get reset => '重置';

  @override
  String get action_view => '显示/隐藏';

  @override
  String get action_start => '启动/停止';

  @override
  String get action_mode => '切换模式';

  @override
  String get action_proxy => '系统代理';

  @override
  String get action_tun => '虚拟网卡';

  @override
  String get hotkeyManagement => '快捷键管理';

  @override
  String get hotkeyManagementDesc => '使用键盘控制应用程序';

  @override
  String get pressKeyboard => '请按下按键';

  @override
  String get remove => '移除';

  @override
  String get noNetwork => '无网络';

  @override
  String get ipv6InboundDesc => '开启 IPv6 后，VPN 允许 IPv6 入站';

  @override
  String get exportLogs => '导出日志';

  @override
  String get exportSuccess => '导出成功';

  @override
  String get iconStyle => '图标样式';

  @override
  String get iconStyleFilled => '色块';

  @override
  String get iconStylePlain => '纯图标';

  @override
  String get iconStyleHidden => '隐藏';

  @override
  String get stackMode => '栈模式';

  @override
  String get network => '网络';

  @override
  String get bypassDomain => '排除域名';

  @override
  String get bypassDomainDesc => '排除域名仅在系统代理启用时生效';

  @override
  String get resetTip => '确定要重置吗?';

  @override
  String get icon => '图片';

  @override
  String get noData => '暂无数据';

  @override
  String get fontFamily => '字体';

  @override
  String get installedFonts => '已安装字体';

  @override
  String get toggle => '切换';

  @override
  String get system => '系统';

  @override
  String get bypassPrivateRoute => '绕过私有路由地址';

  @override
  String get bypassPrivateRouteDesc => '开启绕过私有路由地址后，局域网、回环和组播地址不经过虚拟网卡';

  @override
  String get routeAddress => '路由地址';

  @override
  String get pleaseInputAdminPassword => '请输入管理员密码';

  @override
  String get tunAuthorizationFailed => '无法启用 TUN：管理员授权被拒绝，请允许系统权限请求后重试';

  @override
  String get tunHelperInstallFailed =>
      '无法启用 TUN：Helper 安装或启动失败，请检查应用安装是否完整及系统服务状态后重试';

  @override
  String get tunAdminAccountRequired => '开启 TUN 需要本机管理员账户，请使用管理员账户登录后再开启';

  @override
  String get copyEnvVar => '复制环境变量';

  @override
  String get memoryInfo => '内存信息';

  @override
  String get dialog => '对话框';

  @override
  String get cancel => '取消';

  @override
  String get fileIsUpdate => '文件有修改，是否保存修改';

  @override
  String get profileHasUpdate => '配置文件已经修改,是否关闭自动更新 ';

  @override
  String get copySuccess => '复制成功';

  @override
  String get copyLink => '复制链接';

  @override
  String get exportFile => '导出文件';

  @override
  String get cacheCorrupt => '缓存已损坏，是否清空？';

  @override
  String get listen => '监听';

  @override
  String get undo => '撤销';

  @override
  String get redo => '重做';

  @override
  String get none => '无';

  @override
  String get required => '必填';

  @override
  String get advancedConfig => '进阶配置';

  @override
  String get advancedConfigDesc => '提供多样化配置';

  @override
  String get addRule => '添加规则';

  @override
  String get ruleName => '规则名称';

  @override
  String get content => '内容';

  @override
  String get subRule => '子规则';

  @override
  String get ruleTarget => '规则目标';

  @override
  String get sourceIp => '源IP';

  @override
  String get noResolve => '不解析IP';

  @override
  String get saveChanges => '是否保存更改？';

  @override
  String get findProcessModeAutomaticDesc => '当前规则含进程规则，仅在检查这些规则时查找进程';

  @override
  String get monochromeScheme => '单色';

  @override
  String get colorStyle => '配色风格';

  @override
  String get vividStyle => '鲜明';

  @override
  String get tintedStyle => '氛围';

  @override
  String get softStyle => '柔和';

  @override
  String get customColor => '自定义颜色';

  @override
  String get grid => '网格';

  @override
  String get spectrum => '光谱';

  @override
  String get sliders => '滑块';

  @override
  String get hue => '色相';

  @override
  String get saturation => '饱和度';

  @override
  String get brightness => '亮度';

  @override
  String get hex => '十六进制';

  @override
  String get liquidGlass => '液态玻璃';

  @override
  String get ultra => '极致';

  @override
  String get developerMode => '开发者模式';

  @override
  String get developerModeEnableTip => '开发者模式已启用';

  @override
  String get messageTest => '消息测试';

  @override
  String get messageTestTip => '这是一条消息';

  @override
  String get crashTest => '崩溃测试';

  @override
  String get clearData => '清除数据';

  @override
  String get textScale => '文本缩放';

  @override
  String get internet => '互联网';

  @override
  String get systemApp => '系统应用';

  @override
  String get noNetworkApp => '无网络应用';

  @override
  String get restoreStrategy => '恢复策略';

  @override
  String get restoreStrategy_override => '覆盖';

  @override
  String get restoreStrategy_compatible => '兼容';

  @override
  String get logsTest => '日志测试';

  @override
  String emptyTip(Object label) {
    return '$label不能为空';
  }

  @override
  String urlTip(Object label) {
    return '$label必须为URL';
  }

  @override
  String numberTip(Object label) {
    return '$label必须为数字';
  }

  @override
  String get interval => '间隔';

  @override
  String existsTip(Object label) {
    return '$label当前已存在';
  }

  @override
  String deleteTip(Object label) {
    return '确定删除当前$label吗？';
  }

  @override
  String deleteMultipTip(Object label) {
    return '确定删除选中的$label吗？';
  }

  @override
  String nullTip(Object label) {
    return '暂无$label';
  }

  @override
  String get script => '脚本';

  @override
  String get color => '颜色';

  @override
  String get rename => '重命名';

  @override
  String get unnamed => '未命名';

  @override
  String get mixedPort => '混合端口';

  @override
  String get socksPort => 'Socks端口';

  @override
  String get redirPort => 'Redir端口';

  @override
  String get tproxyPort => 'Tproxy端口';

  @override
  String portTip(Object label) {
    return '$label 必须在 1024 到 49151 之间';
  }

  @override
  String get portConflictTip => '请输入不同的端口';

  @override
  String get portUnavailableTitle => '端口不可用';

  @override
  String portUnavailableMessage(Object port) {
    return '混合端口 $port 无法监听，可能已被其他程序占用。修改后可立即重试';
  }

  @override
  String get saveAndRetry => '保存并重试';

  @override
  String portSuggestionTip(Object port) {
    return '已填入建议端口 $port';
  }

  @override
  String get portProxyAppTip => '如果正在运行其他代理软件，请先将其关闭';

  @override
  String get import => '导入';

  @override
  String get importFile => '通过文件导入';

  @override
  String get importUrl => '通过URL导入';

  @override
  String get autoSetSystemDns => '自动设置系统DNS';

  @override
  String get suspendOnIdle => '空闲时暂停代理';

  @override
  String get suspendOnIdleDesc =>
      '空闲时暂停代理会在熄屏并进入系统空闲状态时暂停流量转发和健康检查以节省电量，可能导致语音通话和实时音频断开、推送通知延迟';

  @override
  String details(Object label) {
    return '$label详情';
  }

  @override
  String get creationTime => '创建时间';

  @override
  String get process => '进程';

  @override
  String get host => '主机';

  @override
  String get destination => '目标地址';

  @override
  String get destinationGeoIP => '目标地理定位';

  @override
  String get destinationIPASN => '目标IP ASN';

  @override
  String get specialProxy => '特殊代理';

  @override
  String get specialRules => '特殊规则';

  @override
  String get remoteDestination => '远程目标';

  @override
  String get networkType => '网络类型';

  @override
  String get proxyChains => '链式代理';

  @override
  String get proxyChainWarning => '链式代理会显著降低网速。如果您没有明确的业务需求，或不了解此项配置，请保持关闭';

  @override
  String get proxyChainInstruction =>
      '按入口到出口顺序排列，任意一跳均可使用节点或策略组；组内具体代理经前一跳拨号，嵌套组及 DIRECT/REJECT 保持原样；保存后，链式代理会以其名称作为策略组出现在代理列表和规则策略中；编辑器中的延迟仅供各跳参考，实际链路请在链式代理的策略组中测速';

  @override
  String get proxyChainMinimumNodes => '链式代理至少需要入口和出口';

  @override
  String get proxyChainMinimumNodesHint => '请选择出口节点或策略组';

  @override
  String get proxyChainPolicyGroups => '策略组';

  @override
  String get proxyChainUnsupportedGroupTip =>
      '链式代理仅支持 select、url-test、fallback 和 load-balance 策略组';

  @override
  String get proxyChainEntry => '入口';

  @override
  String get proxyChainExit => '出口';

  @override
  String get clearProxyChain => '删除链式配置';

  @override
  String get proxyChainCustomNodes => '自定义节点';

  @override
  String get proxyChainCustomNode => '自定义节点';

  @override
  String get addProxyChainNode => '新增';

  @override
  String get proxyChainOtherNodes => '其他节点';

  @override
  String get proxyChainSavedAndApplied => '链式代理已保存并应用，可在规则策略或代理列表中按名称选择';

  @override
  String proxyChainConflictTip(Object name) {
    return '代理 $name 与其他启用链路冲突或形成回环';
  }

  @override
  String proxyChainUnavailableNodeTip(Object name) {
    return '代理 $name 当前不可用于此位置';
  }

  @override
  String proxyChainUnavailableReference(Object chainName, Object nodeName) {
    return '代理链「$chainName」中的节点或策略组「$nodeName」已失效，请在“链式代理”中重新选择该节点或策略组，或关闭这条代理链';
  }

  @override
  String get proxyChainRelatedChainsUpdated => '相关链式代理已更新';

  @override
  String get proxyChainSelectedNodes => '代理链';

  @override
  String get proxyChainAvailableNodes => '可用节点与策略组';

  @override
  String get proxyChainEmpty => '暂无代理链节点';

  @override
  String get proxyChainNodeAdded => '节点已加入链式代理';

  @override
  String get proxyChainUriNodeSupportedFormats =>
      '支持格式：ss://、ssr://、vmess://、vless://、trojan://、anytls://、hysteria:// / hy://、hysteria2:// / hy2://、tuic://、wireguard:// / wg://、http(s)://、socks(5)://';

  @override
  String get log => '日志';

  @override
  String get connection => '连接';

  @override
  String get request => '请求';

  @override
  String get connected => '已连接';

  @override
  String get disconnected => '已断开';

  @override
  String get connecting => '连接中...';

  @override
  String get restartCoreTip => '您确定要重启核心吗？';

  @override
  String get forceRestartCoreTip => '您确定要强制重启核心吗？';

  @override
  String get dnsHijacking => 'DNS劫持';

  @override
  String get coreStatus => '核心状态';

  @override
  String get liveStatus => '实时状态';

  @override
  String liveStatusPosition(Object index, Object count) {
    return '第 $index 项，共 $count 项';
  }

  @override
  String get liveStatusTest => '实时状态卡片测试';

  @override
  String get coreStopped => '内核已停止';

  @override
  String get restartCore => '重启内核';

  @override
  String get coreStarting => '正在启动内核';

  @override
  String get coreStartingDesc => '正在连接内核';

  @override
  String get coreRunning => '内核运行中';

  @override
  String get coreRunningDesc => '应用已连接到内核';

  @override
  String get forceRestartCore => '强制重启';

  @override
  String get forceRestartCoreAsk => '强制重启内核？';

  @override
  String get forceRestartCoreAskDesc => '进行中的连接会断开';

  @override
  String get stopUpdateDownloadTip => '要停止下载更新吗？';

  @override
  String get stopUpdateDownloadDesc => '已下载的部分会被删除';

  @override
  String get stopDownload => '停止';

  @override
  String get coreNotConnected => '内核未连接';

  @override
  String get appendSystemDns => '追加系统DNS';

  @override
  String get blockQuic => '阻止 QUIC';

  @override
  String get blockQuicDesc => '拦截 UDP 443 流量，迫使连接回落到 TCP';

  @override
  String get blockWebRtc => '阻止 WebRTC';

  @override
  String get blockWebRtcDesc => '拦截 STUN 流量以减少 WebRTC IP 泄漏';

  @override
  String get editRule => '编辑规则';

  @override
  String get overrideMode => '覆写模式';

  @override
  String get standardModeDesc => '标准模式，可先运行覆写脚本，再在配置之上追加规则';

  @override
  String get addedRulesAfterScript => '在脚本之后插入，排在配置规则前面';

  @override
  String get addedRules => '附加规则';

  @override
  String get controlGlobalAddedRules => '控制全局附加规则';

  @override
  String get overrideScript => '覆写脚本';

  @override
  String get goToConfigureScript => '前往配置脚本';

  @override
  String get editGlobalRules => '编辑全局规则';

  @override
  String get confirmForceCrashCore => '确定要强制崩溃核心？';

  @override
  String get confirmClearAllData => '确定要清除所有数据？';

  @override
  String get loading => '加载中...';

  @override
  String yearsAgo(num count) {
    return '$count 年前';
  }

  @override
  String monthsAgo(num count) {
    return '$count 个月前';
  }

  @override
  String daysAgo(num count) {
    return '$count 天前';
  }

  @override
  String hoursAgo(num count) {
    return '$count 小时前';
  }

  @override
  String minutesAgo(num count) {
    return '$count 分钟前';
  }

  @override
  String get justNow => '刚刚';

  @override
  String get turnOn => '开启';

  @override
  String get turnOff => '关闭';

  @override
  String get vpnConfigChangeDetected => 'VPN 相关配置已改动，点击重启';

  @override
  String get restart => '重启';

  @override
  String get speedStatistics => '网速统计';

  @override
  String get resetPageChangesTip => '当前页面存在更改，确定重置吗？';

  @override
  String get overwriteTypeCustom => '自定义';

  @override
  String get overwriteTypeCustomDesc => '自定义模式，支持完全自定义修改代理组以及规则';

  @override
  String get emptyCustomOverwrite =>
      '自定义覆写内容为空，请先一键填入或添加规则和策略组；如需保留订阅内容，请使用叠加模式';

  @override
  String get proxyGroupEmpty => '策略组为空';

  @override
  String get proxyGroupNameEmpty => '策略组名称不能为空';

  @override
  String get ruleEmpty => '规则为空';

  @override
  String get confirmOverwriteTip => '确定后将会覆盖已有数据';

  @override
  String get configDataDetected => '检测到配置中存在数据';

  @override
  String get quickFill => '一键填入';

  @override
  String get clearCustomRouting => '一键清空';

  @override
  String get confirmClearCustomRouting =>
      '清空当前配置的自定义策略组和规则？订阅内容、附加规则、链式代理和自定义节点将保留';

  @override
  String get addProxyGroup => '添加策略组';

  @override
  String get editProxyGroup => '编辑策略组';

  @override
  String get lazy => '延迟加载';

  @override
  String get proxyFilter => '节点过滤器';

  @override
  String get excludeProxyFilter => '排除节点过滤器';

  @override
  String get excludeType => '排除类型';

  @override
  String get expectedStatus => '预期状态';

  @override
  String get maxFailedTimes => '最大失败次数';

  @override
  String get timeout => '超时';

  @override
  String get strategy => '策略';

  @override
  String get iconUrl => '图标链接';

  @override
  String get disableUDP => '禁用 UDP';

  @override
  String get hideFromList => '从列表中隐藏';

  @override
  String get includeAll => '包含所有代理和代理集';

  @override
  String get includeAllProxies => '包含所有代理';

  @override
  String get includeAllProxyProviders => '包含所有代理集';

  @override
  String get proxyGroupMembersEmpty => '请添加代理、代理集或启用全部包含选项';

  @override
  String get tolerance => '容差';

  @override
  String customOutboundInUse(Object name) {
    return '$name 仍被策略组、规则或链式代理引用';
  }

  @override
  String get relayGroupUnsupported => '核心已移除 Relay 策略组，请选择其他类型';

  @override
  String rawOutboundInUse(Object name, Object path) {
    return '$name 仍被原始配置中的 $path 引用';
  }

  @override
  String get unknownNetworkError => '未知网络错误';

  @override
  String get restoreException => '恢复异常';

  @override
  String get networkException => '网络异常，请检查连接后重试';

  @override
  String get invalidBackupFile => '无效备份文件';

  @override
  String get backupFromNewerVersion => '该备份来自更高版本的应用，请先更新应用再恢复';

  @override
  String get pruneCache => '修剪缓存';

  @override
  String get backupAndRestore => '备份与恢复';

  @override
  String get backupAndRestoreDesc => '通过WebDAV或者文件同步数据';

  @override
  String get restore => '恢复';

  @override
  String get restoreDefault => '恢复默认';

  @override
  String get restoreSuccess => '恢复成功';

  @override
  String get restoreFromWebDAVDesc => '通过WebDAV恢复数据';

  @override
  String get restoreFromFileDesc => '通过文件恢复数据';

  @override
  String get restoreOnlyConfig => '仅恢复配置文件';

  @override
  String get restoreAllData => '恢复所有数据';

  @override
  String get backupRetention => '保留备份数';

  @override
  String get backupRetentionDesc => '每次备份后自动删除本设备较早的 WebDAV 备份';

  @override
  String get selectBackup => '选择备份';

  @override
  String get noRemoteBackup => 'WebDAV 上没有备份';

  @override
  String get deleteBackupTip => '确定从 WebDAV 删除这个备份吗？';

  @override
  String get addProfile => '添加配置';

  @override
  String get editProfile => '编辑配置';

  @override
  String get delayTest => '延迟测试';

  @override
  String get userCenter => '用户中心';

  @override
  String get userCenterFallback => '用户中心（备用）';

  @override
  String get userGuide => '用户指南';

  @override
  String get oixCloud => 'oixCloud';

  @override
  String get register => '注册';

  @override
  String get registerTitle => '创建账号';

  @override
  String get registerFailed => '注册失败';

  @override
  String get registerClosed => '当前已关闭注册';

  @override
  String get haveAccountAlready => '已有账号？';

  @override
  String get goLogin => '去登录';

  @override
  String get nicknameLabel => '昵称';

  @override
  String get nicknameHint => '字母与数字，最多 12 个字符';

  @override
  String get nicknameValidation => '请输入昵称';

  @override
  String get confirmPasswordLabel => '确认密码';

  @override
  String get confirmPasswordHint => '请再次输入密码';

  @override
  String get confirmPasswordValidation => '请确认密码';

  @override
  String get passwordMismatch => '两次输入的密码不一致';

  @override
  String get passwordRuleHint => '10-36 位，需含大小写字母、数字和符号';

  @override
  String get inviteCodeLabel => '邀请码';

  @override
  String get inviteCodeHint => '请输入邀请码';

  @override
  String get inviteCodeValidation => '请输入邀请码';

  @override
  String get emailCodeLabel => '邮箱验证码';

  @override
  String get emailCodeHint => '请输入 6 位验证码';

  @override
  String get emailCodeValidation => '请输入邮箱验证码';

  @override
  String get sendCode => '获取验证码';

  @override
  String resendCodeIn(Object seconds) {
    return '$seconds 秒后重发';
  }

  @override
  String get codeSent => '验证码已发送';

  @override
  String get loggedOutViewTitle => 'oixCloud';

  @override
  String get loggedOutViewDesc => '登录后查看账户信息和管理订阅';

  @override
  String get signInWithGoogle => '使用 Google 登录';

  @override
  String get googleLoginWaiting => '请在浏览器中完成 Google 登录';

  @override
  String get googleLoginUnavailable => '无法打开 Google 登录，请重试';

  @override
  String get googleLoginTimedOut => 'Google 登录已超时，请重试';

  @override
  String get googleLoginInvalidCallback => '无法验证 Google 登录，请重试';

  @override
  String get loginTitle => '登录';

  @override
  String get startCorePromptTitle => '提示';

  @override
  String get startCorePromptContent => '已成功获取配置文件，是否立即启动？';

  @override
  String get logoutTitle => '退出登录';

  @override
  String get logoutContent => '确定退出登录？';

  @override
  String get loginSuccess => '登录成功';

  @override
  String get getProfileSuccess => '配置文件获取成功';

  @override
  String get startSuccess => '已启动';

  @override
  String get loginFailed => '登录失败';

  @override
  String get invalidCertificateTitle => '证书校验失败';

  @override
  String get certificateExpired => '证书已过期';

  @override
  String get certificateNotYetValid => '证书尚未生效';

  @override
  String get certificateHostnameMismatch => '证书与请求域名不匹配';

  @override
  String get certificateUntrusted => '证书链不受信任';

  @override
  String get certificateValidityHint => '请先同步系统日期和时间，如果时间正确，则需要服务端修复证书';

  @override
  String get invalidCertificateContent =>
      '无法验证服务器证书，跳过校验后无法确认服务器身份，发送或接收的账号凭据、订阅等数据可能被窃取或篡改\n\n仅在信任当前网络和服务器时继续，本次例外仅适用于同一服务器和同一证书的本次重试，操作结束后自动恢复校验';

  @override
  String get allowTemporarily => '临时允许';

  @override
  String get retryWithoutCertificateVerification => '仅临时检测 API';

  @override
  String get apiAvailableWithCertificateException =>
      '本次临时检测可连接 API，但未同步账户或节点配置，请处理证书问题后重新检测';

  @override
  String get certificateUntrustedHint =>
      '先换用手机热点等其他网络重试，并检查系统更新；若安全软件或公司网络会检查 HTTPS，请联系管理员确认；仍失败请联系服务商检查完整证书链';

  @override
  String get certificateHostnameHint =>
      '先换个网络，并完成 Wi-Fi 登录认证；仍失败请联系服务商检查证书是否匹配服务器域名';

  @override
  String get certificateRevokedHint => '请联系服务商更换已吊销的证书，重复重试或修改系统时间无法解决证书吊销问题';

  @override
  String get certificateUnknownHint =>
      '请检查系统日期和时间，再换个网络重试；仍无法验证时，请将此错误提供给服务商协助处理';

  @override
  String get certificateCheckOnlyHint => '此操作只检测 API 连通性，不会登录账户或下载节点配置';

  @override
  String get certificateSyncRetryDescription =>
      '确认后，本次操作会检查连接、刷新账户并下载节点配置，临时证书例外在本次同步结束后失效';

  @override
  String get retryCloudSyncWithCertificateException => '临时允许并同步配置';

  @override
  String get cloudSyncedWithCertificateException =>
      '本次已临时完成账户和配置同步，现已恢复证书校验，请在下次同步前处理证书问题';

  @override
  String get cloudCertificateSyncFailed => 'API 检测已通过，但账户或节点配置同步失败';

  @override
  String get cloudConfigSyncIncomplete => '未能获取节点配置，请处理下载时的错误提示后重新同步';

  @override
  String get emailPassword => '邮箱密码';

  @override
  String get accessToken => 'Access Token';

  @override
  String get emailLabel => '邮箱';

  @override
  String get emailHint => '请输入邮箱地址';

  @override
  String get emailValidation => '请输入邮箱';

  @override
  String get emailFormatValidation => '邮箱格式不正确';

  @override
  String get passwordLabel => '密码';

  @override
  String get forgotPassword => '忘记密码？';

  @override
  String get resetPasswordTitle => '重置密码';

  @override
  String get sendResetEmail => '发送重置邮件';

  @override
  String get resetEmailSent => '重置邮件已发送，请将邮件中的重置链接或代码粘贴到下方';

  @override
  String get resetTokenLabel => '重置链接或代码';

  @override
  String get resetTokenValidation => '请输入重置链接或代码';

  @override
  String get newPasswordLabel => '新密码';

  @override
  String get resetPasswordSuccess => '密码已重置，请使用新密码登录';

  @override
  String get passwordValidation => '请输入密码';

  @override
  String get tokenLabel => 'Access Token';

  @override
  String get tokenValidation => '请输入 Access Token';

  @override
  String expireDate(Object date) {
    return '到期: $date';
  }

  @override
  String get todayUsed => '今日使用';

  @override
  String remaining(Object value) {
    return '剩余: $value';
  }

  @override
  String get balance => '余额';

  @override
  String get commission => '佣金';

  @override
  String get points => '积分';

  @override
  String get announcement => '公告';

  @override
  String get readFullAnnouncement => '阅读全文';

  @override
  String get serviceCheckFailed => '服务检测失败';

  @override
  String get apiAvailable => 'API 服务正常';

  @override
  String get checkApi => '检查 API';

  @override
  String get refresh => '刷新';

  @override
  String get nodeFilter => '节点筛选';

  @override
  String get nodeFilterSmartSelection => '智能优选';

  @override
  String get nodeFilterCustomized => '已自定义';

  @override
  String nodeFilterKept(Object kept, Object total) {
    return '保留 $kept / $total 个节点';
  }

  @override
  String get nodeFilterLines => '线路';

  @override
  String get nodeFilterRegions => '地区';

  @override
  String get nodeFilterNameContains => '名称包含';

  @override
  String get nodeFilterNameExcludes => '名称排除';

  @override
  String get nodeFilterPreview => '节点预览';

  @override
  String get nodeFilterSearch => '搜索节点';

  @override
  String get nodeFilterAny => '不筛选';

  @override
  String get nodeFilterOnly => '仅保留';

  @override
  String get nodeFilterExclude => '排除';

  @override
  String get nodeFilterKeepOne => '至少保留一个节点';

  @override
  String nodeFilterNodeKept(Object name) {
    return '$name，保留';
  }

  @override
  String nodeFilterNodeExcluded(Object name) {
    return '$name，排除';
  }

  @override
  String get nodeFilterRetry => '重试';

  @override
  String get nodeFilterAccountNote => '筛选保存在账户上，对使用此客户端的所有设备生效';

  @override
  String get nodeFilterUnavailable => '开通套餐后可使用节点筛选';

  @override
  String get minimalConfiguration => '最小化配置';

  @override
  String get minimalConfigurationDesc => '使用精简规则集生成更小的配置';

  @override
  String get tcpFastOpen => 'TCP Fast Open';

  @override
  String get tcpFastOpenDesc => '开启此选项以加速 TCP 连接建立';

  @override
  String get store => '商店';

  @override
  String get recharge => '充值';

  @override
  String get availablePlans => '选择套餐';

  @override
  String get noAvailablePlans => '暂无可选套餐';

  @override
  String get myOrders => '已购套餐';

  @override
  String get noPurchaseRecords => '暂未购买套餐';

  @override
  String get accountBalance => '余额';

  @override
  String commissionBalance(Object value) {
    return '佣金 $value';
  }

  @override
  String get soldOut => '已售罄';

  @override
  String remainingStock(Object count) {
    return '仅剩 $count';
  }

  @override
  String get mainlandNetworkWarning => '可能不适用于中国大陆网络';

  @override
  String get planInUse => '使用中';

  @override
  String get planNotActivated => '待激活';

  @override
  String get planEnded => '已结束';

  @override
  String get planAwaitingAutoRenewal => '等待自动续费';

  @override
  String get planAwaitingAutoRenewalNote => '排在其他套餐之后，它们都用完时自动续上';

  @override
  String get planAutoRenewalOffNote => '排在其他套餐之后，它们都用完时结束';

  @override
  String planNumber(Object id) {
    return '套餐 #$id';
  }

  @override
  String get activate => '激活';

  @override
  String get upgradePlan => '升级套餐';

  @override
  String get noPaymentMethods => '暂无可用支付方式';

  @override
  String get activatePlanTitle => '激活套餐';

  @override
  String get activatePlanConfirm => '确认激活该套餐？激活后将成为当前生效套餐';

  @override
  String get noUpgradablePlans => '暂无可升级的套餐';

  @override
  String get selectUpgradeTarget => '选择升级目标套餐';

  @override
  String get refreshAfterPayment => '支付完成后请下拉刷新查看结果';

  @override
  String get discountCodeOptional => '折扣码（可选）';

  @override
  String get bindCoupon => '绑定折扣';

  @override
  String get bindCouponIntro => '输入官方系统折扣代码，按套餐剩余时长结算差价；循环折扣代码会同步更新续费价格';

  @override
  String get verifyCoupon => '验证';

  @override
  String get discountCode => '折扣代码';

  @override
  String get discountCodeRequired => '请输入折扣代码';

  @override
  String get discountedPriceLabel => '折后价';

  @override
  String get amountDueLabel => '应补差价';

  @override
  String get refundAmountLabel => '退还差价';

  @override
  String get recurringRenewalHint => '后续自动续费同享折扣';

  @override
  String get insufficientBalanceHint => '余额不足，请先充值后再继续';

  @override
  String get amountPayable => '本次应付';

  @override
  String get renewalPriceLabel => '后续续费';

  @override
  String get calculatingQuote => '计算中…';

  @override
  String get paymentMethod => '支付方式';

  @override
  String get goPay => '去支付';

  @override
  String get confirmPurchase => '确认购买';

  @override
  String get rechargeAmount => '充值金额（¥）';

  @override
  String get invalidAmount => '请输入有效金额';

  @override
  String get scanOrTransferPay => '扫码 / 转账支付';

  @override
  String get close => '关闭';

  @override
  String get checkingPayment => '检测中...';

  @override
  String get paymentPending => '暂未收到付款，请稍后再查询';

  @override
  String get iHavePaid => '我已支付';

  @override
  String get openInBrowser => '在浏览器中打开';

  @override
  String get openLinkFailed => '无法打开链接，请确认已安装浏览器后重试';

  @override
  String get scanToPayNotice => '请使用支付宝 / 微信扫一扫完成支付';

  @override
  String get paymentAmount => '支付金额';

  @override
  String get receivingAddress => '收款地址';

  @override
  String get addressCopied => '地址已复制';

  @override
  String get transferConfirmNotice => '转账完成后系统会自动确认，确认后将自动开通已选套餐';

  @override
  String get operationSuccess => '操作成功';

  @override
  String get operationFailed => '操作失败';

  @override
  String get paymentSuccess => '支付成功';

  @override
  String get paymentRequestFailed => '支付请求失败';

  @override
  String get fetchPlansFailed => '获取套餐失败';

  @override
  String get storeSubtitle => '购买、续费与升级套餐';

  @override
  String get paymentUnknownResponse => '支付接口返回未知格式';

  @override
  String get buy => '购买';

  @override
  String get payWithBalance => '余额支付';

  @override
  String availableBalance(Object value) {
    return '可用 $value';
  }

  @override
  String get planUnavailable => '不可用';

  @override
  String get balanceDeductionHint => '购买时优先扣除余额，不足部分自动使用佣金抵扣';

  @override
  String rechargeAllowedRange(Object min, Object max) {
    return '可用范围 $min – $max';
  }

  @override
  String get rechargeAmountOutOfRange => '金额超出该支付方式允许的范围';

  @override
  String get insufficientBalanceRecharge => '请充值后重试';

  @override
  String get storeOutcomeUnknown => '请求可能已被处理，请先在“已购套餐”中确认，再决定是否重试';

  @override
  String configParseErrorAtLine(Object line) {
    return '第 $line 行的配置格式不正确';
  }

  @override
  String configTypeMismatch(Object expected, Object actual) {
    return '此处应为$expected，但实际为$actual';
  }

  @override
  String get configYamlFormatHint => '请检查该行附近的缩进和 \"-\" 列表标记';

  @override
  String get configValueTypeList => '列表';

  @override
  String get configValueTypeObject => '对象';

  @override
  String get configValueTypeText => '文本';

  @override
  String get configValueTypeBoolean => '布尔值';

  @override
  String get configValueTypeInteger => '整数';

  @override
  String get configValueTypeNumber => '数字';

  @override
  String get configValueTypeNull => '空值';

  @override
  String get configRecoveryTitle => '恢复本地配置';

  @override
  String get configRecoveryMessage => '暂时无法读取本地配置，原有数据已保留。请解锁设备后重试，或稍后重新打开应用';

  @override
  String get configRecoveryRetry => '重试';

  @override
  String get geoDownloadFailed => 'GEO 数据下载失败';

  @override
  String get geoFileMissing => '尚未下载';

  @override
  String get geoFileReadFailed => '无法读取资源文件';

  @override
  String get geoDownloadRecoveryHint =>
      '下载默认使用当前网络规则，代理尚未可用时直连。可重试当前地址、选择其他来源或输入自定义地址，下载校验成功后自动继续';

  @override
  String get geoOriginalSource => '当前地址';

  @override
  String get geoBackupSource => '备用 CDN';

  @override
  String get geoDownloadUrl => '下载地址';

  @override
  String get geoInvalidDownloadUrl => '请输入有效的 HTTP 或 HTTPS 地址';

  @override
  String get purchasedAtLabel => '购买时间';

  @override
  String get purchasePriceLabel => '购买价格';

  @override
  String get billingPeriodLabel => '计费周期';

  @override
  String get remainingTimeLabel => '剩余时间';

  @override
  String get remainingTrafficLabel => '剩余流量';

  @override
  String get expiresAtLabel => '到期时间';

  @override
  String get usedTrafficLabel => '已用流量';

  @override
  String get purchaseTotalTrafficLabel => '总流量';

  @override
  String get purchaseAutoRenewLabel => '自动续费';

  @override
  String purchaseDays(Object count) {
    return '$count天';
  }

  @override
  String purchaseHours(Object count) {
    return '$count小时';
  }

  @override
  String purchaseMinutes(Object count) {
    return '$count分钟';
  }

  @override
  String get purchaseRenewOn => '开启';

  @override
  String get purchaseRenewOff => '关闭';

  @override
  String get overwriteTypeMerge => '叠加';

  @override
  String get overwriteTypeMergeDesc =>
      '保留订阅规则和策略组，再叠加个人设置。个人规则优先于订阅规则，已有的附加规则保持优先';

  @override
  String get personalRouting => '个人分流';

  @override
  String get overlayHint => '个人设置独立保存，订阅更新后重新叠加。新增策略组没有可用成员时阻止连接';

  @override
  String overlayNameConflict(Object name) {
    return '名称“$name”已被使用，请修改个人策略组名称以保留两者';
  }

  @override
  String get outboundUnavailable => '当前配置中不可用，请移除或重新选择';

  @override
  String get memberOrderHint => '选择顺序即故障转移顺序；取消后重新选择可将成员移至末尾';

  @override
  String groupCycleError(Object name) {
    return '策略组“$name”存在循环引用，请重新选择成员';
  }

  @override
  String get rulesRequireRuleMode => '个人分流规则仅在规则模式下生效';

  @override
  String get checkRouting => '检查配置';

  @override
  String get routingChecked => '配置校验通过，个人设置已保存在当前配置中';

  @override
  String get routingApplied => '个人设置已生效';

  @override
  String get routingApplyFailed => '更改已保存，但未能应用。请检查配置后重试';

  @override
  String get customRuleForm => '表单';

  @override
  String get customRuleRaw => '规则文本';

  @override
  String get customRuleRawHint => '填写一条完整规则，复杂表达式会按原文保留';

  @override
  String get customRuleFormUnavailable => '这条规则使用复杂语法，请编辑规则文本以保留完整内容';

  @override
  String get customRuleInvalidSyntax => '请填写一条完整规则，检查规则类型、内容和目标';

  @override
  String customRuleInvalidContent(Object example) {
    return '请检查此规则类型的内容，例如：$example';
  }

  @override
  String customRuleUnavailableTarget(Object name) {
    return '目标 $name 已不可用，请从当前配置中重新选择';
  }

  @override
  String customRuleUnavailableProvider(Object name) {
    return '规则集 $name 已不可用，请选择已有规则集';
  }

  @override
  String get customRuleChooseTarget => '选择目标策略';

  @override
  String get customRuleChooseProvider => '选择规则集';

  @override
  String get customRuleMatchHint => '匹配所有剩余流量，位于这条规则之后的规则将不会生效';

  @override
  String get customRuleNoResolveHint => '仅匹配已知 IP，不主动解析域名';

  @override
  String get saveRoutingDraft => '保存草稿';

  @override
  String get routingDraftHint => '可保存草稿后继续修复其他项目；完整配置通过校验后才能应用';

  @override
  String get groupFilterHint => '筛选自动加入及提供器中的节点；手动选择的成员始终保留';

  @override
  String get groupTypeSelect => '手动选择';

  @override
  String get groupTypeUrlTest => '自动选择';

  @override
  String get groupTypeFallback => '故障转移';

  @override
  String get groupTypeLoadBalance => '负载均衡';

  @override
  String get groupTypeSelectHint => '在代理页面手动切换使用的成员';

  @override
  String get groupTypeUrlTestHint => '定期测速，自动选择延迟较低的节点';

  @override
  String get groupTypeFallbackHint => '按成员顺序选择，当前成员故障时自动切换';

  @override
  String get groupTypeLoadBalanceHint => '将连接分配到可用成员';

  @override
  String get routingGroupType => '策略组类型';

  @override
  String get customRuleType => '规则类型';

  @override
  String get routingChanged => '编辑或检查期间配置发生变化，请重新打开编辑器或再次检查';

  @override
  String get editCustomRouting => '编辑自定义';

  @override
  String get customRoutingDraftHint => '先填写自定义内容，再切换至自定义模式。编辑草稿不会切换当前模式';

  @override
  String coreBlockedByPolicyTip(int code) {
    return 'Windows 阻止了代理内核启动（系统错误 $code）。请检查 Windows 安全中心的保护历史记录及应用控制策略，并确认安装包来源和签名';
  }

  @override
  String get startupRecoveryTitle => '启动恢复';

  @override
  String get startupRecoveryTip =>
      '上次启动未能完成，本次已暂停自动应用配置和启动 VPN，当前配置选择与设置均已保留，请检查配置后点击“启动”重试；已经运行的 VPN 会继续保持连接';

  @override
  String get initFailed => '启动失败';

  @override
  String get initFailedTip => '应用启动时遇到严重错误，无法继续运行';

  @override
  String get startupTimeoutTip => '启动等待超时，请退出应用后重新打开；如果问题仍然存在，请复制下方诊断信息';

  @override
  String get startupDiagnostics => '启动诊断';

  @override
  String get errorDetails => '错误详情';

  @override
  String get stackTrace => '堆栈信息';

  @override
  String get authentication => '本地代理认证';

  @override
  String get authenticationDesc =>
      '本地代理认证开启后，使用 HTTP/SOCKS 代理需要用户名和密码。开启期间不自动设置系统 HTTP 代理，TUN/VPN 仍可使用';

  @override
  String get authenticationSystemProxyDesc => '启用本地代理认证时不设置系统 HTTP 代理';

  @override
  String get authenticationUsernameInvalid => '请输入 1–255 字节的用户名，不支持冒号或控制字符';

  @override
  String get authenticationPasswordInvalid => '请输入 1–255 字节的密码，不支持控制字符';

  @override
  String get authenticationApplyFailed => '未能应用认证设置';

  @override
  String get installedAppsPermissionRequired => '需要读取应用列表的权限';

  @override
  String get installedAppsPermissionDesc => '允许读取已安装应用列表，以选择哪些应用使用 VPN';

  @override
  String get installedAppsPermissionDeniedMessage => '尚未获得权限，可在系统设置中允许读取应用列表';

  @override
  String get installedAppsPermissionGrant => '授权访问';

  @override
  String get installedAppsLoadFailed => '无法读取应用列表，请重试';

  @override
  String get configRecoveryMissingKey =>
      '原配置的加密密钥缺失或无效。请尝试使用原设备上的原系统用户，或恢复备份。重试无法重新生成已丢失的原密钥';

  @override
  String get configRecoveryDatabaseUnavailable =>
      '暂时无法访问本地数据库，原有文件已保留，请检查本应用数据目录的访问权限，以及数据库是否被其他进程占用后重试';

  @override
  String get configRecoveryIncompatibleDatabase =>
      '本应用数据目录中的数据库不兼容或已损坏，原有文件已保留，请恢复兼容的备份，或备份并重置后重新配置本应用，不会访问其他应用的数据';

  @override
  String get configRecoveryUnreadable =>
      '本地配置无法解密或文件已损坏，原文件已保留。请恢复匹配的密钥与配置备份，或备份后重置';

  @override
  String get configRecoveryStorage =>
      '无法读取或保存本地配置及其加密密钥。请检查应用数据目录和系统安全存储的访问权限后重试';

  @override
  String get configRecoveryReset => '备份并重置';

  @override
  String get configRecoveryResetConfirm =>
      '将本地设置、订阅、规则和账号数据全部加密备份后重置应用？之后需要重新登录，并恢复或导入订阅和设置。备份受当前 Windows 用户保护，但无法找回已丢失的加密密钥';

  @override
  String get configRecoveryResetDone => '原有数据已加密备份至以下目录。请退出并重新打开应用，重新完成配置';

  @override
  String get configRecoveryResetFailed =>
      '未能完成加密备份和重置。未验证备份前不会删除仍保留的原始数据。请重试此操作，或退出后重新打开应用以继续完成';

  @override
  String get configRecoveryKeyring =>
      '无法访问系统密钥环（Secret Service），请在系统设置中启用并解锁 KDE 钱包或 GNOME 密钥环后重试';

  @override
  String get configRecoveryUseLocalStorage => '改用本地文件存储';

  @override
  String get configRecoveryUseLocalStorageConfirm =>
      '将加密密钥和账号凭据改存到应用数据目录中仅当前用户可访问的文件，不再使用系统密钥环？以当前用户身份运行的程序都能读取它们并解密本地配置，此选择之后会一直生效';

  @override
  String get excludeSsids => '暂停代理的 Wi-Fi';

  @override
  String get excludeSsidsDesc => '连接所列 Wi-Fi 时暂停代理；离开后仅在应用仍为启动状态时恢复';

  @override
  String get allowBackgroundLocation => '允许始终使用位置';

  @override
  String get locationPermission => '位置权限';

  @override
  String get locationPermissionRequired => '需要位置权限';

  @override
  String locationPermissionGuide(Object appName) {
    return '1. 打开 系统设置 > 隐私与安全性\n2. 选择 定位服务\n3. 在右侧列表中找到并勾选 $appName\n\n完成设置后，返回应用即可正常使用。感谢您的配合';
  }

  @override
  String get ssidPermissionGuide =>
      '读取 Wi-Fi 名称需要定位权限。Android 请允许始终使用精确位置，并开启系统定位服务';

  @override
  String get ssidPermissionMacosGuide => '读取 Wi-Fi 名称需要定位权限，请在系统设置中允许本应用使用定位服务';

  @override
  String get exitDefault => '默认';

  @override
  String get customExit => '自定义出口';

  @override
  String get inputExitName => '输入出口名称';

  @override
  String get iconHistory => '最近使用的图标';

  @override
  String get exitFullScreen => '退出全屏';

  @override
  String get unmaximize => '向下还原';

  @override
  String get maximize => '最大化';

  @override
  String get unpinWindow => '取消置顶';

  @override
  String get pinWindow => '窗口置顶';

  @override
  String get minimize => '最小化';

  @override
  String get cloudApiDnsFailed => 'DNS 解析失败';

  @override
  String get cloudApiDnsEmpty => 'DNS 返回空结果，可能被拦截或系统 DNS 异常';

  @override
  String get cloudApiDnsUnknownHost => 'DNS 未找到该域名';

  @override
  String get cloudApiConnectTimeout => '连接超时';

  @override
  String get cloudApiSendTimeout => '发送请求超时';

  @override
  String get cloudApiReceiveTimeout => '等待服务器响应超时';

  @override
  String get cloudApiTlsFailed => 'TLS 握手失败';

  @override
  String get cloudApiConnectionRefused => '连接被拒绝';

  @override
  String get cloudApiConnectionReset => '连接被重置';

  @override
  String get cloudApiNetworkUnreachable => '网络不可达';

  @override
  String get cloudApiAccessDenied => '系统拒绝网络访问';

  @override
  String get cloudApiConnectionFailed => '连接失败';

  @override
  String get cloudApiProxyFailed => '代理连接失败';

  @override
  String get cloudApiProxyAuthFailed => '代理认证失败（HTTP 407）';

  @override
  String cloudApiHttpError(Object status) {
    return '服务器返回 HTTP $status';
  }

  @override
  String get certificateRevoked => '证书已被吊销';

  @override
  String get cloudApiBadRequest => '服务器认为请求无效';

  @override
  String get cloudApiForbidden => '访问被服务器拒绝';

  @override
  String get cloudApiNotFound => '请求的接口或资源不存在';

  @override
  String get cloudApiMethodNotAllowed => '服务器不支持此请求方法';

  @override
  String get cloudApiServerRequestTimeout => '服务器接收请求超时';

  @override
  String get cloudApiRequestTooLarge => '请求内容超过服务器大小限制';

  @override
  String get cloudApiRateLimited => '请求过于频繁，请稍后重试';

  @override
  String get cloudApiServerError => '服务器内部错误';

  @override
  String get cloudApiBadGateway => '网关收到无效的上游响应';

  @override
  String get cloudApiServiceUnavailable => '服务暂时不可用';

  @override
  String get cloudApiGatewayTimeout => '网关等待上游服务器响应超时';

  @override
  String get cloudApiNetworkAuthRequired => '当前网络要求认证，请先完成网络登录';

  @override
  String get cloudApiResponseTooLarge => '服务器响应超过允许的大小';

  @override
  String get cloudApiTlsProtocolFailed => 'TLS 协议不兼容或 TLS 响应无效';

  @override
  String get cloudApiTlsAlgorithmFailed => 'TLS 加密算法协商失败';

  @override
  String get cloudApiTlsInterrupted => 'TLS 握手完成前连接已断开';

  @override
  String get cloudApiRedirectLoop => '服务器重定向存在循环';

  @override
  String get cloudApiRedirectLimit => '服务器重定向次数过多';

  @override
  String get cloudApiRedirectInvalid => '服务器重定向无效';

  @override
  String get cloudApiResponseInterrupted => '响应尚未接收完整，连接已断开';

  @override
  String get cloudApiConnectionAborted => '连接已中止';

  @override
  String get cloudApiAddressUnavailable => '网络地址不可用';

  @override
  String get cloudApiAddressInUse => '网络地址或端口已被占用';

  @override
  String get cloudApiNetworkResourcesExhausted => '系统网络资源不足';

  @override
  String get cloudApiClockSkew => '设备时间与服务器相差过大，请开启自动设置时间后重试';

  @override
  String get cloudApiSignatureRejected => '服务器拒绝了本应用的签名，请从官方渠道重新安装最新版本';

  @override
  String get cloudApiServerUnconfigured => '服务端未配置本应用的密钥，请联系客服';

  @override
  String get cloudApiConfigKeyRejected => '服务器拒绝了本设备的配置密钥，请从官方渠道重新安装最新版本';

  @override
  String get cloudApiAccountDisabled => '账号已被停用，请联系客服';

  @override
  String get cloudApiAccountAnomaly => '账号状态异常，请前往网站完成验证后重试';

  @override
  String get cloudApiAccountNotFound => '账号不存在，请重新登录';

  @override
  String get cloudApiInvalidResponse => '服务器响应格式无效';

  @override
  String get cloudApiRequestCanceled => '请求已取消';

  @override
  String cloudApiSystemError(Object code) {
    return '系统错误码 $code';
  }

  @override
  String get cloudApiTimeout => '请求超时';

  @override
  String cloudApiRouteDirect(Object error) {
    return '直连：$error';
  }

  @override
  String cloudApiRouteProxy(Object error) {
    return '内置代理：$error';
  }

  @override
  String get diagTitle => '网络自检';

  @override
  String get diagEntryHint => '检查内核、系统代理、虚拟网卡及 DNS';

  @override
  String get diagScope => '检查当前连接并进行少量抽查，系统网络路径也可能经过虚拟网卡，结果不代表所有应用或节点均正常';

  @override
  String get diagRun => '开始自检';

  @override
  String get diagCopy => '复制诊断报告';

  @override
  String get diagCanceled => '已取消自检，结果不完整';

  @override
  String get diagFixing => '正在执行修复，完成后将重新检查';

  @override
  String get diagFixFailed => '修复未生效，请按上方建议手动处理';

  @override
  String get diagFixApplyProfile => '应用配置';

  @override
  String get diagFixStart => '启动连接';

  @override
  String get diagFixRestartCore => '重启内核';

  @override
  String get diagFixRestartConnection => '重新连接';

  @override
  String get diagFixSystemProxy => '重新设置系统代理';

  @override
  String get diagFixEnableSystemProxy => '开启系统代理';

  @override
  String get diagFixTun => '重新启用虚拟网卡';

  @override
  String get diagFixRetest => '重新测速';

  @override
  String get diagPassed => '通过';

  @override
  String get diagWarning => '需要关注';

  @override
  String get diagFailed => '失败';

  @override
  String get diagUnknown => '未能确认';

  @override
  String get diagSkipped => '未检测';

  @override
  String get diagDisabled => '此选项未开启';

  @override
  String get diagProfile => '已应用配置';

  @override
  String get diagProfileReady => '已应用当前选中的配置';

  @override
  String get diagProfileMissing => '当前选中的配置尚未应用';

  @override
  String get diagProfileHint => '选择有效配置并启动连接后重新检查';

  @override
  String get diagCore => '内核响应';

  @override
  String get diagCoreReady => '内核已响应并报告监听已启动';

  @override
  String get diagCoreUnknown => '无法获取内核诊断结果，或检查期间配置已变化';

  @override
  String get diagCoreStopped => '内核报告流量转发尚未启动';

  @override
  String get diagSuspended => '当前 Wi-Fi 排除设置暂停了流量转发';

  @override
  String get diagCoreHint => '检查连接开关与 Wi-Fi 排除设置；内核无法响应时可重启内核，并确认客户端与内核版本配套';

  @override
  String get diagListener => '本地代理入口';

  @override
  String get diagListenerReady => '预期端口已响应代理协议';

  @override
  String get diagListenerFailed => '预期代理端口未响应，或与内核实际端口不一致';

  @override
  String get diagListenerHint =>
      '检查端口占用或监听是否启动；可先重新连接，仍失败时打开“端口与认证设置”核对或更换混合端口';

  @override
  String get diagSystemProxy => '系统代理设置';

  @override
  String get diagProxyReady => 'HTTP 与 HTTPS 代理设置指向预期本地端口';

  @override
  String get diagProxyDisabled => '客户端已启用系统代理，但操作系统报告代理未开启';

  @override
  String get diagProxyDifferent => '操作系统代理与客户端端口不一致';

  @override
  String get diagProxyAutomatic => '存在自动代理配置，尚未确认其实际使用的路线';

  @override
  String get diagProxyHint => '打开“排查与手动设置”核对系统代理地址和端口；若设置反复被改回，检查其他代理软件或设备管理策略';

  @override
  String get diagProxyAutomaticHint =>
      '自动配置脚本（PAC）或自动发现可能按网站选择不同代理，这不一定表示断网；请先确认配置来源，再按引导检查';

  @override
  String get diagSystemDnsHint =>
      '先尝试其他网络，并在操作系统当前网络连接的 DNS 设置中核对服务器；只修改客户端的 DNS 覆写不一定能修复系统解析';

  @override
  String get diagProxyRecover => '关闭失效的本机代理';

  @override
  String get diagProxyRecoverHint =>
      '停止连接后，可关闭指向当前混合端口且已无服务监听的手动代理\n其他地址、端口或自动代理设置不会更改';

  @override
  String get diagProxyGuide => '排查与手动设置';

  @override
  String get diagRecheck => '重新检测';

  @override
  String get diagOpenPortSettings => '端口与认证设置';

  @override
  String get diagOpenNetworkSettings => '网络与虚拟网卡设置';

  @override
  String get diagOpenDnsSettings => 'DNS 覆写设置';

  @override
  String get diagOpenSystemSettings => '打开系统设置';

  @override
  String get diagOpenSettingsFailed => '未能打开系统设置，请按上述路径手动进入';

  @override
  String get diagCopyProxyAddress => '复制代理地址';

  @override
  String get diagProxyGuidePrepareTitle => '1. 先确认本地代理可用';

  @override
  String get diagProxyGuidePrepare =>
      '在 FlClash 中选择有效配置并启动连接，确认“本地代理入口”检测通过后再填写代理地址\n退出其他代理软件，避免它们反复修改系统代理；若设置由公司或学校管理、无法编辑或自动恢复，请联系管理员确认用途';

  @override
  String get diagProxyGuideManualTitle => '2. 核对或手动填写代理';

  @override
  String get diagProxyGuideWindows =>
      '设置 → 网络和 Internet → 代理\n若确认自动配置是其他软件遗留、当前网络不再需要，可关闭“使用设置脚本”和“自动检测设置”\n在“手动设置代理”中开启“使用代理服务器”，分别填写下方地址与端口并保存；地址栏不加 http://，保留网络需要的例外列表';

  @override
  String get diagProxyGuideMacos =>
      '系统设置 → 网络 → 当前使用的 Wi-Fi 或以太网 → 详细信息 → 代理\nmacOS 12：系统偏好设置 → 网络 → 当前网络 → 高级 → 代理\n若确认自动配置是其他软件遗留、当前网络不再需要，可关闭“自动代理发现”和“自动代理配置”\n启用“网页代理（HTTP）”与“安全网页代理（HTTPS）”，两项都分别填写下方地址与端口并保存，保留网络需要的忽略列表';

  @override
  String get diagProxyGuideLinux =>
      '进入桌面环境的设置 → 网络 → 网络代理，选择手动模式（不同桌面环境的名称可能不同）\n分别为 HTTP 与 HTTPS 填写下方地址和端口并应用；没有系统代理设置的环境可在目标应用中手动设置\n若存在自动配置，请先确认来源及网络是否仍需使用，再切换为手动';

  @override
  String get diagProxyGuideApp =>
      '在这台设备上需要代理的应用中打开代理设置，选择 HTTP 或 SOCKS5，分别填写下方地址与端口\nAndroid 的系统代理随 VPN 服务提供；若希望应用通过 VPN 联网，请在 FlClash 网络设置中检查 VPN 开关和应用访问控制';

  @override
  String get diagProxyGuideAuthenticated =>
      '当前已启用本地代理认证，FlClash 不会自动设置系统代理\n请在支持代理认证的目标应用中选择 HTTP 或 SOCKS5，填写下方地址与端口，并使用 FlClash“覆写 → 常规 → 入站 → 本地代理认证”中的用户名和密码\n不要将用户名或密码放入诊断报告';

  @override
  String diagProxyGuideValues(Object port) {
    return '本机地址：127.0.0.1\n混合端口（当前配置）：$port\nHTTP、HTTPS 网站代理及 SOCKS5 均使用此混合端口，仅供本机应用使用';
  }

  @override
  String get diagProxyGuideInvalidPort => '当前混合端口不可用，请先在“端口与认证设置”中设置有效端口并启动连接';

  @override
  String get diagProxyGuideVerifyTitle => '3. 保存后验证实际应用';

  @override
  String get diagProxyGuideVerify =>
      '返回后点击“重新检测”，同时在实际使用的浏览器或应用中重试\n若本地代理访问通过但某个应用仍失败，检查该应用是否使用系统代理、独立代理或代理扩展；系统代理不会接管所有应用\n手动填写的代理可能需要自行关闭或恢复原设置，避免停止 FlClash 后无法联网';

  @override
  String get diagTun => '虚拟网卡与路由';

  @override
  String get diagTunMissing => '未发现内核对应的虚拟网卡处于启用状态';

  @override
  String get diagTunReady => '内核对应的虚拟网卡已启用，抽查的 IPv4 路由经过该网卡';

  @override
  String get diagTunRouteMismatch => '虚拟网卡已启用，但抽查的 IPv4 路由经过其他接口';

  @override
  String get diagTunRouteUnknown => '虚拟网卡已启用，尚未确认其 IPv4 路由';

  @override
  String get diagTunHint =>
      '重新开启虚拟网卡并完成系统授权；路由不符时检查其他 VPN，IPv6、UDP 与应用排除规则需另行核对';

  @override
  String get proxyConflictTitle => '可能存在代理冲突';

  @override
  String proxyConflictSystemProxy(Object address) {
    return '启动前系统代理指向 $address';
  }

  @override
  String get proxyConflictAutoConfig => '启动前系统代理使用自动配置脚本';

  @override
  String proxyConflictVpn(Object name) {
    return '启动前网络流量经过其他 VPN 或虚拟网卡 $name';
  }

  @override
  String get proxyConflictHint => '如果这是其他代理软件或 VPN，请将其关闭，同时运行可能导致连接异常';

  @override
  String get diagTrafficCapture => '流量接管';

  @override
  String get diagNoCapture => '系统代理与虚拟网卡均未开启';

  @override
  String get diagCaptureHint => '开启系统代理或虚拟网卡，或为目标应用手动配置本地代理';

  @override
  String get diagSystemDns => '系统 DNS';

  @override
  String get diagCoreDns => '内核 DNS';

  @override
  String diagProbeSummary(int passed, int total) {
    return '抽查 $total 项，$passed 项通过';
  }

  @override
  String diagProbeResult(int index, String result, int milliseconds) {
    return '检测 $index：$result · $milliseconds ms';
  }

  @override
  String get diagDnsServerFailed => 'DNS 上游返回服务端故障';

  @override
  String get diagDnsReady => '抽查域名解析成功';

  @override
  String get diagDnsPartial => '仅部分抽查域名解析成功';

  @override
  String get diagOixDnsNoSample => '本次未找到可抽查的受管节点域名';

  @override
  String get diagOixDnsAuthMissing => '受管 DNS 签名功能尚未就绪';

  @override
  String get diagDnsNoAnswer => 'DNS 未返回可用地址，仅凭此结果无法确认认证失败';

  @override
  String get diagDnsRefused => 'DNS 请求被拒绝';

  @override
  String get diagDnsHint =>
      '检查 DNS 覆写设置并尝试其他网络；系统 DNS 正常而内核 DNS 失败时，优先检查配置中的 DNS 设置';

  @override
  String get diagOixDnsHint => '核对客户端版本与系统时间后刷新订阅；仍解析失败时，将诊断报告提供给客服';

  @override
  String get diagSystemPath => '系统网络路径';

  @override
  String get diagProxyPath => '通过本地代理访问';

  @override
  String diagWebResult(Object count) {
    return '两处独立 HTTPS 检测中有 $count 处通过';
  }

  @override
  String get diagSystemPathHint =>
      '此路径未显式使用客户端 HTTP 代理，但仍可能经过虚拟网卡；抽查失败可能与 DNS、网络拦截或检测站点有关，请对比本地代理结果';

  @override
  String get diagProxyPathHint =>
      '系统路径正常时，优先检查当前节点、分流规则与内核 DNS；某个检测站点失败不代表所有节点均不可用';

  @override
  String get diagClock => '系统时间对比';

  @override
  String get diagClockUnknown => '未获得足够的未缓存 HTTPS 响应，无法对比时间';

  @override
  String get diagClockSkew => '两处独立响应均提示时间可能偏差至少五分钟';

  @override
  String get diagClockReady => '本次抽查未发现一致的大幅时间偏差';

  @override
  String get diagClockHint => '启用系统自动设置日期和时间后重试；时间错误可能影响证书校验和 oixCloud DNS 签名';

  @override
  String get diagAllFailed => '本组本轮节点测速全部失败，也可能是测速地址不可达，可运行网络自检';

  @override
  String get updateDownloadBackground => '移到后台下载';

  @override
  String get updateReady => '更新已就绪';

  @override
  String get updateRestart => '更新并重新打开';

  @override
  String get updateRestartHint => '应用将退出、原位更新并重新打开，已有配置会保留';

  @override
  String get updatePreparing => '正在准备安装更新';

  @override
  String get updateVerifying => '正在校验更新包';

  @override
  String get updateCheckingInstaller => '正在检查安装程序';

  @override
  String get updateRestarting => '正在退出并重启';

  @override
  String get updateApplyFailed => '自动更新未完成，请重试或从下载页面更新';

  @override
  String get updateReadyHint => '更新已下载完成，可在方便时安装';

  @override
  String get updateInstall => '安装更新';

  @override
  String get updateDownloading => '正在下载更新';

  @override
  String get updateDownloadFailed => '更新下载失败';

  @override
  String get updateDownloadBrowser => '使用浏览器下载';

  @override
  String get updatePackageFormat => '选择安装包格式';

  @override
  String get updatePackageFormatTip => '无法确定当前的安装方式，请选择与之匹配的格式';

  @override
  String get updateAppImageTip => 'AppImage 无法自动安装，请用下载的文件替换当前程序，已打开文件所在目录';

  @override
  String get updatePackageManagerTip => '当前版本由系统包管理器安装，请按安装时的方式升级';

  @override
  String get tunMtuDesc => '默认 9000，可尝试 1480 或 4064；Android VPN 需重启后生效';

  @override
  String get tunMtuInvalid => '请输入 1280–65535 之间的整数';

  @override
  String get scriptOptions => '脚本选项';

  @override
  String get scriptOptionsEmpty => '此脚本没有提供可配置的开关';

  @override
  String get scriptChanges => '脚本变更';

  @override
  String get scriptFullConfig => '完整配置';

  @override
  String get scriptChangesDescription => '此处列出脚本新增、修改和删除的顶层配置项，完整配置还包含应用设置';

  @override
  String get scriptChangesEmpty => '脚本未改变配置';

  @override
  String scriptChangesAdded(int count) {
    return '新增（$count）';
  }

  @override
  String scriptChangesModified(int count) {
    return '修改（$count）';
  }

  @override
  String scriptChangesRemoved(int count) {
    return '删除（$count）';
  }

  @override
  String get excludeNetworks => '按 IP 或网关暂停代理';

  @override
  String get excludeNetworksDesc =>
      '匹配 Wi-Fi 或以太网的 IPv4 地址、网段或网关时暂停，离开后恢复；用逗号分隔，例如 192.168.1.0/24,gateway:192.168.1.1';

  @override
  String get excludeNetworksInvalid => '最多 16 条规则，请输入有效的 IPv4、网段或 gateway:地址';

  @override
  String get delayConcurrency => '批量测速并发数';

  @override
  String get delayTestFailed => '测试失败';

  @override
  String get updateReleaseNotes => '更新日志';

  @override
  String get updateDownloadConfirm => '下载更新';

  @override
  String get updateLater => '稍后';

  @override
  String get updateCancelDownload => '取消下载';

  @override
  String get updateNotice => '检测到新版本';

  @override
  String updateVersionNumber(String version) {
    return '版本号：$version';
  }

  @override
  String updateBuildNumber(String build) {
    return '构建号：$build';
  }

  @override
  String get updateReleaseNotesFailed => '更新日志加载失败，请重试';

  @override
  String get tailscaleEntryHint => '访问你的 Tailnet 中的设备';

  @override
  String get tailscaleEmptyTitle => '访问你的 Tailnet';

  @override
  String get tailscaleEmptyDesc => '添加网络并在此设备上登录，启动代理后即可访问你的设备';

  @override
  String get tailscaleAddNetwork => '添加网络';

  @override
  String get tailscaleNetworks => '网络';

  @override
  String get tailscaleGuide => '使用说明';

  @override
  String get tailscaleThisDevice => '此设备';

  @override
  String get tailscaleStatus => '状态';

  @override
  String get tailscaleDeviceName => '设备名称';

  @override
  String tailscaleDevices(Object count) {
    return '设备（$count）';
  }

  @override
  String get tailscaleNetworkName => '网络名称';

  @override
  String get tailscaleNameInUse => '此名称已被使用';

  @override
  String get tailscaleLoginMethod => '登录方式';

  @override
  String get tailscaleInteractiveLogin => '交互式登录';

  @override
  String get tailscaleAuthKey => '认证密钥';

  @override
  String get tailscaleAuthKeySaved => '此设备已保存认证密钥，填写新密钥即可替换';

  @override
  String get tailscaleLoginFooter => '每个网络在此设备上登录一次即可';

  @override
  String get tailscaleAutoRoute => '自动路由';

  @override
  String get tailscaleAutoRouteDesc => '自动通过此网络访问对等设备地址、MagicDNS 名称和已批准的子网';

  @override
  String get tailscaleExitNode => '出口节点';

  @override
  String get tailscaleExitNodeDesc => '留空表示不使用，也可填写 auto、对端名称或对端 IP 地址';

  @override
  String get tailscaleAvailableExitNodes => '可用的出口节点';

  @override
  String get tailscaleExitNodeAllowLan => '允许访问本地网络';

  @override
  String get tailscaleAdvanced => '高级';

  @override
  String get tailscaleControlUrl => '控制服务器地址';

  @override
  String get tailscaleCredentialsFooter => '认证信息和设备身份仅保存在此设备';

  @override
  String get tailscaleAccount => '账户';

  @override
  String get tailscaleSaveAndLogin => '保存并登录';

  @override
  String get tailscaleOpenLoginPage => '打开登录页面';

  @override
  String get tailscaleLoginWaiting => '打开登录页面或扫码，授权后将自动完成登录';

  @override
  String get tailscaleSigningIn => '正在登录';

  @override
  String get tailscaleSignedIn => '已登录';

  @override
  String get tailscaleLogout => '退出登录';

  @override
  String get tailscaleLoginFailed => 'Tailscale 登录失败';

  @override
  String get tailscaleLoginTimeout => '五分钟内未完成登录，请重试';

  @override
  String get tailscaleLoginHint => '登录用于授权此设备，启动代理后才能使用此网络';

  @override
  String get tailscaleEnterAuthKey => '请填写认证密钥以在此设备上登录';

  @override
  String tailscaleCheckSettings(Object fields) {
    return '请检查以下设置：$fields';
  }

  @override
  String get tailscaleNotApplied => '未生效';

  @override
  String get tailscaleNotAppliedHint => '网络尚未在运行中的配置里生效，请先选择配置，并确认配置中没有同名节点';

  @override
  String get tailscaleNotSignedIn => '未登录';

  @override
  String get tailscaleNeedsLogin => '需要登录';

  @override
  String get tailscaleKeyExpired => '节点密钥已过期';

  @override
  String get tailscaleNeedsApproval => '等待设备审批';

  @override
  String get tailscaleConnecting => '正在连接';

  @override
  String get tailscaleConnected => '已连接';

  @override
  String get tailscaleStopped => '已停止';

  @override
  String get tailscaleUnavailable => '连接不可用';

  @override
  String get tailscaleOnline => '在线';

  @override
  String get tailscaleOffline => '离线';

  @override
  String get tailscaleRemoveNetwork => '移除网络';

  @override
  String tailscaleRemoveConfirm(Object name) {
    return '此设备将退出 $name，并删除此设备上的登录信息；如果当前无法连接该网络，请到 Tailscale 管理后台移除此设备';
  }

  @override
  String tailscaleNetworkInUse(Object name, Object profile) {
    return '$name 仍被配置「$profile」中的规则或策略组使用';
  }

  @override
  String get tailscaleGuideGetStarted => '开始使用';

  @override
  String get tailscaleGuideGetStartedBody =>
      '添加网络并选择“保存并登录”，打开登录页面并授权此设备，登录将自动完成\n使用认证密钥登录时，选择“认证密钥”并填写密钥，无需通过浏览器登录\n启动代理后才能访问此网络，仅登录不会接管任何流量';

  @override
  String get tailscaleGuideDevices => '设备与 MagicDNS';

  @override
  String get tailscaleGuideDevicesBody =>
      '自动路由会把已知对等设备的地址和 MagicDNS 名称，以及 Tailnet 中已批准的子网送入此网络，其他流量仍遵循你的规则\n自动路由位于你添加的规则和自定义规则之后、配置自带的规则之前\n使用自建控制服务器的自有域名时，只接管已知设备的名称，该域名下的公开网站不受影响\n此设备当前所在局域网内的子网地址仍走本地；如需访问地址相同的远程子网，请添加一条指向此网络的规则\n解析到已批准子网的域名同样经由此网络；若配置直接把该域名交给代理，请添加一条指向此网络的域名规则';

  @override
  String get tailscaleGuideExitNodes => '出口节点';

  @override
  String get tailscaleGuideExitNodesBody =>
      '填写出口节点后，此网络会出现在配置的选择组中；在组中选择它或添加指向它的规则后，相应流量才会经出口节点访问互联网\n留空表示不使用出口节点；auto 会选择一个可用的出口节点，填写设备名称或地址则使用指定设备';

  @override
  String get tailscaleGuideSignIn => '登录与备份';

  @override
  String get tailscaleGuideSignInBody =>
      '网络设置会随备份保存，认证密钥和设备身份只保留在此设备上，在其他设备上恢复后需要重新登录\n节点密钥过期后，请再次选择“保存并登录”；设备审批和访问权限在你的 Tailnet 中管理\n移除网络会让此设备退出登录，并删除此设备上的设备身份';

  @override
  String get tailscaleGuideTroubleshooting => '故障排查';

  @override
  String get tailscaleGuideTroubleshootingBody =>
      '确认代理已启动、此设备已获批准且对等设备在线；访问子网或互联网时，还需检查路由批准状态和出口节点\n状态为“未生效”时，说明运行中的配置不包含此网络，请先选择配置，并确认配置中没有同名节点\n本应用只主动访问你的 Tailnet，不接受来自 Tailnet 的入站连接，也不会把此设备发布为子网路由器或出口节点';

  @override
  String get tailscaleNameInvalid => '不超过 64 个字符，且不能包含逗号';

  @override
  String get tailscaleHostnameInvalid => '只能使用小写字母、数字和连字符，最多 63 个字符';

  @override
  String get tailscaleAuthKeyInvalid => '认证密钥格式不正确';

  @override
  String get tailscaleDirect => '直连';

  @override
  String tailscaleRelay(Object region) {
    return '中继 $region';
  }

  @override
  String get tailscaleExitNodeActive => '正在使用的出口节点';

  @override
  String get quickAdd => '快捷添加';

  @override
  String get rulePresetBlockQuic => '屏蔽 QUIC';

  @override
  String get rulePresetBlockStun => '屏蔽 STUN';

  @override
  String get rulePresetBlockDot => '屏蔽 DNS over TLS';

  @override
  String get rulePresetBlockLoopback => '防止代理回环';

  @override
  String get rulePresetLanDirect => '局域网直连';

  @override
  String get rulePresetSystemServicesDirect => 'Apple 与 Microsoft 直连';

  @override
  String get rulePresetBittorrentDirect => 'BT 下载直连';

  @override
  String get rulePresetInsertHint => '所选预设会添加到现有规则之前，相同规则不会重复添加';

  @override
  String get overwriteIssueEmptyName => '名称为空';

  @override
  String overwriteIssueReservedName(Object name) {
    return '$name 是内置策略名，不能在此使用';
  }

  @override
  String overwriteIssueDuplicateName(Object name) {
    return '名称 $name 已被其他代理或策略组使用';
  }

  @override
  String get overwriteIssueNoProxySource => '未选择任何代理或代理集，内核会拒绝该策略组';

  @override
  String overwriteIssueMissingProxies(Object names) {
    return '以下代理或策略不存在：$names';
  }

  @override
  String overwriteIssueMissingProviders(Object names) {
    return '以下代理集不存在：$names';
  }

  @override
  String overwriteIssueEmptyFallback(Object name) {
    return '空组回退必须指向已有节点或内置出站，不能指向策略组：$name';
  }

  @override
  String overwriteIssueGroupLoop(Object path) {
    return '策略组之间存在循环引用：$path';
  }

  @override
  String invalidPolicy(Object target) {
    return '$target 是一个无效的策略';
  }

  @override
  String invalidRuleSet(Object ruleSet) {
    return '$ruleSet 不是有效的规则集';
  }

  @override
  String invalidSubRule(Object subRule) {
    return '$subRule 是一个无效的SUB_RULE';
  }

  @override
  String get safeMode => '安全模式';

  @override
  String safeModeAppTitle(Object appName) {
    return '$appName（安全模式）';
  }

  @override
  String get hideTimeoutProxies => '隐藏测速失败的节点';

  @override
  String get delayTestQueued => '排队中';

  @override
  String get delayTestRunning => '测速中';

  @override
  String get dnsQueries => 'DNS 查询';

  @override
  String get dnsQueriesDesc => '查看最近 500 条解析查询记录';

  @override
  String get dnsQueryCached => '缓存命中';

  @override
  String get dnsQueryUpstream => '上游解析器';

  @override
  String get dnsQueryAnswers => '解析结果';

  @override
  String get dnsQueryRcode => '响应码';

  @override
  String get dnsQueryType => '查询类型';

  @override
  String get pauseUpdates => '暂停刷新';

  @override
  String get resumeUpdates => '恢复刷新';

  @override
  String get dnsQueryAll => '全部查询';

  @override
  String get dnsQueryFailures => '失败查询';

  @override
  String get dnsQueryInitiatorApp => '应用';

  @override
  String get dnsQueryInitiatorRule => '规则匹配';

  @override
  String get dnsQueryInitiatorDirect => '直连连接';

  @override
  String get dnsQueryInitiatorProxy => '代理连接';

  @override
  String get dnsQueryInitiatorOther => '其他';

  @override
  String get action_ruleMode => '规则模式';

  @override
  String get action_globalMode => '全局模式';

  @override
  String get action_directMode => '直连模式';

  @override
  String get action_delayTest => '节点测速';

  @override
  String get action_updateProfiles => '更新订阅';

  @override
  String get action_copyEnv => '复制代理环境变量';

  @override
  String get action_exit => '退出';

  @override
  String get hotkeyUnavailable => '快捷键注册失败';

  @override
  String get runTime => '运行时间';

  @override
  String get floatingNavigationBar => '悬浮导航';

  @override
  String get localNetworkTip => '未获准访问局域网，本次连接改用 gVisor；局域网代理和服务仍可能不可用';

  @override
  String get sidebar => '侧边栏';

  @override
  String get backgroundBlur => '背景模糊';

  @override
  String get sidebarBlurDesc => '背景模糊会让侧边栏透出窗口后方的桌面';

  @override
  String get format => '格式';

  @override
  String get behavior => '行为';

  @override
  String get appProviderLibrary => '应用资源库';

  @override
  String get providerLocal => '本地文件';

  @override
  String get providerRemote => '远程地址';

  @override
  String get providerContent => '资源内容';

  @override
  String get providerContentInvalid => '资源内容或格式无效';

  @override
  String get providerContentTooLarge => '资源超过 32 MiB';

  @override
  String get providerChanged => '资源已发生变化，请重新打开后编辑';

  @override
  String get providerNameInvalid => '名称不能为空，且不能包含逗号或换行';

  @override
  String providerInUse(String profiles) {
    return '资源仍被以下配置或规则引用：$profiles';
  }

  @override
  String providerRenameShadowed(String profiles) {
    return '改名会改变以下配置中的订阅资源引用：$profiles';
  }

  @override
  String get providerUrlTip => '请输入不含内嵌账号密码的 HTTP 或 HTTPS 地址';

  @override
  String providerSourceReference(String profiles) {
    return '请先在原始配置中修改资源引用，再改名：$profiles';
  }

  @override
  String providerSourceUnavailable(String profiles) {
    return '无法读取以下配置，暂不能检查引用：$profiles';
  }

  @override
  String get nodeDefinition => '完整节点定义';

  @override
  String get nodeQuickFields => '快速编辑';

  @override
  String get nodeCoreValidationUnavailable => '请先启动 Core，再验证节点';

  @override
  String get nodeInvalidDefinition => '请输入包含 name 和 type 的单个完整节点定义';

  @override
  String get releaseMemory => '释放内存';

  @override
  String get memoryCoreHeapInuse => '堆内存使用中';

  @override
  String get memoryCoreHeapIdle => '堆内存空闲';

  @override
  String get memoryCoreStack => '协程栈';

  @override
  String get memoryCoreRuntime => '运行时开销';

  @override
  String get memoryCoreNotRunning => '内核未运行';

  @override
  String get memoryAppResident => '常驻内存';

  @override
  String get memoryAppShared => '应用及共享';

  @override
  String get memoryEstimateDesc => '基于进程常驻内存估算，可能与系统显示的数值不同。';

  @override
  String get memoryEstimateSharedDesc =>
      '内核与应用运行在同一进程，内核部分按运行时统计估算，其余计入应用及共享内存。';

  @override
  String get memoryReleased => '内存已释放';

  @override
  String memoryReleasedSize(Object size) {
    return '已释放 $size';
  }

  @override
  String get releaseMemoryFailed => '释放内存失败';

  @override
  String get total => '总计';

  @override
  String get showNotificationStopAction => '通知栏显示停止按钮';

  @override
  String get interfaceName => '网卡名称';

  @override
  String get interfaceNameMode => '出站网卡';

  @override
  String get interfaceNameDesc => '网卡名称为出站连接使用的网卡';

  @override
  String get interfaceFollowProfile => '跟随配置';

  @override
  String get interfaceAutomatic => '清除绑定（自动选择网卡）';

  @override
  String get hideIp => '隐藏 IP';

  @override
  String get cameraPermissionRequired => '需要相机权限';

  @override
  String get cameraPermissionDesc => '请在系统设置中允许访问相机以扫描二维码，或从相册选择二维码图片。';

  @override
  String get cameraUnavailable => '相机不可用';

  @override
  String get invalidProfileQrcode => '该二维码不包含配置文件链接';

  @override
  String get pickFromAlbum => '从相册选择';

  @override
  String get retry => '重试';

  @override
  String get toggleFlashlight => '切换闪光灯';

  @override
  String get networkTimeoutError => '请求超时，请检查网络或代理后重试';

  @override
  String get networkHostLookupError => '无法解析服务器地址，请确认链接正确且 DNS 可用';

  @override
  String get monochromeIcon => '单色图标';

  @override
  String get networkConnectionError => '无法连接到服务器，请检查网络连接或代理设置';

  @override
  String get networkTlsError => '安全连接失败，服务器证书可能无效，或连接被拦截';

  @override
  String get networkCancelledError => '请求已取消';

  @override
  String networkAccessDeniedError(Object code) {
    return '服务器拒绝访问（HTTP $code），链接可能已过期或凭据有误';
  }

  @override
  String networkNotFoundError(Object code) {
    return '该地址下没有内容（HTTP $code），请确认链接是否正确';
  }

  @override
  String get networkRateLimitedError => '请求过于频繁（HTTP 429），请稍后再试';

  @override
  String networkServerError(Object code) {
    return '服务器出现问题（HTTP $code），请稍后再试';
  }

  @override
  String networkBadResponseError(Object code) {
    return '服务器拒绝了请求（HTTP $code）';
  }

  @override
  String get clipboardWriteFailed => '无法复制到剪贴板，所选内容可能过大';

  @override
  String get lineWrap => '自动换行';

  @override
  String get previousMatch => '上一个匹配';

  @override
  String get nextMatch => '下一个匹配';

  @override
  String get editorUnavailable => '编辑器不可用';

  @override
  String get replaceAll => '全部替换';

  @override
  String get fontSize => '大小';

  @override
  String get replace => '替换';

  @override
  String get locateSelected => '定位当前节点';

  @override
  String get expandList => '展开';

  @override
  String get collapseList => '收起';

  @override
  String get clearSearch => '清除搜索';

  @override
  String get closeAllConnections => '关闭所有连接';

  @override
  String get showMore => '展开';

  @override
  String get showLess => '收起';

  @override
  String get showPassword => '显示密码';

  @override
  String get hidePassword => '隐藏密码';

  @override
  String get switchProfile => '切换配置';

  @override
  String get subscriptionInfo => '订阅信息';

  @override
  String get lastUpdated => '上次更新';

  @override
  String proxiesCount(num count) {
    return '$count 个代理';
  }

  @override
  String rulesCount(num count) {
    return '$count 条规则';
  }

  @override
  String get back => '返回';

  @override
  String get noSearchResults => '没有匹配的结果';

  @override
  String get proxyNode => '代理节点';

  @override
  String get rules => '规则';

  @override
  String get addOverrideEntry => '添加覆写项';

  @override
  String get batchAdd => '批量添加';

  @override
  String get batchListInputTip => '每行一项，也可用逗号分隔';

  @override
  String get batchMapInputTip => '每行一条，键和值之间用空格分隔';

  @override
  String batchPreviewTip(Object count, Object skipped) {
    return '将添加 $count 项，跳过 $skipped 项已存在';
  }

  @override
  String get cacheAlgorithm => '缓存算法';

  @override
  String get cacheMaxSize => '缓存大小';

  @override
  String get dialerProxy => '拨号代理';

  @override
  String get dialerProxyDesc => '拨号代理为连接 NTP 服务器使用的出站';

  @override
  String dialerProxyLoopStopped(Object name) {
    return '经 $name 拨号会绕回使用它的代理，连接已中止';
  }

  @override
  String get discardChanges => '是否放弃更改？';

  @override
  String get fakeipFilterMode => 'Fake-IP过滤模式';

  @override
  String get fakeipFilterModeDesc =>
      'Fake-IP 过滤模式中，blacklist 排除匹配项，whitelist 仅用于匹配项，rule 按规则匹配';

  @override
  String get fakeipRange6 => 'Fake-IP范围（IPv6）';

  @override
  String get fakeipTtl => 'Fake-IP TTL';

  @override
  String get ipv6Timeout => 'IPv6超时（毫秒）';

  @override
  String lineIssueTip(Object line, Object message) {
    return '第 $line 行：$message';
  }

  @override
  String get listenRoutingMark => '监听路由标记';

  @override
  String get listenRoutingMarkDesc => '监听路由标记仅在 Linux 生效';

  @override
  String maxLengthTip(Object label, Object max) {
    return '$label最多$max个字符';
  }

  @override
  String get ntpInterval => '同步间隔（分钟）';

  @override
  String get ntpStatusDesc => '开启 NTP 后从 NTP 服务器获取时间，而非系统时钟';

  @override
  String get overrideEntries => '覆写项';

  @override
  String get quickEdit => '快速编辑';

  @override
  String get server => '服务器';

  @override
  String get singleAdd => '单条添加';

  @override
  String singleValueTip(Object label) {
    return '$label只能是一项';
  }

  @override
  String get writeToSystem => '写入系统';

  @override
  String get writeToSystemDesc => '写入系统会同时设置系统时钟，Android 上不生效';

  @override
  String get basicInfo => '基础信息';

  @override
  String get ruleActionIpSuffixDesc => '匹配 IP 后缀范围';

  @override
  String get ruleActionDomainSuffixDesc => '匹配域名后缀';

  @override
  String get ruleActionMatchDesc => '匹配所有请求，无需条件';

  @override
  String get ruleActionSrcGeoipDesc => '匹配来源 IP 所属国家代码';

  @override
  String get ruleActionDomainWildcardDesc => '通配符匹配，仅支持*和?通配符';

  @override
  String get ruleActionAndDesc => '逻辑规则 AND';

  @override
  String get ruleActionIpCidr6Desc => '匹配 IP 地址范围，IP-CIDR6 只是一个别名';

  @override
  String get ruleActionDomainRegexDesc => '使用域名正则表达式匹配';

  @override
  String get ruleActionProcessPathRegexDesc => '使用进程路径正则表达式匹配';

  @override
  String get ruleActionDstPortDesc => '匹配请求目标端口范围';

  @override
  String get ruleActionDscpDesc => '匹配DSCP标记（仅限 tproxy udp 入站）';

  @override
  String get ruleActionInPortDesc => '匹配入站端口';

  @override
  String get ruleActionUidDesc => '匹配 Linux USER ID';

  @override
  String get ruleActionIpCidrDesc => '匹配 IP 地址范围';

  @override
  String get ruleActionRuleSetDesc => '引用规则集合，需配置rule-providers';

  @override
  String get ruleActionGeositeDesc => '匹配 Geosite 内的域名';

  @override
  String get ruleActionNetworkDesc => '匹配TCP或者UDP';

  @override
  String get ruleActionProcessPathDesc => '使用完整进程路径匹配';

  @override
  String get ruleActionProcessPathWildcardDesc => '使用进程路径通配符匹配，仅支持*和?通配符';

  @override
  String get ruleActionRematchNameDesc => '匹配重匹配名称，多个名称用/分隔';

  @override
  String get ruleActionSrcIpSuffixDesc => '匹配来源 IP 后缀范围';

  @override
  String get ruleActionGeoipDesc => '匹配 IP 所属国家代码';

  @override
  String get ruleActionInUserDesc => '匹配入站用户名，支持使用 / 分隔多个用户名';

  @override
  String get invalidNetworkContent => '仅支持 tcp 或 udp';

  @override
  String get ruleActionDomainKeywordDesc => '匹配域名关键字';

  @override
  String get ruleActionNotDesc => '逻辑规则 NOT';

  @override
  String get ruleActionSrcIpAsnDesc => '匹配来源 IP 所属 ASN';

  @override
  String get invalidRangeContent => '请输入数字或范围，如 80 或 8000-9000，多个用 / 分隔';

  @override
  String get ruleActionProcessNameRegexDesc => '使用进程名称正则表达式匹配，在Android平台可以匹配包名';

  @override
  String get ruleActionSrcIpCidrDesc => '匹配来源 IP 地址范围';

  @override
  String get ruleActionDomainDesc => '匹配完整域名';

  @override
  String get ruleActionInNameDesc => '匹配入站名称';

  @override
  String get invalidDscpContent => 'DSCP 标记不能超过 63';

  @override
  String get invalidCidrContent => '请输入 CIDR 格式的 IP 段，如 192.168.0.0/16';

  @override
  String get invalidIpv6CidrContent => '请输入 CIDR 格式的 IPv6 段，如 fd00::/8';

  @override
  String get invalidHostContent => '请输入域名或 IP 地址';

  @override
  String get invalidListenContent => '请输入地址和端口，如 0.0.0.0:1053';

  @override
  String get ruleActionIpAsnDesc => '匹配 IP 所属 ASN';

  @override
  String get ruleActionSrcPortDesc => '匹配请求来源端口范围';

  @override
  String get ruleActionInTypeDesc => '匹配入站类型';

  @override
  String get ruleActionOrDesc => '逻辑规则 OR';

  @override
  String get ruleActionSubRuleDesc => '匹配至子规则，需要注意括号的使用';

  @override
  String get ruleActionProcessNameWildcardDesc => '使用进程名称通配符匹配，仅支持*和?通配符';

  @override
  String get ruleActionProcessNameDesc => '使用进程匹配，在Android平台可以匹配包名';

  @override
  String get general => '常规';

  @override
  String get startupAndBackground => '启动与后台';

  @override
  String get inbound => '入站';

  @override
  String get outbound => '出站';

  @override
  String get logsAndDiagnostics => '日志与诊断';

  @override
  String get onDemand => '按需运行';

  @override
  String get onDemandDesc => '按需运行会按 Wi-Fi 或网络条件自动暂停和恢复代理';

  @override
  String get prerequisites => '前置条件';

  @override
  String get suspended => '挂起中…';

  @override
  String get enabled => '已开启';

  @override
  String get enabledOnStart => '启动后启用';

  @override
  String get disabled => '已关闭';

  @override
  String overwriteIssuesSummary(Object count) {
    return '$count 项存在问题，应用覆写可能失败';
  }

  @override
  String get ignoreBatteryOptimization => '忽略电池优化';

  @override
  String get batteryOptimizationDesc => '忽略电池优化可保证应用在后台运行';

  @override
  String get batteryOptimizationStatusTip => '由于系统限制，运行状态下无法正确获取电池优化状态';

  @override
  String get authorized => '已授权';

  @override
  String get tapToAuthorize => '点击授权';

  @override
  String get addSsid => '添加SSID';

  @override
  String get editSsid => '编辑SSID';

  @override
  String get ssidsEmpty => 'SSIDs为空';

  @override
  String get hotkeyDesc => '全局快捷键在窗口隐藏时依然生效，点击操作即可录制组合键';

  @override
  String get hotkeyNotSet => '未设置';

  @override
  String hotkeyNeedsModifier(Object modifiers) {
    return '至少包含 $modifiers 中的一个';
  }

  @override
  String hotkeyConflictWith(Object action) {
    return '已被“$action”使用，保存后将移到这里';
  }

  @override
  String get confirmExitWindow => '确定要退出当前窗口吗？';

  @override
  String get dataChangedSave => '检测到数据有更改，是否保存';

  @override
  String get discard => '放弃';

  @override
  String get docked => '固定';

  @override
  String get fade => '淡入';

  @override
  String get floating => '悬浮';

  @override
  String get followSystem => '跟随系统';

  @override
  String get navigationBarStyle => '底栏';

  @override
  String get pureBlack => '纯黑';

  @override
  String get slide => '滑动';

  @override
  String get textScalePreview => '应用内的文字将以这个大小显示';

  @override
  String get basicStrategy => '基础策略';

  @override
  String get nonTextProviderFile => '该外部资源不是文本文件';

  @override
  String get scriptChanged => '脚本已修改或删除，请重新打开后再试';

  @override
  String get startFromScratch => '从零开始';

  @override
  String get optional => '可选';

  @override
  String get coreBlockedBySmartAppControlTip =>
      'Windows 阻止了 FlClashCore.exe，当前已开启智能应用控制，请在 Windows 安全中心 → 应用和浏览器控制中查看拦截详情，并使用来源可信、经过验证的发行版本';

  @override
  String get helperCorruptTip => 'Helper 服务不可用，无法启用 TUN 模式，请重新安装 FlClash';

  @override
  String get changeProxyFailedTip => '切换代理失败，已恢复上一次的选择';

  @override
  String get databaseWriteFailedTip => '保存更改失败，请检查当前值后重试';

  @override
  String get proxyType => '节点类型';

  @override
  String get providerSourceSubscription => '订阅';

  @override
  String get providerSourceProfile => '配置文件';

  @override
  String get providerSourceApp => '应用资源库';

  @override
  String get target => '目标';

  @override
  String get outboundExit => '出口';

  @override
  String get protocol => '协议';

  @override
  String get traffic => '流量';

  @override
  String get totalDownload => '下载总量';

  @override
  String get totalUpload => '上传总量';

  @override
  String get duration => '时长';

  @override
  String get initiatorShort => '发起';

  @override
  String get result => '结果';

  @override
  String get elapsed => '耗时';

  @override
  String get tunOverrideDesc =>
      '添加的项会覆写所有配置的虚拟网卡设置，未添加的项沿用配置自身的设置。自定义配置自己添加的项优先';

  @override
  String get dnsOverrideDesc =>
      '添加的项会覆写所有配置的 DNS 设置，未添加的项沿用配置自身的设置。自定义配置自己添加的项优先';

  @override
  String get ntpOverrideDesc =>
      '添加的项会覆写所有配置的 NTP 设置，未添加的项沿用配置自身的设置。自定义配置自己添加的项优先';

  @override
  String get congestionController => 'TCP 拥塞控制';

  @override
  String get congestionControllerDesc => 'TCP 拥塞控制仅在 mips 栈生效';

  @override
  String get strictRoute => '严格路由';

  @override
  String get strictRouteDesc => '严格路由防止 DNS 等流量绕过虚拟网卡，关闭 IPv6 时会阻断本机的 IPv6 连接';

  @override
  String get routeExcludeAddress => '排除路由地址';

  @override
  String get udpTimeout => 'UDP 超时';

  @override
  String get udpTimeoutDesc => 'UDP 超时以秒为单位，仅在 gvisor、system 和 mixed 栈生效';

  @override
  String get dnsHijackDesc => '未添加时劫持所有发往 53 端口的 DNS 请求（any:53）';

  @override
  String get disableIcmpForwarding => '禁用ICMP转发';

  @override
  String get disableIcmpForwardingDesc =>
      '禁用 ICMP 转发后由虚拟网卡直接应答 ping，ping 将不再显示真实延迟';

  @override
  String get includeInterface => '包含网卡';

  @override
  String get includeInterfaceDesc => '只有从包含网卡进入的流量经过虚拟网卡，设置后排除网卡不再生效';

  @override
  String get excludeInterface => '排除网卡';

  @override
  String get excludeInterfaceDesc => '从这些网卡（如 docker0）进入的流量不经过虚拟网卡';

  @override
  String get includeUid => '包含用户 ID';

  @override
  String get includeUidDesc => '只有这些用户 ID 的进程产生的流量经过虚拟网卡';

  @override
  String get excludeUid => '排除用户 ID';

  @override
  String get excludeUidDesc => '这些用户 ID 的进程产生的流量不经过虚拟网卡';

  @override
  String get excludeSrcPort => '排除源端口';

  @override
  String get excludeSrcPortDesc => '源端口为这些端口的流量不经过虚拟网卡';

  @override
  String get excludeDstPort => '排除目标端口';

  @override
  String get excludeDstPortDesc => '发往这些目标端口的流量不经过虚拟网卡';

  @override
  String numberRangeTip(Object label, Object min, Object max) {
    return '$label必须在 $min 到 $max 之间';
  }

  @override
  String get customProfile => '自定义配置';

  @override
  String get customProfileDesc => '基于自有节点、资源库和其他配置组建策略组与规则';

  @override
  String get emptyCustomProfile => '请先为该自定义配置添加策略组或规则';

  @override
  String get nameCustomProfileTip => '为该自定义配置命名';

  @override
  String profileProviderInUse(Object profiles) {
    return '该配置仍是 $profiles 的代理提供者，请先在其中移除';
  }

  @override
  String get healthCheck => '健康检查';

  @override
  String get additionalPrefix => '名称前缀';

  @override
  String get additionalSuffix => '名称后缀';

  @override
  String get ipVersion => 'IP 版本';

  @override
  String get profileSettingsDesc => '仅作用于当前配置，未添加的项使用默认值';

  @override
  String get profileOverrideSettingsDesc =>
      '仅作用于当前配置，并优先于应用 DNS、NTP 设置中的覆写项，未添加的项沿用这些覆写项';

  @override
  String get profileTunSettingsDesc => '仅作用于当前配置，并优先于网络设置中的虚拟网卡覆写项';

  @override
  String get settingEntries => '设置项';

  @override
  String get addSettingEntry => '添加设置项';

  @override
  String settingsCount(num count) {
    return '$count 项设置';
  }

  @override
  String get sniffer => '域名嗅探';

  @override
  String get snifferStatusDesc => '域名嗅探从 TLS、HTTP、QUIC 流量中识别域名，供规则匹配';

  @override
  String get overrideDestination => '覆盖目标地址';

  @override
  String get overrideDestinationDesc => '覆盖目标地址使用嗅探到的域名替换原目标地址发起连接';

  @override
  String get forceDnsMapping => '强制DNS映射';

  @override
  String get forceDnsMappingDesc => '强制 DNS 映射对通过 DNS 映射得到域名的连接也进行嗅探';

  @override
  String get parsePureIp => '解析纯IP';

  @override
  String get parsePureIpDesc => '解析纯 IP 会嗅探只有 IP 地址的连接';

  @override
  String get forceDomain => '强制嗅探域名';

  @override
  String get forceDomainDesc => '强制嗅探域名中的域名同样会被嗅探，其余已有域名的连接不嗅探';

  @override
  String get skipDomain => '跳过域名';

  @override
  String get skipDomainDesc => '嗅探到跳过域名中的域名时不予采用';

  @override
  String get skipSrcAddress => '跳过来源地址';

  @override
  String get skipDstAddress => '跳过目标地址';

  @override
  String get sniffProtocols => '协议';

  @override
  String get ports => '端口';

  @override
  String get invalidPortRangeContent => '请输入端口或范围，如 443 或 8000-9000';

  @override
  String get importConfig => '导入配置';

  @override
  String get importText => '从文本导入';

  @override
  String get importConfigInvalid => '这不是可导入的配置';

  @override
  String get importConfigReplaceTip => '导入会替换此配置现有的节点、策略组、规则和设置';

  @override
  String get customImportCloudRefused => 'oixCloud 地址不能导入自定义配置';

  @override
  String get customImportNotImported => '未导入';

  @override
  String customImportDroppedSubRules(num count) {
    return '自定义配置不支持子规则，已丢弃 $count 条 SUB-RULE 规则';
  }

  @override
  String customImportUnnamedProxies(num count) {
    return '$count 个节点缺少名称或类型';
  }

  @override
  String failedItem(Object label, Object message) {
    return '$label：$message';
  }

  @override
  String shareLinkNodesAdded(num count) {
    return '已从分享链接添加 $count 个节点';
  }

  @override
  String shareLinksNotRead(num count) {
    return '$count 条链接无法识别';
  }

  @override
  String get connectionStats => '连接统计';

  @override
  String get connectionStatsDesc => '实时连接、最近请求、DNS 查询';

  @override
  String get currentOutboundDesc => '含启动键，不可移除';

  @override
  String get dashboardAddableSection => '可添加';

  @override
  String get dashboardReorderHint => '拖动卡片调整顺序，触屏操作请先长按';

  @override
  String get done => '完成';

  @override
  String get editDashboard => '编辑仪表盘';

  @override
  String groupCount(num count) {
    return '$count 个';
  }

  @override
  String get groupCountUnit => '个';

  @override
  String groupTimeoutCount(Object count) {
    return '$count 超时';
  }

  @override
  String get ipType => '类型';

  @override
  String get liveConnections => '实时连接';

  @override
  String get memoryInfoDesc => '应用与内核占用的内存';

  @override
  String get networkTakeover => '网络接管';

  @override
  String get notRunning => '未运行';

  @override
  String portValue(Object port) {
    return '端口 $port';
  }

  @override
  String profileDaysLeft(num days) {
    return '剩余 $days 天';
  }

  @override
  String profileExpiresIn(Object date, num days) {
    return '$date 到期，剩余 $days 天';
  }

  @override
  String profileUpdatedAt(Object time) {
    return '更新于 $time';
  }

  @override
  String get proxyGroupsAfterStart => '启动后在这里显示代理组';

  @override
  String get running => '运行中';

  @override
  String get serviceFailed => '检测失败';

  @override
  String get tapIconToRetry => '点击图标重试';

  @override
  String trafficPeak(Object value) {
    return '峰值 $value';
  }

  @override
  String trafficTotal(Object value) {
    return '累计 $value';
  }

  @override
  String get usedShort => '已用';

  @override
  String get disableKeepAlive => '禁用 TCP 保持活动';

  @override
  String get keepAliveIdle => 'TCP 保持活动空闲时间';

  @override
  String get routingMark => '路由标记';

  @override
  String get minutes => '分钟';

  @override
  String yearsAgoShort(num count) {
    return '$count 年前';
  }

  @override
  String monthsAgoShort(num count) {
    return '$count 个月前';
  }

  @override
  String daysAgoShort(num count) {
    return '$count 天前';
  }

  @override
  String hoursAgoShort(num count) {
    return '$count 小时前';
  }

  @override
  String minutesAgoShort(num count) {
    return '$count 分钟前';
  }

  @override
  String get expireTime => '到期时间';

  @override
  String get runtimeConfig => '运行时配置';

  @override
  String proxyGroupsCount(num count) {
    return '$count 个代理组';
  }

  @override
  String get confirmDeleteProxyGroup => '确定要删除当前代理组吗？';

  @override
  String invalidProxyProvider(Object providerName) {
    return '$providerName 是无效的代理提供者';
  }

  @override
  String customIssuesSummary(Object count) {
    return '$count 项存在问题，应用配置可能失败';
  }

  @override
  String sectionsInEffect(Object count) {
    return '$count 项生效';
  }

  @override
  String get emptyFallback => '空组兜底';

  @override
  String get testInterval => '测试间隔';

  @override
  String get testWhenUsed => '使用时测试';

  @override
  String get defaultSelected => '默认选中';

  @override
  String get hashByInUser => '按入站用户哈希';

  @override
  String get nodes => '节点';

  @override
  String get addNodes => '添加节点';

  @override
  String get autoInclude => '自动包含';

  @override
  String get filters => '筛选';

  @override
  String get inputProxyGroupName => '输入代理组名称';

  @override
  String get definitionNotMap => '配置必须是包含 name 和 type 的 YAML 映射';

  @override
  String get additionalParameters => '附加参数';

  @override
  String get quickActions => '快捷操作';

  @override
  String get ruleListInvalid =>
      '规则必须是 YAML 列表，每项一条规则，例如 - DOMAIN,example.com,DIRECT';

  @override
  String get goToConfigureAddedRules => '前往配置附加规则';

  @override
  String get large => '大';

  @override
  String get extraLarge => '超大';

  @override
  String get matchCase => '区分大小写';

  @override
  String get regex => '正则';

  @override
  String get yes => '是';

  @override
  String get no => '否';

  @override
  String get error => '错误';

  @override
  String get iconSets => '图标集';

  @override
  String get localImage => '本地图片';

  @override
  String get label => '标签';

  @override
  String get iconSetsEmptyTip => '暂无图标集，可在「自定义配置资源 → 图标集」中添加';

  @override
  String get recommendedIcons => '推荐';

  @override
  String get customProfileResources => '自定义配置资源';

  @override
  String get importFromLink => '从链接导入';

  @override
  String get sendFromPhone => '从手机发送';

  @override
  String get sendFromPhoneTip => '用手机相机扫描二维码，在打开的页面里粘贴链接；两台设备需要连在同一个网络';

  @override
  String get sendFromPhoneNoNetwork => '这台设备没有连接局域网';

  @override
  String get sendFromPhonePermissionDenied =>
      '从手机接收链接需要「附近的设备」权限，FlClash 才能访问局域网，请在应用设置中开启';

  @override
  String get sendFromPhonePageTitle => '把链接发送到 FlClash';

  @override
  String get sendFromPhonePageHint => '订阅链接或代理分享链接';

  @override
  String get send => '发送';

  @override
  String get sendFromPhonePageSent => '已发送，请在另一台设备上确认导入';

  @override
  String get sendFromPhoneConfirmTitle => '导入手机发来的链接？';

  @override
  String get shareQrcodeTip => '在另一台设备上用 FlClash 扫码即可导入此配置';

  @override
  String get qrcodeTooLongTip => '链接过长，无法生成二维码，请改用“复制链接”';

  @override
  String get invalidLinkTip => '不是有效的订阅链接或代理分享链接';

  @override
  String get batchLinkInputTip => '每行一个链接';

  @override
  String get link => '链接';

  @override
  String get allowedIps => '允许的 IP';

  @override
  String get cipher => '加密方式';

  @override
  String get clientFingerprint => '客户端指纹';

  @override
  String get requestHeaders => '请求头';

  @override
  String transportHeaders(Object transport) {
    return '$transport 请求头';
  }

  @override
  String get congestionControl => '拥塞控制';

  @override
  String get downloadBandwidth => '下行带宽';

  @override
  String get hopInterval => '跳跃间隔';

  @override
  String get obfs => '混淆';

  @override
  String get obfsHost => '混淆主机';

  @override
  String get obfsMode => '混淆模式';

  @override
  String get obfsParam => '混淆参数';

  @override
  String get obfsPassword => '混淆密码';

  @override
  String get plugin => '插件';

  @override
  String get pluginHost => '插件主机';

  @override
  String get pluginPath => '插件路径';

  @override
  String get pluginUsername => '插件用户名';

  @override
  String get pluginPassword => '插件密码';

  @override
  String get pluginCipher => '插件加密方式';

  @override
  String get pluginMode => '插件模式';

  @override
  String get portHopping => '端口跳跃';

  @override
  String get preSharedKey => '预共享密钥';

  @override
  String get privateKey => '私钥';

  @override
  String get privateKeyPassphrase => '私钥密码';

  @override
  String get protocolParam => '协议参数';

  @override
  String get protocolVersion => '协议版本';

  @override
  String get publicKey => '公钥';

  @override
  String get remoteDnsResolve => '远程 DNS 解析';

  @override
  String get secretKey => '密钥';

  @override
  String get skipCertVerify => '跳过证书验证';

  @override
  String get transport => '传输协议';

  @override
  String get udpRelayMode => 'UDP 中继模式';

  @override
  String get uploadBandwidth => '上行带宽';

  @override
  String get username => '用户名';

  @override
  String get networkName => '网络名称';

  @override
  String get networkSecret => '网络密码';

  @override
  String get peers => '初始节点';

  @override
  String get virtualIpv4 => '虚拟 IPv4';

  @override
  String get hostname => '主机名';

  @override
  String get exitNodes => '出口节点';

  @override
  String get ageSecretKey => 'age 私钥';

  @override
  String get ageSecretKeyRequiredTip => '该配置已用 age 加密，需要 age 私钥才能解密';

  @override
  String get ageDecryptFailedTip => '无法解密配置，请检查 age 私钥后重试';

  @override
  String get resetDns => '重置 DNS';

  @override
  String get resetDnsSuccess => 'DNS 状态已清理';

  @override
  String get resetDnsFailed => '无法重置 DNS，请确认内核已连接后重试';

  @override
  String resourceSizeLimitTip(Object limit) {
    return '资源大小超过 $limit';
  }

  @override
  String get ruleSetDetect => '自动识别格式和行为';

  @override
  String get ruleSetConvert => '转换为 MRS';

  @override
  String get ruleSetConvertRemote => '下载为本地 MRS';

  @override
  String get ruleSetEmptyTip => '规则集没有可用条目';

  @override
  String get ruleSetMixedTip => '规则集混合了裸域名和 IP 网段，请使用 classical 规则组合它们';

  @override
  String get ruleSetInvalidTip => '无法读取规则集，请检查格式和条目';

  @override
  String get ruleSetUnsupportedTip => '这些规则无法在保持原有行为的情况下转换为 MRS';

  @override
  String get ruleSetBusyTip => '其他规则集操作正在进行，请稍后重试';

  @override
  String get ruleSetNeedsConversionTip => '此远程规则集需要规范化，请下载为本地 MRS 后使用';

  @override
  String get ruleSetSizeTip => '规则集超出处理上限，请拆分后重试';

  @override
  String get providerLookupFailed => '无法读取当前生效的节点配置，请刷新资源后重试';

  @override
  String get lookupProxyConfig => '查找节点配置';

  @override
  String get tunDnsMode => '系统 DNS 模式';

  @override
  String get tunDnsModeDesc =>
      '留空保持原有行为；disabled 不设置系统 DNS；native 使用 TUN 地址；hijack 额外拦截其他网卡的 DNS（Windows 需 strict-route，Linux 需 auto-redirect）。macOS 上显式模式优先于自动设置系统 DNS';

  @override
  String get nodeShareLinkUnavailable => '此节点无法转换为分享链接，请使用字段或 YAML 编辑';

  @override
  String shareLinkNodesPreserved(int count) {
    return '$count 个节点无法转换为链接，将保留原配置';
  }

  @override
  String get select => '选中';

  @override
  String get preferred => '首选';

  @override
  String get addToLocalProxies => '添加到自定义节点';

  @override
  String addedToLocalProxies(Object name) {
    return '已将 $name 添加到自定义节点';
  }

  @override
  String alreadyInLocalProxies(Object name) {
    return '自定义节点中已有 $name';
  }

  @override
  String get generalOverrideDesc =>
      '添加的项会覆写所有配置的对应设置，未添加的项沿用配置自身的设置，配置未设置时使用内核默认值';

  @override
  String get groupBy => '分类';

  @override
  String get copyHost => '复制主机';

  @override
  String get copyDestination => '复制目标地址';

  @override
  String get closeConnection => '关闭连接';

  @override
  String get recentRequests => '最近请求';

  @override
  String get root => 'Root';

  @override
  String get mitm => 'MITM';

  @override
  String get httpsDecryption => 'HTTPS 解密';

  @override
  String get httpCapture => '抓包';

  @override
  String get httpCaptureDesc => '记录“主机名”中列出的主机的请求，在连接详情中查看。记录只保存在内存中';

  @override
  String get httpCaptureNoHosts =>
      '未列出任何主机，不会记录内容。请在 MITM 页的“主机名”中添加，或在连接详情中加入';

  @override
  String get httpCaptureLimit => '最多记录条数';

  @override
  String httpCaptureLimitDesc(Object memory, Object body) {
    return '达到此条数或占满 $memory 内存后，先丢弃最早的记录。每段内容只保留前 $body';
  }

  @override
  String get httpRequests => 'HTTP 请求';

  @override
  String get httpRequestsMissing => '抓包开启前发出或已被清除的请求不在列表中';

  @override
  String get httpRequestCleared => '这条请求的记录已清除';

  @override
  String get httpCaptureOff => '抓包未开启';

  @override
  String get inProgress => '进行中';

  @override
  String get method => '方法';

  @override
  String get originalUrl => '原 URL';

  @override
  String get timeToFirstByte => '首字节耗时';

  @override
  String get requestBody => '请求体';

  @override
  String get response => '响应';

  @override
  String get responseBody => '响应体';

  @override
  String get responseHeaders => '响应头';

  @override
  String get matchedRules => '命中的规则';

  @override
  String get overview => '概览';

  @override
  String get viewAll => '查看全部';

  @override
  String get copyAsBase64 => '复制为 Base64';

  @override
  String get copyAsCurl => '复制为 cURL';

  @override
  String get copyRequest => '复制请求';

  @override
  String get copyResponse => '复制响应';

  @override
  String get copyResponseBody => '复制响应体';

  @override
  String get httpBodyProtobufGuess => '按 Protobuf 解析，没有 .proto：只有字段编号，类型是推测的';

  @override
  String get exportHar => '导出 HAR';

  @override
  String get mitmAddRejectRule => '添加拒绝规则';

  @override
  String get mitmAddMapLocalRule => '添加本地映射规则';

  @override
  String get httpExportPrivateTitle => '包含隐私信息';

  @override
  String get httpExportPrivate => '请求里可能有 Cookie、令牌、密码和表单内容，分享前请确认内容和对象';

  @override
  String get mitmRuleCopiedForStash => '这个模块是 Stash 覆写，规则已复制，请手动添加';

  @override
  String get binaryData => '二进制数据';

  @override
  String get httpBodyNotKept => '内存紧张时未记录这段内容';

  @override
  String get httpBodyTruncated => '只记录了这段内容的开头部分';

  @override
  String httpBodyUndecoded(Object encoding) {
    return '无法解码 $encoding，显示的是传输时的原始数据';
  }

  @override
  String get mitmEnableTip =>
      '开启后，FlClash 能读取发往被解密主机的全部内容，包括 Cookie 和密码。请只为需要改写的主机开启';

  @override
  String get certificate => '证书';

  @override
  String get generateCertificate => '生成证书';

  @override
  String get regenerateCertificate => '重新生成证书';

  @override
  String get regenerateCertificateTip =>
      '新证书会替换当前证书，FlClash 会尽量把当前证书从本机信任的根证书中移除。信任当前证书的其他设备都需要安装新证书';

  @override
  String get exportCertificate => '导出证书';

  @override
  String get installCertificate => '安装到系统';

  @override
  String get installCertificateSuccess => '证书已安装';

  @override
  String validUntil(Object date) {
    return '有效期至 $date';
  }

  @override
  String get mitmCertificateExportTip => '导出后在要解密的设备上信任此证书';

  @override
  String get mitmTrustReady => '已信任';

  @override
  String get mitmTrustUntrusted => '未完全信任';

  @override
  String get mitmTrustNotInstalled => '未安装';

  @override
  String get mitmTrustChecking => '正在检查…';

  @override
  String get trustCertificate => '信任证书';

  @override
  String get mitmCertificateAndroidReadyTip => '只有信任用户证书的应用（多为浏览器）会被解密';

  @override
  String get mitmCertificateLinuxTip => 'Flatpak 版浏览器需要手动导入导出的证书';

  @override
  String mitmCertutilMissing(Object command) {
    return 'Chrome 和 Firefox 使用自己的证书库，需要 certutil：$command';
  }

  @override
  String mitmMissingStores(Object stores) {
    return '尚未加入：$stores';
  }

  @override
  String get mitmSystemStoreFailed => '无法把证书加入系统信任的根证书';

  @override
  String get mitmRootUntilReboot =>
      '未找到可保留证书的 Magisk、KernelSU 或 APatch，重启手机后需要重新安装';

  @override
  String get mitmRootPendingReboot => '证书将在重启手机后生效';

  @override
  String get mitmInstallSystemCaTip =>
      '检测到 root，证书将以 Magisk、KernelSU 或 APatch 模块“FlClash MITM CA”加入系统信任的根证书。之后本机所有应用都会信任它，持有其私钥的人可以解密本机的 HTTPS 流量。如需撤销，可重新生成证书，或在 root 管理器中移除该模块并重启。若拒绝 root 授权，将改为安装用户证书';

  @override
  String get mitmInstallUserCaTip =>
      '未检测到 root，证书只能安装为用户证书。只有信任用户证书的应用（多为浏览器）会被解密，其他应用访问列出的主机会失败，请不要列出它们的主机。Android 11 起需在系统设置中手动完成安装';

  @override
  String mitmCertificateSavedTip(Object fileName) {
    return '已将 $fileName 保存到“下载”。请在系统设置的“安全 › 加密与凭据 › 安装证书 › CA 证书”中安装';
  }

  @override
  String get openSettings => '打开设置';

  @override
  String mitmRemoveOldCertificateTip(Object name) {
    return '请在系统设置的“安全 › 加密与凭据 › 信任的凭据 › 用户”中移除旧证书 $name，再安装新证书';
  }

  @override
  String mitmOldCertificateLeftTip(Object name) {
    return '无法移除旧证书 $name，请自行从信任的根证书中移除';
  }

  @override
  String mitmOldSystemCertificateLeftTip(Object name) {
    return '旧证书 $name 仍在系统信任的证书中。请在 root 管理器中允许 FlClash 使用 root 后重新生成，或在其中移除“FlClash MITM CA”模块并重启';
  }

  @override
  String get mitmDecryptHost => '解密此主机';

  @override
  String mitmDecryptHostTip(Object host) {
    return '要把 $host 加入主机名列表吗？之后 FlClash 能读取发往它的内容，包括 Cookie 和密码';
  }

  @override
  String get mitmClientRefusedCertificate => '客户端拒绝了证书。请安装证书；如果应用固定了证书，请排除此主机';

  @override
  String get mitmExcludeHost => '排除解密';

  @override
  String mitmExcludeHostTip(Object host) {
    return '要把 -$host 加到主机名列表顶部吗？之后不再解密该主机';
  }

  @override
  String get urlRewrite => 'URL 重写';

  @override
  String get headerRewrite => 'Header 重写';

  @override
  String get bodyRewrite => 'Body 重写';

  @override
  String get mapLocal => '本地映射';

  @override
  String get mitmHostnameDesc => '以 - 开头表示排除，第一条匹配的生效';

  @override
  String get mitmModules => '模块';

  @override
  String get mitmModule => '模块';

  @override
  String get mitmModuleInvalid =>
      '这不是 Surge 模块、Loon 插件、Quantumult X 片段或 Stash 覆写';

  @override
  String get arguments => '参数';

  @override
  String get mitmRoutingRules => '分流规则';

  @override
  String get mitmIgnoredLines => '忽略的行';

  @override
  String get mitmModuleRulesDesc => '分流规则排在配置自身的规则之前';

  @override
  String mitmModuleSystemTip(Object system) {
    return '为 $system 编写，部分行可能不适用于本设备';
  }

  @override
  String mitmSkipSection(Object section) {
    return '不支持 [$section] 段';
  }

  @override
  String get mitmSkipSetting => '不支持此设置';

  @override
  String get mitmSkipScriptType => '不支持此类脚本';

  @override
  String get mitmSkipRule => '不支持此规则类型';

  @override
  String get mitmSkipPolicy => '只支持 DIRECT 和 REJECT 策略';

  @override
  String get mitmSkipJq => '不支持 jq 重写';

  @override
  String get mitmSkipJsonBody => '不支持 JSON 正文重写';

  @override
  String get mitmSkipRawHeader => '不支持把全部标头作为一段文本改写';

  @override
  String get mitmSkipConditional => '不支持条件重写';

  @override
  String get mitmSkipRelativeData => '此行引用的文件不是附件，请改用 URL 或添加为附件';

  @override
  String get mitmSkipNotDownloaded => '其文件尚未下载';

  @override
  String get mitmSkipUnreadable => '无法识别此行';

  @override
  String get mitmAddLocalFile => '添加本地文件';

  @override
  String get mitmNewModule => '新建模块';

  @override
  String get mitmAttachments => '附件';

  @override
  String get mitmAttachmentsDesc => '行内按文件名引用附件，如 script-path=a.js';

  @override
  String mitmFileTooLarge(Object size) {
    return '文件大于 $size MB';
  }

  @override
  String get mitmSkipDisabled => '已被参数关闭';

  @override
  String get mitmSkipEvent => '不支持此事件';

  @override
  String get mitmRunScript => '立即运行';

  @override
  String get mitmScriptNoOutput => '脚本已运行完毕，没有输出';

  @override
  String get mitmScriptRiskTitle => '运行此模块的脚本？';

  @override
  String get mitmScriptRisk =>
      '它的脚本能读取并修改所匹配主机的流量，包括 Cookie 和令牌，还能自行发送请求。只在信任其来源时开启';

  @override
  String get skipServerCertVerify => '跳过服务器证书验证';

  @override
  String get http2 => 'HTTP/2';

  @override
  String get decryptUntrusted => '本机未信任时也解密';

  @override
  String invalidOfCount(Object invalid, Object total) {
    return '$total 条中 $invalid 条无效';
  }

  @override
  String mitmModuleScriptsChanged(Object name) {
    return '$name 的脚本有变化，已关闭';
  }

  @override
  String failedCount(Object count) {
    return '$count 项失败，点击查看';
  }

  @override
  String get proxyServerNameserverDesc => '仅用于解析代理服务器的域名';

  @override
  String get proxyServerNameserverPolicyDesc =>
      '匹配的代理服务器域名改用此处指定的 DNS 服务器，优先于 Proxy Server Nameserver';

  @override
  String get directNameserverDesc => '用于解析直连连接的域名';

  @override
  String get fakeipFilterDesc =>
      '这些域名不使用 Fake-IP，返回真实 IP；过滤模式为 whitelist 时则只有它们使用 Fake-IP';

  @override
  String get fallbackFilterGeositeDesc => '属于这些 GeoSite 分类的域名直接使用 Fallback 解析';

  @override
  String get fallbackFilterIpcidrDesc =>
      'Nameserver 返回这些网段内的 IP 时，改用 Fallback 的结果';

  @override
  String get fallbackFilterDomainDesc => '这些域名直接使用 Fallback 解析';

  @override
  String get customResources => '自定义';

  @override
  String get proxyYieldsToSubscription => '订阅中有同名节点，此配置使用订阅节点';

  @override
  String get delayMeasurementUnknown => '测速时间未知';

  @override
  String delayMeasuredAt(String time) {
    return '上次测速：$time';
  }

  @override
  String get delayMeasurementStale => '结果已过期，请重新测速';

  @override
  String get diagUdp => 'UDP 连通性';

  @override
  String get diagUdpReady => 'UDP 往返测试成功';

  @override
  String get diagUdpUnknown => '未能确认 UDP 连通性';

  @override
  String get diagUdpUnsupported => '当前路径不支持 UDP';

  @override
  String get diagUdpHint => '测试遵循当前分流规则，超时可能由测试服务器或网络引起，不能据此认定所有 UDP 均被阻断';

  @override
  String get diagTimeline => '最近操作记录';

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
  String get diagStageFetch => '获取配置';

  @override
  String get diagStageValidate => '校验配置';

  @override
  String get diagStageApply => '应用配置';

  @override
  String get diagStageStart => '启动 VPN';

  @override
  String get diagStageStop => '停止 VPN';

  @override
  String get diagEventStarted => '开始';

  @override
  String get diagEventSucceeded => '成功';

  @override
  String get diagEventFailed => '失败';

  @override
  String get diagEventUnchanged => '内容未变化';

  @override
  String get diagEventCanceled => '已取消';

  @override
  String get diagRecorded => '记录';

  @override
  String mixedPortReset(Object value, Object port) {
    return '混合端口不能是 $value，已恢复为 $port';
  }

  @override
  String get coreStoppedDesc => '应用与内核的连接已断开';

  @override
  String coreStoppedWithReason(Object reason) {
    return '应用与内核的连接已断开：$reason';
  }
}

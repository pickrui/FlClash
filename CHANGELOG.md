# Changelog

## v0.9.1 (2026-10-22)

**Features**

- **providers** Preview effective node configuration with ownership guards (ca73068)
- **resources** Import provider links in bounded batches (3382e1e)
- **rules** Align added rule forms with grouped sheets (1b08b10)
- **rules** Add loopback presets and refresh quick actions (8018eea)
- **access** Align application filter settings with upstream (480bb18)
- **backup** Align WebDAV forms and connection checks with upstream (283d415)
- **ui** Align map entry forms and editor actions with upstream (bd05d7e)
- **import** Accept quoted and same-line batch links (8cac398)
- **ui** Align status notifications with upstream (967a51b)
- **resources** Detect rule sets and convert compatible rules to mrs (6dae577)
- **core** Expose full dns state reset (ef604e1)
- **l10n** Add french, spanish and korean translations (bf2ee1d)
- **ui** Finish resource, import and scanner migration (b22c33a)
- **profiles** Add structured protocol fields to the node editor (590dafa)
- **ui** Port editor, resource libraries and utility pages (7403a97)
- **profiles** Lay out the overwrite modes as upstream's extend pages (5151281)
- **profiles** Set provider options in upstream's grouped form (f06ab00)
- **profiles** Edit rules in upstream's list and grouped form (fe06b5c)
- **profiles** List the running profile's providers on its details page (e240ab9)
- **profiles** Edit proxy groups in upstream's grouped form (0085f98)
- **profiles** Give the custom profile upstream's overview and providers (2a0a00c)
- **profiles** Show profiles as upstream's cards with context menus (36debb4)
- **profiles** Lay out the profile details as a grouped form (d658d5e)
- **network** Set tcp keep-alive idle, disabling and the routing mark (9919e7c)
- **l10n** Take upstream's names for the settings rows (2b5b62a)
- **providers** Lay out the provider library as upstream does (2c7c8c5)
- **rules** Lay out the added rules page as upstream does (4f5a11c)
- **scripts** Lay out the script library as upstream does (e72aef7)
- **on-demand** Lay out the on-demand page as upstream does (1bd7725)
- **config** Lay out the general settings as upstream does (41523f1)
- **l10n** Word the DNS and NTP notes as section footers (18ac1a4)
- **network** Lay out the network settings as upstream does (ec5e34d)
- **config** Lay out the override pages as upstream does (e4afda4)
- **recovery** Restyle the configuration recovery screen (f5f2b24)
- **diagnostics** Restyle the network self-check and its proxy guide (c85e773)
- **tailscale** Restyle the network list, network page and guide (7a92997)
- **cloud** Restyle the node filter editor (72e5176)
- **cloud** Restyle the store, its sheets and its alerts (234b0c5)
- **cloud** Sign in, register and reset passwords in form sheets (f244a77)
- **cloud** Lay out the oixcloud account page as upstream's grouped page (3a4b5d3)
- **window** Open a first window at four dashboard columns (86fd4e2)
- **dashboard** Redesign the dashboard around the current exit (b2d5731)
- **proxies** Open provider actions from a context menu (a72e0b7)
- **proxies** Let the proxies page open as a picker (c8307e2)
- **proxies** Lay the tab style out like upstream's (45b4de3)
- **proxies** Show groups as cards (9526dfc)
- **proxies** Set proxy cards in the iOS type scale (7399fd7)
- **proxies** Name card sizes and icon styles after upstream (5a6ec46)
- **core** Bind the android core with gomobile (1ce45a2)
- **ui** Hide a row's separators when a key moves focus to it (91c0af0)
- **profiles** Sort profiles by their handles (4bead53)
- **ui** Give sortable rows upstream's handles in sort mode (b690ab2)
- **ui** Move floating actions into the toolbar (de32610)
- **ui** Move the scaffold into lib/ui with upstream's toolbar (f7098d0)
- **network** Select excluded SSIDs from the section header (36b95bf)
- **ui** Ring a card only on remote or key-moved focus (71260a3)
- **android** Report a floating tv keyboard to the remote focus layer (4f07bfe)
- **ui** Port upstream's remote focus library with keyboard and traversal parts (b168d0c)
- **ui** Show the app's dialogs as iOS alerts (ebf4273)
- **theme** Pick the app font from the installed families (e547c94)
- **form** Port the selection sheet with removable picks (94a9e8b)
- **ui** Open forms as form sheets (9b977ab)
- **ui** Present bottom sheets on ios detents and stack them (442f17c)
- **ui** Add a view scope for the window size and layout (c4b6266)
- **widgets** Open option rows as an iOS pop-up menu (47014e6)
- **profiles** Add share links to a custom profile as nodes (6bd3d36)
- **profiles** Import a config into a custom profile (5dc82bb)
- **profiles** Set options for library proxy providers in custom profiles (d8096b4)
- **profiles** Edit a custom profile's dns, ntp, sniffer and tun keys (fb916cd)
- **profiles** Keep dns, ntp, sniffer and tun keys per custom profile (58c0c70)
- **theme** Fall back to Han fonts that match the UI language (ea3ef68)
- **theme** Redesign the theme page with an iOS-style color picker (b7a0555)
- **ui** Add the Liquid Glass engine behind a theme setting (f8c0831)
- **theme** Start new installs in iOS blue following the system theme (7fd76a2)
- **theme** Replace scheme variants with four color styles (8b1bea1)
- **profiles** Offer profiles as providers in the custom profile editor (d001f3c)
- **profiles** Keep provider references to profiles intact (bc7e0e7)
- **profiles** Use other profiles as proxy providers in custom profiles (36ea766)
- **profiles** Add a custom profile editor (3c575f6)
- **profiles** Assemble custom profiles from an empty config (6635669)
- **database** Store the profile type and per-profile overrides (0cfc37d)
- **ui** Put pages, sheets and floats on surface levels (f8d9e65)
- **ui** Draw cards, tonal buttons and window chrome with surface levels (08f7b91)
- **ui** Theme every page with the iOS type scale and surface levels (6723850)
- **config** Build the dns and ntp pages on the shared override rows (ef03fb5)
- **android** Set the vpn congestion controller and excluded routes (36ee9d6)
- **network** Pick desktop tun keys in the network settings (f76b5d9)
- **android** Pass the tun congestion controller to the mips stack (da1b8a4)
- **tun** Let desktop tun keys follow the profile unless picked (8632a47)
- **config** Keep picked desktop tun keys apart from the app tun (d8f5bae)
- **core** Take the tun congestion-controller option (7808ee9)
- **network** Replace the route mode with a bypass private route switch (a5c9b47)
- **config** Let optional dns and ntp text fields be cleared (2ea6fc1)
- **config** Apply picked dns and ntp keys without override switches (77cc268)
- **proxies** Show the group tabs as chips (89dbc67)
- **views** Show connections, requests and DNS as sortable tables (5c4b197)
- **widgets** Add a sortable record table frame (6691cec)
- **ui** Add a table layout engine with resizable columns (65aacaa)
- **requests** Report the live traffic of open requests (741d78c)
- **ui** Bring shapes to upstream parity with superellipse corners (98e64c3)
- **sheet** Size side sheets to the window (b5a1f54)
- **profiles** Import share-link lists as subscriptions (1f3ff03)
- **overwrite** Check proxy-group filters as they are typed (e44fe81)
- **core** Report dialer-proxy loops to the user (11733ca)
- **android** Reset core connections when the default network changes (ebaacf8)
- **android** Follow xiaomi's battery saver for the exemption status (bbe1fbe)
- **android** Ask for background location right after the foreground grant (dcc2b14)
- **android** Add start and stop launcher shortcuts (2ecc1b8)

**Bug Fixes**

- **lifecycle** Fix shutdown races, stale WebDAV checks and script time limits, and coalesce address-cache writes (5a47937)
- **profiles** Preserve long node names in structured edits (8d853d3)
- **core** Preserve ipc framing across desktop write stalls (a22e5e8)
- **profiles** Localize batch update network errors (cacf934)
- **profiles** Reject blank names and trim saved labels (b63dc80)
- **import** Bound unique labels and preserve unicode filenames (641545e)
- **editor** Complete proxy provider insertion positions (f9c68d9)
- **ui** Measure record columns with the local text scale (73b24a8)
- **ui** Keep time labels on their current refresh interval (dfe9b5a)
- **storage** Prune orphan provider caches with live reference guards (4a3f0e3)
- **import** Show bounded line errors for batch links (a6f91ad)
- **editor** Preserve back results and confirm bulk deletion (5977879)
- **desktop** Bound window close with the exit watchdog (c8b576f)
- **network** Bound and validate outbound ip queries (ccd2a71)
- **android** Track acknowledged vpn options across service reconnects (2f39b1f)
- **macos** Prevent dns updates after shutdown begins (dfa5e87)
- **common** Align search and collection helpers with upstream (5aa0b63)
- **ui** Retain bounded history while browsing logs and requests (92cb6bc)
- **ui** Display record timestamps in local time (2991d7d)
- **linux** Refresh verified appimage runtime digests (389da30)
- **core** Synchronize desktop ipc connection access (8577653)
- **windows** Omit arm64ec runtime from native arm64 packages (0e6de8d)
- **windows** Refresh installer messages and architecture identifiers (43bc594)
- **linux** Contain connectivity listener startup failures (a17db93)
- **linux** Adopt upstream appimage launch handling (27c7b9a)
- **backup** Clean failed archive attempts (825fb79)
- **android** Invalidate runtime state without a flutter engine (4e0e74d)
- **resources** Preserve size limits through bounded reads (79c972f)
- **android** Discard runtime queries after service loss (a9af0b9)
- **resources** Localize update failures and size limits (31dc000)
- **linux** Validate bundles and complete packaged url entrypoints (1a586ba)
- **android** Package only the requested native abi (3522a93)
- **ui** Complete upstream import and resource behavior (501963c)
- **l10n** List the required string once (9291fec)
- **profiles** Keep the members a custom profile's selectors list (8ede73d)
- **profiles** Add library rule sets that only dns or the sniffer match (869d520)
- **profiles** Check the provider options being edited (e9726ba)
- **tun** Keep tailnet peers and subnets routed while bypassing private ranges (86654fb)
- **ui** Keep hand-drawn cards and page bands on the surface levels (21c81f6)
- **tun** Keep live updates off the profile's tun keys (7c16770)
- **ui** Round the column resizer and group chips with superellipses (93d7d99)
- **dns** Keep the profile nameservers when a picked list is emptied (b47ab73)
- **database** Skip rows this version cannot read instead of failing (de0d237)
- **settings** Keep readable settings when some values cannot be read (72bc0b0)
- **proxies** Keep groups and search matches when hiding timeouts (7492be2)
- **proxies** Hide only the built-in GLOBAL group in rule mode (10dcf49)
- **android** Apply system dns updates in the order they arrive (af95225)
- **core** Spill large core replies into sealed files (83f172c)
- **android** Post the service notification again after unlock (ab8be56)
- **android** Move the vpn tun address to 198.18.0.1/30 (333792e)
- **tray** Ignore tray updates once exit has removed the icon (b1146ef)
- **helper** Close the connection after rejecting a request (57ccb38)
- **ui** Lift every reorderable row with commonProxyDecorator (c0b5a95)
- **ui** Read the bottom inset below the scaffold that adds to it (16351b8)
- **ui** Stop non-secret fields from opening a password keyboard (d979ac6)
- **profiles** Name an exported profile as a yaml file (4081757)
- **proxy** Keep the system proxy off once exit has stopped it (acdd77f)
- **tray** Keep the macos status item at exit and show suspension (cc8dadd)
- **proxy** Drop trailing slashes and bypass intranet hosts on windows (5d167bc)
- **core** Backport upstream mihomo fixes from october (c884406)
- **linux** Match the window to its launcher with StartupWMClass (086efb0)
- **window** Restore positions across mixed-dpi monitors on windows (106aec7)
- **cloud** Align node filter editing and subscription parameters (29faca8)
- **subscription** Bound protected direct updates and label fallback (e04fa57)

**Performance**

- **dns** Reuse query filters across unchanged view builds (1f4dd5a)
- **connections** Decode large snapshots outside the ui isolate (2dfb623)
- **android** Compute vpn routes asynchronously with startup guards (7a03a5e)
- **search** Cache record filters and include connection details (da5c180)
- **platform** Reduce socket lookup and idle wifi callback overhead (d105827)
- **ui** Hand the nested sheet's provider a stable close callback (472d6f3)
- **editor** Build large documents off the UI isolate (11a8c38)
- **ipc** Serve the desktop core from an event-driven tokio server (cdb6046)
- **views** Estimate long lists exactly and narrow proxy rebuilds (4deaefd)
- **ui** Grow the open container by painting alone (4068b3f)
- **ui** Fade pages by painting the surface and defer push starts (1b58d42)
- **scaffold** Keep body relayouts and repaints inside the body (4a13e4f)
- **theme** Keep keyboard frames from rebuilding the theme manager (18e65af)
- **theme** Switch themes in one frame and cross-fade the last one (3a9f07b)
- **android** Keep core calls and events off the main thread (566b05d)
- **core** Release load memory once provider loads go quiet (487b4e9)
- **core** Skip the short-id rewrite for configs without one (67695cb)
- **android** Load at most eight package icons at a time (355bd48)
- **core** Encode desktop requests straight to utf-8 bytes (a42fdcc)

<!-- changelog:frozen -->
<!-- Entries below predate the structured pipeline. Their wording is kept as written; only the heading and list style were normalized. -->

## v0.8.99

性能与资源：节点列表按页读取，连接列表增量更新，减少大订阅和连接较多时的内存分配与界面刷新；合并重复测速并限制自动探测负载，按需创建协议及 DNS 资源，收紧日志、缓存和规则数据占用；修复分页刷新时的缓存超额、版本混用和失败后无法重试

界面与编辑：整理导航、仪表盘和设置，适配不同窗口宽度；完善规则、策略组、节点及资源库的批量编辑、校验和失败重试；保存或导入期间阻止冲突操作，失败、取消及连续返回时保留草稿，避免异步结果误关其他页面；修复 Android 导航栏遮挡 MATCH 选项

配置与脚本：复用脚本选项提取结果，支持手动刷新并保留未保存选项，预览按新增、修改和删除分类；已有脚本缺失时明确报错，应用失败后可重试；恢复的脚本需手动启用；UA 统一使用客户端默认值，移除自定义入口；订阅缺少 DNS 时使用最小兜底，保留显式参数且不额外开放监听端口

Tailscale 与路由：新增网络管理，支持浏览器、二维码、认证密钥及 Headscale 登录，提供设备列表、连接状态和出口节点选择；支持 MagicDNS 与已批准子网，自定义规则优先，重叠局域网默认保留本地路由；规则和策略组可选择 Tailscale 网络，设置出口节点后才自动加入订阅策略组；保护仍被使用的网络，认证密钥单独安全存储

备份与更新：WebDAV 支持按设备保留和恢复历史备份，统一时间排序，上传失败保留已有记录；Windows 安装版、已签名 macOS 版本和 Linux AppImage 支持校验后原地升级并重新打开，保留配置与偏好，无法自动安装时提供手动或浏览器下载入口

协议与规则：修复 OpenVPN peer-id 与 tls-auth 兼容性，恢复 Hysteria v1 UDP 转发，改善 TrustTunnel 失败反馈；修复通配符规则重叠，优化大型规则集与高延迟线路性能；订阅转换保留 REALITY ML-KEM 和 XHTTP 请求头，修正 XHTTP IPv6 节点；桌面端 qBittorrent、aria2c 等下载客户端强制直连，网页连接仅在下载客户端运行时才识别进程；仅当规则含进程类规则时按需查找进程，普通规则不再开启

网络与账户：新增已有账号的 Google 登录，保留邮箱密码与 Access Token 登录；新增 Windows、macOS 代理及 VPN 冲突检查和可用端口建议；网络自检提供分平台的代理排查和手动设置引导，可复制当前本地代理地址，直达端口、DNS 与虚拟网卡设置并返回复检；加固订阅跳转检查，避免跨站点携带认证信息；内置根证书包，旧版 Android 等缺少新根证书的系统不再因此连接或下载失败；完善证书异常的临时授权与重试，修复首次配置下载失败被误报为成功；改善公告、付款状态、链接错误和窄屏显示

稳定性与兼容：及时释放旧连接、DNS 查询和 Tailscale 会话，复用未变更资源，修复网络切换及退出后的过期回调；修复 macOS 启动时隐藏窗口的重入问题；合并 Android 并发启动，修复启动中关闭后的状态残留；仅主动开启“空闲时暂停代理”才暂停连接与健康检查，入口位于“常规 → 启动与后台”；修复 Linux AppImage 输入正确管理员密码后仍无法开启虚拟网卡、修改混合端口失败仍提示成功、内核断开重连后未重新加载配置，以及脚本日志越过执行时限；整理依赖、停用代码和重复读取

## v0.8.98

节点筛选：oixCloud 可按线路、地区和名称保留或排除节点，支持预览，未设置时使用智能优选；筛选保存在账户上，对使用此客户端的所有设备生效，保存后自动更新订阅；移除原「可选项参数」；此前与 iOS 客户端共用登录令牌的设备会自动换用 FlClash 自己的令牌，两端筛选不再互相影响

商店与账户：整理购买、续费和升级入口，购买默认开启自动续费并优先使用余额；余额不足时可直接充值，升级或绑定优惠码时可充值后重新报价；改善注册、金额提示、窄屏显示和读屏操作；商店的流量、周期和标签随界面语言显示

性能与内存：新增低内存 mips TUN 协议栈，可在网络设置或首页快捷选项中选择，并提示内存与吞吐的取舍；减少桌面端与内核通信的等待

连接与测速：连续测速不再中断已有任务或清空结果，共用设置中的并发上限；修正测速失败原因和过期结果覆盖，改善节点选择、策略组刷新与连接列表更新

配置与规则：订阅及资源更新保留本地编辑，修复旧请求覆盖配置、缓存清理误删文件和异常订阅更新失败；改善 YAML 导入、规则排序、自定义节点及代理链校验，保留外部控制器设置

应用更新：自动检查仅显示简洁提示，详情页展示完整版本和对应日志，确认后才下载；支持后台下载、取消、失败重试和日志重新加载

界面与稳定性：修复内核启动失败后无法恢复、重启后日志中断和窗口失焦后数据停止刷新，以及 Windows、Linux 窗口被端口探测意外唤起；改善语言、主题、仪表盘、快捷键、备份及弹窗交互，提升退出和断连时的稳定性

安全与网络：加固桌面 Helper 本地接口，修正系统代理绕过范围，改善部分线路的连接兼容性；细分证书和网络错误提示，API 证书异常时可确认风险后仅为本次操作临时跳过校验，并保留警告

Android：批量测速默认并发调整为 16，可在设置中修改；修复 VPN 权限撤销后的状态清理、后台 Wi-Fi 排除策略和扫码相机重复启动，改善应用访问控制搜索

Linux：新增 Arch 安装包及 PKGBUILD，包管理器安装的版本不再提示应用内更新；修复 AppImage 对 fuse2 的依赖，以及托盘、系统代理、Helper 和升级残留问题

Windows 与 macOS：完善 Windows 系统策略拦截提示、重复启动和代理命令复制，修复 macOS 停用网络服务后系统代理无法开关

## v0.8.97

商店与账户：购买 7 天内可补绑系统折扣代码，按套餐剩余时长退还或补收差价，循环折扣同步更新续费价格；提前续费、升级和更换套餐改为先报价再提交，确认时展示本次应付和后续续费价，并支持折扣代码

网络与诊断：新增 Wi-Fi SSID 排除策略，可在指定网络暂停代理；Windows 和 macOS 新增网络自检，检查系统代理、虚拟网卡、DNS 与联网路径，支持复制报告和全部测速失败时的排查提示

请求与错误提示：API 检测、登录和配置获取显示具体失败原因，区分设备时间、客户端签名和服务端配置问题；完善 DNS 错误提示，系统解析失败时尝试最近成功连接的地址；修复请求取消后仍继续握手的问题

连接与测速：提高批量测速并发并即时显示结果，限制失败节点复测总耗时，保留单节点弱网重试；修复取消测速影响节点健康状态、连接成功后 DNS 缓存未续期的问题

应用更新：自动发现新版本时提示并后台下载，完成后提示安装；手动更新可转入后台查看进度，启动时清理遗留安装包，并修复取消下载后临时文件残留的问题

性能与内存：降低图标解码和缓存占用，及时回收 Android 配置加载后的空闲内存，减少 MKCP 接收缓存和 Mekya 弱网请求积压

界面与平台：更新 Material 界面、配置与图标管理，适配小屏、大字体和 TV 焦点操作；改善托盘、快捷键和窗口交互，修复更新检查打断 Windows 静默启动、Android 小部件启停时窗口闪烁的问题

配置与恢复：改善配置迁移、覆写规则及配置更新的并发保护，保留系统代理恢复和 Windows 配置加密恢复能力

核心与兼容性：更新代理核心、原生构建链、Flutter、Go 1.26.8、Rust 及相关依赖，macOS 最低支持版本调整为 12.0；改善桌面连接，以及 Mekya、AnyTLS 和 Sudoku 的连接稳定性

Linux：新增 Helper 安装、卸载和升级迁移，兼容非 systemd 启动方式；按实际安装方式提供 deb、rpm 或 AppImage 更新，无法判断时由用户选择并记住，AppImage 提示手动替换

## v0.8.96

配置与规则：新增自定义规则和策略组，支持目标选择、成员筛选、独立草稿和应用前校验；自定义配置可一键清空，无效内容保留当前配置；修复覆写后代理标签页消失、同名节点与策略组冲突，以及覆写规则优先级问题

订阅与同步：改善订阅更新和账户同步，避免长时间等待及更新失败覆盖已有配置；托管配置支持自动更新开关和间隔设置，修复变更未及时生效的问题

备份与恢复：Windows 支持加密备份后重置配置及中断后继续处理；修复安全存储并发读写和恢复异常，避免密钥暂时不可用时清除原有数据

应用更新：优先使用内建下载，支持查看进度和取消，失败时可转到浏览器

Geo 资源：默认每 24 小时静默更新，更新后无需重启内核；手动下载失败时可切换下载源

网络与测速：改善批量测速，修复节点切换阻塞、网络检测持续转圈及 IP 和国旗不刷新的问题；自动 IPv6 默认关闭，启用后保留手动设置并随网络变化重新检测

性能与界面：减少连接事件和批处理缓存的内存滞留，降低后台资源占用，改善连接列表滚动和桌面连接稳定性；完善小屏、大字体和多语言显示

Android：新增默认关闭的「空闲时暂停代理」省电选项，修复快捷开关状态不一致和安装包混入其他架构文件的问题

## v0.8.95

网络与配置：修复 DNS 设置未及时生效、恢复设置后代理仍超时，以及 Windows 管理员模式下配置加载失败的问题

备份与启动：修复 Android 无法恢复 WebDAV 备份和 Docker 启动崩溃的问题

多语言：补齐日语和俄语翻译

## v0.8.94

更新与启动：更新弹窗仅显示当前版本日志；修复 Windows 开机静默启动和桌面端重复运行，改善升级时的数据保留和启动体验

配置与恢复：修复 Android 旧备份恢复异常，以及登录后新托管配置导致代理启动失败的问题

连接与测速：修复批量测速遗漏、结果错乱和节点切换异常

macOS：修复应用订阅覆写脚本时崩溃的问题

Docker：降低资源占用，修复重建后自动启动、账户解锁和其他容器访问代理的问题

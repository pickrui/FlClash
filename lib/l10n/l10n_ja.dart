// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get applyNow => '今すぐ適用';

  @override
  String get rule => 'ルール';

  @override
  String get global => 'グローバル';

  @override
  String get direct => 'ダイレクト';

  @override
  String get dashboard => 'ダッシュボード';

  @override
  String get proxies => 'プロキシ';

  @override
  String get profile => 'プロファイル';

  @override
  String get profiles => 'プロファイル一覧';

  @override
  String get tools => 'ツール';

  @override
  String get logs => 'ログ';

  @override
  String get logsDesc => 'ログキャプチャ記録';

  @override
  String get resources => 'リソース';

  @override
  String get resourcesDesc => '外部リソース関連情報';

  @override
  String get trafficUsage => 'トラフィック使用量';

  @override
  String get networkSpeed => 'ネットワーク速度';

  @override
  String get outboundMode => 'アウトバウンドモード';

  @override
  String get networkDetection => 'ネットワーク検出';

  @override
  String get upload => 'アップロード';

  @override
  String get download => 'ダウンロード';

  @override
  String get noProxy => 'プロキシなし';

  @override
  String get nullProfileDesc => 'プロファイルがありません。追加してください';

  @override
  String get settings => '設定';

  @override
  String get language => '言語';

  @override
  String get defaultText => 'デフォルト';

  @override
  String get more => 'その他';

  @override
  String get other => 'その他';

  @override
  String get about => 'について';

  @override
  String get en => '英語';

  @override
  String get ja => '日本語';

  @override
  String get ru => 'ロシア語';

  @override
  String get fr => 'フランス語';

  @override
  String get es => 'スペイン語';

  @override
  String get ko => '韓国語';

  @override
  String get zh_CN => '簡体字中国語';

  @override
  String get theme => 'テーマ';

  @override
  String get themeDesc => 'ダークモードの設定、色の調整';

  @override
  String get overrideLabel => '上書き';

  @override
  String get allowLan => 'LANプロキシ';

  @override
  String get tun => 'TUN';

  @override
  String get tunDesc => 'TUN は管理者モードでのみ有効です';

  @override
  String get minimizeOnExit => '終了時に最小化';

  @override
  String get autoLaunch => '自動起動';

  @override
  String get silentLaunch => 'サイレント起動';

  @override
  String get silentLaunchDesc => 'バックグラウンドで起動';

  @override
  String get autoRun => '自動実行';

  @override
  String get autoRunDesc => 'アプリ起動時に自動実行';

  @override
  String get logcat => 'ログキャプチャ';

  @override
  String get logcatDesc => '無効化するとログエントリを非表示';

  @override
  String get accessControl => 'アクセス制御';

  @override
  String get accessControlDesc => 'アプリケーションのプロキシアクセスを設定';

  @override
  String get application => 'アプリケーション';

  @override
  String get edit => '編集';

  @override
  String get confirm => '確認';

  @override
  String get update => '更新';

  @override
  String get add => '追加';

  @override
  String get save => '保存';

  @override
  String get delete => '削除';

  @override
  String get hours => '時間';

  @override
  String get seconds => '秒';

  @override
  String get qrcode => 'QRコード';

  @override
  String get qrcodeDesc => 'QRコードをスキャンしてプロファイルを取得';

  @override
  String get url => 'URL';

  @override
  String get file => 'ファイル';

  @override
  String get name => '名前';

  @override
  String get profileNameNullValidationDesc => 'プロファイル名を入力してください';

  @override
  String get profileUrlNullValidationDesc => 'プロファイルURLを入力してください';

  @override
  String get profileUrlInvalidValidationDesc => '有効なプロファイルURLを入力してください';

  @override
  String get autoUpdate => '自動更新';

  @override
  String get autoUpdateInterval => '自動更新間隔';

  @override
  String get profileAutoUpdateIntervalNullValidationDesc => '自動更新間隔を入力してください';

  @override
  String get profileAutoUpdateIntervalInvalidValidationDesc =>
      '有効な間隔形式を入力してください';

  @override
  String get themeMode => 'テーマモード';

  @override
  String get themeColor => 'テーマカラー';

  @override
  String get preview => 'プレビュー';

  @override
  String get auto => '自動';

  @override
  String get light => 'ライト';

  @override
  String get dark => 'ダーク';

  @override
  String get submit => '送信';

  @override
  String createProfileFromUrlTip(Object url) {
    return '$url からプロファイルを作成しますか？';
  }

  @override
  String get create => '作成';

  @override
  String get pleaseUploadValidQrcode => '有効なQRコードをアップロードしてください';

  @override
  String get blacklistMode => 'ブラックリストモード';

  @override
  String get whitelistMode => 'ホワイトリストモード';

  @override
  String get selectAll => 'すべて選択';

  @override
  String get cancelSelectAll => '全選択解除';

  @override
  String get appAccessControl => 'アプリアクセス制御';

  @override
  String get accessControlAllowDesc => '選択したアプリのみVPNを経由します';

  @override
  String get accessControlNotAllowDesc => '選択したアプリはVPNから除外されます';

  @override
  String get accessControlDisabledDesc => 'アプリアクセス制御は無効です';

  @override
  String accessControlSelectedCount(num count) {
    return '$count 件選択済み';
  }

  @override
  String get profileParseErrorDesc => 'プロファイル解析エラー';

  @override
  String get proxyPort => 'プロキシポート';

  @override
  String get port => 'ポート';

  @override
  String get logLevel => 'ログレベル';

  @override
  String get show => '表示';

  @override
  String get hide => '非表示';

  @override
  String get exit => '終了';

  @override
  String get systemProxy => 'システムプロキシ';

  @override
  String get custom => 'カスタム';

  @override
  String get project => 'プロジェクト';

  @override
  String get core => 'コア';

  @override
  String get reverseEngineeringNotice =>
      '本アプリのリバースエンジニアリング、逆コンパイル、逆アセンブル、および AI を用いた解析を嚴禁します';

  @override
  String get tabAnimation => 'タブアニメーション';

  @override
  String get desc =>
      'ClashMetaベースのマルチプラットフォームプロキシクライアント。シンプルで使いやすく、オープンソースで広告なし';

  @override
  String get startVpn => 'VPNを開始中...';

  @override
  String get stopVpn => 'VPNを停止中...';

  @override
  String get discovery => '新しいバージョンを発見';

  @override
  String get compatible => '互換モード';

  @override
  String get notSelectedTip => '現在のプロキシグループは選択できません';

  @override
  String get tip => 'ヒント';

  @override
  String get account => 'アカウント';

  @override
  String get backup => 'バックアップ';

  @override
  String get backupSuccess => 'バックアップ成功';

  @override
  String get noInfo => '情報なし';

  @override
  String get pleaseBindWebDAV => 'WebDAVをバインドしてください';

  @override
  String get bind => 'バインド';

  @override
  String get connectivity => '接続性：';

  @override
  String get webDAVConfiguration => 'WebDAV設定';

  @override
  String get address => 'アドレス';

  @override
  String get addressHelp => 'WebDAVサーバーアドレス';

  @override
  String get addressTip => '有効なWebDAVアドレスを入力';

  @override
  String get password => 'パスワード';

  @override
  String get checkUpdate => '更新を確認';

  @override
  String get checkUpdateError => 'アプリは最新版です';

  @override
  String get checkUpdateFailed => '更新の確認に失敗しました。ネットワークを確認して再試行してください';

  @override
  String get unknown => '不明';

  @override
  String get search => '検索';

  @override
  String get allowBypass => 'アプリによるVPNバイパスを許可';

  @override
  String get externalController => '外部コントローラー';

  @override
  String get externalControllerDesc => '外部コントローラーを有効にすると、設定したアドレスでコアを制御できます';

  @override
  String get openDashboard => 'ダッシュボードを開く';

  @override
  String get ipv6Desc => 'IPv6 トラフィックは IPv6 が有効なときだけ受信します';

  @override
  String get autoIpv6 => '自動 IPv6';

  @override
  String get autoIpv6Desc => '自動 IPv6 は、ローカルネットワークの IPv6 対応に応じて自動で切り替えます';

  @override
  String get app => 'アプリ';

  @override
  String get unifiedDelay => '統一遅延';

  @override
  String get tcpConcurrent => 'TCP同時接続';

  @override
  String get geodataLoader => 'Geo低メモリモード';

  @override
  String get requests => 'リクエスト';

  @override
  String get requestsDesc => '最近のリクエストと接続中の通信を表示';

  @override
  String get findProcessMode => 'プロセス検出';

  @override
  String get init => '初期化';

  @override
  String get infiniteTime => '長期有効';

  @override
  String get connections => '接続';

  @override
  String get intranetIP => 'イントラネットIP';

  @override
  String get view => '表示';

  @override
  String get cut => '切り取り';

  @override
  String get copy => 'コピー';

  @override
  String get paste => '貼り付け';

  @override
  String get userAgent => 'User-Agent';

  @override
  String get testUrl => 'テストURL';

  @override
  String get delayTestTimeout => '遅延テストのタイムアウト';

  @override
  String get sync => '同期';

  @override
  String get exclude => '最近のタスクから隠す';

  @override
  String get compact => 'コンパクト';

  @override
  String get filter => 'フィルター';

  @override
  String get tab => 'タブ';

  @override
  String get list => 'リスト';

  @override
  String get delay => '遅延';

  @override
  String get style => 'スタイル';

  @override
  String get size => 'サイズ';

  @override
  String get sort => '並び替え';

  @override
  String get columns => '列';

  @override
  String get proxyGroup => 'プロキシグループ';

  @override
  String get go => '移動';

  @override
  String get externalLink => '外部リンク';

  @override
  String get autoCloseConnections => '接続を自動的に閉じる';

  @override
  String get autoCloseConnectionsDesc =>
      'ノード切り替え後、すべての接続、または変更したプロキシグループを経由する接続のみを閉じます（入れ子のグループを含む）';

  @override
  String get connectionCloseScope => '接続を閉じる範囲';

  @override
  String get closeCurrentGroupConnections => '現在のプロキシグループのみ';

  @override
  String get onlyStatisticsProxy => 'プロキシトラフィックのみ集計';

  @override
  String get pureBlackMode => '純黒モード';

  @override
  String get keepAliveIntervalDesc => 'TCPキープアライブ間隔';

  @override
  String get entries => ' エントリ';

  @override
  String secondsCount(Object count) {
    return '$count 秒';
  }

  @override
  String itemsCount(num count) {
    return '$count 件';
  }

  @override
  String get geoAutoUpdate => '自動更新';

  @override
  String get geoAutoUpdateInterval => '自動更新間隔';

  @override
  String get geoAutoUpdateIntervalTip => '自動更新間隔は1〜8760時間で入力してください';

  @override
  String get geoResources => 'Geoリソース';

  @override
  String geoUpdating(Object name) {
    return '$nameを更新中...';
  }

  @override
  String geoSkipped(Object name) {
    return '$name スキップ済み';
  }

  @override
  String geoUpdated(Object name) {
    return '$name 更新済み';
  }

  @override
  String get local => 'ローカル';

  @override
  String get remote => 'リモート';

  @override
  String get remoteBackupDesc => 'WebDAVにデータをバックアップ';

  @override
  String get localBackupDesc => 'ローカルにデータをバックアップ';

  @override
  String get mode => 'モード';

  @override
  String get time => '時間';

  @override
  String get source => 'ソース';

  @override
  String get action => 'アクション';

  @override
  String get intelligentSelected => 'インテリジェント選択';

  @override
  String get clipboardNoPackageNames => 'クリップボードに有効なパッケージ名がありません';

  @override
  String get clipboardImport => 'クリップボードからインポート';

  @override
  String get clipboardExport => 'クリップボードへエクスポート';

  @override
  String get layout => 'レイアウト';

  @override
  String get tight => 'コンパクト';

  @override
  String get standard => '標準';

  @override
  String get loose => 'ゆったり';

  @override
  String get profilesSort => 'プロファイルの並び替え';

  @override
  String get start => '開始';

  @override
  String get stop => '停止';

  @override
  String get key => 'キー';

  @override
  String get value => '値';

  @override
  String get vpnTip => '変更はVPN再起動後に有効';

  @override
  String get vpnEnableDesc => 'VPN は VpnService でシステムの全トラフィックを自動的にルーティングします';

  @override
  String get options => 'オプション';

  @override
  String get loopback => 'UWP ループバック解除';

  @override
  String get providers => 'プロバイダー';

  @override
  String get proxyProviders => 'プロキシプロバイダー';

  @override
  String get ruleProviders => 'ルールプロバイダー';

  @override
  String get status => 'ステータス';

  @override
  String get statusDesc => 'DNS を無効にすると、システム DNS を使用します';

  @override
  String get preferH3Desc => 'HTTP/3 を優先すると、DoH サーバーで HTTP/3 を優先して使用します';

  @override
  String get respectRules => 'ルールに従う';

  @override
  String get respectRulesDesc =>
      'ルールに従うを有効にすると DNS 接続がルールに従います。プロキシネームサーバーの設定が必要です';

  @override
  String get dnsMode => 'DNSモード';

  @override
  String get fakeipRange => 'Fake-IP範囲';

  @override
  String get fakeipFilter => 'Fake-IPフィルター';

  @override
  String get defaultNameserver => 'デフォルトネームサーバー';

  @override
  String get defaultNameserverDesc =>
      'ほかの DNS サーバーのドメイン名を解決します。IP アドレスのみ指定できます。';

  @override
  String get nameserver => 'ネームサーバー';

  @override
  String get nameserverDesc =>
      '既定で使う DNS サーバーです。例：223.5.5.5、tls://1.1.1.1、https://dns.google/dns-query';

  @override
  String get useHosts => 'Hostsを使用';

  @override
  String get useSystemHosts => 'システムのHostsを使用';

  @override
  String get nameserverPolicy => 'ネームサーバーポリシー';

  @override
  String get nameserverPolicyDesc =>
      '一致したドメインは、Nameserver と Fallback より優先してここで指定した DNS サーバーを使います。';

  @override
  String get proxyNameserver => 'プロキシネームサーバー';

  @override
  String get fallback => 'フォールバック';

  @override
  String get fallbackDesc =>
      'フォールバックフィルターが Nameserver の結果を汚染とみなしたときは、こちらの結果を使います。';

  @override
  String get preferH3 => 'HTTP/3を優先';

  @override
  String get fallbackLazyQuery => 'フォールバックの遅延クエリ';

  @override
  String get proxyNameserverPolicy => 'プロキシネームサーバーポリシー';

  @override
  String get directNameserver => '直接接続ネームサーバー';

  @override
  String get directNameserverFollowPolicy => '直接接続ネームサーバーにポリシーを適用';

  @override
  String get fallbackFilter => 'フォールバックフィルター';

  @override
  String get geoipCode => 'GeoIPコード';

  @override
  String get ipcidr => 'IPCIDR';

  @override
  String get domain => 'ドメイン';

  @override
  String get reset => 'リセット';

  @override
  String get action_view => '表示/非表示';

  @override
  String get action_start => '開始/停止';

  @override
  String get action_mode => 'モード切替';

  @override
  String get action_proxy => 'システムプロキシ';

  @override
  String get action_tun => 'TUN';

  @override
  String get hotkeyManagement => 'ホットキー管理';

  @override
  String get hotkeyManagementDesc => 'キーボードでアプリを制御';

  @override
  String get pressKeyboard => 'キーボードを押してください';

  @override
  String get remove => '削除';

  @override
  String get noNetwork => 'ネットワークなし';

  @override
  String get ipv6InboundDesc => 'IPv6 を有効にすると、VPN で IPv6 インバウンドを許可します';

  @override
  String get exportLogs => 'ログをエクスポート';

  @override
  String get exportSuccess => 'エクスポート成功';

  @override
  String get iconStyle => 'アイコンスタイル';

  @override
  String get iconStyleFilled => '背景あり';

  @override
  String get iconStylePlain => '背景なし';

  @override
  String get iconStyleHidden => '非表示';

  @override
  String get stackMode => 'スタックモード';

  @override
  String get network => 'ネットワーク';

  @override
  String get bypassDomain => '除外ドメイン';

  @override
  String get bypassDomainDesc => '除外ドメインはシステムプロキシが有効な場合のみ適用されます';

  @override
  String get resetTip => 'リセットを確定';

  @override
  String get icon => 'アイコン';

  @override
  String get noData => 'データなし';

  @override
  String get fontFamily => 'フォント';

  @override
  String get installedFonts => 'インストール済みのフォント';

  @override
  String get toggle => 'トグル';

  @override
  String get system => 'システム';

  @override
  String get bypassPrivateRoute => 'プライベートアドレスをバイパス';

  @override
  String get bypassPrivateRouteDesc =>
      'プライベートアドレスをバイパスすると、LAN・ループバック・マルチキャストのアドレスは TUN を通りません';

  @override
  String get routeAddress => 'ルートアドレス';

  @override
  String get pleaseInputAdminPassword => '管理者パスワードを入力';

  @override
  String get tunAuthorizationFailed =>
      '管理者権限が拒否されたため、TUN を有効にできませんでした。システムの権限要求を許可して、もう一度お試しください';

  @override
  String get tunHelperInstallFailed =>
      'TUN を有効にできませんでした：Helper のインストールまたは起動に失敗しました。アプリが正しくインストールされていることと、システムサービスの状態を確認して再試行してください';

  @override
  String get tunAdminAccountRequired =>
      'TUN を有効にするには、この Mac の管理者アカウントでログインする必要があります';

  @override
  String get copyEnvVar => '環境変数をコピー';

  @override
  String get memoryInfo => 'メモリ情報';

  @override
  String get dialog => 'ダイアログ';

  @override
  String get cancel => 'キャンセル';

  @override
  String get fileIsUpdate => 'ファイルが変更されました。保存しますか？';

  @override
  String get profileHasUpdate => 'プロファイルが変更されました。自動更新を無効化しますか？';

  @override
  String get copySuccess => 'コピー成功';

  @override
  String get copyLink => 'リンクをコピー';

  @override
  String get exportFile => 'ファイルをエクスポート';

  @override
  String get cacheCorrupt => 'キャッシュが破損しています。クリアしますか？';

  @override
  String get listen => 'リッスン';

  @override
  String get undo => '元に戻す';

  @override
  String get redo => 'やり直す';

  @override
  String get none => 'なし';

  @override
  String get required => '必須';

  @override
  String get advancedConfig => '詳細設定';

  @override
  String get advancedConfigDesc => '多様な設定を提供';

  @override
  String get addRule => 'ルールを追加';

  @override
  String get ruleName => 'ルール名';

  @override
  String get content => '内容';

  @override
  String get subRule => 'サブルール';

  @override
  String get ruleTarget => 'ルール対象';

  @override
  String get sourceIp => '送信元IP';

  @override
  String get noResolve => 'IPを解決しない';

  @override
  String get saveChanges => '変更を保存しますか？';

  @override
  String get findProcessModeAutomaticDesc => 'プロセスルールの照合時にのみプロセスを検出します';

  @override
  String get monochromeScheme => 'モノクローム';

  @override
  String get colorStyle => '配色スタイル';

  @override
  String get vividStyle => 'ビビッド';

  @override
  String get tintedStyle => 'ティント';

  @override
  String get softStyle => 'ソフト';

  @override
  String get customColor => 'カスタムカラー';

  @override
  String get grid => 'グリッド';

  @override
  String get spectrum => 'スペクトル';

  @override
  String get sliders => 'スライダ';

  @override
  String get hue => '色相';

  @override
  String get saturation => '彩度';

  @override
  String get brightness => '明度';

  @override
  String get hex => '16進数';

  @override
  String get liquidGlass => 'リキッドグラス';

  @override
  String get ultra => '最高';

  @override
  String get developerMode => 'デベロッパーモード';

  @override
  String get developerModeEnableTip => 'デベロッパーモードが有効になりました';

  @override
  String get messageTest => 'メッセージテスト';

  @override
  String get messageTestTip => 'これはメッセージです';

  @override
  String get crashTest => 'クラッシュテスト';

  @override
  String get clearData => 'データを消去';

  @override
  String get textScale => 'テキストスケーリング';

  @override
  String get internet => 'インターネット';

  @override
  String get systemApp => 'システムアプリ';

  @override
  String get noNetworkApp => 'ネットワークなしアプリ';

  @override
  String get restoreStrategy => '復元ストラテジー';

  @override
  String get restoreStrategy_override => '上書き';

  @override
  String get restoreStrategy_compatible => '互換';

  @override
  String get logsTest => 'ログテスト';

  @override
  String emptyTip(Object label) {
    return '$labelは空欄にできません';
  }

  @override
  String urlTip(Object label) {
    return '$labelはURLである必要があります';
  }

  @override
  String numberTip(Object label) {
    return '$labelは数字でなければなりません';
  }

  @override
  String get interval => 'インターバル';

  @override
  String existsTip(Object label) {
    return '現在の$labelは既に存在しています';
  }

  @override
  String deleteTip(Object label) {
    return '現在の$labelを削除してもよろしいですか？';
  }

  @override
  String deleteMultipTip(Object label) {
    return '選択された$labelを削除してもよろしいですか？';
  }

  @override
  String nullTip(Object label) {
    return 'まだ$labelはありません';
  }

  @override
  String get script => 'スクリプト';

  @override
  String get color => 'カラー';

  @override
  String get rename => 'リネーム';

  @override
  String get unnamed => '無題';

  @override
  String get mixedPort => 'Mixedポート';

  @override
  String get socksPort => 'SOCKSポート';

  @override
  String get redirPort => 'Redirポート';

  @override
  String get tproxyPort => 'TProxyポート';

  @override
  String portTip(Object label) {
    return '$label は 1024 から 49151 の間でなければなりません';
  }

  @override
  String get portConflictTip => '別のポートを入力してください';

  @override
  String get portUnavailableTitle => 'ポートを使用できません';

  @override
  String portUnavailableMessage(Object port) {
    return '混合ポート $port で待ち受けを開始できませんでした。他のアプリが使用している可能性があります。ポートを変更すると、すぐに再試行できます';
  }

  @override
  String get saveAndRetry => '保存して再試行';

  @override
  String portSuggestionTip(Object port) {
    return '推奨ポート $port を入力しました';
  }

  @override
  String get portProxyAppTip => '他のプロキシアプリが起動している場合は、先に終了してください';

  @override
  String get import => 'インポート';

  @override
  String get importFile => 'ファイルからインポート';

  @override
  String get importUrl => 'URLからインポート';

  @override
  String get autoSetSystemDns => 'システムDNSを自動設定';

  @override
  String get suspendOnIdle => 'アイドル時にプロキシを一時停止';

  @override
  String get suspendOnIdleDesc =>
      'アイドル時にプロキシを一時停止すると、画面がオフでシステムがアイドル状態のとき通信の転送とヘルスチェックを止めます。通話やライブ音声の切断、プッシュ通知の遅延が発生する場合があります';

  @override
  String details(Object label) {
    return '$label詳細';
  }

  @override
  String get creationTime => '作成時間';

  @override
  String get process => 'プロセス';

  @override
  String get host => 'ホスト';

  @override
  String get destination => '宛先';

  @override
  String get destinationGeoIP => '宛先地理情報';

  @override
  String get destinationIPASN => '宛先IP ASN';

  @override
  String get specialProxy => '特殊プロキシ';

  @override
  String get specialRules => '特殊ルール';

  @override
  String get remoteDestination => 'リモート宛先';

  @override
  String get networkType => 'ネットワーク種別';

  @override
  String get proxyChains => 'プロキシチェーン';

  @override
  String get proxyChainWarning =>
      'プロキシチェーンは通信速度を大きく低下させる可能性があります。明確な用途がない場合は無効のままにしてください';

  @override
  String get proxyChainInstruction =>
      '入口から出口の順に並べます。各ホップにノードまたはポリシーグループを使用できます。グループ内のプロキシは直前のホップを経由し、ネストしたグループと DIRECT/REJECT は変更されません。保存すると、チェーンはその名前のポリシーグループとしてプロキシ一覧とルールのターゲットに表示されます。編集画面の遅延は各ホップの参考値です。実際の経路はチェーンのグループでテストしてください';

  @override
  String get proxyChainMinimumNodes => 'チェーンには入口と出口が必要です';

  @override
  String get proxyChainMinimumNodesHint => '出口ノードまたはグループを選択してください';

  @override
  String get proxyChainPolicyGroups => 'ポリシーグループ';

  @override
  String get proxyChainUnsupportedGroupTip =>
      'チェーンで使用できるのは select、url-test、fallback、load-balance グループのみです';

  @override
  String get proxyChainEntry => '入口';

  @override
  String get proxyChainExit => '出口';

  @override
  String get clearProxyChain => 'チェーン設定を削除';

  @override
  String get proxyChainCustomNodes => 'カスタムノード';

  @override
  String get proxyChainCustomNode => 'カスタムノード';

  @override
  String get addProxyChainNode => '追加';

  @override
  String get proxyChainOtherNodes => 'その他のノード';

  @override
  String get proxyChainSavedAndApplied =>
      'チェーンを保存して適用しました。ルールやプロキシ一覧でチェーン名を選択してください';

  @override
  String proxyChainConflictTip(Object name) {
    return 'プロキシ $name が他の有効なチェーンと競合するか、ループを形成します';
  }

  @override
  String proxyChainUnavailableNodeTip(Object name) {
    return 'プロキシ $name はこの位置では使用できません';
  }

  @override
  String proxyChainUnavailableReference(Object chainName, Object nodeName) {
    return 'プロキシチェーン「$chainName」内のノードまたはポリシーグループ「$nodeName」は利用できません。「プロキシチェーン」で選択し直すか、このチェーンを無効にしてください';
  }

  @override
  String get proxyChainRelatedChainsUpdated => '関連するプロキシチェーンを更新しました';

  @override
  String get proxyChainSelectedNodes => 'プロキシチェーン';

  @override
  String get proxyChainAvailableNodes => '利用可能なノードとグループ';

  @override
  String get proxyChainEmpty => 'プロキシチェーンにノードがありません';

  @override
  String get proxyChainNodeAdded => 'ノードをプロキシチェーンに追加しました';

  @override
  String get proxyChainUriNodeSupportedFormats =>
      '対応形式：ss://、ssr://、vmess://、vless://、trojan://、anytls://、hysteria:// / hy://、hysteria2:// / hy2://、tuic://、wireguard:// / wg://、http(s)://、socks(5)://';

  @override
  String get log => 'ログ';

  @override
  String get connection => '接続';

  @override
  String get request => 'リクエスト';

  @override
  String get connected => '接続済み';

  @override
  String get disconnected => '切断済み';

  @override
  String get connecting => '接続中...';

  @override
  String get restartCoreTip => 'コアを再起動してもよろしいですか？';

  @override
  String get forceRestartCoreTip => 'コアを強制再起動してもよろしいですか？';

  @override
  String get dnsHijacking => 'DNSハイジャック';

  @override
  String get coreStatus => 'コアステータス';

  @override
  String get liveStatus => 'リアルタイムの状態';

  @override
  String liveStatusPosition(Object index, Object count) {
    return '$count 件中 $index 件目';
  }

  @override
  String get liveStatusTest => 'ライブステータスカードのテスト';

  @override
  String get coreStopped => 'コアが停止しました';

  @override
  String get restartCore => 'コアを再起動';

  @override
  String get coreStarting => 'コアを起動中';

  @override
  String get coreStartingDesc => 'コアに接続しています';

  @override
  String get coreRunning => 'コアは実行中';

  @override
  String get coreRunningDesc => 'アプリはコアに接続されています';

  @override
  String get forceRestartCore => '強制再起動';

  @override
  String get forceRestartCoreAsk => 'コアを強制再起動しますか？';

  @override
  String get forceRestartCoreAskDesc => '進行中の接続は切断されます';

  @override
  String get stopUpdateDownloadTip => 'アップデートのダウンロードを中止しますか？';

  @override
  String get stopUpdateDownloadDesc => 'ダウンロード済みの部分は削除されます';

  @override
  String get stopDownload => '中止';

  @override
  String get coreNotConnected => 'コアに接続されていません';

  @override
  String get appendSystemDns => 'システムDNSを追加';

  @override
  String get blockQuic => 'QUIC をブロック';

  @override
  String get blockQuicDesc => 'UDP 443のトラフィックを拒否し、接続をTCPにフォールバックさせます';

  @override
  String get blockWebRtc => 'WebRTCをブロック';

  @override
  String get blockWebRtcDesc => 'WebRTCのIP漏洩を抑えるためSTUN通信を拒否します';

  @override
  String get editRule => 'ルールを編集';

  @override
  String get overrideMode => '上書きモード';

  @override
  String get standardModeDesc => '標準モード、上書きスクリプトを任意で実行し、設定の上にルールを追加';

  @override
  String get addedRulesAfterScript => 'スクリプトの実行後、プロファイルのルールより前に挿入されます';

  @override
  String get addedRules => '追加ルール';

  @override
  String get controlGlobalAddedRules => 'グローバル追加ルールを制御';

  @override
  String get overrideScript => '上書きスクリプト';

  @override
  String get goToConfigureScript => 'スクリプト設定に移動';

  @override
  String get editGlobalRules => 'グローバルルールを編集';

  @override
  String get confirmForceCrashCore => 'コアを強制的にクラッシュさせてもよろしいですか？';

  @override
  String get confirmClearAllData => 'すべてのデータをクリアしてもよろしいですか？';

  @override
  String get loading => '読み込み中...';

  @override
  String yearsAgo(num count) {
    return '$count年前';
  }

  @override
  String monthsAgo(num count) {
    return '$countヶ月前';
  }

  @override
  String daysAgo(num count) {
    return '$count日前';
  }

  @override
  String hoursAgo(num count) {
    return '$count時間前';
  }

  @override
  String minutesAgo(num count) {
    return '$count分前';
  }

  @override
  String get justNow => 'たった今';

  @override
  String get turnOn => 'オン';

  @override
  String get turnOff => 'オフ';

  @override
  String get vpnConfigChangeDetected => 'VPN関連の設定が変更されました。タップして再起動';

  @override
  String get restart => '再起動';

  @override
  String get speedStatistics => '速度統計';

  @override
  String get resetPageChangesTip => '現在のページに変更があります。リセットしてもよろしいですか？';

  @override
  String get overwriteTypeCustom => 'カスタム';

  @override
  String get overwriteTypeCustomDesc => 'カスタムモード、プロキシグループとルールを完全にカスタマイズ可能';

  @override
  String get emptyCustomOverwrite =>
      'カスタム上書きが空です。クイック入力を使うか、ルールとプロキシグループを追加してください。サブスクリプションの内容を保つには、追加モードを使ってください';

  @override
  String get proxyGroupEmpty => 'プロキシグループが空です';

  @override
  String get proxyGroupNameEmpty => 'プロキシグループ名は空にできません';

  @override
  String get ruleEmpty => 'ルールが空です';

  @override
  String get confirmOverwriteTip => '確認後、既存のデータは上書きされます';

  @override
  String get configDataDetected => '設定内にデータが検出されました';

  @override
  String get quickFill => 'クイック入力';

  @override
  String get clearCustomRouting => '一括クリア';

  @override
  String get confirmClearCustomRouting =>
      'このプロファイルのカスタムプロキシグループとルールを消去しますか？サブスクリプションの内容、追加ルール、プロキシチェーン、カスタムノードは保持されます';

  @override
  String get addProxyGroup => 'プロキシグループを追加';

  @override
  String get editProxyGroup => 'プロキシグループを編集';

  @override
  String get lazy => '遅延読み込み';

  @override
  String get proxyFilter => 'プロキシフィルター';

  @override
  String get excludeProxyFilter => '除外プロキシフィルター';

  @override
  String get excludeType => '除外タイプ';

  @override
  String get expectedStatus => '期待されるステータス';

  @override
  String get maxFailedTimes => '最大失敗回数';

  @override
  String get timeout => 'タイムアウト';

  @override
  String get strategy => 'ストラテジー';

  @override
  String get iconUrl => 'アイコンURL';

  @override
  String get disableUDP => 'UDPを無効化';

  @override
  String get hideFromList => 'リストから隠す';

  @override
  String get includeAll => 'すべてのプロキシとプロバイダーを含める';

  @override
  String get includeAllProxies => 'すべてのプロキシを含める';

  @override
  String get includeAllProxyProviders => 'すべてのプロキシプロバイダーを含める';

  @override
  String get proxyGroupMembersEmpty => 'プロキシ、プロバイダー、または全件追加オプションを設定してください';

  @override
  String get tolerance => '許容差';

  @override
  String customOutboundInUse(Object name) {
    return '$name はグループ、ルール、またはプロキシチェーンから参照されています';
  }

  @override
  String get relayGroupUnsupported => 'Relay グループはコアから削除されました。別のタイプを選択してください';

  @override
  String rawOutboundInUse(Object name, Object path) {
    return '$name は元の設定の $path で参照されています';
  }

  @override
  String get unknownNetworkError => '不明なネットワークエラー';

  @override
  String get restoreException => '復元例外';

  @override
  String get networkException => 'ネットワーク例外、接続を確認してもう一度お試しください';

  @override
  String get invalidBackupFile => '無効なバックアップファイル';

  @override
  String get backupFromNewerVersion =>
      'このバックアップは新しいバージョンのアプリで作成されています。アプリを更新してから復元してください';

  @override
  String get pruneCache => 'キャッシュの削除';

  @override
  String get backupAndRestore => 'バックアップと復元';

  @override
  String get backupAndRestoreDesc => 'WebDAVまたはファイルを介してデータを同期する';

  @override
  String get restore => '復元';

  @override
  String get restoreDefault => 'デフォルトに戻す';

  @override
  String get restoreSuccess => '復元に成功しました';

  @override
  String get restoreFromWebDAVDesc => 'WebDAVを介してデータを復元する';

  @override
  String get restoreFromFileDesc => 'ファイルを介してデータを復元する';

  @override
  String get restoreOnlyConfig => '設定ファイルのみを復元する';

  @override
  String get restoreAllData => 'すべてのデータを復元する';

  @override
  String get backupRetention => '保持するバックアップ数';

  @override
  String get backupRetentionDesc => 'バックアップのたびにこのデバイスの古い WebDAV バックアップを削除';

  @override
  String get selectBackup => 'バックアップを選択';

  @override
  String get noRemoteBackup => 'WebDAV にバックアップがありません';

  @override
  String get deleteBackupTip => 'このバックアップを WebDAV から削除しますか？';

  @override
  String get addProfile => 'プロファイルを追加';

  @override
  String get editProfile => 'プロファイルを編集';

  @override
  String get delayTest => '遅延テスト';

  @override
  String get userCenter => 'ユーザーセンター';

  @override
  String get userCenterFallback => 'ユーザーセンター（予備）';

  @override
  String get userGuide => 'ユーザーガイド';

  @override
  String get oixCloud => 'oixCloud';

  @override
  String get register => '登録';

  @override
  String get registerTitle => 'アカウント作成';

  @override
  String get registerFailed => '登録に失敗しました';

  @override
  String get registerClosed => '現在、新規登録は停止しています';

  @override
  String get haveAccountAlready => 'すでにアカウントをお持ちですか？';

  @override
  String get goLogin => 'ログイン';

  @override
  String get nicknameLabel => 'ニックネーム';

  @override
  String get nicknameHint => '英数字、最大12文字';

  @override
  String get nicknameValidation => 'ニックネームを入力してください';

  @override
  String get confirmPasswordLabel => 'パスワード（確認）';

  @override
  String get confirmPasswordHint => 'パスワードを再入力';

  @override
  String get confirmPasswordValidation => 'パスワードを確認してください';

  @override
  String get passwordMismatch => 'パスワードが一致しません';

  @override
  String get passwordRuleHint => '10〜36文字、大文字・小文字・数字・記号を含む';

  @override
  String get inviteCodeLabel => '招待コード';

  @override
  String get inviteCodeHint => '招待コードを入力';

  @override
  String get inviteCodeValidation => '招待コードを入力してください';

  @override
  String get emailCodeLabel => 'メール認証コード';

  @override
  String get emailCodeHint => '6桁のコードを入力';

  @override
  String get emailCodeValidation => 'メール認証コードを入力してください';

  @override
  String get sendCode => 'コードを送信';

  @override
  String resendCodeIn(Object seconds) {
    return '$seconds秒後に再送信';
  }

  @override
  String get codeSent => '認証コードを送信しました';

  @override
  String get loggedOutViewTitle => 'oixCloud';

  @override
  String get loggedOutViewDesc => 'ログインしてアカウント情報を表示し、サブスクリプションを管理';

  @override
  String get signInWithGoogle => 'Google でログイン';

  @override
  String get googleLoginWaiting => 'ブラウザで Google ログインを完了してください';

  @override
  String get googleLoginUnavailable => 'Google ログインを開けませんでした、再試行してください';

  @override
  String get googleLoginTimedOut => 'Google ログインがタイムアウトしました、再試行してください';

  @override
  String get googleLoginInvalidCallback => 'Google ログインを確認できませんでした、再試行してください';

  @override
  String get loginTitle => 'ログイン';

  @override
  String get startCorePromptTitle => 'プロンプト';

  @override
  String get startCorePromptContent => 'プロファイルが正常にインポートされました。今すぐ起動しますか？';

  @override
  String get logoutTitle => 'ログアウト';

  @override
  String get logoutContent => 'ログアウトしますか？';

  @override
  String get loginSuccess => 'ログイン成功';

  @override
  String get getProfileSuccess => 'プロファイルの取得に成功しました';

  @override
  String get startSuccess => '起動しました';

  @override
  String get loginFailed => 'ログイン失敗';

  @override
  String get invalidCertificateTitle => '証明書の検証に失敗しました';

  @override
  String get certificateExpired => '証明書の有効期限が切れています';

  @override
  String get certificateNotYetValid => '証明書はまだ有効ではありません';

  @override
  String get certificateHostnameMismatch => '証明書が接続先ドメインと一致しません';

  @override
  String get certificateUntrusted => '証明書チェーンを信頼できません';

  @override
  String get certificateValidityHint =>
      'まずシステムの日付と時刻を同期してください。時刻が正しい場合は、サーバー証明書の修正が必要です。';

  @override
  String get invalidCertificateContent =>
      'サーバー証明書を検証できません。検証をスキップすると、偽のサーバーに接続し、送受信するアカウント認証情報やサブスクリプションデータが盗まれたり改ざんされたりするおそれがあります。\n\n現在のネットワークとサーバーを信頼できる場合のみ続行してください。この例外は同じサーバーと証明書への今回の再試行にのみ適用され、操作が終わると検証が再開されます。';

  @override
  String get allowTemporarily => '一時的に許可';

  @override
  String get retryWithoutCertificateVerification => 'API を一時的に確認';

  @override
  String get apiAvailableWithCertificateException =>
      '一時的な証明書の例外で API に接続できました。アカウントやノード設定は同期していません。証明書の問題を解決してから再確認してください。';

  @override
  String get certificateUntrustedHint =>
      'スマートフォンのテザリングなど別のネットワークで再試行し、システム更新を確認してください。セキュリティソフトや社内ネットワークが HTTPS を検査する場合は管理者に確認してください。解決しない場合はサービス提供元に証明書チェーンの確認を依頼してください。';

  @override
  String get certificateHostnameHint =>
      '別のネットワークを試し、Wi-Fi のログイン認証を完了してください。解決しない場合はサービス提供元に証明書とサーバードメインの一致を確認してもらってください。';

  @override
  String get certificateRevokedHint =>
      'サービス提供元に失効した証明書の交換を依頼してください。再試行やシステム時刻の変更では解決しません。';

  @override
  String get certificateUnknownHint =>
      'システムの日時を確認し、別のネットワークで再試行してください。引き続き検証できない場合は、このエラーをサービス提供元に伝えてください。';

  @override
  String get certificateCheckOnlyHint =>
      'この操作は API の接続確認のみです。アカウントへのログインやノード設定のダウンロードは行いません。';

  @override
  String get certificateSyncRetryDescription =>
      '確認後、接続確認、アカウント更新、ノード設定のダウンロードを行います。一時的な証明書の例外は今回の同期終了時に解除されます。';

  @override
  String get retryCloudSyncWithCertificateException => '一時的に許可して設定を同期';

  @override
  String get cloudSyncedWithCertificateException =>
      '一時的な証明書の例外でアカウントと設定を同期しました。証明書の検証は復元されています。次回の同期前に証明書の問題を解決してください。';

  @override
  String get cloudCertificateSyncFailed =>
      'API の接続確認には成功しましたが、アカウントまたはノード設定の同期に失敗しました';

  @override
  String get cloudConfigSyncIncomplete =>
      'ノード設定をダウンロードできませんでした。ダウンロード時のエラーを解決してから再同期してください。';

  @override
  String get emailPassword => 'メールとパスワード';

  @override
  String get accessToken => 'Access Token';

  @override
  String get emailLabel => 'メール';

  @override
  String get emailHint => 'メールアドレスを入力';

  @override
  String get emailValidation => 'メールを入力してください';

  @override
  String get emailFormatValidation => 'メール形式が正しくありません';

  @override
  String get passwordLabel => 'パスワード';

  @override
  String get forgotPassword => 'パスワードをお忘れですか？';

  @override
  String get resetPasswordTitle => 'パスワードのリセット';

  @override
  String get sendResetEmail => 'リセットメールを送信';

  @override
  String get resetEmailSent => 'リセットメールを送信しました。メール内のリセットリンクまたはコードを下に貼り付けてください';

  @override
  String get resetTokenLabel => 'リセットリンクまたはコード';

  @override
  String get resetTokenValidation => 'リセットリンクまたはコードを入力してください';

  @override
  String get newPasswordLabel => '新しいパスワード';

  @override
  String get resetPasswordSuccess => 'パスワードをリセットしました。新しいパスワードでログインしてください';

  @override
  String get passwordValidation => 'パスワードを入力してください';

  @override
  String get tokenLabel => 'Access Token';

  @override
  String get tokenValidation => 'アクセストークンを入力してください';

  @override
  String expireDate(Object date) {
    return '有効期限: $date';
  }

  @override
  String get todayUsed => '今日の使用量';

  @override
  String remaining(Object value) {
    return '残り: $value';
  }

  @override
  String get balance => '残高';

  @override
  String get commission => 'コミッション';

  @override
  String get points => 'ポイント';

  @override
  String get announcement => 'お知らせ';

  @override
  String get readFullAnnouncement => '全文を読む';

  @override
  String get serviceCheckFailed => 'サービスチェック失敗';

  @override
  String get apiAvailable => 'APIサービスは正常です';

  @override
  String get checkApi => 'APIをチェック';

  @override
  String get refresh => '更新';

  @override
  String get nodeFilter => 'ノードフィルター';

  @override
  String get nodeFilterSmartSelection => 'スマート選択';

  @override
  String get nodeFilterCustomized => 'カスタマイズ済み';

  @override
  String nodeFilterKept(Object kept, Object total) {
    return '$kept / $total 件のノードを保持';
  }

  @override
  String get nodeFilterLines => '回線';

  @override
  String get nodeFilterRegions => '地域';

  @override
  String get nodeFilterNameContains => '名前に含む';

  @override
  String get nodeFilterNameExcludes => '名前から除外';

  @override
  String get nodeFilterPreview => 'プレビュー';

  @override
  String get nodeFilterSearch => 'ノードを検索';

  @override
  String get nodeFilterAny => '指定なし';

  @override
  String get nodeFilterOnly => 'のみ残す';

  @override
  String get nodeFilterExclude => '除外';

  @override
  String get nodeFilterKeepOne => '少なくとも 1 つのノードを残してください';

  @override
  String nodeFilterNodeKept(Object name) {
    return '$name、保持';
  }

  @override
  String nodeFilterNodeExcluded(Object name) {
    return '$name、除外';
  }

  @override
  String get nodeFilterRetry => '再試行';

  @override
  String get nodeFilterAccountNote =>
      'フィルターはアカウントに保存され、このアプリでサインインしたすべてのデバイスに適用されます';

  @override
  String get nodeFilterUnavailable => 'プランを購入するとノードフィルターを利用できます';

  @override
  String get minimalConfiguration => '最小構成';

  @override
  String get minimalConfigurationDesc => '簡略化したルールセットで小さなプロファイルを生成します';

  @override
  String get tcpFastOpen => 'TCP Fast Open';

  @override
  String get tcpFastOpenDesc => 'TCPの接続確立を高速化するには、このオプションをオンにしてください';

  @override
  String get store => 'ストア';

  @override
  String get recharge => 'チャージ';

  @override
  String get availablePlans => 'プランを選択';

  @override
  String get noAvailablePlans => '利用可能なプランがありません';

  @override
  String get myOrders => '購入済みプラン';

  @override
  String get noPurchaseRecords => '購入済みのプランはありません';

  @override
  String get accountBalance => '残高';

  @override
  String commissionBalance(Object value) {
    return 'コミッション $value';
  }

  @override
  String get soldOut => '売り切れ';

  @override
  String remainingStock(Object count) {
    return '残り$count';
  }

  @override
  String get mainlandNetworkWarning => '中国本土のネットワークには適さない可能性があります';

  @override
  String get planInUse => '使用中';

  @override
  String get planNotActivated => '有効化待ち';

  @override
  String get planEnded => '終了';

  @override
  String get planAwaitingAutoRenewal => '自動更新待ち';

  @override
  String get planAwaitingAutoRenewalNote => '他のプランの後に並んでおり、それらを使い切ると自動で更新されます';

  @override
  String get planAutoRenewalOffNote => '他のプランの後に並んでおり、それらを使い切ると終了します';

  @override
  String planNumber(Object id) {
    return 'プラン #$id';
  }

  @override
  String get activate => 'アクティブ化';

  @override
  String get upgradePlan => 'プランをアップグレード';

  @override
  String get noPaymentMethods => '利用可能な支払い方法がありません';

  @override
  String get activatePlanTitle => 'プランをアクティブ化';

  @override
  String get activatePlanConfirm => 'このプランをアクティブ化しますか？アクティブ化すると現在有効なプランになります';

  @override
  String get noUpgradablePlans => 'アップグレード可能なプランがありません';

  @override
  String get selectUpgradeTarget => 'アップグレード対象を選択';

  @override
  String get refreshAfterPayment => '支払い完了後、下にスワイプして結果を確認してください';

  @override
  String get discountCodeOptional => '割引コード（任意）';

  @override
  String get bindCoupon => 'クーポンを適用';

  @override
  String get bindCouponIntro =>
      '公式のクーポンコードを入力してください。残りの期間に応じて差額を精算し、継続割引のコードは更新価格も変更します。';

  @override
  String get verifyCoupon => '確認';

  @override
  String get discountCode => 'クーポンコード';

  @override
  String get discountCodeRequired => 'クーポンコードを入力してください';

  @override
  String get discountedPriceLabel => '割引後の価格';

  @override
  String get amountDueLabel => '追加支払額';

  @override
  String get refundAmountLabel => '返金額';

  @override
  String get recurringRenewalHint => '以降の自動更新にも割引が適用されます';

  @override
  String get insufficientBalanceHint => '残高が不足しています。チャージしてから続行してください';

  @override
  String get amountPayable => '今回のお支払い';

  @override
  String get renewalPriceLabel => '以降の更新料金';

  @override
  String get calculatingQuote => '計算中…';

  @override
  String get paymentMethod => '支払い方法';

  @override
  String get goPay => '支払いへ';

  @override
  String get confirmPurchase => '購入を確認';

  @override
  String get rechargeAmount => 'チャージ金額（¥）';

  @override
  String get invalidAmount => '有効な金額を入力してください';

  @override
  String get scanOrTransferPay => 'スキャン／送金支払い';

  @override
  String get close => '閉じる';

  @override
  String get checkingPayment => '確認中...';

  @override
  String get paymentPending => 'お支払いはまだ確認できていません。しばらくしてから再度確認してください';

  @override
  String get iHavePaid => '支払い済み';

  @override
  String get openInBrowser => 'ブラウザで開く';

  @override
  String get openLinkFailed => 'リンクを開けません。ブラウザがインストールされていることを確認して、もう一度お試しください';

  @override
  String get scanToPayNotice => 'Alipay / WeChat でスキャンして支払い';

  @override
  String get paymentAmount => '支払い金額';

  @override
  String get receivingAddress => '受取アドレス';

  @override
  String get addressCopied => 'アドレスをコピーしました';

  @override
  String get transferConfirmNotice => '送金完了後、システムが自動的に確認し、選択したプランが自動的に有効になります';

  @override
  String get operationSuccess => '操作に成功しました';

  @override
  String get operationFailed => '操作に失敗しました';

  @override
  String get paymentSuccess => '支払いに成功しました';

  @override
  String get paymentRequestFailed => '支払いリクエストに失敗しました';

  @override
  String get fetchPlansFailed => 'プランの取得に失敗しました';

  @override
  String get storeSubtitle => 'プランの購入・更新・アップグレード';

  @override
  String get paymentUnknownResponse => '支払いエンドポイントが不明な形式を返しました';

  @override
  String get buy => '購入';

  @override
  String get payWithBalance => '残高で支払う';

  @override
  String availableBalance(Object value) {
    return '利用可能 $value';
  }

  @override
  String get planUnavailable => '購入不可';

  @override
  String get balanceDeductionHint => '購入時は残高から優先して差し引かれ、不足分はコミッションで自動的に補われます';

  @override
  String rechargeAllowedRange(Object min, Object max) {
    return '利用可能な範囲 $min – $max';
  }

  @override
  String get rechargeAmountOutOfRange => '金額がこの支払い方法で利用できる範囲外です';

  @override
  String get insufficientBalanceRecharge => 'チャージしてからもう一度お試しください';

  @override
  String get storeOutcomeUnknown =>
      'リクエストは処理済みの可能性があるため、再試行する前に「購入済みプラン」を確認してください';

  @override
  String configParseErrorAtLine(Object line) {
    return '設定ファイルの $line 行目の形式が正しくありません';
  }

  @override
  String configTypeMismatch(Object expected, Object actual) {
    return '$expected が必要ですが、$actual が指定されています';
  }

  @override
  String get configYamlFormatHint => 'この行付近のインデントと \"-\" のリスト記号を確認してください';

  @override
  String get configValueTypeList => 'リスト';

  @override
  String get configValueTypeObject => 'オブジェクト';

  @override
  String get configValueTypeText => 'テキスト';

  @override
  String get configValueTypeBoolean => '真偽値';

  @override
  String get configValueTypeInteger => '整数';

  @override
  String get configValueTypeNumber => '数値';

  @override
  String get configValueTypeNull => '空の値';

  @override
  String get configRecoveryTitle => 'ローカル設定の復元';

  @override
  String get configRecoveryMessage =>
      '現在、ローカル設定を読み込めません。既存のデータは保持されています。端末のロックを解除して再試行するか、後でアプリを開き直してください';

  @override
  String get configRecoveryRetry => '再試行';

  @override
  String get geoDownloadFailed => 'GEO データのダウンロードに失敗しました';

  @override
  String get geoFileMissing => '未ダウンロード';

  @override
  String get geoFileReadFailed => 'リソースファイルを読み取れませんでした';

  @override
  String get geoDownloadRecoveryHint =>
      '現在のネットワークルールで取得し、プロキシが未起動の場合は直接接続します。再試行するか、別の配信元または URL を選択してください。検証後に自動で続行します';

  @override
  String get geoOriginalSource => '現在の URL';

  @override
  String get geoBackupSource => '予備 CDN';

  @override
  String get geoDownloadUrl => 'ダウンロード URL';

  @override
  String get geoInvalidDownloadUrl => '有効な HTTP または HTTPS URL を入力してください';

  @override
  String get purchasedAtLabel => '購入日時';

  @override
  String get purchasePriceLabel => '購入価格';

  @override
  String get billingPeriodLabel => '請求期間';

  @override
  String get remainingTimeLabel => '残り時間';

  @override
  String get remainingTrafficLabel => '残りデータ量';

  @override
  String get expiresAtLabel => '有効期限';

  @override
  String get usedTrafficLabel => '使用済みデータ量';

  @override
  String get purchaseTotalTrafficLabel => '合計データ量';

  @override
  String get purchaseAutoRenewLabel => '自動更新';

  @override
  String purchaseDays(Object count) {
    return '$count日';
  }

  @override
  String purchaseHours(Object count) {
    return '$count時間';
  }

  @override
  String purchaseMinutes(Object count) {
    return '$count分';
  }

  @override
  String get purchaseRenewOn => 'オン';

  @override
  String get purchaseRenewOff => 'オフ';

  @override
  String get overwriteTypeMerge => '追加';

  @override
  String get overwriteTypeMergeDesc =>
      'サブスクリプションのルールとグループを保ち、個人設定を追加します。個人ルールはサブスクリプションより優先され、既存の追加ルールの優先順位は維持されます';

  @override
  String get personalRouting => '個人ルーティング';

  @override
  String get overlayHint =>
      '個人設定は別に保存され、更新後に再適用されます。新しいグループに一致するメンバーがない場合、接続をブロックします';

  @override
  String overlayNameConflict(Object name) {
    return '「$name」は使用済みです。個人グループの名前を変更してください';
  }

  @override
  String get outboundUnavailable => 'この設定では利用できません。削除または再選択してください';

  @override
  String get memberOrderHint => '選択順がフォールバック順になります。選び直すと末尾に移動します';

  @override
  String groupCycleError(Object name) {
    return 'グループ「$name」が循環参照しています。メンバーを変更してください';
  }

  @override
  String get rulesRequireRuleMode => '個人ルールはルールモードで有効になります';

  @override
  String get checkRouting => '設定を確認';

  @override
  String get routingChecked => '設定は有効です。個人設定はこのプロファイルに保存されています';

  @override
  String get routingApplied => '個人設定を適用しました';

  @override
  String get routingApplyFailed => '変更は保存されましたが適用できませんでした。設定を確認して再試行してください';

  @override
  String get customRuleForm => 'フォーム';

  @override
  String get customRuleRaw => 'テキスト';

  @override
  String get customRuleRawHint => '完全なルールを1行で入力します。高度な式はそのまま保持されます';

  @override
  String get customRuleFormUnavailable =>
      'このルールは高度な構文を使用しています。すべての設定を保持するにはテキストを編集してください';

  @override
  String get customRuleInvalidSyntax => '種類、内容、対象が有効な完全なルールを入力してください';

  @override
  String customRuleInvalidContent(Object example) {
    return 'このルールの種類に合った内容を入力してください。例：$example';
  }

  @override
  String customRuleUnavailableTarget(Object name) {
    return '$name は利用できません。この設定から対象を選び直してください';
  }

  @override
  String customRuleUnavailableProvider(Object name) {
    return '$name は利用できません。既存のルールプロバイダーを選んでください';
  }

  @override
  String get customRuleChooseTarget => '対象を選択';

  @override
  String get customRuleChooseProvider => 'ルールプロバイダーを選択';

  @override
  String get customRuleMatchHint => '残りのすべての通信に一致します。これより下のルールは適用されません';

  @override
  String get customRuleNoResolveHint => 'ドメインを解決せず、既知の IP アドレスと照合します';

  @override
  String get saveRoutingDraft => '下書きを保存';

  @override
  String get routingDraftHint => '下書きを保存して他の項目を修正できます。設定全体の検証後に適用されます';

  @override
  String get groupFilterHint => '自動追加とプロバイダーのノードを絞り込みます。手動選択したメンバーは保持されます';

  @override
  String get groupTypeSelect => '手動選択';

  @override
  String get groupTypeUrlTest => '自動選択';

  @override
  String get groupTypeFallback => 'フェイルオーバー';

  @override
  String get groupTypeLoadBalance => '負荷分散';

  @override
  String get groupTypeSelectHint => 'プロキシ画面で使用するメンバーを切り替えます';

  @override
  String get groupTypeUrlTestHint => '定期的に測定し、遅延の低いノードを選択します';

  @override
  String get groupTypeFallbackHint => 'メンバーを順に選び、障害時に切り替えます';

  @override
  String get groupTypeLoadBalanceHint => '接続を利用可能なメンバーに分散します';

  @override
  String get routingGroupType => 'グループの種類';

  @override
  String get customRuleType => 'ルールの種類';

  @override
  String get routingChanged => '編集中または確認中に設定が変更されました。エディターを開き直すか、再度確認してください';

  @override
  String get editCustomRouting => 'カスタム設定を編集';

  @override
  String get customRoutingDraftHint =>
      'カスタム設定を入力してから、カスタムモードに切り替えてください。下書きの編集では現在のモードは変わりません';

  @override
  String coreBlockedByPolicyTip(int code) {
    return 'Windows がプロキシコアの起動をブロックしました（システムエラー $code）。Windows セキュリティの保護の履歴とアプリ制御ポリシーを確認し、インストーラーの入手元と署名を確認してください';
  }

  @override
  String get startupRecoveryTitle => '起動の復旧';

  @override
  String get startupRecoveryTip =>
      '前回の起動が完了しませんでした。今回は設定の自動適用と VPN の自動起動を一時停止しています。選択中のプロファイルと設定は保持されています。設定を確認し、「開始」で再試行してください。実行中の VPN は接続を維持します';

  @override
  String get initFailed => '起動に失敗しました';

  @override
  String get initFailedTip => '起動中に重大なエラーが発生したため、アプリを続行できません';

  @override
  String get startupTimeoutTip =>
      '起動がタイムアウトしました。アプリを終了して再度開いてください。問題が続く場合は、以下の診断情報をコピーしてください。';

  @override
  String get startupDiagnostics => '起動の診断情報';

  @override
  String get errorDetails => 'エラーの詳細';

  @override
  String get stackTrace => 'スタックトレース';

  @override
  String get authentication => 'ローカルプロキシ認証';

  @override
  String get authenticationDesc =>
      'ローカルプロキシ認証を有効にすると、HTTP/SOCKS プロキシの利用にユーザー名とパスワードが必要になります。有効な間はシステム HTTP プロキシを自動設定しませんが、TUN/VPN は利用できます';

  @override
  String get authenticationSystemProxyDesc =>
      'ローカルプロキシ認証が有効な間、システムプロキシは設定されません';

  @override
  String get authenticationUsernameInvalid =>
      'コロンや制御文字を含まない 1～255 UTF-8 バイトを入力してください';

  @override
  String get authenticationPasswordInvalid =>
      '制御文字を含まない 1～255 UTF-8 バイトを入力してください';

  @override
  String get authenticationApplyFailed => '認証設定を適用できませんでした';

  @override
  String get installedAppsPermissionRequired => 'アプリ一覧へのアクセス許可が必要です';

  @override
  String get installedAppsPermissionDesc =>
      'VPN を使用するアプリを選ぶには、インストール済みアプリ一覧へのアクセスを許可してください';

  @override
  String get installedAppsPermissionDeniedMessage =>
      '許可されませんでした。システム設定でアクセスを許可できます';

  @override
  String get installedAppsPermissionGrant => 'アクセスを許可';

  @override
  String get installedAppsLoadFailed => 'アプリ一覧を読み込めませんでした。再試行してください';

  @override
  String get configRecoveryMissingKey =>
      '既存の設定の暗号化キーが見つからないか無効です。元のデバイスの元のユーザーで実行するか、バックアップを復元してください。再試行しても失われたキーは再生成できません';

  @override
  String get configRecoveryDatabaseUnavailable =>
      '現在ローカルデータベースにアクセスできません。元のファイルは保持されています。このアプリのデータフォルダーのアクセス権と、他のプロセスがデータベースを使用していないかを確認してから、再試行してください。';

  @override
  String get configRecoveryIncompatibleDatabase =>
      'このアプリのデータフォルダー内のデータベースに互換性がないか、破損しています。元のファイルは保持されています。互換性のあるバックアップを復元するか、バックアップしてリセットした後、このアプリを再設定してください。他のアプリのデータにはアクセスしません。';

  @override
  String get configRecoveryUnreadable =>
      'ローカル設定を復号できないか、ファイルが破損しています。元のファイルは保持されています。対応するキーと設定のバックアップを復元するか、バックアップしてリセットしてください';

  @override
  String get configRecoveryStorage =>
      'ローカル設定または暗号化キーを読み書きできません。アプリのデータフォルダーとシステムの安全なストレージへのアクセス権を確認して再試行してください';

  @override
  String get configRecoveryReset => 'バックアップしてリセット';

  @override
  String get configRecoveryResetConfirm =>
      'すべてのローカル設定、サブスクリプション、ルール、アカウントデータを暗号化してバックアップし、アプリをリセットしますか？再ログインと、設定およびサブスクリプションの復元またはインポートが必要です。バックアップは現在の Windows ユーザーで保護されますが、失われた暗号化キーは復元できません';

  @override
  String get configRecoveryResetDone =>
      '元のデータを以下のフォルダーに暗号化してバックアップしました。アプリを終了して再度開き、設定を行ってください';

  @override
  String get configRecoveryResetFailed =>
      '暗号化バックアップとリセットを完了できませんでした。バックアップを検証するまで残っている元のデータは削除されません。再試行するか、アプリを終了して再度開いて完了してください';

  @override
  String get configRecoveryKeyring =>
      'システムのキーリング（Secret Service）にアクセスできないため、システム設定で KDE ウォレットまたは GNOME キーリングを有効にしてロックを解除してから再試行してください';

  @override
  String get configRecoveryUseLocalStorage => 'ローカルファイルに保存';

  @override
  String get configRecoveryUseLocalStorageConfirm =>
      '暗号化キーとアカウントの認証情報を、システムのキーリングではなくアプリのデータフォルダー内の現在のユーザーだけがアクセスできるファイルに保存しますか？現在のユーザーとして動作するプログラムはそれらを読み取ってローカル設定を復号でき、この選択は今後も維持されます';

  @override
  String get excludeSsids => 'プロキシを停止する Wi-Fi';

  @override
  String get excludeSsidsDesc =>
      '指定した Wi-Fi ではプロキシを一時停止し、アプリが開始状態の場合のみ離れると再開します';

  @override
  String get allowBackgroundLocation => '常に位置情報を許可';

  @override
  String get locationPermission => '位置情報の権限';

  @override
  String get locationPermissionRequired => '位置情報の権限が必要です';

  @override
  String locationPermissionGuide(Object appName) {
    return '1. システム設定 > プライバシーとセキュリティ を開く\n2. 位置情報サービス を選択\n3. リストで $appName を見つけてチェックを入れる\n\n設定が完了したらアプリに戻ると、通常どおり使用できます。ご協力ありがとうございます';
  }

  @override
  String get ssidPermissionGuide =>
      'Wi-Fi 名の取得には位置情報の許可が必要です。Android では正確な位置情報を常に許可し、位置情報サービスを有効にしてください';

  @override
  String get ssidPermissionMacosGuide =>
      'Wi-Fi 名を取得するには、システム設定でこのアプリの位置情報サービスを許可してください';

  @override
  String get exitDefault => 'デフォルト';

  @override
  String get customExit => 'カスタム出口';

  @override
  String get inputExitName => '出口名を入力してください';

  @override
  String get iconHistory => '最近使用したアイコン';

  @override
  String get exitFullScreen => '全画面表示を終了';

  @override
  String get unmaximize => '元に戻す';

  @override
  String get maximize => '最大化';

  @override
  String get unpinWindow => '固定を解除';

  @override
  String get pinWindow => '最前面に固定';

  @override
  String get minimize => '最小化';

  @override
  String get cloudApiDnsFailed => 'DNS 名前解決に失敗しました';

  @override
  String get cloudApiDnsEmpty => 'DNS が空の応答を返しました。妨害またはシステム DNS の異常の可能性があります';

  @override
  String get cloudApiDnsUnknownHost => 'DNS がこのドメインを見つけられませんでした';

  @override
  String get cloudApiConnectTimeout => '接続がタイムアウトしました';

  @override
  String get cloudApiSendTimeout => 'リクエスト送信がタイムアウトしました';

  @override
  String get cloudApiReceiveTimeout => 'サーバー応答がタイムアウトしました';

  @override
  String get cloudApiTlsFailed => 'TLS ハンドシェイクに失敗しました';

  @override
  String get cloudApiConnectionRefused => '接続が拒否されました';

  @override
  String get cloudApiConnectionReset => '接続がリセットされました';

  @override
  String get cloudApiNetworkUnreachable => 'ネットワークに到達できません';

  @override
  String get cloudApiAccessDenied => 'ネットワークへのアクセスが拒否されました';

  @override
  String get cloudApiConnectionFailed => '接続に失敗しました';

  @override
  String get cloudApiProxyFailed => 'プロキシ接続に失敗しました';

  @override
  String get cloudApiProxyAuthFailed => 'プロキシ認証に失敗しました（HTTP 407）';

  @override
  String cloudApiHttpError(Object status) {
    return 'サーバーが HTTP $status を返しました';
  }

  @override
  String get certificateRevoked => '証明書は失効しています';

  @override
  String get cloudApiBadRequest => 'サーバーがリクエストを無効と判断しました';

  @override
  String get cloudApiForbidden => 'サーバーへのアクセスが拒否されました';

  @override
  String get cloudApiNotFound => '要求された API またはリソースが見つかりません';

  @override
  String get cloudApiMethodNotAllowed => 'このリクエストメソッドは許可されていません';

  @override
  String get cloudApiServerRequestTimeout => 'サーバーでリクエストの受信がタイムアウトしました';

  @override
  String get cloudApiRequestTooLarge => 'リクエストがサーバーのサイズ制限を超えています';

  @override
  String get cloudApiRateLimited => 'リクエストが多すぎます。しばらくしてから再試行してください';

  @override
  String get cloudApiServerError => 'サーバー内部エラー';

  @override
  String get cloudApiBadGateway => 'ゲートウェイが上流から無効な応答を受信しました';

  @override
  String get cloudApiServiceUnavailable => 'サービスは一時的に利用できません';

  @override
  String get cloudApiGatewayTimeout => 'ゲートウェイで上流サーバーの応答待ちがタイムアウトしました';

  @override
  String get cloudApiNetworkAuthRequired => 'このネットワークでは接続前にログインが必要です';

  @override
  String get cloudApiResponseTooLarge => 'サーバーの応答が許容サイズを超えています';

  @override
  String get cloudApiTlsProtocolFailed => 'TLS プロトコルに互換性がないか、TLS 応答が無効です';

  @override
  String get cloudApiTlsAlgorithmFailed => 'TLS 暗号アルゴリズムのネゴシエーションに失敗しました';

  @override
  String get cloudApiTlsInterrupted => 'TLS ハンドシェイクの完了前に接続が切断されました';

  @override
  String get cloudApiRedirectLoop => 'サーバーのリダイレクトがループしています';

  @override
  String get cloudApiRedirectLimit => 'サーバーのリダイレクト回数が多すぎます';

  @override
  String get cloudApiRedirectInvalid => 'サーバーのリダイレクトが無効です';

  @override
  String get cloudApiResponseInterrupted => '応答の受信が完了する前に接続が切断されました';

  @override
  String get cloudApiConnectionAborted => '接続が中止されました';

  @override
  String get cloudApiAddressUnavailable => 'ネットワークアドレスを利用できません';

  @override
  String get cloudApiAddressInUse => 'ネットワークアドレスまたはポートは使用中です';

  @override
  String get cloudApiNetworkResourcesExhausted => 'システムのネットワークリソースが不足しています';

  @override
  String get cloudApiClockSkew => '端末の時計がサーバーとずれすぎています。日時の自動設定をオンにして再試行してください。';

  @override
  String get cloudApiSignatureRejected =>
      'サーバーがこのアプリの署名を拒否しました。公式の最新版を再インストールしてください。';

  @override
  String get cloudApiServerUnconfigured =>
      'サーバーにこのアプリの鍵が設定されていません。サポートにご連絡ください。';

  @override
  String get cloudApiConfigKeyRejected =>
      'サーバーがこの端末の構成キーを拒否しました。公式の最新版を再インストールしてください。';

  @override
  String get cloudApiAccountDisabled => 'このアカウントは停止されています。サポートにご連絡ください。';

  @override
  String get cloudApiAccountAnomaly =>
      'このアカウントは確認が必要です。ウェブサイトで確認を済ませてから再試行してください。';

  @override
  String get cloudApiAccountNotFound => 'このアカウントは存在しません。再度ログインしてください。';

  @override
  String get cloudApiInvalidResponse => 'サーバー応答の形式が無効です';

  @override
  String get cloudApiRequestCanceled => 'リクエストがキャンセルされました';

  @override
  String cloudApiSystemError(Object code) {
    return 'システムエラー $code';
  }

  @override
  String get cloudApiTimeout => 'リクエストがタイムアウトしました';

  @override
  String cloudApiRouteDirect(Object error) {
    return '直接接続：$error';
  }

  @override
  String cloudApiRouteProxy(Object error) {
    return '内蔵プロキシ：$error';
  }

  @override
  String get diagTitle => 'ネットワーク診断';

  @override
  String get diagEntryHint => 'コア、システムプロキシ、TUN、DNS を確認';

  @override
  String get diagScope =>
      '現在の接続を少数のサンプルで確認します。システム経路も TUN を通る場合があります。すべてのアプリやノードを保証するものではありません';

  @override
  String get diagRun => '診断を開始';

  @override
  String get diagCopy => '診断レポートをコピー';

  @override
  String get diagCanceled => '診断はキャンセルされました。結果は不完全です';

  @override
  String get diagFixing => '修復を適用しています。完了後に再確認します';

  @override
  String get diagFixFailed => '修復を適用できませんでした。上記の提案に従って手動で対処してください';

  @override
  String get diagFixApplyProfile => '構成を適用';

  @override
  String get diagFixStart => '接続を開始';

  @override
  String get diagFixRestartCore => 'コアを再起動';

  @override
  String get diagFixRestartConnection => '再接続';

  @override
  String get diagFixSystemProxy => 'システムプロキシを再設定';

  @override
  String get diagFixEnableSystemProxy => 'システムプロキシを有効化';

  @override
  String get diagFixTun => 'TUN を再有効化';

  @override
  String get diagFixRetest => 'ノードを再テスト';

  @override
  String get diagPassed => '成功';

  @override
  String get diagWarning => '確認が必要';

  @override
  String get diagFailed => '失敗';

  @override
  String get diagUnknown => '確認できません';

  @override
  String get diagSkipped => 'スキップ';

  @override
  String get diagDisabled => 'このオプションは無効です';

  @override
  String get diagProfile => '適用済み設定';

  @override
  String get diagProfileReady => '選択した設定は適用済みです';

  @override
  String get diagProfileMissing => '選択した設定は未適用です';

  @override
  String get diagProfileHint => '有効な設定を選び、接続を開始してから再確認してください';

  @override
  String get diagCore => 'コア応答';

  @override
  String get diagCoreReady => 'コアが応答し、リスナーの起動を報告しました';

  @override
  String get diagCoreUnknown => 'コアの診断結果を取得できないか、診断中に設定が変わりました';

  @override
  String get diagCoreStopped => 'コアのトラフィック転送が停止しています';

  @override
  String get diagSuspended => '現在の Wi-Fi 除外設定により転送が一時停止しています';

  @override
  String get diagCoreHint =>
      '接続スイッチと Wi-Fi 除外を確認してください。コアが応答しない場合は再起動し、クライアントとコアのバージョンを揃えてください';

  @override
  String get diagListener => 'ローカルプロキシ入口';

  @override
  String get diagListenerReady => '指定ポートがプロキシプロトコルに応答しました';

  @override
  String get diagListenerFailed => '指定プロキシポートが応答しないか、コアのポートと一致しません';

  @override
  String get diagListenerHint =>
      'ポートの競合やリスナーの停止を確認してください。まず再接続し、解決しない場合は「ポートと認証の設定」で混合ポートを確認・変更してください。';

  @override
  String get diagSystemProxy => 'システムプロキシ設定';

  @override
  String get diagProxyReady => 'HTTP と HTTPS プロキシが指定ローカルポートを指しています';

  @override
  String get diagProxyDisabled => 'アプリでは有効ですが、OS のシステムプロキシは無効です';

  @override
  String get diagProxyDifferent => 'OS のプロキシがアプリのポートと一致しません';

  @override
  String get diagProxyAutomatic => '自動プロキシ設定があります。実際の経路は未確認です';

  @override
  String get diagProxyHint =>
      '「トラブルシューティングと手動設定」でシステムプロキシのアドレスとポートを確認してください。設定が元に戻る場合は、他のプロキシアプリやデバイス管理ポリシーを確認してください。';

  @override
  String get diagProxyAutomaticHint =>
      'PAC スクリプトや自動検出はサイトごとに異なるプロキシを選択する場合があります。必ずしも接続障害ではありません。変更前に設定の提供元を確認してください。';

  @override
  String get diagSystemDnsHint =>
      '別のネットワークを試し、OS の現在の接続の DNS サーバーを確認してください。クライアントの DNS 上書きだけではシステムの名前解決が直らない場合があります。';

  @override
  String get diagProxyRecover => '無効なローカルプロキシを解除';

  @override
  String get diagProxyRecoverHint =>
      '先に接続を停止してください。現在のローカルポートでサービスが待ち受けていない場合にのみ、そのポートを指定した手動プロキシを解除します。他のアドレス、ポート、自動設定は保持されます。';

  @override
  String get diagProxyGuide => 'トラブルシューティングと手動設定';

  @override
  String get diagRecheck => '再チェック';

  @override
  String get diagOpenPortSettings => 'ポートと認証の設定';

  @override
  String get diagOpenNetworkSettings => 'ネットワークと TUN の設定';

  @override
  String get diagOpenDnsSettings => 'DNS 上書き設定';

  @override
  String get diagOpenSystemSettings => 'システム設定を開く';

  @override
  String get diagOpenSettingsFailed => 'システム設定を開けませんでした。上記の手順で手動で開いてください。';

  @override
  String get diagCopyProxyAddress => 'プロキシアドレスをコピー';

  @override
  String get diagProxyGuidePrepareTitle => '1. ローカルプロキシを先に確認';

  @override
  String get diagProxyGuidePrepare =>
      'FlClash で有効なプロファイルを選択して接続を開始し、「ローカルプロキシリスナー」のチェックが成功してからアドレスを入力してください。\n設定を書き換える他のプロキシアプリを終了してください。会社や学校の管理下にある、編集できない、または元に戻る設定は管理者に確認してください。';

  @override
  String get diagProxyGuideManualTitle => '2. プロキシ設定を確認・入力';

  @override
  String get diagProxyGuideWindows =>
      '設定 → ネットワークとインターネット → プロキシ\n自動設定が他のアプリの残したもので現在のネットワークに不要なら、「セットアップスクリプトを使う」と「設定を自動的に検出する」をオフにします。\n手動プロキシ設定で「プロキシサーバーを使う」をオンにし、下記のアドレスとポートを別々の欄に入力して保存します。アドレスに http:// を付けず、ネットワークに必要な例外は残してください。';

  @override
  String get diagProxyGuideMacos =>
      'システム設定 → ネットワーク → 使用中の Wi-Fi または Ethernet → 詳細 → プロキシ\nmacOS 12：システム環境設定 → ネットワーク → 使用中の接続 → 詳細 → プロキシ\n自動設定が他のアプリの残したもので現在のネットワークに不要なら、「自動プロキシ検出」と「自動プロキシ構成」をオフにします。\nWeb プロキシ（HTTP）と保護された Web プロキシ（HTTPS）をオンにし、両方に下記のアドレスとポートを入力して保存します。必要な除外設定は残してください。';

  @override
  String get diagProxyGuideLinux =>
      'デスクトップの設定 → ネットワーク → ネットワークプロキシで手動モードを選びます（名称は環境によって異なります）。\nHTTP と HTTPS の両方に下記のアドレスとポートを入力して適用します。システムの設定画面がなければ、対象アプリで設定してください。\n自動設定から変更する前に、提供元と現在も必要かを確認してください。';

  @override
  String get diagProxyGuideApp =>
      'このデバイスの対象アプリでプロキシ設定を開き、HTTP または SOCKS5 を選んで下記のアドレスとポートを入力します。\nAndroid のシステムプロキシは VPN サービス経由で提供されます。VPN 接続には FlClash のネットワーク設定で VPN とアプリアクセス制御を確認してください。';

  @override
  String get diagProxyGuideAuthenticated =>
      'ローカルプロキシ認証が有効なため、FlClash はシステムプロキシを自動設定しません。\n認証対応アプリで HTTP または SOCKS5 を選び、下記のアドレスとポートを入力します。ユーザー名とパスワードは FlClash → 上書き → 一般 → インバウンド → 認証で確認できます。\n診断レポートに認証情報を含めないでください。';

  @override
  String diagProxyGuideValues(Object port) {
    return 'ローカルアドレス：127.0.0.1\n混合ポート（現在の設定）：$port\nこのデバイス上の HTTP、HTTPS サイトへのプロキシ接続、SOCKS5 に同じ混合ポートを使用します。';
  }

  @override
  String get diagProxyGuideInvalidPort =>
      '混合ポートが利用できません。「ポートと認証の設定」で有効なポートを設定し、接続を開始してください。';

  @override
  String get diagProxyGuideVerifyTitle => '3. 保存後に実際のアプリで確認';

  @override
  String get diagProxyGuideVerify =>
      '戻って「再チェック」を選び、普段使うブラウザやアプリでも再試行してください。\nローカルプロキシのチェックが成功してもアプリが接続できない場合は、アプリ独自のプロキシ設定や拡張機能を確認してください。システムプロキシはすべてのアプリに適用されるわけではありません。\nFlClash 停止後も通信できるよう、手動設定したプロキシは自分で解除または元の設定に戻す必要がある場合があります。';

  @override
  String get diagTun => 'TUN インターフェースと経路';

  @override
  String get diagTunMissing => 'コアに対応する TUN が有効な状態で見つかりません';

  @override
  String get diagTunReady => 'コアの TUN は有効で、確認した IPv4 経路もそこを通ります';

  @override
  String get diagTunRouteMismatch => 'TUN は有効ですが、確認した IPv4 経路は別のインターフェースを通ります';

  @override
  String get diagTunRouteUnknown => 'TUN は有効ですが、IPv4 経路を確認できません';

  @override
  String get diagTunHint =>
      'TUN を再度有効にし、システム認証を完了してください。経路が違う場合は他の VPN を確認してください。IPv6、UDP、アプリ除外は別途確認が必要です';

  @override
  String get proxyConflictTitle => 'プロキシが競合している可能性があります';

  @override
  String proxyConflictSystemProxy(Object address) {
    return '起動前、システムプロキシは $address に設定されていました';
  }

  @override
  String get proxyConflictAutoConfig => '起動前、システムプロキシは自動構成スクリプトを使用していました';

  @override
  String proxyConflictVpn(Object name) {
    return '起動前、通信は別の VPN または仮想アダプター $name を経由していました';
  }

  @override
  String get proxyConflictHint =>
      '同時に使用すると接続に問題が起きるため、他のプロキシアプリや VPN であれば終了してください';

  @override
  String get diagTrafficCapture => 'トラフィックの取り込み';

  @override
  String get diagNoCapture => 'システムプロキシと TUN が両方とも無効です';

  @override
  String get diagCaptureHint =>
      'システムプロキシまたは TUN を有効にするか、対象アプリにローカルプロキシを設定してください';

  @override
  String get diagSystemDns => 'システム DNS';

  @override
  String get diagCoreDns => 'コア DNS';

  @override
  String diagProbeSummary(int passed, int total) {
    return '$total 件中 $passed 件のサンプルが成功';
  }

  @override
  String diagProbeResult(int index, String result, int milliseconds) {
    return '検査 $index：$result · $milliseconds ms';
  }

  @override
  String get diagDnsServerFailed => 'DNS 上流がサーバーエラーを返しました';

  @override
  String get diagDnsReady => '確認したドメインを解決できました';

  @override
  String get diagDnsPartial => '一部のドメインのみ解決できました';

  @override
  String get diagOixDnsNoSample => '今回の確認に使える管理対象ノードのドメインがありません';

  @override
  String get diagOixDnsAuthMissing => '管理対象 DNS の署名機能が準備できていません';

  @override
  String get diagDnsNoAnswer => 'DNS が有効なアドレスを返しませんでした。この結果だけでは認証失敗とは断定できません';

  @override
  String get diagDnsRefused => 'DNS リクエストが拒否されました';

  @override
  String get diagDnsHint =>
      'DNS の上書き設定を確認し、別のネットワークでも試してください。システム DNS のみ成功する場合は設定内の DNS を確認してください';

  @override
  String get diagOixDnsHint =>
      'クライアントのバージョンとシステム時刻を確認し、サブスクリプションを更新してください。解決しない場合は診断レポートをサポートへ共有してください';

  @override
  String get diagSystemPath => 'システムのネットワーク経路';

  @override
  String get diagProxyPath => 'ローカルプロキシ経由の接続';

  @override
  String diagWebResult(Object count) {
    return '独立した HTTPS 検査 2 件中 $count 件が成功';
  }

  @override
  String get diagSystemPathHint =>
      'この経路はアプリの HTTP プロキシを明示的には使いませんが、TUN を通る場合があります。DNS、フィルタリング、検査サイトの影響を考慮し、プロキシ結果と比較してください';

  @override
  String get diagProxyPathHint =>
      'システム経路が成功する場合は、選択ノード、ルール、コア DNS を確認してください。検査サイト 1 つの失敗だけですべてのノードが使えないとは言えません';

  @override
  String get diagClock => 'システム時刻の比較';

  @override
  String get diagClockUnknown => '時刻比較に必要な未キャッシュの HTTPS 応答が不足しています';

  @override
  String get diagClockSkew => '独立した 2 件の応答が 5 分以上の時刻差の可能性を示しています';

  @override
  String get diagClockReady => '今回の確認では一貫した大きな時刻差は見つかりませんでした';

  @override
  String get diagClockHint =>
      'システムの日時自動設定を有効にして再試行してください。時刻のずれは証明書検証と oixCloud DNS 署名に影響する場合があります';

  @override
  String get diagAllFailed =>
      'このグループの今回の速度テストはすべて失敗しました。テスト URL に到達できない可能性もあります。ネットワーク診断を実行できます';

  @override
  String get updateDownloadBackground => 'バックグラウンドでダウンロード';

  @override
  String get updateReady => '更新の準備ができました';

  @override
  String get updateRestart => '更新してアプリを再起動';

  @override
  String get updateRestartHint => 'アプリを終了して更新し、再起動します。設定は保持されます。';

  @override
  String get updatePreparing => 'アップデートを準備しています';

  @override
  String get updateVerifying => '更新パッケージを検証しています';

  @override
  String get updateCheckingInstaller => 'インストーラーを確認しています';

  @override
  String get updateRestarting => '終了して再起動しています';

  @override
  String get updateApplyFailed => '自動更新を完了できませんでした。再試行するか、ダウンロードページから更新してください。';

  @override
  String get updateReadyHint => '更新のダウンロードが完了しました。都合のよいときにインストールできます';

  @override
  String get updateInstall => '更新をインストール';

  @override
  String get updateDownloading => '更新をダウンロード中';

  @override
  String get updateDownloadFailed => '更新のダウンロードに失敗しました';

  @override
  String get updateDownloadBrowser => 'ブラウザーでダウンロード';

  @override
  String get updatePackageFormat => 'パッケージ形式を選択';

  @override
  String get updatePackageFormatTip => 'インストール方法を判別できませんでした。一致する形式を選んでください。';

  @override
  String get updateAppImageTip =>
      'AppImage は自動インストールできません。ダウンロードしたファイルで現在のプログラムを置き換えてください。保存先のフォルダーを開きました';

  @override
  String get updatePackageManagerTip =>
      'このビルドはパッケージマネージャーでインストールされています。インストール時と同じ方法で更新してください。';

  @override
  String get tunMtuDesc => '既定値は 9000、1480 または 4064 も選択可能。Android VPN の再起動後に適用';

  @override
  String get tunMtuInvalid => '1280〜65535 の整数を入力してください';

  @override
  String get scriptOptions => 'スクリプト設定';

  @override
  String get scriptOptionsEmpty => 'このスクリプトには設定可能なスイッチがありません';

  @override
  String get scriptChanges => 'スクリプトの変更';

  @override
  String get scriptFullConfig => '設定全体';

  @override
  String get scriptChangesDescription =>
      'スクリプトが追加・変更・削除した最上位の設定項目です。設定全体にはアプリの設定も含まれます。';

  @override
  String get scriptChangesEmpty => 'スクリプトによる設定の変更はありません';

  @override
  String scriptChangesAdded(int count) {
    return '追加（$count）';
  }

  @override
  String scriptChangesModified(int count) {
    return '変更（$count）';
  }

  @override
  String scriptChangesRemoved(int count) {
    return '削除（$count）';
  }

  @override
  String get excludeNetworks => 'IP またはゲートウェイでプロキシを一時停止';

  @override
  String get excludeNetworksDesc =>
      'Wi-Fi／イーサネットの IPv4、サブネット、ゲートウェイに一致すると一時停止し、離れると再開。カンマ区切り、例: 192.168.1.0/24,gateway:192.168.1.1';

  @override
  String get excludeNetworksInvalid =>
      '最大 16 件。有効な IPv4、CIDR または gateway:アドレスを入力';

  @override
  String get delayConcurrency => '一括測定の同時実行数';

  @override
  String get delayTestFailed => '測定失敗';

  @override
  String get updateReleaseNotes => '更新内容';

  @override
  String get updateDownloadConfirm => '更新をダウンロード';

  @override
  String get updateLater => '後で';

  @override
  String get updateCancelDownload => 'ダウンロードを中止';

  @override
  String get updateNotice => '新しいバージョンが見つかりました';

  @override
  String updateVersionNumber(String version) {
    return 'バージョン：$version';
  }

  @override
  String updateBuildNumber(String build) {
    return 'ビルド番号: $build';
  }

  @override
  String get updateReleaseNotesFailed => '更新履歴を読み込めませんでした。再試行してください';

  @override
  String get tailscaleEntryHint => 'Tailnet 内のデバイスにアクセス';

  @override
  String get tailscaleEmptyTitle => 'Tailnet にアクセス';

  @override
  String get tailscaleEmptyDesc =>
      'ネットワークを追加してこのデバイスでログインし、プロキシを起動するとデバイスにアクセスできます';

  @override
  String get tailscaleAddNetwork => 'ネットワークを追加';

  @override
  String get tailscaleNetworks => 'ネットワーク';

  @override
  String get tailscaleGuide => '使い方';

  @override
  String get tailscaleThisDevice => 'このデバイス';

  @override
  String get tailscaleStatus => '状態';

  @override
  String get tailscaleDeviceName => 'デバイス名';

  @override
  String tailscaleDevices(Object count) {
    return 'デバイス（$count）';
  }

  @override
  String get tailscaleNetworkName => 'ネットワーク名';

  @override
  String get tailscaleNameInUse => 'この名前は既に使われています';

  @override
  String get tailscaleLoginMethod => 'ログイン方法';

  @override
  String get tailscaleInteractiveLogin => '対話型ログイン';

  @override
  String get tailscaleAuthKey => '認証キー';

  @override
  String get tailscaleAuthKeySaved => 'このデバイスには認証キーが保存されています。新しいキーを入力すると置き換えます';

  @override
  String get tailscaleLoginFooter => 'ネットワークごとにこのデバイスで一度ログインするだけです';

  @override
  String get tailscaleAutoRoute => '自動ルーティング';

  @override
  String get tailscaleAutoRouteDesc =>
      'ピアのアドレス、MagicDNS 名、承認済みサブネットをこのネットワーク経由でルーティング';

  @override
  String get tailscaleExitNode => '出口ノード';

  @override
  String get tailscaleExitNodeDesc => '空欄で使用しません。auto、ピア名またはピアの IP アドレスも指定できます';

  @override
  String get tailscaleAvailableExitNodes => '利用可能な出口ノード';

  @override
  String get tailscaleExitNodeAllowLan => 'ローカルネットワークへのアクセスを許可';

  @override
  String get tailscaleAdvanced => '詳細設定';

  @override
  String get tailscaleControlUrl => 'コントロールサーバーの URL';

  @override
  String get tailscaleCredentialsFooter => '認証情報とデバイスの識別情報はこのデバイスにのみ保存されます';

  @override
  String get tailscaleAccount => 'アカウント';

  @override
  String get tailscaleSaveAndLogin => '保存してログイン';

  @override
  String get tailscaleOpenLoginPage => 'ログインページを開く';

  @override
  String get tailscaleLoginWaiting =>
      'ログインページを開くかコードをスキャンしてください。承認後に自動でログインが完了します';

  @override
  String get tailscaleSigningIn => 'ログイン中';

  @override
  String get tailscaleSignedIn => 'ログイン済み';

  @override
  String get tailscaleLogout => 'ログアウト';

  @override
  String get tailscaleLoginFailed => 'Tailscale へのログインに失敗しました';

  @override
  String get tailscaleLoginTimeout => '5 分以内にログインが完了しませんでした。もう一度お試しください';

  @override
  String get tailscaleLoginHint => 'ログインでこのデバイスを承認します。ネットワークを使うにはプロキシを起動してください';

  @override
  String get tailscaleEnterAuthKey => 'このデバイスでログインするには認証キーを入力してください';

  @override
  String tailscaleCheckSettings(Object fields) {
    return '次の設定を確認してください：$fields';
  }

  @override
  String get tailscaleNotApplied => '未適用';

  @override
  String get tailscaleNotAppliedHint =>
      'ネットワークが実行中の設定に含まれていません。プロファイルを選択し、同じ名前のノードがないことを確認してください';

  @override
  String get tailscaleNotSignedIn => '未ログイン';

  @override
  String get tailscaleNeedsLogin => 'ログインが必要です';

  @override
  String get tailscaleKeyExpired => 'ノードキーの有効期限が切れました';

  @override
  String get tailscaleNeedsApproval => 'デバイスの承認待ちです';

  @override
  String get tailscaleConnecting => '接続中';

  @override
  String get tailscaleConnected => '接続済み';

  @override
  String get tailscaleStopped => '停止中';

  @override
  String get tailscaleUnavailable => '接続できません';

  @override
  String get tailscaleOnline => 'オンライン';

  @override
  String get tailscaleOffline => 'オフライン';

  @override
  String get tailscaleRemoveNetwork => 'ネットワークを削除';

  @override
  String tailscaleRemoveConfirm(Object name) {
    return 'このデバイスは $name から退出し、このデバイス上のログイン情報が削除されます。現在ネットワークに接続できない場合は、Tailscale の管理コンソールでデバイスを削除してください';
  }

  @override
  String tailscaleNetworkInUse(Object name, Object profile) {
    return '$name はプロファイル「$profile」のルールまたはグループでまだ使われています';
  }

  @override
  String get tailscaleGuideGetStarted => 'はじめに';

  @override
  String get tailscaleGuideGetStartedBody =>
      'ネットワークを追加して「保存してログイン」を選び、ログインページでこのデバイスを承認すると自動でログインが完了します\n認証キーでログインする場合は「認証キー」を選んでキーを入力します。ブラウザは不要です\nネットワークはプロキシの実行中のみ使えます。ログインしただけでは通信は経由しません';

  @override
  String get tailscaleGuideDevices => 'デバイスと MagicDNS';

  @override
  String get tailscaleGuideDevicesBody =>
      '自動ルーティングは既知のピアのアドレスと MagicDNS 名、および Tailnet で承認済みのサブネットをこのネットワークに送ります。その他の通信はルールに従います\n自動ルーティングは追加したルールとカスタムルールの後、プロファイル自身のルールの前に適用されます\n独自ドメインのコントロールサーバーでは既知のデバイス名だけを経由させるため、そのドメインの公開サイトには影響しません\nこのデバイスが接続しているローカルネットワーク内のサブネットアドレスはローカルのままです。同じアドレスのリモートサブネットにアクセスするには、このネットワークを指すルールを追加してください\n承認済みサブネットに解決されるドメインもこのネットワークを経由します。プロファイルがそのドメインを直接プロキシに渡す場合は、このネットワークを指すドメインルールを追加してください';

  @override
  String get tailscaleGuideExitNodes => '出口ノード';

  @override
  String get tailscaleGuideExitNodesBody =>
      '出口ノードを設定すると、このネットワークがプロファイルの選択グループに表示されます。グループで選択するかルールで指定した通信だけが出口ノード経由になります\n空欄の場合は出口ノードを使用しません。auto は利用可能な出口ノードを選び、デバイス名やアドレスを指定するとそのデバイスを使います';

  @override
  String get tailscaleGuideSignIn => 'ログインとバックアップ';

  @override
  String get tailscaleGuideSignInBody =>
      'ネットワーク設定はバックアップに含まれます。認証キーとデバイスの識別情報はこのデバイスにのみ残るため、別のデバイスで復元した後は再ログインが必要です\nノードキーの有効期限が切れたら、もう一度「保存してログイン」を選んでください。デバイスの承認とアクセス権は Tailnet で管理します\nネットワークを削除すると、このデバイスはログアウトし、このデバイス上の識別情報が削除されます';

  @override
  String get tailscaleGuideTroubleshooting => 'トラブルシューティング';

  @override
  String get tailscaleGuideTroubleshootingBody =>
      'プロキシが実行中か、このデバイスが承認済みか、ピアがオンラインかを確認してください。サブネットやインターネットにアクセスする場合は、ルートの承認状態と出口ノードも確認してください\n「未適用」は実行中の設定にこのネットワークが含まれていないことを示します。プロファイルを選択し、同じ名前のノードがないことを確認してください\nこのアプリは Tailnet へ接続するだけで、Tailnet からの着信接続は受け付けず、このデバイスをサブネットルーターや出口ノードとして公開しません';

  @override
  String get tailscaleNameInvalid => '64 文字以内で、カンマは使えません';

  @override
  String get tailscaleHostnameInvalid => '小文字、数字、ハイフンのみ、63 文字以内';

  @override
  String get tailscaleAuthKeyInvalid => '認証キーの形式が正しくありません';

  @override
  String get tailscaleDirect => '直接接続';

  @override
  String tailscaleRelay(Object region) {
    return 'リレー $region';
  }

  @override
  String get tailscaleExitNodeActive => '使用中の出口ノード';

  @override
  String get quickAdd => 'クイック追加';

  @override
  String get rulePresetBlockQuic => 'QUIC をブロック';

  @override
  String get rulePresetBlockStun => 'STUN をブロック';

  @override
  String get rulePresetBlockDot => 'DNS over TLS をブロック';

  @override
  String get rulePresetBlockLoopback => 'プロキシのループバックを防止';

  @override
  String get rulePresetLanDirect => 'LAN 直接接続';

  @override
  String get rulePresetSystemServicesDirect => 'Apple と Microsoft に直接接続';

  @override
  String get rulePresetBittorrentDirect => 'BitTorrent を直接接続';

  @override
  String get rulePresetInsertHint =>
      '選択したプリセットを既存のルールの前に追加します。同じルールは重複して追加しません。';

  @override
  String get overwriteIssueEmptyName => '名前が空です';

  @override
  String overwriteIssueReservedName(Object name) {
    return '$name は組み込みポリシー名のため使用できません';
  }

  @override
  String overwriteIssueDuplicateName(Object name) {
    return '名前 $name は他のプロキシまたはプロキシグループで使用されています';
  }

  @override
  String get overwriteIssueNoProxySource =>
      'プロキシもプロキシプロバイダーも選択されていないため、コアはこのグループを拒否します';

  @override
  String overwriteIssueMissingProxies(Object names) {
    return '次のプロキシまたはポリシーは存在しません：$names';
  }

  @override
  String overwriteIssueMissingProviders(Object names) {
    return '次のプロキシプロバイダーは存在しません：$names';
  }

  @override
  String overwriteIssueEmptyFallback(Object name) {
    return '空のグループのフォールバックには、プロキシグループではなく、既存のノードまたは組み込みアウトバウンドを指定してください：$name';
  }

  @override
  String overwriteIssueGroupLoop(Object path) {
    return 'プロキシグループが循環参照しています：$path';
  }

  @override
  String invalidPolicy(Object target) {
    return '$target は無効なポリシーです';
  }

  @override
  String invalidRuleSet(Object ruleSet) {
    return '$ruleSet は無効なルールセットです';
  }

  @override
  String invalidSubRule(Object subRule) {
    return '$subRule は無効な SUB_RULE です';
  }

  @override
  String get safeMode => 'セーフモード';

  @override
  String safeModeAppTitle(Object appName) {
    return '$appName（セーフモード）';
  }

  @override
  String get hideTimeoutProxies => '測定に失敗したノードを非表示';

  @override
  String get delayTestQueued => '待機中';

  @override
  String get delayTestRunning => '測定中';

  @override
  String get dnsQueries => 'DNS クエリ';

  @override
  String get dnsQueriesDesc => '最新 500 件の名前解決クエリを表示';

  @override
  String get dnsQueryCached => 'キャッシュ';

  @override
  String get dnsQueryUpstream => '上流リゾルバー';

  @override
  String get dnsQueryAnswers => '応答';

  @override
  String get dnsQueryRcode => '応答コード';

  @override
  String get dnsQueryType => 'クエリの種類';

  @override
  String get pauseUpdates => '更新を一時停止';

  @override
  String get resumeUpdates => '更新を再開';

  @override
  String get dnsQueryAll => 'すべてのクエリ';

  @override
  String get dnsQueryFailures => '失敗したクエリ';

  @override
  String get dnsQueryInitiatorApp => 'アプリ';

  @override
  String get dnsQueryInitiatorRule => 'ルール判定';

  @override
  String get dnsQueryInitiatorDirect => '直接接続';

  @override
  String get dnsQueryInitiatorProxy => 'プロキシ接続';

  @override
  String get dnsQueryInitiatorOther => 'その他';

  @override
  String get action_ruleMode => 'ルールモード';

  @override
  String get action_globalMode => 'グローバルモード';

  @override
  String get action_directMode => '直接接続モード';

  @override
  String get action_delayTest => 'ノード遅延を測定';

  @override
  String get action_updateProfiles => 'プロファイルを更新';

  @override
  String get action_copyEnv => 'プロキシ環境変数をコピー';

  @override
  String get action_exit => '終了';

  @override
  String get hotkeyUnavailable => 'ショートカットを登録できません';

  @override
  String get runTime => '稼働時間';

  @override
  String get floatingNavigationBar => 'フローティングナビゲーション';

  @override
  String get localNetworkTip =>
      'ローカルネットワークへのアクセスが許可されていないため、今回は gVisor を使用します。LAN 上のプロキシやサービスは引き続き利用できない場合があります';

  @override
  String get sidebar => 'サイドバー';

  @override
  String get backgroundBlur => '背景のぼかし';

  @override
  String get sidebarBlurDesc => '背景のぼかしでは、ウィンドウの背後のデスクトップがサイドバー越しに見えます';

  @override
  String get format => '形式';

  @override
  String get behavior => '動作';

  @override
  String get appProviderLibrary => 'プロバイダーライブラリ';

  @override
  String get providerLocal => 'ローカルファイル';

  @override
  String get providerRemote => 'リモート URL';

  @override
  String get providerContent => 'リソースの内容';

  @override
  String get providerContentInvalid => 'リソースの内容または形式が無効です';

  @override
  String get providerContentTooLarge => 'リソースが 32 MiB を超えています';

  @override
  String get providerChanged => '編集中にリソースが変更されました。開き直してください';

  @override
  String get providerNameInvalid => '空でなく、カンマや改行を含まない名前を入力してください';

  @override
  String providerInUse(String profiles) {
    return 'このリソースは $profiles で使用中です';
  }

  @override
  String providerRenameShadowed(String profiles) {
    return '名前の変更で $profiles の参照先が変わります';
  }

  @override
  String get providerUrlTip => '認証情報を含まない HTTP または HTTPS URL を入力してください';

  @override
  String providerSourceReference(String profiles) {
    return '名前を変更する前に元のプロファイルの参照を編集してください：$profiles';
  }

  @override
  String providerSourceUnavailable(String profiles) {
    return '参照の確認に必要なプロファイルを読み取れません：$profiles';
  }

  @override
  String get nodeDefinition => 'ノード定義';

  @override
  String get nodeQuickFields => '簡易編集';

  @override
  String get nodeCoreValidationUnavailable => 'ノードの検証前に Core を起動してください';

  @override
  String get nodeInvalidDefinition => 'name と type を含む完全なノード定義を1つ入力してください';

  @override
  String get releaseMemory => 'メモリを解放';

  @override
  String get memoryCoreHeapInuse => '使用中のヒープ';

  @override
  String get memoryCoreHeapIdle => '未使用のヒープ';

  @override
  String get memoryCoreStack => 'ゴルーチンスタック';

  @override
  String get memoryCoreRuntime => 'ランタイムのオーバーヘッド';

  @override
  String get memoryCoreNotRunning => 'コアは実行されていません';

  @override
  String get memoryAppResident => '常駐メモリ';

  @override
  String get memoryAppShared => 'アプリと共有';

  @override
  String get memoryEstimateDesc => 'プロセスの常駐メモリからの推定値で、システムの表示とは異なる場合があります。';

  @override
  String get memoryEstimateSharedDesc =>
      'コアはアプリと同じプロセスで動作します。コア分はランタイム統計から推定し、残りはアプリと共有メモリとして計上します。';

  @override
  String get memoryReleased => 'メモリを解放しました';

  @override
  String memoryReleasedSize(Object size) {
    return '$size を解放しました';
  }

  @override
  String get releaseMemoryFailed => 'メモリの解放に失敗しました';

  @override
  String get total => '合計';

  @override
  String get showNotificationStopAction => '通知に停止ボタンを表示';

  @override
  String get interfaceName => 'インターフェース名';

  @override
  String get interfaceNameMode => 'アウトバウンドインターフェース';

  @override
  String get interfaceNameDesc => 'インターフェース名は、アウトバウンド接続に使用するネットワークインターフェースです';

  @override
  String get interfaceFollowProfile => 'プロファイルに従う';

  @override
  String get interfaceAutomatic => '指定を解除（自動選択）';

  @override
  String get hideIp => 'IP を隠す';

  @override
  String get cameraPermissionRequired => 'カメラの権限が必要です';

  @override
  String get cameraPermissionDesc =>
      'QRコードをスキャンするには、システム設定でカメラへのアクセスを許可するか、アルバムからQRコード画像を選択してください。';

  @override
  String get cameraUnavailable => 'カメラを使用できません';

  @override
  String get invalidProfileQrcode => 'このQRコードにはプロファイルのリンクが含まれていません';

  @override
  String get pickFromAlbum => 'アルバムから選択';

  @override
  String get retry => '再試行';

  @override
  String get toggleFlashlight => 'ライト切替';

  @override
  String get networkTimeoutError =>
      'リクエストがタイムアウトしました。ネットワークまたはプロキシを確認してから再試行してください';

  @override
  String get networkHostLookupError =>
      'サーバーのアドレスを解決できませんでした。URL が正しいこと、DNS が使えることを確認してください';

  @override
  String get monochromeIcon => 'モノクロームアイコン';

  @override
  String get networkConnectionError =>
      'サーバーに接続できませんでした。ネットワーク接続またはプロキシ設定を確認してください';

  @override
  String get networkTlsError => '安全な接続に失敗しました。サーバー証明書が無効か、接続が傍受されている可能性があります';

  @override
  String get networkCancelledError => 'リクエストはキャンセルされました';

  @override
  String networkAccessDeniedError(Object code) {
    return 'サーバーがアクセスを拒否しました（HTTP $code）。リンクの期限切れか、認証情報が誤っている可能性があります';
  }

  @override
  String networkNotFoundError(Object code) {
    return 'このアドレスには何も見つかりませんでした（HTTP $code）。URL が正しいか確認してください';
  }

  @override
  String get networkRateLimitedError =>
      'リクエストが多すぎます（HTTP 429）。しばらく待ってから再試行してください';

  @override
  String networkServerError(Object code) {
    return 'サーバーで問題が発生しました（HTTP $code）。しばらくしてから再試行してください';
  }

  @override
  String networkBadResponseError(Object code) {
    return 'サーバーがリクエストを拒否しました（HTTP $code）';
  }

  @override
  String get clipboardWriteFailed => 'クリップボードにコピーできませんでした。選択範囲が大きすぎる可能性があります';

  @override
  String get lineWrap => '折り返し';

  @override
  String get previousMatch => '前の一致';

  @override
  String get nextMatch => '次の一致';

  @override
  String get editorUnavailable => 'エディターを利用できません';

  @override
  String get replaceAll => 'すべて置換';

  @override
  String get fontSize => 'サイズ';

  @override
  String get replace => '置換';

  @override
  String get locateSelected => '選択中のノードへ移動';

  @override
  String get expandList => '展開';

  @override
  String get collapseList => '折りたたむ';

  @override
  String get clearSearch => '検索をクリア';

  @override
  String get closeAllConnections => 'すべての接続を閉じる';

  @override
  String get showMore => '展開';

  @override
  String get showLess => '折りたたむ';

  @override
  String get showPassword => 'パスワードを表示';

  @override
  String get hidePassword => 'パスワードを隠す';

  @override
  String get switchProfile => 'プロファイルを切り替え';

  @override
  String get subscriptionInfo => 'サブスクリプション情報';

  @override
  String get lastUpdated => '最終更新';

  @override
  String proxiesCount(num count) {
    return 'プロキシ $count 件';
  }

  @override
  String rulesCount(num count) {
    return 'ルール $count 件';
  }

  @override
  String get back => '戻る';

  @override
  String get noSearchResults => '一致する結果はありません';

  @override
  String get proxyNode => 'プロキシノード';

  @override
  String get rules => 'ルール';

  @override
  String get addOverrideEntry => '上書き項目を追加';

  @override
  String get batchAdd => '一括追加';

  @override
  String get batchListInputTip => '1行に1項目、またはカンマ区切りで入力してください';

  @override
  String get batchMapInputTip => '1行に1件、キーと値はスペースで区切ってください';

  @override
  String batchPreviewTip(Object count, Object skipped) {
    return '$count件を追加、$skipped件は既存のためスキップ';
  }

  @override
  String get cacheAlgorithm => 'キャッシュアルゴリズム';

  @override
  String get cacheMaxSize => 'キャッシュサイズ';

  @override
  String get dialerProxy => 'ダイヤラープロキシ';

  @override
  String get dialerProxyDesc => 'ダイヤラープロキシは NTP サーバーへの接続に使用するアウトバウンドです';

  @override
  String dialerProxyLoopStopped(Object name) {
    return '$name 経由の接続が使用元のプロキシに戻るため、接続を中止しました';
  }

  @override
  String get discardChanges => '変更を破棄しますか？';

  @override
  String get fakeipFilterMode => 'Fake-IPフィルターモード';

  @override
  String get fakeipFilterModeDesc =>
      'Fake-IP フィルターモードでは、blacklist は一致を除外、whitelist は一致のみ、rule はルールで判定します';

  @override
  String get fakeipRange6 => 'Fake-IP範囲（IPv6）';

  @override
  String get fakeipTtl => 'Fake-IP TTL';

  @override
  String get ipv6Timeout => 'IPv6タイムアウト（ms）';

  @override
  String lineIssueTip(Object line, Object message) {
    return '$line行目：$message';
  }

  @override
  String get listenRoutingMark => 'リッスンのルーティングマーク';

  @override
  String get listenRoutingMarkDesc => 'リッスンのルーティングマークは Linux でのみ有効です';

  @override
  String maxLengthTip(Object label, Object max) {
    return '$labelは最大$max文字です';
  }

  @override
  String get ntpInterval => '同期間隔（分）';

  @override
  String get ntpStatusDesc => 'NTP を有効にすると、システムクロックではなく NTP サーバーから時刻を取得します';

  @override
  String get overrideEntries => '上書き項目';

  @override
  String get quickEdit => 'クイック編集';

  @override
  String get server => 'サーバー';

  @override
  String get singleAdd => '個別追加';

  @override
  String singleValueTip(Object label) {
    return '$labelは1項目のみ指定できます';
  }

  @override
  String get writeToSystem => 'システムに書き込む';

  @override
  String get writeToSystemDesc =>
      'システムに書き込むを有効にするとシステムクロックも設定します。Android では無視されます';

  @override
  String get basicInfo => '基本情報';

  @override
  String get ruleActionIpSuffixDesc => 'IPサフィックス範囲にマッチ';

  @override
  String get ruleActionDomainSuffixDesc => 'ドメインサフィックスにマッチ';

  @override
  String get ruleActionMatchDesc => 'すべてのリクエストにマッチ（条件不要）';

  @override
  String get ruleActionSrcGeoipDesc => '送信元IPの国コードにマッチ';

  @override
  String get ruleActionDomainWildcardDesc => 'ワイルドカードでマッチ（* と ? のみ対応）';

  @override
  String get ruleActionAndDesc => '論理ルール AND';

  @override
  String get ruleActionIpCidr6Desc => 'IPアドレス範囲にマッチ（IP-CIDR6 は別名です）';

  @override
  String get ruleActionDomainRegexDesc => 'ドメインの正規表現でマッチ';

  @override
  String get ruleActionProcessPathRegexDesc => 'プロセスパスの正規表現でマッチ';

  @override
  String get ruleActionDstPortDesc => '宛先ポート範囲にマッチ';

  @override
  String get ruleActionDscpDesc => 'DSCPマークにマッチ（tproxy udpインバウンドのみ）';

  @override
  String get ruleActionInPortDesc => 'インバウンドポートにマッチ';

  @override
  String get ruleActionUidDesc => 'LinuxのユーザーIDにマッチ';

  @override
  String get ruleActionIpCidrDesc => 'IPアドレス範囲にマッチ';

  @override
  String get ruleActionRuleSetDesc => 'ルールセットを参照します。rule-providersの設定が必要です';

  @override
  String get ruleActionGeositeDesc => 'Geosite 内のドメインにマッチ';

  @override
  String get ruleActionNetworkDesc => 'TCPまたはUDPにマッチ';

  @override
  String get ruleActionProcessPathDesc => 'プロセスのフルパスでマッチ';

  @override
  String get ruleActionProcessPathWildcardDesc =>
      'プロセスパスのワイルドカードでマッチ（* と ? のみ対応）';

  @override
  String get ruleActionRematchNameDesc => '再マッチ名にマッチ（複数は / で区切る）';

  @override
  String get ruleActionSrcIpSuffixDesc => '送信元IPサフィックス範囲にマッチ';

  @override
  String get ruleActionGeoipDesc => 'IPの国コードにマッチ';

  @override
  String get ruleActionInUserDesc => 'インバウンドユーザー名にマッチ（/ で複数指定可）';

  @override
  String get invalidNetworkContent => 'tcp または udp のみ対応しています';

  @override
  String get ruleActionDomainKeywordDesc => 'ドメインキーワードにマッチ';

  @override
  String get ruleActionNotDesc => '論理ルール NOT';

  @override
  String get ruleActionSrcIpAsnDesc => '送信元IPが属するASNにマッチ';

  @override
  String get invalidRangeContent =>
      '80 や 8000-9000 のような数値または範囲を / 区切りで入力してください';

  @override
  String get ruleActionProcessNameRegexDesc =>
      'プロセス名の正規表現でマッチ（Androidではパッケージ名にマッチ）';

  @override
  String get ruleActionSrcIpCidrDesc => '送信元IPアドレス範囲にマッチ';

  @override
  String get ruleActionDomainDesc => '完全なドメインにマッチ';

  @override
  String get ruleActionInNameDesc => 'インバウンド名にマッチ';

  @override
  String get invalidDscpContent => 'DSCP マークは 63 を超えられません';

  @override
  String get invalidCidrContent =>
      '192.168.0.0/16 のような CIDR 形式の IP 範囲を入力してください';

  @override
  String get invalidIpv6CidrContent =>
      'fd00::/8 のような CIDR 形式の IPv6 範囲を入力してください';

  @override
  String get invalidHostContent => 'ドメインまたは IP アドレスを入力してください';

  @override
  String get invalidListenContent => '0.0.0.0:1053 のようなアドレスとポートを入力してください';

  @override
  String get ruleActionIpAsnDesc => 'IPが属するASNにマッチ';

  @override
  String get ruleActionSrcPortDesc => '送信元ポート範囲にマッチ';

  @override
  String get ruleActionInTypeDesc => 'インバウンドタイプにマッチ';

  @override
  String get ruleActionOrDesc => '論理ルール OR';

  @override
  String get ruleActionSubRuleDesc => 'サブルールへマッチします。括弧の使い方に注意してください';

  @override
  String get ruleActionProcessNameWildcardDesc =>
      'プロセス名のワイルドカードでマッチ（* と ? のみ対応）';

  @override
  String get ruleActionProcessNameDesc => 'プロセス名でマッチ（Androidではパッケージ名にマッチ）';

  @override
  String get general => '一般';

  @override
  String get startupAndBackground => '起動とバックグラウンド';

  @override
  String get inbound => 'インバウンド';

  @override
  String get outbound => 'アウトバウンド';

  @override
  String get logsAndDiagnostics => 'ログと診断';

  @override
  String get onDemand => 'オンデマンド';

  @override
  String get onDemandDesc => 'オンデマンドは、Wi-Fi やネットワークの条件に応じてプロキシを自動で停止・再開します';

  @override
  String get prerequisites => '前提条件';

  @override
  String get suspended => '一時停止中…';

  @override
  String get enabled => '有効';

  @override
  String get enabledOnStart => '起動時に有効';

  @override
  String get disabled => '無効';

  @override
  String overwriteIssuesSummary(Object count) {
    return '$count 件に問題があり、上書きの適用に失敗する可能性があります';
  }

  @override
  String get ignoreBatteryOptimization => '電池の最適化を無視';

  @override
  String get batteryOptimizationDesc => '電池の最適化を無視すると、アプリがバックグラウンドで動作し続けます';

  @override
  String get batteryOptimizationStatusTip =>
      'システムの制限により、実行中は電池の最適化の状態を正しく取得できません';

  @override
  String get authorized => '許可済み';

  @override
  String get tapToAuthorize => 'タップして許可';

  @override
  String get addSsid => 'SSIDを追加';

  @override
  String get editSsid => 'SSIDを編集';

  @override
  String get ssidsEmpty => 'SSIDが空です';

  @override
  String get hotkeyDesc =>
      'グローバルホットキーはウィンドウが非表示でも有効です。アクションをタップしてキーの組み合わせを記録します。';

  @override
  String get hotkeyNotSet => '未設定';

  @override
  String hotkeyNeedsModifier(Object modifiers) {
    return '$modifiers のいずれかを含めてください';
  }

  @override
  String hotkeyConflictWith(Object action) {
    return '「$action」で使用中です。保存するとこちらに移動します。';
  }

  @override
  String get confirmExitWindow => '現在のウィンドウを閉じてもよろしいですか？';

  @override
  String get dataChangedSave => 'データの変更を検出しました。保存しますか？';

  @override
  String get discard => '破棄';

  @override
  String get docked => '固定';

  @override
  String get fade => 'フェード';

  @override
  String get floating => 'フローティング';

  @override
  String get followSystem => 'システムに従う';

  @override
  String get navigationBarStyle => 'ボトムバー';

  @override
  String get pureBlack => 'ピュアブラック';

  @override
  String get slide => 'スライド';

  @override
  String get textScalePreview => 'アプリ内の文字はこの大きさで表示されます';

  @override
  String get basicStrategy => '基本ポリシー';

  @override
  String get nonTextProviderFile => 'この外部リソースはテキストファイルではありません';

  @override
  String get scriptChanged => 'スクリプトが変更または削除されました。開き直して再試行してください。';

  @override
  String get startFromScratch => '最初から作成';

  @override
  String get optional => '任意';

  @override
  String get coreBlockedBySmartAppControlTip =>
      'Windows が FlClashCore.exe をブロックし、スマート アプリ コントロールが有効になっています。Windows セキュリティ → アプリとブラウザーの制御で詳細を確認し、信頼できる検証済みのリリースを使用してください';

  @override
  String get helperCorruptTip =>
      'Helper サービスが利用できないため、TUN モードを有効にできません。FlClash を再インストールしてください。';

  @override
  String get changeProxyFailedTip => 'プロキシの切り替えに失敗したため、前回の選択に戻しました';

  @override
  String get databaseWriteFailedTip => '変更を保存できませんでした。現在の値を確認して再試行してください';

  @override
  String get proxyType => 'ノードの種類';

  @override
  String get providerSourceSubscription => 'サブスクリプション';

  @override
  String get providerSourceProfile => 'プロファイル';

  @override
  String get providerSourceApp => 'アプリライブラリ';

  @override
  String get target => '宛先';

  @override
  String get outboundExit => '出口';

  @override
  String get protocol => 'プロトコル';

  @override
  String get traffic => '通信量';

  @override
  String get totalDownload => 'ダウンロード量';

  @override
  String get totalUpload => 'アップロード量';

  @override
  String get duration => '経過時間';

  @override
  String get initiatorShort => '発信元';

  @override
  String get result => '結果';

  @override
  String get elapsed => '所要時間';

  @override
  String get tunOverrideDesc =>
      'ここで追加した項目は、すべてのプロファイルの TUN 設定を上書きします。追加していない項目はプロファイル自身の設定のままです。カスタムプロファイル自身が追加した項目が優先されます';

  @override
  String get dnsOverrideDesc =>
      'ここで追加した項目は、すべてのプロファイルの DNS 設定を上書きします。追加していない項目はプロファイル自身の設定のままです。カスタムプロファイル自身が追加した項目が優先されます';

  @override
  String get ntpOverrideDesc =>
      'ここで追加した項目は、すべてのプロファイルの NTP 設定を上書きします。追加していない項目はプロファイル自身の設定のままです。カスタムプロファイル自身が追加した項目が優先されます';

  @override
  String get congestionController => 'TCP 輻輳制御';

  @override
  String get congestionControllerDesc => 'TCP 輻輳制御は mips スタックでのみ有効です';

  @override
  String get strictRoute => '厳格なルーティング';

  @override
  String get strictRouteDesc =>
      '厳格なルーティングは DNS などの通信が TUN を迂回するのを防ぎます。IPv6 がオフの場合、この端末の IPv6 通信は遮断されます';

  @override
  String get routeExcludeAddress => 'ルート除外アドレス';

  @override
  String get udpTimeout => 'UDP タイムアウト';

  @override
  String get udpTimeoutDesc =>
      'UDP タイムアウトは秒単位で、gvisor・system・mixed スタックでのみ有効です';

  @override
  String get dnsHijackDesc =>
      '追加しない場合、ポート 53 宛てのすべての DNS 問い合わせをハイジャックします（any:53）';

  @override
  String get disableIcmpForwarding => 'ICMP 転送を無効化';

  @override
  String get disableIcmpForwardingDesc =>
      'ICMP 転送を無効にすると TUN が ping に直接応答するため、ping に実際の遅延が表示されなくなります';

  @override
  String get includeInterface => '対象インターフェース';

  @override
  String get includeInterfaceDesc =>
      '対象インターフェースから入る通信だけが TUN を通り、除外インターフェースは無効になります';

  @override
  String get excludeInterface => '除外インターフェース';

  @override
  String get excludeInterfaceDesc => 'docker0 などの除外インターフェースから入る通信は TUN を通りません';

  @override
  String get includeUid => '対象ユーザー ID';

  @override
  String get includeUidDesc => '対象ユーザー ID のプロセスの通信だけが TUN を通ります';

  @override
  String get excludeUid => '除外ユーザー ID';

  @override
  String get excludeUidDesc => '除外ユーザー ID のプロセスの通信は TUN を通りません';

  @override
  String get excludeSrcPort => '除外送信元ポート';

  @override
  String get excludeSrcPortDesc => '除外送信元ポートからの通信は TUN を通りません';

  @override
  String get excludeDstPort => '除外宛先ポート';

  @override
  String get excludeDstPortDesc => '除外宛先ポートへの通信は TUN を通りません';

  @override
  String numberRangeTip(Object label, Object min, Object max) {
    return '$labelは$minから$maxの範囲で指定してください';
  }

  @override
  String get customProfile => 'カスタムプロファイル';

  @override
  String get customProfileDesc =>
      '自分のノード、プロバイダーライブラリ、他のプロファイルからプロキシグループとルールを組み立てます';

  @override
  String get emptyCustomProfile => 'このカスタムプロファイルに先にプロキシグループかルールを追加してください';

  @override
  String get nameCustomProfileTip => 'このカスタムプロファイルに名前を付けてください';

  @override
  String profileProviderInUse(Object profiles) {
    return 'このプロファイルは $profiles のプロキシプロバイダーです。先にそちらから外してください';
  }

  @override
  String get healthCheck => 'ヘルスチェック';

  @override
  String get additionalPrefix => '名前のプレフィックス';

  @override
  String get additionalSuffix => '名前のサフィックス';

  @override
  String get ipVersion => 'IP バージョン';

  @override
  String get profileSettingsDesc => 'このプロファイルにのみ適用されます。追加していない項目はデフォルト値を使用します';

  @override
  String get profileOverrideSettingsDesc =>
      'このプロファイルにのみ適用され、アプリの DNS・NTP 設定の上書き項目より優先されます。追加していない項目はそれらの上書き項目に従います';

  @override
  String get profileTunSettingsDesc =>
      'このプロファイルにのみ適用され、ネットワーク設定の TUN 上書き項目より優先されます';

  @override
  String get settingEntries => '設定項目';

  @override
  String get addSettingEntry => '設定項目を追加';

  @override
  String settingsCount(num count) {
    return '設定 $count 件';
  }

  @override
  String get sniffer => 'スニッファー';

  @override
  String get snifferStatusDesc =>
      'スニッファーは TLS・HTTP・QUIC の通信からドメインを読み取り、ルールで照合できるようにします';

  @override
  String get overrideDestination => '宛先を上書き';

  @override
  String get overrideDestinationDesc => '宛先を上書きすると、元のアドレスではなく検出したドメインに接続します';

  @override
  String get forceDnsMapping => 'DNSマッピングを強制';

  @override
  String get forceDnsMappingDesc =>
      'DNS マッピングを強制すると、DNS マッピングでドメインを得た接続もスニッフィングします';

  @override
  String get parsePureIp => '純粋なIPを解析';

  @override
  String get parsePureIpDesc => '純粋な IP を解析すると、IP アドレスしかない接続をスニッフィングします';

  @override
  String get forceDomain => '強制するドメイン';

  @override
  String get forceDomainDesc => '強制するドメインもスニッフィングします。ドメインを持つその他の接続は対象外です';

  @override
  String get skipDomain => 'スキップするドメイン';

  @override
  String get skipDomainDesc => 'スキップするドメインにあるドメインを検出しても使用しません';

  @override
  String get skipSrcAddress => 'スキップする送信元アドレス';

  @override
  String get skipDstAddress => 'スキップする宛先アドレス';

  @override
  String get sniffProtocols => 'プロトコル';

  @override
  String get ports => 'ポート';

  @override
  String get invalidPortRangeContent => '443 や 8000-9000 のようなポートまたは範囲を入力してください';

  @override
  String get importConfig => '設定をインポート';

  @override
  String get importText => 'テキストからインポート';

  @override
  String get importConfigInvalid => 'インポートできる設定ではありません';

  @override
  String get importConfigReplaceTip =>
      'インポートすると、このプロファイルの現在のノード、プロキシグループ、ルール、設定が置き換えられます';

  @override
  String get customImportCloudRefused => 'oixCloud のアドレスはカスタムプロファイルにインポートできません';

  @override
  String get customImportNotImported => 'インポートされなかった項目';

  @override
  String customImportDroppedSubRules(num count) {
    return 'カスタムプロファイルはサブルールに対応していないため、SUB-RULE ルール $count 件を破棄しました';
  }

  @override
  String customImportUnnamedProxies(num count) {
    return '名前または種類のないプロキシ $count 件';
  }

  @override
  String failedItem(Object label, Object message) {
    return '$label：$message';
  }

  @override
  String shareLinkNodesAdded(num count) {
    return '共有リンクからノードを $count 件追加しました';
  }

  @override
  String shareLinksNotRead(num count) {
    return '$count 件のリンクを読み取れませんでした';
  }

  @override
  String get connectionStats => '接続統計';

  @override
  String get connectionStatsDesc => 'ライブ接続、最近のリクエスト、DNS クエリ';

  @override
  String get currentOutboundDesc => '起動ボタンがあるため削除できません';

  @override
  String get dashboardAddableSection => '追加できるカード';

  @override
  String get dashboardReorderHint => 'カードをドラッグして並べ替えます。タッチ操作では先に長押ししてください';

  @override
  String get done => '完了';

  @override
  String get editDashboard => 'ダッシュボードを編集';

  @override
  String groupCount(num count) {
    return '$count 個';
  }

  @override
  String get groupCountUnit => '個';

  @override
  String groupTimeoutCount(Object count) {
    return '$count 件タイムアウト';
  }

  @override
  String get ipType => 'タイプ';

  @override
  String get liveConnections => 'リアルタイム接続';

  @override
  String get memoryInfoDesc => 'アプリとコアが使用するメモリ';

  @override
  String get networkTakeover => 'トラフィックの引き継ぎ';

  @override
  String get notRunning => '停止中';

  @override
  String portValue(Object port) {
    return 'ポート $port';
  }

  @override
  String profileDaysLeft(num days) {
    return '残り $days 日';
  }

  @override
  String profileExpiresIn(Object date, num days) {
    return '$date に期限切れ、残り $days 日';
  }

  @override
  String profileUpdatedAt(Object time) {
    return '$timeに更新';
  }

  @override
  String get proxyGroupsAfterStart => '起動するとここにグループが表示されます';

  @override
  String get running => '実行中';

  @override
  String get serviceFailed => '検出に失敗しました';

  @override
  String get tapIconToRetry => 'アイコンをタップして再試行';

  @override
  String trafficPeak(Object value) {
    return 'ピーク $value';
  }

  @override
  String trafficTotal(Object value) {
    return '累計 $value';
  }

  @override
  String get usedShort => '使用済み';

  @override
  String get disableKeepAlive => 'TCP キープアライブを無効化';

  @override
  String get keepAliveIdle => 'TCP キープアライブ待機時間';

  @override
  String get routingMark => 'ルーティングマーク';

  @override
  String get minutes => '分';

  @override
  String yearsAgoShort(num count) {
    return '$count 年前';
  }

  @override
  String monthsAgoShort(num count) {
    return '$count か月前';
  }

  @override
  String daysAgoShort(num count) {
    return '$count 日前';
  }

  @override
  String hoursAgoShort(num count) {
    return '$count 時間前';
  }

  @override
  String minutesAgoShort(num count) {
    return '$count 分前';
  }

  @override
  String get expireTime => '有効期限';

  @override
  String get runtimeConfig => 'ランタイム設定';

  @override
  String proxyGroupsCount(num count) {
    return 'プロキシグループ $count 件';
  }

  @override
  String get confirmDeleteProxyGroup => 'このプロキシグループを削除してもよろしいですか？';

  @override
  String invalidProxyProvider(Object providerName) {
    return '$providerName は無効なプロキシプロバイダーです';
  }

  @override
  String customIssuesSummary(Object count) {
    return '$count 件に問題があり、プロファイルの適用に失敗する可能性があります';
  }

  @override
  String sectionsInEffect(Object count) {
    return '$count 件が有効';
  }

  @override
  String get emptyFallback => '空グループのフォールバック';

  @override
  String get testInterval => 'テスト間隔';

  @override
  String get testWhenUsed => '使用時にテスト';

  @override
  String get defaultSelected => 'デフォルトの選択';

  @override
  String get hashByInUser => 'インバウンドユーザーでハッシュ';

  @override
  String get nodes => 'ノード';

  @override
  String get addNodes => 'ノードを追加';

  @override
  String get autoInclude => '自動で含める';

  @override
  String get filters => 'フィルター';

  @override
  String get inputProxyGroupName => 'プロキシグループ名を入力してください';

  @override
  String get definitionNotMap => '設定は name と type を含む YAML マッピングである必要があります';

  @override
  String get additionalParameters => '追加パラメータ';

  @override
  String get quickActions => 'クイック操作';

  @override
  String get ruleListInvalid =>
      'ルールは 1 項目に 1 つのルールを書いた YAML リストにしてください。例：- DOMAIN,example.com,DIRECT';

  @override
  String get goToConfigureAddedRules => '追加ルール設定へ移動';

  @override
  String get large => '大';

  @override
  String get extraLarge => '特大';

  @override
  String get matchCase => '大文字と小文字を区別';

  @override
  String get regex => '正規表現';

  @override
  String get yes => 'はい';

  @override
  String get no => 'いいえ';

  @override
  String get error => 'エラー';

  @override
  String get iconSets => 'アイコンセット';

  @override
  String get localImage => 'ローカル画像';

  @override
  String get label => 'ラベル';

  @override
  String get iconSetsEmptyTip =>
      'アイコンセットはまだありません。「カスタムプロファイルのリソース → アイコンセット」で追加できます';

  @override
  String get recommendedIcons => 'おすすめ';

  @override
  String get customProfileResources => 'カスタムプロファイルのリソース';

  @override
  String get importFromLink => 'リンクからインポート';

  @override
  String get sendFromPhone => 'スマートフォンから送信';

  @override
  String get sendFromPhoneTip =>
      'スマートフォンのカメラでコードをスキャンし、開いたページにリンクを貼り付けてください。両方のデバイスを同じネットワークに接続する必要があります';

  @override
  String get sendFromPhoneNoNetwork => 'このデバイスはローカルネットワークに接続されていません';

  @override
  String get sendFromPhonePermissionDenied =>
      'スマートフォンからリンクを受け取るには、FlClash がローカルネットワークにアクセスするための「付近のデバイス」権限が必要です。アプリの設定でオンにしてください';

  @override
  String get sendFromPhonePageTitle => 'FlClash にリンクを送信';

  @override
  String get sendFromPhonePageHint => 'サブスクリプションリンクまたはプロキシ共有リンク';

  @override
  String get send => '送信';

  @override
  String get sendFromPhonePageSent => '送信しました。もう一方のデバイスでインポートを確認してください';

  @override
  String get sendFromPhoneConfirmTitle => 'スマートフォンから届いたリンクをインポートしますか？';

  @override
  String get shareQrcodeTip => '別のデバイスの FlClash でスキャンすると、このプロファイルをインポートできます';

  @override
  String get qrcodeTooLongTip => 'このリンクは長すぎて QR コードにできません。「リンクをコピー」を使ってください';

  @override
  String get invalidLinkTip => 'サブスクリプションリンクまたはプロキシの共有リンクではありません';

  @override
  String get batchLinkInputTip => '1行に1つのリンクを入力してください';

  @override
  String get link => 'リンク';

  @override
  String get allowedIps => '許可する IP';

  @override
  String get cipher => '暗号方式';

  @override
  String get clientFingerprint => 'クライアントフィンガープリント';

  @override
  String get requestHeaders => 'リクエストヘッダー';

  @override
  String transportHeaders(Object transport) {
    return '$transport リクエストヘッダー';
  }

  @override
  String get congestionControl => '輻輳制御';

  @override
  String get downloadBandwidth => 'ダウンロード帯域幅';

  @override
  String get hopInterval => 'ホップ間隔';

  @override
  String get obfs => '難読化';

  @override
  String get obfsHost => '難読化ホスト';

  @override
  String get obfsMode => '難読化モード';

  @override
  String get obfsParam => '難読化パラメータ';

  @override
  String get obfsPassword => '難読化パスワード';

  @override
  String get plugin => 'プラグイン';

  @override
  String get pluginHost => 'プラグインホスト';

  @override
  String get pluginPath => 'プラグインパス';

  @override
  String get pluginUsername => 'プラグインユーザー名';

  @override
  String get pluginPassword => 'プラグインパスワード';

  @override
  String get pluginCipher => 'プラグイン暗号方式';

  @override
  String get pluginMode => 'プラグインモード';

  @override
  String get portHopping => 'ポートホッピング';

  @override
  String get preSharedKey => '事前共有鍵';

  @override
  String get privateKey => '秘密鍵';

  @override
  String get privateKeyPassphrase => '秘密鍵のパスフレーズ';

  @override
  String get protocolParam => 'プロトコルパラメータ';

  @override
  String get protocolVersion => 'プロトコルバージョン';

  @override
  String get publicKey => '公開鍵';

  @override
  String get remoteDnsResolve => 'リモート DNS 解決';

  @override
  String get secretKey => 'キー';

  @override
  String get skipCertVerify => '証明書の検証をスキップ';

  @override
  String get transport => 'トランスポート';

  @override
  String get udpRelayMode => 'UDP リレーモード';

  @override
  String get uploadBandwidth => 'アップロード帯域幅';

  @override
  String get username => 'ユーザー名';

  @override
  String get networkName => 'ネットワーク名';

  @override
  String get networkSecret => 'ネットワークシークレット';

  @override
  String get peers => 'ピア';

  @override
  String get virtualIpv4 => '仮想 IPv4';

  @override
  String get hostname => 'ホスト名';

  @override
  String get exitNodes => '出口ノード';

  @override
  String get ageSecretKey => 'age 秘密鍵';

  @override
  String get ageSecretKeyRequiredTip =>
      'このプロファイルは age で暗号化されており、復号には age 秘密鍵が必要です';

  @override
  String get ageDecryptFailedTip => '設定を復号できませんでした。age 秘密鍵を確認して再試行してください。';

  @override
  String get resetDns => 'DNS をリセット';

  @override
  String get resetDnsSuccess => 'DNS の状態をクリアしました';

  @override
  String get resetDnsFailed => 'DNS をリセットできませんでした。コアの接続を確認して、もう一度お試しください。';

  @override
  String resourceSizeLimitTip(Object limit) {
    return 'リソースが $limit を超えています';
  }

  @override
  String get ruleSetDetect => '形式と動作を自動検出';

  @override
  String get ruleSetConvert => 'MRS に変換';

  @override
  String get ruleSetConvertRemote => 'ローカル MRS としてダウンロード';

  @override
  String get ruleSetEmptyTip => 'ルールセットに有効な項目がありません';

  @override
  String get ruleSetMixedTip =>
      'ドメイン名と IP 範囲が混在しています。併用するには classical ルールを使用してください';

  @override
  String get ruleSetInvalidTip => 'ルールセットを読み込めません。形式と項目を確認してください';

  @override
  String get ruleSetUnsupportedTip => '動作を維持したまま、このルールを MRS に変換することはできません';

  @override
  String get ruleSetBusyTip => '別のルールセット操作を実行中です。しばらくしてから再試行してください';

  @override
  String get ruleSetNeedsConversionTip =>
      'このリモートルールセットは正規化が必要です。ローカル MRS としてダウンロードしてください';

  @override
  String get ruleSetSizeTip => 'ルールセットが処理上限を超えています。分割して再試行してください';

  @override
  String get providerLookupFailed => '現在有効なノード設定を読み取れません。リソースを更新して再試行してください';

  @override
  String get lookupProxyConfig => 'ノード設定を検索';

  @override
  String get tunDnsMode => 'システム DNS モード';

  @override
  String get tunDnsModeDesc =>
      '空欄は従来の動作を維持します。disabled はシステム DNS を変更せず、native は TUN アドレスを使用します。hijack は他のインターフェースの DNS も捕捉します（Windows は strict-route、Linux は auto-redirect が必要）。macOS では明示したモードが自動 DNS 設定に優先します。';

  @override
  String get nodeShareLinkUnavailable =>
      'このノードは共有リンクに変換できません。項目または YAML で編集してください';

  @override
  String shareLinkNodesPreserved(int count) {
    return 'リンクに変換できない $count 個のノードは変更せず保持されます';
  }

  @override
  String get select => '選択';

  @override
  String get preferred => '優先';

  @override
  String get addToLocalProxies => 'カスタムノードに追加';

  @override
  String addedToLocalProxies(Object name) {
    return '$name をカスタムノードに追加しました';
  }

  @override
  String alreadyInLocalProxies(Object name) {
    return '$name はすでにカスタムノードにあります';
  }

  @override
  String get generalOverrideDesc =>
      'ここで追加した項目は、すべてのプロファイルの該当設定を上書きします。追加していない項目はプロファイル自身の設定のままで、プロファイルにない場合はコアの既定値を使います';

  @override
  String get groupBy => '分類';

  @override
  String get copyHost => 'ホストをコピー';

  @override
  String get copyDestination => '宛先をコピー';

  @override
  String get closeConnection => '接続を閉じる';

  @override
  String get recentRequests => '最近のリクエスト';

  @override
  String get root => 'Root';

  @override
  String get mitm => 'MITM';

  @override
  String get httpsDecryption => 'HTTPS 復号';

  @override
  String get httpCapture => 'HTTP キャプチャ';

  @override
  String get httpCaptureDesc =>
      'ホスト名に記載したホストへのリクエストを記録し、接続の詳細で確認できます。記録はメモリ上にのみ保持されます。';

  @override
  String get httpCaptureNoHosts =>
      'ホストが記載されていないため、何も記録されません。MITM ページの「ホスト名」または接続の詳細から追加してください。';

  @override
  String get httpCaptureLimit => '最大記録数';

  @override
  String httpCaptureLimitDesc(Object memory, Object body) {
    return 'この件数に達するか、メモリを $memory 使い切ると、古い記録から削除されます。本文は先頭の $body のみ保持されます。';
  }

  @override
  String get httpRequests => 'HTTP リクエスト';

  @override
  String get httpRequestsMissing => 'キャプチャをオンにする前のリクエストや、消去済みのリクエストは表示されません。';

  @override
  String get httpRequestCleared => 'このリクエストの記録は消去されました';

  @override
  String get httpCaptureOff => 'キャプチャはオフです';

  @override
  String get inProgress => '進行中';

  @override
  String get method => 'メソッド';

  @override
  String get originalUrl => '元の URL';

  @override
  String get timeToFirstByte => '最初のバイトまでの時間';

  @override
  String get requestBody => 'リクエストボディ';

  @override
  String get response => 'レスポンス';

  @override
  String get responseBody => 'レスポンスボディ';

  @override
  String get responseHeaders => 'レスポンスヘッダー';

  @override
  String get matchedRules => '一致したルール';

  @override
  String get overview => '概要';

  @override
  String get viewAll => 'すべて表示';

  @override
  String get copyAsBase64 => 'Base64 としてコピー';

  @override
  String get copyAsCurl => 'cURL としてコピー';

  @override
  String get copyRequest => 'リクエストをコピー';

  @override
  String get copyResponse => 'レスポンスをコピー';

  @override
  String get copyResponseBody => 'レスポンス本文をコピー';

  @override
  String get httpBodyProtobufGuess =>
      'スキーマなしで Protobuf として解析しました。フィールド番号のみで、型は推測です。';

  @override
  String get exportHar => 'HAR をエクスポート';

  @override
  String get mitmAddRejectRule => '拒否ルールを追加';

  @override
  String get mitmAddMapLocalRule => 'ローカルマップのルールを追加';

  @override
  String get httpExportPrivateTitle => 'プライベートな情報を含みます';

  @override
  String get httpExportPrivate =>
      'リクエストには Cookie、トークン、パスワード、フォームの内容が含まれることがあります。共有する内容と相手を確認してください。';

  @override
  String get mitmRuleCopiedForStash =>
      'このモジュールは Stash のオーバーライドのため、ルールをコピーしました。手動で追加してください。';

  @override
  String get binaryData => 'バイナリデータ';

  @override
  String get httpBodyNotKept => 'メモリ不足のため記録されていません。';

  @override
  String get httpBodyTruncated => 'このボディは先頭部分のみ記録されています。';

  @override
  String httpBodyUndecoded(Object encoding) {
    return '$encoding をデコードできないため、送信時のままのデータを表示しています。';
  }

  @override
  String get mitmEnableTip =>
      'オンにすると、FlClash は復号するホストに送られるすべての内容（Cookie やパスワードを含む）を読み取れます。書き換えが必要なホストに限ってオンにしてください。';

  @override
  String get generateCertificate => '証明書を生成';

  @override
  String get regenerateCertificate => '証明書を再生成';

  @override
  String get regenerateCertificateTip =>
      '新しい証明書が現在の証明書を置き換えます。FlClash は可能な場合、現在の証明書をこのデバイスの信頼されたルートから削除します。現在の証明書を信頼している他のデバイスには、新しい証明書をインストールする必要があります。';

  @override
  String get exportCertificate => '証明書をエクスポート';

  @override
  String get installCertificate => 'システムにインストール';

  @override
  String get installCertificateSuccess => '証明書をインストールしました';

  @override
  String validUntil(Object date) {
    return '有効期限 $date';
  }

  @override
  String get mitmCertificateExportTip => 'エクスポートして、復号したいデバイスで信頼してください。';

  @override
  String get mitmTrustReady => '信頼済み';

  @override
  String get mitmTrustUntrusted => '完全には信頼されていません';

  @override
  String get mitmTrustNotInstalled => '未インストール';

  @override
  String get mitmTrustChecking => '確認中…';

  @override
  String get mitmCertificateAndroidReadyTip =>
      '復号されるのはユーザー証明書を信頼するアプリ（主にブラウザ）だけです。';

  @override
  String get mitmAndroidRootDesc =>
      'root がない場合、復号できるのはユーザー証明書を信頼するアプリ（主にブラウザ）だけです。root があればすべてのアプリを復号できます';

  @override
  String get mitmCertificateLinuxTip =>
      'Flatpak 版ブラウザには、エクスポートした証明書を手動でインポートする必要があります。';

  @override
  String mitmCertutilMissing(Object command) {
    return 'Chrome と Firefox は独自の証明書ストアを使うため、certutil が必要です：$command';
  }

  @override
  String mitmMissingStores(Object stores) {
    return '未追加：$stores';
  }

  @override
  String get httpRequestsReadFailed => 'リクエストを読み取れません';

  @override
  String get requestBodyReadFailed => 'リクエストボディを読み取れません';

  @override
  String get responseBodyReadFailed => 'レスポンスボディを読み取れません';

  @override
  String mitmGrpcOverLimit(Object size) {
    return '展開すると $size MB を超えるため、圧縮データを表示しています';
  }

  @override
  String mitmUntrustedStores(Object stores) {
    return 'インストール済みですが未信頼：$stores';
  }

  @override
  String get mitmSystemStoreFailed => '証明書をシステムの信頼されたルートに追加できませんでした';

  @override
  String get mitmRootUntilReboot =>
      '証明書を保持する Magisk、KernelSU、APatch が見つかりません。端末の再起動後にもう一度インストールしてください。';

  @override
  String get mitmRootPendingReboot => '証明書は端末の再起動後に有効になります。';

  @override
  String get mitmInstallSystemCaTip =>
      'root が見つかったため、証明書は Magisk、KernelSU または APatch のモジュール「FlClash MITM CA」としてシステムの信頼できる証明書に追加されます。以後この端末のすべてのアプリが信頼し、秘密鍵を持つ人はこの端末の HTTPS 通信を復号できます。元に戻すには証明書を再生成するか、root マネージャーでモジュールを削除して再起動してください。root が拒否された場合はユーザー証明書としてインストールします。';

  @override
  String get mitmInstallUserCaTip =>
      'root が見つからないため、ユーザー証明書としてのみインストールできます。復号されるのはユーザー証明書を信頼するアプリ（主にブラウザ）だけで、他のアプリは記載したホストへの接続に失敗するため、それらのホストは記載しないでください。Android 11 以降はシステム設定で手動でインストールを完了します。';

  @override
  String mitmCertificateSavedTip(Object fileName) {
    return '$fileName を「ダウンロード」に保存しました。設定の「セキュリティ › 暗号化と認証情報 › 証明書のインストール › CA 証明書」からインストールしてください。';
  }

  @override
  String get openSettings => '設定を開く';

  @override
  String mitmRemoveOldCertificateTip(Object name) {
    return '設定の「セキュリティ › 暗号化と認証情報 › 信頼できる認証情報 › ユーザー」で古い証明書 $name を削除してから、新しい証明書をインストールしてください。';
  }

  @override
  String mitmOldCertificateLeftTip(Object name) {
    return '古い証明書 $name を削除できませんでした。信頼されたルートから手動で削除してください。';
  }

  @override
  String mitmOldSystemCertificateLeftTip(Object name) {
    return '古い証明書 $name はシステムの信頼された証明書に残っています。root マネージャーで FlClash に root を許可してから再生成するか、そこで「FlClash MITM CA」モジュールを削除して再起動してください。';
  }

  @override
  String get removeCertificate => '証明書を削除';

  @override
  String get removeCertificateSuccess => '証明書を削除しました';

  @override
  String get mitmSystemStoreRemoveFailed => '証明書をシステムの信頼されたルートから削除できませんでした';

  @override
  String get mitmRemoveInSettings => '設定で削除';

  @override
  String mitmRemoveUserCertificateTip(Object name) {
    return 'Android ではアプリがユーザー証明書を削除できません。設定の「セキュリティ › 暗号化と認証情報 › 信頼できる認証情報 › ユーザー」で $name を削除してください';
  }

  @override
  String get mitmCannotRemove => '削除できません';

  @override
  String get mitmRemoveSystemCertificateTip =>
      'この証明書は root モジュール「FlClash MITM CA」によってシステムに追加されています。root マネージャーで FlClash に root を許可してからもう一度試すか、そこでモジュールを削除して再起動してください';

  @override
  String get mitmDecryptHost => 'このホストを復号';

  @override
  String mitmDecryptHostTip(Object host) {
    return '$host をホスト名リストに追加しますか？FlClash は Cookie やパスワードを含め、このホストに送られる内容を読み取れるようになります。';
  }

  @override
  String get mitmClientRefusedCertificate =>
      'クライアントが証明書を拒否しました。証明書をインストールするか、アプリが証明書を固定している場合はこのホストを除外してください。';

  @override
  String get mitmExcludeHost => '復号から除外';

  @override
  String mitmExcludeHostTip(Object host) {
    return 'ホスト名リストの先頭に -$host を追加しますか？以後このホストは復号されません。';
  }

  @override
  String get urlRewrite => 'URL 書き換え';

  @override
  String get headerRewrite => 'ヘッダー書き換え';

  @override
  String get bodyRewrite => 'ボディ書き換え';

  @override
  String get mapLocal => 'ローカルマップ';

  @override
  String get requestBodyMock => 'リクエストボディの置き換え';

  @override
  String get clientSourceAddress => 'クライアントアドレス';

  @override
  String get skipVerifyHostname => '証明書を検証しないホスト';

  @override
  String get mitmModules => 'モジュール';

  @override
  String get mitmModule => 'モジュール';

  @override
  String get mitmModuleInvalid =>
      'Surge モジュール、Loon プラグイン、Quantumult X スニペット、Stash オーバーライドのいずれでもありません';

  @override
  String get arguments => '引数';

  @override
  String get mitmRoutingRules => 'ルーティングルール';

  @override
  String get mitmIgnoredLines => '無視された行';

  @override
  String get mitmModuleRulesDesc => 'ルーティングルールはプロファイル自身のルールより前に入ります。';

  @override
  String get mitmRequestRulesDesc =>
      'このモジュールの URL-REGEX と USER-AGENT のルールは URL 書き換えに変換され、リクエストごとに判定されます。平文の HTTP はすべてのリクエスト、HTTPS は MITM ホスト名に含まれる接続だけが対象です';

  @override
  String mitmModuleSystemTip(Object system) {
    return '$system 向けに書かれています。一部の行はこのデバイスのアプリに一致しない場合があります。';
  }

  @override
  String mitmModuleRequirementTip(Object requirement) {
    return 'このモジュールは $requirement を必要としますが、このデバイスは満たしていないため、想定どおりに動作しない場合があります';
  }

  @override
  String mitmExitModules(Object modules) {
    return 'モジュール：$modules';
  }

  @override
  String get mitmModuleRiskTitle => 'このモジュールをオンにしますか？';

  @override
  String get mitmNetworkRisk =>
      '設定の生成時に以下のネットワーク設定を変更し、FlClash で同じ項目に設定した内容より優先されます。モジュールをオフにするか削除すると元に戻ります';

  @override
  String mitmSkipVerifyRisk(Object hosts) {
    return 'オンにすると、次のホストのサーバー証明書を検証しなくなり、それらになりすましたサーバーに気付けなくなります：$hosts';
  }

  @override
  String mitmClientSourceRisk(Object addresses) {
    return '次のクライアントの通信だけを復号します：$addresses。TUN がオンのとき、この端末のアプリは TUN のアドレスから接続するため、対象外になることがあります';
  }

  @override
  String get mitmClientSourceTunTip =>
      'TUN がオンのとき、この端末のアプリの送信元は TUN のアドレスです。リストに含まれていない場合、その通信は復号されません';

  @override
  String get mitmNetworkChanges => 'ネットワーク設定';

  @override
  String mitmChangeReplace(Object values) {
    return '$values に置き換え';
  }

  @override
  String mitmChangeInsert(Object values) {
    return '先頭に $values を追加';
  }

  @override
  String mitmChangeAppend(Object values) {
    return '$values を追加';
  }

  @override
  String get mitmChangeOverridesYours => 'あなたの設定より優先されます';

  @override
  String mitmChangeReplacedBy(Object module) {
    return 'モジュール $module が優先されています';
  }

  @override
  String mitmSkipSection(Object section) {
    return '[$section] セクションには対応していません';
  }

  @override
  String get mitmSkipSetting => 'この設定には対応していません';

  @override
  String get mitmSkipScriptType => 'この種類のスクリプトには対応していません';

  @override
  String get mitmSkipRule => 'この種類のルールには対応していません';

  @override
  String get mitmSkipHttpRulePolicy =>
      'URL-REGEX と USER-AGENT のルールは REJECT 系のポリシーのみ使えます';

  @override
  String get mitmSkipFinalRule => 'モジュールのルールは先頭に入るため、最終ルールは以降のすべてのルールを隠してしまいます';

  @override
  String get mitmSkipDeviceRule => 'このルールには FlClash が読み取れないデバイスやネットワークの情報が必要です';

  @override
  String get mitmSkipRequirement => 'この行の使用条件をこのデバイスは満たしていません';

  @override
  String get mitmSkipManagedCa => 'CA 証明書は FlClash が管理しており、モジュールからは変更できません';

  @override
  String get mitmSkipProxies => 'モジュールはプロキシやプロキシグループを変更できません';

  @override
  String get mitmSkipAppOnly => '元のアプリ固有の機能で、FlClash には対応するものがありません';

  @override
  String get mitmSkipReflect => 'FlClash はパケットを送信元へ折り返せません';

  @override
  String get mitmSkipConditional => '条件付きの書き換えには対応していません';

  @override
  String get mitmSkipSkipVerifyAll => 'すべてのホストで証明書の検証を無効にすることはできません';

  @override
  String get mitmSkipRelativeData => 'この行が指すファイルは添付されていません。URL を使うか、添付してください';

  @override
  String get mitmSkipNotDownloaded => 'ファイルがまだダウンロードされていません';

  @override
  String get mitmSkipUnreadable => 'この行を読み取れません';

  @override
  String get mitmAddLocalFile => 'ローカルファイルを追加';

  @override
  String get mitmNewModule => 'モジュールを新規作成';

  @override
  String get mitmAttachments => '添付ファイル';

  @override
  String get mitmAttachmentsDesc =>
      '行は script-path=a.js のようにファイル名で添付ファイルを参照します。';

  @override
  String mitmFileTooLarge(Object size) {
    return 'ファイルが $size MB を超えています';
  }

  @override
  String get mitmSkipDisabled => '引数でオフになっています';

  @override
  String get mitmSkipEvent => 'このイベントには対応していません';

  @override
  String get mitmRunScript => '今すぐ実行';

  @override
  String get mitmScriptCron => '定期';

  @override
  String get mitmScriptEvent => 'イベント';

  @override
  String get mitmScriptGeneric => '汎用';

  @override
  String get mitmExcluded => '除外';

  @override
  String get mitmScriptNoOutput => 'スクリプトは出力なしで終了しました';

  @override
  String get mitmScriptRiskTitle => 'このモジュールのスクリプトを実行しますか？';

  @override
  String get mitmModulesTurnedOff => 'モジュールをオフにしました';

  @override
  String mitmModuleTurnedOffDesc(Object name) {
    return '$name の更新に、まだ同意していないスクリプトまたはネットワーク変更が含まれています';
  }

  @override
  String mitmModulesTurnedOffDesc(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 個のモジュールの更新に、まだ同意していないスクリプトまたはネットワーク変更が含まれています',
    );
    return '$_temp0';
  }

  @override
  String get mitmScriptRisk =>
      'スクリプトは一致したホストの通信を読み取り、変更できます。Cookie やトークンも含まれ、独自にリクエストを送ることもできます。提供元を信頼できる場合にのみオンにしてください。オンにすると、以後の更新は確認なしで反映されます';

  @override
  String get mitmModuleUnreadableRisk =>
      'モジュールファイルを読み取れないため、何が変更されるかわかりません。提供元を信頼できる場合にのみオンにしてください';

  @override
  String get skipServerCertVerify => 'サーバー証明書の検証をスキップ';

  @override
  String get http2 => 'HTTP/2';

  @override
  String get decryptUntrusted => 'ローカルで信頼されていなくても復号';

  @override
  String invalidOfCount(Object invalid, Object total) {
    return '$total 件中 $invalid 件が無効';
  }

  @override
  String failedCount(Object count) {
    return '$count 件が失敗しました。タップして表示';
  }

  @override
  String get proxyServerNameserverDesc => 'プロキシサーバーのドメイン名の解決にのみ使います。';

  @override
  String get proxyServerNameserverPolicyDesc =>
      '一致したプロキシサーバーのドメイン名は、Proxy Server Nameserver より優先してここで指定した DNS サーバーを使います。';

  @override
  String get directNameserverDesc => '直接接続する通信のドメイン名を解決します。';

  @override
  String get fakeipFilterDesc =>
      'これらのドメインには Fake-IP ではなく実際の IP を返します。whitelist モードでは、これらだけが Fake-IP を使います。';

  @override
  String get fallbackFilterGeositeDesc =>
      'これらの GeoSite カテゴリのドメインは、直接 Fallback で解決します。';

  @override
  String get fallbackFilterIpcidrDesc =>
      'Nameserver がこれらの範囲の IP を返したときは、Fallback の結果を使います。';

  @override
  String get fallbackFilterDomainDesc => 'これらのドメインは、直接 Fallback で解決します。';

  @override
  String get customResources => 'カスタム';

  @override
  String get proxyYieldsToSubscription =>
      'サブスクリプションに同名のノードがあるため、このプロファイルではそちらを使用します';

  @override
  String get delayMeasurementUnknown => '測定時刻不明';

  @override
  String delayMeasuredAt(String time) {
    return '最終測定：$time';
  }

  @override
  String get delayMeasurementStale => '古い結果です。再測定してください';

  @override
  String get diagUdp => 'UDP 接続';

  @override
  String get diagUdpReady => 'UDP 往復テストに成功';

  @override
  String get diagUdpUnknown => 'UDP 接続を確認できませんでした';

  @override
  String get diagUdpUnsupported => '現在の経路は UDP に非対応';

  @override
  String get diagUdpHint =>
      'テストは現在のルーティング規則に従います。タイムアウトだけでは、すべての UDP が遮断されているとは判断できません。';

  @override
  String get diagTimeline => '最近の操作履歴';

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
  String get diagStageFetch => '設定の取得';

  @override
  String get diagStageValidate => '設定の検証';

  @override
  String get diagStageApply => '設定の適用';

  @override
  String get diagStageStart => 'VPN の開始';

  @override
  String get diagStageStop => 'VPN の停止';

  @override
  String get diagEventStarted => '開始';

  @override
  String get diagEventSucceeded => '成功';

  @override
  String get diagEventFailed => '失敗';

  @override
  String get diagEventUnchanged => '内容に変更なし';

  @override
  String get diagEventCanceled => 'キャンセル済み';

  @override
  String get diagRecorded => '履歴';

  @override
  String mixedPortReset(Object value, Object port) {
    return 'ミックスポートを $value にはできないため、$port に戻しました';
  }

  @override
  String get coreStoppedDesc => 'アプリとコアの接続が切れました';

  @override
  String coreStoppedWithReason(Object reason) {
    return 'アプリとコアの接続が切れました：$reason';
  }

  @override
  String get vpnPermissionNotGranted =>
      'VPN の権限が許可されなかったため、VPN は起動しませんでした。ほかのアプリが常時接続 VPN に設定されている場合も起動できません';

  @override
  String get vpnServiceStartFailed => 'VPN サービスを起動できませんでした';
}

// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
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
  String get localeName => 'ja';

  static String m0(value) => "コミッション ¥ ${value}";

  static String m1(line) => "設定ファイルの ${line} 行目の形式が正しくありません";

  static String m2(expected, actual) =>
      "${expected} が必要ですが、${actual} が指定されています";

  static String m3(name) => "${name} はグループ、ルール、またはプロキシチェーンから参照されています";

  static String m4(count) => "${count}日前";

  static String m5(label) => "選択された${label}を削除してもよろしいですか？";

  static String m6(label) => "現在の${label}を削除してもよろしいですか？";

  static String m7(label) => "${label}詳細";

  static String m8(label) => "${label}は空欄にできません";

  static String m9(count) => "${count} エントリ";

  static String m10(label) => "現在の${label}は既に存在しています";

  static String m11(date) => "有効期限: ${date}";

  static String m12(name) => "${name} スキップ済み";

  static String m13(name) => "${name} 更新済み";

  static String m14(name) => "${name}を更新中...";

  static String m15(count) => "${count}時間前";

  static String m16(count) => "${count} 時間";

  static String m17(count) => "${count}分前";

  static String m18(count) => "${count}ヶ月前";

  static String m19(label) => "まだ${label}はありません";

  static String m20(label) => "${label}は数字でなければなりません";

  static String m21(id) => "プラン #${id}";

  static String m22(label) => "${label} は 1024 から 49151 の間でなければなりません";

  static String m23(name) =>
      "ノード ${name} は別の有効なチェーンで使用されているか、プロキシチェーン関係の競合があります";

  static String m24(name) => "ノード ${name} はこの位置では使用できません";

  static String m25(time) => "${time} に購入";

  static String m26(name, path) => "${name} は元の設定の ${path} で参照されています";

  static String m27(value) => "残り: ${value}";

  static String m28(count) => "残り${count}";

  static String m29(seconds) => "${seconds}秒後に再送信";

  static String m30(count) => "${count} 秒";

  static String m31(count) => "${count} 項目が選択されています";

  static String m32(label) => "${label}はURLである必要があります";

  static String m33(count) => "${count}年前";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("について"),
    "accessControl": MessageLookupByLibrary.simpleMessage("アクセス制御"),
    "accessControlAllowDesc": MessageLookupByLibrary.simpleMessage(
      "選択したアプリのみVPNを許可",
    ),
    "accessControlDesc": MessageLookupByLibrary.simpleMessage(
      "アプリケーションのプロキシアクセスを設定",
    ),
    "accessControlNotAllowDesc": MessageLookupByLibrary.simpleMessage(
      "選択したアプリをVPNから除外",
    ),
    "accessControlSettings": MessageLookupByLibrary.simpleMessage("アクセス制御設定"),
    "accessToken": MessageLookupByLibrary.simpleMessage("アクセストークン"),
    "account": MessageLookupByLibrary.simpleMessage("アカウント"),
    "accountBalance": MessageLookupByLibrary.simpleMessage("残高"),
    "action": MessageLookupByLibrary.simpleMessage("アクション"),
    "action_mode": MessageLookupByLibrary.simpleMessage("モード切替"),
    "action_proxy": MessageLookupByLibrary.simpleMessage("システムプロキシ"),
    "action_start": MessageLookupByLibrary.simpleMessage("開始/停止"),
    "action_tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "action_view": MessageLookupByLibrary.simpleMessage("表示/非表示"),
    "activate": MessageLookupByLibrary.simpleMessage("アクティブ化"),
    "activatePlanConfirm": MessageLookupByLibrary.simpleMessage(
      "このプランをアクティブ化しますか？アクティブ化すると現在有効なプランになります",
    ),
    "activatePlanTitle": MessageLookupByLibrary.simpleMessage("プランをアクティブ化"),
    "add": MessageLookupByLibrary.simpleMessage("追加"),
    "addProfile": MessageLookupByLibrary.simpleMessage("プロファイルを追加"),
    "addProxyChainNode": MessageLookupByLibrary.simpleMessage("追加"),
    "addProxyGroup": MessageLookupByLibrary.simpleMessage("プロキシグループを追加"),
    "addRule": MessageLookupByLibrary.simpleMessage("ルールを追加"),
    "addedRules": MessageLookupByLibrary.simpleMessage("追加ルール"),
    "address": MessageLookupByLibrary.simpleMessage("アドレス"),
    "addressCopied": MessageLookupByLibrary.simpleMessage("アドレスをコピーしました"),
    "addressHelp": MessageLookupByLibrary.simpleMessage("WebDAVサーバーアドレス"),
    "addressTip": MessageLookupByLibrary.simpleMessage("有効なWebDAVアドレスを入力"),
    "advancedConfig": MessageLookupByLibrary.simpleMessage("高度な設定"),
    "advancedConfigDesc": MessageLookupByLibrary.simpleMessage("多様な設定を提供"),
    "allowBypass": MessageLookupByLibrary.simpleMessage("アプリがVPNをバイパスすることを許可"),
    "allowBypassDesc": MessageLookupByLibrary.simpleMessage(
      "有効化すると一部アプリがVPNをバイパス",
    ),
    "allowLan": MessageLookupByLibrary.simpleMessage("LANを許可"),
    "allowLanDesc": MessageLookupByLibrary.simpleMessage("LAN経由でのプロキシアクセスを許可"),
    "allowTemporarily": MessageLookupByLibrary.simpleMessage("一時的に許可"),
    "announcement": MessageLookupByLibrary.simpleMessage("お知らせ"),
    "apiAvailable": MessageLookupByLibrary.simpleMessage("APIサービスは正常です"),
    "app": MessageLookupByLibrary.simpleMessage("アプリ"),
    "appAccessControl": MessageLookupByLibrary.simpleMessage("アプリアクセス制御"),
    "appendSystemDns": MessageLookupByLibrary.simpleMessage("システムDNSを追加"),
    "appendSystemDnsTip": MessageLookupByLibrary.simpleMessage(
      "設定にシステムDNSを強制的に追加します",
    ),
    "application": MessageLookupByLibrary.simpleMessage("アプリケーション"),
    "applicationDesc": MessageLookupByLibrary.simpleMessage("アプリ関連設定を変更"),
    "auto": MessageLookupByLibrary.simpleMessage("自動"),
    "autoCloseConnections": MessageLookupByLibrary.simpleMessage("接続を自動閉じる"),
    "autoCloseConnectionsDesc": MessageLookupByLibrary.simpleMessage(
      "ノード変更後に接続を自動閉じる",
    ),
    "autoIpv6": MessageLookupByLibrary.simpleMessage("自動 IPv6"),
    "autoIpv6Desc": MessageLookupByLibrary.simpleMessage(
      "ローカルネットワークの IPv6 対応に応じて自動切り替え",
    ),
    "autoLaunch": MessageLookupByLibrary.simpleMessage("自動起動"),
    "autoLaunchDesc": MessageLookupByLibrary.simpleMessage("システムの自動起動に従う"),
    "autoRenewOff": MessageLookupByLibrary.simpleMessage("自動更新：オフ"),
    "autoRenewOn": MessageLookupByLibrary.simpleMessage("自動更新：オン"),
    "autoRun": MessageLookupByLibrary.simpleMessage("自動実行"),
    "autoRunDesc": MessageLookupByLibrary.simpleMessage("アプリ起動時に自動実行"),
    "autoSetSystemDns": MessageLookupByLibrary.simpleMessage("オートセットシステムDNS"),
    "autoUpdate": MessageLookupByLibrary.simpleMessage("自動更新"),
    "autoUpdateInterval": MessageLookupByLibrary.simpleMessage("自動更新間隔（分）"),
    "availablePlans": MessageLookupByLibrary.simpleMessage("プランを選択"),
    "backup": MessageLookupByLibrary.simpleMessage("バックアップ"),
    "backupAndRestore": MessageLookupByLibrary.simpleMessage("バックアップと復元"),
    "backupAndRestoreDesc": MessageLookupByLibrary.simpleMessage(
      "WebDAVまたはファイルを介してデータを同期する",
    ),
    "backupSuccess": MessageLookupByLibrary.simpleMessage("バックアップ成功"),
    "balance": MessageLookupByLibrary.simpleMessage("残高"),
    "basicConfig": MessageLookupByLibrary.simpleMessage("基本設定"),
    "basicConfigDesc": MessageLookupByLibrary.simpleMessage("基本設定をグローバルに変更"),
    "bind": MessageLookupByLibrary.simpleMessage("バインド"),
    "blacklistMode": MessageLookupByLibrary.simpleMessage("ブラックリストモード"),
    "blockQuic": MessageLookupByLibrary.simpleMessage("QUICをブロック"),
    "blockQuicDesc": MessageLookupByLibrary.simpleMessage(
      "UDP 443のトラフィックを拒否し、接続をTCPにフォールバックさせます",
    ),
    "buyWithBalance": MessageLookupByLibrary.simpleMessage("残高を使用"),
    "bypassDomain": MessageLookupByLibrary.simpleMessage("バイパスドメイン"),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage("システムプロキシ有効時のみ適用"),
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "キャッシュが破損しています。クリアしますか？",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
    "cancelSelectAll": MessageLookupByLibrary.simpleMessage("全選択解除"),
    "checkApi": MessageLookupByLibrary.simpleMessage("APIをチェック"),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("更新を確認"),
    "checkUpdateError": MessageLookupByLibrary.simpleMessage("アプリは最新版です"),
    "checkUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "更新の確認に失敗しました。ネットワークを確認して再試行してください",
    ),
    "checkingPayment": MessageLookupByLibrary.simpleMessage("確認中..."),
    "clearData": MessageLookupByLibrary.simpleMessage("データを消去"),
    "clearProxyChain": MessageLookupByLibrary.simpleMessage("チェーン設定を削除"),
    "clipboardExport": MessageLookupByLibrary.simpleMessage("クリップボードにエクスポート"),
    "clipboardImport": MessageLookupByLibrary.simpleMessage("クリップボードからインポート"),
    "close": MessageLookupByLibrary.simpleMessage("閉じる"),
    "codeSent": MessageLookupByLibrary.simpleMessage("認証コードを送信しました"),
    "color": MessageLookupByLibrary.simpleMessage("カラー"),
    "colorSchemes": MessageLookupByLibrary.simpleMessage("カラースキーム"),
    "columns": MessageLookupByLibrary.simpleMessage("列"),
    "commission": MessageLookupByLibrary.simpleMessage("コミッション"),
    "commissionBalance": m0,
    "compatible": MessageLookupByLibrary.simpleMessage("互換モード"),
    "configDataDetected": MessageLookupByLibrary.simpleMessage(
      "設定内にデータが検出されました",
    ),
    "configParseErrorAtLine": m1,
    "configTypeMismatch": m2,
    "configValueTypeBoolean": MessageLookupByLibrary.simpleMessage("真偽値"),
    "configValueTypeInteger": MessageLookupByLibrary.simpleMessage("整数"),
    "configValueTypeList": MessageLookupByLibrary.simpleMessage("リスト"),
    "configValueTypeNull": MessageLookupByLibrary.simpleMessage("空の値"),
    "configValueTypeNumber": MessageLookupByLibrary.simpleMessage("数値"),
    "configValueTypeObject": MessageLookupByLibrary.simpleMessage("オブジェクト"),
    "configValueTypeText": MessageLookupByLibrary.simpleMessage("テキスト"),
    "configYamlFormatHint": MessageLookupByLibrary.simpleMessage(
      "この行付近のインデントと \"-\" のリスト記号を確認してください",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("確認"),
    "confirmClearAllData": MessageLookupByLibrary.simpleMessage(
      "すべてのデータをクリアしてもよろしいですか？",
    ),
    "confirmForceCrashCore": MessageLookupByLibrary.simpleMessage(
      "コアを強制的にクラッシュさせてもよろしいですか？",
    ),
    "confirmOverwriteTip": MessageLookupByLibrary.simpleMessage(
      "確認後、既存のデータは上書きされます",
    ),
    "confirmPasswordHint": MessageLookupByLibrary.simpleMessage("パスワードを再入力"),
    "confirmPasswordLabel": MessageLookupByLibrary.simpleMessage("パスワード（確認）"),
    "confirmPasswordValidation": MessageLookupByLibrary.simpleMessage(
      "パスワードを確認してください",
    ),
    "confirmPurchase": MessageLookupByLibrary.simpleMessage("購入を確認"),
    "connected": MessageLookupByLibrary.simpleMessage("接続済み"),
    "connecting": MessageLookupByLibrary.simpleMessage("接続中..."),
    "connection": MessageLookupByLibrary.simpleMessage("接続"),
    "connections": MessageLookupByLibrary.simpleMessage("接続"),
    "connectionsDesc": MessageLookupByLibrary.simpleMessage("現在の接続データを表示"),
    "connectivity": MessageLookupByLibrary.simpleMessage("接続性："),
    "content": MessageLookupByLibrary.simpleMessage("内容"),
    "contentScheme": MessageLookupByLibrary.simpleMessage("コンテンツテーマ"),
    "controlGlobalAddedRules": MessageLookupByLibrary.simpleMessage(
      "グローバル追加ルールを制御",
    ),
    "copy": MessageLookupByLibrary.simpleMessage("コピー"),
    "copyEnvVar": MessageLookupByLibrary.simpleMessage("環境変数をコピー"),
    "copyLink": MessageLookupByLibrary.simpleMessage("リンクをコピー"),
    "copySuccess": MessageLookupByLibrary.simpleMessage("コピー成功"),
    "core": MessageLookupByLibrary.simpleMessage("コア"),
    "coreStatus": MessageLookupByLibrary.simpleMessage("コアステータス"),
    "country": MessageLookupByLibrary.simpleMessage("国"),
    "crashTest": MessageLookupByLibrary.simpleMessage("クラッシュテスト"),
    "create": MessageLookupByLibrary.simpleMessage("作成"),
    "creationTime": MessageLookupByLibrary.simpleMessage("作成時間"),
    "custom": MessageLookupByLibrary.simpleMessage("カスタム"),
    "customOutboundInUse": m3,
    "cut": MessageLookupByLibrary.simpleMessage("切り取り"),
    "dark": MessageLookupByLibrary.simpleMessage("ダーク"),
    "dashboard": MessageLookupByLibrary.simpleMessage("ダッシュボード"),
    "days": MessageLookupByLibrary.simpleMessage("日"),
    "daysAgo": m4,
    "defaultNameserver": MessageLookupByLibrary.simpleMessage("デフォルトネームサーバー"),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "DNSサーバーの解決用",
    ),
    "defaultText": MessageLookupByLibrary.simpleMessage("デフォルト"),
    "delay": MessageLookupByLibrary.simpleMessage("遅延"),
    "delayTest": MessageLookupByLibrary.simpleMessage("遅延テスト"),
    "delete": MessageLookupByLibrary.simpleMessage("削除"),
    "deleteAccount": MessageLookupByLibrary.simpleMessage("アカウントを削除"),
    "deleteAccountAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "この操作でアカウントが完全に削除されることを理解しました",
    ),
    "deleteAccountFailed": MessageLookupByLibrary.simpleMessage(
      "アカウントを削除できませんでした",
    ),
    "deleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
      "アカウントを削除しました",
    ),
    "deleteAccountWarning": MessageLookupByLibrary.simpleMessage(
      "アカウントを完全に削除すると、アカウント、有効なプラン、残高、購入履歴、関連するクラウドデータが削除されます。この操作は取り消せません",
    ),
    "deleteMultipTip": m5,
    "deleteTip": m6,
    "desc": MessageLookupByLibrary.simpleMessage(
      "ClashMetaベースのマルチプラットフォームプロキシクライアント。シンプルで使いやすく、オープンソースで広告なし",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("宛先"),
    "destinationGeoIP": MessageLookupByLibrary.simpleMessage("宛先地理情報"),
    "destinationIPASN": MessageLookupByLibrary.simpleMessage("宛先IP ASN"),
    "details": m7,
    "detectionTip": MessageLookupByLibrary.simpleMessage("サードパーティAPIに依存（参考値）"),
    "developerMode": MessageLookupByLibrary.simpleMessage("デベロッパーモード"),
    "developerModeEnableTip": MessageLookupByLibrary.simpleMessage(
      "デベロッパーモードが有効になりました",
    ),
    "direct": MessageLookupByLibrary.simpleMessage("ダイレクト"),
    "disableUDP": MessageLookupByLibrary.simpleMessage("UDPを無効化"),
    "disconnected": MessageLookupByLibrary.simpleMessage("切断済み"),
    "discountCodeOptional": MessageLookupByLibrary.simpleMessage("割引コード（任意）"),
    "discovery": MessageLookupByLibrary.simpleMessage("新しいバージョンを発見"),
    "dnsDesc": MessageLookupByLibrary.simpleMessage("DNS関連設定の更新"),
    "dnsHijacking": MessageLookupByLibrary.simpleMessage("DNSハイジャッキング"),
    "dnsMode": MessageLookupByLibrary.simpleMessage("DNSモード"),
    "doYouWantToPass": MessageLookupByLibrary.simpleMessage("通過させますか？"),
    "documentCenter": MessageLookupByLibrary.simpleMessage("ドキュメントセンター"),
    "domain": MessageLookupByLibrary.simpleMessage("ドメイン"),
    "download": MessageLookupByLibrary.simpleMessage("ダウンロード"),
    "earlyRenew": MessageLookupByLibrary.simpleMessage("早期更新"),
    "edit": MessageLookupByLibrary.simpleMessage("編集"),
    "editGlobalRules": MessageLookupByLibrary.simpleMessage("グローバルルールを編集"),
    "editProxyGroup": MessageLookupByLibrary.simpleMessage("プロキシグループを編集"),
    "editRule": MessageLookupByLibrary.simpleMessage("ルールを編集"),
    "emailCodeHint": MessageLookupByLibrary.simpleMessage("6桁のコードを入力"),
    "emailCodeLabel": MessageLookupByLibrary.simpleMessage("メール認証コード"),
    "emailCodeValidation": MessageLookupByLibrary.simpleMessage(
      "メール認証コードを入力してください",
    ),
    "emailFormatValidation": MessageLookupByLibrary.simpleMessage(
      "メール形式が正しくありません",
    ),
    "emailHint": MessageLookupByLibrary.simpleMessage("メールアドレスを入力"),
    "emailLabel": MessageLookupByLibrary.simpleMessage("メール"),
    "emailPassword": MessageLookupByLibrary.simpleMessage("メールとパスワード"),
    "emailValidation": MessageLookupByLibrary.simpleMessage("メールを入力してください"),
    "emergencyMode": MessageLookupByLibrary.simpleMessage("緊急モード"),
    "emergencyModeDesc": MessageLookupByLibrary.simpleMessage(
      "通常の回線が利用できないときに、このオプションを有効にしてバックアップノードに切り替えてください",
    ),
    "emptyTip": m8,
    "en": MessageLookupByLibrary.simpleMessage("英語"),
    "enableAutoRenew": MessageLookupByLibrary.simpleMessage("自動更新を有効にする"),
    "entries": MessageLookupByLibrary.simpleMessage(" エントリ"),
    "entriesCount": m9,
    "exclude": MessageLookupByLibrary.simpleMessage("最近のタスクから非表示"),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "アプリがバックグラウンド時に最近のタスクから非表示",
    ),
    "excludeProxyFilter": MessageLookupByLibrary.simpleMessage("除外プロキシフィルター"),
    "excludeType": MessageLookupByLibrary.simpleMessage("除外タイプ"),
    "existsTip": m10,
    "exit": MessageLookupByLibrary.simpleMessage("終了"),
    "expand": MessageLookupByLibrary.simpleMessage("標準"),
    "expectedStatus": MessageLookupByLibrary.simpleMessage("期待されるステータス"),
    "expireDate": m11,
    "exportFile": MessageLookupByLibrary.simpleMessage("ファイルをエクスポート"),
    "exportLogs": MessageLookupByLibrary.simpleMessage("ログをエクスポート"),
    "exportSuccess": MessageLookupByLibrary.simpleMessage("エクスポート成功"),
    "expressiveScheme": MessageLookupByLibrary.simpleMessage("エクスプレッシブ"),
    "externalController": MessageLookupByLibrary.simpleMessage("外部コントローラー"),
    "externalControllerDesc": MessageLookupByLibrary.simpleMessage(
      "有効化すると設定したポートでClashコアを制御可能",
    ),
    "externalFetch": MessageLookupByLibrary.simpleMessage("外部取得"),
    "externalLink": MessageLookupByLibrary.simpleMessage("外部リンク"),
    "fakeipFilter": MessageLookupByLibrary.simpleMessage("Fakeipフィルター"),
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Fakeip範囲"),
    "fallback": MessageLookupByLibrary.simpleMessage("フォールバック"),
    "fallbackDesc": MessageLookupByLibrary.simpleMessage("通常はオフショアDNSを使用"),
    "fallbackFilter": MessageLookupByLibrary.simpleMessage("フォールバックフィルター"),
    "fetchOrdersFailed": MessageLookupByLibrary.simpleMessage("購入履歴の取得に失敗しました"),
    "fetchPlansFailed": MessageLookupByLibrary.simpleMessage("プランの取得に失敗しました"),
    "fidelityScheme": MessageLookupByLibrary.simpleMessage("ハイファイデリティー"),
    "file": MessageLookupByLibrary.simpleMessage("ファイル"),
    "fileDesc": MessageLookupByLibrary.simpleMessage("プロファイルを直接アップロード"),
    "fileIsUpdate": MessageLookupByLibrary.simpleMessage(
      "ファイルが変更されました。保存しますか？",
    ),
    "findProcessMode": MessageLookupByLibrary.simpleMessage("プロセス検出"),
    "findProcessModeDesc": MessageLookupByLibrary.simpleMessage(
      "有効化するとパフォーマンスが若干低下します",
    ),
    "fontFamily": MessageLookupByLibrary.simpleMessage("フォントファミリー"),
    "forceRestartCoreTip": MessageLookupByLibrary.simpleMessage(
      "コアを強制再起動してもよろしいですか？",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("パスワードをお忘れですか？"),
    "fruitSaladScheme": MessageLookupByLibrary.simpleMessage("フルーツサラダ"),
    "general": MessageLookupByLibrary.simpleMessage("一般"),
    "geoAutoUpdate": MessageLookupByLibrary.simpleMessage("自動更新"),
    "geoAutoUpdateInterval": MessageLookupByLibrary.simpleMessage("自動更新間隔"),
    "geoAutoUpdateIntervalTip": MessageLookupByLibrary.simpleMessage(
      "自動更新間隔は1〜8760時間で入力してください",
    ),
    "geoOptions": MessageLookupByLibrary.simpleMessage("Geoオプション"),
    "geoResources": MessageLookupByLibrary.simpleMessage("Geoリソース"),
    "geoSkipped": m12,
    "geoUpdated": m13,
    "geoUpdating": m14,
    "geodataLoader": MessageLookupByLibrary.simpleMessage("Geo低メモリモード"),
    "geodataLoaderDesc": MessageLookupByLibrary.simpleMessage(
      "有効化するとGeo低メモリローダーを使用",
    ),
    "geoipCode": MessageLookupByLibrary.simpleMessage("GeoIPコード"),
    "getProfileSuccess": MessageLookupByLibrary.simpleMessage(
      "プロファイルの取得に成功しました",
    ),
    "global": MessageLookupByLibrary.simpleMessage("グローバル"),
    "go": MessageLookupByLibrary.simpleMessage("移動"),
    "goLogin": MessageLookupByLibrary.simpleMessage("ログイン"),
    "goPay": MessageLookupByLibrary.simpleMessage("支払いへ"),
    "goToConfigureScript": MessageLookupByLibrary.simpleMessage("スクリプト設定に移動"),
    "hasCacheChange": MessageLookupByLibrary.simpleMessage("変更をキャッシュしますか？"),
    "haveAccountAlready": MessageLookupByLibrary.simpleMessage(
      "すでにアカウントをお持ちですか？",
    ),
    "hide": MessageLookupByLibrary.simpleMessage("非表示"),
    "hideFromList": MessageLookupByLibrary.simpleMessage("リストから隠す"),
    "host": MessageLookupByLibrary.simpleMessage("ホスト"),
    "hostsDesc": MessageLookupByLibrary.simpleMessage("ホストを追加"),
    "hotkeyConflict": MessageLookupByLibrary.simpleMessage("ホットキー競合"),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage("ホットキー管理"),
    "hotkeyManagementDesc": MessageLookupByLibrary.simpleMessage(
      "キーボードでアプリを制御",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("時間"),
    "hoursAgo": m15,
    "hoursCount": m16,
    "iHavePaid": MessageLookupByLibrary.simpleMessage("支払い済み"),
    "icon": MessageLookupByLibrary.simpleMessage("アイコン"),
    "iconStyle": MessageLookupByLibrary.simpleMessage("アイコンスタイル"),
    "iconUrl": MessageLookupByLibrary.simpleMessage("アイコンURL"),
    "import": MessageLookupByLibrary.simpleMessage("インポート"),
    "importFile": MessageLookupByLibrary.simpleMessage("ファイルからインポート"),
    "importFromURL": MessageLookupByLibrary.simpleMessage("URLからインポート"),
    "importUrl": MessageLookupByLibrary.simpleMessage("URLからインポート"),
    "includeAll": MessageLookupByLibrary.simpleMessage("すべてのプロキシとプロバイダーを含める"),
    "includeAllProxies": MessageLookupByLibrary.simpleMessage("すべてのプロキシを含める"),
    "includeAllProxyProviders": MessageLookupByLibrary.simpleMessage(
      "すべてのプロキシプロバイダーを含める",
    ),
    "infiniteTime": MessageLookupByLibrary.simpleMessage("長期有効"),
    "init": MessageLookupByLibrary.simpleMessage("初期化"),
    "inputCorrectHotkey": MessageLookupByLibrary.simpleMessage("正しいホットキーを入力"),
    "intelligentSelected": MessageLookupByLibrary.simpleMessage("インテリジェント選択"),
    "internet": MessageLookupByLibrary.simpleMessage("インターネット"),
    "interval": MessageLookupByLibrary.simpleMessage("インターバル"),
    "intranetIP": MessageLookupByLibrary.simpleMessage("イントラネットIP"),
    "invalidAmount": MessageLookupByLibrary.simpleMessage("有効な金額を入力してください"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage("無効なバックアップファイル"),
    "invalidCertificateContent": MessageLookupByLibrary.simpleMessage(
      "サーバー証明書を検証できません。現在のネットワークとサーバーを信頼できる場合のみ、この再試行だけ検証をスキップできます",
    ),
    "invalidCertificateTitle": MessageLookupByLibrary.simpleMessage(
      "証明書の検証に失敗しました",
    ),
    "inviteCodeHint": MessageLookupByLibrary.simpleMessage("招待コードを入力"),
    "inviteCodeLabel": MessageLookupByLibrary.simpleMessage("招待コード"),
    "inviteCodeValidation": MessageLookupByLibrary.simpleMessage(
      "招待コードを入力してください",
    ),
    "ipcidr": MessageLookupByLibrary.simpleMessage("IPCIDR"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage("有効化するとIPv6トラフィックを受信可能"),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage("IPv6インバウンドを許可"),
    "ja": MessageLookupByLibrary.simpleMessage("日本語"),
    "justNow": MessageLookupByLibrary.simpleMessage("たった今"),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "TCPキープアライブ間隔",
    ),
    "key": MessageLookupByLibrary.simpleMessage("キー"),
    "language": MessageLookupByLibrary.simpleMessage("言語"),
    "layout": MessageLookupByLibrary.simpleMessage("レイアウト"),
    "lazy": MessageLookupByLibrary.simpleMessage("遅延読み込み"),
    "light": MessageLookupByLibrary.simpleMessage("ライト"),
    "list": MessageLookupByLibrary.simpleMessage("リスト"),
    "listen": MessageLookupByLibrary.simpleMessage("リスン"),
    "loadTest": MessageLookupByLibrary.simpleMessage("読み込みテスト"),
    "loading": MessageLookupByLibrary.simpleMessage("読み込み中..."),
    "local": MessageLookupByLibrary.simpleMessage("ローカル"),
    "localBackupDesc": MessageLookupByLibrary.simpleMessage("ローカルにデータをバックアップ"),
    "log": MessageLookupByLibrary.simpleMessage("ログ"),
    "logLevel": MessageLookupByLibrary.simpleMessage("ログレベル"),
    "logcat": MessageLookupByLibrary.simpleMessage("ログキャット"),
    "logcatDesc": MessageLookupByLibrary.simpleMessage("無効化するとログエントリを非表示"),
    "loggedOutViewDesc": MessageLookupByLibrary.simpleMessage(
      "ログインしてアカウント情報を表示し、サブスクリプションを管理",
    ),
    "loggedOutViewTitle": MessageLookupByLibrary.simpleMessage("oixCloud"),
    "loginFailed": MessageLookupByLibrary.simpleMessage("ログイン失敗"),
    "loginSuccess": MessageLookupByLibrary.simpleMessage("ログイン成功"),
    "loginTitle": MessageLookupByLibrary.simpleMessage("ログイン"),
    "logoutAndDeleteToken": MessageLookupByLibrary.simpleMessage(
      "ログアウトしてトークンを削除",
    ),
    "logoutContent": MessageLookupByLibrary.simpleMessage(
      "どちらを選んでも、このデバイスからトークンは削除されます。oixCloudからトークンを削除すると、同じトークンを使用している他のデバイスでもログアウトする場合があります",
    ),
    "logoutLocalOnly": MessageLookupByLibrary.simpleMessage("ログアウトのみ"),
    "logoutTitle": MessageLookupByLibrary.simpleMessage("ログアウト"),
    "logs": MessageLookupByLibrary.simpleMessage("ログ"),
    "logsDesc": MessageLookupByLibrary.simpleMessage("ログキャプチャ記録"),
    "logsTest": MessageLookupByLibrary.simpleMessage("ログテスト"),
    "loopback": MessageLookupByLibrary.simpleMessage("ループバック解除ツール"),
    "loopbackDesc": MessageLookupByLibrary.simpleMessage("UWPループバック解除用"),
    "loose": MessageLookupByLibrary.simpleMessage("疎"),
    "mainlandNetworkWarning": MessageLookupByLibrary.simpleMessage(
      "中国本土のネットワークには適さない可能性があります",
    ),
    "maxFailedTimes": MessageLookupByLibrary.simpleMessage("最大失敗回数"),
    "memoryInfo": MessageLookupByLibrary.simpleMessage("メモリ情報"),
    "messageTest": MessageLookupByLibrary.simpleMessage("メッセージテスト"),
    "messageTestTip": MessageLookupByLibrary.simpleMessage("これはメッセージです"),
    "min": MessageLookupByLibrary.simpleMessage("最小化"),
    "minimalConfiguration": MessageLookupByLibrary.simpleMessage("最小構成"),
    "minimalConfigurationDesc": MessageLookupByLibrary.simpleMessage(
      "簡略化したルールセットで小さなプロファイルを生成します",
    ),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage("終了時に最小化"),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "システムの終了イベントを変更",
    ),
    "minutes": MessageLookupByLibrary.simpleMessage("分"),
    "minutesAgo": m17,
    "mixedPort": MessageLookupByLibrary.simpleMessage("混合ポート"),
    "mode": MessageLookupByLibrary.simpleMessage("モード"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("モノクローム"),
    "months": MessageLookupByLibrary.simpleMessage("月"),
    "monthsAgo": m18,
    "more": MessageLookupByLibrary.simpleMessage("詳細"),
    "myOrders": MessageLookupByLibrary.simpleMessage("購入済みプラン"),
    "name": MessageLookupByLibrary.simpleMessage("名前"),
    "nameserver": MessageLookupByLibrary.simpleMessage("ネームサーバー"),
    "nameserverDesc": MessageLookupByLibrary.simpleMessage("ドメイン解決用"),
    "nameserverPolicy": MessageLookupByLibrary.simpleMessage("ネームサーバーポリシー"),
    "nameserverPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "対応するネームサーバーポリシーを指定",
    ),
    "network": MessageLookupByLibrary.simpleMessage("ネットワーク"),
    "networkDesc": MessageLookupByLibrary.simpleMessage("ネットワーク関連設定の変更"),
    "networkDetection": MessageLookupByLibrary.simpleMessage("ネットワーク検出"),
    "networkException": MessageLookupByLibrary.simpleMessage(
      "ネットワーク例外、接続を確認してもう一度お試しください",
    ),
    "networkSpeed": MessageLookupByLibrary.simpleMessage("ネットワーク速度"),
    "networkType": MessageLookupByLibrary.simpleMessage("ネットワーク種別"),
    "neutralScheme": MessageLookupByLibrary.simpleMessage("ニュートラル"),
    "newPasswordLabel": MessageLookupByLibrary.simpleMessage("新しいパスワード"),
    "nicknameHint": MessageLookupByLibrary.simpleMessage("英数字、最大12文字"),
    "nicknameLabel": MessageLookupByLibrary.simpleMessage("ニックネーム"),
    "nicknameValidation": MessageLookupByLibrary.simpleMessage(
      "ニックネームを入力してください",
    ),
    "noAvailablePlans": MessageLookupByLibrary.simpleMessage("利用可能なプランがありません"),
    "noData": MessageLookupByLibrary.simpleMessage("データなし"),
    "noHotKey": MessageLookupByLibrary.simpleMessage("ホットキーなし"),
    "noInfo": MessageLookupByLibrary.simpleMessage("情報なし"),
    "noNetwork": MessageLookupByLibrary.simpleMessage("ネットワークなし"),
    "noNetworkApp": MessageLookupByLibrary.simpleMessage("ネットワークなしアプリ"),
    "noPaymentMethods": MessageLookupByLibrary.simpleMessage(
      "利用可能な支払い方法がありません",
    ),
    "noProxy": MessageLookupByLibrary.simpleMessage("プロキシなし"),
    "noPurchaseRecords": MessageLookupByLibrary.simpleMessage("購入済みのプランはありません"),
    "noResolve": MessageLookupByLibrary.simpleMessage("IPを解決しない"),
    "noUpgradablePlans": MessageLookupByLibrary.simpleMessage(
      "アップグレード可能なプランがありません",
    ),
    "none": MessageLookupByLibrary.simpleMessage("なし"),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "現在のプロキシグループは選択できません",
    ),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "プロファイルがありません。追加してください",
    ),
    "nullTip": m19,
    "numberTip": m20,
    "oixCloud": MessageLookupByLibrary.simpleMessage("oixCloud"),
    "onlyIcon": MessageLookupByLibrary.simpleMessage("アイコンのみ"),
    "onlyStatisticsProxy": MessageLookupByLibrary.simpleMessage("プロキシのみ統計"),
    "onlyStatisticsProxyDesc": MessageLookupByLibrary.simpleMessage(
      "有効化するとプロキシトラフィックのみ統計",
    ),
    "openDashboard": MessageLookupByLibrary.simpleMessage("ダッシュボードを開く"),
    "openInBrowser": MessageLookupByLibrary.simpleMessage("ブラウザで開く"),
    "operationFailed": MessageLookupByLibrary.simpleMessage("操作に失敗しました"),
    "operationSuccess": MessageLookupByLibrary.simpleMessage("操作に成功しました"),
    "optionalParameters": MessageLookupByLibrary.simpleMessage("オプションパラメータ"),
    "options": MessageLookupByLibrary.simpleMessage("オプション"),
    "orderAndPay": MessageLookupByLibrary.simpleMessage("オンライン決済"),
    "other": MessageLookupByLibrary.simpleMessage("その他"),
    "outboundMode": MessageLookupByLibrary.simpleMessage("アウトバウンドモード"),
    "override": MessageLookupByLibrary.simpleMessage("上書き"),
    "overrideDns": MessageLookupByLibrary.simpleMessage("DNS上書き"),
    "overrideDnsDesc": MessageLookupByLibrary.simpleMessage(
      "有効化するとプロファイルのDNS設定を上書き",
    ),
    "overrideMode": MessageLookupByLibrary.simpleMessage("上書きモード"),
    "overrideScript": MessageLookupByLibrary.simpleMessage("上書きスクリプト"),
    "overseasNetworkEnvironment": MessageLookupByLibrary.simpleMessage(
      "海外ネットワーク環境",
    ),
    "overseasNetworkEnvironmentDesc": MessageLookupByLibrary.simpleMessage(
      "中国本土外にいる場合はこのオプションをオンにしてください",
    ),
    "overwriteTypeCustom": MessageLookupByLibrary.simpleMessage("カスタム"),
    "overwriteTypeCustomDesc": MessageLookupByLibrary.simpleMessage(
      "カスタムモード、プロキシグループとルールを完全にカスタマイズ可能",
    ),
    "palette": MessageLookupByLibrary.simpleMessage("パレット"),
    "password": MessageLookupByLibrary.simpleMessage("パスワード"),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("パスワード"),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage("パスワードが一致しません"),
    "passwordRuleHint": MessageLookupByLibrary.simpleMessage(
      "10〜36文字、大文字・小文字・数字・記号を含む",
    ),
    "passwordValidation": MessageLookupByLibrary.simpleMessage(
      "パスワードを入力してください",
    ),
    "paste": MessageLookupByLibrary.simpleMessage("貼り付け"),
    "paymentAmount": MessageLookupByLibrary.simpleMessage("支払い金額"),
    "paymentMethod": MessageLookupByLibrary.simpleMessage("支払い方法"),
    "paymentRequestFailed": MessageLookupByLibrary.simpleMessage(
      "支払いリクエストに失敗しました",
    ),
    "paymentSuccess": MessageLookupByLibrary.simpleMessage("支払いに成功しました"),
    "paymentUnknownResponse": MessageLookupByLibrary.simpleMessage(
      "支払いエンドポイントが不明な形式を返しました",
    ),
    "planEnded": MessageLookupByLibrary.simpleMessage("終了"),
    "planInUse": MessageLookupByLibrary.simpleMessage("使用中"),
    "planNotActivated": MessageLookupByLibrary.simpleMessage("有効化待ち"),
    "planNumber": m21,
    "pleaseBindWebDAV": MessageLookupByLibrary.simpleMessage(
      "WebDAVをバインドしてください",
    ),
    "pleaseEnterScriptName": MessageLookupByLibrary.simpleMessage(
      "スクリプト名を入力してください",
    ),
    "pleaseInputAdminPassword": MessageLookupByLibrary.simpleMessage(
      "管理者パスワードを入力",
    ),
    "pleaseUploadValidQrcode": MessageLookupByLibrary.simpleMessage(
      "有効なQRコードをアップロードしてください",
    ),
    "points": MessageLookupByLibrary.simpleMessage("ポイント"),
    "port": MessageLookupByLibrary.simpleMessage("ポート"),
    "portConflictTip": MessageLookupByLibrary.simpleMessage("別のポートを入力してください"),
    "portTip": m22,
    "preferH3Desc": MessageLookupByLibrary.simpleMessage("DOHのHTTP/3を優先使用"),
    "pressKeyboard": MessageLookupByLibrary.simpleMessage("キーボードを押してください"),
    "preview": MessageLookupByLibrary.simpleMessage("プレビュー"),
    "process": MessageLookupByLibrary.simpleMessage("プロセス"),
    "profile": MessageLookupByLibrary.simpleMessage("プロファイル"),
    "profileAutoUpdateIntervalInvalidValidationDesc":
        MessageLookupByLibrary.simpleMessage("有効な間隔形式を入力してください"),
    "profileAutoUpdateIntervalNullValidationDesc":
        MessageLookupByLibrary.simpleMessage("自動更新間隔を入力してください"),
    "profileHasUpdate": MessageLookupByLibrary.simpleMessage(
      "プロファイルが変更されました。自動更新を無効化しますか？",
    ),
    "profileNameNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "プロファイル名を入力してください",
    ),
    "profileParseErrorDesc": MessageLookupByLibrary.simpleMessage(
      "プロファイル解析エラー",
    ),
    "profileUrlInvalidValidationDesc": MessageLookupByLibrary.simpleMessage(
      "有効なプロファイルURLを入力してください",
    ),
    "profileUrlNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "プロファイルURLを入力してください",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("プロファイル一覧"),
    "profilesSort": MessageLookupByLibrary.simpleMessage("プロファイルの並び替え"),
    "project": MessageLookupByLibrary.simpleMessage("プロジェクト"),
    "providers": MessageLookupByLibrary.simpleMessage("プロバイダー"),
    "proxies": MessageLookupByLibrary.simpleMessage("プロキシ"),
    "proxyChainAvailableNodes": MessageLookupByLibrary.simpleMessage(
      "利用可能なノード",
    ),
    "proxyChainConflictTip": m23,
    "proxyChainCustomNode": MessageLookupByLibrary.simpleMessage("カスタムノード"),
    "proxyChainCustomNodes": MessageLookupByLibrary.simpleMessage("カスタムノード"),
    "proxyChainEmpty": MessageLookupByLibrary.simpleMessage(
      "プロキシチェーンにノードがありません",
    ),
    "proxyChainEntry": MessageLookupByLibrary.simpleMessage("入口"),
    "proxyChainExit": MessageLookupByLibrary.simpleMessage("出口"),
    "proxyChainInstruction": MessageLookupByLibrary.simpleMessage(
      "ノードを順番に追加します。最初が入口、最後が出口です。保存後は出口ノードを選択して使用します",
    ),
    "proxyChainMinimumNodes": MessageLookupByLibrary.simpleMessage(
      "プロキシチェーンには少なくとも 2 つのノードが必要です",
    ),
    "proxyChainMinimumNodesHint": MessageLookupByLibrary.simpleMessage(
      "プロキシチェーンには少なくとも 2 つのノードが必要です。出口ノードを追加してください",
    ),
    "proxyChainNodeAdded": MessageLookupByLibrary.simpleMessage(
      "ノードをプロキシチェーンに追加しました",
    ),
    "proxyChainOtherNodes": MessageLookupByLibrary.simpleMessage("その他のノード"),
    "proxyChainRelatedChainsUpdated": MessageLookupByLibrary.simpleMessage(
      "関連するプロキシチェーンを更新しました",
    ),
    "proxyChainSavedAndApplied": MessageLookupByLibrary.simpleMessage(
      "プロキシチェーンを保存して適用しました。使用するには出口ノードを選択してください",
    ),
    "proxyChainSelectedNodes": MessageLookupByLibrary.simpleMessage("プロキシチェーン"),
    "proxyChainUnavailableNodeTip": m24,
    "proxyChainUriNodeSupportedFormats": MessageLookupByLibrary.simpleMessage(
      "対応形式：ss://、ssr://、vmess://、vless://、trojan://、anytls://、hysteria:// / hy://、hysteria2:// / hy2://、tuic://、wireguard:// / wg://、http(s)://、socks(5)://",
    ),
    "proxyChainWarning": MessageLookupByLibrary.simpleMessage(
      "プロキシチェーンは通信速度を大きく低下させる可能性があります。明確な用途がない場合は無効のままにしてください",
    ),
    "proxyChains": MessageLookupByLibrary.simpleMessage("プロキシチェーン"),
    "proxyFilter": MessageLookupByLibrary.simpleMessage("プロキシフィルター"),
    "proxyGroup": MessageLookupByLibrary.simpleMessage("プロキシグループ"),
    "proxyGroupEmpty": MessageLookupByLibrary.simpleMessage("プロキシグループが空です"),
    "proxyGroupMembersEmpty": MessageLookupByLibrary.simpleMessage(
      "プロキシ、プロバイダー、または全件追加オプションを設定してください",
    ),
    "proxyGroupNameEmpty": MessageLookupByLibrary.simpleMessage(
      "プロキシグループ名は空にできません",
    ),
    "proxyNameserver": MessageLookupByLibrary.simpleMessage("プロキシネームサーバー"),
    "proxyNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "プロキシノード解決用ドメイン",
    ),
    "proxyPort": MessageLookupByLibrary.simpleMessage("プロキシポート"),
    "proxyProviders": MessageLookupByLibrary.simpleMessage("プロキシプロバイダー"),
    "pruneCache": MessageLookupByLibrary.simpleMessage("キャッシュの削除"),
    "purchaseTime": m25,
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("純黒モード"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QRコード"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage("QRコードをスキャンしてプロファイルを取得"),
    "quickFill": MessageLookupByLibrary.simpleMessage("クイック入力"),
    "rainbowScheme": MessageLookupByLibrary.simpleMessage("レインボー"),
    "rawOutboundInUse": m26,
    "receivingAddress": MessageLookupByLibrary.simpleMessage("受取アドレス"),
    "recharge": MessageLookupByLibrary.simpleMessage("チャージ"),
    "rechargeAmount": MessageLookupByLibrary.simpleMessage("チャージ金額（¥）"),
    "redirPort": MessageLookupByLibrary.simpleMessage("Redirポート"),
    "redo": MessageLookupByLibrary.simpleMessage("やり直す"),
    "refresh": MessageLookupByLibrary.simpleMessage("更新"),
    "refreshAfterPayment": MessageLookupByLibrary.simpleMessage(
      "支払い完了後、下にスワイプして結果を確認してください",
    ),
    "regExp": MessageLookupByLibrary.simpleMessage("正規表現"),
    "register": MessageLookupByLibrary.simpleMessage("登録"),
    "registerClosed": MessageLookupByLibrary.simpleMessage("現在、新規登録は停止しています"),
    "registerFailed": MessageLookupByLibrary.simpleMessage("登録に失敗しました"),
    "registerTitle": MessageLookupByLibrary.simpleMessage("アカウント作成"),
    "relayGroupUnsupported": MessageLookupByLibrary.simpleMessage(
      "Relay グループはコアから削除されました。別のタイプを選択してください",
    ),
    "reload": MessageLookupByLibrary.simpleMessage("リロード"),
    "remaining": m27,
    "remainingStock": m28,
    "remote": MessageLookupByLibrary.simpleMessage("リモート"),
    "remoteBackupDesc": MessageLookupByLibrary.simpleMessage(
      "WebDAVにデータをバックアップ",
    ),
    "remoteDestination": MessageLookupByLibrary.simpleMessage("リモート宛先"),
    "remove": MessageLookupByLibrary.simpleMessage("削除"),
    "rename": MessageLookupByLibrary.simpleMessage("リネーム"),
    "request": MessageLookupByLibrary.simpleMessage("リクエスト"),
    "requests": MessageLookupByLibrary.simpleMessage("リクエスト"),
    "requestsDesc": MessageLookupByLibrary.simpleMessage("最近のリクエスト記録を表示"),
    "resendCodeIn": m29,
    "reset": MessageLookupByLibrary.simpleMessage("リセット"),
    "resetEmailSent": MessageLookupByLibrary.simpleMessage(
      "リセットメールを送信しました。メール内のリセットリンクまたはコードを下に貼り付けてください",
    ),
    "resetPageChangesTip": MessageLookupByLibrary.simpleMessage(
      "現在のページに変更があります。リセットしてもよろしいですか？",
    ),
    "resetPasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "パスワードをリセットしました。新しいパスワードでログインしてください",
    ),
    "resetPasswordTitle": MessageLookupByLibrary.simpleMessage("パスワードのリセット"),
    "resetTip": MessageLookupByLibrary.simpleMessage("リセットを確定"),
    "resetTokenLabel": MessageLookupByLibrary.simpleMessage("リセットリンクまたはコード"),
    "resetTokenValidation": MessageLookupByLibrary.simpleMessage(
      "リセットリンクまたはコードを入力してください",
    ),
    "resources": MessageLookupByLibrary.simpleMessage("リソース"),
    "resourcesDesc": MessageLookupByLibrary.simpleMessage("外部リソース関連情報"),
    "respectRules": MessageLookupByLibrary.simpleMessage("ルール尊重"),
    "respectRulesDesc": MessageLookupByLibrary.simpleMessage(
      "DNS接続がルールに従う（proxy-server-nameserverの設定が必要）",
    ),
    "restart": MessageLookupByLibrary.simpleMessage("再起動"),
    "restartCoreTip": MessageLookupByLibrary.simpleMessage("コアを再起動してもよろしいですか？"),
    "restore": MessageLookupByLibrary.simpleMessage("復元"),
    "restoreAllData": MessageLookupByLibrary.simpleMessage("すべてのデータを復元する"),
    "restoreDefault": MessageLookupByLibrary.simpleMessage("デフォルトに戻す"),
    "restoreException": MessageLookupByLibrary.simpleMessage("復元例外"),
    "restoreFromFileDesc": MessageLookupByLibrary.simpleMessage(
      "ファイルを介してデータを復元する",
    ),
    "restoreFromWebDAVDesc": MessageLookupByLibrary.simpleMessage(
      "WebDAVを介してデータを復元する",
    ),
    "restoreOnlyConfig": MessageLookupByLibrary.simpleMessage("設定ファイルのみを復元する"),
    "restoreStrategy": MessageLookupByLibrary.simpleMessage("復元ストラテジー"),
    "restoreStrategy_compatible": MessageLookupByLibrary.simpleMessage("互換"),
    "restoreStrategy_override": MessageLookupByLibrary.simpleMessage("上書き"),
    "restoreSuccess": MessageLookupByLibrary.simpleMessage("復元に成功しました"),
    "routeAddress": MessageLookupByLibrary.simpleMessage("ルートアドレス"),
    "routeAddressDesc": MessageLookupByLibrary.simpleMessage("ルートアドレスを設定"),
    "routeMode": MessageLookupByLibrary.simpleMessage("ルートモード"),
    "routeMode_bypassPrivate": MessageLookupByLibrary.simpleMessage(
      "プライベートルートをバイパス",
    ),
    "routeMode_config": MessageLookupByLibrary.simpleMessage("設定を使用"),
    "ru": MessageLookupByLibrary.simpleMessage("ロシア語"),
    "rule": MessageLookupByLibrary.simpleMessage("ルール"),
    "ruleEmpty": MessageLookupByLibrary.simpleMessage("ルールが空です"),
    "ruleName": MessageLookupByLibrary.simpleMessage("ルール名"),
    "ruleProviders": MessageLookupByLibrary.simpleMessage("ルールプロバイダー"),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("ルール対象"),
    "save": MessageLookupByLibrary.simpleMessage("保存"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("変更を保存しますか？"),
    "scanOrTransferPay": MessageLookupByLibrary.simpleMessage("スキャン／送金支払い"),
    "scanToPayNotice": MessageLookupByLibrary.simpleMessage(
      "Alipay / WeChat でスキャンして支払い",
    ),
    "script": MessageLookupByLibrary.simpleMessage("スクリプト"),
    "scriptModeDesc": MessageLookupByLibrary.simpleMessage(
      "スクリプトモード、外部拡張スクリプトを使用し、ワンクリックで設定を上書きする機能を提供",
    ),
    "search": MessageLookupByLibrary.simpleMessage("検索"),
    "seconds": MessageLookupByLibrary.simpleMessage("秒"),
    "secondsCount": m30,
    "selectAll": MessageLookupByLibrary.simpleMessage("すべて選択"),
    "selectUpgradeTarget": MessageLookupByLibrary.simpleMessage("アップグレード対象を選択"),
    "selected": MessageLookupByLibrary.simpleMessage("選択済み"),
    "selectedCountTitle": m31,
    "sendCode": MessageLookupByLibrary.simpleMessage("コードを送信"),
    "sendResetEmail": MessageLookupByLibrary.simpleMessage("リセットメールを送信"),
    "serviceCheckFailed": MessageLookupByLibrary.simpleMessage("サービスチェック失敗"),
    "settings": MessageLookupByLibrary.simpleMessage("設定"),
    "show": MessageLookupByLibrary.simpleMessage("表示"),
    "shrink": MessageLookupByLibrary.simpleMessage("縮小"),
    "silentLaunch": MessageLookupByLibrary.simpleMessage("バックグラウンド起動"),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage("バックグラウンドで起動"),
    "size": MessageLookupByLibrary.simpleMessage("サイズ"),
    "socksPort": MessageLookupByLibrary.simpleMessage("Socksポート"),
    "softwareCenter": MessageLookupByLibrary.simpleMessage("ソフトウェアセンター"),
    "soldOut": MessageLookupByLibrary.simpleMessage("売り切れ"),
    "sort": MessageLookupByLibrary.simpleMessage("並び替え"),
    "source": MessageLookupByLibrary.simpleMessage("ソース"),
    "sourceIp": MessageLookupByLibrary.simpleMessage("送信元IP"),
    "specialProxy": MessageLookupByLibrary.simpleMessage("特殊プロキシ"),
    "specialRules": MessageLookupByLibrary.simpleMessage("特殊ルール"),
    "speedStatistics": MessageLookupByLibrary.simpleMessage("速度統計"),
    "stackMode": MessageLookupByLibrary.simpleMessage("スタックモード"),
    "standard": MessageLookupByLibrary.simpleMessage("標準"),
    "standardModeDesc": MessageLookupByLibrary.simpleMessage(
      "標準モード、基本設定を上書きし、シンプルなルール追加機能を提供",
    ),
    "start": MessageLookupByLibrary.simpleMessage("開始"),
    "startCorePromptContent": MessageLookupByLibrary.simpleMessage(
      "プロファイルが正常にインポートされました。今すぐ起動しますか？",
    ),
    "startCorePromptTitle": MessageLookupByLibrary.simpleMessage("プロンプト"),
    "startSuccess": MessageLookupByLibrary.simpleMessage("起動しました"),
    "startVpn": MessageLookupByLibrary.simpleMessage("VPNを開始中..."),
    "status": MessageLookupByLibrary.simpleMessage("ステータス"),
    "statusDesc": MessageLookupByLibrary.simpleMessage("無効時はシステムDNSを使用"),
    "stop": MessageLookupByLibrary.simpleMessage("停止"),
    "stopVpn": MessageLookupByLibrary.simpleMessage("VPNを停止中..."),
    "store": MessageLookupByLibrary.simpleMessage("ストア"),
    "storeSubtitle": MessageLookupByLibrary.simpleMessage(
      "プラン購入 · チャージ · 更新とアップグレード",
    ),
    "strategy": MessageLookupByLibrary.simpleMessage("ストラテジー"),
    "style": MessageLookupByLibrary.simpleMessage("スタイル"),
    "subRule": MessageLookupByLibrary.simpleMessage("サブルール"),
    "submit": MessageLookupByLibrary.simpleMessage("送信"),
    "sync": MessageLookupByLibrary.simpleMessage("同期"),
    "system": MessageLookupByLibrary.simpleMessage("システム"),
    "systemApp": MessageLookupByLibrary.simpleMessage("システムアプリ"),
    "systemProxy": MessageLookupByLibrary.simpleMessage("システムプロキシ"),
    "systemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "HTTPプロキシをVpnServiceに接続",
    ),
    "tab": MessageLookupByLibrary.simpleMessage("タブ"),
    "tabAnimation": MessageLookupByLibrary.simpleMessage("タブアニメーション"),
    "tabAnimationDesc": MessageLookupByLibrary.simpleMessage("モバイル表示でのみ有効"),
    "tcpConcurrent": MessageLookupByLibrary.simpleMessage("TCP並列処理"),
    "tcpConcurrentDesc": MessageLookupByLibrary.simpleMessage("TCP並列処理を許可"),
    "tcpFastOpen": MessageLookupByLibrary.simpleMessage("TCP Fast Open"),
    "tcpFastOpenDesc": MessageLookupByLibrary.simpleMessage(
      "TCPの接続確立を高速化するには、このオプションをオンにしてください",
    ),
    "testUrl": MessageLookupByLibrary.simpleMessage("URLテスト"),
    "textScale": MessageLookupByLibrary.simpleMessage("テキストスケーリング"),
    "theme": MessageLookupByLibrary.simpleMessage("テーマ"),
    "themeColor": MessageLookupByLibrary.simpleMessage("テーマカラー"),
    "themeDesc": MessageLookupByLibrary.simpleMessage("ダークモードの設定、色の調整"),
    "themeMode": MessageLookupByLibrary.simpleMessage("テーマモード"),
    "tight": MessageLookupByLibrary.simpleMessage("密"),
    "time": MessageLookupByLibrary.simpleMessage("時間"),
    "timeSyncTip": MessageLookupByLibrary.simpleMessage(
      "プロキシプロトコルは、デバイスの時刻が世界標準時（UTC）と30秒以内の誤差である必要があります。デバイスの時刻が正確であることを確認してください",
    ),
    "timeout": MessageLookupByLibrary.simpleMessage("タイムアウト"),
    "tip": MessageLookupByLibrary.simpleMessage("ヒント"),
    "todayUsed": MessageLookupByLibrary.simpleMessage("今日の使用量"),
    "toggle": MessageLookupByLibrary.simpleMessage("トグル"),
    "tokenLabel": MessageLookupByLibrary.simpleMessage("アクセストークン"),
    "tokenValidation": MessageLookupByLibrary.simpleMessage(
      "アクセストークンを入力してください",
    ),
    "tolerance": MessageLookupByLibrary.simpleMessage("許容差"),
    "tonalSpotScheme": MessageLookupByLibrary.simpleMessage("トーンスポット"),
    "tools": MessageLookupByLibrary.simpleMessage("ツール"),
    "tproxyPort": MessageLookupByLibrary.simpleMessage("Tproxyポート"),
    "trafficUsage": MessageLookupByLibrary.simpleMessage("トラフィック使用量"),
    "transferConfirmNotice": MessageLookupByLibrary.simpleMessage(
      "送金完了後、システムが自動的に確認し、選択したプランが自動的に有効になります",
    ),
    "tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "tunDesc": MessageLookupByLibrary.simpleMessage("管理者モードでのみ有効"),
    "turnOff": MessageLookupByLibrary.simpleMessage("オフ"),
    "turnOn": MessageLookupByLibrary.simpleMessage("オン"),
    "twoFactorCodeOptional": MessageLookupByLibrary.simpleMessage(
      "2段階認証コード（有効な場合）",
    ),
    "undo": MessageLookupByLibrary.simpleMessage("元に戻す"),
    "unifiedDelay": MessageLookupByLibrary.simpleMessage("統一遅延"),
    "unifiedDelayDesc": MessageLookupByLibrary.simpleMessage(
      "ハンドシェイクなどの余分な遅延を削除",
    ),
    "unknown": MessageLookupByLibrary.simpleMessage("不明"),
    "unknownNetworkError": MessageLookupByLibrary.simpleMessage("不明なネットワークエラー"),
    "unnamed": MessageLookupByLibrary.simpleMessage("無題"),
    "update": MessageLookupByLibrary.simpleMessage("更新"),
    "upgradePlan": MessageLookupByLibrary.simpleMessage("プランをアップグレード"),
    "upload": MessageLookupByLibrary.simpleMessage("アップロード"),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage("URL経由でプロファイルを取得"),
    "urlTip": m32,
    "useHosts": MessageLookupByLibrary.simpleMessage("ホストを使用"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage("システムホストを使用"),
    "userAgent": MessageLookupByLibrary.simpleMessage("ユーザーエージェント"),
    "userCenter": MessageLookupByLibrary.simpleMessage("ユーザーセンター"),
    "userCenterFallback": MessageLookupByLibrary.simpleMessage("ユーザーセンター（予備）"),
    "value": MessageLookupByLibrary.simpleMessage("値"),
    "vibrantScheme": MessageLookupByLibrary.simpleMessage("ビブラント"),
    "view": MessageLookupByLibrary.simpleMessage("表示"),
    "vpnConfigChangeDetected": MessageLookupByLibrary.simpleMessage(
      "VPN設定の変更が検出されました",
    ),
    "vpnEnableDesc": MessageLookupByLibrary.simpleMessage(
      "VpnService経由で全システムトラフィックをルーティング",
    ),
    "vpnTip": MessageLookupByLibrary.simpleMessage("変更はVPN再起動後に有効"),
    "webDAVConfiguration": MessageLookupByLibrary.simpleMessage("WebDAV設定"),
    "whitelistMode": MessageLookupByLibrary.simpleMessage("ホワイトリストモード"),
    "years": MessageLookupByLibrary.simpleMessage("年"),
    "yearsAgo": m33,
    "zh_CN": MessageLookupByLibrary.simpleMessage("簡体字中国語"),
  };
}

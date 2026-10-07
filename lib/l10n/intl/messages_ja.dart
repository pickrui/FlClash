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

  static String m0(value) => "利用可能 ${value}";

  static String m1(count, skipped) => "${count}件を追加、${skipped}件は既存のためスキップ";

  static String m2(status) => "サーバーが HTTP ${status} を返しました";

  static String m3(error) => "直接接続：${error}";

  static String m4(error) => "内蔵プロキシ：${error}";

  static String m5(code) => "システムエラー ${code}";

  static String m6(value) => "コミッション ${value}";

  static String m7(line) => "設定ファイルの ${line} 行目の形式が正しくありません";

  static String m8(expected, actual) =>
      "${expected} が必要ですが、${actual} が指定されています";

  static String m9(code) =>
      "Windows がプロキシコアの起動をブロックしました（システムエラー ${code}）。Windows セキュリティの保護の履歴とアプリ制御ポリシーを確認し、インストーラーの入手元と署名を確認してください";

  static String m10(name) => "${name} はグループ、ルール、またはプロキシチェーンから参照されています";

  static String m11(example) => "このルールの種類に合った内容を入力してください。例：${example}";

  static String m12(name) => "${name} は利用できません。既存のルールプロバイダーを選んでください";

  static String m13(name) => "${name} は利用できません。この設定から対象を選び直してください";

  static String m14(count) => "${count}日前";

  static String m15(label) => "選択された${label}を削除してもよろしいですか？";

  static String m16(label) => "現在の${label}を削除してもよろしいですか？";

  static String m17(label) => "${label}詳細";

  static String m18(count) => "独立した HTTPS 検査 2 件中 ${count} 件が成功";

  static String m19(label) => "${label}は空欄にできません";

  static String m20(count) => "${count} エントリ";

  static String m21(label) => "現在の${label}は既に存在しています";

  static String m22(date) => "有効期限: ${date}";

  static String m23(name) => "${name} スキップ済み";

  static String m24(name) => "${name} 更新済み";

  static String m25(name) => "${name}を更新中...";

  static String m26(name) => "グループ「${name}」が循環参照しています。メンバーを変更してください";

  static String m27(action) => "「${action}」で使用中です。保存するとこちらに移動します。";

  static String m28(modifiers) => "${modifiers} のいずれかを含めてください";

  static String m29(count) => "${count}時間前";

  static String m30(count) => "${count} 時間";

  static String m31(target) => "${target} は無効なポリシーです";

  static String m32(ruleSet) => "${ruleSet} は無効なルールセットです";

  static String m33(subRule) => "${subRule} は無効な SUB_RULE です";

  static String m34(line, message) => "${line}行目：${message}";

  static String m35(appName) =>
      "1. システム設定 > プライバシーとセキュリティ を開く\n2. 位置情報サービス を選択\n3. リストで ${appName} を見つけてチェックを入れる\n\n設定が完了したらアプリに戻ると、通常どおり使用できます。ご協力ありがとうございます";

  static String m36(label, max) => "${label}は最大${max}文字です";

  static String m37(size) => "${size} を解放しました";

  static String m38(count) => "${count}分前";

  static String m39(count) => "${count}ヶ月前";

  static String m40(code) =>
      "サーバーがアクセスを拒否しました（HTTP ${code}）。リンクの期限切れか、認証情報が誤っている可能性があります";

  static String m41(code) => "サーバーがリクエストを拒否しました（HTTP ${code}）";

  static String m42(code) =>
      "このアドレスには何も見つかりませんでした（HTTP ${code}）。URL が正しいか確認してください";

  static String m43(detail) => "ネットワークリクエストに失敗しました：${detail}";

  static String m44(code) => "サーバーで問題が発生しました（HTTP ${code}）。しばらくしてから再試行してください";

  static String m45(kept, total) => "${kept} / ${total} 件のノードを保持";

  static String m46(name) => "${name}、除外";

  static String m47(name) => "${name}、保持";

  static String m48(label) => "まだ${label}はありません";

  static String m49(label) => "${label}は数字でなければなりません";

  static String m50(name) => "「${name}」は使用済みです。個人グループの名前を変更してください";

  static String m51(name) => "名前 ${name} は他のプロキシまたはプロキシグループで使用されています";

  static String m52(path) => "プロキシグループが循環参照しています：${path}";

  static String m53(names) => "次のプロキシプロバイダーは存在しません：${names}";

  static String m54(names) => "次のプロキシまたはポリシーは存在しません：${names}";

  static String m55(name) => "${name} は組み込みポリシー名のため使用できません";

  static String m56(count) => "${count} 件に問題があり、上書きの適用に失敗する可能性があります";

  static String m57(id) => "プラン #${id}";

  static String m58(port) => "推奨ポート ${port} を入力しました";

  static String m59(label) => "${label} は 1024 から 49151 の間でなければなりません";

  static String m60(port) =>
      "混合ポート ${port} で待ち受けを開始できませんでした。他のアプリが使用している可能性があります。ポートを変更すると、すぐに再試行できます";

  static String m61(profiles) => "このリソースは ${profiles} で使用中です";

  static String m62(profiles) => "名前の変更で ${profiles} の参照先が変わります";

  static String m63(profiles) => "名前を変更する前に元のプロファイルの参照を編集してください：${profiles}";

  static String m64(profiles) => "参照の確認に必要なプロファイルを読み取れません：${profiles}";

  static String m65(count) => "プロキシ ${count} 件";

  static String m66(name) =>
      "ノード ${name} は別の有効なチェーンで使用されているか、プロキシチェーン関係の競合があります";

  static String m67(name) => "ノード ${name} はこの位置では使用できません";

  static String m68(address) => "起動前、システムプロキシは ${address} に設定されていました";

  static String m69(name) => "起動前、通信は別の VPN または仮想アダプター ${name} を経由していました";

  static String m70(count) => "${count}日";

  static String m71(count) => "${count}時間";

  static String m72(count) => "${count}分";

  static String m73(time) => "${time} に購入";

  static String m74(name, path) => "${name} は元の設定の ${path} で参照されています";

  static String m75(min, max) => "利用可能な範囲 ${min} – ${max}";

  static String m76(value) => "残り: ${value}";

  static String m77(count) => "残り${count}";

  static String m78(seconds) => "${seconds}秒後に再送信";

  static String m79(count) => "ルール ${count} 件";

  static String m80(appName) => "${appName}（セーフモード）";

  static String m81(count) => "${count} 秒";

  static String m82(count) => "${count} 件選択中";

  static String m83(label) => "${label}は1項目のみ指定できます";

  static String m84(fields) => "次の設定を確認してください：${fields}";

  static String m85(count) => "デバイス（${count}）";

  static String m86(name, profile) =>
      "${name} はプロファイル「${profile}」のルールまたはグループでまだ使われています";

  static String m87(region) => "リレー ${region}";

  static String m88(name) =>
      "このデバイスは ${name} から退出し、このデバイス上のログイン情報が削除されます。現在ネットワークに接続できない場合は、Tailscale の管理コンソールでデバイスを削除してください";

  static String m89(build) => "ビルド番号: ${build}";

  static String m90(version) => "バージョン：${version}";

  static String m91(label) => "${label}はURLである必要があります";

  static String m92(count) => "${count}年前";

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
    "accessControlDisabledDesc": MessageLookupByLibrary.simpleMessage(
      "アプリアクセス制御は無効です",
    ),
    "accessControlNotAllowDesc": MessageLookupByLibrary.simpleMessage(
      "選択したアプリをVPNから除外",
    ),
    "accessControlSettings": MessageLookupByLibrary.simpleMessage("アクセス制御設定"),
    "accessToken": MessageLookupByLibrary.simpleMessage("アクセストークン"),
    "account": MessageLookupByLibrary.simpleMessage("アカウント"),
    "accountBalance": MessageLookupByLibrary.simpleMessage("残高"),
    "action": MessageLookupByLibrary.simpleMessage("アクション"),
    "action_copyEnv": MessageLookupByLibrary.simpleMessage("プロキシ環境変数をコピー"),
    "action_delayTest": MessageLookupByLibrary.simpleMessage("ノード遅延を測定"),
    "action_directMode": MessageLookupByLibrary.simpleMessage("直接接続モード"),
    "action_exit": MessageLookupByLibrary.simpleMessage("終了"),
    "action_globalMode": MessageLookupByLibrary.simpleMessage("グローバルモード"),
    "action_mode": MessageLookupByLibrary.simpleMessage("モード切替"),
    "action_proxy": MessageLookupByLibrary.simpleMessage("システムプロキシ"),
    "action_ruleMode": MessageLookupByLibrary.simpleMessage("ルールモード"),
    "action_start": MessageLookupByLibrary.simpleMessage("開始/停止"),
    "action_tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "action_updateProfiles": MessageLookupByLibrary.simpleMessage("プロファイルを更新"),
    "action_view": MessageLookupByLibrary.simpleMessage("表示/非表示"),
    "activate": MessageLookupByLibrary.simpleMessage("アクティブ化"),
    "activatePlanConfirm": MessageLookupByLibrary.simpleMessage(
      "このプランをアクティブ化しますか？アクティブ化すると現在有効なプランになります",
    ),
    "activatePlanTitle": MessageLookupByLibrary.simpleMessage("プランをアクティブ化"),
    "add": MessageLookupByLibrary.simpleMessage("追加"),
    "addOverrideEntry": MessageLookupByLibrary.simpleMessage("上書き項目を追加"),
    "addProfile": MessageLookupByLibrary.simpleMessage("プロファイルを追加"),
    "addProxyChainNode": MessageLookupByLibrary.simpleMessage("追加"),
    "addProxyGroup": MessageLookupByLibrary.simpleMessage("プロキシグループを追加"),
    "addRule": MessageLookupByLibrary.simpleMessage("ルールを追加"),
    "addSsid": MessageLookupByLibrary.simpleMessage("SSIDを追加"),
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
    "amountDueLabel": MessageLookupByLibrary.simpleMessage("追加支払額"),
    "amountPayable": MessageLookupByLibrary.simpleMessage("今回のお支払い"),
    "announcement": MessageLookupByLibrary.simpleMessage("お知らせ"),
    "apiAvailable": MessageLookupByLibrary.simpleMessage("APIサービスは正常です"),
    "apiAvailableWithCertificateException": MessageLookupByLibrary.simpleMessage(
      "一時的な証明書の例外で API に接続できました。アカウントやノード設定は同期していません。証明書の問題を解決してから再確認してください。",
    ),
    "app": MessageLookupByLibrary.simpleMessage("アプリ"),
    "appAccessControl": MessageLookupByLibrary.simpleMessage("アプリアクセス制御"),
    "appProviderLibrary": MessageLookupByLibrary.simpleMessage("プロバイダーライブラリ"),
    "appendSystemDns": MessageLookupByLibrary.simpleMessage("システムDNSを追加"),
    "appendSystemDnsTip": MessageLookupByLibrary.simpleMessage(
      "設定にシステムDNSを強制的に追加します",
    ),
    "application": MessageLookupByLibrary.simpleMessage("アプリケーション"),
    "applicationDesc": MessageLookupByLibrary.simpleMessage("アプリ関連設定を変更"),
    "authentication": MessageLookupByLibrary.simpleMessage("ローカルプロキシ認証"),
    "authenticationApplyFailed": MessageLookupByLibrary.simpleMessage(
      "認証設定を適用できませんでした",
    ),
    "authenticationDesc": MessageLookupByLibrary.simpleMessage(
      "HTTP/SOCKS プロキシにユーザー名とパスワードを設定します。システム HTTP プロキシの自動設定は停止しますが、TUN/VPN は利用できます",
    ),
    "authenticationPasswordInvalid": MessageLookupByLibrary.simpleMessage(
      "制御文字を含まない 1～255 UTF-8 バイトを入力してください",
    ),
    "authenticationSystemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "ローカルプロキシ認証が有効な間は設定されません",
    ),
    "authenticationUsernameInvalid": MessageLookupByLibrary.simpleMessage(
      "コロンや制御文字を含まない 1～255 UTF-8 バイトを入力してください",
    ),
    "authorized": MessageLookupByLibrary.simpleMessage("許可済み"),
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
    "availableBalance": m0,
    "availablePlans": MessageLookupByLibrary.simpleMessage("プランを選択"),
    "back": MessageLookupByLibrary.simpleMessage("戻る"),
    "backup": MessageLookupByLibrary.simpleMessage("バックアップ"),
    "backupAndRestore": MessageLookupByLibrary.simpleMessage("バックアップと復元"),
    "backupAndRestoreDesc": MessageLookupByLibrary.simpleMessage(
      "WebDAVまたはファイルを介してデータを同期する",
    ),
    "backupFromNewerVersion": MessageLookupByLibrary.simpleMessage(
      "このバックアップは新しいバージョンのアプリで作成されています。アプリを更新してから復元してください",
    ),
    "backupRetention": MessageLookupByLibrary.simpleMessage("保持するバックアップ数"),
    "backupRetentionDesc": MessageLookupByLibrary.simpleMessage(
      "バックアップのたびにこのデバイスの古い WebDAV バックアップを削除",
    ),
    "backupSuccess": MessageLookupByLibrary.simpleMessage("バックアップ成功"),
    "balance": MessageLookupByLibrary.simpleMessage("残高"),
    "balanceDeductionHint": MessageLookupByLibrary.simpleMessage(
      "購入時は残高から優先して差し引かれ、不足分はコミッションで自動的に補われます",
    ),
    "basicConfig": MessageLookupByLibrary.simpleMessage("基本設定"),
    "basicConfigDesc": MessageLookupByLibrary.simpleMessage("基本設定をグローバルに変更"),
    "basicInfo": MessageLookupByLibrary.simpleMessage("基本情報"),
    "basicStrategy": MessageLookupByLibrary.simpleMessage("基本ポリシー"),
    "batchAdd": MessageLookupByLibrary.simpleMessage("一括追加"),
    "batchListInputTip": MessageLookupByLibrary.simpleMessage(
      "1行に1項目、またはカンマ区切りで入力してください",
    ),
    "batchMapInputTip": MessageLookupByLibrary.simpleMessage(
      "1行に1件、キーと値はスペースで区切ってください",
    ),
    "batchPreviewTip": m1,
    "batteryOptimizationDesc": MessageLookupByLibrary.simpleMessage(
      "バックグラウンドでの動作を維持するため、このアプリの電池の最適化を無効にしてください。タップすると設定を開きます。",
    ),
    "batteryOptimizationStatusTip": MessageLookupByLibrary.simpleMessage(
      "システムの制限により、実行中は電池の最適化の状態を正しく取得できません",
    ),
    "behavior": MessageLookupByLibrary.simpleMessage("動作"),
    "billingPeriodLabel": MessageLookupByLibrary.simpleMessage("請求期間"),
    "bind": MessageLookupByLibrary.simpleMessage("バインド"),
    "bindCoupon": MessageLookupByLibrary.simpleMessage("クーポンを適用"),
    "bindCouponIntro": MessageLookupByLibrary.simpleMessage(
      "公式のクーポンコードを入力してください。残りの期間に応じて差額を精算し、継続割引のコードは更新価格も変更します。",
    ),
    "blacklistMode": MessageLookupByLibrary.simpleMessage("ブラックリストモード"),
    "blockQuic": MessageLookupByLibrary.simpleMessage("QUICをブロック"),
    "blockQuicDesc": MessageLookupByLibrary.simpleMessage(
      "UDP 443のトラフィックを拒否し、接続をTCPにフォールバックさせます",
    ),
    "blockWebRtc": MessageLookupByLibrary.simpleMessage("WebRTCをブロック"),
    "blockWebRtcDesc": MessageLookupByLibrary.simpleMessage(
      "WebRTCのIP漏洩を抑えるためSTUN通信を拒否します。通話やライブ音声が利用できなくなる場合があります",
    ),
    "buy": MessageLookupByLibrary.simpleMessage("購入"),
    "bypassDomain": MessageLookupByLibrary.simpleMessage("バイパスドメイン"),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage("システムプロキシ有効時のみ適用"),
    "cacheAlgorithm": MessageLookupByLibrary.simpleMessage("キャッシュアルゴリズム"),
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "キャッシュが破損しています。クリアしますか？",
    ),
    "cacheMaxSize": MessageLookupByLibrary.simpleMessage("キャッシュサイズ"),
    "calculatingQuote": MessageLookupByLibrary.simpleMessage("計算中…"),
    "cameraPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "QRコードをスキャンするには、システム設定でカメラへのアクセスを許可するか、アルバムからQRコード画像を選択してください。",
    ),
    "cameraPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "カメラの権限が必要です",
    ),
    "cameraUnavailable": MessageLookupByLibrary.simpleMessage("カメラを使用できません"),
    "cancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
    "cancelSelectAll": MessageLookupByLibrary.simpleMessage("全選択解除"),
    "certificateCheckOnlyHint": MessageLookupByLibrary.simpleMessage(
      "この操作は API の接続確認のみです。アカウントへのログインやノード設定のダウンロードは行いません。",
    ),
    "certificateExpired": MessageLookupByLibrary.simpleMessage(
      "証明書の有効期限が切れています",
    ),
    "certificateHostnameHint": MessageLookupByLibrary.simpleMessage(
      "別のネットワークを試し、Wi-Fi のログイン認証を完了してください。解決しない場合はサービス提供元に証明書とサーバードメインの一致を確認してもらってください。",
    ),
    "certificateHostnameMismatch": MessageLookupByLibrary.simpleMessage(
      "証明書が接続先ドメインと一致しません",
    ),
    "certificateNotYetValid": MessageLookupByLibrary.simpleMessage(
      "証明書はまだ有効ではありません",
    ),
    "certificateRevoked": MessageLookupByLibrary.simpleMessage("証明書は失効しています"),
    "certificateRevokedHint": MessageLookupByLibrary.simpleMessage(
      "サービス提供元に失効した証明書の交換を依頼してください。再試行やシステム時刻の変更では解決しません。",
    ),
    "certificateSyncRetryDescription": MessageLookupByLibrary.simpleMessage(
      "確認後、接続確認、アカウント更新、ノード設定のダウンロードを行います。一時的な証明書の例外は今回の同期終了時に解除されます。",
    ),
    "certificateUnknownHint": MessageLookupByLibrary.simpleMessage(
      "システムの日時を確認し、別のネットワークで再試行してください。引き続き検証できない場合は、このエラーをサービス提供元に伝えてください。",
    ),
    "certificateUntrusted": MessageLookupByLibrary.simpleMessage(
      "証明書チェーンを信頼できません",
    ),
    "certificateUntrustedHint": MessageLookupByLibrary.simpleMessage(
      "スマートフォンのテザリングなど別のネットワークで再試行し、システム更新を確認してください。セキュリティソフトや社内ネットワークが HTTPS を検査する場合は管理者に確認してください。解決しない場合はサービス提供元に証明書チェーンの確認を依頼してください。",
    ),
    "certificateValidityHint": MessageLookupByLibrary.simpleMessage(
      "まずシステムの日付と時刻を同期してください。時刻が正しい場合は、サーバー証明書の修正が必要です。",
    ),
    "changelogBreaking": MessageLookupByLibrary.simpleMessage("破壊的変更"),
    "changelogFeatures": MessageLookupByLibrary.simpleMessage("新機能"),
    "changelogFixes": MessageLookupByLibrary.simpleMessage("不具合修正"),
    "changelogPerformance": MessageLookupByLibrary.simpleMessage("パフォーマンス"),
    "changelogReverts": MessageLookupByLibrary.simpleMessage("取り消し"),
    "checkApi": MessageLookupByLibrary.simpleMessage("APIをチェック"),
    "checkRouting": MessageLookupByLibrary.simpleMessage("設定を確認"),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("更新を確認"),
    "checkUpdateError": MessageLookupByLibrary.simpleMessage("アプリは最新版です"),
    "checkUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "更新の確認に失敗しました。ネットワークを確認して再試行してください",
    ),
    "checkingPayment": MessageLookupByLibrary.simpleMessage("確認中..."),
    "chooseMembers": MessageLookupByLibrary.simpleMessage("メンバーを選択"),
    "clearCustomRouting": MessageLookupByLibrary.simpleMessage("一括クリア"),
    "clearData": MessageLookupByLibrary.simpleMessage("データを消去"),
    "clearProxyChain": MessageLookupByLibrary.simpleMessage("チェーン設定を削除"),
    "clearSearch": MessageLookupByLibrary.simpleMessage("検索をクリア"),
    "clipboardExport": MessageLookupByLibrary.simpleMessage("クリップボードへエクスポート"),
    "clipboardImport": MessageLookupByLibrary.simpleMessage("クリップボードからインポート"),
    "clipboardWriteFailed": MessageLookupByLibrary.simpleMessage(
      "クリップボードにコピーできませんでした。選択範囲が大きすぎる可能性があります",
    ),
    "close": MessageLookupByLibrary.simpleMessage("閉じる"),
    "closeAllConnections": MessageLookupByLibrary.simpleMessage("すべての接続を閉じる"),
    "cloudApiAccessDenied": MessageLookupByLibrary.simpleMessage(
      "ネットワークへのアクセスが拒否されました",
    ),
    "cloudApiAddressInUse": MessageLookupByLibrary.simpleMessage(
      "ネットワークアドレスまたはポートは使用中です",
    ),
    "cloudApiAddressUnavailable": MessageLookupByLibrary.simpleMessage(
      "ネットワークアドレスを利用できません",
    ),
    "cloudApiBadGateway": MessageLookupByLibrary.simpleMessage(
      "ゲートウェイが上流から無効な応答を受信しました",
    ),
    "cloudApiBadRequest": MessageLookupByLibrary.simpleMessage(
      "サーバーがリクエストを無効と判断しました",
    ),
    "cloudApiClockSkew": MessageLookupByLibrary.simpleMessage(
      "端末の時計がサーバーとずれすぎています。日時の自動設定をオンにして再試行してください。",
    ),
    "cloudApiConnectTimeout": MessageLookupByLibrary.simpleMessage(
      "接続がタイムアウトしました",
    ),
    "cloudApiConnectionAborted": MessageLookupByLibrary.simpleMessage(
      "接続が中止されました",
    ),
    "cloudApiConnectionFailed": MessageLookupByLibrary.simpleMessage(
      "接続に失敗しました",
    ),
    "cloudApiConnectionRefused": MessageLookupByLibrary.simpleMessage(
      "接続が拒否されました",
    ),
    "cloudApiConnectionReset": MessageLookupByLibrary.simpleMessage(
      "接続がリセットされました",
    ),
    "cloudApiDnsEmpty": MessageLookupByLibrary.simpleMessage(
      "DNS が空の応答を返しました。妨害またはシステム DNS の異常の可能性があります",
    ),
    "cloudApiDnsFailed": MessageLookupByLibrary.simpleMessage(
      "DNS 名前解決に失敗しました",
    ),
    "cloudApiDnsUnknownHost": MessageLookupByLibrary.simpleMessage(
      "DNS がこのドメインを見つけられませんでした",
    ),
    "cloudApiForbidden": MessageLookupByLibrary.simpleMessage(
      "サーバーへのアクセスが拒否されました",
    ),
    "cloudApiGatewayTimeout": MessageLookupByLibrary.simpleMessage(
      "ゲートウェイで上流サーバーの応答待ちがタイムアウトしました",
    ),
    "cloudApiHttpError": m2,
    "cloudApiInvalidResponse": MessageLookupByLibrary.simpleMessage(
      "サーバー応答の形式が無効です",
    ),
    "cloudApiMethodNotAllowed": MessageLookupByLibrary.simpleMessage(
      "このリクエストメソッドは許可されていません",
    ),
    "cloudApiNetworkAuthRequired": MessageLookupByLibrary.simpleMessage(
      "このネットワークでは接続前にログインが必要です",
    ),
    "cloudApiNetworkResourcesExhausted": MessageLookupByLibrary.simpleMessage(
      "システムのネットワークリソースが不足しています",
    ),
    "cloudApiNetworkUnreachable": MessageLookupByLibrary.simpleMessage(
      "ネットワークに到達できません",
    ),
    "cloudApiNotFound": MessageLookupByLibrary.simpleMessage(
      "要求された API またはリソースが見つかりません",
    ),
    "cloudApiProxyAuthFailed": MessageLookupByLibrary.simpleMessage(
      "プロキシ認証に失敗しました（HTTP 407）",
    ),
    "cloudApiProxyFailed": MessageLookupByLibrary.simpleMessage(
      "プロキシ接続に失敗しました",
    ),
    "cloudApiRateLimited": MessageLookupByLibrary.simpleMessage(
      "リクエストが多すぎます。しばらくしてから再試行してください",
    ),
    "cloudApiReceiveTimeout": MessageLookupByLibrary.simpleMessage(
      "サーバー応答がタイムアウトしました",
    ),
    "cloudApiRedirectInvalid": MessageLookupByLibrary.simpleMessage(
      "サーバーのリダイレクトが無効です",
    ),
    "cloudApiRedirectLimit": MessageLookupByLibrary.simpleMessage(
      "サーバーのリダイレクト回数が多すぎます",
    ),
    "cloudApiRedirectLoop": MessageLookupByLibrary.simpleMessage(
      "サーバーのリダイレクトがループしています",
    ),
    "cloudApiRequestCanceled": MessageLookupByLibrary.simpleMessage(
      "リクエストがキャンセルされました",
    ),
    "cloudApiRequestTooLarge": MessageLookupByLibrary.simpleMessage(
      "リクエストがサーバーのサイズ制限を超えています",
    ),
    "cloudApiResponseInterrupted": MessageLookupByLibrary.simpleMessage(
      "応答の受信が完了する前に接続が切断されました",
    ),
    "cloudApiResponseTooLarge": MessageLookupByLibrary.simpleMessage(
      "サーバーの応答が許容サイズを超えています",
    ),
    "cloudApiRouteDirect": m3,
    "cloudApiRouteProxy": m4,
    "cloudApiSendTimeout": MessageLookupByLibrary.simpleMessage(
      "リクエスト送信がタイムアウトしました",
    ),
    "cloudApiServerError": MessageLookupByLibrary.simpleMessage("サーバー内部エラー"),
    "cloudApiServerRequestTimeout": MessageLookupByLibrary.simpleMessage(
      "サーバーでリクエストの受信がタイムアウトしました",
    ),
    "cloudApiServerUnconfigured": MessageLookupByLibrary.simpleMessage(
      "サーバーにこのアプリの鍵が設定されていません。サポートにご連絡ください。",
    ),
    "cloudApiServiceUnavailable": MessageLookupByLibrary.simpleMessage(
      "サービスは一時的に利用できません",
    ),
    "cloudApiSignatureRejected": MessageLookupByLibrary.simpleMessage(
      "サーバーがこのアプリの署名を拒否しました。公式の最新版を再インストールしてください。",
    ),
    "cloudApiSystemError": m5,
    "cloudApiTimeout": MessageLookupByLibrary.simpleMessage("リクエストがタイムアウトしました"),
    "cloudApiTlsAlgorithmFailed": MessageLookupByLibrary.simpleMessage(
      "TLS 暗号アルゴリズムのネゴシエーションに失敗しました",
    ),
    "cloudApiTlsFailed": MessageLookupByLibrary.simpleMessage(
      "TLS ハンドシェイクに失敗しました",
    ),
    "cloudApiTlsInterrupted": MessageLookupByLibrary.simpleMessage(
      "TLS ハンドシェイクの完了前に接続が切断されました",
    ),
    "cloudApiTlsProtocolFailed": MessageLookupByLibrary.simpleMessage(
      "TLS プロトコルに互換性がないか、TLS 応答が無効です",
    ),
    "cloudCertificateSyncFailed": MessageLookupByLibrary.simpleMessage(
      "API の接続確認には成功しましたが、アカウントまたはノード設定の同期に失敗しました",
    ),
    "cloudConfigSyncIncomplete": MessageLookupByLibrary.simpleMessage(
      "ノード設定をダウンロードできませんでした。ダウンロード時のエラーを解決してから再同期してください。",
    ),
    "cloudSyncedWithCertificateException": MessageLookupByLibrary.simpleMessage(
      "一時的な証明書の例外でアカウントと設定を同期しました。証明書の検証は復元されています。次回の同期前に証明書の問題を解決してください。",
    ),
    "codeSent": MessageLookupByLibrary.simpleMessage("認証コードを送信しました"),
    "collapseList": MessageLookupByLibrary.simpleMessage("折りたたむ"),
    "color": MessageLookupByLibrary.simpleMessage("カラー"),
    "colorSchemes": MessageLookupByLibrary.simpleMessage("カラースキーム"),
    "columns": MessageLookupByLibrary.simpleMessage("列"),
    "commission": MessageLookupByLibrary.simpleMessage("コミッション"),
    "commissionBalance": m6,
    "compatible": MessageLookupByLibrary.simpleMessage("互換モード"),
    "configDataDetected": MessageLookupByLibrary.simpleMessage(
      "設定内にデータが検出されました",
    ),
    "configParseErrorAtLine": m7,
    "configRecoveryKeyring": MessageLookupByLibrary.simpleMessage(
      "システムのキーリング（Secret Service）にアクセスできないため、システム設定で KDE ウォレットまたは GNOME キーリングを有効にしてロックを解除してから再試行してください",
    ),
    "configRecoveryMessage": MessageLookupByLibrary.simpleMessage(
      "現在、ローカル設定を読み込めません。既存のデータは保持されています。端末のロックを解除して再試行するか、後でアプリを開き直してください",
    ),
    "configRecoveryMissingKey": MessageLookupByLibrary.simpleMessage(
      "既存の設定の暗号化キーが見つからないか無効です。元のデバイスの元のユーザーで実行するか、バックアップを復元してください。再試行しても失われたキーは再生成できません",
    ),
    "configRecoveryReset": MessageLookupByLibrary.simpleMessage("バックアップしてリセット"),
    "configRecoveryResetConfirm": MessageLookupByLibrary.simpleMessage(
      "すべてのローカル設定、サブスクリプション、ルール、アカウントデータを暗号化してバックアップし、アプリをリセットしますか？再ログインと、設定およびサブスクリプションの復元またはインポートが必要です。バックアップは現在の Windows ユーザーで保護されますが、失われた暗号化キーは復元できません",
    ),
    "configRecoveryResetDone": MessageLookupByLibrary.simpleMessage(
      "元のデータを以下のフォルダーに暗号化してバックアップしました。アプリを終了して再度開き、設定を行ってください",
    ),
    "configRecoveryResetFailed": MessageLookupByLibrary.simpleMessage(
      "暗号化バックアップとリセットを完了できませんでした。バックアップを検証するまで残っている元のデータは削除されません。再試行するか、アプリを終了して再度開いて完了してください",
    ),
    "configRecoveryRetry": MessageLookupByLibrary.simpleMessage("再試行"),
    "configRecoveryStorage": MessageLookupByLibrary.simpleMessage(
      "ローカル設定または暗号化キーを読み書きできません。アプリのデータフォルダーとシステムの安全なストレージへのアクセス権を確認して再試行してください",
    ),
    "configRecoveryTitle": MessageLookupByLibrary.simpleMessage("ローカル設定の復元"),
    "configRecoveryUnreadable": MessageLookupByLibrary.simpleMessage(
      "ローカル設定を復号できないか、ファイルが破損しています。元のファイルは保持されています。対応するキーと設定のバックアップを復元するか、バックアップしてリセットしてください",
    ),
    "configRecoveryUseLocalStorage": MessageLookupByLibrary.simpleMessage(
      "ローカルファイルに保存",
    ),
    "configRecoveryUseLocalStorageConfirm":
        MessageLookupByLibrary.simpleMessage(
          "暗号化キーとアカウントの認証情報を、システムのキーリングではなくアプリのデータフォルダー内の現在のユーザーだけがアクセスできるファイルに保存しますか？現在のユーザーとして動作するプログラムはそれらを読み取ってローカル設定を復号でき、この選択は今後も維持されます",
        ),
    "configTypeMismatch": m8,
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
    "confirmClearCustomRouting": MessageLookupByLibrary.simpleMessage(
      "このプロファイルのカスタムプロキシグループとルールを消去しますか？サブスクリプションの内容、追加ルール、プロキシチェーン、カスタムノードは保持されます",
    ),
    "confirmExitWindow": MessageLookupByLibrary.simpleMessage(
      "現在のウィンドウを閉じてもよろしいですか？",
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
    "coreBlockedByPolicyTip": m9,
    "coreStatus": MessageLookupByLibrary.simpleMessage("コアステータス"),
    "crashTest": MessageLookupByLibrary.simpleMessage("クラッシュテスト"),
    "create": MessageLookupByLibrary.simpleMessage("作成"),
    "creationTime": MessageLookupByLibrary.simpleMessage("作成時間"),
    "custom": MessageLookupByLibrary.simpleMessage("カスタム"),
    "customOutboundInUse": m10,
    "customRoutingDraftHint": MessageLookupByLibrary.simpleMessage(
      "カスタム設定を入力してから、カスタムモードに切り替えてください。下書きの編集では現在のモードは変わりません",
    ),
    "customRuleChooseProvider": MessageLookupByLibrary.simpleMessage(
      "ルールプロバイダーを選択",
    ),
    "customRuleChooseTarget": MessageLookupByLibrary.simpleMessage("対象を選択"),
    "customRuleDomainSuffixHint": MessageLookupByLibrary.simpleMessage(
      "このドメインとサブドメインに一致します。https:// やパスを含めずに入力してください",
    ),
    "customRuleForm": MessageLookupByLibrary.simpleMessage("フォーム"),
    "customRuleFormUnavailable": MessageLookupByLibrary.simpleMessage(
      "このルールは高度な構文を使用しています。すべての設定を保持するにはテキストを編集してください",
    ),
    "customRuleInvalidContent": m11,
    "customRuleInvalidSyntax": MessageLookupByLibrary.simpleMessage(
      "種類、内容、対象が有効な完全なルールを入力してください",
    ),
    "customRuleMatchHint": MessageLookupByLibrary.simpleMessage(
      "残りのすべての通信に一致します。これより下のルールは適用されません",
    ),
    "customRuleNoResolveHint": MessageLookupByLibrary.simpleMessage(
      "ドメインを解決せず、既知の IP アドレスと照合します",
    ),
    "customRuleRaw": MessageLookupByLibrary.simpleMessage("テキスト"),
    "customRuleRawHint": MessageLookupByLibrary.simpleMessage(
      "完全なルールを1行で入力します。高度な式はそのまま保持されます",
    ),
    "customRuleTargetHint": MessageLookupByLibrary.simpleMessage(
      "ポリシーグループ、プロキシ、組み込み動作を選択します",
    ),
    "customRuleType": MessageLookupByLibrary.simpleMessage("ルールの種類"),
    "customRuleUnavailableProvider": m12,
    "customRuleUnavailableTarget": m13,
    "customUserAgent": MessageLookupByLibrary.simpleMessage("カスタム（手動入力）"),
    "customUserAgentHint": MessageLookupByLibrary.simpleMessage(
      "User-Agentの値を省略せずに入力",
    ),
    "customUserAgentInvalid": MessageLookupByLibrary.simpleMessage(
      "半角英数字、スペース、標準的な記号のみ使用できます",
    ),
    "cut": MessageLookupByLibrary.simpleMessage("切り取り"),
    "dark": MessageLookupByLibrary.simpleMessage("ダーク"),
    "dashboard": MessageLookupByLibrary.simpleMessage("ダッシュボード"),
    "dataChangedSave": MessageLookupByLibrary.simpleMessage(
      "データの変更を検出しました。保存しますか？",
    ),
    "daysAgo": m14,
    "defaultNameserver": MessageLookupByLibrary.simpleMessage("デフォルトネームサーバー"),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "DNSサーバーの解決用",
    ),
    "defaultText": MessageLookupByLibrary.simpleMessage("デフォルト"),
    "delay": MessageLookupByLibrary.simpleMessage("遅延"),
    "delayConcurrency": MessageLookupByLibrary.simpleMessage("一括測定の同時実行数"),
    "delayConcurrencyAndroidDesc": MessageLookupByLibrary.simpleMessage(
      "Android の既定値は 16、回線が混雑する場合は減らしてください。次回の一括測定から適用",
    ),
    "delayConcurrencyDesc": MessageLookupByLibrary.simpleMessage(
      "既定値は 50、回線が混雑する場合は減らしてください。次回の一括測定から適用",
    ),
    "delayTest": MessageLookupByLibrary.simpleMessage("遅延テスト"),
    "delayTestFailed": MessageLookupByLibrary.simpleMessage("測定失敗"),
    "delayTestQueued": MessageLookupByLibrary.simpleMessage("待機中"),
    "delayTestRunning": MessageLookupByLibrary.simpleMessage("測定中"),
    "delete": MessageLookupByLibrary.simpleMessage("削除"),
    "deleteBackupTip": MessageLookupByLibrary.simpleMessage(
      "このバックアップを WebDAV から削除しますか？",
    ),
    "deleteMultipTip": m15,
    "deleteTip": m16,
    "desc": MessageLookupByLibrary.simpleMessage(
      "ClashMetaベースのマルチプラットフォームプロキシクライアント。シンプルで使いやすく、オープンソースで広告なし",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("宛先"),
    "destinationGeoIP": MessageLookupByLibrary.simpleMessage("宛先地理情報"),
    "destinationIPASN": MessageLookupByLibrary.simpleMessage("宛先IP ASN"),
    "details": m17,
    "detectionTip": MessageLookupByLibrary.simpleMessage("サードパーティAPIに依存（参考値）"),
    "developerMode": MessageLookupByLibrary.simpleMessage("デベロッパーモード"),
    "developerModeEnableTip": MessageLookupByLibrary.simpleMessage(
      "デベロッパーモードが有効になりました",
    ),
    "diagAllFailed": MessageLookupByLibrary.simpleMessage(
      "このグループの今回の速度テストはすべて失敗しました。テスト URL に到達できない可能性もあります。ネットワーク診断を実行できます",
    ),
    "diagCanceled": MessageLookupByLibrary.simpleMessage(
      "診断はキャンセルされました。結果は不完全です",
    ),
    "diagCaptureHint": MessageLookupByLibrary.simpleMessage(
      "システムプロキシまたは TUN を有効にするか、対象アプリにローカルプロキシを設定してください",
    ),
    "diagClock": MessageLookupByLibrary.simpleMessage("システム時刻の比較"),
    "diagClockHint": MessageLookupByLibrary.simpleMessage(
      "システムの日時自動設定を有効にして再試行してください。時刻のずれは証明書検証と oixCloud DNS 署名に影響する場合があります",
    ),
    "diagClockReady": MessageLookupByLibrary.simpleMessage(
      "今回の確認では一貫した大きな時刻差は見つかりませんでした",
    ),
    "diagClockSkew": MessageLookupByLibrary.simpleMessage(
      "独立した 2 件の応答が 5 分以上の時刻差の可能性を示しています",
    ),
    "diagClockUnknown": MessageLookupByLibrary.simpleMessage(
      "時刻比較に必要な未キャッシュの HTTPS 応答が不足しています",
    ),
    "diagCopy": MessageLookupByLibrary.simpleMessage("診断レポートをコピー"),
    "diagCore": MessageLookupByLibrary.simpleMessage("コア応答"),
    "diagCoreDns": MessageLookupByLibrary.simpleMessage("コア DNS"),
    "diagCoreHint": MessageLookupByLibrary.simpleMessage(
      "接続スイッチと Wi-Fi 除外を確認してください。コアが応答しない場合は再起動し、クライアントとコアのバージョンを揃えてください",
    ),
    "diagCoreReady": MessageLookupByLibrary.simpleMessage(
      "コアが応答し、リスナーの起動を報告しました",
    ),
    "diagCoreStopped": MessageLookupByLibrary.simpleMessage(
      "コアのトラフィック転送が停止しています",
    ),
    "diagCoreUnknown": MessageLookupByLibrary.simpleMessage(
      "コアの診断結果を取得できないか、診断中に設定が変わりました",
    ),
    "diagDisabled": MessageLookupByLibrary.simpleMessage("このオプションは無効です"),
    "diagDnsHint": MessageLookupByLibrary.simpleMessage(
      "DNS の上書き設定を確認し、別のネットワークでも試してください。システム DNS のみ成功する場合は設定内の DNS を確認してください",
    ),
    "diagDnsNoAnswer": MessageLookupByLibrary.simpleMessage(
      "DNS が有効なアドレスを返しませんでした。この結果だけでは認証失敗とは断定できません",
    ),
    "diagDnsPartial": MessageLookupByLibrary.simpleMessage("一部のドメインのみ解決できました"),
    "diagDnsReady": MessageLookupByLibrary.simpleMessage("確認したドメインを解決できました"),
    "diagDnsRefused": MessageLookupByLibrary.simpleMessage("DNS リクエストが拒否されました"),
    "diagEntryHint": MessageLookupByLibrary.simpleMessage(
      "コア、システムプロキシ、TUN、DNS を確認",
    ),
    "diagFailed": MessageLookupByLibrary.simpleMessage("失敗"),
    "diagFixApplyProfile": MessageLookupByLibrary.simpleMessage("構成を適用"),
    "diagFixEnableSystemProxy": MessageLookupByLibrary.simpleMessage(
      "システムプロキシを有効化",
    ),
    "diagFixFailed": MessageLookupByLibrary.simpleMessage(
      "修復を適用できませんでした。上記の提案に従って手動で対処してください",
    ),
    "diagFixRestartConnection": MessageLookupByLibrary.simpleMessage("再接続"),
    "diagFixRestartCore": MessageLookupByLibrary.simpleMessage("コアを再起動"),
    "diagFixRetest": MessageLookupByLibrary.simpleMessage("ノードを再テスト"),
    "diagFixStart": MessageLookupByLibrary.simpleMessage("接続を開始"),
    "diagFixSystemProxy": MessageLookupByLibrary.simpleMessage("システムプロキシを再設定"),
    "diagFixTun": MessageLookupByLibrary.simpleMessage("TUN を再有効化"),
    "diagFixing": MessageLookupByLibrary.simpleMessage("修復を適用しています。完了後に再確認します"),
    "diagListener": MessageLookupByLibrary.simpleMessage("ローカルプロキシ入口"),
    "diagListenerFailed": MessageLookupByLibrary.simpleMessage(
      "指定プロキシポートが応答しないか、コアのポートと一致しません",
    ),
    "diagListenerHint": MessageLookupByLibrary.simpleMessage(
      "ポート競合やリスナー停止を確認してください。再接続し、必要ならネットワーク設定で混合ポートを変更してください",
    ),
    "diagListenerReady": MessageLookupByLibrary.simpleMessage(
      "指定ポートがプロキシプロトコルに応答しました",
    ),
    "diagNoCapture": MessageLookupByLibrary.simpleMessage(
      "システムプロキシと TUN が両方とも無効です",
    ),
    "diagOixDns": MessageLookupByLibrary.simpleMessage("oixCloud 署名付き DNS"),
    "diagOixDnsAuthMissing": MessageLookupByLibrary.simpleMessage(
      "管理対象 DNS の署名機能が準備できていません",
    ),
    "diagOixDnsHint": MessageLookupByLibrary.simpleMessage(
      "クライアントのバージョンとシステム時刻を確認し、サブスクリプションを更新してください。解決しない場合は診断レポートをサポートへ共有してください",
    ),
    "diagOixDnsNoSample": MessageLookupByLibrary.simpleMessage(
      "今回の確認に使える管理対象ノードのドメインがありません",
    ),
    "diagPassed": MessageLookupByLibrary.simpleMessage("成功"),
    "diagProfile": MessageLookupByLibrary.simpleMessage("適用済み設定"),
    "diagProfileHint": MessageLookupByLibrary.simpleMessage(
      "有効な設定を選び、接続を開始してから再確認してください",
    ),
    "diagProfileMissing": MessageLookupByLibrary.simpleMessage("選択した設定は未適用です"),
    "diagProfileReady": MessageLookupByLibrary.simpleMessage("選択した設定は適用済みです"),
    "diagProxyAutomatic": MessageLookupByLibrary.simpleMessage(
      "自動プロキシ設定があります。実際の経路は未確認です",
    ),
    "diagProxyDifferent": MessageLookupByLibrary.simpleMessage(
      "OS のプロキシがアプリのポートと一致しません",
    ),
    "diagProxyDisabled": MessageLookupByLibrary.simpleMessage(
      "アプリでは有効ですが、OS のシステムプロキシは無効です",
    ),
    "diagProxyHint": MessageLookupByLibrary.simpleMessage(
      "システムプロキシを再度有効にし、他のプロキシアプリや組織ポリシーによる制御を確認してください。独自設定を使うアプリもあります",
    ),
    "diagProxyPath": MessageLookupByLibrary.simpleMessage("ローカルプロキシ経由の接続"),
    "diagProxyPathHint": MessageLookupByLibrary.simpleMessage(
      "システム経路が成功する場合は、選択ノード、ルール、コア DNS を確認してください。検査サイト 1 つの失敗だけですべてのノードが使えないとは言えません",
    ),
    "diagProxyReady": MessageLookupByLibrary.simpleMessage(
      "HTTP と HTTPS プロキシが指定ローカルポートを指しています",
    ),
    "diagRun": MessageLookupByLibrary.simpleMessage("診断を開始"),
    "diagScope": MessageLookupByLibrary.simpleMessage(
      "現在の接続を少数のサンプルで確認します。システム経路も TUN を通る場合があります。すべてのアプリやノードを保証するものではありません",
    ),
    "diagSkipped": MessageLookupByLibrary.simpleMessage("スキップ"),
    "diagSuspended": MessageLookupByLibrary.simpleMessage(
      "現在の Wi-Fi 除外設定により転送が一時停止しています",
    ),
    "diagSystemDns": MessageLookupByLibrary.simpleMessage("システム DNS"),
    "diagSystemPath": MessageLookupByLibrary.simpleMessage("システムのネットワーク経路"),
    "diagSystemPathHint": MessageLookupByLibrary.simpleMessage(
      "この経路はアプリの HTTP プロキシを明示的には使いませんが、TUN を通る場合があります。DNS、フィルタリング、検査サイトの影響を考慮し、プロキシ結果と比較してください",
    ),
    "diagSystemProxy": MessageLookupByLibrary.simpleMessage("システムプロキシ設定"),
    "diagTitle": MessageLookupByLibrary.simpleMessage("ネットワーク診断"),
    "diagTrafficCapture": MessageLookupByLibrary.simpleMessage("トラフィックの取り込み"),
    "diagTun": MessageLookupByLibrary.simpleMessage("TUN インターフェースと経路"),
    "diagTunHint": MessageLookupByLibrary.simpleMessage(
      "TUN を再度有効にし、システム認証を完了してください。経路が違う場合は他の VPN を確認してください。IPv6、UDP、アプリ除外は別途確認が必要です",
    ),
    "diagTunMissing": MessageLookupByLibrary.simpleMessage(
      "コアに対応する TUN が有効な状態で見つかりません",
    ),
    "diagTunReady": MessageLookupByLibrary.simpleMessage(
      "コアの TUN は有効で、確認した IPv4 経路もそこを通ります",
    ),
    "diagTunRouteMismatch": MessageLookupByLibrary.simpleMessage(
      "TUN は有効ですが、確認した IPv4 経路は別のインターフェースを通ります",
    ),
    "diagTunRouteUnknown": MessageLookupByLibrary.simpleMessage(
      "TUN は有効ですが、IPv4 経路を確認できません",
    ),
    "diagUnknown": MessageLookupByLibrary.simpleMessage("確認できません"),
    "diagWarning": MessageLookupByLibrary.simpleMessage("確認が必要"),
    "diagWebResult": m18,
    "dialerProxy": MessageLookupByLibrary.simpleMessage("ダイヤラープロキシ"),
    "dialerProxyDesc": MessageLookupByLibrary.simpleMessage(
      "NTPサーバーへの接続に使用するアウトバウンド",
    ),
    "direct": MessageLookupByLibrary.simpleMessage("ダイレクト"),
    "disableUDP": MessageLookupByLibrary.simpleMessage("UDPを無効化"),
    "disabled": MessageLookupByLibrary.simpleMessage("無効"),
    "discard": MessageLookupByLibrary.simpleMessage("破棄"),
    "discardChanges": MessageLookupByLibrary.simpleMessage("変更を破棄しますか？"),
    "disconnected": MessageLookupByLibrary.simpleMessage("切断済み"),
    "discountCode": MessageLookupByLibrary.simpleMessage("クーポンコード"),
    "discountCodeOptional": MessageLookupByLibrary.simpleMessage("割引コード（任意）"),
    "discountCodeRequired": MessageLookupByLibrary.simpleMessage(
      "クーポンコードを入力してください",
    ),
    "discountedPriceLabel": MessageLookupByLibrary.simpleMessage("割引後の価格"),
    "discovery": MessageLookupByLibrary.simpleMessage("新しいバージョンを発見"),
    "dnsDesc": MessageLookupByLibrary.simpleMessage("DNS関連設定の更新"),
    "dnsHijacking": MessageLookupByLibrary.simpleMessage("DNSハイジャッキング"),
    "dnsMode": MessageLookupByLibrary.simpleMessage("DNSモード"),
    "dnsQueries": MessageLookupByLibrary.simpleMessage("DNS クエリ"),
    "dnsQueriesDesc": MessageLookupByLibrary.simpleMessage(
      "最新 500 件の名前解決クエリを表示",
    ),
    "dnsQueryAll": MessageLookupByLibrary.simpleMessage("すべてのクエリ"),
    "dnsQueryAnswers": MessageLookupByLibrary.simpleMessage("応答"),
    "dnsQueryCached": MessageLookupByLibrary.simpleMessage("キャッシュ"),
    "dnsQueryFailures": MessageLookupByLibrary.simpleMessage("失敗したクエリ"),
    "dnsQueryInitiatorApp": MessageLookupByLibrary.simpleMessage("アプリ"),
    "dnsQueryInitiatorDirect": MessageLookupByLibrary.simpleMessage("直接接続"),
    "dnsQueryInitiatorOther": MessageLookupByLibrary.simpleMessage("その他"),
    "dnsQueryInitiatorProxy": MessageLookupByLibrary.simpleMessage("プロキシ接続"),
    "dnsQueryInitiatorRule": MessageLookupByLibrary.simpleMessage("ルール判定"),
    "dnsQueryRcode": MessageLookupByLibrary.simpleMessage("応答コード"),
    "dnsQueryType": MessageLookupByLibrary.simpleMessage("クエリの種類"),
    "dnsQueryUpstream": MessageLookupByLibrary.simpleMessage("上流リゾルバー"),
    "doYouWantToPass": MessageLookupByLibrary.simpleMessage("通過させますか？"),
    "docked": MessageLookupByLibrary.simpleMessage("固定"),
    "documentCenter": MessageLookupByLibrary.simpleMessage("ドキュメントセンター"),
    "domain": MessageLookupByLibrary.simpleMessage("ドメイン"),
    "download": MessageLookupByLibrary.simpleMessage("ダウンロード"),
    "dynamicMembersHint": MessageLookupByLibrary.simpleMessage(
      "更新時にこの設定のノードを自動追加します。Japan|JP などの名前フィルターを使用できます",
    ),
    "edit": MessageLookupByLibrary.simpleMessage("編集"),
    "editCustomRouting": MessageLookupByLibrary.simpleMessage("カスタム設定を編集"),
    "editGlobalRules": MessageLookupByLibrary.simpleMessage("グローバルルールを編集"),
    "editProfile": MessageLookupByLibrary.simpleMessage("プロファイルを編集"),
    "editProxyGroup": MessageLookupByLibrary.simpleMessage("プロキシグループを編集"),
    "editRule": MessageLookupByLibrary.simpleMessage("ルールを編集"),
    "editSsid": MessageLookupByLibrary.simpleMessage("SSIDを編集"),
    "editorUnavailable": MessageLookupByLibrary.simpleMessage("エディターを利用できません"),
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
    "emptyCustomOverwrite": MessageLookupByLibrary.simpleMessage(
      "カスタム上書きが空です。クイック入力を使うか、ルールとプロキシグループを追加してください。サブスクリプションの内容を保つには、追加モードを使ってください",
    ),
    "emptyTip": m19,
    "en": MessageLookupByLibrary.simpleMessage("英語"),
    "enableAutoRenew": MessageLookupByLibrary.simpleMessage("自動更新を有効にする"),
    "enabled": MessageLookupByLibrary.simpleMessage("有効"),
    "entries": MessageLookupByLibrary.simpleMessage(" エントリ"),
    "entriesCount": m20,
    "exclude": MessageLookupByLibrary.simpleMessage("最近のタスクから非表示"),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "アプリがバックグラウンド時に最近のタスクから非表示",
    ),
    "excludeNetworks": MessageLookupByLibrary.simpleMessage(
      "IP またはゲートウェイでプロキシを一時停止",
    ),
    "excludeNetworksDesc": MessageLookupByLibrary.simpleMessage(
      "Wi-Fi／イーサネットの IPv4、サブネット、ゲートウェイに一致すると一時停止し、離れると再開。カンマ区切り、例: 192.168.1.0/24,gateway:192.168.1.1",
    ),
    "excludeNetworksInvalid": MessageLookupByLibrary.simpleMessage(
      "最大 16 件。有効な IPv4、CIDR または gateway:アドレスを入力",
    ),
    "excludeProxyFilter": MessageLookupByLibrary.simpleMessage("除外プロキシフィルター"),
    "excludeSsids": MessageLookupByLibrary.simpleMessage("除外SSID"),
    "excludeSsidsDesc": MessageLookupByLibrary.simpleMessage(
      "指定した Wi-Fi ではプロキシを一時停止し、アプリが開始状態の場合のみ離れると再開します",
    ),
    "excludeType": MessageLookupByLibrary.simpleMessage("除外タイプ"),
    "existsTip": m21,
    "exit": MessageLookupByLibrary.simpleMessage("終了"),
    "exitFullScreen": MessageLookupByLibrary.simpleMessage("全画面表示を終了"),
    "expand": MessageLookupByLibrary.simpleMessage("標準"),
    "expandList": MessageLookupByLibrary.simpleMessage("展開"),
    "expectedStatus": MessageLookupByLibrary.simpleMessage("期待されるステータス"),
    "expireDate": m22,
    "expiresAtLabel": MessageLookupByLibrary.simpleMessage("有効期限"),
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
    "fade": MessageLookupByLibrary.simpleMessage("フェード"),
    "fakeipFilter": MessageLookupByLibrary.simpleMessage("Fakeipフィルター"),
    "fakeipFilterMode": MessageLookupByLibrary.simpleMessage("Fake-IPフィルターモード"),
    "fakeipFilterModeDesc": MessageLookupByLibrary.simpleMessage(
      "blacklistは一致を除外、whitelistは一致のみ、ruleはルールで判定",
    ),
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Fakeip範囲"),
    "fakeipRange6": MessageLookupByLibrary.simpleMessage("Fake-IP範囲（IPv6）"),
    "fakeipTtl": MessageLookupByLibrary.simpleMessage("Fake-IP TTL"),
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
    "floating": MessageLookupByLibrary.simpleMessage("フローティング"),
    "floatingNavigationBar": MessageLookupByLibrary.simpleMessage(
      "フローティングナビゲーション",
    ),
    "floatingNavigationBarDesc": MessageLookupByLibrary.simpleMessage(
      "コンパクトな画面でフローティングドックを使用",
    ),
    "followProfile": MessageLookupByLibrary.simpleMessage("プロファイルに従う"),
    "followSystem": MessageLookupByLibrary.simpleMessage("システムに従う"),
    "fontFamily": MessageLookupByLibrary.simpleMessage("フォントファミリー"),
    "fontSize": MessageLookupByLibrary.simpleMessage("サイズ"),
    "forceRestartCoreTip": MessageLookupByLibrary.simpleMessage(
      "コアを強制再起動してもよろしいですか？",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("パスワードをお忘れですか？"),
    "format": MessageLookupByLibrary.simpleMessage("形式"),
    "fruitSaladScheme": MessageLookupByLibrary.simpleMessage("フルーツサラダ"),
    "general": MessageLookupByLibrary.simpleMessage("一般"),
    "geoAutoUpdate": MessageLookupByLibrary.simpleMessage("自動更新"),
    "geoAutoUpdateInterval": MessageLookupByLibrary.simpleMessage("自動更新間隔"),
    "geoAutoUpdateIntervalTip": MessageLookupByLibrary.simpleMessage(
      "自動更新間隔は1〜8760時間で入力してください",
    ),
    "geoBackupSource": MessageLookupByLibrary.simpleMessage("予備 CDN"),
    "geoDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "GEO データのダウンロードに失敗しました",
    ),
    "geoDownloadRecoveryHint": MessageLookupByLibrary.simpleMessage(
      "現在のネットワークルールで取得し、プロキシが未起動の場合は直接接続します。再試行するか、別の配信元または URL を選択してください。検証後に自動で続行します",
    ),
    "geoDownloadUrl": MessageLookupByLibrary.simpleMessage("ダウンロード URL"),
    "geoInvalidDownloadUrl": MessageLookupByLibrary.simpleMessage(
      "有効な HTTP または HTTPS URL を入力してください",
    ),
    "geoOptions": MessageLookupByLibrary.simpleMessage("Geoオプション"),
    "geoOriginalSource": MessageLookupByLibrary.simpleMessage("現在の URL"),
    "geoResources": MessageLookupByLibrary.simpleMessage("Geoリソース"),
    "geoSkipped": m23,
    "geoUpdated": m24,
    "geoUpdating": m25,
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
    "groupCycleError": m26,
    "groupFilterHint": MessageLookupByLibrary.simpleMessage(
      "自動追加とプロバイダーのノードを絞り込みます。手動選択したメンバーは保持されます",
    ),
    "groupTypeFallback": MessageLookupByLibrary.simpleMessage("フェイルオーバー"),
    "groupTypeFallbackHint": MessageLookupByLibrary.simpleMessage(
      "メンバーを順に選び、障害時に切り替えます",
    ),
    "groupTypeLoadBalance": MessageLookupByLibrary.simpleMessage("負荷分散"),
    "groupTypeLoadBalanceHint": MessageLookupByLibrary.simpleMessage(
      "接続を利用可能なメンバーに分散します",
    ),
    "groupTypeSelect": MessageLookupByLibrary.simpleMessage("手動選択"),
    "groupTypeSelectHint": MessageLookupByLibrary.simpleMessage(
      "プロキシ画面で使用するメンバーを切り替えます",
    ),
    "groupTypeUrlTest": MessageLookupByLibrary.simpleMessage("自動選択"),
    "groupTypeUrlTestHint": MessageLookupByLibrary.simpleMessage(
      "定期的に測定し、遅延の低いノードを選択します",
    ),
    "hasCacheChange": MessageLookupByLibrary.simpleMessage("変更をキャッシュしますか？"),
    "haveAccountAlready": MessageLookupByLibrary.simpleMessage(
      "すでにアカウントをお持ちですか？",
    ),
    "hide": MessageLookupByLibrary.simpleMessage("非表示"),
    "hideFromList": MessageLookupByLibrary.simpleMessage("リストから隠す"),
    "hideIp": MessageLookupByLibrary.simpleMessage("IP を隠す"),
    "hideTimeoutProxies": MessageLookupByLibrary.simpleMessage(
      "測定に失敗したノードを非表示",
    ),
    "hideTimeoutProxiesDesc": MessageLookupByLibrary.simpleMessage(
      "選択中のノードと測定が完了していないノードは表示します",
    ),
    "host": MessageLookupByLibrary.simpleMessage("ホスト"),
    "hostsDesc": MessageLookupByLibrary.simpleMessage("ホストを追加"),
    "hotkeyConflict": MessageLookupByLibrary.simpleMessage("ホットキー競合"),
    "hotkeyConflictWith": m27,
    "hotkeyDesc": MessageLookupByLibrary.simpleMessage(
      "グローバルホットキーはウィンドウが非表示でも有効です。アクションをタップしてキーの組み合わせを記録します。",
    ),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage("ホットキー管理"),
    "hotkeyManagementDesc": MessageLookupByLibrary.simpleMessage(
      "キーボードでアプリを制御",
    ),
    "hotkeyNeedsModifier": m28,
    "hotkeyNotSet": MessageLookupByLibrary.simpleMessage("未設定"),
    "hotkeyUnavailable": MessageLookupByLibrary.simpleMessage(
      "ショートカットを登録できません",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("時間"),
    "hoursAgo": m29,
    "hoursCount": m30,
    "iHavePaid": MessageLookupByLibrary.simpleMessage("支払い済み"),
    "icon": MessageLookupByLibrary.simpleMessage("アイコン"),
    "iconHistory": MessageLookupByLibrary.simpleMessage("最近使用したアイコン"),
    "iconStyle": MessageLookupByLibrary.simpleMessage("アイコンスタイル"),
    "iconStyleFilled": MessageLookupByLibrary.simpleMessage("背景あり"),
    "iconStyleHidden": MessageLookupByLibrary.simpleMessage("非表示"),
    "iconStylePlain": MessageLookupByLibrary.simpleMessage("背景なし"),
    "iconUrl": MessageLookupByLibrary.simpleMessage("アイコンURL"),
    "ignoreBatteryOptimization": MessageLookupByLibrary.simpleMessage(
      "電池の最適化を無視",
    ),
    "import": MessageLookupByLibrary.simpleMessage("インポート"),
    "importFile": MessageLookupByLibrary.simpleMessage("ファイルからインポート"),
    "importFromURL": MessageLookupByLibrary.simpleMessage("URLからインポート"),
    "importUrl": MessageLookupByLibrary.simpleMessage("URLからインポート"),
    "inbound": MessageLookupByLibrary.simpleMessage("インバウンド"),
    "includeAll": MessageLookupByLibrary.simpleMessage("すべてのプロキシとプロバイダーを含める"),
    "includeAllProxies": MessageLookupByLibrary.simpleMessage("すべてのプロキシを含める"),
    "includeAllProxyProviders": MessageLookupByLibrary.simpleMessage(
      "すべてのプロキシプロバイダーを含める",
    ),
    "infiniteTime": MessageLookupByLibrary.simpleMessage("長期有効"),
    "init": MessageLookupByLibrary.simpleMessage("初期化"),
    "inputCorrectHotkey": MessageLookupByLibrary.simpleMessage("正しいホットキーを入力"),
    "installedAppsLoadFailed": MessageLookupByLibrary.simpleMessage(
      "アプリ一覧を読み込めませんでした。再試行してください",
    ),
    "installedAppsPermissionDeniedMessage":
        MessageLookupByLibrary.simpleMessage("許可されませんでした。システム設定でアクセスを許可できます"),
    "installedAppsPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "VPN を使用するアプリを選ぶには、インストール済みアプリ一覧へのアクセスを許可してください",
    ),
    "installedAppsPermissionGrant": MessageLookupByLibrary.simpleMessage(
      "アクセスを許可",
    ),
    "installedAppsPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "アプリ一覧へのアクセス許可が必要です",
    ),
    "insufficientBalanceHint": MessageLookupByLibrary.simpleMessage(
      "残高が不足しています。チャージしてから続行してください",
    ),
    "insufficientBalanceRecharge": MessageLookupByLibrary.simpleMessage(
      "チャージしてからもう一度お試しください",
    ),
    "intelligentSelected": MessageLookupByLibrary.simpleMessage("インテリジェント選択"),
    "interfaceAutomatic": MessageLookupByLibrary.simpleMessage("指定を解除（自動選択）"),
    "interfaceFollowProfile": MessageLookupByLibrary.simpleMessage("プロファイルに従う"),
    "interfaceName": MessageLookupByLibrary.simpleMessage("インターフェース名"),
    "internet": MessageLookupByLibrary.simpleMessage("インターネット"),
    "interval": MessageLookupByLibrary.simpleMessage("インターバル"),
    "intranetIP": MessageLookupByLibrary.simpleMessage("イントラネットIP"),
    "invalidAmount": MessageLookupByLibrary.simpleMessage("有効な金額を入力してください"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage("無効なバックアップファイル"),
    "invalidCertificateContent": MessageLookupByLibrary.simpleMessage(
      "サーバー証明書を検証できません。検証をスキップすると、偽のサーバーに接続し、送受信するアカウント認証情報やサブスクリプションデータが盗まれたり改ざんされたりするおそれがあります。\n\n現在のネットワークとサーバーを信頼できる場合のみ続行してください。この例外は同じサーバーと証明書への今回の再試行にのみ適用され、操作が終わると検証が再開されます。",
    ),
    "invalidCertificateTitle": MessageLookupByLibrary.simpleMessage(
      "証明書の検証に失敗しました",
    ),
    "invalidDscpContent": MessageLookupByLibrary.simpleMessage(
      "DSCP マークは 63 を超えられません",
    ),
    "invalidNetworkContent": MessageLookupByLibrary.simpleMessage(
      "tcp または udp のみ対応しています",
    ),
    "invalidPolicy": m31,
    "invalidProfileQrcode": MessageLookupByLibrary.simpleMessage(
      "このQRコードにはプロファイルのリンクが含まれていません",
    ),
    "invalidRangeContent": MessageLookupByLibrary.simpleMessage(
      "80 や 8000-9000 のような数値または範囲を / 区切りで入力してください",
    ),
    "invalidRuleSet": m32,
    "invalidSubRule": m33,
    "inviteCodeHint": MessageLookupByLibrary.simpleMessage("招待コードを入力"),
    "inviteCodeLabel": MessageLookupByLibrary.simpleMessage("招待コード"),
    "inviteCodeValidation": MessageLookupByLibrary.simpleMessage(
      "招待コードを入力してください",
    ),
    "ipcidr": MessageLookupByLibrary.simpleMessage("IPCIDR"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage("有効化するとIPv6トラフィックを受信可能"),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage("IPv6インバウンドを許可"),
    "ipv6Timeout": MessageLookupByLibrary.simpleMessage("IPv6タイムアウト（ms）"),
    "ja": MessageLookupByLibrary.simpleMessage("日本語"),
    "justNow": MessageLookupByLibrary.simpleMessage("たった今"),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "TCPキープアライブ間隔",
    ),
    "key": MessageLookupByLibrary.simpleMessage("キー"),
    "language": MessageLookupByLibrary.simpleMessage("言語"),
    "lastUpdated": MessageLookupByLibrary.simpleMessage("最終更新"),
    "layout": MessageLookupByLibrary.simpleMessage("レイアウト"),
    "lazy": MessageLookupByLibrary.simpleMessage("遅延読み込み"),
    "light": MessageLookupByLibrary.simpleMessage("ライト"),
    "lineIssueTip": m34,
    "lineWrap": MessageLookupByLibrary.simpleMessage("折り返し"),
    "list": MessageLookupByLibrary.simpleMessage("リスト"),
    "listen": MessageLookupByLibrary.simpleMessage("リスン"),
    "listenRoutingMark": MessageLookupByLibrary.simpleMessage("リッスンのルーティングマーク"),
    "listenRoutingMarkDesc": MessageLookupByLibrary.simpleMessage("Linuxのみ"),
    "loadTest": MessageLookupByLibrary.simpleMessage("読み込みテスト"),
    "loading": MessageLookupByLibrary.simpleMessage("読み込み中..."),
    "local": MessageLookupByLibrary.simpleMessage("ローカル"),
    "localBackupDesc": MessageLookupByLibrary.simpleMessage("ローカルにデータをバックアップ"),
    "localNetworkTip": MessageLookupByLibrary.simpleMessage(
      "ローカルネットワークへのアクセスが許可されていないため、今回は gVisor を使用します。LAN 上のプロキシやサービスは引き続き利用できない場合があります",
    ),
    "locateSelected": MessageLookupByLibrary.simpleMessage("選択中のノードへ移動"),
    "locationPermission": MessageLookupByLibrary.simpleMessage("位置情報の権限"),
    "locationPermissionDeniedMessage": MessageLookupByLibrary.simpleMessage(
      "位置情報の権限が拒否されたため、現在の Wi-Fi 名を取得できません。システム設定で位置情報の権限を手動で有効にしてください",
    ),
    "locationPermissionGuide": m35,
    "locationPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "位置情報の権限が必要です",
    ),
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
    "logoutContent": MessageLookupByLibrary.simpleMessage("ログアウトしますか？"),
    "logoutTitle": MessageLookupByLibrary.simpleMessage("ログアウト"),
    "logs": MessageLookupByLibrary.simpleMessage("ログ"),
    "logsAndDiagnostics": MessageLookupByLibrary.simpleMessage("ログと診断"),
    "logsDesc": MessageLookupByLibrary.simpleMessage("ログキャプチャ記録"),
    "logsTest": MessageLookupByLibrary.simpleMessage("ログテスト"),
    "loopback": MessageLookupByLibrary.simpleMessage("ループバック解除ツール"),
    "loopbackDesc": MessageLookupByLibrary.simpleMessage("UWPループバック解除用"),
    "loose": MessageLookupByLibrary.simpleMessage("疎"),
    "mainlandNetworkWarning": MessageLookupByLibrary.simpleMessage(
      "中国本土のネットワークには適さない可能性があります",
    ),
    "manageUserAgents": MessageLookupByLibrary.simpleMessage("一覧を管理"),
    "matchTarget": MessageLookupByLibrary.simpleMessage("MATCH-TARGET"),
    "matchTargetDesc": MessageLookupByLibrary.simpleMessage(
      "MATCH-TARGET を対象にしたルールの行き先。既定ではこのプロファイル末尾の MATCH ルールのターゲットを使います",
    ),
    "matchTargetTitle": MessageLookupByLibrary.simpleMessage("マッチ先"),
    "maxFailedTimes": MessageLookupByLibrary.simpleMessage("最大失敗回数"),
    "maxLengthTip": m36,
    "maximize": MessageLookupByLibrary.simpleMessage("最大化"),
    "memberOrderHint": MessageLookupByLibrary.simpleMessage(
      "選択順がフォールバック順になります。選び直すと末尾に移動します",
    ),
    "memoryAppResident": MessageLookupByLibrary.simpleMessage("常駐メモリ"),
    "memoryAppShared": MessageLookupByLibrary.simpleMessage("アプリと共有"),
    "memoryCoreHeapIdle": MessageLookupByLibrary.simpleMessage("未使用のヒープ"),
    "memoryCoreHeapInuse": MessageLookupByLibrary.simpleMessage("使用中のヒープ"),
    "memoryCoreNotRunning": MessageLookupByLibrary.simpleMessage(
      "コアは実行されていません",
    ),
    "memoryCoreRuntime": MessageLookupByLibrary.simpleMessage("ランタイムのオーバーヘッド"),
    "memoryCoreStack": MessageLookupByLibrary.simpleMessage("ゴルーチンスタック"),
    "memoryEstimateDesc": MessageLookupByLibrary.simpleMessage(
      "プロセスの常駐メモリからの推定値で、システムの表示とは異なる場合があります。",
    ),
    "memoryEstimateSharedDesc": MessageLookupByLibrary.simpleMessage(
      "コアはアプリと同じプロセスで動作します。コア分はランタイム統計から推定し、残りはアプリと共有メモリとして計上します。",
    ),
    "memoryInfo": MessageLookupByLibrary.simpleMessage("メモリ情報"),
    "memoryReleased": MessageLookupByLibrary.simpleMessage("メモリを解放しました"),
    "memoryReleasedSize": m37,
    "messageTest": MessageLookupByLibrary.simpleMessage("メッセージテスト"),
    "messageTestTip": MessageLookupByLibrary.simpleMessage("これはメッセージです"),
    "min": MessageLookupByLibrary.simpleMessage("最小化"),
    "minimalConfiguration": MessageLookupByLibrary.simpleMessage("最小構成"),
    "minimalConfigurationDesc": MessageLookupByLibrary.simpleMessage(
      "簡略化したルールセットで小さなプロファイルを生成します",
    ),
    "minimize": MessageLookupByLibrary.simpleMessage("最小化"),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage("終了時に最小化"),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "システムの終了イベントを変更",
    ),
    "minutesAgo": m38,
    "mipsStackDesc": MessageLookupByLibrary.simpleMessage(
      "低メモリのユーザー空間スタック。高遅延の回線ではスループットが低下する場合があります",
    ),
    "mixedPort": MessageLookupByLibrary.simpleMessage("混合ポート"),
    "mode": MessageLookupByLibrary.simpleMessage("モード"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("モノクローム"),
    "monthsAgo": m39,
    "more": MessageLookupByLibrary.simpleMessage("その他"),
    "myOrders": MessageLookupByLibrary.simpleMessage("購入済みプラン"),
    "name": MessageLookupByLibrary.simpleMessage("名前"),
    "nameserver": MessageLookupByLibrary.simpleMessage("ネームサーバー"),
    "nameserverDesc": MessageLookupByLibrary.simpleMessage("ドメイン解決用"),
    "nameserverPolicy": MessageLookupByLibrary.simpleMessage("ネームサーバーポリシー"),
    "nameserverPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "対応するネームサーバーポリシーを指定",
    ),
    "navigationBarStyle": MessageLookupByLibrary.simpleMessage("ボトムバー"),
    "network": MessageLookupByLibrary.simpleMessage("ネットワーク"),
    "networkAccessDeniedError": m40,
    "networkBadResponseError": m41,
    "networkCancelledError": MessageLookupByLibrary.simpleMessage(
      "リクエストはキャンセルされました",
    ),
    "networkConnectionError": MessageLookupByLibrary.simpleMessage(
      "サーバーに接続できませんでした。ネットワーク接続またはプロキシ設定を確認してください",
    ),
    "networkDesc": MessageLookupByLibrary.simpleMessage("ネットワーク関連設定の変更"),
    "networkDetection": MessageLookupByLibrary.simpleMessage("ネットワーク検出"),
    "networkException": MessageLookupByLibrary.simpleMessage(
      "ネットワーク例外、接続を確認してもう一度お試しください",
    ),
    "networkHostLookupError": MessageLookupByLibrary.simpleMessage(
      "サーバーのアドレスを解決できませんでした。URL が正しいこと、DNS が使えることを確認してください",
    ),
    "networkNotFoundError": m42,
    "networkRateLimitedError": MessageLookupByLibrary.simpleMessage(
      "リクエストが多すぎます（HTTP 429）。しばらく待ってから再試行してください",
    ),
    "networkRequestFailed": m43,
    "networkServerError": m44,
    "networkSpeed": MessageLookupByLibrary.simpleMessage("ネットワーク速度"),
    "networkTimeoutError": MessageLookupByLibrary.simpleMessage(
      "リクエストがタイムアウトしました。ネットワークまたはプロキシを確認してから再試行してください",
    ),
    "networkTlsError": MessageLookupByLibrary.simpleMessage(
      "安全な接続に失敗しました。サーバー証明書が無効か、接続が傍受されている可能性があります",
    ),
    "networkType": MessageLookupByLibrary.simpleMessage("ネットワーク種別"),
    "neutralScheme": MessageLookupByLibrary.simpleMessage("ニュートラル"),
    "newPasswordLabel": MessageLookupByLibrary.simpleMessage("新しいパスワード"),
    "nextMatch": MessageLookupByLibrary.simpleMessage("次の一致"),
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
    "noRemoteBackup": MessageLookupByLibrary.simpleMessage(
      "WebDAV にバックアップがありません",
    ),
    "noResolve": MessageLookupByLibrary.simpleMessage("IPを解決しない"),
    "noSearchResult": MessageLookupByLibrary.simpleMessage("一致する結果がありません"),
    "noSearchResults": MessageLookupByLibrary.simpleMessage("一致する結果はありません"),
    "noUpgradablePlans": MessageLookupByLibrary.simpleMessage(
      "アップグレード可能なプランがありません",
    ),
    "nodeCoreValidationUnavailable": MessageLookupByLibrary.simpleMessage(
      "ノードの検証前に Core を起動してください",
    ),
    "nodeDefinition": MessageLookupByLibrary.simpleMessage("ノード定義"),
    "nodeFilter": MessageLookupByLibrary.simpleMessage("ノードフィルター"),
    "nodeFilterAccountNote": MessageLookupByLibrary.simpleMessage(
      "フィルターはアカウントに保存され、このアプリでサインインしたすべてのデバイスに適用されます",
    ),
    "nodeFilterAny": MessageLookupByLibrary.simpleMessage("指定なし"),
    "nodeFilterCustomized": MessageLookupByLibrary.simpleMessage("カスタマイズ済み"),
    "nodeFilterExclude": MessageLookupByLibrary.simpleMessage("除外"),
    "nodeFilterKeepOne": MessageLookupByLibrary.simpleMessage(
      "少なくとも 1 つのノードを残してください",
    ),
    "nodeFilterKept": m45,
    "nodeFilterLines": MessageLookupByLibrary.simpleMessage("回線"),
    "nodeFilterNameContains": MessageLookupByLibrary.simpleMessage("名前に含む"),
    "nodeFilterNameExcludes": MessageLookupByLibrary.simpleMessage("名前から除外"),
    "nodeFilterNodeExcluded": m46,
    "nodeFilterNodeKept": m47,
    "nodeFilterOnly": MessageLookupByLibrary.simpleMessage("のみ残す"),
    "nodeFilterPreview": MessageLookupByLibrary.simpleMessage("プレビュー"),
    "nodeFilterRegions": MessageLookupByLibrary.simpleMessage("地域"),
    "nodeFilterRetry": MessageLookupByLibrary.simpleMessage("再試行"),
    "nodeFilterSearch": MessageLookupByLibrary.simpleMessage("ノードを検索"),
    "nodeFilterSmartSelection": MessageLookupByLibrary.simpleMessage("スマート選択"),
    "nodeInvalidDefinition": MessageLookupByLibrary.simpleMessage(
      "name と type を含む完全なノード定義を1つ入力してください",
    ),
    "nodeQuickFields": MessageLookupByLibrary.simpleMessage("簡易編集"),
    "nonTextProviderFile": MessageLookupByLibrary.simpleMessage(
      "この外部リソースはテキストファイルではありません",
    ),
    "none": MessageLookupByLibrary.simpleMessage("なし"),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "現在のプロキシグループは選択できません",
    ),
    "ntpInterval": MessageLookupByLibrary.simpleMessage("同期間隔（分）"),
    "ntpStatusDesc": MessageLookupByLibrary.simpleMessage(
      "システムクロックではなくNTPサーバーから時刻を取得します",
    ),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "プロファイルがありません。追加してください",
    ),
    "nullTip": m48,
    "numberTip": m49,
    "oixCloud": MessageLookupByLibrary.simpleMessage("oixCloud"),
    "onDemand": MessageLookupByLibrary.simpleMessage("オンデマンド"),
    "onDemandDesc": MessageLookupByLibrary.simpleMessage(
      "特定のシナリオでのアプリの実行状態を設定します",
    ),
    "onlyIcon": MessageLookupByLibrary.simpleMessage("アイコンのみ"),
    "onlyStatisticsProxy": MessageLookupByLibrary.simpleMessage("プロキシのみ統計"),
    "onlyStatisticsProxyDesc": MessageLookupByLibrary.simpleMessage(
      "有効化するとプロキシトラフィックのみ統計",
    ),
    "openDashboard": MessageLookupByLibrary.simpleMessage("ダッシュボードを開く"),
    "openInBrowser": MessageLookupByLibrary.simpleMessage("ブラウザで開く"),
    "operationFailed": MessageLookupByLibrary.simpleMessage("操作に失敗しました"),
    "operationSuccess": MessageLookupByLibrary.simpleMessage("操作に成功しました"),
    "optional": MessageLookupByLibrary.simpleMessage("任意"),
    "options": MessageLookupByLibrary.simpleMessage("オプション"),
    "other": MessageLookupByLibrary.simpleMessage("その他"),
    "outboundIp": MessageLookupByLibrary.simpleMessage("出口 IP"),
    "outboundMode": MessageLookupByLibrary.simpleMessage("アウトバウンドモード"),
    "outboundUnavailable": MessageLookupByLibrary.simpleMessage(
      "この設定では利用できません。削除または再選択してください",
    ),
    "overlayHint": MessageLookupByLibrary.simpleMessage(
      "個人設定は別に保存され、更新後に再適用されます。新しいグループに一致するメンバーがない場合、接続をブロックします",
    ),
    "overlayNameConflict": m50,
    "override": MessageLookupByLibrary.simpleMessage("上書き"),
    "overrideDns": MessageLookupByLibrary.simpleMessage("DNS上書き"),
    "overrideDnsDesc": MessageLookupByLibrary.simpleMessage(
      "選択した項目だけを上書きし、ほかの値はプロファイルを引き継ぎます",
    ),
    "overrideEntries": MessageLookupByLibrary.simpleMessage("上書き項目"),
    "overrideFieldsDesc": MessageLookupByLibrary.simpleMessage(
      "選択した項目だけを上書きし、ほかの値はプロファイルを引き継ぎます",
    ),
    "overrideFieldsEmpty": MessageLookupByLibrary.simpleMessage(
      "上書きする項目を追加するか、YAML を編集してください",
    ),
    "overrideMode": MessageLookupByLibrary.simpleMessage("上書きモード"),
    "overrideNtp": MessageLookupByLibrary.simpleMessage("NTP を上書き"),
    "overrideScript": MessageLookupByLibrary.simpleMessage("上書きスクリプト"),
    "overwriteIssueDuplicateName": m51,
    "overwriteIssueEmptyName": MessageLookupByLibrary.simpleMessage("名前が空です"),
    "overwriteIssueGroupLoop": m52,
    "overwriteIssueMissingProviders": m53,
    "overwriteIssueMissingProxies": m54,
    "overwriteIssueNoProxySource": MessageLookupByLibrary.simpleMessage(
      "プロキシもプロキシプロバイダーも選択されていないため、コアはこのグループを拒否します",
    ),
    "overwriteIssueReservedName": m55,
    "overwriteIssuesSummary": m56,
    "overwriteTypeCustom": MessageLookupByLibrary.simpleMessage("カスタム"),
    "overwriteTypeCustomDesc": MessageLookupByLibrary.simpleMessage(
      "カスタムモード、プロキシグループとルールを完全にカスタマイズ可能",
    ),
    "overwriteTypeMerge": MessageLookupByLibrary.simpleMessage("追加"),
    "overwriteTypeMergeDesc": MessageLookupByLibrary.simpleMessage(
      "サブスクリプションのルールとグループを保ち、個人設定を追加します。個人ルールはサブスクリプションより優先され、既存の追加ルールの優先順位は維持されます",
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
    "pauseUpdates": MessageLookupByLibrary.simpleMessage("更新を一時停止"),
    "payWithBalance": MessageLookupByLibrary.simpleMessage("残高で支払う"),
    "paymentAmount": MessageLookupByLibrary.simpleMessage("支払い金額"),
    "paymentMethod": MessageLookupByLibrary.simpleMessage("支払い方法"),
    "paymentRequestFailed": MessageLookupByLibrary.simpleMessage(
      "支払いリクエストに失敗しました",
    ),
    "paymentSuccess": MessageLookupByLibrary.simpleMessage("支払いに成功しました"),
    "paymentUnknownResponse": MessageLookupByLibrary.simpleMessage(
      "支払いエンドポイントが不明な形式を返しました",
    ),
    "personalRouting": MessageLookupByLibrary.simpleMessage("個人ルーティング"),
    "pickFromAlbum": MessageLookupByLibrary.simpleMessage("アルバムから選択"),
    "pinWindow": MessageLookupByLibrary.simpleMessage("最前面に固定"),
    "planEnded": MessageLookupByLibrary.simpleMessage("終了"),
    "planInUse": MessageLookupByLibrary.simpleMessage("使用中"),
    "planNotActivated": MessageLookupByLibrary.simpleMessage("有効化待ち"),
    "planNumber": m57,
    "planUnavailable": MessageLookupByLibrary.simpleMessage("購入不可"),
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
    "portProxyAppTip": MessageLookupByLibrary.simpleMessage(
      "他のプロキシアプリが起動している場合は、先に終了してください",
    ),
    "portSuggestionTip": m58,
    "portTip": m59,
    "portUnavailableMessage": m60,
    "portUnavailableTitle": MessageLookupByLibrary.simpleMessage("ポートを使用できません"),
    "preferH3Desc": MessageLookupByLibrary.simpleMessage("DOHのHTTP/3を優先使用"),
    "prerequisites": MessageLookupByLibrary.simpleMessage("前提条件"),
    "pressKeyboard": MessageLookupByLibrary.simpleMessage("キーボードを押してください"),
    "preview": MessageLookupByLibrary.simpleMessage("プレビュー"),
    "previousMatch": MessageLookupByLibrary.simpleMessage("前の一致"),
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
    "providerChanged": MessageLookupByLibrary.simpleMessage(
      "編集中にリソースが変更されました。開き直してください",
    ),
    "providerContent": MessageLookupByLibrary.simpleMessage("リソースの内容"),
    "providerContentInvalid": MessageLookupByLibrary.simpleMessage(
      "リソースの内容または形式が無効です",
    ),
    "providerContentTooLarge": MessageLookupByLibrary.simpleMessage(
      "リソースが 32 MiB を超えています",
    ),
    "providerInUse": m61,
    "providerLocal": MessageLookupByLibrary.simpleMessage("ローカルファイル"),
    "providerNameInvalid": MessageLookupByLibrary.simpleMessage(
      "空でなく、カンマや改行を含まない名前を入力してください",
    ),
    "providerRemote": MessageLookupByLibrary.simpleMessage("リモート URL"),
    "providerRenameShadowed": m62,
    "providerSourceReference": m63,
    "providerSourceUnavailable": m64,
    "providerUrlTip": MessageLookupByLibrary.simpleMessage(
      "認証情報を含まない HTTP または HTTPS URL を入力してください",
    ),
    "providers": MessageLookupByLibrary.simpleMessage("プロバイダー"),
    "proxies": MessageLookupByLibrary.simpleMessage("プロキシ"),
    "proxiesCount": m65,
    "proxyChainAvailableNodes": MessageLookupByLibrary.simpleMessage(
      "利用可能なノード",
    ),
    "proxyChainConflictTip": m66,
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
    "proxyChainUnavailableNodeTip": m67,
    "proxyChainUriNodeSupportedFormats": MessageLookupByLibrary.simpleMessage(
      "対応形式：ss://、ssr://、vmess://、vless://、trojan://、anytls://、hysteria:// / hy://、hysteria2:// / hy2://、tuic://、wireguard:// / wg://、http(s)://、socks(5)://",
    ),
    "proxyChainWarning": MessageLookupByLibrary.simpleMessage(
      "プロキシチェーンは通信速度を大きく低下させる可能性があります。明確な用途がない場合は無効のままにしてください",
    ),
    "proxyChains": MessageLookupByLibrary.simpleMessage("プロキシチェーン"),
    "proxyConflictAutoConfig": MessageLookupByLibrary.simpleMessage(
      "起動前、システムプロキシは自動構成スクリプトを使用していました",
    ),
    "proxyConflictHint": MessageLookupByLibrary.simpleMessage(
      "同時に使用すると接続に問題が起きるため、他のプロキシアプリや VPN であれば終了してください",
    ),
    "proxyConflictSystemProxy": m68,
    "proxyConflictTitle": MessageLookupByLibrary.simpleMessage(
      "プロキシが競合している可能性があります",
    ),
    "proxyConflictVpn": m69,
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
    "proxyNode": MessageLookupByLibrary.simpleMessage("プロキシノード"),
    "proxyPort": MessageLookupByLibrary.simpleMessage("プロキシポート"),
    "proxyProviders": MessageLookupByLibrary.simpleMessage("プロキシプロバイダー"),
    "pruneCache": MessageLookupByLibrary.simpleMessage("キャッシュの削除"),
    "purchaseAutoRenewLabel": MessageLookupByLibrary.simpleMessage("自動更新"),
    "purchaseDays": m70,
    "purchaseHours": m71,
    "purchaseMinutes": m72,
    "purchasePriceLabel": MessageLookupByLibrary.simpleMessage("購入価格"),
    "purchaseRenewOff": MessageLookupByLibrary.simpleMessage("オフ"),
    "purchaseRenewOn": MessageLookupByLibrary.simpleMessage("オン"),
    "purchaseRenewalPriceLabel": MessageLookupByLibrary.simpleMessage("更新価格"),
    "purchaseTime": m73,
    "purchaseTotalTrafficLabel": MessageLookupByLibrary.simpleMessage("合計データ量"),
    "purchasedAtLabel": MessageLookupByLibrary.simpleMessage("購入日時"),
    "pureBlack": MessageLookupByLibrary.simpleMessage("ピュアブラック"),
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("純黒モード"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QRコード"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage("QRコードをスキャンしてプロファイルを取得"),
    "quickAdd": MessageLookupByLibrary.simpleMessage("クイック追加"),
    "quickEdit": MessageLookupByLibrary.simpleMessage("クイック編集"),
    "quickFill": MessageLookupByLibrary.simpleMessage("クイック入力"),
    "rainbowScheme": MessageLookupByLibrary.simpleMessage("レインボー"),
    "rawOutboundInUse": m74,
    "receivingAddress": MessageLookupByLibrary.simpleMessage("受取アドレス"),
    "recharge": MessageLookupByLibrary.simpleMessage("チャージ"),
    "rechargeAllowedRange": m75,
    "rechargeAmount": MessageLookupByLibrary.simpleMessage("チャージ金額（¥）"),
    "rechargeAmountOutOfRange": MessageLookupByLibrary.simpleMessage(
      "金額がこの支払い方法で利用できる範囲外です",
    ),
    "recurringRenewalHint": MessageLookupByLibrary.simpleMessage(
      "以降の自動更新にも割引が適用されます",
    ),
    "redirPort": MessageLookupByLibrary.simpleMessage("Redirポート"),
    "redo": MessageLookupByLibrary.simpleMessage("やり直す"),
    "refresh": MessageLookupByLibrary.simpleMessage("更新"),
    "refreshAfterPayment": MessageLookupByLibrary.simpleMessage(
      "支払い完了後、下にスワイプして結果を確認してください",
    ),
    "refundAmountLabel": MessageLookupByLibrary.simpleMessage("返金額"),
    "register": MessageLookupByLibrary.simpleMessage("登録"),
    "registerClosed": MessageLookupByLibrary.simpleMessage("現在、新規登録は停止しています"),
    "registerFailed": MessageLookupByLibrary.simpleMessage("登録に失敗しました"),
    "registerTitle": MessageLookupByLibrary.simpleMessage("アカウント作成"),
    "relayGroupUnsupported": MessageLookupByLibrary.simpleMessage(
      "Relay グループはコアから削除されました。別のタイプを選択してください",
    ),
    "releaseMemory": MessageLookupByLibrary.simpleMessage("メモリを解放"),
    "releaseMemoryFailed": MessageLookupByLibrary.simpleMessage(
      "メモリの解放に失敗しました",
    ),
    "remaining": m76,
    "remainingStock": m77,
    "remainingTimeLabel": MessageLookupByLibrary.simpleMessage("残り時間"),
    "remainingTrafficLabel": MessageLookupByLibrary.simpleMessage("残りデータ量"),
    "remote": MessageLookupByLibrary.simpleMessage("リモート"),
    "remoteBackupDesc": MessageLookupByLibrary.simpleMessage(
      "WebDAVにデータをバックアップ",
    ),
    "remoteDestination": MessageLookupByLibrary.simpleMessage("リモート宛先"),
    "remove": MessageLookupByLibrary.simpleMessage("削除"),
    "rename": MessageLookupByLibrary.simpleMessage("リネーム"),
    "renewalPriceLabel": MessageLookupByLibrary.simpleMessage("以降の更新料金"),
    "replace": MessageLookupByLibrary.simpleMessage("置換"),
    "replaceAll": MessageLookupByLibrary.simpleMessage("すべて置換"),
    "request": MessageLookupByLibrary.simpleMessage("リクエスト"),
    "requests": MessageLookupByLibrary.simpleMessage("リクエスト"),
    "requestsAndUpdates": MessageLookupByLibrary.simpleMessage("リクエストと更新"),
    "requestsDesc": MessageLookupByLibrary.simpleMessage("最近のリクエスト記録を表示"),
    "resendCodeIn": m78,
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
    "resumeUpdates": MessageLookupByLibrary.simpleMessage("更新を再開"),
    "retry": MessageLookupByLibrary.simpleMessage("再試行"),
    "retryCloudSyncWithCertificateException":
        MessageLookupByLibrary.simpleMessage("一時的に許可して設定を同期"),
    "retryWithoutCertificateVerification": MessageLookupByLibrary.simpleMessage(
      "API を一時的に確認",
    ),
    "reverseEngineeringNotice": MessageLookupByLibrary.simpleMessage(
      "本アプリのリバースエンジニアリング、逆コンパイル、逆アセンブル、および AI を用いた解析を嚴禁します",
    ),
    "routeAddress": MessageLookupByLibrary.simpleMessage("ルートアドレス"),
    "routeAddressDesc": MessageLookupByLibrary.simpleMessage("ルートアドレスを設定"),
    "routeMode": MessageLookupByLibrary.simpleMessage("ルートモード"),
    "routeMode_bypassPrivate": MessageLookupByLibrary.simpleMessage(
      "プライベートルートをバイパス",
    ),
    "routeMode_config": MessageLookupByLibrary.simpleMessage("設定を使用"),
    "routingApplied": MessageLookupByLibrary.simpleMessage("個人設定を適用しました"),
    "routingApplyFailed": MessageLookupByLibrary.simpleMessage(
      "変更は保存されましたが適用できませんでした。設定を確認して再試行してください",
    ),
    "routingChanged": MessageLookupByLibrary.simpleMessage(
      "編集中または確認中に設定が変更されました。エディターを開き直すか、再度確認してください",
    ),
    "routingChecked": MessageLookupByLibrary.simpleMessage(
      "設定は有効です。個人設定はこのプロファイルに保存されています",
    ),
    "routingDraftHint": MessageLookupByLibrary.simpleMessage(
      "下書きを保存して他の項目を修正できます。設定全体の検証後に適用されます",
    ),
    "routingGroupType": MessageLookupByLibrary.simpleMessage("グループの種類"),
    "ru": MessageLookupByLibrary.simpleMessage("ロシア語"),
    "rule": MessageLookupByLibrary.simpleMessage("ルール"),
    "ruleActionAndDesc": MessageLookupByLibrary.simpleMessage("論理ルール AND"),
    "ruleActionDomainDesc": MessageLookupByLibrary.simpleMessage("完全なドメインにマッチ"),
    "ruleActionDomainKeywordDesc": MessageLookupByLibrary.simpleMessage(
      "ドメインキーワードにマッチ",
    ),
    "ruleActionDomainRegexDesc": MessageLookupByLibrary.simpleMessage(
      "ドメインの正規表現でマッチ",
    ),
    "ruleActionDomainSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "ドメインサフィックスにマッチ",
    ),
    "ruleActionDomainWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "ワイルドカードでマッチ（* と ? のみ対応）",
    ),
    "ruleActionDscpDesc": MessageLookupByLibrary.simpleMessage(
      "DSCPマークにマッチ（tproxy udpインバウンドのみ）",
    ),
    "ruleActionDstPortDesc": MessageLookupByLibrary.simpleMessage(
      "宛先ポート範囲にマッチ",
    ),
    "ruleActionGeoipDesc": MessageLookupByLibrary.simpleMessage("IPの国コードにマッチ"),
    "ruleActionGeositeDesc": MessageLookupByLibrary.simpleMessage(
      "Geosite 内のドメインにマッチ",
    ),
    "ruleActionInNameDesc": MessageLookupByLibrary.simpleMessage("インバウンド名にマッチ"),
    "ruleActionInPortDesc": MessageLookupByLibrary.simpleMessage(
      "インバウンドポートにマッチ",
    ),
    "ruleActionInTypeDesc": MessageLookupByLibrary.simpleMessage(
      "インバウンドタイプにマッチ",
    ),
    "ruleActionInUserDesc": MessageLookupByLibrary.simpleMessage(
      "インバウンドユーザー名にマッチ（/ で複数指定可）",
    ),
    "ruleActionIpAsnDesc": MessageLookupByLibrary.simpleMessage(
      "IPが属するASNにマッチ",
    ),
    "ruleActionIpCidr6Desc": MessageLookupByLibrary.simpleMessage(
      "IPアドレス範囲にマッチ（IP-CIDR6 は別名です）",
    ),
    "ruleActionIpCidrDesc": MessageLookupByLibrary.simpleMessage(
      "IPアドレス範囲にマッチ",
    ),
    "ruleActionIpSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "IPサフィックス範囲にマッチ",
    ),
    "ruleActionMatchDesc": MessageLookupByLibrary.simpleMessage(
      "すべてのリクエストにマッチ（条件不要）",
    ),
    "ruleActionNetworkDesc": MessageLookupByLibrary.simpleMessage(
      "TCPまたはUDPにマッチ",
    ),
    "ruleActionNotDesc": MessageLookupByLibrary.simpleMessage("論理ルール NOT"),
    "ruleActionOrDesc": MessageLookupByLibrary.simpleMessage("論理ルール OR"),
    "ruleActionProcessNameDesc": MessageLookupByLibrary.simpleMessage(
      "プロセス名でマッチ（Androidではパッケージ名にマッチ）",
    ),
    "ruleActionProcessNameRegexDesc": MessageLookupByLibrary.simpleMessage(
      "プロセス名の正規表現でマッチ（Androidではパッケージ名にマッチ）",
    ),
    "ruleActionProcessNameWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "プロセス名のワイルドカードでマッチ（* と ? のみ対応）",
    ),
    "ruleActionProcessPathDesc": MessageLookupByLibrary.simpleMessage(
      "プロセスのフルパスでマッチ",
    ),
    "ruleActionProcessPathRegexDesc": MessageLookupByLibrary.simpleMessage(
      "プロセスパスの正規表現でマッチ",
    ),
    "ruleActionProcessPathWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "プロセスパスのワイルドカードでマッチ（* と ? のみ対応）",
    ),
    "ruleActionRematchNameDesc": MessageLookupByLibrary.simpleMessage(
      "再マッチ名にマッチ（複数は / で区切る）",
    ),
    "ruleActionRuleSetDesc": MessageLookupByLibrary.simpleMessage(
      "ルールセットを参照します。rule-providersの設定が必要です",
    ),
    "ruleActionSrcGeoipDesc": MessageLookupByLibrary.simpleMessage(
      "送信元IPの国コードにマッチ",
    ),
    "ruleActionSrcIpAsnDesc": MessageLookupByLibrary.simpleMessage(
      "送信元IPが属するASNにマッチ",
    ),
    "ruleActionSrcIpCidrDesc": MessageLookupByLibrary.simpleMessage(
      "送信元IPアドレス範囲にマッチ",
    ),
    "ruleActionSrcIpSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "送信元IPサフィックス範囲にマッチ",
    ),
    "ruleActionSrcPortDesc": MessageLookupByLibrary.simpleMessage(
      "送信元ポート範囲にマッチ",
    ),
    "ruleActionSubRuleDesc": MessageLookupByLibrary.simpleMessage(
      "サブルールへマッチします。括弧の使い方に注意してください",
    ),
    "ruleActionUidDesc": MessageLookupByLibrary.simpleMessage(
      "LinuxのユーザーIDにマッチ",
    ),
    "ruleEmpty": MessageLookupByLibrary.simpleMessage("ルールが空です"),
    "ruleName": MessageLookupByLibrary.simpleMessage("ルール名"),
    "rulePresetBittorrentDirect": MessageLookupByLibrary.simpleMessage(
      "BitTorrent を直接接続",
    ),
    "rulePresetBlockDot": MessageLookupByLibrary.simpleMessage(
      "DNS over TLS をブロック",
    ),
    "rulePresetBlockQuic": MessageLookupByLibrary.simpleMessage("QUIC をブロック"),
    "rulePresetBlockStun": MessageLookupByLibrary.simpleMessage("STUN をブロック"),
    "rulePresetInsertHint": MessageLookupByLibrary.simpleMessage(
      "選択したプリセットを既存のルールの前に追加します。同じルールは重複して追加しません。",
    ),
    "rulePresetLanDirect": MessageLookupByLibrary.simpleMessage("LAN 直接接続"),
    "rulePresetSystemServicesDirect": MessageLookupByLibrary.simpleMessage(
      "Apple と Microsoft に直接接続",
    ),
    "ruleProviders": MessageLookupByLibrary.simpleMessage("ルールプロバイダー"),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("ルール対象"),
    "rules": MessageLookupByLibrary.simpleMessage("ルール"),
    "rulesCount": m79,
    "rulesRequireRuleMode": MessageLookupByLibrary.simpleMessage(
      "個人ルールはルールモードで有効になります",
    ),
    "runTime": MessageLookupByLibrary.simpleMessage("稼働時間"),
    "safeMode": MessageLookupByLibrary.simpleMessage("セーフモード"),
    "safeModeAppTitle": m80,
    "save": MessageLookupByLibrary.simpleMessage("保存"),
    "saveAndRetry": MessageLookupByLibrary.simpleMessage("保存して再試行"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("変更を保存しますか？"),
    "saveRoutingDraft": MessageLookupByLibrary.simpleMessage("下書きを保存"),
    "scanOrTransferPay": MessageLookupByLibrary.simpleMessage("スキャン／送金支払い"),
    "scanToPayNotice": MessageLookupByLibrary.simpleMessage(
      "Alipay / WeChat でスキャンして支払い",
    ),
    "script": MessageLookupByLibrary.simpleMessage("スクリプト"),
    "scriptChanged": MessageLookupByLibrary.simpleMessage(
      "スクリプトが変更または削除されました。開き直して再試行してください。",
    ),
    "scriptModeDesc": MessageLookupByLibrary.simpleMessage(
      "スクリプトモード、外部拡張スクリプトを使用し、ワンクリックで設定を上書きする機能を提供",
    ),
    "scriptOptions": MessageLookupByLibrary.simpleMessage("スクリプト設定"),
    "scriptOptionsEmpty": MessageLookupByLibrary.simpleMessage(
      "このスクリプトには設定可能なスイッチがありません",
    ),
    "search": MessageLookupByLibrary.simpleMessage("検索"),
    "seconds": MessageLookupByLibrary.simpleMessage("秒"),
    "secondsCount": m81,
    "selectAll": MessageLookupByLibrary.simpleMessage("すべて選択"),
    "selectBackup": MessageLookupByLibrary.simpleMessage("バックアップを選択"),
    "selectUpgradeTarget": MessageLookupByLibrary.simpleMessage("アップグレード対象を選択"),
    "selected": MessageLookupByLibrary.simpleMessage("選択済み"),
    "selectedCountTitle": m82,
    "sendCode": MessageLookupByLibrary.simpleMessage("コードを送信"),
    "sendResetEmail": MessageLookupByLibrary.simpleMessage("リセットメールを送信"),
    "server": MessageLookupByLibrary.simpleMessage("サーバー"),
    "serviceCheckFailed": MessageLookupByLibrary.simpleMessage("サービスチェック失敗"),
    "settings": MessageLookupByLibrary.simpleMessage("設定"),
    "show": MessageLookupByLibrary.simpleMessage("表示"),
    "showLess": MessageLookupByLibrary.simpleMessage("折りたたむ"),
    "showMore": MessageLookupByLibrary.simpleMessage("展開"),
    "showNotificationStopAction": MessageLookupByLibrary.simpleMessage(
      "通知に停止ボタンを表示",
    ),
    "shrink": MessageLookupByLibrary.simpleMessage("縮小"),
    "sidebarBlur": MessageLookupByLibrary.simpleMessage("サイドバーのぼかし"),
    "sidebarBlurDesc": MessageLookupByLibrary.simpleMessage(
      "サイドバーに半透明のシステム背景を表示",
    ),
    "silentLaunch": MessageLookupByLibrary.simpleMessage("バックグラウンド起動"),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage("バックグラウンドで起動"),
    "singleAdd": MessageLookupByLibrary.simpleMessage("個別追加"),
    "singleValueTip": m83,
    "size": MessageLookupByLibrary.simpleMessage("サイズ"),
    "slide": MessageLookupByLibrary.simpleMessage("スライド"),
    "socksPort": MessageLookupByLibrary.simpleMessage("Socksポート"),
    "softwareCenter": MessageLookupByLibrary.simpleMessage("ソフトウェアセンター"),
    "soldOut": MessageLookupByLibrary.simpleMessage("売り切れ"),
    "sort": MessageLookupByLibrary.simpleMessage("並び替え"),
    "source": MessageLookupByLibrary.simpleMessage("ソース"),
    "sourceIp": MessageLookupByLibrary.simpleMessage("送信元IP"),
    "specialProxy": MessageLookupByLibrary.simpleMessage("特殊プロキシ"),
    "specialRules": MessageLookupByLibrary.simpleMessage("特殊ルール"),
    "speedStatistics": MessageLookupByLibrary.simpleMessage("速度統計"),
    "ssidPermissionGuide": MessageLookupByLibrary.simpleMessage(
      "Wi-Fi 名の取得には位置情報の許可が必要です。Android では正確な位置情報を常に許可し、位置情報サービスを有効にしてください",
    ),
    "ssidsEmpty": MessageLookupByLibrary.simpleMessage("SSIDが空です"),
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
    "startFromScratch": MessageLookupByLibrary.simpleMessage("最初から作成"),
    "startSuccess": MessageLookupByLibrary.simpleMessage("起動しました"),
    "startVpn": MessageLookupByLibrary.simpleMessage("VPNを開始中..."),
    "startupAndBackground": MessageLookupByLibrary.simpleMessage("起動とバックグラウンド"),
    "startupRecoveryTip": MessageLookupByLibrary.simpleMessage(
      "直近2回の起動に失敗したため、今回は設定の自動適用とVPNの自動起動を一時停止しました。選択中のプロファイルと設定は保持されています。設定を確認し、「開始」を押して再試行してください。実行中のVPN接続は維持されます",
    ),
    "startupRecoveryTitle": MessageLookupByLibrary.simpleMessage("起動の復旧"),
    "status": MessageLookupByLibrary.simpleMessage("ステータス"),
    "statusDesc": MessageLookupByLibrary.simpleMessage("無効時はシステムDNSを使用"),
    "stop": MessageLookupByLibrary.simpleMessage("停止"),
    "stopVpn": MessageLookupByLibrary.simpleMessage("VPNを停止中..."),
    "store": MessageLookupByLibrary.simpleMessage("ストア"),
    "storeSubtitle": MessageLookupByLibrary.simpleMessage("プランの購入・更新・アップグレード"),
    "strategy": MessageLookupByLibrary.simpleMessage("ストラテジー"),
    "style": MessageLookupByLibrary.simpleMessage("スタイル"),
    "subRule": MessageLookupByLibrary.simpleMessage("サブルール"),
    "submit": MessageLookupByLibrary.simpleMessage("送信"),
    "subscriptionInfo": MessageLookupByLibrary.simpleMessage("サブスクリプション情報"),
    "suspendOnIdle": MessageLookupByLibrary.simpleMessage("アイドル時にプロキシを一時停止"),
    "suspendOnIdleDesc": MessageLookupByLibrary.simpleMessage(
      "画面がオフでシステムがアイドル状態のとき、通信の転送とヘルスチェックを一時停止します。通話やライブ音声の切断、プッシュ通知の遅延が発生する場合があります",
    ),
    "suspended": MessageLookupByLibrary.simpleMessage("一時停止中…"),
    "switchProfile": MessageLookupByLibrary.simpleMessage("プロファイルを切り替え"),
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
    "tabAnimationFade": MessageLookupByLibrary.simpleMessage("フェード"),
    "tabAnimationSlide": MessageLookupByLibrary.simpleMessage("スライド"),
    "tailscaleAccount": MessageLookupByLibrary.simpleMessage("アカウント"),
    "tailscaleAddNetwork": MessageLookupByLibrary.simpleMessage("ネットワークを追加"),
    "tailscaleAdvanced": MessageLookupByLibrary.simpleMessage("詳細設定"),
    "tailscaleAuthKey": MessageLookupByLibrary.simpleMessage("認証キー"),
    "tailscaleAuthKeyInvalid": MessageLookupByLibrary.simpleMessage(
      "認証キーの形式が正しくありません",
    ),
    "tailscaleAuthKeySaved": MessageLookupByLibrary.simpleMessage(
      "このデバイスには認証キーが保存されています。新しいキーを入力すると置き換えます",
    ),
    "tailscaleAutoRoute": MessageLookupByLibrary.simpleMessage("自動ルーティング"),
    "tailscaleAutoRouteDesc": MessageLookupByLibrary.simpleMessage(
      "ピアのアドレス、MagicDNS 名、承認済みサブネットをこのネットワーク経由でルーティング",
    ),
    "tailscaleAvailableExitNodes": MessageLookupByLibrary.simpleMessage(
      "利用可能な出口ノード",
    ),
    "tailscaleCheckSettings": m84,
    "tailscaleConnected": MessageLookupByLibrary.simpleMessage("接続済み"),
    "tailscaleConnecting": MessageLookupByLibrary.simpleMessage("接続中"),
    "tailscaleControlUrl": MessageLookupByLibrary.simpleMessage(
      "コントロールサーバーの URL",
    ),
    "tailscaleCredentialsFooter": MessageLookupByLibrary.simpleMessage(
      "認証情報とデバイスの識別情報はこのデバイスにのみ保存されます",
    ),
    "tailscaleDeviceName": MessageLookupByLibrary.simpleMessage("デバイス名"),
    "tailscaleDevices": m85,
    "tailscaleDirect": MessageLookupByLibrary.simpleMessage("直接接続"),
    "tailscaleEmptyDesc": MessageLookupByLibrary.simpleMessage(
      "ネットワークを追加してこのデバイスでログインし、プロキシを起動するとデバイスにアクセスできます",
    ),
    "tailscaleEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "Tailnet にアクセス",
    ),
    "tailscaleEnterAuthKey": MessageLookupByLibrary.simpleMessage(
      "このデバイスでログインするには認証キーを入力してください",
    ),
    "tailscaleEntryHint": MessageLookupByLibrary.simpleMessage(
      "Tailnet 内のデバイスにアクセス",
    ),
    "tailscaleExitNode": MessageLookupByLibrary.simpleMessage("出口ノード"),
    "tailscaleExitNodeActive": MessageLookupByLibrary.simpleMessage(
      "使用中の出口ノード",
    ),
    "tailscaleExitNodeAllowLan": MessageLookupByLibrary.simpleMessage(
      "ローカルネットワークへのアクセスを許可",
    ),
    "tailscaleExitNodeDesc": MessageLookupByLibrary.simpleMessage(
      "空欄で使用しません。auto、ピア名またはピアの IP アドレスも指定できます",
    ),
    "tailscaleGuide": MessageLookupByLibrary.simpleMessage("使い方"),
    "tailscaleGuideDevices": MessageLookupByLibrary.simpleMessage(
      "デバイスと MagicDNS",
    ),
    "tailscaleGuideDevicesBody": MessageLookupByLibrary.simpleMessage(
      "自動ルーティングは既知のピアのアドレスと MagicDNS 名、および Tailnet で承認済みのサブネットをこのネットワークに送ります。その他の通信はルールに従います\n自動ルーティングは追加したルールとカスタムルールの後、プロファイル自身のルールの前に適用されます\n独自ドメインのコントロールサーバーでは既知のデバイス名だけを経由させるため、そのドメインの公開サイトには影響しません\nこのデバイスが接続しているローカルネットワーク内のサブネットアドレスはローカルのままです。同じアドレスのリモートサブネットにアクセスするには、このネットワークを指すルールを追加してください\n承認済みサブネットに解決されるドメインもこのネットワークを経由します。プロファイルがそのドメインを直接プロキシに渡す場合は、このネットワークを指すドメインルールを追加してください",
    ),
    "tailscaleGuideExitNodes": MessageLookupByLibrary.simpleMessage("出口ノード"),
    "tailscaleGuideExitNodesBody": MessageLookupByLibrary.simpleMessage(
      "出口ノードを設定すると、このネットワークがプロファイルの選択グループに表示されます。グループで選択するかルールで指定した通信だけが出口ノード経由になります\n空欄の場合は出口ノードを使用しません。auto は利用可能な出口ノードを選び、デバイス名やアドレスを指定するとそのデバイスを使います",
    ),
    "tailscaleGuideGetStarted": MessageLookupByLibrary.simpleMessage("はじめに"),
    "tailscaleGuideGetStartedBody": MessageLookupByLibrary.simpleMessage(
      "ネットワークを追加して「保存してログイン」を選び、ログインページでこのデバイスを承認すると自動でログインが完了します\n認証キーでログインする場合は「認証キー」を選んでキーを入力します。ブラウザは不要です\nネットワークはプロキシの実行中のみ使えます。ログインしただけでは通信は経由しません",
    ),
    "tailscaleGuideSignIn": MessageLookupByLibrary.simpleMessage("ログインとバックアップ"),
    "tailscaleGuideSignInBody": MessageLookupByLibrary.simpleMessage(
      "ネットワーク設定はバックアップに含まれます。認証キーとデバイスの識別情報はこのデバイスにのみ残るため、別のデバイスで復元した後は再ログインが必要です\nノードキーの有効期限が切れたら、もう一度「保存してログイン」を選んでください。デバイスの承認とアクセス権は Tailnet で管理します\nネットワークを削除すると、このデバイスはログアウトし、このデバイス上の識別情報が削除されます",
    ),
    "tailscaleGuideTroubleshooting": MessageLookupByLibrary.simpleMessage(
      "トラブルシューティング",
    ),
    "tailscaleGuideTroubleshootingBody": MessageLookupByLibrary.simpleMessage(
      "プロキシが実行中か、このデバイスが承認済みか、ピアがオンラインかを確認してください。サブネットやインターネットにアクセスする場合は、ルートの承認状態と出口ノードも確認してください\n「未適用」は実行中の設定にこのネットワークが含まれていないことを示します。プロファイルを選択し、同じ名前のノードがないことを確認してください\nこのアプリは Tailnet へ接続するだけで、Tailnet からの着信接続は受け付けず、このデバイスをサブネットルーターや出口ノードとして公開しません",
    ),
    "tailscaleHostnameInvalid": MessageLookupByLibrary.simpleMessage(
      "小文字、数字、ハイフンのみ、63 文字以内",
    ),
    "tailscaleInteractiveLogin": MessageLookupByLibrary.simpleMessage(
      "対話型ログイン",
    ),
    "tailscaleKeyExpired": MessageLookupByLibrary.simpleMessage(
      "ノードキーの有効期限が切れました",
    ),
    "tailscaleLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Tailscale へのログインに失敗しました",
    ),
    "tailscaleLoginFooter": MessageLookupByLibrary.simpleMessage(
      "ネットワークごとにこのデバイスで一度ログインするだけです",
    ),
    "tailscaleLoginHint": MessageLookupByLibrary.simpleMessage(
      "ログインでこのデバイスを承認します。ネットワークを使うにはプロキシを起動してください",
    ),
    "tailscaleLoginMethod": MessageLookupByLibrary.simpleMessage("ログイン方法"),
    "tailscaleLoginTimeout": MessageLookupByLibrary.simpleMessage(
      "5 分以内にログインが完了しませんでした。もう一度お試しください",
    ),
    "tailscaleLoginWaiting": MessageLookupByLibrary.simpleMessage(
      "ログインページを開くかコードをスキャンしてください。承認後に自動でログインが完了します",
    ),
    "tailscaleLogout": MessageLookupByLibrary.simpleMessage("ログアウト"),
    "tailscaleNameInUse": MessageLookupByLibrary.simpleMessage(
      "この名前は既に使われています",
    ),
    "tailscaleNameInvalid": MessageLookupByLibrary.simpleMessage(
      "64 文字以内で、カンマは使えません",
    ),
    "tailscaleNeedsApproval": MessageLookupByLibrary.simpleMessage(
      "デバイスの承認待ちです",
    ),
    "tailscaleNeedsLogin": MessageLookupByLibrary.simpleMessage("ログインが必要です"),
    "tailscaleNetworkInUse": m86,
    "tailscaleNetworkName": MessageLookupByLibrary.simpleMessage("ネットワーク名"),
    "tailscaleNetworks": MessageLookupByLibrary.simpleMessage("ネットワーク"),
    "tailscaleNotApplied": MessageLookupByLibrary.simpleMessage("未適用"),
    "tailscaleNotAppliedHint": MessageLookupByLibrary.simpleMessage(
      "ネットワークが実行中の設定に含まれていません。プロファイルを選択し、同じ名前のノードがないことを確認してください",
    ),
    "tailscaleNotSignedIn": MessageLookupByLibrary.simpleMessage("未ログイン"),
    "tailscaleOffline": MessageLookupByLibrary.simpleMessage("オフライン"),
    "tailscaleOnline": MessageLookupByLibrary.simpleMessage("オンライン"),
    "tailscaleOpenLoginPage": MessageLookupByLibrary.simpleMessage(
      "ログインページを開く",
    ),
    "tailscaleRelay": m87,
    "tailscaleRemoveConfirm": m88,
    "tailscaleRemoveNetwork": MessageLookupByLibrary.simpleMessage("ネットワークを削除"),
    "tailscaleSaveAndLogin": MessageLookupByLibrary.simpleMessage("保存してログイン"),
    "tailscaleSignedIn": MessageLookupByLibrary.simpleMessage("ログイン済み"),
    "tailscaleSigningIn": MessageLookupByLibrary.simpleMessage("ログイン中"),
    "tailscaleStatus": MessageLookupByLibrary.simpleMessage("状態"),
    "tailscaleStopped": MessageLookupByLibrary.simpleMessage("停止中"),
    "tailscaleThisDevice": MessageLookupByLibrary.simpleMessage("このデバイス"),
    "tailscaleUnavailable": MessageLookupByLibrary.simpleMessage("接続できません"),
    "tapToAuthorize": MessageLookupByLibrary.simpleMessage("タップして許可"),
    "tcpConcurrent": MessageLookupByLibrary.simpleMessage("TCP並列処理"),
    "tcpConcurrentDesc": MessageLookupByLibrary.simpleMessage("TCP並列処理を許可"),
    "tcpFastOpen": MessageLookupByLibrary.simpleMessage("TCP Fast Open"),
    "tcpFastOpenDesc": MessageLookupByLibrary.simpleMessage(
      "TCPの接続確立を高速化するには、このオプションをオンにしてください",
    ),
    "testUrl": MessageLookupByLibrary.simpleMessage("URLテスト"),
    "textScale": MessageLookupByLibrary.simpleMessage("テキストスケーリング"),
    "textScalePreview": MessageLookupByLibrary.simpleMessage(
      "アプリ内の文字はこの大きさで表示されます",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("テーマ"),
    "themeColor": MessageLookupByLibrary.simpleMessage("テーマカラー"),
    "themeDesc": MessageLookupByLibrary.simpleMessage("ダークモードの設定、色の調整"),
    "themeMode": MessageLookupByLibrary.simpleMessage("テーマモード"),
    "tight": MessageLookupByLibrary.simpleMessage("密"),
    "time": MessageLookupByLibrary.simpleMessage("時間"),
    "timeout": MessageLookupByLibrary.simpleMessage("タイムアウト"),
    "tip": MessageLookupByLibrary.simpleMessage("ヒント"),
    "todayUsed": MessageLookupByLibrary.simpleMessage("今日の使用量"),
    "toggle": MessageLookupByLibrary.simpleMessage("トグル"),
    "toggleFlashlight": MessageLookupByLibrary.simpleMessage("ライト切替"),
    "toggleNavigationLabels": MessageLookupByLibrary.simpleMessage(
      "ナビゲーションラベルの表示切替",
    ),
    "tokenLabel": MessageLookupByLibrary.simpleMessage("アクセストークン"),
    "tokenValidation": MessageLookupByLibrary.simpleMessage(
      "アクセストークンを入力してください",
    ),
    "tolerance": MessageLookupByLibrary.simpleMessage("許容差"),
    "tonalSpotScheme": MessageLookupByLibrary.simpleMessage("トーンスポット"),
    "tools": MessageLookupByLibrary.simpleMessage("ツール"),
    "total": MessageLookupByLibrary.simpleMessage("合計"),
    "tproxyPort": MessageLookupByLibrary.simpleMessage("Tproxyポート"),
    "trafficUsage": MessageLookupByLibrary.simpleMessage("トラフィック使用量"),
    "transferConfirmNotice": MessageLookupByLibrary.simpleMessage(
      "送金完了後、システムが自動的に確認し、選択したプランが自動的に有効になります",
    ),
    "tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "tunAuthorizationFailed": MessageLookupByLibrary.simpleMessage(
      "管理者権限が拒否されたため、TUN を有効にできませんでした。システムの権限要求を許可して、もう一度お試しください",
    ),
    "tunDesc": MessageLookupByLibrary.simpleMessage("管理者モードでのみ有効"),
    "tunMtuDesc": MessageLookupByLibrary.simpleMessage(
      "既定値は 9000、1480 または 4064 も選択可能。Android VPN の再起動後に適用",
    ),
    "tunMtuInvalid": MessageLookupByLibrary.simpleMessage(
      "1280〜65535 の整数を入力してください",
    ),
    "turnOff": MessageLookupByLibrary.simpleMessage("オフ"),
    "turnOn": MessageLookupByLibrary.simpleMessage("オン"),
    "undo": MessageLookupByLibrary.simpleMessage("元に戻す"),
    "unifiedDelay": MessageLookupByLibrary.simpleMessage("統一遅延"),
    "unifiedDelayDesc": MessageLookupByLibrary.simpleMessage(
      "ハンドシェイクなどの余分な遅延を削除",
    ),
    "unknown": MessageLookupByLibrary.simpleMessage("不明"),
    "unknownNetworkError": MessageLookupByLibrary.simpleMessage("不明なネットワークエラー"),
    "unmaximize": MessageLookupByLibrary.simpleMessage("元に戻す"),
    "unnamed": MessageLookupByLibrary.simpleMessage("無題"),
    "unpinWindow": MessageLookupByLibrary.simpleMessage("固定を解除"),
    "update": MessageLookupByLibrary.simpleMessage("更新"),
    "updateAppImageTip": MessageLookupByLibrary.simpleMessage(
      "AppImage は自動インストールできません。ダウンロードしたファイルで現在のプログラムを置き換えてください。保存先のフォルダーを開きました。",
    ),
    "updateBuildNumber": m89,
    "updateCancelDownload": MessageLookupByLibrary.simpleMessage("ダウンロードを中止"),
    "updateDownloadBackground": MessageLookupByLibrary.simpleMessage(
      "バックグラウンドでダウンロード",
    ),
    "updateDownloadBrowser": MessageLookupByLibrary.simpleMessage(
      "ブラウザーでダウンロード",
    ),
    "updateDownloadConfirm": MessageLookupByLibrary.simpleMessage("更新をダウンロード"),
    "updateDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "更新のダウンロードに失敗しました",
    ),
    "updateDownloading": MessageLookupByLibrary.simpleMessage("更新をダウンロード中"),
    "updateInstall": MessageLookupByLibrary.simpleMessage("更新をインストール"),
    "updateLater": MessageLookupByLibrary.simpleMessage("後で"),
    "updateNotice": MessageLookupByLibrary.simpleMessage("新しいバージョンが見つかりました"),
    "updatePackageFormat": MessageLookupByLibrary.simpleMessage("パッケージ形式を選択"),
    "updatePackageFormatTip": MessageLookupByLibrary.simpleMessage(
      "インストール方法を判別できませんでした。一致する形式を選んでください。",
    ),
    "updatePackageManagerTip": MessageLookupByLibrary.simpleMessage(
      "このビルドはパッケージマネージャーでインストールされています。インストール時と同じ方法で更新してください。",
    ),
    "updateReady": MessageLookupByLibrary.simpleMessage("更新の準備ができました"),
    "updateReadyHint": MessageLookupByLibrary.simpleMessage(
      "更新のダウンロードが完了しました。都合のよいときにインストールできます",
    ),
    "updateReleaseNotes": MessageLookupByLibrary.simpleMessage("更新内容"),
    "updateReleaseNotesFailed": MessageLookupByLibrary.simpleMessage(
      "更新履歴を読み込めませんでした。再試行してください",
    ),
    "updateVersionNumber": m90,
    "upgradePlan": MessageLookupByLibrary.simpleMessage("プランをアップグレード"),
    "upload": MessageLookupByLibrary.simpleMessage("アップロード"),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage("URL経由でプロファイルを取得"),
    "urlTip": m91,
    "useHosts": MessageLookupByLibrary.simpleMessage("ホストを使用"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage("システムホストを使用"),
    "usedTrafficLabel": MessageLookupByLibrary.simpleMessage("使用済みデータ量"),
    "userAgent": MessageLookupByLibrary.simpleMessage("ユーザーエージェント"),
    "userCenter": MessageLookupByLibrary.simpleMessage("ユーザーセンター"),
    "userCenterFallback": MessageLookupByLibrary.simpleMessage("ユーザーセンター（予備）"),
    "value": MessageLookupByLibrary.simpleMessage("値"),
    "verifyCoupon": MessageLookupByLibrary.simpleMessage("確認"),
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
    "writeToSystem": MessageLookupByLibrary.simpleMessage("システムに書き込む"),
    "writeToSystemDesc": MessageLookupByLibrary.simpleMessage(
      "システムクロックも設定します。Androidでは無視されます",
    ),
    "yearsAgo": m92,
    "zh_CN": MessageLookupByLibrary.simpleMessage("簡体字中国語"),
  };
}

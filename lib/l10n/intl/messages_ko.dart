// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
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
  String get localeName => 'ko';

  static String m0(value) => "사용 가능: ${value}";

  static String m1(count, skipped) => "추가 ${count}개, 이미 있어서 건너뜀 ${skipped}개";

  static String m2(status) => "서버가 HTTP ${status}을(를) 반환했습니다";

  static String m3(error) => "직접 연결: ${error}";

  static String m4(error) => "로컬 프록시: ${error}";

  static String m5(code) => "시스템 오류 ${code}";

  static String m6(value) => "수수료 ${value}";

  static String m7(line) => "${line}번째 줄의 설정 형식이 올바르지 않습니다.";

  static String m8(expected, actual) =>
      "${expected}이(가) 필요하지만 ${actual}이(가) 있습니다.";

  static String m9(code) =>
      "Windows가 프록시 코어 시작을 차단했습니다(시스템 오류 ${code}). Windows 보안의 보호 기록과 앱 제어 정책을 확인하고 설치 프로그램의 출처와 서명을 검증하세요.";

  static String m10(url) => "${url}에서 프로필을 만드시겠습니까?";

  static String m11(count) =>
      "${Intl.plural(count, one: '사용자 지정 프로필은 하위 규칙을 지원하지 않아 SUB-RULE 규칙 1개를 제외했습니다', other: '사용자 지정 프로필은 하위 규칙을 지원하지 않아 SUB-RULE 규칙 ${count}개를 제외했습니다')}";

  static String m12(count) =>
      "${Intl.plural(count, one: '노드 1개에 이름 또는 유형이 없습니다', other: '노드 ${count}개에 이름 또는 유형이 없습니다')}";

  static String m13(count) => "문제가 있는 항목 ${count}개, 이 프로필을 적용하면 실패할 수 있습니다";

  static String m14(name) => "그룹, 규칙 또는 프록시 체인이 아직 ${name}을 참조하고 있습니다";

  static String m15(example) => "이 규칙 유형에 맞는 내용인지 확인하세요. 예: ${example}";

  static String m16(name) => "${name}을(를) 사용할 수 없습니다. 기존 규칙 공급자를 선택하세요.";

  static String m17(name) => "${name}을(를) 사용할 수 없습니다. 이 설정에 있는 대상을 선택하세요.";

  static String m18(count) => "${Intl.plural(count, other: '${count}일 전')}";

  static String m19(count) => "${Intl.plural(count, other: '${count}일 전')}";

  static String m20(label) => "선택한 ${label}을(를) 삭제하시겠습니까?";

  static String m21(label) => "${label}을(를) 삭제하시겠습니까?";

  static String m22(label) => "${label} 상세 정보";

  static String m23(port) =>
      "로컬 주소: 127.0.0.1\n혼합 포트(현재 설정): ${port}\n이 기기에서만 HTTP, HTTPS 웹사이트 프록시 또는 SOCKS5에 이 혼합 포트를 사용하세요.";

  static String m24(count) => "독립적인 HTTPS 점검 2개 중 ${count}개 통과";

  static String m25(name) =>
      "${name}을(를) 거치는 다이얼이 이를 사용하는 프록시로 되돌아와 연결을 중단했습니다";

  static String m26(label) => "${label}을(를) 입력하세요";

  static String m27(label) => "${label}이(가) 이미 있습니다";

  static String m28(date) => "만료일: ${date}";

  static String m29(label, message) => "${label}: ${message}";

  static String m30(name) => "${name} 건너뜀";

  static String m31(name) => "${name}: 업데이트됨";

  static String m32(name) => "${name} 업데이트 중…";

  static String m33(count) => "${Intl.plural(count, other: '그룹 ${count}개')}";

  static String m34(name) => "그룹 순환 참조: ${name}. 다른 구성원을 선택하세요.";

  static String m35(count) => "${count}개 시간 초과";

  static String m36(action) => "이미 “${action}”에서 사용 중입니다. 저장하면 이쪽으로 옮겨집니다.";

  static String m37(modifiers) => "${modifiers} 중 하나 이상을 포함하세요";

  static String m38(count) => "${Intl.plural(count, other: '${count}시간 전')}";

  static String m39(count) => "${Intl.plural(count, other: '${count}시간 전')}";

  static String m40(count) => "${count}시간";

  static String m41(target) => "올바르지 않은 정책: ${target}";

  static String m42(providerName) => "올바르지 않은 프록시 공급자: ${providerName}";

  static String m43(ruleSet) => "올바르지 않은 규칙 세트: ${ruleSet}";

  static String m44(subRule) => "올바르지 않은 SUB_RULE: ${subRule}";

  static String m45(count) => "${Intl.plural(count, other: '항목 ${count}개')}";

  static String m46(line, message) => "${line}행: ${message}";

  static String m47(appName) =>
      "1. 시스템 설정 > 개인정보 보호 및 보안을 엽니다\n2. 위치 서비스를 선택합니다\n3. 목록에서 ${appName}을(를) 찾아 체크합니다\n\n완료되면 앱으로 돌아와 계속하세요. 협조해 주셔서 감사합니다.";

  static String m48(label, max) => "${label}은(는) 최대 ${max}자까지 입력할 수 있습니다";

  static String m49(size) => "${size} 해제됨";

  static String m50(count) => "${Intl.plural(count, other: '${count}분 전')}";

  static String m51(count) => "${Intl.plural(count, other: '${count}분 전')}";

  static String m52(count) => "${Intl.plural(count, other: '${count}개월 전')}";

  static String m53(count) => "${Intl.plural(count, other: '${count}개월 전')}";

  static String m54(code) =>
      "서버가 접근을 거부했습니다(HTTP ${code}). 링크가 만료되었거나 자격 증명이 잘못되었을 수 있습니다";

  static String m55(code) => "서버가 요청을 거부했습니다(HTTP ${code})";

  static String m56(code) =>
      "이 주소에서 아무것도 찾지 못했습니다(HTTP ${code}). URL이 올바른지 확인하세요";

  static String m57(code) => "서버에 문제가 발생했습니다(HTTP ${code}). 나중에 다시 시도하세요";

  static String m58(kept, total) => "${total}개 중 ${kept}개 노드 유지";

  static String m59(name) => "${name}, 제외됨";

  static String m60(name) => "${name}, 유지됨";

  static String m61(label) => "${label}이(가) 아직 없습니다";

  static String m62(label, min, max) => "${label}은(는) ${min}에서 ${max} 사이여야 합니다";

  static String m63(label) => "${label}은(는) 숫자여야 합니다";

  static String m64(name) =>
      "이름 \"${name}\"이(가) 이미 사용 중입니다. 둘 다 유지하려면 개인 그룹의 이름을 변경하세요.";

  static String m65(name) => "다른 프록시 또는 프록시 그룹이 이미 이름 ${name}을(를) 사용하고 있습니다";

  static String m66(name) =>
      "빈 그룹의 대체 대상은 프록시 그룹이 아닌 기존 노드 또는 기본 아웃바운드여야 합니다: ${name}";

  static String m67(path) => "프록시 그룹이 순환 참조하고 있습니다: ${path}";

  static String m68(names) => "다음 프록시 공급자가 없습니다: ${names}";

  static String m69(names) => "다음 프록시 또는 정책이 없습니다: ${names}";

  static String m70(name) => "${name}은(는) 기본 정책 이름이므로 여기서 사용할 수 없습니다";

  static String m71(count) => "${count}개 항목에 문제가 있어 덮어쓰기 적용에 실패할 수 있습니다";

  static String m72(id) => "요금제 #${id}";

  static String m73(port) => "권장 포트 ${port}을 입력했습니다.";

  static String m74(label) => "${label}은(는) 1024에서 49151 사이여야 합니다";

  static String m75(port) =>
      "혼합 포트 ${port}에서 수신을 시작하지 못했습니다. 다른 앱이 사용 중일 수 있습니다. 포트를 변경하면 즉시 다시 시도할 수 있습니다.";

  static String m76(port) => "포트 ${port}";

  static String m77(days) => "${Intl.plural(days, other: '${days}일 남음')}";

  static String m78(date, days) =>
      "${date} 만료, ${Intl.plural(days, other: '${days}일')} 남음";

  static String m79(profiles) =>
      "이 프로필은 ${profiles}의 프록시 공급자입니다. 먼저 해당 프로필에서 제거하세요.";

  static String m80(time) => "${time} 업데이트";

  static String m81(profiles) => "${profiles}에서 아직 이 리소스를 사용하고 있습니다";

  static String m82(profiles) => "이름을 변경하면 ${profiles}의 구독 리소스 참조가 달라집니다";

  static String m83(profiles) => "이름을 변경하기 전에 원본 프로필의 참조를 수정하세요: ${profiles}";

  static String m84(profiles) => "참조를 확인하기 위해 다음 프로필을 읽을 수 없습니다: ${profiles}";

  static String m85(count) =>
      "${Intl.plural(count, one: '프록시 1개', other: '프록시 ${count}개')}";

  static String m86(name) => "노드 ${name}은 다른 활성 체인에서 사용 중이거나 체인 연결 관계가 충돌합니다";

  static String m87(name) => "이 위치에서는 노드 ${name}을 사용할 수 없습니다";

  static String m88(address) => "시작 전 시스템 프록시가 ${address}을(를) 가리키고 있었습니다.";

  static String m89(name) => "시작 전 트래픽이 다른 VPN 또는 가상 어댑터를 통과하고 있었습니다: ${name}.";

  static String m90(count) =>
      "${Intl.plural(count, one: '프록시 그룹 1개', other: '프록시 그룹 ${count}개')}";

  static String m91(count) => "${count}일";

  static String m92(count) => "${count}시간";

  static String m93(count) => "${count}분";

  static String m94(name, path) => "원본 설정의 ${path}에서 ${name}을 참조하고 있습니다";

  static String m95(min, max) => "허용 범위: ${min} – ${max}";

  static String m96(value) => "남은 용량: ${value}";

  static String m97(count) => "${count}개 남음";

  static String m98(seconds) => "${seconds}초 후 재전송";

  static String m99(limit) => "리소스가 ${limit}를 초과합니다";

  static String m100(count) =>
      "${Intl.plural(count, one: '규칙 1개', other: '규칙 ${count}개')}";

  static String m101(appName) => "${appName} (안전 모드)";

  static String m102(count) => "추가됨(${count})";

  static String m103(count) => "수정됨(${count})";

  static String m104(count) => "삭제됨(${count})";

  static String m105(count) => "${count}초";

  static String m106(count) => "${count}개 적용 중";

  static String m107(count) => "${Intl.plural(count, other: '설정 ${count}개')}";

  static String m108(count) =>
      "${Intl.plural(count, one: '공유 링크에서 노드 1개를 추가했습니다', other: '공유 링크에서 노드 ${count}개를 추가했습니다')}";

  static String m109(count) =>
      "${Intl.plural(count, one: '링크 1개를 읽지 못했습니다', other: '링크 ${count}개를 읽지 못했습니다')}";

  static String m110(label) => "${label}은(는) 하나만 입력해야 합니다";

  static String m111(fields) => "다음 설정을 확인하세요: ${fields}";

  static String m112(count) => "기기(${count})";

  static String m113(name, profile) =>
      "프로필 ${profile}의 규칙 또는 그룹이 아직 ${name}을(를) 사용하고 있습니다";

  static String m114(region) => "중계 ${region}";

  static String m115(name) =>
      "이 기기가 ${name}에서 나가고 기기에 저장된 로그인 정보가 삭제됩니다. 현재 네트워크에 연결할 수 없다면 Tailscale 관리 콘솔에서 기기를 제거하세요.";

  static String m116(value) => "최고 ${value}";

  static String m117(value) => "합계 ${value}";

  static String m118(build) => "빌드: ${build}";

  static String m119(version) => "버전: ${version}";

  static String m120(label) => "${label}은(는) URL이어야 합니다";

  static String m121(count) => "${Intl.plural(count, other: '${count}년 전')}";

  static String m122(count) => "${Intl.plural(count, other: '${count}년 전')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("정보"),
    "accessControl": MessageLookupByLibrary.simpleMessage("접근 제어"),
    "accessControlAllowDesc": MessageLookupByLibrary.simpleMessage(
      "선택한 앱만 VPN 사용",
    ),
    "accessControlDesc": MessageLookupByLibrary.simpleMessage("앱의 프록시 접근 설정"),
    "accessControlDisabledDesc": MessageLookupByLibrary.simpleMessage(
      "앱 접근 제어가 꺼져 있습니다",
    ),
    "accessControlNotAllowDesc": MessageLookupByLibrary.simpleMessage(
      "선택한 앱을 VPN에서 제외",
    ),
    "accessControlSettings": MessageLookupByLibrary.simpleMessage("접근 제어 설정"),
    "accessToken": MessageLookupByLibrary.simpleMessage("액세스 토큰"),
    "account": MessageLookupByLibrary.simpleMessage("계정"),
    "accountBalance": MessageLookupByLibrary.simpleMessage("잔액"),
    "action": MessageLookupByLibrary.simpleMessage("동작"),
    "action_copyEnv": MessageLookupByLibrary.simpleMessage("프록시 환경 변수 복사"),
    "action_delayTest": MessageLookupByLibrary.simpleMessage("노드 지연 테스트"),
    "action_directMode": MessageLookupByLibrary.simpleMessage("직접 연결 모드"),
    "action_exit": MessageLookupByLibrary.simpleMessage("종료"),
    "action_globalMode": MessageLookupByLibrary.simpleMessage("글로벌 모드"),
    "action_mode": MessageLookupByLibrary.simpleMessage("모드 전환"),
    "action_proxy": MessageLookupByLibrary.simpleMessage("시스템 프록시"),
    "action_ruleMode": MessageLookupByLibrary.simpleMessage("규칙 모드"),
    "action_start": MessageLookupByLibrary.simpleMessage("시작/중지"),
    "action_tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "action_updateProfiles": MessageLookupByLibrary.simpleMessage("프로필 업데이트"),
    "action_view": MessageLookupByLibrary.simpleMessage("표시/숨기기"),
    "activate": MessageLookupByLibrary.simpleMessage("활성화"),
    "activatePlanConfirm": MessageLookupByLibrary.simpleMessage(
      "이 요금제를 활성화하시겠습니까? 현재 사용 요금제로 적용됩니다.",
    ),
    "activatePlanTitle": MessageLookupByLibrary.simpleMessage("요금제 활성화"),
    "add": MessageLookupByLibrary.simpleMessage("추가"),
    "addNodes": MessageLookupByLibrary.simpleMessage("노드 추가"),
    "addOverrideEntry": MessageLookupByLibrary.simpleMessage("덮어쓰기 항목 추가"),
    "addProfile": MessageLookupByLibrary.simpleMessage("프로필 추가"),
    "addProxyChainNode": MessageLookupByLibrary.simpleMessage("추가"),
    "addProxyGroup": MessageLookupByLibrary.simpleMessage("프록시 그룹 추가"),
    "addRule": MessageLookupByLibrary.simpleMessage("규칙 추가"),
    "addSettingEntry": MessageLookupByLibrary.simpleMessage("설정 추가"),
    "addSsid": MessageLookupByLibrary.simpleMessage("SSID 추가"),
    "addedRules": MessageLookupByLibrary.simpleMessage("추가한 규칙"),
    "additionalParameters": MessageLookupByLibrary.simpleMessage("추가 매개변수"),
    "additionalPrefix": MessageLookupByLibrary.simpleMessage("이름 접두사"),
    "additionalSuffix": MessageLookupByLibrary.simpleMessage("이름 접미사"),
    "address": MessageLookupByLibrary.simpleMessage("주소"),
    "addressCopied": MessageLookupByLibrary.simpleMessage("주소를 복사했습니다"),
    "addressHelp": MessageLookupByLibrary.simpleMessage("WebDAV 서버 주소"),
    "addressTip": MessageLookupByLibrary.simpleMessage("올바른 WebDAV 주소를 입력하세요"),
    "advancedConfig": MessageLookupByLibrary.simpleMessage("고급 구성"),
    "advancedConfigDesc": MessageLookupByLibrary.simpleMessage("다양한 설정 옵션 제공"),
    "ageDecryptFailedTip": MessageLookupByLibrary.simpleMessage(
      "프로필을 복호화하지 못했습니다. age 비밀 키를 확인한 후 다시 시도하세요.",
    ),
    "ageSecretKey": MessageLookupByLibrary.simpleMessage("age 비밀 키"),
    "ageSecretKeyRequiredTip": MessageLookupByLibrary.simpleMessage(
      "이 프로필은 age로 암호화되어 있어 복호화하려면 age 비밀 키가 필요합니다",
    ),
    "allowBackgroundLocation": MessageLookupByLibrary.simpleMessage("항상 위치 허용"),
    "allowBypass": MessageLookupByLibrary.simpleMessage("앱의 VPN 우회 허용"),
    "allowBypassDesc": MessageLookupByLibrary.simpleMessage(
      "일부 앱이 VPN을 우회하도록 허용",
    ),
    "allowLan": MessageLookupByLibrary.simpleMessage("LAN 허용"),
    "allowLanDesc": MessageLookupByLibrary.simpleMessage("LAN에서 프록시 접근 허용"),
    "allowTemporarily": MessageLookupByLibrary.simpleMessage("일시적으로 허용"),
    "allowedIps": MessageLookupByLibrary.simpleMessage("허용 IP"),
    "amountDueLabel": MessageLookupByLibrary.simpleMessage("결제할 금액"),
    "amountPayable": MessageLookupByLibrary.simpleMessage("결제 금액"),
    "announcement": MessageLookupByLibrary.simpleMessage("공지"),
    "apiAvailable": MessageLookupByLibrary.simpleMessage("API 서비스가 정상 작동 중입니다"),
    "apiAvailableWithCertificateException":
        MessageLookupByLibrary.simpleMessage(
          "인증서 예외를 임시 적용하여 API에 연결했습니다. 계정이나 노드 설정은 동기화하지 않았습니다. 인증서 문제를 해결한 후 다시 확인하세요.",
        ),
    "app": MessageLookupByLibrary.simpleMessage("앱"),
    "appAccessControl": MessageLookupByLibrary.simpleMessage("앱 접근 제어"),
    "appProviderLibrary": MessageLookupByLibrary.simpleMessage("공급자 라이브러리"),
    "appendSystemDns": MessageLookupByLibrary.simpleMessage("시스템 DNS 추가"),
    "appendSystemDnsTip": MessageLookupByLibrary.simpleMessage(
      "설정에 시스템 DNS를 강제로 추가",
    ),
    "application": MessageLookupByLibrary.simpleMessage("애플리케이션"),
    "authentication": MessageLookupByLibrary.simpleMessage("로컬 프록시 인증"),
    "authenticationApplyFailed": MessageLookupByLibrary.simpleMessage(
      "인증 설정을 적용하지 못했습니다",
    ),
    "authenticationDesc": MessageLookupByLibrary.simpleMessage(
      "HTTP 및 SOCKS 포트에서 사용자 이름과 비밀번호를 요구합니다. 켜져 있는 동안 시스템 HTTP 프록시는 설정하지 않으며 TUN과 VPN은 계속 작동합니다",
    ),
    "authenticationPasswordInvalid": MessageLookupByLibrary.simpleMessage(
      "제어 문자를 제외한 UTF-8 1~255바이트를 사용하세요",
    ),
    "authenticationSystemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "로컬 프록시 인증이 켜져 있으면 시스템 프록시를 적용하지 않습니다",
    ),
    "authenticationUsernameInvalid": MessageLookupByLibrary.simpleMessage(
      "콜론과 제어 문자를 제외한 UTF-8 1~255바이트를 사용하세요",
    ),
    "authorized": MessageLookupByLibrary.simpleMessage("허용됨"),
    "auto": MessageLookupByLibrary.simpleMessage("자동"),
    "autoCloseConnections": MessageLookupByLibrary.simpleMessage("연결 자동 종료"),
    "autoCloseConnectionsDesc": MessageLookupByLibrary.simpleMessage(
      "노드 변경 후 연결 자동 종료",
    ),
    "autoInclude": MessageLookupByLibrary.simpleMessage("자동 포함"),
    "autoIpv6": MessageLookupByLibrary.simpleMessage("자동 IPv6"),
    "autoIpv6Desc": MessageLookupByLibrary.simpleMessage(
      "로컬 네트워크의 지원 여부에 따라 IPv6를 자동으로 켜거나 끕니다",
    ),
    "autoLaunch": MessageLookupByLibrary.simpleMessage("자동 실행"),
    "autoLaunchDesc": MessageLookupByLibrary.simpleMessage("시스템 시작 시 자동 실행"),
    "autoRun": MessageLookupByLibrary.simpleMessage("자동 시작"),
    "autoRunDesc": MessageLookupByLibrary.simpleMessage("앱을 열 때 자동 실행"),
    "autoSetSystemDns": MessageLookupByLibrary.simpleMessage("시스템 DNS 자동 설정"),
    "autoUpdate": MessageLookupByLibrary.simpleMessage("자동 업데이트"),
    "autoUpdateInterval": MessageLookupByLibrary.simpleMessage("자동 업데이트 간격"),
    "availableBalance": m0,
    "availablePlans": MessageLookupByLibrary.simpleMessage("요금제 선택"),
    "back": MessageLookupByLibrary.simpleMessage("뒤로"),
    "backup": MessageLookupByLibrary.simpleMessage("백업"),
    "backupAndRestore": MessageLookupByLibrary.simpleMessage("백업 및 복원"),
    "backupAndRestoreDesc": MessageLookupByLibrary.simpleMessage(
      "WebDAV 또는 파일로 데이터 동기화",
    ),
    "backupFromNewerVersion": MessageLookupByLibrary.simpleMessage(
      "이 백업은 더 최신 버전의 앱에서 만들어졌습니다. 복원하기 전에 앱을 업데이트하세요",
    ),
    "backupRetention": MessageLookupByLibrary.simpleMessage("보관할 백업 수"),
    "backupRetentionDesc": MessageLookupByLibrary.simpleMessage(
      "백업할 때 이 기기의 오래된 WebDAV 백업을 삭제합니다",
    ),
    "backupSuccess": MessageLookupByLibrary.simpleMessage("백업 성공"),
    "balance": MessageLookupByLibrary.simpleMessage("잔액"),
    "balanceDeductionHint": MessageLookupByLibrary.simpleMessage(
      "구매 시 잔액을 먼저 사용하고 부족한 금액은 수수료 잔액에서 차감합니다.",
    ),
    "basicInfo": MessageLookupByLibrary.simpleMessage("기본 정보"),
    "basicStrategy": MessageLookupByLibrary.simpleMessage("기본 전략"),
    "batchAdd": MessageLookupByLibrary.simpleMessage("일괄 추가"),
    "batchLinkInputTip": MessageLookupByLibrary.simpleMessage("한 줄에 링크 하나씩"),
    "batchListInputTip": MessageLookupByLibrary.simpleMessage(
      "한 줄에 하나씩 또는 쉼표로 구분하여 입력하세요",
    ),
    "batchMapInputTip": MessageLookupByLibrary.simpleMessage(
      "한 줄에 하나씩, 키, 공백, 값 순서로 입력하세요",
    ),
    "batchPreviewTip": m1,
    "batteryOptimizationDesc": MessageLookupByLibrary.simpleMessage(
      "배터리 최적화를 무시하면 앱이 백그라운드에서 계속 실행됩니다.",
    ),
    "batteryOptimizationStatusTip": MessageLookupByLibrary.simpleMessage(
      "시스템 제한으로 인해 실행 중에는 배터리 최적화 상태를 정확히 읽을 수 없습니다",
    ),
    "behavior": MessageLookupByLibrary.simpleMessage("동작"),
    "billingPeriodLabel": MessageLookupByLibrary.simpleMessage("청구 주기"),
    "bind": MessageLookupByLibrary.simpleMessage("연결"),
    "bindCoupon": MessageLookupByLibrary.simpleMessage("쿠폰 적용"),
    "bindCouponIntro": MessageLookupByLibrary.simpleMessage(
      "공식 쿠폰 코드를 입력하세요. 요금제의 남은 기간에 대해 차액을 정산하며, 반복 적용 쿠폰은 갱신 가격도 변경합니다.",
    ),
    "blacklistMode": MessageLookupByLibrary.simpleMessage("블랙리스트 모드"),
    "blockQuic": MessageLookupByLibrary.simpleMessage("QUIC 차단"),
    "blockQuicDesc": MessageLookupByLibrary.simpleMessage(
      "UDP 443 트래픽을 거부하여 TCP 연결로 전환",
    ),
    "blockWebRtc": MessageLookupByLibrary.simpleMessage("WebRTC 차단"),
    "blockWebRtcDesc": MessageLookupByLibrary.simpleMessage(
      "STUN 트래픽을 거부하여 WebRTC IP 유출을 줄입니다.",
    ),
    "brightness": MessageLookupByLibrary.simpleMessage("밝기"),
    "buy": MessageLookupByLibrary.simpleMessage("구매"),
    "bypassDomain": MessageLookupByLibrary.simpleMessage("우회 도메인"),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage(
      "우회 도메인은 시스템 프록시가 켜져 있을 때만 적용됩니다.",
    ),
    "bypassPrivateRoute": MessageLookupByLibrary.simpleMessage("사설 주소 우회"),
    "bypassPrivateRouteDesc": MessageLookupByLibrary.simpleMessage(
      "사설 주소 우회를 켜면 LAN, 루프백, 멀티캐스트 주소는 TUN을 거치지 않습니다.",
    ),
    "cacheAlgorithm": MessageLookupByLibrary.simpleMessage("캐시 알고리즘"),
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "캐시가 손상되었습니다. 지우시겠습니까?",
    ),
    "cacheMaxSize": MessageLookupByLibrary.simpleMessage("캐시 크기"),
    "calculatingQuote": MessageLookupByLibrary.simpleMessage("계산 중…"),
    "cameraPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "QR 코드를 스캔하려면 시스템 설정에서 카메라 접근을 허용하거나, 앨범에서 QR 코드 이미지를 선택하세요.",
    ),
    "cameraPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "카메라 권한 필요",
    ),
    "cameraUnavailable": MessageLookupByLibrary.simpleMessage("카메라를 사용할 수 없음"),
    "cancel": MessageLookupByLibrary.simpleMessage("취소"),
    "cancelSelectAll": MessageLookupByLibrary.simpleMessage("모두 선택 해제"),
    "certificateCheckOnlyHint": MessageLookupByLibrary.simpleMessage(
      "이 작업은 API 연결만 확인하며, 로그인하거나 노드 설정을 다운로드하지 않습니다.",
    ),
    "certificateExpired": MessageLookupByLibrary.simpleMessage("인증서가 만료되었습니다"),
    "certificateHostnameHint": MessageLookupByLibrary.simpleMessage(
      "다른 네트워크를 사용하고 Wi-Fi 로그인이 필요하다면 먼저 완료하세요. 문제가 계속되면 서비스 제공자에게 인증서가 서버 도메인과 일치하는지 확인해 달라고 요청하세요.",
    ),
    "certificateHostnameMismatch": MessageLookupByLibrary.simpleMessage(
      "인증서가 요청한 도메인과 일치하지 않습니다",
    ),
    "certificateNotYetValid": MessageLookupByLibrary.simpleMessage(
      "아직 유효하지 않은 인증서입니다",
    ),
    "certificateRevoked": MessageLookupByLibrary.simpleMessage("인증서가 폐기되었습니다"),
    "certificateRevokedHint": MessageLookupByLibrary.simpleMessage(
      "서비스 제공자에게 폐기된 인증서를 교체해 달라고 요청하세요. 재시도하거나 시스템 시간을 변경해도 폐기된 인증서는 복구되지 않습니다.",
    ),
    "certificateSyncRetryDescription": MessageLookupByLibrary.simpleMessage(
      "확인하면 이번 시도에서 연결을 확인하고 계정을 새로 고친 뒤 노드 설정을 다운로드합니다. 동기화가 끝나면 인증서 예외가 해제됩니다.",
    ),
    "certificateUnknownHint": MessageLookupByLibrary.simpleMessage(
      "시스템 날짜와 시간을 확인한 후 다른 네트워크를 사용하세요. 검증이 계속 실패하면 이 오류를 서비스 제공자에게 전달하여 도움을 받으세요.",
    ),
    "certificateUntrusted": MessageLookupByLibrary.simpleMessage(
      "신뢰할 수 없는 인증서 체인입니다",
    ),
    "certificateUntrustedHint": MessageLookupByLibrary.simpleMessage(
      "휴대전화 핫스팟 등 다른 네트워크를 사용하고 시스템 업데이트를 확인하세요. 백신이나 회사 네트워크가 HTTPS를 검사한다면 관리자에게 확인을 요청하세요. 문제가 계속되면 서비스 제공자에게 인증서 체인을 확인해 달라고 요청하세요.",
    ),
    "certificateValidityHint": MessageLookupByLibrary.simpleMessage(
      "먼저 시스템 날짜와 시간을 동기화하세요. 시간이 정확하다면 서버 인증서를 수정해야 합니다.",
    ),
    "changeProxyFailedTip": MessageLookupByLibrary.simpleMessage(
      "프록시를 전환하지 못해 이전 선택을 복원했습니다",
    ),
    "changelogBreaking": MessageLookupByLibrary.simpleMessage("호환성 변경"),
    "changelogFeatures": MessageLookupByLibrary.simpleMessage("새로운 기능"),
    "changelogFixes": MessageLookupByLibrary.simpleMessage("버그 수정"),
    "changelogPerformance": MessageLookupByLibrary.simpleMessage("성능"),
    "changelogReverts": MessageLookupByLibrary.simpleMessage("되돌림"),
    "checkApi": MessageLookupByLibrary.simpleMessage("API 확인"),
    "checkRouting": MessageLookupByLibrary.simpleMessage("설정 확인"),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("업데이트 확인"),
    "checkUpdateError": MessageLookupByLibrary.simpleMessage("이미 최신 버전입니다"),
    "checkUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "업데이트를 확인하지 못했습니다. 네트워크를 확인한 후 다시 시도하세요",
    ),
    "checkingPayment": MessageLookupByLibrary.simpleMessage("확인 중…"),
    "chooseMembers": MessageLookupByLibrary.simpleMessage("구성원 선택"),
    "cipher": MessageLookupByLibrary.simpleMessage("암호화 방식"),
    "clearCustomRouting": MessageLookupByLibrary.simpleMessage("모두 지우기"),
    "clearData": MessageLookupByLibrary.simpleMessage("데이터 지우기"),
    "clearProxyChain": MessageLookupByLibrary.simpleMessage("체인 설정 지우기"),
    "clearSearch": MessageLookupByLibrary.simpleMessage("검색 지우기"),
    "clientFingerprint": MessageLookupByLibrary.simpleMessage("클라이언트 핑거프린트"),
    "clipboardExport": MessageLookupByLibrary.simpleMessage("클립보드로 내보내기"),
    "clipboardImport": MessageLookupByLibrary.simpleMessage("클립보드에서 가져오기"),
    "clipboardWriteFailed": MessageLookupByLibrary.simpleMessage(
      "클립보드에 복사하지 못했습니다. 선택 영역이 너무 클 수 있습니다",
    ),
    "close": MessageLookupByLibrary.simpleMessage("닫기"),
    "closeAllConnections": MessageLookupByLibrary.simpleMessage("모든 연결 닫기"),
    "cloudApiAccessDenied": MessageLookupByLibrary.simpleMessage("네트워크 접근 거부됨"),
    "cloudApiAddressInUse": MessageLookupByLibrary.simpleMessage(
      "네트워크 주소 또는 포트가 이미 사용 중입니다",
    ),
    "cloudApiAddressUnavailable": MessageLookupByLibrary.simpleMessage(
      "네트워크 주소를 사용할 수 없습니다",
    ),
    "cloudApiBadGateway": MessageLookupByLibrary.simpleMessage(
      "게이트웨이가 상위 서버에서 유효하지 않은 응답을 받았습니다",
    ),
    "cloudApiBadRequest": MessageLookupByLibrary.simpleMessage(
      "서버가 유효하지 않은 요청으로 거부했습니다",
    ),
    "cloudApiClockSkew": MessageLookupByLibrary.simpleMessage(
      "기기 시계와 서버 시계의 차이가 너무 큽니다. 자동 날짜 및 시간을 켠 후 다시 시도하세요.",
    ),
    "cloudApiConnectTimeout": MessageLookupByLibrary.simpleMessage("연결 시간 초과"),
    "cloudApiConnectionAborted": MessageLookupByLibrary.simpleMessage(
      "연결이 중단되었습니다",
    ),
    "cloudApiConnectionFailed": MessageLookupByLibrary.simpleMessage("연결 실패"),
    "cloudApiConnectionRefused": MessageLookupByLibrary.simpleMessage("연결 거부됨"),
    "cloudApiConnectionReset": MessageLookupByLibrary.simpleMessage("연결이 재설정됨"),
    "cloudApiDnsEmpty": MessageLookupByLibrary.simpleMessage(
      "DNS가 주소를 반환하지 않았습니다. 차단되었거나 시스템 DNS 확인기에 문제가 있을 수 있습니다",
    ),
    "cloudApiDnsFailed": MessageLookupByLibrary.simpleMessage("DNS 조회 실패"),
    "cloudApiDnsUnknownHost": MessageLookupByLibrary.simpleMessage(
      "DNS에서 이 도메인을 찾지 못했습니다",
    ),
    "cloudApiForbidden": MessageLookupByLibrary.simpleMessage("접근 금지"),
    "cloudApiGatewayTimeout": MessageLookupByLibrary.simpleMessage(
      "게이트웨이의 상위 서버 응답 대기 시간이 초과되었습니다",
    ),
    "cloudApiHttpError": m2,
    "cloudApiInvalidResponse": MessageLookupByLibrary.simpleMessage(
      "서버 응답이 유효하지 않습니다",
    ),
    "cloudApiMethodNotAllowed": MessageLookupByLibrary.simpleMessage(
      "허용되지 않은 요청 메서드입니다",
    ),
    "cloudApiNetworkAuthRequired": MessageLookupByLibrary.simpleMessage(
      "이 네트워크에 접근하려면 먼저 로그인해야 합니다",
    ),
    "cloudApiNetworkResourcesExhausted": MessageLookupByLibrary.simpleMessage(
      "시스템 네트워크 리소스가 부족합니다",
    ),
    "cloudApiNetworkUnreachable": MessageLookupByLibrary.simpleMessage(
      "네트워크에 연결할 수 없음",
    ),
    "cloudApiNotFound": MessageLookupByLibrary.simpleMessage(
      "요청한 API 또는 리소스를 찾지 못했습니다",
    ),
    "cloudApiProxyAuthFailed": MessageLookupByLibrary.simpleMessage(
      "프록시 인증 실패(HTTP 407)",
    ),
    "cloudApiProxyFailed": MessageLookupByLibrary.simpleMessage("프록시 연결 실패"),
    "cloudApiRateLimited": MessageLookupByLibrary.simpleMessage(
      "요청이 너무 많습니다. 나중에 다시 시도하세요",
    ),
    "cloudApiReceiveTimeout": MessageLookupByLibrary.simpleMessage(
      "응답 대기 시간 초과",
    ),
    "cloudApiRedirectInvalid": MessageLookupByLibrary.simpleMessage(
      "서버 리디렉션이 유효하지 않습니다",
    ),
    "cloudApiRedirectLimit": MessageLookupByLibrary.simpleMessage(
      "서버 리디렉션이 너무 많습니다",
    ),
    "cloudApiRedirectLoop": MessageLookupByLibrary.simpleMessage(
      "서버 리디렉션이 반복됩니다",
    ),
    "cloudApiRequestCanceled": MessageLookupByLibrary.simpleMessage("요청 취소됨"),
    "cloudApiRequestTooLarge": MessageLookupByLibrary.simpleMessage(
      "요청이 서버의 크기 제한을 초과했습니다",
    ),
    "cloudApiResponseInterrupted": MessageLookupByLibrary.simpleMessage(
      "전체 응답을 받기 전에 연결이 닫혔습니다",
    ),
    "cloudApiResponseTooLarge": MessageLookupByLibrary.simpleMessage(
      "서버 응답이 허용된 크기를 초과했습니다",
    ),
    "cloudApiRouteDirect": m3,
    "cloudApiRouteProxy": m4,
    "cloudApiSendTimeout": MessageLookupByLibrary.simpleMessage("요청 전송 시간 초과"),
    "cloudApiServerError": MessageLookupByLibrary.simpleMessage("서버 내부 오류"),
    "cloudApiServerRequestTimeout": MessageLookupByLibrary.simpleMessage(
      "서버의 요청 수신 시간이 초과되었습니다",
    ),
    "cloudApiServerUnconfigured": MessageLookupByLibrary.simpleMessage(
      "서버에 이 앱의 키가 설정되어 있지 않습니다. 고객 지원에 문의하세요.",
    ),
    "cloudApiServiceUnavailable": MessageLookupByLibrary.simpleMessage(
      "서비스를 일시적으로 사용할 수 없습니다",
    ),
    "cloudApiSignatureRejected": MessageLookupByLibrary.simpleMessage(
      "서버가 이 앱의 서명을 거부했습니다. 최신 공식 버전을 다시 설치하세요.",
    ),
    "cloudApiSystemError": m5,
    "cloudApiTimeout": MessageLookupByLibrary.simpleMessage("요청 시간 초과"),
    "cloudApiTlsAlgorithmFailed": MessageLookupByLibrary.simpleMessage(
      "TLS 암호화 알고리즘 협상 실패",
    ),
    "cloudApiTlsFailed": MessageLookupByLibrary.simpleMessage("TLS 핸드셰이크 실패"),
    "cloudApiTlsInterrupted": MessageLookupByLibrary.simpleMessage(
      "TLS 핸드셰이크가 완료되기 전에 연결이 닫혔습니다",
    ),
    "cloudApiTlsProtocolFailed": MessageLookupByLibrary.simpleMessage(
      "TLS 프로토콜이 호환되지 않거나 TLS 응답이 유효하지 않습니다",
    ),
    "cloudCertificateSyncFailed": MessageLookupByLibrary.simpleMessage(
      "API 확인은 통과했으나 계정 또는 노드 설정 동기화에 실패했습니다: ",
    ),
    "cloudConfigSyncIncomplete": MessageLookupByLibrary.simpleMessage(
      "노드 설정을 다운로드하지 못했습니다. 다운로드 오류를 해결한 후 다시 동기화하세요.",
    ),
    "cloudSyncedWithCertificateException": MessageLookupByLibrary.simpleMessage(
      "인증서 예외를 임시 적용하여 계정과 설정을 동기화했습니다. 검증이 다시 활성화되었습니다. 다음 동기화 전에 인증서 문제를 해결하세요.",
    ),
    "codeSent": MessageLookupByLibrary.simpleMessage("인증 코드를 전송했습니다"),
    "collapseList": MessageLookupByLibrary.simpleMessage("접기"),
    "color": MessageLookupByLibrary.simpleMessage("색상"),
    "colorStyle": MessageLookupByLibrary.simpleMessage("색상 스타일"),
    "columns": MessageLookupByLibrary.simpleMessage("열"),
    "commission": MessageLookupByLibrary.simpleMessage("수수료"),
    "commissionBalance": m6,
    "compact": MessageLookupByLibrary.simpleMessage("간결하게"),
    "compatible": MessageLookupByLibrary.simpleMessage("호환 모드"),
    "configDataDetected": MessageLookupByLibrary.simpleMessage(
      "설정에서 데이터를 발견했습니다",
    ),
    "configParseErrorAtLine": m7,
    "configRecoveryKeyring": MessageLookupByLibrary.simpleMessage(
      "시스템 키링(Secret Service)에 접근하지 못했습니다. 시스템 설정에서 KDE Wallet 또는 GNOME Keyring을 켜고 잠금을 해제한 후 다시 시도하세요.",
    ),
    "configRecoveryMessage": MessageLookupByLibrary.simpleMessage(
      "로컬 설정을 일시적으로 사용할 수 없습니다. 기존 데이터는 보존되었습니다. 기기의 잠금을 해제한 후 다시 시도하거나 나중에 앱을 다시 여세요.",
    ),
    "configRecoveryMissingKey": MessageLookupByLibrary.simpleMessage(
      "기존 설정의 암호화 키가 없거나 유효하지 않습니다. 원래 기기의 원래 시스템 계정을 사용하거나 백업을 복원하세요. 재시도로 분실한 키를 다시 만들 수는 없습니다.",
    ),
    "configRecoveryReset": MessageLookupByLibrary.simpleMessage("백업 후 초기화"),
    "configRecoveryResetConfirm": MessageLookupByLibrary.simpleMessage(
      "모든 로컬 설정, 구독, 규칙 및 계정 데이터를 암호화하여 백업한 후 앱을 초기화하시겠습니까? 다시 로그인하고 구독과 설정을 복원하거나 가져와야 합니다. 백업은 이 Windows 계정으로 보호되며, 분실한 암호화 키는 복구할 수 없습니다.",
    ),
    "configRecoveryResetDone": MessageLookupByLibrary.simpleMessage(
      "원본 데이터의 암호화된 백업을 아래 폴더에 저장했습니다. 앱을 종료한 후 다시 열어 설정하세요.",
    ),
    "configRecoveryResetFailed": MessageLookupByLibrary.simpleMessage(
      "암호화 백업 및 초기화를 완료하지 못했습니다. 검증된 백업 없이는 남아 있는 원본 데이터를 삭제하지 않습니다. 다시 시도하거나 앱을 종료한 후 다시 열어 작업을 완료하세요.",
    ),
    "configRecoveryRetry": MessageLookupByLibrary.simpleMessage("다시 시도"),
    "configRecoveryStorage": MessageLookupByLibrary.simpleMessage(
      "로컬 설정 또는 암호화 키를 읽거나 저장하지 못했습니다. 앱 데이터 폴더와 시스템 보안 저장소에 대한 접근 권한을 확인한 후 다시 시도하세요.",
    ),
    "configRecoveryTitle": MessageLookupByLibrary.simpleMessage("로컬 설정 복구"),
    "configRecoveryUnreadable": MessageLookupByLibrary.simpleMessage(
      "로컬 설정을 복호화할 수 없거나 설정이 손상되었습니다. 기존 파일은 보존되었습니다. 일치하는 키와 설정 백업을 복원하거나 백업 후 초기화하세요.",
    ),
    "configRecoveryUseLocalStorage": MessageLookupByLibrary.simpleMessage(
      "로컬 파일 저장소 사용",
    ),
    "configRecoveryUseLocalStorageConfirm":
        MessageLookupByLibrary.simpleMessage(
          "시스템 키링 대신 사용자 계정만 열 수 있는 앱 데이터 폴더의 파일에 암호화 키와 계정 인증 정보를 저장하시겠습니까? 같은 사용자 계정으로 실행되는 모든 프로그램이 이를 읽고 로컬 설정을 복호화할 수 있습니다. 이 선택은 이후에도 유지됩니다.",
        ),
    "configTypeMismatch": m8,
    "configValueTypeBoolean": MessageLookupByLibrary.simpleMessage("불리언"),
    "configValueTypeInteger": MessageLookupByLibrary.simpleMessage("정수"),
    "configValueTypeList": MessageLookupByLibrary.simpleMessage("목록"),
    "configValueTypeNull": MessageLookupByLibrary.simpleMessage("빈 값"),
    "configValueTypeNumber": MessageLookupByLibrary.simpleMessage("숫자"),
    "configValueTypeObject": MessageLookupByLibrary.simpleMessage("객체"),
    "configValueTypeText": MessageLookupByLibrary.simpleMessage("텍스트"),
    "configYamlFormatHint": MessageLookupByLibrary.simpleMessage(
      "이 줄 주변의 들여쓰기와 목록 표시 \'-\'를 확인하세요.",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("확인"),
    "confirmClearAllData": MessageLookupByLibrary.simpleMessage(
      "모든 데이터를 지우시겠습니까?",
    ),
    "confirmClearCustomRouting": MessageLookupByLibrary.simpleMessage(
      "이 프로필의 사용자 지정 프록시 그룹과 규칙을 지우시겠습니까? 구독 내용, 추가 규칙, 프록시 체인 및 사용자 지정 노드는 유지됩니다.",
    ),
    "confirmDeleteProxyGroup": MessageLookupByLibrary.simpleMessage(
      "이 프록시 그룹을 삭제하시겠습니까?",
    ),
    "confirmExitWindow": MessageLookupByLibrary.simpleMessage("현재 창을 닫으시겠습니까?"),
    "confirmForceCrashCore": MessageLookupByLibrary.simpleMessage(
      "코어를 강제로 비정상 종료시키시겠습니까?",
    ),
    "confirmOverwriteTip": MessageLookupByLibrary.simpleMessage(
      "확인하면 기존 데이터를 덮어씁니다",
    ),
    "confirmPasswordHint": MessageLookupByLibrary.simpleMessage(
      "비밀번호를 다시 입력하세요",
    ),
    "confirmPasswordLabel": MessageLookupByLibrary.simpleMessage("비밀번호 확인"),
    "confirmPasswordValidation": MessageLookupByLibrary.simpleMessage(
      "비밀번호를 확인하세요",
    ),
    "confirmPurchase": MessageLookupByLibrary.simpleMessage("구매 확인"),
    "congestionControl": MessageLookupByLibrary.simpleMessage("혼잡 제어"),
    "congestionController": MessageLookupByLibrary.simpleMessage("TCP 혼잡 제어"),
    "congestionControllerDesc": MessageLookupByLibrary.simpleMessage(
      "TCP 혼잡 제어는 mips 스택에서만 작동합니다.",
    ),
    "connected": MessageLookupByLibrary.simpleMessage("연결됨"),
    "connecting": MessageLookupByLibrary.simpleMessage("연결 중…"),
    "connection": MessageLookupByLibrary.simpleMessage("연결"),
    "connectionStats": MessageLookupByLibrary.simpleMessage("연결 통계"),
    "connectionStatsDesc": MessageLookupByLibrary.simpleMessage(
      "실시간 연결, 최근 요청, DNS 쿼리",
    ),
    "connections": MessageLookupByLibrary.simpleMessage("연결"),
    "connectionsDesc": MessageLookupByLibrary.simpleMessage("현재 연결 정보 보기"),
    "connectivity": MessageLookupByLibrary.simpleMessage("연결 상태: "),
    "content": MessageLookupByLibrary.simpleMessage("내용"),
    "controlGlobalAddedRules": MessageLookupByLibrary.simpleMessage(
      "전역 추가 규칙 관리",
    ),
    "copy": MessageLookupByLibrary.simpleMessage("복사"),
    "copyEnvVar": MessageLookupByLibrary.simpleMessage("환경 변수 복사"),
    "copyLink": MessageLookupByLibrary.simpleMessage("링크 복사"),
    "copySuccess": MessageLookupByLibrary.simpleMessage("복사했습니다"),
    "core": MessageLookupByLibrary.simpleMessage("코어"),
    "coreBlockedByPolicyTip": m9,
    "coreBlockedBySmartAppControlTip": MessageLookupByLibrary.simpleMessage(
      "Windows가 FlClashCore.exe를 차단했으며 스마트 앱 컨트롤이 켜져 있습니다. Windows 보안 → 앱 및 브라우저 컨트롤에서 차단 세부 정보를 확인하고 신뢰할 수 있는 검증된 버전을 사용하세요.",
    ),
    "coreNotConnected": MessageLookupByLibrary.simpleMessage("코어가 연결되지 않았습니다"),
    "coreStatus": MessageLookupByLibrary.simpleMessage("코어 상태"),
    "crashTest": MessageLookupByLibrary.simpleMessage("비정상 종료 테스트"),
    "create": MessageLookupByLibrary.simpleMessage("만들기"),
    "createProfileFromUrlTip": m10,
    "creationTime": MessageLookupByLibrary.simpleMessage("생성 시간"),
    "currentOutboundDesc": MessageLookupByLibrary.simpleMessage(
      "시작 버튼이 있어 제거할 수 없습니다",
    ),
    "custom": MessageLookupByLibrary.simpleMessage("사용자 지정"),
    "customColor": MessageLookupByLibrary.simpleMessage("사용자 지정 색상"),
    "customImportCloudRefused": MessageLookupByLibrary.simpleMessage(
      "oixCloud 주소는 사용자 지정 프로필로 가져올 수 없습니다",
    ),
    "customImportDroppedSubRules": m11,
    "customImportNotImported": MessageLookupByLibrary.simpleMessage("가져오지 않음"),
    "customImportUnnamedProxies": m12,
    "customIssuesSummary": m13,
    "customOutboundInUse": m14,
    "customProfile": MessageLookupByLibrary.simpleMessage("사용자 지정 프로필"),
    "customProfileDesc": MessageLookupByLibrary.simpleMessage(
      "내 노드, 공급자 라이브러리 및 다른 프로필로 프록시 그룹과 규칙 구성",
    ),
    "customProfileResources": MessageLookupByLibrary.simpleMessage(
      "사용자 지정 프로필 리소스",
    ),
    "customRoutingDraftHint": MessageLookupByLibrary.simpleMessage(
      "사용자 지정 라우팅을 구성한 후 사용자 지정 모드로 전환하세요. 이 초안을 편집해도 현재 모드는 바뀌지 않습니다.",
    ),
    "customRuleChooseProvider": MessageLookupByLibrary.simpleMessage(
      "규칙 공급자 선택",
    ),
    "customRuleChooseTarget": MessageLookupByLibrary.simpleMessage("대상 선택"),
    "customRuleForm": MessageLookupByLibrary.simpleMessage("양식"),
    "customRuleFormUnavailable": MessageLookupByLibrary.simpleMessage(
      "고급 문법을 사용하는 규칙입니다. 모든 옵션을 유지하려면 규칙 텍스트를 편집하세요.",
    ),
    "customRuleInvalidContent": m15,
    "customRuleInvalidSyntax": MessageLookupByLibrary.simpleMessage(
      "올바른 유형, 내용 및 대상을 포함한 완전한 규칙을 입력하세요.",
    ),
    "customRuleMatchHint": MessageLookupByLibrary.simpleMessage(
      "남은 모든 트래픽에 일치합니다. 뒤에 있는 규칙은 실행되지 않습니다.",
    ),
    "customRuleNoResolveHint": MessageLookupByLibrary.simpleMessage(
      "도메인 이름을 확인하지 않고 알려진 IP 주소로 일치 여부를 확인합니다.",
    ),
    "customRuleRaw": MessageLookupByLibrary.simpleMessage("규칙 텍스트"),
    "customRuleRawHint": MessageLookupByLibrary.simpleMessage(
      "완전한 규칙 하나를 입력하세요. 고급 표현식은 유지됩니다.",
    ),
    "customRuleTargetHint": MessageLookupByLibrary.simpleMessage(
      "정책 그룹, 프록시 또는 기본 동작을 선택하세요.",
    ),
    "customRuleType": MessageLookupByLibrary.simpleMessage("규칙 유형"),
    "customRuleUnavailableProvider": m16,
    "customRuleUnavailableTarget": m17,
    "cut": MessageLookupByLibrary.simpleMessage("잘라내기"),
    "dark": MessageLookupByLibrary.simpleMessage("다크"),
    "dashboard": MessageLookupByLibrary.simpleMessage("대시보드"),
    "dashboardAddableSection": MessageLookupByLibrary.simpleMessage("추가 가능"),
    "dataChangedSave": MessageLookupByLibrary.simpleMessage(
      "변경된 데이터가 있습니다. 저장하시겠습니까?",
    ),
    "databaseWriteFailedTip": MessageLookupByLibrary.simpleMessage(
      "변경 사항을 저장하지 못했습니다. 현재 값을 확인한 후 다시 시도하세요.",
    ),
    "daysAgo": m18,
    "daysAgoShort": m19,
    "defaultNameserver": MessageLookupByLibrary.simpleMessage("기본 DNS 서버"),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "DNS 서버의 도메인 이름을 확인합니다",
    ),
    "defaultSelected": MessageLookupByLibrary.simpleMessage("기본 선택"),
    "defaultText": MessageLookupByLibrary.simpleMessage("기본값"),
    "definitionNotMap": MessageLookupByLibrary.simpleMessage(
      "구성은 이름과 유형이 있는 YAML 매핑이어야 합니다",
    ),
    "delay": MessageLookupByLibrary.simpleMessage("지연"),
    "delayConcurrency": MessageLookupByLibrary.simpleMessage(
      "일괄 지연 테스트 동시 실행 수",
    ),
    "delayConcurrencyAndroidDesc": MessageLookupByLibrary.simpleMessage(
      "Android 기본값: 16. 혼잡한 네트워크에서는 줄이세요. 다음 일괄 테스트부터 적용됩니다",
    ),
    "delayConcurrencyDesc": MessageLookupByLibrary.simpleMessage(
      "기본값: 50. 혼잡한 네트워크에서는 줄이세요. 다음 일괄 테스트부터 적용됩니다",
    ),
    "delayTest": MessageLookupByLibrary.simpleMessage("지연 테스트"),
    "delayTestFailed": MessageLookupByLibrary.simpleMessage("실패"),
    "delayTestQueued": MessageLookupByLibrary.simpleMessage("대기 중"),
    "delayTestRunning": MessageLookupByLibrary.simpleMessage("테스트 중"),
    "delete": MessageLookupByLibrary.simpleMessage("삭제"),
    "deleteBackupTip": MessageLookupByLibrary.simpleMessage(
      "WebDAV에서 이 백업을 삭제하시겠습니까?",
    ),
    "deleteMultipTip": m20,
    "deleteTip": m21,
    "desc": MessageLookupByLibrary.simpleMessage(
      "ClashMeta 기반의 멀티 플랫폼 프록시 클라이언트로, 간편하게 사용할 수 있으며 오픈 소스이고 광고가 없습니다.",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("목적지"),
    "destinationGeoIP": MessageLookupByLibrary.simpleMessage("목적지 GeoIP"),
    "destinationIPASN": MessageLookupByLibrary.simpleMessage("목적지 IP ASN"),
    "details": m22,
    "detectionTip": MessageLookupByLibrary.simpleMessage(
      "타사 API를 사용하며 결과는 참고용입니다",
    ),
    "developerMode": MessageLookupByLibrary.simpleMessage("개발자 모드"),
    "developerModeEnableTip": MessageLookupByLibrary.simpleMessage(
      "개발자 모드가 켜졌습니다.",
    ),
    "diagAllFailed": MessageLookupByLibrary.simpleMessage(
      "이 그룹에서 테스트한 모든 노드가 실패했습니다. 테스트 URL에 접근할 수 없는 경우일 수도 있습니다. 네트워크 자체 점검을 실행하시겠습니까?",
    ),
    "diagCanceled": MessageLookupByLibrary.simpleMessage("점검이 취소되어 결과가 불완전합니다"),
    "diagCaptureHint": MessageLookupByLibrary.simpleMessage(
      "시스템 프록시나 TUN을 켜거나 해당 앱이 로컬 프록시를 사용하도록 설정하세요.",
    ),
    "diagClock": MessageLookupByLibrary.simpleMessage("시스템 시간 비교"),
    "diagClockHint": MessageLookupByLibrary.simpleMessage(
      "시스템의 자동 날짜 및 시간을 켠 후 다시 시도하세요. 시계 오류는 인증서와 oixCloud DNS 서명에 영향을 줄 수 있습니다.",
    ),
    "diagClockReady": MessageLookupByLibrary.simpleMessage(
      "이번 표본에서 일관된 큰 시간 차이는 발견되지 않았습니다",
    ),
    "diagClockSkew": MessageLookupByLibrary.simpleMessage(
      "독립적인 두 응답에서 5분 이상의 시간 차이가 있을 가능성이 확인되었습니다",
    ),
    "diagClockUnknown": MessageLookupByLibrary.simpleMessage(
      "시간을 비교할 캐시되지 않은 HTTPS 응답이 부족합니다",
    ),
    "diagCopy": MessageLookupByLibrary.simpleMessage("진단 보고서 복사"),
    "diagCopyProxyAddress": MessageLookupByLibrary.simpleMessage("프록시 주소 복사"),
    "diagCore": MessageLookupByLibrary.simpleMessage("코어 응답"),
    "diagCoreDns": MessageLookupByLibrary.simpleMessage("코어 DNS"),
    "diagCoreHint": MessageLookupByLibrary.simpleMessage(
      "연결 스위치와 Wi-Fi 제외 설정을 확인하세요. 코어가 응답하지 않으면 다시 시작하고 서로 호환되는 최신 클라이언트와 코어를 사용하세요.",
    ),
    "diagCoreReady": MessageLookupByLibrary.simpleMessage(
      "코어가 응답했으며 수신 포트가 활성 상태라고 보고했습니다",
    ),
    "diagCoreStopped": MessageLookupByLibrary.simpleMessage(
      "코어가 트래픽 전달이 중지되었다고 보고했습니다",
    ),
    "diagCoreUnknown": MessageLookupByLibrary.simpleMessage(
      "코어 진단 응답을 사용할 수 없거나 설정이 변경되었습니다",
    ),
    "diagDisabled": MessageLookupByLibrary.simpleMessage("이 옵션이 켜져 있지 않습니다"),
    "diagDnsHint": MessageLookupByLibrary.simpleMessage(
      "DNS 덮어쓰기 설정을 확인하고 다른 네트워크를 사용하세요. 시스템 DNS는 작동하지만 코어 DNS가 실패하면 프로필의 DNS 설정을 확인하세요.",
    ),
    "diagDnsNoAnswer": MessageLookupByLibrary.simpleMessage(
      "DNS가 사용 가능한 주소를 반환하지 않았습니다. 이것만으로 인증 실패라고 판단할 수는 없습니다",
    ),
    "diagDnsPartial": MessageLookupByLibrary.simpleMessage(
      "표본 도메인 이름 중 일부만 확인했습니다",
    ),
    "diagDnsReady": MessageLookupByLibrary.simpleMessage("표본 도메인 이름을 확인했습니다"),
    "diagDnsRefused": MessageLookupByLibrary.simpleMessage("DNS 요청이 거부되었습니다"),
    "diagEntryHint": MessageLookupByLibrary.simpleMessage(
      "코어, 시스템 프록시, TUN 및 DNS 확인",
    ),
    "diagFailed": MessageLookupByLibrary.simpleMessage("실패"),
    "diagFixApplyProfile": MessageLookupByLibrary.simpleMessage("설정 적용"),
    "diagFixEnableSystemProxy": MessageLookupByLibrary.simpleMessage(
      "시스템 프록시 켜기",
    ),
    "diagFixFailed": MessageLookupByLibrary.simpleMessage(
      "수정 사항을 적용하지 못했습니다. 위의 안내를 따라 주세요.",
    ),
    "diagFixRestartConnection": MessageLookupByLibrary.simpleMessage("다시 연결"),
    "diagFixRestartCore": MessageLookupByLibrary.simpleMessage("코어 다시 시작"),
    "diagFixRetest": MessageLookupByLibrary.simpleMessage("노드 다시 테스트"),
    "diagFixStart": MessageLookupByLibrary.simpleMessage("연결 시작"),
    "diagFixSystemProxy": MessageLookupByLibrary.simpleMessage("시스템 프록시 다시 적용"),
    "diagFixTun": MessageLookupByLibrary.simpleMessage("TUN 다시 켜기"),
    "diagFixing": MessageLookupByLibrary.simpleMessage(
      "수정 사항을 적용한 후 다시 확인 중입니다",
    ),
    "diagListener": MessageLookupByLibrary.simpleMessage("로컬 프록시 수신"),
    "diagListenerFailed": MessageLookupByLibrary.simpleMessage(
      "예상한 프록시 포트가 응답하지 않거나 코어 포트와 다릅니다",
    ),
    "diagListenerHint": MessageLookupByLibrary.simpleMessage(
      "포트 충돌이나 수신 중지 여부를 확인하세요. 먼저 다시 연결하고, 계속 실패하면 포트 및 인증에서 혼합 포트를 확인하거나 변경하세요.",
    ),
    "diagListenerReady": MessageLookupByLibrary.simpleMessage(
      "예상한 포트가 프록시 프로토콜에 응답했습니다",
    ),
    "diagNoCapture": MessageLookupByLibrary.simpleMessage(
      "시스템 프록시와 TUN이 모두 꺼져 있습니다",
    ),
    "diagOixDns": MessageLookupByLibrary.simpleMessage("oixCloud 서명 DNS"),
    "diagOixDnsAuthMissing": MessageLookupByLibrary.simpleMessage(
      "관리형 DNS 서명 기능이 준비되지 않았습니다",
    ),
    "diagOixDnsHint": MessageLookupByLibrary.simpleMessage(
      "클라이언트 버전과 시스템 시간을 확인한 후 구독을 새로 고치세요. 계속 실패하면 이 진단 보고서를 고객 지원에 전달하세요.",
    ),
    "diagOixDnsNoSample": MessageLookupByLibrary.simpleMessage(
      "이번 표본에 사용할 관리형 노드 호스트 이름이 없습니다",
    ),
    "diagOpenDnsSettings": MessageLookupByLibrary.simpleMessage("DNS 덮어쓰기 설정"),
    "diagOpenNetworkSettings": MessageLookupByLibrary.simpleMessage(
      "네트워크 및 TUN 설정",
    ),
    "diagOpenPortSettings": MessageLookupByLibrary.simpleMessage("포트 및 인증"),
    "diagOpenSettingsFailed": MessageLookupByLibrary.simpleMessage(
      "시스템 설정을 열지 못했습니다. 위 경로를 따라 직접 여세요.",
    ),
    "diagOpenSystemSettings": MessageLookupByLibrary.simpleMessage("시스템 설정 열기"),
    "diagPassed": MessageLookupByLibrary.simpleMessage("통과"),
    "diagProfile": MessageLookupByLibrary.simpleMessage("적용된 설정"),
    "diagProfileHint": MessageLookupByLibrary.simpleMessage(
      "유효한 설정을 선택하고 연결을 시작한 후 다시 확인하세요.",
    ),
    "diagProfileMissing": MessageLookupByLibrary.simpleMessage(
      "선택한 설정이 적용되지 않았습니다",
    ),
    "diagProfileReady": MessageLookupByLibrary.simpleMessage("선택한 설정이 적용되었습니다"),
    "diagProxyAutomatic": MessageLookupByLibrary.simpleMessage(
      "자동 프록시 설정이 있습니다. 실제 경로는 확인하지 못했습니다",
    ),
    "diagProxyAutomaticHint": MessageLookupByLibrary.simpleMessage(
      "PAC 스크립트나 자동 검색이 웹사이트마다 다른 프록시를 선택할 수 있습니다. 반드시 연결 장애를 뜻하는 것은 아닙니다. 변경하기 전에 설정 제공자를 확인하세요.",
    ),
    "diagProxyDifferent": MessageLookupByLibrary.simpleMessage(
      "운영체제 프록시가 앱 포트와 일치하지 않습니다",
    ),
    "diagProxyDisabled": MessageLookupByLibrary.simpleMessage(
      "앱에서 시스템 프록시를 요청했지만 운영체제에서는 꺼져 있다고 보고했습니다",
    ),
    "diagProxyGuide": MessageLookupByLibrary.simpleMessage("문제 해결 및 수동 설정"),
    "diagProxyGuideApp": MessageLookupByLibrary.simpleMessage(
      "이 기기에서 대상 앱의 프록시 설정을 열고 HTTP 또는 SOCKS5를 선택한 뒤 아래 주소와 포트를 입력하세요.\nAndroid는 VPN 서비스를 통해 시스템 프록시를 제공합니다. VPN 연결은 FlClash 네트워크 설정에서 VPN 스위치와 앱 접근 제어를 확인하세요.",
    ),
    "diagProxyGuideAuthenticated": MessageLookupByLibrary.simpleMessage(
      "로컬 프록시 인증이 켜져 있어 FlClash가 시스템 프록시를 자동 적용하지 않습니다.\n프록시 인증을 지원하는 앱에서 HTTP 또는 SOCKS5를 선택하고 아래 주소와 포트를 입력하세요. FlClash → 덮어쓰기 → 일반 → 인바운드 → 인증의 사용자 이름과 비밀번호를 사용하세요.\n진단 보고서에 인증 정보를 포함하지 마세요.",
    ),
    "diagProxyGuideInvalidPort": MessageLookupByLibrary.simpleMessage(
      "혼합 포트를 사용할 수 없습니다. 포트 및 인증에서 유효한 포트를 설정한 후 연결을 시작하세요.",
    ),
    "diagProxyGuideLinux": MessageLookupByLibrary.simpleMessage(
      "데스크톱 설정 → 네트워크 → 네트워크 프록시를 열고 수동을 선택하세요. 명칭은 데스크톱 환경마다 다릅니다.\nHTTP와 HTTPS에 아래 주소와 포트를 입력한 후 적용하세요. 시스템 프록시 설정 화면이 없으면 대상 앱에서 설정하세요.\n자동 설정을 바꾸기 전에 출처와 네트워크에서 여전히 필요한지 확인하세요.",
    ),
    "diagProxyGuideMacos": MessageLookupByLibrary.simpleMessage(
      "시스템 설정 → 네트워크 → 활성 Wi-Fi 또는 이더넷 서비스 → 세부사항 → 프록시\nmacOS 12: 시스템 환경설정 → 네트워크 → 활성 서비스 → 고급 → 프록시\n다른 앱이 남긴 자동 설정을 더 이상 사용하지 않는다면 자동 프록시 검색과 자동 프록시 구성을 끄세요.\n웹 프록시(HTTP)와 보안 웹 프록시(HTTPS)를 켜세요. 둘 다 아래 주소와 포트를 입력한 후 저장하세요. 네트워크에 필요한 우회 항목은 유지하세요.",
    ),
    "diagProxyGuideManualTitle": MessageLookupByLibrary.simpleMessage(
      "2. 프록시 설정 확인 또는 입력",
    ),
    "diagProxyGuidePrepare": MessageLookupByLibrary.simpleMessage(
      "유효한 프로필을 선택하고 FlClash에서 연결을 시작하세요. 프록시 주소를 입력하기 전에 로컬 프록시 수신 점검이 통과했는지 확인하세요.\n시스템 설정을 계속 변경할 수 있는 다른 프록시 앱을 종료하세요. 회사나 학교에서 설정을 관리하거나 설정이 잠겨 있거나 계속 되돌아간다면 관리자에게 문의하세요.",
    ),
    "diagProxyGuidePrepareTitle": MessageLookupByLibrary.simpleMessage(
      "1. 로컬 프록시 먼저 확인",
    ),
    "diagProxyGuideValues": m23,
    "diagProxyGuideVerify": MessageLookupByLibrary.simpleMessage(
      "돌아와서 다시 확인을 선택한 뒤 사용하는 브라우저나 앱에서 다시 시도하세요.\n로컬 프록시 점검은 통과했는데 앱에서 계속 실패한다면 해당 앱의 시스템 프록시, 사용자 지정 프록시 또는 프록시 확장 설정을 확인하세요. 시스템 프록시가 모든 앱의 트래픽을 처리하는 것은 아닙니다.\nFlClash를 중지할 때 인터넷 연결을 유지하려면 수동 설정한 프록시를 끄거나 이전 설정으로 복원해야 할 수 있습니다.",
    ),
    "diagProxyGuideVerifyTitle": MessageLookupByLibrary.simpleMessage(
      "3. 저장 후 실제 앱에서 확인",
    ),
    "diagProxyGuideWindows": MessageLookupByLibrary.simpleMessage(
      "설정 → 네트워크 및 인터넷 → 프록시\n다른 앱이 남긴 자동 설정을 네트워크에서 더 이상 사용하지 않는다면 \'설정 스크립트 사용\'과 \'자동으로 설정 검색\'을 끄세요.\n수동 프록시 설정에서 \'프록시 서버 사용\'을 켜고 아래 주소와 포트를 각각 입력한 뒤 저장하세요. 주소 앞에 http://를 붙이지 마세요. 네트워크에 필요한 예외는 유지하세요.",
    ),
    "diagProxyHint": MessageLookupByLibrary.simpleMessage(
      "문제 해결 및 수동 설정을 열어 시스템 프록시 주소와 포트를 비교하세요. 설정이 계속 되돌아간다면 다른 프록시 앱이나 기기 관리 정책을 확인하세요.",
    ),
    "diagProxyPath": MessageLookupByLibrary.simpleMessage("로컬 프록시 경유"),
    "diagProxyPathHint": MessageLookupByLibrary.simpleMessage(
      "시스템 경로가 작동한다면 선택한 노드, 라우팅 규칙 및 코어 DNS를 확인하세요. 테스트 사이트 하나의 실패가 모든 노드를 사용할 수 없다는 뜻은 아닙니다.",
    ),
    "diagProxyReady": MessageLookupByLibrary.simpleMessage(
      "HTTP 및 HTTPS 프록시가 예상한 로컬 포트를 가리킵니다",
    ),
    "diagRecheck": MessageLookupByLibrary.simpleMessage("다시 확인"),
    "diagRun": MessageLookupByLibrary.simpleMessage("자체 점검 실행"),
    "diagScope": MessageLookupByLibrary.simpleMessage(
      "작은 표본으로 현재 연결을 확인합니다. 시스템 네트워크 경로도 TUN을 통과할 수 있습니다. 결과가 모든 앱이나 노드에 적용되는 것은 아닙니다.",
    ),
    "diagSkipped": MessageLookupByLibrary.simpleMessage("건너뜀"),
    "diagSuspended": MessageLookupByLibrary.simpleMessage(
      "현재 Wi-Fi 제외 설정에 따라 트래픽 전달이 일시 중지되었습니다",
    ),
    "diagSystemDns": MessageLookupByLibrary.simpleMessage("시스템 DNS"),
    "diagSystemDnsHint": MessageLookupByLibrary.simpleMessage(
      "다른 네트워크를 사용하고 운영체제에서 활성 연결의 DNS 서버를 확인하세요. 클라이언트의 DNS 덮어쓰기만 변경해서는 시스템 조회 문제가 해결되지 않을 수 있습니다.",
    ),
    "diagSystemPath": MessageLookupByLibrary.simpleMessage("시스템 네트워크 경로"),
    "diagSystemPathHint": MessageLookupByLibrary.simpleMessage(
      "이 경로는 앱의 HTTP 프록시를 명시적으로 사용하지 않지만 TUN을 통과할 수 있습니다. 표본 점검 실패는 DNS, 필터링 또는 테스트 사이트 때문일 수 있습니다. 로컬 프록시 결과와 비교하세요.",
    ),
    "diagSystemProxy": MessageLookupByLibrary.simpleMessage("시스템 프록시 설정"),
    "diagTitle": MessageLookupByLibrary.simpleMessage("네트워크 자체 점검"),
    "diagTrafficCapture": MessageLookupByLibrary.simpleMessage("트래픽 처리"),
    "diagTun": MessageLookupByLibrary.simpleMessage("TUN 인터페이스 및 경로"),
    "diagTunHint": MessageLookupByLibrary.simpleMessage(
      "TUN을 껐다 켜고 시스템 권한을 승인하세요. 경로가 다르면 다른 VPN을 확인하세요. IPv6, UDP 및 앱별 제외 설정은 별도로 확인해야 합니다.",
    ),
    "diagTunMissing": MessageLookupByLibrary.simpleMessage(
      "활성 상태인 코어 TUN 인터페이스를 찾지 못했습니다",
    ),
    "diagTunReady": MessageLookupByLibrary.simpleMessage(
      "코어 TUN 인터페이스가 활성 상태이며 표본 IPv4 경로가 이를 사용합니다",
    ),
    "diagTunRouteMismatch": MessageLookupByLibrary.simpleMessage(
      "TUN은 활성 상태지만 표본 IPv4 경로는 다른 인터페이스를 사용합니다",
    ),
    "diagTunRouteUnknown": MessageLookupByLibrary.simpleMessage(
      "TUN은 활성 상태이나 IPv4 경로는 확인하지 못했습니다",
    ),
    "diagUnknown": MessageLookupByLibrary.simpleMessage("확인할 수 없음"),
    "diagWarning": MessageLookupByLibrary.simpleMessage("확인 필요"),
    "diagWebResult": m24,
    "dialerProxy": MessageLookupByLibrary.simpleMessage("다이얼러 프록시"),
    "dialerProxyDesc": MessageLookupByLibrary.simpleMessage(
      "다이얼러 프록시는 NTP 서버에 연결할 때 사용하는 아웃바운드입니다.",
    ),
    "dialerProxyLoopStopped": m25,
    "direct": MessageLookupByLibrary.simpleMessage("직접"),
    "directNameserver": MessageLookupByLibrary.simpleMessage("직접 연결 DNS"),
    "directNameserverFollowPolicy": MessageLookupByLibrary.simpleMessage(
      "직접 연결 DNS에 정책 적용",
    ),
    "disableIcmpForwarding": MessageLookupByLibrary.simpleMessage(
      "ICMP 전달 사용 안 함",
    ),
    "disableIcmpForwardingDesc": MessageLookupByLibrary.simpleMessage(
      "ICMP 전달을 끄면 TUN이 ping에 직접 응답하므로 ping에 실제 지연 시간이 표시되지 않습니다.",
    ),
    "disableKeepAlive": MessageLookupByLibrary.simpleMessage(
      "TCP 킵얼라이브 사용 안 함",
    ),
    "disableUDP": MessageLookupByLibrary.simpleMessage("UDP 사용 안 함"),
    "disabled": MessageLookupByLibrary.simpleMessage("사용 안 함"),
    "discard": MessageLookupByLibrary.simpleMessage("버리기"),
    "discardChanges": MessageLookupByLibrary.simpleMessage("변경 사항을 취소하시겠습니까?"),
    "disconnected": MessageLookupByLibrary.simpleMessage("연결 끊김"),
    "discountCode": MessageLookupByLibrary.simpleMessage("할인 코드"),
    "discountCodeOptional": MessageLookupByLibrary.simpleMessage(
      "할인 코드(선택 사항)",
    ),
    "discountCodeRequired": MessageLookupByLibrary.simpleMessage(
      "할인 코드를 입력하세요",
    ),
    "discountedPriceLabel": MessageLookupByLibrary.simpleMessage("할인 가격"),
    "discovery": MessageLookupByLibrary.simpleMessage("새 버전 발견"),
    "dnsDesc": MessageLookupByLibrary.simpleMessage("DNS 관련 설정 변경"),
    "dnsHijackDesc": MessageLookupByLibrary.simpleMessage(
      "추가하지 않으면 53번 포트로 가는 모든 DNS 쿼리를 하이재킹합니다(any:53).",
    ),
    "dnsHijacking": MessageLookupByLibrary.simpleMessage("DNS 하이재킹"),
    "dnsMode": MessageLookupByLibrary.simpleMessage("DNS 모드"),
    "dnsOverrideDesc": MessageLookupByLibrary.simpleMessage(
      "여기에 추가한 항목은 모든 프로필의 DNS 설정을 대체하며, 추가하지 않은 항목은 각 프로필의 설정을 유지합니다. 사용자 지정 프로필 자체의 항목이 우선합니다",
    ),
    "dnsQueries": MessageLookupByLibrary.simpleMessage("DNS 쿼리"),
    "dnsQueriesDesc": MessageLookupByLibrary.simpleMessage("최근 DNS 조회 500개 보기"),
    "dnsQueryAll": MessageLookupByLibrary.simpleMessage("모든 조회"),
    "dnsQueryAnswers": MessageLookupByLibrary.simpleMessage("응답"),
    "dnsQueryCached": MessageLookupByLibrary.simpleMessage("캐시됨"),
    "dnsQueryFailures": MessageLookupByLibrary.simpleMessage("실패한 조회"),
    "dnsQueryInitiatorApp": MessageLookupByLibrary.simpleMessage("애플리케이션"),
    "dnsQueryInitiatorDirect": MessageLookupByLibrary.simpleMessage("직접 연결"),
    "dnsQueryInitiatorOther": MessageLookupByLibrary.simpleMessage("기타"),
    "dnsQueryInitiatorProxy": MessageLookupByLibrary.simpleMessage("프록시 연결"),
    "dnsQueryInitiatorRule": MessageLookupByLibrary.simpleMessage("규칙 일치"),
    "dnsQueryRcode": MessageLookupByLibrary.simpleMessage("응답 코드"),
    "dnsQueryType": MessageLookupByLibrary.simpleMessage("조회 유형"),
    "dnsQueryUpstream": MessageLookupByLibrary.simpleMessage("상위 서버"),
    "doYouWantToPass": MessageLookupByLibrary.simpleMessage("계속하시겠습니까?"),
    "docked": MessageLookupByLibrary.simpleMessage("고정"),
    "domain": MessageLookupByLibrary.simpleMessage("도메인"),
    "done": MessageLookupByLibrary.simpleMessage("완료"),
    "download": MessageLookupByLibrary.simpleMessage("다운로드"),
    "downloadBandwidth": MessageLookupByLibrary.simpleMessage("다운로드 대역폭"),
    "duration": MessageLookupByLibrary.simpleMessage("소요 시간"),
    "dynamicMembersHint": MessageLookupByLibrary.simpleMessage(
      "구독이 업데이트될 때 이 설정의 노드를 자동으로 포함합니다. Japan|JP 같은 이름 필터를 사용하세요.",
    ),
    "edit": MessageLookupByLibrary.simpleMessage("편집"),
    "editCustomRouting": MessageLookupByLibrary.simpleMessage("사용자 지정 라우팅 편집"),
    "editDashboard": MessageLookupByLibrary.simpleMessage("대시보드 편집"),
    "editGlobalRules": MessageLookupByLibrary.simpleMessage("전역 규칙 편집"),
    "editProfile": MessageLookupByLibrary.simpleMessage("프로필 편집"),
    "editProxyGroup": MessageLookupByLibrary.simpleMessage("프록시 그룹 편집"),
    "editRule": MessageLookupByLibrary.simpleMessage("규칙 편집"),
    "editSsid": MessageLookupByLibrary.simpleMessage("SSID 편집"),
    "editorUnavailable": MessageLookupByLibrary.simpleMessage("편집기를 사용할 수 없음"),
    "elapsed": MessageLookupByLibrary.simpleMessage("소요"),
    "emailCodeHint": MessageLookupByLibrary.simpleMessage("6자리 코드를 입력하세요"),
    "emailCodeLabel": MessageLookupByLibrary.simpleMessage("이메일 인증 코드"),
    "emailCodeValidation": MessageLookupByLibrary.simpleMessage(
      "이메일 인증 코드를 입력하세요",
    ),
    "emailFormatValidation": MessageLookupByLibrary.simpleMessage(
      "이메일 형식이 올바르지 않습니다",
    ),
    "emailHint": MessageLookupByLibrary.simpleMessage("이메일 주소를 입력하세요"),
    "emailLabel": MessageLookupByLibrary.simpleMessage("이메일"),
    "emailPassword": MessageLookupByLibrary.simpleMessage("이메일 및 비밀번호"),
    "emailValidation": MessageLookupByLibrary.simpleMessage("이메일을 입력하세요"),
    "emptyCustomOverwrite": MessageLookupByLibrary.simpleMessage(
      "사용자 지정 덮어쓰기 내용이 비어 있습니다. 빠른 채우기를 사용하거나 규칙과 프록시 그룹을 추가하세요. 구독 내용을 유지하려면 오버레이 모드를 사용하세요.",
    ),
    "emptyCustomProfile": MessageLookupByLibrary.simpleMessage(
      "먼저 이 사용자 지정 프로필에 프록시 그룹 또는 규칙을 추가하세요",
    ),
    "emptyFallback": MessageLookupByLibrary.simpleMessage("빈 폴백"),
    "emptyTip": m26,
    "en": MessageLookupByLibrary.simpleMessage("영어"),
    "enableAutoRenew": MessageLookupByLibrary.simpleMessage("자동 갱신 켜기"),
    "enabled": MessageLookupByLibrary.simpleMessage("사용"),
    "enabledOnStart": MessageLookupByLibrary.simpleMessage("시작 시 켜기"),
    "entries": MessageLookupByLibrary.simpleMessage("개 항목"),
    "error": MessageLookupByLibrary.simpleMessage("오류"),
    "errorDetails": MessageLookupByLibrary.simpleMessage("오류 세부 정보"),
    "es": MessageLookupByLibrary.simpleMessage("스페인어"),
    "exclude": MessageLookupByLibrary.simpleMessage("최근 작업에서 숨기기"),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "앱이 백그라운드에 있을 때 최근 앱 목록에서 숨기기",
    ),
    "excludeDstPort": MessageLookupByLibrary.simpleMessage("제외할 대상 포트"),
    "excludeDstPortDesc": MessageLookupByLibrary.simpleMessage(
      "제외할 대상 포트로 가는 트래픽은 TUN을 거치지 않습니다.",
    ),
    "excludeInterface": MessageLookupByLibrary.simpleMessage("제외할 인터페이스"),
    "excludeInterfaceDesc": MessageLookupByLibrary.simpleMessage(
      "docker0와 같이 제외할 인터페이스로 들어오는 트래픽은 TUN을 거치지 않습니다.",
    ),
    "excludeNetworks": MessageLookupByLibrary.simpleMessage(
      "IP 또는 게이트웨이별 프록시 일시 중지",
    ),
    "excludeNetworksDesc": MessageLookupByLibrary.simpleMessage(
      "일치하는 Wi-Fi/이더넷 IPv4 주소, 서브넷 또는 게이트웨이에서 일시 중지하고 벗어나면 재개합니다. 쉼표로 구분하세요. 예: 192.168.1.0/24,gateway:192.168.1.1",
    ),
    "excludeNetworksInvalid": MessageLookupByLibrary.simpleMessage(
      "최대 16개 규칙을 사용할 수 있습니다. 올바른 IPv4, CIDR 또는 gateway:주소를 입력하세요",
    ),
    "excludeProxyFilter": MessageLookupByLibrary.simpleMessage("프록시 제외 필터"),
    "excludeSrcPort": MessageLookupByLibrary.simpleMessage("제외할 소스 포트"),
    "excludeSrcPortDesc": MessageLookupByLibrary.simpleMessage(
      "제외할 소스 포트에서 나가는 트래픽은 TUN을 거치지 않습니다.",
    ),
    "excludeSsids": MessageLookupByLibrary.simpleMessage(
      "프록시를 일시 중지할 Wi-Fi 네트워크",
    ),
    "excludeSsidsDesc": MessageLookupByLibrary.simpleMessage(
      "지정한 Wi-Fi 네트워크에서 프록시를 일시 중지합니다. 벗어난 후 앱이 계속 시작된 상태인 경우에만 재개합니다",
    ),
    "excludeType": MessageLookupByLibrary.simpleMessage("제외할 유형"),
    "excludeUid": MessageLookupByLibrary.simpleMessage("제외할 사용자 ID"),
    "excludeUidDesc": MessageLookupByLibrary.simpleMessage(
      "제외할 사용자 ID의 프로세스 트래픽은 TUN을 거치지 않습니다.",
    ),
    "existsTip": m27,
    "exit": MessageLookupByLibrary.simpleMessage("종료"),
    "exitFullScreen": MessageLookupByLibrary.simpleMessage("전체 화면 종료"),
    "exitNodes": MessageLookupByLibrary.simpleMessage("출구 노드"),
    "expandList": MessageLookupByLibrary.simpleMessage("펼치기"),
    "expectedStatus": MessageLookupByLibrary.simpleMessage("예상 상태"),
    "expireDate": m28,
    "expireTime": MessageLookupByLibrary.simpleMessage("만료 시간"),
    "expiresAtLabel": MessageLookupByLibrary.simpleMessage("만료 시각"),
    "exportFile": MessageLookupByLibrary.simpleMessage("파일 내보내기"),
    "exportLogs": MessageLookupByLibrary.simpleMessage("로그 내보내기"),
    "exportSuccess": MessageLookupByLibrary.simpleMessage("내보내기 성공"),
    "externalController": MessageLookupByLibrary.simpleMessage("외부 컨트롤러"),
    "externalControllerDesc": MessageLookupByLibrary.simpleMessage(
      "외부 컨트롤러를 통해 설정된 주소에서 코어를 제어할 수 있습니다",
    ),
    "externalLink": MessageLookupByLibrary.simpleMessage("외부 링크"),
    "extraLarge": MessageLookupByLibrary.simpleMessage("매우 크게"),
    "fade": MessageLookupByLibrary.simpleMessage("페이드"),
    "failedItem": m29,
    "fakeipFilter": MessageLookupByLibrary.simpleMessage("Fake-IP 필터"),
    "fakeipFilterMode": MessageLookupByLibrary.simpleMessage("Fake-IP 필터 모드"),
    "fakeipFilterModeDesc": MessageLookupByLibrary.simpleMessage(
      "Fake-IP 필터 모드에서 블랙리스트는 일치 항목을 제외하고, 화이트리스트는 일치 항목에만 가짜 IP를 사용하며, 규칙은 규칙에 따라 일치시킵니다.",
    ),
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Fake-IP 범위"),
    "fakeipRange6": MessageLookupByLibrary.simpleMessage("Fake-IP 범위(IPv6)"),
    "fakeipTtl": MessageLookupByLibrary.simpleMessage("Fake-IP TTL"),
    "fallback": MessageLookupByLibrary.simpleMessage("보조 DNS"),
    "fallbackDesc": MessageLookupByLibrary.simpleMessage(
      "일반적으로 해외 DNS 서버를 지정합니다",
    ),
    "fallbackFilter": MessageLookupByLibrary.simpleMessage("폴백 필터"),
    "fallbackLazyQuery": MessageLookupByLibrary.simpleMessage("보조 DNS 지연 조회"),
    "fetchOrdersFailed": MessageLookupByLibrary.simpleMessage(
      "구매 기록을 불러오지 못했습니다",
    ),
    "fetchPlansFailed": MessageLookupByLibrary.simpleMessage("요금제를 불러오지 못했습니다"),
    "file": MessageLookupByLibrary.simpleMessage("파일"),
    "fileDesc": MessageLookupByLibrary.simpleMessage("프로필 파일 직접 가져오기"),
    "fileIsUpdate": MessageLookupByLibrary.simpleMessage(
      "파일이 변경되었습니다. 변경 사항을 저장하시겠습니까?",
    ),
    "filter": MessageLookupByLibrary.simpleMessage("필터"),
    "filters": MessageLookupByLibrary.simpleMessage("필터"),
    "findProcessMode": MessageLookupByLibrary.simpleMessage("프로세스 찾기"),
    "findProcessModeAutomaticDesc": MessageLookupByLibrary.simpleMessage(
      "프로세스 규칙을 확인할 때만 프로세스를 조회합니다",
    ),
    "findProcessModeDesc": MessageLookupByLibrary.simpleMessage(
      "사용 시 성능이 다소 저하될 수 있습니다",
    ),
    "floating": MessageLookupByLibrary.simpleMessage("플로팅"),
    "floatingNavigationBar": MessageLookupByLibrary.simpleMessage("플로팅 탐색"),
    "followProfile": MessageLookupByLibrary.simpleMessage("프로필 따르기"),
    "followSystem": MessageLookupByLibrary.simpleMessage("시스템 설정 따르기"),
    "fontFamily": MessageLookupByLibrary.simpleMessage("글꼴"),
    "fontSize": MessageLookupByLibrary.simpleMessage("크기"),
    "forceDnsMapping": MessageLookupByLibrary.simpleMessage("DNS 매핑 강제"),
    "forceDnsMappingDesc": MessageLookupByLibrary.simpleMessage(
      "DNS 매핑 강제는 DNS 매핑에서 도메인을 얻은 연결도 스니핑합니다.",
    ),
    "forceDomain": MessageLookupByLibrary.simpleMessage("강제 도메인"),
    "forceDomainDesc": MessageLookupByLibrary.simpleMessage(
      "강제 도메인은 항상 스니핑합니다. 이미 도메인이 있는 다른 연결은 그대로 둡니다.",
    ),
    "forceRestartCoreTip": MessageLookupByLibrary.simpleMessage(
      "코어를 강제로 다시 시작하시겠습니까?",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("비밀번호를 잊으셨나요?"),
    "format": MessageLookupByLibrary.simpleMessage("형식"),
    "fr": MessageLookupByLibrary.simpleMessage("프랑스어"),
    "general": MessageLookupByLibrary.simpleMessage("일반"),
    "geoAutoUpdate": MessageLookupByLibrary.simpleMessage("자동 업데이트"),
    "geoAutoUpdateInterval": MessageLookupByLibrary.simpleMessage("자동 업데이트 간격"),
    "geoAutoUpdateIntervalTip": MessageLookupByLibrary.simpleMessage(
      "자동 업데이트 간격은 1~8760시간이어야 합니다",
    ),
    "geoBackupSource": MessageLookupByLibrary.simpleMessage("보조 CDN"),
    "geoDownloadFailed": MessageLookupByLibrary.simpleMessage("GEO 다운로드 실패"),
    "geoDownloadRecoveryHint": MessageLookupByLibrary.simpleMessage(
      "다운로드는 현재 네트워크 규칙을 따르며, 프록시를 사용할 수 없으면 직접 연결합니다. 현재 주소로 재시도하거나 다른 소스를 선택하거나 URL을 입력하세요. 검증을 통과하면 작업이 자동으로 계속됩니다.",
    ),
    "geoDownloadUrl": MessageLookupByLibrary.simpleMessage("다운로드 URL"),
    "geoFileMissing": MessageLookupByLibrary.simpleMessage("다운로드되지 않음"),
    "geoFileReadFailed": MessageLookupByLibrary.simpleMessage(
      "리소스 파일을 읽지 못했습니다",
    ),
    "geoInvalidDownloadUrl": MessageLookupByLibrary.simpleMessage(
      "올바른 HTTP 또는 HTTPS URL을 입력하세요",
    ),
    "geoOptions": MessageLookupByLibrary.simpleMessage("Geo 옵션"),
    "geoOriginalSource": MessageLookupByLibrary.simpleMessage("현재 주소"),
    "geoResources": MessageLookupByLibrary.simpleMessage("Geo 리소스"),
    "geoSkipped": m30,
    "geoUpdated": m31,
    "geoUpdating": m32,
    "geodataLoader": MessageLookupByLibrary.simpleMessage("Geo 저메모리 모드"),
    "geodataLoaderDesc": MessageLookupByLibrary.simpleMessage(
      "메모리 사용량이 적은 Geo 로더 사용",
    ),
    "geoipCode": MessageLookupByLibrary.simpleMessage("GeoIP 코드"),
    "getProfileSuccess": MessageLookupByLibrary.simpleMessage("프로필을 가져왔습니다"),
    "global": MessageLookupByLibrary.simpleMessage("전역"),
    "go": MessageLookupByLibrary.simpleMessage("이동"),
    "goLogin": MessageLookupByLibrary.simpleMessage("로그인"),
    "goPay": MessageLookupByLibrary.simpleMessage("결제"),
    "goToConfigureAddedRules": MessageLookupByLibrary.simpleMessage(
      "추가한 규칙 구성으로 이동",
    ),
    "goToConfigureScript": MessageLookupByLibrary.simpleMessage("스크립트 설정으로 이동"),
    "googleLoginInvalidCallback": MessageLookupByLibrary.simpleMessage(
      "Google 로그인을 확인하지 못했습니다. 다시 시도하세요.",
    ),
    "googleLoginTimedOut": MessageLookupByLibrary.simpleMessage(
      "Google 로그인 시간이 초과되었습니다. 다시 시도하세요.",
    ),
    "googleLoginUnavailable": MessageLookupByLibrary.simpleMessage(
      "Google 로그인 페이지를 열지 못했습니다. 다시 시도하세요.",
    ),
    "googleLoginWaiting": MessageLookupByLibrary.simpleMessage(
      "브라우저에서 Google 로그인을 완료하세요",
    ),
    "grid": MessageLookupByLibrary.simpleMessage("격자"),
    "groupCount": m33,
    "groupCountUnit": MessageLookupByLibrary.simpleMessage("개"),
    "groupCycleError": m34,
    "groupFilterHint": MessageLookupByLibrary.simpleMessage(
      "자동 포함 노드와 공급자 노드를 필터링합니다. 직접 선택한 구성원은 항상 유지됩니다.",
    ),
    "groupTimeoutCount": m35,
    "groupTypeFallback": MessageLookupByLibrary.simpleMessage("장애 조치"),
    "groupTypeFallbackHint": MessageLookupByLibrary.simpleMessage(
      "구성원을 순서대로 시도하며 현재 구성원에 장애가 발생하면 전환합니다.",
    ),
    "groupTypeLoadBalance": MessageLookupByLibrary.simpleMessage("부하 분산"),
    "groupTypeLoadBalanceHint": MessageLookupByLibrary.simpleMessage(
      "사용 가능한 구성원에 연결을 분산합니다.",
    ),
    "groupTypeSelect": MessageLookupByLibrary.simpleMessage("수동 선택"),
    "groupTypeSelectHint": MessageLookupByLibrary.simpleMessage(
      "프록시 페이지에서 사용할 구성원을 선택하세요.",
    ),
    "groupTypeUrlTest": MessageLookupByLibrary.simpleMessage("자동 선택"),
    "groupTypeUrlTestHint": MessageLookupByLibrary.simpleMessage(
      "구성원을 주기적으로 테스트하고 지연이 낮은 노드를 선택합니다.",
    ),
    "hasCacheChange": MessageLookupByLibrary.simpleMessage(
      "변경 사항을 캐시에 저장하시겠습니까?",
    ),
    "hashByInUser": MessageLookupByLibrary.simpleMessage("인바운드 사용자별 해시"),
    "haveAccountAlready": MessageLookupByLibrary.simpleMessage("이미 계정이 있으신가요?"),
    "healthCheck": MessageLookupByLibrary.simpleMessage("상태 확인"),
    "helperCorruptTip": MessageLookupByLibrary.simpleMessage(
      "헬퍼 서비스를 사용할 수 없어 TUN 모드를 켤 수 없습니다. FlClash를 다시 설치하여 복구하세요.",
    ),
    "hex": MessageLookupByLibrary.simpleMessage("16진수"),
    "hide": MessageLookupByLibrary.simpleMessage("숨기기"),
    "hideFromList": MessageLookupByLibrary.simpleMessage("목록에서 숨기기"),
    "hideIp": MessageLookupByLibrary.simpleMessage("IP 숨기기"),
    "hidePassword": MessageLookupByLibrary.simpleMessage("비밀번호 숨기기"),
    "hideTimeoutProxies": MessageLookupByLibrary.simpleMessage("실패한 노드 숨기기"),
    "hideTimeoutProxiesDesc": MessageLookupByLibrary.simpleMessage(
      "선택한 노드와 테스트가 끝나지 않은 노드는 유지합니다",
    ),
    "hopInterval": MessageLookupByLibrary.simpleMessage("호핑 간격"),
    "host": MessageLookupByLibrary.simpleMessage("호스트"),
    "hostname": MessageLookupByLibrary.simpleMessage("호스트 이름"),
    "hostsDesc": MessageLookupByLibrary.simpleMessage("Hosts 추가"),
    "hotkeyConflictWith": m36,
    "hotkeyDesc": MessageLookupByLibrary.simpleMessage(
      "전역 단축키는 창이 숨겨져 있어도 작동합니다. 동작을 눌러 키 조합을 기록하세요.",
    ),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage("단축키 관리"),
    "hotkeyManagementDesc": MessageLookupByLibrary.simpleMessage("키보드로 앱 제어"),
    "hotkeyNeedsModifier": m37,
    "hotkeyNotSet": MessageLookupByLibrary.simpleMessage("설정 안 됨"),
    "hotkeyUnavailable": MessageLookupByLibrary.simpleMessage("단축키를 사용할 수 없음"),
    "hours": MessageLookupByLibrary.simpleMessage("시간"),
    "hoursAgo": m38,
    "hoursAgoShort": m39,
    "hoursCount": m40,
    "hue": MessageLookupByLibrary.simpleMessage("색조"),
    "iHavePaid": MessageLookupByLibrary.simpleMessage("결제했습니다"),
    "icon": MessageLookupByLibrary.simpleMessage("아이콘"),
    "iconHistory": MessageLookupByLibrary.simpleMessage("최근 아이콘"),
    "iconSets": MessageLookupByLibrary.simpleMessage("아이콘 세트"),
    "iconSetsEmptyTip": MessageLookupByLibrary.simpleMessage(
      "아이콘 세트가 아직 없습니다. 사용자 지정 프로필 리소스 → 아이콘 세트에서 추가하세요",
    ),
    "iconStyle": MessageLookupByLibrary.simpleMessage("아이콘 스타일"),
    "iconStyleFilled": MessageLookupByLibrary.simpleMessage("채움"),
    "iconStyleHidden": MessageLookupByLibrary.simpleMessage("숨김"),
    "iconStylePlain": MessageLookupByLibrary.simpleMessage("기본"),
    "iconUrl": MessageLookupByLibrary.simpleMessage("아이콘 URL"),
    "ignoreBatteryOptimization": MessageLookupByLibrary.simpleMessage(
      "배터리 최적화 무시",
    ),
    "import": MessageLookupByLibrary.simpleMessage("가져오기"),
    "importConfig": MessageLookupByLibrary.simpleMessage("설정 가져오기"),
    "importConfigDesc": MessageLookupByLibrary.simpleMessage(
      "설정의 프록시, 그룹, 규칙 및 옵션으로 사용자 지정 프로필 만들기",
    ),
    "importConfigInvalid": MessageLookupByLibrary.simpleMessage(
      "가져올 수 있는 설정이 아닙니다",
    ),
    "importConfigReplaceTip": MessageLookupByLibrary.simpleMessage(
      "가져오면 이 프로필의 현재 노드, 프록시 그룹, 규칙 및 설정이 바뀝니다",
    ),
    "importFile": MessageLookupByLibrary.simpleMessage("파일에서 가져오기"),
    "importFromLink": MessageLookupByLibrary.simpleMessage("링크에서 가져오기"),
    "importFromURL": MessageLookupByLibrary.simpleMessage("URL에서 가져오기"),
    "importText": MessageLookupByLibrary.simpleMessage("텍스트에서 가져오기"),
    "importUrl": MessageLookupByLibrary.simpleMessage("URL에서 가져오기"),
    "inbound": MessageLookupByLibrary.simpleMessage("인바운드"),
    "includeAll": MessageLookupByLibrary.simpleMessage("모든 프록시 및 공급자 포함"),
    "includeAllProxies": MessageLookupByLibrary.simpleMessage("모든 프록시 포함"),
    "includeAllProxyProviders": MessageLookupByLibrary.simpleMessage(
      "모든 프록시 공급자 포함",
    ),
    "includeInterface": MessageLookupByLibrary.simpleMessage("포함할 인터페이스"),
    "includeInterfaceDesc": MessageLookupByLibrary.simpleMessage(
      "포함할 인터페이스로 들어오는 트래픽만 TUN을 거치며, 제외할 인터페이스는 더 이상 적용되지 않습니다.",
    ),
    "includeUid": MessageLookupByLibrary.simpleMessage("포함할 사용자 ID"),
    "includeUidDesc": MessageLookupByLibrary.simpleMessage(
      "포함할 사용자 ID의 프로세스 트래픽만 TUN을 거칩니다.",
    ),
    "infiniteTime": MessageLookupByLibrary.simpleMessage("무기한"),
    "init": MessageLookupByLibrary.simpleMessage("초기화"),
    "initFailed": MessageLookupByLibrary.simpleMessage("시작 실패"),
    "initFailedTip": MessageLookupByLibrary.simpleMessage(
      "앱을 시작하는 중 심각한 오류가 발생하여 계속할 수 없습니다.",
    ),
    "initiatorShort": MessageLookupByLibrary.simpleMessage("출처"),
    "inputProxyGroupName": MessageLookupByLibrary.simpleMessage(
      "프록시 그룹 이름을 입력하세요",
    ),
    "installedAppsLoadFailed": MessageLookupByLibrary.simpleMessage(
      "설치된 앱을 불러오지 못했습니다. 다시 시도하세요.",
    ),
    "installedAppsPermissionDeniedMessage":
        MessageLookupByLibrary.simpleMessage(
          "권한이 허용되지 않았습니다. 시스템 설정에서 켤 수 있습니다.",
        ),
    "installedAppsPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "VPN을 사용할 앱을 선택하려면 설치된 앱 목록에 대한 접근을 허용하세요.",
    ),
    "installedAppsPermissionGrant": MessageLookupByLibrary.simpleMessage(
      "접근 허용",
    ),
    "installedAppsPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "설치된 앱 접근 권한 필요",
    ),
    "installedFonts": MessageLookupByLibrary.simpleMessage("설치된 글꼴"),
    "insufficientBalanceHint": MessageLookupByLibrary.simpleMessage(
      "잔액이 부족합니다. 충전 후 계속하세요.",
    ),
    "insufficientBalanceRecharge": MessageLookupByLibrary.simpleMessage(
      "충전 후 다시 시도하세요.",
    ),
    "intelligentSelected": MessageLookupByLibrary.simpleMessage("스마트 선택"),
    "interfaceAutomatic": MessageLookupByLibrary.simpleMessage(
      "덮어쓰기 해제(자동 인터페이스)",
    ),
    "interfaceFollowProfile": MessageLookupByLibrary.simpleMessage("프로필 따르기"),
    "interfaceName": MessageLookupByLibrary.simpleMessage("인터페이스 이름"),
    "interfaceNameDesc": MessageLookupByLibrary.simpleMessage(
      "인터페이스 이름은 아웃바운드 연결이 사용하는 네트워크 인터페이스입니다.",
    ),
    "interfaceNameMode": MessageLookupByLibrary.simpleMessage("아웃바운드 인터페이스"),
    "internet": MessageLookupByLibrary.simpleMessage("인터넷"),
    "interval": MessageLookupByLibrary.simpleMessage("간격"),
    "intranetIP": MessageLookupByLibrary.simpleMessage("내부망 IP"),
    "invalidAmount": MessageLookupByLibrary.simpleMessage("올바른 금액을 입력하세요"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage("올바르지 않은 백업 파일"),
    "invalidCertificateContent": MessageLookupByLibrary.simpleMessage(
      "서버 인증서를 검증하지 못했습니다. 검증을 건너뛰면 서버가 위조되었을 수 있으며, 송수신하는 계정 인증 정보나 구독 데이터가 도난당하거나 변조될 수 있습니다.\n\n이 네트워크와 서버를 신뢰하는 경우에만 계속하세요. 예외는 동일한 서버와 인증서에 대한 이번 재시도에만 적용되며, 작업이 끝나면 해제됩니다.",
    ),
    "invalidCertificateTitle": MessageLookupByLibrary.simpleMessage(
      "인증서 검증 실패",
    ),
    "invalidCidrContent": MessageLookupByLibrary.simpleMessage(
      "192.168.0.0/16과 같은 CIDR 형식의 IP 범위를 입력하세요",
    ),
    "invalidDscpContent": MessageLookupByLibrary.simpleMessage(
      "DSCP 마크는 63을 넘을 수 없습니다",
    ),
    "invalidHostContent": MessageLookupByLibrary.simpleMessage(
      "도메인 또는 IP 주소를 입력하세요",
    ),
    "invalidIpv6CidrContent": MessageLookupByLibrary.simpleMessage(
      "fd00::/8처럼 CIDR 형식의 IPv6 범위를 입력하세요",
    ),
    "invalidLinkTip": MessageLookupByLibrary.simpleMessage(
      "구독 링크 또는 프록시 공유 링크가 아닙니다",
    ),
    "invalidListenContent": MessageLookupByLibrary.simpleMessage(
      "0.0.0.0:1053과 같은 주소와 포트를 입력하세요",
    ),
    "invalidNetworkContent": MessageLookupByLibrary.simpleMessage(
      "tcp 또는 udp만 지원합니다",
    ),
    "invalidPolicy": m41,
    "invalidPortRangeContent": MessageLookupByLibrary.simpleMessage(
      "443 또는 8000-9000과 같은 포트나 범위를 입력하세요",
    ),
    "invalidProfileQrcode": MessageLookupByLibrary.simpleMessage(
      "이 QR 코드에는 프로필 링크가 없습니다",
    ),
    "invalidProxyProvider": m42,
    "invalidRangeContent": MessageLookupByLibrary.simpleMessage(
      "80 또는 8000-9000과 같은 숫자나 범위를 /로 구분하여 입력하세요",
    ),
    "invalidRuleSet": m43,
    "invalidSubRule": m44,
    "inviteCodeHint": MessageLookupByLibrary.simpleMessage("초대 코드를 입력하세요"),
    "inviteCodeLabel": MessageLookupByLibrary.simpleMessage("초대 코드"),
    "inviteCodeValidation": MessageLookupByLibrary.simpleMessage(
      "초대 코드를 입력하세요",
    ),
    "ipType": MessageLookupByLibrary.simpleMessage("유형"),
    "ipVersion": MessageLookupByLibrary.simpleMessage("IP 버전"),
    "ipcidr": MessageLookupByLibrary.simpleMessage("IP CIDR"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage(
      "IPv6 트래픽은 IPv6가 켜져 있을 때만 수신됩니다.",
    ),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage(
      "IPv6를 켜면 VPN이 IPv6 인바운드를 허용합니다.",
    ),
    "ipv6Timeout": MessageLookupByLibrary.simpleMessage("IPv6 타임아웃(ms)"),
    "itemsCount": m45,
    "ja": MessageLookupByLibrary.simpleMessage("일본어"),
    "justNow": MessageLookupByLibrary.simpleMessage("방금"),
    "keepAliveIdle": MessageLookupByLibrary.simpleMessage("TCP 킵얼라이브 유휴 시간"),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "TCP 킵얼라이브 간격",
    ),
    "key": MessageLookupByLibrary.simpleMessage("키"),
    "ko": MessageLookupByLibrary.simpleMessage("한국어"),
    "label": MessageLookupByLibrary.simpleMessage("레이블"),
    "language": MessageLookupByLibrary.simpleMessage("언어"),
    "large": MessageLookupByLibrary.simpleMessage("크게"),
    "lastUpdated": MessageLookupByLibrary.simpleMessage("마지막 업데이트"),
    "layout": MessageLookupByLibrary.simpleMessage("레이아웃"),
    "lazy": MessageLookupByLibrary.simpleMessage("지연 로딩"),
    "light": MessageLookupByLibrary.simpleMessage("라이트"),
    "lineIssueTip": m46,
    "lineWrap": MessageLookupByLibrary.simpleMessage("자동 줄 바꿈"),
    "link": MessageLookupByLibrary.simpleMessage("링크"),
    "linkDesc": MessageLookupByLibrary.simpleMessage(
      "구독 링크 또는 프록시 공유 링크로 프로필 가져오기",
    ),
    "liquidGlass": MessageLookupByLibrary.simpleMessage("Liquid Glass"),
    "list": MessageLookupByLibrary.simpleMessage("목록"),
    "listen": MessageLookupByLibrary.simpleMessage("수신"),
    "listenRoutingMark": MessageLookupByLibrary.simpleMessage("수신 라우팅 마크"),
    "listenRoutingMarkDesc": MessageLookupByLibrary.simpleMessage(
      "수신 라우팅 마크는 Linux에서만 작동합니다.",
    ),
    "liveConnections": MessageLookupByLibrary.simpleMessage("실시간 연결"),
    "loading": MessageLookupByLibrary.simpleMessage("로드 중…"),
    "local": MessageLookupByLibrary.simpleMessage("로컬"),
    "localBackupDesc": MessageLookupByLibrary.simpleMessage("로컬 데이터를 이 기기에 백업"),
    "localImage": MessageLookupByLibrary.simpleMessage("로컬 이미지"),
    "localNetworkTip": MessageLookupByLibrary.simpleMessage(
      "로컬 네트워크 접근이 거부되어 이번 연결에는 gVisor를 사용합니다. LAN 프록시와 서비스는 계속 사용할 수 없을 수 있습니다",
    ),
    "locateSelected": MessageLookupByLibrary.simpleMessage("선택한 노드 찾기"),
    "locationPermission": MessageLookupByLibrary.simpleMessage("위치 권한"),
    "locationPermissionGuide": m47,
    "locationPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "위치 권한 필요",
    ),
    "log": MessageLookupByLibrary.simpleMessage("로그"),
    "logLevel": MessageLookupByLibrary.simpleMessage("로그 수준"),
    "logcat": MessageLookupByLibrary.simpleMessage("Logcat"),
    "logcatDesc": MessageLookupByLibrary.simpleMessage("끄면 로그 항목이 숨겨집니다"),
    "loggedOutViewDesc": MessageLookupByLibrary.simpleMessage(
      "로그인하여 계정 정보를 확인하고 구독을 관리하세요",
    ),
    "loggedOutViewTitle": MessageLookupByLibrary.simpleMessage("oixCloud"),
    "loginFailed": MessageLookupByLibrary.simpleMessage("로그인 실패"),
    "loginSuccess": MessageLookupByLibrary.simpleMessage("로그인 성공"),
    "loginTitle": MessageLookupByLibrary.simpleMessage("로그인"),
    "logoutContent": MessageLookupByLibrary.simpleMessage("로그아웃하시겠습니까?"),
    "logoutTitle": MessageLookupByLibrary.simpleMessage("로그아웃"),
    "logs": MessageLookupByLibrary.simpleMessage("로그"),
    "logsAndDiagnostics": MessageLookupByLibrary.simpleMessage("로그 및 진단"),
    "logsDesc": MessageLookupByLibrary.simpleMessage("로그 기록"),
    "logsTest": MessageLookupByLibrary.simpleMessage("로그 테스트"),
    "lookupProxyConfig": MessageLookupByLibrary.simpleMessage("노드 설정 찾기"),
    "loopback": MessageLookupByLibrary.simpleMessage("UWP 루프백 예외"),
    "loopbackDesc": MessageLookupByLibrary.simpleMessage("UWP 앱의 루프백 제한 해제"),
    "loose": MessageLookupByLibrary.simpleMessage("넓게"),
    "mainlandNetworkWarning": MessageLookupByLibrary.simpleMessage(
      "중국 본토 네트워크에 적합하지 않을 수 있습니다",
    ),
    "matchCase": MessageLookupByLibrary.simpleMessage("대/소문자 구분"),
    "matchTarget": MessageLookupByLibrary.simpleMessage("MATCH-TARGET"),
    "matchTargetTitle": MessageLookupByLibrary.simpleMessage("일치 대상"),
    "maxFailedTimes": MessageLookupByLibrary.simpleMessage("최대 실패 횟수"),
    "maxLengthTip": m48,
    "maximize": MessageLookupByLibrary.simpleMessage("최대화"),
    "memberOrderHint": MessageLookupByLibrary.simpleMessage(
      "선택한 순서가 대체 연결 순서입니다. 구성원을 제거한 후 다시 선택하면 맨 뒤로 이동합니다.",
    ),
    "memoryAppResident": MessageLookupByLibrary.simpleMessage("상주 메모리"),
    "memoryAppShared": MessageLookupByLibrary.simpleMessage("앱 및 공유"),
    "memoryCoreHeapIdle": MessageLookupByLibrary.simpleMessage("유휴 힙"),
    "memoryCoreHeapInuse": MessageLookupByLibrary.simpleMessage("사용 중인 힙"),
    "memoryCoreNotRunning": MessageLookupByLibrary.simpleMessage(
      "코어가 실행 중이 아닙니다",
    ),
    "memoryCoreRuntime": MessageLookupByLibrary.simpleMessage("런타임 오버헤드"),
    "memoryCoreStack": MessageLookupByLibrary.simpleMessage("고루틴 스택"),
    "memoryEstimateDesc": MessageLookupByLibrary.simpleMessage(
      "프로세스 상주 메모리로 추정한 값이며 시스템에 표시되는 값과 다를 수 있습니다.",
    ),
    "memoryEstimateSharedDesc": MessageLookupByLibrary.simpleMessage(
      "코어는 앱 프로세스 안에서 실행됩니다. 코어의 점유량은 런타임 통계로 추정하며, 나머지는 앱 및 공유 메모리로 집계합니다.",
    ),
    "memoryInfo": MessageLookupByLibrary.simpleMessage("메모리 정보"),
    "memoryInfoDesc": MessageLookupByLibrary.simpleMessage("앱과 코어가 사용하는 메모리"),
    "memoryReleased": MessageLookupByLibrary.simpleMessage("메모리를 해제했습니다"),
    "memoryReleasedSize": m49,
    "messageTest": MessageLookupByLibrary.simpleMessage("메시지 테스트"),
    "messageTestTip": MessageLookupByLibrary.simpleMessage("이것은 메시지입니다."),
    "minimalConfiguration": MessageLookupByLibrary.simpleMessage("최소 설정"),
    "minimalConfigurationDesc": MessageLookupByLibrary.simpleMessage(
      "간소화된 규칙으로 더 작은 프로필을 생성합니다",
    ),
    "minimize": MessageLookupByLibrary.simpleMessage("최소화"),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage("종료 시 최소화"),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "앱 종료 시 기본 동작 변경",
    ),
    "minutes": MessageLookupByLibrary.simpleMessage("분"),
    "minutesAgo": m50,
    "minutesAgoShort": m51,
    "mixedPort": MessageLookupByLibrary.simpleMessage("혼합 포트"),
    "mode": MessageLookupByLibrary.simpleMessage("모드"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("모노크롬"),
    "monthsAgo": m52,
    "monthsAgoShort": m53,
    "more": MessageLookupByLibrary.simpleMessage("더 보기"),
    "myOrders": MessageLookupByLibrary.simpleMessage("구매한 요금제"),
    "name": MessageLookupByLibrary.simpleMessage("이름"),
    "nameCustomProfileTip": MessageLookupByLibrary.simpleMessage(
      "이 사용자 지정 프로필의 이름을 입력하세요",
    ),
    "nameserver": MessageLookupByLibrary.simpleMessage("DNS 서버"),
    "nameserverDesc": MessageLookupByLibrary.simpleMessage("도메인 이름을 확인합니다"),
    "nameserverPolicy": MessageLookupByLibrary.simpleMessage("DNS 서버 정책"),
    "nameserverPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "일치하는 도메인에 사용할 DNS 서버를 선택합니다",
    ),
    "navigationBarStyle": MessageLookupByLibrary.simpleMessage("하단 바"),
    "network": MessageLookupByLibrary.simpleMessage("네트워크"),
    "networkAccessDeniedError": m54,
    "networkBadResponseError": m55,
    "networkCancelledError": MessageLookupByLibrary.simpleMessage(
      "요청이 취소되었습니다",
    ),
    "networkConnectionError": MessageLookupByLibrary.simpleMessage(
      "서버에 연결할 수 없습니다. 네트워크 연결이나 프록시 설정을 확인하세요",
    ),
    "networkDesc": MessageLookupByLibrary.simpleMessage("네트워크 관련 설정 변경"),
    "networkDetection": MessageLookupByLibrary.simpleMessage("네트워크 진단"),
    "networkException": MessageLookupByLibrary.simpleMessage(
      "네트워크 오류입니다. 연결을 확인한 후 다시 시도하세요",
    ),
    "networkHostLookupError": MessageLookupByLibrary.simpleMessage(
      "서버 주소를 확인할 수 없습니다. URL이 올바른지, DNS가 정상인지 확인하세요",
    ),
    "networkName": MessageLookupByLibrary.simpleMessage("네트워크 이름"),
    "networkNotFoundError": m56,
    "networkRateLimitedError": MessageLookupByLibrary.simpleMessage(
      "요청이 너무 많습니다(HTTP 429). 잠시 후 다시 시도하세요",
    ),
    "networkSecret": MessageLookupByLibrary.simpleMessage("네트워크 시크릿"),
    "networkServerError": m57,
    "networkSpeed": MessageLookupByLibrary.simpleMessage("네트워크 속도"),
    "networkTakeover": MessageLookupByLibrary.simpleMessage("트래픽 가로채기"),
    "networkTimeoutError": MessageLookupByLibrary.simpleMessage(
      "요청 시간이 초과되었습니다. 네트워크나 프록시를 확인한 후 다시 시도하세요",
    ),
    "networkTlsError": MessageLookupByLibrary.simpleMessage(
      "보안 연결에 실패했습니다. 서버 인증서가 올바르지 않거나 연결이 가로채이고 있을 수 있습니다",
    ),
    "networkType": MessageLookupByLibrary.simpleMessage("네트워크 유형"),
    "newPasswordLabel": MessageLookupByLibrary.simpleMessage("새 비밀번호"),
    "nextMatch": MessageLookupByLibrary.simpleMessage("다음 결과"),
    "nicknameHint": MessageLookupByLibrary.simpleMessage("영문자와 숫자, 최대 12자"),
    "nicknameLabel": MessageLookupByLibrary.simpleMessage("닉네임"),
    "nicknameValidation": MessageLookupByLibrary.simpleMessage("닉네임을 입력하세요"),
    "no": MessageLookupByLibrary.simpleMessage("아니요"),
    "noAvailablePlans": MessageLookupByLibrary.simpleMessage(
      "이용 가능한 요금제가 없습니다",
    ),
    "noData": MessageLookupByLibrary.simpleMessage("데이터 없음"),
    "noInfo": MessageLookupByLibrary.simpleMessage("정보 없음"),
    "noNetwork": MessageLookupByLibrary.simpleMessage("네트워크 없음"),
    "noNetworkApp": MessageLookupByLibrary.simpleMessage("네트워크를 사용하지 않는 앱"),
    "noPaymentMethods": MessageLookupByLibrary.simpleMessage(
      "이용 가능한 결제 수단이 없습니다",
    ),
    "noProxy": MessageLookupByLibrary.simpleMessage("프록시 없음"),
    "noPurchaseRecords": MessageLookupByLibrary.simpleMessage("구매한 요금제가 없습니다"),
    "noRemoteBackup": MessageLookupByLibrary.simpleMessage("WebDAV에 백업이 없습니다"),
    "noResolve": MessageLookupByLibrary.simpleMessage("IP 확인 안 함"),
    "noSearchResult": MessageLookupByLibrary.simpleMessage("일치하는 결과가 없습니다"),
    "noSearchResults": MessageLookupByLibrary.simpleMessage("일치하는 결과 없음"),
    "noUpgradablePlans": MessageLookupByLibrary.simpleMessage(
      "업그레이드 가능한 요금제가 없습니다",
    ),
    "nodeCoreValidationUnavailable": MessageLookupByLibrary.simpleMessage(
      "이 노드를 검증하기 전에 코어를 시작하세요",
    ),
    "nodeDefinition": MessageLookupByLibrary.simpleMessage("노드 정의"),
    "nodeFilter": MessageLookupByLibrary.simpleMessage("노드 필터"),
    "nodeFilterAccountNote": MessageLookupByLibrary.simpleMessage(
      "계정에 저장되며 이 앱에 로그인한 모든 기기에 적용됩니다.",
    ),
    "nodeFilterAny": MessageLookupByLibrary.simpleMessage("모두"),
    "nodeFilterCustomized": MessageLookupByLibrary.simpleMessage("사용자 지정"),
    "nodeFilterExclude": MessageLookupByLibrary.simpleMessage("제외"),
    "nodeFilterKeepOne": MessageLookupByLibrary.simpleMessage(
      "노드를 하나 이상 유지하세요",
    ),
    "nodeFilterKept": m58,
    "nodeFilterLines": MessageLookupByLibrary.simpleMessage("회선"),
    "nodeFilterNameContains": MessageLookupByLibrary.simpleMessage("이름에 포함"),
    "nodeFilterNameExcludes": MessageLookupByLibrary.simpleMessage("이름에서 제외"),
    "nodeFilterNodeExcluded": m59,
    "nodeFilterNodeKept": m60,
    "nodeFilterOnly": MessageLookupByLibrary.simpleMessage("선택 항목만"),
    "nodeFilterPreview": MessageLookupByLibrary.simpleMessage("미리 보기"),
    "nodeFilterRegions": MessageLookupByLibrary.simpleMessage("지역"),
    "nodeFilterRetry": MessageLookupByLibrary.simpleMessage("다시 시도"),
    "nodeFilterSearch": MessageLookupByLibrary.simpleMessage("노드 검색"),
    "nodeFilterSmartSelection": MessageLookupByLibrary.simpleMessage("스마트 선택"),
    "nodeInvalidDefinition": MessageLookupByLibrary.simpleMessage(
      "이름과 유형을 포함한 완전한 프록시 정의를 입력하세요",
    ),
    "nodeQuickFields": MessageLookupByLibrary.simpleMessage("빠른 편집"),
    "nodes": MessageLookupByLibrary.simpleMessage("노드"),
    "nonTextProviderFile": MessageLookupByLibrary.simpleMessage(
      "이 외부 리소스는 텍스트 파일이 아닙니다",
    ),
    "none": MessageLookupByLibrary.simpleMessage("없음"),
    "notRunning": MessageLookupByLibrary.simpleMessage("실행 중 아님"),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "현재 프록시 그룹은 선택할 수 없습니다",
    ),
    "ntpDesc": MessageLookupByLibrary.simpleMessage("NTP 관련 설정 변경"),
    "ntpInterval": MessageLookupByLibrary.simpleMessage("동기화 간격(분)"),
    "ntpOverrideDesc": MessageLookupByLibrary.simpleMessage(
      "여기에 추가한 항목은 모든 프로필의 NTP 설정을 대체하며, 추가하지 않은 항목은 각 프로필의 설정을 유지합니다. 사용자 지정 프로필 자체의 항목이 우선합니다",
    ),
    "ntpStatusDesc": MessageLookupByLibrary.simpleMessage(
      "NTP는 시스템 시계 대신 NTP 서버에서 시간을 가져옵니다.",
    ),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "프로필이 없습니다. 프로필을 추가하세요",
    ),
    "nullTip": m61,
    "numberRangeTip": m62,
    "numberTip": m63,
    "obfs": MessageLookupByLibrary.simpleMessage("난독화"),
    "obfsHost": MessageLookupByLibrary.simpleMessage("난독화 호스트"),
    "obfsMode": MessageLookupByLibrary.simpleMessage("난독화 모드"),
    "obfsParam": MessageLookupByLibrary.simpleMessage("난독화 매개변수"),
    "obfsPassword": MessageLookupByLibrary.simpleMessage("난독화 비밀번호"),
    "oixCloud": MessageLookupByLibrary.simpleMessage("oixCloud"),
    "onDemand": MessageLookupByLibrary.simpleMessage("필요 시 실행"),
    "onDemandDesc": MessageLookupByLibrary.simpleMessage(
      "Wi-Fi 또는 네트워크 상태에 따라 프록시를 일시 중지하거나 재개합니다",
    ),
    "onlyStatisticsProxy": MessageLookupByLibrary.simpleMessage("프록시 트래픽만 집계"),
    "onlyStatisticsProxyDesc": MessageLookupByLibrary.simpleMessage(
      "프록시 트래픽만 집계",
    ),
    "openDashboard": MessageLookupByLibrary.simpleMessage("대시보드 열기"),
    "openInBrowser": MessageLookupByLibrary.simpleMessage("브라우저에서 열기"),
    "openLinkFailed": MessageLookupByLibrary.simpleMessage(
      "링크를 열 수 없습니다. 브라우저가 설치되어 있는지 확인한 후 다시 시도하세요.",
    ),
    "operationFailed": MessageLookupByLibrary.simpleMessage("작업 실패"),
    "operationSuccess": MessageLookupByLibrary.simpleMessage("작업 성공"),
    "optional": MessageLookupByLibrary.simpleMessage("선택 사항"),
    "options": MessageLookupByLibrary.simpleMessage("옵션"),
    "other": MessageLookupByLibrary.simpleMessage("기타"),
    "outbound": MessageLookupByLibrary.simpleMessage("아웃바운드"),
    "outboundExit": MessageLookupByLibrary.simpleMessage("출구"),
    "outboundMode": MessageLookupByLibrary.simpleMessage("아웃바운드 모드"),
    "outboundUnavailable": MessageLookupByLibrary.simpleMessage(
      "이 설정에서는 사용할 수 없습니다. 제거하거나 다른 항목으로 바꾸세요.",
    ),
    "overlayHint": MessageLookupByLibrary.simpleMessage(
      "구독과 별도로 저장되며 업데이트 후 다시 적용됩니다. 새 그룹에 일치하는 구성원이 없으면 연결을 차단합니다.",
    ),
    "overlayNameConflict": m64,
    "override": MessageLookupByLibrary.simpleMessage("덮어쓰기"),
    "overrideDestination": MessageLookupByLibrary.simpleMessage("대상 덮어쓰기"),
    "overrideDestinationDesc": MessageLookupByLibrary.simpleMessage(
      "대상 덮어쓰기는 원래 주소 대신 스니핑한 도메인으로 연결합니다.",
    ),
    "overrideEntries": MessageLookupByLibrary.simpleMessage("덮어쓰기 항목"),
    "overrideMode": MessageLookupByLibrary.simpleMessage("덮어쓰기 모드"),
    "overrideScript": MessageLookupByLibrary.simpleMessage("덮어쓰기 스크립트"),
    "overwriteIssueDuplicateName": m65,
    "overwriteIssueEmptyFallback": m66,
    "overwriteIssueEmptyName": MessageLookupByLibrary.simpleMessage(
      "이름이 비어 있습니다",
    ),
    "overwriteIssueGroupLoop": m67,
    "overwriteIssueMissingProviders": m68,
    "overwriteIssueMissingProxies": m69,
    "overwriteIssueNoProxySource": MessageLookupByLibrary.simpleMessage(
      "프록시나 프록시 공급자가 선택되지 않아 코어가 이 그룹을 거부합니다",
    ),
    "overwriteIssueReservedName": m70,
    "overwriteIssuesSummary": m71,
    "overwriteTypeCustom": MessageLookupByLibrary.simpleMessage("사용자 지정"),
    "overwriteTypeCustomDesc": MessageLookupByLibrary.simpleMessage(
      "프록시 그룹과 규칙을 모두 직접 구성합니다",
    ),
    "overwriteTypeMerge": MessageLookupByLibrary.simpleMessage("오버레이"),
    "overwriteTypeMergeDesc": MessageLookupByLibrary.simpleMessage(
      "구독의 규칙과 그룹을 유지하고 개인 설정을 추가합니다. 개인 규칙은 구독 규칙보다 우선하며, 기존 추가 규칙은 우선순위를 유지합니다.",
    ),
    "parsePureIp": MessageLookupByLibrary.simpleMessage("순수 IP 분석"),
    "parsePureIpDesc": MessageLookupByLibrary.simpleMessage(
      "순수 IP 분석은 IP 주소만 있는 연결을 스니핑합니다.",
    ),
    "password": MessageLookupByLibrary.simpleMessage("비밀번호"),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("비밀번호"),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage("비밀번호가 일치하지 않습니다"),
    "passwordRuleHint": MessageLookupByLibrary.simpleMessage(
      "대문자, 소문자, 숫자 및 기호를 포함한 10~36자",
    ),
    "passwordValidation": MessageLookupByLibrary.simpleMessage("비밀번호를 입력하세요"),
    "paste": MessageLookupByLibrary.simpleMessage("붙여넣기"),
    "pauseUpdates": MessageLookupByLibrary.simpleMessage("새로 고침 일시 중지"),
    "payWithBalance": MessageLookupByLibrary.simpleMessage("잔액으로 결제"),
    "paymentAmount": MessageLookupByLibrary.simpleMessage("결제 금액"),
    "paymentMethod": MessageLookupByLibrary.simpleMessage("결제 수단"),
    "paymentPending": MessageLookupByLibrary.simpleMessage(
      "아직 결제가 확인되지 않았습니다. 잠시 후 다시 확인하세요.",
    ),
    "paymentRequestFailed": MessageLookupByLibrary.simpleMessage("결제 요청 실패"),
    "paymentSuccess": MessageLookupByLibrary.simpleMessage("결제 성공"),
    "paymentUnknownResponse": MessageLookupByLibrary.simpleMessage(
      "결제 서비스가 알 수 없는 형식으로 응답했습니다",
    ),
    "peers": MessageLookupByLibrary.simpleMessage("피어"),
    "personalRouting": MessageLookupByLibrary.simpleMessage("개인 라우팅"),
    "pickFromAlbum": MessageLookupByLibrary.simpleMessage("앨범에서 선택"),
    "pinWindow": MessageLookupByLibrary.simpleMessage("창 고정"),
    "planEnded": MessageLookupByLibrary.simpleMessage("종료됨"),
    "planInUse": MessageLookupByLibrary.simpleMessage("사용 중"),
    "planNotActivated": MessageLookupByLibrary.simpleMessage("활성화 대기"),
    "planNumber": m72,
    "planUnavailable": MessageLookupByLibrary.simpleMessage("이용 불가"),
    "pleaseBindWebDAV": MessageLookupByLibrary.simpleMessage("WebDAV를 연결하세요"),
    "pleaseInputAdminPassword": MessageLookupByLibrary.simpleMessage(
      "관리자 비밀번호를 입력하세요",
    ),
    "pleaseUploadValidQrcode": MessageLookupByLibrary.simpleMessage(
      "올바른 QR 코드를 업로드하세요",
    ),
    "plugin": MessageLookupByLibrary.simpleMessage("플러그인"),
    "pluginHost": MessageLookupByLibrary.simpleMessage("플러그인 호스트"),
    "pluginMode": MessageLookupByLibrary.simpleMessage("플러그인 모드"),
    "points": MessageLookupByLibrary.simpleMessage("포인트"),
    "port": MessageLookupByLibrary.simpleMessage("포트"),
    "portConflictTip": MessageLookupByLibrary.simpleMessage("다른 포트를 입력하세요"),
    "portHopping": MessageLookupByLibrary.simpleMessage("포트 호핑"),
    "portProxyAppTip": MessageLookupByLibrary.simpleMessage(
      "다른 프록시 앱이 실행 중이면 먼저 종료하세요.",
    ),
    "portSuggestionTip": m73,
    "portTip": m74,
    "portUnavailableMessage": m75,
    "portUnavailableTitle": MessageLookupByLibrary.simpleMessage(
      "포트를 사용할 수 없음",
    ),
    "portValue": m76,
    "ports": MessageLookupByLibrary.simpleMessage("포트"),
    "preSharedKey": MessageLookupByLibrary.simpleMessage("사전 공유 키"),
    "preferH3": MessageLookupByLibrary.simpleMessage("HTTP/3 우선 사용"),
    "preferH3Desc": MessageLookupByLibrary.simpleMessage(
      "DoH 서버에 HTTP/3을 우선 시도합니다",
    ),
    "prerequisites": MessageLookupByLibrary.simpleMessage("사전 요건"),
    "pressKeyboard": MessageLookupByLibrary.simpleMessage("키를 누르세요."),
    "preview": MessageLookupByLibrary.simpleMessage("미리보기"),
    "previousMatch": MessageLookupByLibrary.simpleMessage("이전 결과"),
    "privateKey": MessageLookupByLibrary.simpleMessage("개인 키"),
    "privateKeyPassphrase": MessageLookupByLibrary.simpleMessage("개인 키 암호"),
    "process": MessageLookupByLibrary.simpleMessage("프로세스"),
    "profile": MessageLookupByLibrary.simpleMessage("프로필"),
    "profileAutoUpdateIntervalInvalidValidationDesc":
        MessageLookupByLibrary.simpleMessage("올바른 간격을 입력하세요"),
    "profileAutoUpdateIntervalNullValidationDesc":
        MessageLookupByLibrary.simpleMessage("자동 업데이트 간격을 입력하세요"),
    "profileDaysLeft": m77,
    "profileExpiresIn": m78,
    "profileHasUpdate": MessageLookupByLibrary.simpleMessage(
      "프로필이 변경되었습니다. 자동 업데이트를 끄시겠습니까?",
    ),
    "profileNameNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "프로필 이름을 입력하세요",
    ),
    "profileOverrideSettingsDesc": MessageLookupByLibrary.simpleMessage(
      "이 프로필에만 적용되며 앱의 DNS 및 NTP 덮어쓰기 항목보다 우선합니다. 추가하지 않은 항목은 앱의 덮어쓰기 설정을 따릅니다",
    ),
    "profileParseErrorDesc": MessageLookupByLibrary.simpleMessage(
      "프로필 구문 분석 오류",
    ),
    "profileProviderInUse": m79,
    "profileSettingsDesc": MessageLookupByLibrary.simpleMessage(
      "이 프로필에만 적용되며, 추가하지 않은 항목은 기본값을 사용합니다.",
    ),
    "profileTunSettingsDesc": MessageLookupByLibrary.simpleMessage(
      "이 프로필에만 적용되며 네트워크 설정의 TUN 덮어쓰기 항목보다 우선합니다.",
    ),
    "profileUpdatedAt": m80,
    "profileUrlInvalidValidationDesc": MessageLookupByLibrary.simpleMessage(
      "올바른 프로필 URL을 입력하세요",
    ),
    "profileUrlNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "프로필 URL을 입력하세요",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("프로필"),
    "profilesSort": MessageLookupByLibrary.simpleMessage("프로필 정렬"),
    "project": MessageLookupByLibrary.simpleMessage("프로젝트"),
    "protocol": MessageLookupByLibrary.simpleMessage("프로토콜"),
    "protocolParam": MessageLookupByLibrary.simpleMessage("프로토콜 매개변수"),
    "protocolVersion": MessageLookupByLibrary.simpleMessage("프로토콜 버전"),
    "providerChanged": MessageLookupByLibrary.simpleMessage(
      "편집 중 리소스가 변경되었습니다. 다시 열어 시도하세요",
    ),
    "providerContent": MessageLookupByLibrary.simpleMessage("리소스 내용"),
    "providerContentInvalid": MessageLookupByLibrary.simpleMessage(
      "리소스 내용 또는 형식이 유효하지 않습니다",
    ),
    "providerContentTooLarge": MessageLookupByLibrary.simpleMessage(
      "리소스가 32 MiB를 초과합니다",
    ),
    "providerInUse": m81,
    "providerLocal": MessageLookupByLibrary.simpleMessage("로컬 파일"),
    "providerLookupFailed": MessageLookupByLibrary.simpleMessage(
      "현재 적용된 노드 설정을 읽을 수 없습니다. 리소스를 새로 고친 후 다시 시도하세요",
    ),
    "providerNameInvalid": MessageLookupByLibrary.simpleMessage(
      "쉼표와 줄바꿈이 없는 이름을 입력하세요",
    ),
    "providerRemote": MessageLookupByLibrary.simpleMessage("원격 URL"),
    "providerRenameShadowed": m82,
    "providerSourceApp": MessageLookupByLibrary.simpleMessage("앱 라이브러리"),
    "providerSourceProfile": MessageLookupByLibrary.simpleMessage("프로필"),
    "providerSourceReference": m83,
    "providerSourceSubscription": MessageLookupByLibrary.simpleMessage("구독"),
    "providerSourceUnavailable": m84,
    "providerUrlTip": MessageLookupByLibrary.simpleMessage(
      "인증 정보가 포함되지 않은 HTTP 또는 HTTPS URL을 입력하세요",
    ),
    "providers": MessageLookupByLibrary.simpleMessage("공급자"),
    "proxies": MessageLookupByLibrary.simpleMessage("프록시"),
    "proxiesCount": m85,
    "proxyChainAvailableNodes": MessageLookupByLibrary.simpleMessage(
      "사용 가능한 노드",
    ),
    "proxyChainConflictTip": m86,
    "proxyChainCustomNode": MessageLookupByLibrary.simpleMessage("사용자 지정 노드"),
    "proxyChainCustomNodes": MessageLookupByLibrary.simpleMessage("사용자 지정 노드"),
    "proxyChainEmpty": MessageLookupByLibrary.simpleMessage("프록시 체인에 노드가 없습니다"),
    "proxyChainEntry": MessageLookupByLibrary.simpleMessage("진입"),
    "proxyChainExit": MessageLookupByLibrary.simpleMessage("출구"),
    "proxyChainInstruction": MessageLookupByLibrary.simpleMessage(
      "노드를 순서대로 선택하세요. 첫 번째 노드는 진입점, 마지막 노드는 출구입니다. 체인을 사용하려면 출구 노드를 선택하세요.",
    ),
    "proxyChainMinimumNodes": MessageLookupByLibrary.simpleMessage(
      "프록시 체인에는 노드가 2개 이상 필요합니다",
    ),
    "proxyChainMinimumNodesHint": MessageLookupByLibrary.simpleMessage(
      "프록시 체인에는 노드가 2개 이상 필요합니다. 출구 노드를 추가하세요.",
    ),
    "proxyChainNodeAdded": MessageLookupByLibrary.simpleMessage(
      "프록시 체인에 노드를 추가했습니다",
    ),
    "proxyChainOtherNodes": MessageLookupByLibrary.simpleMessage("기타 노드"),
    "proxyChainRelatedChainsUpdated": MessageLookupByLibrary.simpleMessage(
      "관련 프록시 체인을 업데이트했습니다",
    ),
    "proxyChainSavedAndApplied": MessageLookupByLibrary.simpleMessage(
      "프록시 체인을 저장하고 적용했습니다. 사용하려면 출구 노드를 선택하세요",
    ),
    "proxyChainSelectedNodes": MessageLookupByLibrary.simpleMessage("프록시 체인"),
    "proxyChainUnavailableNodeTip": m87,
    "proxyChainUriNodeSupportedFormats": MessageLookupByLibrary.simpleMessage(
      "지원 형식: ss://, ssr://, vmess://, vless://, trojan://, anytls://, hysteria:// / hy://, hysteria2:// / hy2://, tuic://, wireguard:// / wg://, http(s)://, socks(5)://",
    ),
    "proxyChainWarning": MessageLookupByLibrary.simpleMessage(
      "프록시 체인은 네트워크 속도를 크게 떨어뜨릴 수 있습니다. 필요한 경우에만 사용하세요.",
    ),
    "proxyChains": MessageLookupByLibrary.simpleMessage("프록시 체인"),
    "proxyConflictAutoConfig": MessageLookupByLibrary.simpleMessage(
      "시작 전 시스템 프록시가 자동 설정 스크립트를 사용하고 있었습니다.",
    ),
    "proxyConflictHint": MessageLookupByLibrary.simpleMessage(
      "다른 프록시 앱이나 VPN의 설정이라면 해당 앱을 종료하세요. 동시에 실행하면 연결에 문제가 생길 수 있습니다.",
    ),
    "proxyConflictSystemProxy": m88,
    "proxyConflictTitle": MessageLookupByLibrary.simpleMessage("프록시 충돌 가능성"),
    "proxyConflictVpn": m89,
    "proxyFilter": MessageLookupByLibrary.simpleMessage("프록시 필터"),
    "proxyGroup": MessageLookupByLibrary.simpleMessage("프록시 그룹"),
    "proxyGroupEmpty": MessageLookupByLibrary.simpleMessage("프록시 그룹이 비어 있습니다"),
    "proxyGroupMembersEmpty": MessageLookupByLibrary.simpleMessage(
      "프록시, 공급자 또는 모두 포함 옵션을 추가하세요",
    ),
    "proxyGroupNameEmpty": MessageLookupByLibrary.simpleMessage(
      "프록시 그룹 이름은 비워 둘 수 없습니다",
    ),
    "proxyGroupsAfterStart": MessageLookupByLibrary.simpleMessage(
      "코어가 시작되면 그룹이 여기에 표시됩니다",
    ),
    "proxyGroupsCount": m90,
    "proxyNameserver": MessageLookupByLibrary.simpleMessage("프록시 노드 DNS"),
    "proxyNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "프록시 노드의 도메인 이름을 확인합니다",
    ),
    "proxyNameserverPolicy": MessageLookupByLibrary.simpleMessage(
      "프록시 노드 DNS 정책",
    ),
    "proxyNode": MessageLookupByLibrary.simpleMessage("프록시 노드"),
    "proxyPort": MessageLookupByLibrary.simpleMessage("프록시 포트"),
    "proxyProviders": MessageLookupByLibrary.simpleMessage("프록시 공급자"),
    "proxyType": MessageLookupByLibrary.simpleMessage("프록시 유형"),
    "pruneCache": MessageLookupByLibrary.simpleMessage("캐시 정리"),
    "publicKey": MessageLookupByLibrary.simpleMessage("공개 키"),
    "purchaseAutoRenewLabel": MessageLookupByLibrary.simpleMessage("자동 갱신"),
    "purchaseDays": m91,
    "purchaseHours": m92,
    "purchaseMinutes": m93,
    "purchasePriceLabel": MessageLookupByLibrary.simpleMessage("구매 가격"),
    "purchaseRenewOff": MessageLookupByLibrary.simpleMessage("꺼짐"),
    "purchaseRenewOn": MessageLookupByLibrary.simpleMessage("켜짐"),
    "purchaseTotalTrafficLabel": MessageLookupByLibrary.simpleMessage("총 트래픽"),
    "purchasedAtLabel": MessageLookupByLibrary.simpleMessage("구매 시각"),
    "pureBlack": MessageLookupByLibrary.simpleMessage("퓨어 블랙"),
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("퓨어 블랙 모드"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QR 코드"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage("QR 코드를 스캔하여 프로필 가져오기"),
    "quickActions": MessageLookupByLibrary.simpleMessage("빠른 작업"),
    "quickAdd": MessageLookupByLibrary.simpleMessage("빠른 추가"),
    "quickEdit": MessageLookupByLibrary.simpleMessage("빠른 편집"),
    "quickFill": MessageLookupByLibrary.simpleMessage("빠른 채우기"),
    "rawOutboundInUse": m94,
    "readFullAnnouncement": MessageLookupByLibrary.simpleMessage("공지 전체 읽기"),
    "receivingAddress": MessageLookupByLibrary.simpleMessage("수신 주소"),
    "recharge": MessageLookupByLibrary.simpleMessage("충전"),
    "rechargeAllowedRange": m95,
    "rechargeAmount": MessageLookupByLibrary.simpleMessage("충전 금액(¥)"),
    "rechargeAmountOutOfRange": MessageLookupByLibrary.simpleMessage(
      "이 결제 수단에서 허용하는 금액 범위를 벗어났습니다",
    ),
    "recommendedIcons": MessageLookupByLibrary.simpleMessage("추천"),
    "recurringRenewalHint": MessageLookupByLibrary.simpleMessage(
      "이후 자동 갱신에도 이 할인이 적용됩니다",
    ),
    "redirPort": MessageLookupByLibrary.simpleMessage("Redir 포트"),
    "redo": MessageLookupByLibrary.simpleMessage("다시 실행"),
    "refresh": MessageLookupByLibrary.simpleMessage("새로 고침"),
    "refreshAfterPayment": MessageLookupByLibrary.simpleMessage(
      "결제 후 아래로 당겨 새로 고침하고 결과를 확인하세요",
    ),
    "refundAmountLabel": MessageLookupByLibrary.simpleMessage("환불액"),
    "regex": MessageLookupByLibrary.simpleMessage("정규식"),
    "register": MessageLookupByLibrary.simpleMessage("가입"),
    "registerClosed": MessageLookupByLibrary.simpleMessage("현재 가입이 마감되었습니다"),
    "registerFailed": MessageLookupByLibrary.simpleMessage("가입 실패"),
    "registerTitle": MessageLookupByLibrary.simpleMessage("계정 만들기"),
    "relayGroupUnsupported": MessageLookupByLibrary.simpleMessage(
      "코어에서 Relay 그룹이 제거되었습니다. 다른 유형을 선택하세요.",
    ),
    "releaseMemory": MessageLookupByLibrary.simpleMessage("메모리 해제"),
    "releaseMemoryFailed": MessageLookupByLibrary.simpleMessage(
      "메모리를 해제하지 못했습니다",
    ),
    "remaining": m96,
    "remainingStock": m97,
    "remainingTimeLabel": MessageLookupByLibrary.simpleMessage("남은 시간"),
    "remainingTrafficLabel": MessageLookupByLibrary.simpleMessage("남은 트래픽"),
    "remote": MessageLookupByLibrary.simpleMessage("원격"),
    "remoteBackupDesc": MessageLookupByLibrary.simpleMessage(
      "로컬 데이터를 WebDAV에 백업",
    ),
    "remoteDestination": MessageLookupByLibrary.simpleMessage("원격 목적지"),
    "remoteDnsResolve": MessageLookupByLibrary.simpleMessage("원격 DNS 확인"),
    "remove": MessageLookupByLibrary.simpleMessage("제거"),
    "rename": MessageLookupByLibrary.simpleMessage("이름 변경"),
    "renewalPriceLabel": MessageLookupByLibrary.simpleMessage("갱신 가격"),
    "replace": MessageLookupByLibrary.simpleMessage("바꾸기"),
    "replaceAll": MessageLookupByLibrary.simpleMessage("모두 바꾸기"),
    "request": MessageLookupByLibrary.simpleMessage("요청"),
    "requests": MessageLookupByLibrary.simpleMessage("요청"),
    "requestsDesc": MessageLookupByLibrary.simpleMessage("최근 요청 기록 보기"),
    "required": MessageLookupByLibrary.simpleMessage("필수"),
    "resendCodeIn": m98,
    "reset": MessageLookupByLibrary.simpleMessage("초기화"),
    "resetDns": MessageLookupByLibrary.simpleMessage("DNS 초기화"),
    "resetDnsFailed": MessageLookupByLibrary.simpleMessage(
      "DNS를 초기화하지 못했습니다. 코어 연결을 확인하고 다시 시도하세요.",
    ),
    "resetDnsSuccess": MessageLookupByLibrary.simpleMessage("DNS 상태를 초기화했습니다"),
    "resetEmailSent": MessageLookupByLibrary.simpleMessage(
      "재설정 이메일을 보냈습니다. 이메일의 재설정 링크나 코드를 아래에 붙여 넣으세요.",
    ),
    "resetPageChangesTip": MessageLookupByLibrary.simpleMessage(
      "현재 페이지에 변경 사항이 있습니다. 초기화하시겠습니까?",
    ),
    "resetPasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "비밀번호가 재설정되었습니다. 새 비밀번호로 로그인하세요",
    ),
    "resetPasswordTitle": MessageLookupByLibrary.simpleMessage("비밀번호 재설정"),
    "resetTip": MessageLookupByLibrary.simpleMessage("초기화 확인"),
    "resetTokenLabel": MessageLookupByLibrary.simpleMessage("재설정 링크 또는 코드"),
    "resetTokenValidation": MessageLookupByLibrary.simpleMessage(
      "재설정 링크 또는 코드를 입력하세요",
    ),
    "resourceSizeLimitTip": m99,
    "resources": MessageLookupByLibrary.simpleMessage("리소스"),
    "resourcesDesc": MessageLookupByLibrary.simpleMessage("외부 리소스 정보"),
    "respectRules": MessageLookupByLibrary.simpleMessage("규칙 준수"),
    "respectRulesDesc": MessageLookupByLibrary.simpleMessage(
      "DNS 연결에 규칙을 적용합니다. 프록시 노드용 DNS 서버가 필요합니다",
    ),
    "restart": MessageLookupByLibrary.simpleMessage("다시 시작"),
    "restartCoreTip": MessageLookupByLibrary.simpleMessage("코어를 다시 시작하시겠습니까?"),
    "restore": MessageLookupByLibrary.simpleMessage("복원"),
    "restoreAllData": MessageLookupByLibrary.simpleMessage("모든 데이터 복원"),
    "restoreDefault": MessageLookupByLibrary.simpleMessage("기본값 복원"),
    "restoreException": MessageLookupByLibrary.simpleMessage("복원 오류"),
    "restoreFromFileDesc": MessageLookupByLibrary.simpleMessage("파일에서 데이터 복원"),
    "restoreFromWebDAVDesc": MessageLookupByLibrary.simpleMessage(
      "WebDAV에서 데이터 복원",
    ),
    "restoreOnlyConfig": MessageLookupByLibrary.simpleMessage("설정 파일만 복원"),
    "restoreStrategy": MessageLookupByLibrary.simpleMessage("복원 방식"),
    "restoreStrategy_compatible": MessageLookupByLibrary.simpleMessage("호환"),
    "restoreStrategy_override": MessageLookupByLibrary.simpleMessage("덮어쓰기"),
    "restoreSuccess": MessageLookupByLibrary.simpleMessage("복원 성공"),
    "result": MessageLookupByLibrary.simpleMessage("결과"),
    "resumeUpdates": MessageLookupByLibrary.simpleMessage("새로 고침 재개"),
    "retry": MessageLookupByLibrary.simpleMessage("다시 시도"),
    "retryCloudSyncWithCertificateException":
        MessageLookupByLibrary.simpleMessage("일시적으로 허용하고 동기화"),
    "retryWithoutCertificateVerification": MessageLookupByLibrary.simpleMessage(
      "API 임시 확인",
    ),
    "reverseEngineeringNotice": MessageLookupByLibrary.simpleMessage(
      "이 애플리케이션의 리버스 엔지니어링, 디컴파일, 디스어셈블 및 AI를 이용한 분석은 엄격히 금지됩니다.",
    ),
    "routeAddress": MessageLookupByLibrary.simpleMessage("라우팅 주소"),
    "routeAddressDesc": MessageLookupByLibrary.simpleMessage("수신할 라우팅 주소 설정"),
    "routeExcludeAddress": MessageLookupByLibrary.simpleMessage("라우팅 제외 주소"),
    "routingApplied": MessageLookupByLibrary.simpleMessage("개인 설정을 적용했습니다."),
    "routingApplyFailed": MessageLookupByLibrary.simpleMessage(
      "변경 사항은 저장했으나 적용하지 못했습니다. 설정을 확인한 후 다시 시도하세요.",
    ),
    "routingChanged": MessageLookupByLibrary.simpleMessage(
      "편집 또는 확인 중에 설정이 변경되었습니다. 편집기를 다시 열거나 다시 확인하세요.",
    ),
    "routingChecked": MessageLookupByLibrary.simpleMessage(
      "설정이 유효합니다. 이 프로필의 개인 설정을 저장했습니다.",
    ),
    "routingDraftHint": MessageLookupByLibrary.simpleMessage(
      "다른 항목을 수정할 수 있도록 초안을 저장합니다. 전체 설정이 검증을 통과한 후에만 적용됩니다.",
    ),
    "routingGroupType": MessageLookupByLibrary.simpleMessage("그룹 유형"),
    "routingMark": MessageLookupByLibrary.simpleMessage("라우팅 마크"),
    "ru": MessageLookupByLibrary.simpleMessage("러시아어"),
    "rule": MessageLookupByLibrary.simpleMessage("규칙"),
    "ruleActionAndDesc": MessageLookupByLibrary.simpleMessage("논리 규칙 AND"),
    "ruleActionDomainDesc": MessageLookupByLibrary.simpleMessage("전체 도메인 일치"),
    "ruleActionDomainKeywordDesc": MessageLookupByLibrary.simpleMessage(
      "도메인 키워드 일치",
    ),
    "ruleActionDomainRegexDesc": MessageLookupByLibrary.simpleMessage(
      "도메인 정규식 일치",
    ),
    "ruleActionDomainSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "도메인 접미사 일치",
    ),
    "ruleActionDomainWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "와일드카드 일치, *와 ?만 지원",
    ),
    "ruleActionDscpDesc": MessageLookupByLibrary.simpleMessage(
      "DSCP 마크 일치(tproxy UDP 인바운드 전용)",
    ),
    "ruleActionDstPortDesc": MessageLookupByLibrary.simpleMessage(
      "목적지 포트 범위 일치",
    ),
    "ruleActionGeoipDesc": MessageLookupByLibrary.simpleMessage("IP의 국가 코드 일치"),
    "ruleActionGeositeDesc": MessageLookupByLibrary.simpleMessage(
      "Geosite의 도메인 일치",
    ),
    "ruleActionInNameDesc": MessageLookupByLibrary.simpleMessage("인바운드 이름 일치"),
    "ruleActionInPortDesc": MessageLookupByLibrary.simpleMessage("인바운드 포트 일치"),
    "ruleActionInTypeDesc": MessageLookupByLibrary.simpleMessage("인바운드 유형 일치"),
    "ruleActionInUserDesc": MessageLookupByLibrary.simpleMessage(
      "인바운드 사용자 이름 일치, 여러 사용자 이름은 /로 구분",
    ),
    "ruleActionIpAsnDesc": MessageLookupByLibrary.simpleMessage("IP의 ASN 일치"),
    "ruleActionIpCidr6Desc": MessageLookupByLibrary.simpleMessage(
      "IP 주소 범위 일치, IP-CIDR6는 별칭일 뿐입니다",
    ),
    "ruleActionIpCidrDesc": MessageLookupByLibrary.simpleMessage("IP 주소 범위 일치"),
    "ruleActionIpSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "IP 접미사 범위 일치",
    ),
    "ruleActionMatchDesc": MessageLookupByLibrary.simpleMessage(
      "모든 요청과 일치, 조건 불필요",
    ),
    "ruleActionNetworkDesc": MessageLookupByLibrary.simpleMessage(
      "TCP 또는 UDP 일치",
    ),
    "ruleActionNotDesc": MessageLookupByLibrary.simpleMessage("논리 규칙 NOT"),
    "ruleActionOrDesc": MessageLookupByLibrary.simpleMessage("논리 규칙 OR"),
    "ruleActionProcessNameDesc": MessageLookupByLibrary.simpleMessage(
      "프로세스 이름으로 일치, Android에서는 패키지 이름과 일치",
    ),
    "ruleActionProcessNameRegexDesc": MessageLookupByLibrary.simpleMessage(
      "프로세스 이름 정규식으로 일치, Android에서는 패키지 이름과 일치",
    ),
    "ruleActionProcessNameWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "프로세스 이름 와일드카드로 일치, *와 ?만 지원",
    ),
    "ruleActionProcessPathDesc": MessageLookupByLibrary.simpleMessage(
      "전체 프로세스 경로로 일치",
    ),
    "ruleActionProcessPathRegexDesc": MessageLookupByLibrary.simpleMessage(
      "프로세스 경로 정규식으로 일치",
    ),
    "ruleActionProcessPathWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "프로세스 경로 와일드카드로 일치, *와 ?만 지원",
    ),
    "ruleActionRematchNameDesc": MessageLookupByLibrary.simpleMessage(
      "리매치 이름 일치, 여러 이름은 /로 구분",
    ),
    "ruleActionRuleSetDesc": MessageLookupByLibrary.simpleMessage(
      "규칙 세트 참조, rule-providers 필요",
    ),
    "ruleActionSrcGeoipDesc": MessageLookupByLibrary.simpleMessage(
      "출발지 IP의 국가 코드 일치",
    ),
    "ruleActionSrcIpAsnDesc": MessageLookupByLibrary.simpleMessage(
      "출발지 IP의 ASN 일치",
    ),
    "ruleActionSrcIpCidrDesc": MessageLookupByLibrary.simpleMessage(
      "출발지 IP 주소 범위 일치",
    ),
    "ruleActionSrcIpSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "출발지 IP 접미사 범위 일치",
    ),
    "ruleActionSrcPortDesc": MessageLookupByLibrary.simpleMessage(
      "출발지 포트 범위 일치",
    ),
    "ruleActionSubRuleDesc": MessageLookupByLibrary.simpleMessage(
      "하위 규칙으로 일치, 괄호에 유의",
    ),
    "ruleActionUidDesc": MessageLookupByLibrary.simpleMessage(
      "Linux 사용자 ID 일치",
    ),
    "ruleEmpty": MessageLookupByLibrary.simpleMessage("규칙이 비어 있습니다"),
    "ruleListInvalid": MessageLookupByLibrary.simpleMessage(
      "규칙은 항목마다 규칙 하나인 YAML 목록이어야 합니다. 예: - DOMAIN,example.com,DIRECT",
    ),
    "ruleName": MessageLookupByLibrary.simpleMessage("규칙 이름"),
    "rulePresetBittorrentDirect": MessageLookupByLibrary.simpleMessage(
      "BitTorrent 직접 연결",
    ),
    "rulePresetBlockDot": MessageLookupByLibrary.simpleMessage(
      "DNS over TLS 차단",
    ),
    "rulePresetBlockLoopback": MessageLookupByLibrary.simpleMessage(
      "프록시 루프백 차단",
    ),
    "rulePresetBlockQuic": MessageLookupByLibrary.simpleMessage("QUIC 차단"),
    "rulePresetBlockStun": MessageLookupByLibrary.simpleMessage("STUN 차단"),
    "rulePresetInsertHint": MessageLookupByLibrary.simpleMessage(
      "선택한 사전 설정을 기존 규칙 앞에 추가합니다. 동일한 규칙은 다시 추가하지 않습니다.",
    ),
    "rulePresetLanDirect": MessageLookupByLibrary.simpleMessage("LAN 직접 연결"),
    "rulePresetSystemServicesDirect": MessageLookupByLibrary.simpleMessage(
      "Apple 및 Microsoft 직접 연결",
    ),
    "ruleProviders": MessageLookupByLibrary.simpleMessage("규칙 공급자"),
    "ruleSetBusyTip": MessageLookupByLibrary.simpleMessage(
      "다른 규칙 세트 작업이 진행 중입니다. 잠시 후 다시 시도하세요",
    ),
    "ruleSetConvert": MessageLookupByLibrary.simpleMessage("MRS로 변환"),
    "ruleSetConvertRemote": MessageLookupByLibrary.simpleMessage(
      "로컬 MRS로 다운로드",
    ),
    "ruleSetDetect": MessageLookupByLibrary.simpleMessage("형식 및 규칙 유형 자동 감지"),
    "ruleSetEmptyTip": MessageLookupByLibrary.simpleMessage(
      "규칙 세트에 사용 가능한 항목이 없습니다",
    ),
    "ruleSetInvalidTip": MessageLookupByLibrary.simpleMessage(
      "규칙 세트를 읽을 수 없습니다. 형식과 항목을 확인하세요",
    ),
    "ruleSetMixedTip": MessageLookupByLibrary.simpleMessage(
      "도메인과 IP 대역이 혼합되어 있습니다. 함께 사용하려면 classical 규칙을 사용하세요",
    ),
    "ruleSetNeedsConversionTip": MessageLookupByLibrary.simpleMessage(
      "이 원격 규칙 세트는 정규화가 필요합니다. 로컬 MRS로 다운로드하여 사용하세요",
    ),
    "ruleSetSizeTip": MessageLookupByLibrary.simpleMessage(
      "규칙 세트가 처리 한도를 초과했습니다. 더 작은 세트로 나누세요",
    ),
    "ruleSetUnsupportedTip": MessageLookupByLibrary.simpleMessage(
      "이 규칙은 기존 동작을 유지하면서 MRS로 변환할 수 없습니다",
    ),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("규칙 대상"),
    "rules": MessageLookupByLibrary.simpleMessage("규칙"),
    "rulesCount": m100,
    "rulesRequireRuleMode": MessageLookupByLibrary.simpleMessage(
      "개인 라우팅 규칙은 규칙 모드에서 적용됩니다.",
    ),
    "runTime": MessageLookupByLibrary.simpleMessage("가동 시간"),
    "running": MessageLookupByLibrary.simpleMessage("실행 중"),
    "runtimeConfig": MessageLookupByLibrary.simpleMessage("런타임 구성"),
    "safeMode": MessageLookupByLibrary.simpleMessage("안전 모드"),
    "safeModeAppTitle": m101,
    "saturation": MessageLookupByLibrary.simpleMessage("채도"),
    "save": MessageLookupByLibrary.simpleMessage("저장"),
    "saveAndRetry": MessageLookupByLibrary.simpleMessage("저장 후 다시 시도"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("변경 사항을 저장하시겠습니까?"),
    "saveRoutingDraft": MessageLookupByLibrary.simpleMessage("초안 저장"),
    "scanOrTransferPay": MessageLookupByLibrary.simpleMessage("스캔 / 이체 결제"),
    "scanToPayNotice": MessageLookupByLibrary.simpleMessage(
      "Alipay / WeChat으로 스캔하여 결제하세요",
    ),
    "script": MessageLookupByLibrary.simpleMessage("스크립트"),
    "scriptChanged": MessageLookupByLibrary.simpleMessage(
      "스크립트가 변경되거나 삭제되었습니다. 다시 열어 시도하세요.",
    ),
    "scriptChanges": MessageLookupByLibrary.simpleMessage("스크립트 변경 사항"),
    "scriptChangesAdded": m102,
    "scriptChangesDescription": MessageLookupByLibrary.simpleMessage(
      "스크립트가 추가, 수정 또는 삭제한 최상위 설정 항목입니다. 전체 설정에는 앱 설정도 포함됩니다.",
    ),
    "scriptChangesEmpty": MessageLookupByLibrary.simpleMessage(
      "스크립트가 설정을 변경하지 않았습니다",
    ),
    "scriptChangesModified": m103,
    "scriptChangesRemoved": m104,
    "scriptFullConfig": MessageLookupByLibrary.simpleMessage("전체 설정"),
    "scriptModeDesc": MessageLookupByLibrary.simpleMessage(
      "스크립트 모드: 확장 스크립트로 설정을 한 번에 덮어씁니다",
    ),
    "scriptOptions": MessageLookupByLibrary.simpleMessage("스크립트 옵션"),
    "scriptOptionsEmpty": MessageLookupByLibrary.simpleMessage(
      "이 스크립트에는 설정 가능한 스위치가 없습니다",
    ),
    "search": MessageLookupByLibrary.simpleMessage("검색"),
    "seconds": MessageLookupByLibrary.simpleMessage("초"),
    "secondsCount": m105,
    "secretKey": MessageLookupByLibrary.simpleMessage("키"),
    "sectionsInEffect": m106,
    "selectAll": MessageLookupByLibrary.simpleMessage("모두 선택"),
    "selectBackup": MessageLookupByLibrary.simpleMessage("백업 선택"),
    "selectUpgradeTarget": MessageLookupByLibrary.simpleMessage("업그레이드 대상 선택"),
    "selected": MessageLookupByLibrary.simpleMessage("선택됨"),
    "sendCode": MessageLookupByLibrary.simpleMessage("코드 전송"),
    "sendResetEmail": MessageLookupByLibrary.simpleMessage("재설정 이메일 전송"),
    "server": MessageLookupByLibrary.simpleMessage("서버"),
    "serviceCheckFailed": MessageLookupByLibrary.simpleMessage("서비스 확인 실패"),
    "serviceFailed": MessageLookupByLibrary.simpleMessage("확인 실패"),
    "settingEntries": MessageLookupByLibrary.simpleMessage("설정"),
    "settings": MessageLookupByLibrary.simpleMessage("설정"),
    "settingsCount": m107,
    "shareLinkNodesAdded": m108,
    "shareLinksNotRead": m109,
    "show": MessageLookupByLibrary.simpleMessage("표시"),
    "showLess": MessageLookupByLibrary.simpleMessage("접기"),
    "showMore": MessageLookupByLibrary.simpleMessage("펼치기"),
    "showNotificationStopAction": MessageLookupByLibrary.simpleMessage(
      "알림에 중지 버튼 표시",
    ),
    "showPassword": MessageLookupByLibrary.simpleMessage("비밀번호 표시"),
    "sidebarBlur": MessageLookupByLibrary.simpleMessage("사이드바 흐림 효과"),
    "sidebarBlurDesc": MessageLookupByLibrary.simpleMessage(
      "사이드바 뒤에 반투명 시스템 배경을 표시합니다",
    ),
    "signInWithGoogle": MessageLookupByLibrary.simpleMessage("Google로 로그인"),
    "silentLaunch": MessageLookupByLibrary.simpleMessage("백그라운드 실행"),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage("백그라운드에서 시작"),
    "singleAdd": MessageLookupByLibrary.simpleMessage("개별 추가"),
    "singleValueTip": m110,
    "size": MessageLookupByLibrary.simpleMessage("크기"),
    "skipCertVerify": MessageLookupByLibrary.simpleMessage("인증서 검증 건너뛰기"),
    "skipDomain": MessageLookupByLibrary.simpleMessage("건너뛸 도메인"),
    "skipDomainDesc": MessageLookupByLibrary.simpleMessage(
      "건너뛸 도메인 목록에 있는 스니핑된 도메인은 사용하지 않습니다.",
    ),
    "skipDstAddress": MessageLookupByLibrary.simpleMessage("건너뛸 목적지 주소"),
    "skipSrcAddress": MessageLookupByLibrary.simpleMessage("건너뛸 출발지 주소"),
    "slide": MessageLookupByLibrary.simpleMessage("슬라이드"),
    "sliders": MessageLookupByLibrary.simpleMessage("슬라이더"),
    "sniffProtocols": MessageLookupByLibrary.simpleMessage("프로토콜"),
    "sniffer": MessageLookupByLibrary.simpleMessage("스니퍼"),
    "snifferStatusDesc": MessageLookupByLibrary.simpleMessage(
      "스니퍼는 TLS, HTTP, QUIC 트래픽에서 도메인을 읽어 규칙이 일치할 수 있게 합니다.",
    ),
    "socksPort": MessageLookupByLibrary.simpleMessage("SOCKS 포트"),
    "softStyle": MessageLookupByLibrary.simpleMessage("부드러움"),
    "soldOut": MessageLookupByLibrary.simpleMessage("품절"),
    "sort": MessageLookupByLibrary.simpleMessage("정렬"),
    "source": MessageLookupByLibrary.simpleMessage("소스"),
    "sourceIp": MessageLookupByLibrary.simpleMessage("출발지 IP"),
    "specialProxy": MessageLookupByLibrary.simpleMessage("특수 프록시"),
    "specialRules": MessageLookupByLibrary.simpleMessage("특수 규칙"),
    "spectrum": MessageLookupByLibrary.simpleMessage("스펙트럼"),
    "speedStatistics": MessageLookupByLibrary.simpleMessage("속도 통계"),
    "ssidPermissionGuide": MessageLookupByLibrary.simpleMessage(
      "Wi-Fi 이름을 읽으려면 위치 접근을 허용하세요. Android에서는 정확한 위치를 항상 허용하고 시스템 위치 서비스를 켜세요.",
    ),
    "ssidPermissionMacosGuide": MessageLookupByLibrary.simpleMessage(
      "Wi-Fi 이름을 읽으려면 시스템 설정에서 이 앱의 위치 서비스 사용을 허용하세요.",
    ),
    "ssidsEmpty": MessageLookupByLibrary.simpleMessage("SSID가 비어 있습니다"),
    "stackMode": MessageLookupByLibrary.simpleMessage("스택 모드"),
    "stackTrace": MessageLookupByLibrary.simpleMessage("스택 트레이스"),
    "standard": MessageLookupByLibrary.simpleMessage("표준"),
    "standardModeDesc": MessageLookupByLibrary.simpleMessage(
      "표준 모드: 기본 설정을 덮어쓰고 간단한 규칙 추가 기능을 제공합니다",
    ),
    "start": MessageLookupByLibrary.simpleMessage("시작"),
    "startCorePromptContent": MessageLookupByLibrary.simpleMessage(
      "프로필을 가져왔습니다. 지금 코어를 시작하시겠습니까?",
    ),
    "startCorePromptTitle": MessageLookupByLibrary.simpleMessage("안내"),
    "startFromScratch": MessageLookupByLibrary.simpleMessage("처음부터 시작"),
    "startSuccess": MessageLookupByLibrary.simpleMessage("시작했습니다"),
    "startVpn": MessageLookupByLibrary.simpleMessage("VPN 시작 중…"),
    "startupAndBackground": MessageLookupByLibrary.simpleMessage("시작 및 백그라운드"),
    "startupDiagnostics": MessageLookupByLibrary.simpleMessage("시작 진단"),
    "startupRecoveryTip": MessageLookupByLibrary.simpleMessage(
      "이전 시작이 완료되지 않았습니다. 이번 실행에서는 자동 설정 적용과 VPN 시작을 일시 중지합니다. 선택한 프로필과 설정은 변경되지 않습니다. 설정을 확인하고 시작을 눌러 다시 시도하세요. 이미 실행 중인 VPN은 연결을 유지합니다.",
    ),
    "startupRecoveryTitle": MessageLookupByLibrary.simpleMessage("시작 복구"),
    "startupTimeoutTip": MessageLookupByLibrary.simpleMessage(
      "시작 시간이 초과되었습니다. 앱을 종료한 후 다시 여세요. 문제가 계속되면 아래 진단 정보를 복사하세요.",
    ),
    "status": MessageLookupByLibrary.simpleMessage("상태"),
    "statusDesc": MessageLookupByLibrary.simpleMessage(
      "DNS를 끄면 시스템 DNS를 사용합니다.",
    ),
    "stop": MessageLookupByLibrary.simpleMessage("중지"),
    "stopVpn": MessageLookupByLibrary.simpleMessage("VPN 중지 중…"),
    "store": MessageLookupByLibrary.simpleMessage("스토어"),
    "storeOutcomeUnknown": MessageLookupByLibrary.simpleMessage(
      "요청이 이미 처리되었을 수 있습니다. 다시 시도하기 전에 구매한 요금제를 확인하세요.",
    ),
    "storeSubtitle": MessageLookupByLibrary.simpleMessage("요금제 구매, 갱신 및 업그레이드"),
    "strategy": MessageLookupByLibrary.simpleMessage("전략"),
    "strictRoute": MessageLookupByLibrary.simpleMessage("엄격한 라우팅"),
    "strictRouteDesc": MessageLookupByLibrary.simpleMessage(
      "엄격한 라우팅은 DNS 등의 트래픽이 TUN을 우회하지 못하게 하며, IPv6가 꺼져 있으면 이 기기의 IPv6 연결을 차단합니다.",
    ),
    "style": MessageLookupByLibrary.simpleMessage("스타일"),
    "subRule": MessageLookupByLibrary.simpleMessage("하위 규칙"),
    "submit": MessageLookupByLibrary.simpleMessage("제출"),
    "subscriptionInfo": MessageLookupByLibrary.simpleMessage("구독 정보"),
    "suspendOnIdle": MessageLookupByLibrary.simpleMessage("유휴 상태에서 프록시 일시 중지"),
    "suspendOnIdleDesc": MessageLookupByLibrary.simpleMessage(
      "화면이 꺼지고 시스템이 유휴 상태일 때 트래픽 전달과 상태 확인을 중지합니다. 통화와 실시간 오디오가 끊기거나 푸시 알림이 지연될 수 있습니다",
    ),
    "suspended": MessageLookupByLibrary.simpleMessage("일시 중지됨…"),
    "switchProfile": MessageLookupByLibrary.simpleMessage("프로필 전환"),
    "sync": MessageLookupByLibrary.simpleMessage("동기화"),
    "system": MessageLookupByLibrary.simpleMessage("시스템"),
    "systemApp": MessageLookupByLibrary.simpleMessage("시스템 앱"),
    "systemProxy": MessageLookupByLibrary.simpleMessage("시스템 프록시"),
    "systemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "HTTP 프록시를 VpnService에 연결",
    ),
    "tab": MessageLookupByLibrary.simpleMessage("탭"),
    "tabAnimation": MessageLookupByLibrary.simpleMessage("탭 애니메이션"),
    "tailscaleAccount": MessageLookupByLibrary.simpleMessage("계정"),
    "tailscaleAddNetwork": MessageLookupByLibrary.simpleMessage("네트워크 추가"),
    "tailscaleAdvanced": MessageLookupByLibrary.simpleMessage("고급"),
    "tailscaleAuthKey": MessageLookupByLibrary.simpleMessage("인증 키"),
    "tailscaleAuthKeyInvalid": MessageLookupByLibrary.simpleMessage(
      "인증 키 형식이 올바르지 않은 것 같습니다",
    ),
    "tailscaleAuthKeySaved": MessageLookupByLibrary.simpleMessage(
      "이 기기에 인증 키가 저장되어 있습니다. 바꾸려면 새 키를 입력하세요.",
    ),
    "tailscaleAutoRoute": MessageLookupByLibrary.simpleMessage("자동 라우팅"),
    "tailscaleAutoRouteDesc": MessageLookupByLibrary.simpleMessage(
      "피어 주소, MagicDNS 이름 및 승인된 서브넷의 트래픽을 이 네트워크로 전달합니다",
    ),
    "tailscaleAvailableExitNodes": MessageLookupByLibrary.simpleMessage(
      "사용 가능한 출구 노드",
    ),
    "tailscaleCheckSettings": m111,
    "tailscaleConnected": MessageLookupByLibrary.simpleMessage("연결됨"),
    "tailscaleConnecting": MessageLookupByLibrary.simpleMessage("연결 중"),
    "tailscaleControlUrl": MessageLookupByLibrary.simpleMessage("제어 서버 URL"),
    "tailscaleCredentialsFooter": MessageLookupByLibrary.simpleMessage(
      "인증 정보와 기기 ID는 이 기기에만 보관됩니다.",
    ),
    "tailscaleDeviceName": MessageLookupByLibrary.simpleMessage("기기 이름"),
    "tailscaleDevices": m112,
    "tailscaleDirect": MessageLookupByLibrary.simpleMessage("직접 연결"),
    "tailscaleEmptyDesc": MessageLookupByLibrary.simpleMessage(
      "네트워크를 추가하고 이 기기에서 로그인한 후 프록시를 시작하면 다른 기기에 접근할 수 있습니다.",
    ),
    "tailscaleEmptyTitle": MessageLookupByLibrary.simpleMessage("tailnet에 접근"),
    "tailscaleEnterAuthKey": MessageLookupByLibrary.simpleMessage(
      "이 기기에서 로그인하려면 인증 키를 입력하세요.",
    ),
    "tailscaleEntryHint": MessageLookupByLibrary.simpleMessage(
      "tailnet의 기기에 접근",
    ),
    "tailscaleExitNode": MessageLookupByLibrary.simpleMessage("출구 노드"),
    "tailscaleExitNodeActive": MessageLookupByLibrary.simpleMessage(
      "사용 중인 출구 노드",
    ),
    "tailscaleExitNodeAllowLan": MessageLookupByLibrary.simpleMessage(
      "로컬 네트워크 접근 허용",
    ),
    "tailscaleExitNodeDesc": MessageLookupByLibrary.simpleMessage(
      "사용하지 않으려면 비워 두세요. auto, 피어 이름 또는 피어 IP 주소를 입력할 수 있습니다.",
    ),
    "tailscaleGuide": MessageLookupByLibrary.simpleMessage("가이드"),
    "tailscaleGuideDevices": MessageLookupByLibrary.simpleMessage(
      "기기 및 MagicDNS",
    ),
    "tailscaleGuideDevicesBody": MessageLookupByLibrary.simpleMessage(
      "자동 라우팅은 알려진 피어의 주소와 MagicDNS 이름, tailnet에서 승인된 서브넷을 이 네트워크로 전달합니다. 나머지 트래픽은 기존 규칙을 따릅니다.\n추가 규칙과 사용자 지정 규칙 뒤, 프로필 자체 규칙 앞에서 적용됩니다.\n사용자 지정 제어 서버 도메인을 사용하는 경우 알려진 기기 이름만 라우팅하므로 해당 도메인의 공개 사이트는 계속 접근할 수 있습니다.\n현재 연결된 로컬 네트워크 안의 서브넷 주소는 로컬에 남습니다. 같은 주소를 쓰는 원격 서브넷에 접근하려면 이 네트워크를 가리키는 규칙을 추가하세요.\n승인된 서브넷으로 해석되는 호스트 이름도 이 네트워크를 통과합니다. 프로필이 해당 이름을 프록시로 바로 전달한다면 이 네트워크를 가리키는 도메인 규칙을 추가하세요.",
    ),
    "tailscaleGuideExitNodes": MessageLookupByLibrary.simpleMessage("출구 노드"),
    "tailscaleGuideExitNodesBody": MessageLookupByLibrary.simpleMessage(
      "출구 노드를 지정하면 프로필의 선택 그룹에 네트워크가 나타납니다. 해당 그룹에서 네트워크를 선택하거나 규칙의 대상으로 지정한 후에만 트래픽이 출구 노드를 사용합니다.\n출구 노드를 사용하지 않으려면 비워 두세요. auto는 사용 가능한 출구 노드를 선택하며, 기기 이름이나 주소를 입력하면 해당 기기를 선택합니다.",
    ),
    "tailscaleGuideGetStarted": MessageLookupByLibrary.simpleMessage("시작하기"),
    "tailscaleGuideGetStartedBody": MessageLookupByLibrary.simpleMessage(
      "네트워크를 추가하고 \'저장 후 로그인\'을 선택하세요. 로그인 페이지에서 이 기기를 승인하면 로그인이 자동으로 완료됩니다.\n인증 키로 로그인하려면 \'인증 키\'를 선택하고 키를 입력하세요. 브라우저가 필요하지 않습니다.\n프록시가 실행 중일 때만 네트워크가 트래픽을 전달합니다. 로그인만으로는 트래픽을 라우팅하지 않습니다.",
    ),
    "tailscaleGuideSignIn": MessageLookupByLibrary.simpleMessage("로그인 및 백업"),
    "tailscaleGuideSignInBody": MessageLookupByLibrary.simpleMessage(
      "네트워크 설정은 백업에 포함됩니다. 인증 키와 기기 ID는 이 기기에만 보관되므로 다른 기기에 복원한 후에는 다시 로그인하세요.\n노드 키가 만료되면 \'저장 후 로그인\'을 다시 선택하세요. 기기 승인과 접근 권한은 tailnet에서 관리합니다.\n네트워크를 제거하면 이 기기가 로그아웃되고 기기에 저장된 ID가 삭제됩니다.",
    ),
    "tailscaleGuideTroubleshooting": MessageLookupByLibrary.simpleMessage(
      "문제 해결",
    ),
    "tailscaleGuideTroubleshootingBody": MessageLookupByLibrary.simpleMessage(
      "프록시가 실행 중이고 이 기기가 승인되었으며 피어가 온라인인지 확인하세요. 서브넷이나 인터넷에 접근하려면 경로 승인과 출구 노드도 확인하세요.\n\'적용되지 않음\'은 실행 중인 설정에 네트워크가 없다는 뜻입니다. 프로필을 선택하고 같은 이름의 노드가 없는지 확인하세요.\n이 앱은 tailnet으로 나가는 연결만 만듭니다. 들어오는 연결을 받지 않으며 이 기기를 서브넷 라우터나 출구 노드로 제공하지 않습니다.",
    ),
    "tailscaleHostnameInvalid": MessageLookupByLibrary.simpleMessage(
      "소문자, 숫자 및 하이픈을 사용하여 최대 63자로 입력하세요",
    ),
    "tailscaleInteractiveLogin": MessageLookupByLibrary.simpleMessage("대화형"),
    "tailscaleKeyExpired": MessageLookupByLibrary.simpleMessage(
      "노드 키가 만료되었습니다",
    ),
    "tailscaleLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Tailscale 로그인 실패",
    ),
    "tailscaleLoginFooter": MessageLookupByLibrary.simpleMessage(
      "이 기기에서 네트워크마다 한 번씩 로그인하세요.",
    ),
    "tailscaleLoginHint": MessageLookupByLibrary.simpleMessage(
      "로그인하면 이 기기가 승인됩니다. 네트워크를 사용하려면 프록시를 시작하세요.",
    ),
    "tailscaleLoginMethod": MessageLookupByLibrary.simpleMessage("로그인 방식"),
    "tailscaleLoginTimeout": MessageLookupByLibrary.simpleMessage(
      "5분 내에 로그인을 완료하지 못했습니다. 다시 시도하세요.",
    ),
    "tailscaleLoginWaiting": MessageLookupByLibrary.simpleMessage(
      "로그인 페이지를 열거나 코드를 스캔하세요. 승인 후 로그인이 자동으로 완료됩니다.",
    ),
    "tailscaleLogout": MessageLookupByLibrary.simpleMessage("로그아웃"),
    "tailscaleNameInUse": MessageLookupByLibrary.simpleMessage(
      "이미 사용 중인 이름입니다",
    ),
    "tailscaleNameInvalid": MessageLookupByLibrary.simpleMessage(
      "쉼표 없이 최대 64자를 사용하세요",
    ),
    "tailscaleNeedsApproval": MessageLookupByLibrary.simpleMessage(
      "기기 승인 대기 중",
    ),
    "tailscaleNeedsLogin": MessageLookupByLibrary.simpleMessage("로그인 필요"),
    "tailscaleNetworkInUse": m113,
    "tailscaleNetworkName": MessageLookupByLibrary.simpleMessage("네트워크 이름"),
    "tailscaleNetworks": MessageLookupByLibrary.simpleMessage("네트워크"),
    "tailscaleNotApplied": MessageLookupByLibrary.simpleMessage("적용되지 않음"),
    "tailscaleNotAppliedHint": MessageLookupByLibrary.simpleMessage(
      "실행 중인 설정에 이 네트워크가 없습니다. 프로필을 선택하고 같은 이름의 노드가 없는지 확인하세요.",
    ),
    "tailscaleNotSignedIn": MessageLookupByLibrary.simpleMessage("로그인하지 않음"),
    "tailscaleOffline": MessageLookupByLibrary.simpleMessage("오프라인"),
    "tailscaleOnline": MessageLookupByLibrary.simpleMessage("온라인"),
    "tailscaleOpenLoginPage": MessageLookupByLibrary.simpleMessage(
      "로그인 페이지 열기",
    ),
    "tailscaleRelay": m114,
    "tailscaleRemoveConfirm": m115,
    "tailscaleRemoveNetwork": MessageLookupByLibrary.simpleMessage("네트워크 제거"),
    "tailscaleSaveAndLogin": MessageLookupByLibrary.simpleMessage("저장 후 로그인"),
    "tailscaleSignedIn": MessageLookupByLibrary.simpleMessage("로그인됨"),
    "tailscaleSigningIn": MessageLookupByLibrary.simpleMessage("로그인 중"),
    "tailscaleStatus": MessageLookupByLibrary.simpleMessage("상태"),
    "tailscaleStopped": MessageLookupByLibrary.simpleMessage("중지됨"),
    "tailscaleThisDevice": MessageLookupByLibrary.simpleMessage("이 기기"),
    "tailscaleUnavailable": MessageLookupByLibrary.simpleMessage("연결할 수 없음"),
    "tapIconToRetry": MessageLookupByLibrary.simpleMessage("아이콘을 눌러 다시 시도"),
    "tapToAuthorize": MessageLookupByLibrary.simpleMessage("눌러서 허용"),
    "target": MessageLookupByLibrary.simpleMessage("대상"),
    "tcpConcurrent": MessageLookupByLibrary.simpleMessage("TCP 동시 연결"),
    "tcpConcurrentDesc": MessageLookupByLibrary.simpleMessage("TCP 동시 연결 허용"),
    "tcpFastOpen": MessageLookupByLibrary.simpleMessage("TCP Fast Open"),
    "tcpFastOpenDesc": MessageLookupByLibrary.simpleMessage(
      "TCP 연결 설정 속도를 높입니다",
    ),
    "testInterval": MessageLookupByLibrary.simpleMessage("테스트 간격"),
    "testUrl": MessageLookupByLibrary.simpleMessage("테스트 URL"),
    "testWhenUsed": MessageLookupByLibrary.simpleMessage("사용할 때 테스트"),
    "textScale": MessageLookupByLibrary.simpleMessage("글자 크기 조절"),
    "textScalePreview": MessageLookupByLibrary.simpleMessage(
      "앱의 글자가 이렇게 표시됩니다",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("테마"),
    "themeColor": MessageLookupByLibrary.simpleMessage("테마 색상"),
    "themeDesc": MessageLookupByLibrary.simpleMessage("다크 모드 및 색상 설정"),
    "themeMode": MessageLookupByLibrary.simpleMessage("테마 모드"),
    "tight": MessageLookupByLibrary.simpleMessage("좁게"),
    "time": MessageLookupByLibrary.simpleMessage("시간"),
    "timeout": MessageLookupByLibrary.simpleMessage("시간 초과"),
    "tintedStyle": MessageLookupByLibrary.simpleMessage("틴트"),
    "tip": MessageLookupByLibrary.simpleMessage("안내"),
    "todayUsed": MessageLookupByLibrary.simpleMessage("오늘 사용량"),
    "toggle": MessageLookupByLibrary.simpleMessage("전환"),
    "toggleFlashlight": MessageLookupByLibrary.simpleMessage("손전등 켜기/끄기"),
    "tokenLabel": MessageLookupByLibrary.simpleMessage("액세스 토큰"),
    "tokenValidation": MessageLookupByLibrary.simpleMessage("액세스 토큰을 입력하세요"),
    "tolerance": MessageLookupByLibrary.simpleMessage("허용 오차"),
    "tools": MessageLookupByLibrary.simpleMessage("도구"),
    "total": MessageLookupByLibrary.simpleMessage("합계"),
    "totalDownload": MessageLookupByLibrary.simpleMessage("다운로드량"),
    "totalUpload": MessageLookupByLibrary.simpleMessage("업로드량"),
    "tproxyPort": MessageLookupByLibrary.simpleMessage("TProxy 포트"),
    "traffic": MessageLookupByLibrary.simpleMessage("트래픽"),
    "trafficPeak": m116,
    "trafficTotal": m117,
    "trafficUsage": MessageLookupByLibrary.simpleMessage("트래픽 사용량"),
    "transferConfirmNotice": MessageLookupByLibrary.simpleMessage(
      "이체가 완료되면 시스템에서 자동으로 확인하고 선택한 요금제를 활성화합니다.",
    ),
    "transport": MessageLookupByLibrary.simpleMessage("전송"),
    "tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "tunAdminAccountRequired": MessageLookupByLibrary.simpleMessage(
      "이 Mac에서 TUN을 사용하려면 관리자 계정이 필요합니다. 관리자 계정으로 로그인한 후 켜세요.",
    ),
    "tunAuthorizationFailed": MessageLookupByLibrary.simpleMessage(
      "관리자 권한이 거부되어 TUN을 켤 수 없습니다. 시스템 권한 요청을 승인한 후 다시 시도하세요.",
    ),
    "tunDesc": MessageLookupByLibrary.simpleMessage("TUN은 관리자 모드에서만 작동합니다."),
    "tunDnsMode": MessageLookupByLibrary.simpleMessage("시스템 DNS 모드"),
    "tunDnsModeDesc": MessageLookupByLibrary.simpleMessage(
      "비워 두면 기존 동작을 유지합니다. disabled는 시스템 DNS를 변경하지 않고, native는 TUN 주소를 사용합니다. hijack은 다른 인터페이스의 DNS도 가로챕니다(Windows는 strict-route, Linux는 auto-redirect 필요). macOS에서는 명시한 모드가 자동 DNS 설정보다 우선합니다.",
    ),
    "tunHelperInstallFailed": MessageLookupByLibrary.simpleMessage(
      "보조 서비스의 설치 또는 시작에 실패하여 TUN을 켤 수 없습니다. 앱 설치가 완료되었는지, 시스템 서비스가 작동하는지 확인한 후 다시 시도하세요.",
    ),
    "tunMtuDesc": MessageLookupByLibrary.simpleMessage(
      "기본값: 9000, 대안: 1480 또는 4064. 적용하려면 Android VPN을 다시 시작하세요",
    ),
    "tunMtuInvalid": MessageLookupByLibrary.simpleMessage(
      "1280~65535 사이의 정수를 입력하세요",
    ),
    "tunOverrideDesc": MessageLookupByLibrary.simpleMessage(
      "여기에 추가한 항목은 모든 프로필의 TUN 설정을 대체합니다. 추가하지 않은 항목은 프로필 자체 설정을 유지합니다. 사용자 지정 프로필이 직접 추가한 항목이 우선합니다.",
    ),
    "turnOff": MessageLookupByLibrary.simpleMessage("끄기"),
    "turnOn": MessageLookupByLibrary.simpleMessage("켜기"),
    "udpRelayMode": MessageLookupByLibrary.simpleMessage("UDP 릴레이 모드"),
    "udpTimeout": MessageLookupByLibrary.simpleMessage("UDP 시간 제한"),
    "udpTimeoutDesc": MessageLookupByLibrary.simpleMessage(
      "UDP 시간 제한은 초 단위이며 gvisor, system, mixed 스택에서만 작동합니다.",
    ),
    "ultra": MessageLookupByLibrary.simpleMessage("최고"),
    "undo": MessageLookupByLibrary.simpleMessage("실행 취소"),
    "unifiedDelay": MessageLookupByLibrary.simpleMessage("통합 지연"),
    "unifiedDelayDesc": MessageLookupByLibrary.simpleMessage(
      "핸드셰이크 등의 추가 지연 제외",
    ),
    "unknown": MessageLookupByLibrary.simpleMessage("알 수 없음"),
    "unknownNetworkError": MessageLookupByLibrary.simpleMessage(
      "알 수 없는 네트워크 오류",
    ),
    "unmaximize": MessageLookupByLibrary.simpleMessage("이전 크기로 복원"),
    "unnamed": MessageLookupByLibrary.simpleMessage("이름 없음"),
    "unpinWindow": MessageLookupByLibrary.simpleMessage("창 고정 해제"),
    "update": MessageLookupByLibrary.simpleMessage("업데이트"),
    "updateAppImageTip": MessageLookupByLibrary.simpleMessage(
      "AppImage는 자동 설치할 수 없습니다. 실행 중인 프로그램을 다운로드한 파일로 바꾸세요. 파일이 있는 폴더를 열었습니다.",
    ),
    "updateApplyFailed": MessageLookupByLibrary.simpleMessage(
      "자동 업데이트를 완료하지 못했습니다. 다시 시도하거나 다운로드 페이지에서 업데이트하세요.",
    ),
    "updateBuildNumber": m118,
    "updateCancelDownload": MessageLookupByLibrary.simpleMessage("다운로드 취소"),
    "updateDownloadBackground": MessageLookupByLibrary.simpleMessage(
      "백그라운드에서 다운로드",
    ),
    "updateDownloadBrowser": MessageLookupByLibrary.simpleMessage(
      "브라우저에서 다운로드",
    ),
    "updateDownloadConfirm": MessageLookupByLibrary.simpleMessage("업데이트 다운로드"),
    "updateDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "업데이트 다운로드 실패",
    ),
    "updateDownloading": MessageLookupByLibrary.simpleMessage("업데이트 다운로드 중"),
    "updateInstall": MessageLookupByLibrary.simpleMessage("업데이트 설치"),
    "updateLater": MessageLookupByLibrary.simpleMessage("나중에"),
    "updateNotice": MessageLookupByLibrary.simpleMessage("새 버전 감지"),
    "updatePackageFormat": MessageLookupByLibrary.simpleMessage("패키지 형식 선택"),
    "updatePackageFormatTip": MessageLookupByLibrary.simpleMessage(
      "이 버전의 설치 방식을 확인하지 못했습니다. 설치 방식에 맞는 형식을 선택하세요.",
    ),
    "updatePackageManagerTip": MessageLookupByLibrary.simpleMessage(
      "패키지 관리자로 설치한 버전입니다. 설치할 때와 같은 방법으로 업데이트하세요.",
    ),
    "updateReady": MessageLookupByLibrary.simpleMessage("업데이트 설치 준비 완료"),
    "updateReadyHint": MessageLookupByLibrary.simpleMessage(
      "업데이트를 다운로드했습니다. 편할 때 설치하세요.",
    ),
    "updateReleaseNotes": MessageLookupByLibrary.simpleMessage("릴리스 노트"),
    "updateReleaseNotesFailed": MessageLookupByLibrary.simpleMessage(
      "릴리스 노트를 불러오지 못했습니다. 다시 시도하세요.",
    ),
    "updateRestart": MessageLookupByLibrary.simpleMessage("업데이트 후 다시 시작"),
    "updateRestartHint": MessageLookupByLibrary.simpleMessage(
      "앱이 닫힌 뒤 현재 위치에서 업데이트되고 다시 열립니다. 설정은 유지됩니다.",
    ),
    "updateVersionNumber": m119,
    "upgradePlan": MessageLookupByLibrary.simpleMessage("요금제 업그레이드"),
    "upload": MessageLookupByLibrary.simpleMessage("업로드"),
    "uploadBandwidth": MessageLookupByLibrary.simpleMessage("업로드 대역폭"),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage("URL로 프로필 가져오기"),
    "urlTip": m120,
    "useHosts": MessageLookupByLibrary.simpleMessage("hosts 사용"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage("시스템 hosts 사용"),
    "usedShort": MessageLookupByLibrary.simpleMessage("사용"),
    "usedTrafficLabel": MessageLookupByLibrary.simpleMessage("사용한 트래픽"),
    "userAgent": MessageLookupByLibrary.simpleMessage("User-Agent"),
    "userCenter": MessageLookupByLibrary.simpleMessage("사용자 센터"),
    "userCenterFallback": MessageLookupByLibrary.simpleMessage("사용자 센터(보조)"),
    "userGuide": MessageLookupByLibrary.simpleMessage("사용자 가이드"),
    "username": MessageLookupByLibrary.simpleMessage("사용자 이름"),
    "value": MessageLookupByLibrary.simpleMessage("값"),
    "verifyCoupon": MessageLookupByLibrary.simpleMessage("확인"),
    "view": MessageLookupByLibrary.simpleMessage("보기"),
    "virtualIpv4": MessageLookupByLibrary.simpleMessage("가상 IPv4"),
    "vividStyle": MessageLookupByLibrary.simpleMessage("선명"),
    "vpnConfigChangeDetected": MessageLookupByLibrary.simpleMessage(
      "VPN 설정 변경 감지",
    ),
    "vpnEnableDesc": MessageLookupByLibrary.simpleMessage(
      "VPN은 VpnService를 통해 모든 시스템 트래픽을 자동으로 라우팅합니다.",
    ),
    "vpnTip": MessageLookupByLibrary.simpleMessage("VPN을 다시 시작하면 변경 사항이 적용됩니다"),
    "webDAVConfiguration": MessageLookupByLibrary.simpleMessage("WebDAV 구성"),
    "whitelistMode": MessageLookupByLibrary.simpleMessage("화이트리스트 모드"),
    "writeToSystem": MessageLookupByLibrary.simpleMessage("시스템에 기록"),
    "writeToSystemDesc": MessageLookupByLibrary.simpleMessage(
      "시스템에 기록하면 시스템 시계도 설정합니다. Android에서는 무시됩니다.",
    ),
    "yearsAgo": m121,
    "yearsAgoShort": m122,
    "yes": MessageLookupByLibrary.simpleMessage("예"),
    "zh_CN": MessageLookupByLibrary.simpleMessage("중국어 간체"),
  };
}

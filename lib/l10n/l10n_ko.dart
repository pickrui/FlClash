// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get applyNow => '지금 적용';

  @override
  String get rule => '규칙';

  @override
  String get global => '전역';

  @override
  String get direct => '직접';

  @override
  String get dashboard => '대시보드';

  @override
  String get proxies => '프록시';

  @override
  String get profile => '프로필';

  @override
  String get profiles => '프로필';

  @override
  String get tools => '도구';

  @override
  String get logs => '로그';

  @override
  String get logsDesc => '로그 기록';

  @override
  String get resources => '리소스';

  @override
  String get resourcesDesc => '외부 리소스 정보';

  @override
  String get trafficUsage => '트래픽 사용량';

  @override
  String get networkSpeed => '네트워크 속도';

  @override
  String get outboundMode => '아웃바운드 모드';

  @override
  String get networkDetection => '네트워크 진단';

  @override
  String get upload => '업로드';

  @override
  String get download => '다운로드';

  @override
  String get noProxy => '프록시 없음';

  @override
  String get nullProfileDesc => '프로필이 없습니다. 프로필을 추가하세요';

  @override
  String get settings => '설정';

  @override
  String get language => '언어';

  @override
  String get defaultText => '기본값';

  @override
  String get more => '더 보기';

  @override
  String get other => '기타';

  @override
  String get about => '정보';

  @override
  String get en => '영어';

  @override
  String get ja => '일본어';

  @override
  String get ru => '러시아어';

  @override
  String get fr => '프랑스어';

  @override
  String get es => '스페인어';

  @override
  String get ko => '한국어';

  @override
  String get zh_CN => '중국어 간체';

  @override
  String get theme => '테마';

  @override
  String get themeDesc => '다크 모드 및 색상 설정';

  @override
  String get overrideLabel => '덮어쓰기';

  @override
  String get allowLan => 'LAN 허용';

  @override
  String get tun => 'TUN';

  @override
  String get tunDesc => 'TUN은 관리자 모드에서만 작동합니다.';

  @override
  String get minimizeOnExit => '종료 시 최소화';

  @override
  String get autoLaunch => '자동 실행';

  @override
  String get silentLaunch => '백그라운드 실행';

  @override
  String get silentLaunchDesc => '백그라운드에서 시작';

  @override
  String get autoRun => '자동 시작';

  @override
  String get autoRunDesc => '앱을 열 때 자동 실행';

  @override
  String get logcat => 'Logcat';

  @override
  String get logcatDesc => '끄면 로그 항목이 숨겨집니다';

  @override
  String get accessControl => '접근 제어';

  @override
  String get accessControlDesc => '앱의 프록시 접근 설정';

  @override
  String get application => '애플리케이션';

  @override
  String get edit => '편집';

  @override
  String get confirm => '확인';

  @override
  String get update => '업데이트';

  @override
  String get add => '추가';

  @override
  String get save => '저장';

  @override
  String get delete => '삭제';

  @override
  String get hours => '시간';

  @override
  String get seconds => '초';

  @override
  String get qrcode => 'QR 코드';

  @override
  String get qrcodeDesc => 'QR 코드를 스캔하여 프로필 가져오기';

  @override
  String get url => 'URL';

  @override
  String get file => '파일';

  @override
  String get name => '이름';

  @override
  String get profileNameNullValidationDesc => '프로필 이름을 입력하세요';

  @override
  String get profileUrlNullValidationDesc => '프로필 URL을 입력하세요';

  @override
  String get profileUrlInvalidValidationDesc => '올바른 프로필 URL을 입력하세요';

  @override
  String get autoUpdate => '자동 업데이트';

  @override
  String get autoUpdateInterval => '자동 업데이트 간격';

  @override
  String get profileAutoUpdateIntervalNullValidationDesc => '자동 업데이트 간격을 입력하세요';

  @override
  String get profileAutoUpdateIntervalInvalidValidationDesc => '올바른 간격을 입력하세요';

  @override
  String get themeMode => '테마 모드';

  @override
  String get themeColor => '테마 색상';

  @override
  String get preview => '미리보기';

  @override
  String get auto => '자동';

  @override
  String get light => '라이트';

  @override
  String get dark => '다크';

  @override
  String get submit => '제출';

  @override
  String createProfileFromUrlTip(Object url) {
    return '$url에서 프로필을 만드시겠습니까?';
  }

  @override
  String get create => '만들기';

  @override
  String get pleaseUploadValidQrcode => '올바른 QR 코드를 업로드하세요';

  @override
  String get blacklistMode => '블랙리스트 모드';

  @override
  String get whitelistMode => '화이트리스트 모드';

  @override
  String get selectAll => '모두 선택';

  @override
  String get cancelSelectAll => '모두 선택 해제';

  @override
  String get appAccessControl => '앱 접근 제어';

  @override
  String get accessControlAllowDesc => '선택한 앱만 VPN을 거칩니다';

  @override
  String get accessControlNotAllowDesc => '선택한 앱은 VPN에서 제외됩니다';

  @override
  String get accessControlDisabledDesc => '앱 접근 제어가 꺼져 있습니다';

  @override
  String accessControlSelectedCount(num count) {
    return '$count개 선택됨';
  }

  @override
  String get profileParseErrorDesc => '프로필 구문 분석 오류';

  @override
  String get proxyPort => '프록시 포트';

  @override
  String get port => '포트';

  @override
  String get logLevel => '로그 수준';

  @override
  String get show => '표시';

  @override
  String get hide => '숨기기';

  @override
  String get exit => '종료';

  @override
  String get systemProxy => '시스템 프록시';

  @override
  String get custom => '사용자 지정';

  @override
  String get project => '프로젝트';

  @override
  String get core => '코어';

  @override
  String get reverseEngineeringNotice =>
      '이 애플리케이션의 리버스 엔지니어링, 디컴파일, 디스어셈블 및 AI를 이용한 분석은 엄격히 금지됩니다.';

  @override
  String get tabAnimation => '탭 애니메이션';

  @override
  String get desc =>
      'ClashMeta 기반의 멀티 플랫폼 프록시 클라이언트로, 간편하게 사용할 수 있으며 오픈 소스이고 광고가 없습니다.';

  @override
  String get startVpn => 'VPN 시작 중…';

  @override
  String get stopVpn => 'VPN 중지 중…';

  @override
  String get discovery => '새 버전 발견';

  @override
  String get compatible => '호환 모드';

  @override
  String get notSelectedTip => '현재 프록시 그룹은 선택할 수 없습니다';

  @override
  String get tip => '안내';

  @override
  String get account => '계정';

  @override
  String get backup => '백업';

  @override
  String get backupSuccess => '백업 성공';

  @override
  String get noInfo => '정보 없음';

  @override
  String get pleaseBindWebDAV => 'WebDAV를 연결하세요';

  @override
  String get bind => '연결';

  @override
  String get connectivity => '연결 상태: ';

  @override
  String get webDAVConfiguration => 'WebDAV 구성';

  @override
  String get address => '주소';

  @override
  String get addressHelp => 'WebDAV 서버 주소';

  @override
  String get addressTip => '올바른 WebDAV 주소를 입력하세요';

  @override
  String get password => '비밀번호';

  @override
  String get checkUpdate => '업데이트 확인';

  @override
  String get checkUpdateError => '이미 최신 버전입니다';

  @override
  String get checkUpdateFailed => '업데이트를 확인하지 못했습니다. 네트워크를 확인한 후 다시 시도하세요';

  @override
  String get unknown => '알 수 없음';

  @override
  String get search => '검색';

  @override
  String get allowBypass => '앱의 VPN 우회 허용';

  @override
  String get externalController => '외부 컨트롤러';

  @override
  String get externalControllerDesc => '외부 컨트롤러를 통해 설정된 주소에서 코어를 제어할 수 있습니다';

  @override
  String get openDashboard => '대시보드 열기';

  @override
  String get ipv6Desc => 'IPv6 트래픽은 IPv6가 켜져 있을 때만 수신됩니다.';

  @override
  String get autoIpv6 => '자동 IPv6';

  @override
  String get autoIpv6Desc => '로컬 네트워크의 지원 여부에 따라 IPv6를 자동으로 켜거나 끕니다';

  @override
  String get app => '앱';

  @override
  String get unifiedDelay => '통합 지연';

  @override
  String get tcpConcurrent => 'TCP 동시 연결';

  @override
  String get geodataLoader => 'Geo 저메모리 모드';

  @override
  String get requests => '요청';

  @override
  String get requestsDesc => '최근 요청과 활성 연결 보기';

  @override
  String get findProcessMode => '프로세스 찾기';

  @override
  String get init => '초기화';

  @override
  String get infiniteTime => '무기한';

  @override
  String get connections => '연결';

  @override
  String get intranetIP => '내부망 IP';

  @override
  String get view => '보기';

  @override
  String get cut => '잘라내기';

  @override
  String get copy => '복사';

  @override
  String get paste => '붙여넣기';

  @override
  String get userAgent => 'User-Agent';

  @override
  String get testUrl => '테스트 URL';

  @override
  String get delayTestTimeout => '지연 테스트 시간 제한';

  @override
  String get sync => '동기화';

  @override
  String get exclude => '최근 작업에서 숨기기';

  @override
  String get compact => '간결하게';

  @override
  String get filter => '필터';

  @override
  String get tab => '탭';

  @override
  String get list => '목록';

  @override
  String get delay => '지연';

  @override
  String get style => '스타일';

  @override
  String get size => '크기';

  @override
  String get sort => '정렬';

  @override
  String get columns => '열';

  @override
  String get proxyGroup => '프록시 그룹';

  @override
  String get go => '이동';

  @override
  String get externalLink => '외부 링크';

  @override
  String get autoCloseConnections => '연결 자동 종료';

  @override
  String get autoCloseConnectionsDesc =>
      '노드 변경 후 모든 연결을 종료하거나 변경한 프록시 그룹을 통과하는 연결만 종료합니다(중첩 그룹 포함)';

  @override
  String get connectionCloseScope => '연결 종료 범위';

  @override
  String get closeCurrentGroupConnections => '현재 프록시 그룹만';

  @override
  String get onlyStatisticsProxy => '프록시 트래픽만 집계';

  @override
  String get pureBlackMode => '퓨어 블랙 모드';

  @override
  String get keepAliveIntervalDesc => 'TCP 킵얼라이브 간격';

  @override
  String get entries => '개 항목';

  @override
  String secondsCount(Object count) {
    return '$count초';
  }

  @override
  String itemsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '항목 $count개',
    );
    return '$_temp0';
  }

  @override
  String get geoAutoUpdate => '자동 업데이트';

  @override
  String get geoAutoUpdateInterval => '자동 업데이트 간격';

  @override
  String get geoAutoUpdateIntervalTip => '자동 업데이트 간격은 1~8760시간이어야 합니다';

  @override
  String get geoResources => 'Geo 리소스';

  @override
  String geoUpdating(Object name) {
    return '$name 업데이트 중…';
  }

  @override
  String geoSkipped(Object name) {
    return '$name 건너뜀';
  }

  @override
  String geoUpdated(Object name) {
    return '$name: 업데이트됨';
  }

  @override
  String get local => '로컬';

  @override
  String get remote => '원격';

  @override
  String get remoteBackupDesc => '로컬 데이터를 WebDAV에 백업';

  @override
  String get localBackupDesc => '로컬 데이터를 이 기기에 백업';

  @override
  String get mode => '모드';

  @override
  String get time => '시간';

  @override
  String get source => '소스';

  @override
  String get action => '동작';

  @override
  String get intelligentSelected => '스마트 선택';

  @override
  String get clipboardNoPackageNames => '클립보드에 유효한 패키지 이름이 없습니다';

  @override
  String get clipboardImport => '클립보드에서 가져오기';

  @override
  String get clipboardExport => '클립보드로 내보내기';

  @override
  String get layout => '레이아웃';

  @override
  String get tight => '좁게';

  @override
  String get standard => '표준';

  @override
  String get loose => '넓게';

  @override
  String get profilesSort => '프로필 정렬';

  @override
  String get start => '시작';

  @override
  String get stop => '중지';

  @override
  String get key => '키';

  @override
  String get value => '값';

  @override
  String get vpnTip => 'VPN을 다시 시작하면 변경 사항이 적용됩니다';

  @override
  String get vpnEnableDesc => 'VPN은 VpnService를 통해 모든 시스템 트래픽을 자동으로 라우팅합니다.';

  @override
  String get options => '옵션';

  @override
  String get loopback => 'UWP 루프백 예외';

  @override
  String get providers => '공급자';

  @override
  String get proxyProviders => '프록시 공급자';

  @override
  String get ruleProviders => '규칙 공급자';

  @override
  String get status => '상태';

  @override
  String get statusDesc => 'DNS를 끄면 시스템 DNS를 사용합니다.';

  @override
  String get preferH3Desc => 'DoH 서버에 HTTP/3을 우선 시도합니다';

  @override
  String get respectRules => '규칙 준수';

  @override
  String get respectRulesDesc => 'DNS 연결에 규칙을 적용합니다. 프록시 노드용 DNS 서버가 필요합니다';

  @override
  String get dnsMode => 'DNS 모드';

  @override
  String get fakeipRange => 'Fake-IP 범위';

  @override
  String get fakeipFilter => 'Fake-IP 필터';

  @override
  String get defaultNameserver => '기본 DNS 서버';

  @override
  String get defaultNameserverDesc =>
      '다른 DNS 서버의 도메인을 확인합니다. IP 주소만 입력할 수 있습니다.';

  @override
  String get nameserver => 'DNS 서버';

  @override
  String get nameserverDesc =>
      '기본으로 사용하는 DNS 서버입니다. 예: 223.5.5.5, tls://1.1.1.1, https://dns.google/dns-query';

  @override
  String get useHosts => 'hosts 사용';

  @override
  String get useSystemHosts => '시스템 hosts 사용';

  @override
  String get nameserverPolicy => 'DNS 서버 정책';

  @override
  String get nameserverPolicyDesc =>
      '일치하는 도메인은 Nameserver와 Fallback 대신 여기서 지정한 DNS 서버를 사용합니다.';

  @override
  String get proxyNameserver => '프록시 노드 DNS';

  @override
  String get fallback => '보조 DNS';

  @override
  String get fallbackDesc => '폴백 필터가 Nameserver 결과를 오염으로 판단하면 이 서버의 결과를 사용합니다.';

  @override
  String get preferH3 => 'HTTP/3 우선 사용';

  @override
  String get fallbackLazyQuery => '보조 DNS 지연 조회';

  @override
  String get proxyNameserverPolicy => '프록시 노드 DNS 정책';

  @override
  String get directNameserver => '직접 연결 DNS';

  @override
  String get directNameserverFollowPolicy => '직접 연결 DNS에 정책 적용';

  @override
  String get fallbackFilter => '폴백 필터';

  @override
  String get geoipCode => 'GeoIP 코드';

  @override
  String get ipcidr => 'IP CIDR';

  @override
  String get domain => '도메인';

  @override
  String get reset => '초기화';

  @override
  String get action_view => '표시/숨기기';

  @override
  String get action_start => '시작/중지';

  @override
  String get action_mode => '모드 전환';

  @override
  String get action_proxy => '시스템 프록시';

  @override
  String get action_tun => 'TUN';

  @override
  String get hotkeyManagement => '단축키 관리';

  @override
  String get hotkeyManagementDesc => '키보드로 앱 제어';

  @override
  String get pressKeyboard => '키를 누르세요.';

  @override
  String get remove => '제거';

  @override
  String get noNetwork => '네트워크 없음';

  @override
  String get ipv6InboundDesc => 'IPv6를 켜면 VPN이 IPv6 인바운드를 허용합니다.';

  @override
  String get exportLogs => '로그 내보내기';

  @override
  String get exportSuccess => '내보내기 성공';

  @override
  String get iconStyle => '아이콘 스타일';

  @override
  String get iconStyleFilled => '채움';

  @override
  String get iconStylePlain => '기본';

  @override
  String get iconStyleHidden => '숨김';

  @override
  String get stackMode => '스택 모드';

  @override
  String get network => '네트워크';

  @override
  String get bypassDomain => '우회 도메인';

  @override
  String get bypassDomainDesc => '우회 도메인은 시스템 프록시가 켜져 있을 때만 적용됩니다.';

  @override
  String get resetTip => '초기화 확인';

  @override
  String get icon => '아이콘';

  @override
  String get noData => '데이터 없음';

  @override
  String get fontFamily => '글꼴';

  @override
  String get installedFonts => '설치된 글꼴';

  @override
  String get toggle => '전환';

  @override
  String get system => '시스템';

  @override
  String get bypassPrivateRoute => '사설 주소 우회';

  @override
  String get bypassPrivateRouteDesc =>
      '사설 주소 우회를 켜면 LAN, 루프백, 멀티캐스트 주소는 TUN을 거치지 않습니다.';

  @override
  String get routeAddress => '라우팅 주소';

  @override
  String get pleaseInputAdminPassword => '관리자 비밀번호를 입력하세요';

  @override
  String get tunAuthorizationFailed =>
      '관리자 권한이 거부되어 TUN을 켤 수 없습니다. 시스템 권한 요청을 승인한 후 다시 시도하세요.';

  @override
  String get tunHelperInstallFailed =>
      '보조 서비스의 설치 또는 시작에 실패하여 TUN을 켤 수 없습니다. 앱 설치가 완료되었는지, 시스템 서비스가 작동하는지 확인한 후 다시 시도하세요.';

  @override
  String get tunAdminAccountRequired =>
      '이 Mac에서 TUN을 사용하려면 관리자 계정이 필요합니다. 관리자 계정으로 로그인한 후 켜세요.';

  @override
  String get copyEnvVar => '환경 변수 복사';

  @override
  String get memoryInfo => '메모리 정보';

  @override
  String get dialog => '대화상자';

  @override
  String get cancel => '취소';

  @override
  String get fileIsUpdate => '파일이 변경되었습니다. 변경 사항을 저장하시겠습니까?';

  @override
  String get profileHasUpdate => '프로필이 변경되었습니다. 자동 업데이트를 끄시겠습니까?';

  @override
  String get copySuccess => '복사했습니다';

  @override
  String get copyLink => '링크 복사';

  @override
  String get exportFile => '파일 내보내기';

  @override
  String get cacheCorrupt => '캐시가 손상되었습니다. 지우시겠습니까?';

  @override
  String get listen => '수신';

  @override
  String get undo => '실행 취소';

  @override
  String get redo => '다시 실행';

  @override
  String get none => '없음';

  @override
  String get required => '필수';

  @override
  String get advancedConfig => '고급 구성';

  @override
  String get advancedConfigDesc => '다양한 설정 옵션 제공';

  @override
  String get addRule => '규칙 추가';

  @override
  String get ruleName => '규칙 이름';

  @override
  String get content => '내용';

  @override
  String get subRule => '하위 규칙';

  @override
  String get ruleTarget => '규칙 대상';

  @override
  String get sourceIp => '출발지 IP';

  @override
  String get noResolve => 'IP 확인 안 함';

  @override
  String get saveChanges => '변경 사항을 저장하시겠습니까?';

  @override
  String get findProcessModeAutomaticDesc => '프로세스 규칙을 확인할 때만 프로세스를 조회합니다';

  @override
  String get monochromeScheme => '모노크롬';

  @override
  String get colorStyle => '색상 스타일';

  @override
  String get vividStyle => '선명';

  @override
  String get tintedStyle => '틴트';

  @override
  String get softStyle => '부드러움';

  @override
  String get customColor => '사용자 지정 색상';

  @override
  String get grid => '격자';

  @override
  String get spectrum => '스펙트럼';

  @override
  String get sliders => '슬라이더';

  @override
  String get hue => '색조';

  @override
  String get saturation => '채도';

  @override
  String get brightness => '밝기';

  @override
  String get hex => '16진수';

  @override
  String get liquidGlass => 'Liquid Glass';

  @override
  String get ultra => '최고';

  @override
  String get developerMode => '개발자 모드';

  @override
  String get developerModeEnableTip => '개발자 모드가 켜졌습니다.';

  @override
  String get messageTest => '메시지 테스트';

  @override
  String get messageTestTip => '이것은 메시지입니다.';

  @override
  String get crashTest => '비정상 종료 테스트';

  @override
  String get clearData => '데이터 지우기';

  @override
  String get textScale => '글자 크기 조절';

  @override
  String get internet => '인터넷';

  @override
  String get systemApp => '시스템 앱';

  @override
  String get noNetworkApp => '네트워크를 사용하지 않는 앱';

  @override
  String get restoreStrategy => '복원 방식';

  @override
  String get restoreStrategy_override => '덮어쓰기';

  @override
  String get restoreStrategy_compatible => '호환';

  @override
  String get logsTest => '로그 테스트';

  @override
  String emptyTip(Object label) {
    return '$label을(를) 입력하세요';
  }

  @override
  String urlTip(Object label) {
    return '$label은(는) URL이어야 합니다';
  }

  @override
  String numberTip(Object label) {
    return '$label은(는) 숫자여야 합니다';
  }

  @override
  String get interval => '간격';

  @override
  String existsTip(Object label) {
    return '$label이(가) 이미 있습니다';
  }

  @override
  String deleteTip(Object label) {
    return '$label을(를) 삭제하시겠습니까?';
  }

  @override
  String deleteMultipTip(Object label) {
    return '선택한 $label을(를) 삭제하시겠습니까?';
  }

  @override
  String nullTip(Object label) {
    return '$label이(가) 아직 없습니다';
  }

  @override
  String get script => '스크립트';

  @override
  String get color => '색상';

  @override
  String get rename => '이름 변경';

  @override
  String get unnamed => '이름 없음';

  @override
  String get mixedPort => '혼합 포트';

  @override
  String get socksPort => 'SOCKS 포트';

  @override
  String get redirPort => 'Redir 포트';

  @override
  String get tproxyPort => 'TProxy 포트';

  @override
  String portTip(Object label) {
    return '$label은(는) 1024에서 49151 사이여야 합니다';
  }

  @override
  String get portConflictTip => '다른 포트를 입력하세요';

  @override
  String get portUnavailableTitle => '포트를 사용할 수 없음';

  @override
  String portUnavailableMessage(Object port) {
    return '혼합 포트 $port에서 수신을 시작하지 못했습니다. 다른 앱이 사용 중일 수 있습니다. 포트를 변경하면 즉시 다시 시도할 수 있습니다.';
  }

  @override
  String get saveAndRetry => '저장 후 다시 시도';

  @override
  String portSuggestionTip(Object port) {
    return '권장 포트 $port을 입력했습니다.';
  }

  @override
  String get portProxyAppTip => '다른 프록시 앱이 실행 중이면 먼저 종료하세요.';

  @override
  String get import => '가져오기';

  @override
  String get importFile => '파일에서 가져오기';

  @override
  String get importUrl => 'URL에서 가져오기';

  @override
  String get autoSetSystemDns => '시스템 DNS 자동 설정';

  @override
  String get suspendOnIdle => '유휴 상태에서 프록시 일시 중지';

  @override
  String get suspendOnIdleDesc =>
      '화면이 꺼지고 시스템이 유휴 상태일 때 트래픽 전달과 상태 확인을 중지합니다. 통화와 실시간 오디오가 끊기거나 푸시 알림이 지연될 수 있습니다';

  @override
  String details(Object label) {
    return '$label 상세 정보';
  }

  @override
  String get creationTime => '생성 시간';

  @override
  String get process => '프로세스';

  @override
  String get host => '호스트';

  @override
  String get destination => '목적지';

  @override
  String get destinationGeoIP => '목적지 GeoIP';

  @override
  String get destinationIPASN => '목적지 IP ASN';

  @override
  String get specialProxy => '특수 프록시';

  @override
  String get specialRules => '특수 규칙';

  @override
  String get remoteDestination => '원격 목적지';

  @override
  String get networkType => '네트워크 유형';

  @override
  String get proxyChains => '프록시 체인';

  @override
  String get proxyChainWarning =>
      '프록시 체인은 네트워크 속도를 크게 떨어뜨릴 수 있습니다. 필요한 경우에만 사용하세요.';

  @override
  String get proxyChainInstruction =>
      '진입점부터 출구까지 순서대로 배치하세요. 모든 호프에 노드나 정책 그룹을 사용할 수 있습니다. 그룹의 프록시 멤버는 이전 호프를 사용하며 중첩 그룹과 DIRECT/REJECT는 그대로 유지됩니다. 저장하면 체인이 이름 그대로 정책 그룹으로 프록시 목록과 규칙 대상에 표시됩니다. 편집기의 지연은 각 호프의 참고값입니다. 실제 경로는 체인 그룹에서 검사하세요.';

  @override
  String get proxyChainMinimumNodes => '체인에는 진입점과 출구가 필요합니다';

  @override
  String get proxyChainMinimumNodesHint => '출구 노드 또는 그룹을 선택하세요.';

  @override
  String get proxyChainPolicyGroups => '정책 그룹';

  @override
  String get proxyChainUnsupportedGroupTip =>
      '체인에는 select, url-test, fallback, load-balance 그룹만 사용할 수 있습니다.';

  @override
  String get proxyChainEntry => '진입';

  @override
  String get proxyChainExit => '출구';

  @override
  String get clearProxyChain => '체인 설정 지우기';

  @override
  String get proxyChainCustomNodes => '사용자 지정 노드';

  @override
  String get proxyChainCustomNode => '사용자 지정 노드';

  @override
  String get addProxyChainNode => '추가';

  @override
  String get proxyChainOtherNodes => '기타 노드';

  @override
  String get proxyChainSavedAndApplied =>
      '체인을 저장하고 적용했습니다. 규칙이나 프록시 목록에서 체인 이름을 선택하세요.';

  @override
  String proxyChainConflictTip(Object name) {
    return '프록시 $name이 다른 활성 체인과 충돌하거나 루프를 만듭니다';
  }

  @override
  String proxyChainUnavailableNodeTip(Object name) {
    return '프록시 $name은 이 위치에서 사용할 수 없습니다';
  }

  @override
  String proxyChainUnavailableReference(Object chainName, Object nodeName) {
    return '프록시 체인 “$chainName”의 노드 또는 정책 그룹 “$nodeName”을 사용할 수 없습니다. “프록시 체인”에서 다시 선택하거나 이 체인을 비활성화하세요.';
  }

  @override
  String get proxyChainRelatedChainsUpdated => '관련 프록시 체인을 업데이트했습니다';

  @override
  String get proxyChainSelectedNodes => '프록시 체인';

  @override
  String get proxyChainAvailableNodes => '사용 가능한 노드 및 그룹';

  @override
  String get proxyChainEmpty => '프록시 체인에 노드가 없습니다';

  @override
  String get proxyChainNodeAdded => '프록시 체인에 노드를 추가했습니다';

  @override
  String get proxyChainUriNodeSupportedFormats =>
      '지원 형식: ss://, ssr://, vmess://, vless://, trojan://, anytls://, hysteria:// / hy://, hysteria2:// / hy2://, tuic://, wireguard:// / wg://, http(s)://, socks(5)://';

  @override
  String get log => '로그';

  @override
  String get connection => '연결';

  @override
  String get request => '요청';

  @override
  String get connected => '연결됨';

  @override
  String get disconnected => '연결 끊김';

  @override
  String get connecting => '연결 중…';

  @override
  String get restartCoreTip => '코어를 다시 시작하시겠습니까?';

  @override
  String get forceRestartCoreTip => '코어를 강제로 다시 시작하시겠습니까?';

  @override
  String get dnsHijacking => 'DNS 하이재킹';

  @override
  String get coreStatus => '코어 상태';

  @override
  String get liveStatus => '실시간 상태';

  @override
  String liveStatusPosition(Object index, Object count) {
    return '$count개 중 $index번째';
  }

  @override
  String get liveStatusTest => '실시간 상태 카드 테스트';

  @override
  String get coreStopped => '코어가 중지됨';

  @override
  String get restartCore => '코어 다시 시작';

  @override
  String get coreStarting => '코어 시작 중';

  @override
  String get coreStartingDesc => '코어에 연결하는 중';

  @override
  String get coreRunning => '코어 실행 중';

  @override
  String get coreRunningDesc => '앱이 코어에 연결되어 있습니다';

  @override
  String get forceRestartCore => '강제 다시 시작';

  @override
  String get forceRestartCoreAsk => '코어를 강제로 다시 시작할까요?';

  @override
  String get forceRestartCoreAskDesc => '진행 중인 연결이 끊어집니다';

  @override
  String get stopUpdateDownloadTip => '업데이트 다운로드를 중지할까요?';

  @override
  String get stopUpdateDownloadDesc => '이미 받은 부분은 삭제됩니다';

  @override
  String get stopDownload => '중지';

  @override
  String get coreNotConnected => '코어가 연결되지 않았습니다';

  @override
  String get appendSystemDns => '시스템 DNS 추가';

  @override
  String get blockQuic => 'QUIC 차단';

  @override
  String get blockQuicDesc => 'UDP 443 트래픽을 거부하여 TCP 연결로 전환';

  @override
  String get blockWebRtc => 'WebRTC 차단';

  @override
  String get blockWebRtcDesc => 'STUN 트래픽을 거부하여 WebRTC IP 유출을 줄입니다.';

  @override
  String get editRule => '규칙 편집';

  @override
  String get overrideMode => '덮어쓰기 모드';

  @override
  String get standardModeDesc => '표준 모드: 필요하면 덮어쓰기 스크립트를 실행한 뒤 설정 위에 규칙을 추가합니다';

  @override
  String get addedRulesAfterScript => '스크립트 실행 후 프로필 규칙 앞에 삽입됩니다';

  @override
  String get addedRules => '추가한 규칙';

  @override
  String get controlGlobalAddedRules => '전역 추가 규칙 관리';

  @override
  String get overrideScript => '덮어쓰기 스크립트';

  @override
  String get goToConfigureScript => '스크립트 설정으로 이동';

  @override
  String get editGlobalRules => '전역 규칙 편집';

  @override
  String get confirmForceCrashCore => '코어를 강제로 비정상 종료시키시겠습니까?';

  @override
  String get confirmClearAllData => '모든 데이터를 지우시겠습니까?';

  @override
  String get loading => '로드 중…';

  @override
  String yearsAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count년 전',
    );
    return '$_temp0';
  }

  @override
  String monthsAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count개월 전',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count일 전',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count시간 전',
    );
    return '$_temp0';
  }

  @override
  String minutesAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count분 전',
    );
    return '$_temp0';
  }

  @override
  String get justNow => '방금';

  @override
  String get turnOn => '켜기';

  @override
  String get turnOff => '끄기';

  @override
  String get vpnConfigChangeDetected => 'VPN 관련 구성이 변경되었습니다. 눌러서 재시작';

  @override
  String get restart => '다시 시작';

  @override
  String get speedStatistics => '속도 통계';

  @override
  String get resetPageChangesTip => '현재 페이지에 변경 사항이 있습니다. 초기화하시겠습니까?';

  @override
  String get overwriteTypeCustom => '사용자 지정';

  @override
  String get overwriteTypeCustomDesc => '프록시 그룹과 규칙을 모두 직접 구성합니다';

  @override
  String get emptyCustomOverwrite =>
      '사용자 지정 덮어쓰기 내용이 비어 있습니다. 빠른 채우기를 사용하거나 규칙과 프록시 그룹을 추가하세요. 구독 내용을 유지하려면 오버레이 모드를 사용하세요.';

  @override
  String get proxyGroupEmpty => '프록시 그룹이 비어 있습니다';

  @override
  String get proxyGroupNameEmpty => '프록시 그룹 이름은 비워 둘 수 없습니다';

  @override
  String get ruleEmpty => '규칙이 비어 있습니다';

  @override
  String get confirmOverwriteTip => '확인하면 기존 데이터를 덮어씁니다';

  @override
  String get configDataDetected => '설정에서 데이터를 발견했습니다';

  @override
  String get quickFill => '빠른 채우기';

  @override
  String get clearCustomRouting => '모두 지우기';

  @override
  String get confirmClearCustomRouting =>
      '이 프로필의 사용자 지정 프록시 그룹과 규칙을 지우시겠습니까? 구독 내용, 추가 규칙, 프록시 체인 및 사용자 지정 노드는 유지됩니다.';

  @override
  String get addProxyGroup => '프록시 그룹 추가';

  @override
  String get editProxyGroup => '프록시 그룹 편집';

  @override
  String get lazy => '지연 로딩';

  @override
  String get proxyFilter => '프록시 필터';

  @override
  String get excludeProxyFilter => '프록시 제외 필터';

  @override
  String get excludeType => '제외할 유형';

  @override
  String get expectedStatus => '예상 상태';

  @override
  String get maxFailedTimes => '최대 실패 횟수';

  @override
  String get timeout => '시간 초과';

  @override
  String get strategy => '전략';

  @override
  String get iconUrl => '아이콘 URL';

  @override
  String get disableUDP => 'UDP 사용 안 함';

  @override
  String get hideFromList => '목록에서 숨기기';

  @override
  String get includeAll => '모든 프록시 및 공급자 포함';

  @override
  String get includeAllProxies => '모든 프록시 포함';

  @override
  String get includeAllProxyProviders => '모든 프록시 공급자 포함';

  @override
  String get proxyGroupMembersEmpty => '프록시, 공급자 또는 모두 포함 옵션을 추가하세요';

  @override
  String get tolerance => '허용 오차';

  @override
  String customOutboundInUse(Object name) {
    return '그룹, 규칙 또는 프록시 체인이 아직 $name을 참조하고 있습니다';
  }

  @override
  String get relayGroupUnsupported => '코어에서 Relay 그룹이 제거되었습니다. 다른 유형을 선택하세요.';

  @override
  String rawOutboundInUse(Object name, Object path) {
    return '원본 설정의 $path에서 $name을 참조하고 있습니다';
  }

  @override
  String get unknownNetworkError => '알 수 없는 네트워크 오류';

  @override
  String get restoreException => '복원 오류';

  @override
  String get networkException => '네트워크 오류입니다. 연결을 확인한 후 다시 시도하세요';

  @override
  String get invalidBackupFile => '올바르지 않은 백업 파일';

  @override
  String get backupFromNewerVersion =>
      '이 백업은 더 최신 버전의 앱에서 만들어졌습니다. 복원하기 전에 앱을 업데이트하세요';

  @override
  String get pruneCache => '캐시 정리';

  @override
  String get backupAndRestore => '백업 및 복원';

  @override
  String get backupAndRestoreDesc => 'WebDAV 또는 파일로 데이터 동기화';

  @override
  String get restore => '복원';

  @override
  String get restoreDefault => '기본값 복원';

  @override
  String get restoreSuccess => '복원 성공';

  @override
  String get restoreFromWebDAVDesc => 'WebDAV에서 데이터 복원';

  @override
  String get restoreFromFileDesc => '파일에서 데이터 복원';

  @override
  String get restoreOnlyConfig => '설정 파일만 복원';

  @override
  String get restoreAllData => '모든 데이터 복원';

  @override
  String get backupRetention => '보관할 백업 수';

  @override
  String get backupRetentionDesc => '백업할 때 이 기기의 오래된 WebDAV 백업을 삭제합니다';

  @override
  String get selectBackup => '백업 선택';

  @override
  String get noRemoteBackup => 'WebDAV에 백업이 없습니다';

  @override
  String get deleteBackupTip => 'WebDAV에서 이 백업을 삭제하시겠습니까?';

  @override
  String get addProfile => '프로필 추가';

  @override
  String get editProfile => '프로필 편집';

  @override
  String get delayTest => '지연 테스트';

  @override
  String get userCenter => '사용자 센터';

  @override
  String get userCenterFallback => '사용자 센터(보조)';

  @override
  String get userGuide => '사용자 가이드';

  @override
  String get oixCloud => 'oixCloud';

  @override
  String get register => '가입';

  @override
  String get registerTitle => '계정 만들기';

  @override
  String get registerFailed => '가입 실패';

  @override
  String get registerClosed => '현재 가입이 마감되었습니다';

  @override
  String get haveAccountAlready => '이미 계정이 있으신가요?';

  @override
  String get goLogin => '로그인';

  @override
  String get nicknameLabel => '닉네임';

  @override
  String get nicknameHint => '영문자와 숫자, 최대 12자';

  @override
  String get nicknameValidation => '닉네임을 입력하세요';

  @override
  String get confirmPasswordLabel => '비밀번호 확인';

  @override
  String get confirmPasswordHint => '비밀번호를 다시 입력하세요';

  @override
  String get confirmPasswordValidation => '비밀번호를 확인하세요';

  @override
  String get passwordMismatch => '비밀번호가 일치하지 않습니다';

  @override
  String get passwordRuleHint => '대문자, 소문자, 숫자 및 기호를 포함한 10~36자';

  @override
  String get inviteCodeLabel => '초대 코드';

  @override
  String get inviteCodeHint => '초대 코드를 입력하세요';

  @override
  String get inviteCodeValidation => '초대 코드를 입력하세요';

  @override
  String get emailCodeLabel => '이메일 인증 코드';

  @override
  String get emailCodeHint => '6자리 코드를 입력하세요';

  @override
  String get emailCodeValidation => '이메일 인증 코드를 입력하세요';

  @override
  String get sendCode => '코드 전송';

  @override
  String resendCodeIn(Object seconds) {
    return '$seconds초 후 재전송';
  }

  @override
  String get codeSent => '인증 코드를 전송했습니다';

  @override
  String get loggedOutViewTitle => 'oixCloud';

  @override
  String get loggedOutViewDesc => '로그인하여 계정 정보를 확인하고 구독을 관리하세요';

  @override
  String get signInWithGoogle => 'Google로 로그인';

  @override
  String get googleLoginWaiting => '브라우저에서 Google 로그인을 완료하세요';

  @override
  String get googleLoginUnavailable => 'Google 로그인 페이지를 열지 못했습니다. 다시 시도하세요.';

  @override
  String get googleLoginTimedOut => 'Google 로그인 시간이 초과되었습니다. 다시 시도하세요.';

  @override
  String get googleLoginInvalidCallback => 'Google 로그인을 확인하지 못했습니다. 다시 시도하세요.';

  @override
  String get loginTitle => '로그인';

  @override
  String get startCorePromptTitle => '안내';

  @override
  String get startCorePromptContent => '프로필을 가져왔습니다. 지금 코어를 시작하시겠습니까?';

  @override
  String get logoutTitle => '로그아웃';

  @override
  String get logoutContent => '로그아웃하시겠습니까?';

  @override
  String get loginSuccess => '로그인 성공';

  @override
  String get getProfileSuccess => '프로필을 가져왔습니다';

  @override
  String get startSuccess => '시작했습니다';

  @override
  String get loginFailed => '로그인 실패';

  @override
  String get invalidCertificateTitle => '인증서 검증 실패';

  @override
  String get certificateExpired => '인증서가 만료되었습니다';

  @override
  String get certificateNotYetValid => '아직 유효하지 않은 인증서입니다';

  @override
  String get certificateHostnameMismatch => '인증서가 요청한 도메인과 일치하지 않습니다';

  @override
  String get certificateUntrusted => '신뢰할 수 없는 인증서 체인입니다';

  @override
  String get certificateValidityHint =>
      '먼저 시스템 날짜와 시간을 동기화하세요. 시간이 정확하다면 서버 인증서를 수정해야 합니다.';

  @override
  String get invalidCertificateContent =>
      '서버 인증서를 검증하지 못했습니다. 검증을 건너뛰면 서버가 위조되었을 수 있으며, 송수신하는 계정 인증 정보나 구독 데이터가 도난당하거나 변조될 수 있습니다.\n\n이 네트워크와 서버를 신뢰하는 경우에만 계속하세요. 예외는 동일한 서버와 인증서에 대한 이번 재시도에만 적용되며, 작업이 끝나면 해제됩니다.';

  @override
  String get allowTemporarily => '일시적으로 허용';

  @override
  String get retryWithoutCertificateVerification => 'API 임시 확인';

  @override
  String get apiAvailableWithCertificateException =>
      '인증서 예외를 임시 적용하여 API에 연결했습니다. 계정이나 노드 설정은 동기화하지 않았습니다. 인증서 문제를 해결한 후 다시 확인하세요.';

  @override
  String get certificateUntrustedHint =>
      '휴대전화 핫스팟 등 다른 네트워크를 사용하고 시스템 업데이트를 확인하세요. 백신이나 회사 네트워크가 HTTPS를 검사한다면 관리자에게 확인을 요청하세요. 문제가 계속되면 서비스 제공자에게 인증서 체인을 확인해 달라고 요청하세요.';

  @override
  String get certificateHostnameHint =>
      '다른 네트워크를 사용하고 Wi-Fi 로그인이 필요하다면 먼저 완료하세요. 문제가 계속되면 서비스 제공자에게 인증서가 서버 도메인과 일치하는지 확인해 달라고 요청하세요.';

  @override
  String get certificateRevokedHint =>
      '서비스 제공자에게 폐기된 인증서를 교체해 달라고 요청하세요. 재시도하거나 시스템 시간을 변경해도 폐기된 인증서는 복구되지 않습니다.';

  @override
  String get certificateUnknownHint =>
      '시스템 날짜와 시간을 확인한 후 다른 네트워크를 사용하세요. 검증이 계속 실패하면 이 오류를 서비스 제공자에게 전달하여 도움을 받으세요.';

  @override
  String get certificateCheckOnlyHint =>
      '이 작업은 API 연결만 확인하며, 로그인하거나 노드 설정을 다운로드하지 않습니다.';

  @override
  String get certificateSyncRetryDescription =>
      '확인하면 이번 시도에서 연결을 확인하고 계정을 새로 고친 뒤 노드 설정을 다운로드합니다. 동기화가 끝나면 인증서 예외가 해제됩니다.';

  @override
  String get retryCloudSyncWithCertificateException => '일시적으로 허용하고 동기화';

  @override
  String get cloudSyncedWithCertificateException =>
      '인증서 예외를 임시 적용하여 계정과 설정을 동기화했습니다. 검증이 다시 활성화되었습니다. 다음 동기화 전에 인증서 문제를 해결하세요.';

  @override
  String get cloudCertificateSyncFailed =>
      'API 확인은 통과했으나 계정 또는 노드 설정 동기화에 실패했습니다: ';

  @override
  String get cloudConfigSyncIncomplete =>
      '노드 설정을 다운로드하지 못했습니다. 다운로드 오류를 해결한 후 다시 동기화하세요.';

  @override
  String get emailPassword => '이메일 및 비밀번호';

  @override
  String get accessToken => '액세스 토큰';

  @override
  String get emailLabel => '이메일';

  @override
  String get emailHint => '이메일 주소를 입력하세요';

  @override
  String get emailValidation => '이메일을 입력하세요';

  @override
  String get emailFormatValidation => '이메일 형식이 올바르지 않습니다';

  @override
  String get passwordLabel => '비밀번호';

  @override
  String get forgotPassword => '비밀번호를 잊으셨나요?';

  @override
  String get resetPasswordTitle => '비밀번호 재설정';

  @override
  String get sendResetEmail => '재설정 이메일 전송';

  @override
  String get resetEmailSent => '재설정 이메일을 보냈습니다. 이메일의 재설정 링크나 코드를 아래에 붙여 넣으세요.';

  @override
  String get resetTokenLabel => '재설정 링크 또는 코드';

  @override
  String get resetTokenValidation => '재설정 링크 또는 코드를 입력하세요';

  @override
  String get newPasswordLabel => '새 비밀번호';

  @override
  String get resetPasswordSuccess => '비밀번호가 재설정되었습니다. 새 비밀번호로 로그인하세요';

  @override
  String get passwordValidation => '비밀번호를 입력하세요';

  @override
  String get tokenLabel => '액세스 토큰';

  @override
  String get tokenValidation => '액세스 토큰을 입력하세요';

  @override
  String expireDate(Object date) {
    return '만료일: $date';
  }

  @override
  String get todayUsed => '오늘 사용량';

  @override
  String remaining(Object value) {
    return '남은 용량: $value';
  }

  @override
  String get balance => '잔액';

  @override
  String get commission => '수수료';

  @override
  String get points => '포인트';

  @override
  String get announcement => '공지';

  @override
  String get readFullAnnouncement => '공지 전체 읽기';

  @override
  String get serviceCheckFailed => '서비스 확인 실패';

  @override
  String get apiAvailable => 'API 서비스가 정상 작동 중입니다';

  @override
  String get checkApi => 'API 확인';

  @override
  String get refresh => '새로 고침';

  @override
  String get nodeFilter => '노드 필터';

  @override
  String get nodeFilterSmartSelection => '스마트 선택';

  @override
  String get nodeFilterCustomized => '사용자 지정';

  @override
  String nodeFilterKept(Object kept, Object total) {
    return '$total개 중 $kept개 노드 유지';
  }

  @override
  String get nodeFilterLines => '회선';

  @override
  String get nodeFilterRegions => '지역';

  @override
  String get nodeFilterNameContains => '이름에 포함';

  @override
  String get nodeFilterNameExcludes => '이름에서 제외';

  @override
  String get nodeFilterPreview => '미리 보기';

  @override
  String get nodeFilterSearch => '노드 검색';

  @override
  String get nodeFilterAny => '모두';

  @override
  String get nodeFilterOnly => '선택 항목만';

  @override
  String get nodeFilterExclude => '제외';

  @override
  String get nodeFilterKeepOne => '노드를 하나 이상 유지하세요';

  @override
  String nodeFilterNodeKept(Object name) {
    return '$name, 유지됨';
  }

  @override
  String nodeFilterNodeExcluded(Object name) {
    return '$name, 제외됨';
  }

  @override
  String get nodeFilterRetry => '다시 시도';

  @override
  String get nodeFilterAccountNote => '계정에 저장되며 이 앱에 로그인한 모든 기기에 적용됩니다.';

  @override
  String get nodeFilterUnavailable => '요금제를 구매하면 노드 필터를 사용할 수 있습니다';

  @override
  String get minimalConfiguration => '최소 설정';

  @override
  String get minimalConfigurationDesc => '간소화된 규칙으로 더 작은 프로필을 생성합니다';

  @override
  String get tcpFastOpen => 'TCP Fast Open';

  @override
  String get tcpFastOpenDesc => 'TCP 연결 설정 속도를 높입니다';

  @override
  String get store => '스토어';

  @override
  String get recharge => '충전';

  @override
  String get availablePlans => '요금제 선택';

  @override
  String get noAvailablePlans => '이용 가능한 요금제가 없습니다';

  @override
  String get myOrders => '구매한 요금제';

  @override
  String get noPurchaseRecords => '구매한 요금제가 없습니다';

  @override
  String get accountBalance => '잔액';

  @override
  String commissionBalance(Object value) {
    return '수수료 $value';
  }

  @override
  String get soldOut => '품절';

  @override
  String remainingStock(Object count) {
    return '$count개 남음';
  }

  @override
  String get mainlandNetworkWarning => '중국 본토 네트워크에 적합하지 않을 수 있습니다';

  @override
  String get planInUse => '사용 중';

  @override
  String get planNotActivated => '활성화 대기';

  @override
  String get planEnded => '종료됨';

  @override
  String get planAwaitingAutoRenewal => '자동 갱신 대기';

  @override
  String get planAwaitingAutoRenewalNote =>
      '다른 요금제 다음 순서이며, 모두 사용하면 자동으로 갱신됩니다';

  @override
  String get planAutoRenewalOffNote => '다른 요금제 다음 순서이며, 모두 사용하면 종료됩니다';

  @override
  String planNumber(Object id) {
    return '요금제 #$id';
  }

  @override
  String get activate => '활성화';

  @override
  String get upgradePlan => '요금제 업그레이드';

  @override
  String get noPaymentMethods => '이용 가능한 결제 수단이 없습니다';

  @override
  String get activatePlanTitle => '요금제 활성화';

  @override
  String get activatePlanConfirm => '이 요금제를 활성화하시겠습니까? 현재 사용 요금제로 적용됩니다.';

  @override
  String get noUpgradablePlans => '업그레이드 가능한 요금제가 없습니다';

  @override
  String get selectUpgradeTarget => '업그레이드 대상 선택';

  @override
  String get refreshAfterPayment => '결제 후 아래로 당겨 새로 고침하고 결과를 확인하세요';

  @override
  String get discountCodeOptional => '할인 코드(선택 사항)';

  @override
  String get bindCoupon => '쿠폰 적용';

  @override
  String get bindCouponIntro =>
      '공식 쿠폰 코드를 입력하세요. 요금제의 남은 기간에 대해 차액을 정산하며, 반복 적용 쿠폰은 갱신 가격도 변경합니다.';

  @override
  String get verifyCoupon => '확인';

  @override
  String get discountCode => '할인 코드';

  @override
  String get discountCodeRequired => '할인 코드를 입력하세요';

  @override
  String get discountedPriceLabel => '할인 가격';

  @override
  String get amountDueLabel => '결제할 금액';

  @override
  String get refundAmountLabel => '환불액';

  @override
  String get recurringRenewalHint => '이후 자동 갱신에도 이 할인이 적용됩니다';

  @override
  String get insufficientBalanceHint => '잔액이 부족합니다. 충전 후 계속하세요.';

  @override
  String get amountPayable => '결제 금액';

  @override
  String get renewalPriceLabel => '갱신 가격';

  @override
  String get calculatingQuote => '계산 중…';

  @override
  String get paymentMethod => '결제 수단';

  @override
  String get goPay => '결제';

  @override
  String get confirmPurchase => '구매 확인';

  @override
  String get rechargeAmount => '충전 금액(¥)';

  @override
  String get invalidAmount => '올바른 금액을 입력하세요';

  @override
  String get scanOrTransferPay => '스캔 / 이체 결제';

  @override
  String get close => '닫기';

  @override
  String get checkingPayment => '확인 중…';

  @override
  String get paymentPending => '아직 결제가 확인되지 않았습니다. 잠시 후 다시 확인하세요.';

  @override
  String get iHavePaid => '결제했습니다';

  @override
  String get openInBrowser => '브라우저에서 열기';

  @override
  String get openLinkFailed => '링크를 열 수 없습니다. 브라우저가 설치되어 있는지 확인한 후 다시 시도하세요.';

  @override
  String get scanToPayNotice => 'Alipay / WeChat으로 스캔하여 결제하세요';

  @override
  String get paymentAmount => '결제 금액';

  @override
  String get receivingAddress => '수신 주소';

  @override
  String get addressCopied => '주소를 복사했습니다';

  @override
  String get transferConfirmNotice =>
      '이체가 완료되면 시스템에서 자동으로 확인하고 선택한 요금제를 활성화합니다.';

  @override
  String get operationSuccess => '작업 성공';

  @override
  String get operationFailed => '작업 실패';

  @override
  String get paymentSuccess => '결제 성공';

  @override
  String get paymentRequestFailed => '결제 요청 실패';

  @override
  String get fetchPlansFailed => '요금제를 불러오지 못했습니다';

  @override
  String get storeSubtitle => '요금제 구매, 갱신 및 업그레이드';

  @override
  String get paymentUnknownResponse => '결제 서비스가 알 수 없는 형식으로 응답했습니다';

  @override
  String get buy => '구매';

  @override
  String get payWithBalance => '잔액으로 결제';

  @override
  String availableBalance(Object value) {
    return '사용 가능: $value';
  }

  @override
  String get planUnavailable => '이용 불가';

  @override
  String get balanceDeductionHint => '구매 시 잔액을 먼저 사용하고 부족한 금액은 수수료 잔액에서 차감합니다.';

  @override
  String rechargeAllowedRange(Object min, Object max) {
    return '허용 범위: $min – $max';
  }

  @override
  String get rechargeAmountOutOfRange => '이 결제 수단에서 허용하는 금액 범위를 벗어났습니다';

  @override
  String get insufficientBalanceRecharge => '충전 후 다시 시도하세요.';

  @override
  String get storeOutcomeUnknown =>
      '요청이 이미 처리되었을 수 있습니다. 다시 시도하기 전에 구매한 요금제를 확인하세요.';

  @override
  String configParseErrorAtLine(Object line) {
    return '$line번째 줄의 설정 형식이 올바르지 않습니다.';
  }

  @override
  String configTypeMismatch(Object expected, Object actual) {
    return '$expected이(가) 필요하지만 $actual이(가) 있습니다.';
  }

  @override
  String get configYamlFormatHint => '이 줄 주변의 들여쓰기와 목록 표시 \'-\'를 확인하세요.';

  @override
  String get configValueTypeList => '목록';

  @override
  String get configValueTypeObject => '객체';

  @override
  String get configValueTypeText => '텍스트';

  @override
  String get configValueTypeBoolean => '불리언';

  @override
  String get configValueTypeInteger => '정수';

  @override
  String get configValueTypeNumber => '숫자';

  @override
  String get configValueTypeNull => '빈 값';

  @override
  String get configRecoveryTitle => '로컬 설정 복구';

  @override
  String get configRecoveryMessage =>
      '로컬 설정을 일시적으로 사용할 수 없습니다. 기존 데이터는 보존되었습니다. 기기의 잠금을 해제한 후 다시 시도하거나 나중에 앱을 다시 여세요.';

  @override
  String get configRecoveryRetry => '다시 시도';

  @override
  String get geoDownloadFailed => 'GEO 다운로드 실패';

  @override
  String get geoFileMissing => '다운로드되지 않음';

  @override
  String get geoFileReadFailed => '리소스 파일을 읽지 못했습니다';

  @override
  String get geoDownloadRecoveryHint =>
      '다운로드는 현재 네트워크 규칙을 따르며, 프록시를 사용할 수 없으면 직접 연결합니다. 현재 주소로 재시도하거나 다른 소스를 선택하거나 URL을 입력하세요. 검증을 통과하면 작업이 자동으로 계속됩니다.';

  @override
  String get geoOriginalSource => '현재 주소';

  @override
  String get geoBackupSource => '보조 CDN';

  @override
  String get geoDownloadUrl => '다운로드 URL';

  @override
  String get geoInvalidDownloadUrl => '올바른 HTTP 또는 HTTPS URL을 입력하세요';

  @override
  String get purchasedAtLabel => '구매 시각';

  @override
  String get purchasePriceLabel => '구매 가격';

  @override
  String get billingPeriodLabel => '청구 주기';

  @override
  String get remainingTimeLabel => '남은 시간';

  @override
  String get remainingTrafficLabel => '남은 트래픽';

  @override
  String get expiresAtLabel => '만료 시각';

  @override
  String get usedTrafficLabel => '사용한 트래픽';

  @override
  String get purchaseTotalTrafficLabel => '총 트래픽';

  @override
  String get purchaseAutoRenewLabel => '자동 갱신';

  @override
  String purchaseDays(Object count) {
    return '$count일';
  }

  @override
  String purchaseHours(Object count) {
    return '$count시간';
  }

  @override
  String purchaseMinutes(Object count) {
    return '$count분';
  }

  @override
  String get purchaseRenewOn => '켜짐';

  @override
  String get purchaseRenewOff => '꺼짐';

  @override
  String get overwriteTypeMerge => '오버레이';

  @override
  String get overwriteTypeMergeDesc =>
      '구독의 규칙과 그룹을 유지하고 개인 설정을 추가합니다. 개인 규칙은 구독 규칙보다 우선하며, 기존 추가 규칙은 우선순위를 유지합니다.';

  @override
  String get personalRouting => '개인 라우팅';

  @override
  String get overlayHint =>
      '구독과 별도로 저장되며 업데이트 후 다시 적용됩니다. 새 그룹에 일치하는 구성원이 없으면 연결을 차단합니다.';

  @override
  String overlayNameConflict(Object name) {
    return '이름 \"$name\"이(가) 이미 사용 중입니다. 둘 다 유지하려면 개인 그룹의 이름을 변경하세요.';
  }

  @override
  String get outboundUnavailable => '이 설정에서는 사용할 수 없습니다. 제거하거나 다른 항목으로 바꾸세요.';

  @override
  String get memberOrderHint =>
      '선택한 순서가 대체 연결 순서입니다. 구성원을 제거한 후 다시 선택하면 맨 뒤로 이동합니다.';

  @override
  String groupCycleError(Object name) {
    return '그룹 순환 참조: $name. 다른 구성원을 선택하세요.';
  }

  @override
  String get rulesRequireRuleMode => '개인 라우팅 규칙은 규칙 모드에서 적용됩니다.';

  @override
  String get checkRouting => '설정 확인';

  @override
  String get routingChecked => '설정이 유효합니다. 이 프로필의 개인 설정을 저장했습니다.';

  @override
  String get routingApplied => '개인 설정을 적용했습니다.';

  @override
  String get routingApplyFailed =>
      '변경 사항은 저장했으나 적용하지 못했습니다. 설정을 확인한 후 다시 시도하세요.';

  @override
  String get customRuleForm => '양식';

  @override
  String get customRuleRaw => '규칙 텍스트';

  @override
  String get customRuleRawHint => '완전한 규칙 하나를 입력하세요. 고급 표현식은 유지됩니다.';

  @override
  String get customRuleFormUnavailable =>
      '고급 문법을 사용하는 규칙입니다. 모든 옵션을 유지하려면 규칙 텍스트를 편집하세요.';

  @override
  String get customRuleInvalidSyntax => '올바른 유형, 내용 및 대상을 포함한 완전한 규칙을 입력하세요.';

  @override
  String customRuleInvalidContent(Object example) {
    return '이 규칙 유형에 맞는 내용인지 확인하세요. 예: $example';
  }

  @override
  String customRuleUnavailableTarget(Object name) {
    return '$name을(를) 사용할 수 없습니다. 이 설정에 있는 대상을 선택하세요.';
  }

  @override
  String customRuleUnavailableProvider(Object name) {
    return '$name을(를) 사용할 수 없습니다. 기존 규칙 공급자를 선택하세요.';
  }

  @override
  String get customRuleChooseTarget => '대상 선택';

  @override
  String get customRuleChooseProvider => '규칙 공급자 선택';

  @override
  String get customRuleMatchHint => '남은 모든 트래픽에 일치합니다. 뒤에 있는 규칙은 실행되지 않습니다.';

  @override
  String get customRuleNoResolveHint =>
      '도메인 이름을 확인하지 않고 알려진 IP 주소로 일치 여부를 확인합니다.';

  @override
  String get saveRoutingDraft => '초안 저장';

  @override
  String get routingDraftHint =>
      '다른 항목을 수정할 수 있도록 초안을 저장합니다. 전체 설정이 검증을 통과한 후에만 적용됩니다.';

  @override
  String get groupFilterHint =>
      '자동 포함 노드와 공급자 노드를 필터링합니다. 직접 선택한 구성원은 항상 유지됩니다.';

  @override
  String get groupTypeSelect => '수동 선택';

  @override
  String get groupTypeUrlTest => '자동 선택';

  @override
  String get groupTypeFallback => '장애 조치';

  @override
  String get groupTypeLoadBalance => '부하 분산';

  @override
  String get groupTypeSelectHint => '프록시 페이지에서 사용할 구성원을 선택하세요.';

  @override
  String get groupTypeUrlTestHint => '구성원을 주기적으로 테스트하고 지연이 낮은 노드를 선택합니다.';

  @override
  String get groupTypeFallbackHint => '구성원을 순서대로 시도하며 현재 구성원에 장애가 발생하면 전환합니다.';

  @override
  String get groupTypeLoadBalanceHint => '사용 가능한 구성원에 연결을 분산합니다.';

  @override
  String get routingGroupType => '그룹 유형';

  @override
  String get customRuleType => '규칙 유형';

  @override
  String get routingChanged => '편집 또는 확인 중에 설정이 변경되었습니다. 편집기를 다시 열거나 다시 확인하세요.';

  @override
  String get editCustomRouting => '사용자 지정 라우팅 편집';

  @override
  String get customRoutingDraftHint =>
      '사용자 지정 라우팅을 구성한 후 사용자 지정 모드로 전환하세요. 이 초안을 편집해도 현재 모드는 바뀌지 않습니다.';

  @override
  String coreBlockedByPolicyTip(int code) {
    return 'Windows가 프록시 코어 시작을 차단했습니다(시스템 오류 $code). Windows 보안의 보호 기록과 앱 제어 정책을 확인하고 설치 프로그램의 출처와 서명을 검증하세요.';
  }

  @override
  String get startupRecoveryTitle => '시작 복구';

  @override
  String get startupRecoveryTip =>
      '이전 시작이 완료되지 않았습니다. 이번 실행에서는 자동 설정 적용과 VPN 시작을 일시 중지합니다. 선택한 프로필과 설정은 변경되지 않습니다. 설정을 확인하고 시작을 눌러 다시 시도하세요. 이미 실행 중인 VPN은 연결을 유지합니다.';

  @override
  String get initFailed => '시작 실패';

  @override
  String get initFailedTip => '앱을 시작하는 중 심각한 오류가 발생하여 계속할 수 없습니다.';

  @override
  String get startupTimeoutTip =>
      '시작 시간이 초과되었습니다. 앱을 종료한 후 다시 여세요. 문제가 계속되면 아래 진단 정보를 복사하세요.';

  @override
  String get startupDiagnostics => '시작 진단';

  @override
  String get errorDetails => '오류 세부 정보';

  @override
  String get stackTrace => '스택 트레이스';

  @override
  String get authentication => '로컬 프록시 인증';

  @override
  String get authenticationDesc =>
      'HTTP 및 SOCKS 포트에서 사용자 이름과 비밀번호를 요구합니다. 켜져 있는 동안 시스템 HTTP 프록시는 설정하지 않으며 TUN과 VPN은 계속 작동합니다';

  @override
  String get authenticationSystemProxyDesc =>
      '로컬 프록시 인증이 켜져 있으면 시스템 프록시를 적용하지 않습니다';

  @override
  String get authenticationUsernameInvalid =>
      '콜론과 제어 문자를 제외한 UTF-8 1~255바이트를 사용하세요';

  @override
  String get authenticationPasswordInvalid =>
      '제어 문자를 제외한 UTF-8 1~255바이트를 사용하세요';

  @override
  String get authenticationApplyFailed => '인증 설정을 적용하지 못했습니다';

  @override
  String get installedAppsPermissionRequired => '설치된 앱 접근 권한 필요';

  @override
  String get installedAppsPermissionDesc =>
      'VPN을 사용할 앱을 선택하려면 설치된 앱 목록에 대한 접근을 허용하세요.';

  @override
  String get installedAppsPermissionDeniedMessage =>
      '권한이 허용되지 않았습니다. 시스템 설정에서 켤 수 있습니다.';

  @override
  String get installedAppsPermissionGrant => '접근 허용';

  @override
  String get installedAppsLoadFailed => '설치된 앱을 불러오지 못했습니다. 다시 시도하세요.';

  @override
  String get configRecoveryMissingKey =>
      '기존 설정의 암호화 키가 없거나 유효하지 않습니다. 원래 기기의 원래 시스템 계정을 사용하거나 백업을 복원하세요. 재시도로 분실한 키를 다시 만들 수는 없습니다.';

  @override
  String get configRecoveryDatabaseUnavailable =>
      '현재 로컬 데이터베이스에 접근할 수 없습니다. 기존 파일은 보존되었습니다. 이 앱의 데이터 폴더 접근 권한과 다른 프로세스가 데이터베이스를 사용 중인지 확인한 후 다시 시도하세요.';

  @override
  String get configRecoveryIncompatibleDatabase =>
      '이 앱의 데이터 폴더에 있는 데이터베이스가 호환되지 않거나 손상되었습니다. 기존 파일은 보존되었습니다. 호환되는 백업을 복원하거나 백업 후 초기화하여 앱을 다시 설정하세요. 다른 앱의 데이터에는 접근하지 않습니다.';

  @override
  String get configRecoveryUnreadable =>
      '로컬 설정을 복호화할 수 없거나 설정이 손상되었습니다. 기존 파일은 보존되었습니다. 일치하는 키와 설정 백업을 복원하거나 백업 후 초기화하세요.';

  @override
  String get configRecoveryStorage =>
      '로컬 설정 또는 암호화 키를 읽거나 저장하지 못했습니다. 앱 데이터 폴더와 시스템 보안 저장소에 대한 접근 권한을 확인한 후 다시 시도하세요.';

  @override
  String get configRecoveryReset => '백업 후 초기화';

  @override
  String get configRecoveryResetConfirm =>
      '모든 로컬 설정, 구독, 규칙 및 계정 데이터를 암호화하여 백업한 후 앱을 초기화하시겠습니까? 다시 로그인하고 구독과 설정을 복원하거나 가져와야 합니다. 백업은 이 Windows 계정으로 보호되며, 분실한 암호화 키는 복구할 수 없습니다.';

  @override
  String get configRecoveryResetDone =>
      '원본 데이터의 암호화된 백업을 아래 폴더에 저장했습니다. 앱을 종료한 후 다시 열어 설정하세요.';

  @override
  String get configRecoveryResetFailed =>
      '암호화 백업 및 초기화를 완료하지 못했습니다. 검증된 백업 없이는 남아 있는 원본 데이터를 삭제하지 않습니다. 다시 시도하거나 앱을 종료한 후 다시 열어 작업을 완료하세요.';

  @override
  String get configRecoveryKeyring =>
      '시스템 키링(Secret Service)에 접근하지 못했습니다. 시스템 설정에서 KDE Wallet 또는 GNOME Keyring을 켜고 잠금을 해제한 후 다시 시도하세요.';

  @override
  String get configRecoveryUseLocalStorage => '로컬 파일 저장소 사용';

  @override
  String get configRecoveryUseLocalStorageConfirm =>
      '시스템 키링 대신 사용자 계정만 열 수 있는 앱 데이터 폴더의 파일에 암호화 키와 계정 인증 정보를 저장하시겠습니까? 같은 사용자 계정으로 실행되는 모든 프로그램이 이를 읽고 로컬 설정을 복호화할 수 있습니다. 이 선택은 이후에도 유지됩니다.';

  @override
  String get excludeSsids => '프록시를 일시 중지할 Wi-Fi 네트워크';

  @override
  String get excludeSsidsDesc =>
      '지정한 Wi-Fi 네트워크에서 프록시를 일시 중지합니다. 벗어난 후 앱이 계속 시작된 상태인 경우에만 재개합니다';

  @override
  String get allowBackgroundLocation => '항상 위치 허용';

  @override
  String get locationPermission => '위치 권한';

  @override
  String get locationPermissionRequired => '위치 권한 필요';

  @override
  String locationPermissionGuide(Object appName) {
    return '1. 시스템 설정 > 개인정보 보호 및 보안을 엽니다\n2. 위치 서비스를 선택합니다\n3. 목록에서 $appName을(를) 찾아 체크합니다\n\n완료되면 앱으로 돌아와 계속하세요. 협조해 주셔서 감사합니다.';
  }

  @override
  String get ssidPermissionGuide =>
      'Wi-Fi 이름을 읽으려면 위치 접근을 허용하세요. Android에서는 정확한 위치를 항상 허용하고 시스템 위치 서비스를 켜세요.';

  @override
  String get ssidPermissionMacosGuide =>
      'Wi-Fi 이름을 읽으려면 시스템 설정에서 이 앱의 위치 서비스 사용을 허용하세요.';

  @override
  String get exitDefault => '기본값';

  @override
  String get customExit => '사용자 지정 출구';

  @override
  String get inputExitName => '출구 이름을 입력하세요';

  @override
  String get iconHistory => '최근 아이콘';

  @override
  String get exitFullScreen => '전체 화면 종료';

  @override
  String get unmaximize => '이전 크기로 복원';

  @override
  String get maximize => '최대화';

  @override
  String get unpinWindow => '창 고정 해제';

  @override
  String get pinWindow => '창 고정';

  @override
  String get minimize => '최소화';

  @override
  String get cloudApiDnsFailed => 'DNS 조회 실패';

  @override
  String get cloudApiDnsEmpty =>
      'DNS가 주소를 반환하지 않았습니다. 차단되었거나 시스템 DNS 확인기에 문제가 있을 수 있습니다';

  @override
  String get cloudApiDnsUnknownHost => 'DNS에서 이 도메인을 찾지 못했습니다';

  @override
  String get cloudApiConnectTimeout => '연결 시간 초과';

  @override
  String get cloudApiSendTimeout => '요청 전송 시간 초과';

  @override
  String get cloudApiReceiveTimeout => '응답 대기 시간 초과';

  @override
  String get cloudApiTlsFailed => 'TLS 핸드셰이크 실패';

  @override
  String get cloudApiConnectionRefused => '연결 거부됨';

  @override
  String get cloudApiConnectionReset => '연결이 재설정됨';

  @override
  String get cloudApiNetworkUnreachable => '네트워크에 연결할 수 없음';

  @override
  String get cloudApiAccessDenied => '네트워크 접근 거부됨';

  @override
  String get cloudApiConnectionFailed => '연결 실패';

  @override
  String get cloudApiProxyFailed => '프록시 연결 실패';

  @override
  String get cloudApiProxyAuthFailed => '프록시 인증 실패(HTTP 407)';

  @override
  String cloudApiHttpError(Object status) {
    return '서버가 HTTP $status을(를) 반환했습니다';
  }

  @override
  String get certificateRevoked => '인증서가 폐기되었습니다';

  @override
  String get cloudApiBadRequest => '서버가 유효하지 않은 요청으로 거부했습니다';

  @override
  String get cloudApiForbidden => '접근 금지';

  @override
  String get cloudApiNotFound => '요청한 API 또는 리소스를 찾지 못했습니다';

  @override
  String get cloudApiMethodNotAllowed => '허용되지 않은 요청 메서드입니다';

  @override
  String get cloudApiServerRequestTimeout => '서버의 요청 수신 시간이 초과되었습니다';

  @override
  String get cloudApiRequestTooLarge => '요청이 서버의 크기 제한을 초과했습니다';

  @override
  String get cloudApiRateLimited => '요청이 너무 많습니다. 나중에 다시 시도하세요';

  @override
  String get cloudApiServerError => '서버 내부 오류';

  @override
  String get cloudApiBadGateway => '게이트웨이가 상위 서버에서 유효하지 않은 응답을 받았습니다';

  @override
  String get cloudApiServiceUnavailable => '서비스를 일시적으로 사용할 수 없습니다';

  @override
  String get cloudApiGatewayTimeout => '게이트웨이의 상위 서버 응답 대기 시간이 초과되었습니다';

  @override
  String get cloudApiNetworkAuthRequired => '이 네트워크에 접근하려면 먼저 로그인해야 합니다';

  @override
  String get cloudApiResponseTooLarge => '서버 응답이 허용된 크기를 초과했습니다';

  @override
  String get cloudApiTlsProtocolFailed =>
      'TLS 프로토콜이 호환되지 않거나 TLS 응답이 유효하지 않습니다';

  @override
  String get cloudApiTlsAlgorithmFailed => 'TLS 암호화 알고리즘 협상 실패';

  @override
  String get cloudApiTlsInterrupted => 'TLS 핸드셰이크가 완료되기 전에 연결이 닫혔습니다';

  @override
  String get cloudApiRedirectLoop => '서버 리디렉션이 반복됩니다';

  @override
  String get cloudApiRedirectLimit => '서버 리디렉션이 너무 많습니다';

  @override
  String get cloudApiRedirectInvalid => '서버 리디렉션이 유효하지 않습니다';

  @override
  String get cloudApiResponseInterrupted => '전체 응답을 받기 전에 연결이 닫혔습니다';

  @override
  String get cloudApiConnectionAborted => '연결이 중단되었습니다';

  @override
  String get cloudApiAddressUnavailable => '네트워크 주소를 사용할 수 없습니다';

  @override
  String get cloudApiAddressInUse => '네트워크 주소 또는 포트가 이미 사용 중입니다';

  @override
  String get cloudApiNetworkResourcesExhausted => '시스템 네트워크 리소스가 부족합니다';

  @override
  String get cloudApiClockSkew =>
      '기기 시계와 서버 시계의 차이가 너무 큽니다. 자동 날짜 및 시간을 켠 후 다시 시도하세요.';

  @override
  String get cloudApiSignatureRejected =>
      '서버가 이 앱의 서명을 거부했습니다. 최신 공식 버전을 다시 설치하세요.';

  @override
  String get cloudApiServerUnconfigured =>
      '서버에 이 앱의 키가 설정되어 있지 않습니다. 고객 지원에 문의하세요.';

  @override
  String get cloudApiConfigKeyRejected =>
      '서버가 이 기기의 구성 키를 거부했습니다. 최신 공식 버전을 다시 설치하세요.';

  @override
  String get cloudApiAccountDisabled => '이 계정은 비활성화되었습니다. 고객 지원에 문의하세요.';

  @override
  String get cloudApiAccountAnomaly =>
      '이 계정은 인증이 필요합니다. 웹사이트에서 인증을 마친 후 다시 시도하세요.';

  @override
  String get cloudApiAccountNotFound => '이 계정은 더 이상 존재하지 않습니다. 다시 로그인하세요.';

  @override
  String get cloudApiInvalidResponse => '서버 응답이 유효하지 않습니다';

  @override
  String get cloudApiRequestCanceled => '요청 취소됨';

  @override
  String cloudApiSystemError(Object code) {
    return '시스템 오류 $code';
  }

  @override
  String get cloudApiTimeout => '요청 시간 초과';

  @override
  String cloudApiRouteDirect(Object error) {
    return '직접 연결: $error';
  }

  @override
  String cloudApiRouteProxy(Object error) {
    return '로컬 프록시: $error';
  }

  @override
  String get diagTitle => '네트워크 자체 점검';

  @override
  String get diagEntryHint => '코어, 시스템 프록시, TUN 및 DNS 확인';

  @override
  String get diagScope =>
      '작은 표본으로 현재 연결을 확인합니다. 시스템 네트워크 경로도 TUN을 통과할 수 있습니다. 결과가 모든 앱이나 노드에 적용되는 것은 아닙니다.';

  @override
  String get diagRun => '자체 점검 실행';

  @override
  String get diagCopy => '진단 보고서 복사';

  @override
  String get diagCanceled => '점검이 취소되어 결과가 불완전합니다';

  @override
  String get diagFixing => '수정 사항을 적용한 후 다시 확인 중입니다';

  @override
  String get diagFixFailed => '수정 사항을 적용하지 못했습니다. 위의 안내를 따라 주세요.';

  @override
  String get diagFixApplyProfile => '설정 적용';

  @override
  String get diagFixStart => '연결 시작';

  @override
  String get diagFixRestartCore => '코어 다시 시작';

  @override
  String get diagFixRestartConnection => '다시 연결';

  @override
  String get diagFixSystemProxy => '시스템 프록시 다시 적용';

  @override
  String get diagFixEnableSystemProxy => '시스템 프록시 켜기';

  @override
  String get diagFixTun => 'TUN 다시 켜기';

  @override
  String get diagFixRetest => '노드 다시 테스트';

  @override
  String get diagPassed => '통과';

  @override
  String get diagWarning => '확인 필요';

  @override
  String get diagFailed => '실패';

  @override
  String get diagUnknown => '확인할 수 없음';

  @override
  String get diagSkipped => '건너뜀';

  @override
  String get diagDisabled => '이 옵션이 켜져 있지 않습니다';

  @override
  String get diagProfile => '적용된 설정';

  @override
  String get diagProfileReady => '선택한 설정이 적용되었습니다';

  @override
  String get diagProfileMissing => '선택한 설정이 적용되지 않았습니다';

  @override
  String get diagProfileHint => '유효한 설정을 선택하고 연결을 시작한 후 다시 확인하세요.';

  @override
  String get diagCore => '코어 응답';

  @override
  String get diagCoreReady => '코어가 응답했으며 수신 포트가 활성 상태라고 보고했습니다';

  @override
  String get diagCoreUnknown => '코어 진단 응답을 사용할 수 없거나 설정이 변경되었습니다';

  @override
  String get diagCoreStopped => '코어가 트래픽 전달이 중지되었다고 보고했습니다';

  @override
  String get diagSuspended => '현재 Wi-Fi 제외 설정에 따라 트래픽 전달이 일시 중지되었습니다';

  @override
  String get diagCoreHint =>
      '연결 스위치와 Wi-Fi 제외 설정을 확인하세요. 코어가 응답하지 않으면 다시 시작하고 서로 호환되는 최신 클라이언트와 코어를 사용하세요.';

  @override
  String get diagListener => '로컬 프록시 수신';

  @override
  String get diagListenerReady => '예상한 포트가 프록시 프로토콜에 응답했습니다';

  @override
  String get diagListenerFailed => '예상한 프록시 포트가 응답하지 않거나 코어 포트와 다릅니다';

  @override
  String get diagListenerHint =>
      '포트 충돌이나 수신 중지 여부를 확인하세요. 먼저 다시 연결하고, 계속 실패하면 포트 및 인증에서 혼합 포트를 확인하거나 변경하세요.';

  @override
  String get diagSystemProxy => '시스템 프록시 설정';

  @override
  String get diagProxyReady => 'HTTP 및 HTTPS 프록시가 예상한 로컬 포트를 가리킵니다';

  @override
  String get diagProxyDisabled => '앱에서 시스템 프록시를 요청했지만 운영체제에서는 꺼져 있다고 보고했습니다';

  @override
  String get diagProxyDifferent => '운영체제 프록시가 앱 포트와 일치하지 않습니다';

  @override
  String get diagProxyAutomatic => '자동 프록시 설정이 있습니다. 실제 경로는 확인하지 못했습니다';

  @override
  String get diagProxyHint =>
      '문제 해결 및 수동 설정을 열어 시스템 프록시 주소와 포트를 비교하세요. 설정이 계속 되돌아간다면 다른 프록시 앱이나 기기 관리 정책을 확인하세요.';

  @override
  String get diagProxyAutomaticHint =>
      'PAC 스크립트나 자동 검색이 웹사이트마다 다른 프록시를 선택할 수 있습니다. 반드시 연결 장애를 뜻하는 것은 아닙니다. 변경하기 전에 설정 제공자를 확인하세요.';

  @override
  String get diagSystemDnsHint =>
      '다른 네트워크를 사용하고 운영체제에서 활성 연결의 DNS 서버를 확인하세요. 클라이언트의 DNS 덮어쓰기만 변경해서는 시스템 조회 문제가 해결되지 않을 수 있습니다.';

  @override
  String get diagProxyRecover => '비활성 로컬 프록시 끄기';

  @override
  String get diagProxyRecoverHint =>
      '먼저 연결을 중지하세요. 현재 로컬 포트에서 수신 중인 서비스가 없을 때만 해당 포트의 수동 프록시를 끕니다. 다른 주소, 포트 및 자동 설정은 유지됩니다.';

  @override
  String get diagProxyGuide => '문제 해결 및 수동 설정';

  @override
  String get diagRecheck => '다시 확인';

  @override
  String get diagOpenPortSettings => '포트 및 인증';

  @override
  String get diagOpenNetworkSettings => '네트워크 및 TUN 설정';

  @override
  String get diagOpenDnsSettings => 'DNS 덮어쓰기 설정';

  @override
  String get diagOpenSystemSettings => '시스템 설정 열기';

  @override
  String get diagOpenSettingsFailed => '시스템 설정을 열지 못했습니다. 위 경로를 따라 직접 여세요.';

  @override
  String get diagCopyProxyAddress => '프록시 주소 복사';

  @override
  String get diagProxyGuidePrepareTitle => '1. 로컬 프록시 먼저 확인';

  @override
  String get diagProxyGuidePrepare =>
      '유효한 프로필을 선택하고 FlClash에서 연결을 시작하세요. 프록시 주소를 입력하기 전에 로컬 프록시 수신 점검이 통과했는지 확인하세요.\n시스템 설정을 계속 변경할 수 있는 다른 프록시 앱을 종료하세요. 회사나 학교에서 설정을 관리하거나 설정이 잠겨 있거나 계속 되돌아간다면 관리자에게 문의하세요.';

  @override
  String get diagProxyGuideManualTitle => '2. 프록시 설정 확인 또는 입력';

  @override
  String get diagProxyGuideWindows =>
      '설정 → 네트워크 및 인터넷 → 프록시\n다른 앱이 남긴 자동 설정을 네트워크에서 더 이상 사용하지 않는다면 \'설정 스크립트 사용\'과 \'자동으로 설정 검색\'을 끄세요.\n수동 프록시 설정에서 \'프록시 서버 사용\'을 켜고 아래 주소와 포트를 각각 입력한 뒤 저장하세요. 주소 앞에 http://를 붙이지 마세요. 네트워크에 필요한 예외는 유지하세요.';

  @override
  String get diagProxyGuideMacos =>
      '시스템 설정 → 네트워크 → 활성 Wi-Fi 또는 이더넷 서비스 → 세부사항 → 프록시\nmacOS 12: 시스템 환경설정 → 네트워크 → 활성 서비스 → 고급 → 프록시\n다른 앱이 남긴 자동 설정을 더 이상 사용하지 않는다면 자동 프록시 검색과 자동 프록시 구성을 끄세요.\n웹 프록시(HTTP)와 보안 웹 프록시(HTTPS)를 켜세요. 둘 다 아래 주소와 포트를 입력한 후 저장하세요. 네트워크에 필요한 우회 항목은 유지하세요.';

  @override
  String get diagProxyGuideLinux =>
      '데스크톱 설정 → 네트워크 → 네트워크 프록시를 열고 수동을 선택하세요. 명칭은 데스크톱 환경마다 다릅니다.\nHTTP와 HTTPS에 아래 주소와 포트를 입력한 후 적용하세요. 시스템 프록시 설정 화면이 없으면 대상 앱에서 설정하세요.\n자동 설정을 바꾸기 전에 출처와 네트워크에서 여전히 필요한지 확인하세요.';

  @override
  String get diagProxyGuideApp =>
      '이 기기에서 대상 앱의 프록시 설정을 열고 HTTP 또는 SOCKS5를 선택한 뒤 아래 주소와 포트를 입력하세요.\nAndroid는 VPN 서비스를 통해 시스템 프록시를 제공합니다. VPN 연결은 FlClash 네트워크 설정에서 VPN 스위치와 앱 접근 제어를 확인하세요.';

  @override
  String get diagProxyGuideAuthenticated =>
      '로컬 프록시 인증이 켜져 있어 FlClash가 시스템 프록시를 자동 적용하지 않습니다.\n프록시 인증을 지원하는 앱에서 HTTP 또는 SOCKS5를 선택하고 아래 주소와 포트를 입력하세요. FlClash → 덮어쓰기 → 일반 → 인바운드 → 인증의 사용자 이름과 비밀번호를 사용하세요.\n진단 보고서에 인증 정보를 포함하지 마세요.';

  @override
  String diagProxyGuideValues(Object port) {
    return '로컬 주소: 127.0.0.1\n혼합 포트(현재 설정): $port\n이 기기에서만 HTTP, HTTPS 웹사이트 프록시 또는 SOCKS5에 이 혼합 포트를 사용하세요.';
  }

  @override
  String get diagProxyGuideInvalidPort =>
      '혼합 포트를 사용할 수 없습니다. 포트 및 인증에서 유효한 포트를 설정한 후 연결을 시작하세요.';

  @override
  String get diagProxyGuideVerifyTitle => '3. 저장 후 실제 앱에서 확인';

  @override
  String get diagProxyGuideVerify =>
      '돌아와서 다시 확인을 선택한 뒤 사용하는 브라우저나 앱에서 다시 시도하세요.\n로컬 프록시 점검은 통과했는데 앱에서 계속 실패한다면 해당 앱의 시스템 프록시, 사용자 지정 프록시 또는 프록시 확장 설정을 확인하세요. 시스템 프록시가 모든 앱의 트래픽을 처리하는 것은 아닙니다.\nFlClash를 중지할 때 인터넷 연결을 유지하려면 수동 설정한 프록시를 끄거나 이전 설정으로 복원해야 할 수 있습니다.';

  @override
  String get diagTun => 'TUN 인터페이스 및 경로';

  @override
  String get diagTunMissing => '활성 상태인 코어 TUN 인터페이스를 찾지 못했습니다';

  @override
  String get diagTunReady => '코어 TUN 인터페이스가 활성 상태이며 표본 IPv4 경로가 이를 사용합니다';

  @override
  String get diagTunRouteMismatch => 'TUN은 활성 상태지만 표본 IPv4 경로는 다른 인터페이스를 사용합니다';

  @override
  String get diagTunRouteUnknown => 'TUN은 활성 상태이나 IPv4 경로는 확인하지 못했습니다';

  @override
  String get diagTunHint =>
      'TUN을 껐다 켜고 시스템 권한을 승인하세요. 경로가 다르면 다른 VPN을 확인하세요. IPv6, UDP 및 앱별 제외 설정은 별도로 확인해야 합니다.';

  @override
  String get proxyConflictTitle => '프록시 충돌 가능성';

  @override
  String proxyConflictSystemProxy(Object address) {
    return '시작 전 시스템 프록시가 $address을(를) 가리키고 있었습니다.';
  }

  @override
  String get proxyConflictAutoConfig => '시작 전 시스템 프록시가 자동 설정 스크립트를 사용하고 있었습니다.';

  @override
  String proxyConflictVpn(Object name) {
    return '시작 전 트래픽이 다른 VPN 또는 가상 어댑터를 통과하고 있었습니다: $name.';
  }

  @override
  String get proxyConflictHint =>
      '다른 프록시 앱이나 VPN의 설정이라면 해당 앱을 종료하세요. 동시에 실행하면 연결에 문제가 생길 수 있습니다.';

  @override
  String get diagTrafficCapture => '트래픽 처리';

  @override
  String get diagNoCapture => '시스템 프록시와 TUN이 모두 꺼져 있습니다';

  @override
  String get diagCaptureHint => '시스템 프록시나 TUN을 켜거나 해당 앱이 로컬 프록시를 사용하도록 설정하세요.';

  @override
  String get diagSystemDns => '시스템 DNS';

  @override
  String get diagCoreDns => '코어 DNS';

  @override
  String diagProbeSummary(int passed, int total) {
    return '$total개 표본 중 $passed개 통과';
  }

  @override
  String diagProbeResult(int index, String result, int milliseconds) {
    return '검사 $index: $result · $milliseconds ms';
  }

  @override
  String get diagDnsServerFailed => 'DNS 업스트림이 서버 오류를 반환했습니다';

  @override
  String get diagDnsReady => '표본 도메인 이름을 확인했습니다';

  @override
  String get diagDnsPartial => '표본 도메인 이름 중 일부만 확인했습니다';

  @override
  String get diagOixDnsNoSample => '이번 표본에 사용할 관리형 노드 호스트 이름이 없습니다';

  @override
  String get diagOixDnsAuthMissing => '관리형 DNS 서명 기능이 준비되지 않았습니다';

  @override
  String get diagDnsNoAnswer =>
      'DNS가 사용 가능한 주소를 반환하지 않았습니다. 이것만으로 인증 실패라고 판단할 수는 없습니다';

  @override
  String get diagDnsRefused => 'DNS 요청이 거부되었습니다';

  @override
  String get diagDnsHint =>
      'DNS 덮어쓰기 설정을 확인하고 다른 네트워크를 사용하세요. 시스템 DNS는 작동하지만 코어 DNS가 실패하면 프로필의 DNS 설정을 확인하세요.';

  @override
  String get diagOixDnsHint =>
      '클라이언트 버전과 시스템 시간을 확인한 후 구독을 새로 고치세요. 계속 실패하면 이 진단 보고서를 고객 지원에 전달하세요.';

  @override
  String get diagSystemPath => '시스템 네트워크 경로';

  @override
  String get diagProxyPath => '로컬 프록시 경유';

  @override
  String diagWebResult(Object count) {
    return '독립적인 HTTPS 점검 2개 중 $count개 통과';
  }

  @override
  String get diagSystemPathHint =>
      '이 경로는 앱의 HTTP 프록시를 명시적으로 사용하지 않지만 TUN을 통과할 수 있습니다. 표본 점검 실패는 DNS, 필터링 또는 테스트 사이트 때문일 수 있습니다. 로컬 프록시 결과와 비교하세요.';

  @override
  String get diagProxyPathHint =>
      '시스템 경로가 작동한다면 선택한 노드, 라우팅 규칙 및 코어 DNS를 확인하세요. 테스트 사이트 하나의 실패가 모든 노드를 사용할 수 없다는 뜻은 아닙니다.';

  @override
  String get diagClock => '시스템 시간 비교';

  @override
  String get diagClockUnknown => '시간을 비교할 캐시되지 않은 HTTPS 응답이 부족합니다';

  @override
  String get diagClockSkew => '독립적인 두 응답에서 5분 이상의 시간 차이가 있을 가능성이 확인되었습니다';

  @override
  String get diagClockReady => '이번 표본에서 일관된 큰 시간 차이는 발견되지 않았습니다';

  @override
  String get diagClockHint =>
      '시스템의 자동 날짜 및 시간을 켠 후 다시 시도하세요. 시계 오류는 인증서와 oixCloud DNS 서명에 영향을 줄 수 있습니다.';

  @override
  String get diagAllFailed =>
      '이 그룹에서 테스트한 모든 노드가 실패했습니다. 테스트 URL에 접근할 수 없는 경우일 수도 있습니다. 네트워크 자체 점검을 실행하시겠습니까?';

  @override
  String get updateDownloadBackground => '백그라운드에서 다운로드';

  @override
  String get updateReady => '업데이트 설치 준비 완료';

  @override
  String get updateRestart => '업데이트 후 앱 다시 열기';

  @override
  String get updateRestartHint => '앱이 닫힌 뒤 현재 위치에서 업데이트되고 다시 열립니다. 설정은 유지됩니다.';

  @override
  String get updatePreparing => '업데이트 준비 중';

  @override
  String get updateVerifying => '업데이트 패키지 확인 중';

  @override
  String get updateCheckingInstaller => '설치 프로그램 확인 중';

  @override
  String get updateRestarting => '종료 후 다시 시작하는 중';

  @override
  String get updateApplyFailed =>
      '자동 업데이트를 완료하지 못했습니다. 다시 시도하거나 다운로드 페이지에서 업데이트하세요.';

  @override
  String get updateReadyHint => '업데이트를 다운로드했습니다. 편할 때 설치하세요.';

  @override
  String get updateInstall => '업데이트 설치';

  @override
  String get updateDownloading => '업데이트 다운로드 중';

  @override
  String get updateDownloadFailed => '업데이트 다운로드 실패';

  @override
  String get updateDownloadBrowser => '브라우저에서 다운로드';

  @override
  String get updatePackageFormat => '패키지 형식 선택';

  @override
  String get updatePackageFormatTip =>
      '이 버전의 설치 방식을 확인하지 못했습니다. 설치 방식에 맞는 형식을 선택하세요.';

  @override
  String get updateAppImageTip =>
      'AppImage는 자동 설치할 수 없습니다. 실행 중인 프로그램을 다운로드한 파일로 바꾸세요. 파일이 있는 폴더를 열었습니다.';

  @override
  String get updatePackageManagerTip =>
      '패키지 관리자로 설치한 버전입니다. 설치할 때와 같은 방법으로 업데이트하세요.';

  @override
  String get tunMtuDesc =>
      '기본값: 9000, 대안: 1480 또는 4064. 적용하려면 Android VPN을 다시 시작하세요';

  @override
  String get tunMtuInvalid => '1280~65535 사이의 정수를 입력하세요';

  @override
  String get scriptOptions => '스크립트 옵션';

  @override
  String get scriptOptionsEmpty => '이 스크립트에는 설정 가능한 스위치가 없습니다';

  @override
  String get scriptChanges => '스크립트 변경 사항';

  @override
  String get scriptFullConfig => '전체 설정';

  @override
  String get scriptChangesDescription =>
      '스크립트가 추가, 수정 또는 삭제한 최상위 설정 항목입니다. 전체 설정에는 앱 설정도 포함됩니다.';

  @override
  String get scriptChangesEmpty => '스크립트가 설정을 변경하지 않았습니다';

  @override
  String scriptChangesAdded(int count) {
    return '추가됨($count)';
  }

  @override
  String scriptChangesModified(int count) {
    return '수정됨($count)';
  }

  @override
  String scriptChangesRemoved(int count) {
    return '삭제됨($count)';
  }

  @override
  String get excludeNetworks => 'IP 또는 게이트웨이별 프록시 일시 중지';

  @override
  String get excludeNetworksDesc =>
      '일치하는 Wi-Fi/이더넷 IPv4 주소, 서브넷 또는 게이트웨이에서 일시 중지하고 벗어나면 재개합니다. 쉼표로 구분하세요. 예: 192.168.1.0/24,gateway:192.168.1.1';

  @override
  String get excludeNetworksInvalid =>
      '최대 16개 규칙을 사용할 수 있습니다. 올바른 IPv4, CIDR 또는 gateway:주소를 입력하세요';

  @override
  String get delayConcurrency => '일괄 지연 테스트 동시 실행 수';

  @override
  String get delayTestFailed => '실패';

  @override
  String get updateReleaseNotes => '릴리스 노트';

  @override
  String get updateDownloadConfirm => '업데이트 다운로드';

  @override
  String get updateLater => '나중에';

  @override
  String get updateCancelDownload => '다운로드 취소';

  @override
  String get updateNotice => '새 버전 감지';

  @override
  String updateVersionNumber(String version) {
    return '버전: $version';
  }

  @override
  String updateBuildNumber(String build) {
    return '빌드: $build';
  }

  @override
  String get updateReleaseNotesFailed => '릴리스 노트를 불러오지 못했습니다. 다시 시도하세요.';

  @override
  String get tailscaleEntryHint => 'tailnet의 기기에 접근';

  @override
  String get tailscaleEmptyTitle => 'tailnet에 접근';

  @override
  String get tailscaleEmptyDesc =>
      '네트워크를 추가하고 이 기기에서 로그인한 후 프록시를 시작하면 다른 기기에 접근할 수 있습니다.';

  @override
  String get tailscaleAddNetwork => '네트워크 추가';

  @override
  String get tailscaleNetworks => '네트워크';

  @override
  String get tailscaleGuide => '가이드';

  @override
  String get tailscaleThisDevice => '이 기기';

  @override
  String get tailscaleStatus => '상태';

  @override
  String get tailscaleDeviceName => '기기 이름';

  @override
  String tailscaleDevices(Object count) {
    return '기기($count)';
  }

  @override
  String get tailscaleNetworkName => '네트워크 이름';

  @override
  String get tailscaleNameInUse => '이미 사용 중인 이름입니다';

  @override
  String get tailscaleLoginMethod => '로그인 방식';

  @override
  String get tailscaleInteractiveLogin => '대화형';

  @override
  String get tailscaleAuthKey => '인증 키';

  @override
  String get tailscaleAuthKeySaved => '이 기기에 인증 키가 저장되어 있습니다. 바꾸려면 새 키를 입력하세요.';

  @override
  String get tailscaleLoginFooter => '이 기기에서 네트워크마다 한 번씩 로그인하세요.';

  @override
  String get tailscaleAutoRoute => '자동 라우팅';

  @override
  String get tailscaleAutoRouteDesc =>
      '피어 주소, MagicDNS 이름 및 승인된 서브넷의 트래픽을 이 네트워크로 전달합니다';

  @override
  String get tailscaleExitNode => '출구 노드';

  @override
  String get tailscaleExitNodeDesc =>
      '사용하지 않으려면 비워 두세요. auto, 피어 이름 또는 피어 IP 주소를 입력할 수 있습니다.';

  @override
  String get tailscaleAvailableExitNodes => '사용 가능한 출구 노드';

  @override
  String get tailscaleExitNodeAllowLan => '로컬 네트워크 접근 허용';

  @override
  String get tailscaleAdvanced => '고급';

  @override
  String get tailscaleControlUrl => '제어 서버 URL';

  @override
  String get tailscaleCredentialsFooter => '인증 정보와 기기 ID는 이 기기에만 보관됩니다.';

  @override
  String get tailscaleAccount => '계정';

  @override
  String get tailscaleSaveAndLogin => '저장 후 로그인';

  @override
  String get tailscaleOpenLoginPage => '로그인 페이지 열기';

  @override
  String get tailscaleLoginWaiting =>
      '로그인 페이지를 열거나 코드를 스캔하세요. 승인 후 로그인이 자동으로 완료됩니다.';

  @override
  String get tailscaleSigningIn => '로그인 중';

  @override
  String get tailscaleSignedIn => '로그인됨';

  @override
  String get tailscaleLogout => '로그아웃';

  @override
  String get tailscaleLoginFailed => 'Tailscale 로그인 실패';

  @override
  String get tailscaleLoginTimeout => '5분 내에 로그인을 완료하지 못했습니다. 다시 시도하세요.';

  @override
  String get tailscaleLoginHint => '로그인하면 이 기기가 승인됩니다. 네트워크를 사용하려면 프록시를 시작하세요.';

  @override
  String get tailscaleEnterAuthKey => '이 기기에서 로그인하려면 인증 키를 입력하세요.';

  @override
  String tailscaleCheckSettings(Object fields) {
    return '다음 설정을 확인하세요: $fields';
  }

  @override
  String get tailscaleNotApplied => '적용되지 않음';

  @override
  String get tailscaleNotAppliedHint =>
      '실행 중인 설정에 이 네트워크가 없습니다. 프로필을 선택하고 같은 이름의 노드가 없는지 확인하세요.';

  @override
  String get tailscaleNotSignedIn => '로그인하지 않음';

  @override
  String get tailscaleNeedsLogin => '로그인 필요';

  @override
  String get tailscaleKeyExpired => '노드 키가 만료되었습니다';

  @override
  String get tailscaleNeedsApproval => '기기 승인 대기 중';

  @override
  String get tailscaleConnecting => '연결 중';

  @override
  String get tailscaleConnected => '연결됨';

  @override
  String get tailscaleStopped => '중지됨';

  @override
  String get tailscaleUnavailable => '연결할 수 없음';

  @override
  String get tailscaleOnline => '온라인';

  @override
  String get tailscaleOffline => '오프라인';

  @override
  String get tailscaleRemoveNetwork => '네트워크 제거';

  @override
  String tailscaleRemoveConfirm(Object name) {
    return '이 기기가 $name에서 나가고 기기에 저장된 로그인 정보가 삭제됩니다. 현재 네트워크에 연결할 수 없다면 Tailscale 관리 콘솔에서 기기를 제거하세요.';
  }

  @override
  String tailscaleNetworkInUse(Object name, Object profile) {
    return '프로필 $profile의 규칙 또는 그룹이 아직 $name을(를) 사용하고 있습니다';
  }

  @override
  String get tailscaleGuideGetStarted => '시작하기';

  @override
  String get tailscaleGuideGetStartedBody =>
      '네트워크를 추가하고 \'저장 후 로그인\'을 선택하세요. 로그인 페이지에서 이 기기를 승인하면 로그인이 자동으로 완료됩니다.\n인증 키로 로그인하려면 \'인증 키\'를 선택하고 키를 입력하세요. 브라우저가 필요하지 않습니다.\n프록시가 실행 중일 때만 네트워크가 트래픽을 전달합니다. 로그인만으로는 트래픽을 라우팅하지 않습니다.';

  @override
  String get tailscaleGuideDevices => '기기 및 MagicDNS';

  @override
  String get tailscaleGuideDevicesBody =>
      '자동 라우팅은 알려진 피어의 주소와 MagicDNS 이름, tailnet에서 승인된 서브넷을 이 네트워크로 전달합니다. 나머지 트래픽은 기존 규칙을 따릅니다.\n추가 규칙과 사용자 지정 규칙 뒤, 프로필 자체 규칙 앞에서 적용됩니다.\n사용자 지정 제어 서버 도메인을 사용하는 경우 알려진 기기 이름만 라우팅하므로 해당 도메인의 공개 사이트는 계속 접근할 수 있습니다.\n현재 연결된 로컬 네트워크 안의 서브넷 주소는 로컬에 남습니다. 같은 주소를 쓰는 원격 서브넷에 접근하려면 이 네트워크를 가리키는 규칙을 추가하세요.\n승인된 서브넷으로 해석되는 호스트 이름도 이 네트워크를 통과합니다. 프로필이 해당 이름을 프록시로 바로 전달한다면 이 네트워크를 가리키는 도메인 규칙을 추가하세요.';

  @override
  String get tailscaleGuideExitNodes => '출구 노드';

  @override
  String get tailscaleGuideExitNodesBody =>
      '출구 노드를 지정하면 프로필의 선택 그룹에 네트워크가 나타납니다. 해당 그룹에서 네트워크를 선택하거나 규칙의 대상으로 지정한 후에만 트래픽이 출구 노드를 사용합니다.\n출구 노드를 사용하지 않으려면 비워 두세요. auto는 사용 가능한 출구 노드를 선택하며, 기기 이름이나 주소를 입력하면 해당 기기를 선택합니다.';

  @override
  String get tailscaleGuideSignIn => '로그인 및 백업';

  @override
  String get tailscaleGuideSignInBody =>
      '네트워크 설정은 백업에 포함됩니다. 인증 키와 기기 ID는 이 기기에만 보관되므로 다른 기기에 복원한 후에는 다시 로그인하세요.\n노드 키가 만료되면 \'저장 후 로그인\'을 다시 선택하세요. 기기 승인과 접근 권한은 tailnet에서 관리합니다.\n네트워크를 제거하면 이 기기가 로그아웃되고 기기에 저장된 ID가 삭제됩니다.';

  @override
  String get tailscaleGuideTroubleshooting => '문제 해결';

  @override
  String get tailscaleGuideTroubleshootingBody =>
      '프록시가 실행 중이고 이 기기가 승인되었으며 피어가 온라인인지 확인하세요. 서브넷이나 인터넷에 접근하려면 경로 승인과 출구 노드도 확인하세요.\n\'적용되지 않음\'은 실행 중인 설정에 네트워크가 없다는 뜻입니다. 프로필을 선택하고 같은 이름의 노드가 없는지 확인하세요.\n이 앱은 tailnet으로 나가는 연결만 만듭니다. 들어오는 연결을 받지 않으며 이 기기를 서브넷 라우터나 출구 노드로 제공하지 않습니다.';

  @override
  String get tailscaleNameInvalid => '쉼표 없이 최대 64자를 사용하세요';

  @override
  String get tailscaleHostnameInvalid => '소문자, 숫자 및 하이픈을 사용하여 최대 63자로 입력하세요';

  @override
  String get tailscaleAuthKeyInvalid => '인증 키 형식이 올바르지 않은 것 같습니다';

  @override
  String get tailscaleDirect => '직접 연결';

  @override
  String tailscaleRelay(Object region) {
    return '중계 $region';
  }

  @override
  String get tailscaleExitNodeActive => '사용 중인 출구 노드';

  @override
  String get quickAdd => '빠른 추가';

  @override
  String get rulePresetBlockQuic => 'QUIC 차단';

  @override
  String get rulePresetBlockStun => 'STUN 차단';

  @override
  String get rulePresetBlockDot => 'DNS over TLS 차단';

  @override
  String get rulePresetBlockLoopback => '프록시 루프백 차단';

  @override
  String get rulePresetLanDirect => 'LAN 직접 연결';

  @override
  String get rulePresetSystemServicesDirect => 'Apple 및 Microsoft 직접 연결';

  @override
  String get rulePresetBittorrentDirect => 'BitTorrent 직접 연결';

  @override
  String get rulePresetInsertHint =>
      '선택한 사전 설정을 기존 규칙 앞에 추가합니다. 동일한 규칙은 다시 추가하지 않습니다.';

  @override
  String get overwriteIssueEmptyName => '이름이 비어 있습니다';

  @override
  String overwriteIssueReservedName(Object name) {
    return '$name은(는) 기본 정책 이름이므로 여기서 사용할 수 없습니다';
  }

  @override
  String overwriteIssueDuplicateName(Object name) {
    return '다른 프록시 또는 프록시 그룹이 이미 이름 $name을(를) 사용하고 있습니다';
  }

  @override
  String get overwriteIssueNoProxySource =>
      '프록시나 프록시 공급자가 선택되지 않아 코어가 이 그룹을 거부합니다';

  @override
  String overwriteIssueMissingProxies(Object names) {
    return '다음 프록시 또는 정책이 없습니다: $names';
  }

  @override
  String overwriteIssueMissingProviders(Object names) {
    return '다음 프록시 공급자가 없습니다: $names';
  }

  @override
  String overwriteIssueEmptyFallback(Object name) {
    return '빈 그룹의 대체 대상은 프록시 그룹이 아닌 기존 노드 또는 기본 아웃바운드여야 합니다: $name';
  }

  @override
  String overwriteIssueGroupLoop(Object path) {
    return '프록시 그룹이 순환 참조하고 있습니다: $path';
  }

  @override
  String invalidPolicy(Object target) {
    return '올바르지 않은 정책: $target';
  }

  @override
  String invalidRuleSet(Object ruleSet) {
    return '올바르지 않은 규칙 세트: $ruleSet';
  }

  @override
  String invalidSubRule(Object subRule) {
    return '올바르지 않은 SUB_RULE: $subRule';
  }

  @override
  String get safeMode => '안전 모드';

  @override
  String safeModeAppTitle(Object appName) {
    return '$appName (안전 모드)';
  }

  @override
  String get hideTimeoutProxies => '실패한 노드 숨기기';

  @override
  String get delayTestQueued => '대기 중';

  @override
  String get delayTestRunning => '테스트 중';

  @override
  String get dnsQueries => 'DNS 쿼리';

  @override
  String get dnsQueriesDesc => '최근 DNS 조회 500개 보기';

  @override
  String get dnsQueryCached => '캐시됨';

  @override
  String get dnsQueryUpstream => '상위 서버';

  @override
  String get dnsQueryAnswers => '응답';

  @override
  String get dnsQueryRcode => '응답 코드';

  @override
  String get dnsQueryType => '조회 유형';

  @override
  String get pauseUpdates => '새로 고침 일시 중지';

  @override
  String get resumeUpdates => '새로 고침 재개';

  @override
  String get dnsQueryAll => '모든 조회';

  @override
  String get dnsQueryFailures => '실패한 조회';

  @override
  String get dnsQueryInitiatorApp => '애플리케이션';

  @override
  String get dnsQueryInitiatorRule => '규칙 일치';

  @override
  String get dnsQueryInitiatorDirect => '직접 연결';

  @override
  String get dnsQueryInitiatorProxy => '프록시 연결';

  @override
  String get dnsQueryInitiatorOther => '기타';

  @override
  String get action_ruleMode => '규칙 모드';

  @override
  String get action_globalMode => '글로벌 모드';

  @override
  String get action_directMode => '직접 연결 모드';

  @override
  String get action_delayTest => '노드 지연 테스트';

  @override
  String get action_updateProfiles => '프로필 업데이트';

  @override
  String get action_copyEnv => '프록시 환경 변수 복사';

  @override
  String get action_exit => '종료';

  @override
  String get hotkeyUnavailable => '단축키를 사용할 수 없음';

  @override
  String get runTime => '가동 시간';

  @override
  String get floatingNavigationBar => '플로팅 탐색';

  @override
  String get localNetworkTip =>
      '로컬 네트워크 접근이 거부되어 이번 연결에는 gVisor를 사용합니다. LAN 프록시와 서비스는 계속 사용할 수 없을 수 있습니다';

  @override
  String get sidebar => '사이드바';

  @override
  String get backgroundBlur => '배경 흐림';

  @override
  String get sidebarBlurDesc => '배경 흐림은 창 뒤의 바탕화면을 사이드바에 비쳐 보이게 합니다.';

  @override
  String get format => '형식';

  @override
  String get behavior => '동작';

  @override
  String get appProviderLibrary => '공급자 라이브러리';

  @override
  String get providerLocal => '로컬 파일';

  @override
  String get providerRemote => '원격 URL';

  @override
  String get providerContent => '리소스 내용';

  @override
  String get providerContentInvalid => '리소스 내용 또는 형식이 유효하지 않습니다';

  @override
  String get providerContentTooLarge => '리소스가 32 MiB를 초과합니다';

  @override
  String get providerChanged => '편집 중 리소스가 변경되었습니다. 다시 열어 시도하세요';

  @override
  String get providerNameInvalid => '쉼표와 줄바꿈이 없는 이름을 입력하세요';

  @override
  String providerInUse(String profiles) {
    return '$profiles에서 아직 이 리소스를 사용하고 있습니다';
  }

  @override
  String providerRenameShadowed(String profiles) {
    return '이름을 변경하면 $profiles의 구독 리소스 참조가 달라집니다';
  }

  @override
  String get providerUrlTip => '인증 정보가 포함되지 않은 HTTP 또는 HTTPS URL을 입력하세요';

  @override
  String providerSourceReference(String profiles) {
    return '이름을 변경하기 전에 원본 프로필의 참조를 수정하세요: $profiles';
  }

  @override
  String providerSourceUnavailable(String profiles) {
    return '참조를 확인하기 위해 다음 프로필을 읽을 수 없습니다: $profiles';
  }

  @override
  String get nodeDefinition => '노드 정의';

  @override
  String get nodeQuickFields => '빠른 편집';

  @override
  String get nodeCoreValidationUnavailable => '이 노드를 검증하기 전에 코어를 시작하세요';

  @override
  String get nodeInvalidDefinition => '이름과 유형을 포함한 완전한 프록시 정의를 입력하세요';

  @override
  String get releaseMemory => '메모리 해제';

  @override
  String get memoryCoreHeapInuse => '사용 중인 힙';

  @override
  String get memoryCoreHeapIdle => '유휴 힙';

  @override
  String get memoryCoreStack => '고루틴 스택';

  @override
  String get memoryCoreRuntime => '런타임 오버헤드';

  @override
  String get memoryCoreNotRunning => '코어가 실행 중이 아닙니다';

  @override
  String get memoryAppResident => '상주 메모리';

  @override
  String get memoryAppShared => '앱 및 공유';

  @override
  String get memoryEstimateDesc =>
      '프로세스 상주 메모리로 추정한 값이며 시스템에 표시되는 값과 다를 수 있습니다.';

  @override
  String get memoryEstimateSharedDesc =>
      '코어는 앱 프로세스 안에서 실행됩니다. 코어의 점유량은 런타임 통계로 추정하며, 나머지는 앱 및 공유 메모리로 집계합니다.';

  @override
  String get memoryReleased => '메모리를 해제했습니다';

  @override
  String memoryReleasedSize(Object size) {
    return '$size 해제됨';
  }

  @override
  String get releaseMemoryFailed => '메모리를 해제하지 못했습니다';

  @override
  String get total => '합계';

  @override
  String get showNotificationStopAction => '알림에 중지 버튼 표시';

  @override
  String get interfaceName => '인터페이스 이름';

  @override
  String get interfaceNameMode => '아웃바운드 인터페이스';

  @override
  String get interfaceNameDesc => '인터페이스 이름은 아웃바운드 연결이 사용하는 네트워크 인터페이스입니다.';

  @override
  String get interfaceFollowProfile => '프로필 따르기';

  @override
  String get interfaceAutomatic => '덮어쓰기 해제(자동 인터페이스)';

  @override
  String get hideIp => 'IP 숨기기';

  @override
  String get cameraPermissionRequired => '카메라 권한 필요';

  @override
  String get cameraPermissionDesc =>
      'QR 코드를 스캔하려면 시스템 설정에서 카메라 접근을 허용하거나, 앨범에서 QR 코드 이미지를 선택하세요.';

  @override
  String get cameraUnavailable => '카메라를 사용할 수 없음';

  @override
  String get invalidProfileQrcode => '이 QR 코드에는 프로필 링크가 없습니다';

  @override
  String get pickFromAlbum => '앨범에서 선택';

  @override
  String get retry => '다시 시도';

  @override
  String get toggleFlashlight => '손전등 켜기/끄기';

  @override
  String get networkTimeoutError => '요청 시간이 초과되었습니다. 네트워크나 프록시를 확인한 후 다시 시도하세요';

  @override
  String get networkHostLookupError =>
      '서버 주소를 확인할 수 없습니다. URL이 올바른지, DNS가 정상인지 확인하세요';

  @override
  String get monochromeIcon => '모노크롬 아이콘';

  @override
  String get networkConnectionError =>
      '서버에 연결할 수 없습니다. 네트워크 연결이나 프록시 설정을 확인하세요';

  @override
  String get networkTlsError =>
      '보안 연결에 실패했습니다. 서버 인증서가 올바르지 않거나 연결이 가로채이고 있을 수 있습니다';

  @override
  String get networkCancelledError => '요청이 취소되었습니다';

  @override
  String networkAccessDeniedError(Object code) {
    return '서버가 접근을 거부했습니다(HTTP $code). 링크가 만료되었거나 자격 증명이 잘못되었을 수 있습니다';
  }

  @override
  String networkNotFoundError(Object code) {
    return '이 주소에서 아무것도 찾지 못했습니다(HTTP $code). URL이 올바른지 확인하세요';
  }

  @override
  String get networkRateLimitedError => '요청이 너무 많습니다(HTTP 429). 잠시 후 다시 시도하세요';

  @override
  String networkServerError(Object code) {
    return '서버에 문제가 발생했습니다(HTTP $code). 나중에 다시 시도하세요';
  }

  @override
  String networkBadResponseError(Object code) {
    return '서버가 요청을 거부했습니다(HTTP $code)';
  }

  @override
  String get clipboardWriteFailed => '클립보드에 복사하지 못했습니다. 선택 영역이 너무 클 수 있습니다';

  @override
  String get lineWrap => '자동 줄 바꿈';

  @override
  String get previousMatch => '이전 결과';

  @override
  String get nextMatch => '다음 결과';

  @override
  String get editorUnavailable => '편집기를 사용할 수 없음';

  @override
  String get replaceAll => '모두 바꾸기';

  @override
  String get fontSize => '크기';

  @override
  String get replace => '바꾸기';

  @override
  String get locateSelected => '선택한 노드 찾기';

  @override
  String get expandList => '펼치기';

  @override
  String get collapseList => '접기';

  @override
  String get clearSearch => '검색 지우기';

  @override
  String get closeAllConnections => '모든 연결 닫기';

  @override
  String get showMore => '펼치기';

  @override
  String get showLess => '접기';

  @override
  String get showPassword => '비밀번호 표시';

  @override
  String get hidePassword => '비밀번호 숨기기';

  @override
  String get switchProfile => '프로필 전환';

  @override
  String get subscriptionInfo => '구독 정보';

  @override
  String get lastUpdated => '마지막 업데이트';

  @override
  String proxiesCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '프록시 $count개',
      one: '프록시 1개',
    );
    return '$_temp0';
  }

  @override
  String rulesCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '규칙 $count개',
      one: '규칙 1개',
    );
    return '$_temp0';
  }

  @override
  String get back => '뒤로';

  @override
  String get noSearchResults => '일치하는 결과 없음';

  @override
  String get proxyNode => '프록시 노드';

  @override
  String get rules => '규칙';

  @override
  String get addOverrideEntry => '덮어쓰기 항목 추가';

  @override
  String get batchAdd => '일괄 추가';

  @override
  String get batchListInputTip => '한 줄에 하나씩 또는 쉼표로 구분하여 입력하세요';

  @override
  String get batchMapInputTip => '한 줄에 하나씩, 키, 공백, 값 순서로 입력하세요';

  @override
  String batchPreviewTip(Object count, Object skipped) {
    return '추가 $count개, 이미 있어서 건너뜀 $skipped개';
  }

  @override
  String get cacheAlgorithm => '캐시 알고리즘';

  @override
  String get cacheMaxSize => '캐시 크기';

  @override
  String get dialerProxy => '다이얼러 프록시';

  @override
  String get dialerProxyDesc => '다이얼러 프록시는 NTP 서버에 연결할 때 사용하는 아웃바운드입니다.';

  @override
  String dialerProxyLoopStopped(Object name) {
    return '$name을(를) 거치는 다이얼이 이를 사용하는 프록시로 되돌아와 연결을 중단했습니다';
  }

  @override
  String get discardChanges => '변경 사항을 취소하시겠습니까?';

  @override
  String get fakeipFilterMode => 'Fake-IP 필터 모드';

  @override
  String get fakeipFilterModeDesc =>
      'Fake-IP 필터 모드에서 블랙리스트는 일치 항목을 제외하고, 화이트리스트는 일치 항목에만 가짜 IP를 사용하며, 규칙은 규칙에 따라 일치시킵니다.';

  @override
  String get fakeipRange6 => 'Fake-IP 범위(IPv6)';

  @override
  String get fakeipTtl => 'Fake-IP TTL';

  @override
  String get ipv6Timeout => 'IPv6 타임아웃(ms)';

  @override
  String lineIssueTip(Object line, Object message) {
    return '$line행: $message';
  }

  @override
  String get listenRoutingMark => '수신 라우팅 마크';

  @override
  String get listenRoutingMarkDesc => '수신 라우팅 마크는 Linux에서만 작동합니다.';

  @override
  String maxLengthTip(Object label, Object max) {
    return '$label은(는) 최대 $max자까지 입력할 수 있습니다';
  }

  @override
  String get ntpInterval => '동기화 간격(분)';

  @override
  String get ntpStatusDesc => 'NTP는 시스템 시계 대신 NTP 서버에서 시간을 가져옵니다.';

  @override
  String get overrideEntries => '덮어쓰기 항목';

  @override
  String get quickEdit => '빠른 편집';

  @override
  String get server => '서버';

  @override
  String get singleAdd => '개별 추가';

  @override
  String singleValueTip(Object label) {
    return '$label은(는) 하나만 입력해야 합니다';
  }

  @override
  String get writeToSystem => '시스템에 기록';

  @override
  String get writeToSystemDesc => '시스템에 기록하면 시스템 시계도 설정합니다. Android에서는 무시됩니다.';

  @override
  String get basicInfo => '기본 정보';

  @override
  String get ruleActionIpSuffixDesc => 'IP 접미사 범위 일치';

  @override
  String get ruleActionDomainSuffixDesc => '도메인 접미사 일치';

  @override
  String get ruleActionMatchDesc => '모든 요청과 일치, 조건 불필요';

  @override
  String get ruleActionSrcGeoipDesc => '출발지 IP의 국가 코드 일치';

  @override
  String get ruleActionDomainWildcardDesc => '와일드카드 일치, *와 ?만 지원';

  @override
  String get ruleActionAndDesc => '논리 규칙 AND';

  @override
  String get ruleActionIpCidr6Desc => 'IP 주소 범위 일치, IP-CIDR6는 별칭일 뿐입니다';

  @override
  String get ruleActionDomainRegexDesc => '도메인 정규식 일치';

  @override
  String get ruleActionProcessPathRegexDesc => '프로세스 경로 정규식으로 일치';

  @override
  String get ruleActionDstPortDesc => '목적지 포트 범위 일치';

  @override
  String get ruleActionDscpDesc => 'DSCP 마크 일치(tproxy UDP 인바운드 전용)';

  @override
  String get ruleActionInPortDesc => '인바운드 포트 일치';

  @override
  String get ruleActionUidDesc => 'Linux 사용자 ID 일치';

  @override
  String get ruleActionIpCidrDesc => 'IP 주소 범위 일치';

  @override
  String get ruleActionRuleSetDesc => '규칙 세트 참조, rule-providers 필요';

  @override
  String get ruleActionGeositeDesc => 'Geosite의 도메인 일치';

  @override
  String get ruleActionNetworkDesc => 'TCP 또는 UDP 일치';

  @override
  String get ruleActionProcessPathDesc => '전체 프로세스 경로로 일치';

  @override
  String get ruleActionProcessPathWildcardDesc => '프로세스 경로 와일드카드로 일치, *와 ?만 지원';

  @override
  String get ruleActionRematchNameDesc => '리매치 이름 일치, 여러 이름은 /로 구분';

  @override
  String get ruleActionSrcIpSuffixDesc => '출발지 IP 접미사 범위 일치';

  @override
  String get ruleActionGeoipDesc => 'IP의 국가 코드 일치';

  @override
  String get ruleActionInUserDesc => '인바운드 사용자 이름 일치, 여러 사용자 이름은 /로 구분';

  @override
  String get invalidNetworkContent => 'tcp 또는 udp만 지원합니다';

  @override
  String get ruleActionDomainKeywordDesc => '도메인 키워드 일치';

  @override
  String get ruleActionNotDesc => '논리 규칙 NOT';

  @override
  String get ruleActionSrcIpAsnDesc => '출발지 IP의 ASN 일치';

  @override
  String get invalidRangeContent => '80 또는 8000-9000과 같은 숫자나 범위를 /로 구분하여 입력하세요';

  @override
  String get ruleActionProcessNameRegexDesc =>
      '프로세스 이름 정규식으로 일치, Android에서는 패키지 이름과 일치';

  @override
  String get ruleActionSrcIpCidrDesc => '출발지 IP 주소 범위 일치';

  @override
  String get ruleActionDomainDesc => '전체 도메인 일치';

  @override
  String get ruleActionInNameDesc => '인바운드 이름 일치';

  @override
  String get invalidDscpContent => 'DSCP 마크는 63을 넘을 수 없습니다';

  @override
  String get invalidCidrContent => '192.168.0.0/16과 같은 CIDR 형식의 IP 범위를 입력하세요';

  @override
  String get invalidIpv6CidrContent => 'fd00::/8처럼 CIDR 형식의 IPv6 범위를 입력하세요';

  @override
  String get invalidHostContent => '도메인 또는 IP 주소를 입력하세요';

  @override
  String get invalidListenContent => '0.0.0.0:1053과 같은 주소와 포트를 입력하세요';

  @override
  String get ruleActionIpAsnDesc => 'IP의 ASN 일치';

  @override
  String get ruleActionSrcPortDesc => '출발지 포트 범위 일치';

  @override
  String get ruleActionInTypeDesc => '인바운드 유형 일치';

  @override
  String get ruleActionOrDesc => '논리 규칙 OR';

  @override
  String get ruleActionSubRuleDesc => '하위 규칙으로 일치, 괄호에 유의';

  @override
  String get ruleActionProcessNameWildcardDesc => '프로세스 이름 와일드카드로 일치, *와 ?만 지원';

  @override
  String get ruleActionProcessNameDesc => '프로세스 이름으로 일치, Android에서는 패키지 이름과 일치';

  @override
  String get general => '일반';

  @override
  String get startupAndBackground => '시작 및 백그라운드';

  @override
  String get inbound => '인바운드';

  @override
  String get outbound => '아웃바운드';

  @override
  String get logsAndDiagnostics => '로그 및 진단';

  @override
  String get onDemand => '필요 시 실행';

  @override
  String get onDemandDesc => 'Wi-Fi 또는 네트워크 상태에 따라 프록시를 일시 중지하거나 재개합니다';

  @override
  String get prerequisites => '사전 요건';

  @override
  String get suspended => '일시 중지됨…';

  @override
  String get enabled => '사용';

  @override
  String get enabledOnStart => '시작 시 켜기';

  @override
  String get disabled => '사용 안 함';

  @override
  String overwriteIssuesSummary(Object count) {
    return '$count개 항목에 문제가 있어 덮어쓰기 적용에 실패할 수 있습니다';
  }

  @override
  String get ignoreBatteryOptimization => '배터리 최적화 무시';

  @override
  String get batteryOptimizationDesc => '배터리 최적화를 무시하면 앱이 백그라운드에서 계속 실행됩니다.';

  @override
  String get batteryOptimizationStatusTip =>
      '시스템 제한으로 인해 실행 중에는 배터리 최적화 상태를 정확히 읽을 수 없습니다';

  @override
  String get authorized => '허용됨';

  @override
  String get tapToAuthorize => '눌러서 허용';

  @override
  String get addSsid => 'SSID 추가';

  @override
  String get editSsid => 'SSID 편집';

  @override
  String get ssidsEmpty => 'SSID가 비어 있습니다';

  @override
  String get hotkeyDesc => '전역 단축키는 창이 숨겨져 있어도 작동합니다. 동작을 눌러 키 조합을 기록하세요.';

  @override
  String get hotkeyNotSet => '설정 안 됨';

  @override
  String hotkeyNeedsModifier(Object modifiers) {
    return '$modifiers 중 하나 이상을 포함하세요';
  }

  @override
  String hotkeyConflictWith(Object action) {
    return '이미 “$action”에서 사용 중입니다. 저장하면 이쪽으로 옮겨집니다.';
  }

  @override
  String get confirmExitWindow => '현재 창을 닫으시겠습니까?';

  @override
  String get dataChangedSave => '변경된 데이터가 있습니다. 저장하시겠습니까?';

  @override
  String get discard => '버리기';

  @override
  String get docked => '고정';

  @override
  String get fade => '페이드';

  @override
  String get floating => '플로팅';

  @override
  String get followSystem => '시스템 설정 따르기';

  @override
  String get navigationBarStyle => '하단 바';

  @override
  String get pureBlack => '퓨어 블랙';

  @override
  String get slide => '슬라이드';

  @override
  String get textScalePreview => '앱의 글자가 이렇게 표시됩니다';

  @override
  String get basicStrategy => '기본 전략';

  @override
  String get nonTextProviderFile => '이 외부 리소스는 텍스트 파일이 아닙니다';

  @override
  String get scriptChanged => '스크립트가 변경되거나 삭제되었습니다. 다시 열어 시도하세요.';

  @override
  String get startFromScratch => '처음부터 시작';

  @override
  String get optional => '선택 사항';

  @override
  String get coreBlockedBySmartAppControlTip =>
      'Windows가 FlClashCore.exe를 차단했으며 스마트 앱 컨트롤이 켜져 있습니다. Windows 보안 → 앱 및 브라우저 컨트롤에서 차단 세부 정보를 확인하고 신뢰할 수 있는 검증된 버전을 사용하세요.';

  @override
  String get helperCorruptTip =>
      '헬퍼 서비스를 사용할 수 없어 TUN 모드를 켤 수 없습니다. FlClash를 다시 설치하여 복구하세요.';

  @override
  String get changeProxyFailedTip => '프록시를 전환하지 못해 이전 선택을 복원했습니다';

  @override
  String get databaseWriteFailedTip =>
      '변경 사항을 저장하지 못했습니다. 현재 값을 확인한 후 다시 시도하세요.';

  @override
  String get proxyType => '프록시 유형';

  @override
  String get providerSourceSubscription => '구독';

  @override
  String get providerSourceProfile => '프로필';

  @override
  String get providerSourceApp => '앱 라이브러리';

  @override
  String get target => '대상';

  @override
  String get outboundExit => '출구';

  @override
  String get protocol => '프로토콜';

  @override
  String get traffic => '트래픽';

  @override
  String get totalDownload => '다운로드량';

  @override
  String get totalUpload => '업로드량';

  @override
  String get duration => '소요 시간';

  @override
  String get initiatorShort => '출처';

  @override
  String get result => '결과';

  @override
  String get elapsed => '소요';

  @override
  String get tunOverrideDesc =>
      '여기에 추가한 항목은 모든 프로필의 TUN 설정을 대체합니다. 추가하지 않은 항목은 프로필 자체 설정을 유지합니다. 사용자 지정 프로필이 직접 추가한 항목이 우선합니다.';

  @override
  String get dnsOverrideDesc =>
      '여기에 추가한 항목은 모든 프로필의 DNS 설정을 대체하며, 추가하지 않은 항목은 각 프로필의 설정을 유지합니다. 사용자 지정 프로필 자체의 항목이 우선합니다';

  @override
  String get ntpOverrideDesc =>
      '여기에 추가한 항목은 모든 프로필의 NTP 설정을 대체하며, 추가하지 않은 항목은 각 프로필의 설정을 유지합니다. 사용자 지정 프로필 자체의 항목이 우선합니다';

  @override
  String get congestionController => 'TCP 혼잡 제어';

  @override
  String get congestionControllerDesc => 'TCP 혼잡 제어는 mips 스택에서만 작동합니다.';

  @override
  String get strictRoute => '엄격한 라우팅';

  @override
  String get strictRouteDesc =>
      '엄격한 라우팅은 DNS 등의 트래픽이 TUN을 우회하지 못하게 하며, IPv6가 꺼져 있으면 이 기기의 IPv6 연결을 차단합니다.';

  @override
  String get routeExcludeAddress => '라우팅 제외 주소';

  @override
  String get udpTimeout => 'UDP 시간 제한';

  @override
  String get udpTimeoutDesc =>
      'UDP 시간 제한은 초 단위이며 gvisor, system, mixed 스택에서만 작동합니다.';

  @override
  String get dnsHijackDesc => '추가하지 않으면 53번 포트로 가는 모든 DNS 쿼리를 하이재킹합니다(any:53).';

  @override
  String get disableIcmpForwarding => 'ICMP 전달 사용 안 함';

  @override
  String get disableIcmpForwardingDesc =>
      'ICMP 전달을 끄면 TUN이 ping에 직접 응답하므로 ping에 실제 지연 시간이 표시되지 않습니다.';

  @override
  String get includeInterface => '포함할 인터페이스';

  @override
  String get includeInterfaceDesc =>
      '포함할 인터페이스로 들어오는 트래픽만 TUN을 거치며, 제외할 인터페이스는 더 이상 적용되지 않습니다.';

  @override
  String get excludeInterface => '제외할 인터페이스';

  @override
  String get excludeInterfaceDesc =>
      'docker0와 같이 제외할 인터페이스로 들어오는 트래픽은 TUN을 거치지 않습니다.';

  @override
  String get includeUid => '포함할 사용자 ID';

  @override
  String get includeUidDesc => '포함할 사용자 ID의 프로세스 트래픽만 TUN을 거칩니다.';

  @override
  String get excludeUid => '제외할 사용자 ID';

  @override
  String get excludeUidDesc => '제외할 사용자 ID의 프로세스 트래픽은 TUN을 거치지 않습니다.';

  @override
  String get excludeSrcPort => '제외할 소스 포트';

  @override
  String get excludeSrcPortDesc => '제외할 소스 포트에서 나가는 트래픽은 TUN을 거치지 않습니다.';

  @override
  String get excludeDstPort => '제외할 대상 포트';

  @override
  String get excludeDstPortDesc => '제외할 대상 포트로 가는 트래픽은 TUN을 거치지 않습니다.';

  @override
  String numberRangeTip(Object label, Object min, Object max) {
    return '$label은(는) $min에서 $max 사이여야 합니다';
  }

  @override
  String get customProfile => '사용자 지정 프로필';

  @override
  String get customProfileDesc => '내 노드, 공급자 라이브러리 및 다른 프로필로 프록시 그룹과 규칙 구성';

  @override
  String get emptyCustomProfile => '먼저 이 사용자 지정 프로필에 프록시 그룹 또는 규칙을 추가하세요';

  @override
  String get nameCustomProfileTip => '이 사용자 지정 프로필의 이름을 입력하세요';

  @override
  String profileProviderInUse(Object profiles) {
    return '이 프로필은 $profiles의 프록시 공급자입니다. 먼저 해당 프로필에서 제거하세요.';
  }

  @override
  String get healthCheck => '상태 확인';

  @override
  String get additionalPrefix => '이름 접두사';

  @override
  String get additionalSuffix => '이름 접미사';

  @override
  String get ipVersion => 'IP 버전';

  @override
  String get profileSettingsDesc => '이 프로필에만 적용되며, 추가하지 않은 항목은 기본값을 사용합니다.';

  @override
  String get profileOverrideSettingsDesc =>
      '이 프로필에만 적용되며 앱의 DNS 및 NTP 덮어쓰기 항목보다 우선합니다. 추가하지 않은 항목은 앱의 덮어쓰기 설정을 따릅니다';

  @override
  String get profileTunSettingsDesc =>
      '이 프로필에만 적용되며 네트워크 설정의 TUN 덮어쓰기 항목보다 우선합니다.';

  @override
  String get settingEntries => '설정';

  @override
  String get addSettingEntry => '설정 추가';

  @override
  String settingsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '설정 $count개',
    );
    return '$_temp0';
  }

  @override
  String get sniffer => '스니퍼';

  @override
  String get snifferStatusDesc =>
      '스니퍼는 TLS, HTTP, QUIC 트래픽에서 도메인을 읽어 규칙이 일치할 수 있게 합니다.';

  @override
  String get overrideDestination => '대상 덮어쓰기';

  @override
  String get overrideDestinationDesc => '대상 덮어쓰기는 원래 주소 대신 스니핑한 도메인으로 연결합니다.';

  @override
  String get forceDnsMapping => 'DNS 매핑 강제';

  @override
  String get forceDnsMappingDesc => 'DNS 매핑 강제는 DNS 매핑에서 도메인을 얻은 연결도 스니핑합니다.';

  @override
  String get parsePureIp => '순수 IP 분석';

  @override
  String get parsePureIpDesc => '순수 IP 분석은 IP 주소만 있는 연결을 스니핑합니다.';

  @override
  String get forceDomain => '강제 도메인';

  @override
  String get forceDomainDesc => '강제 도메인은 항상 스니핑합니다. 이미 도메인이 있는 다른 연결은 그대로 둡니다.';

  @override
  String get skipDomain => '건너뛸 도메인';

  @override
  String get skipDomainDesc => '건너뛸 도메인 목록에 있는 스니핑된 도메인은 사용하지 않습니다.';

  @override
  String get skipSrcAddress => '건너뛸 출발지 주소';

  @override
  String get skipDstAddress => '건너뛸 목적지 주소';

  @override
  String get sniffProtocols => '프로토콜';

  @override
  String get ports => '포트';

  @override
  String get invalidPortRangeContent => '443 또는 8000-9000과 같은 포트나 범위를 입력하세요';

  @override
  String get importConfig => '설정 가져오기';

  @override
  String get importText => '텍스트에서 가져오기';

  @override
  String get importConfigInvalid => '가져올 수 있는 설정이 아닙니다';

  @override
  String get importConfigReplaceTip =>
      '가져오면 이 프로필의 현재 노드, 프록시 그룹, 규칙 및 설정이 바뀝니다';

  @override
  String get customImportCloudRefused => 'oixCloud 주소는 사용자 지정 프로필로 가져올 수 없습니다';

  @override
  String get customImportNotImported => '가져오지 않음';

  @override
  String customImportDroppedSubRules(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '사용자 지정 프로필은 하위 규칙을 지원하지 않아 SUB-RULE 규칙 $count개를 제외했습니다',
      one: '사용자 지정 프로필은 하위 규칙을 지원하지 않아 SUB-RULE 규칙 1개를 제외했습니다',
    );
    return '$_temp0';
  }

  @override
  String customImportUnnamedProxies(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '노드 $count개에 이름 또는 유형이 없습니다',
      one: '노드 1개에 이름 또는 유형이 없습니다',
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
      other: '공유 링크에서 노드 $count개를 추가했습니다',
      one: '공유 링크에서 노드 1개를 추가했습니다',
    );
    return '$_temp0';
  }

  @override
  String shareLinksNotRead(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '링크 $count개를 읽지 못했습니다',
      one: '링크 1개를 읽지 못했습니다',
    );
    return '$_temp0';
  }

  @override
  String get connectionStats => '연결 통계';

  @override
  String get connectionStatsDesc => '실시간 연결, 최근 요청, DNS 쿼리';

  @override
  String get currentOutboundDesc => '시작 버튼이 있어 제거할 수 없습니다';

  @override
  String get dashboardAddableSection => '추가 가능';

  @override
  String get dashboardReorderHint => '카드를 드래그하여 순서를 변경하세요. 터치스크린에서는 먼저 길게 누르세요';

  @override
  String get done => '완료';

  @override
  String get editDashboard => '대시보드 편집';

  @override
  String groupCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '그룹 $count개',
    );
    return '$_temp0';
  }

  @override
  String get groupCountUnit => '개';

  @override
  String groupTimeoutCount(Object count) {
    return '$count개 시간 초과';
  }

  @override
  String get ipType => '유형';

  @override
  String get liveConnections => '실시간 연결';

  @override
  String get memoryInfoDesc => '앱과 코어가 사용하는 메모리';

  @override
  String get networkTakeover => '트래픽 가로채기';

  @override
  String get notRunning => '실행 중 아님';

  @override
  String portValue(Object port) {
    return '포트 $port';
  }

  @override
  String profileDaysLeft(num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days일 남음',
    );
    return '$_temp0';
  }

  @override
  String profileExpiresIn(Object date, num days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days일',
    );
    return '$date 만료, $_temp0 남음';
  }

  @override
  String profileUpdatedAt(Object time) {
    return '$time 업데이트';
  }

  @override
  String get proxyGroupsAfterStart => '코어가 시작되면 그룹이 여기에 표시됩니다';

  @override
  String get running => '실행 중';

  @override
  String get serviceFailed => '확인 실패';

  @override
  String get tapIconToRetry => '아이콘을 눌러 다시 시도';

  @override
  String trafficPeak(Object value) {
    return '최고 $value';
  }

  @override
  String trafficTotal(Object value) {
    return '합계 $value';
  }

  @override
  String get usedShort => '사용';

  @override
  String get disableKeepAlive => 'TCP 킵얼라이브 사용 안 함';

  @override
  String get keepAliveIdle => 'TCP 킵얼라이브 유휴 시간';

  @override
  String get routingMark => '라우팅 마크';

  @override
  String get minutes => '분';

  @override
  String yearsAgoShort(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count년 전',
    );
    return '$_temp0';
  }

  @override
  String monthsAgoShort(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count개월 전',
    );
    return '$_temp0';
  }

  @override
  String daysAgoShort(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count일 전',
    );
    return '$_temp0';
  }

  @override
  String hoursAgoShort(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count시간 전',
    );
    return '$_temp0';
  }

  @override
  String minutesAgoShort(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count분 전',
    );
    return '$_temp0';
  }

  @override
  String get expireTime => '만료 시간';

  @override
  String get runtimeConfig => '런타임 구성';

  @override
  String proxyGroupsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '프록시 그룹 $count개',
      one: '프록시 그룹 1개',
    );
    return '$_temp0';
  }

  @override
  String get confirmDeleteProxyGroup => '이 프록시 그룹을 삭제하시겠습니까?';

  @override
  String invalidProxyProvider(Object providerName) {
    return '올바르지 않은 프록시 공급자: $providerName';
  }

  @override
  String customIssuesSummary(Object count) {
    return '문제가 있는 항목 $count개, 이 프로필을 적용하면 실패할 수 있습니다';
  }

  @override
  String sectionsInEffect(Object count) {
    return '$count개 적용 중';
  }

  @override
  String get emptyFallback => '빈 폴백';

  @override
  String get testInterval => '테스트 간격';

  @override
  String get testWhenUsed => '사용할 때 테스트';

  @override
  String get defaultSelected => '기본 선택';

  @override
  String get hashByInUser => '인바운드 사용자별 해시';

  @override
  String get nodes => '노드';

  @override
  String get addNodes => '노드 추가';

  @override
  String get autoInclude => '자동 포함';

  @override
  String get filters => '필터';

  @override
  String get inputProxyGroupName => '프록시 그룹 이름을 입력하세요';

  @override
  String get definitionNotMap => '구성은 이름과 유형이 있는 YAML 매핑이어야 합니다';

  @override
  String get additionalParameters => '추가 매개변수';

  @override
  String get quickActions => '빠른 작업';

  @override
  String get ruleListInvalid =>
      '규칙은 항목마다 규칙 하나인 YAML 목록이어야 합니다. 예: - DOMAIN,example.com,DIRECT';

  @override
  String get goToConfigureAddedRules => '추가한 규칙 구성으로 이동';

  @override
  String get large => '크게';

  @override
  String get extraLarge => '매우 크게';

  @override
  String get matchCase => '대/소문자 구분';

  @override
  String get regex => '정규식';

  @override
  String get yes => '예';

  @override
  String get no => '아니요';

  @override
  String get error => '오류';

  @override
  String get iconSets => '아이콘 세트';

  @override
  String get localImage => '로컬 이미지';

  @override
  String get label => '레이블';

  @override
  String get iconSetsEmptyTip =>
      '아이콘 세트가 아직 없습니다. 사용자 지정 프로필 리소스 → 아이콘 세트에서 추가하세요';

  @override
  String get recommendedIcons => '추천';

  @override
  String get customProfileResources => '사용자 지정 프로필 리소스';

  @override
  String get importFromLink => '링크에서 가져오기';

  @override
  String get sendFromPhone => '휴대폰에서 보내기';

  @override
  String get sendFromPhoneTip =>
      '휴대폰 카메라로 코드를 스캔한 뒤 열린 페이지에 링크를 붙여 넣으세요. 두 기기가 같은 네트워크에 연결되어 있어야 합니다.';

  @override
  String get sendFromPhoneNoNetwork => '이 기기는 로컬 네트워크에 연결되어 있지 않습니다';

  @override
  String get sendFromPhonePermissionDenied =>
      '휴대폰에서 링크를 받으려면 FlClash가 로컬 네트워크에 접근할 수 있도록 \'근처 기기\' 권한이 필요합니다. 앱 설정에서 켜 주세요.';

  @override
  String get sendFromPhonePageTitle => 'FlClash로 링크 보내기';

  @override
  String get sendFromPhonePageHint => '구독 링크 또는 프록시 공유 링크';

  @override
  String get send => '보내기';

  @override
  String get sendFromPhonePageSent => '보냈습니다. 다른 기기에서 가져오기를 확인하세요.';

  @override
  String get sendFromPhoneConfirmTitle => '휴대폰에서 받은 링크를 가져올까요?';

  @override
  String get shareQrcodeTip => '다른 기기의 FlClash로 스캔하면 이 프로필을 가져올 수 있습니다.';

  @override
  String get qrcodeTooLongTip => '이 링크는 너무 길어 QR 코드로 만들 수 없습니다. 링크 복사를 사용하세요.';

  @override
  String get invalidLinkTip => '구독 링크 또는 프록시 공유 링크가 아닙니다';

  @override
  String get batchLinkInputTip => '한 줄에 링크 하나씩';

  @override
  String get link => '링크';

  @override
  String get allowedIps => '허용 IP';

  @override
  String get cipher => '암호화 방식';

  @override
  String get clientFingerprint => '클라이언트 핑거프린트';

  @override
  String get requestHeaders => '요청 헤더';

  @override
  String transportHeaders(Object transport) {
    return '$transport 요청 헤더';
  }

  @override
  String get congestionControl => '혼잡 제어';

  @override
  String get downloadBandwidth => '다운로드 대역폭';

  @override
  String get hopInterval => '호핑 간격';

  @override
  String get obfs => '난독화';

  @override
  String get obfsHost => '난독화 호스트';

  @override
  String get obfsMode => '난독화 모드';

  @override
  String get obfsParam => '난독화 매개변수';

  @override
  String get obfsPassword => '난독화 비밀번호';

  @override
  String get plugin => '플러그인';

  @override
  String get pluginHost => '플러그인 호스트';

  @override
  String get pluginPath => '플러그인 경로';

  @override
  String get pluginUsername => '플러그인 사용자 이름';

  @override
  String get pluginPassword => '플러그인 비밀번호';

  @override
  String get pluginCipher => '플러그인 암호화 방식';

  @override
  String get pluginMode => '플러그인 모드';

  @override
  String get portHopping => '포트 호핑';

  @override
  String get preSharedKey => '사전 공유 키';

  @override
  String get privateKey => '개인 키';

  @override
  String get privateKeyPassphrase => '개인 키 암호';

  @override
  String get protocolParam => '프로토콜 매개변수';

  @override
  String get protocolVersion => '프로토콜 버전';

  @override
  String get publicKey => '공개 키';

  @override
  String get remoteDnsResolve => '원격 DNS 확인';

  @override
  String get secretKey => '키';

  @override
  String get skipCertVerify => '인증서 검증 건너뛰기';

  @override
  String get transport => '전송';

  @override
  String get udpRelayMode => 'UDP 릴레이 모드';

  @override
  String get uploadBandwidth => '업로드 대역폭';

  @override
  String get username => '사용자 이름';

  @override
  String get networkName => '네트워크 이름';

  @override
  String get networkSecret => '네트워크 시크릿';

  @override
  String get peers => '피어';

  @override
  String get virtualIpv4 => '가상 IPv4';

  @override
  String get hostname => '호스트 이름';

  @override
  String get exitNodes => '출구 노드';

  @override
  String get ageSecretKey => 'age 비밀 키';

  @override
  String get ageSecretKeyRequiredTip =>
      '이 프로필은 age로 암호화되어 있어 복호화하려면 age 비밀 키가 필요합니다';

  @override
  String get ageDecryptFailedTip =>
      '프로필을 복호화하지 못했습니다. age 비밀 키를 확인한 후 다시 시도하세요.';

  @override
  String get resetDns => 'DNS 초기화';

  @override
  String get resetDnsSuccess => 'DNS 상태를 초기화했습니다';

  @override
  String get resetDnsFailed => 'DNS를 초기화하지 못했습니다. 코어 연결을 확인하고 다시 시도하세요.';

  @override
  String resourceSizeLimitTip(Object limit) {
    return '리소스가 $limit를 초과합니다';
  }

  @override
  String get ruleSetDetect => '형식 및 규칙 유형 자동 감지';

  @override
  String get ruleSetConvert => 'MRS로 변환';

  @override
  String get ruleSetConvertRemote => '로컬 MRS로 다운로드';

  @override
  String get ruleSetEmptyTip => '규칙 세트에 사용 가능한 항목이 없습니다';

  @override
  String get ruleSetMixedTip =>
      '도메인과 IP 대역이 혼합되어 있습니다. 함께 사용하려면 classical 규칙을 사용하세요';

  @override
  String get ruleSetInvalidTip => '규칙 세트를 읽을 수 없습니다. 형식과 항목을 확인하세요';

  @override
  String get ruleSetUnsupportedTip => '이 규칙은 기존 동작을 유지하면서 MRS로 변환할 수 없습니다';

  @override
  String get ruleSetBusyTip => '다른 규칙 세트 작업이 진행 중입니다. 잠시 후 다시 시도하세요';

  @override
  String get ruleSetNeedsConversionTip =>
      '이 원격 규칙 세트는 정규화가 필요합니다. 로컬 MRS로 다운로드하여 사용하세요';

  @override
  String get ruleSetSizeTip => '규칙 세트가 처리 한도를 초과했습니다. 더 작은 세트로 나누세요';

  @override
  String get providerLookupFailed =>
      '현재 적용된 노드 설정을 읽을 수 없습니다. 리소스를 새로 고친 후 다시 시도하세요';

  @override
  String get lookupProxyConfig => '노드 설정 찾기';

  @override
  String get tunDnsMode => '시스템 DNS 모드';

  @override
  String get tunDnsModeDesc =>
      '비워 두면 기존 동작을 유지합니다. disabled는 시스템 DNS를 변경하지 않고, native는 TUN 주소를 사용합니다. hijack은 다른 인터페이스의 DNS도 가로챕니다(Windows는 strict-route, Linux는 auto-redirect 필요). macOS에서는 명시한 모드가 자동 DNS 설정보다 우선합니다.';

  @override
  String get nodeShareLinkUnavailable =>
      '이 노드는 공유 링크로 변환할 수 없습니다. 필드 또는 YAML로 편집하세요';

  @override
  String shareLinkNodesPreserved(int count) {
    return '링크로 변환할 수 없는 노드 $count개는 변경 없이 유지됩니다';
  }

  @override
  String get select => '선택';

  @override
  String get preferred => '우선';

  @override
  String get addToLocalProxies => '사용자 지정 노드에 추가';

  @override
  String addedToLocalProxies(Object name) {
    return '$name을(를) 사용자 지정 노드에 추가했습니다';
  }

  @override
  String alreadyInLocalProxies(Object name) {
    return '$name은(는) 이미 사용자 지정 노드에 있습니다';
  }

  @override
  String get generalOverrideDesc =>
      '여기에 추가한 항목은 모든 프로필의 해당 설정을 대체합니다. 추가하지 않은 항목은 프로필 자체 설정을 유지하며, 프로필에 없으면 코어 기본값을 사용합니다.';

  @override
  String get groupBy => '분류';

  @override
  String get copyHost => '호스트 복사';

  @override
  String get copyDestination => '대상 주소 복사';

  @override
  String get closeConnection => '연결 닫기';

  @override
  String get recentRequests => '최근 요청';

  @override
  String get root => 'Root';

  @override
  String get mitm => 'MITM';

  @override
  String get httpsDecryption => 'HTTPS 복호화';

  @override
  String get httpCapture => 'HTTP 캡처';

  @override
  String get httpCaptureDesc =>
      '호스트 이름에 나열한 호스트의 요청을 기록하며, 연결 세부 정보에서 볼 수 있습니다. 기록은 메모리에만 보관됩니다.';

  @override
  String get httpCaptureNoHosts =>
      '나열된 호스트가 없어 아무것도 기록되지 않습니다. MITM 페이지의 호스트 이름이나 연결 세부 정보에서 추가하세요.';

  @override
  String get httpCaptureLimit => '최대 기록 수';

  @override
  String httpCaptureLimitDesc(Object memory, Object body) {
    return '이 개수에 도달하거나 메모리 $memory를 채우면 가장 오래된 기록부터 삭제됩니다. 본문은 앞부분 $body만 보관합니다.';
  }

  @override
  String get httpRequests => 'HTTP 요청';

  @override
  String get httpRequestsMissing => '캡처를 켜기 전에 보냈거나 이미 지워진 요청은 표시되지 않습니다.';

  @override
  String get httpRequestCleared => '이 요청의 기록은 지워졌습니다';

  @override
  String get httpCaptureOff => '캡처가 꺼져 있습니다';

  @override
  String get inProgress => '진행 중';

  @override
  String get method => '메서드';

  @override
  String get originalUrl => '원래 URL';

  @override
  String get timeToFirstByte => '첫 바이트까지 시간';

  @override
  String get requestBody => '요청 본문';

  @override
  String get response => '응답';

  @override
  String get responseBody => '응답 본문';

  @override
  String get responseHeaders => '응답 헤더';

  @override
  String get matchedRules => '일치한 규칙';

  @override
  String get overview => '개요';

  @override
  String get viewAll => '모두 보기';

  @override
  String get copyAsBase64 => 'Base64로 복사';

  @override
  String get copyAsCurl => 'cURL로 복사';

  @override
  String get copyRequest => '요청 복사';

  @override
  String get copyResponse => '응답 복사';

  @override
  String get copyResponseBody => '응답 본문 복사';

  @override
  String get httpBodyProtobufGuess =>
      '스키마 없이 Protobuf로 읽었습니다. 필드 번호만 표시되며 유형은 추정입니다.';

  @override
  String get exportHar => 'HAR 내보내기';

  @override
  String get mitmAddRejectRule => '거부 규칙 추가';

  @override
  String get mitmAddMapLocalRule => '로컬 매핑 규칙 추가';

  @override
  String get httpExportPrivateTitle => '개인 정보 포함';

  @override
  String get httpExportPrivate =>
      '요청에는 쿠키, 토큰, 비밀번호, 양식 내용이 담길 수 있습니다. 공유할 내용과 대상을 확인하세요.';

  @override
  String get mitmRuleCopiedForStash =>
      '이 모듈은 Stash 오버라이드이므로 규칙을 복사했습니다. 직접 추가하세요.';

  @override
  String get binaryData => '바이너리 데이터';

  @override
  String get httpBodyNotKept => '메모리가 부족해 기록되지 않았습니다.';

  @override
  String get httpBodyTruncated => '이 본문은 앞부분만 기록되었습니다.';

  @override
  String httpBodyUndecoded(Object encoding) {
    return '$encoding을(를) 디코딩할 수 없어 전송된 그대로의 데이터를 표시합니다.';
  }

  @override
  String get mitmEnableTip =>
      '켜면 FlClash가 복호화되는 호스트로 보내는 모든 내용을 읽을 수 있습니다(쿠키와 비밀번호 포함). 재작성이 필요한 호스트에만 켜세요.';

  @override
  String get certificate => '인증서';

  @override
  String get generateCertificate => '인증서 생성';

  @override
  String get regenerateCertificate => '인증서 다시 생성';

  @override
  String get regenerateCertificateTip =>
      '새 인증서가 현재 인증서를 대체하며, FlClash는 가능한 경우 현재 인증서를 이 기기의 신뢰할 수 있는 루트에서 제거합니다. 현재 인증서를 신뢰하는 다른 모든 기기에는 새 인증서를 설치해야 합니다.';

  @override
  String get exportCertificate => '인증서 내보내기';

  @override
  String get installCertificate => '시스템에 설치';

  @override
  String get installCertificateSuccess => '인증서를 설치했습니다';

  @override
  String validUntil(Object date) {
    return '$date까지 유효';
  }

  @override
  String get mitmCertificateExportTip => '내보낸 뒤 복호화할 기기에서 신뢰하도록 설정하세요.';

  @override
  String get mitmTrustReady => '신뢰됨';

  @override
  String get mitmTrustUntrusted => '완전히 신뢰되지 않음';

  @override
  String get mitmTrustNotInstalled => '설치되지 않음';

  @override
  String get mitmTrustChecking => '확인 중…';

  @override
  String get trustCertificate => '인증서 신뢰';

  @override
  String get mitmCertificateAndroidReadyTip =>
      '사용자 인증서를 신뢰하는 앱(주로 브라우저)만 복호화됩니다.';

  @override
  String get mitmCertificateLinuxTip => 'Flatpak 브라우저에는 내보낸 인증서를 직접 가져와야 합니다.';

  @override
  String mitmCertutilMissing(Object command) {
    return 'Chrome과 Firefox는 자체 인증서 저장소를 쓰며, 여기에는 certutil이 필요합니다: $command';
  }

  @override
  String mitmMissingStores(Object stores) {
    return '아직 추가되지 않음: $stores';
  }

  @override
  String get mitmSystemStoreFailed => '인증서를 시스템의 신뢰할 수 있는 루트에 추가하지 못했습니다';

  @override
  String get mitmRootUntilReboot =>
      '인증서를 유지할 Magisk, KernelSU, APatch를 찾지 못했습니다. 기기를 다시 시작한 후 다시 설치하세요.';

  @override
  String get mitmRootPendingReboot => '인증서는 기기를 다시 시작한 후 적용됩니다.';

  @override
  String get mitmInstallSystemCaTip =>
      'root가 감지되어 인증서가 Magisk, KernelSU 또는 APatch 모듈 \"FlClash MITM CA\"로 시스템 신뢰 인증서에 추가됩니다. 이후 이 기기의 모든 앱이 이를 신뢰하며, 개인 키를 가진 사람은 이 기기의 HTTPS 트래픽을 복호화할 수 있습니다. 되돌리려면 인증서를 다시 생성하거나 root 관리자에서 모듈을 제거한 뒤 다시 시작하세요. root가 거부되면 사용자 인증서로 설치합니다.';

  @override
  String get mitmInstallUserCaTip =>
      'root가 감지되지 않아 사용자 인증서로만 설치할 수 있습니다. 사용자 인증서를 신뢰하는 앱(주로 브라우저)만 복호화되고 다른 앱은 나열한 호스트에 연결하지 못하므로 해당 호스트는 나열하지 마세요. Android 11부터는 시스템 설정에서 직접 설치를 마쳐야 합니다.';

  @override
  String mitmCertificateSavedTip(Object fileName) {
    return '$fileName을(를) 다운로드에 저장했습니다. 설정의 \'보안 › 암호화 및 사용자 인증 정보 › 인증서 설치 › CA 인증서\'에서 설치하세요.';
  }

  @override
  String get openSettings => '설정 열기';

  @override
  String mitmRemoveOldCertificateTip(Object name) {
    return '설정의 \'보안 › 암호화 및 사용자 인증 정보 › 신뢰할 수 있는 자격증명 › 사용자\'에서 이전 인증서 $name을(를) 제거한 뒤 새 인증서를 설치하세요.';
  }

  @override
  String mitmOldCertificateLeftTip(Object name) {
    return '이전 인증서 $name을(를) 제거하지 못했습니다. 신뢰할 수 있는 루트에서 직접 제거하세요.';
  }

  @override
  String mitmOldSystemCertificateLeftTip(Object name) {
    return '이전 인증서 $name이(가) 시스템의 신뢰할 수 있는 인증서에 남아 있습니다. 루트 관리자에서 FlClash의 루트 권한을 허용한 뒤 다시 생성하거나, 그곳에서 \'FlClash MITM CA\' 모듈을 제거하고 다시 시작하세요.';
  }

  @override
  String get mitmDecryptHost => '이 호스트 복호화';

  @override
  String mitmDecryptHostTip(Object host) {
    return '$host을(를) 호스트 이름 목록에 추가할까요? FlClash가 쿠키와 비밀번호를 포함해 이 호스트로 보내는 내용을 읽을 수 있습니다.';
  }

  @override
  String get mitmClientRefusedCertificate =>
      '클라이언트가 인증서를 거부했습니다. 인증서를 설치하거나, 앱이 인증서를 고정한 경우 이 호스트를 제외하세요.';

  @override
  String get mitmExcludeHost => '복호화에서 제외';

  @override
  String mitmExcludeHostTip(Object host) {
    return '호스트 이름 목록 맨 위에 -$host을(를) 추가할까요? 이후 이 호스트는 복호화되지 않습니다.';
  }

  @override
  String get urlRewrite => 'URL 재작성';

  @override
  String get headerRewrite => '헤더 재작성';

  @override
  String get bodyRewrite => '본문 재작성';

  @override
  String get mapLocal => '로컬 매핑';

  @override
  String get mitmHostnameDesc => '앞에 -를 붙이면 제외하며, 처음 일치하는 항목이 적용됩니다.';

  @override
  String get mitmModules => '모듈';

  @override
  String get mitmModule => '모듈';

  @override
  String get mitmModuleInvalid =>
      'Surge 모듈, Loon 플러그인, Quantumult X 스니펫, Stash 오버라이드가 아닙니다';

  @override
  String get arguments => '인수';

  @override
  String get mitmRoutingRules => '라우팅 규칙';

  @override
  String get mitmIgnoredLines => '무시된 줄';

  @override
  String get mitmModuleRulesDesc => '라우팅 규칙은 프로필 자체 규칙보다 앞에 적용됩니다.';

  @override
  String mitmModuleSystemTip(Object system) {
    return '$system용으로 작성되었습니다. 일부 줄은 이 기기의 앱과 맞지 않을 수 있습니다.';
  }

  @override
  String mitmSkipSection(Object section) {
    return '[$section] 섹션은 지원되지 않습니다';
  }

  @override
  String get mitmSkipSetting => '이 설정은 지원되지 않습니다';

  @override
  String get mitmSkipScriptType => '이 유형의 스크립트는 지원되지 않습니다';

  @override
  String get mitmSkipRule => '이 규칙 유형은 지원되지 않습니다';

  @override
  String get mitmSkipPolicy => 'DIRECT 및 REJECT 정책만 지원됩니다';

  @override
  String get mitmSkipJq => 'jq 재작성은 지원되지 않습니다';

  @override
  String get mitmSkipJsonBody => 'JSON 본문 재작성은 지원되지 않습니다';

  @override
  String get mitmSkipRawHeader => '모든 헤더를 하나의 텍스트로 다시 쓰는 기능은 지원되지 않습니다';

  @override
  String get mitmSkipConditional => '조건부 재작성은 지원되지 않습니다';

  @override
  String get mitmSkipRelativeData =>
      '이 줄이 가리키는 파일이 첨부되어 있지 않습니다. URL을 쓰거나 첨부하세요';

  @override
  String get mitmSkipNotDownloaded => '파일이 아직 다운로드되지 않았습니다';

  @override
  String get mitmSkipUnreadable => '이 줄을 읽을 수 없습니다';

  @override
  String get mitmAddLocalFile => '로컬 파일 추가';

  @override
  String get mitmNewModule => '새 모듈';

  @override
  String get mitmAttachments => '첨부 파일';

  @override
  String get mitmAttachmentsDesc =>
      '각 줄은 script-path=a.js처럼 파일 이름으로 첨부 파일을 참조합니다.';

  @override
  String mitmFileTooLarge(Object size) {
    return '파일이 ${size}MB보다 큽니다';
  }

  @override
  String get mitmSkipDisabled => '인수로 꺼져 있습니다';

  @override
  String get mitmSkipEvent => '이 이벤트는 지원되지 않습니다';

  @override
  String get mitmRunScript => '지금 실행';

  @override
  String get mitmScriptNoOutput => '스크립트가 출력 없이 끝났습니다';

  @override
  String get mitmScriptRiskTitle => '이 모듈의 스크립트를 실행할까요?';

  @override
  String get mitmScriptRisk =>
      '스크립트가 일치하는 호스트의 트래픽을 읽고 바꿀 수 있으며, 쿠키와 토큰도 포함되고 직접 요청을 보낼 수도 있습니다. 출처를 신뢰할 때만 켜세요.';

  @override
  String get skipServerCertVerify => '서버 인증서 검증 건너뛰기';

  @override
  String get http2 => 'HTTP/2';

  @override
  String get decryptUntrusted => '로컬 신뢰 없이 복호화';

  @override
  String invalidOfCount(Object invalid, Object total) {
    return '$total개 중 $invalid개 무효';
  }

  @override
  String mitmModuleScriptsChanged(Object name) {
    return '$name의 스크립트가 변경되어 껐습니다';
  }

  @override
  String failedCount(Object count) {
    return '$count개 항목 실패. 눌러서 보기';
  }

  @override
  String get proxyServerNameserverDesc => '프록시 서버의 도메인 확인에만 사용합니다.';

  @override
  String get proxyServerNameserverPolicyDesc =>
      '일치하는 프록시 서버 도메인은 Proxy Server Nameserver 대신 여기서 지정한 DNS 서버를 사용합니다.';

  @override
  String get directNameserverDesc => '직접 연결의 도메인을 확인합니다.';

  @override
  String get fakeipFilterDesc =>
      '이 도메인에는 Fake-IP 대신 실제 IP를 반환합니다. whitelist 모드에서는 이 도메인만 Fake-IP를 사용합니다.';

  @override
  String get fallbackFilterGeositeDesc =>
      '이 GeoSite 분류의 도메인은 바로 Fallback으로 확인합니다.';

  @override
  String get fallbackFilterIpcidrDesc =>
      'Nameserver가 이 범위의 IP를 반환하면 Fallback 결과를 사용합니다.';

  @override
  String get fallbackFilterDomainDesc => '이 도메인은 바로 Fallback으로 확인합니다.';

  @override
  String get customResources => '사용자 지정';

  @override
  String get proxyYieldsToSubscription =>
      '구독에 같은 이름의 노드가 있어 이 프로필은 해당 노드를 사용합니다';

  @override
  String get delayMeasurementUnknown => '측정 시간 알 수 없음';

  @override
  String delayMeasuredAt(String time) {
    return '마지막 테스트: $time';
  }

  @override
  String get delayMeasurementStale => '오래된 결과입니다. 다시 테스트하세요';

  @override
  String get diagUdp => 'UDP 연결';

  @override
  String get diagUdpReady => 'UDP 왕복 테스트 성공';

  @override
  String get diagUdpUnknown => 'UDP 연결을 확인하지 못했습니다';

  @override
  String get diagUdpUnsupported => '현재 경로는 UDP를 지원하지 않습니다';

  @override
  String get diagUdpHint =>
      '테스트는 현재 라우팅 규칙을 따릅니다. 시간 초과는 서버나 네트워크 때문일 수 있으며 모든 UDP가 차단되었다는 뜻은 아닙니다.';

  @override
  String get diagTimeline => '최근 작업 기록';

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
  String get diagStageFetch => '설정 가져오기';

  @override
  String get diagStageValidate => '설정 검증';

  @override
  String get diagStageApply => '설정 적용';

  @override
  String get diagStageStart => 'VPN 시작';

  @override
  String get diagStageStop => 'VPN 중지';

  @override
  String get diagEventStarted => '시작됨';

  @override
  String get diagEventSucceeded => '성공';

  @override
  String get diagEventFailed => '실패';

  @override
  String get diagEventUnchanged => '내용 변경 없음';

  @override
  String get diagEventCanceled => '취소됨';

  @override
  String get diagRecorded => '기록';

  @override
  String mixedPortReset(Object value, Object port) {
    return '혼합 포트는 $value일 수 없어 $port(으)로 되돌렸습니다';
  }

  @override
  String get coreStoppedDesc => '앱과 코어의 연결이 끊어졌습니다';

  @override
  String coreStoppedWithReason(Object reason) {
    return '앱과 코어의 연결이 끊어졌습니다: $reason';
  }

  @override
  String get vpnPermissionNotGranted =>
      'VPN 권한이 허용되지 않아 VPN을 시작하지 않았습니다. 다른 앱이 상시 사용 VPN으로 설정되어 있어도 시작할 수 없습니다.';

  @override
  String get vpnServiceStartFailed => 'VPN 서비스를 시작하지 못했습니다.';
}

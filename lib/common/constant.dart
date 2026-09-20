// ignore_for_file: constant_identifier_names

import 'dart:math';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:material_ui/material_ui.dart';

const appName = 'FlClash for oixCloud';
const appHelperService = 'FlClashHelperService';
const coreManifestName = 'manifest.json';
const browserUa =
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36';
const packageName = 'com.oixcloud.clash';
const legacyPackageName = 'com.follow.clash';
const identityMigrationMarkerName = '.identity-migrated-from-com.follow.clash';
const releaseRepository = 'pickrui/FlClash';
final unixSocketPath = '/tmp/FlClashSocket_${Random().nextInt(10000)}.sock';
final windowsPipeName = '\\\\.\\pipe\\FlClashCore_${_randomPipeId()}';
const helperPort = 47890;
const helperProtocolVersionHeader = 'x-flclash-helper-protocol';
const helperProtocolVersion = '6';
const maxTextScale = 1.4;
const minTextScale = 0.8;
final baseInfoEdgeInsets = EdgeInsets.symmetric(
  vertical: 16.mAp,
  horizontal: 16.mAp,
);
final listHeaderPadding = EdgeInsets.only(
  left: 16.mAp,
  right: 8.mAp,
  top: 24.mAp,
  bottom: 8.mAp,
);

const watchExecution = false;

String _randomPipeId() {
  final random = Random.secure();
  return List.generate(
    16,
    (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
  ).join();
}

final defaultTextScaleFactor =
    WidgetsBinding.instance.platformDispatcher.textScaleFactor;
const httpTimeoutDuration = Duration(milliseconds: 5000);

/// How long the Core may spend on one delay test. It spends this twice in the
/// worst case, once queueing for a slot and once on the probe itself, so the
/// guard has to outlast twice this value.
const delayTestTimeoutDuration = Duration(seconds: 8);
const delayTestGuardDuration = Duration(seconds: 30);

/// Probes one test run sends at once.
const defaultDelayTestConcurrency = 50;
const defaultAndroidDelayTestConcurrency = 16;
const maxConcurrentDelayTests = 150;
const delayTestConcurrencyOptions = [8, 16, 32, 50, 100, 150];
int normalizeDelayTestConcurrency(int? value) =>
    delayTestConcurrencyOptions.contains(value)
    ? value!
    : defaultDelayTestConcurrency;

int? normalizeOptionalDelayTestConcurrency(int? value) =>
    delayTestConcurrencyOptions.contains(value) ? value : null;

/// Mirrored by NormalizeMTU (core/tun/options.go) and normalizeTunMtu (Kotlin).
const minTunMtu = 1280;
const maxTunMtu = 65535;
const defaultTunMtu = 9000;
int normalizeTunMtu(int? value) =>
    value != null && value >= minTunMtu && value <= maxTunMtu
    ? value
    : defaultTunMtu;

/// One spare RPC lets a new batch cancel saturated probes; network work stays at 150.
const maxInFlightDelayTests = maxConcurrentDelayTests + 1;
const animateDuration = Duration(milliseconds: 100);
const midDuration = Duration(milliseconds: 200);
const commonDuration = Duration(milliseconds: 300);
const defaultUpdateDuration = Duration(days: 1);
const MMDB = 'GEOIP.metadb';
const ASN = 'ASN.mmdb';
const GEOIP = 'GEOIP.dat';
const GEOSITE = 'GEOSITE.dat';
final double kHeaderHeight = getWindowHeaderHeight(
  isDesktop: system.isDesktop,
  isMacOS: system.isMacOS,
);
const profilesDirectoryName = 'profiles';
const localhost = '127.0.0.1';
const clashConfigKey = 'clash_config';
const configKey = 'config';
const double dialogCommonWidth = 300;
const repository = 'chen08209/FlClash';
const maxMobileWidth = 600;
const maxLaptopWidth = 840;
const defaultTestUrl = 'http://cp.cloudflare.com/generate_204';
const defaultDirectTestUrl = 'https://wifi.vivo.com.cn/generate_204';

String getDelayTestUrl({required String proxyName, required String testUrl}) {
  return proxyName == UsedProxy.DIRECT.value ? defaultDirectTestUrl : testUrl;
}

final commonFilter = ImageFilter.blur(
  sigmaX: 5,
  sigmaY: 5,
  tileMode: TileMode.clamp,
);

const trackerInfoListEquality = ListEquality<TrackerInfo>();
const stringListEquality = ListEquality<String>();
const intListEquality = ListEquality<int>();
const logListEquality = ListEquality<Log>();
const ruleListEquality = ListEquality<Rule>();
const proxyChainListEquality = ListEquality<ProxyChain>();
const profileProxyListEquality = ListEquality<ProfileProxy>();
const scriptListEquality = ListEquality<Script>();
const profileListEquality = ListEquality<Profile>();
const proxyGroupsEquality = ListEquality<ProxyGroup>();
const hotKeyActionListEquality = ListEquality<HotKeyAction>();
const stringAndStringMapEquality = MapEquality<String, String>();
const stringAndStringMapEntryListEquality =
    ListEquality<MapEntry<String, String>>();
const keyboardModifierListEquality = SetEquality<KeyboardModifier>();

const proxiesListStoreKey = PageStorageKey<String>('proxies_list');
const toolsStoreKey = PageStorageKey<String>('tools');
const profilesStoreKey = PageStorageKey<String>('profiles');

const defaultPrimaryColor = 0XFFD8C0C3;

double getWidgetHeight(num lines) {
  final space = 14.mAp;
  return max(lines * (80.ap + space) - space, 0);
}

const maxLength = 1000;

const defaultPrimaryColors = [
  0xFF795548,
  0xFF03A9F4,
  0xFFFFFF00,
  0XFFBBC9CC,
  0XFFABD397,
  defaultPrimaryColor,
  0XFF665390,
];

const scriptTemplate = '''
const main = (config) => {
  return config;
}''';

const backupDatabaseName = 'database.sqlite';
const configJsonName = 'config.json';

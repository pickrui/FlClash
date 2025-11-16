import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/cupertino.dart';

class Request {
  static const String _downloadBaseUrl = 'https://dl.dler.io';
  static const String _defaultMacOSArch = 'arm64';
  static const String _defaultAndroidAbi = 'arm64-v8a';
  static const Duration _helperTimeout = Duration(milliseconds: 2000);
  
  late final Dio dio;
  late final Dio _clashDio;

  Request() {
    final baseOptions = BaseOptions(headers: {'User-Agent': globalState.ua});
    
    dio = Dio(baseOptions);
    _clashDio = Dio(baseOptions);
    _clashDio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
          client.userAgent = globalState.ua;
        client.findProxy = (uri) => FlClashHttpOverrides.handleFindProxy(uri);
        return client;
      },
    );
  }

  Future<Response> _smartFallbackRequest(
    String url,
    Options options, {
    bool? useProxy,
  }) async {
    if (useProxy != null) {
      return (useProxy ? _clashDio : dio).get(url, options: options);
    }
    
    try {
      return await dio.get(url, options: options);
    } catch (directError) {
      try {
        return await _clashDio.get(url, options: options);
      } catch (_) {
        throw directError;
      }
    }
  }

  Future<Response> getFileResponseForUrl(String url, {bool? useProxy}) async {
    return _smartFallbackRequest(
      url,
      Options(responseType: ResponseType.bytes),
      useProxy: useProxy,
    );
  }

  Future<Response> getTextResponseForUrl(String url, {bool? useProxy}) async {
    return _smartFallbackRequest(
      url,
      Options(responseType: ResponseType.plain),
      useProxy: useProxy,
    );
  }

  Future<MemoryImage?> getImage(String url) async {
    if (url.isEmpty) return null;
    
    final response = await dio.get<Uint8List>(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    
    return response.data != null ? MemoryImage(response.data!) : null;
  }

  Future<String> _getMacOSArch() async {
    try {
      final result = await Process.run('uname', ['-m']);
      final arch = result.stdout.toString().trim();
      return arch == 'x86_64' ? 'amd64' : arch;
    } catch (_) {
      return _defaultMacOSArch;
    }
  }

  Future<String> _getAndroidAbi() async {
    try {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final supportedAbis = androidInfo.supportedAbis;
      if (supportedAbis.isEmpty) return _defaultAndroidAbi;
      
      final primaryAbi = supportedAbis.first.toLowerCase();
      if (primaryAbi.contains('arm64')) return 'arm64-v8a';
      if (primaryAbi.contains('armeabi')) return 'armeabi-v7a';
      if (primaryAbi.contains('x86_64')) return 'x86_64';
      
      return _defaultAndroidAbi;
    } catch (_) {
      return _defaultAndroidAbi;
    }
  }

  Future<String?> _getDownloadUrl() async {
    if (Platform.isMacOS) {
      final arch = await _getMacOSArch();
      return '$_downloadBaseUrl/flclash-macos-$arch.dmg';
    }
    
    if (Platform.isWindows) {
      return '$_downloadBaseUrl/flclash-windows-x86_64.exe';
    }
    
    if (Platform.isAndroid) {
      final abi = await _getAndroidAbi();
      return '$_downloadBaseUrl/flclash-android-$abi.apk';
    }
    
    return null;
  }

  Future<Map<String, dynamic>?> checkForUpdate() async {
    final result = await dlerCloudApi.getVersion();
    
    if (!result.isSuccess) return null;
    
    final remoteVersion = result.data;
    if (remoteVersion == null || remoteVersion.isEmpty) return null;
    
    final currentVersion = globalState.packageInfo.fullVersion;
    final hasUpdate = utils.compareVersions(remoteVersion, currentVersion) > 0;
    if (!hasUpdate) return null;
    
    return {
      'version': remoteVersion,
      'downloadUrl': await _getDownloadUrl(),
    };
  }

  final Map<String, IpInfo Function(Map<String, dynamic>)> _ipInfoSources = {
    'https://ipwho.is': IpInfo.fromIpWhoIsJson,
    'https://api.myip.com': IpInfo.fromMyIpJson,
    'https://ipapi.co/json': IpInfo.fromIpApiCoJson,
    'https://ident.me/json': IpInfo.fromIdentMeJson,
    'http://ip-api.com/json': IpInfo.fromIpAPIJson,
    'https://api.ip.sb/geoip': IpInfo.fromIpSbJson,
    'https://ipinfo.io/json': IpInfo.fromIpInfoIoJson,
  };

  Future<Result<IpInfo?>> checkIp({CancelToken? cancelToken}) async {
    var failureCount = 0;
    final totalSources = _ipInfoSources.length;
    
    final futures = _ipInfoSources.entries.map((source) async {
      final completer = Completer<Result<IpInfo?>>();
      
      void handleFailure() {
        if (!completer.isCompleted && failureCount == totalSources) {
          completer.complete(Result.success(null));
        }
      }

      dio
          .get<Map<String, dynamic>>(
            source.key,
            cancelToken: cancelToken,
            options: Options(responseType: ResponseType.json),
          )
          .timeout(const Duration(seconds: 10))
          .then((res) {
            if (res.statusCode == HttpStatus.ok && res.data != null) {
              completer.complete(Result.success(source.value(res.data!)));
            } else {
              failureCount++;
              handleFailure();
            }
          })
          .catchError((e) {
            failureCount++;
            if (e is DioException && e.type == DioExceptionType.cancel) {
              completer.complete(Result.error('cancelled'));
            }
            handleFailure();
          });
      
      return completer.future;
    });
    
    final res = await Future.any(futures);
    cancelToken?.cancel();
    return res;
  }

  Future<Response?> _helperRequest(
    String endpoint, {
    String? data,
    bool isPost = false,
  }) async {
    try {
      final url = 'http://$localhost:$helperPort/$endpoint';
      final response = isPost
          ? await dio.post(url, data: data, options: Options(responseType: ResponseType.plain))
          : await dio.get(url, options: Options(responseType: ResponseType.plain));
      
      return response.statusCode == HttpStatus.ok ? response : null;
    } catch (_) {
      return null;
    }
  }

  Future<bool> pingHelper() async {
    final response = await _helperRequest('ping').timeout(_helperTimeout);
    return response?.data == globalState.coreSHA256;
  }

  Future<bool> startCoreByHelper(String arg) async {
    final data = json.encode({'path': appPath.corePath, 'arg': arg});
    final response = await _helperRequest('start', data: data, isPost: true).timeout(_helperTimeout);
    return response != null && (response.data as String).isEmpty;
  }

  Future<bool> stopCoreByHelper() async {
    final response = await _helperRequest('stop', isPost: true).timeout(_helperTimeout);
    return response != null && (response.data as String).isEmpty;
  }
}

final request = Request();

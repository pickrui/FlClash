import 'dart:async';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';

import 'method.dart';

mixin CoreInterface {
  bool get isConnected;

  Future<String> preload();

  Future<bool> shutdown(bool isUser);

  FutureOr<bool> destroy();

  Future<bool> init(InitParams params);

  Future<bool> get isInit;

  Future<bool> forceGc();

  Future<String> validateConfig(String path);

  Future<String> validateConfigWithBytes(String data);

  Future<Map<String, dynamic>> getConfig(String path);

  Future<Map<String, dynamic>> getConfigFromBytes(String data);

  Future<Delay> asyncTestDelay(String url, String proxyName);

  Future<String> updateConfig(UpdateParams updateParams);

  Future<String> setupConfig(SetupParams setupParams);

  Future<ProxiesData> getProxies();

  Future<String> changeProxy(ChangeProxyParams changeProxyParams);

  Future<bool> startListener();

  Future<bool> stopListener();

  Future<List<ExternalProvider>> getExternalProviders();

  Future<ExternalProvider?> getExternalProvider(String externalProviderName);

  Future<String> updateGeoData(UpdateGeoDataParams params);

  Future<String> sideLoadExternalProvider({
    required String providerName,
    required String data,
  });

  Future<String> updateExternalProvider(String providerName);

  FutureOr<Traffic> getTraffic(bool onlyStatisticsProxy);

  FutureOr<Traffic> getTotalTraffic(bool onlyStatisticsProxy);

  FutureOr<String> getCountryCode(String ip);

  FutureOr<int> getMemory();

  FutureOr<void> resetTraffic();

  FutureOr<void> startLog();

  FutureOr<void> stopLog();

  Future<bool> crash();

  FutureOr<List<TrackerInfo>> getConnections();

  FutureOr<bool> closeConnection(String id);

  FutureOr<String> deleteFile(String path);

  FutureOr<bool> closeConnections();

  FutureOr<bool> resetConnections();
}

abstract class CoreHandlerInterface with CoreInterface {
  Future<T?> _invokeMethod<T>({
    required CoreMethod method,
    Object? arguments,
    Duration? timeout,
  }) async {
    return await utils.handleWatch<T?>(
      function: () => invokeMethod<T>(
        method: method,
        arguments: arguments,
        timeout: timeout,
      ),
      onWatch: (_, elapsedMilliseconds) {
        if (watchExecution) {
          commonPrint.log('Invoke ${method.name} ${elapsedMilliseconds}ms');
        }
      },
    );
  }

  Future<T?> invokeMethod<T>({
    required CoreMethod method,
    Object? arguments,
    Duration? timeout,
  });

  Future<T> _invokeRequiredMethod<T>({
    required CoreMethod method,
    Object? arguments,
  }) async {
    final result = await _invokeMethod<T>(method: method, arguments: arguments);
    if (result == null) {
      throw CoreMethodException(
        code: 'empty_result',
        message: 'Core returned no response for ${method.name}',
      );
    }
    return result;
  }

  Future<bool> shutdownCore() async {
    return _invokeRequiredMethod<bool>(method: CoreMethod.shutdown);
  }

  @override
  Future<bool> init(InitParams params) async {
    return await _invokeMethod<bool>(
          method: CoreMethod.initClash,
          arguments: params.toJson(),
        ) ??
        false;
  }

  @override
  Future<bool> get isInit async {
    return await _invokeMethod<bool>(method: CoreMethod.getIsInit) ?? false;
  }

  @override
  Future<bool> forceGc() async {
    return await _invokeMethod<bool>(method: CoreMethod.forceGc) ?? false;
  }

  @override
  Future<String> validateConfig(String path) async {
    return _invokeRequiredMethod<String>(
      method: CoreMethod.validateConfig,
      arguments: path,
    );
  }

  @override
  Future<String> validateConfigWithBytes(String data) async {
    return _invokeRequiredMethod<String>(
      method: CoreMethod.validateConfigWithBytes,
      arguments: data,
    );
  }

  Future<Map<String, dynamic>> _getConfig(CoreMethod method, String source) {
    return _invokeRequiredMethod<Map<String, dynamic>>(
      method: method,
      arguments: source,
    );
  }

  @override
  Future<Map<String, dynamic>> getConfig(String path) {
    return _getConfig(CoreMethod.getConfig, path);
  }

  @override
  Future<Map<String, dynamic>> getConfigFromBytes(String data) {
    return _getConfig(CoreMethod.getConfigFromBytes, data);
  }

  @override
  Future<String> updateConfig(UpdateParams updateParams) async {
    return _invokeRequiredMethod<String>(
      method: CoreMethod.updateConfig,
      arguments: updateParams.toJson(),
    );
  }

  @override
  Future<String> setupConfig(SetupParams setupParams) async {
    return _invokeRequiredMethod<String>(
      method: CoreMethod.setupConfig,
      arguments: setupParams.toJson(),
    );
  }

  @override
  Future<bool> crash() async {
    return await _invokeMethod<bool>(method: CoreMethod.crash) ?? false;
  }

  @override
  Future<ProxiesData> getProxies() async {
    final data = await _invokeMethod<Map<String, dynamic>>(
      method: CoreMethod.getProxies,
    );
    return data == null
        ? const ProxiesData(proxies: {}, all: [])
        : ProxiesData.fromJson(data);
  }

  @override
  Future<String> changeProxy(ChangeProxyParams changeProxyParams) async {
    return await _invokeMethod<String>(
          method: CoreMethod.changeProxy,
          arguments: changeProxyParams.toJson(),
        ) ??
        '';
  }

  @override
  Future<List<ExternalProvider>> getExternalProviders() async {
    final data = await _invokeMethod<List<dynamic>>(
      method: CoreMethod.getExternalProviders,
    );
    return data
            ?.whereType<Map>()
            .map(
              (item) =>
                  ExternalProvider.fromJson(Map<String, Object?>.from(item)),
            )
            .toList() ??
        [];
  }

  @override
  Future<ExternalProvider?> getExternalProvider(
    String externalProviderName,
  ) async {
    final data = await _invokeMethod<Map<String, dynamic>>(
      method: CoreMethod.getExternalProvider,
      arguments: externalProviderName,
    );
    return data == null ? null : ExternalProvider.fromJson(data);
  }

  @override
  Future<String> updateGeoData(UpdateGeoDataParams params) async {
    return await _invokeMethod<String>(
          method: CoreMethod.updateGeoData,
          arguments: params.toJson(),
        ) ??
        '';
  }

  @override
  Future<String> sideLoadExternalProvider({
    required String providerName,
    required String data,
  }) async {
    return await _invokeMethod<String>(
          method: CoreMethod.sideLoadExternalProvider,
          arguments: {'providerName': providerName, 'data': data},
        ) ??
        '';
  }

  @override
  Future<String> updateExternalProvider(String providerName) async {
    return await _invokeMethod<String>(
          method: CoreMethod.updateExternalProvider,
          arguments: providerName,
        ) ??
        '';
  }

  @override
  Future<List<TrackerInfo>> getConnections() async {
    final data = await _invokeMethod<Map<String, dynamic>>(
      method: CoreMethod.getConnections,
    );
    final connections = data?['connections'];
    if (connections is! List) {
      return [];
    }
    return connections
        .whereType<Map>()
        .map((item) => TrackerInfo.fromJson(Map<String, Object?>.from(item)))
        .toList();
  }

  @override
  Future<bool> closeConnections() async {
    return await _invokeMethod<bool>(method: CoreMethod.closeConnections) ??
        false;
  }

  @override
  Future<bool> resetConnections() async {
    return await _invokeMethod<bool>(method: CoreMethod.resetConnections) ??
        false;
  }

  @override
  Future<bool> closeConnection(String id) async {
    return await _invokeMethod<bool>(
          method: CoreMethod.closeConnection,
          arguments: id,
        ) ??
        false;
  }

  @override
  Future<Traffic> getTotalTraffic(bool onlyStatisticsProxy) async {
    final data = await _invokeMethod<Map<String, dynamic>>(
      method: CoreMethod.getTotalTraffic,
      arguments: onlyStatisticsProxy,
    );
    return data == null ? const Traffic() : Traffic.fromJson(data);
  }

  @override
  Future<Traffic> getTraffic(bool onlyStatisticsProxy) async {
    final data = await _invokeMethod<Map<String, dynamic>>(
      method: CoreMethod.getTraffic,
      arguments: onlyStatisticsProxy,
    );
    return data == null ? const Traffic() : Traffic.fromJson(data);
  }

  @override
  Future<String> deleteFile(String path) async {
    return await _invokeMethod<String>(
          method: CoreMethod.deleteFile,
          arguments: path,
        ) ??
        '';
  }

  @override
  FutureOr<void> resetTraffic() {
    _invokeMethod(method: CoreMethod.resetTraffic);
  }

  @override
  FutureOr<void> startLog() {
    _invokeMethod(method: CoreMethod.startLog);
  }

  @override
  FutureOr<void> stopLog() {
    _invokeMethod<bool>(method: CoreMethod.stopLog);
  }

  @override
  Future<bool> startListener() async {
    return _invokeRequiredMethod<bool>(method: CoreMethod.startListener);
  }

  @override
  Future<bool> stopListener() async {
    return _invokeRequiredMethod<bool>(method: CoreMethod.stopListener);
  }

  @override
  Future<Delay> asyncTestDelay(String url, String proxyName) async {
    final data = await _invokeMethod<Map<String, dynamic>>(
      method: CoreMethod.asyncTestDelay,
      arguments: {
        'proxy-name': proxyName,
        'timeout': httpTimeoutDuration.inMilliseconds,
        'test-url': url,
      },
      timeout: const Duration(seconds: 6),
    );
    return data == null
        ? Delay(name: proxyName, value: -1, url: url)
        : Delay.fromJson(data);
  }

  @override
  Future<String> getCountryCode(String ip) async {
    return await _invokeMethod<String>(
          method: CoreMethod.getCountryCode,
          arguments: ip,
        ) ??
        '';
  }

  @override
  Future<int> getMemory() async {
    final value = await _invokeMethod<num>(method: CoreMethod.getMemory);
    return value?.toInt() ?? 0;
  }
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/state.dart';

class DlerCloudApi {
  static const String baseUrl = 'https://dler.cloud/api/v1';
  
  final Dio _dio;
  final Dio _clashDio;

  DlerCloudApi({Dio? dio}) 
      : _dio = dio ?? Dio(),
        _clashDio = Dio() {
    final baseOptions = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 5),
    );
    
    _dio.options = baseOptions;
    
    _clashDio.options = baseOptions;
    _clashDio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.findProxy = (uri) => FlClashHttpOverrides.handleFindProxy(uri);
        return client;
      },
    );
  }

  String _formatError(dynamic error) {
    if (error is! DioException) {
      return error?.toString().isNotEmpty == true 
          ? error.toString() 
          : '网络连接失败，请检查网络设置';
    }

    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => 
        '连接超时，请检查网络连接后重试',
      
      DioExceptionType.badResponse => 
        '服务器响应错误: ${error.response?.statusCode ?? "未知"}',
      
      DioExceptionType.cancel => 
        '请求已取消',
      
      DioExceptionType.badCertificate => 
        'SSL 证书验证失败',
      
      DioExceptionType.connectionError => 
        _isHandshakeError(error) 
            ? 'SSL 握手失败，请稍后重试'
            : '网络连接失败，请检查网络设置',
      
      DioExceptionType.unknown => 
        _isHandshakeError(error)
            ? 'SSL 握手失败，请稍后重试'
            : error.message?.isNotEmpty == true 
                ? '网络错误: ${error.message}'
                : '网络连接失败，请检查网络设置',
    };
  }

  bool _isHandshakeError(DioException error) {
    final msg = error.message?.toLowerCase() ?? '';
    return msg.contains('handshake') || msg.contains('connection terminated');
  }

  bool _shouldFallback(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError;
  }

  Result<T> _parseApiResponse<T>(
    Response<Map<String, dynamic>> response,
    T Function(Map<String, dynamic>) fromJson,
    bool dataInResponse,
  ) {
      if (response.statusCode != HttpStatus.ok || response.data == null) {
        return Result.error('请求失败: ${response.statusCode}');
      }

      final json = response.data!;
      final ret = json['ret'] as int?;

      if (ret != 200) {
        return Result.error(json['msg'] as String? ?? '未知错误');
      }

      if (dataInResponse) {
        final dataJson = json['data'] as Map<String, dynamic>?;
        if (dataJson == null) return Result.error('响应数据为空');
        return Result.success(fromJson(dataJson));
      }
      return Result.success(fromJson(json));
  }

  Future<Result<T>> _apiRequest<T>({
    required String endpoint,
    required Map<String, dynamic> data,
    required T Function(Map<String, dynamic>) fromJson,
    bool dataInResponse = true,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(endpoint, data: data);
      return _parseApiResponse(response, fromJson, dataInResponse);
    } catch (directError) {
      if (directError is DioException &&
          _shouldFallback(directError) &&
          globalState.appState.runTime != null) {
        try {
          final response = await _clashDio.post<Map<String, dynamic>>(endpoint, data: data);
          return _parseApiResponse(response, fromJson, dataInResponse);
        } catch (_) {
          // Ignore proxy error
        }
      }
      return Result.error(_formatError(directError));
    }
  }

  Future<Result<DlerCloudLoginData>> login({
    required String email,
    required String passwd,
    int? tokenExpire,
  }) async {
    return _apiRequest(
      endpoint: '/login',
      data: {
        'email': email,
        'passwd': passwd,
        if (tokenExpire != null) 'token_expire': tokenExpire,
      },
      fromJson: DlerCloudLoginData.fromJson,
    );
  }

  Future<Result<bool>> logout({required String accessToken}) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/logout',
        data: {'access_token': accessToken},
      );

      if (response.statusCode != HttpStatus.ok || response.data == null) {
        return Result.error('请求失败: ${response.statusCode}');
      }

      final json = response.data!;
      final ret = json['ret'] as int?;

      if (ret != 200) {
        return Result.error(json['msg'] as String? ?? '未知错误');
      }

      return Result.success(true);
    } catch (directError) {
      if (directError is DioException &&
          _shouldFallback(directError) &&
          globalState.appState.runTime != null) {
        try {
          final response = await _clashDio.post<Map<String, dynamic>>(
            '/logout',
            data: {'access_token': accessToken},
          );

          if (response.statusCode != HttpStatus.ok || response.data == null) {
            return Result.error('请求失败: ${response.statusCode}');
          }

          final json = response.data!;
          final ret = json['ret'] as int?;

          if (ret != 200) {
            return Result.error(json['msg'] as String? ?? '未知错误');
          }

          return Result.success(true);
        } catch (_) {
          // Ignore proxy error
        }
      }
      return Result.error(_formatError(directError));
    }
  }

  Future<Result<DlerCloudUserInfo>> getUserInfo({
    required String accessToken,
  }) async {
    return _apiRequest(
      endpoint: '/information',
      data: {'access_token': accessToken},
      fromJson: DlerCloudUserInfo.fromJson,
    );
  }

  Future<Result<DlerCloudManagedData>> getManaged({
    required String accessToken,
  }) async {
    return _apiRequest(
      endpoint: '/managed/clash',
      data: {
        'access_token': accessToken,
      },
      fromJson: DlerCloudManagedData.fromJson,
      dataInResponse: false,
    );
  }

  Future<Result<Map<String, dynamic>>> getSubscriptionPayload(String subscriptionUrl) async {
    final options = Options(
          responseType: ResponseType.plain,
          followRedirects: true,
          validateStatus: (status) => status != null && status < 500,
      );

    try {
      final response = await _dio.get<String>(subscriptionUrl, options: options);

      if (response.statusCode != HttpStatus.ok || response.data == null) {
        return Result.error('获取订阅失败: ${response.statusCode}');
      }

      return Result.success({
        'payload': response.data!,
        'subscription-userinfo': response.headers.value('subscription-userinfo'),
        'content-disposition': response.headers.value('content-disposition'),
      });
    } catch (directError) {
      if (directError is DioException &&
          _shouldFallback(directError) &&
          globalState.appState.runTime != null) {
        try {
          final response = await _clashDio.get<String>(subscriptionUrl, options: options);

          if (response.statusCode != HttpStatus.ok || response.data == null) {
            return Result.error('获取订阅失败: ${response.statusCode}');
          }

          return Result.success({
            'payload': response.data!,
            'subscription-userinfo': response.headers.value('subscription-userinfo'),
            'content-disposition': response.headers.value('content-disposition'),
      });
        } catch (_) {
          // Ignore proxy error
        }
      }
      return Result.error(_formatError(directError));
    }
  }

  Future<Result<DlerCloudAnnouncement>> getAnnouncement() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/announcement');

      if (response.statusCode != HttpStatus.ok || response.data == null) {
        return Result.error('请求失败: ${response.statusCode}');
      }

      final json = response.data!;
      final ret = json['ret'] as int?;

      if (ret == 404) {
        return Result.error('暂无公告');
      }

      if (ret != 200) {
        return Result.error(json['msg'] as String? ?? '未知错误');
      }

      final dataJson = json['data'] as Map<String, dynamic>?;
      if (dataJson == null) {
        return Result.error('响应数据为空');
      }

      return Result.success(DlerCloudAnnouncement.fromJson(dataJson));
    } catch (directError) {
      if (directError is DioException &&
          _shouldFallback(directError) &&
          globalState.appState.runTime != null) {
        try {
          final response = await _clashDio.get<Map<String, dynamic>>('/announcement');

          if (response.statusCode != HttpStatus.ok || response.data == null) {
            return Result.error('请求失败: ${response.statusCode}');
          }

          final json = response.data!;
          final ret = json['ret'] as int?;

          if (ret == 404) {
            return Result.error('暂无公告');
          }

          if (ret != 200) {
            return Result.error(json['msg'] as String? ?? '未知错误');
          }

          final dataJson = json['data'] as Map<String, dynamic>?;
          if (dataJson == null) {
            return Result.error('响应数据为空');
          }

          return Result.success(DlerCloudAnnouncement.fromJson(dataJson));
        } catch (_) {
          // Ignore proxy error
        }
      }
      return Result.error(_formatError(directError));
    }
  }

  Future<Result<String>> getVersion() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/version/get');

      if (response.statusCode != HttpStatus.ok || response.data == null) {
        return Result.error('请求失败: ${response.statusCode}');
      }

      final json = response.data!;
      final ret = json['ret'] as int?;

      if (ret == 404) {
        return Result.error('版本信息不存在');
      }

      if (ret != 200) {
        return Result.error(json['msg'] as String? ?? '未知错误');
      }

      final dataJson = json['data'] as Map<String, dynamic>?;
      if (dataJson == null) {
        return Result.error('响应数据为空');
      }

      final version = dataJson['version'] as String?;
      if (version == null || version.isEmpty) {
        return Result.error('版本号为空');
      }

      return Result.success(version);
    } catch (directError) {
      if (directError is DioException &&
          _shouldFallback(directError) &&
          globalState.appState.runTime != null) {
        try {
          final response = await _clashDio.get<Map<String, dynamic>>('/version/get');

          if (response.statusCode != HttpStatus.ok || response.data == null) {
            return Result.error('请求失败: ${response.statusCode}');
          }

          final json = response.data!;
          final ret = json['ret'] as int?;

          if (ret == 404) {
            return Result.error('版本信息不存在');
          }

          if (ret != 200) {
            return Result.error(json['msg'] as String? ?? '未知错误');
          }

          final dataJson = json['data'] as Map<String, dynamic>?;
          if (dataJson == null) {
            return Result.error('响应数据为空');
          }

          final version = dataJson['version'] as String?;
          if (version == null || version.isEmpty) {
            return Result.error('版本号为空');
          }

          return Result.success(version);
        } catch (_) {
          // Ignore proxy error
        }
      }
      return Result.error(_formatError(directError));
    }
  }
}

final dlerCloudApi = DlerCloudApi();
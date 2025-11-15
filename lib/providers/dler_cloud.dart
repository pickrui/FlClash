import 'dart:convert';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/dler_cloud.g.dart';

const String _dlerCloudTokenKey = 'dler_cloud_token';
const String _dlerCloudUserInfoKey = 'dler_cloud_user_info';
const String _dlerCloudManagedKey = 'dler_cloud_managed';

String? _extractDomain(String url) {
  try {
    final uri = Uri.parse(url);
    return uri.host;
  } catch (_) {
    return null;
  }
}

void _updateLogFilteredDomains(DlerCloudManagedData? managedData) {
  if (managedData == null) {
    globalState.logFilteredDomains.clear();
    return;
  }
  
  final domains = <String>{};
  
  final smartDomain = _extractDomain(managedData.smart);
  if (smartDomain != null) domains.add(smartDomain);
  
  if (managedData.ss2022 != null) {
    final ss2022Domain = _extractDomain(managedData.ss2022!);
    if (ss2022Domain != null) domains.add(ss2022Domain);
  }
  
  if (managedData.vmess != null) {
    final vmessDomain = _extractDomain(managedData.vmess!);
    if (vmessDomain != null) domains.add(vmessDomain);
  }
  
  final rootDomains = domains.map((domain) {
    final parts = domain.split('.');
    if (parts.length >= 2) {
      return parts.sublist(parts.length - 2).join('.');
    }
    return domain;
  }).toSet();
  
  domains.addAll(rootDomains);
  globalState.logFilteredDomains = domains;
}

/// Dler Cloud 账户状态
class DlerCloudAccountState {
  final String? token;
  final DlerCloudUserInfo? userInfo;
  final DlerCloudManagedData? managedData;
  final bool isLoading;
  final DateTime? lastRefreshTime;

  const DlerCloudAccountState({
    this.token,
    this.userInfo,
    this.managedData,
    this.isLoading = false,
    this.lastRefreshTime,
  });

  DlerCloudAccountState copyWith({
    String? token,
    DlerCloudUserInfo? userInfo,
    DlerCloudManagedData? managedData,
    bool? isLoading,
    DateTime? lastRefreshTime,
  }) {
    return DlerCloudAccountState(
      token: token ?? this.token,
      userInfo: userInfo ?? this.userInfo,
      managedData: managedData ?? this.managedData,
      isLoading: isLoading ?? this.isLoading,
      lastRefreshTime: lastRefreshTime ?? this.lastRefreshTime,
    );
  }
}

/// Dler Cloud 账户 Provider
@riverpod
class DlerCloudAccount extends _$DlerCloudAccount {
  @override
  Future<DlerCloudAccountState> build() async {
    final state = await _loadState();
    
    if (state.token != null && state.managedData == null) {
      _autoFetchManagedData(state.token!);
    }
    
    return state;
  }

  void _autoFetchManagedData(String token) async {
    try {
      final managedResult = await dlerCloudApi.getManaged(accessToken: token);
      
      if (managedResult.type == ResultType.success && managedResult.data != null) {
        final managedData = managedResult.data!;
        _updateLogFilteredDomains(managedData);
        await _autoImportSmartProfile(managedData.smart);
        
        final currentState = await _loadState();
        await _saveState(token, currentState.userInfo, managedData);
        
        if (ref.mounted) {
          state = AsyncValue.data(
            DlerCloudAccountState(
              token: token,
              userInfo: currentState.userInfo,
              managedData: managedData,
              isLoading: false,
              lastRefreshTime: DateTime.now(),
            ),
          );
        }
      }
    } catch (_) {
      // 静默处理错误
    }
  }

  Future<DlerCloudAccountState> _loadState() async {
    try {
      final prefs = await preferences.sharedPreferencesCompleter.future;
      final token = prefs?.getString(_dlerCloudTokenKey);
      final userInfoJson = prefs?.getString(_dlerCloudUserInfoKey);
      final managedJson = prefs?.getString(_dlerCloudManagedKey);
      
      DlerCloudUserInfo? userInfo;
      if (userInfoJson != null) {
        final json = jsonDecode(userInfoJson) as Map<String, dynamic>;
        userInfo = DlerCloudUserInfo.fromJson(json);
      }

      DlerCloudManagedData? managedData;
      if (managedJson != null) {
        final json = jsonDecode(managedJson) as Map<String, dynamic>;
        managedData = DlerCloudManagedData.fromJson(json);
      }

      // 更新日志过滤域名（从已保存的配置中恢复）
      _updateLogFilteredDomains(managedData);

      return DlerCloudAccountState(
        token: token,
        userInfo: userInfo,
        managedData: managedData,
      );
    } catch (_) {
      return const DlerCloudAccountState();
    }
  }

  Future<void> _saveState(
    String? token,
    DlerCloudUserInfo? userInfo,
    DlerCloudManagedData? managedData,
  ) async {
    try {
      final prefs = await preferences.sharedPreferencesCompleter.future;
      if (token != null) {
        await prefs?.setString(_dlerCloudTokenKey, token);
      } else {
        await prefs?.remove(_dlerCloudTokenKey);
      }
      
      if (userInfo != null) {
        await prefs?.setString(_dlerCloudUserInfoKey, jsonEncode(userInfo.toJson()));
      } else {
        await prefs?.remove(_dlerCloudUserInfoKey);
      }

      if (managedData != null) {
        await prefs?.setString(_dlerCloudManagedKey, jsonEncode(managedData.toJson()));
      } else {
        await prefs?.remove(_dlerCloudManagedKey);
      }
    } catch (_) {
      // Ignore save errors
    }
  }

  String _buildUrlWithoutOptionalParams(String url, String urlParams) {
    if (urlParams.isEmpty) return url;
    
    final questionMarkIndex = url.indexOf('?');
    if (questionMarkIndex == -1) return url;
    
    final urlBase = url.substring(0, questionMarkIndex);
    String queryString = url.substring(questionMarkIndex + 1);
    
    final lastDotIndex = queryString.lastIndexOf('.');
    String extension = '';
    if (lastDotIndex != -1) {
      extension = queryString.substring(lastDotIndex);
      queryString = queryString.substring(0, lastDotIndex);
    }
    
    final ampersandIndex = queryString.indexOf('&');
    final requiredParams = ampersandIndex != -1
        ? queryString.substring(0, ampersandIndex)
        : queryString;
    
    return '$urlBase?$requiredParams$extension';
  }

  Future<void> _autoImportSmartProfile(String smartUrl) async {
    try {
      final profiles = globalState.config.profiles;
      final baseUrl = utils.removeUrlParams(smartUrl);
      final urlParams = utils.extractUrlParams(smartUrl);
      
      final existingProfile = profiles.cast<Profile?>().firstWhere(
        (p) => p != null && utils.removeUrlParams(p.url) == baseUrl,
        orElse: () => null,
      );
      
      if (existingProfile != null) {
        final profileToUpdate = existingProfile.copyWith(
          url: _buildUrlWithoutOptionalParams(smartUrl, urlParams),
          urlParams: urlParams,
        );
        globalState.appController.setProfile(profileToUpdate);
        await globalState.appController.updateProfile(profileToUpdate);
      } else {
        final newProfile = Profile.normal(url: _buildUrlWithoutOptionalParams(smartUrl, urlParams)).copyWith(
          urlParams: urlParams,
        );
        
        final profile = await globalState.appController.safeRun(
          () async {
            return await newProfile.update();
          },
          needLoading: true,
          title: '添加配置',
        );
        
        if (profile != null) {
          await globalState.appController.addProfile(profile);
        }
      }
    } catch (_) {
      // Ignore import errors
    }
  }

  Future<Result<DlerCloudLoginData>> login({
    required String email,
    required String passwd,
    int? tokenExpire,
  }) async {
    state = AsyncValue.data(
      (await _loadState()).copyWith(isLoading: true),
    );

    try {
      final result = await dlerCloudApi.login(
        email: email,
        passwd: passwd,
        tokenExpire: tokenExpire,
      );

      if (result.type == ResultType.success && result.data != null) {
        final loginData = result.data!;
        final userInfo = DlerCloudUserInfo(
          plan: loginData.plan,
          planTime: loginData.planTime,
          money: loginData.money,
          affMoney: loginData.affMoney,
          todayUsed: loginData.todayUsed,
          used: loginData.used,
          unused: loginData.unused,
          traffic: loginData.traffic,
          integral: loginData.integral,
        );

        DlerCloudManagedData? managedData;
        final managedResult = await dlerCloudApi.getManaged(
          accessToken: loginData.token,
        );
        if (managedResult.type == ResultType.success && managedResult.data != null) {
          managedData = managedResult.data!;
          _updateLogFilteredDomains(managedData);
        await _autoImportSmartProfile(managedData.smart);
      } else {
        await _showRetryManagedDialog(loginData.token);
        }

        await _saveState(loginData.token, userInfo, managedData);
        
        if (ref.mounted) {
        state = AsyncValue.data(
          DlerCloudAccountState(
            token: loginData.token,
            userInfo: userInfo,
            managedData: managedData,
            isLoading: false,
            lastRefreshTime: DateTime.now(),
          ),
        );
        }
      } else {
        if (ref.mounted) {
        state = AsyncValue.data(
          (await _loadState()).copyWith(isLoading: false),
        );
        }
      }

      return result;
    } catch (e) {
      if (ref.mounted) {
      state = AsyncValue.data(
        (await _loadState()).copyWith(isLoading: false),
      );
      }
      return Result.error('登录失败: $e');
    }
  }

  /// 使用 Access Token 登录
  Future<Result<DlerCloudLoginData>> loginWithToken({
    required String token,
  }) async {
    state = AsyncValue.data(
      (await _loadState()).copyWith(isLoading: true),
    );

    try {
      final userInfoResult = await dlerCloudApi.getUserInfo(
        accessToken: token,
      );

      if (userInfoResult.type != ResultType.success || userInfoResult.data == null) {
        if (ref.mounted) {
        state = AsyncValue.data(
          (await _loadState()).copyWith(isLoading: false),
        );
        }
        return Result.error(userInfoResult.message);
      }

      final userInfo = userInfoResult.data!;

      DlerCloudManagedData? managedData;
      final managedResult = await dlerCloudApi.getManaged(
        accessToken: token,
      );
      if (managedResult.type == ResultType.success && managedResult.data != null) {
        managedData = managedResult.data!;
        _updateLogFilteredDomains(managedData);
        await _autoImportSmartProfile(managedData.smart);
      } else {
        await _showRetryManagedDialog(token);
      }

      await _saveState(token, userInfo, managedData);
      
      if (ref.mounted) {
      state = AsyncValue.data(
        DlerCloudAccountState(
          token: token,
          userInfo: userInfo,
          managedData: managedData,
          isLoading: false,
          lastRefreshTime: DateTime.now(),
        ),
      );
      }

      // 返回一个 DlerCloudLoginData 格式的数据
      // 注意：由于使用 token 登录，某些字段可能不可用，使用默认值
      final loginData = DlerCloudLoginData(
        token: token,
        tokenExpire: '',
        plan: userInfo.plan,
        planTime: userInfo.planTime,
        money: userInfo.money,
        affMoney: userInfo.affMoney,
        todayUsed: userInfo.todayUsed,
        used: userInfo.used,
        unused: userInfo.unused,
        traffic: userInfo.traffic,
        integral: userInfo.integral,
      );

      return Result.success(loginData);
    } catch (e) {
      if (ref.mounted) {
      state = AsyncValue.data(
        (await _loadState()).copyWith(isLoading: false),
      );
      }
      return Result.error('登录失败: $e');
    }
  }

  /// 退出登录（仅清除本地状态，不删除Token）
  Future<Result<bool>> logout() async {
    final currentState = await _loadState();

    if (currentState.token == null) {
      return Result.error('未登录');
    }

    await _removeDlerCloudProfiles(currentState.managedData);
    await _saveState(null, null, null);
    _updateLogFilteredDomains(null);
    
    state = const AsyncValue.data(
      DlerCloudAccountState(isLoading: false),
    );

    return Result.success(true);
  }

  /// 注销并删除Token（调用API删除Token）
  Future<Result<bool>> logoutAndDeleteToken() async {
    final currentState = await _loadState();
    final token = currentState.token;

    if (token == null) {
      return Result.error('未登录');
    }

    state = AsyncValue.data(
      currentState.copyWith(isLoading: true),
    );

    try {
      final result = await dlerCloudApi.logout(accessToken: token);

      if (result.type == ResultType.success) {
        await _removeDlerCloudProfiles(currentState.managedData);
        await _saveState(null, null, null);
        _updateLogFilteredDomains(null);
        
        if (ref.mounted) {
        state = const AsyncValue.data(
          DlerCloudAccountState(isLoading: false),
        );
        }
      } else {
        if (ref.mounted) {
        state = AsyncValue.data(
          currentState.copyWith(isLoading: false),
        );
        }
      }

      return result;
    } catch (e) {
      if (ref.mounted) {
      state = AsyncValue.data(
        currentState.copyWith(isLoading: false),
      );
      }
      return Result.error('注销失败: $e');
    }
  }

  /// 刷新用户信息
  Future<Result<DlerCloudUserInfo>> refreshUserInfo() async {
    final currentState = await _loadState();
    final token = currentState.token;

    if (token == null) {
      return Result.error('未登录');
    }

    state = AsyncValue.data(
      currentState.copyWith(isLoading: true),
    );

    try {
      final result = await dlerCloudApi.getUserInfo(accessToken: token);

      if (result.type == ResultType.success && result.data != null) {
        final userInfo = result.data!;
        await _saveState(token, userInfo, currentState.managedData);
        if (ref.mounted) {
        state = AsyncValue.data(
          DlerCloudAccountState(
            token: token,
            userInfo: userInfo,
            managedData: currentState.managedData,
            isLoading: false,
            lastRefreshTime: DateTime.now(),
          ),
        );
        }
      } else {
        if (ref.mounted) {
        state = AsyncValue.data(
          currentState.copyWith(isLoading: false),
        );
        }
      }

      return result;
    } catch (e) {
      if (ref.mounted) {
      state = AsyncValue.data(
        currentState.copyWith(isLoading: false),
      );
      }
      return Result.error('获取用户信息失败: $e');
    }
  }

  /// 获取订阅地址
  Future<Result<DlerCloudManagedData>> getManaged() async {
    final currentState = await _loadState();
    final token = currentState.token;

    if (token == null) {
      return Result.error('未登录');
    }

    state = AsyncValue.data(
      currentState.copyWith(isLoading: true),
    );

    try {
      final result = await dlerCloudApi.getManaged(
        accessToken: token,
      );

      if (result.type == ResultType.success && result.data != null) {
        final managedData = result.data!;
        _updateLogFilteredDomains(managedData);
        await _autoImportSmartProfile(managedData.smart);
        
        await _saveState(token, currentState.userInfo, managedData);
        if (ref.mounted) {
        state = AsyncValue.data(
          DlerCloudAccountState(
            token: token,
            userInfo: currentState.userInfo,
            managedData: managedData,
            isLoading: false,
          ),
        );
        }
      } else {
        if (ref.mounted) {
        state = AsyncValue.data(
          currentState.copyWith(isLoading: false),
        );
        }
      }

      return result;
    } catch (e) {
      if (ref.mounted) {
      state = AsyncValue.data(
        currentState.copyWith(isLoading: false),
      );
      }
      return Result.error('获取订阅地址失败: $e');
    }
  }

  /// 获取公告信息
  Future<Result<DlerCloudAnnouncement>> getAnnouncement() async {
    try {
      return await dlerCloudApi.getAnnouncement();
    } catch (e) {
      return Result.error('获取公告失败: $e');
    }
  }

  /// 删除 Dler Cloud 相关的订阅配置
  Future<void> _removeDlerCloudProfiles(DlerCloudManagedData? managedData) async {
    if (managedData == null) return;

    try {
      final profiles = globalState.config.profiles;
      final urlsToRemove = <String>{
        managedData.smart,
        if (managedData.ss2022 != null) managedData.ss2022!,
        if (managedData.vmess != null) managedData.vmess!,
      };

      final profilesToRemove = profiles.where((profile) {
        final url = profile.url;
        if (url.isEmpty) return false;
        
        final profileUrl = utils.removeUrlParams(url);
        return urlsToRemove.any((targetUrl) {
          final cleanUrl = utils.removeUrlParams(targetUrl);
          return profileUrl == cleanUrl;
        });
      }).toList();

      for (final profile in profilesToRemove) {
        try {
          await globalState.appController.deleteProfile(profile.id);
        } catch (_) {
          // Ignore individual profile deletion failures
        }
      }
    } catch (_) {
      // Ignore deletion errors, don't affect logout flow
    }
  }

  Future<void> _showRetryManagedDialog(String token) async {
    try {
      final result = await globalState.showMessage(
        title: '获取订阅配置失败',
        message: const TextSpan(text: '是否重试？'),
        confirmText: '重试',
        cancelable: true,
      );

      if (result == true) {
        await _retryGetManaged(token);
      }
    } catch (_) {
      // Ignore dialog errors
    }
  }

  /// 重试获取订阅地址
  Future<void> _retryGetManaged(String token) async {
    final currentState = await _loadState();
    
    final managedResult = await dlerCloudApi.getManaged(
      accessToken: token,
    );
    
    if (managedResult.type == ResultType.success && managedResult.data != null) {
      final managedData = managedResult.data!;
      _updateLogFilteredDomains(managedData);
      await _autoImportSmartProfile(managedData.smart);
      
      await _saveState(token, currentState.userInfo, managedData);
      if (ref.mounted) {
        state = AsyncValue.data(
          DlerCloudAccountState(
            token: token,
            userInfo: currentState.userInfo,
            managedData: managedData,
            isLoading: false,
            lastRefreshTime: DateTime.now(),
          ),
        );
      }
      
      globalState.showMessage(
        title: '成功',
        message: const TextSpan(text: '订阅地址获取成功'),
      );
    } else {
      await _showRetryManagedDialog(token);
    }
  }
}


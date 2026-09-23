import 'dart:async';
import 'dart:io';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/boot_record.dart';
import 'package:fl_clash/models/models.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

class App {
  static App? _instance;
  late MethodChannel methodChannel;
  final _packageChanges = StreamController<void>.broadcast(sync: true);
  Stream<void> get packageChanges => _packageChanges.stream;
  final _iconChanges = StreamController<void>.broadcast(sync: true);
  Stream<void> get iconChanges => _iconChanges.stream;

  App._internal() {
    methodChannel = const MethodChannel('$packageName/app');
    methodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'packagesChanged':
          clearPackageIconCache();
          _packageChanges.add(null);
        default:
          throw MissingPluginException();
      }
    });
  }

  factory App() {
    _instance ??= App._internal();
    return _instance!;
  }

  Future<AppExitInfo?> getLastExitInfo() async {
    return AppExitInfo.fromJson(
      await methodChannel.invokeMethod<Object?>('getLastExitInfo'),
    );
  }

  Future<bool?> moveTaskToBack() async {
    return methodChannel.invokeMethod<bool>('moveTaskToBack');
  }

  Future<List<Package>> getPackages({bool refresh = false}) async {
    final packagesString = await methodChannel.invokeMethod<String>(
      'getPackages',
      {'refresh': refresh},
    );
    final List<dynamic> packagesRaw =
        (await packagesString?.commonToJSON<List<dynamic>>()) ?? [];
    return packagesRaw.map((e) => Package.fromJson(e)).toSet().toList();
  }

  Future<bool> isInstalledAppsPermissionGranted() async {
    return await methodChannel.invokeMethod<bool>(
          'isInstalledAppsPermissionGranted',
        ) ??
        false;
  }

  Future<bool> requestInstalledAppsPermission() async {
    return await methodChannel.invokeMethod<bool>(
          'requestInstalledAppsPermission',
        ) ??
        false;
  }

  Future<bool> openAppSettings() async {
    return await methodChannel.invokeMethod<bool>('openAppSettings') ?? false;
  }

  Future<List<String>> getChinaPackageNames() async {
    final packageNamesString = await methodChannel.invokeMethod<String>(
      'getChinaPackageNames',
    );
    final List<dynamic> packageNamesRaw =
        await packageNamesString?.commonToJSON<List<dynamic>>() ?? [];
    return packageNamesRaw.map((e) => e.toString()).toList();
  }

  Future<bool> openFile(String path) async {
    return await methodChannel.invokeMethod<bool>('openFile', {'path': path}) ??
        false;
  }

  int _iconRevision = 0;
  final Map<String, ImageProvider?> _packageIcons = {};
  final Map<String, Future<ImageProvider?>> _packageIconTasks = {};

  bool hasPackageIcon(String packageName) {
    return _packageIcons.containsKey(packageName);
  }

  ImageProvider? getCachedPackageIcon(String packageName) {
    return _packageIcons[packageName];
  }

  Future<ImageProvider?> getPackageIcon(String packageName) {
    if (packageName.isEmpty) {
      return Future.value(null);
    }
    if (_packageIcons.containsKey(packageName)) {
      return Future.value(_packageIcons[packageName]);
    }
    return _packageIconTasks[packageName] ??= _loadPackageIcon(packageName);
  }

  Future<ImageProvider?> _loadPackageIcon(String packageName) async {
    final revision = _iconRevision;
    ImageProvider? icon;
    try {
      final path = await methodChannel.invokeMethod<String>('getPackageIcon', {
        'packageName': packageName,
      });
      icon = path == null || path.isEmpty ? null : FileImage(File(path));
    } catch (error) {
      commonPrint.log('getPackageIcon error: $error');
    }
    if (revision != _iconRevision) return null;
    _packageIcons[packageName] = icon;
    _packageIconTasks.remove(packageName);
    return icon;
  }

  void clearPackageIconCache() {
    _iconRevision++;
    _packageIcons.clear();
    _packageIconTasks.clear();
    _iconChanges.add(null);
  }

  Future<bool?> tip(String message) async {
    return methodChannel.invokeMethod<bool>('tip', {'message': message});
  }

  Future<bool?> initShortcuts() async {
    return methodChannel.invokeMethod<bool>(
      'initShortcuts',
      appLocalizations.toggle,
    );
  }

  Future<bool?> updateExcludeFromRecents(bool value) async {
    return methodChannel.invokeMethod<bool>('updateExcludeFromRecents', {
      'value': value,
    });
  }
}

final app = system.isAndroid ? App() : null;

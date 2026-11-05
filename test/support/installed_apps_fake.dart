import 'dart:async';

import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/plugins/app.dart';
import 'package:mocktail/mocktail.dart';

Package installedPackage(String name, {int version = 1, bool system = false}) =>
    Package(
      packageName: name,
      label: name,
      system: system,
      internet: true,
      lastUpdateTime: version,
    );

class InstalledAppsFake extends Fake implements App {
  final changes = StreamController<void>.broadcast(sync: true);
  bool granted = true;
  bool requestResult = true;
  bool fail = false;
  int queries = 0;
  int requests = 0;
  int settings = 0;
  List<Package> packages = [];
  Future<List<Package>> Function()? load;
  Future<bool> Function()? check;

  @override
  Stream<void> get packageChanges => changes.stream;
  @override
  Future<bool> isInstalledAppsPermissionGranted() async =>
      await check?.call() ?? granted;
  @override
  Future<List<Package>> getPackages({bool refresh = false}) async {
    queries++;
    if (!refresh) throw StateError('The page must request a current list');
    if (fail) throw StateError('PackageManager unavailable');
    return await load?.call() ?? packages;
  }

  @override
  void clearPackageIconCache() {}
  @override
  Future<bool> requestInstalledAppsPermission() async {
    requests++;
    granted = requestResult;
    return requestResult;
  }

  @override
  Future<bool> openAppSettings() async {
    settings++;
    return true;
  }
}

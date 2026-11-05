import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/plugins/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InstalledAppsResult {
  final bool permissionGranted;
  final List<Package> packages;

  const InstalledAppsResult({
    required this.permissionGranted,
    this.packages = const [],
  });
}

final installedAppsAppProvider = Provider<App?>((ref) => app);

final installedAppsProvider = FutureProvider.autoDispose<InstalledAppsResult>((
  ref,
) async {
  final api = ref.watch(installedAppsAppProvider);
  if (api == null) return const InstalledAppsResult(permissionGranted: true);
  final changes = api.packageChanges.listen((_) => ref.invalidateSelf());
  ref.onDispose(changes.cancel);
  // The OS can return a nonempty but partial list when vendor permission is denied.
  if (!await api.isInstalledAppsPermissionGranted()) {
    return const InstalledAppsResult(permissionGranted: false);
  }
  final packages = await api.getPackages(refresh: true);
  if (!await api.isInstalledAppsPermissionGranted()) {
    return const InstalledAppsResult(permissionGranted: false);
  }
  return InstalledAppsResult(permissionGranted: true, packages: packages);
}, retry: (_, _) => null);

import 'package:fl_clash/common/secrets.dart';

const oixCloudManagedProfileUrl = 'oixcloud://managed';

bool isoixCloudProfileUrl(String url) {
  final normalizedUrl = url.trim().toLowerCase();
  if (normalizedUrl == oixCloudManagedProfileUrl) return true;

  final parsed = Uri.tryParse(normalizedUrl);
  if (parsed == null) return false;
  return parsed.scheme == 'oixcloud' ||
      Secrets.cloudDomains.contains(parsed.host);
}

Future<T?> createAndActivateManagedProfile<T>({
  required Future<T?> Function({required bool requestStartIfNeeded}) create,
  required Future<void> Function(T profile) activate,
}) async {
  final profile = await create(requestStartIfNeeded: false);
  if (profile != null) {
    await activate(profile);
  }
  return profile;
}

typedef ManagedProfileDeduplicator<T> = Future<void> Function(List<T> profiles);

typedef ManagedProfileRefresher<T> =
    Future<T> Function(
      T profile, {
      required bool showLoading,
      required bool applyIfCurrent,
    });

typedef ManagedProfileActivator<T> =
    Future<void> Function(T profile, {required bool applyIfRunning});

class CloudManagedProfileUpdateFlow<T> {
  final ManagedProfileDeduplicator<T> deduplicate;
  final ManagedProfileRefresher<T> refresh;
  final ManagedProfileActivator<T> activate;

  const CloudManagedProfileUpdateFlow({
    required this.deduplicate,
    required this.refresh,
    required this.activate,
  });

  Future<T> refreshExisting(
    List<T> existing, {
    required bool showLoading,
  }) async {
    if (existing.isEmpty) {
      throw StateError('No oixCloud profile to refresh');
    }

    await deduplicate(existing);
    final updatedProfile = await refresh(
      existing.first,
      showLoading: showLoading,
      applyIfCurrent: false,
    );
    await activate(updatedProfile, applyIfRunning: false);
    return updatedProfile;
  }
}

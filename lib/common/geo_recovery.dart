import 'package:fl_clash/common/constant.dart' show ASN, GEOIP, GEOSITE, MMDB;
import 'package:fl_clash/enum/enum.dart';

String geoFileName(GeoResource resource) => switch (resource) {
  GeoResource.MMDB => MMDB,
  GeoResource.ASN => ASN,
  GeoResource.GEOIP => GEOIP,
  GeoResource.GEOSITE => GEOSITE,
};

String geoReleaseFileName(GeoResource resource) => switch (resource) {
  GeoResource.MMDB => 'geoip.metadb',
  GeoResource.ASN => 'GeoLite2-ASN.mmdb',
  GeoResource.GEOIP => 'geoip.dat',
  GeoResource.GEOSITE => 'geosite.dat',
};

final _geoDownloadError = RegExp(
  r"can't download (GeoIP\.dat|GeoSite\.dat|MMDB|ASN(?:\.mmdb)?):",
  caseSensitive: false,
);
final _httpGetError = RegExp(
  r"""Get ["'](https?://[^"']+)["']:""",
  caseSensitive: false,
);

/// Inspect the actual failed URL, not resource names in unrelated error text.
String? failedGeoDownloadUrl(Object error) =>
    _httpGetError.firstMatch(error.toString())?.group(1);

GeoResource? _resourceForFile(String name) => switch (name.toLowerCase()) {
  'mmdb' || 'geoip.metadb' || 'country.mmdb' || 'geoip.db' => GeoResource.MMDB,
  'asn' || 'asn.mmdb' || 'geolite2-asn.mmdb' => GeoResource.ASN,
  'geoip.dat' => GeoResource.GEOIP,
  'geosite.dat' => GeoResource.GEOSITE,
  _ => null,
};

GeoResource? failedGeoResource(Object error) {
  final resource = _geoDownloadError.firstMatch(error.toString())?.group(1);
  if (resource != null) return _resourceForFile(resource);
  final url = Uri.tryParse(failedGeoDownloadUrl(error) ?? '');
  if (url == null || url.pathSegments.isEmpty) return null;
  return _resourceForFile(url.pathSegments.last);
}

/// Offline validation reports a missing dependency without attempting HTTP.
/// The application must try the configured URL before offering other sources.
bool needsInitialGeoDownload(Object error) =>
    failedGeoResource(error) != null &&
    error.toString().contains('validator://disabled');

/// Changing sources can repair network/content failures, not local filesystem
/// errors, an unavailable Core, or another update already holding the gate.
bool canRecoverGeoDownload(Object error) {
  final message = error.toString();
  if (message == 'context canceled' || message.endsWith(': context canceled')) {
    return false;
  }
  return message.startsWith('GEO download ') ||
      message.startsWith('invalid GEO download URL') ||
      RegExp(
        r'^invalid (MMDB|ASN|GEOIP|GEOSITE) database file:',
      ).hasMatch(message) ||
      failedGeoResource(error) != null ||
      failedGeoDownloadUrl(error) != null;
}

/// The validator never downloads dependencies. Try the configured source once
/// before showing recovery, while real download failures go straight to it.
Future<bool> downloadGeoWithRecovery({
  Object? initialError,
  required Future<String> Function() download,
  required Future<bool> Function(Object error) recover,
  required bool Function() shouldContinue,
}) async {
  if (!shouldContinue()) return false;
  final failure = initialError == null || needsInitialGeoDownload(initialError)
      ? await download()
      : initialError;
  if (!shouldContinue()) return false;
  if (failure == '') return true;
  if (!canRecoverGeoDownload(failure)) throw failure;
  final result = await recover(failure);
  return shouldContinue() && result;
}

/// Cancellation is a normal outcome. Each resource gets one successful repair
/// per apply, so a download that cannot fix the config cannot loop indefinitely.
Future<bool> withGeoRecovery({
  required Future<bool> Function() action,
  required Future<bool> Function(GeoResource resource, Object error) recover,
  required bool Function() shouldContinue,
}) async {
  final recovered = <GeoResource>{};
  while (shouldContinue()) {
    try {
      final result = await action();
      return shouldContinue() && result;
    } catch (error) {
      if (!shouldContinue()) return false;
      final resource = failedGeoResource(error);
      if (resource == null || !recovered.add(resource)) rethrow;
      if (!await recover(resource, error)) return false;
    }
  }
  return false;
}

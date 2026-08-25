part of '../model/estimated_intensity_archive_descriptor.dart';

/// Descriptor URL の authority と content-addressed path を検証する。
final class EstimatedIntensityArchiveUrlValidator {
  const new();

  EstimatedIntensityArchiveFailure? validate({
    required String rawUrl,
    required Uri uri,
    required String eventId,
    required String sha256,
    required EstimatedIntensityArchiveUrlPolicy policy,
  }) {
    if (uri.scheme != 'https') {
      return .insecureScheme;
    }
    if (!uri.hasAuthority) {
      return .missingAuthority;
    }
    if (uri.host.isEmpty) {
      return .invalidUrl;
    }
    if (uri.authority.contains('@')) {
      return .userInfoNotAllowed;
    }
    if (uri.hasQuery) {
      return .queryNotAllowed;
    }
    if (uri.hasFragment) {
      return .fragmentNotAllowed;
    }
    if (uri.hasPort && uri.port != 443) {
      return .nonDefaultPort;
    }
    if (!policy.allowedHosts.contains(uri.host)) {
      return .disallowedHost;
    }

    final pathFailure = const EstimatedIntensityArchiveUrlPathValidator()
        .validate(rawUrl: rawUrl, uri: uri, eventId: eventId, sha256: sha256);
    if (pathFailure != null) {
      return pathFailure;
    }

    final canonicalHost = uri.host.contains(':') ? '[${uri.host}]' : uri.host;
    final canonicalPath = '/ixac41/$eventId/$sha256.pmtiles';
    final canonicalUrl = 'https://$canonicalHost$canonicalPath';
    final canonicalUrlWithPort = 'https://$canonicalHost:443$canonicalPath';
    return rawUrl == canonicalUrl || rawUrl == canonicalUrlWithPort
        ? null
        : .nonCanonicalUrl;
  }
}

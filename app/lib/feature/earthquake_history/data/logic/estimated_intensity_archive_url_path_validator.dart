part of '../model/estimated_intensity_archive_descriptor.dart';

final _encodedSeparatorPattern = RegExp('%(?:2f|5c)', caseSensitive: false);

/// Decoded segment と raw path の両方を照合し、URI alias を拒否する。
final class EstimatedIntensityArchiveUrlPathValidator {
  const new();

  EstimatedIntensityArchiveFailure? validate({
    required String rawUrl,
    required Uri uri,
    required String eventId,
    required String sha256,
  }) {
    final pathStart = rawUrl.indexOf('/', rawUrl.indexOf('://') + 3);
    final rawPath = pathStart < 0 ? '' : rawUrl.substring(pathStart);
    if (rawPath.contains('//') || rawPath.endsWith('/')) {
      return .invalidPath;
    }
    if (_encodedSeparatorPattern.hasMatch(rawPath)) {
      return .invalidPath;
    }

    final segments = uri.pathSegments;
    if (segments.length != 3 || segments.first != 'ixac41') {
      return .invalidPath;
    }
    if (segments[1] != eventId) {
      return _estimatedIntensityEventIdPattern.hasMatch(segments[1])
          ? .eventIdMismatch
          : .invalidEventId;
    }

    final filename = segments[2];
    if (!filename.endsWith('.pmtiles')) {
      return .invalidPath;
    }
    final urlSha256 = filename.substring(0, filename.length - 8);
    if (!_estimatedIntensitySha256Pattern.hasMatch(urlSha256)) {
      return .invalidSha256;
    }
    if (urlSha256 != sha256) {
      return .sha256Mismatch;
    }

    final expectedPath = '/ixac41/$eventId/$sha256.pmtiles';
    return rawPath == expectedPath ? null : .nonCanonicalUrl;
  }
}

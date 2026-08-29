part of '../model/estimated_intensity_archive_descriptor.dart';

final class EarthquakeEventIdValidator {
  const new();

  bool validate(String eventId) =>
      _estimatedIntensityEventIdPattern.hasMatch(eventId);
}

/// API descriptor を package-neutral な検証済み値へ変換する pure boundary。
final class EstimatedIntensityArchiveDescriptorValidator {
  const new();

  EstimatedIntensityArchiveValidationResult validate({
    required String eventId,
    required EstimatedIntensityArchiveDescriptorInput? input,
    required EstimatedIntensityArchiveUrlPolicy policy,
  }) {
    if (!const EarthquakeEventIdValidator().validate(eventId)) {
      return const EstimatedIntensityArchiveValidationInvalid(
        .invalidEventId,
      );
    }
    if (input == null) {
      return const EstimatedIntensityArchiveValidationMissing();
    }
    if (input.sizeBytes <= 0) {
      return const EstimatedIntensityArchiveValidationInvalid(.invalidSize);
    }
    if (input.sizeBytes > policy.maxArchiveBytes) {
      return const EstimatedIntensityArchiveValidationInvalid(
        .archiveTooLarge,
      );
    }
    if (!_estimatedIntensitySha256Pattern.hasMatch(input.sha256)) {
      return const EstimatedIntensityArchiveValidationInvalid(.invalidSha256);
    }

    final uri = Uri.tryParse(input.url);
    if (uri == null) {
      return const EstimatedIntensityArchiveValidationInvalid(.invalidUrl);
    }
    final urlFailure = const EstimatedIntensityArchiveUrlValidator().validate(
      rawUrl: input.url,
      uri: uri,
      eventId: eventId,
      sha256: input.sha256,
      policy: policy,
    );
    if (urlFailure != null) {
      return EstimatedIntensityArchiveValidationInvalid(urlFailure);
    }

    return EstimatedIntensityArchiveValidationValid(
      EstimatedIntensityArchiveDescriptor._(
        eventId: eventId,
        url: uri,
        sizeBytes: input.sizeBytes,
        sha256: input.sha256,
      ),
    );
  }
}

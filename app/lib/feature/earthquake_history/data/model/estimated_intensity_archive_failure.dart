part of 'estimated_intensity_archive_descriptor.dart';

/// Untrusted descriptor の値を保持しない fail-closed reason。
enum EstimatedIntensityArchiveFailure {
  invalidEventId,
  invalidUrl,
  insecureScheme,
  missingAuthority,
  userInfoNotAllowed,
  queryNotAllowed,
  fragmentNotAllowed,
  nonDefaultPort,
  disallowedHost,
  invalidPath,
  nonCanonicalUrl,
  eventIdMismatch,
  invalidSha256,
  sha256Mismatch,
  invalidSize,
  archiveTooLarge,
}

/// API field の欠落、検証成功、検証失敗を区別する結果。
sealed class EstimatedIntensityArchiveValidationResult {
  const new();
}

final class EstimatedIntensityArchiveValidationMissing
    extends EstimatedIntensityArchiveValidationResult {
  const new();

  @override
  String toString() => 'EstimatedIntensityArchiveValidationResult.missing()';
}

final class EstimatedIntensityArchiveValidationValid
    extends EstimatedIntensityArchiveValidationResult {
  const new(this.descriptor);

  final EstimatedIntensityArchiveDescriptor descriptor;

  @override
  String toString() =>
      'EstimatedIntensityArchiveValidationResult.valid($descriptor)';
}

final class EstimatedIntensityArchiveValidationInvalid
    extends EstimatedIntensityArchiveValidationResult {
  const new(this.failure);

  final EstimatedIntensityArchiveFailure failure;

  @override
  String toString() =>
      'EstimatedIntensityArchiveValidationResult.invalid('
      'failure: $failure)';
}

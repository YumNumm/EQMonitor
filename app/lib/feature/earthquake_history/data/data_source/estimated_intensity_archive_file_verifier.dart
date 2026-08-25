part of '../model/estimated_intensity_archive_download.dart';

/// Close済み一時fileを再読込し、exact sizeとSHA-256をattestする。
abstract interface class EstimatedIntensityArchiveFileVerifier {
  Future<EstimatedIntensityArchiveDownloadResult> verify({
    required EstimatedIntensityArchiveDescriptor descriptor,
    required File file,
  });
}

final class DartIoEstimatedIntensityArchiveFileVerifier
    implements EstimatedIntensityArchiveFileVerifier {
  const new();

  @override
  Future<EstimatedIntensityArchiveDownloadResult> verify({
    required EstimatedIntensityArchiveDescriptor descriptor,
    required File file,
  }) async {
    final actualLength = await file.length();
    if (actualLength != descriptor.sizeBytes) {
      return const EstimatedIntensityArchiveDownloadRejected(
        EstimatedIntensityArchiveDownloadFailure.sizeMismatch,
      );
    }
    final actualSha256 = (await sha256.bind(file.openRead()).first).toString();
    if (actualSha256 != descriptor.sha256) {
      return const EstimatedIntensityArchiveDownloadRejected(
        EstimatedIntensityArchiveDownloadFailure.sha256Mismatch,
      );
    }
    return EstimatedIntensityArchiveDownloadSuccess(
      VerifiedEstimatedIntensityArchiveDownload._(
        eventId: descriptor.eventId,
        sha256: descriptor.sha256,
        file: file,
        sizeBytes: actualLength,
      ),
    );
  }
}

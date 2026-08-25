part of '../model/estimated_intensity_archive_download.dart';

/// Close済み一時fileを再読込し、exact sizeとSHA-256をattestする。
abstract interface class EstimatedIntensityArchiveFileVerifier {
  Future<EstimatedIntensityArchiveDownloadResult> verify({
    required EstimatedIntensityArchiveDescriptor descriptor,
    required File file,
    required Future<EstimatedIntensityArchiveStopReason> stopRequested,
  });
}

final class DartIoEstimatedIntensityArchiveFileVerifier
    implements EstimatedIntensityArchiveFileVerifier {
  const new();

  @override
  Future<EstimatedIntensityArchiveDownloadResult> verify({
    required EstimatedIntensityArchiveDescriptor descriptor,
    required File file,
    required Future<EstimatedIntensityArchiveStopReason> stopRequested,
  }) async {
    final actualLength = await file.length();
    if (actualLength != descriptor.sizeBytes) {
      return const EstimatedIntensityArchiveDownloadRejected(
        EstimatedIntensityArchiveDownloadFailure.sizeMismatch,
      );
    }
    final digestIterator = StreamIterator(sha256.bind(file.openRead()));
    final moveNext = digestIterator.moveNext();
    final outcome = await Future.any([
      moveNext.then((moved) => (moved: moved, stopped: null)),
      stopRequested.then((stopped) => (moved: false, stopped: stopped)),
    ]);
    if (outcome.stopped case final stopped?) {
      try {
        await digestIterator.cancel();
      } catch (_) {}
      try {
        await moveNext;
      } catch (_) {}
      return const EstimatedIntensityArchiveStopResultMapper().map(stopped);
    }
    if (!outcome.moved) {
      return const EstimatedIntensityArchiveDownloadRejected(
        EstimatedIntensityArchiveDownloadFailure.requestFailed,
      );
    }
    final actualSha256 = digestIterator.current.toString();
    await digestIterator.cancel();
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

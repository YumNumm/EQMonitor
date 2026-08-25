part of '../model/estimated_intensity_archive_download.dart';

/// Close済み一時fileを再読込し、exact sizeとSHA-256をattestする。
abstract interface class EstimatedIntensityArchiveFileVerifier {
  Future<EstimatedIntensityArchiveDownloadResult> verify({
    required EstimatedIntensityArchiveDescriptor descriptor,
    required File file,
    required Future<EstimatedIntensityArchiveStopReason> stopRequested,
    required EstimatedIntensityArchiveDiagnosticReporter diagnosticReporter,
  });
}

abstract interface class EstimatedIntensityArchiveFileLengthReader {
  Future<int> read({required File file});
}

final class DartIoEstimatedIntensityArchiveFileLengthReader
    implements EstimatedIntensityArchiveFileLengthReader {
  const new();

  @override
  Future<int> read({required File file}) => file.length();
}

final class DartIoEstimatedIntensityArchiveFileVerifier
    implements EstimatedIntensityArchiveFileVerifier {
  const new({
    this.fileLengthReader =
        const DartIoEstimatedIntensityArchiveFileLengthReader(),
  });

  final EstimatedIntensityArchiveFileLengthReader fileLengthReader;

  @override
  Future<EstimatedIntensityArchiveDownloadResult> verify({
    required EstimatedIntensityArchiveDescriptor descriptor,
    required File file,
    required Future<EstimatedIntensityArchiveStopReason> stopRequested,
    required EstimatedIntensityArchiveDiagnosticReporter diagnosticReporter,
  }) async {
    final pendingLength = fileLengthReader.read(file: file);
    final lengthOutcome =
        await Future.any<
          ({int? length, EstimatedIntensityArchiveStopReason? stopped})
        >([
          pendingLength.then((length) => (length: length, stopped: null)),
          stopRequested.then((stopped) => (length: null, stopped: stopped)),
        ]);
    if (lengthOutcome.stopped case final stopped?) {
      try {
        await pendingLength;
      } catch (_) {}
      return const EstimatedIntensityArchiveStopResultMapper().map(stopped);
    }
    final actualLength = lengthOutcome.length;
    if (actualLength == null) {
      return const EstimatedIntensityArchiveDownloadRejected(
        EstimatedIntensityArchiveDownloadFailure.requestFailed,
      );
    }
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
      } catch (_) {
        reportEstimatedIntensityArchiveDiagnostic(
          reporter: diagnosticReporter,
          diagnostic: .hashStreamCancellationFailed,
        );
      }
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
    try {
      await digestIterator.cancel();
    } catch (_) {
      reportEstimatedIntensityArchiveDiagnostic(
        reporter: diagnosticReporter,
        diagnostic: .hashStreamCancellationFailed,
      );
    }
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

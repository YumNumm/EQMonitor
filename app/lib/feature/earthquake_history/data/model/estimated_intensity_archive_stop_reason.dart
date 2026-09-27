import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';

enum EstimatedIntensityArchiveStopReason { none, cancelled, timeout }

typedef EstimatedIntensityArchiveStopReasonReader =
    EstimatedIntensityArchiveStopReason Function();

final class const EstimatedIntensityArchiveStopResultMapper() {
  EstimatedIntensityArchiveDownloadRejected map(
    EstimatedIntensityArchiveStopReason reason,
  ) => EstimatedIntensityArchiveDownloadRejected(
    switch (reason) {
      EstimatedIntensityArchiveStopReason.none =>
        EstimatedIntensityArchiveDownloadFailure.requestFailed,
      EstimatedIntensityArchiveStopReason.cancelled =>
        EstimatedIntensityArchiveDownloadFailure.cancelled,
      EstimatedIntensityArchiveStopReason.timeout =>
        EstimatedIntensityArchiveDownloadFailure.timeout,
    },
  );
}

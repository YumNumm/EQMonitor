import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_descriptor.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';

/// Verifier resultを現在のdescriptorと一時fileへ再bindし、replayを拒否する。
final class EstimatedIntensityArchiveAttestationBinder {
  const new();

  EstimatedIntensityArchiveDownloadResult bind({
    required EstimatedIntensityArchiveDownloadResult result,
    required EstimatedIntensityArchiveDescriptor descriptor,
    required File partFile,
  }) {
    if (result case EstimatedIntensityArchiveDownloadSuccess(:final archive)) {
      final matchesCurrentDownload =
          archive.eventId == descriptor.eventId &&
          archive.sha256 == descriptor.sha256 &&
          archive.sizeBytes == descriptor.sizeBytes &&
          identical(archive.file, partFile);
      if (!matchesCurrentDownload) {
        return const EstimatedIntensityArchiveDownloadRejected(
          EstimatedIntensityArchiveDownloadFailure.requestFailed,
        );
      }
    }
    return result;
  }
}

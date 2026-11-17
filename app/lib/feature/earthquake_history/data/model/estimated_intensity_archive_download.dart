import 'dart:async';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_descriptor.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_cleanup_diagnostic.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_stop_reason.dart';

export 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_limits.dart';

part '../data_source/estimated_intensity_archive_file_verifier.dart';

/// Untrusted responseや例外の内容を保持しないfail-closed reason。
enum EstimatedIntensityArchiveDownloadFailure {
  cancelled,
  timeout,
  requestFailed,
  invalidStatus,
  invalidContentEncoding,
  invalidContentLength,
  archiveTooLarge,
  sizeMismatch,
  sha256Mismatch,
  storageFailure,
}

sealed class const EstimatedIntensityArchiveDownloadResult();

final class const EstimatedIntensityArchiveDownloadSuccess(
  final VerifiedEstimatedIntensityArchiveDownload archive,
) extends EstimatedIntensityArchiveDownloadResult {
  @override
  String toString() =>
      'EstimatedIntensityArchiveDownloadResult.success(identity: redacted)';
}

final class const EstimatedIntensityArchiveDownloadRejected(
  final EstimatedIntensityArchiveDownloadFailure failure,
) extends EstimatedIntensityArchiveDownloadResult {
  @override
  String toString() =>
      'EstimatedIntensityArchiveDownloadResult.rejected(failure: $failure)';
}

/// Exact sizeとSHA-256検証を完了した、未publishの一時archive。
final class const VerifiedEstimatedIntensityArchiveDownload._({
  required final String eventId,
  required final String sha256,
  required final File file,
  required final int sizeBytes,
}) {
  @override
  String toString() =>
      'VerifiedEstimatedIntensityArchiveDownload('
      'eventId: $eventId, sizeBytes: $sizeBytes, identity: redacted)';
}

import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_pmtiles_opener.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/estimated_intensity_archive_header_validator.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_header_validation.dart';
import 'package:pmtiles_v3/pmtiles_v3.dart';

/// SHA-256検証済みの一時fileを開き、受入可能なPMTilesか確認する。
final class EstimatedIntensityArchiveHeaderVerifier {
  const new({
    this.opener = const DartIoEstimatedIntensityArchivePmTilesOpener(),
    this.headerValidator = const EstimatedIntensityArchiveHeaderValidator(),
  });

  final EstimatedIntensityArchivePmTilesOpener opener;
  final EstimatedIntensityArchiveHeaderValidator headerValidator;

  Future<EstimatedIntensityArchiveHeaderValidationResult> verify({
    required VerifiedEstimatedIntensityArchiveDownload download,
    required PmTilesV3Limits limits,
  }) async {
    PmTilesV3Archive? archive;
    late final EstimatedIntensityArchiveHeaderValidationResult result;
    var closeFailed = false;
    try {
      archive = await opener.open(file: download.file, limits: limits);
      final header = archive.header;
      final failure = headerValidator.validate(header);
      result = failure == null
          ? EstimatedIntensityArchiveHeaderAccepted(header)
          : EstimatedIntensityArchiveHeaderRejected(failure);
    } on PmTilesV3SourceReadFailedException {
      result = const EstimatedIntensityArchiveHeaderRejected(
        EstimatedIntensityArchiveHeaderFailure.storageFailure,
      );
    } on PmTilesV3ResourceLimitExceededException {
      result = const EstimatedIntensityArchiveHeaderRejected(
        EstimatedIntensityArchiveHeaderFailure.resourceLimitExceeded,
      );
    } on FileSystemException {
      result = const EstimatedIntensityArchiveHeaderRejected(
        EstimatedIntensityArchiveHeaderFailure.storageFailure,
      );
    } on PmTilesV3Exception {
      result = const EstimatedIntensityArchiveHeaderRejected(
        EstimatedIntensityArchiveHeaderFailure.invalidArchive,
      );
    } finally {
      if (archive case final openedArchive?) {
        try {
          await openedArchive.close();
          // Archive implementations may throw any error while closing.
          // ignore: avoid_catches_without_on_clauses
        } catch (_) {
          closeFailed = true;
        }
      }
    }
    if (closeFailed && result is EstimatedIntensityArchiveHeaderAccepted) {
      return const EstimatedIntensityArchiveHeaderRejected(
        EstimatedIntensityArchiveHeaderFailure.closeFailure,
      );
    }
    return result;
  }
}

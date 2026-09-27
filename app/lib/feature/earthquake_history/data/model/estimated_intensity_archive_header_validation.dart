import 'package:pmtiles_v3/pmtiles_v3.dart';

enum EstimatedIntensityArchiveHeaderFailure {
  invalidArchive,
  invalidTileType,
  invalidTileCompression,
  invalidZoomRange,
  invalidBounds,
  storageFailure,
  resourceLimitExceeded,
  closeFailure,
}

sealed class const EstimatedIntensityArchiveHeaderValidationResult();

final class const EstimatedIntensityArchiveHeaderAccepted(
  final PmTilesV3Header header,
) extends EstimatedIntensityArchiveHeaderValidationResult {
  @override
  String toString() =>
      'EstimatedIntensityArchiveHeaderValidationResult.accepted('
      'zoom: ${header.minZoom}-${header.maxZoom})';
}

final class const EstimatedIntensityArchiveHeaderRejected(
  final EstimatedIntensityArchiveHeaderFailure failure,
) extends EstimatedIntensityArchiveHeaderValidationResult {
  @override
  String toString() =>
      'EstimatedIntensityArchiveHeaderValidationResult.rejected('
      'failure: $failure)';
}

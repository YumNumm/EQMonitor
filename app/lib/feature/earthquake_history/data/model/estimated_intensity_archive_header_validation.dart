import 'package:pmtiles_v3/pmtiles_v3.dart';

enum EstimatedIntensityArchiveHeaderFailure {
  invalidArchive,
  invalidTileType,
  invalidTileCompression,
  invalidZoomRange,
  invalidBounds,
  storageFailure,
  closeFailure,
}

sealed class EstimatedIntensityArchiveHeaderValidationResult {
  const new();
}

final class EstimatedIntensityArchiveHeaderAccepted
    extends EstimatedIntensityArchiveHeaderValidationResult {
  const new(this.header);

  final PmTilesV3Header header;

  @override
  String toString() =>
      'EstimatedIntensityArchiveHeaderValidationResult.accepted('
      'zoom: ${header.minZoom}-${header.maxZoom})';
}

final class EstimatedIntensityArchiveHeaderRejected
    extends EstimatedIntensityArchiveHeaderValidationResult {
  const new(this.failure);

  final EstimatedIntensityArchiveHeaderFailure failure;

  @override
  String toString() =>
      'EstimatedIntensityArchiveHeaderValidationResult.rejected('
      'failure: $failure)';
}

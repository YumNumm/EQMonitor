import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_header_validation.dart';
import 'package:pmtiles_v3/pmtiles_v3.dart';

/// `PmTilesV3Archive.open`済みheaderの推計震度固有制約を検証する。
///
/// PMTiles version、section範囲と重なり、internal compressionの対応状況は
/// archive open側の検証を正とし、ここでは再実装しない。
final class EstimatedIntensityArchiveHeaderValidator {
  const new();

  static const mvtTileType = 1;
  static const gzipTileCompression = 2;

  EstimatedIntensityArchiveHeaderFailure? validate(PmTilesV3Header header) {
    if (header.tileType != mvtTileType) {
      return EstimatedIntensityArchiveHeaderFailure.invalidTileType;
    }
    if (header.tileCompression != gzipTileCompression) {
      return EstimatedIntensityArchiveHeaderFailure.invalidTileCompression;
    }
    if (header.minZoom < 0 ||
        header.minZoom > header.maxZoom ||
        header.maxZoom > PmTilesV3TileId.maxZoom) {
      return EstimatedIntensityArchiveHeaderFailure.invalidZoomRange;
    }
    final bounds = [
      header.minLongitude,
      header.minLatitude,
      header.maxLongitude,
      header.maxLatitude,
    ];
    if (bounds.any((coordinate) => !coordinate.isFinite) ||
        header.minLongitude < -180 ||
        header.maxLongitude > 180 ||
        header.minLatitude < -90 ||
        header.maxLatitude > 90 ||
        header.minLongitude > header.maxLongitude ||
        header.minLatitude > header.maxLatitude) {
      return EstimatedIntensityArchiveHeaderFailure.invalidBounds;
    }
    return null;
  }
}

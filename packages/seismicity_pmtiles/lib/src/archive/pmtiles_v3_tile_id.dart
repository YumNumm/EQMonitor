import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

final class PmTilesV3TileId {
  const PmTilesV3TileId();

  static const maxZoom = 31;
  static const int maxValue = ((1 << 62) - 1) ~/ 3 + (1 << 62) - 1;

  ({int start, int endExclusive}) rangeForZoom({required int zoom}) {
    if (zoom < 0 || zoom > maxZoom) {
      throw RangeError.range(zoom, 0, maxZoom, 'zoom');
    }
    final tileCount = 1 << (zoom * 2);
    final start = (tileCount - 1) ~/ 3;
    return (start: start, endExclusive: start + tileCount);
  }

  void validateDecoded({required int tileId}) {
    if (tileId < 0 || tileId > maxValue) {
      throw SeismicityPmTilesException.corruptArchive(
        reason: 'Tile ID $tileId is outside the PMTiles v3 zoom 0-31 range.',
      );
    }
  }

  void validateArgument({required int tileId}) {
    if (tileId < 0 || tileId > maxValue) {
      throw SeismicityPmTilesException.invalidTileId(
        tileId: tileId,
        minTileId: 0,
        maxTileId: maxValue,
      );
    }
  }
}

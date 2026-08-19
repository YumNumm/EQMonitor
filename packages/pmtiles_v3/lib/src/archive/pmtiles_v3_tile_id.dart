import 'package:pmtiles_v3/src/model/pmtiles_v3_exception.dart';

final class PmTilesV3TileId {
  const new();

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
      throw PmTilesV3Exception.corruptArchive(
        reason: 'Tile ID $tileId is outside the PMTiles v3 zoom 0-31 range.',
      );
    }
  }

  void validateArgument({required int tileId}) {
    if (tileId < 0 || tileId > maxValue) {
      throw PmTilesV3Exception.invalidTileId(
        tileId: tileId,
        minTileId: 0,
        maxTileId: maxValue,
      );
    }
  }

  /// z/x/yで指定したXYZタイル座標を、Hilbert曲線でarchive内のtile IDへ変換する。
  /// PMTiles v3仕様のTile ID Calculationに基づく変換で、archiveの内容とは
  /// 無関係にzoom/x/yだけから決まる。
  int tileIdForZxy({required int z, required int x, required int y}) {
    if (z < 0 || z > maxZoom) {
      throw PmTilesV3Exception.invalidTileCoordinate(z: z, x: x, y: y);
    }
    final levelTiles = 1 << z;
    if (x < 0 || x >= levelTiles || y < 0 || y >= levelTiles) {
      throw PmTilesV3Exception.invalidTileCoordinate(z: z, x: x, y: y);
    }
    final range = rangeForZoom(zoom: z);
    return range.start + hilbertDistance(levelTiles: levelTiles, x: x, y: y);
  }

  /// PMTiles v3のtile IDをXYZタイル座標へ逆変換する。
  ({int z, int x, int y}) zxyForTileId({required int tileId}) {
    validateArgument(tileId: tileId);
    var zoom = 0;
    var range = rangeForZoom(zoom: zoom);
    while (tileId >= range.endExclusive) {
      zoom++;
      range = rangeForZoom(zoom: zoom);
    }

    var x = 0;
    var y = 0;
    var distance = tileId - range.start;
    for (var scale = 1; scale < 1 << zoom; scale <<= 1) {
      final rx = 1 & (distance >> 1);
      final ry = 1 & (distance ^ rx);
      final rotated = rotateInverse(
        scale: scale,
        x: x,
        y: y,
        rx: rx,
        ry: ry,
      );
      x = rotated.x + scale * rx;
      y = rotated.y + scale * ry;
      distance >>= 2;
    }
    return (z: zoom, x: x, y: y);
  }

  /// 一辺`levelTiles`のHilbert曲線上で(x, y)が何番目かを返す。
  ///
  /// protomaps/PMTiles の公式リファレンス実装
  /// (`js/src/index.ts`の`zxyToTileId`/`rotate`)を移植したもの。回転時に
  /// 固定のarchive幅ではなく現在の再帰段階の`s`を渡す点が、Wikipediaの
  /// 教科書的なHilbert曲線実装と異なるため、この参照実装から直接移植する。
  int hilbertDistance({
    required int levelTiles,
    required int x,
    required int y,
  }) {
    var tx = x;
    var ty = y;
    var distance = 0;
    var s = levelTiles ~/ 2;
    while (s > 0) {
      final rx = (tx & s) > 0 ? 1 : 0;
      final ry = (ty & s) > 0 ? 1 : 0;
      distance += s * s * ((3 * rx) ^ ry);
      if (ry == 0) {
        if (rx == 1) {
          tx = s - 1 - tx;
          ty = s - 1 - ty;
        }
        final swap = tx;
        tx = ty;
        ty = swap;
      }
      s ~/= 2;
    }
    return distance;
  }
}

({int x, int y}) rotateInverse({
  required int scale,
  required int x,
  required int y,
  required int rx,
  required int ry,
}) {
  if (ry != 0) {
    return (x: x, y: y);
  }
  final rotatedX = rx == 1 ? scale - 1 - x : x;
  final rotatedY = rx == 1 ? scale - 1 - y : y;
  return (x: rotatedY, y: rotatedX);
}

import 'package:eqmonitor_map/src/geo/tile_id.dart';

/// 不変archiveでdecodeに失敗したtileをterminalとして保持する。
final class BaseMapTileDecodeFailureOwner {
  BaseMapTileDecodeFailureOwner({required this.maxEntries}) {
    if (maxEntries <= 0) {
      throw ArgumentError.value(maxEntries, 'maxEntries', 'must be positive');
    }
  }

  final int maxEntries;
  final _tiles = <CanonicalTileId>{};

  bool contains(CanonicalTileId tileId) {
    if (!_tiles.remove(tileId)) {
      return false;
    }
    _tiles.add(tileId);
    return true;
  }

  void record(CanonicalTileId tileId) {
    _tiles
      ..remove(tileId)
      ..add(tileId);
    while (_tiles.length > maxEntries) {
      _tiles.remove(_tiles.first);
    }
  }
}

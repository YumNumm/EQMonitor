import 'dart:typed_data';

import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/tile/remote/map_remote_pm_tiles_reader.dart';
import 'package:eqmonitor_map/src/tile/verified_pm_tiles_source.dart';
import 'package:pmtiles_v3/pmtiles_v3.dart';

/// [VerifiedTileSource]が指すPMTiles archiveから、[CanonicalTileId]単位で
/// tile bytesを取得する。source が local file か remote URL かは
/// [PmTilesRandomAccessReader]の実装差で吸収し、archive/readTile の契約は
/// 共通のまま保つ。
///
/// 欠損tileと不正tileの区別はここでは何も足さず、`PmTilesV3Archive.readTile`の
/// 契約(sparse archiveの欠損は`null`、破損・上限超過・座標範囲外は
/// `PmTilesV3Exception`)をそのまま呼び出し側へ伝播する(Global Constraints
/// 「欠損tileと不正tileを区別する」節)。[readTile]はこの伝播だけが責務であり、
/// `try/catch`で握り潰したり空tileへ丸めたりしない。
final class BaseMapTileRepository {
  new _(this.source, this._archive);

  /// このrepositoryが読む対象を確定した契約([VerifiedTileSource]の
  /// doc comment参照)。
  final VerifiedTileSource source;
  final PmTilesV3Archive _archive;

  /// [source]を local file / remote URL に応じて開き、PMTiles v3 archiveとして
  /// 検証する。archive自体の破損は`PmTilesV3Archive.open`が投げる
  /// `PmTilesV3Exception`としてそのまま伝播する。
  ///
  /// [remoteMaxCacheBytes]はremote source のときだけ使う、reader 内 byte 範囲
  /// LRU の上限(呼び出し側が明示する。hidden default を持たない)。
  static Future<BaseMapTileRepository> open({
    required VerifiedTileSource source,
    required PmTilesV3Limits limits,
    int? remoteMaxCacheBytes,
  }) async {
    final reader = switch (source) {
      VerifiedPmTilesSource() => await PmTilesV3FileRandomAccessReader.open(
        path: source.absolutePath,
      ),
      VerifiedRemotePmTilesSource() => MapRemotePmTilesRandomAccessReader(
        source: source,
        maxCacheBytes:
            remoteMaxCacheBytes ??
            (throw ArgumentError.notNull('remoteMaxCacheBytes')),
      ),
    };
    final archive = await PmTilesV3Archive.open(reader: reader, limits: limits);
    return BaseMapTileRepository._(source, archive);
  }

  /// [tileId]のtile bytesを読む。archiveのzoom範囲外や座標範囲外は
  /// `PmTilesV3Exception.invalidTileCoordinate`、sparse archiveでの単純な
  /// 欠損は`null`になる(`PmTilesV3Archive.readTile`の契約どおり)。
  Future<Uint8List?> readTile(CanonicalTileId tileId) {
    return _archive.readTile(z: tileId.z, x: tileId.x, y: tileId.y);
  }

  Future<void> close() => _archive.close();
}

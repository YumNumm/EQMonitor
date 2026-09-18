import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh.dart';
import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/renderer/base_map_packed_mesh.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_decoder.dart';

/// tile 1枚ぶんのpacked meshを`(sourceInstanceId, CanonicalTileId)`単位で
/// 保持するcache。
///
/// # なぜinstance identityが本質なのか
///
/// `MapRenderPacket`はGPU resource idを持たない。そのため
/// `MapRenderBatchAdapter`(Flutter Scene実装)は**[MapPackedMesh]の
/// instance identity**をGPU resourceのkeyにしている
/// (`HashMap(equals: identical, hashCode: identityHashCode)`)。
/// このcacheが毎回詰め直した新しい[MapPackedMesh]を返すと、adapterはそれを
/// 未知のmeshと見なし、**毎frame全meshをGPUへ再uploadする**。
///
/// 従って本cacheの責務は「詰め直しのCPU時間を省くこと」ではなく
/// 「同じkeyに対して同じinstanceを返し続け、GPU uploadを
/// `(sourceInstanceId, CanonicalTileId)`につき1回に抑えること」である。
/// 一度返したinstanceはevictされるまで不変で、[getOrBuild]がhitした場合は
/// 引数の[BaseMapTileGeometry]を読まずにcache済みinstanceを返す
/// (同じkeyでgeometryが差し替わることは、`sourceInstanceId`が内容digestを
/// 含む`VerifiedTileSourceCacheIdentity.cacheIdentity`である前提のもとでは
/// 起きない。`BaseMapTileCache`のcache key節と同じ前提)。
///
/// この責務は`BaseMapView._TileSceneMeshCache`が`scene.Mesh`に対して負って
/// いたものを、Scene非依存のCPU側payloadへ引き上げたものである
/// (計画書「GPU resourceのidentity」節)。
///
/// # eviction
///
/// 件数上限[maxEntries]は呼び出し側が渡す(Global Constraints「上限値は
/// 呼び出し側が渡す」)。上限を超えた分は**最も長く参照されていないentry
/// (LRU)**から破棄する。`_entries`は挿入順を保つ`Map`
/// (Dartの既定`Map`は`LinkedHashMap`)であり、[getOrBuild]がhitするたびに
/// entryを取り除いて入れ直すことで最新位置へ移動させるため、
/// `_entries.keys.first`が常に「最も長く未参照のentry」になる
/// (`BaseMapTileCache._evictOverCapacity`と同じ手法)。
///
/// 旧`_TileSceneMeshCache`はhit時の入れ直しを行わず`_entries.keys.first`を
/// 捨てていたため、実質**挿入順(FIFO)eviction**だった。zoomを変えないpan
/// 往復では表示中のtileが毎frame要求され続けるにもかかわらず、先に挿入
/// されたという理由だけで捨てられ得た(=表示中tileのGPU再uploadが起きる)。
/// hit時にMRU側へ移すことでこれを塞いでいる。
final class BaseMapPackedMeshCache {
  new({required this.maxEntries}) {
    if (maxEntries <= 0) {
      throw ArgumentError.value(maxEntries, 'maxEntries', 'must be positive');
    }
  }

  /// cacheへ保持できるtile entryの最大件数。1 entryは1 tileの全layer分の
  /// packed meshを指すため、mesh数ではなくtile数の上限である。
  final int maxEntries;

  final Map<(String, CanonicalTileId), Map<String, List<MapPackedMesh>>>
  _entries = {};

  /// 現在のentry(tile)件数。
  int get length => _entries.length;

  /// [tileId]のpacked meshを`styleLayerId`ごとに返す。未cacheなら
  /// [geometry]から詰めてcacheへ入れる。
  ///
  /// 返すmapは[BaseMapTileGeometry.layers]と同じ順序・同じ件数のkeyを持つ。
  /// meshが空のlayerも**keyを落とさず空リストを入れる**のは、
  /// [BaseMapTileGeometry.layers]自身が「対応するMVT layerが無くても
  /// エントリは欠落しない」契約を持ち、呼び出し側が順序に依存したzipを
  /// 書けるようにしているため。空meshに対して
  /// [packBaseMapFillMesh]/[packBaseMapLineMesh]は呼ばない(両者は空meshを
  /// 配線バグとして`ArgumentError`で拒否する設計であり、sparse tileは
  /// バグではない)。
  Map<String, List<MapPackedMesh>> getOrBuild({
    required String sourceInstanceId,
    required CanonicalTileId tileId,
    required BaseMapTileGeometry geometry,
  }) {
    final key = (sourceInstanceId, tileId);
    final cached = _entries.remove(key);
    if (cached != null) {
      // hitしたentryをMRU側(挿入順の末尾)へ移してLRUを維持する。
      _entries[key] = cached;
      return cached;
    }

    final packed = Map<String, List<MapPackedMesh>>.unmodifiable({
      for (final layer in geometry.layers)
        layer.styleLayerId: switch (layer) {
          BaseMapTileFillLayerGeometry(:final meshes) =>
            List<MapPackedMesh>.unmodifiable([
              for (final mesh in meshes) packBaseMapFillMesh(mesh),
            ]),
          BaseMapTileLineLayerGeometry(:final meshes) =>
            List<MapPackedMesh>.unmodifiable([
              for (final mesh in meshes) packBaseMapLineMesh(mesh),
            ]),
        },
    });
    _entries[key] = packed;
    _evictOverCapacity();
    return packed;
  }

  void _evictOverCapacity() {
    while (_entries.length > maxEntries) {
      _entries.remove(_entries.keys.first);
    }
  }

  /// 全entryを破棄する。以後の[getOrBuild]は新しい[MapPackedMesh] instanceを
  /// 返すため、adapter側のGPU resourceも別物として扱われる(context lostや
  /// source差し替えのように、既存のGPU resourceを捨てたい場面で呼ぶ)。
  void clear() => _entries.clear();
}

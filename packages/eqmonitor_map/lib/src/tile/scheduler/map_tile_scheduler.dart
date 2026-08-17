import 'package:eqmonitor_map/src/geo/tile_id.dart';

/// tile decode 要求の重複排除・backpressure・cancel 判定を担う純粋な計画
/// コンポーネント。
///
/// 実際の decode 実行(worker 起動)や incarnation token の管理は行わない
/// (それらは decode client / cache が担当する)。scheduler は「今この frame で
/// どの tile を新規に開始し、どの in-flight を打ち切るべきか」だけを、渡された
/// 状態から決定的に算出する。
///
/// - 優先順位: `TileCoverCalculator.cover` が返す **camera 中心近傍優先・
///   wrap 考慮済みの順序をそのまま尊重** する。scheduler 側で距離を再計算
///   しないのは、date line を跨いだとき(`wrap != 0`)に canonical `x` の差だけで
///   順位付けすると、視覚的には中心の隣なのに `x = 2^z - 1` の tile が最遠と
///   誤判定され、`maxInFlightDecodes` が小さいほど後回しにされるため。距離の
///   定義を2箇所に持つと必ず drift するので、cover 側を単一の情報源とする。
/// - 重複排除(coalesce): 既に in-flight / decode 済み / 要求内重複の tile は
///   開始しない。
/// - backpressure: 同時 in-flight 数は[maxInFlightDecodes]を超えない。
/// - cancel: camera 移動後にもう要求されていない in-flight tile を打ち切る。
///
/// **順序・描画位置は[UnwrappedTileId]、decode の同一性は[CanonicalTileId]**で
/// 扱う。date line 付近では同じ canonical tile が複数の world copy として cover に
/// 現れるが、repository / geometry cache は `CanonicalTileId` で読み書きしており
/// 実体は同じ PMTiles bytes である。world copy 単位で decode を張ると、
/// `maxInFlightDecodes` が小さいときに同じ bytes の重複 decode が slot を占有し、
/// まだ持っていない tile の decode を遅らせる。よって in-flight / decode 済みの
/// 判定は canonical で行い、返す値は描画位置を保つため unwrapped のままにする。
final class MapTileScheduler {
  const new({required this.maxInFlightDecodes})
    : assert(maxInFlightDecodes > 0, 'maxInFlightDecodes must be > 0');

  /// 同時に走らせてよい decode 数の上限(呼び出し側が明示。
  /// `MapTilePipelineBudget.maxInFlightDecodes` 由来の運用値)。
  final int maxInFlightDecodes;

  /// 今 frame で新規開始すべき tile を、優先順・coalesce・backpressure を適用して
  /// 返す。返る件数は残 in-flight budget(`maxInFlightDecodes - inFlight.length`)を
  /// 超えない。
  ///
  /// [coverOrdered]は`TileCoverCalculator.cover`が返した順序(camera 中心
  /// 近傍優先)であることを前提とし、その相対順序を保ったまま絞り込む。
  ///
  /// [inFlight]/[completed]は decode 単位である[CanonicalTileId]の集合。
  /// 返る各要素の `canonical` は互いに重複しない(同じ canonical の別 world copy
  /// は、最も優先度の高い1件だけを decode 対象にする)。
  List<UnwrappedTileId> selectNext({
    required List<UnwrappedTileId> coverOrdered,
    required Set<CanonicalTileId> inFlight,
    required Set<CanonicalTileId> completed,
  }) {
    final remaining = maxInFlightDecodes - inFlight.length;
    if (remaining <= 0) {
      return const [];
    }

    final seen = <CanonicalTileId>{};
    final selected = <UnwrappedTileId>[];
    for (final tile in coverOrdered) {
      if (selected.length >= remaining) {
        break;
      }
      final canonical = tile.canonical;
      if (inFlight.contains(canonical) || completed.contains(canonical)) {
        continue;
      }
      if (!seen.add(canonical)) {
        continue;
      }
      selected.add(tile);
    }
    return List.unmodifiable(selected);
  }

  /// camera 移動後にもう要求されていない in-flight decode(打ち切り対象)を返す。
  ///
  /// decode 単位なので canonical で判定する。ある canonical tile は、どれか1つの
  /// world copy がまだ要求されている限り打ち切らない。
  Set<CanonicalTileId> tilesToCancel({
    required Set<CanonicalTileId> inFlight,
    required Set<CanonicalTileId> stillRequested,
  }) => inFlight.difference(stillRequested);
}

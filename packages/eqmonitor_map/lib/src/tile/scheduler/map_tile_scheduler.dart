import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/tile/map_tile_pipeline_budget.dart';

/// tile decode 要求の優先順位付け・重複排除・backpressure・cancel 判定を担う
/// 純粋な計画コンポーネント。
///
/// 実際の decode 実行(worker 起動)や incarnation token の管理は行わない
/// (それらは decode client / cache が担当する)。scheduler は「今この frame で
/// どの tile を新規に開始し、どの in-flight を打ち切るべきか」だけを、渡された
/// 状態から決定的に算出する。
///
/// - 優先順位: camera 中心 tile に近いものから(同距離は x, y 昇順で安定化)。
/// - 重複排除(coalesce): 既に in-flight / decode 済み / 要求内重複の tile は
///   開始しない。
/// - backpressure: 同時 in-flight 数は[MapTilePipelineBudget.maxInFlightDecodes]
///   を超えない。
/// - cancel: camera 移動後にもう要求されていない in-flight tile を打ち切る。
final class MapTileScheduler {
  const MapTileScheduler({required this.budget});

  final MapTilePipelineBudget budget;

  /// 今 frame で新規開始すべき tile を、優先順・coalesce・backpressure を適用して
  /// 返す。返る件数は残 in-flight budget(`maxInFlightDecodes - inFlight.length`)を
  /// 超えない。
  List<CanonicalTileId> selectNext({
    required List<CanonicalTileId> requested,
    required Set<CanonicalTileId> inFlight,
    required Set<CanonicalTileId> completed,
    required CanonicalTileId center,
  }) {
    final remaining = budget.maxInFlightDecodes - inFlight.length;
    if (remaining <= 0) {
      return const [];
    }

    final seen = <CanonicalTileId>{};
    final scored =
        [
          for (final tile in requested)
            if (!inFlight.contains(tile) &&
                !completed.contains(tile) &&
                seen.add(tile))
              (
                distance:
                    (tile.x - center.x) * (tile.x - center.x) +
                    (tile.y - center.y) * (tile.y - center.y),
                x: tile.x,
                y: tile.y,
                tile: tile,
              ),
        ]..sort((a, b) {
          if (a.distance != b.distance) {
            return a.distance.compareTo(b.distance);
          }
          if (a.x != b.x) {
            return a.x.compareTo(b.x);
          }
          return a.y.compareTo(b.y);
        });

    return [for (final entry in scored.take(remaining)) entry.tile];
  }

  /// camera 移動後にもう要求されていない in-flight tile(打ち切り対象)を返す。
  Set<CanonicalTileId> tilesToCancel({
    required Set<CanonicalTileId> inFlight,
    required Set<CanonicalTileId> stillRequested,
  }) => inFlight.difference(stillRequested);
}

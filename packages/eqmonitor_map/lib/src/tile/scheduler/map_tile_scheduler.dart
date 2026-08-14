import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/tile/map_tile_pipeline_budget.dart';

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
/// - backpressure: 同時 in-flight 数は[MapTilePipelineBudget.maxInFlightDecodes]
///   を超えない。
/// - cancel: camera 移動後にもう要求されていない in-flight tile を打ち切る。
///
/// tile の identity は world copy を含む[UnwrappedTileId]で扱う。canonical
/// `z/x/y` だけにすると、date line を挟んで隣り合う別 world copy の tile が
/// 同一視され、coalesce と cancel の判定を誤る。
final class MapTileScheduler {
  const MapTileScheduler({required this.budget});

  final MapTilePipelineBudget budget;

  /// 今 frame で新規開始すべき tile を、優先順・coalesce・backpressure を適用して
  /// 返す。返る件数は残 in-flight budget(`maxInFlightDecodes - inFlight.length`)を
  /// 超えない。
  ///
  /// [coverOrdered]は`TileCoverCalculator.cover`が返した順序(camera 中心
  /// 近傍優先)であることを前提とし、その相対順序を保ったまま絞り込む。
  List<UnwrappedTileId> selectNext({
    required List<UnwrappedTileId> coverOrdered,
    required Set<UnwrappedTileId> inFlight,
    required Set<UnwrappedTileId> completed,
  }) {
    final remaining = budget.maxInFlightDecodes - inFlight.length;
    if (remaining <= 0) {
      return const [];
    }

    final seen = <UnwrappedTileId>{};
    final selected = <UnwrappedTileId>[];
    for (final tile in coverOrdered) {
      if (selected.length >= remaining) {
        break;
      }
      if (inFlight.contains(tile) || completed.contains(tile)) {
        continue;
      }
      if (!seen.add(tile)) {
        continue;
      }
      selected.add(tile);
    }
    return List.unmodifiable(selected);
  }

  /// camera 移動後にもう要求されていない in-flight tile(打ち切り対象)を返す。
  Set<UnwrappedTileId> tilesToCancel({
    required Set<UnwrappedTileId> inFlight,
    required Set<UnwrappedTileId> stillRequested,
  }) => inFlight.difference(stillRequested);
}

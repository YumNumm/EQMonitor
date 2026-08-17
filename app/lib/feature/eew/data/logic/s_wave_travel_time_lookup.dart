import 'package:collection/collection.dart';
import 'package:eqmonitor/core/provider/travel_time/model/travel_time_table.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sWaveTravelTimeLookupProvider = Provider<SWaveTravelTimeLookup>(
  (_) => const SWaveTravelTimeLookup(),
);

class SWaveTravelTimeLookup {
  const new();

  /// 走時テーブルからS波到達時間(秒)を震央距離(km)から逆引きする。
  double? lookup({
    required TravelTimeTables tables,
    required int depth,
    required double distanceKm,
  }) {
    final depthTables = tables.table.where((t) => t.depth == depth).toList()
      ..sort((a, b) => a.distance.compareTo(b.distance));

    if (depthTables.isEmpty) {
      return null;
    }

    final d1 = depthTables.lastWhereOrNull((t) => t.distance <= distanceKm);
    final d2 = depthTables.firstWhereOrNull((t) => t.distance >= distanceKm);

    if (d1 == null || d2 == null) {
      return null;
    }

    if (d1.distance == d2.distance) {
      return d1.s;
    }

    // 線形補間
    final ratio = (distanceKm - d1.distance) / (d2.distance - d1.distance);
    return d1.s + ratio * (d2.s - d1.s);
  }
}

import 'package:eqmonitor/core/provider/travel_time/model/travel_time_table.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 's_wave_travel_time_lookup.g.dart';

@Riverpod(keepAlive: true)
SWaveTravelTimeLookup sWaveTravelTimeLookup(Ref ref) =>
    const SWaveTravelTimeLookup();

class const SWaveTravelTimeLookup() {
  /// 深さ別テーブルを一度だけ準備し、複数の震央距離に対するS波走時を返す。
  List<double?> lookupAll({
    required TravelTimeTables tables,
    required int depth,
    required List<double> distancesKm,
  }) {
    final depthTables = tables.table.where((t) => t.depth == depth).toList()
      ..sort((a, b) => a.distance.compareTo(b.distance));
    if (depthTables.isEmpty) {
      return List<double?>.filled(distancesKm.length, null, growable: false);
    }
    return [
      for (final distanceKm in distancesKm)
        lookupPrepared(
          depthTables: depthTables,
          distanceKm: distanceKm,
        ),
    ];
  }

  double? lookupPrepared({
    required List<TravelTimeTable> depthTables,
    required double distanceKm,
  }) {
    if (distanceKm < depthTables.first.distance ||
        distanceKm > depthTables.last.distance) {
      return null;
    }
    var lowerIndex = 0;
    var upperIndex = depthTables.length - 1;
    while (upperIndex - lowerIndex > 1) {
      final middleIndex = (lowerIndex + upperIndex) ~/ 2;
      if (depthTables[middleIndex].distance <= distanceKm) {
        lowerIndex = middleIndex;
      } else {
        upperIndex = middleIndex;
      }
    }
    final lower = depthTables[lowerIndex];
    final upper = depthTables[upperIndex];
    if (lower.distance == upper.distance) {
      return lower.s;
    }
    final ratio =
        (distanceKm - lower.distance) / (upper.distance - lower.distance);
    return lower.s + ratio * (upper.s - lower.s);
  }
}

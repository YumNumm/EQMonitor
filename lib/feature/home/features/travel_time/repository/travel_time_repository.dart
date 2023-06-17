import 'package:collection/collection.dart';
import 'package:eqmonitor/feature/home/features/travel_time/data/travel_time_data_source.dart';
import 'package:eqmonitor/feature/home/features/travel_time/model/travel_time_table.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'travel_time_repository.g.dart';

@Riverpod(keepAlive: true)
class TravelTimeRepository extends _$TravelTimeRepository {
  @override
  List<TravelTimeTable> build() {
    _dataSource = ref.watch(travelTimeDataSourceProvider);
    initialize();
    return [];
  }

  late TravelTimeDataSource _dataSource;

  Future<List<TravelTimeTable>> initialize() async =>
      state = await _dataSource.loadTables();

  /// 走時を求めます
  /// [depth]: 震源の深さ(km)
  /// [time]: 地震発生からの経過時間(sec)
  /// ref: https://zenn.dev/iedred7584/articles/travel-time-table-converter-adcal2020#%E5%86%86%E3%81%AE%E5%A4%A7%E3%81%8D%E3%81%95%E3%82%92%E6%B1%82%E3%82%81%E3%82%8B
  TravelTimeResult getValue(int depth, double time) {
    if (depth > 700 || time > 2000) {
      return TravelTimeResult(null, null);
    }
    final table = state.where((e) => e.depth == depth).toList();
    if (table.isEmpty) {
      return TravelTimeResult(null, null);
    }
    final p1 = table.firstWhereOrNull((e) => e.p <= time);
    final p2 = table.lastWhereOrNull((e) => e.p >= time);
    if (p1 == null || p2 == null) {
      return TravelTimeResult(null, null);
    }
    final p = (time - p1.p) / (p2.p - p1.p) * (p2.distance - p1.distance) +
        p1.distance;
    final s1 = table.firstWhereOrNull((e) => e.s <= time);
    final s2 = table.lastWhereOrNull((e) => e.s >= time);
    if (s1 == null || s2 == null) {
      return TravelTimeResult(null, p);
    }
    final s = (time - s1.s) / (s2.s - s1.s) * (s2.distance - s1.distance) +
        s1.distance;
    return TravelTimeResult(s, p);
  }
}

class TravelTimeResult {
  TravelTimeResult(this.sDistance, this.pDistance);

  /// S波到達予想(km)
  final double? sDistance;

  /// P波到達予想(km)
  final double? pDistance;
}

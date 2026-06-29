import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/nearby_earthquake_search_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NearbyEarthquakeSearchParameter.toHistoryParameter', () {
    test('既定の緯度経度範囲と深さ範囲を履歴検索パラメータに変換できること', () {
      const parameter = NearbyEarthquakeSearchParameter(
        latitude: 35,
        longitude: 139,
        depth: 60,
        sortBy: EarthquakeSortBy.originTime,
        sortOrder: SortOrder.desc,
      );

      expect(
        parameter.toHistoryParameter(),
        const EarthquakeHistoryParameter(
          latitudeGte: 34.5,
          latitudeLte: 35.5,
          longitudeGte: 138.5,
          longitudeLte: 139.5,
          depthGte: 10,
          depthLte: 110,
          sortBy: EarthquakeSortBy.originTime,
          sortOrder: SortOrder.desc,
        ),
      );
    });

    test('深さ下限は0km未満にならないこと', () {
      const parameter = NearbyEarthquakeSearchParameter(
        latitude: 35,
        longitude: 139,
        depth: 20,
        sortBy: EarthquakeSortBy.depth,
        sortOrder: SortOrder.asc,
      );

      expect(parameter.toHistoryParameter().depthGte, 0);
      expect(parameter.toHistoryParameter().depthLte, 70);
    });

    test('深さ不明の場合は深さ条件を付けないこと', () {
      const parameter = NearbyEarthquakeSearchParameter(
        latitude: 35,
        longitude: 139,
        sortBy: EarthquakeSortBy.magnitude,
        sortOrder: SortOrder.desc,
      );

      expect(parameter.toHistoryParameter().depthGte, isNull);
      expect(parameter.toHistoryParameter().depthLte, isNull);
    });
  });

  group('NearbyEarthquakeSearchParameter', () {
    test('詳細画面の近傍地震取得件数は5件であること', () {
      const parameter = NearbyEarthquakeSearchParameter(
        latitude: 35,
        longitude: 139,
        sortBy: EarthquakeSortBy.originTime,
        sortOrder: SortOrder.desc,
      );

      expect(parameter.fetchLimit, 5);
    });

    test('現在の探索条件を表示できること', () {
      const parameter = NearbyEarthquakeSearchParameter(
        latitude: 35,
        longitude: 139,
        depth: 60,
        latLngRange: 0.7,
        depthRangeKm: 80,
        sortBy: EarthquakeSortBy.originTime,
        sortOrder: SortOrder.desc,
      );

      expect(parameter.latLngRangeLabel, '緯度経度: 震源から±0.7°');
      expect(parameter.depthRangeLabel, '深さ: 0〜140km');
    });

    test('深さ不明の場合は深さ条件なしと表示すること', () {
      const parameter = NearbyEarthquakeSearchParameter(
        latitude: 35,
        longitude: 139,
        sortBy: EarthquakeSortBy.originTime,
        sortOrder: SortOrder.desc,
      );

      expect(parameter.depthRangeLabel, '深さ: 条件なし');
    });

    test('同じソート項目を選ぶと昇降順を切り替えること', () {
      const parameter = NearbyEarthquakeSearchParameter(
        latitude: 35,
        longitude: 139,
        sortBy: EarthquakeSortBy.originTime,
        sortOrder: SortOrder.desc,
      );

      final updated = parameter.updateSort(EarthquakeSortBy.originTime);

      expect(updated.sortBy, EarthquakeSortBy.originTime);
      expect(updated.sortOrder, SortOrder.asc);
    });

    test('別のソート項目を選ぶと深さは昇順、それ以外は降順にすること', () {
      const parameter = NearbyEarthquakeSearchParameter(
        latitude: 35,
        longitude: 139,
        sortBy: EarthquakeSortBy.originTime,
        sortOrder: SortOrder.asc,
      );

      final depth = parameter.updateSort(EarthquakeSortBy.depth);
      final magnitude = depth.updateSort(EarthquakeSortBy.magnitude);

      expect(depth.sortOrder, SortOrder.asc);
      expect(magnitude.sortOrder, SortOrder.desc);
    });
  });
}

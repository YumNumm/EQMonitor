import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/nearby_earthquake_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/nearby_earthquake_query.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NearbyEarthquakeQuery', () {
    test('初期値は緯度経度±0.5度と深さ±50kmに変換される', () {
      const query = NearbyEarthquakeQuery(
        excludeEventId: 'current',
        latitude: 35,
        longitude: 139,
        depth: 40,
        parameter: NearbyEarthquakeParameter(),
        sortBy: EarthquakeSortBy.maxIntensity,
        sortOrder: SortOrder.desc,
      );

      expect(query.latitudeGte, 34.5);
      expect(query.latitudeLte, 35.5);
      expect(query.longitudeGte, 138.5);
      expect(query.longitudeLte, 139.5);
      expect(query.depthGte, 0);
      expect(query.depthLte, 90);
    });

    test('緯度経度と深さをAPIの入力範囲に丸める', () {
      const query = NearbyEarthquakeQuery(
        excludeEventId: 'current',
        latitude: 89.9,
        longitude: -179.9,
        depth: 1950,
        parameter: NearbyEarthquakeParameter(
          latitudeOffset: 3,
          longitudeOffset: 3,
          depthOffset: 200,
        ),
        sortBy: EarthquakeSortBy.maxIntensity,
        sortOrder: SortOrder.desc,
      );

      expect(query.latitudeGte, 86.9);
      expect(query.latitudeLte, 90);
      expect(query.longitudeGte, -180);
      expect(query.longitudeLte, -176.9);
      expect(query.depthGte, 1750);
      expect(query.depthLte, 2000);
    });

    test('深さ不明なら深さ条件を作らない', () {
      const query = NearbyEarthquakeQuery(
        excludeEventId: 'current',
        latitude: 35,
        longitude: 139,
        depth: null,
        parameter: NearbyEarthquakeParameter(),
        sortBy: EarthquakeSortBy.maxIntensity,
        sortOrder: SortOrder.desc,
      );

      expect(query.depthGte, isNull);
      expect(query.depthLte, isNull);
    });
  });
}

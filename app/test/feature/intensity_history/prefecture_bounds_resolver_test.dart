import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/repository/prefecture_bounds_resolver.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jma_map/jma_map.dart';
import 'package:maplibre/maplibre.dart';

// ---------------------------------------------------------------------------
// Test fixtures
// ---------------------------------------------------------------------------

LocalizedName _name(String ja) => LocalizedName(ja: ja, en: ja);

EarthquakeParameterCityItem _city(String code) => EarthquakeParameterCityItem(
  code: code,
  name: _name('city-$code'),
  kana: null,
  stations: const [],
);

EarthquakeParameterRegionItem _region(String code, int cityCount) =>
    EarthquakeParameterRegionItem(
      code: code,
      name: _name('region-$code'),
      kana: null,
      cities: List.generate(cityCount, (index) => _city('$code$index')),
    );

/// 東京都相当のフィクスチャ。
/// - `100`/`101`: 本土（陸続き・外接矩形が重なる）
/// - `200`: 伊豆諸島（本土から 1 度以上離れた離島）
/// - `300`: 小笠原諸島（さらに南方の離島）
final _prefectures = [
  EarthquakeParameterPrefectureItem(
    code: '13',
    name: _name('東京都'),
    regions: [
      _region('100', 23),
      _region('101', 10),
      _region('200', 2),
      _region('300', 1),
    ],
  ),
];

JmaMap_JmaMapData_JmaMapDataItem _item({
  required String code,
  required double south,
  required double north,
  required double west,
  required double east,
}) => JmaMap_JmaMapData_JmaMapDataItem(
  property: JmaMap_JmaMapData_JmaMapDataItem_Property(code: code, name: code),
  bounds: JmaMap_LatLngBounds(
    southWest: JmaMap_LatLng(lat: south, lng: west),
    northEast: JmaMap_LatLng(lat: north, lng: east),
  ),
);

Map<JmaMapType, JmaMap_JmaMapData> _jmaMap() => {
  JmaMapType.areaForecastLocalE: JmaMap_JmaMapData(
    mapType: JmaMap_JmaMapData_JmaMapType.AREA_FORECAST_LOCAL_E,
    data: [
      _item(code: '100', south: 35.5, north: 35.9, west: 139.5, east: 139.9),
      _item(code: '101', south: 35.5, north: 35.9, west: 138.9, east: 139.6),
      _item(code: '200', south: 33.0, north: 34.0, west: 139.1, east: 139.5),
      _item(code: '300', south: 24.2, north: 27.2, west: 141.0, east: 154.0),
    ],
  ),
};

void main() {
  const resolver = PrefectureBoundsResolver();

  group('resolve', () {
    test('遠隔の離島を含めず、市区町村数が最多のクラスタを採用する', () {
      final bounds = resolver.resolve(
        prefectureCode: '13',
        prefectures: _prefectures,
        jmaMap: _jmaMap(),
      );

      expect(bounds, isNotNull);
      expect(bounds!.latitudeSouth, 35.5);
      expect(bounds.latitudeNorth, 35.9);
      expect(bounds.longitudeWest, 138.9);
      expect(bounds.longitudeEast, 139.9);
    });

    test('seedRegionCode を含むクラスタを優先する', () {
      final bounds = resolver.resolve(
        prefectureCode: '13',
        prefectures: _prefectures,
        jmaMap: _jmaMap(),
        seedRegionCode: '300',
      );

      expect(bounds, isNotNull);
      expect(bounds!.latitudeSouth, 24.2);
      expect(bounds.latitudeNorth, 27.2);
      expect(bounds.longitudeWest, 141.0);
      expect(bounds.longitudeEast, 154.0);
    });

    test('存在しない都道府県コードでは null を返す', () {
      final bounds = resolver.resolve(
        prefectureCode: '99',
        prefectures: _prefectures,
        jmaMap: _jmaMap(),
      );

      expect(bounds, isNull);
    });

    test('該当する細分区域ポリゴンが 1 件もない場合は null を返す', () {
      final bounds = resolver.resolve(
        prefectureCode: '13',
        prefectures: _prefectures,
        jmaMap: {
          JmaMapType.areaForecastLocalE: JmaMap_JmaMapData(
            mapType: JmaMap_JmaMapData_JmaMapType.AREA_FORECAST_LOCAL_E,
            data: [
              _item(code: '999', south: 35, north: 36, west: 139, east: 140),
            ],
          ),
        },
      );

      expect(bounds, isNull);
    });
  });

  group('clusterByProximity', () {
    test('外接矩形が重なる区域は同一クラスタになる', () {
      final clusters = resolver.clusterByProximity([
        (
          code: 'a',
          bounds: const LngLatBounds(
            longitudeWest: 139.5,
            longitudeEast: 139.9,
            latitudeSouth: 35.5,
            latitudeNorth: 35.9,
          ),
        ),
        (
          code: 'b',
          bounds: const LngLatBounds(
            longitudeWest: 138.9,
            longitudeEast: 139.6,
            latitudeSouth: 35.5,
            latitudeNorth: 35.9,
          ),
        ),
      ]);

      expect(clusters, hasLength(1));
      expect(clusters.single.map((e) => e.code), containsAll(['a', 'b']));
    });

    test('ギャップを超えて離れた区域は別クラスタになる', () {
      final clusters = resolver.clusterByProximity([
        (
          code: 'a',
          bounds: const LngLatBounds(
            longitudeWest: 139.5,
            longitudeEast: 139.9,
            latitudeSouth: 35.5,
            latitudeNorth: 35.9,
          ),
        ),
        (
          code: 'b',
          bounds: const LngLatBounds(
            longitudeWest: 139.1,
            longitudeEast: 139.5,
            latitudeSouth: 33.0,
            latitudeNorth: 34.0,
          ),
        ),
      ]);

      expect(clusters, hasLength(2));
    });

    test('連結する区域は推移的に同一クラスタになる', () {
      final clusters = resolver.clusterByProximity([
        (
          code: 'a',
          bounds: const LngLatBounds(
            longitudeWest: 139.0,
            longitudeEast: 139.4,
            latitudeSouth: 35.0,
            latitudeNorth: 35.4,
          ),
        ),
        (
          code: 'c',
          bounds: const LngLatBounds(
            longitudeWest: 139.8,
            longitudeEast: 140.2,
            latitudeSouth: 35.0,
            latitudeNorth: 35.4,
          ),
        ),
        (
          code: 'b',
          bounds: const LngLatBounds(
            longitudeWest: 139.3,
            longitudeEast: 139.9,
            latitudeSouth: 35.0,
            latitudeNorth: 35.4,
          ),
        ),
      ]);

      expect(clusters, hasLength(1));
    });
  });

  group('unionBounds', () {
    test('空の場合は null を返す', () {
      expect(resolver.unionBounds(const []), isNull);
    });

    test('全体を包含する矩形を返す', () {
      final bounds = resolver.unionBounds(const [
        LngLatBounds(
          longitudeWest: 139.0,
          longitudeEast: 139.4,
          latitudeSouth: 35.0,
          latitudeNorth: 35.4,
        ),
        LngLatBounds(
          longitudeWest: 138.5,
          longitudeEast: 140.2,
          latitudeSouth: 34.2,
          latitudeNorth: 35.1,
        ),
      ]);

      expect(bounds, isNotNull);
      expect(bounds!.longitudeWest, 138.5);
      expect(bounds.longitudeEast, 140.2);
      expect(bounds.latitudeSouth, 34.2);
      expect(bounds.latitudeNorth, 35.4);
    });
  });
}

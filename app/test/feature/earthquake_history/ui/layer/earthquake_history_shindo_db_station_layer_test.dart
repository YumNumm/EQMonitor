import 'dart:convert';

import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_catalog.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_station_layer.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lat_lng/lat_lng.dart';

void main() {
  group('buildShindoDbStationGeoJson', () {
    test('同一観測点コードは1件に集約される', () {
      final geoJson = buildShindoDbStationGeoJson(
        tree: _tree([
          _station('ST001'),
          _station('ST001'),
          _station('ST002'),
        ]),
        colorModel: _colorModel,
      );

      final features = _features(geoJson);

      expect(features, hasLength(2));
      expect(features.map((feature) => feature['properties']['name']), [
        'ST001',
        'ST002',
      ]);
    });

    test('GeoJSON 生成件数は上限値で打ち切られる', () {
      final geoJson = buildShindoDbStationGeoJson(
        tree: _tree([
          for (var i = 0; i < shindoDbStationGeoJsonFeatureLimit + 1; i++)
            _station('ST${i.toString().padLeft(5, '0')}'),
        ]),
        colorModel: _colorModel,
      );

      expect(
        _features(geoJson),
        hasLength(shindoDbStationGeoJsonFeatureLimit),
      );
    });
  });
}

final _colorModel = switch (AppTheme.eqmonitorDefault().light) {
  final light? => light.intensity,
  null => throw StateError('EQMonitor default light theme is missing'),
};

List<Map<String, dynamic>> _features(String geoJson) {
  final decoded = jsonDecode(geoJson) as Map<String, dynamic>;
  return (decoded['features'] as List<dynamic>).cast<Map<String, dynamic>>();
}

ShindoDbIntensityTree _tree(List<ShindoDbStationNode> stations) =>
    ShindoDbIntensityTree(
      tree: {
        ShindoDbIntensityClass.three: [
          ShindoDbPrefectureNode(
            prefecture: EarthquakeParameterPrefectureItem(
              code: '01',
              name: const LocalizedName(ja: 'テスト都道府県'),
              regions: const [],
            ),
            cities: [
              ShindoDbCityNode(
                city: EarthquakeParameterCityItem(
                  code: '01100',
                  name: const LocalizedName(ja: 'テスト市区町村'),
                  kana: null,
                  stations: const [],
                ),
                region: EarthquakeParameterRegionItem(
                  code: '010100',
                  name: const LocalizedName(ja: 'テスト地域'),
                  kana: null,
                  cities: const [],
                ),
                stations: stations,
              ),
            ],
          ),
        ],
      },
      unresolvedStations: const {},
      totalStationCount: stations.length,
    );

ShindoDbStationNode _station(String code) => ShindoDbStationNode(
  record: EarthquakeCatalogStationRecord(
    stationCode: code,
    intensityClass: ShindoDbIntensityClass.three,
    instrumentalIntensity: null,
    observedAt: null,
    maxAcceleration: null,
    maxAccelTime: null,
    periods: null,
    observationCount: null,
  ),
  name: code,
  location: const LatLng(43.06, 141.35),
);

import 'dart:convert';

import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_catalog.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_station_layer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lat_lng/lat_lng.dart';

ShindoDbStationNode makeStation({
  required String code,
  required String name,
  required ShindoDbIntensityClass intensityClass,
}) => ShindoDbStationNode(
  record: EarthquakeCatalogStationRecord(
    stationCode: code,
    intensityClass: intensityClass,
    instrumentalIntensity: null,
    observedAt: null,
    maxAcceleration: null,
    maxAccelTime: null,
    periods: null,
    observationCount: null,
  ),
  name: name,
  location: const LatLng(35, 139),
);

void main() {
  test('tree が空でも固定 source ID 向けの空 GeoJSON を生成する', () {
    final geoJson = const EarthquakeHistoryShindoDbStationGeoJsonBuilder()
        .build(
          tree: const ShindoDbIntensityTree(
            tree: {},
            unresolvedStations: {},
            totalStationCount: 0,
          ),
        );
    final decoded = jsonDecode(geoJson) as Map<String, dynamic>;

    expect(decoded['features'], isEmpty);
    expect(EarthquakeHistoryShindoDbStationLayer.sourceId, isNotEmpty);
    expect(EarthquakeHistoryShindoDbStationLayer.iconLayerId, isNotEmpty);
  });

  test('観測階級から full/plain アイコンと最大階級フラグを生成する', () {
    final tree = ShindoDbIntensityTree(
      tree: const {},
      unresolvedStations: {
        ShindoDbIntensityClass.three: [
          makeStation(
            code: 'ST3',
            name: '震度3',
            intensityClass: ShindoDbIntensityClass.three,
          ),
        ],
        ShindoDbIntensityClass.five: [
          makeStation(
            code: 'ST5',
            name: '旧震度5',
            intensityClass: ShindoDbIntensityClass.five,
          ),
        ],
      },
      totalStationCount: 2,
    );

    final decoded = jsonDecode(
      const EarthquakeHistoryShindoDbStationGeoJsonBuilder().build(
        tree: tree,
      ),
    ) as Map<String, dynamic>;
    final features = (decoded['features'] as List<dynamic>)
        .cast<Map<String, dynamic>>();
    final propertiesByName = <String, Map<String, dynamic>>{
      for (final feature in features)
        if (feature['properties'] case final Map<String, dynamic> properties)
          properties['name'] as String: properties,
    };

    expect(
      propertiesByName['震度3'],
      containsPair('iconIdFull', 'JmaIntensity.small.three'),
    );
    expect(
      propertiesByName['震度3'],
      containsPair('iconIdPlain', 'JmaIntensity.smallWithoutText.three'),
    );
    expect(propertiesByName['震度3'], containsPair('isMax', false));
    expect(propertiesByName['旧震度5'], containsPair('isMax', true));
    expect(
      propertiesByName['旧震度5'],
      containsPair(
        'iconIdPlain',
        'JmaIntensity.smallWithoutText.fiveUnknown',
      ),
    );
  });
}

import 'dart:convert';

import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart'
    as parameter;
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart'
    as parameter;
import 'package:eqmonitor/feature/parameter/data/model/tsunami/tsunami_parameter.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_state.dart';
import 'package:eqmonitor/feature/tsunami/ui/components/tsunami_details_map_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jma_map/jma_map.dart';

void main() {
  const builder = TsunamiMapGeoJsonBuilder();

  test('震源座標を Point GeoJSON に変換する', () {
    final geoJson = builder.buildHypocenter(latitude: 35, longitude: 139);
    final decoded = jsonDecode(geoJson) as Map<String, dynamic>;
    final feature =
        (decoded['features'] as List<dynamic>).single as Map<String, dynamic>;

    expect((feature['geometry'] as Map<String, dynamic>)['coordinates'], [
      139,
      35,
    ]);
  });

  test('予報区データが空なら空 FeatureCollection を返す', () {
    final geoJson = builder.buildRegions(
      tsunamiMapData: JmaMap_JmaMapData(),
      regions: const [],
    );

    expect((jsonDecode(geoJson) as Map<String, dynamic>)['features'], isEmpty);
  });

  test('観測点データが空なら空 FeatureCollection を返す', () {
    final geoJson = builder.buildObservationStations(
      tsunami: TsunamiState(
        id: 'test',
        eventIds: const [],
        isActive: true,
        isCanceled: false,
        updatedAt: DateTime.utc(2026),
        earthquakes: const [],
        latestTelegrams: const [],
        regions: const [],
        offshoreStations: const [],
      ),
      tsunamiParameter: const TsunamiParameter(
        metadata: parameter.ParameterMetadata(
          type: parameter.ParameterType.tsunamiStations,
          schemaVersion: 1,
          sourceVersion: 'test',
          sourceUpdatedAt: null,
          sourceUrls: [],
          sha256: 'test',
        ),
        prefectures: [],
      ),
    );

    expect((jsonDecode(geoJson) as Map<String, dynamic>)['features'], isEmpty);
  });
}

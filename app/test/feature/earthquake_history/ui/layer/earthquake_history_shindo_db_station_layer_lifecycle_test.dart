import 'dart:convert';

import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_station_layer.dart';
import 'package:flutter_test/flutter_test.dart';

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
}

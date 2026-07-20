import 'dart:convert';

import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_hypocenter_error_layer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('座標精度変更時も固定 source ID 向けの Polygon を生成する', () {
    const builder = EarthquakeHistoryHypocenterErrorGeoJsonBuilder();
    const coordinates = Coordinate.latLng(latitude: 35, longitude: 139);
    final coarse = builder.build(coordinates: coordinates, decimalPlaces: 1);
    final precise = builder.build(coordinates: coordinates, decimalPlaces: 3);
    final decoded = jsonDecode(precise) as Map<String, dynamic>;

    expect(coarse, isNot(precise));
    expect(decoded['features'], hasLength(1));
    expect(EarthquakeHistoryHypocenterErrorLayerBuilder.sourceId, isNotEmpty);
  });
}

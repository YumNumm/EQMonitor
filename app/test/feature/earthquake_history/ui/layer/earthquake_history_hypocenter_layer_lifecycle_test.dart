import 'dart:convert';

import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_hypocenter_layer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('座標変更時も固定 source ID 向けの GeoJSON を生成する', () {
    const builder = EarthquakeHistoryHypocenterGeoJsonBuilder();
    final first = builder.build(
      points: const [(latitude: 35, longitude: 139, index: null)],
    );
    final second = builder.build(
      points: const [(latitude: 36, longitude: 140, index: null)],
    );
    final decoded = jsonDecode(second) as Map<String, dynamic>;
    final feature =
        (decoded['features'] as List<dynamic>).single as Map<String, dynamic>;

    expect(first, isNot(second));
    expect((feature['geometry'] as Map<String, dynamic>)['coordinates'], [
      140,
      36,
    ]);
    expect(EarthquakeHistoryHypocenterLayerBuilder.sourceId, isNotEmpty);
  });
}

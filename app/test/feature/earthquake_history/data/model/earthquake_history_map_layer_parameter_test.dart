import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('stationTextZoom の既定値は 9 で、保存済み JSON に無くても復元できる', () {
    const parameter = EarthquakeHistoryMapLayerParameter();
    expect(parameter.stationTextZoom, 9);

    final restored = EarthquakeHistoryMapLayerParameter.fromJson(
      <String, dynamic>{},
    );
    expect(restored.stationTextZoom, 9);
  });
}

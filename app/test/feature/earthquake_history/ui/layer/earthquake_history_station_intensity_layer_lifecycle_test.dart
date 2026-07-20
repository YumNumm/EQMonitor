import 'dart:convert';

import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_station_intensity_layer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('観測点データがない場合も更新可能な空 GeoJSON を生成する', () {
    final geoJson = const EarthquakeHistoryStationGeoJsonBuilder().build(
      intensity: null,
      colorModel: AppTheme.eqmonitorDefault().light!.intensity,
      stationDisplayMode: StationDisplayMode.normal,
      showingLpgmIntensity: false,
    );
    final decoded = jsonDecode(geoJson) as Map<String, dynamic>;

    expect(decoded['features'], isEmpty);
    expect(EarthquakeHistoryStationIntensityLayerBuilder.sourceId, isNotEmpty);
  });
}
